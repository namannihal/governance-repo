#Requires -Version 5.1
<#
.SYNOPSIS
    Fetches LSEG LMP documentation from GitLab REST API into the templates/ cache.

.DESCRIPTION
    Replaces Fetch-ADRs.ps1 (HTML scraping + Pandoc) and Fetch-GitLab.ps1.
    No Pandoc required — reads .md files directly from GitLab repositories.

    Fetches four content sets into templates/:
      ADRs      — docs/adrs/**/*.md     from mig-pat-source-to-target
      Patterns  — docs/patterns/**/*.md  from mig-pat-source-to-target
      CPF       — README.md             from every repo in prdsvc/terraform
      CPF-pat   — README.md             from every repo in prdsvcpat/terraform

    Output structure mirrors the existing templates/ cache:
      templates/adrs/                             (mirrors docs/adrs/)
      templates/patterns/                         (mirrors docs/patterns/)
      templates/cpf/cpf-azure-prdsvc-<name>/index.md
      templates/cpf/cpf-azure-prdsvcpat-<name>/index.md

.PARAMETER Token
    GitLab Personal Access Token with read_api and read_repository scopes.
    Create one at: https://gitlab.dx1.lseg.com/-/user_settings/personal_access_tokens

.PARAMETER OutputPath
    Root output directory. Defaults to .\templates

.PARAMETER GitLabBase
    GitLab API base URL. Defaults to https://gitlab.dx1.lseg.com/api/v4

.PARAMETER ADRsOnly
    Fetch only the ADRs content set.

.PARAMETER PatternsOnly
    Fetch only the Patterns content set.

.PARAMETER CPFOnly
    Fetch only the CPF module docs (prdsvc + prdsvcpat).

.PARAMETER DryRun
    Discover all files and repos without writing any files.

.EXAMPLE
    # Full refresh
    .\Fetch-Content.ps1 -Token "sdp-xxxx"

.EXAMPLE
    # ADRs and Patterns only
    .\Fetch-Content.ps1 -Token "sdp-xxxx" -ADRsOnly
    .\Fetch-Content.ps1 -Token "sdp-xxxx" -PatternsOnly

.EXAMPLE
    # CPF modules only
    .\Fetch-Content.ps1 -Token "sdp-xxxx" -CPFOnly

.EXAMPLE
    # Dry run — discover without writing
    .\Fetch-Content.ps1 -Token "sdp-xxxx" -DryRun
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string] $Token,

    [string] $OutputPath  = '.\templates',
    [string] $GitLabBase  = 'https://gitlab.dx1.lseg.com/api/v4',

    [switch] $ADRsOnly,
    [switch] $PatternsOnly,
    [switch] $CPFOnly,
    [switch] $SkipExisting,
    [switch] $DryRun
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$ProgressPreference    = 'SilentlyContinue'   # Suppress Invoke-WebRequest progress bar (major perf gain)

# Resolve OutputPath to an absolute path immediately (before any cd or .NET calls)
$OutputPath = [System.IO.Path]::GetFullPath((Join-Path (Get-Location).Path $OutputPath))

# ──────────────────────────────────────────────────────────────
# Source configuration
# ──────────────────────────────────────────────────────────────
$ADR_PROJECT      = 'app/app-51723/migration-patterns/mig-pat-source-to-target'
$ADR_PATH         = 'docs/adrs'
$PATTERNS_PATH    = 'docs/patterns'
$PRDSVC_GROUP     = 'app/app-51310/azure/prdsvc/terraform'
$PRDSVCPAT_GROUP  = 'app/app-51310/azure/prdsvcpat/terraform'

# ──────────────────────────────────────────────────────────────
# Helpers
# ──────────────────────────────────────────────────────────────
function Encode-Path([string]$path) {
    [Uri]::EscapeDataString($path)
}

function Invoke-GitLabGet {
    param([string]$Url)
    try {
        $response = Invoke-WebRequest -Uri $Url `
            -Headers @{ 'PRIVATE-TOKEN' = $Token } `
            -UseBasicParsing -TimeoutSec 30 -ErrorAction Stop
        return $response
    }
    catch {
        $statusCode = if ($_.Exception.Response) { $_.Exception.Response.StatusCode.value__ } else { 'timeout' }
        throw "HTTP $statusCode — $Url"
    }
}

function Get-GitLabJson {
    param([string]$Url)
    $response = Invoke-GitLabGet $Url
    return $response.Content | ConvertFrom-Json
}

