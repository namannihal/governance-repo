#requires -Version 5.1
# Validates publication provenance, per-deliverable versions, and rerun-safe storage boundaries.
[CmdletBinding()]
param([string]$FeatureDirName, [string[]]$DeliverableId, [switch]$Json)

$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'common.ps1')

if (-not $FeatureDirName) { $FeatureDirName = Get-CurrentFeatureDirName }
if (-not $FeatureDirName) { Write-Error 'Unable to identify one active feature.'; exit 1 }
$paths = Get-FeaturePaths -FeatureDirName $FeatureDirName
$errors = [System.Collections.Generic.List[string]]::new()
$manifest = $null
if (-not (Test-Path -LiteralPath $paths.PUBLICATION_MANIFEST -PathType Leaf)) { $errors.Add("Publication manifest is missing at $($paths.PUBLICATION_MANIFEST).") }
else {
    try { $manifest = Get-Content -LiteralPath $paths.PUBLICATION_MANIFEST -Raw | ConvertFrom-Json }
    catch { $errors.Add("Publication manifest is invalid JSON: $($_.Exception.Message)") }
}

if ($manifest) {
    if ($manifest.schemaVersion -ne 1) { $errors.Add('Publication manifest schemaVersion must be 1.') }
    if ($manifest.feature -ne $FeatureDirName) { $errors.Add("Manifest feature '$($manifest.feature)' does not match '$FeatureDirName'.") }
    if ($manifest.pendingSourceFingerprint) { $errors.Add('Publication setup has not been finalized.') }
    $requiredIds = @('C-2','C-3','F-1','G-2','G-3','G-4','G-6','G-7','G-9','M-1','S-1')
    foreach ($id in $requiredIds) {
        $matches = @($manifest.deliverables | Where-Object { $_.id -eq $id })
        if ($matches.Count -ne 1) { $errors.Add("Manifest must contain exactly one $id entry (found $($matches.Count)).") }
    }
    $externalEntry = $manifest.deliverables | Where-Object { $_.id -eq 'F-1' }
    if ($externalEntry.applicability -ne 'External') { $errors.Add('F-1 must remain External unless a separate governance layer explicitly owns it.') }
    $testPlanEntry = @($manifest.deliverables | Where-Object { $_.id -eq 'G-3' })
    if ($testPlanEntry.Count -eq 1 -and ($testPlanEntry[0].path -ne 'G-test-plan.md' -or -not $testPlanEntry[0].frameworkManaged)) {
        $errors.Add('G-3 must be a framework-managed deliverable at deliverables/G-test-plan.md, sourced from the canonical feature-root G-test-plan.md.')
    }
    $selectedEntries = @($manifest.deliverables | Where-Object { $_.path -and (-not $DeliverableId -or $_.id -in $DeliverableId) })
    if ($DeliverableId -and $selectedEntries.Count -ne $DeliverableId.Count) { $errors.Add('One or more requested deliverable IDs are missing or have no publishable path.') }
    foreach ($entry in $selectedEntries) {
        $outputPath = [System.IO.Path]::GetFullPath((Join-Path $paths.DELIVERABLES_DIR $entry.path))
        if (-not (Test-Path -LiteralPath $outputPath -PathType Leaf)) {
            if ($entry.id -eq 'G-3' -and $entry.applicability -eq 'Pending' -and -not (Test-Path -LiteralPath $paths.TEST_PLAN -PathType Leaf) -and -not ($DeliverableId -and 'G-3' -in $DeliverableId)) { continue }
            if ($entry.frameworkManaged) { $errors.Add("Managed deliverable $($entry.id) is missing at $outputPath.") }
            continue
        }
        $content = Get-Content -LiteralPath $outputPath -Raw
        if ($content -notmatch '<!-- speckit-publication-metadata:start -->') { $errors.Add("Deliverable $($entry.id) has no publication metadata block."); continue }
        if ($content -notmatch "\*\*Deliverable Version:\*\*\s+$($entry.currentVersion)\s") { $errors.Add("Deliverable $($entry.id) version does not match its manifest entry.") }
        $baseContent = Get-PublicationContentBody -Content $content
        if ($entry.id -eq 'G-3') {
            if (-not (Test-Path -LiteralPath $paths.TEST_PLAN -PathType Leaf)) {
                $errors.Add('G-3 publication exists but the canonical feature-root G-test-plan.md is missing.')
            } else {
                $canonicalBody = Get-PublicationContentBody -Content (Get-Content -LiteralPath $paths.TEST_PLAN -Raw)
                if ($baseContent -cne $canonicalBody) { $errors.Add('G-3 publication content differs from the canonical feature-root G-test-plan.md.') }
            }
        }
        if ($entry.id -eq 'C-3' -and $baseContent -match '(?i)Datadog|BigPanda') {
            if ($baseContent -notmatch '(?is)Excluded from C-3.{0,160}Application Team|Application Team.{0,160}Excluded from C-3') {
                $errors.Add('C-3 references Datadog/BigPanda without declaring their commercial charges excluded and Application Team-owned.')
            }
            $pricedThirdPartyLines = @($baseContent -split "`n" | Where-Object { $_ -match '(?i)Datadog|BigPanda' -and $_ -match '\$\s*[0-9{]' })
            if ($pricedThirdPartyLines.Count -gt 0) { $errors.Add('C-3 must not assign a currency amount to Datadog/BigPanda; price Azure-native observability resources only.') }
        }
        if ((Get-Sha256ForText -Text $baseContent) -ne $entry.contentHash) { $errors.Add("Deliverable $($entry.id) content hash does not match its manifest entry.") }
        $history = @($entry.history | Where-Object { $null -ne $_ })
        if ($entry.currentVersion -lt 1 -or $history.Count -ne $entry.currentVersion) { $errors.Add("Deliverable $($entry.id) has a non-contiguous version history.") }
        if ($entry.status -match '^(Complete|Approved|Revalidated)$') {
            $approval = @(Get-ChildItem -LiteralPath $paths.DELIVERABLES_APPROVALS_DIR -File -Filter "$($entry.id)-v$($entry.currentVersion)-*" -ErrorAction SilentlyContinue)
            if ($approval.Count -eq 0) { $errors.Add("Deliverable $($entry.id) is $($entry.status) but has no approval named '$($entry.id)-v$($entry.currentVersion)-*'.") }
        }
    }
    $currentSourceState = Get-PublicationSourceState -FeatureDirectory $paths.FEATURE_DIR
    if ($manifest.sourceFingerprint -ne $currentSourceState.fingerprint) { $errors.Add('Publication sources changed after the last publish pass. Re-run /speckit.publish.') }
}

foreach ($directory in @($paths.DELIVERABLES_EVIDENCE_DIR, $paths.DELIVERABLES_APPROVALS_DIR)) {
    if (-not (Test-Path -LiteralPath $directory -PathType Container)) { $errors.Add("Required rerun-safe directory is missing: $directory") }
}

if ($errors.Count -gt 0) {
    if ($Json) { @{ valid=$false; feature=$FeatureDirName; errors=@($errors) } | ConvertTo-Json -Depth 6 }
    else { $errors | ForEach-Object { Write-Error $_ } }
    exit 1
}
Write-ScriptResult -Data @{ valid=$true; feature=$FeatureDirName; publicationRun=$manifest.publicationRun; sourceFingerprint=$manifest.sourceFingerprint } -Json:$Json