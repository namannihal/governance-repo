#Requires -Version 5.1
<#
.SYNOPSIS
    Fetches CPF Terraform module documentation from GitLab AND generates
    JSON schema files for each module — all in a single pass.

.DESCRIPTION
    Combines two steps into one script:

    Step 1 — Fetch  (skip with -SkipFetch):
      Uses the GitLab REST API to enumerate all Terraform module repositories
      in the CPF group, retrieves each module's latest git tag (version),
      fetches the full documentation from the catalog-metadata repository with
      all --8<-- snippet includes resolved (terraform-docs tables from README.md),
      and writes one index.md per module under OutputPath.
      Falls back to the module's own README.md when catalog docs are unavailable.

    Step 2 — Schema  (skip with -SkipSchemas):
      Parses each index.md, extracts module metadata, Terraform inputs/outputs/
      resources, and writes a structured JSON schema to SchemaOutputDir.
      Also generates _catalog.json (module index) and _version-map.json
      (cpf_id → version + pinned_source) for quick lookups by downstream tooling.

    Typical workflows:

      Full run — fetch docs then generate schemas (most common):
        .\Fetch-GitLab.ps1 -GitLabToken "glpat-xxxx"

      Schema refresh only — docs already up to date, regenerate schemas:
        .\Fetch-GitLab.ps1 -SkipFetch

      Fetch only — skip schema generation:
        .\Fetch-GitLab.ps1 -GitLabToken "glpat-xxxx" -SkipSchemas

      Single-module targeted run:
        .\Fetch-GitLab.ps1 -GitLabToken "glpat-xxxx" -NameFilter "applicationgateway"

      Dry run — discover available modules without writing any files:
        .\Fetch-GitLab.ps1 -GitLabToken "glpat-xxxx" -DryRun

.PARAMETER GitLabToken
    GitLab Personal Access Token with read_api and read_repository scopes.
    Required when -SkipFetch is NOT specified.
    Create one at: https://gitlab.dx1.lseg.com/-/user_settings/personal_access_tokens

.PARAMETER OutputPath
    Root directory for generated Markdown files (one index.md per module).
    Defaults to .\docs\cpf

.PARAMETER SchemaOutputDir
    Directory where JSON schema files will be written.
    Defaults to .\docs\cpf-schemas

.PARAMETER ModuleGroup
    GitLab group path that contains the module repositories.
    Defaults to app/app-51310/azure/prdsvc/terraform

.PARAMETER CatalogMetaProject
    GitLab project path for the catalog-metadata repo.
    Defaults to app/app-51310/azure/config/yaml/azure-config-yaml-catalogmetadata-backstage

.PARAMETER GitLabBase
    GitLab API base URL. Defaults to https://gitlab.dx1.lseg.com/api/v4

.PARAMETER RepoPrefix
    Only process repositories whose name starts with this prefix.
    Defaults to 'azure-prdsvc-terraform-'

.PARAMETER NameFilter
    Optional: further restrict to repositories whose name contains this
    substring (case-insensitive). Useful for targeted single-module runs.

.PARAMETER DryRun
    Discovers and lists all repositories (with their latest tag/version)
    without writing any files. Implies -SkipSchemas.

.PARAMETER SkipFetch
    Skip Step 1 — do not call the GitLab API. Generate schemas from index.md
    files already present in OutputPath. GitLabToken is NOT required.

.PARAMETER SkipSchemas
    Skip Step 2 — do not generate JSON schemas. Only fetches documentation.

.EXAMPLE
    .\Fetch-GitLab.ps1 -GitLabToken "glpat-xxxx"

.EXAMPLE
    .\Fetch-GitLab.ps1 -GitLabToken "glpat-xxxx" -NameFilter "applicationgateway"

.EXAMPLE
    .\Fetch-GitLab.ps1 -GitLabToken "glpat-xxxx" -DryRun

.EXAMPLE
    .\Fetch-GitLab.ps1 -SkipFetch

.EXAMPLE
    .\Fetch-GitLab.ps1 -GitLabToken "glpat-xxxx" -SkipSchemas
