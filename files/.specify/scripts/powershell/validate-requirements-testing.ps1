#requires -Version 5.1
# Validates the authoritative application testing requirements profile before architecture begins.
[CmdletBinding()]
param(
    [string]$TestingProfilePath,
    [string]$RequirementsDirectory,
    [ValidateSet('Draft','ReadyForReview','Execution')]
    [string]$ValidationStage = 'Execution',
    [switch]$Json
)

$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'common.ps1')

if (-not $TestingProfilePath) {
    $featureDirName = Get-CurrentFeatureDirName
    if (-not $featureDirName) { Write-Error 'Unable to identify the current feature.'; exit 1 }
    $paths = Get-FeaturePaths -FeatureDirName $featureDirName
    $TestingProfilePath = $paths.TESTING_PROFILE
    $RequirementsDirectory = $paths.REQUIREMENTS_DIR
}
if (-not (Test-Path -LiteralPath $TestingProfilePath -PathType Leaf)) {
    Write-Error "testing-profile.md not found: $TestingProfilePath"
    exit 1
}
if (-not $RequirementsDirectory) { $RequirementsDirectory = Split-Path -Parent $TestingProfilePath }

$content = Get-Content -LiteralPath $TestingProfilePath -Raw
$errors = [System.Collections.Generic.List[string]]::new()
$warnings = [System.Collections.Generic.List[string]]::new()
$inputCompleteness = [ordered]@{ sources = 0; verifiedAssets = 0; unresolvedAssets = 0; openConflicts = 0; openActions = 0 }
$requiredTypes = @(
    'Connectivity', 'Unit', 'Data migration verification', 'Migration tool',
    'Application installation', 'Smoke/regression', 'Change-based functional',
    'Full functional', 'Performance and baseline', 'High availability',
    'Disaster recovery', 'Security testing', 'Security penetration testing',
    'Operational acceptance testing', 'User acceptance testing'
)
$allowedDispositions = @('Applicable', 'Conditionally Applicable', 'Not Applicable', 'Exception Proposed', 'Unknown')
$requirementIds = @()
if (Test-Path -LiteralPath $RequirementsDirectory -PathType Container) {
    $requirementIds = @(Get-ChildItem -LiteralPath $RequirementsDirectory -File -Filter '*.md' |
        Where-Object { $_.BaseName -match '^(REQ|NFR)-\d{3}-' } |
        ForEach-Object { ([regex]::Match($_.BaseName, '^(REQ|NFR)-\d{3}')).Value })
}

