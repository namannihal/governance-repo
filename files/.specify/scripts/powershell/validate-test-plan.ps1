#requires -Version 5.1
# Validates the canonical application G-test-plan.md before task generation.
[CmdletBinding()]
param(
    [string]$TestPlanPath,
    [string]$TestingProfilePath,
    [string]$ArchitecturePath,
    [string]$PlanPath,
    [ValidateSet('Draft','ReadyForReview','Execution')]
    [string]$ValidationStage = 'Execution',
    [switch]$Json
)

$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'common.ps1')

if (-not $TestPlanPath) {
    $featureDirName = Get-CurrentFeatureDirName
    if (-not $featureDirName) { Write-Error 'Unable to identify the current feature.'; exit 1 }
    $paths = Get-FeaturePaths -FeatureDirName $featureDirName
    $TestPlanPath = $paths.TEST_PLAN
    $TestingProfilePath = $paths.TESTING_PROFILE
    $ArchitecturePath = $paths.ARCHITECTURE
    $PlanPath = $paths.PLAN
}
foreach ($path in @($TestPlanPath,$TestingProfilePath,$ArchitecturePath,$PlanPath)) {
    if (-not $path -or -not (Test-Path -LiteralPath $path -PathType Leaf)) { Write-Error "Required Test Plan validation input missing: $path"; exit 1 }
}

