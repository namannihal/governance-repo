#requires -Version 5.1
# Validates target architecture views and their connectivity-table reconciliation.
[CmdletBinding()]
param(
    [string]$ArchitecturePath,
    [string]$TransitionProfilePath,
    [string]$TestingProfilePath,
    [switch]$Json
)

$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'common.ps1')

if (-not $ArchitecturePath) {
    $featureDirName = Get-CurrentFeatureDirName
    if (-not $featureDirName) {
        Write-Error "Unable to identify the current feature. Pass -ArchitecturePath or use a matching feature branch/folder."
        exit 1
    }
    $ArchitecturePath = (Get-FeaturePaths -FeatureDirName $featureDirName).ARCHITECTURE
}

if (-not (Test-Path -LiteralPath $ArchitecturePath -PathType Leaf)) {
    Write-Error "architecture.md not found: $ArchitecturePath"
    exit 1
}

if (-not $TransitionProfilePath) {
    $candidateTransitionProfile = Join-Path (Join-Path (Split-Path -Parent ([System.IO.Path]::GetFullPath($ArchitecturePath))) 'requirements') 'migration-transition.md'
    if (Test-Path -LiteralPath $candidateTransitionProfile -PathType Leaf) {
        $TransitionProfilePath = $candidateTransitionProfile
    }
}
if ($TransitionProfilePath -and -not (Test-Path -LiteralPath $TransitionProfilePath -PathType Leaf)) {
    Write-Error "migration-transition.md not found: $TransitionProfilePath"
    exit 1
}
if (-not $TestingProfilePath) {
    $candidateTestingProfile = Join-Path (Join-Path (Split-Path -Parent ([System.IO.Path]::GetFullPath($ArchitecturePath))) 'requirements') 'testing-profile.md'
    if (Test-Path -LiteralPath $candidateTestingProfile -PathType Leaf) { $TestingProfilePath = $candidateTestingProfile }
}
if (-not $TestingProfilePath -or -not (Test-Path -LiteralPath $TestingProfilePath -PathType Leaf)) {
    Write-Error "testing-profile.md not found beside architecture requirements: $TestingProfilePath"
    exit 1
}

$content = Get-Content -LiteralPath $ArchitecturePath -Raw
$errors = [System.Collections.Generic.List[string]]::new()
$warnings = [System.Collections.Generic.List[string]]::new()

function Add-ValidationError {
    param([Parameter(Mandatory = $true)][string]$Message)
    $errors.Add($Message)
}

function Get-SectionContent {
    param([Parameter(Mandatory = $true)][string]$HeadingPattern)
    $match = [regex]::Match($content, "(?ms)^$HeadingPattern\s*\r?\n(?<body>.*?)(?=^#{2,3}\s|\z)")
    if ($match.Success) { return $match.Groups['body'].Value }
    return $null
}

function Get-NormalizedTestingApplicability {
    param([string]$Value)
    if ($Value -match '^Applicable(?:\s+[—:-]\s+.+)?$') { return 'Applicable' }
    if ($Value -match '^Not Applicable(?:\s+[—:-]\s+.+)?$') { return 'Not Applicable' }
    if ($Value -match '^Exception Approved(?:\s+[—:-]\s+.+)?$') { return 'Exception Approved' }
    return $null
}

$requiredSections = [ordered]@{
    'Target Diagram Inventory and Notation' = '###\s+2\.0\s+Target Diagram Inventory and Notation\s*$'
    'C4 System Context' = '###\s+2\.1\s+System Context\s*$'
    'C4 Container' = '###\s+2\.2\s+Container(?:\s+\(Target Azure Services\))?\s*$'
    'Target Azure Deployment / Runtime View' = '###\s+2\.3\s+Target Azure Deployment\s*/\s*Runtime View\s*$'
    'SKU / Tier Deployability Reconciliation' = '###\s+3\.1\s+SKU\s*/\s*Tier Deployability Reconciliation\s*$'
    'End-User Connectivity Design' = '###\s+5\.1\s+End-User Connectivity Design\s*$'
    'Application-to-Application Interface Design' = '###\s+5\.2\s+Application-to-Application Interface Design(?:\s+\(SAD 2\.6\.2\))?\s*$'
    'Data Footprint' = '###\s+6\.1\s+Data Footprint\s*$'
    'Source Profile Fitness' = '###\s+6\.5\s+Source Profile Fitness for Migration Design\s*$'
    'Migration Toolchain Decision' = '###\s+6\.6\s+Migration Toolchain Decision\s*$'
    'Rejected Migration Tool Candidates' = '###\s+6\.6\.1\s+Rejected Migration Tool Candidates\s*$'
    'Migration Tool Consequences' = '###\s+6\.7\s+Migration Tool Deployment and Operational Consequences\s*$'
    'Migration Transition & Cutover Design' = '##\s+7A\.\s+Migration Transition\s*&\s*Cutover Design\s*$'
    'Complexity Calculator V4.1 Inputs' = '###\s+8A\.\s+Complexity Calculator V4\.1 Inputs\s*$'
    'Migration Testability Matrix' = '###\s+14\.1\s+Migration Testability Matrix\s*$'
    'OAT Scenario Applicability Matrix' = '###\s+14\.2\s+OAT Scenario Applicability Matrix\s*$'
    'High-Level Test Scenario Design' = '###\s+14\.3\s+High-Level Test Scenario Design\s*$'
    'Migration Impact-to-Test Crosswalk' = '###\s+14\.4\s+Migration Impact-to-Test Crosswalk\s*$'
    'Environment Topology Variances' = '###\s+1\.3\s+Environment Topology Variances\s*$'
    'Technology Inventory and Lifecycle' = '###\s+3\.2\s+Technology Inventory and Lifecycle\s*$'
    'Infrastructure Requirements Assessment' = '###\s+3\.3\s+Infrastructure Requirements Assessment\s*$'
    'Interface Protection Controls' = '####\s+5\.2\.1\s+Interface Protection Controls\s*$'
    'Dependency Governance' = '####\s+5\.2\.2\s+Dependency Governance\s*$'
    'Internet Perimeter Protection' = '###\s+5\.6\s+Internet Perimeter Protection\s*$'
    'Data Sovereignty and Jurisdiction' = '###\s+6\.8\s+Data Sovereignty and Jurisdiction\s*$'
    'Data Integrity Controls' = '###\s+6\.9\s+Data Integrity Controls\s*$'
    'End-User Device Profiles and MFA' = '####\s+7\.2\.5\s+End-User Device Profiles and MFA\s*$'
    'Production Operator Access Model' = '####\s+7\.2\.6\s+Production Operator Access Model\s*$'
    'MEC Applicability and Target Treatment' = '###\s+7\.4\s+MEC Applicability and Target Treatment\s*$'
    'Endpoint and Workload Security Agents' = '###\s+7\.5\s+Endpoint and Workload Security Agents\s*$'
    'Application and Software Security' = '###\s+7\.6\s+Application and Software Security\s*$'
    'AI and LLM Security' = '###\s+7\.7\s+AI and LLM Security\s*$'
    'Security Logging and Threat Detection' = '###\s+7\.8\s+Security Logging and Threat Detection\s*$'
    'Guardrail and Policy Exceptions Register' = '###\s+10\.1\s+Guardrail and Policy Exceptions Register\s*$'
    'Observability Solution Design' = '####\s+12\.1\.1\s+Observability Solution Design\s*$'
    'Target Lifecycle, Currency and Exit' = '####\s+12\.6\.4\s+Target Lifecycle, Currency and Exit\s*$'
    'Cost Drivers and Commitment Strategy' = '###\s+13\.4A\s+Cost Drivers and Commitment Strategy\s*$'
    'Sustainability Design Rationale' = '####\s+13\.8\.1\s+Sustainability Design Rationale\s*$'
}

foreach ($entry in $requiredSections.GetEnumerator()) {
    if (-not [regex]::IsMatch($content, "(?m)^$($entry.Value)")) {
        Add-ValidationError "Missing required section: $($entry.Key)."
    }
}

