#requires -Version 5.1
# Materializes rerunnable publication views and refreshes pending source provenance.
[CmdletBinding()]
param([string]$FeatureDirName, [string[]]$DeliverableId, [switch]$Json)

$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'common.ps1')

$repoRoot = Get-RepoRoot
if (-not $FeatureDirName) { $FeatureDirName = Get-CurrentFeatureDirName }
if (-not $FeatureDirName) { Write-Error 'Unable to identify one active feature. Pass -FeatureDirName or use a matching feature branch.'; exit 1 }
$paths = Get-FeaturePaths -FeatureDirName $FeatureDirName
if (-not (Test-Path -LiteralPath $paths.FEATURE_DIR -PathType Container)) { Write-Error "Feature folder '$($paths.FEATURE_DIR)' does not exist."; exit 1 }
if (-not (Test-Path -LiteralPath $paths.REQUIREMENTS -PathType Leaf) -and -not (Test-Path -LiteralPath $paths.REQUIREMENTS_INDEX -PathType Leaf)) {
    Write-Error 'Publication requires indexed requirements or requirements.md as an evidence source.'; exit 1
}

foreach ($directory in @($paths.DELIVERABLES_DIR, $paths.DELIVERABLES_EVIDENCE_DIR, $paths.DELIVERABLES_APPROVALS_DIR)) {
    New-Item -ItemType Directory -Path $directory -Force | Out-Null
}

$definitions = @(
    [PSCustomObject]@{ id='C-2'; file='C-license-forecast.md'; template='C-license-forecast.md'; managed=$true; applicability='Pending'; status='Not Started'; sourceBasis='requirements, architecture, plan, and commercial evidence' },
    [PSCustomObject]@{ id='C-3'; file='C-cost-profile.md'; template='C-cost-profile.md'; managed=$true; applicability='Applicable'; status='Not Started'; sourceBasis='architecture Section 13, plan, and calculator evidence' },
    [PSCustomObject]@{ id='F-1'; file='F-caf-eligibility-assessment.md'; template='F-caf-eligibility-assessment.md'; managed=$false; applicability='External'; status='Not Generated'; sourceBasis='external governance layer; versioned here only when externally supplied' },
    [PSCustomObject]@{ id='G-2'; file='G-sad-baseline.md'; template='G-sad-baseline.md'; managed=$true; applicability='Applicable'; status='Not Started'; sourceBasis='requirements, architecture Section 16, decisions, risks, and plan' },
    [PSCustomObject]@{ id='G-3'; file='G-test-plan.md'; template='G-test-plan.md'; managed=$true; applicability='Applicable'; status='In Progress'; sourceBasis='full-fidelity published copy of feature-root G-test-plan.md' },
    [PSCustomObject]@{ id='G-4'; file='G-mec-assessment.md'; template='G-mec-assessment.md'; managed=$true; applicability='Applicable'; status='Not Started'; sourceBasis='MEC requirements evidence, architecture Section 7, and spec Section 5' },
    [PSCustomObject]@{ id='G-6'; file='G-adr-risk-register.md'; template='G-adr-risk-register.md'; managed=$true; applicability='Applicable'; status='Not Started'; sourceBasis='authoritative decision and risk records' },
    [PSCustomObject]@{ id='G-7'; file='complexity-calculator.md'; template='complexity-calculator.md'; managed=$true; applicability='Pending'; status='Not Started'; sourceBasis='architecture Section 8A and signed calculator evidence' },
    [PSCustomObject]@{ id='G-9'; file='G-rtype-decision-record.md'; template='G-rtype-decision-record.md'; managed=$true; applicability='Pending'; status='Not Started'; sourceBasis='approved R-Type ADR and external governance evidence' },
    [PSCustomObject]@{ id='M-1'; file='M-migration-plan.md'; template='M-migration-plan.md'; managed=$true; applicability='Applicable'; status='Not Started'; sourceBasis='architecture Section 7A and plan.md' },
    [PSCustomObject]@{ id='S-1'; file='S-devsecops-report.md'; template='S-devsecops-report.md'; managed=$true; applicability='Applicable'; status='Not Started'; sourceBasis='requirements, architecture Sections 7 and 12, and implementation evidence' }
)