# Paginated GET — returns all items across all pages
function Get-AllPages {
    param([string]$BaseUrl, [int]$PerPage = 100)
    $items   = @()
    $page    = 1
    do {
        $sep  = if ($BaseUrl -match '\?') { '&' } else { '?' }
        $url  = "${BaseUrl}${sep}per_page=${PerPage}&page=${page}"
        $resp = Invoke-GitLabGet $url
        $batch = $resp.Content | ConvertFrom-Json
        if ($null -eq $batch -or $batch.Count -eq 0) { break }
        $items += $batch
        # Check X-Next-Page header (may be array or string)
        $nextPageRaw = $resp.Headers['X-Next-Page']
        $nextPageStr = if ($nextPageRaw -is [array]) { $nextPageRaw[0] } else { $nextPageRaw }
        $page = if ($nextPageStr -and $nextPageStr -match '^\d+$' -and [int]$nextPageStr -gt 0) { [int]$nextPageStr } else { 0 }
    } while ($page -gt 0)
    return $items
}

# Recursively list all blobs under a repo path
function Get-RepoTree {
    param([string]$ProjectPath, [string]$TreePath, [string]$Ref = 'main')
    $encodedProject = Encode-Path $ProjectPath
    $encodedPath    = Encode-Path $TreePath
    $url = "$GitLabBase/projects/$encodedProject/repository/tree?path=$encodedPath&recursive=true&ref=$Ref"
    $items = Get-AllPages $url
    return $items | Where-Object { $_.type -eq 'blob' }
}

# Fetch raw file content
function Get-FileContent {
    param([string]$ProjectPath, [string]$FilePath, [string]$Ref = 'main')
    $encodedProject = Encode-Path $ProjectPath
    $encodedFile    = Encode-Path $FilePath
    $url = "$GitLabBase/projects/$encodedProject/repository/files/$encodedFile/raw?ref=$Ref"
    $response = Invoke-GitLabGet $url
    return $response.Content
}

# Write file, creating parent dirs as needed
function Write-CachedFile {
    param([string]$FullPath, [string]$Content)
    $dir = Split-Path $FullPath -Parent
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
    $Content | Set-Content -LiteralPath $FullPath -Encoding UTF8 -Force
}

function Write-Section([string]$Title) {
    Write-Host ""
    Write-Host "━━━ $Title ━━━" -ForegroundColor Cyan
}

function Write-OK  ([string]$msg) { Write-Host "  ✓ $msg" -ForegroundColor Green  }
function Write-Skip([string]$msg) { Write-Host "  · $msg" -ForegroundColor DarkGray }
function Write-Warn([string]$msg) { Write-Host "  ⚠ $msg" -ForegroundColor Yellow }
function Write-Fail([string]$msg) { Write-Host "  ✗ $msg" -ForegroundColor Red    }

# ──────────────────────────────────────────────────────────────
# Decide which content sets to run
# ──────────────────────────────────────────────────────────────
$runADRs     = -not $PatternsOnly -and -not $CPFOnly
$runPatterns = -not $ADRsOnly     -and -not $CPFOnly
$runCPF      = -not $ADRsOnly     -and -not $PatternsOnly

Write-Host ""
Write-Host "=== Fetch-Content — GitLab API → templates/ ===" -ForegroundColor Cyan
if ($DryRun) { Write-Host "  [DRY RUN — no files will be written]" -ForegroundColor Yellow }
Write-Host ""

$totalFetched = 0
$totalSkipped = 0
$failedFiles  = @()

# ──────────────────────────────────────────────────────────────
# 1. ADRs
# ──────────────────────────────────────────────────────────────
if ($runADRs) {
    Write-Section "ADRs  ($ADR_PROJECT — $ADR_PATH)"

    $blobs = Get-RepoTree -ProjectPath $ADR_PROJECT -TreePath $ADR_PATH
    $mdBlobs = $blobs | Where-Object {
        $_.name -like '*.md' -and $_.name -notlike '.*'
    }

    Write-Host "  Found $($mdBlobs.Count) .md files" -ForegroundColor Gray

    foreach ($blob in $mdBlobs) {
        # Strip leading "docs/adrs/" to get relative output path
        $relPath    = $blob.path -replace '^docs/adrs/', ''
        $outputFile = Join-Path $OutputPath "adrs\$($relPath -replace '/', '\')"

        if ($DryRun) {
            Write-Skip $blob.path
            continue
        }

        if ($SkipExisting -and (Test-Path $outputFile)) {
            Write-Skip "$($blob.path) [exists]"
            $totalSkipped++
            continue
        }

        try {
            $content = Get-FileContent -ProjectPath $ADR_PROJECT -FilePath $blob.path
            Write-CachedFile $outputFile $content
            Write-OK $blob.path
            $totalFetched++
        }
        catch {
            Write-Fail "$($blob.path) — $_"
            $failedFiles += $blob.path
        }
    }
}

