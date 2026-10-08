# LMP Migration Testing Strategy — Index

> **Agent usage**: Load this index first. Load only the linked section of
> `LMP-Migration-Testing-Strategy.md` needed for the current requirement, architecture review, or
> plan. The Markdown is a fidelity extraction of the source DOCX, not a replacement policy.

## Source and provenance

| Field | Value |
| --- | --- |
| Source | `LMP Migration Testing Strategy.docx` |
| Source version/date | 2.0 / 2026-03-23 |
| Source SHA-256 | `6335E66062C6BFEB30D3C97A257DBF2865051438B4121428BD89E8AA518CF0F9` |
| Extraction | Pandoc DOCX → GitHub-Flavored Markdown, media preserved under `media/` |
| Extracted file | `LMP-Migration-Testing-Strategy.md` |
| Extraction SHA-256 | `9255CB6C754FF1D37E8B9B87ED57EBA8F7D0CD1F95AFE8884EC9E0BD22B7DAF2` |
| Reviewed contract | `testing-strategy-contract.json` |

Run `.specify/scripts/powershell/validate-testing-strategy.ps1` to detect source or extraction
drift. When the DOCX changes, run `export-testing-strategy.ps1`, review the resulting content and
this index, then update the validator baseline. Current baseline: 15 source top-level sections plus
the generated table of contents, 45 level-two headings, 11 level-three headings, 24 source tables,
and 5 media files.

## Executive summary

The strategy supplements divisional testing strategies for LMP migrations. Testing is mandatory
for every application. The application Test Plan is defined and approved during Planning & Design,
then drives engineering, migration testing, pre-cutover, cutover, evidence collection, and final
approval. The baseline covers connectivity, migration tooling, installation, smoke/regression,
performance baseline/comparison, HA, DR, security, penetration testing, OAT, and UAT. Unit-test
implementation follows migration code changes while preserving existing automated suites; data
migration verification follows actual data movement. Refactor adds change-based functional
testing; Rearchitect adds full functional testing.

The source makes five controls especially important to this framework:

1. Test scope, measurable success criteria, owners, environments, data, tooling, evidence, and
   exceptions must be decided before execution.
2. Functional obligations are ordinary `REQ-*` records; measurable performance, availability,
   recovery, security, operability, data-quality, and defect thresholds are ordinary `NFR-*`
   records. A missing mandatory test or deviation is a Proposed ADR and, when exposure exists, an
   Identified risk. Do not create a separate requirement namespace for tests.
3. The target design must be testable: production-comparable environments, monitoring, access,
   test data controls, failover/recovery mechanisms, deployment verification, and evidence routes
   must be designed before the plan schedules tests.
4. UAT is mandatory and may not be exempted. Other expected tests require the formal Test Exception
   Process when omitted, incomplete, or run against a non-comparable environment.
5. Test execution is not complete without reproducible cases, requirement/defect traceability,
   results reports, centrally retained evidence, named LSEG approval, and documented treatment of
   unresolved defects.

## Workflow ownership

| Stage | Owner | Uses this strategy to produce |
| --- | --- | --- |
| Requirements | `requirements-testing` | Atomic REQ/NFR records for test applicability, outcomes, thresholds, evidence, approvals, and exceptions; conditional R-Type obligations stay conditional until architecture decides R-Type. |
| Architecture | `architecture-testing` | Cross-layer testability review of environments, observability, access/data controls, failure/recovery mechanisms, and treatment-specific applicability. It proposes ADRs/risks for design gaps; it is not a ninth design layer. |
| Planning | `plan-testing` | The application Test Plan, test schedule, entry/exit/acceptance gates, RACI, tooling, evidence repository, defects, exceptions, dependencies, and approvals. |
| Tasks | `tasks-assembly` / `tasks-validation` | Executable test preparation, execution, reporting, remediation, evidence, and human approval tasks traced to the plan and REQ/NFR records. |

