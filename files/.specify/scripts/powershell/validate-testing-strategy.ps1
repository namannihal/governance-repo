#requires -Version 5.1
# Validates the testing strategy source, extraction, hierarchy, tables, and media against the reviewed baseline.
[CmdletBinding()]
param(
    [string]$DocxPath,
    [string]$MarkdownPath,
    [string]$IndexPath,
    [string]$ContractPath,
    [switch]$Json
)

$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'common.ps1')

$repoRoot = Get-RepoRoot
$strategyRoot = Join-Path $repoRoot 'docs/testing-strategy'
$DocxPath = if ($DocxPath) { $DocxPath } else { Join-Path $strategyRoot 'LMP Migration Testing Strategy.docx' }
$MarkdownPath = if ($MarkdownPath) { $MarkdownPath } else { Join-Path $strategyRoot 'LMP-Migration-Testing-Strategy.md' }
$IndexPath = if ($IndexPath) { $IndexPath } else { Join-Path $strategyRoot 'INDEX.md' }
$ContractPath = if ($ContractPath) { $ContractPath } else { Join-Path $strategyRoot 'testing-strategy-contract.json' }

foreach ($path in @($DocxPath, $MarkdownPath, $IndexPath, $ContractPath)) {
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) { throw "Required testing strategy input missing: $path" }
}

$contract = Get-Content -LiteralPath $ContractPath -Raw | ConvertFrom-Json
$expectedSourceHash = $contract.sourceSha256
$expectedMarkdownHash = $contract.markdownSha256
$errors = [System.Collections.Generic.List[string]]::new()
$sourceHash = (Get-FileHash -LiteralPath $DocxPath -Algorithm SHA256).Hash
$markdownHash = (Get-FileHash -LiteralPath $MarkdownPath -Algorithm SHA256).Hash
$indexHash = (Get-FileHash -LiteralPath $IndexPath -Algorithm SHA256).Hash
$markdown = Get-Content -LiteralPath $MarkdownPath -Raw
$index = Get-Content -LiteralPath $IndexPath -Raw

if ($sourceHash -ne $expectedSourceHash) {
    $errors.Add("Testing strategy DOCX changed ($expectedSourceHash -> $sourceHash); re-extract and review the index and workflow rules.")
}
if ($markdownHash -ne $expectedMarkdownHash) {
    $errors.Add("Testing strategy Markdown changed ($expectedMarkdownHash -> $markdownHash); re-extract or update the reviewed baseline.")
}
if ($indexHash -ne $contract.indexSha256) {
    $errors.Add("Testing strategy index changed ($($contract.indexSha256) -> $indexHash); review its policy interpretation and update the contract deliberately.")
}

$headingCounts = @{
    level1 = [regex]::Matches($markdown, '(?m)^# ').Count
    level2 = [regex]::Matches($markdown, '(?m)^## ').Count
    level3 = [regex]::Matches($markdown, '(?m)^### ').Count
}
if ($headingCounts.level1 -ne $contract.counts.level1Headings) { $errors.Add("Expected $($contract.counts.level1Headings) level-one headings including the generated TOC; found $($headingCounts.level1).") }
if ($headingCounts.level2 -ne $contract.counts.level2Headings) { $errors.Add("Expected $($contract.counts.level2Headings) level-two headings; found $($headingCounts.level2).") }
if ($headingCounts.level3 -ne $contract.counts.level3Headings) { $errors.Add("Expected $($contract.counts.level3Headings) level-three headings; found $($headingCounts.level3).") }
foreach ($requiredSection in @('High Availability Testing','Disaster Recovery Testing')) {
    if ($markdown -notmatch "(?m)^##\s+$([regex]::Escape($requiredSection))\s*$") {
        $errors.Add("Testing strategy Markdown is missing source section '$requiredSection'.")
    }
}

Add-Type -AssemblyName System.IO.Compression.FileSystem
$archive = [System.IO.Compression.ZipFile]::OpenRead($DocxPath)
try {
    $documentEntry = $archive.GetEntry('word/document.xml')
    if (-not $documentEntry) { throw 'DOCX does not contain word/document.xml.' }
    $reader = [System.IO.StreamReader]::new($documentEntry.Open())
    try { $documentXml = $reader.ReadToEnd() } finally { $reader.Dispose() }
    $tableCount = [regex]::Matches($documentXml, '<w:tbl(?=[ >])').Count
} finally {
    $archive.Dispose()
}
if ($tableCount -ne $contract.counts.sourceTables) { $errors.Add("Expected $($contract.counts.sourceTables) source tables; found $tableCount.") }

$mediaReferences = @([regex]::Matches($markdown, '(?i)\./media/(?<name>image\d+\.[a-z0-9]+)') | ForEach-Object { $_.Groups['name'].Value } | Sort-Object -Unique)
$mediaFiles = @(Get-ChildItem -LiteralPath (Join-Path $strategyRoot 'media') -File -ErrorAction SilentlyContinue)
if ($mediaReferences.Count -ne $contract.counts.media) { $errors.Add("Expected $($contract.counts.media) unique media references; found $($mediaReferences.Count).") }
if ($mediaFiles.Count -ne $contract.counts.media) { $errors.Add("Expected $($contract.counts.media) extracted media files; found $($mediaFiles.Count).") }
foreach ($reference in $mediaReferences) {
    if (-not (Test-Path -LiteralPath (Join-Path $strategyRoot "media/$reference") -PathType Leaf)) {
        $errors.Add("Referenced testing strategy media file is missing: $reference")
    }
}
foreach ($expectedMedia in $contract.media) {
    $mediaPath = Join-Path $strategyRoot "media/$($expectedMedia.file)"
    if (-not (Test-Path -LiteralPath $mediaPath -PathType Leaf)) { $errors.Add("Contract media file is missing: $($expectedMedia.file)"); continue }
    $mediaHash = (Get-FileHash -LiteralPath $mediaPath -Algorithm SHA256).Hash
    if ($mediaHash -ne $expectedMedia.sha256) { $errors.Add("Testing strategy media '$($expectedMedia.file)' changed ($($expectedMedia.sha256) -> $mediaHash).") }
}

foreach ($marker in $contract.requiredIndexMarkers) {
    if (-not $index.Contains($marker)) { $errors.Add("Testing strategy index missing required marker: $marker") }
}

$result = @{
    valid = ($errors.Count -eq 0)
    errorCount = $errors.Count
    errors = @($errors)
    sourceSha256 = $sourceHash
    markdownSha256 = $markdownHash
    indexSha256 = $indexHash
    headings = $headingCounts
    sourceTables = $tableCount
    mediaReferences = $mediaReferences.Count
    mediaFiles = $mediaFiles.Count
}
Write-ScriptResult -Data $result -Json:$Json
if ($errors.Count -gt 0) { exit 1 }
exit 0