$existingManifest = $null
$existingById = @{}
if (Test-Path -LiteralPath $paths.PUBLICATION_MANIFEST -PathType Leaf) {
    try { $existingManifest = Get-Content -LiteralPath $paths.PUBLICATION_MANIFEST -Raw | ConvertFrom-Json }
    catch { Write-Error "Existing publication manifest is invalid JSON: $($_.Exception.Message)"; exit 1 }
    foreach ($entry in @($existingManifest.deliverables)) { $existingById[$entry.id] = $entry }
}

$templatesDirectory = Join-Path $repoRoot 'deliverables-template/md-templates'
$materialized = [System.Collections.Generic.List[string]]::new()
$deliverables = foreach ($definition in $definitions) {
    $selected = -not $DeliverableId -or $definition.id -in $DeliverableId
    if ($definition.managed -and $selected) {
        $destination = Join-Path $paths.DELIVERABLES_DIR $definition.file
        if (-not (Test-Path -LiteralPath $destination -PathType Leaf)) {
            if ($definition.id -eq 'G-3') {
                if (Test-Path -LiteralPath $paths.TEST_PLAN -PathType Leaf) {
                    Copy-Item -LiteralPath $paths.TEST_PLAN -Destination $destination
                    $materialized.Add($definition.file)
                }
            } else {
                Copy-Item -LiteralPath (Join-Path $templatesDirectory $definition.template) -Destination $destination
                $materialized.Add($definition.file)
            }
        }
    }
    $existing = $existingById[$definition.id]
    $existingHistory = [object[]]@()
    if ($existing) { $existingHistory = [object[]]@($existing.history | Where-Object { $null -ne $_ }) }
    [PSCustomObject]@{
        id = $definition.id
        path = $definition.file
        template = $definition.template
        frameworkManaged = $definition.managed
        applicability = if ($definition.id -eq 'G-3' -and -not (Test-Path -LiteralPath $paths.TEST_PLAN -PathType Leaf)) { 'Pending' } elseif ($definition.id -eq 'G-3' -and $existing -and $existing.applicability -eq 'Pending') { 'Applicable' } elseif ($existing -and $existing.applicability) { $existing.applicability } else { $definition.applicability }
        status = if ($definition.id -eq 'G-3' -and -not (Test-Path -LiteralPath $paths.TEST_PLAN -PathType Leaf)) { 'Not Started' } elseif ($definition.id -eq 'G-3' -and $existing -and $existing.status -in @('Canonical Source','Not Started')) { 'In Progress' } elseif ($existing -and $existing.status) { $existing.status } else { $definition.status }
        sourceBasis = $definition.sourceBasis
        currentVersion = if ($existing -and $null -ne $existing.currentVersion) { [int]$existing.currentVersion } else { 0 }
        contentHash = if ($existing) { $existing.contentHash } else { $null }
        history = $existingHistory
        notes = if ($definition.id -eq 'G-3' -and -not (Test-Path -LiteralPath $paths.TEST_PLAN -PathType Leaf)) { 'Pending: canonical feature-root G-test-plan.md does not exist yet; no deliverable copy was created.' } elseif ($definition.id -eq 'G-3') { 'Full-fidelity published copy of canonical feature-root G-test-plan.md; human approval state is unchanged.' } elseif ($existing) { $existing.notes } else { $null }
    }
}

$sourceState = Get-PublicationSourceState -FeatureDirectory $paths.FEATURE_DIR
    $existingRunHistory = [object[]]@()
    if ($existingManifest) { $existingRunHistory = [object[]]@($existingManifest.runHistory | Where-Object { $null -ne $_ }) }
$manifest = [ordered]@{
    schemaVersion = 1
    feature = $FeatureDirName
    frameworkVersion = (Get-Content -LiteralPath (Join-Path $repoRoot 'VERSION') -Raw).Trim()
    publicationRun = if ($existingManifest -and $existingManifest.publicationRun) { [int]$existingManifest.publicationRun } else { 0 }
    sourceFingerprint = if ($existingManifest) { $existingManifest.sourceFingerprint } else { $null }
    pendingSourceFingerprint = $sourceState.fingerprint
    sources = $sourceState.sources
    evidenceDirectory = 'evidence'
    approvalsDirectory = 'approvals'
    runHistory = $existingRunHistory
    deliverables = @($deliverables)
}
$manifest | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath $paths.PUBLICATION_MANIFEST -Encoding UTF8

Write-ScriptResult -Data @{ feature=$FeatureDirName; manifest=$paths.PUBLICATION_MANIFEST; materialized=@($materialized); pendingSourceFingerprint=$sourceState.fingerprint } -Json:$Json