$content = Get-Content -LiteralPath $TestPlanPath -Raw
$profile = Get-Content -LiteralPath $TestingProfilePath -Raw
$architecture = Get-Content -LiteralPath $ArchitecturePath -Raw
$plan = Get-Content -LiteralPath $PlanPath -Raw
$statusMatch = [regex]::Match($content, '(?mi)^\|\s*\*\*Status\*\*\s*\|\s*(?<status>[^|]+?)\s*\|')
$planStatus = if ($statusMatch.Success) { $statusMatch.Groups['status'].Value.Trim() } else { $null }
$errors = [System.Collections.Generic.List[string]]::new()
$warnings = [System.Collections.Generic.List[string]]::new()
$inputCompleteness = [ordered]@{ verified = 0; unresolved = 0; unavailable = 0; conflicting = 0 }
$testTypes = @('Connectivity','Unit','Data migration verification','Migration tool','Application installation','Smoke/regression','Change-based functional','Full functional','Performance and baseline','High availability','Disaster recovery','Security testing','Security penetration testing','Operational acceptance testing','User acceptance testing')
$resolvedPlanDispositions = @{}
$deferredReadiness = [System.Collections.Generic.List[string]]::new()
$deferredApprovers = [System.Collections.Generic.List[string]]::new()
$actionsSectionMatch = [regex]::Match($profile, '(?ms)^##\s+Human Input and Decision Register\s*$\s*(?<body>.*?)(?=^##\s|\z)')
$profileActionRows = @([regex]::Matches($actionsSectionMatch.Groups['body'].Value, '(?mi)^\|\s*(?<id>ACT-\d{3}|AUT-\d{2,})\s*\|(?<rest>.*)$'))
$ownedActions = @{}
foreach ($actionRow in $profileActionRows) {
    $actionId = $actionRow.Groups['id'].Value
    $actionCells = @($actionRow.Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
    if ($ownedActions.ContainsKey($actionId)) { $errors.Add("Profile action '$actionId' is duplicated."); continue }
    if ($actionCells.Count -ne 8 -or @($actionCells | Where-Object { -not $_ -or $_ -match '(?i)^(?:Unknown|TBD|N/?A|None|\{.*\})$' }).Count -gt 0 -or
        $actionCells[2] -match '(?i)(?:^|:\s*)(?:Pending|Unknown|TBD)(?:$|[;,])' -or $actionCells[3] -match '(?i)^Pending$' -or
        $actionCells[6] -notin @('Requested','Answered-unvalidated','Validated','Closed')) {
        $errors.Add("Profile action '$actionId' requires a substantive question, evidence, contact/coordinator, needed-by gate, trace, impact and valid status.")
        continue
    }
    if ($actionCells[6] -in @('Validated','Closed') -and ($actionCells[7] -match '(?i)^Pending$' -or $actionCells[7] -notmatch '(?i)(?:https?://|(?:SRC|AST|CASE|REQ|NFR|ADR|RSK|report|result|evidence|record)[-/#])')) {
        $errors.Add("Profile action '$actionId' cannot be Validated/Closed without an answer and evidence locator.")
        continue
    }
    $ownedActions[$actionId] = $actionCells
}

function Test-OwnedDependency {
    param([string]$Trace, [switch]$Appointment)
    $traceIds = @([regex]::Matches($Trace, '\b(?:ACT-\d{3}|AUT-\d{2,}|REQ-\d{3}|NFR-\d{3}|ADR-\d{4}|RSK-\d{3})\b') | ForEach-Object { $_.Value })
    foreach ($actionId in $ownedActions.Keys) {
        $cells = $ownedActions[$actionId]
        if ($cells[6] -notin @('Requested','Answered-unvalidated')) { continue }
        if ($Appointment -and ($cells[0] + ' ' + $cells[5]) -notmatch '(?i)approv|appoint|authority|roster|named') { continue }
        # Existing plans can trace the authoritative action through its REQ/NFR or ADR/risk.
        $actionTrace = @($actionId) + @([regex]::Matches($cells[4], '\b(?:REQ-\d{3}|NFR-\d{3}|ADR-\d{4}|RSK-\d{3})\b') | ForEach-Object { $_.Value })
        if (@($traceIds | Where-Object { $actionTrace -contains $_ }).Count -gt 0) { return $true }
    }
    return $false
}

$automationReviewSection = [regex]::Match($profile, '(?ms)^##\s+Automation Availability Review\s*$\s*(?<body>.*?)(?=^##\s|\z)')
foreach ($reviewRow in @([regex]::Matches($automationReviewSection.Groups['body'].Value, '(?mi)^\|\s*(?<id>AUT-\d{2,})\s*\|(?<rest>.*)$'))) {
    $cells = @($reviewRow.Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
    if ($cells.Count -ne 6) { $errors.Add("Automation review '$($reviewRow.Groups['id'].Value)' requires all review fields."); continue }
    if ($cells[1] -in @('Unknown','Partial','None') -and -not $ownedActions.ContainsKey($reviewRow.Groups['id'].Value)) { $errors.Add("Unresolved automation review '$($reviewRow.Groups['id'].Value)' requires an owned profile action.") }
    if ($cells[1] -eq 'Verified' -and ($cells[2] -notmatch '\b20\d{2}-\d{2}-\d{2}\b' -or $cells[2] -notmatch '(?i)\b(?:run|result|report)\b')) { $errors.Add("Automation review '$($reviewRow.Groups['id'].Value)' cannot be Verified without dated run/result evidence.") }
}

$sizingMatch = [regex]::Match($content, '(?ms)^###\s+Scenario Scope and Automation Effort\s*$\s*(?<body>.*?)(?=^###\s|^##\s|\z)')
if (-not $sizingMatch.Success) {
    $errors.Add('Test Plan missing Scenario Scope and Automation Effort section.')
} else {
    $designMatch = [regex]::Match($architecture, '(?ms)^###\s+14\.3\s+High-Level Test Scenario Design\s*$\s*(?<body>.*?)(?=^###\s|^##\s|\z)')
    foreach ($testType in $testTypes) {
        $scopeRow = [regex]::Match($content, "(?mi)^\|\s*$([regex]::Escape($testType))\s*\|\s*(?<applicability>[^|]+)\|")
        if ($scopeRow.Success -and $scopeRow.Groups['applicability'].Value.Trim() -match '^Not Applicable|^Exception Approved') { continue }
        $rows = @([regex]::Matches($sizingMatch.Groups['body'].Value, "(?mi)^\|\s*[^|]+\s*\|\s*$([regex]::Escape($testType))\s*\|(?<rest>.*)$"))
        if ($rows.Count -eq 0) { $errors.Add("Test Plan requires scenario/automation effort for '$testType'."); continue }
        foreach ($row in $rows) {
            $cells = @($row.Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
            if ($cells.Count -ne 6) { $errors.Add("Test Plan sizing '$testType' requires all six scope/effort fields."); continue }
            foreach ($index in 0..5) {
                if (-not $cells[$index] -or $cells[$index] -match '^\{.*\}$') { $errors.Add("Test Plan sizing '$testType' has an unresolved field."); break }
            }
            $designRows = @([regex]::Matches($designMatch.Groups['body'].Value, "(?mi)^\|\s*(?<id>[^|]+)\s*\|\s*$([regex]::Escape($testType))\s*\|"))
            if ($designRows.Count -eq 0 -or -not @($designRows | Where-Object { $cells[0].Contains($_.Groups['id'].Value.Trim()) }).Count) {
                $errors.Add("Test Plan sizing '$testType' must reference its Section 14.3 scenario scope.")
            }
            $reviewRow = [regex]::Match($profile, "(?mi)^\|\s*(?<id>AUT-\d{2,})\s*\|\s*$([regex]::Escape($testType))\s*\|")
            if (-not $reviewRow.Success -or $cells[1] -notmatch "\b$([regex]::Escape($reviewRow.Groups['id'].Value))\b") { $errors.Add("Test Plan sizing '$testType' must trace its automation review action.") }
            foreach ($effortPhase in @('Review','Automation','Setup','Execution','Retest','Report')) {
                if ($cells[3] -notmatch "(?i)\b$effortPhase\s*[:=]\s*\d") { $errors.Add("Test Plan sizing '$testType' requires a numeric person-day range for $effortPhase.") }
            }
            if ($cells[4] -notmatch '(?i)Section\s+\d' -or $cells[4] -notmatch '(?i)Appendix 5') { $errors.Add("Test Plan sizing '$testType' requires LMP section/RACI ownership evidence.") }
        }
    }
}

function Get-NormalizedApplicability {
    param([string]$Value)
    if ($Value -match '^Applicable(?:\s+[—:-]\s+.+)?$') { return 'Applicable' }
    if ($Value -match '^Not Applicable(?:\s+[—:-]\s+.+)?$') { return 'Not Applicable' }
    if ($Value -match '^Exception Approved(?:\s+[—:-]\s+.+)?$') { return 'Exception Approved' }
    return $null
}

function Test-IsNamedPerson {
    param([string]$Value)
    if (-not $Value) { return $false }
    $namePart = ($Value -replace '\s+\([^)]+\)\s*$','').Trim()
    return $namePart -match "^[A-Za-z][A-Za-z'.-]+(?:\s+[A-Za-z][A-Za-z'.-]+)+$" -and
        $namePart -notmatch '(?i)\b(?:Pending|Unknown|TBD|Unassigned|Appointment|Named|Team|Lead|Architect|Owner|Manager|Reviewer|Approver|Security|Operations|Testing|Migration|Application|Product|Customer|QA|LSEG|Microsoft)\b'
}

foreach ($heading in @('## Test Strategy','### Test Types','### Estimated Elapsed Testing Timeline and Capacity','### Optional Pre-OAT Scope — Lower Environment','### High Availability Test Design','### Disaster Recovery Test Design','### Operational Acceptance Test Design','### Minimum Viable Testing','### Automation Strategy and Ownership','### RACI','### Test Assets and Traceability','### Environment Strategy','### Entry/Exit Criteria','### Defect Management','### Exceptions, Dependencies and Approvals','### Test Plan Review and Approval','## Test Plan Approval Gate')) {
    if ($content -notmatch "(?m)^$([regex]::Escape($heading))\s*$") { $errors.Add("Test Plan missing required heading: $heading") }
}

$testSectionMatch = [regex]::Match($content, '(?ms)^###\s+Test Types\s*$\s*(?<body>.*?)(?=^###\s|^##\s|\z)')
$haSectionMatch = [regex]::Match($content, '(?ms)^###\s+High Availability Test Design\s*$\s*(?<body>.*?)(?=^###\s|^##\s|\z)')
$drSectionMatch = [regex]::Match($content, '(?ms)^###\s+Disaster Recovery Test Design\s*$\s*(?<body>.*?)(?=^###\s|^##\s|\z)')
$oatSectionMatch = [regex]::Match($content, '(?ms)^###\s+Operational Acceptance Test Design\s*$\s*(?<body>.*?)(?=^###\s|^##\s|\z)')
$timelineMatch = [regex]::Match($content, '(?ms)^###\s+Estimated Elapsed Testing Timeline and Capacity\s*$\s*(?<body>.*?)(?=^###\s|^##\s|\z)')
$preOatScopeMatch = [regex]::Match($content, '(?ms)^###\s+Optional Pre-OAT Scope\s+[—-]\s+Lower Environment\s*$\s*(?<body>.*?)(?=^###\s|^##\s|\z)')
$reviewApprovalsMatch = [regex]::Match($content, '(?ms)^###\s+Test Plan Review and Approval\s*$\s*(?<body>.*?)(?=^###\s|^##\s|\z)')
$raciMatch = [regex]::Match($content, '(?ms)^###\s+RACI\s*$\s*(?<body>.*?)(?=^###\s|^##\s|\z)')
$mvtMatch = [regex]::Match($content, '(?ms)^###\s+Minimum Viable Testing\s*$\s*(?<body>.*?)(?=^###\s|^##\s|\z)')
$automationMatch = [regex]::Match($content, '(?ms)^###\s+Automation Strategy and Ownership\s*$\s*(?<body>.*?)(?=^###\s|^##\s|\z)')
$architectureTestabilityMatch = [regex]::Match($architecture, '(?ms)^###\s+14\.1\s+Migration Testability Matrix\s*$\s*(?<body>.*?)(?=^###\s|^##\s|\z)')
$architectureOatMatch = [regex]::Match($architecture, '(?ms)^###\s+14\.2\s+OAT Scenario Applicability Matrix\s*$\s*(?<body>.*?)(?=^###\s|^##\s|\z)')
if (-not $testSectionMatch.Success) { $errors.Add('Test Plan Test Types table is missing.') }
if (-not $haSectionMatch.Success) { $errors.Add('Test Plan High Availability Test Design section is missing.') }
if (-not $drSectionMatch.Success) { $errors.Add('Test Plan Disaster Recovery Test Design section is missing.') }
if (-not $oatSectionMatch.Success) { $errors.Add('Test Plan Operational Acceptance Test Design section is missing.') }
if (-not $timelineMatch.Success) { $errors.Add('Test Plan Estimated Elapsed Testing Timeline and Capacity section is missing.') }
if (-not $preOatScopeMatch.Success) { $errors.Add('Test Plan optional lower-environment Pre-OAT scope section is missing.') }
if (-not $reviewApprovalsMatch.Success) { $errors.Add('Test Plan multi-party Review and Approval section is missing.') }
if (-not $raciMatch.Success) { $errors.Add('Test Plan RACI table is missing.') }
if (-not $architectureTestabilityMatch.Success) { $errors.Add('Architecture Section 14.1 testability matrix is missing.') }
if (-not $architectureOatMatch.Success) { $errors.Add('Architecture Section 14.2 OAT scenario applicability matrix is missing.') }
foreach ($tableName in @($profile,$testSectionMatch.Groups['body'].Value,$architectureTestabilityMatch.Groups['body'].Value,$raciMatch.Groups['body'].Value)) {
    if ($tableName -is [string] -and $tableName -match '(?mi)^\|\s*Integration(?:\s+testing)?\s*\|') {
        $errors.Add('Integration is scenario scope, not a standalone test type/RACI row; place it under Change-based functional or mandatory UAT.')
        break
    }
}
if ($testSectionMatch.Success) {
    $changeFunctionalRow = [regex]::Match($testSectionMatch.Groups['body'].Value, '(?mi)^\|\s*Change-based functional\s*\|(?<rest>.*)$')
    if ($changeFunctionalRow.Success) {
        $changeFunctionalText = $changeFunctionalRow.Value
        foreach ($term in @('integration', 'Refactor', 'Re-Host/Re-Platform', 'Migration Team')) {
            if ($changeFunctionalText -notmatch [regex]::Escape($term)) {
                $errors.Add("Change-based functional Test Plan row must include integration scenarios for Migration-Team refactoring and '$term'.")
            }
        }
    }
    $uatRow = [regex]::Match($testSectionMatch.Groups['body'].Value, '(?mi)^\|\s*User acceptance testing\s*\|(?<rest>.*)$')
    if ($uatRow.Success -and ($uatRow.Value -notmatch '(?i)integration' -or $uatRow.Value -notmatch '(?i)Application Team')) {
        $errors.Add('Mandatory UAT Test Plan row must include applicable integration scenarios under Application Team ownership.')
    }
}

if ($oatSectionMatch.Success) {
    $oatDesign = $oatSectionMatch.Groups['body'].Value
    foreach ($term in @('LSEG-L2-OAT-Game-Day-Scenario-Catalog.md','Architecture Section 14.2','as-is','Azure target','Application Operations','Production','Cutover','runbook','change')) {
        if ($oatDesign -notmatch [regex]::Escape($term)) { $errors.Add("OAT Test Plan section must include '$term'.") }
    }
    $oatIds = @()
    foreach ($group in @(@{ prefix='GD'; count=24 }, @{ prefix='CHG'; count=9 }, @{ prefix='VAL'; count=18 })) {
        for ($number = 1; $number -le $group.count; $number++) {
            $oatIds += "L2-OAT-$($group.prefix)-$('{0:D2}' -f $number)"
        }
    }
    foreach ($oatId in $oatIds) {
        $rows = @([regex]::Matches($oatDesign, "(?mi)^\|\s*$([regex]::Escape($oatId))\s*\|(?<rest>.*)$"))
        if ($rows.Count -ne 1) { $errors.Add("OAT Test Plan must contain exactly one disposition row for '$oatId' (found $($rows.Count))."); continue }
        $cells = @($rows[0].Groups['rest'].Value.TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
        if ($cells.Count -lt 7) { $errors.Add("OAT Test Plan row '$oatId' is missing required fields."); continue }
        if ($architectureOatMatch.Success) {
            $architectureRows = @([regex]::Matches($architectureOatMatch.Groups['body'].Value, "(?mi)^\|\s*$([regex]::Escape($oatId))\s*\|(?<rest>.*)$"))
            if ($architectureRows.Count -ne 1) { $errors.Add("Architecture Section 14.2 must contain exactly one '$oatId' scenario row (found $($architectureRows.Count)).") }
            else {
                $architectureOatCells = @($architectureRows[0].Groups['rest'].Value.TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
                if ($architectureOatCells.Count -lt 2 -or $architectureOatCells[1] -ne $cells[1]) { $errors.Add("OAT Test Plan disposition for '$oatId' must match Architecture Section 14.2.") }
            }
        }
        if ($cells[1] -notin @('Recommended','Conditionally applicable','Not applicable','Blocked')) { $errors.Add("OAT Test Plan row '$oatId' has invalid disposition '$($cells[1])'.") }
        if ($cells[1] -eq 'Not applicable' -and $cells[2] -match '(?i)^(?:N/?A|None|Unknown|TBD|\{.*\})$') { $errors.Add("OAT Not applicable row '$oatId' requires evidence that the scenario does not apply.") }
        foreach ($index in 0..6) { if (-not $cells[$index] -or $cells[$index] -match '^\{.*\}$') { $errors.Add("OAT Test Plan row '$oatId' has an unresolved required field."); break } }
        if ($cells[5] -match '(?i)production' -and ($cells[0] + ' ' + $cells[4]) -match '(?i)failover|inject|terminate|disable|shutdown|restart|deny|block|chaos|disrupt') {
            foreach ($safeguard in @('approved change','bounded impact','communications','stop conditions','recovery readiness')) {
                if ($cells[5] -notmatch "(?i)$([regex]::Escape($safeguard))") { $errors.Add("Production-disruptive OAT row '$oatId' must document '$safeguard'.") }
            }
        }
    }
}

if ($timelineMatch.Success) {
    $timeline = $timelineMatch.Groups['body'].Value
    $timelineHeader = ([regex]::Match($timeline, '(?m)^\|.*\|\s*$')).Value
    foreach ($column in @('Test Type / Workstream','Applicability','Case-count and automation basis','Elapsed — 1 tester','Elapsed — 2 testers','Elapsed — 3 testers','Dependencies, overlap, wait time, confidence')) {
        if ($timelineHeader -notmatch [regex]::Escape($column)) { $errors.Add("Testing timeline is missing required column '$column'.") }
    }
    foreach ($term in @('1, 2 and 3 active testers','effort','automation','external','parallel','critical path','contingency','not a sum','Optional pre-OAT','lower-environment','Migration Team','Application Team','scenario IDs/count','does not replace')) {
        if ($timeline -notmatch [regex]::Escape($term)) { $errors.Add("Testing timeline must document '$term'.") }
    }
    foreach ($testType in $testTypes) {
        $timelineRows = @([regex]::Matches($timeline, "(?mi)^\|\s*$([regex]::Escape($testType))\s*\|(?<rest>.*)$"))
        if ($timelineRows.Count -ne 1) { $errors.Add("Testing timeline must contain exactly one '$testType' row (found $($timelineRows.Count))."); continue }
        $cells = @($timelineRows[0].Groups['rest'].Value.TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
        if ($cells.Count -lt 6) { $errors.Add("Testing timeline row '$testType' is missing capacity or evidence fields."); continue }
        foreach ($index in 0..5) {
            if (-not $cells[$index] -or $cells[$index] -match '^\{.*\}$') { $errors.Add("Testing timeline row '$testType' has an unresolved required field."); break }
        }
        if ($testType -eq 'Operational acceptance testing' -and $timeline -notmatch '(?i)4 calendar weeks') { $errors.Add('Testing timeline must preserve the four-calendar-week L2 Production OAT baseline unless current L2 evidence revises it.') }
    }
    if ($timeline -notmatch '(?i)pre-OAT.{0,160}(?:agree|agreement).{0,120}(?:scenario IDs/count|scenario count|number of scenarios)') { $errors.Add('Optional pre-OAT must require a joint scenario-count agreement before scheduling.') }
}

if ($preOatScopeMatch.Success) {
    $preOatScope = $preOatScopeMatch.Groups['body'].Value
    foreach ($term in @('optional','Migration Team','Application Team','scenario IDs/count','lower environment','entry/exit','duration','does not satisfy Production OAT')) {
        if ($preOatScope -notmatch [regex]::Escape($term)) { $errors.Add("Optional Pre-OAT scope must document '$term'.") }
    }
}

if ($reviewApprovalsMatch.Success) {
    $reviewApprovals = $reviewApprovalsMatch.Groups['body'].Value
    foreach ($organization in @('Migration Team','Migration Testing Team','Application Team','L2 Operations')) {
        $approvalRows = @([regex]::Matches($reviewApprovals, "(?mi)^\|\s*$([regex]::Escape($organization))\s*\|(?<rest>.*)$"))
        if ($approvalRows.Count -ne 1) { $errors.Add("Test Plan approvals must contain exactly one '$organization' reviewer row (found $($approvalRows.Count))."); continue }
        $cells = @($approvalRows[0].Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
        if ($cells.Count -lt 5 -or @($cells | Where-Object { -not $_ -or $_ -match '^\{.*\}$' }).Count -gt 0) { $errors.Add("Test Plan approval row '$organization' is incomplete or contains unresolved placeholders."); continue }
        if ($cells[3] -notin @('Pending','Approved','Changes requested')) { $errors.Add("Test Plan approval row '$organization' has invalid outcome '$($cells[3])'.") }
        if ($cells[3] -eq 'Approved' -and (-not (Test-IsNamedPerson -Value $cells[1]) -or $cells[2] -notmatch '^\d{4}-\d{2}-\d{2}$' -or $cells[4] -match '(?i)^(?:Pending|N/?A|None)$')) { $errors.Add("Approved Test Plan row '$organization' requires a named reviewer, ISO date and evidence link.") }
    }
}

foreach ($testType in $testTypes) {
    $profileRows = @([regex]::Matches($profile, "(?mi)^\|\s*$([regex]::Escape($testType))\s*\|(?<rest>.*)$"))
    $planRows = if ($testSectionMatch.Success) { @([regex]::Matches($testSectionMatch.Groups['body'].Value, "(?mi)^\|\s*$([regex]::Escape($testType))\s*\|(?<rest>.*)$")) } else { @() }
    $architectureRows = if ($architectureTestabilityMatch.Success) { @([regex]::Matches($architectureTestabilityMatch.Groups['body'].Value, "(?mi)^\|\s*$([regex]::Escape($testType))\s*\|(?<rest>.*)$")) } else { @() }
    if ($profileRows.Count -ne 1) { $errors.Add("Testing profile must contain exactly one '$testType' row (found $($profileRows.Count)).") }
    if ($architectureRows.Count -ne 1) { $errors.Add("Architecture Section 14.1 must contain exactly one '$testType' row (found $($architectureRows.Count)).") }
    $profileCells = if ($profileRows.Count -eq 1) { @($profileRows[0].Groups['rest'].Value.TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() }) } else { @() }
    $profileDisposition = if ($profileCells.Count -ge 2) { $profileCells[1] } else { $null }
    $profileIds = if ($profileCells.Count -ge 4) { @([regex]::Matches($profileCells[3], '\b(?:REQ|NFR)-\d{3}\b') | ForEach-Object { $_.Value } | Select-Object -Unique) } else { @() }
    $architectureCells = if ($architectureRows.Count -eq 1) { @($architectureRows[0].Groups['rest'].Value.TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() }) } else { @() }
    if ($planRows.Count -ne 1) { $errors.Add("Test Plan must contain exactly one '$testType' row (found $($planRows.Count)).") } else {
        $cells = @($planRows[0].Groups['rest'].Value.TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
        if ($cells.Count -lt 10) { $errors.Add("Test Plan row '$testType' does not contain all required fields.") } else {
            $planIds = @([regex]::Matches($cells[2], '\b(?:REQ|NFR)-\d{3}\b') | ForEach-Object { $_.Value } | Select-Object -Unique)
            $architectureIds = if ($architectureCells.Count -ge 1) { @([regex]::Matches($architectureCells[0], '\b(?:REQ|NFR)-\d{3}\b') | ForEach-Object { $_.Value } | Select-Object -Unique) } else { @() }
            if ($profileDisposition -ne 'Not Applicable' -and $planIds.Count -eq 0) { $errors.Add("Test Plan row '$testType' must trace a REQ/NFR ID.") }
            foreach ($profileId in $profileIds) {
                if ($planIds -notcontains $profileId) { $errors.Add("Test Plan row '$testType' omits profile requirement '$profileId'.") }
                if ($architectureIds -notcontains $profileId) { $errors.Add("Architecture row '$testType' omits profile requirement '$profileId'.") }
            }
            foreach ($planId in $planIds) { if ($profileIds -notcontains $planId) { $errors.Add("Test Plan row '$testType' adds requirement '$planId' absent from the authoritative profile.") } }
            foreach ($architectureId in $architectureIds) { if ($profileIds -notcontains $architectureId) { $errors.Add("Architecture row '$testType' adds requirement '$architectureId' absent from the authoritative profile.") } }
            foreach ($index in 0..8) { if (-not $cells[$index] -or $cells[$index] -match '^\{.*\}$') { $errors.Add("Test Plan row '$testType' has an unresolved required field."); break } }
            if ($profileDisposition -eq 'Exception Proposed' -and $cells[9] -notmatch '\bADR-\d{4}\b.*\bRSK-\d{3}\b|\bRSK-\d{3}\b.*\bADR-\d{4}\b') { $errors.Add("Excepted Test Plan row '$testType' must link both ADR and risk.") }
            if ($profileDisposition -eq 'Unknown' -and $ValidationStage -eq 'Execution') { $errors.Add("Testing profile row '$testType' remains Unknown and cannot produce an execution-baseline Test Plan.") }
            elseif ($profileDisposition -eq 'Unknown' -and -not (Test-OwnedDependency -Trace ($profileRows[0].Value + ' ' + $planRows[0].Value))) { $errors.Add("Unknown profile row '$testType' requires an owned action before review.") }
            $architectureApplicability = if ($architectureCells.Count -ge 2) { $architectureCells[1] } else { '' }
            $normalizedArchitectureApplicability = Get-NormalizedApplicability -Value $architectureApplicability
            $normalizedPlanApplicability = Get-NormalizedApplicability -Value $cells[0]
            $resolvedPlanDispositions[$testType] = $normalizedPlanApplicability
            if (-not $normalizedArchitectureApplicability) { $errors.Add("Architecture row '$testType' must start with exact applicability Applicable, Not Applicable, or Exception Approved plus optional ' — basis'.") }
            if (-not $normalizedPlanApplicability) { $errors.Add("Test Plan row '$testType' must start with exact applicability Applicable, Not Applicable, or Exception Approved plus optional ' — basis'.") }
            if ($profileDisposition -eq 'Applicable' -and ($normalizedPlanApplicability -ne 'Applicable' -or $normalizedArchitectureApplicability -ne 'Applicable')) { $errors.Add("Applicable profile row '$testType' must remain Applicable in architecture and Test Plan; mandatory scope cannot become an exception.") }
            if ($profileDisposition -eq 'Conditionally Applicable') {
                if ($normalizedArchitectureApplicability -notin @('Applicable','Not Applicable')) { $errors.Add("Conditional profile row '$testType' must be resolved by architecture to Applicable or Not Applicable.") }
                if ($normalizedPlanApplicability -ne $normalizedArchitectureApplicability) { $errors.Add("Test Plan row '$testType' disagrees with architecture's conditional applicability resolution.") }
            }
            if ($profileDisposition -eq 'Not Applicable' -and ($normalizedPlanApplicability -ne 'Not Applicable' -or $normalizedArchitectureApplicability -ne 'Not Applicable')) { $errors.Add("Not Applicable profile row '$testType' is inconsistent downstream.") }
            if ($profileDisposition -eq 'Exception Proposed' -and ($normalizedPlanApplicability -ne 'Exception Approved' -or $normalizedArchitectureApplicability -ne 'Exception Approved')) { $errors.Add("Exception Proposed profile row '$testType' requires an approved exception disposition in architecture and Test Plan.") }
            if ($architectureCells.Count -lt 9) { $errors.Add("Architecture row '$testType' must contain all testability fields.") }
            elseif (@($architectureCells[0..8] | Where-Object { -not $_ -or $_ -match '^\{.*\}$' }).Count -gt 0) { $errors.Add("Architecture row '$testType' has an unresolved required testability field.") }
            elseif ($architectureCells[7] -notin @('Ready','Conditional','Blocked')) { $errors.Add("Architecture row '$testType' has invalid readiness '$($architectureCells[7])'.") }
            elseif ($architectureCells[7] -ne 'Ready') {
                if ($ValidationStage -eq 'Execution') { $errors.Add("Approved Test Plan row '$testType' requires architecture readiness Ready, found '$($architectureCells[7])'.") }
                elseif ($architectureCells[8] -notmatch '\b(?:ADR-\d{4}|RSK-\d{3})\b' -or -not (Test-OwnedDependency -Trace $architectureRows[0].Value)) { $errors.Add("Architecture row '$testType' with unresolved readiness requires an ADR/risk and an owned profile action with a needed-by gate.") }
                else { $deferredReadiness.Add($testType) }
            }
        }
    }
    $raciRows = if ($raciMatch.Success) { @([regex]::Matches($raciMatch.Groups['body'].Value, "(?mi)^\|\s*$([regex]::Escape($testType))\s*\|(?<rest>.*)$")) } else { @() }
    if ($raciRows.Count -ne 1) { $errors.Add("RACI must contain exactly one '$testType' row (found $($raciRows.Count)).") } else {
        $raciCells = @($raciRows[0].Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
        if ($raciCells.Count -ne 6) { $errors.Add("RACI row '$testType' must contain exactly five role fields and one approver field (found $($raciCells.Count)).") } else {
            $accountableCount = 0
            $responsibleCount = 0
            $notApplicableRaci = $resolvedPlanDispositions[$testType] -eq 'Not Applicable'
            foreach ($roleCell in $raciCells[0..4]) {
                if ($roleCell -eq 'N/A') {
                    if (-not $notApplicableRaci) { $errors.Add("RACI row '$testType' cannot use N/A for an applicable or excepted test.") }
                    continue
                }
                $roleTokens = @($roleCell -split '[,\s]+' | ForEach-Object { $_ -split '/' } | Where-Object { $_ })
                $accountableCount += @($roleTokens | Where-Object { $_ -eq 'A' }).Count
                $responsibleCount += @($roleTokens | Where-Object { $_ -eq 'R' }).Count
                if (@($roleTokens | Where-Object { $_ -notin @('A','R','C','I') }).Count -gt 0) { $errors.Add("RACI row '$testType' contains invalid role token in '$roleCell'.") }
            }
            if ($notApplicableRaci) {
                if (@($raciCells[0..4] | Where-Object { $_ -ne 'N/A' }).Count -gt 0 -or $raciCells[5] -notmatch '(?i)^N/A\s+[—:-]\s+.+') { $errors.Add("Not Applicable RACI row '$testType' must use N/A for all roles and an evidence-backed `N/A — reason` approver field.") }
            } else {
                if ($accountableCount -ne 1) { $errors.Add("RACI row '$testType' must have exactly one accountable role (found $accountableCount).") }
                if ($responsibleCount -lt 1) { $errors.Add("RACI row '$testType' must have at least one responsible role.") }
                if (-not (Test-IsNamedPerson -Value $raciCells[5])) {
                    if ($ValidationStage -eq 'Execution') { $errors.Add("RACI row '$testType' must name the authorized human deliverable approver, not only a placeholder or generic role.") }
                    elseif ($raciCells[5] -notmatch '(?i)\b(?:Owner|Lead|Coordinator|Manager|Approver|Operations|Security|Team)\b' -or
                        -not (Test-OwnedDependency -Trace ($raciRows[0].Value + ' ' + $planRows[0].Value) -Appointment)) { $errors.Add("RACI row '$testType' requires an approver role/contact and an owned appointment action with a needed-by gate.") }
                    else { $deferredApprovers.Add($testType) }
                }
            }
        }
    }
}

if ($mvtMatch.Success) {
    $mvtRows = @($mvtMatch.Groups['body'].Value -split "`r?`n" | Where-Object { $_ -match '^\|\s*(?:Not Applicable|Proposed|Approved)\s*\|' })
    if ($mvtRows.Count -ne 1) { $errors.Add("Minimum Viable Testing must contain exactly one resolved applicability row (found $($mvtRows.Count)).") } else {
        $mvtCells = @($mvtRows[0].Trim('|') -split '\|' | ForEach-Object { $_.Trim() })
        $incompleteMvtCells = @($mvtCells | Where-Object { -not $_ -or $_ -match '^\{.*\}$' })
        if ($mvtCells.Count -lt 5 -or $incompleteMvtCells.Count -gt 0) { $errors.Add('Minimum Viable Testing row is incomplete or contains placeholders.') }
        if ($mvtCells[0] -eq 'Proposed' -and $planStatus -eq 'Approved') { $errors.Add('An Approved Test Plan cannot retain Proposed Minimum Viable Testing.') }
        if ($mvtCells[0] -eq 'Approved' -and $mvtCells[3] -notmatch '\bADR-\d{4}\b.*\bRSK-\d{3}\b|\bRSK-\d{3}\b.*\bADR-\d{4}\b') { $errors.Add('Approved Minimum Viable Testing requires an ADR and linked risk.') }
        $mvtText = $mvtCells -join ' '
        if ($mvtText -notmatch '(?i)UAT.*(?:mandatory|no exemption|not waived)|(?:mandatory|no exemption|not waived).*UAT') { $errors.Add('Minimum Viable Testing disposition must state that UAT remains mandatory and is not waived.') }
        if ($mvtCells[0] -eq 'Approved') {
            $mvtScopeItems = @($mvtCells[2] -split '[;,]' | ForEach-Object { $_.Trim() })
            if ($mvtScopeItems -notcontains 'Application installation' -or $mvtScopeItems -notcontains 'Connectivity') { $errors.Add('Approved Minimum Viable Testing must affirmatively list exact scope items `Application installation` and `Connectivity`.') }
            $dataProfileRow = [regex]::Match($profile, '(?mi)^\|\s*Data migration verification\s*\|(?<rest>.*)$')
            if ($dataProfileRow.Success) {
                $dataProfileCells = @($dataProfileRow.Groups['rest'].Value.TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
                if ($dataProfileCells.Count -ge 2 -and $dataProfileCells[1] -eq 'Applicable' -and $mvtScopeItems -notcontains 'Data migration verification') { $errors.Add('Approved Minimum Viable Testing must affirmatively list exact scope item `Data migration verification` when data movement is Applicable.') }
            }
        }
        if ($mvtCells[0] -eq 'Not Applicable') {
            if ($mvtCells[1] -match '(?i)^(?:N/?A|None|TBD|Unknown|full scope)$' -or $mvtCells[1].Length -lt 12) { $errors.Add('Not Applicable MVT requires substantive evidence that complete test assets and specifications are available.') }
            if ($mvtCells[2] -notmatch '(?i)^Full approved scope applies\b') { $errors.Add('Not Applicable MVT must affirmatively state `Full approved scope applies`.') }
            if ($mvtCells[3] -notmatch '(?i)^N/A\s+[—:-]\s+.+') { $errors.Add('Not Applicable MVT requires an evidence-backed `N/A — reason` approval/exception rationale.') }
        }
        if ($mvtCells[4] -match '(?i)^(?:N/?A|None|TBD|Unknown|Approved)$') { $errors.Add('Minimum Viable Testing must name concrete exit evidence, not a generic status.') }
    }
}
if ($automationMatch.Success) {
    $automationRows = @($automationMatch.Groups['body'].Value -split "`r?`n" | Where-Object { $_ -match '^\|' -and $_ -notmatch '^\|\s*(?:Scope / Repository|---)' })
    if ($automationRows.Count -lt 1) { $errors.Add('Automation Strategy and Ownership requires at least one scope/repository row.') }
    foreach ($row in $automationRows) {
        $automationCells = @($row.Trim('|') -split '\|' | ForEach-Object { $_.Trim() })
        $incompleteAutomationCells = @($automationCells | Where-Object { -not $_ -or $_ -match '^\{.*\}$' })
        if ($automationCells.Count -lt 8 -or $incompleteAutomationCells.Count -gt 0) { $errors.Add("Automation Strategy row is incomplete: $($row.Trim())") }
        if ($automationCells.Count -ge 8) {
            $hasNoAutomation = $automationCells[1] -match '(?i)^None\s+[—:-]\s+.+$'
            $hasConcreteAutomation = $automationCells[1] -match '(?i)(?:[/\\]|https?://|\brepository\b|\brepo\b)' -and $automationCells[1] -match '(?i)(?:\bv?\d+(?:\.\d+)+\b|\bversion\b|\bcommit\b|\bhash\b)'
            if (-not $hasNoAutomation -and -not $hasConcreteAutomation) { $errors.Add('Automation Strategy must identify a concrete repository/path plus version/commit, or an evidence-backed `None — reason`.') }
            if ($automationCells[2] -notmatch '(?i)unchanged|impacted|changed|migration code') { $errors.Add('Automation Strategy must state migration-change impact for each scope/repository.') }
            if (-not $hasNoAutomation -and ($automationCells[3] -notmatch '(?i)CI|pipeline|build' -or $automationCells[3] -notmatch '(?i)stage|job|workflow' -or $automationCells[3] -notmatch '(?i)per|every|on\s+' -or $automationCells[3] -match '(?i)\b(?:no|not|without)\s+(?:CI|pipeline|build)')) { $errors.Add('Automation Strategy must affirmatively name the CI/build pipeline stage or job and execution frequency.') }
            if (-not $hasNoAutomation -and ($automationCells[4] -match '(?i)^(?:Existing|Existing framework|Framework|Tool|TBD|Unknown|Pending)$' -or $automationCells[4] -notmatch '(?i)\bv?\d+(?:\.\d+)+\b|approved\s+[A-Za-z0-9._-]+')) { $errors.Add('Automation Strategy must name the approved framework/tool and version.') }
            if ($automationCells[5] -match '(?i)^(?:N/?A|TBD|Unknown|Pending)$' -or $automationCells[6] -match '(?i)^(?:N/?A|TBD|Unknown|Pending)$') { $errors.Add('Automation Strategy must name implementation and ongoing maintenance owners.') }
            if ($automationCells[7] -notmatch '(?i)MEC|GCF|ADR-\d{4}|RSK-\d{3}|approved.*(?:evidence|source)|N/A\s+[—:-]\s+.+') { $errors.Add('Automation Strategy must cite MEC/GCF, ADR/risk, approved evidence, or an evidence-backed N/A rationale.') }
        }
    }
}

$unitRow = [regex]::Match($testSectionMatch.Groups['body'].Value, '(?mi)^\|\s*Unit\s*\|(?<rest>.*)$').Groups['rest'].Value
if ($unitRow -notmatch '(?i)existing automated suites' -or $unitRow -notmatch '(?i)migration-changed|impacted code') { $errors.Add('Unit Test Plan scope must continue existing suites and limit Migration Team changes to migration-changed, impacted code.') }
$drRow = [regex]::Match($testSectionMatch.Groups['body'].Value, '(?mi)^\|\s*Disaster recovery\s*\|(?<rest>.*)$').Groups['rest'].Value
if ($drRow -notmatch '(?i)Production') { $errors.Add('Disaster recovery acceptance must be planned in Production.') }
if ($haSectionMatch.Success) {
    $haDesign = $haSectionMatch.Groups['body'].Value
    foreach ($check in @(
        @{ Label='the LMP strategy Section 7.2 source reference'; Pattern='(?i)Section 7\.2' },
        @{ Label='Application Owner and R-Type assessment'; Pattern='(?is)Application Owner.*R-Type' },
        @{ Label='approved uptime/SLA and RTO/RPO goals'; Pattern='(?is)(?:uptime.*SLA|SLA.*uptime).*RTO/RPO|RTO/RPO.*(?:uptime.*SLA|SLA.*uptime)' },
        @{ Label='redundancy/failover, scalability, and resource-utilization goals'; Pattern='(?is)redundancy.*failover.*scalability.*resource utilization' },
        @{ Label='scope/cases, pass/fail criteria, and background load'; Pattern='(?is)(?:scope|cases).*pass/fail.*background load' },
        @{ Label='production-comparable PPE, approved SII, monitoring, and test data'; Pattern='(?is)PPE.*SII.*monitoring.*test data' },
        @{ Label='isolated execution window and entry/exit criteria'; Pattern='(?is)isolated.*entry.*exit' },
        @{ Label='defect treatment and signed Test Execution Results Report'; Pattern='(?is)defects?.*(?:retest|risk.accepted).*Test\s+Execution\s+Results\s+Report' }
    )) {
        if ($haDesign -notmatch $check.Pattern) { $errors.Add("HA Test Design must include $($check.Label).") }
    }
}
if ($drSectionMatch.Success) {
    $drDesign = $drSectionMatch.Groups['body'].Value
    foreach ($check in @(
        @{ Label='the LMP strategy Section 7.3 source reference'; Pattern='(?i)Section 7\.3' },
        @{ Label='L2 Production acceptance before customer cutover'; Pattern='(?is)Production.*L2.*before customer cutover|L2.*Production.*before customer cutover' },
        @{ Label='Migration Team runbook creation and handover to L2'; Pattern='(?is)Migration Team.*runbook.*handover to L2' },
        @{ Label='LSEG DR Coordinator and Technology Owner'; Pattern='(?is)DR Coordinator.*Technology Owner' },
        @{ Label='dependency failover while the hosting environment remains in place'; Pattern='(?is)dependency failover.*hosting environment remains in place' },
        @{ Label='Production readiness, representative data, tools, trained team, and synchronized backups'; Pattern='(?is)Production.*(?:authentication|authorization).*test data.*tools.*team.*backup' },
        @{ Label='RTA/RTO and RPA/RPO measures'; Pattern='(?is)RTA.*RTO.*RPA.*RPO' },
        @{ Label='data integrity/accuracy, critical functionality, and tested failback/normalization'; Pattern='(?is)integrity.*accuracy.*critical functionality.*failback.*normalization' },
        @{ Label='defect disposition, results report, evidence, and sign-off'; Pattern='(?is)defects?.*(?:retest|risk acceptance).*results report.*evidence.*sign.off' }
    )) {
        if ($drDesign -notmatch $check.Pattern) { $errors.Add("DR Test Design must include $($check.Label).") }
    }
}
if ($content -match '(?mi)^\|\s*Security\s*/\s*penetration\s*\|') { $errors.Add('Security testing and security penetration testing must be separate Test Plan rows.') }

if ($plan -notmatch '(?m)^###\s+Application Test Plan Handoff\s*$' -or $plan -notmatch '(?m)^\|\s*`G-test-plan\.md`\s*\|') { $errors.Add('plan.md does not contain the canonical G-test-plan.md handoff row.') }

$requiredStatus = switch ($ValidationStage) {
    'Draft' { 'Draft' }
    'ReadyForReview' { 'Ready for Review' }
    'Execution' { 'Approved' }
}
if (-not $statusMatch.Success -or $planStatus -ne $requiredStatus) {
    $errors.Add("Test Plan status must be '$requiredStatus' for validation stage '$ValidationStage'.")
}
if ($planStatus -eq 'Approved' -and $reviewApprovalsMatch.Success) {
    foreach ($organization in @('Migration Team','Migration Testing Team','Application Team','L2 Operations')) {
        $approvalRow = [regex]::Match($reviewApprovalsMatch.Groups['body'].Value, "(?mi)^\|\s*$([regex]::Escape($organization))\s*\|(?<rest>.*)$")
        if (-not $approvalRow.Success) { continue }
        $approvalCells = @($approvalRow.Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
        if ($approvalCells.Count -lt 4 -or $approvalCells[3] -ne 'Approved') { $errors.Add("Test Plan cannot be Approved until '$organization' records Approved for this version.") }
    }
}
$approvalSection = [regex]::Match($content, '(?ms)^##\s+Test Plan Approval Gate\s*$\s*(?<body>.*?)(?=^##\s|\z)')
$reviewMatch = if ($approvalSection.Success) { [regex]::Match($approvalSection.Value, '(?m)^\*\*Reviewed by\*\*:\s*(?<name>[^|{}]+?)\s*\|\s*\*\*Date\*\*:\s*(?<date>\d{4}-\d{2}-\d{2})\s*\|\s*\*\*Outcome\*\*:\s*Approved\s*$') } else { [regex]::Match('', 'a^') }
$testPlanReviewer = if ($reviewMatch.Success) { $reviewMatch.Groups['name'].Value.Trim() } else { $null }
if ($ValidationStage -eq 'Execution' -and (-not $reviewMatch.Success -or -not (Test-IsNamedPerson -Value $testPlanReviewer))) { $errors.Add('Test Plan requires a named human reviewer, ISO date, and Approved outcome.') }
if ($ValidationStage -ne 'Draft' -and $content -match '\{[^{}\r\n]+\}') { $errors.Add('Test Plan contains unresolved template placeholders.') }

$caseSectionMatch = [regex]::Match($content, '(?ms)^###\s+High-Level Case Outlines\s*$\s*(?<body>.*?)(?=^###\s|^##\s|\z)')
$estimateBoundaryMatch = [regex]::Match($content, '(?ms)^###\s+Estimate Scope and Boundary Reconciliation\s*$\s*(?<body>.*?)(?=^###\s|^##\s|\z)')
$assetSectionMatch = [regex]::Match($content, '(?ms)^###\s+Test Assets and Traceability\s*$\s*(?<body>.*?)(?=^###\s|^##\s|\z)')
$actionIds = @()
if ($actionsSectionMatch.Success) {
    $actionIds += @([regex]::Matches($actionsSectionMatch.Groups['body'].Value, '(?mi)^\|\s*(?<id>ACT-\d{3}|AUT-\d{2,})\s*\|') | ForEach-Object { $_.Groups['id'].Value })
}
$actionIds += @([regex]::Matches($profile, '(?mi)^\|\s*(?<id>AUT-\d{2,})\s*\|') | ForEach-Object { $_.Groups['id'].Value })
$actionIds = @($actionIds | Select-Object -Unique)
if ($actionsSectionMatch.Success) {
    foreach ($actionRow in $profileActionRows) {
        $actionCells = @($actionRow.Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
        if ($actionCells.Count -ge 7 -and $ValidationStage -eq 'Execution' -and $actionCells[6] -in @('Requested','Answered-unvalidated') -and $actionCells[5] -match '(?i)execution|case scope|test scope|mandatory approval|target disposition') {
            $errors.Add("Open action '$($actionRow.Groups['id'].Value)' blocks the Test Plan execution baseline: $($actionCells[0])")
        }
    }
}

foreach ($section in @(
    @{ Name='High-Level Case Outlines'; Match=$caseSectionMatch },
    @{ Name='Estimate Scope and Boundary Reconciliation'; Match=$estimateBoundaryMatch },
    @{ Name='Test Assets and Traceability'; Match=$assetSectionMatch }
)) {
    if (-not $section.Match.Success) {
        if ($ValidationStage -eq 'Draft') { $warnings.Add("Legacy or incomplete draft is missing '$($section.Name)'; migrate it before review.") }
        else { $errors.Add("Test Plan missing required section '$($section.Name)'.") }
    }
}

$caseRows = @()
if ($caseSectionMatch.Success) {
    $caseBody = $caseSectionMatch.Groups['body'].Value
    $caseHeader = ([regex]::Match($caseBody, '(?m)^\|.*\|\s*$')).Value
    foreach ($column in @('Case ID','Origin (Supplied / Proposed)','Source Asset / Locator','Test Type / Family / REQ-NFR / Component or Flow','Objective / Preconditions / Data / High-Level Steps','Measurable Expected Outcome','Disposition (Covered / Adapt / Proposed / Excluded / Pending) and Evidence','Environment / Tool / Automation','Owner / Evidence Result Path / Action ID')) {
        if ($caseHeader -notmatch [regex]::Escape($column)) { $errors.Add("High-Level Case Outlines is missing required column '$column'.") }
    }
    $caseRows = @([regex]::Matches($caseBody, '(?mi)^\|\s*(?<id>[^|]+)\s*\|\s*(?<rest>.*)$') | Where-Object { $_.Groups['id'].Value.Trim() -notmatch '^(?:Case ID|-+)$' })
    $seenCaseIds = @{}
    foreach ($caseRow in $caseRows) {
        $caseId = $caseRow.Groups['id'].Value.Trim()
        $cells = @($caseRow.Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
        if ($cells.Count -ne 8) { $errors.Add("Case outline '$caseId' must contain all eight detail fields."); continue }
        if (-not $caseId -or $caseId -match '^\{.*\}$') { $errors.Add('Case outline requires a stable supplied or proposed ID.') }
        elseif ($seenCaseIds.ContainsKey($caseId)) { $errors.Add("Case ID '$caseId' is duplicated; supplied IDs must be preserved once.") }
        else { $seenCaseIds[$caseId] = $true }
        if ($cells[0] -notin @('Supplied','Proposed')) { $errors.Add("Case outline '$caseId' has invalid origin '$($cells[0])'.") }
        foreach ($field in @(@('source/trace',$cells[1] + ' ' + $cells[2]), @('objective',$cells[3]), @('measurable expected outcome',$cells[4]), @('environment/tool/automation',$cells[6]), @('owner/evidence path',$cells[7]))) {
            if (-not $field[1].Trim() -or $field[1] -match '(?i)^\s*(?:N/?A|Unknown|TBD|Pending|\{.*\})\s*$') {
                if ($cells[5] -notmatch '^(?:Pending|Proposed)\b' -or $cells[7] -notmatch '\b(?:ACT-\d{3}|AUT-\d{2,})\b') {
                    $errors.Add("Case outline '$caseId' requires a substantive $($field[0]) or an owned Proposed/Pending action.")
                }
            }
        }
        if ($cells[5] -notmatch '(?i)^(Covered|Adapt|Proposed|Excluded|Pending)(?:\s+[—:-].*)?$') { $errors.Add("Case outline '$caseId' has invalid disposition '$($cells[5])'.") }
        if ($ValidationStage -eq 'Execution' -and $cells[5] -match '^(?:Proposed|Pending)\b') { $errors.Add("Case outline '$caseId' is still Proposed/Pending and cannot enter the execution baseline.") }
        if ($cells[0] -eq 'Supplied' -and ($cells[1] -match '(?i)^(?:N/?A|Unknown|Pending|\{.*\})$' -or $cells[1] -notmatch '(?i)(?:version|commit|hash|SRC-|AST-|https?://|[/\\])')) { $errors.Add("Supplied case '$caseId' must retain a source asset locator/version.") }
        if ($cells[5] -match '^(?:Pending|Proposed)' -and $cells[7] -notmatch '\b(?:ACT-\d{3}|AUT-\d{2,})\b') { $errors.Add("Unresolved case '$caseId' must link an owned action.") }
        foreach ($actionId in @([regex]::Matches($cells[7], '\b(?:ACT-\d{3}|AUT-\d{2,})\b') | ForEach-Object { $_.Value })) {
            if ($actionIds -notcontains $actionId) { $errors.Add("Case '$caseId' references missing profile action '$actionId'.") }
            elseif ($cells[5] -match '^(?:Pending|Proposed)' -and -not $ownedActions.ContainsKey($actionId)) { $errors.Add("Unresolved case '$caseId' references unowned profile action '$actionId'.") }
        }
        if (($cells[5] + ' ' + $cells[6]) -match '(?i)\b(?:Executed|Passed|Failed)\b' -and $cells[6] -notmatch '(?i)(?:dated|run|result|report|evidence)') { $errors.Add("Case '$caseId' cannot claim execution outcome without result evidence.") }
    }
    foreach ($testType in $testTypes) {
        $typeRows = @($caseRows | Where-Object { $_.Groups['rest'].Value -match "(?i)\b$([regex]::Escape($testType))\b" })
        $scopeRow = [regex]::Match($sizingMatch.Groups['body'].Value, "(?mi)^\|\s*[^|]+\s*\|\s*$([regex]::Escape($testType))\s*\|(?<rest>.*)$")
        $scopeHasAction = $scopeRow.Success -and $scopeRow.Groups['rest'].Value -match '\b(?:ACT-\d{3}|AUT-\d{2,})\b'
        if ($typeRows.Count -eq 0 -and -not $scopeHasAction) { $errors.Add("Test type '$testType' needs an evidence-based case outline or an owned action for missing case-design inputs.") }
    }
}

if ($estimateBoundaryMatch.Success) {
    $estimateBody = $estimateBoundaryMatch.Groups['body'].Value
    $estimateHeader = ([regex]::Match($estimateBody, '(?m)^\|.*\|\s*$')).Value
    foreach ($column in @('Estimate ID / Source','Estimate Kind / Value / Confidence','Start Boundary','End Boundary','Included Phases / Work','Excluded Phases / External Waits','Basis / Scope Version / Evidence','Comparison / Reconciliation / Action')) {
        if ($estimateHeader -notmatch [regex]::Escape($column)) { $errors.Add("Estimate boundary reconciliation is missing required column '$column'.") }
    }
    $estimateRows = @([regex]::Matches($estimateBody, '(?mi)^\|\s*EST-\d{3}\s*\|(?<rest>.*)$'))
    if ($estimateRows.Count -eq 0) { $errors.Add('Estimate boundary reconciliation requires at least one estimate record.') }
    $estimateIds = @()
    foreach ($estimateRow in $estimateRows) {
        $estimateId = ([regex]::Match($estimateRow.Value, '^\|\s*(?<id>EST-\d{3})')).Groups['id'].Value
        $estimateIds += $estimateId
        $cells = @($estimateRow.Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
        if ($cells.Count -ne 7) { $errors.Add('Estimate boundary record requires kind/value, start/end, included/excluded scope, evidence and reconciliation fields.'); continue }
        $unresolvedEstimate = @($cells[0..5] | Where-Object { $_ -match '(?i)unknown|TBD' }).Count -gt 0
        $estimateActions = @([regex]::Matches($cells[6], '\b(?:ACT-\d{3}|AUT-\d{2,})\b') | ForEach-Object { $_.Value })
        if ($cells[0] -eq $cells[1]) {
            $errors.Add('Estimate boundary record must distinguish its source from the estimate or comparison.')
        }
        if ($unresolvedEstimate -and $estimateActions.Count -eq 0) {
            $errors.Add('Unresolved estimate boundaries need a specific owner action; unknown scope is not treated as a zero-length estimate.')
        }
        elseif ($unresolvedEstimate -and $ValidationStage -eq 'Execution') {
            $errors.Add('Estimate boundaries remain unresolved and cannot enter the execution baseline.')
        }
        foreach ($actionId in $estimateActions) {
            if ($actionIds -notcontains $actionId) { $errors.Add("Estimate record references missing profile action '$actionId'.") }
        }
    }
    foreach ($duplicate in @($estimateIds | Group-Object | Where-Object { $_.Count -gt 1 })) { $errors.Add("Estimate ID '$($duplicate.Name)' is duplicated.") }
}

if ($assetSectionMatch.Success) {
    $assetBody = $assetSectionMatch.Groups['body'].Value
    $assetHeader = ([regex]::Match($assetBody, '(?m)^\|.*\|\s*$')).Value
    foreach ($column in @('Asset ID','Asset Type / Supplied Case IDs','Version / Locator / Owner','Availability','Reuse Health','Verified Coverage / Gaps / Families','Last Run / Result Locator','Compatibility / Applicability Evidence','Maintenance / Retention / Action ID')) {
        if ($assetHeader -notmatch [regex]::Escape($column)) { $errors.Add("Test Assets and Traceability is missing required column '$column'.") }
    }
    $assetRows = @([regex]::Matches($assetBody, '(?mi)^\|\s*AST-\d{3}\s*\|(?<rest>.*)$'))
    if ($assetRows.Count -eq 0 -and $ValidationStage -ne 'Draft') { $errors.Add('Test Asset Inventory requires a row or an explicit Unknown/Unavailable inventory record.') }
    $seenAssetIds = @{}
    foreach ($assetRow in $assetRows) {
        $assetId = ([regex]::Match($assetRow.Value, '^\|\s*(?<id>AST-\d{3})')).Groups['id'].Value
        $cells = @($assetRow.Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
        if ($cells.Count -ne 8) { $errors.Add("Test asset '$assetId' must contain all eight inventory details."); continue }
        if ($seenAssetIds.ContainsKey($assetId)) { $errors.Add("Test asset ID '$assetId' is duplicated.") } else { $seenAssetIds[$assetId] = $true }
        if ($cells[2] -notin @('Reported-linked','Available-unverified','Verified-available','Unavailable','Unknown')) { $errors.Add("Test asset '$assetId' has invalid availability '$($cells[2])'.") }
        if ($cells[3] -notin @('Reuse','Adapt','Build','Manual','Excluded','Undecided')) { $errors.Add("Test asset '$assetId' has invalid reuse health '$($cells[3])'.") }
        if ($cells[2] -eq 'Verified-available' -and ($cells[5] -notmatch '\b20\d{2}-\d{2}-\d{2}\b' -or $cells[5] -notmatch '(?i)\b(?:run|result|report)\b')) { $errors.Add("Test asset '$assetId' cannot be Verified-available without a dated compatible run/result locator.") }
        if ($cells[2] -in @('Unknown','Unavailable','Available-unverified') -and $cells[7] -notmatch '\b(?:ACT-\d{3}|AUT-\d{2,})\b') { $errors.Add("Unverified test asset '$assetId' must link an owner action.") }
        foreach ($actionId in @([regex]::Matches($cells[7], '\b(?:ACT-\d{3}|AUT-\d{2,})\b') | ForEach-Object { $_.Value })) {
            if ($actionIds -notcontains $actionId) { $errors.Add("Test asset '$assetId' references missing profile action '$actionId'.") }
        }
    }
}

$profileAssetSection = [regex]::Match($profile, '(?ms)^##\s+Test Asset Inventory\s*$\s*(?<body>.*?)(?=^##\s|\z)')
if ($profileAssetSection.Success) {
    $profileAssetRows = @([regex]::Matches($profileAssetSection.Groups['body'].Value, '(?mi)^\|\s*AST-\d{3}\s*\|(?<rest>.*)$'))
    foreach ($assetRow in $profileAssetRows) {
        $cells = @($assetRow.Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
        if ($cells.Count -ge 6 -and $cells[2] -eq 'Verified-available' -and ($cells[5] -notmatch '\b20\d{2}-\d{2}-\d{2}\b' -or $cells[5] -notmatch '(?i)\b(?:run|result|report)\b')) { $errors.Add('Profile test asset cannot be Verified-available without a dated compatible run/result locator.') }
        if ($cells.Count -ge 3 -and $cells[2] -eq 'Verified-available') { $inputCompleteness.verified++ }
        if ($cells.Count -ge 3 -and $cells[2] -in @('Reported-linked','Available-unverified','Unavailable','Unknown')) { $inputCompleteness.unavailable++ }
    }
}
$profileConflictSection = [regex]::Match($profile, '(?ms)^##\s+Evidence Sources and Conflicts\s*$\s*(?<body>.*?)(?=^##\s|\z)')
if ($profileConflictSection.Success) {
    $inputCompleteness.conflicting = @([regex]::Matches($profileConflictSection.Groups['body'].Value, '(?mi)^\|\s*CON-\d{3}\s*\|(?<rest>.*)$') | Where-Object {
        $cells = @($_.Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
        $cells.Count -ge 5 -and $cells[4] -eq 'Open'
    }).Count
}
$inputCompleteness.unresolved = @($profileActionRows | Where-Object {
    $cells = @($_.Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
    $cells.Count -ge 7 -and $cells[6] -in @('Requested','Answered-unvalidated')
}).Count
$briefMatch = [regex]::Match($content, '(?ms)^##\s+Review Brief\s*$\s*(?<body>.*?)(?=^##\s|\z)')
if (-not $briefMatch.Success) {
    if ($ValidationStage -eq 'ReadyForReview') { $errors.Add('ReadyForReview requires a concise Review Brief before Test Strategy.') }
    else { $warnings.Add('Legacy Test Plan is missing Review Brief; add linked review navigation before the next human review.') }
} else {
    $brief = $briefMatch.Groups['body'].Value
    $strategyHeading = [regex]::Match($content, '(?m)^##\s+Test Strategy\s*$')
    if ($strategyHeading.Success -and $briefMatch.Index -gt $strategyHeading.Index) { $errors.Add('Review Brief must precede Test Strategy and detailed test tables.') }
    foreach ($label in @('Purpose and maturity','Proposed scope and exclusions','Evidence basis and confidence','Artifact quality versus input completeness','Next gate and version boundary')) {
        if ($brief -notmatch "(?m)^\*\*$([regex]::Escape($label))\*\*:[ \t]*\S") { $errors.Add("Review Brief requires '$label'.") }
    }
    $briefStatuses = @{}
    foreach ($actionId in $ownedActions.Keys) { $briefStatuses[$actionId] = $ownedActions[$actionId][6] }
    foreach ($conflict in @([regex]::Matches($profileConflictSection.Groups['body'].Value, '(?mi)^\|\s*(?<id>CON-\d{3})\s*\|(?<rest>.*)$'))) {
        $cells = @($conflict.Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
        if ($cells.Count -ge 5) { $briefStatuses[$conflict.Groups['id'].Value] = $cells[4] }
    }
    foreach ($id in @([regex]::Matches($brief, '\b(?:ACT-\d{3}|AUT-\d{2,}|CON-\d{3})\b') | ForEach-Object { $_.Value } | Select-Object -Unique)) {
        if (-not $briefStatuses.ContainsKey($id)) { $errors.Add("Review Brief references missing or unowned canonical record '$id'.") }
    }
    foreach ($sectionName in @('Significant Conflicts','Priority Human Actions')) {
        $section = [regex]::Match($brief, "(?ms)^###\s+$([regex]::Escape($sectionName))\s*$\s*(?<body>.*?)(?=^###\s|\z)")
        if (-not $section.Success) { $errors.Add("Review Brief requires '$sectionName'."); continue }
        $rows = @([regex]::Matches($section.Groups['body'].Value, '(?m)^\|\s*(?<rest>.*)$') | Where-Object { $_.Value -notmatch '^\|\s*(?:Priority / Why Now|---)' })
        if ($rows.Count -gt 5) { $errors.Add("Review Brief '$sectionName' must prioritize at most five items; link the full register.") }
        if ($rows.Count -eq 0 -and $section.Value -notmatch '(?i)None\s+[—:-]\s+\S') { $errors.Add("Review Brief '$sectionName' requires prioritized rows or 'None — reason'.") }
        foreach ($row in $rows) {
            $cells = @($row.Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
            if ($cells.Count -ne 4 -or @($cells | Where-Object { -not $_ -or $_ -match '^\{.*\}$' }).Count -gt 0) { $errors.Add("Review Brief '$sectionName' requires priority, linked canonical reference, current status and next step."); continue }
            $idPattern = if ($sectionName -eq 'Significant Conflicts') { '\bCON-\d{3}\b' } else { '\b(?:ACT-\d{3}|AUT-\d{2,})\b' }
            $ids = @([regex]::Matches($cells[1], $idPattern) | ForEach-Object { $_.Value })
            $registerAnchor = if ($sectionName -eq 'Significant Conflicts') { 'evidence-sources-and-conflicts' } else { 'human-input-and-decision-register' }
            if ($ids.Count -ne 1 -or $cells[1] -notmatch "\]\([^)]+testing-profile\.md#$registerAnchor\)") { $errors.Add("Review Brief '$sectionName' must link one canonical register record per row."); continue }
            if ($briefStatuses.ContainsKey($ids[0]) -and $cells[2] -ne $briefStatuses[$ids[0]]) { $errors.Add("Review Brief status for '$($ids[0])' contradicts the canonical register.") }
        }
    }
    foreach ($anchor in @('#scenario-scope-and-automation-effort','#high-level-case-outlines','#test-assets-and-traceability','#estimate-scope-and-boundary-reconciliation','#test-plan-approval-gate')) {
        if ($brief -notmatch [regex]::Escape("]($anchor)")) { $errors.Add("Review Brief must link supporting detail '$anchor'.") }
    }
}
if ($deferredReadiness.Count -gt 0) { $warnings.Add("$($deferredReadiness.Count) test types have owned unresolved architecture readiness; resolve before Execution.") }
if ($deferredApprovers.Count -gt 0) { $warnings.Add("$($deferredApprovers.Count) test types have owned pending approver appointments; named humans are required before Execution.") }
$result = @{
    testPlanPath = [System.IO.Path]::GetFullPath($TestPlanPath)
    validationStage = $ValidationStage
    planStatus = $planStatus
    valid = ($errors.Count -eq 0)
    errorCount = $errors.Count
    errors = @($errors)
    warnings = @($warnings)
    inputCompleteness = $inputCompleteness
    deferredExecutionRequirements = @{ architectureReadiness = @($deferredReadiness); namedApprovers = @($deferredApprovers) }
}
Write-ScriptResult -Data $result -Json:$Json
if ($errors.Count -gt 0) { exit 1 }
exit 0