# MEC architecture assessment must keep compliance calculation separate from three-role approval.
$mecBody = Get-SectionContent -HeadingPattern '###\s+7\.4\s+MEC Applicability and Target Treatment\s*$'
if ($null -ne $mecBody) {
    $mecLines = @($mecBody -split "`r?`n")
    $header = @($mecLines | Where-Object { $_ -match "^\|.*This Application's MEC Compliance Status.*Compliance Review State.*\|$" } | Select-Object -First 1)
    if ($header.Count -ne 1) {
        Add-ValidationError "Section 7.4 must include separate 'This Application's MEC Compliance Status' and 'Compliance Review State' columns."
    } else {
        $headerCells = @($header[0].Trim('|').Split('|') | ForEach-Object { $_.Trim() })
        $statusColumn = [Array]::IndexOf($headerCells, "This Application's MEC Compliance Status")
        $reviewColumn = [Array]::IndexOf($headerCells, 'Compliance Review State')
        $rows = @($mecLines | Where-Object { $_ -match '^\|\s*MEC-v3_3-\d+\s*\|' })
        if ($rows.Count -ne 30) { Add-ValidationError "Section 7.4 must contain exactly 30 MEC rows; found $($rows.Count)." }
        $allowedStatuses = @('Compliant', 'Not Applicable', 'Non-Compliant', 'Partially-Compliant')
        $proposedCount = 0
        foreach ($row in $rows) {
            $cells = @($row.Trim('|').Split('|') | ForEach-Object { $_.Trim() })
            $id = $cells[0]
            if ($statusColumn -ge $cells.Count -or $cells[$statusColumn] -notin $allowedStatuses) {
                Add-ValidationError "$id has an invalid application MEC compliance status in Section 7.4."
            }
            if ($reviewColumn -ge $cells.Count -or $cells[$reviewColumn] -notmatch '^(?:Proposed — pending Migration Architect, Application Architect and Security SME review|Approved — .+)$') {
                Add-ValidationError "$id has an invalid Compliance Review State in Section 7.4."
            } elseif ($cells[$reviewColumn] -like 'Proposed*') {
                $proposedCount++
            }
        }
        if ($proposedCount -gt 0 -and $content -match '(?m)^\*\*Outcome\*\*:\s*Cleared\b') {
            Add-ValidationError "Architecture Review Gate cannot be Cleared while $proposedCount MEC compliance rows remain Proposed."
        }
    }
}

$architectureDirectory = Split-Path -Parent ([System.IO.Path]::GetFullPath($ArchitecturePath))
$mecChecklistPath = Join-Path (Join-Path $architectureDirectory 'checklists') 'mec-assessment.md'
$frameworkRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..\..\..'))
$mecBaselinePath = Join-Path (Join-Path $frameworkRoot '.specify\checklists') 'mec-assessment.md'
if (-not (Test-Path -LiteralPath $mecChecklistPath -PathType Leaf)) {
    Add-ValidationError "Required MEC assessment quality checklist is missing: $mecChecklistPath"
} elseif (-not (Test-Path -LiteralPath $mecBaselinePath -PathType Leaf)) {
    Add-ValidationError "Controlled MEC assessment checklist baseline is missing: $mecBaselinePath"
} else {
    $mecChecklistContent = Get-Content -LiteralPath $mecChecklistPath -Raw
    $mecChecklistItems = @([regex]::Matches($mecChecklistContent, '(?m)^- \[(?<mark>[ xX])\] (?<id>CHK\d{3})\s+(?<text>.+)$'))
    $mecBaselineContent = Get-Content -LiteralPath $mecBaselinePath -Raw
    $mecBaselineItems = @([regex]::Matches($mecBaselineContent, '(?m)^- \[[ xX]\] (?<id>CHK\d{3})\s+(?<text>.+)$'))
    foreach ($baselineItem in $mecBaselineItems) {
        $id = $baselineItem.Groups['id'].Value
        $canonicalText = $baselineItem.Groups['text'].Value.TrimEnd("`r")
        $applicationItem = @($mecChecklistItems | Where-Object { $_.Groups['id'].Value -eq $id })
        if ($applicationItem.Count -ne 1 -or -not $applicationItem[0].Groups['text'].Value.TrimEnd("`r").StartsWith($canonicalText, [System.StringComparison]::Ordinal)) {
            Add-ValidationError "MEC assessment checklist must preserve controlled baseline item $id verbatim."
        }
    }
    $mecCheckedCount = @($mecChecklistItems | Where-Object { $_.Groups['mark'].Value -match '[xX]' }).Count
    $mecOpenCount = $mecChecklistItems.Count - $mecCheckedCount
    $mecStatusSection = [regex]::Match($content, '(?ms)^####\s+7\.4\.1\s+MEC Assessment Quality Checklist\s*\r?\n(?<body>.*?)(?=^###\s)')
    if (-not $mecStatusSection.Success) {
        Add-ValidationError 'Architecture is missing Section 7.4.1 MEC Assessment Quality Checklist.'
    } else {
        $mecStatusRow = [regex]::Match($mecStatusSection.Groups['body'].Value, '(?m)^\|\s*`checklists/mec-assessment\.md`\s*\|(?<row>.+)$')
        if (-not $mecStatusRow.Success) {
            Add-ValidationError 'Section 7.4.1 is missing the MEC checklist status row.'
        } else {
            $cells = @($mecStatusRow.Value.Trim('|').Split('|') | ForEach-Object { $_.Trim() })
            if ($cells.Count -lt 6 -or $cells[1] -ne [string]$mecChecklistItems.Count -or $cells[2] -ne [string]$mecCheckedCount -or $cells[3] -ne [string]$mecOpenCount) {
                Add-ValidationError "Section 7.4.1 MEC checklist counts do not match the checklist ($($mecChecklistItems.Count)/$mecCheckedCount/$mecOpenCount)."
            }
        }
    }
    if ($mecOpenCount -gt 0 -and $content -match '(?m)^\*\*Outcome\*\*:\s*Cleared\b') {
        Add-ValidationError "Architecture Review Gate cannot be Cleared while $mecOpenCount required MEC checklist item(s) remain unchecked."
    }
}

# Each WAF pillar table must disposition every checklist code exactly once.
$wafPillars = @(
    @{ Heading = '###\s+7\.9\s+Well-Architected Security Alignment\s*$'; Prefix = 'SE'; Count = 12 },
    @{ Heading = '###\s+12\.7\s+Well-Architected Reliability Alignment\s*$'; Prefix = 'RE'; Count = 10 },
    @{ Heading = '###\s+12\.8\s+Well-Architected Operational Excellence Alignment\s*$'; Prefix = 'OE'; Count = 11 },
    @{ Heading = '###\s+12\.9\s+Well-Architected Performance Efficiency Alignment\s*$'; Prefix = 'PE'; Count = 12 },
    @{ Heading = '###\s+13\.9\s+Well-Architected Cost Optimization Alignment\s*$'; Prefix = 'CO'; Count = 14 }
)
foreach ($pillar in $wafPillars) {
    $pillarBody = Get-SectionContent -HeadingPattern $pillar.Heading
    if ($null -eq $pillarBody) { Add-ValidationError "Missing WAF alignment section for $($pillar.Prefix) codes."; continue }
    for ($i = 1; $i -le $pillar.Count; $i++) {
        $code = '{0}:{1:D2}' -f $pillar.Prefix, $i
        $rows = @([regex]::Matches($pillarBody, "(?m)^\|\s*$([regex]::Escape($code))\s*\|(?<rest>.*)$"))
        if ($rows.Count -ne 1) { Add-ValidationError "WAF code $code must appear exactly once in its alignment table (found $($rows.Count))."; continue }
        $cells = @($rows[0].Groups['rest'].Value -split '\|' | ForEach-Object { $_.Trim() })
        if ($cells.Count -ge 5 -and $cells[4] -notmatch '^(Aligned|Partially aligned|Deviation\s+[—-]\s+(justified|risk)|Not applicable)\b') {
            Add-ValidationError "WAF code $code has an invalid alignment disposition '$($cells[4])'."
        }
        if ($cells.Count -ge 7 -and $cells[4] -match '^(Partially aligned|Deviation\s+[—-]\s+risk)' -and $cells[6] -notmatch '\b(ADR|RSK)-\d{3,4}\b') {
            Add-ValidationError "WAF code $code is '$($cells[4])' but links no ADR/RSK."
        }
    }
}

