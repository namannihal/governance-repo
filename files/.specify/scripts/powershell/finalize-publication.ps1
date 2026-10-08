#requires -Version 5.1
# Assigns versions to changed deliverables and appends immutable manifest history.
[CmdletBinding()]
param([string]$FeatureDirName, [string[]]$DeliverableId, [switch]$Json)

$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'common.ps1')

if (-not $FeatureDirName) { $FeatureDirName = Get-CurrentFeatureDirName }
if (-not $FeatureDirName) { Write-Error 'Unable to identify one active feature.'; exit 1 }
$paths = Get-FeaturePaths -FeatureDirName $FeatureDirName
if (-not (Test-Path -LiteralPath $paths.PUBLICATION_MANIFEST -PathType Leaf)) { Write-Error 'Run setup-publication.ps1 before finalizing.'; exit 1 }
try { $manifest = Get-Content -LiteralPath $paths.PUBLICATION_MANIFEST -Raw | ConvertFrom-Json }
catch { Write-Error "Publication manifest is invalid JSON: $($_.Exception.Message)"; exit 1 }

$sourceState = Get-PublicationSourceState -FeatureDirectory $paths.FEATURE_DIR
if ($manifest.pendingSourceFingerprint -ne $sourceState.fingerprint) { Write-Error 'Source artifacts changed after publication setup. Re-run /speckit.publish from setup.'; exit 1 }
$publishedAt = [DateTime]::UtcNow.ToString('o')
$changed = [System.Collections.Generic.List[string]]::new()

$selectedEntries = @($manifest.deliverables | Where-Object { $_.path -and (-not $DeliverableId -or $_.id -in $DeliverableId) })
if ($DeliverableId -and $selectedEntries.Count -ne $DeliverableId.Count) { Write-Error 'One or more requested deliverable IDs are missing or have no publishable path.'; exit 1 }
foreach ($entry in $selectedEntries) {
    $path = [System.IO.Path]::GetFullPath((Join-Path $paths.DELIVERABLES_DIR $entry.path))
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        if ($entry.id -eq 'G-3' -and $entry.applicability -eq 'Pending' -and -not (Test-Path -LiteralPath $paths.TEST_PLAN -PathType Leaf)) {
            if ($DeliverableId -and 'G-3' -in $DeliverableId) { Write-Error 'Cannot publish G-3 because the canonical feature-root G-test-plan.md is missing.'; exit 1 }
            continue
        }
        if ($entry.frameworkManaged) { Write-Error "Managed deliverable $($entry.id) is missing at $path."; exit 1 }
        continue
    }
    $content = Get-Content -LiteralPath $path -Raw
    $baseContent = Get-PublicationContentBody -Content $content
    if ($entry.id -eq 'G-3') {
        if (-not (Test-Path -LiteralPath $paths.TEST_PLAN -PathType Leaf)) { Write-Error 'Cannot publish G-3 because the canonical feature-root G-test-plan.md is missing.'; exit 1 }
        $canonicalBody = Get-PublicationContentBody -Content (Get-Content -LiteralPath $paths.TEST_PLAN -Raw)
        if ($baseContent -cne $canonicalBody) { Write-Error 'G-3 published content differs from the canonical root G-test-plan.md. Render the source copy before finalization.'; exit 1 }
    }
    $contentHash = Get-Sha256ForText -Text $baseContent
    $version = [int]$entry.currentVersion
    $history = @($entry.history | Where-Object { $null -ne $_ })
    if ($entry.contentHash -ne $contentHash) {
        $version++
        $changed.Add($entry.id)
        $history += [PSCustomObject]@{
            version = $version
            publishedAtUtc = $publishedAt
            sourceFingerprint = $sourceState.fingerprint
            contentHash = $contentHash
            frameworkVersion = $manifest.frameworkVersion
        }
    }
    $entry.currentVersion = $version
    $entry.contentHash = $contentHash
    $entry.history = @($history)
    $versionPublishedAt = if ($history.Count -gt 0) { $history[-1].publishedAtUtc } else { $publishedAt }

    $metadata = @(
        '<!-- speckit-publication-metadata:start -->',
        "**Deliverable Version:** $version  ",
        "**Framework Template Version:** $($manifest.frameworkVersion)  ",
        "**Source Fingerprint:** ``$($sourceState.fingerprint)``  ",
        "**Published UTC:** $versionPublishedAt",
        '<!-- speckit-publication-metadata:end -->'
    ) -join "`r`n"
    $firstBreak = $baseContent.IndexOf("`n")
    if ($firstBreak -ge 0) {
        $updatedContent = $baseContent.Substring(0, $firstBreak + 1) + "`r`n" + $metadata + "`r`n`r`n" + $baseContent.Substring($firstBreak + 1).TrimStart("`r", "`n")
    } else {
        $updatedContent = $baseContent + "`r`n`r`n" + $metadata + "`r`n"
    }
    Set-Content -LiteralPath $path -Value $updatedContent -Encoding UTF8
}

$manifest.publicationRun = [int]$manifest.publicationRun + 1
$manifest.sourceFingerprint = $sourceState.fingerprint
$manifest.pendingSourceFingerprint = $null
$manifest.sources = $sourceState.sources
$manifest.runHistory = @($manifest.runHistory | Where-Object { $null -ne $_ }) + [PSCustomObject]@{
    run = $manifest.publicationRun
    publishedAtUtc = $publishedAt
    sourceFingerprint = $sourceState.fingerprint
    changedDeliverables = @($changed)
}
$manifest | ConvertTo-Json -Depth 12 | Set-Content -LiteralPath $paths.PUBLICATION_MANIFEST -Encoding UTF8

Write-ScriptResult -Data @{ feature=$FeatureDirName; publicationRun=$manifest.publicationRun; changedDeliverables=@($changed); sourceFingerprint=$sourceState.fingerprint } -Json:$Json