## Test applicability baseline

| Test type | Rehost | Replatform | Refactor | Rearchitect | Primary requirement/design concern |
| --- | :---: | :---: | :---: | :---: | --- |
| Connectivity | Yes | Yes | Yes | Yes | Users, upstream/downstream systems, internal components, positive/negative authorization and payload paths |
| Unit | Conditional | Conditional | Conditional | Conditional | Existing automated suites continue. Migration Team adds/extends tests only for migration-changed, impacted code. |
| Data migration verification | Conditional | Conditional | Conditional | Conditional | Required whenever data moves; evidence-backed N/A only when no data movement is in scope. |
| Migration tool | Yes | Yes | Yes | Yes | Tool fitness and source-environment validation |
| Application installation | Yes | Yes | Yes | Yes | Deployment/configuration verification and post-deployment behavior |
| Smoke/regression | Yes | Yes | Yes | Yes | Critical/common behavior and migration regression coverage |
| Change-based functional | No | No | Yes | No | Changed and dependent unchanged components |
| Full rearchitecture functional | No | No | No | Yes | User-story and end-to-end behavior |
| Performance and baseline | Yes | Yes | Yes | Yes | Equal-volumetric comparison, NFRs, tolerable variance, production-representative PPE |
| High availability | Yes | Yes | Yes | Yes | Failover, redundancy, stability, no excess loss/degradation |
| Disaster recovery | Yes | Yes | Yes | Yes | Production pre-cutover recovery and normalization against RTO/RPO |
| Security penetration | Yes | Yes | Yes | Yes | LSEG-owned production execution; Critical/High remediation |
| Operational acceptance | Yes | Yes | Yes | Yes | LSEG operations readiness in production |
| User acceptance | Yes | Yes | Yes | Yes | Mandatory business acceptance in PPE; no exemption |

`Yes` means expected by the source strategy. Application records still define exact scope, level,
thresholds, evidence, and owner. Any permitted deviation follows the Test Exception Process.

## Normative conflict resolutions

These resolutions prevent the source DOCX, Backlog Playbook, and templates from producing
different application plans. They are framework interpretations of the current sources; a future
source revision that changes them requires review through `validate-testing-strategy.ps1`.