$testabilitySection = Get-SectionContent -HeadingPattern $requiredSections['Migration Testability Matrix']
$testingProfileContent = Get-Content -LiteralPath $TestingProfilePath -Raw
$canonicalTestTypes = @(
    'Connectivity', 'Unit', 'Data migration verification', 'Migration tool',
    'Application installation', 'Smoke/regression', 'Change-based functional',
    'Full functional', 'Performance and baseline', 'High availability',
    'Disaster recovery', 'Security testing', 'Security penetration testing',
    'Operational acceptance testing', 'User acceptance testing'
)
if ($null -ne $testabilitySection) {
    $header = ([regex]::Match($testabilitySection, '(?m)^\|.*\|\s*$')).Value
    foreach ($column in @('Test Type','Requirements / Profile Disposition','Resolved Applicability / R-Type Basis','Owning Architecture Section(s)','Target Mechanism Under Test','Approved Environment / Production Comparability','Observability / Evidence Path','Data / Identity / Access Prerequisites','Readiness','ADR/Risk')) {
        if ($header -notmatch [regex]::Escape($column)) { Add-ValidationError "Section 14.1 is missing required column '$column'." }
    }
    foreach ($testType in $canonicalTestTypes) {
        $profileRows = @([regex]::Matches($testingProfileContent, "(?mi)^\|\s*$([regex]::Escape($testType))\s*\|(?<rest>.*)$"))
        if ($profileRows.Count -ne 1) { Add-ValidationError "Testing profile must contain exactly one canonical '$testType' row (found $($profileRows.Count))."; continue }
        $rows = @([regex]::Matches($testabilitySection, "(?mi)^\|\s*$([regex]::Escape($testType))\s*\|(?<rest>.*)$"))
        if ($rows.Count -ne 1) { Add-ValidationError "Section 14.1 must contain exactly one '$testType' row (found $($rows.Count))."; continue }
        $profileCells = @($profileRows[0].Groups['rest'].Value.TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
        $cells = @($rows[0].Groups['rest'].Value.TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
        if ($cells.Count -lt 9) { Add-ValidationError "Section 14.1 row '$testType' does not contain all required fields."; continue }
        $profileDisposition = if ($profileCells.Count -ge 2) { $profileCells[1] } else { $null }
        $profileIds = if ($profileCells.Count -ge 4) { @([regex]::Matches($profileCells[3], '\b(?:REQ|NFR)-\d{3}\b') | ForEach-Object { $_.Value } | Select-Object -Unique) } else { @() }
        $architectureIds = @([regex]::Matches($cells[0], '\b(?:REQ|NFR)-\d{3}\b') | ForEach-Object { $_.Value } | Select-Object -Unique)
        $statedDispositionMatches = @([regex]::Matches($cells[0], '(?i)(?:^|[;\s])(?<value>Conditionally Applicable|Not Applicable|Exception Proposed|Applicable|Unknown)(?:$|[;\s])'))
        if ($statedDispositionMatches.Count -ne 1) { Add-ValidationError "Section 14.1 row '$testType' must state exactly one testing-profile disposition." }
        elseif ($statedDispositionMatches[0].Groups['value'].Value -cne $profileDisposition) { Add-ValidationError "Section 14.1 row '$testType' states profile disposition '$($statedDispositionMatches[0].Groups['value'].Value)' but authoritative profile says '$profileDisposition'." }
        if ($profileDisposition -ne 'Not Applicable' -and $architectureIds.Count -eq 0) { Add-ValidationError "Section 14.1 row '$testType' must trace at least one REQ/NFR." }
        foreach ($profileId in $profileIds) { if ($architectureIds -notcontains $profileId) { Add-ValidationError "Section 14.1 row '$testType' omits profile requirement '$profileId'." } }
        foreach ($architectureId in $architectureIds) { if ($profileIds -notcontains $architectureId) { Add-ValidationError "Section 14.1 row '$testType' adds requirement '$architectureId' absent from the testing profile." } }
        $architectureApplicability = Get-NormalizedTestingApplicability -Value $cells[1]
        if (-not $architectureApplicability) { Add-ValidationError "Section 14.1 row '$testType' has invalid resolved applicability '$($cells[1])'." }
        if ($profileDisposition -eq 'Applicable' -and $architectureApplicability -ne 'Applicable') { Add-ValidationError "Applicable profile row '$testType' must remain Applicable in architecture." }
        if ($profileDisposition -eq 'Conditionally Applicable' -and $architectureApplicability -notin @('Applicable','Not Applicable')) { Add-ValidationError "Conditional profile row '$testType' must resolve to Applicable or Not Applicable in architecture." }
        if ($profileDisposition -eq 'Not Applicable' -and $architectureApplicability -ne 'Not Applicable') { Add-ValidationError "Not Applicable profile row '$testType' must remain Not Applicable in architecture." }
        if ($profileDisposition -eq 'Exception Proposed' -and $architectureApplicability -ne 'Exception Approved') { Add-ValidationError "Exception Proposed profile row '$testType' must resolve to Exception Approved before the architecture gate clears." }
        if ($profileDisposition -eq 'Unknown') { Add-ValidationError "Testing profile row '$testType' remains Unknown and blocks architecture readiness." }
        if ($cells[2] -notmatch '(?i)Section') { Add-ValidationError "Section 14.1 row '$testType' must name its owning architecture section(s)." }
        if ($cells[7] -notin @('Ready','Conditional','Blocked')) { Add-ValidationError "Section 14.1 row '$testType' has invalid readiness '$($cells[7])'." }
        if ($cells[7] -in @('Conditional','Blocked') -and $cells[8] -notmatch '\b(?:ADR|RSK)-\d{3,4}\b') { Add-ValidationError "Section 14.1 row '$testType' is $($cells[7]) and must link an ADR/risk." }
        foreach ($index in 1..6) { if (-not $cells[$index] -or $cells[$index] -match '^\{.*\}$') { Add-ValidationError "Section 14.1 row '$testType' has an unresolved required field."; break } }
    }
}

$scenarioSection = Get-SectionContent -HeadingPattern '###\s+14\.3\s+High-Level Test Scenario Design'
if ($null -eq $scenarioSection) {
    Add-ValidationError 'Missing Section 14.3 High-Level Test Scenario Design.'
} else {
    $profileActionsSection = [regex]::Match($testingProfileContent, '(?ms)^##\s+Human Input and Decision Register\s*$\s*(?<body>.*?)(?=^##\s|\z)')
    $profileActionIds = @()
    if ($profileActionsSection.Success) {
        $profileActionIds = @([regex]::Matches($profileActionsSection.Groups['body'].Value, '(?mi)^\|\s*(?<id>ACT-\d{3}|AUT-\d{2,})\s*\|') | ForEach-Object { $_.Groups['id'].Value })
    }
    $scenarioRefs = @()
    foreach ($testType in $canonicalTestTypes) {
        $typeRow = [regex]::Match($testabilitySection, "(?mi)^\|\s*$([regex]::Escape($testType))\s*\|(?<rest>.*)$")
        $typeCells = @($typeRow.Groups['rest'].Value.TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
        if ($typeCells.Count -lt 2 -or $typeCells[1] -match '^Not Applicable|^Exception Approved') { continue }
        $rows = @([regex]::Matches($scenarioSection, "(?mi)^\|\s*(?<id>[^|]+)\s*\|\s*$([regex]::Escape($testType))\s*\|(?<rest>.*)$"))
        if ($rows.Count -eq 0) {
            $reviewRow = [regex]::Match($testingProfileContent, "(?mi)^\|\s*(?<id>AUT-\d{2,})\s*\|\s*$([regex]::Escape($testType))\s*\|")
            if (-not $reviewRow.Success -or $profileActionIds -notcontains $reviewRow.Groups['id'].Value) {
                Add-ValidationError "Section 14.3 '$testType' needs an evidenced scenario family or its owned Application Team action."
            }
            continue
        }
        foreach ($row in $rows) {
            $scenarioRef = $row.Groups['id'].Value.Trim()
            if ($scenarioRef -notmatch '^[A-Za-z][A-Za-z0-9._-]+$') { Add-ValidationError "Section 14.3 '$testType' has invalid stable family reference '$scenarioRef'." }
            $scenarioRefs += $scenarioRef
            $cells = @($row.Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
            if ($cells.Count -ne 5) { Add-ValidationError "Section 14.3 '$testType' requires all five design fields."; continue }
            foreach ($index in 0..4) {
                if (-not $cells[$index] -or $cells[$index] -match '^\{.*\}$') { Add-ValidationError "Section 14.3 '$testType' has an unresolved design field."; break }
            }
            if ($cells[0] -notmatch '\b(?:REQ|NFR)-\d{3}\b') { Add-ValidationError "Section 14.3 '$testType' requires requirement traces." }
            $reviewRow = [regex]::Match($testingProfileContent, "(?mi)^\|\s*(?<id>AUT-\d{2,})\s*\|\s*$([regex]::Escape($testType))\s*\|\s*(?<status>[^|]+)\s*\|")
            if (-not $reviewRow.Success -or $cells[2] -notmatch "\b$([regex]::Escape($reviewRow.Groups['id'].Value))\b" -or $cells[2] -notmatch "\b$([regex]::Escape($reviewRow.Groups['status'].Value.Trim()))\b") {
                Add-ValidationError "Section 14.3 '$testType' must trace its automation review ID and status."
            }
            if ($cells[4] -notmatch '(?i)Section\s+\d' -or $cells[4] -notmatch '(?i)Appendix 5' -or $cells[4] -notmatch '(?i)implementation' -or $cells[4] -notmatch '(?i)execution' -or $cells[4] -notmatch '(?i)maintenance') {
                Add-ValidationError "Section 14.3 '$testType' must separate implementation/execution/maintenance and cite the LMP section/Appendix 5."
            }
        }
    }
    foreach ($duplicate in @($scenarioRefs | Group-Object | Where-Object { $_.Count -gt 1 })) {
        Add-ValidationError "Section 14.3 family reference '$($duplicate.Name)' is duplicated."
    }
}

$impactSection = Get-SectionContent -HeadingPattern $requiredSections['Migration Impact-to-Test Crosswalk']
if ($null -ne $impactSection) {
    $impactHeader = ([regex]::Match($impactSection, '(?m)^\|.*\|\s*$')).Value
    foreach ($column in @('Impact ID','Source Component / Store / Interface / Flow and Evidence Locator','Target Disposition (Retain / Change / Replace / Retire)','Data / State Movement Mechanism or Evidence-backed None','Impacted and Dependent Unchanged Behavior','REQ/NFR and Test Type / Section 14.3 Family or Supplied Case','Coverage Disposition (Covered / Proposed / Excluded / Pending) and Evidence','Owner / Action ID / Gate')) {
        if ($impactHeader -notmatch [regex]::Escape($column)) { Add-ValidationError "Section 14.4 is missing required column '$column'." }
    }
    $impactRows = @([regex]::Matches($impactSection, '(?mi)^\|\s*(?<id>XWALK-\d{3})\s*\|(?<rest>.*)$'))
    if ($impactRows.Count -eq 0) { Add-ValidationError 'Section 14.4 must contain at least one evidenced impact row or an explicit tracked inventory gap.' }
    $impactIds = @()
    $profileRequirementIds = @()
    foreach ($testType in $canonicalTestTypes) {
        $profileRow = [regex]::Match($testingProfileContent, "(?mi)^\|\s*$([regex]::Escape($testType))\s*\|(?<rest>.*)$")
        if (-not $profileRow.Success) { continue }
        $profileCells = @($profileRow.Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
        if ($profileCells.Count -ge 4) { $profileRequirementIds += @([regex]::Matches($profileCells[3], '\b(?:REQ|NFR)-\d{3}\b') | ForEach-Object { $_.Value }) }
    }
    $profileRequirementIds = @($profileRequirementIds | Select-Object -Unique)
    $scenarioReferenceSet = @()
    if ($null -ne $scenarioSection) { $scenarioReferenceSet = @([regex]::Matches($scenarioSection, '(?mi)^\|\s*(?<id>[A-Za-z][A-Za-z0-9._-]+)\s*\|\s*(?:Connectivity|Unit|Data migration verification|Migration tool|Application installation|Smoke/regression|Change-based functional|Full functional|Performance and baseline|High availability|Disaster recovery|Security testing|Security penetration testing|Operational acceptance testing|User acceptance testing)\s*\|') | ForEach-Object { $_.Groups['id'].Value }) }
    $profileActionIds = @()
    $profileActionsSection = [regex]::Match($testingProfileContent, '(?ms)^##\s+Human Input and Decision Register\s*$\s*(?<body>.*?)(?=^##\s|\z)')
    if ($profileActionsSection.Success) { $profileActionIds = @([regex]::Matches($profileActionsSection.Groups['body'].Value, '(?mi)^\|\s*(?<id>ACT-\d{3}|AUT-\d{2,})\s*\|') | ForEach-Object { $_.Groups['id'].Value }) }
    foreach ($impactRow in $impactRows) {
        $impactId = $impactRow.Groups['id'].Value
        $impactIds += $impactId
        $cells = @($impactRow.Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
        if ($cells.Count -ne 7) { Add-ValidationError "Section 14.4 row '$impactId' requires all seven impact-to-test fields."; continue }
        if ($cells[0] -match '(?i)^(?:N/?A|Unknown|TBD|\{.*\})$' -and $cells[6] -notmatch '\b(?:ACT-\d{3}|AUT-\d{2,})\b') { Add-ValidationError "Section 14.4 row '$impactId' must identify its source inventory item or link an owner action." }
        if ($cells[1] -notmatch '^(?:Retain|Change|Replace|Retire)\b') { Add-ValidationError "Section 14.4 row '$impactId' must distinguish Retain, Change, Replace, or Retire." }
        if ($cells[2] -match '(?i)^(?:N/?A|Unknown|TBD|\{.*\})$') { Add-ValidationError "Section 14.4 row '$impactId' must state a data/state movement mechanism or cite evidence-backed no movement." }
        if ($cells[3] -match '(?i)^(?:N/?A|Unknown|TBD|\{.*\})$' -and $cells[6] -notmatch '\b(?:ACT-\d{3}|AUT-\d{2,})\b') { Add-ValidationError "Section 14.4 row '$impactId' must identify affected/dependent behavior or an owner action." }
        $impactRequirementIds = @([regex]::Matches($cells[4], '\b(?:REQ|NFR)-\d{3}\b') | ForEach-Object { $_.Value } | Select-Object -Unique)
        $coverageDispositionMatch = [regex]::Match($cells[5], '^(?<value>Covered|Proposed|Excluded|Pending)(?:\s+[—:-]\s*(?<detail>.*))?$')
        if (-not $coverageDispositionMatch.Success) { Add-ValidationError "Section 14.4 row '$impactId' has invalid coverage disposition '$($cells[5])'." }
        $coverageDisposition = if ($coverageDispositionMatch.Success) { $coverageDispositionMatch.Groups['value'].Value } else { $null }
        if ($coverageDisposition -eq 'Excluded' -and ($coverageDispositionMatch.Groups['detail'].Value -match '(?i)^(?:N/?A|None|Unknown|TBD|\{.*\})$' -or $coverageDispositionMatch.Groups['detail'].Value.Length -lt 8)) { Add-ValidationError "Section 14.4 excluded row '$impactId' requires applicability evidence." }
        $hasCanonicalType = $false
        foreach ($testType in $canonicalTestTypes) { if ($cells[4] -match [regex]::Escape($testType)) { $hasCanonicalType = $true; break } }
        $hasCaseTrace = $cells[4] -match '\b(?:SCN-[A-Za-z0-9_-]+|CASE-[A-Za-z0-9._-]+|L2-OAT-[A-Z]+-\d{2})\b'
        if ($coverageDisposition -in @('Covered','Proposed') -and ($impactRequirementIds.Count -eq 0 -or -not $hasCanonicalType -or -not $hasCaseTrace)) { Add-ValidationError "Section 14.4 row '$impactId' must link REQ/NFR, canonical test type and a family/supplied case." }
        foreach ($requirementId in $impactRequirementIds) {
            if ($profileRequirementIds -notcontains $requirementId) { Add-ValidationError "Section 14.4 row '$impactId' references '$requirementId' absent from the authoritative testing profile." }
        }
        $scenarioIds = @([regex]::Matches($cells[4], '\bSCN-[A-Za-z0-9_-]+\b') | ForEach-Object { $_.Value })
        foreach ($scenarioId in $scenarioIds) { if ($scenarioReferenceSet -notcontains $scenarioId) { Add-ValidationError "Section 14.4 row '$impactId' references missing Section 14.3 family '$scenarioId'." } }
        if ($coverageDisposition -eq 'Pending' -and $cells[6] -notmatch '\b(?:ACT-\d{3}|AUT-\d{2,})\b') { Add-ValidationError "Pending Section 14.4 row '$impactId' must link a human action." }
        foreach ($actionId in @([regex]::Matches($cells[6], '\b(?:ACT-\d{3}|AUT-\d{2,})\b') | ForEach-Object { $_.Value })) {
            if ($profileActionIds -notcontains $actionId) { Add-ValidationError "Section 14.4 row '$impactId' references missing profile action '$actionId'." }
        }
    }
    foreach ($duplicate in @($impactIds | Group-Object | Where-Object { $_.Count -gt 1 })) { Add-ValidationError "Section 14.4 impact ID '$($duplicate.Name)' is duplicated." }
}

$oatSection = Get-SectionContent -HeadingPattern $requiredSections['OAT Scenario Applicability Matrix']
$oatCatalogPath = Join-Path (Get-RepoRoot) 'docs/testing-strategy/LSEG-L2-OAT-Game-Day-Scenario-Catalog.md'
if (-not (Test-Path -LiteralPath $oatCatalogPath -PathType Leaf)) {
    Add-ValidationError "LSEG L2 OAT scenario catalog is missing: $oatCatalogPath"
} elseif ($null -ne $oatSection) {
    $oatHeader = ([regex]::Match($oatSection, '(?m)^\|.*\|\s*$')).Value
    foreach ($column in @('Catalog ID','Scenario','Applicability','As-is evidence','Proposed Azure target and evidence','Operational objective / testability','Environment, safety, change','Owner, runbook, evidence, ADR/risk')) {
        if ($oatHeader -notmatch [regex]::Escape($column)) { Add-ValidationError "Section 14.2 OAT matrix is missing required column '$column'." }
    }
    $oatIds = @()
    foreach ($group in @(@{ prefix='GD'; count=24 }, @{ prefix='CHG'; count=9 }, @{ prefix='VAL'; count=18 })) {
        for ($number = 1; $number -le $group.count; $number++) {
            $oatIds += "L2-OAT-$($group.prefix)-$('{0:D2}' -f $number)"
        }
    }
    foreach ($oatId in $oatIds) {
        $rows = @([regex]::Matches($oatSection, "(?mi)^\|\s*$([regex]::Escape($oatId))\s*\|(?<rest>.*)$"))
        if ($rows.Count -ne 1) { Add-ValidationError "Section 14.2 must contain exactly one '$oatId' scenario row (found $($rows.Count))."; continue }
        $cells = @($rows[0].Groups['rest'].Value.TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
        if ($cells.Count -lt 7) { Add-ValidationError "Section 14.2 row '$oatId' is missing required fields."; continue }
        if ($cells[1] -notin @('Recommended','Conditionally applicable','Not applicable','Blocked')) { Add-ValidationError "Section 14.2 row '$oatId' has invalid applicability '$($cells[1])'." }
        if ($cells[1] -eq 'Not applicable' -and $cells[2] -match '(?i)^(?:N/?A|None|Unknown|TBD|\{.*\})$') { Add-ValidationError "Section 14.2 Not applicable row '$oatId' requires evidence that its condition does not apply." }
        foreach ($index in 0..6) { if (-not $cells[$index] -or $cells[$index] -match '^\{.*\}$') { Add-ValidationError "Section 14.2 row '$oatId' has an unresolved required field."; break } }
        if (($cells[0] + ' ' + $cells[5]) -match '(?i)production.*(?:failover|inject|terminate|disable|shutdown|restart|deny|block|chaos|disrupt)|(?:failover|inject|terminate|disable|shutdown|restart|deny|block|chaos|disrupt).*production') {
            foreach ($safeguard in @('approved change','bounded impact','communications','stop conditions','recovery readiness')) {
                if ($cells[5] -notmatch "(?i)$([regex]::Escape($safeguard))") { Add-ValidationError "Production-disruptive OAT row '$oatId' must document '$safeguard'." }
            }
        }
    }
}

$complexitySection = Get-SectionContent -HeadingPattern $requiredSections['Complexity Calculator V4.1 Inputs']
if ($null -ne $complexitySection) {
    $complexityFactors = @(
        'Dependencies',
        'Deployable Target Infra Components',
        'Modified Application Component Counts',
        'Modified Database Object Counts',
        'Integration Testing Complexity',
        'Resilience',
        'DevOps Maturity',
        'Cut-over complexity'
    )
    foreach ($factor in $complexityFactors) {
        if ($complexitySection -notmatch [regex]::Escape($factor)) {
            Add-ValidationError "Section 8A missing Complexity Calculator factor: $factor."
        }
    }
    foreach ($column in @('Final Input / Count', 'Rating', 'Architecture Evidence', 'Requirements Trace', 'Confidence', 'ADR / Risk / Human Review')) {
        if ($complexitySection -notmatch [regex]::Escape($column)) {
            Add-ValidationError "Section 8A missing required column: $column."
        }
    }

    if ($complexitySection -notmatch '(?m)^####\s+8A\.Q\s+Complexity Quality Checklist\s*$') {
        Add-ValidationError 'Section 8A missing required subsection: 8A.Q Complexity Quality Checklist.'
    }
    $featureDirectory = Split-Path -Parent ([System.IO.Path]::GetFullPath($ArchitecturePath))
    $complexityChecklistPath = Join-Path (Join-Path $featureDirectory 'checklists') 'complexity-calculator.md'
    if (-not (Test-Path -LiteralPath $complexityChecklistPath -PathType Leaf)) {
        Add-ValidationError "Required Complexity quality checklist is missing: $complexityChecklistPath"
    } else {
        $checklistContent = Get-Content -LiteralPath $complexityChecklistPath -Raw
        $checklistItems = @([regex]::Matches($checklistContent, '(?m)^- \[(?<mark>[ xX])\] (?<id>CHK\d{3})\s+(?<text>.+)$'))
        if ($checklistItems.Count -eq 0) {
            Add-ValidationError 'Complexity quality checklist contains no canonical CHK### items.'
        } else {
            $frameworkRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..\..\..'))
            $complexityBaselinePath = Join-Path $frameworkRoot '.specify\checklists\complexity-calculator.md'
            if (-not (Test-Path -LiteralPath $complexityBaselinePath -PathType Leaf)) {
                Add-ValidationError "Controlled Complexity checklist baseline is missing: $complexityBaselinePath"
            } else {
                $baselineContent = Get-Content -LiteralPath $complexityBaselinePath -Raw
                $baselineItems = @([regex]::Matches($baselineContent, '(?m)^- \[[ xX]\] (?<id>CHK\d{3})\s+(?<text>.+)$'))
                foreach ($baselineItem in $baselineItems) {
                    $baselineId = $baselineItem.Groups['id'].Value
                    $baselineText = $baselineItem.Groups['text'].Value.TrimEnd("`r")
                    $applicationItem = @($checklistItems | Where-Object { $_.Groups['id'].Value -eq $baselineId })
                    if ($applicationItem.Count -ne 1) {
                        Add-ValidationError "Complexity checklist must contain baseline item $baselineId exactly once."
                    } elseif (-not $applicationItem[0].Groups['text'].Value.TrimEnd("`r").StartsWith($baselineText, [System.StringComparison]::Ordinal)) {
                        Add-ValidationError "Complexity checklist item $baselineId does not preserve the controlled baseline question and quality tags."
                    }
                }
            }
            $checkedCount = 0
            foreach ($checklistItem in $checklistItems) {
                if ($checklistItem.Groups['mark'].Value -match '[xX]') { $checkedCount++ }
            }
            $openCount = $checklistItems.Count - $checkedCount
            $statusRow = [regex]::Match($complexitySection, '(?mi)^\|\s*`?checklists/complexity-calculator\.md`?\s*\|(?<rest>.*)$')
            if (-not $statusRow.Success) {
                Add-ValidationError 'Section 8A.Q must contain a status row for checklists/complexity-calculator.md.'
            } else {
                $statusCells = @($statusRow.Groups['rest'].Value.TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
                if ($statusCells.Count -lt 6) {
                    Add-ValidationError 'Section 8A.Q checklist status row is missing required fields.'
                } else {
                    $reportedItems = 0
                    $reportedPassed = 0
                    $reportedOpen = 0
                    if (-not [int]::TryParse($statusCells[1], [ref]$reportedItems) -or $reportedItems -ne $checklistItems.Count) {
                        Add-ValidationError "Section 8A.Q reports item count '$($statusCells[1])' but checklist contains $($checklistItems.Count)."
                    }
                    if (-not [int]::TryParse($statusCells[2], [ref]$reportedPassed) -or $reportedPassed -ne $checkedCount) {
                        Add-ValidationError "Section 8A.Q reports passed count '$($statusCells[2])' but checklist contains $checkedCount checked items."
                    }
                    if (-not [int]::TryParse($statusCells[3], [ref]$reportedOpen) -or $reportedOpen -ne $openCount) {
                        Add-ValidationError "Section 8A.Q reports open count '$($statusCells[3])' but checklist contains $openCount unchecked items."
                    }
                    if ($openCount -eq 0 -and $statusCells[5] -notmatch '^Pass\b') {
                        Add-ValidationError 'Section 8A.Q disposition must be Pass when no checklist items are open.'
                    }
                    if ($openCount -gt 0 -and $statusCells[5] -notmatch '^Blocked\b') {
                        Add-ValidationError 'Section 8A.Q disposition must be Blocked when checklist items remain open.'
                    }
                }
            }
            $gateOutcome = [regex]::Match($content, '(?mi)^\*\*Outcome\*\*:\s*(?<value>.+)$')
            if ($gateOutcome.Success -and $gateOutcome.Groups['value'].Value.Trim() -match '^Cleared\b' -and $openCount -gt 0) {
                Add-ValidationError "Architecture Review Gate is Cleared but the required Complexity quality checklist has $openCount open item(s)."
            }
        }
    }
}

$contextSection = Get-SectionContent -HeadingPattern $requiredSections['C4 System Context']
$containerSection = Get-SectionContent -HeadingPattern $requiredSections['C4 Container']
$deploymentSection = Get-SectionContent -HeadingPattern $requiredSections['Target Azure Deployment / Runtime View']
$inventorySection = Get-SectionContent -HeadingPattern $requiredSections['Target Diagram Inventory and Notation']

if ($null -ne $contextSection -and $contextSection -notmatch '(?s)```mermaid\s+.*?\bC4Context\b') {
    Add-ValidationError 'Section 2.1 must contain a Mermaid C4Context diagram.'
}
if ($null -ne $containerSection -and $containerSection -notmatch '(?s)```mermaid\s+.*?\bC4Container\b') {
    Add-ValidationError 'Section 2.2 must contain a Mermaid C4Container diagram.'
}
if ($null -ne $deploymentSection -and $deploymentSection -notmatch '(?s)```mermaid\s+.*?\b(flowchart|C4Deployment)\b') {
    Add-ValidationError 'Section 2.3 must contain a Mermaid flowchart or C4Deployment diagram.'
}

$interfaceSection = Get-SectionContent -HeadingPattern $requiredSections['Application-to-Application Interface Design']
# 5.2.1/5.2.2 are #### subsections keyed by the same flow IDs; exclude them from the 5.2 inventory.
if ($null -ne $interfaceSection) { $interfaceSection = [regex]::Split($interfaceSection, '(?m)^####\s')[0] }
$skuDeployabilitySection = Get-SectionContent -HeadingPattern $requiredSections['SKU / Tier Deployability Reconciliation']
$skuDeployabilityColumns = @(
    'Target Azure Service', 'Proposed SKU / Tier', 'CPF Module / Version',
    'CPF Mandatory Control / Setting', 'Applicable MEC / Security Constraint',
    'Resilience / Network Compatibility', 'Provisioning Path / Prerequisite',
    'Deployability Disposition', 'Conflict / Required Resolution', 'Traces / ADR / Risk'
)
if ($null -ne $skuDeployabilitySection) {
    $skuHeader = ([regex]::Match($skuDeployabilitySection, '(?m)^\|.*\|\s*$')).Value
    foreach ($column in $skuDeployabilityColumns) {
        if ($skuHeader -notmatch [regex]::Escape($column)) {
            Add-ValidationError "Section 3.1 is missing required column '$column'."
        }
    }
    $skuRows = @([regex]::Matches($skuDeployabilitySection, '(?m)^\|\s*(?!-)(?<service>[^|]+)\|(?<rest>.*)$'))
    if ($skuRows.Count -lt 2) {
        Add-ValidationError 'Section 3.1 must contain at least one SKU/tier deployability row.'
    }
    foreach ($skuRow in $skuRows) {
        $serviceName = $skuRow.Groups['service'].Value.Trim()
        if ($serviceName -eq 'Target Azure Service' -or $serviceName -match '^-+$') { continue }
        $cells = @($skuRow.Groups['rest'].Value.TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
        if ($cells.Count -lt 9) {
            Add-ValidationError "Section 3.1 row '$serviceName' does not contain all required fields."
            continue
        }
        foreach ($index in 0..8) {
            if (-not $cells[$index] -or $cells[$index] -match '^\{.*\}$') {
                Add-ValidationError "Section 3.1 row '$serviceName' has an unresolved required field."
                break
            }
        }
        $disposition = $cells[6]
        $resolution = $cells[7]
        if ($disposition -notmatch '^(?:Deployable|Conditional|Not deployable|Unknown)(?:\s+[—:-].*)?$') {
            Add-ValidationError "Section 3.1 row '$serviceName' has invalid deployability disposition '$disposition'."
        }
        if ($disposition -match '^(?:Conditional|Not deployable|Unknown)' -and $resolution -notmatch '\b(?:ADR|RSK)-\d{3,4}\b') {
            Add-ValidationError "Section 3.1 row '$serviceName' is $disposition and must link an ADR/risk in its conflict resolution."
        }
    }
}
$interfaceColumns = @(
    'Flow ID', 'Connection Type', 'Source Application', 'Source Component',
    'Destination Application', 'Destination Component', 'Direction',
    'Public / Private / On-Premises', 'Protocol', 'Port', 'Encryption',
    'Authentication / Authorization', 'Security Proxy / Gateway',
    'Purpose / Data Exchanged', 'Criticality / Frequency', 'Status', 'Evidence',
    'Traces to Req/NFR'
)
if ($null -ne $interfaceSection) {
    $header = ([regex]::Match($interfaceSection, '(?m)^\|.*\|\s*$')).Value
    foreach ($column in $interfaceColumns) {
        if ($header -notmatch [regex]::Escape($column)) {
            Add-ValidationError "Section 5.2 is missing required column '$column'."
        }
    }
}

$userSection = Get-SectionContent -HeadingPattern $requiredSections['End-User Connectivity Design']
$dataFootprintSection = Get-SectionContent -HeadingPattern $requiredSections['Data Footprint']
$profileFitnessSection = Get-SectionContent -HeadingPattern $requiredSections['Source Profile Fitness']
$toolchainSection = Get-SectionContent -HeadingPattern $requiredSections['Migration Toolchain Decision']
$rejectedToolsSection = Get-SectionContent -HeadingPattern $requiredSections['Rejected Migration Tool Candidates']
$toolConsequencesSection = Get-SectionContent -HeadingPattern $requiredSections['Migration Tool Consequences']
if ($null -eq $toolchainSection) { $toolchainSection = '' }

$dataSourceIds = @()
if ($null -ne $dataFootprintSection) {
    $dataSourceIds = @([regex]::Matches($dataFootprintSection, '(?m)^\|\s*(DATA-SRC-\d{3})\s*\|') | ForEach-Object { $_.Groups[1].Value })
    foreach ($duplicate in @($dataSourceIds | Group-Object | Where-Object { $_.Count -gt 1 })) {
        Add-ValidationError "Data Source ID '$($duplicate.Name)' occurs $($duplicate.Count) times in Section 6.1."
    }
    $dataSourceIds = @($dataSourceIds | Select-Object -Unique)
}

if ($TransitionProfilePath) {
    $transitionProfileContent = Get-Content -LiteralPath $TransitionProfilePath -Raw
    $requirementsDataSourceIds = @([regex]::Matches($transitionProfileContent, '(?m)^\|\s*(DATA-SRC-\d{3})\s*\|') | ForEach-Object { $_.Groups[1].Value } | Select-Object -Unique)
    foreach ($sourceId in $requirementsDataSourceIds) {
        if ($dataSourceIds -notcontains $sourceId) {
            Add-ValidationError "Requirements source profile '$sourceId' is missing from architecture Section 6.1."
        }
    }
    foreach ($sourceId in $dataSourceIds) {
        if ($requirementsDataSourceIds -notcontains $sourceId) {
            Add-ValidationError "Architecture data source '$sourceId' has no authoritative profile in migration-transition.md."
        }
    }
}

$toolchainColumns = @(
    'Data Source ID', 'Exact Source → Target Pair', 'Phase',
    'Microsoft Matrix Candidates / Cell / Reviewed Date',
    'Local ADR / Pattern / Tech-Selection Guidance', 'CPF / Approved Provisioning Path',
    'Hard Filters Applied', 'Selected Tool / Mode', 'Selection Evidence',
    'Status / Human Decision'
)
if ($null -ne $toolchainSection) {
    $toolchainHeader = ([regex]::Match($toolchainSection, '(?m)^\|.*\|\s*$')).Value
    foreach ($column in $toolchainColumns) {
        if ($toolchainHeader -notmatch [regex]::Escape($column)) {
            Add-ValidationError "Section 6.6 is missing required toolchain column '$column'."
        }
    }
}

$requiredToolPhases = @(
    'Discover/Inventory', 'Target/SKU Recommendation', 'App Data Access Assessment',
    'Database Assessment', 'Performance Assessment', 'Schema', 'Offline Data',
    'Online Data/CDC', 'Validation/Reconciliation', 'Postmigration Optimization'
)
foreach ($dataSourceId in $dataSourceIds) {
    foreach ($sectionCheck in @{
        '6.5 profile fitness' = $profileFitnessSection
        '6.6.1 rejected candidates' = $rejectedToolsSection
        '6.7 deployment consequences' = $toolConsequencesSection
    }.GetEnumerator()) {
        if ($null -eq $sectionCheck.Value -or $sectionCheck.Value -notmatch "\b$([regex]::Escape($dataSourceId))\b") {
            Add-ValidationError "$dataSourceId is missing from Section $($sectionCheck.Key)."
        }
    }

    $sourceToolRows = @([regex]::Matches($toolchainSection, "(?m)^\|\s*$([regex]::Escape($dataSourceId))\s*\|(?<rest>.*)$"))
    foreach ($phase in $requiredToolPhases) {
        $phaseRows = @($sourceToolRows | Where-Object {
            $cells = @($_.Groups['rest'].Value.TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
            $cells.Count -ge 9 -and $cells[1] -eq $phase
        })
        if ($phaseRows.Count -ne 1) {
            Add-ValidationError "$dataSourceId must have exactly one Section 6.6 row for phase '$phase' (found $($phaseRows.Count))."
        }
    }

    foreach ($toolRow in $sourceToolRows) {
        $cells = @($toolRow.Groups['rest'].Value.TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
        if ($cells.Count -lt 9) {
            Add-ValidationError "$dataSourceId has an incomplete Section 6.6 toolchain row."
            continue
        }
        $pair = $cells[0]
        $matrixEvidence = $cells[2]
        $localGuidance = $cells[3]
        $cpfPath = $cells[4]
        $hardFilters = $cells[5]
        $selectedTool = $cells[6]
        $selectionEvidence = $cells[7]
        $decisionStatus = $cells[8]
        if ($pair -notmatch '(?i)\bUNKNOWN\b|→|->') {
            Add-ValidationError "$dataSourceId phase '$($cells[1])' must state one exact source-to-target pair or UNKNOWN."
        }
        if ($matrixEvidence -notmatch '(?i)(?:learn\.microsoft\.com/.*/azure/dms/dms-tools-matrix.*(?:reviewed|updated)\s+\d{4}-\d{2}-\d{2}|N/A\s*[—-]\s*non-database)') {
            Add-ValidationError "$dataSourceId toolchain phase '$($cells[1])' must cite the Matrix URL plus a fresh ISO reviewed/updated date, or evidence-backed non-database N/A."
        }
        foreach ($requiredValue in @{
            'local guidance' = $localGuidance
            'CPF/provisioning path' = $cpfPath
            'hard filters' = $hardFilters
            'selected tool/mode' = $selectedTool
            'selection evidence' = $selectionEvidence
            'status/human decision' = $decisionStatus
        }.GetEnumerator()) {
            if (-not $requiredValue.Value) {
                Add-ValidationError "$dataSourceId phase '$($cells[1])' is missing $($requiredValue.Key)."
            }
        }
        if (($pair -match '(?i)\bUNKNOWN\b' -or $selectedTool -match '(?i)\bUNKNOWN\b' -or $matrixEvidence -match '(?i)blank|no exact row|no Microsoft recommendation') -and
            $decisionStatus -notmatch '\b(?:ADR|RSK)-\d{3,4}\b') {
            Add-ValidationError "$dataSourceId phase '$($cells[1])' has an unresolved pair/tool/matrix result and must link an ADR/risk."
        }
        if ($cpfPath -match '(?i)CPF\s+unavailable|no approved provisioning' -and
            $decisionStatus -notmatch '\b(?:ADR|RSK)-\d{3,4}\b') {
            Add-ValidationError "$dataSourceId phase '$($cells[1])' lacks an approved CPF/provisioning path and must link an ADR/risk."
        }
        if ($selectedTool -match '(?i)\b(Qlik|Striim|Cloudamize|Cloud Atlas|Ispirer|SharePlex|Ora2Pg|MyDumper|MyLoader|Imanis)\b' -and
            $localGuidance -notmatch '\b(?:LMP-PAT|LMP-ADR)-\d{4}\b' -and
            $decisionStatus -notmatch '\bADR-\d{3,4}\b') {
            Add-ValidationError "$dataSourceId phase '$($cells[1])' selects a third-party tool without published local guidance or a human ADR."
        }
        if (($selectedTool -match '(?i)Classic\s+DMS' -or $cpfPath -match 'cpf-azure-prdsvc-databasemigrationservice') -and
            $pair -notmatch '(?i)MySQL.*(?:Azure Database for MySQL|MySQL)') {
            Add-ValidationError "$dataSourceId selects Classic CPF DMS for non-clear-listed pair '$pair'."
        }
    }
}

$transitionSectionMatch = [regex]::Match($content, '(?ms)^##\s+7A\.\s+Migration Transition\s*&\s*Cutover Design\s*$\s*(?<body>.*?)(?=^##\s|\z)')
$transitionSection = if ($transitionSectionMatch.Success) { $transitionSectionMatch.Groups['body'].Value } else { $null }
if ($null -ne $transitionSection) {
    $transitionSubsections = @(
        '7A.1 Strategy, Migration Units and Waves',
        '7A.2 Client / Customer / User Migration',
        '7A.3 Application Cutover and Coexistence',
        '7A.4 Data Migration and Reconciliation',
        '7A.5 Rehearsal, Go/No-Go and Acceptance Gates',
        '7A.6 Rollback / Backout and Point of No Return',
        '7A.7 Hypercare, Operational Handoff and Decommission Prerequisites',
        '7A.8 Transition Sequence and State Model'
    )
    foreach ($subsection in $transitionSubsections) {
        if ($transitionSection -notmatch "(?m)^###\s+$([regex]::Escape($subsection))\s*$") {
            Add-ValidationError "Missing required transition subsection: $subsection."
        }
    }
    $transitionFieldChecks = [ordered]@{
        '7A.1 Strategy, Migration Units and Waves' = @('MIG-\d{3}', 'Migration Unit|Wave', 'Entry', 'Exit|Acceptance')
        '7A.2 Client / Customer / User Migration' = @('MIG-\d{3}', 'Population|Channel', 'Compatibility', 'Routing|Endpoint', 'Acceptance', 'Owner')
        '7A.3 Application Cutover and Coexistence' = @('MIG-\d{3}', 'Source Role', 'Target Role', 'Source-of-Truth', 'Read/Write', 'Exit')
        '7A.4 Data Migration and Reconciliation' = @('MIG-\d{3}', 'Source.*Target', 'Seed|Bulk', 'Delta|CDC', 'Freeze', 'Reconciliation', 'Tolerance', 'Rollback|Reverse')
        '7A.5 Rehearsal, Go/No-Go and Acceptance Gates' = @('MIG-\d{3}', 'Entry', 'Evidence|Threshold', 'Decision Authority', 'Abort|Escalation')
        '7A.6 Rollback / Backout and Point of No Return' = @('MIG-\d{3}', 'Trigger', 'Decision Authority', 'Maximum.*Time', 'Data.*Recovery', 'Point of No Return')
        '7A.7 Hypercare, Operational Handoff and Decommission Prerequisites' = @('MIG-\d{3}', 'Entry', 'Telemetry|Incident|Data-Quality', 'Owner', 'Exit|Acceptance', 'Retention|Legal Hold', 'Recovery Impact')
    }
    foreach ($check in $transitionFieldChecks.GetEnumerator()) {
        $subsectionMatch = [regex]::Match($transitionSection, "(?ms)^###\s+$([regex]::Escape($check.Key))\s*$\s*(?<body>.*?)(?=^###\s|\z)")
        if (-not $subsectionMatch.Success) { continue }
        foreach ($fieldPattern in $check.Value) {
            if ($subsectionMatch.Groups['body'].Value -notmatch $fieldPattern) {
                Add-ValidationError "Transition subsection '$($check.Key)' is missing required field/control '$fieldPattern'."
            }
        }
    }
    $dataTransitionMatch = [regex]::Match($transitionSection, '(?ms)^###\s+7A\.4\s+Data Migration and Reconciliation\s*$\s*(?<body>.*?)(?=^###\s|\z)')
    if ($dataTransitionMatch.Success) {
        foreach ($dataSourceId in $dataSourceIds) {
            if ($dataTransitionMatch.Groups['body'].Value -notmatch "\b$([regex]::Escape($dataSourceId))\b") {
                Add-ValidationError "$dataSourceId is missing from Section 7A.4 Data Migration and Reconciliation."
            }
        }
    }
    $migrationControlIds = @([regex]::Matches($transitionSection, '\bMIG-\d{3}\b') | ForEach-Object { $_.Value } | Select-Object -Unique)
    if ($migrationControlIds.Count -eq 0) {
        Add-ValidationError 'Section 7A must contain at least one concrete MIG-### control ID.'
    }
    if ($transitionSection -notmatch '(?s)```mermaid\s+.*?\b(?:stateDiagram-v2|flowchart)\b') {
        Add-ValidationError 'Section 7A.8 must contain a Mermaid transition state or flow diagram.'
    }
}
$tableFlowIds = [System.Collections.Generic.List[string]]::new()
foreach ($section in @($userSection, $interfaceSection)) {
    if ($null -eq $section) { continue }
    foreach ($match in [regex]::Matches($section, '(?m)^\|\s*(FLOW-(?:USER|APP)-\d{3})\s*\|')) {
        $tableFlowIds.Add($match.Groups[1].Value)
    }
}

$diagramAreaMatch = [regex]::Match($content, '(?ms)^##\s+2\.\s+C4 Diagrams\s*$\s*(?<body>.*?)(?=^##\s+3\.)')
$diagramArea = if ($diagramAreaMatch.Success) { $diagramAreaMatch.Groups['body'].Value } else { '' }
$diagramFlowIds = @([regex]::Matches($diagramArea, 'FLOW-(?:USER|APP)-\d{3}') | ForEach-Object { $_.Value } | Select-Object -Unique)
$tableUniqueFlowIds = @($tableFlowIds | Select-Object -Unique)

foreach ($flowId in $tableUniqueFlowIds) {
    if ($diagramFlowIds -notcontains $flowId) {
        Add-ValidationError "Connectivity row '$flowId' has no matching relationship in Section 2."
    }
}
foreach ($flowId in $diagramFlowIds) {
    if ($tableUniqueFlowIds -notcontains $flowId) {
        Add-ValidationError "Diagram relationship '$flowId' has no matching row in Section 5.1 or 5.2."
    }
}

$duplicateFlowIds = @($tableFlowIds | Group-Object | Where-Object { $_.Count -gt 1 })
foreach ($duplicate in $duplicateFlowIds) {
    Add-ValidationError "Connectivity flow ID '$($duplicate.Name)' occurs $($duplicate.Count) times; flow IDs must be unique."
}

foreach ($line in ($diagramArea -split "`r?`n")) {
    $isRelationship = $line -match '\bRel\s*\(' -or $line -match '(?:-->|-\.->)'
    if ($isRelationship -and $line -match 'FLOW-(?:USER|APP)-\d{3}' -and $line -notmatch '(?i)([A-Za-z][A-Za-z0-9+.-]*|UNKNOWN):(?:\d+|UNKNOWN)') {
        Add-ValidationError "Flow relationship is missing protocol:port (or UNKNOWN:UNKNOWN): $($line.Trim())"
    }
    if ($line -match '(?i)\b(Azure\s+[A-Za-z ]+|App\s+Service|AKS|Function(?:s| App)?|Cosmos\s+DB|SQL|PostgreSQL|Service\s+Bus|Event\s+Hubs?)\s+or\s+(Azure\s+)?[A-Za-z]') {
        Add-ValidationError "Diagram contains mutually exclusive service alternatives in one node/relationship: $($line.Trim())"
    }
}

$repoRoot = Get-RepoRoot
$sadContractPath = Join-Path $repoRoot 'deliverables-template/md-templates/sad-v3.4-contract.json'
$sadCoverageMapPath = Join-Path $repoRoot 'deliverables-template/md-templates/sad-v3.4-coverage-map.json'
if (-not (Test-Path -LiteralPath $sadContractPath -PathType Leaf) -or -not (Test-Path -LiteralPath $sadCoverageMapPath -PathType Leaf)) {
    Add-ValidationError 'SAD v3.4 contract is missing; architecture publication readiness cannot be validated.'
} else {
    $sadContract = Get-Content -LiteralPath $sadContractPath -Raw | ConvertFrom-Json
    $sadCoverageMap = Get-Content -LiteralPath $sadCoverageMapPath -Raw | ConvertFrom-Json
    foreach ($marker in $sadCoverageMap.requiredArchitectureMarkers) {
        if (-not $content.Contains([string]$marker)) { Add-ValidationError "Architecture is missing canonical SAD field marker: $marker" }
    }
    $canonicalTopLevels = @('Overview','Proposed Solution','Data View','Security View','End-to-End Operability','Total Cost of Ownership (TCO)','Cutover Methodology','Client Migration','Sustainability')
    $canonicalSadIds = @($sadContract.headings | Where-Object {
        $_.style -notmatch '(?i)toc|title' -and $_.headingPath.Count -gt 0 -and $_.headingPath[0] -in $canonicalTopLevels
    } | ForEach-Object { $_.id })
    $sadSectionMatch = [regex]::Match($content, '(?ms)^##\s+16\.\s+SAD v3\.4 Publication Readiness\s*$\s*(?<body>.*?)(?=^##\s|\z)')
    if (-not $sadSectionMatch.Success) {
        Add-ValidationError 'Missing required Section 16: SAD v3.4 Publication Readiness.'
    } else {
        $architectureSadIds = @([regex]::Matches($sadSectionMatch.Groups['body'].Value, '(?m)^\|\s*(SAD-BLOCK-\d{4})\s*\|') | ForEach-Object { $_.Groups[1].Value })
        foreach ($sadId in $canonicalSadIds) {
            $count = @($architectureSadIds | Where-Object { $_ -eq $sadId }).Count
            if ($count -ne 1) { Add-ValidationError "Canonical SAD item '$sadId' must occur exactly once in Section 16 (found $count)." }
        }
        foreach ($sadId in ($architectureSadIds | Select-Object -Unique)) {
            if ($canonicalSadIds -notcontains $sadId) { Add-ValidationError "Section 16 contains non-canonical SAD item '$sadId'." }
        }
    }
}

foreach ($section in @($inventorySection, $userSection, $interfaceSection)) {
    if ($null -eq $section) { continue }
    foreach ($line in ($section -split "`r?`n")) {
        if ($line -match '^\|' -and $line -match '\b(Proposed|Conditional|Unknown)\b' -and $line -notmatch '\b(ADR|RSK)-\d{3,4}\b') {
            $warnings.Add("Non-Confirmed target/flow row should link an ADR/risk: $($line.Trim())")
        }
    }
}

$backlogPlaybookPath = Join-Path $repoRoot 'docs/backlog-playbook/v1/Backlog-Playbook-v1.csv'
$planningDesignUserStoryCount = 0
if (-not (Test-Path -LiteralPath $backlogPlaybookPath -PathType Leaf)) {
    Add-ValidationError 'Backlog Playbook v1 CSV is missing; Section 15 Planning & Design coverage cannot be validated.'
} else {
    $backlogRows = Import-Csv -LiteralPath $backlogPlaybookPath
    $planningDesignUserStoryIds = @($backlogRows | Where-Object { $_.Phase -eq 'Planning & Design' -and $_.'Work Item Type' -eq 'User Story' } | ForEach-Object { $_.ID } | Select-Object -Unique)
    $planningDesignUserStoryCount = $planningDesignUserStoryIds.Count
    $section15Match = [regex]::Match($content, '(?ms)^##\s+15\.\s+Backlog Playbook Coverage Check\s*$\s*(?<body>.*?)(?=^##\s+16\.)')
    if (-not $section15Match.Success) {
        Add-ValidationError 'Missing required Section 15: Backlog Playbook Coverage Check.'
    } else {
        $section15Body = $section15Match.Groups['body'].Value
        $section151Match = [regex]::Match($section15Body, '(?ms)^###\s+15\.1\s+Planning\s*&\s*Design Coverage\s*$\s*(?<body>.*?)(?=^###\s+15\.2|\z)')
        if (-not $section151Match.Success) {
            Add-ValidationError 'Missing required Section 15.1: Planning & Design Coverage table (one row per Playbook User Story).'
        } else {
            $section151Ids = @([regex]::Matches($section151Match.Groups['body'].Value, '(?m)^\|[^|\r\n]*\|\s*(\d+)\s*\|') | ForEach-Object { $_.Groups[1].Value })
            foreach ($storyId in $planningDesignUserStoryIds) {
                $count = @($section151Ids | Where-Object { $_ -eq $storyId }).Count
                if ($count -ne 1) { Add-ValidationError "Backlog Playbook Planning & Design User Story '$storyId' must occur exactly once in Section 15.1 (found $count)." }
            }
            $nonCoveredRows = @([regex]::Matches($section151Match.Groups['body'].Value, '(?m)^\|.*\|\s*(?:Partial|No)\s*\|\s*$'))
            if ($nonCoveredRows.Count -gt 0 -and $section15Body -notmatch '(?m)^###\s+15\.2\s+Open Points') {
                Add-ValidationError 'Section 15.1 has Partial/No rows but Section 15.2 (Open Points & Topics) is missing.'
            }
        }
    }
}

if ($content -match '\{[^{}\r\n]+\}') {
    Add-ValidationError 'Architecture contains unresolved template placeholders.'
}

$result = @{
    architecturePath = [System.IO.Path]::GetFullPath($ArchitecturePath)
    valid = ($errors.Count -eq 0)
    errorCount = $errors.Count
    warningCount = $warnings.Count
    errors = @($errors)
    warnings = @($warnings)
    tableFlowCount = $tableUniqueFlowIds.Count
    diagramFlowCount = $diagramFlowIds.Count
    sadCoverageCount = if ($architectureSadIds) { @($architectureSadIds | Select-Object -Unique).Count } else { 0 }
    dataSourceCount = $dataSourceIds.Count
    planningDesignUserStoryCount = $planningDesignUserStoryCount
}

Write-ScriptResult -Data $result -Json:$Json
if ($errors.Count -gt 0) { exit 1 }
exit 0