$profileMatch = [regex]::Match($content, '(?ms)^##\s+Testing Requirements Profile\s*$\s*(?<body>.*?)(?=^##\s|\z)')
if (-not $profileMatch.Success) {
    $errors.Add('Missing required Testing Requirements Profile section.')
} else {
    $profile = $profileMatch.Groups['body'].Value
    $header = ([regex]::Match($profile, '(?m)^\|.*\|\s*$')).Value
    foreach ($column in @('Test Type','Baseline Applicability','Disposition','R-Type / Scope Condition','Requirement IDs','Required Outcome / Measurable Target','Expected Environment','Evidence / Rationale','Execution Owner','Approval Owner','Linked ADR/Risk')) {
        if ($header -notmatch [regex]::Escape($column)) { $errors.Add("Testing profile is missing required column '$column'.") }
    }

    foreach ($testType in $requiredTypes) {
        $rows = @([regex]::Matches($profile, "(?mi)^\|\s*$([regex]::Escape($testType))\s*\|(?<rest>.*)$"))
        if ($rows.Count -ne 1) { $errors.Add("Testing profile must contain exactly one '$testType' row (found $($rows.Count))."); continue }
        $cells = @($rows[0].Groups['rest'].Value.TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
        if ($cells.Count -lt 10) { $errors.Add("Testing profile row '$testType' does not contain all required fields."); continue }

        $baseline = $cells[0]
        $disposition = $cells[1]
        $condition = $cells[2]
        $idsCell = $cells[3]
        $outcome = $cells[4]
        $environment = $cells[5]
        $evidence = $cells[6]
        $executionOwner = $cells[7]
        $approvalOwner = $cells[8]
        $adrRisk = $cells[9]

        if ($baseline -notin @('Required','Conditional')) { $errors.Add("Testing profile row '$testType' has invalid baseline applicability '$baseline'.") }
        if ($disposition -notin $allowedDispositions) { $errors.Add("Testing profile row '$testType' has invalid disposition '$disposition'.") }
        foreach ($field in @(@('R-Type / Scope Condition',$condition), @('Required Outcome / Measurable Target',$outcome), @('Expected Environment',$environment), @('Evidence / Rationale',$evidence), @('Execution Owner',$executionOwner), @('Approval Owner',$approvalOwner))) {
            if (-not $field[1] -or $field[1] -match '^\s*\{.*\}\s*$') { $errors.Add("Testing profile row '$testType' is missing '$($field[0])'.") }
        }

        $linkedIds = @([regex]::Matches($idsCell, '\b(?:REQ|NFR)-\d{3}\b') | ForEach-Object { $_.Value } | Select-Object -Unique)
        if ($disposition -in @('Applicable','Conditionally Applicable','Exception Proposed') -and $linkedIds.Count -eq 0) {
            $errors.Add("Testing profile row '$testType' with disposition '$disposition' must link at least one REQ/NFR.")
        }
        foreach ($linkedId in $linkedIds) {
            if ($requirementIds -notcontains $linkedId) { $errors.Add("Testing profile row '$testType' references missing requirement '$linkedId'.") }
        }
        if ($disposition -eq 'Not Applicable' -and $baseline -ne 'Conditional') {
            $errors.Add("Required testing profile row '$testType' cannot be Not Applicable; use Exception Proposed with governance.")
        }
        if ($disposition -eq 'Not Applicable' -and ($evidence -match '^\s*(?:N/?A|None|Unknown|\{.*\})\s*$')) {
            $errors.Add("Not Applicable testing profile row '$testType' requires evidence proving its condition is false.")
        }
        if ($disposition -eq 'Exception Proposed' -and $adrRisk -notmatch '\bADR-\d{4}\b.*\bRSK-\d{3}\b|\bRSK-\d{3}\b.*\bADR-\d{4}\b') {
            $errors.Add("Exception Proposed testing profile row '$testType' must link both a Proposed ADR and Identified risk.")
        }
        if ($disposition -eq 'Unknown') {
            if ($adrRisk -notmatch '\b(?:ADR-\d{4}|RSK-\d{3})\b') { $errors.Add("Unknown testing profile row '$testType' must link an ADR/risk.") }
        }
        if ($testType -eq 'User acceptance testing' -and $disposition -ne 'Applicable') {
            $errors.Add('User acceptance testing must be Applicable and cannot be conditional, omitted, or excepted.')
        }
        if ($testType -eq 'Unit') {
            if ($condition -notmatch '(?i)existing automated suites' -or $condition -notmatch '(?i)code changed during migration|impacted code') {
                $errors.Add('Unit testing must preserve existing automated suites and limit Migration Team implementation/extension to migration-changed, impacted code.')
            }
        }
        if ($testType -eq 'Disaster recovery' -and $environment -notmatch '(?i)Production.*acceptance') {
            $errors.Add('Disaster recovery acceptance must explicitly occur in Production; lower environments are rehearsal only.')
        }
    }

    if (@([regex]::Matches($profile, '(?mi)^\|\s*Integration(?:\s+testing)?\s*\|')).Count -gt 0) {
        $errors.Add('Integration is scenario scope, not a standalone testing-profile test type; place it under Change-based functional or mandatory UAT.')
    }
    $changeFunctionalRow = [regex]::Match($profile, '(?mi)^\|\s*Change-based functional\s*\|(?<rest>.*)$')
    if ($changeFunctionalRow.Success) {
        $changeFunctionalText = $changeFunctionalRow.Value
        foreach ($term in @('integration', 'Re-Factor', 'Re-Host/Re-Platform', 'Migration Team', 'UAT', 'Application Team')) {
            if ($changeFunctionalText -notmatch [regex]::Escape($term)) {
                $errors.Add("Change-based functional testing must define the integration ownership branch and include '$term'.")
            }
        }
    }
    $uatRow = [regex]::Match($profile, '(?mi)^\|\s*User acceptance testing\s*\|(?<rest>.*)$')
    if ($uatRow.Success -and ($uatRow.Value -notmatch '(?i)integration' -or $uatRow.Value -notmatch '(?i)Application Team')) {
        $errors.Add('Mandatory UAT must include applicable integration scenarios under Application Team ownership.')
    }
}

$automationReview = [regex]::Match($content, '(?ms)^##\s+Automation Availability Review\s*$\s*(?<body>.*?)(?=^##\s|\z)')
if (-not $automationReview.Success) {
    $errors.Add('Missing required Automation Availability Review section.')
} else {
    $reviewIds = @()
    foreach ($testType in $requiredTypes) {
        $rows = @([regex]::Matches($automationReview.Groups['body'].Value, "(?mi)^\|\s*(?<id>AUT-\d{2,})\s*\|\s*$([regex]::Escape($testType))\s*\|(?<rest>.*)$"))
        if ($rows.Count -ne 1) { $errors.Add("Automation review must contain exactly one '$testType' entry."); continue }
        $reviewIds += $rows[0].Groups['id'].Value
        $cells = @($rows[0].Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
        if ($cells.Count -ne 5) { $errors.Add("Automation review '$testType' must contain all five review fields."); continue }
        $status = $cells[0]
        if ($status -notin @('Verified','Partial','None','Unknown','Not Applicable')) { $errors.Add("Automation review '$testType' has invalid status '$status'.") }
        foreach ($index in 1..4) {
            if (-not $cells[$index] -or $cells[$index] -match '^\{.*\}$') { $errors.Add("Automation review '$testType' has an unresolved required field."); break }
        }
        if ($status -in @('Partial','None','Verified') -and ($cells[1] -notmatch '\b\d{4}-\d{2}-\d{2}\b' -or $cells[1] -match '(?i)^\s*(?:Unknown|Pending|None|N/?A)\s*$')) {
            $errors.Add("Automation review '$testType' status '$status' requires dated response/run evidence.")
        }
        if ($status -in @('Unknown','Partial','None')) {
            if ($cells[3] -notmatch '(?i)Application Team' -or $cells[3] -notmatch '(?i)owner|coordinator' -or $cells[3] -notmatch '(?i)needed.by') {
                $errors.Add("Automation review '$testType' requires an Application Team action/contact, coordinating owner and needed-by gate/date.")
            }
            if ($cells[4] -notmatch '\b(?:REQ|NFR)-\d{3}\b' -or $cells[4] -notmatch '\b(?:ADR-\d{4}|RSK-\d{3})\b') {
                $errors.Add("Automation review '$testType' gap must trace a requirement and ADR/risk.")
            }
        }
        if ($status -eq 'Not Applicable') {
            $typeRow = [regex]::Match($profileMatch.Groups['body'].Value, "(?mi)^\|\s*$([regex]::Escape($testType))\s*\|(?<rest>.*)$")
            $typeCells = @($typeRow.Groups['rest'].Value.TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
            if ($typeCells.Count -lt 2 -or $typeCells[1] -ne 'Not Applicable') { $errors.Add("Automation review '$testType' cannot be Not Applicable when testing applicability is not Not Applicable.") }
        }
    }
    if (@($reviewIds | Select-Object -Unique).Count -ne $reviewIds.Count) { $errors.Add('Automation review IDs must be unique.') }
}

$sourceSection = [regex]::Match($content, '(?ms)^##\s+Evidence Sources and Conflicts\s*$\s*(?<body>.*?)(?=^##\s|\z)')
$assetSection = [regex]::Match($content, '(?ms)^##\s+Test Asset Inventory\s*$\s*(?<body>.*?)(?=^##\s|\z)')
$actionSection = [regex]::Match($content, '(?ms)^##\s+Human Input and Decision Register\s*$\s*(?<body>.*?)(?=^##\s|\z)')
$modernSections = @(
    @{ Name='Evidence Sources and Conflicts'; Match=$sourceSection },
    @{ Name='Test Asset Inventory'; Match=$assetSection },
    @{ Name='Human Input and Decision Register'; Match=$actionSection }
)
foreach ($section in $modernSections) {
    if (-not $section.Match.Success) {
        if ($ValidationStage -eq 'Draft') { $warnings.Add("Legacy profile is missing '$($section.Name)'; migrate it before review.") }
        else { $errors.Add("Testing profile is missing required section '$($section.Name)'.") }
    }
}

$sourceIds = @()
$conflictIds = @()
if ($sourceSection.Success) {
    $sourceBody = $sourceSection.Groups['body'].Value
    $sourceRows = @([regex]::Matches($sourceBody, '(?mi)^\|\s*(?<id>SRC-\d{3})\s*\|(?<rest>.*)$'))
    foreach ($sourceRow in $sourceRows) {
        $cells = @($sourceRow.Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
        if ($cells.Count -ne 7) { $errors.Add("Evidence source '$($sourceRow.Groups['id'].Value)' must contain all seven provenance fields (found $($cells.Count))."); continue }
        if ($cells[0] -match '(?i)^(?:N/?A|Unknown|TBD|\{.*\})$' -or $cells[1] -match '(?i)^(?:N/?A|Unknown|TBD|\{.*\})$') { $errors.Add("Evidence source '$($sourceRow.Groups['id'].Value)' needs an artifact/version and exact locator or explicit follow-up.") }
        if ($cells[3] -notin @('Sourced fact','Proposed judgment','Human input','Approved decision')) { $errors.Add("Evidence source '$($sourceRow.Groups['id'].Value)' has invalid evidence class '$($cells[3])'.") }
        if ($cells[4] -match '(?i)^(?:N/?A|Unknown|TBD|\{.*\})$') { $errors.Add("Evidence source '$($sourceRow.Groups['id'].Value)' must name governing authority or the human action needed.") }
        $sourceIds += $sourceRow.Groups['id'].Value
        $inputCompleteness.sources++
    }
    if (@($sourceIds | Select-Object -Unique).Count -ne $sourceIds.Count) { $errors.Add('Evidence Source IDs must be unique.') }
    $conflictRows = @([regex]::Matches($sourceBody, '(?mi)^\|\s*(?<id>CON-\d{3})\s*\|(?<rest>.*)$'))
    foreach ($conflictRow in $conflictRows) {
        $cells = @($conflictRow.Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
        if ($cells.Count -ne 6) { $errors.Add("Source conflict '$($conflictRow.Groups['id'].Value)' must contain all six resolution fields."); continue }
        if ($cells[0] -notmatch '\bSRC-\d{3}\b.*\bSRC-\d{3}\b' -or $cells[0] -match '\bSRC-(\d{3})\b.*\bSRC-\1\b') { $errors.Add("Source conflict '$($conflictRow.Groups['id'].Value)' must cite two distinct competing source IDs and locators.") }
        if ($cells[2] -match '(?i)^(?:N/?A|Unknown|TBD|\{.*\})$' -and $cells[3] -notmatch '\b(?:ACT-\d{3}|AUT-\d{2,})\b') { $errors.Add("Unresolved source conflict '$($conflictRow.Groups['id'].Value)' must identify its owner action.") }
        if ($cells[4] -notin @('Open','Resolved with evidence')) { $errors.Add("Source conflict '$($conflictRow.Groups['id'].Value)' has invalid status '$($cells[4])'.") }
        if ($cells[4] -eq 'Open') { $inputCompleteness.openConflicts++ }
        $conflictIds += $conflictRow.Groups['id'].Value
    }
    if (@($conflictIds | Select-Object -Unique).Count -ne $conflictIds.Count) { $errors.Add('Source Conflict IDs must be unique.') }
}

$registeredActions = @{}
if ($actionSection.Success) {
    $actionRows = @([regex]::Matches($actionSection.Groups['body'].Value, '(?mi)^\|\s*(?<id>ACT-\d{3}|AUT-\d{2,})\s*\|(?<rest>.*)$'))
    foreach ($actionRow in $actionRows) {
        $actionId = $actionRow.Groups['id'].Value
        $cells = @($actionRow.Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
        if ($cells.Count -ne 8) { $errors.Add("Human input action '$actionId' must contain all eight action fields (found $($cells.Count))."); continue }
        if ($registeredActions.ContainsKey($actionId)) { $errors.Add("Human input action ID '$actionId' is duplicated.") } else { $registeredActions[$actionId] = $true }
        if ($cells[0] -match '(?i)^(?:N/?A|Unknown|TBD|\{.*\})$' -or $cells[1] -match '(?i)^(?:N/?A|Unknown|TBD|\{.*\})$') { $errors.Add("Action '$actionId' must state a specific question and expected evidence.") }
        if ($cells[2] -match '(?i)^(?:N/?A|Unknown|TBD|\{.*\})$' -or $cells[3] -match '(?i)^(?:N/?A|Unknown|TBD|\{.*\})$') { $errors.Add("Action '$actionId' must name a contact/accountable coordinator and needed-by date or gate.") }
        if ($cells[6] -notin @('Requested','Answered-unvalidated','Validated','Closed')) { $errors.Add("Action '$actionId' has invalid status '$($cells[6])'.") }
        if ($cells[6] -in @('Validated','Closed') -and ($cells[7] -match '(?i)^(?:Pending|Unknown|N/?A|\{.*\})$' -or $cells[7] -notmatch '(?i)(?:https?://|(?:SRC|AST|CASE|REQ|NFR|ADR|RSK|report|result|evidence|record)[-/#])')) { $errors.Add("Action '$actionId' cannot be Validated/Closed without an answer and evidence locator.") }
        if ($cells[6] -in @('Requested','Answered-unvalidated')) { $inputCompleteness.openActions++ }
    }
    $autActions = @($actionRows | Where-Object { $_.Groups['id'].Value -match '^AUT-' } | ForEach-Object { $_.Groups['id'].Value })
    if (@($autActions | Select-Object -Unique).Count -ne $autActions.Count) { $errors.Add('Automation review action IDs must be unique in the shared action register.') }
}

if ($assetSection.Success) {
    $assetRows = @([regex]::Matches($assetSection.Groups['body'].Value, '(?mi)^\|\s*(?<id>AST-\d{3})\s*\|(?<rest>.*)$'))
    $assetIds = @()
    foreach ($assetRow in $assetRows) {
        $assetId = $assetRow.Groups['id'].Value
        $cells = @($assetRow.Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
        if ($cells.Count -ne 8) { $errors.Add("Test asset '$assetId' must contain all eight inventory fields (found $($cells.Count))."); continue }
        if ($cells[2] -notin @('Reported-linked','Available-unverified','Verified-available','Unavailable','Unknown')) { $errors.Add("Test asset '$assetId' has invalid availability '$($cells[2])'.") }
        if ($cells[3] -notin @('Reuse','Adapt','Build','Manual','Excluded','Undecided')) { $errors.Add("Test asset '$assetId' has invalid reuse health '$($cells[3])'.") }
        if ($cells[2] -eq 'Verified-available' -and ($cells[5] -notmatch '\b20\d{2}-\d{2}-\d{2}\b' -or $cells[5] -notmatch '(?i)\b(?:run|result|report)\b')) { $errors.Add("Test asset '$assetId' cannot be Verified-available without dated run/result evidence.") }
        if ($cells[2] -in @('Available-unverified','Unavailable','Unknown') -and $cells[7] -notmatch '\b(?:ACT-\d{3}|AUT-\d{2,})\b') { $errors.Add("Unverified test asset '$assetId' needs an action to confirm availability or report the gap.") }
        foreach ($actionId in @([regex]::Matches($cells[7], '\b(?:ACT-\d{3}|AUT-\d{2,})\b') | ForEach-Object { $_.Value })) {
            if (-not $registeredActions.ContainsKey($actionId) -and $actionId -notmatch '^AUT-' ) { $errors.Add("Test asset '$assetId' references missing action '$actionId'.") }
        }
        $assetIds += $assetId
        if ($cells[2] -eq 'Verified-available') { $inputCompleteness.verifiedAssets++ }
        if ($cells[2] -in @('Reported-linked','Available-unverified','Unavailable','Unknown')) { $inputCompleteness.unresolvedAssets++ }
    }
    if (@($assetIds | Select-Object -Unique).Count -ne $assetIds.Count) { $errors.Add('Test Asset IDs must be unique.') }
}

if ($automationReview.Success) {
    foreach ($testType in $requiredTypes) {
        $reviewRow = [regex]::Match($automationReview.Groups['body'].Value, "(?mi)^\|\s*(?<id>AUT-\d{2,})\s*\|\s*$([regex]::Escape($testType))\s*\|(?<rest>.*)$")
        if (-not $reviewRow.Success) { continue }
        $reviewCells = @($reviewRow.Groups['rest'].Value.TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
        if ($reviewCells.Count -lt 5) { continue }
        $status = $reviewCells[0]
        $needsAction = $status -in @('Unknown','Partial','None')
        if ($needsAction -and $reviewCells[3] -notmatch "\b$([regex]::Escape($reviewRow.Groups['id'].Value))\b") { $errors.Add("Automation review '$($reviewRow.Groups['id'].Value)' must link its shared action ID.") }
        if ($needsAction -and -not $registeredActions.ContainsKey($reviewRow.Groups['id'].Value) -and $ValidationStage -ne 'Draft') { $errors.Add("Automation review '$($reviewRow.Groups['id'].Value)' requires a matching action in Human Input and Decision Register.") }
        if ($status -eq 'Verified' -and ($reviewCells[1] -notmatch '\b20\d{2}-\d{2}-\d{2}\b' -or $reviewCells[1] -notmatch '(?i)\b(?:run|result|report)\b' -or $reviewCells[2] -match '(?i)^(?:Unknown|Pending|N/?A|\{.*\})$')) {
            $errors.Add("Automation review '$($reviewRow.Groups['id'].Value)' cannot claim Verified without dated run/result evidence and a stated verified coverage scope.")
        }
    }
}

$readinessMatch = [regex]::Match($content, '(?ms)^##\s+Test Readiness Inputs\s*$\s*(?<body>.*?)(?=^##\s|\z)')
if (-not $readinessMatch.Success) {
    $errors.Add('Missing required Test Readiness Inputs section.')
} else {
    $readinessRows = @([regex]::Matches($readinessMatch.Groups['body'].Value, '(?m)^\|\s*[^|]+\s*\|(?<rest>.*)$') | Where-Object { $_.Value -notmatch '^\|\s*(?:Readiness Area|---)' })
    if ($readinessRows.Count -lt 8) { $errors.Add("Test Readiness Inputs must contain all 8 areas; found $($readinessRows.Count).") }
    foreach ($row in $readinessRows) {
        $cells = @($row.Groups['rest'].Value.TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
        if ($cells.Count -lt 4) { $errors.Add("Incomplete Test Readiness row: $($row.Value.Trim())"); continue }
        if ($cells[0] -notin @('Ready','Partial','Unknown','Not Applicable')) { $errors.Add("Invalid Test Readiness status '$($cells[0])'.") }
        if ($cells[0] -in @('Partial','Unknown') -and $cells[3] -notmatch '\b(?:REQ|NFR|ADR|RSK)-\d{3,4}\b') {
            $errors.Add("Test Readiness row '$($row.Value.Trim())' is incomplete/unknown and must link a requirement, ADR, or risk.")
        }
    }
}

if ($content -match '\{[^{}\r\n]+\}') { $errors.Add('Testing profile contains unresolved template placeholders.') }

$result = @{
    testingProfilePath = [System.IO.Path]::GetFullPath($TestingProfilePath)
    validationStage = $ValidationStage
    valid = ($errors.Count -eq 0)
    errorCount = $errors.Count
    errors = @($errors)
    warnings = @($warnings)
    inputCompleteness = $inputCompleteness
}
Write-ScriptResult -Data $result -Json:$Json
if ($errors.Count -gt 0) { exit 1 }
exit 0