# ──────────────────────────────────────────────────────────────
# 2. Patterns
# ──────────────────────────────────────────────────────────────
if ($runPatterns) {
    Write-Section "Patterns  ($ADR_PROJECT — $PATTERNS_PATH)"

    $blobs = Get-RepoTree -ProjectPath $ADR_PROJECT -TreePath $PATTERNS_PATH
    $mdBlobs = $blobs | Where-Object {
        $_.name -like '*.md' -and $_.name -notlike '.*'
    }

    Write-Host "  Found $($mdBlobs.Count) .md files" -ForegroundColor Gray

    foreach ($blob in $mdBlobs) {
        $relPath    = $blob.path -replace '^docs/patterns/', ''
        $outputFile = Join-Path $OutputPath "patterns\$($relPath -replace '/', '\')"

        if ($DryRun) {
            Write-Skip $blob.path
            continue
        }

        if ($SkipExisting -and (Test-Path $outputFile)) {
            Write-Skip "$($blob.path) [exists]"
            $totalSkipped++
            continue
        }

        try {
            $content = Get-FileContent -ProjectPath $ADR_PROJECT -FilePath $blob.path
            Write-CachedFile $outputFile $content
            Write-OK $blob.path
            $totalFetched++
        }
        catch {
            Write-Fail "$($blob.path) — $_"
            $failedFiles += $blob.path
        }
    }
}

# ──────────────────────────────────────────────────────────────
# 3. CPF modules (prdsvc + prdsvcpat)
# ──────────────────────────────────────────────────────────────
function Fetch-CpfGroup {
    param(
        [string] $GroupPath,
        [string] $RepoPrefix,   # e.g. 'azure-prdsvc-terraform-'
        [string] $CpfPrefix     # e.g. 'cpf-azure-prdsvc-'
    )

    Write-Section "CPF  ($GroupPath)"

    $encodedGroup = Encode-Path $GroupPath
    $projects = Get-AllPages "$GitLabBase/groups/$encodedGroup/projects"
    $moduleRepos = $projects | Where-Object { $_.name -like "${RepoPrefix}*" -and -not $_.archived }

    Write-Host "  Found $($moduleRepos.Count) module repos" -ForegroundColor Gray

    foreach ($repo in $moduleRepos) {
        # Derive module name and cpf-id
        $moduleName = $repo.name -replace "^$([regex]::Escape($RepoPrefix))", ''
        $cpfId      = "$CpfPrefix$moduleName"
        $outputFile = Join-Path $OutputPath "cpf\$cpfId\index.md"

        if ($DryRun) {
            Write-Skip "$cpfId  ($($repo.path_with_namespace))"
            continue
        }

        if ($SkipExisting -and (Test-Path $outputFile)) {
            Write-Skip "$cpfId [exists]"
            $script:totalSkipped++
            continue
        }

        try {
            $content = Get-FileContent -ProjectPath $repo.path_with_namespace -FilePath 'README.md'
            Write-CachedFile $outputFile $content
            Write-OK $cpfId
            $script:totalFetched++
        }
        catch {
            Write-Fail "$cpfId — $_"
            $script:failedFiles += "$cpfId (README.md)"
        }
    }
}

if ($runCPF) {
    Fetch-CpfGroup `
        -GroupPath  $PRDSVC_GROUP `
        -RepoPrefix 'azure-prdsvc-terraform-' `
        -CpfPrefix  'cpf-azure-prdsvc-'

    Fetch-CpfGroup `
        -GroupPath  $PRDSVCPAT_GROUP `
        -RepoPrefix 'azure-prdsvcpat-terraform-' `
        -CpfPrefix  'cpf-azure-prdsvcpat-'
}

# ──────────────────────────────────────────────────────────────
# 4. Summary
# ──────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "━━━ Summary ━━━" -ForegroundColor Cyan

if ($DryRun) {
    Write-Host "  Dry run complete — no files written." -ForegroundColor Yellow
} else {
    Write-Host "  Fetched : $totalFetched files" -ForegroundColor Green
    if ($totalSkipped -gt 0) {
        Write-Host "  Skipped : $totalSkipped files (already existed)" -ForegroundColor DarkGray
    }
    if ($failedFiles.Count -gt 0) {
        Write-Host "  Failed  : $($failedFiles.Count) files" -ForegroundColor Red
        $failedPath = Join-Path $OutputPath 'failed-files.txt'
        $failedFiles | Set-Content $failedPath -Encoding UTF8
        Write-Host "  Failures written to: $failedPath" -ForegroundColor Yellow
    }
}
Write-Host ""