| Topic | Source tension | Normative resolution |
| --- | --- | --- |
| Unit testing applicability | The strategy matrix marks unit testing for all R-Types; Backlog execution rows emphasize Refactor; the environment table says no DEV testing while the RACI uses DEV/CI. | Existing automated unit suites continue for every migration. The Migration Team implements or extends unit tests only for code changed during migration, scoped to impacted code. Execute in CI/build pipelines; use DEV only when the approved delivery design places execution there. No migration code change means no new Migration-Team unit-test scope, not deletion of the existing suite. |
| Data migration verification | The strategy matrix marks it broadly while MVT and Backlog wording say "if applicable." | Required for every in-scope data movement. `Not Applicable` requires evidence that no application data, files, durable messages, or state are moved. If data moves and testing cannot be completed, use `Exception Proposed`, not N/A. |
| Disaster recovery environment | The strategy requires Production before customer cutover; Backlog rows also name PPE/QA. | Production DR execution is the acceptance test. PPE/QA activities are additional rehearsals and cannot satisfy the production DR deliverable. |
| Security versus penetration | The strategy separates general security testing in PPE from penetration testing in Production; some backlog labels are broader. | Maintain two distinct rows, plans, tasks, evidence sets, owners, and approvals. General security testing normally runs in PPE; penetration testing runs in Production. |
| Integration testing classification | [Source Section 6.6.1](LMP-Migration-Testing-Strategy.md#functional-testing-change-based-functional-testinglimited-functional-testing-re-factor-only) defines Refactor functional testing as extending Re-Host/Re-Platform functional tests to cover interaction between unchanged and refactored components; it does not establish Integration Testing as an independent canonical test type. | Do not create a standalone Integration Testing row in the testing profile, architecture matrix, Test Plan, RACI, or task taxonomy. Include integration scenarios in Change-Based Functional Testing when the Migration Team performs refactoring (including refactoring activities within Re-Host/Re-Platform). Otherwise, keep integration scenarios within mandatory UAT, owned and executed by the Application Team. UAT remains mandatory in either case; do not duplicate or double-count the same scenario across categories. This classification rule does not remove the separate Integration Testing Complexity assessment of qualifying external standalone business/negative-path cases. |
| Operational Acceptance Testing | The LMP strategy assigns OAT to Application Operations during Cutover in Production. The LSEG L2 Game Day catalog is a generic recommended scenario baseline with Production/DR and production-like examples, not proof that each scenario applies or is authorized for every app. | Use the [LSEG L2 OAT Game Day Scenario Catalog](LSEG-L2-OAT-Game-Day-Scenario-Catalog.md) with discovery/as-is evidence and the proposed Azure architecture. Disposition every catalog ID, map only evidenced Azure services, name operational outcomes and runbooks, and resolve environment, change approval, safety, ownership and evidence. The Architecture stage assesses applicability/testability; Planning turns selected cases into executable, scheduled OAT. Do not claim execution from the catalog or substitute OAT for HA/DR/UAT or other test obligations. |
| UAT | The strategy explicitly forbids exemption. | UAT is Applicable for every R-Type. Missing cases, users, data, or environment are blocking readiness gaps, never N/A or an exception. |

## Automation interpretation

Apply [Automation review and high-level scenario sizing](automation-review-and-scenario-sizing.md)
through Requirements, Architecture, Planning and Analyze. Every test type needs an as-is review
entry; missing evidence triggers an explicit Application Team review action, not a "no automation"
assumption. None/Partial/Unknown coverage requires a provisional architecture scenario proposal
and visible reuse/adapt/build effort. Assign activities from the extracted strategy's relevant
sections and Appendix 5, including Section 4.1's one-sprint enablement boundary, rather than
assuming the Migration Team creates or maintains every missing suite.

The application profile is also the reusable evidence-intake and human-input layer. Register
supplied plans, catalogs, linked workbooks/repositories, source inventories and run evidence with
version/date/locator, scope, authority, access, applicability and freshness. Preserve source
conflicts with competing claims and locators, governing rule, owner action and downstream impact;
an uploaded plan does not supersede the LMP strategy or independently derived architecture.
Record business facts only when supported by evidence or a validated human answer. Missing inputs
remain visible, owned unknowns and do not prevent a useful Draft or Ready-for-Review proposal.

Reuse the profile's shared human-input register for questions across requirements, architecture and
planning; existing AUT follow-ups link to that action rather than creating duplicate rows or a new
requirement namespace. Keep test-asset availability separate from reuse health: linked or
framework-present assets are not verified until scope, compatible dated run/results and coverage
are evidenced. In the Test Plan, preserve supplied case IDs and distinguish unique cases from
families, grouped classifications and repeated runs. Outline proposed cases only from evidenced
application behavior; otherwise retain an owned question/action.

Architecture Section 14.4 maps evidenced source components, stores, interfaces and flows to
Retain/Change/Replace/Retire decisions, state movement, affected and dependent unchanged behavior,
requirements, families/supplied cases, coverage disposition and owner action. Reconcile duration
estimates only when their start/end boundary, included/excluded phases and waits match; an L2 OAT
window and full migration timeline are not conflicting merely because durations differ. Keep
governing LMP recovery obligations independent from an example workbook's DR N/A or a workbook's
proposed R-Type.

Validation stages separate structure/readiness from execution approval. `Draft` permits owned
unknown inputs; `ReadyForReview` establishes a reviewable proposal but not formal approval;
`Execution` remains strict, requires the Approved Test Plan and existing approvals, and is the
default for backward-compatible task-generation/prerequisite validation. Publication preserves the
full source and honest status; it does not approve a draft or fail publication solely because
evidence remains incomplete.

Draft and document review defer production readiness and named appointments only when relevant
profile actions own the unresolved dependencies, contacts/coordinators and needed-by gates.
Execution still requires Ready architecture rows and named per-test approvers; contradictions and
unsupported verified/approved claims remain errors in every stage. Lead the Test Plan with the
concise linked Review Brief described in
[the workflow guidance](automation-review-and-scenario-sizing.md#reader-first-review-path):
proposed scope, material conflicts, prioritized human actions and the next version-specific gate
first; detailed case mappings and supporting ledgers follow. Legacy Drafts warn if it is absent;
ReadyForReview requires it. Publication preserves, rather than invents, this source-owned brief.

The strategy requires maintained automation but does not prescribe one automation level for every
test type. The framework applies the following minimum automation model unless application evidence
or a human-approved exception requires a stricter treatment:

| Test scope | Minimum target automation | Interpretation |
| --- | --- | --- |
| Unit | Automated | Existing automated suites continue; migration-changed impacted code receives automated unit coverage in the approved CI/build pipeline. |
| Connectivity | Automated | Approved and prohibited network, identity and service paths are exercised repeatably with machine-verifiable pass/fail evidence. |
| Performance/load | Automated | Repeatable workload scripts, telemetry capture and threshold evaluation are versioned and executable through approved delivery controls. |
| Integration scenarios within functional testing or UAT | Semi-automated permitted | Integration is scenario scope, not a standalone canonical test type. Place scenarios in Change-Based Functional Testing when the Migration Team refactors; otherwise include them in mandatory Application-Team UAT. Automate repeatable setup, invocation and assertions where feasible; document manual orchestration, observation or approval steps with an accountable owner. |
| Smoke/regression and functional | Semi-automated permitted | Automate stable critical paths where feasible; retain versioned manual steps, expected results, evidence capture and named execution/approval ownership for the remainder. Change-Based Functional Testing includes integration coverage for refactored components and their unchanged dependencies. |

`Semi-automated` does not mean unstructured manual testing. Every manual step remains reproducible,
traceable to a requirement/case/defect, assigned through the application RACI, and represented in
the case count. If discovery and source-code evidence cannot prove the current as-is automation
level or case inventory, record a readiness risk and scope the missing automation or controlled
manual coverage to the Migration Team or Application Team according to the approved RACI and R-Type.

## Section index

| Source section | Use for | Primary consumers |
| --- | --- | --- |
| [1 Introduction](LMP-Migration-Testing-Strategy.md#introduction) | Authority, related standards, templates, external systems | All stages |
| [2 Testing Scope](LMP-Migration-Testing-Strategy.md#testing-scope) | Phase deliverables, owners, environments, approvals | Requirements, planning |
| [3 Test Planning](LMP-Migration-Testing-Strategy.md#test-planning) | Test Plan content, case quality, R-Type matrix | Requirements, architecture review, planning |
| [4 Test Automation](LMP-Migration-Testing-Strategy.md#test-automation) | MEC, shared ownership, maintained/versioned test code | Requirements, architecture, planning |
| [5 Minimum Viable Testing](LMP-Migration-Testing-Strategy.md#minimum-viable-testing) | Governed fallback when specifications/cases are unavailable | Requirements, ADR/risk, planning |
| [6 Functional Testing](LMP-Migration-Testing-Strategy.md#testing-functional) | Tool, unit, data, installation, connectivity, regression, Refactor/Rearchitect criteria | Requirements, architecture, planning |
| [7 Non-Functional Testing](LMP-Migration-Testing-Strategy.md#testing-non-functional) | Performance, HA, DR, security, penetration, OAT | NFRs, architecture layers, planning |
| [LSEG L2 OAT Game Day Scenario Catalog](LSEG-L2-OAT-Game-Day-Scenario-Catalog.md) | 24 Game Day, 9 standard-change, and 18 validation-only recommendations; use stable scenario IDs and application evidence | Architecture OAT applicability via `oat-scenario-design`; OAT scenario planning via `oat-scenario-planning`; operations runbooks |
| [7.2 High Availability Testing](LMP-Migration-Testing-Strategy.md#high-availability-testing) | Application Owner assessment; HA goals; test-plan contents; PPE, tooling, monitoring, data, execution window, entry/exit criteria | Requirements, architecture resilience, planning, analysis |
| [7.3 Disaster Recovery Testing](LMP-Migration-Testing-Strategy.md#disaster-recovery-testing) | Production DR execution, L2 ownership, runbook handover, scenarios, entry/exit criteria, failback, evidence and approval | Requirements, architecture resilience/transition, planning, analysis |
| [8 UAT](LMP-Migration-Testing-Strategy.md#user-acceptance-testing-uat) | Mandatory business acceptance, entry/exit criteria | Requirements, transition, planning |
| [9 Test Process](LMP-Migration-Testing-Strategy.md#test-process) | Management, execution, data, delays, acceptance | Planning, tasks |
| [10 Exceptions](LMP-Migration-Testing-Strategy.md#test-exception-process) | Mandatory Decision work item and governance review | ADRs, risks, planning |
| [11 Risks](LMP-Migration-Testing-Strategy.md#test-risk-management) | RAID/SII escalation and go-live reporting | Risks, planning |
| [12 Defects](LMP-Migration-Testing-Strategy.md#defect-management) | Logging, triage, lifecycle, traceability, severity/priority | Requirements thresholds, planning, tasks |
| [13 Results and Reporting](LMP-Migration-Testing-Strategy.md#test-execution-results-reporting) | Per-type result reports, repository structure, completion status | Planning, tasks, evidence |
| [14 Approval](LMP-Migration-Testing-Strategy.md#test-deliverable-approval-process) | Named human approvers and deliverable sign-off | Planning, gates |
| [15 Appendices](LMP-Migration-Testing-Strategy.md#appendices) | Change history, personas, Microsoft roles, detailed RACI | Planning |

## Interpretation rules

- The DOCX is LSEG source guidance. Preserve its mandatory language and cite the exact section.
- Do not use the R-Type matrix to select an R-Type. Requirements records universal obligations and
  conditional Refactor/Rearchitect obligations; architecture independently decides R-Type, then
  resolves the applicable branch.
- Do not copy generic numeric targets from this strategy where the source requires application
  values. Record or propose measurable application targets under the framework's evidence rules.
- Tool examples are candidates, not automatic architecture decisions. Apply current ADR, pattern,
  CPF, MEC, GCF, DevSecOps, and security constraints before selecting them.
- Source statements that conflict with newer binding LSEG governance require a Proposed ADR/risk
  and human resolution; do not silently choose either source.
- Apply the normative resolutions above before raising an application ADR. Raise an ADR only when
  the application proposes to deviate from the resolved rule or newer binding evidence conflicts.
- For HA planning and assurance, consult [Section 7.2](LMP-Migration-Testing-Strategy.md#high-availability-testing)
  and carry its owner assessment, approved goals, complete test plan, production-comparable PPE,
  monitoring/data preparation, isolated execution window, and entry/exit evidence into the
  requirements, architecture, and Test Plan.
- For DR planning and assurance, consult [Section 7.3](LMP-Migration-Testing-Strategy.md#disaster-recovery-testing).
  Production execution by the Application L2 Team before customer cutover is the acceptance test;
  a lower-environment rehearsal is additional evidence only. Preserve runbook handover, dependency
  failure scenarios, backup readiness, RTA/RPA against RTO/RPO, failback/normalization, defect
  closure or approved risk acceptance, results evidence, and named approval.
