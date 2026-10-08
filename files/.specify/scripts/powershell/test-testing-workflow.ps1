#requires -Version 5.1
# Self-contained positive-path smoke test for testing profile, Test Plan, and testing task validators.
[CmdletBinding()]
param([switch]$Json, [string]$WorkspaceRoot = ([System.IO.Path]::GetTempPath()))

$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'common.ps1')

$tempRoot = Join-Path $WorkspaceRoot ("spec-layer-testing-workflow-" + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $tempRoot -Force | Out-Null
$requirementsDir = Join-Path $tempRoot 'requirements'
New-Item -ItemType Directory -Path $requirementsDir -Force | Out-Null

$types = @(
    @{ Name='Connectivity'; Baseline='Required'; Condition='All migrations'; Environment='PPE' },
    @{ Name='Unit'; Baseline='Conditional'; Condition='Continue existing automated suites; Migration Team implements or extends unit tests only for code changed during migration and impacted code'; Environment='CI build pipeline; DEV only when approved' },
    @{ Name='Data migration verification'; Baseline='Conditional'; Condition='Required when data moves'; Environment='Migration rehearsal' },
    @{ Name='Migration tool'; Baseline='Required'; Condition='All migrations'; Environment='Source test environment' },
    @{ Name='Application installation'; Baseline='Required'; Condition='All migrations'; Environment='PPE' },
    @{ Name='Smoke/regression'; Baseline='Required'; Condition='All migrations'; Environment='PPE' },
    @{ Name='Change-based functional'; Baseline='Conditional'; Condition='Integration scenarios for Re-Factor and Migration Team refactoring within Re-Host/Re-Platform; otherwise integration scenarios are mandatory UAT owned by Application Team'; Environment='PPE' },
    @{ Name='Full functional'; Baseline='Conditional'; Condition='Rearchitect'; Environment='PPE' },
    @{ Name='Performance and baseline'; Baseline='Required'; Condition='All migrations'; Environment='Production representative PPE' },
    @{ Name='High availability'; Baseline='Required'; Condition='All migrations'; Environment='Production representative PPE' },
    @{ Name='Disaster recovery'; Baseline='Required'; Condition='All migrations'; Environment='Production acceptance; lower environments rehearsal only' },
    @{ Name='Security testing'; Baseline='Required'; Condition='All migrations'; Environment='PPE' },
    @{ Name='Security penetration testing'; Baseline='Required'; Condition='All migrations'; Environment='Production' },
    @{ Name='Operational acceptance testing'; Baseline='Required'; Condition='All migrations'; Environment='Production' },
    @{ Name='User acceptance testing'; Baseline='Required'; Condition='All migrations no exemption; integration scenarios when no Migration Team refactoring occurs are owned and executed by Application Team'; Environment='PPE' }
)
$slugs = @('CONNECTIVITY','UNIT','DATA-MIGRATION','MIGRATION-TOOL','INSTALLATION','SMOKE-REGRESSION','CHANGE-FUNCTIONAL','FULL-FUNCTIONAL','PERFORMANCE','HA','DR','SECURITY','PENETRATION','OAT','UAT')
$oatIds = @()
foreach ($group in @(@{ prefix='GD'; count=24 }, @{ prefix='CHG'; count=9 }, @{ prefix='VAL'; count=18 })) {
    for ($number = 1; $number -le $group.count; $number++) { $oatIds += "L2-OAT-$($group.prefix)-$('{0:D2}' -f $number)" }
}
$oatArchitectureRows = foreach ($id in $oatIds) {
    "| $id | Fixture scenario | Recommended | As-is evidence: source baseline recorded | Proposed Azure target: evidenced service mapping | Objective: measurable operational threshold | Production actions: approved change CHG-123; bounded impact; communications; stop conditions; recovery readiness | Application Operations; runbook OAT-001; evidence result link; ADR-0001/RSK-001 |"
}
$oatPlanRows = foreach ($id in $oatIds) {
    "| $id | Fixture scenario | Recommended | As-is evidence: source baseline recorded | Proposed Azure target: evidenced service mapping | Verify observable operational result and measurable threshold; no fault injection | Production during Cutover; approved change CHG-123; bounded impact; communications; stop conditions; recovery readiness | Application Operations; runbook OAT-001; evidence result link; Planned |"
}

try {
    @('# NFR-001: Testing outcome','', '- ID: NFR-001','- Type: Non-Functional','- Status: Proposed','- Priority: Must','- Source: Test fixture','- Primary Layer(s): architecture-testing','','## Intent / Problem Addressed','','Prove testing workflow validation.','','## Requirement','','The migration shall satisfy the approved testing target.','','## Acceptance Criteria / Metric / Target','','All approved tests pass.','','## Verification','','Review test evidence.') | Set-Content -LiteralPath (Join-Path $requirementsDir 'NFR-001-testing-outcome.md') -Encoding UTF8

    $profileLines = @('# Migration Testing Requirements Profile: Fixture','','## Testing Requirements Profile','','| Test Type | Baseline Applicability | Disposition | R-Type / Scope Condition | Requirement IDs | Required Outcome / Measurable Target | Expected Environment | Evidence / Rationale | Execution Owner | Approval Owner | Linked ADR/Risk |','| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |')
    foreach ($type in $types) {
        $profileLines += "| $($type.Name) | $($type.Baseline) | Applicable | $($type.Condition) | NFR-001 | Approved measurable pass target | $($type.Environment) | Reviewed fixture evidence | Migration Team | Application Owner | N/A |"
    }
    $profileLines += @('','## Evidence Sources and Conflicts','','| Source ID | Artifact / Version / Date | Exact Locator | Claim / Scope | Evidence Class | Authority / Governing Rule | Access / Applicability / Freshness | Conflict / Action ID |','| --- | --- | --- | --- | --- | --- | --- | --- |','| SRC-001 | Fixture source repository v1.2 / 2026-10-06 | repo/tests @ abc123 | Test suite inventory for fixture behaviors | Sourced fact | Application Team repository; LMP strategy governs test requirements | Readable; fixture scope; current for regression | None |','| SRC-002 | Fixture CI run-123 / 2026-10-06 | CI report run-123 | Three cases passed; remaining cases unverified | Sourced fact | Run report governs only its recorded scope | Available; applicable to fixture; dated | None |','','| Conflict ID | Competing Claims and Source IDs / Locators | Affected Scope | Governing Rule (not assumed source precedence) | Decision Owner / Action ID | Status | Downstream Impact |','| --- | --- | --- | --- | --- | --- | --- |','| None identified | Compared SRC-001 and SRC-002 | Fixture test assets | LMP strategy remains governing | Fixture reviewer; N/A | Resolved with evidence | No conflicting scope/count claims |','','## Test Asset Inventory','','| Asset ID | Asset Type / Supplied Case IDs | Version / Locator / Owner | Reported Availability | Reuse Health | Coverage / Related Families | Latest Run / Result Evidence | Applicability / Compatibility | Validation Action ID |','| --- | --- | --- | --- | --- | --- | --- | --- | --- |','| AST-001 | Test repository / CASE-001 through CASE-015 | v1.2 repo/tests; Application Team | Verified-available | Adapt | 3 verified cases; remaining case families reviewed | 2026-10-06 CI run-123 passed | Fixture flows only; compatible with reviewed build | AUT-01 |','| AST-002 | Existing case catalog / supplied identifiers | version and locator requested; Application Team | Available-unverified | Undecided | Case count and flow coverage unknown | Not run | Applicability needs owner confirmation | AUT-02 |','','## Human Input and Decision Register','','| Action ID | Exact Question / Decision / Conflict to Resolve | Why Needed / Evidence Expected and Location | Contact / Accountable Coordinator | Needed By / Gate | Linked REQ/NFR / ADR / Risk / Flow / Asset | Blocking Impact | Status | Answer / Evidence / Validation |','| --- | --- | --- | --- | --- | --- | --- | --- | --- |')
    for ($index = 0; $index -lt $types.Count; $index++) {
        $actionId = "AUT-$('{0:D2}' -f ($index + 1))"
        $profileLines += "| $actionId | Confirmed partial coverage and uncovered scope for $($types[$index].Name) | Dated case inventory and CI evidence at SRC-002 / run-123 | Application Team contact: Fixture owner; coordinator: Migration Test coordinator | Scope review gate / date confirmed | NFR-001 RSK-001 | Residual cases are sized for review; no coverage inferred beyond run-123 | Validated | Application Team response 2026-10-06; SRC-002 run-123; coverage limited to three cases |"
    }
    $profileLines += @('','## Automation Availability Review','','| Review ID | Test Type | Automation Status | Evidence / Application Team Response | Verified Coverage / Uncovered Scope | Application Team Review Action ID / Contact / Owner / Needed By / Status | Requirement / ADR / Risk |','| --- | --- | --- | --- | --- | --- | --- |')
    for ($index = 0; $index -lt $types.Count; $index++) {
        $actionId = "AUT-$('{0:D2}' -f ($index + 1))"
        $profileLines += "| $actionId | $($types[$index].Name) | Partial | Application Team response 2026-10-06: repo/tests run-123 confirms partial coverage | 3 verified cases; remaining negative paths unverified | $actionId; Application Team contact: Fixture owner; owner: Migration Test coordinator; needed-by: scope review; status: Validated | NFR-001 RSK-001 |"
    }
    $profileLines += @('','## Test Readiness Inputs','','| Readiness Area | Status | Required Evidence / Outcome | Owner | Requirement / ADR / Risk |','| --- | --- | --- | --- | --- |')
    foreach ($area in @('Existing test plans cases scripts and results','Automation repositories and maintenance capacity','Performance baseline and volumetrics','Test environments and production comparability','Monitoring and evidence capture','Test data identities access and privacy controls','Defect thresholds triage and risk acceptance','Named test execution and deliverable approvers')) {
        $profileLines += "| $area | Ready | Reviewed evidence | Application Owner | NFR-001 |"
    }
    $profilePath = Join-Path $requirementsDir 'testing-profile.md'
    $profileLines | Set-Content -LiteralPath $profilePath -Encoding UTF8

    $architecturePath = Join-Path $tempRoot 'architecture.md'
    $architectureLines = @('# Architecture Fixture','','### 14.1 Migration Testability Matrix','','| Test Type | Requirements / Profile Disposition | Resolved Applicability / R-Type Basis | Owning Architecture Section(s) | Target Mechanism Under Test | Approved Environment / Production Comparability | Observability / Evidence Path | Data / Identity / Access Prerequisites | Readiness | ADR/Risk |','| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |')
    foreach ($type in $types) { $architectureLines += "| $($type.Name) | NFR-001 Applicable | Applicable — fixture basis | Section 12 | Approved mechanism | $($type.Environment) | Results repository | Approved prerequisites | Ready | N/A |" }
    $architectureLines += @('','### 14.2 OAT Scenario Applicability Matrix','','| Catalog ID | Scenario | Applicability | As-is evidence | Proposed Azure target and evidence | Operational objective / testability | Environment, safety, change | Owner, runbook, evidence, ADR/risk |','| --- | --- | --- | --- | --- | --- | --- | --- |')
    $architectureLines += $oatArchitectureRows
    $architectureLines += @('','### 14.3 High-Level Test Scenario Design','','| Scenario Reference | Test Type | REQ/NFR / Component / Flow Evidence | Family / Outcome / Environment / Data | Automation Status / Review ID / Reuse-Adapt-Build-Manual | Proposed Volume / Derivation / Confidence | Implementation / Execution / Maintenance / LMP Section-RACI |','| --- | --- | --- | --- | --- | --- | --- |')
    for ($index = 0; $index -lt $types.Count; $index++) {
        $architectureLines += "| SCN-$('{0:D2}' -f ($index + 1)) | $($types[$index].Name) | NFR-001 component inventory | Approved positive/negative family; pass threshold; $($types[$index].Environment); representative data | Partial AUT-$('{0:D2}' -f ($index + 1)); reuse verified cases; build uncovered cases after review | 1 family, 3-5 proposed cases from one evidenced component; Low confidence | Implementation: strategy owner; Execution: strategy owner; Maintenance: Application Team; LMP Section 4.1 and test-specific section; Appendix 5; review pending |"
    }
    $architectureLines += @('','### 14.4 Migration Impact-to-Test Crosswalk','','| Impact ID | Source Component / Store / Interface / Flow and Evidence Locator | Target Disposition (Retain / Change / Replace / Retire) | Data / State Movement Mechanism or Evidence-backed None | Impacted and Dependent Unchanged Behavior | REQ/NFR and Test Type / Section 14.3 Family or Supplied Case | Coverage Disposition (Covered / Proposed / Excluded / Pending) and Evidence | Owner / Action ID / Gate |','| --- | --- | --- | --- | --- | --- | --- | --- |')
    for ($index = 0; $index -lt $types.Count; $index++) {
        $targetDisposition = @('Retain','Change','Replace','Retire')[$index % 4]
        $coverageDisposition = if ($index -eq 0) { 'Covered — CI run-123 evidence' } else { 'Proposed — high-level family; execution pending' }
        $architectureLines += "| XWALK-$('{0:D3}' -f ($index + 1)) | Fixture component $($index + 1); source inventory SRC-001 | $targetDisposition — fixture target mapping | No state movement for this fixture flow; SRC-001 inventory and NFR-001 scope | Fixture behavior $($index + 1) and dependent unchanged fixture behavior; source flow inventory SRC-001 | NFR-001; $($types[$index].Name); SCN-$('{0:D2}' -f ($index + 1)) | $coverageDisposition | Migration Team; AUT-$('{0:D2}' -f ($index + 1)); scope review gate |"
    }
    $architectureLines | Set-Content -LiteralPath $architecturePath -Encoding UTF8
    $planPath = Join-Path $tempRoot 'plan.md'
    @('# Plan Fixture','','### Application Test Plan Handoff','','| Test Plan | Status |','| --- | --- |','| `G-test-plan.md` | Approved |') | Set-Content -LiteralPath $planPath -Encoding UTF8

    $testPlanLines = @('# G — Test Plan Fixture','','| Property | Value |','| --- | --- |','| **Status** | Approved |','','## Test Strategy','','### Test Types','','| Type | Applicability / R-Type Basis | Scope / Level | REQ/NFR/MIG Traces | Owner / Approver | Environment | Entry Criteria | Exit / Acceptance Criteria | When / Dependency | Results / Evidence | Exception ADR / Risk |','| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |')
    foreach ($type in $types) {
        $applicability = if ($type.Name -eq 'Unit') { 'Applicable — continue existing automated suites; Migration Team covers migration-changed impacted code' } else { 'Applicable — fixture basis' }
        $scope = if ($type.Name -eq 'Change-based functional') { 'Integration scenarios for Re-Factor and Migration Team refactoring within Re-Host/Re-Platform' } elseif ($type.Name -eq 'User acceptance testing') { 'Business and integration scenarios when Migration Team refactoring is not performed' } else { 'Approved scope' }
        $owner = if ($type.Name -eq 'User acceptance testing') { 'LSEG Application Team / Application Owner' } else { 'Migration Team / Application Owner' }
        $testPlanLines += "| $($type.Name) | $applicability | $scope | NFR-001 | $owner | $($type.Environment) | Entry ready | Pass target met | Scheduled dependency | Results repository | N/A |"
    }
    $testPlanLines += @('','### Scenario Scope and Automation Effort','','| Scope Reference | Test Type | Scenario References / Count Band / Basis | Verified Reuse / Uncovered Scope / Review Action | Reuse-Adapt-Build-Manual Decision | Effort Range (person-days): Review / Automation / Setup / Execution / Retest / Report-Handover | Implementation / Execution / Maintenance / LMP Section-RACI | Confidence / Assumptions / Backlog Trace |','| --- | --- | --- | --- | --- | --- | --- | --- |')
    for ($index = 0; $index -lt $types.Count; $index++) {
        $testPlanLines += "| SIZE-$('{0:D2}' -f ($index + 1)) | $($types[$index].Name) | SCN-$('{0:D2}' -f ($index + 1)); 3-5 proposed cases from component inventory | AUT-$('{0:D2}' -f ($index + 1)); partial run-123 coverage; uncovered negatives pending Application Team review | Reuse verified cases; build/adapt after scope review | Review: 1-2; Automation: 2-4; Setup: 1-2; Execution: 1-2; Retest: 1-2; Report: 1-2 person-days | Implementation: strategy owner; Execution: strategy owner; Maintenance: Application Team; LMP Section 4.1 and Appendix 5 | Low confidence; specialist capacity separate; backlog TEST-PREP |"
    }
    $testPlanLines += @('','### High-Level Case Outlines','','Preserve supplied case identifiers and source locators. These fixture outlines are not execution claims. OAT cases remain in the OAT catalog matrix.','','| Case ID | Origin (Supplied / Proposed) | Source Asset / Locator | Test Type / Family / REQ-NFR / Component or Flow | Objective / Preconditions / Data / High-Level Steps | Measurable Expected Outcome | Disposition (Covered / Adapt / Proposed / Excluded / Pending) and Evidence | Environment / Tool / Automation | Owner / Evidence Result Path / Action ID |','| --- | --- | --- | --- | --- | --- | --- | --- | --- |')
    for ($index = 0; $index -lt $types.Count; $index++) {
        $disposition = if ($index -eq 0) { 'Covered — CI run-123 verifies fixture subset' } else { 'Adapt — inventory-derived outline; not yet executed' }
        $testPlanLines += "| CASE-$('{0:D3}' -f ($index + 1)) | Supplied | AST-001 repo/tests v1.2; source CASE-$('{0:D3}' -f ($index + 1)) | $($types[$index].Name); SCN-$('{0:D2}' -f ($index + 1)); NFR-001; fixture component $($index + 1) | Verify evidenced fixture behavior; approved fixture data; invoke listed case and inspect assertion | The fixture-defined pass condition is met; threshold remains NFR-001 | $disposition | $($types[$index].Environment); fixture test runner; partial automation | Migration Team; planned results path; N/A |"
    }
    $testPlanLines += @('','### Estimated Elapsed Testing Timeline and Capacity','','Use capacity scenarios of 1, 2 and 3 active testers. Elapsed duration differs from person effort; estimates state verified automation, manual coverage, external approval waits, parallel work, critical path and contingency. Record an integrated window, not a sum of row durations. Optional pre-OAT is a lower-environment rehearsal, only after Migration Team and Application Team agree scenario IDs/count; it does not replace Production OAT.')
    $testPlanLines += @('| Test Type / Workstream | Applicability | Case-count and automation basis | Elapsed — 1 tester | Elapsed — 2 testers | Elapsed — 3 testers | Dependencies, overlap, wait time, confidence |','| --- | --- | --- | --- | --- | --- | --- |')
    foreach ($type in $types) {
        $duration = if ($type.Name -eq 'Operational acceptance testing') { '4 calendar weeks' } else { '1-2 weeks' }
        $testPlanLines += "| $($type.Name) | Applicable — fixture evidence | Verified cases and automation/manual split recorded; coverage basis documented | $duration | $duration | $duration | Dependencies, overlap, wait time, critical path and contingency; Low confidence |"
    }
    $testPlanLines += '| Optional pre-OAT lower-environment rehearsal | Optional — jointly agreed | Scenario IDs/count agreed by Migration Team and Application Team | 1-2 weeks after agreement | 1-2 weeks after agreement | 1 week after agreement | Lower environment; does not replace Production OAT |'
    $testPlanLines += @('','### Estimate Scope and Boundary Reconciliation','','Estimate boundaries are compared before durations are combined.','','| Estimate ID / Source | Estimate Kind / Value / Confidence | Start Boundary | End Boundary | Included Phases / Work | Excluded Phases / External Waits | Basis / Scope Version / Evidence | Comparison / Reconciliation / Action |','| --- | --- | --- | --- | --- | --- | --- | --- |','| EST-001 | Test execution phase; 2-4 elapsed weeks; Low confidence | Test entry readiness approved | Test results reviewed and handed over | Testing workstream; preparation through review | End-to-end migration phases, customer waits and unbooked external approvals | Fixture case inventory CASE-001 through CASE-015; scope v1; SRC-001 | Phase estimate is not an end-to-end estimate; compare only matching boundaries |','| EST-002 | End-to-end migration; 20 elapsed weeks; Medium confidence | Migration mobilization | Hypercare exit | Discovery through hypercare | Customer-specific external approvals | Schedule baseline v1; SRC-001 | Not directly comparable to EST-001; scope windows differ |')
    $testPlanLines += @('','### Optional Pre-OAT Scope — Lower Environment','','Optional lower-environment rehearsal in a lower environment; Migration Team and Application Team jointly agree the scenario IDs/count, entry/exit, owners and duration. This rehearsal does not satisfy Production OAT.')
    $testPlanLines += @('','### High Availability Test Design','','Use LMP strategy Section 7.2. Application Owner assessment based on the R-Type and the approved HA design. Approved uptime/SLA and RTO/RPO goals include redundancy/failover, scalability, and resource utilization. Scope and test cases have pass/fail criteria and background load. Production-comparable PPE, an approved SII, monitoring, and test data are ready. Execute in an isolated PPE window after entry criteria are met. Exit requires all cases passed, defects retested or risk accepted, and a signed Test Execution Results Report.')
    $testPlanLines += @('','### Disaster Recovery Test Design','','Use LMP strategy Section 7.3. Production acceptance by the L2 Team before customer cutover; Migration Team owns runbook creation and handover to L2. LSEG DR Coordinator and Technology Owner are named. Include dependency failover while the hosting environment remains in place. Production is configured with authentication/authorization, representative test data, selected tools, a trained team, and synchronized backups. Exit measures RTA against RTO and RPA against RPO, data integrity and accuracy, critical functionality, tested failback and normalization, defect retest or risk acceptance, results report, evidence, and sign-off.')
    $testPlanLines += @('','### Operational Acceptance Test Design','','Use `docs/testing-strategy/LSEG-L2-OAT-Game-Day-Scenario-Catalog.md` and approved Architecture Section 14.2; assess as-is evidence and the proposed Azure target separately. Application Operations executes/accepts OAT in Production during Cutover. Each planned production disruption requires an approved change, bounded impact, communications, stop conditions, and recovery readiness. Record the runbook and evidence; OAT does not replace HA, DR, or UAT.')
    $testPlanLines += @('| Catalog ID | Scenario | Disposition | As-is evidence | Proposed Azure target / applicability | Executable steps and expected outcome | Environment / change approval / stop-recovery | Operations owner / runbook / evidence / status |','| --- | --- | --- | --- | --- | --- | --- | --- |')
    $testPlanLines += $oatPlanRows
    $testPlanLines += @('','### Minimum Viable Testing','','| Applicability | Trigger / Evidence Gap | Mandatory Minimum Scope | Approval / Exception | Exit Evidence |','| --- | --- | --- | --- | --- |','| Not Applicable | Full test assets available | Full approved scope applies; UAT remains mandatory and is not waived | N/A — no scope reduction | Per-test execution reports |','','### Automation Strategy and Ownership','','| Scope / Repository | Existing Automation | Migration Change Impact | Build / Pipeline Execution | Framework / Tool Decision | Implementation Owner | Ongoing Maintenance Owner | MEC/GCF / Exception Evidence |','| --- | --- | --- | --- | --- | --- | --- | --- |','| Application | repo/tests version 1.2 | Impacted code | CI pipeline unit-test stage per merge request | pytest 8.4 | Migration Team | Application Team | GCF approved evidence |','','### RACI','','| Test Type / Activity | Migration Team | Migration Test Team | LSEG Application Team / Owner | LSEG L2 / Operations | LSEG Security | Named Deliverable Approver |','| --- | --- | --- | --- | --- | --- | --- |')
    foreach ($type in $types) { $testPlanLines += "| $($type.Name) | R | C | A | I | I | Jane Smith |" }
    $testPlanLines += @('','### Test Assets and Traceability','','Keep availability separate from reuse health.','','| Asset ID | Asset Type / Supplied Case IDs | Version / Locator / Owner | Availability (Reported-linked / Available-unverified / Verified-available / Unavailable / Unknown) | Reuse Health (Reuse / Adapt / Build / Manual / Excluded / Undecided) | Verified Coverage / Gaps / Families | Last Run / Result Locator | Compatibility / Applicability Evidence | Maintenance / Retention / Action ID |','| --- | --- | --- | --- | --- | --- | --- | --- | --- |','| AST-001 | Test repo / CASE-001 through CASE-015 | v1.2 repo/tests; Application Team | Verified-available | Adapt | 3 verified; remaining scope separately outlined | 2026-10-06 CI run-123 passed | Compatible fixture build and reviewed tests | Application Team; retain reports; AUT-01 |','| AST-002 | Case inventory | Unknown version/path; Application Team | Available-unverified | Undecided | Exact coverage unknown | Not run | Applicability confirmation pending | Application Team; retain response; AUT-02 |','','### Environment Strategy','','| Environment | Purpose |','| --- | --- |','| PPE | Testing |','','### Entry/Exit Criteria','','| Gate | Entry | Exit |','| --- | --- | --- |','| Testing | Ready | Passed |','','### Defect Management','','| Severity | Treatment |','| --- | --- |','| Critical | Blocks |','','### Exceptions, Dependencies and Approvals','','| Item | Outcome |','| --- | --- |','| None | Approved |','','### Test Plan Review and Approval','','| Required reviewer organization | Review focus | Named reviewer | Decision date | Outcome | Evidence / comments |','| --- | --- | --- | --- | --- | --- |','| Migration Team | Scope and schedule | Jane Smith | 2026-09-21 | Approved | Review record |','| Migration Testing Team | Cases and automation | John Jones | 2026-09-21 | Approved | Review record |','| Application Team | Business and data | Mary Brown | 2026-09-21 | Approved | Review record |','| L2 Operations | Runbooks and operations | Alex White | 2026-09-21 | Approved | Review record |','','## Test Plan Approval Gate','','**Reviewed by**: Jane Smith | **Date**: 2026-09-21 | **Outcome**: Approved')
    $testPlanPath = Join-Path $tempRoot 'G-test-plan.md'
    $testPlanLines | Set-Content -LiteralPath $testPlanPath -Encoding UTF8

    $taskLines = @('# Migration Tasks Fixture','','## Phase D — Testing Execution and Evidence','','Unit testing continues existing automated suites and limits additions to migration-changed impacted code.')
    for ($index = 0; $index -lt $slugs.Count; $index++) {
        foreach ($action in @('PREP','EXEC','REMEDIATE','EVIDENCE','APPROVAL')) {
            $taskLines += "- [ ] T$('{0:D3}' -f (100 + ($index * 5) + [array]::IndexOf(@('PREP','EXEC','REMEDIATE','EVIDENCE','APPROVAL'),$action))) [TEST-$($slugs[$index])-$action] Fixture task for $($types[$index].Name) — NFR-001"
        }
    }
    $tasksPath = Join-Path $tempRoot 'tasks.md'
    $taskLines | Set-Content -LiteralPath $tasksPath -Encoding UTF8

    $results = @()
    $negativeResults = @()

    $repoRoot = Get-RepoRoot
    $specTemplate = Get-Content -LiteralPath (Join-Path $repoRoot '.specify/templates/spec-template.md') -Raw
    $specPrompt = Get-Content -LiteralPath (Join-Path $repoRoot '.github/prompts/speckit.specify.prompt.md') -Raw
    $specBacklogSkill = Get-Content -LiteralPath (Join-Path $repoRoot '.github/skills/specify-backlog/SKILL.md') -Raw
    $specCoverageSkill = Get-Content -LiteralPath (Join-Path $repoRoot '.github/skills/specify-coverage/SKILL.md') -Raw
    $handoffMatch = [regex]::Match($specTemplate, '(?ms)^## 6\. Testing Evidence Handoff\s*$\s*(?<body>.*?)(?=^##\s|\z)')
    $specContractErrors = [System.Collections.Generic.List[string]]::new()
    if (-not $handoffMatch.Success) {
        $specContractErrors.Add('SPEC template is missing Section 6 Testing Evidence Handoff.')
    } else {
        $handoff = $handoffMatch.Groups['body'].Value
        foreach ($column in @('Test Type','Applicability / Condition and Evidence','REQ/NFR / IMP IDs and Repository Readiness','Architecture Crosswalk / Family References','Supplied or Proposed Case / Asset References','Shared Profile Action / Source Evidence','Selected Section 3 User Story Handoff','Preparation / Execution / Retest Handoff','Evidence, Approval Gate and Accountable Roles')) {
            if ($handoff -notmatch [regex]::Escape($column)) { $specContractErrors.Add("SPEC testing handoff is missing '$column'.") }
        }
        foreach ($type in $types) {
            $typeRowCount = [regex]::Matches($handoff, "(?m)^\|\s*$([regex]::Escape($type.Name))\s*\|").Count
            if ($typeRowCount -ne 1) { $specContractErrors.Add("SPEC testing handoff must contain exactly one '$($type.Name)' row; found $typeRowCount.") }
        }
        $normalizedHandoff = [regex]::Replace($handoff, '\s+', ' ')
        foreach ($rule in @('Full functional is conditional on Re-architect','UAT remains applicable for every R-Type','Do not add standalone Integration Testing','not a prerequisite')) {
            if ($normalizedHandoff -notmatch [regex]::Escape($rule)) { $specContractErrors.Add("SPEC testing handoff is missing rule '$rule'.") }
        }
    }
    foreach ($contract in @(
        @{ Text=$specPrompt; Pattern='`G-test-plan\.md` is produced during Planning & Design and is not a SPEC prerequisite'; Message='SPEC prompt must keep the Planning-stage Test Plan out of the initial SPEC prerequisites.' },
        @{ Text=$specPrompt; Pattern='Stop at Section 9 \(Review Checkpoint\)'; Message='SPEC prompt must stop at the pending human review checkpoint.' },
        @{ Text=$specBacklogSkill; Pattern='exact Section 3 work-item IDs'; Message='Backlog skill must preserve exact selected story handoff IDs.' },
        @{ Text=$specCoverageSkill; Pattern='without copying its action rows'; Message='Coverage skill must reference, not duplicate, shared profile actions.' }
    )) {
        if ($contract.Text -notmatch $contract.Pattern) { $specContractErrors.Add($contract.Message) }
    }
    $specHandoffPassed = ($specContractErrors.Count -eq 0)
    $results += @{ name='specTestingEvidenceHandoff'; passed=$specHandoffPassed; errors=@($specContractErrors) }
    if (-not $specHandoffPassed) { throw "SPEC testing evidence handoff contract failed: $($specContractErrors -join ' ')" }

    $requirementsOutput = & (Join-Path $PSScriptRoot 'validate-requirements-testing.ps1') -TestingProfilePath $profilePath -RequirementsDirectory $requirementsDir -Json 2>&1
    $results += @{ name='requirementsTesting'; passed=($LASTEXITCODE -eq 0); output=($requirementsOutput -join "`n") }
    if ($LASTEXITCODE -ne 0) { throw "requirementsTesting positive-path validation failed: $($requirementsOutput -join ' ')" }

    $testPlanOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
    $results += @{ name='testPlan'; passed=($LASTEXITCODE -eq 0); output=($testPlanOutput -join "`n") }
    if ($LASTEXITCODE -ne 0) { throw "testPlan positive-path validation failed: $($testPlanOutput -join ' ')" }

    $stageProfile = ($profileLines -join "`n").Replace('| None identified | Compared SRC-001 and SRC-002 | Fixture test assets | LMP strategy remains governing | Fixture reviewer; N/A | Resolved with evidence | No conflicting scope/count claims |', '| CON-001 | SRC-001 repo/tests reports 15 identifiers; SRC-002 run-123 verifies three | Fixture case inventory | LMP evidence rule; a run proves only executed cases | Fixture owner; ACT-001 | Open | Blocks case scope confirmation and execution baseline |')
    $stageProfile = $stageProfile.Replace('## Automation Availability Review', '| ACT-001 | Confirm the missing fixture behavior and expected assertion | Application Team answer and source behavior locator in requirements/testing-profile.md | Application Team contact: Fixture owner; coordinator: Migration Test coordinator | Test scope review gate; date pending | NFR-001 | Blocks case scope confirmation and execution baseline | Requested | Pending |' + "`n" + '## Automation Availability Review')
    $stagePlan = ($testPlanLines -join "`n").Replace('| **Status** | Approved |', '| **Status** | Draft |')
    $stagePlan = $stagePlan.Replace('Covered — CI run-123 verifies fixture subset', 'Pending — source behavior confirmation required')
    $stagePlan = $stagePlan.Replace('Migration Team; planned results path; N/A |', 'Migration Team; planned results path; ACT-001 |')
    $reviewBrief = @'
## Review Brief

**Purpose and maturity**: Review the fixture proposal, not an execution baseline.
**Proposed scope and exclusions**: Fixture families only; mandatory UAT retained.
**Evidence basis and confidence**: SRC-001 v1.2 and SRC-002 run-123; three verified cases, remaining scope proposed.
**Artifact quality versus input completeness**: Structurally reviewable; inputs remain unresolved.
**Next gate and version boundary**: Review fixture source v1; execution and exact-version human approvals remain blocked.

### Significant Conflicts

| Priority / Why Now | Canonical Reference | Current Status | Review Focus / Next Step |
| --- | --- | --- | --- |
| First — resolve inventory before sizing | [CON-001](requirements/testing-profile.md#evidence-sources-and-conflicts) | Open | Scope conflict; ACT-001 owns the next decision. |

### Priority Human Actions

| Priority / Why Now | Canonical Reference | Current Status | Review Focus / Next Step |
| --- | --- | --- | --- |
| First — acceptance and scope dependency | [ACT-001](requirements/testing-profile.md#human-input-and-decision-register) | Requested | Fixture owner and Migration Test coordinator; test scope review gate; answer the behavior question before execution. |

[Scope](#scenario-scope-and-automation-effort), [Cases](#high-level-case-outlines),
[Assets](#test-assets-and-traceability), [Estimates](#estimate-scope-and-boundary-reconciliation),
[Approval](#test-plan-approval-gate).

'@
    $stagePlan = $stagePlan.Replace('## Test Strategy', $reviewBrief + "`n## Test Strategy")
    Set-Content -LiteralPath $profilePath -Value $stageProfile -Encoding UTF8
    Set-Content -LiteralPath $testPlanPath -Value $stagePlan -Encoding UTF8
    $draftProfileOutput = & (Join-Path $PSScriptRoot 'validate-requirements-testing.ps1') -TestingProfilePath $profilePath -RequirementsDirectory $requirementsDir -ValidationStage Draft -Json 2>&1
    $draftProfileData = ($draftProfileOutput -join "`n") | ConvertFrom-Json
    $draftProfilePassed = ($LASTEXITCODE -eq 0 -and $draftProfileData.inputCompleteness.sources -eq 2 -and $draftProfileData.inputCompleteness.openConflicts -eq 1 -and $draftProfileData.inputCompleteness.openActions -eq 1)
    $results += @{ name='ownedUnknownInputsAcceptedForRequirementsDraft'; passed=$draftProfilePassed }
    if (-not $draftProfilePassed) { throw "Owned unknown inputs prevented a reviewable requirements draft: $($draftProfileOutput -join ' ')" }
    $draftStageOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -ValidationStage Draft -Json 2>&1
    $draftStageData = ($draftStageOutput -join "`n") | ConvertFrom-Json
    $draftStagePassed = ($LASTEXITCODE -eq 0 -and $draftStageData.validationStage -eq 'Draft' -and $draftStageData.planStatus -eq 'Draft' -and $draftStageData.inputCompleteness.unresolved -eq 1 -and $draftStageData.inputCompleteness.conflicting -eq 1)
    $results += @{ name='ownedUnknownCaseAcceptedForDraft'; passed=$draftStagePassed }
    if (-not $draftStagePassed) { throw "Owned unknown case was not accepted as a Draft with incompleteness reported: $($draftStageOutput -join ' ')" }
    $readyPlan = $stagePlan.Replace('| **Status** | Draft |', '| **Status** | Ready for Review |')
    Set-Content -LiteralPath $testPlanPath -Value $readyPlan -Encoding UTF8
    $reviewStageOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -ValidationStage ReadyForReview -Json 2>&1
    $reviewStageData = ($reviewStageOutput -join "`n") | ConvertFrom-Json
    $reviewStagePassed = ($LASTEXITCODE -eq 0 -and $reviewStageData.validationStage -eq 'ReadyForReview' -and $reviewStageData.planStatus -eq 'Ready for Review' -and $reviewStageData.inputCompleteness.unresolved -eq 1 -and $reviewStageData.inputCompleteness.conflicting -eq 1)
    $results += @{ name='ownedUnknownCaseAcceptedForReview'; passed=$reviewStagePassed }
    if (-not $reviewStagePassed) { throw "Owned unknown case was not reviewable without claiming completeness: $($reviewStageOutput -join ' ')" }
    $unresolvedEstimate = $stagePlan.Replace('Test entry readiness approved', 'Unknown pending Application Team confirmation').Replace('Phase estimate is not an end-to-end estimate; compare only matching boundaries', 'Scope comparison pending owner confirmation; ACT-001')
    Set-Content -LiteralPath $testPlanPath -Value $unresolvedEstimate -Encoding UTF8
    $draftEstimateOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -ValidationStage Draft -Json 2>&1
    $draftEstimateAccepted = ($LASTEXITCODE -eq 0)
    $results += @{ name='ownedEstimateBoundaryAcceptedForDraft'; passed=$draftEstimateAccepted }
    if (-not $draftEstimateAccepted) { throw "Owned unknown estimate boundary prevented a Draft: $($draftEstimateOutput -join ' ')" }
    $reviewEstimate = $unresolvedEstimate.Replace('| **Status** | Draft |', '| **Status** | Ready for Review |')
    Set-Content -LiteralPath $testPlanPath -Value $reviewEstimate -Encoding UTF8
    $reviewEstimateOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -ValidationStage ReadyForReview -Json 2>&1
    $reviewEstimateAccepted = ($LASTEXITCODE -eq 0)
    $results += @{ name='ownedEstimateBoundaryAcceptedForReview'; passed=$reviewEstimateAccepted }
    if (-not $reviewEstimateAccepted) { throw "Owned unknown estimate boundary prevented ReadyForReview: $($reviewEstimateOutput -join ' ')" }
    $executionEstimate = $unresolvedEstimate.Replace('| **Status** | Draft |', '| **Status** | Approved |')
    Set-Content -LiteralPath $testPlanPath -Value $executionEstimate -Encoding UTF8
    $executionEstimateOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -ValidationStage Execution -Json 2>&1
    $executionEstimateRejected = ($LASTEXITCODE -ne 0 -and ($executionEstimateOutput -join ' ') -match 'Estimate boundaries remain unresolved')
    $negativeResults += @{ name='unresolvedEstimateBoundaryBlockedFromExecution'; passed=$executionEstimateRejected }
    if (-not $executionEstimateRejected) { throw 'An unresolved estimate boundary entered the execution baseline.' }
    Set-Content -LiteralPath $testPlanPath -Value $readyPlan -Encoding UTF8
    $executionStageOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -ValidationStage Execution -Json 2>&1
    $executionStageRejected = ($LASTEXITCODE -ne 0 -and ($executionStageOutput -join ' ') -match "Case outline 'CASE-001' is still Proposed/Pending")
    $negativeResults += @{ name='unresolvedCaseBlockedFromExecution'; passed=$executionStageRejected }
    if (-not $executionStageRejected) { throw "Execution stage accepted a Pending case: $($executionStageOutput -join ' ')" }
    $strictDefaultOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
    $strictDefaultRejected = ($LASTEXITCODE -ne 0 -and ($strictDefaultOutput -join ' ') -match "status must be 'Approved' for validation stage 'Execution'")
    $negativeResults += @{ name='defaultValidationRemainsExecutionStrict'; passed=$strictDefaultRejected }
    if (-not $strictDefaultRejected) { throw 'Default Test Plan validation no longer enforces the existing strict execution gate.' }
    foreach ($stage in @('Draft','ReadyForReview','Execution')) {
        $approvedPendingPlan = $stagePlan.Replace('| **Status** | Draft |', '| **Status** | Approved |')
        $approvedPendingPlan = $approvedPendingPlan.Replace('| Migration Testing Team | Cases and automation | John Jones | 2026-09-21 | Approved | Review record |', '| Migration Testing Team | Cases and automation | John Jones | Pending | Pending | Pending |')
        Set-Content -LiteralPath $testPlanPath -Value $approvedPendingPlan -Encoding UTF8
        $approvedPendingOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -ValidationStage $stage -Json 2>&1
        $approvedPendingRejected = ($LASTEXITCODE -ne 0 -and ($approvedPendingOutput -join ' ') -match "cannot be Approved until 'Migration Testing Team'")
        if ($stage -ne 'Execution') { $approvedPendingRejected = $approvedPendingRejected -and ($approvedPendingOutput -join ' ') -match 'status must be' }
        $negativeResults += @{ name="approvedStatusCannotBypass${stage}"; passed=$approvedPendingRejected }
        if (-not $approvedPendingRejected) { throw "An Approved Test Plan bypassed the $stage status gate." }
    }
    Set-Content -LiteralPath $testPlanPath -Value $stagePlan -Encoding UTF8
    $unsupportedVerifiedAsset = $stagePlan.Replace('| AST-002 | Case inventory | Unknown version/path; Application Team | Available-unverified |', '| AST-002 | Case inventory | Unknown version/path; Application Team | Verified-available |')
    Set-Content -LiteralPath $testPlanPath -Value $unsupportedVerifiedAsset -Encoding UTF8
    $unsupportedVerifiedOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -ValidationStage Draft -Json 2>&1
    $unsupportedVerifiedRejected = ($LASTEXITCODE -ne 0 -and ($unsupportedVerifiedOutput -join ' ') -match "cannot be Verified-available")
    $negativeResults += @{ name='unverifiedAssetCannotBeClaimedVerified'; passed=$unsupportedVerifiedRejected }
    if (-not $unsupportedVerifiedRejected) { throw 'An asset without a compatible dated run was accepted as verified in Draft.' }
    $caseWithoutOutcome = ($testPlanLines -join "`n").Replace('The fixture-defined pass condition is met; threshold remains NFR-001', 'Unknown')
    Set-Content -LiteralPath $testPlanPath -Value $caseWithoutOutcome -Encoding UTF8
    $caseOutcomeOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -ValidationStage Draft -Json 2>&1
    $caseOutcomeRejected = ($LASTEXITCODE -ne 0 -and ($caseOutcomeOutput -join ' ') -match "requires a substantive measurable expected outcome")
    $negativeResults += @{ name='coveredCaseRequiresMeasurableOutcome'; passed=$caseOutcomeRejected }
    if (-not $caseOutcomeRejected) { throw 'A covered case without a measurable expected outcome was accepted.' }
    $ownedProfile = $stageProfile.Replace('## Automation Availability Review', '| ACT-002 | Confirm approver appointments and environment prerequisites for fixture | Appointment roster and environment/access evidence at SRC-001 | Application Owner contact; Migration Test coordinator | Execution baseline gate | NFR-001 RSK-001 | Named approval and environment execution readiness | Requested | Pending |' + "`n" + '## Automation Availability Review')
    $ownedProfile = [regex]::Replace($ownedProfile, '(?m)^(\|\s*AUT-\d+\s*\|.*)\| Validated \| Application Team response.*$', '$1| Requested | Pending |')
    $ownedProfile = $ownedProfile.Replace('| Partial | Application Team response 2026-10-06: repo/tests run-123 confirms partial coverage |', '| Unknown | Pending current Application Team automation evidence |')
    $ownedProfile = $ownedProfile.Replace('status: Validated', 'status: Requested')
    $ownedArchitecture = ($architectureLines -join "`n").Replace('| Ready | N/A |', '| Conditional | RSK-001 |')
    $ownedPlan = $stagePlan.Replace('| Jane Smith |', '| Pending Application Owner |')
    $ownedPlan = $ownedPlan.Replace('| 2026-09-21 | Approved | Review record |', '| Pending | Pending | Pending |')
    $ownedPlan = $ownedPlan.Replace('| Not Applicable | Full test assets available | Full approved scope applies; UAT remains mandatory and is not waived | N/A — no scope reduction | Per-test execution reports |', '| Proposed | Asset inventory confirmation pending; ACT-001 | Application installation; Connectivity; Data migration verification; UAT remains mandatory and is not waived | Proposed ADR-0001 RSK-001; ACT-001 | Per-test execution reports before acceptance |')
    Set-Content -LiteralPath $profilePath -Value $ownedProfile -Encoding UTF8
    Set-Content -LiteralPath $architecturePath -Value $ownedArchitecture -Encoding UTF8
    foreach ($stage in @('Draft','ReadyForReview','Execution')) {
        $status = switch ($stage) { 'Draft' { 'Draft' }; 'ReadyForReview' { 'Ready for Review' }; 'Execution' { 'Approved' } }
        Set-Content -LiteralPath $testPlanPath -Value $ownedPlan.Replace('| **Status** | Draft |', "| **Status** | $status |") -Encoding UTF8
        $output = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -ValidationStage $stage -Json 2>&1
        $data = ($output -join "`n") | ConvertFrom-Json
        if ($stage -eq 'Execution') {
            $passed = $LASTEXITCODE -ne 0 -and ($data.errors -join ' ') -match 'architecture readiness Ready' -and ($data.errors -join ' ') -match 'authorized human deliverable approver'
            $negativeResults += @{ name='ownedReadinessAndAppointmentsStillBlockExecution'; passed=$passed }
        } else {
            $passed = $LASTEXITCODE -eq 0 -and $data.deferredExecutionRequirements.architectureReadiness.Count -eq 15 -and $data.deferredExecutionRequirements.namedApprovers.Count -eq 15
            $results += @{ name="ownedConditionalReadinessAndPendingAppointmentsAcceptedFor${stage}"; passed=$passed }
        }
        if (-not $passed) { throw "Stage-specific owned dependency regression failed for ${stage}: $($output -join ' ')" }
    }
    foreach ($mutation in @(
        @{ name='missingDependencyOwnerRejected'; Profile=$ownedProfile.Replace('Application Owner contact; Migration Test coordinator', 'Unknown'); Plan=$ownedPlan; Architecture=$ownedArchitecture; Pattern='contact/coordinator' },
        @{ name='missingNeededByGateRejected'; Profile=$ownedProfile.Replace('Execution baseline gate | NFR-001 RSK-001', 'Pending | NFR-001 RSK-001'); Plan=$ownedPlan; Architecture=$ownedArchitecture; Pattern='needed-by gate' },
        @{ name='unownedConditionalReadinessRejected'; Profile=($profileLines -join "`n"); Plan=$stagePlan; Architecture=$ownedArchitecture; Pattern='unresolved readiness requires' },
        @{ name='unownedPendingApproverRejected'; Profile=$stageProfile; Plan=$ownedPlan; Architecture=($architectureLines -join "`n"); Pattern='owned appointment action' },
        @{ name='briefMissingActionRejected'; Profile=$ownedProfile; Plan=$ownedPlan.Replace('[ACT-001]', '[ACT-999]'); Architecture=$ownedArchitecture; Pattern='missing or unowned canonical record' },
        @{ name='briefMissingConflictRejected'; Profile=$ownedProfile; Plan=$ownedPlan.Replace('[CON-001]', '[CON-999]'); Architecture=$ownedArchitecture; Pattern='missing or unowned canonical record' },
        @{ name='briefClosedClaimRejected'; Profile=$ownedProfile; Plan=$ownedPlan.Replace('| Requested | Fixture owner', '| Closed | Fixture owner'); Architecture=$ownedArchitecture; Pattern='contradicts the canonical register' },
        @{ name='briefResolvedConflictClaimRejected'; Profile=$ownedProfile; Plan=$ownedPlan.Replace('| Open | Scope conflict', '| Resolved with evidence | Scope conflict'); Architecture=$ownedArchitecture; Pattern='contradicts the canonical register' },
        @{ name='invalidReadinessRejectedInDraft'; Profile=$ownedProfile; Plan=$ownedPlan; Architecture=$ownedArchitecture.Replace('| Conditional |', '| Unknown |'); Pattern='invalid readiness' }
        @{ name='conditionalReadinessWithoutRiskRejected'; Profile=$ownedProfile; Plan=$ownedPlan; Architecture=$ownedArchitecture.Replace('| Conditional | RSK-001 |', '| Conditional | N/A |'); Pattern='unresolved readiness requires' }
        @{ name='unsupportedClosedActionRejected'; Profile=$ownedProfile.Replace('| Requested | Pending |', '| Closed | Pending |'); Plan=$ownedPlan; Architecture=$ownedArchitecture; Pattern='cannot be Validated/Closed' }
        @{ name='unownedUnknownAutomationRejected'; Profile=([regex]::Replace($ownedProfile, '(?m)^\| AUT-01 \| Confirmed partial coverage.*\r?\n?', '')); Plan=$ownedPlan; Architecture=$ownedArchitecture; Pattern="automation review 'AUT-01'.*owned profile action" }
        @{ name='unsupportedVerifiedAutomationRejected'; Profile=$ownedProfile.Replace('| Unknown | Pending current Application Team automation evidence |', '| Verified | Pending current Application Team automation evidence |'); Plan=$ownedPlan; Architecture=$ownedArchitecture; Pattern='cannot be Verified without dated run/result evidence' }
        @{ name='briefBlankScopeRejected'; Profile=$ownedProfile; Plan=$ownedPlan.Replace('**Proposed scope and exclusions**: Fixture families only; mandatory UAT retained.', '**Proposed scope and exclusions**:'); Architecture=$ownedArchitecture; Pattern="Review Brief requires 'Proposed scope and exclusions'" }
        @{ name='briefWrongRegisterAnchorRejected'; Profile=$ownedProfile; Plan=$ownedPlan.Replace('testing-profile.md#human-input-and-decision-register', 'testing-profile.md#wrong-register'); Architecture=$ownedArchitecture; Pattern='must link one canonical register record' }
        @{ name='briefOverloadedPrioritiesRejected'; Profile=$ownedProfile; Plan=$ownedPlan.Replace('| First — acceptance and scope dependency | [ACT-001](requirements/testing-profile.md#human-input-and-decision-register) | Requested | Fixture owner and Migration Test coordinator; test scope review gate; answer the behavior question before execution. |', ((1..6 | ForEach-Object { '| First — dependency | [ACT-001](requirements/testing-profile.md#human-input-and-decision-register) | Requested | Resolve acceptance before execution. |' }) -join "`n")); Architecture=$ownedArchitecture; Pattern='at most five items' }
    )) {
        Set-Content -LiteralPath $profilePath -Value $mutation.Profile -Encoding UTF8
        Set-Content -LiteralPath $testPlanPath -Value $mutation.Plan -Encoding UTF8
        Set-Content -LiteralPath $architecturePath -Value $mutation.Architecture -Encoding UTF8
        $output = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -ValidationStage Draft -Json 2>&1
        $passed = $LASTEXITCODE -ne 0 -and ($output -join ' ') -match $mutation.Pattern
        $negativeResults += @{ name=$mutation.name; passed=$passed }
        if (-not $passed) { throw "Regression '$($mutation.name)' failed: $($output -join ' ')" }
    }
    Set-Content -LiteralPath $profilePath -Value ($profileLines -join "`n") -Encoding UTF8
    Set-Content -LiteralPath $architecturePath -Value ($architectureLines -join "`n") -Encoding UTF8
    Set-Content -LiteralPath $testPlanPath -Value (($testPlanLines -join "`n").Replace('| Jane Smith |', '| Pending Jane Smith |')) -Encoding UTF8
    $output = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -ValidationStage Execution -Json 2>&1
    $passed = $LASTEXITCODE -ne 0 -and ($output -join ' ') -match 'authorized human deliverable approver'
    $negativeResults += @{ name='pendingPersonIsNotExecutionAppointment'; passed=$passed }
    if (-not $passed) { throw 'A pending named contact was treated as an execution approver appointment.' }
    Set-Content -LiteralPath $profilePath -Value $stageProfile -Encoding UTF8
    Set-Content -LiteralPath $architecturePath -Value ($architectureLines -join "`n") -Encoding UTF8
    $legacyPlan = ($testPlanLines -join "`n").Replace('| **Status** | Approved |', '| **Status** | Draft |')
    Set-Content -LiteralPath $testPlanPath -Value $legacyPlan -Encoding UTF8
    $output = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -ValidationStage Draft -Json 2>&1
    $data = ($output -join "`n") | ConvertFrom-Json
    $passed = $LASTEXITCODE -eq 0 -and ($data.warnings -join ' ') -match 'missing Review Brief'
    $results += @{ name='legacyDraftMissingBriefWarns'; passed=$passed }
    if (-not $passed) { throw 'Legacy Draft without Review Brief was not accepted with a migration warning.' }
    Set-Content -LiteralPath $testPlanPath -Value $legacyPlan.Replace('| **Status** | Draft |', '| **Status** | Ready for Review |') -Encoding UTF8
    $output = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -ValidationStage ReadyForReview -Json 2>&1
    $passed = $LASTEXITCODE -ne 0 -and ($output -join ' ') -match 'requires a concise Review Brief'
    $negativeResults += @{ name='reviewHandoffRequiresBrief'; passed=$passed }
    if (-not $passed) { throw 'ReadyForReview accepted a missing Review Brief.' }
    Set-Content -LiteralPath $testPlanPath -Value $stagePlan.Replace('| First — resolve inventory before sizing | [CON-001](requirements/testing-profile.md#evidence-sources-and-conflicts) | Open | Scope conflict; ACT-001 owns the next decision. |', 'None — no significant conflict requiring this review; full register remains linked.') -Encoding UTF8
    $output = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -ValidationStage Draft -Json 2>&1
    $passed = $LASTEXITCODE -eq 0
    $results += @{ name='briefEmptyPriorityListWithRationaleAccepted'; passed=$passed }
    if (-not $passed) { throw "An explicit empty priority list was rejected: $($output -join ' ')" }
    Set-Content -LiteralPath $profilePath -Value ($profileLines -join "`n") -Encoding UTF8
    Set-Content -LiteralPath $testPlanPath -Value ($testPlanLines -join "`n") -Encoding UTF8

    $tasksOutput = & (Join-Path $PSScriptRoot 'validate-testing-tasks.ps1') -TasksPath $tasksPath -TestingProfilePath $profilePath -TestPlanPath $testPlanPath -Json 2>&1
    $results += @{ name='testingTasks'; passed=($LASTEXITCODE -eq 0); output=($tasksOutput -join "`n") }
    if ($LASTEXITCODE -ne 0) { throw "testingTasks positive-path validation failed: $($tasksOutput -join ' ')" }

    $positiveProfile = Get-Content -LiteralPath $profilePath -Raw
    $positiveArchitecture = Get-Content -LiteralPath $architecturePath -Raw
    $positiveTestPlan = Get-Content -LiteralPath $testPlanPath -Raw
    $notApplicableProfile = $positiveProfile.Replace('| Full functional | Conditional | Applicable |', '| Full functional | Conditional | Not Applicable |')
    $notApplicableArchitecture = $positiveArchitecture.Replace('| Full functional | NFR-001 Applicable | Applicable — fixture basis |', '| Full functional | NFR-001 Not Applicable | Not Applicable — fixture is not Rearchitect |')
    $notApplicableTestPlan = $positiveTestPlan.Replace('| Full functional | Applicable — fixture basis |', '| Full functional | Not Applicable — fixture is not Rearchitect |').Replace('| Full functional | R | C | A | I | I | Jane Smith |', '| Full functional | N/A | N/A | N/A | N/A | N/A | N/A — not Rearchitect |')
    Set-Content -LiteralPath $profilePath -Value $notApplicableProfile -Encoding UTF8
    Set-Content -LiteralPath $architecturePath -Value $notApplicableArchitecture -Encoding UTF8
    Set-Content -LiteralPath $testPlanPath -Value $notApplicableTestPlan -Encoding UTF8
    $notApplicableOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
    $results += @{ name='notApplicableRaci'; passed=($LASTEXITCODE -eq 0); output=($notApplicableOutput -join "`n") }
    if ($LASTEXITCODE -ne 0) { throw "Valid Not Applicable RACI was rejected: $($notApplicableOutput -join ' ')" }
    Set-Content -LiteralPath $profilePath -Value $positiveProfile -Encoding UTF8
    Set-Content -LiteralPath $architecturePath -Value $positiveArchitecture -Encoding UTF8
    Set-Content -LiteralPath $testPlanPath -Value $positiveTestPlan -Encoding UTF8

    $testPlanOriginal = Get-Content -LiteralPath $testPlanPath -Raw
    foreach ($status in @('Unknown','None','Verified')) {
        $statusProfile = $positiveProfile.Replace('| Connectivity | Partial | Application Team response 2026-10-06: repo/tests run-123 confirms partial coverage |', "| Connectivity | $status | Application Team response 2026-10-06: fixture evidence for $status |")
        if ($status -eq 'Unknown') { $statusProfile = $statusProfile.Replace('Application Team response 2026-10-06: fixture evidence for Unknown', 'Pending Application Team response; no referenced assets found') }
        if ($status -eq 'Verified') { $statusProfile = $statusProfile.Replace('Application Team response 2026-10-06: fixture evidence for Verified', 'Application Team response 2026-10-06: CI run-123 confirms verified coverage') }
        Set-Content -LiteralPath $profilePath -Value $statusProfile -Encoding UTF8
        $statusOutput = & (Join-Path $PSScriptRoot 'validate-requirements-testing.ps1') -TestingProfilePath $profilePath -RequirementsDirectory $requirementsDir -Json 2>&1
        $results += @{ name="automation${status}Accepted"; passed=($LASTEXITCODE -eq 0) }
        if ($LASTEXITCODE -ne 0) { throw "Automation $status with required evidence/action rejected: $($statusOutput -join ' ')" }
    }
    Set-Content -LiteralPath $profilePath -Value $positiveProfile -Encoding UTF8
    $reviewMutations = @(
        @{ name='missingPerTypeAutomationReviewRejected'; content=([regex]::Replace($positiveProfile, '(?m)^\| AUT-01 \| Connectivity \|.*\r?\n', '')); expected="Automation review must contain exactly one 'Connectivity' entry" },
        @{ name='missingApplicationTeamAutomationActionRejected'; content=$positiveProfile.Replace('AUT-01; Application Team contact: Fixture owner; owner: Migration Test coordinator; needed-by: scope review; status: Validated', 'No review scheduled'); expected='requires an Application Team action' },
        @{ name='unconfirmedAbsentAutomationRejected'; content=$positiveProfile.Replace('| Connectivity | Partial | Application Team response 2026-10-06: repo/tests run-123 confirms partial coverage |', '| Connectivity | None | No files discovered |'); expected='requires dated response/run evidence' },
        @{ name='automationGapWithoutRiskRejected'; content=$positiveProfile.Replace('| NFR-001 RSK-001 |', '| NFR-001 |'); expected='gap must trace a requirement and ADR/risk' },
        @{ name='verifiedAutomationWithoutRunEvidenceRejected'; content=$positiveProfile.Replace('| Connectivity | Partial | Application Team response 2026-10-06: repo/tests run-123 confirms partial coverage |', '| Connectivity | Verified | Application Team response 2026-10-06: framework files are present |'); expected="cannot claim Verified without dated run/result evidence" }
    )
    foreach ($mutation in $reviewMutations) {
        Set-Content -LiteralPath $profilePath -Value $mutation.content -Encoding UTF8
        $mutationOutput = & (Join-Path $PSScriptRoot 'validate-requirements-testing.ps1') -TestingProfilePath $profilePath -RequirementsDirectory $requirementsDir -Json 2>&1
        $rejected = $LASTEXITCODE -ne 0 -and ($mutationOutput -join ' ') -match [regex]::Escape($mutation.expected)
        $negativeResults += @{ name=$mutation.name; passed=$rejected }
        if (-not $rejected) { throw "Automation regression failed: $($mutation.name): $($mutationOutput -join ' ')" }
    }
    Set-Content -LiteralPath $profilePath -Value $positiveProfile -Encoding UTF8

    $scenarioMutations = @(
        @{ name='missingHighLevelScenarioRejected'; content=([regex]::Replace($positiveArchitecture, '(?m)^\| SCN-02 \| Unit \|.*\r?\n', '')); profileContent=([regex]::Replace($positiveProfile, '(?m)^\| AUT-02 \| Confirmed partial coverage.*\r?\n', '')); expected="Section 14.3 'Unit' needs an evidenced scenario family or its owned Application Team action" },
        @{ name='scenarioAutomationReviewDriftRejected'; content=$positiveArchitecture.Replace('Partial AUT-02;', 'None AUT-99;'); expected="Section 14.3 'Unit' must trace its automation review ID and status" },
        @{ name='scenarioOwnershipWithoutStrategyRejected'; content=$positiveArchitecture.Replace('LMP Section 4.1 and test-specific section; Appendix 5', 'Assumed assignment'); expected='must separate implementation/execution/maintenance and cite the LMP section/Appendix 5' }
    )
    $scenarioPositiveOutput = & (Join-Path $PSScriptRoot 'validate-architecture.ps1') -ArchitecturePath $architecturePath -TestingProfilePath $profilePath -Json 2>&1
    if (($scenarioPositiveOutput -join ' ') -match 'Section 14\.3|High-Level Test Scenario Design') { throw "Complete scenario fixture rejected: $($scenarioPositiveOutput -join ' ')" }
    $results += @{ name='highLevelScenarioDesignAccepted'; passed=$true }
    foreach ($mutation in $scenarioMutations) {
        Set-Content -LiteralPath $architecturePath -Value $mutation.content -Encoding UTF8
        if ($mutation.ContainsKey('profileContent')) { Set-Content -LiteralPath $profilePath -Value $mutation.profileContent -Encoding UTF8 }
        $mutationOutput = & (Join-Path $PSScriptRoot 'validate-architecture.ps1') -ArchitecturePath $architecturePath -TestingProfilePath $profilePath -Json 2>&1
        $rejected = $LASTEXITCODE -ne 0 -and ($mutationOutput -join ' ') -match [regex]::Escape($mutation.expected)
        $negativeResults += @{ name=$mutation.name; passed=$rejected }
        if (-not $rejected) { throw "Scenario regression failed: $($mutation.name): $($mutationOutput -join ' ')" }
        Set-Content -LiteralPath $profilePath -Value $positiveProfile -Encoding UTF8
    }
    Set-Content -LiteralPath $architecturePath -Value $positiveArchitecture -Encoding UTF8
    $sizingMutations = @(
        @{ name='missingPerTypeSizingRejected'; content=([regex]::Replace($testPlanOriginal, '(?m)^\| SIZE-09 \| Performance and baseline \|.*\r?\n', '')); expected="Test Plan requires scenario/automation effort for 'Performance and baseline'" },
        @{ name='missingAutomationBuildEffortRejected'; content=$testPlanOriginal.Replace('Automation: 2-4;', 'Automation: Pending;'); expected='requires a numeric person-day range for Automation' },
        @{ name='sizingScenarioTraceDriftRejected'; content=$testPlanOriginal.Replace('| SCN-02; 3-5 proposed', '| SCN-99; 3-5 proposed'); expected="Test Plan sizing 'Unit' must reference its Section 14.3 scenario scope" },
        @{ name='sizingReviewTraceDriftRejected'; content=$testPlanOriginal.Replace('| AUT-02; partial', '| AUT-99; partial'); expected="Test Plan sizing 'Unit' must trace its automation review action" }
    )
    foreach ($mutation in $sizingMutations) {
        Set-Content -LiteralPath $testPlanPath -Value $mutation.content -Encoding UTF8
        $mutationOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
        $rejected = $LASTEXITCODE -ne 0 -and ($mutationOutput -join ' ') -match [regex]::Escape($mutation.expected)
        $negativeResults += @{ name=$mutation.name; passed=$rejected }
        if (-not $rejected) { throw "Sizing regression failed: $($mutation.name): $($mutationOutput -join ' ')" }
    }
    Set-Content -LiteralPath $testPlanPath -Value $testPlanOriginal -Encoding UTF8
    $missingTimelineType = [regex]::Replace($testPlanOriginal, '(?m)^\|\s*Connectivity\s*\| Applicable — fixture evidence \| Verified cases and automation/manual split recorded; coverage basis documented \|.*\r?\n', '')
    Set-Content -LiteralPath $testPlanPath -Value $missingTimelineType -Encoding UTF8
    $missingTimelineTypeOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
    $negativeResults += @{ name='missingEstimatedTestTypeRejected'; passed=($LASTEXITCODE -ne 0 -and ($missingTimelineTypeOutput -join ' ') -match "Testing timeline must contain exactly one 'Connectivity' row") }
    if ($LASTEXITCODE -eq 0 -or ($missingTimelineTypeOutput -join ' ') -notmatch "Testing timeline must contain exactly one 'Connectivity' row") { throw 'Test Plan validator did not reject a missing timeline test type.' }

    $missingCapacityScenario = $testPlanOriginal.Replace('Elapsed — 3 testers |', 'Elapsed — 3 testers |').Replace('| Connectivity | Applicable — fixture evidence | Verified cases and automation/manual split recorded; coverage basis documented | 1-2 weeks | 1-2 weeks | 1-2 weeks |', '| Connectivity | Applicable — fixture evidence | Verified cases and automation/manual split recorded; coverage basis documented | 1-2 weeks | 1-2 weeks |  |')
    Set-Content -LiteralPath $testPlanPath -Value $missingCapacityScenario -Encoding UTF8
    $missingCapacityOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
    $negativeResults += @{ name='missingTesterCapacityEstimateRejected'; passed=($LASTEXITCODE -ne 0 -and ($missingCapacityOutput -join ' ') -match "Testing timeline row 'Connectivity' has an unresolved required field") }
    if ($LASTEXITCODE -eq 0 -or ($missingCapacityOutput -join ' ') -notmatch "Testing timeline row 'Connectivity' has an unresolved required field") { throw 'Test Plan validator did not reject a missing tester-capacity estimate.' }

    $missingRequiredApproval = [regex]::Replace($testPlanOriginal, '(?m)^\|\s*L2 Operations\s*\|.*\r?\n', '')
    Set-Content -LiteralPath $testPlanPath -Value $missingRequiredApproval -Encoding UTF8
    $missingRequiredApprovalOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
    $negativeResults += @{ name='missingL2PlanApprovalRejected'; passed=($LASTEXITCODE -ne 0 -and ($missingRequiredApprovalOutput -join ' ') -match "Test Plan approvals must contain exactly one 'L2 Operations' reviewer row") }
    if ($LASTEXITCODE -eq 0 -or ($missingRequiredApprovalOutput -join ' ') -notmatch "Test Plan approvals must contain exactly one 'L2 Operations' reviewer row") { throw 'Test Plan validator did not reject a missing L2 approval.' }

    $pendingPlanApproval = $testPlanOriginal.Replace('| Migration Testing Team | Cases and automation | John Jones | 2026-09-21 | Approved | Review record |', '| Migration Testing Team | Cases and automation | John Jones | 2026-09-21 | Pending | Review record |')
    Set-Content -LiteralPath $testPlanPath -Value $pendingPlanApproval -Encoding UTF8
    $pendingPlanApprovalOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
    $negativeResults += @{ name='approvedPlanWithPendingPartyRejected'; passed=($LASTEXITCODE -ne 0 -and ($pendingPlanApprovalOutput -join ' ') -match "Test Plan cannot be Approved until 'Migration Testing Team'") }
    if ($LASTEXITCODE -eq 0 -or ($pendingPlanApprovalOutput -join ' ') -notmatch "Test Plan cannot be Approved until 'Migration Testing Team'") { throw 'Test Plan validator allowed Approved status with a pending required organization.' }
    Set-Content -LiteralPath $testPlanPath -Value $testPlanOriginal -Encoding UTF8

    $missingOatPlan = [regex]::Replace($testPlanOriginal, '(?m)^\|\s*L2-OAT-GD-01\s*\|.*\r?\n', '')
    Set-Content -LiteralPath $testPlanPath -Value $missingOatPlan -Encoding UTF8
    $missingOatPlanOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
    $negativeResults += @{ name='missingOatPlanIdRejected'; passed=($LASTEXITCODE -ne 0 -and ($missingOatPlanOutput -join ' ') -match "exactly one disposition row for 'L2-OAT-GD-01'") }
    if ($LASTEXITCODE -eq 0 -or ($missingOatPlanOutput -join ' ') -notmatch "exactly one disposition row for 'L2-OAT-GD-01'") { throw 'Test Plan validator did not reject a missing OAT scenario ID.' }

    $missingOatAsIs = $testPlanOriginal.Replace('As-is evidence: source baseline recorded', '')
    Set-Content -LiteralPath $testPlanPath -Value $missingOatAsIs -Encoding UTF8
    $missingOatAsIsOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
    $negativeResults += @{ name='missingOatAsIsEvidenceRejected'; passed=($LASTEXITCODE -ne 0 -and ($missingOatAsIsOutput -join ' ') -match "OAT Test Plan row 'L2-OAT-GD-01' has an unresolved required field") }
    if ($LASTEXITCODE -eq 0 -or ($missingOatAsIsOutput -join ' ') -notmatch "OAT Test Plan row 'L2-OAT-GD-01' has an unresolved required field") { throw 'Test Plan validator did not reject missing OAT as-is evidence.' }

    $missingOatAzure = $testPlanOriginal.Replace('Proposed Azure target: evidenced service mapping', '')
    Set-Content -LiteralPath $testPlanPath -Value $missingOatAzure -Encoding UTF8
    $missingOatAzureOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
    $negativeResults += @{ name='missingOatAzureEvidenceRejected'; passed=($LASTEXITCODE -ne 0 -and ($missingOatAzureOutput -join ' ') -match "OAT Test Plan row 'L2-OAT-GD-01' has an unresolved required field") }
    if ($LASTEXITCODE -eq 0 -or ($missingOatAzureOutput -join ' ') -notmatch "OAT Test Plan row 'L2-OAT-GD-01' has an unresolved required field") { throw 'Test Plan validator did not reject missing OAT Azure target evidence.' }

    $oatDispositionDrift = $testPlanOriginal.Replace('| L2-OAT-GD-01 | Fixture scenario | Recommended |', '| L2-OAT-GD-01 | Fixture scenario | Not applicable |')
    Set-Content -LiteralPath $testPlanPath -Value $oatDispositionDrift -Encoding UTF8
    $oatDispositionDriftOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
    $negativeResults += @{ name='oatDispositionDriftRejected'; passed=($LASTEXITCODE -ne 0 -and ($oatDispositionDriftOutput -join ' ') -match "OAT Test Plan disposition for 'L2-OAT-GD-01' must match Architecture Section 14.2") }
    if ($LASTEXITCODE -eq 0 -or ($oatDispositionDriftOutput -join ' ') -notmatch "OAT Test Plan disposition for 'L2-OAT-GD-01' must match Architecture Section 14.2") { throw 'Test Plan validator did not reject OAT disposition drift from architecture.' }

    $unsafeProductionOatPlan = $testPlanOriginal.Replace('Fixture scenario | Recommended | As-is evidence: source baseline recorded | Proposed Azure target: evidenced service mapping | Verify observable operational result and measurable threshold; no fault injection | Production during Cutover; approved change CHG-123; bounded impact; communications; stop conditions; recovery readiness', 'Database failover | Recommended | As-is evidence: source baseline recorded | Proposed Azure target: evidenced service mapping | Disable production database to force failover | Production during Cutover; pending change; no approval, bounded impact, stop conditions, or recovery readiness')
    Set-Content -LiteralPath $testPlanPath -Value $unsafeProductionOatPlan -Encoding UTF8
    $unsafeProductionOatPlanOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
    $unsafeProductionOatPlanRejected = ($LASTEXITCODE -ne 0 -and ($unsafeProductionOatPlanOutput -join ' ') -match "Production-disruptive OAT row 'L2-OAT-GD-01'")
    $negativeResults += @{ name='unsafeProductionOatPlanRejected'; passed=$unsafeProductionOatPlanRejected }
    if (-not $unsafeProductionOatPlanRejected) { throw 'Test Plan validator did not reject unsafe production-disruptive OAT execution.' }
    Set-Content -LiteralPath $testPlanPath -Value $testPlanOriginal -Encoding UTF8

    $standaloneIntegrationProfile = $positiveProfile.Replace('## Evidence Sources and Conflicts', '| Integration Testing | Required | Applicable | All migrations | NFR-001 | Approved measurable pass target | PPE | Reviewed fixture evidence | Migration Team | Application Owner | N/A |' + "`n" + '## Evidence Sources and Conflicts')
    Set-Content -LiteralPath $profilePath -Value $standaloneIntegrationProfile -Encoding UTF8
    $standaloneIntegrationProfileOutput = & (Join-Path $PSScriptRoot 'validate-requirements-testing.ps1') -TestingProfilePath $profilePath -RequirementsDirectory $requirementsDir -Json 2>&1
    $negativeResults += @{ name='standaloneIntegrationProfileRejected'; passed=($LASTEXITCODE -ne 0) }
    if ($LASTEXITCODE -eq 0) { throw 'Standalone Integration Testing profile row was not rejected.' }
    Set-Content -LiteralPath $profilePath -Value $positiveProfile -Encoding UTF8

    $standaloneIntegrationPlan = $testPlanOriginal.Replace('| Connectivity | Applicable — fixture basis | Approved scope | NFR-001 |', '| Integration Testing | Applicable — fixture basis | Approved scope | NFR-001 | Migration Team / Application Owner | PPE | Entry ready | Pass target met | Scheduled dependency | Results repository | N/A |' + "`n" + '| Connectivity | Applicable — fixture basis | Approved scope | NFR-001 |')
    Set-Content -LiteralPath $testPlanPath -Value $standaloneIntegrationPlan -Encoding UTF8
    $standaloneIntegrationPlanOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
    $negativeResults += @{ name='standaloneIntegrationPlanRejected'; passed=($LASTEXITCODE -ne 0) }
    if ($LASTEXITCODE -eq 0) { throw 'Standalone Integration Testing Test Plan row was not rejected.' }
    Set-Content -LiteralPath $testPlanPath -Value $testPlanOriginal -Encoding UTF8

    $connectivityArchitectureRow = ([regex]::Match($positiveArchitecture, '(?m)^\|\s*Connectivity\s*\|.*$')).Value
    $integrationArchitectureRow = '| Integration Testing | NFR-001 Applicable | Applicable — fixture basis | Section 12 | Approved mechanism | PPE | Results repository | Approved prerequisites | Ready | N/A |'
    $standaloneIntegrationArchitecture = $positiveArchitecture.Replace($connectivityArchitectureRow, $connectivityArchitectureRow + "`n" + $integrationArchitectureRow)
    Set-Content -LiteralPath $architecturePath -Value $standaloneIntegrationArchitecture -Encoding UTF8
    $standaloneIntegrationArchitectureOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
    $negativeResults += @{ name='standaloneIntegrationArchitectureRejected'; passed=($LASTEXITCODE -ne 0) }
    if ($LASTEXITCODE -eq 0) { throw 'Standalone Integration Testing architecture matrix row was not rejected.' }
    Set-Content -LiteralPath $architecturePath -Value $positiveArchitecture -Encoding UTF8

    $standaloneIntegrationRaci = $testPlanOriginal.Replace('| Connectivity | R | C | A | I | I | Jane Smith |', '| Integration Testing | R | C | A | I | I | Jane Smith |' + "`n" + '| Connectivity | R | C | A | I | I | Jane Smith |')
    Set-Content -LiteralPath $testPlanPath -Value $standaloneIntegrationRaci -Encoding UTF8
    $standaloneIntegrationRaciOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
    $negativeResults += @{ name='standaloneIntegrationRaciRejected'; passed=($LASTEXITCODE -ne 0) }
    if ($LASTEXITCODE -eq 0) { throw 'Standalone Integration Testing RACI row was not rejected.' }
    Set-Content -LiteralPath $testPlanPath -Value $testPlanOriginal -Encoding UTF8

    $missingIntegrationBranch = $testPlanOriginal.Replace('Integration scenarios for Re-Factor and Migration Team refactoring within Re-Host/Re-Platform', 'Approved scope')
    Set-Content -LiteralPath $testPlanPath -Value $missingIntegrationBranch -Encoding UTF8
    $missingIntegrationBranchOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
    $negativeResults += @{ name='missingIntegrationBranchRejected'; passed=($LASTEXITCODE -ne 0) }
    if ($LASTEXITCODE -eq 0) { throw 'Change-based functional row without integration classification was not rejected.' }
    Set-Content -LiteralPath $testPlanPath -Value $testPlanOriginal -Encoding UTF8

    $missingHaGoal = $positiveTestPlan.Replace('uptime/SLA and RTO/RPO goals', 'uptime goals')
    Set-Content -LiteralPath $testPlanPath -Value $missingHaGoal -Encoding UTF8
    $missingHaGoalOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
    $negativeResults += @{ name='missingHaGoalRejected'; passed=($LASTEXITCODE -ne 0) }
    if ($LASTEXITCODE -eq 0) { throw 'HA Test Plan without RTO/RPO goals was not rejected.' }

    $missingHaReference = $positiveTestPlan.Replace('Use LMP strategy Section 7.2. ', '')
    Set-Content -LiteralPath $testPlanPath -Value $missingHaReference -Encoding UTF8
    $missingHaReferenceOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
    $negativeResults += @{ name='missingHaSourceReferenceRejected'; passed=($LASTEXITCODE -ne 0) }
    if ($LASTEXITCODE -eq 0) { throw 'HA Test Plan without its strategy reference was not rejected.' }

    $missingDrNormalization = $positiveTestPlan.Replace('tested failback and normalization', 'tested failback')
    Set-Content -LiteralPath $testPlanPath -Value $missingDrNormalization -Encoding UTF8
    $missingDrNormalizationOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
    $negativeResults += @{ name='missingDrNormalizationRejected'; passed=($LASTEXITCODE -ne 0) }
    if ($LASTEXITCODE -eq 0) { throw 'DR Test Plan without normalization was not rejected.' }

    $missingDrReference = $positiveTestPlan.Replace('Use LMP strategy Section 7.3. ', '')
    Set-Content -LiteralPath $testPlanPath -Value $missingDrReference -Encoding UTF8
    $missingDrReferenceOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
    $negativeResults += @{ name='missingDrSourceReferenceRejected'; passed=($LASTEXITCODE -ne 0) }
    if ($LASTEXITCODE -eq 0) { throw 'DR Test Plan without its strategy reference was not rejected.' }

    Set-Content -LiteralPath $testPlanPath -Value $positiveTestPlan -Encoding UTF8
    $profileOriginal = Get-Content -LiteralPath $profilePath -Raw
    $connectivityProfileRow = ([regex]::Match($profileOriginal, '(?m)^\|\s*Connectivity\s*\|.*$')).Value
    Set-Content -LiteralPath $profilePath -Value ($profileOriginal + "`n" + $connectivityProfileRow) -Encoding UTF8
    $duplicateOutput = & (Join-Path $PSScriptRoot 'validate-requirements-testing.ps1') -TestingProfilePath $profilePath -RequirementsDirectory $requirementsDir -Json 2>&1
    $negativeResults += @{ name='duplicateProfileRowRejected'; passed=($LASTEXITCODE -ne 0) }
    if ($LASTEXITCODE -eq 0) { throw 'Duplicate testing profile row was not rejected.' }
    Set-Content -LiteralPath $profilePath -Value $profileOriginal -Encoding UTF8

    $traceDrift = $testPlanOriginal.Replace('| Connectivity | Applicable — fixture basis | Approved scope | NFR-001 |', '| Connectivity | Applicable — fixture basis | Approved scope | NFR-999 |')
    Set-Content -LiteralPath $testPlanPath -Value $traceDrift -Encoding UTF8
    $traceOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
    $negativeResults += @{ name='crossArtifactTraceDriftRejected'; passed=($LASTEXITCODE -ne 0) }
    if ($LASTEXITCODE -eq 0) { throw 'Cross-artifact Test Plan trace drift was not rejected.' }

    $extraTrace = $testPlanOriginal.Replace('| Connectivity | Applicable — fixture basis | Approved scope | NFR-001 |', '| Connectivity | Applicable — fixture basis | Approved scope | NFR-001 NFR-999 |')
    Set-Content -LiteralPath $testPlanPath -Value $extraTrace -Encoding UTF8
    $extraTraceOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
    $negativeResults += @{ name='extraDownstreamTraceRejected'; passed=($LASTEXITCODE -ne 0) }
    if ($LASTEXITCODE -eq 0) { throw 'Extra downstream Test Plan requirement was not rejected.' }

    $badApplicability = $testPlanOriginal.Replace('| Connectivity | Applicable — fixture basis |', '| Connectivity | Sometimes |')
    Set-Content -LiteralPath $testPlanPath -Value $badApplicability -Encoding UTF8
    $applicabilityOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
    $negativeResults += @{ name='arbitraryApplicabilityRejected'; passed=($LASTEXITCODE -ne 0) }
    if ($LASTEXITCODE -eq 0) { throw 'Arbitrary Test Plan applicability was not rejected.' }

    $architectureOriginal = Get-Content -LiteralPath $architecturePath -Raw
    $mandatoryExceptionArchitecture = $architectureOriginal.Replace('| Connectivity | NFR-001 Applicable | Applicable — fixture basis |', '| Connectivity | NFR-001 Applicable | Exception Approved — invalid mandatory exception |')
    Set-Content -LiteralPath $architecturePath -Value $mandatoryExceptionArchitecture -Encoding UTF8
    Set-Content -LiteralPath $testPlanPath -Value $testPlanOriginal -Encoding UTF8
    $mandatoryExceptionOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
    $negativeResults += @{ name='mandatoryArchitectureExceptionRejected'; passed=($LASTEXITCODE -ne 0) }
    if ($LASTEXITCODE -eq 0) { throw 'Architecture exception for an Applicable profile row was not rejected.' }
    Set-Content -LiteralPath $architecturePath -Value $architectureOriginal -Encoding UTF8

    $architectureValidationFixture = (Get-Content -LiteralPath (Join-Path (Get-RepoRoot) '.specify/templates/architecture-template.md') -Raw).Replace('| Connectivity | {REQ/NFR + disposition} | {Applicable — basis} |', '| Connectivity | NFR-001 Applicable | Exception Approved — invalid mandatory exception |')
    foreach ($index in 0..($oatIds.Count - 1)) {
        $architectureValidationFixture = [regex]::Replace($architectureValidationFixture, "(?m)^\|\s*$([regex]::Escape($oatIds[$index]))\s*\|.*$", [System.Text.RegularExpressions.MatchEvaluator]{ param($match) $oatArchitectureRows[$index] })
    }
    $architectureValidationPath = Join-Path $tempRoot 'architecture-validation-negative.md'
    Set-Content -LiteralPath $architectureValidationPath -Value $architectureValidationFixture -Encoding UTF8
    $architectureOatPositiveOutput = & (Join-Path $PSScriptRoot 'validate-architecture.ps1') -ArchitecturePath $architectureValidationPath -TestingProfilePath $profilePath -Json 2>&1
    $architectureOatPositive = (($architectureOatPositiveOutput -join ' ') -notmatch '(?i)(OAT Scenario Applicability Matrix|Section 14\.2|OAT scenario catalog|OAT row)')
    $results += @{ name='architectureOatCompleteMatrixAccepted'; passed=$architectureOatPositive }
    if (-not $architectureOatPositive) { throw "Architecture validator rejected the complete OAT matrix: $($architectureOatPositiveOutput -join ' ')" }
    $architectureValidationOutput = & (Join-Path $PSScriptRoot 'validate-architecture.ps1') -ArchitecturePath $architectureValidationPath -TestingProfilePath $profilePath -Json 2>&1
    $architectureDispositionRejected = ($LASTEXITCODE -ne 0 -and ($architectureValidationOutput -join ' ') -match "Applicable profile row 'Connectivity' must remain Applicable")
    $negativeResults += @{ name='architectureProfileDispositionMismatchRejected'; passed=$architectureDispositionRejected }
    if (-not $architectureDispositionRejected) { throw 'Architecture validator did not report the mandatory applicability mismatch.' }

    $missingLedgerArchitecture = [regex]::Replace($architectureValidationFixture, '(?ms)^###\s+3\.1\s+SKU\s*/\s*Tier Deployability Reconciliation\s*$.*?(?=^##\s+4\.)', '')
    Set-Content -LiteralPath $architectureValidationPath -Value $missingLedgerArchitecture -Encoding UTF8
    $missingLedgerOutput = & (Join-Path $PSScriptRoot 'validate-architecture.ps1') -ArchitecturePath $architectureValidationPath -TestingProfilePath $profilePath -Json 2>&1
    $missingLedgerRejected = ($LASTEXITCODE -ne 0 -and ($missingLedgerOutput -join ' ') -match 'Missing required section: SKU / Tier Deployability Reconciliation')
    $negativeResults += @{ name='architectureSkuTierLedgerRequired'; passed=$missingLedgerRejected }
    if (-not $missingLedgerRejected) { throw 'Architecture validator did not require the SKU/tier deployability ledger.' }

    $missingWafCodeArchitecture = [regex]::Replace($architectureValidationFixture, '(?m)^\|\s*SE:05\s*\|.*\r?\n', '')
    Set-Content -LiteralPath $architectureValidationPath -Value $missingWafCodeArchitecture -Encoding UTF8
    $missingWafCodeOutput = & (Join-Path $PSScriptRoot 'validate-architecture.ps1') -ArchitecturePath $architectureValidationPath -TestingProfilePath $profilePath -Json 2>&1
    $missingWafCodeRejected = ($LASTEXITCODE -ne 0 -and ($missingWafCodeOutput -join ' ') -match 'WAF code SE:05 must appear exactly once')
    $negativeResults += @{ name='architectureWafCodeCompletenessRequired'; passed=$missingWafCodeRejected }
    if (-not $missingWafCodeRejected) { throw 'Architecture validator did not require every WAF checklist code.' }

    $missingSovereigntyArchitecture = [regex]::Replace($architectureValidationFixture, '(?m)^###\s+6\.8\s+Data Sovereignty and Jurisdiction\s*$', '### 6.8 Removed')
    Set-Content -LiteralPath $architectureValidationPath -Value $missingSovereigntyArchitecture -Encoding UTF8
    $missingSovereigntyOutput = & (Join-Path $PSScriptRoot 'validate-architecture.ps1') -ArchitecturePath $architectureValidationPath -TestingProfilePath $profilePath -Json 2>&1
    $missingSovereigntyRejected = ($LASTEXITCODE -ne 0 -and ($missingSovereigntyOutput -join ' ') -match 'Missing required section: Data Sovereignty and Jurisdiction')
    $negativeResults += @{ name='architectureDataSovereigntyRequired'; passed=$missingSovereigntyRejected }
    if (-not $missingSovereigntyRejected) { throw 'Architecture validator did not require the data sovereignty section.' }

    $missingOatArchitecture = [regex]::Replace($architectureValidationFixture, '(?m)^\|\s*L2-OAT-GD-01\s*\|.*\r?\n', '')
    Set-Content -LiteralPath $architectureValidationPath -Value $missingOatArchitecture -Encoding UTF8
    $missingOatArchitectureOutput = & (Join-Path $PSScriptRoot 'validate-architecture.ps1') -ArchitecturePath $architectureValidationPath -TestingProfilePath $profilePath -Json 2>&1
    $missingOatArchitectureRejected = ($LASTEXITCODE -ne 0 -and ($missingOatArchitectureOutput -join ' ') -match "must contain exactly one 'L2-OAT-GD-01'")
    $negativeResults += @{ name='missingOatArchitectureIdRejected'; passed=$missingOatArchitectureRejected }
    if (-not $missingOatArchitectureRejected) { throw 'Architecture validator did not reject a missing OAT scenario ID.' }

    $missingOatAzureEvidence = $architectureValidationFixture.Replace('Proposed Azure target: evidenced service mapping', '')
    Set-Content -LiteralPath $architectureValidationPath -Value $missingOatAzureEvidence -Encoding UTF8
    $missingOatAzureOutput = & (Join-Path $PSScriptRoot 'validate-architecture.ps1') -ArchitecturePath $architectureValidationPath -TestingProfilePath $profilePath -Json 2>&1
    $missingOatAzureRejected = ($LASTEXITCODE -ne 0 -and ($missingOatAzureOutput -join ' ') -match "row 'L2-OAT-GD-01' has an unresolved required field")
    $negativeResults += @{ name='missingOatAzureEvidenceRejected'; passed=$missingOatAzureRejected }
    if (-not $missingOatAzureRejected) { throw 'Architecture validator did not reject missing Azure target evidence.' }

    $unsafeProductionOat = $architectureValidationFixture.Replace('Fixture scenario | Recommended | As-is evidence: source baseline recorded | Proposed Azure target: evidenced service mapping | Objective: measurable operational threshold | Production actions: approved change CHG-123; bounded impact; communications; stop conditions; recovery readiness', 'Database failover | Recommended | As-is evidence: source baseline recorded | Proposed Azure target: evidenced service mapping | Objective: measurable operational threshold | Production actions: pending change; no bounded impact or stop conditions')
    Set-Content -LiteralPath $architectureValidationPath -Value $unsafeProductionOat -Encoding UTF8
    $unsafeProductionOatOutput = & (Join-Path $PSScriptRoot 'validate-architecture.ps1') -ArchitecturePath $architectureValidationPath -TestingProfilePath $profilePath -Json 2>&1
    $unsafeProductionOatRejected = ($LASTEXITCODE -ne 0 -and ($unsafeProductionOatOutput -join ' ') -match "Production-disruptive OAT row 'L2-OAT-GD-01'")
    $negativeResults += @{ name='unsafeProductionOatDesignRejected'; passed=$unsafeProductionOatRejected }
    if (-not $unsafeProductionOatRejected) { throw 'Architecture validator did not reject unsafe production-disruptive OAT design.' }

    $badRaci = $testPlanOriginal.Replace('| Connectivity | R | C | A | I | I | Jane Smith |', '| Connectivity | A | C | A | R | I | Jane Smith |')
    Set-Content -LiteralPath $testPlanPath -Value $badRaci -Encoding UTF8
    $raciOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
    $negativeResults += @{ name='multipleAccountableRolesRejected'; passed=($LASTEXITCODE -ne 0) }
    if ($LASTEXITCODE -eq 0) { throw 'Malformed RACI with multiple accountable roles was not rejected.' }

    $naRaci = $testPlanOriginal.Replace('| Connectivity | R | C | A | I | I | Jane Smith |', '| Connectivity | R | C | N/A | I | I | Jane Smith |')
    Set-Content -LiteralPath $testPlanPath -Value $naRaci -Encoding UTF8
    $naRaciOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
    $negativeResults += @{ name='naAccountableRejected'; passed=($LASTEXITCODE -ne 0) }
    if ($LASTEXITCODE -eq 0) { throw 'N/A accountable role was not rejected for an applicable test.' }

    $tbdApprover = $testPlanOriginal.Replace('| Connectivity | R | C | A | I | I | Jane Smith |', '| Connectivity | R | C | A | I | I | TBD |')
    Set-Content -LiteralPath $testPlanPath -Value $tbdApprover -Encoding UTF8
    $tbdApproverOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
    $negativeResults += @{ name='tbdApproverRejected'; passed=($LASTEXITCODE -ne 0) }
    if ($LASTEXITCODE -eq 0) { throw 'TBD deliverable approver was not rejected.' }

    $roleOnlyApprover = $testPlanOriginal.Replace('| Connectivity | R | C | A | I | I | Jane Smith |', '| Connectivity | R | C | A | I | I | Migration Test Team |')
    Set-Content -LiteralPath $testPlanPath -Value $roleOnlyApprover -Encoding UTF8
    $roleOnlyOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
    $negativeResults += @{ name='roleOnlyApproverRejected'; passed=($LASTEXITCODE -ne 0) }
    if ($LASTEXITCODE -eq 0) { throw 'Generic role-only Test Plan approver was not rejected.' }

    $unscopedTestPlanReview = "**Reviewed by**: Unrelated Reviewer | **Date**: 2026-09-21 | **Outcome**: Approved`n`n" + ($testPlanOriginal -replace '(?m)^\*\*Reviewed by\*\*:.*$','')
    Set-Content -LiteralPath $testPlanPath -Value $unscopedTestPlanReview -Encoding UTF8
    $unscopedTestPlanOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
    $negativeResults += @{ name='unrelatedTestPlanReviewerRejected'; passed=($LASTEXITCODE -ne 0) }
    if ($LASTEXITCODE -eq 0) { throw 'Unrelated reviewer metadata satisfied the Test Plan approval gate.' }

    $genericTestPlanReviewer = $testPlanOriginal.Replace('**Reviewed by**: Jane Smith |', '**Reviewed by**: Architecture Team |')
    Set-Content -LiteralPath $testPlanPath -Value $genericTestPlanReviewer -Encoding UTF8
    $genericTestPlanReviewerOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
    $negativeResults += @{ name='genericTestPlanReviewerRejected'; passed=($LASTEXITCODE -ne 0) }
    if ($LASTEXITCODE -eq 0) { throw 'Generic role label satisfied the Test Plan approval gate.' }

    $badMvt = $testPlanOriginal.Replace('| Not Applicable | Full test assets available |', '| Proposed | Full test assets unavailable |')
    Set-Content -LiteralPath $testPlanPath -Value $badMvt -Encoding UTF8
    $mvtOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
    $negativeResults += @{ name='proposedMvtRejected'; passed=($LASTEXITCODE -ne 0) }
    if ($LASTEXITCODE -eq 0) { throw 'Proposed MVT remained in an Approved Test Plan without rejection.' }

    $mvtWithoutUatProtection = $testPlanOriginal.Replace('Full approved scope applies; UAT remains mandatory and is not waived', 'Full approved scope applies')
    Set-Content -LiteralPath $testPlanPath -Value $mvtWithoutUatProtection -Encoding UTF8
    $mvtUatOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
    $negativeResults += @{ name='mvtWithoutUatProtectionRejected'; passed=($LASTEXITCODE -ne 0) }
    if ($LASTEXITCODE -eq 0) { throw 'MVT without explicit UAT protection was not rejected.' }

    $badAutomation = $testPlanOriginal.Replace('| Application | repo/tests version 1.2 | Impacted code | CI pipeline unit-test stage per merge request | pytest 8.4 | Migration Team | Application Team | GCF approved evidence |', '| Application | repo/tests version 1.2 | Impacted code | CI pipeline unit-test stage per merge request | pytest 8.4 | Migration Team |  | GCF approved evidence |')
    Set-Content -LiteralPath $testPlanPath -Value $badAutomation -Encoding UTF8
    $automationOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
    $negativeResults += @{ name='missingAutomationOwnerRejected'; passed=($LASTEXITCODE -ne 0) }
    if ($LASTEXITCODE -eq 0) { throw 'Automation row without a maintenance owner was not rejected.' }

    $automationWithoutPipeline = $testPlanOriginal.Replace('| Application | repo/tests version 1.2 | Impacted code | CI pipeline unit-test stage per merge request | pytest 8.4 | Migration Team | Application Team | GCF approved evidence |', '| Application | repo/tests version 1.2 | Impacted code | Manual | pytest 8.4 | Migration Team | Application Team | GCF approved evidence |')
    Set-Content -LiteralPath $testPlanPath -Value $automationWithoutPipeline -Encoding UTF8
    $automationPipelineOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
    $negativeResults += @{ name='automationWithoutPipelineRejected'; passed=($LASTEXITCODE -ne 0) }
    if ($LASTEXITCODE -eq 0) { throw 'Automation row without pipeline execution was not rejected.' }

    $genericAutomation = $testPlanOriginal.Replace('| Application | repo/tests version 1.2 | Impacted code | CI pipeline unit-test stage per merge request | pytest 8.4 | Migration Team | Application Team | GCF approved evidence |', '| Application | Existing | Impacted code | CI pipeline | Existing framework | Migration Team | Application Team | GCF approved evidence |')
    Set-Content -LiteralPath $testPlanPath -Value $genericAutomation -Encoding UTF8
    $genericAutomationOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
    $negativeResults += @{ name='genericAutomationDetailsRejected'; passed=($LASTEXITCODE -ne 0) }
    if ($LASTEXITCODE -eq 0) { throw 'Generic automation suite/framework details were not rejected.' }

    $excludedMvtScope = $testPlanOriginal.Replace('| Not Applicable | Full test assets available | Full approved scope applies; UAT remains mandatory and is not waived | N/A — no scope reduction | Per-test execution reports |', '| Approved | Missing specifications | Application installation; Connectivity excluded; Data migration verification; UAT remains mandatory and is not waived | ADR-0001 RSK-001 | MVT execution reports |')
    Set-Content -LiteralPath $testPlanPath -Value $excludedMvtScope -Encoding UTF8
    $excludedMvtOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
    $negativeResults += @{ name='excludedMvtConnectivityRejected'; passed=($LASTEXITCODE -ne 0) }
    if ($LASTEXITCODE -eq 0) { throw 'MVT scope with connectivity excluded was not rejected.' }
    Set-Content -LiteralPath $testPlanPath -Value $testPlanOriginal -Encoding UTF8

    $tasksOriginal = Get-Content -LiteralPath $tasksPath -Raw
    $untracedTasks = $tasksOriginal.Replace('[TEST-CONNECTIVITY-PREP] Fixture task for Connectivity — NFR-001', '[TEST-CONNECTIVITY-PREP] Fixture task for Connectivity')
    Set-Content -LiteralPath $tasksPath -Value $untracedTasks -Encoding UTF8
    $untracedOutput = & (Join-Path $PSScriptRoot 'validate-testing-tasks.ps1') -TasksPath $tasksPath -TestingProfilePath $profilePath -TestPlanPath $testPlanPath -Json 2>&1
    $negativeResults += @{ name='untracedTestingTaskRejected'; passed=($LASTEXITCODE -ne 0) }
    if ($LASTEXITCODE -eq 0) { throw 'Untraced testing task was not rejected.' }

    $wrongTraceTasks = $tasksOriginal.Replace('[TEST-CONNECTIVITY-PREP] Fixture task for Connectivity — NFR-001', '[TEST-CONNECTIVITY-PREP] Fixture task for Connectivity — NFR-999')
    Set-Content -LiteralPath $tasksPath -Value $wrongTraceTasks -Encoding UTF8
    $wrongTraceOutput = & (Join-Path $PSScriptRoot 'validate-testing-tasks.ps1') -TasksPath $tasksPath -TestingProfilePath $profilePath -TestPlanPath $testPlanPath -Json 2>&1
    $negativeResults += @{ name='wrongTestingTaskTraceRejected'; passed=($LASTEXITCODE -ne 0) }
    if ($LASTEXITCODE -eq 0) { throw 'Testing task with the wrong REQ/NFR trace was not rejected.' }

    $extraTaskTrace = $tasksOriginal.Replace('[TEST-CONNECTIVITY-PREP] Fixture task for Connectivity — NFR-001', '[TEST-CONNECTIVITY-PREP] Fixture task for Connectivity — NFR-001 NFR-999')
    Set-Content -LiteralPath $tasksPath -Value $extraTaskTrace -Encoding UTF8
    $extraTaskTraceOutput = & (Join-Path $PSScriptRoot 'validate-testing-tasks.ps1') -TasksPath $tasksPath -TestingProfilePath $profilePath -TestPlanPath $testPlanPath -Json 2>&1
    $negativeResults += @{ name='extraTestingTaskTraceRejected'; passed=($LASTEXITCODE -ne 0) }
    if ($LASTEXITCODE -eq 0) { throw 'Testing task with an extra unapproved REQ/NFR trace was not rejected.' }

    $unexpectedTagTasks = $tasksOriginal + "`n- [ ] T999 [TEST-UNKNOWN-EXEC] Unexpected testing tag — NFR-001"
    Set-Content -LiteralPath $tasksPath -Value $unexpectedTagTasks -Encoding UTF8
    $unexpectedTagOutput = & (Join-Path $PSScriptRoot 'validate-testing-tasks.ps1') -TasksPath $tasksPath -TestingProfilePath $profilePath -TestPlanPath $testPlanPath -Json 2>&1
    $negativeResults += @{ name='unexpectedTestingTagRejected'; passed=($LASTEXITCODE -ne 0) }
    if ($LASTEXITCODE -eq 0) { throw 'Unexpected testing task tag was not rejected.' }

    $malformedActionTasks = $tasksOriginal + "`n- [ ] T998 [TEST-CONNECTIVITY-RUN] Malformed testing action — NFR-001"
    Set-Content -LiteralPath $tasksPath -Value $malformedActionTasks -Encoding UTF8
    $malformedActionOutput = & (Join-Path $PSScriptRoot 'validate-testing-tasks.ps1') -TasksPath $tasksPath -TestingProfilePath $profilePath -TestPlanPath $testPlanPath -Json 2>&1
    $negativeResults += @{ name='malformedTestingActionRejected'; passed=($LASTEXITCODE -ne 0) }
    if ($LASTEXITCODE -eq 0) { throw 'Malformed testing action tag was not rejected.' }

    $lowercaseTagTasks = $tasksOriginal.Replace('[TEST-CONNECTIVITY-PREP]', '[test-connectivity-prep]')
    Set-Content -LiteralPath $tasksPath -Value $lowercaseTagTasks -Encoding UTF8
    $lowercaseTagOutput = & (Join-Path $PSScriptRoot 'validate-testing-tasks.ps1') -TasksPath $tasksPath -TestingProfilePath $profilePath -TestPlanPath $testPlanPath -Json 2>&1
    $negativeResults += @{ name='lowercaseTestingTagRejected'; passed=($LASTEXITCODE -ne 0) }
    if ($LASTEXITCODE -eq 0) { throw 'Lowercase testing tag was not rejected.' }

    $underscoreTagTasks = $tasksOriginal + "`n- [ ] T997 [TEST_CONNECTIVITY_PREP] Malformed underscore testing tag — NFR-001"
    Set-Content -LiteralPath $tasksPath -Value $underscoreTagTasks -Encoding UTF8
    $underscoreTagOutput = & (Join-Path $PSScriptRoot 'validate-testing-tasks.ps1') -TasksPath $tasksPath -TestingProfilePath $profilePath -TestPlanPath $testPlanPath -Json 2>&1
    $negativeResults += @{ name='underscoreTestingTagRejected'; passed=($LASTEXITCODE -ne 0) }
    if ($LASTEXITCODE -eq 0) { throw 'Underscore testing tag was not rejected.' }

    $spaceTagTasks = $tasksOriginal + "`n- [ ] T996 [TEST CONNECTIVITY PREP] Malformed space testing tag — NFR-001"
    Set-Content -LiteralPath $tasksPath -Value $spaceTagTasks -Encoding UTF8
    $spaceTagOutput = & (Join-Path $PSScriptRoot 'validate-testing-tasks.ps1') -TasksPath $tasksPath -TestingProfilePath $profilePath -TestPlanPath $testPlanPath -Json 2>&1
    $negativeResults += @{ name='spaceTestingTagRejected'; passed=($LASTEXITCODE -ne 0) }
    if ($LASTEXITCODE -eq 0) { throw 'Space-delimited testing tag was not rejected.' }

    $duplicateTaskIdTasks = $tasksOriginal -replace '(?m)^- \[ \] T101 ', '- [ ] T100 '
    Set-Content -LiteralPath $tasksPath -Value $duplicateTaskIdTasks -Encoding UTF8
    $duplicateTaskIdOutput = & (Join-Path $PSScriptRoot 'validate-testing-tasks.ps1') -TasksPath $tasksPath -TestingProfilePath $profilePath -TestPlanPath $testPlanPath -Json 2>&1
    $negativeResults += @{ name='duplicateTaskIdRejected'; passed=($LASTEXITCODE -ne 0) }
    if ($LASTEXITCODE -eq 0) { throw 'Duplicate testing task ID was not rejected.' }

    $appRoot = Join-Path $tempRoot 'app'
    $featureRoot = Join-Path $appRoot 'specs/001-testing-fixture'
    New-Item -ItemType Directory -Path (Join-Path $featureRoot 'requirements') -Force | Out-Null
    New-Item -ItemType Directory -Path (Join-Path $featureRoot 'decisions') -Force | Out-Null
    New-Item -ItemType Directory -Path (Join-Path $featureRoot 'risks') -Force | Out-Null
    Copy-Item -LiteralPath $profilePath -Destination (Join-Path $featureRoot 'requirements/testing-profile.md')
    Copy-Item -LiteralPath (Join-Path $requirementsDir 'NFR-001-testing-outcome.md') -Destination (Join-Path $featureRoot 'requirements/NFR-001-testing-outcome.md')
    Set-Content -LiteralPath (Join-Path $featureRoot 'tasks.md') -Value $tasksOriginal -Encoding UTF8
    $gateArchitecture = (Get-Content -LiteralPath $architecturePath -Raw) + "`n## Architecture Review Gate`n`n| Architecture Review Gate | Cleared |`n`n**Reviewed by**: Jane Smith | **Date**: 2026-09-21 | **Outcome**: Approved"
    Set-Content -LiteralPath (Join-Path $featureRoot 'architecture.md') -Value $gateArchitecture -Encoding UTF8
    $gatePlan = (Get-Content -LiteralPath $planPath -Raw) + "`n## 2. Review Gate`n`n**Outcome**: Cleared`n`n**Reviewed by**: Jane Smith | **Date**: 2026-09-21 | **Outcome**: Approved"
    Set-Content -LiteralPath (Join-Path $featureRoot 'plan.md') -Value $gatePlan -Encoding UTF8
    Copy-Item -LiteralPath $testPlanPath -Destination (Join-Path $featureRoot 'G-test-plan.md')
    $previousAppRoot = $env:SPEC_LAYER_APP_ROOT
    $previousTemp = $env:TEMP
    $previousTmp = $env:TMP
    $env:SPEC_LAYER_APP_ROOT = $appRoot
    # Keep the existing test-only prerequisite restriction scoped to this runner's fixture.
    $env:TEMP = $tempRoot
    $env:TMP = $tempRoot
    try {
        @('# Requirements Index','','## Requirements Review Gate','','| Gate | Status |','| --- | --- |','| Requirements Review Gate | Cleared |','','**Reviewed by**: Jane Smith | **Date**: 2026-09-21 | **Outcome**: Approved') | Set-Content -LiteralPath (Join-Path $featureRoot 'requirements/index.md') -Encoding UTF8
        $implementationReadyOutput = & (Join-Path $PSScriptRoot 'check-prerequisites.ps1') -RequireImplementationReady -TestOnlySkipNonTestingValidation -Json 2>&1
        $results += @{ name='implementationReady'; passed=($LASTEXITCODE -eq 0); output=($implementationReadyOutput -join "`n") }
        if ($LASTEXITCODE -ne 0) { throw "Valid implementation-readiness fixture failed: $($implementationReadyOutput -join ' ')" }

        $appProfilePath = Join-Path $featureRoot 'requirements/testing-profile.md'
        $appProfileOriginal = Get-Content -LiteralPath $appProfilePath -Raw
        $appConnectivityRow = ([regex]::Match($appProfileOriginal, '(?m)^\|\s*Connectivity\s*\|.*$')).Value
        Set-Content -LiteralPath $appProfilePath -Value ($appProfileOriginal + "`n" + $appConnectivityRow) -Encoding UTF8
        $profileDriftRejected = $false
        try { $profileDriftOutput = & (Join-Path $PSScriptRoot 'check-prerequisites.ps1') -RequireImplementationReady -TestOnlySkipNonTestingValidation -Json 2>&1; $profileDriftRejected = ($LASTEXITCODE -ne 0) } catch { $profileDriftRejected = $true }
        $negativeResults += @{ name='implementationProfileDriftRejected'; passed=$profileDriftRejected }
        if (-not $profileDriftRejected) { throw 'Post-approval testing-profile drift was not rejected.' }
        Set-Content -LiteralPath $appProfilePath -Value $appProfileOriginal -Encoding UTF8

        $appArchitecturePath = Join-Path $featureRoot 'architecture.md'
        $appArchitectureOriginal = Get-Content -LiteralPath $appArchitecturePath -Raw
        Set-Content -LiteralPath $appArchitecturePath -Value $appArchitectureOriginal.Replace('| Connectivity | NFR-001 Applicable |', '| Connectivity | NFR-999 Applicable |') -Encoding UTF8
        $architectureDriftRejected = $false
        try { $architectureDriftOutput = & (Join-Path $PSScriptRoot 'check-prerequisites.ps1') -RequireImplementationReady -TestOnlySkipNonTestingValidation -Json 2>&1; $architectureDriftRejected = ($LASTEXITCODE -ne 0) } catch { $architectureDriftRejected = $true }
        $negativeResults += @{ name='implementationArchitectureDriftRejected'; passed=$architectureDriftRejected }
        if (-not $architectureDriftRejected) { throw 'Post-approval architecture testing drift was not rejected.' }
        Set-Content -LiteralPath $appArchitecturePath -Value $appArchitectureOriginal -Encoding UTF8

        $appTestPlanPath = Join-Path $featureRoot 'G-test-plan.md'
        $appTestPlanOriginal = Get-Content -LiteralPath $appTestPlanPath -Raw
        Set-Content -LiteralPath $appTestPlanPath -Value $appTestPlanOriginal.Replace('| **Status** | Approved |','| **Status** | Draft |') -Encoding UTF8
        $testPlanDriftRejected = $false
        try { $testPlanDriftOutput = & (Join-Path $PSScriptRoot 'check-prerequisites.ps1') -RequireImplementationReady -TestOnlySkipNonTestingValidation -Json 2>&1; $testPlanDriftRejected = ($LASTEXITCODE -ne 0) } catch { $testPlanDriftRejected = $true }
        $negativeResults += @{ name='implementationTestPlanDriftRejected'; passed=$testPlanDriftRejected }
        if (-not $testPlanDriftRejected) { throw 'Post-approval Test Plan drift was not rejected.' }
        Set-Content -LiteralPath $appTestPlanPath -Value $appTestPlanOriginal -Encoding UTF8

        @('# Requirements Index','','## Requirements Review Gate','','| Gate | Status |','| --- | --- |','| Requirements Review Gate | Pending |','','**Reviewed by**: Jane Smith | **Date**: 2026-09-21 | **Outcome**: Changes requested') | Set-Content -LiteralPath (Join-Path $featureRoot 'requirements/index.md') -Encoding UTF8
        $gateRejected = $false
        try {
            $gateOutput = & (Join-Path $PSScriptRoot 'check-prerequisites.ps1') -RequireImplementationReady -Json 2>&1
            $gateRejected = ($LASTEXITCODE -ne 0)
        } catch {
            $gateRejected = $_.Exception.Message -match 'Requirements Review Gate is no longer Cleared'
        }
        $negativeResults += @{ name='downgradedRequirementsGateRejected'; passed=$gateRejected }
        if (-not $gateRejected) { throw 'Downgraded Requirements Review Gate was not rejected before implementation.' }

        @('# Unrelated Review','','**Reviewed by**: Unrelated Reviewer | **Date**: 2026-09-21 | **Outcome**: Approved','','## Requirements Review Gate','','| Gate | Status |','| --- | --- |','| Requirements Review Gate | Cleared |') | Set-Content -LiteralPath (Join-Path $featureRoot 'requirements/index.md') -Encoding UTF8
        $globalRequirementsReviewerRejected = $false
        try {
            $globalRequirementsOutput = & (Join-Path $PSScriptRoot 'check-prerequisites.ps1') -RequireImplementationReady -Json 2>&1
            $globalRequirementsReviewerRejected = ($LASTEXITCODE -ne 0)
        } catch {
            $globalRequirementsReviewerRejected = $_.Exception.Message -match 'Requirements Review Gate is no longer Cleared'
        }
        $negativeResults += @{ name='unrelatedRequirementsReviewerRejected'; passed=$globalRequirementsReviewerRejected }
        if (-not $globalRequirementsReviewerRejected) { throw 'Unrelated reviewer metadata satisfied the Requirements gate.' }

        @('# Requirements Index','','## Requirements Review Gate','','| Gate | Status |','| --- | --- |','| Requirements Review Gate | Cleared |','','**Reviewed by**: Jane Smith | **Date**: 2026-09-21 | **Outcome**: Approved') | Set-Content -LiteralPath (Join-Path $featureRoot 'requirements/index.md') -Encoding UTF8
        $unscopedArchitecture = "# Unrelated Review`n`n**Reviewed by**: Unrelated Reviewer | **Date**: 2026-09-21 | **Outcome**: Approved`n`n" + $architectureOriginal + "`n## Architecture Review Gate`n`n| Architecture Review Gate | Cleared |"
        Set-Content -LiteralPath (Join-Path $featureRoot 'architecture.md') -Value $unscopedArchitecture -Encoding UTF8
        $globalArchitectureReviewerRejected = $false
        try {
            $globalArchitectureOutput = & (Join-Path $PSScriptRoot 'check-prerequisites.ps1') -RequireImplementationReady -Json 2>&1
            $globalArchitectureReviewerRejected = ($LASTEXITCODE -ne 0)
        } catch {
            $globalArchitectureReviewerRejected = $_.Exception.Message -match 'Architecture Review Gate is no longer Cleared'
        }
        $negativeResults += @{ name='unrelatedArchitectureReviewerRejected'; passed=$globalArchitectureReviewerRejected }
        if (-not $globalArchitectureReviewerRejected) { throw 'Unrelated reviewer metadata satisfied the Architecture gate.' }

        @('# Requirements Index','','## Requirements Review Gate','','| Gate | Status |','| --- | --- |','| Requirements Review Gate | Cleared |','','**Reviewed by**: Jane Smith | **Date**: 2026-09-21 | **Outcome**: Changes requested') | Set-Content -LiteralPath (Join-Path $featureRoot 'requirements/index.md') -Encoding UTF8
        $changesRequestedRejected = $false
        try {
            $changesRequestedOutput = & (Join-Path $PSScriptRoot 'check-prerequisites.ps1') -RequireImplementationReady -Json 2>&1
            $changesRequestedRejected = ($LASTEXITCODE -ne 0)
        } catch {
            $changesRequestedRejected = $_.Exception.Message -match 'Requirements Review Gate is no longer Cleared'
        }
        $negativeResults += @{ name='changesRequestedGateOutcomeRejected'; passed=$changesRequestedRejected }
        if (-not $changesRequestedRejected) { throw 'Gate-local Changes requested outcome was accepted as cleared.' }

        @('# Requirements Index','','## Requirements Review Gate','','| Gate | Status |','| --- | --- |','| Requirements Review Gate | Cleared |','','**Reviewed by**: Architecture Team | **Date**: 2026-09-21 | **Outcome**: Approved') | Set-Content -LiteralPath (Join-Path $featureRoot 'requirements/index.md') -Encoding UTF8
        $genericGateReviewerRejected = $false
        try {
            $genericGateOutput = & (Join-Path $PSScriptRoot 'check-prerequisites.ps1') -RequireImplementationReady -Json 2>&1
            $genericGateReviewerRejected = ($LASTEXITCODE -ne 0)
        } catch {
            $genericGateReviewerRejected = $_.Exception.Message -match 'Requirements Review Gate is no longer Cleared'
        }
        $negativeResults += @{ name='genericGateReviewerRejected'; passed=$genericGateReviewerRejected }
        if (-not $genericGateReviewerRejected) { throw 'Generic team label satisfied the Requirements gate.' }

        @('# Requirements Index','','## Requirements Review Gate','','| Gate | Status |','| --- | --- |','| Requirements Review Gate | Cleared |','','**Reviewed by**: Jane Smith | **Date**: 2026-09-21 | **Outcome**: Approved') | Set-Content -LiteralPath (Join-Path $featureRoot 'requirements/index.md') -Encoding UTF8
        $changesRequestedArchitecture = $architectureOriginal + "`n## Architecture Review Gate`n`n| Architecture Review Gate | Cleared |`n`n**Reviewed by**: Jane Smith | **Date**: 2026-09-21 | **Outcome**: Changes requested"
        Set-Content -LiteralPath (Join-Path $featureRoot 'architecture.md') -Value $changesRequestedArchitecture -Encoding UTF8
        $architectureChangesRequestedRejected = $false
        try {
            $architectureChangesOutput = & (Join-Path $PSScriptRoot 'check-prerequisites.ps1') -RequireImplementationReady -Json 2>&1
            $architectureChangesRequestedRejected = ($LASTEXITCODE -ne 0)
        } catch {
            $architectureChangesRequestedRejected = $_.Exception.Message -match 'Architecture Review Gate is no longer Cleared'
        }
        $negativeResults += @{ name='architectureChangesRequestedOutcomeRejected'; passed=$architectureChangesRequestedRejected }
        if (-not $architectureChangesRequestedRejected) { throw 'Architecture gate-local Changes requested outcome was accepted as cleared.' }
    } finally {
        $env:SPEC_LAYER_APP_ROOT = $previousAppRoot
        $env:TEMP = $previousTemp
        $env:TMP = $previousTmp
    }

    $result = @{ valid=$true; validations=$results; negativeValidations=$negativeResults }
    Write-ScriptResult -Data $result -Json:$Json
    exit 0
} finally {
    Remove-Item -LiteralPath $tempRoot -Recurse -Force -ErrorAction SilentlyContinue
}
