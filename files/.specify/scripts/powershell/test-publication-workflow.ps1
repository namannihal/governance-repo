#requires -Version 5.1
# Self-contained smoke test for rerunnable publication and per-deliverable version history.
[CmdletBinding()]
param([switch]$Json, [string]$WorkspaceRoot = ([System.IO.Path]::GetTempPath()))

$ErrorActionPreference = 'Stop'
$tempRoot = Join-Path $WorkspaceRoot ("spec-layer-publication-" + [guid]::NewGuid().ToString('N'))
$featureName = '001-publication-fixture'
$featureRoot = Join-Path (Join-Path $tempRoot 'specs') $featureName
$previousAppRoot = $env:SPEC_LAYER_APP_ROOT

try {
    New-Item -ItemType Directory -Path (Join-Path $featureRoot 'requirements') -Force | Out-Null
    New-Item -ItemType Directory -Path (Join-Path $featureRoot 'decisions') -Force | Out-Null
    New-Item -ItemType Directory -Path (Join-Path $featureRoot 'risks') -Force | Out-Null
    '# Requirements fixture' | Set-Content -LiteralPath (Join-Path $featureRoot 'requirements.md') -Encoding UTF8
    '# Architecture fixture' | Set-Content -LiteralPath (Join-Path $featureRoot 'architecture.md') -Encoding UTF8
    @('# Test Plan fixture','','## Review Brief','','Draft proposal; appointments and environment evidence remain pending.',
        "[Human inputs](/specs/$featureName/requirements/testing-profile.md#human-input-and-decision-register)",
        '[Case mappings](#high-level-case-outlines)','','## Test Strategy','','### High-Level Case Outlines','',
        '| Case ID | Origin | Disposition |','| --- | --- | --- |','| CASE-001 | Proposed | Pending — ACT-001 |') |
        Set-Content -LiteralPath (Join-Path $featureRoot 'G-test-plan.md') -Encoding UTF8
    '# ADR index fixture' | Set-Content -LiteralPath (Join-Path $featureRoot 'decisions/index.md') -Encoding UTF8
    '# Risk index fixture' | Set-Content -LiteralPath (Join-Path $featureRoot 'risks/index.md') -Encoding UTF8
    $env:SPEC_LAYER_APP_ROOT = $tempRoot

    & (Join-Path $PSScriptRoot 'setup-publication.ps1') -FeatureDirName $featureName -DeliverableId 'C-3' -Json | Out-Null
    if (-not (Test-Path -LiteralPath (Join-Path $featureRoot 'deliverables/C-cost-profile.md'))) { throw 'Scoped setup did not materialize C-3.' }
    if (Test-Path -LiteralPath (Join-Path $featureRoot 'deliverables/G-adr-risk-register.md')) { throw 'Scoped setup materialized an unrelated deliverable.' }
    & (Join-Path $PSScriptRoot 'finalize-publication.ps1') -FeatureDirName $featureName -DeliverableId 'C-3' -Json | Out-Null
    & (Join-Path $PSScriptRoot 'validate-publication.ps1') -FeatureDirName $featureName -DeliverableId 'C-3' -Json | Out-Null

    & (Join-Path $PSScriptRoot 'setup-publication.ps1') -FeatureDirName $featureName -Json | Out-Null
    $publishedTestPlanPath = Join-Path $featureRoot 'deliverables/G-test-plan.md'
    if (-not (Test-Path -LiteralPath $publishedTestPlanPath)) { throw 'Full setup did not publish the canonical G-3 Test Plan under deliverables.' }
    if ((Get-Content -LiteralPath (Join-Path $featureRoot 'G-test-plan.md') -Raw).Trim() -ne (Get-Content -LiteralPath $publishedTestPlanPath -Raw).Trim()) { throw 'Initial G-3 publication differs from its canonical source.' }
    $publishedBody = Get-Content -LiteralPath $publishedTestPlanPath -Raw
    if ($publishedBody.IndexOf('## Review Brief') -ge $publishedBody.IndexOf('## Test Strategy') -or -not $publishedBody.Contains('| CASE-001 | Proposed | Pending — ACT-001 |')) { throw 'Publication lost the source-owned opening brief or detailed pending case mapping.' }
    'Fixture publication content.' | Add-Content -LiteralPath (Join-Path $featureRoot 'deliverables/G-adr-risk-register.md') -Encoding UTF8
    'Evidence survives reruns.' | Set-Content -LiteralPath (Join-Path $featureRoot 'deliverables/evidence/source.txt') -Encoding UTF8
    & (Join-Path $PSScriptRoot 'finalize-publication.ps1') -FeatureDirName $featureName -Json | Out-Null
    & (Join-Path $PSScriptRoot 'validate-publication.ps1') -FeatureDirName $featureName -Json | Out-Null
    $first = Get-Content -LiteralPath (Join-Path $featureRoot 'deliverables/manifest.json') -Raw | ConvertFrom-Json
    $firstG6 = $first.deliverables | Where-Object { $_.id -eq 'G-6' }
    $firstG3 = $first.deliverables | Where-Object { $_.id -eq 'G-3' }
    if ($firstG6.currentVersion -ne 1) { throw 'First publication did not assign G-6 version 1.' }
    if (@($firstG6.history).Count -ne 1) { throw "First publication produced $(@($firstG6.history).Count) G-6 history entries; expected 1." }
    if ($firstG3.path -ne 'G-test-plan.md' -or -not $firstG3.frameworkManaged -or $firstG3.currentVersion -ne 1) { throw 'G-3 was not tracked as a managed deliverable version 1.' }

    & (Join-Path $PSScriptRoot 'setup-publication.ps1') -FeatureDirName $featureName -Json | Out-Null
    $afterSecondSetup = Get-Content -LiteralPath (Join-Path $featureRoot 'deliverables/manifest.json') -Raw | ConvertFrom-Json
    $afterSecondSetupG6 = $afterSecondSetup.deliverables | Where-Object { $_.id -eq 'G-6' }
    if (@($afterSecondSetupG6.history).Count -ne 1) { throw "Second setup produced $(@($afterSecondSetupG6.history).Count) G-6 history entries; expected 1." }
    & (Join-Path $PSScriptRoot 'finalize-publication.ps1') -FeatureDirName $featureName -Json | Out-Null
    $second = Get-Content -LiteralPath (Join-Path $featureRoot 'deliverables/manifest.json') -Raw | ConvertFrom-Json
    $secondG6 = $second.deliverables | Where-Object { $_.id -eq 'G-6' }
    $secondG3 = $second.deliverables | Where-Object { $_.id -eq 'G-3' }
    if ($secondG6.currentVersion -ne 1) { throw 'Unchanged rerun incorrectly incremented G-6.' }
    if (@($secondG6.history).Count -ne 1) { throw "Unchanged rerun produced $(@($secondG6.history).Count) G-6 history entries; expected 1." }
    if ($secondG3.currentVersion -ne 1 -or @($secondG3.history).Count -ne 1) { throw 'Unchanged rerun incorrectly changed G-3 history.' }

    'Changed requirement.' | Add-Content -LiteralPath (Join-Path $featureRoot 'requirements.md') -Encoding UTF8
    'Updated canonical Test Plan.' | Add-Content -LiteralPath (Join-Path $featureRoot 'G-test-plan.md') -Encoding UTF8
    & (Join-Path $PSScriptRoot 'setup-publication.ps1') -FeatureDirName $featureName -Json | Out-Null
    'Regenerated decision content.' | Add-Content -LiteralPath (Join-Path $featureRoot 'deliverables/G-adr-risk-register.md') -Encoding UTF8
    Copy-Item -LiteralPath (Join-Path $featureRoot 'G-test-plan.md') -Destination $publishedTestPlanPath -Force
    & (Join-Path $PSScriptRoot 'finalize-publication.ps1') -FeatureDirName $featureName -Json | Out-Null
    & (Join-Path $PSScriptRoot 'validate-publication.ps1') -FeatureDirName $featureName -Json | Out-Null
    $third = Get-Content -LiteralPath (Join-Path $featureRoot 'deliverables/manifest.json') -Raw | ConvertFrom-Json
    $thirdG6 = $third.deliverables | Where-Object { $_.id -eq 'G-6' }
    $thirdG3 = $third.deliverables | Where-Object { $_.id -eq 'G-3' }
    if ($thirdG6.currentVersion -ne 2 -or @($thirdG6.history).Count -ne 2) { throw "Changed rerun produced G-6 version $($thirdG6.currentVersion) with $(@($thirdG6.history).Count) history entries; expected version 2 with 2 entries." }
    if ($thirdG3.currentVersion -ne 2 -or @($thirdG3.history).Count -ne 2) { throw 'Changed canonical test plan did not increment G-3 to version 2.' }
    if (-not (Test-Path -LiteralPath (Join-Path $featureRoot 'deliverables/evidence/source.txt'))) { throw 'Rerun removed evidence.' }

    'Source changed after publication.' | Add-Content -LiteralPath (Join-Path $featureRoot 'requirements.md') -Encoding UTF8
    & (Join-Path $PSScriptRoot 'validate-publication.ps1') -FeatureDirName $featureName -Json 2>$null | Out-Null
    if ($LASTEXITCODE -eq 0) { throw 'Stale source fingerprint was not rejected.' }

    $pendingFeatureName = '002-publication-pending-test-plan'
    $pendingFeatureRoot = Join-Path (Join-Path $tempRoot 'specs') $pendingFeatureName
    foreach ($directory in @('requirements','decisions','risks')) { New-Item -ItemType Directory -Path (Join-Path $pendingFeatureRoot $directory) -Force | Out-Null }
    '# Pending requirements fixture' | Set-Content -LiteralPath (Join-Path $pendingFeatureRoot 'requirements.md') -Encoding UTF8
    & (Join-Path $PSScriptRoot 'setup-publication.ps1') -FeatureDirName $pendingFeatureName -Json | Out-Null
    $pendingDeliverablePath = Join-Path $pendingFeatureRoot 'deliverables/G-test-plan.md'
    if (Test-Path -LiteralPath $pendingDeliverablePath) { throw 'Publication invented a G-3 deliverable before the canonical Test Plan existed.' }
    & (Join-Path $PSScriptRoot 'finalize-publication.ps1') -FeatureDirName $pendingFeatureName -Json | Out-Null
    & (Join-Path $PSScriptRoot 'validate-publication.ps1') -FeatureDirName $pendingFeatureName -Json | Out-Null
    $pendingManifest = Get-Content -LiteralPath (Join-Path $pendingFeatureRoot 'deliverables/manifest.json') -Raw | ConvertFrom-Json
    $pendingG3 = $pendingManifest.deliverables | Where-Object { $_.id -eq 'G-3' }
    if ($pendingG3.applicability -ne 'Pending' -or $pendingG3.status -ne 'Not Started') { throw 'G-3 without a source must remain Pending/Not Started.' }
    '# Newly authored canonical Test Plan' | Set-Content -LiteralPath (Join-Path $pendingFeatureRoot 'G-test-plan.md') -Encoding UTF8
    & (Join-Path $PSScriptRoot 'setup-publication.ps1') -FeatureDirName $pendingFeatureName -Json | Out-Null
    $activatedManifest = Get-Content -LiteralPath (Join-Path $pendingFeatureRoot 'deliverables/manifest.json') -Raw | ConvertFrom-Json
    $activatedG3 = $activatedManifest.deliverables | Where-Object { $_.id -eq 'G-3' }
    if ($activatedG3.applicability -ne 'Applicable' -or $activatedG3.status -ne 'In Progress' -or -not (Test-Path -LiteralPath $pendingDeliverablePath)) { throw 'G-3 did not become an In Progress publication when its canonical source was added.' }
    if ((Get-Content -LiteralPath (Join-Path $pendingFeatureRoot 'G-test-plan.md') -Raw).Trim() -ne (Get-Content -LiteralPath $pendingDeliverablePath -Raw).Trim()) { throw 'Activated G-3 publication differs from its canonical source.' }
    if ((Get-Content -LiteralPath $pendingDeliverablePath -Raw) -match '## Review Brief') { throw 'Publication invented a brief absent from its canonical source.' }
    & (Join-Path $PSScriptRoot 'finalize-publication.ps1') -FeatureDirName $pendingFeatureName -Json | Out-Null
    & (Join-Path $PSScriptRoot 'validate-publication.ps1') -FeatureDirName $pendingFeatureName -Json | Out-Null

    $result = @{ passed=$true; scopedPublication=$true; publicationRuns=$third.publicationRun; g3Version=$thirdG3.currentVersion; g3History=@($thirdG3.history).Count; g6Version=$thirdG6.currentVersion; g6History=@($thirdG6.history).Count; staleSourceRejected=$true; pendingG3Skipped=$true; pendingG3Activated=$true }
    if ($Json) { $result | ConvertTo-Json -Depth 5 } else { $result.GetEnumerator() | ForEach-Object { Write-Host ("{0}: {1}" -f $_.Key, $_.Value) } }
} finally {
    $env:SPEC_LAYER_APP_ROOT = $previousAppRoot
    Remove-Item -LiteralPath $tempRoot -Recurse -Force -ErrorAction SilentlyContinue
}