#>
[CmdletBinding()]
param(
    [string] $GitLabToken = '',

    [string] $OutputPath = '.\docs\cpf',

    [string] $SchemaOutputDir = '.\docs\cpf-schemas',

    [string] $ModuleGroup = 'app/app-51310/azure/prdsvc/terraform',

    [string] $CatalogMetaProject = 'app/app-51310/azure/config/yaml/azure-config-yaml-catalogmetadata-backstage',

    [string] $GitLabBase = 'https://gitlab.dx1.lseg.com/api/v4',

    # Only process repos whose name starts with this prefix
    [string] $RepoPrefix = 'azure-prdsvc-terraform-',

    # Optional additional filter (substring, case-insensitive)
    [string] $NameFilter = '',

    [switch] $DryRun,

    # Skip Step 1 (GitLab fetch); use existing index.md files in OutputPath
    [switch] $SkipFetch,

    # Skip Step 2 (schema generation); only fetch documentation
    [switch] $SkipSchemas
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# Infrastructure/demo repos that do not contain customer-facing module docs.
$SkipExact = [System.Collections.Generic.HashSet[string]]([System.StringComparer]::OrdinalIgnoreCase)
@(
    'azure-prdsvc-terraform-foundation',
    'azure-prdsvc-terraform-release',
    'azure-prdsvc-terraform-projectconfig',
    'azure-prdsvc-terraform-resourcenames',
    'azure-prdsvc-terraform-catalogmetadatatest',
    'azure-prdsvc-terraform-not',
    'azure-prdsvc-terraform-testissuetemplate',
    'azure-prdsvc-terraform-mssqlelasticpool'
) | ForEach-Object { [void]$SkipExact.Add($_) }

# ─────────────────────────────────────────────────────────────
# Step 1 helpers — GitLab fetch
# ─────────────────────────────────────────────────────────────

function Invoke-GlApi {
    param([string] $Url)
    try {
        return Invoke-RestMethod -Uri $Url -Headers $script:GlHeader -ErrorAction Stop
    }
    catch {
        $code = $_.Exception.Response.StatusCode.value__
        if ($code -eq 401 -or $code -eq 403) {
            Write-Error @"
HTTP $code — GitLab token is invalid or has expired.
Create a new PAT (read_api + read_repository scopes) at:
  https://gitlab.dx1.lseg.com/-/user_settings/personal_access_tokens
"@
            exit 1
        }
        throw
    }
}

function Get-GlFileRaw {
    param(
        [string] $Project,
        [string] $FilePath,
        [string] $Ref = 'main'
    )
    $ep   = [Uri]::EscapeDataString($Project)
    $ef   = [Uri]::EscapeDataString($FilePath)
    $url  = "$GitLabBase/projects/$ep/repository/files/$ef/raw?ref=$Ref"
    $resp = Invoke-WebRequest -Uri $url -Headers $script:GlHeader -UseBasicParsing -ErrorAction Stop
    if ($resp.Content -match '(?is)^\s*<!DOCTYPE|^\s*<html') {
        throw "GitLab returned an HTML page for '$FilePath' — PAT may be invalid or expired"
    }
    return $resp.Content
}

function Get-LatestTag {
    param([string] $ProjectPath)
    try {
        $ep   = [Uri]::EscapeDataString($ProjectPath)
        $tags = Invoke-GlApi -Url "$GitLabBase/projects/$ep/repository/tags?order_by=updated&sort=desc&per_page=1"
        if ($tags -and $tags.Count -gt 0) { return $tags[0].name }
    }
    catch { }
    return $null
}

# Resolve --8<-- "path" snippet include directives (MkDocs "snippets" extension).
function Resolve-Snippets {
    param(
        [string] $Content,
        [string] $FileDir,
        [string] $CatalogProject,
        [string] $ModuleProject,
        [string] $ModuleBranch
    )
    $rx = [System.Text.RegularExpressions.Regex]::new('--8<--\s+"([^"]+)"')
    foreach ($m in $rx.Matches($Content)) {
        $relPath      = $m.Groups[1].Value
        $resolvedPath = [Uri]::new([Uri]"https://x/$FileDir/", $relPath).AbsolutePath.TrimStart('/')
        Write-Verbose "        [INCLUDE] $resolvedPath"
        $snippet = $null
        try {
            $snippet = Get-GlFileRaw -Project $CatalogProject -FilePath $resolvedPath
        }
        catch {
            $fileName = $relPath -replace '^.*[\\/]', ''
            Write-Verbose "        [INCLUDE-MOD] $fileName"
            try {
                $snippet = Get-GlFileRaw -Project $ModuleProject -FilePath $fileName -Ref $ModuleBranch
            }
            catch {
                Write-Verbose "        [INCLUDE-SKIP] $relPath"
            }
        }
        if ($snippet) { $Content = $Content.Replace($m.Value, $snippet) }
    }
    return $Content
}

# Remove backslash-escaped underscores (terraform-docs emits \_) outside fenced
# code blocks so variable names render cleanly in Markdown viewers.
function Remove-EscapedUnderscores {
    param([string] $Md)
    try {
        $out   = [System.Collections.Generic.List[string]]::new()
        $fence = $false
        foreach ($line in ($Md -split '\r?\n')) {
            if ($line -match '^```') { $fence = -not $fence }
            $out.Add($(if ($fence -or $line -match '^```') { $line } else { $line -replace '\\_', '_' }))
        }
        return $out -join "`n"
    }
    catch { return $Md }
}

# Replace image references with alt-text placeholders to reduce token usage.
function Remove-ImageReferences {
    param([string] $Md)
    $Md = [System.Text.RegularExpressions.Regex]::Replace($Md, '(?is)<img\b[^>]*/?>',
        {
            param($m)
            $altM = [System.Text.RegularExpressions.Regex]::Match($m.Value, '(?i)\balt\s*=\s*"([^"]*)"')
            $alt  = if ($altM.Success) { $altM.Groups[1].Value.Trim() } else { '' }
            if ($alt) { "[Image: $alt]" } else { '' }
        })
    $Md = [System.Text.RegularExpressions.Regex]::Replace($Md, '!\[([^\]]*)\]\([^)]*\)',
        { param($m) $a = $m.Groups[1].Value.Trim(); if ($a) { "[Image: $a]" } else { '' } })
    $Md = [System.Text.RegularExpressions.Regex]::Replace($Md, '!\[([^\]]*)\]\[[^\]]*\]',
        { param($m) $a = $m.Groups[1].Value.Trim(); if ($a) { "[Image: $a]" } else { '' } })
    return $Md
}

# Convert GitLab repo name to CPF output folder name.
# azure-prdsvc-terraform-applicationgateway → cpf-azure-prdsvc-applicationgateway
function ConvertTo-CpfName {
    param([string] $RepoName)
    return 'cpf-' + ($RepoName -replace '-terraform-', '-')
}

# ─────────────────────────────────────────────────────────────
# Step 2 helpers — schema generation
# ─────────────────────────────────────────────────────────────

function Strip-Html {
    param([string]$Html)
    if ([string]::IsNullOrWhiteSpace($Html)) { return '' }
    $t = $Html -replace '<[^>]+>', ' '
    $t = $t -replace '&amp;',  '&'
    $t = $t -replace '&lt;',   '<'
    $t = $t -replace '&gt;',   '>'
    $t = $t -replace '&quot;', '"'
    $t = $t -replace '&#39;',  "'"
    $t = $t -replace '&nbsp;', ' '
    $t = $t -replace '\\_',    '_'
    $t = $t -replace '\\\*',   '*'
    $t = $t -replace '\' + '`', '`'
    $t = $t -replace '\s+',    ' '
    return $t.Trim()
}

function Clean-Cell {
    param([string]$Val)
    if ([string]::IsNullOrWhiteSpace($Val)) { return $Val }
    $v = $Val.Trim()
    if ($v -match '^`(.*)`$') { $v = $Matches[1] }
    $v = $v -replace '\\_', '_'
    $v = $v -replace '\\\*', '*'
    return $v.Trim()
}

function Get-ModuleTitle {
    param([string]$Content)
    if ($Content -match '(?m)^#\s+(.+)$') {
        $t = Strip-Html $Matches[1]
        if ($t.Length -gt 2) { return $t }
    }
    if ($Content -match 'aria-label="([^"]+)"[^>]*data-md-component="logo"') {
        return $Matches[1].Trim()
    }
    if ($Content -match '<h1[^>]*>([^<]+)<') {
        return Strip-Html $Matches[1]
    }
    return ''
}

function Get-GitLabSource {
    param([string]$Content)
    if ($Content -match 'href="(https://gitlab[\w\.\-/:%]+/-/tree/[^"]+)"') {
        return $Matches[1]
    }
    if ($Content -match '\(https://gitlab[\w\.\-/:%]+/-/tree/[^)]+\)') {
        return $Matches[0].Trim('(', ')')
    }
    return ''
}

function Get-ModuleVersion {
    param([string]$Content)
    if ($Content -match '(?m)^---[\s\S]*?^version:\s*([^\s#]+)') {
        return $Matches[1].Trim()
    }
    if ($Content -match '(?im)^\|\s*version\s*\|\s*([0-9]+\.[0-9]+\.[0-9][^\|]*)\|') {
        return $Matches[1].Trim()
    }
    return ''
}

function Get-TerraformSource {
    param([string]$CpfId, [string]$GitLabUrl = '', [string]$Version = '')
    $ref = if ($Version -ne '') { "?ref=$Version" } else { '' }
    if ($CpfId -match 'cpf-azure-(prdsvc|prdapppat|prdsvcpat)-(.+)$') {
        $modType = $Matches[1]
        $modName = $Matches[2]
        $baseUrl  = 'https://gitlab.dx1.lseg.com/app/app-51310/azure'
        $repoName = "azure-$modType-terraform-$modName"
        return "git::$baseUrl/$modType/terraform/$repoName.git//$ref"
    }
    if (-not [string]::IsNullOrEmpty($GitLabUrl)) {
        return ($GitLabUrl -replace '/-/tree/main.*$', ".git//$ref")
    }
    return ''
}

function Get-ModuleType {
    param([string]$CpfId)
    if ($CpfId -match 'prdsvcpat')  { return 'service-pattern' }
    if ($CpfId -match 'prdapppat')  { return 'application-pattern' }
    return 'service'
}

function Get-AzureServiceName {
    param([string]$FolderName)
    $svc = $FolderName -replace '^cpf-azure-(prdsvc|prdapppat|prdsvcpat)-', ''
    $svc = $svc -replace '-', ' '
    $svc = [regex]::Replace($svc, '(?<=[a-z])(?=[A-Z])', ' ')
    return (Get-Culture).TextInfo.ToTitleCase($svc.ToLower())
}

function Get-Prerequisites {
    param([string]$Content)
    $prereqs = @()
    if ($Content -match '(?s)(?:## Prerequisites|Prerequisites</h2>)(.*?)(?=<h2|##\s)') {
        $section = $Matches[1]
        $items = [regex]::Matches($section, '<li[^>]*>(.*?)</li>',
                    [System.Text.RegularExpressions.RegexOptions]::Singleline)
        foreach ($item in $items) {
            $txt = Strip-Html $item.Groups[1].Value
            if ($txt.Length -gt 1) { $prereqs += $txt }
        }
        $codeItems = [regex]::Matches($section, '`([^`]+)`')
        foreach ($ci in $codeItems) {
            $val = $ci.Groups[1].Value.Trim()
            if ($val.Length -gt 1 -and $val -notin $prereqs) { $prereqs += $val }
        }
    }
    return $prereqs | Select-Object -Unique
}

function Parse-HtmlTable {
    param([string]$TableHtml)
    $rows = @()
    $headers = @()
    $thMatches = [regex]::Matches($TableHtml, '<th[^>]*>(.*?)</th>',
                    [System.Text.RegularExpressions.RegexOptions]::Singleline)
    foreach ($th in $thMatches) {
        $headers += (Strip-Html $th.Groups[1].Value).ToLower().Trim()
    }
    if ($headers.Count -eq 0) { return $rows }
    $trMatches = [regex]::Matches($TableHtml, '<tr[^>]*>(.*?)</tr>',
                    [System.Text.RegularExpressions.RegexOptions]::Singleline)
    foreach ($tr in $trMatches) {
        $tdMatches = [regex]::Matches($tr.Groups[1].Value, '<td[^>]*>(.*?)</td>',
                        [System.Text.RegularExpressions.RegexOptions]::Singleline)
        if ($tdMatches.Count -eq 0) { continue }
        $row = @{}
        for ($i = 0; $i -lt [Math]::Min($headers.Count, $tdMatches.Count); $i++) {
            $row[$headers[$i]] = (Strip-Html $tdMatches[$i].Groups[1].Value)
        }
        $rows += $row
    }
    return $rows
}

function Parse-MarkdownTable {
    param([string]$Text)
    $rows  = @()
    $lines = $Text -split "`n" | Where-Object { $_.Trim() -match '^\|' }
    if ($lines.Count -lt 2) { return $rows }
    $headerLine = $lines[0]
    $headers = ($headerLine -split '\|' | Select-Object -Skip 1) |
               ForEach-Object { Strip-Html $_.Trim() } |
               Where-Object   { $_ -ne '' } |
               ForEach-Object { $_.ToLower() }
    if ($headers.Count -eq 0) { return $rows }
    foreach ($line in ($lines | Select-Object -Skip 2)) {
        if ($line.Trim() -match '^[\|\s\-:]+$') { continue }
        $cells = ($line -split '\|' | Select-Object -Skip 1) |
                 ForEach-Object {
                     $cell = Strip-Html $_.Trim()
                     if ($cell -match 'name="(?:input|output|requirement|provider|resource)_([^"]+)"') {
                         $cell = $Matches[1]
                     } elseif ($cell -match '^\[([^\]]+)\]') {
                         $cell = Clean-Cell ($Matches[1])
                     } else {
                         $cell = Clean-Cell $cell
                     }
                     $cell
                 }
        if ($cells.Count -eq 0) { continue }
        $row = @{}
        for ($i = 0; $i -lt [Math]::Min($headers.Count, $cells.Count); $i++) {
            if ($headers[$i] -ne '') { $row[$headers[$i]] = $cells[$i] }
        }
        $rows += $row
    }
    return $rows
}

function Get-SectionTable {
    param([string]$Content, [string]$SectionPattern)
    $rows = @()
    if ($Content -match "(?s)$SectionPattern[\s\S]{0,200}?<table>([\s\S]*?)</table>") {
        $tableHtml = $Matches[1]
        $rows = Parse-HtmlTable "<table>$tableHtml</table>"
        if ($rows.Count -gt 0) { return $rows }
    }
    if ($Content -match "(?s)$SectionPattern([\s\S]+)") {
        $section = $Matches[1]
        if ($section -match '(?s)([\s\S]+?)(?=\n#{1,3}\s|\z)') {
            $section = $Matches[1]
        }
        $rows = Parse-MarkdownTable $section
    }
    return $rows
}

function Get-Inputs {
    param([string]$Content)
    $inputs  = @()
    $sections = [regex]::Split($Content, '(?m)^#{1,3}\s+Inputs')
    if ($sections.Count -lt 2) { return $inputs }
    $rows = Get-SectionTable ($sections[1]) ''
    foreach ($row in $rows) {
        $name = if ($row['name']) { $row['name'].Trim() } else { '' }
        if ($name -match '^\[([^\]]+)\]') { $name = Clean-Cell $Matches[1] }
        $name = Clean-Cell $name
        if ([string]::IsNullOrEmpty($name)) { continue }
        $desc     = if ($row['description']) { (Clean-Cell $row['description']).Trim() } else { '' }
        $type     = if ($row['type'])        { Clean-Cell $row['type'] } else { 'string' }
        $default  = if ($row['default'])     { Clean-Cell $row['default'] } else { $null }
        $required = if ($row['required'])    { $row['required'].Trim().ToLower() -eq 'yes' } else { $false }
        if ($default -eq 'n/a' -or $default -eq '') { $default = $null }
        $inputs += [ordered]@{
            name        = $name
            description = $desc
            type        = $type.Trim()
            default     = $default
            required    = $required
        }
    }
    return $inputs
}

function Get-Outputs {
    param([string]$Content)
    $outputs  = @()
    $sections = [regex]::Split($Content, '(?m)^#{1,3}\s+Outputs')
    $bestRows = @()
    foreach ($section in ($sections | Select-Object -Skip 1)) {
        $rows = Get-SectionTable $section ''
        if ($rows.Count -gt $bestRows.Count) { $bestRows = $rows }
    }
    foreach ($row in $bestRows) {
        $name = if ($row['name']) { $row['name'].Trim() } else { '' }
        if ($name -match '^\[([^\]]+)\]') { $name = Clean-Cell $Matches[1] }
        $name = Clean-Cell $name
        if ([string]::IsNullOrEmpty($name)) { continue }
        $desc = if ($row['description']) { (Clean-Cell $row['description']).Trim() } else { '' }
        $outputs += [ordered]@{ name = $name; description = $desc }
    }
    return $outputs
}

function Get-Resources {
    param([string]$Content)
    $resources = @()
    $sections  = [regex]::Split($Content, '(?m)^#{1,3}\s+Resources')
    foreach ($section in ($sections | Select-Object -Skip 1)) {
        $rows  = Get-SectionTable $section ''
        $found = @()
        foreach ($row in $rows) {
            $name = if ($row['name']) { $row['name'] -replace '\[([^\]]+)\].*', '$1' } else { '' }
            $name = $name.Trim()
            if ([string]::IsNullOrEmpty($name)) { continue }
            $type = if ($row['type']) { $row['type'].Trim() } else { '' }
            if ($type -notmatch '(?i)resource|data source|module') { continue }
            $found += [ordered]@{ terraform_resource = $name; type = $type }
        }
        if ($found.Count -gt 0) { $resources = $found; break }
    }
    return $resources
}

function Get-Requirements {
    param([string]$Content)
    $reqs     = @{}
    $sections = [regex]::Split($Content, '(?m)^#{1,3}\s+Requirements')
    foreach ($section in ($sections | Select-Object -Skip 1)) {
        $rows = Get-SectionTable $section ''
        foreach ($row in $rows) {
            $name = if ($row['name']) { ($row['name'] -replace '\[([^\]]+)\].*', '$1').Trim() } else { '' }
            $ver  = if ($row['version']) { $row['version'].Trim() } else { '' }
            if ($name -and $ver -match '>|=|~|\d') { $reqs[$name] = $ver }
        }
    }
    return $reqs
}

# ─────────────────────────────────────────────────────────────
# Step 0: Pre-flight
# ─────────────────────────────────────────────────────────────

Write-Host ''
Write-Host '=== Fetch-GitLab — CPF Modules → Markdown + JSON Schemas ===' -ForegroundColor Cyan
Write-Host "    Group          : $ModuleGroup"
Write-Host "    Catalog repo   : $CatalogMetaProject"
Write-Host "    Docs output    : $OutputPath"
Write-Host "    Schema output  : $SchemaOutputDir"
Write-Host "    Skip fetch     : $SkipFetch"
Write-Host "    Skip schemas   : $SkipSchemas"
Write-Host ''

# Validate: GitLabToken required unless skipping fetch
if (-not $SkipFetch -and [string]::IsNullOrEmpty($GitLabToken)) {
    Write-Error 'GitLabToken is required when -SkipFetch is not specified.'
    exit 1
}

if (-not $SkipFetch) {
    $script:GlHeader = @{ 'PRIVATE-TOKEN' = $GitLabToken }
}

# ─────────────────────────────────────────────────────────────
# Step 1: Fetch documentation from GitLab
# ─────────────────────────────────────────────────────────────

$fetchedModules = [System.Collections.Generic.List[string]]::new()

if (-not $SkipFetch) {
    if (-not $DryRun) {
        New-Item -ItemType Directory -Path $OutputPath -Force | Out-Null
        Write-Host "[OK] Docs output directory ready: $OutputPath" -ForegroundColor Green
        Write-Host ''
    }

    Write-Host '--- Step 1/2 : Listing repositories ---' -ForegroundColor Yellow

    $groupEncoded = [Uri]::EscapeDataString($ModuleGroup)
    $allProjects  = [System.Collections.Generic.List[object]]::new()
    $page         = 1

    do {
        $url   = "$GitLabBase/groups/$groupEncoded/projects?per_page=100&page=$page"
        $resp  = Invoke-WebRequest -Uri $url -Headers $script:GlHeader -UseBasicParsing -ErrorAction Stop
        $batch = $resp.Content | ConvertFrom-Json
        if ($batch -and $batch.Count -gt 0) { $allProjects.AddRange([object[]]$batch) }
        $xNext = $resp.Headers['X-Next-Page']
        if ($xNext -is [array]) { $xNext = $xNext[0] }
        $page  = if ($xNext -and $xNext -ne '') { [int]$xNext } else { 0 }
    } while ($page -gt 0)

    Write-Host "[OK] $($allProjects.Count) total project(s) in group." -ForegroundColor Green

    $repos = @($allProjects | Where-Object {
        $n = $_.name
        $n.StartsWith($RepoPrefix, [System.StringComparison]::OrdinalIgnoreCase)       -and
        ($NameFilter -eq '' -or $n -match [regex]::Escape($NameFilter))                -and
        (-not $SkipExact.Contains($n))                                                  -and
        (-not $n.StartsWith("$($RepoPrefix)demo", [System.StringComparison]::OrdinalIgnoreCase))
    })

    Write-Host "[OK] $($repos.Count) module(s) to process (after filters)." -ForegroundColor Green

    if ($DryRun) {
        Write-Host ''
        Write-Host 'DRY-RUN — repositories discovered (no files written):' -ForegroundColor Cyan
        foreach ($r in $repos) {
            $v    = Get-LatestTag -ProjectPath $r.path_with_namespace
            $vStr = if ($v) { $v } else { '(no tags)' }
            Write-Host "  $($r.name)   version=$vStr"
        }
        Write-Host ''
        exit 0
    }

    Write-Host ''
    Write-Host '--- Fetching module documentation ---' -ForegroundColor Yellow

    $failed = [System.Collections.Generic.List[string]]::new()
    $i      = 0
    $total  = $repos.Count

    foreach ($repo in $repos) {
        $i++
        $repoName  = $repo.name
        $repoPath  = $repo.path_with_namespace
        $defBranch = if ($repo.PSObject.Properties['default_branch'] -and
                         $repo.default_branch) { $repo.default_branch } else { 'main' }
        $cpfName   = ConvertTo-CpfName -RepoName $repoName
        $entityDir = Join-Path $OutputPath $cpfName

        Write-Progress -Activity 'Fetching CPF modules' `
            -Status "($i/$total) $repoName" `
            -PercentComplete ([int](($i / $total) * 100))

        Write-Host "  [$i/$total] $repoName" -ForegroundColor White

        $version     = Get-LatestTag -ProjectPath $repoPath
        $frontmatter = if ($version) { "---`nversion: $version`n---`n`n" } else { '' }
        Write-Host "      version : $(if ($version) { $version } else { '(no tags)' })" -ForegroundColor DarkGray

        $nameParts = $repoName -split '-'
        $glCloud   = $nameParts[0]
        $glType    = $nameParts[1]
        $glDocFile = "patterns/$glCloud/$glType/$repoName/docs/index.md"
        $glDocDir  = "patterns/$glCloud/$glType/$repoName/docs"

        $content = $null

        # Strategy 1: catalog-metadata docs/index.md
        try {
            Write-Verbose "      [CATALOG] $glDocFile"
            $raw = Get-GlFileRaw -Project $CatalogMetaProject -FilePath $glDocFile

            $raw = Resolve-Snippets -Content $raw `
                        -FileDir        $glDocDir `
                        -CatalogProject $CatalogMetaProject `
                        -ModuleProject  $repoPath `
                        -ModuleBranch   $defBranch

            if ($raw -notmatch '(?m)^## Inputs\b' -and $raw -match '(?m)^## Resources\b') {
                Write-Verbose "      [INPUTS] Section missing — injecting from README.md"
                try {
                    $readme      = Get-GlFileRaw -Project $repoPath -FilePath 'README.md' -Ref $defBranch
                    $inputsMatch = [System.Text.RegularExpressions.Regex]::Match(
                                       $readme, '(?ms)(^## Inputs\b.*?)(?=^## |\Z)')
                    if ($inputsMatch.Success) {
                        $inputsBlock = $inputsMatch.Groups[1].Value.TrimEnd()
                        $idx         = $raw.IndexOf("`n## Outputs")
                        if ($idx -gt 0) {
                            $raw = $raw.Substring(0, $idx + 1) + $inputsBlock + "`n`n" + $raw.Substring($idx + 1)
                            Write-Verbose "      [INPUTS] Injected"
                        }
                    }
                }
                catch { Write-Verbose "      [INPUTS] README.md unavailable: $_" }
            }

            $content = $raw
            Write-Host "      [SRC]  catalog docs/index.md" -ForegroundColor DarkGray
        }
        catch { Write-Verbose "      [CATALOG] Not found: $_" }

        # Strategy 2: module README.md
        if (-not $content) {
            try {
                $content = Get-GlFileRaw -Project $repoPath -FilePath 'README.md' -Ref $defBranch
                Write-Host "      [SRC]  module README.md" -ForegroundColor DarkGray
            }
            catch {
                Write-Warning "      [SKIP] No documentation found for $repoName — $_"
                $failed.Add("NO-CONTENT: $repoName | $_")
                continue
            }
        }

        $content = Remove-EscapedUnderscores -Md $content
        $content = Remove-ImageReferences    -Md $content

        New-Item -ItemType Directory -Path $entityDir -Force | Out-Null
        $mdPath = Join-Path $entityDir 'index.md'
        [System.IO.File]::WriteAllText($mdPath, $frontmatter + $content, [System.Text.Encoding]::UTF8)
        Write-Host "    [SAVED] $mdPath" -ForegroundColor Green

        $fetchedModules.Add($cpfName)
    }

    Write-Progress -Activity 'Fetching CPF modules' -Completed

    Write-Host ''
    Write-Host "Fetch complete — $($fetchedModules.Count) module(s) written to $OutputPath" -ForegroundColor Cyan

    if ($failed.Count -gt 0) {
        $failLog = Join-Path $OutputPath 'failed-repos.txt'
        $failed | Set-Content -Path $failLog -Encoding UTF8
        Write-Host "Failed fetch    : $($failed.Count)  (see $failLog)" -ForegroundColor Red
    }
    else {
        Write-Host "Failed fetch    : 0" -ForegroundColor Green
    }
}
else {
    Write-Host '--- Step 1/2 : Fetch skipped (-SkipFetch) ---' -ForegroundColor DarkGray
    Write-Host "    Using existing index.md files in: $OutputPath" -ForegroundColor DarkGray
    Write-Host ''
}

# ─────────────────────────────────────────────────────────────
# Step 2: Generate JSON schemas from index.md files
# ─────────────────────────────────────────────────────────────

if ($SkipSchemas -or $DryRun) {
    if ($DryRun) {
        Write-Host '--- Step 2/2 : Schema generation skipped (-DryRun) ---' -ForegroundColor DarkGray
    } else {
        Write-Host '--- Step 2/2 : Schema generation skipped (-SkipSchemas) ---' -ForegroundColor DarkGray
    }
    Write-Host ''
    exit 0
}

Write-Host ''
Write-Host '--- Step 2/2 : Generating JSON schemas ---' -ForegroundColor Yellow

if (-not (Test-Path $OutputPath)) {
    Write-Error "Docs output path not found: $OutputPath`nRun without -SkipFetch first, or set -OutputPath to your existing docs/cpf/ folder."
    exit 1
}

New-Item -ItemType Directory -Path $SchemaOutputDir -Force | Out-Null
Write-Host "[OK] Schema output directory ready: $SchemaOutputDir" -ForegroundColor Green

# If a NameFilter was active during fetch, only process those folders; otherwise all
$folders = if ($NameFilter -ne '' -and $fetchedModules.Count -gt 0) {
    $fetchedModules | ForEach-Object { Get-Item (Join-Path $OutputPath $_) -ErrorAction SilentlyContinue } |
    Where-Object { $_ }
} else {
    Get-ChildItem $OutputPath -Directory | Sort-Object Name
}

$schemaTotal  = @($folders).Count
$schemaCount  = 0
$schemaErrors = @()

Write-Host "Processing $schemaTotal module folder(s)..."

foreach ($folder in $folders) {
    $schemaCount++
    $cpfId     = $folder.Name
    $indexPath = Join-Path $folder.FullName 'index.md'

    if (-not (Test-Path $indexPath)) {
        Write-Host "[$schemaCount/$schemaTotal] SKIP (no index.md): $cpfId"
        continue
    }

    Write-Host "  [$schemaCount/$schemaTotal] Schema: $cpfId"

    try {
        $content = [System.IO.File]::ReadAllText($indexPath, [System.Text.Encoding]::UTF8)
        $content = $content -replace "`r`n", "`n" -replace "`r", "`n"

        $title          = Get-ModuleTitle     $content
        $gitlabUrl      = Get-GitLabSource    $content
        $moduleVersion  = Get-ModuleVersion   $content
        $tfSource       = Get-TerraformSource $cpfId $gitlabUrl $moduleVersion
        $moduleType     = Get-ModuleType      $cpfId
        $azureService   = Get-AzureServiceName $cpfId
        $prerequisites  = Get-Prerequisites   $content
        $inputs         = Get-Inputs          $content
        $outputs        = Get-Outputs         $content
        $resources      = Get-Resources       $content
        $requirements   = Get-Requirements    $content

        $requiredInputs = $inputs | Where-Object { $_.required -eq $true }

        $schema = [ordered]@{
            '$schema'                = 'http://json-schema.org/draft-07/schema#'
            title                    = "CPF Module Schema: $title"
            description              = "JSON schema for CPF module '$cpfId'. Use this to generate Terraform code that calls the CPF module."
            cpf_id                   = $cpfId
            module_type              = $moduleType
            azure_service            = $azureService
            module_name              = $title
            latest_tag               = $moduleVersion
            gitlab_repository        = $gitlabUrl
            terraform_source         = $tfSource
            terraform_requirements   = $requirements
            prerequisites            = @($prerequisites)
            azure_resources_created  = @($resources)
            terraform_usage          = [ordered]@{
                module_call_template = [ordered]@{
                    module_label = ($cpfId -replace '^cpf-azure-(prdsvc|prdapppat|prdsvcpat)-', '')
                    source       = $tfSource
                    version      = if ($moduleVersion -ne '') { $moduleVersion } else { 'latest' }
                }
            }
            inputs  = [ordered]@{
                type       = 'object'
                required   = @($requiredInputs | ForEach-Object { $_.name })
                properties = [ordered]@{}
            }
            outputs = [ordered]@{}
            agent_instructions = [ordered]@{
                summary     = "To provision '$azureService' via Terraform, call this CPF module with the inputs defined below. Required inputs have no default and must be provided."
                module_type_notes = switch ($moduleType) {
                    'service'              { 'This is a single-service CPF module. It provisions one Azure resource type.' }
                    'service-pattern'      { 'This is a service pattern module. It bundles multiple related services/configurations.' }
                    'application-pattern'  { 'This is an application pattern module. It provisions a full application-ready infrastructure stack.' }
                }
                naming_convention    = 'Resource names are auto-generated by the module using app_id, environment, and region.'
                prerequisite_modules = @($prerequisites)
            }
        }

        foreach ($inp in $inputs) {
            $prop = [ordered]@{
                type        = $inp.type
                description = $inp.description
                required    = $inp.required
            }
            if ($null -ne $inp.default -and $inp.default -ne '') {
                $prop['default'] = $inp.default
            }
            $schema['inputs']['properties'][$inp.name] = $prop
        }

        foreach ($out in $outputs) {
            $schema['outputs'][$out.name] = [ordered]@{ description = $out.description }
        }

        $jsonContent = $schema | ConvertTo-Json -Depth 20
        $outputPath  = Join-Path $SchemaOutputDir "$cpfId.json"
        [System.IO.File]::WriteAllText($outputPath, $jsonContent, [System.Text.Encoding]::UTF8)
    }
    catch {
        $schemaErrors += "[$cpfId] Error: $($_.Exception.Message)"
        Write-Warning "Error processing $cpfId`: $($_.Exception.Message)"
    }
}

# Catalog index
$catalog = @{
    generated_at  = (Get-Date -Format 'yyyy-MM-ddTHH:mm:ssZ')
    total_modules = $schemaCount
    cpf_root      = $OutputPath
    output_dir    = $SchemaOutputDir
    modules       = @()
}

Get-ChildItem $SchemaOutputDir -Filter '*.json' |
    Where-Object { $_.Name -ne '_catalog.json' } |
    Sort-Object Name |
    ForEach-Object {
        try {
            $mod = Get-Content $_.FullName -Raw | ConvertFrom-Json
            $catalog.modules += [ordered]@{
                cpf_id        = $mod.cpf_id
                module_type   = $mod.module_type
                azure_service = $mod.azure_service
                module_name   = $mod.module_name
                latest_tag    = $mod.latest_tag
                schema_file   = $_.Name
                input_count   = ($mod.inputs.properties.PSObject.Properties | Measure-Object).Count
                output_count  = ($mod.outputs.PSObject.Properties | Measure-Object).Count
            }
        } catch { }
    }

$catalogPath = Join-Path $SchemaOutputDir '_catalog.json'
$catalog | ConvertTo-Json -Depth 10 | Out-File -FilePath $catalogPath -Encoding UTF8
Write-Host "  [CATALOG] $catalogPath" -ForegroundColor DarkGray

# Version map
$versionMap = [ordered]@{
    generated_at = (Get-Date -Format 'yyyy-MM-ddTHH:mm:ssZ')
    modules      = [ordered]@{}
}

Get-ChildItem $SchemaOutputDir -Filter '*.json' |
    Where-Object { $_.Name -notin @('_catalog.json', '_version-map.json') } |
    Sort-Object Name |
    ForEach-Object {
        try {
            $mod = Get-Content $_.FullName -Raw | ConvertFrom-Json
            if (-not [string]::IsNullOrEmpty($mod.cpf_id)) {
                $versionMap.modules[$mod.cpf_id] = [ordered]@{
                    version       = if ($mod.latest_tag) { $mod.latest_tag } else { '' }
                    pinned_source = $mod.terraform_source
                }
            }
        } catch { }
    }

$versionMapPath = Join-Path $SchemaOutputDir '_version-map.json'
$versionMap | ConvertTo-Json -Depth 5 | Out-File -FilePath $versionMapPath -Encoding UTF8
Write-Host "  [VERSION MAP] $versionMapPath" -ForegroundColor DarkGray

# ─────────────────────────────────────────────────────────────
# Summary
# ─────────────────────────────────────────────────────────────

Write-Host ''
Write-Host '=== Done ===' -ForegroundColor Yellow
Write-Host ''
Write-Host "Docs directory    : $OutputPath"     -ForegroundColor Cyan
Write-Host "Schema directory  : $SchemaOutputDir" -ForegroundColor Cyan
Write-Host "Schemas generated : $($schemaCount - $schemaErrors.Count) / $schemaTotal" -ForegroundColor Cyan

if ($schemaErrors.Count -gt 0) {
    Write-Host "Schema errors     : $($schemaErrors.Count)" -ForegroundColor Red
    $schemaErrors | ForEach-Object { Write-Warning $_ }
}
else {
    Write-Host "Schema errors     : 0" -ForegroundColor Green
}

Write-Host ''
