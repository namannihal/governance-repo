# G — Test Plan Baseline Template

| Property | Value |
| --- | --- |
| **ID** | G-3 |
| **Status** | {Draft / Ready for Review / Approved} |
| **Owner** | Migration Team |
| **Application** | {Application Name} |

---

## Review Brief

Keep this opening to approximately one page. It is navigation into the authoritative evidence,
not another register: rank at most five significant conflicts and five next human actions by
scope/acceptance risk and dependency order, not ID order or a blanket Critical priority.
Use `None — reason` when a list is empty; keep remaining items in the linked registers.

**Purpose and maturity**: {what this review should decide; current Draft/Ready for Review/Approved
status; proposal versus execution baseline}

**Proposed scope and exclusions**: {evidence-bounded scope, unchanged mandatory obligations,
exclusions with basis; link families/cases rather than listing every case}

**Evidence basis and confidence**: {source/version/locators, reported versus verified assets and
unique cases versus families; unknown counts remain Unknown; stale or missing inputs lower confidence}

**Artifact quality versus input completeness**: {stage validation result separately from
verified/unresolved/unavailable/conflicting inputs, with dated evidence basis; no unsupported completeness percentage}

**Next gate and version boundary**: {what humans are being asked to review now, what remains
blocked for execution, exact source/published version and approvals that must be renewed after changes}

### Significant Conflicts

| Priority / Why Now | Canonical Reference | Current Status | Review Focus / Next Step |
| --- | --- | --- | --- |
| {risk and dependent scope; maximum five rows} | {CON-ID linked to /specs/feature-directory/requirements/testing-profile.md#evidence-sources-and-conflicts} | {exact register status} | {decision needed, affected scope; link related ACT/AUT action, do not copy competing-claim ledger} |

### Priority Human Actions

| Priority / Why Now | Canonical Reference | Current Status | Review Focus / Next Step |
| --- | --- | --- | --- |
| {dependency/impact ordering; maximum five rows} | {ACT/AUT-ID linked to /specs/feature-directory/requirements/testing-profile.md#human-input-and-decision-register} | {exact register status} | {question/decision, contact/accountable role, needed-by gate and impact via canonical row; do not invent appointment or date} |

**Supporting detail**: [Scope and effort](#scenario-scope-and-automation-effort) ·
[Case mappings](#high-level-case-outlines) · [Asset inventory](#test-assets-and-traceability) ·
[Estimate boundaries](#estimate-scope-and-boundary-reconciliation) ·
[Migration impacts](/specs/{feature-directory}/architecture.md#144-migration-impact-to-test-crosswalk) ·
[All conflicts](/specs/{feature-directory}/requirements/testing-profile.md#evidence-sources-and-conflicts) ·
[All human inputs](/specs/{feature-directory}/requirements/testing-profile.md#human-input-and-decision-register) ·
[Approval boundary](#test-plan-approval-gate).

Replace cross-file feature-directory placeholders with the actual repository-root feature path
or controlled source URL; preserve the same body and local anchors in the published copy.

## Test Strategy

**Authoritative application source**: feature-root `G-test-plan.md`.
**Published deliverable**: `deliverables/G-test-plan.md`, generated from this source by `/speckit.publish`.

**Sources**: `docs/testing-strategy/INDEX.md`, `requirements/testing-profile.md`, approved
`REQ-*`/`NFR-*` records, and `architecture.md` Section 14.1. Testing scope must not be inferred only
from R-Type, and this deliverable must not approve its own exceptions or risks.

### Objectives

- Verify all business capabilities are preserved after migration
- Validate NFR targets are met on target platform
- Confirm security controls are operational
- Ensure operational readiness

### Test Types

| Type | Applicability / R-Type Basis | Scope / Level | REQ/NFR/MIG Traces | Owner / Approver | Environment | Entry Criteria | Exit / Acceptance Criteria | When / Dependency | Results / Evidence | Exception ADR / Risk |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Connectivity | Applicable — universal baseline | {user/system/component positive and negative paths} | {IDs} | {roles} | {env} | {criteria} | {criteria} | {window/gate} | {report/path} | {N/A or ADR/RSK} |
| Unit | {Applicable/Not Applicable — continue existing automated suites; Migration Team implements/extends tests only for migration-changed, impacted code} | {existing suites plus changed-code units and metric} | {IDs} | {roles} | CI/build pipeline; DEV only when approved | {criteria} | {existing suite passes; impacted-code threshold} | Every applicable build | {report/path} | {N/A or ADR/RSK} |
| Data migration verification | {Applicable/Not Applicable — required for every in-scope data movement; N/A only when evidence proves no data moves} | {pre/during/post migration and reconciliation} | {IDs} | {roles} | {env} | {criteria} | {integrity/completeness/tolerance} | Each rehearsal/execution | {report/path} | {N/A with evidence, or ADR/RSK} |
| Migration tool | Applicable — universal baseline | {tool fitness and source validation} | {IDs} | {roles} | {env} | {criteria} | {criteria} | Before migration use | {report/path} | {N/A or ADR/RSK} |
| Application installation | Applicable — universal baseline | {deployment/configuration and post-deploy behavior} | {IDs} | {roles} | {env} | {criteria} | {criteria} | Every applicable deploy | {report/path} | {N/A or ADR/RSK} |
| Smoke/regression | Applicable — universal baseline | {critical/common behavior and regression depth} | {IDs} | {roles} | PPE | {criteria} | {criteria} | Before cutover | {report/path} | {N/A or ADR/RSK} |
| Change-based functional | {Applicable/Not Applicable — resolved migration-change basis} | {for Re-Factor, or lower R-Type with Migration-Team refactoring: changed/refactored components and dependent unchanged components, including integration scenarios} | {IDs} | {Migration Team for its refactoring; otherwise N/A — integration scenarios belong to App-Team UAT} | PPE | {criteria} | {criteria} | {window/gate} | {report/path} | {N/A or ADR/RSK} |
| Full functional | {Applicable/Not Applicable — resolved R-Type basis} | {user-story/end-to-end behavior} | {IDs} | {roles} | {env} | {criteria} | {criteria} | {window/gate} | {report/path} | {N/A or ADR/RSK} |
| Performance and baseline | Applicable — universal baseline | {latency/load/capacity/stress/endurance and equal-volume comparison} | {IDs} | {roles} | PPE | {valid baseline/NFRs/monitoring} | {targets/tolerable variance} | Before cutover | {report/path} | {N/A or ADR/RSK} |
| High availability | Applicable — universal baseline | {component/application failure scenarios} | {IDs} | {roles} | PPE | {production-comparable setup} | {availability/loss/degradation targets} | Before cutover | {report/path} | {N/A or ADR/RSK} |
| Disaster recovery | Applicable — universal baseline | {recovery, dependency failover and normalization} | {IDs} | {roles} | Production | {criteria/change approval} | {RTA/RPA meet RTO/RPO} | Pre-customer cutover | {report/path} | {N/A or ADR/RSK} |
| Security testing | Applicable — universal baseline | {vulnerability/configuration/code/control checks} | {IDs} | {roles} | PPE except approved production checks | {criteria} | {approved findings threshold} | Pre-cutover | {report/path} | {N/A or ADR/RSK} |
| Security penetration testing | Applicable — universal baseline unless exception approved | {production penetration scope} | {IDs} | {LSEG security role / approver} | Production | {authorization/window/entry criteria} | {Critical/High disposition} | Pre-cutover | {report/path} | {N/A or ADR/RSK} |
| Operational acceptance testing | Applicable — universal baseline | {operational readiness scenarios} | {IDs} | {roles} | Production | {criteria/change approval} | {operations acceptance} | Cutover | {report/path} | {N/A or ADR/RSK} |
| User acceptance testing | Applicable — universal baseline; no exemption | {business scenarios and integration scenarios when Migration Team refactoring is not performed; do not duplicate cases already counted under Change-Based Functional Testing} | {IDs} | {LSEG Application Team owns and executes business and applicable integration scenarios} | PPE | {criteria} | {business acceptance/defect threshold} | Before cutover | {report/path} | N/A |
| Migration rehearsal | Section 7A | {MIG sequence, timing, roles and evidence capture} | {IDs} | {roles} | Production-like | {criteria} | {all controls within thresholds} | Before go/no-go | {report/path} | {N/A or ADR/RSK} |
| Rollback/backout | Section 7A | {trigger, authority, traffic/application/data recovery and point of no return} | {IDs} | {roles} | Production-like | {criteria} | {recovery target/evidence} | Before cutover approval | {report/path} | {N/A or ADR/RSK} |
| Client migration / hypercare | Section 7A | {compatibility, adoption, telemetry, incidents, defects and data quality} | {IDs} | {roles} | {pilot/production} | {criteria} | {wave/hypercare acceptance} | {window/gate} | {report/path} | {N/A or ADR/RSK} |

### Scenario Scope and Automation Effort

Consume the profile's Automation Availability Review and Architecture Section 14.3 using
`docs/testing-strategy/automation-review-and-scenario-sizing.md`. Keep this plan high-level:
one sizing row per applicable canonical test type when supported by application evidence; where a
business fact or asset inventory is missing, carry the linked action and mark scope/basis Unknown
rather than inventing cases. Show verified reusable coverage separately from reported or linked
assets and uncovered scope. Unknown automation remains pending Application Team confirmation, never
an assumed negative answer.
Migration and Application Teams jointly deep-dive scenario scope, effort and automation decisions
before baselining; specialized L2/Security ownership remains as prescribed by the LMP strategy.

| Scope Reference | Test Type | Scenario References / Count Band / Basis | Verified Reuse / Uncovered Scope / Review Action | Reuse-Adapt-Build-Manual Decision | Effort Range (person-days): Review / Automation / Setup / Execution / Retest / Report-Handover | Implementation / Execution / Maintenance / LMP Section-RACI | Confidence / Assumptions / Backlog Trace |
| --- | --- | --- | --- | --- | --- | --- | --- |
| {scope reference} | {canonical type; repeat for each applicable type} | {architecture family IDs, proposed/verified counts distinguished and derivation} | {asset/run evidence, coverage gaps, AUT-ID and Application Team response/follow-up} | {reuse/adapt/build scope; reproducible manual portion} | {six separate effort ranges; zero with reason for no work} | {separate roles, ongoing maintenance capacity, exact strategy section and Appendix 5} | {confidence/drivers/exclusions, review gate and backlog item} |

### High-Level Case Outlines

Preserve supplied case identifiers and their source/version/locator. Use stable local IDs only for
proposed outlines. These are reviewable objectives, not detailed scripts or execution evidence.
Use an evidence-backed outline only when the actual component/flow and behavior are known; otherwise
link the owned action that must establish the missing fact. Keep OAT catalog cases in the OAT table
and reference catalog IDs rather than counting them twice. Case disposition is separate from
execution result.

| Case ID | Origin (Supplied / Proposed) | Source Asset / Locator | Test Type / Family / REQ-NFR / Component or Flow | Objective / Preconditions / Data / High-Level Steps | Measurable Expected Outcome | Disposition (Covered / Adapt / Proposed / Excluded / Pending) and Evidence | Environment / Tool / Automation | Owner / Evidence Result Path / Action ID |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| {supplied ID unchanged or stable local CASE-###} | {Supplied / Proposed} | {asset/version/locator or proposed basis} | {canonical type, SCN reference, REQ/NFR and evidenced component/flow} | {objective, preconditions, data and high-level steps; no invented business facts} | {source-backed result or action needed to define it} | {disposition/evidence; do not claim execution} | {environment/tool and verified/proposed/manual} | {accountable role; planned result path or Pending; ACT-### if open} |

Especially for Unit and Performance, expose automation creation/adaptation effort separately
from execution. Developer/performance-engineer availability is not implied by 1/2/3 tester capacity.
Retain existing unit suites; Migration additions cover only migration-changed impacted code.
For performance separately size baseline acquisition/validation, workload scripts, data/telemetry
setup and owner-approved workload execution. Section 4.1 framework recommendation, 2-3 sample
cases and knowledge transfer are conditional and limited to one sprint, not a commitment to build
every missing suite; Application Team adoption, coverage growth and maintenance are separate.
Feed these work packages into elapsed estimates and scheduled backlog, retaining Low confidence
and open review gates where evidence is incomplete.

### Estimated Elapsed Testing Timeline and Capacity

Provide evidence-based elapsed-time estimates for every canonical test type and separately for
optional pre-OAT. Estimates cover the window from agreed scope and entry readiness through
execution, expected defect/retest allowance, reporting and review; show external approval,
procurement, change-window and customer wait time separately. These are planning ranges, not
commitments or effort estimates. Do not add row durations to calculate the end date: record actual
predecessor gates, parallel work, resource/environment conflicts, critical path and dated
assumptions in `plan.md`.

Use capacity scenarios of 1, 2 and 3 active testers. State whether they are dedicated full-time
equivalents and identify specialist and operational contributors separately. Do not scale duration
linearly when constrained by a shared environment, serial data movement, security approval,
Production windows, L2 availability or business-user calendars. For each row record verified case
counts, automation/manual split, reuse/build assumptions, and confidence/rationale. If coverage is
not evidenced, size conservatively as unverified rather than assuming automation exists; re-estimate
when inventory and pilot results are available. State a separate contingency reserve and its basis.

| Test Type / Workstream | Applicability | Case-count and automation basis | Elapsed — 1 tester | Elapsed — 2 testers | Elapsed — 3 testers | Dependencies, overlap, wait time, confidence |
| --- | --- | --- | --- | --- | --- | --- |
| Connectivity | {Applicable / N/A + evidence} | {verified cases; automated/manual; reuse/build} | {range} | {range} | {range} | {entry, overlap, approvals, confidence} |
| Unit | {Applicable / N/A + evidence} | {migration-changed impacted code; existing suite coverage} | {range} | {range} | {range} | {CI cadence, code availability, confidence} |
| Data migration verification | {Applicable / N/A + evidence} | {source count; reconciliation automation/manual split} | {range} | {range} | {range} | {data readiness, serial/parallel work, confidence} |
| Migration tool | {Applicable / N/A + evidence} | {tool/mode cases; automated/manual split} | {range} | {range} | {range} | {access, source window, confidence} |
| Application installation | {Applicable / N/A + evidence} | {target components/environments; IaC/pipeline reuse} | {range} | {range} | {range} | {foundation, environment, confidence} |
| Smoke/regression | {Applicable / N/A + evidence} | {critical-path cases; automated/manual split} | {range} | {range} | {range} | {build/deploy gates, confidence} |
| Change-based functional | {Applicable / N/A + evidence} | {migration-changed functional cases; integration only for Migration-Team refactoring} | {range} | {range} | {range} | {test data, dependencies, shared PPE, confidence} |
| Full functional | {Applicable / N/A + evidence} | {case count and automation basis} | {range or N/A} | {range or N/A} | {range or N/A} | {R-Type basis, confidence} |
| Performance and baseline | {Applicable / N/A + evidence} | {workload scripts, automation coverage, baseline readiness} | {range} | {range} | {range} | {PPE exclusivity, data/tool readiness, confidence} |
| High availability | {Applicable / N/A + evidence} | {HA cases, reusable scripts, manual fault-control steps} | {range} | {range} | {range} | {isolated PPE window, monitoring, confidence} |
| Disaster recovery | {Applicable / N/A + evidence} | {DR cases, runbook automation/manual execution} | {range} | {range} | {range} | {L2 calendar, Production/change window, hard gate, confidence} |
| Security testing | {Applicable / N/A + evidence} | {continuous automated scans plus manual assurance and retest} | {range} | {range} | {range} | {tool/access/findings turnaround, confidence} |
| Security penetration testing | {Applicable / approved exception only} | {authorized scope, specialist execution and remediation/retest} | {range} | {range} | {range} | {security slot and Production authorization waits separately} |
| Operational acceptance testing | {Applicable / N/A + evidence} | {approved OAT scenarios; automation/manual split; L2 capacity} | {4 calendar weeks unless evidence revises} | {4 calendar weeks unless evidence revises} | {4 calendar weeks unless evidence revises} | {Application Operations/L2 Production/Cutover calendar and change windows; do not shorten by assumed tester count} |
| User acceptance testing | Applicable — mandatory for every R-Type | {business case count; automated/manual split; business-user capacity} | {range} | {range} | {range} | {named business users, approval window, hard gate} |
| Migration rehearsal and rollback/backout | {Applicable / N/A + evidence} | {MIG-### sequence, rehearsal and rollback checks; automated/manual split} | {range} | {range} | {range} | {environment/data refresh, cutover gate, confidence} |
| Optional pre-OAT lower-environment rehearsal | Optional — only when Migration Team and Application Team agree | {jointly agreed scenario IDs/count, exclusions, automation/manual split} | {range after scope agreement} | {range after scope agreement} | {range after scope agreement} | {lower environment; agreed scope/window/owner; never substitutes for Production OAT} |

Record the proposed integrated window, not a sum of this table: `{range at 1 tester}` versus
`{range at 2–3 testers}`, including the 4-week L2 OAT block, critical path, overlaps and external
waits. Identify low-confidence drivers and re-estimate after the case-count/automation inventory,
environment rehearsal and named-team calendars are confirmed.

### Estimate Scope and Boundary Reconciliation

State exactly what each estimate includes and excludes. A phase estimate and an end-to-end estimate
are not contradictory until their start/end boundaries, included work, calendars, dependencies and
external waits are compared. Distinguish source-evidenced constraints from proposed estimates;
reconcile changed approved scope by re-estimating rather than silently changing a baseline. Keep
the LMP four-calendar-week Production OAT baseline as an L2 elapsed-time reference unless current
L2 evidence revises it; it is not a whole-project timeline or a confirmed calendar booking.

| Estimate ID / Source | Estimate Kind / Value / Confidence | Start Boundary | End Boundary | Included Phases / Work | Excluded Phases / External Waits | Basis / Scope Version / Evidence | Comparison / Reconciliation / Action |
| --- | --- | --- | --- | --- | --- | --- | --- |
| EST-001 | {phase or end-to-end; effort or elapsed; range/confidence} | {entry event/date or relative point} | {exit event/date or relative point} | {included work and overlap} | {excluded work, calendar, approval or external waits} | {case/family volume, reuse health, capacity, source locator, scope version} | {compatible, incomparable boundaries, source conflict, or ACT-### to confirm} |

### Optional Pre-OAT Scope — Lower Environment

This is an optional rehearsal workstream, not a replacement for the mandatory Application
Operations Production OAT during Cutover and not a new canonical test type. Keep it `Not agreed`
until the Migration Team and Application Team jointly approve the scenario IDs/count, objectives,
lower environment, data/access, owners, entry/exit criteria, automated/manual split and elapsed
window. Record the agreement and linked work in the tables below. If not agreed, state the reason
and leave it unscheduled; do not infer scenario volume or approval.

| Decision field | Proposed value / required agreement |
| --- | --- |
| Current decision | {Not agreed / Agreed / Declined + rationale} |
| Selected OAT scenario IDs and count | {Jointly agreed IDs/count, or Pending} |
| Lower environment and production comparability | {environment, constraints and evidence} |
| Entry/exit criteria, data, access and safety | {readiness and pass/fail criteria} |
| Owners and evidence | {Migration Team / Application Team roles, reports and evidence path} |
| Elapsed window and dependencies | {1/2/3 tester estimate, agreed dates/window, dependencies and confidence} |
| Agreement record | {named Migration and Application approvers, dates and evidence, or Pending} |

### High Availability Test Design

Use `docs/testing-strategy/LMP-Migration-Testing-Strategy.md` Section 7.2. Record:

- Application Owner assessment based on R-Type, failover mechanisms, redundancy, load balancing,
  and implemented resiliency.
- Approved HA goals and success metrics: uptime/SLA, RTO/RPO, redundancy/failover, scalability,
  resource utilization, data loss, and performance degradation. Do not invent thresholds.
- Scope, test types/cases, pass/fail criteria, background load, selected/provisioned tooling, and
  reusable functional/performance automation where suitable.
- Production-comparable PPE configuration, approved SII and plan entry for any material
  production difference, complete monitoring, and prepared test data.
- A safe PPE window with no concurrent activities, named execution/support/approval roles, and
  signed entry/exit criteria. Entry must confirm approved goals/cases/plan, PPE/monitoring, and
  application access. Exit must confirm all HA cases and goals pass, defects are fixed/retested or
  formally risk-accepted, and the HA report and Test Execution Results Report are approved.

### Disaster Recovery Test Design

Use `docs/testing-strategy/LMP-Migration-Testing-Strategy.md` Section 7.3. Production execution by
the LSEG Application L2 Team before customer cutover is the DR acceptance test; lower environments
are rehearsals only. Record:

- Migration Team ownership of DR cases and runbook creation/handover to L2; LSEG employee
  ownership of the DR Coordinator and Technology Owner roles; and the L2 team's readiness and
  execution role.
- Production recovery steps and all plausible failure scenarios, including dependency failover
  while the application/cloud hosting environment remains in place.
- Entry approval, understood recovery plan and objectives, fully provisioned Production setup
  (including authentication/authorization), representative test data, selected tools, trained team,
  and configured/in-sync backup systems.
- Exit measures for RTA <= RTO and RPA <= RPO; restored-data integrity/accuracy; critical
  functionality; tested failback and recovery normalization; completed test documentation and
  technical/process learnings;
  resolved/retested defects or authorized LSEG risk acceptance; results report, evidence link,
  and standard deliverable sign-off.

### Operational Acceptance Test Design

Use `docs/testing-strategy/LSEG-L2-OAT-Game-Day-Scenario-Catalog.md` and the approved
Architecture Section 14.2 matrix; invoke `oat-scenario-planning`. Keep one row for every catalog
ID, preserving the architecture disposition. For each recommended scenario, complete the as-is
and target mapping, executable steps, measurable expected result, environment and change approval,
stop/recovery controls, Operations owner, runbook and evidence. `Not applicable` requires evidence;
unknown is a blocker. Source statuses and tooling examples are not test results or current approvals.
Per the LMP strategy, Application Operations executes/accepts OAT in Production during Cutover.
Destructive Production/DR actions also require explicit authorization and safeguards. OAT does not
replace HA, DR, UAT, or other test obligations.

| Catalog ID | Scenario | Disposition | As-is evidence | Proposed Azure target / applicability | Executable steps and expected outcome | Environment / change approval / stop-recovery | Operations owner / runbook / evidence / status |
| --- | --- | --- | --- | --- | --- | --- | --- |
| L2-OAT-GD-01 | Availability-zone failover | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-GD-02 | VM interruption during request | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-GD-03 | Container interruption during request | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-GD-04 | Serverless concurrency limit | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-GD-05 | Database zone failure | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-GD-06 | High-concurrency stress and recovery | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-GD-07 | Storage internal errors | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-GD-08 | Messaging region failure | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-GD-09 | Third-party dependency outage | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-GD-10 | Application smoke | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-GD-11 | AKS upgrade and conditional key rotation | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-GD-12 | IaC no-change drift check | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-GD-13 | Production deployment operational checks | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-GD-14 | Critical workflow SLO breach alert | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-GD-15 | Upstream service-level breach alert | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-GD-16 | Server/container resource threshold alert | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-GD-17 | Serverless resource/timeout alert | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-GD-18 | Database backup failure alert | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-GD-19 | Storage capacity threshold alert | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-GD-20 | Log levels and error quality | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-GD-21 | Incident communications | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-GD-22 | Account/service quota threshold alert | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-GD-23 | Database point-in-time/backup restore | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-GD-24 | Object restore | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-CHG-01 | Recreate application IaC stack | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-CHG-02 | Golden-image refresh (self-managed compute) | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-CHG-03 | Database schema deployment | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-CHG-04 | Infrastructure deployment rollback | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-CHG-05 | Blue/green application deployment | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-CHG-06 | Application deployment rollback | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-CHG-07 | Database deployment rollback | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-CHG-08 | Vertical VM scaling | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-CHG-09 | Add disk/extend LVM capacity | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-VAL-01 | DR documentation and RTA/RTO evidence | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-VAL-02 | Encryption at rest/in transit | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-VAL-03 | Infrastructure/production access control | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-VAL-04 | Access approver groups and reviews | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-VAL-05 | Logging compliance | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-VAL-06 | Password rotation/secrets management | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-VAL-07 | Certificate uniqueness and renewal | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-VAL-08 | Third-party vulnerabilities/licensing | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-VAL-09 | One Policy Engine pipeline/report | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-VAL-10 | Terraform module scan/CPF drift | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-VAL-11 | Mandatory resource tagging | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-VAL-12 | Runbook and support contacts | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-VAL-13 | Manual operational activities/RAID | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-VAL-14 | CloudOps onboarding checklist | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-VAL-15 | Datadog monitor hygiene | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-VAL-16 | DML/technical debt and SIIs | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-VAL-17 | Azure account/subscription outage | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
| L2-OAT-VAL-18 | Third-party outage response | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |

### Minimum Viable Testing

| Applicability | Trigger / Evidence Gap | Mandatory Minimum Scope | Approval / Exception | Exit Evidence |
| --- | --- | --- | --- | --- |
| {Not Applicable/Proposed/Approved} | {why full cases/specifications cannot be supplied, or evidence that full scope applies} | {Application installation, data migration verification when data moves, connectivity, additional risk-driven tests; explicitly state UAT remains mandatory and is not waived} | {named LSEG approver + ADR/RSK, or N/A with rationale} | {specific reports/evidence} |

MVT is a governed fallback, not a default scope-reduction mechanism. It does not waive UAT or any
test whose omission lacks an approved Test Exception.

### Automation Strategy and Ownership

| Scope / Repository | Existing Automation | Migration Change Impact | Build / Pipeline Execution | Framework / Tool Decision | Implementation Owner | Ongoing Maintenance Owner | MEC/GCF / Exception Evidence |
| --- | --- | --- | --- | --- | --- | --- | --- |
| {suite/component} | {repository/path + version/commit, or None — evidence} | {unchanged/impacted code/new migration code} | {named CI/build pipeline stage, frequency and report} | {named approved framework/tool or approved candidate} | {role/team} | {LSEG application role/team} | {MEC/GCF evidence, ADR/RSK, or evidence-backed N/A} |

Existing automated suites continue for every migration. The Migration Team adds or changes unit
tests only for code it changes during migration, scoped to impacted code. Test code is maintained
and governed like application code.

### RACI

| Test Type / Activity | Migration Team | Migration Test Team | LSEG Application Team / Owner | LSEG L2 / Operations | LSEG Security | Named Deliverable Approver |
| --- | --- | --- | --- | --- | --- | --- |
| Connectivity | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {role; name resolved before approval} |
| Unit | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {role; name resolved before approval} |
| Data migration verification | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {role; name resolved before approval} |
| Migration tool | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {role; name resolved before approval} |
| Application installation | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {role; name resolved before approval} |
| Smoke/regression | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {role; name resolved before approval} |
| Change-based functional | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {role; name resolved before approval} |
| Full functional | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {role; name resolved before approval} |
| Performance and baseline | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {role; name resolved before approval} |
| High availability | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {role; name resolved before approval} |
| Disaster recovery | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {role; name resolved before approval} |
| Security testing | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {role; name resolved before approval} |
| Security penetration testing | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {role; name resolved before approval} |
| Operational acceptance testing | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {role; name resolved before approval} |
| User acceptance testing | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {R/A/C/I/N/A} | {role; name resolved before approval} |

Every applicable test type and deliverable approval must have exactly one accountable role and at
least one responsible role. Do not fabricate individual names.

Integration is scenario scope, not a separate test type or RACI row. Assign integration scenarios to
Change-Based Functional Testing when the Migration Team performs refactoring; otherwise assign them
to mandatory UAT under the LSEG Application Team. UAT remains mandatory in both cases.

### Test Assets and Traceability

Keep reported availability separate from verified reuse health. A framework, repository link or
catalog listing is not proof that a compatible suite runs or covers the proposed target. Only a
dated run/result or equivalent evidence supports `Verified-available`; zero verified cases is a
valid, explicit finding.

| Asset ID | Asset Type / Supplied Case IDs | Version / Locator / Owner | Availability (Reported-linked / Available-unverified / Verified-available / Unavailable / Unknown) | Reuse Health (Reuse / Adapt / Build / Manual / Excluded / Undecided) | Verified Coverage / Gaps / Families | Last Run / Result Locator | Compatibility / Applicability Evidence | Maintenance / Retention / Action ID |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| AST-001 | {test plan/case/script/baseline/data/tool/result/environment; preserve IDs} | {version/path/contact} | {availability state and evidence} | {reuse decision, separate from availability} | {verified counts/families and uncovered scope} | {dated result or Not run} | {fit evidence or Unknown} | {owner/retention and ACT-### or N/A with reason} |

### Environment Strategy

| Environment | Purpose / Test Types | Production Comparability | Monitoring | Data / Identity / Access Controls | Temporary Capacity / Cost / Scale-down | Deviation ADR / Risk |
| --- | --- | --- | --- | --- | --- | --- |
| {env} | {purpose/tests} | {region/topology/size/config comparison} | {telemetry} | {data/accounts/secrets/privacy} | {event and return to baseline} | {N/A or ADR/RSK} |

### Entry/Exit Criteria

| Gate | Entry Criteria | Exit Criteria |
| --- | --- | --- |
| Start Testing | {criteria} | — |
| Performance Testing | {criteria} | {targets met} |
| Security Testing | {criteria} | {no critical findings} |
| UAT | {criteria} | {business sign-off} |
| Production | {criteria} | {all tests pass} |
| Migration Rehearsal | {production-like data/config/routes and rollback prerequisites ready} | {all MIG controls evidenced within thresholds} |
| Cutover Go/No-Go | {rehearsal accepted; reconciliation and rollback evidence current} | {named authority records Go/No-Go outcome} |
| Hypercare Exit | {target live and monitored} | {Section 7A thresholds sustained; operational/data-owner acceptance recorded} |
| Decommission Eligible | {hypercare exited; dependencies and retention known} | {separate source-removal authorization evidence complete} |

### Defect Management

| Severity | Response Time | Resolution Time | Blocks Cutover? |
| --- | --- | --- | --- |
| Critical (P1) | Immediate | {hours} | Yes |
| High (P2) | {hours} | {days} | Yes |
| Medium (P3) | {hours} | {sprint} | No |
| Low (P4) | {days} | {backlog} | No |

Every unresolved defect that crosses an approved exit/acceptance threshold requires documented
risk acceptance by an authorized human. Preserve test-case-to-defect links and retest evidence.

### Exceptions, Dependencies and Approvals

| Item | Trigger / Gap | Decision / Risk | Owner | Required Action / Evidence | Due / Gate | Human Outcome |
| --- | --- | --- | --- | --- | --- | --- |
| {test exception/dependency/delay/approval} | {condition} | {ADR/RSK/SII/ADO reference} | {role/team} | {action/evidence} | {date/gate} | {Pending/approved outcome with reviewer/date} |

### Test Plan Review and Approval

The complete Test Plan, including scope, timeline, assumptions, capacity, optional pre-OAT
recommendation and outstanding risks, must be reviewed and approved by all four delivery parties
below before the overall Test Plan is marked Approved or used as an execution baseline. Record an
individual's name, decision date, outcome and evidence link for each approval. Pending is not
approval. Additional Security, business, change or Production authorizations remain required where
applicable.

| Required reviewer organization | Review focus | Named reviewer | Decision date | Outcome | Evidence / comments |
| --- | --- | --- | --- | --- | --- |
| Migration Team | Migration scope, dependencies, schedule, readiness and delivery ownership | {name / Pending} | {YYYY-MM-DD / Pending} | {Pending / Approved / Changes requested} | {link / Pending} |
| Migration Testing Team | Test design, automation, case inventory, estimates, evidence and execution readiness | {name / Pending} | {YYYY-MM-DD / Pending} | {Pending / Approved / Changes requested} | {link / Pending} |
| Application Team | Business scope, application assumptions, test data, available SMEs, optional pre-OAT agreement and acceptance | {name / Pending} | {YYYY-MM-DD / Pending} | {Pending / Approved / Changes requested} | {link / Pending} |
| L2 Operations | Operational scenarios, runbooks, OAT/DR ownership, Production windows and four-week OAT plan | {name / Pending} | {YYYY-MM-DD / Pending} | {Pending / Approved / Changes requested} | {link / Pending} |

## Test Plan Approval Gate

- [ ] Every testing-profile row is represented and traced to REQ/NFR records
- [ ] No standalone Integration Testing row is created; integration scenarios follow the Migration-Team-refactoring versus App-Team-UAT split, with UAT mandatory in either case
- [ ] Every applicable test has scope, environment, entry/exit criteria, evidence and RACI
- [ ] HA includes Section 7.2 goals, assessment, cases, PPE, monitoring/data, isolated window and signed exit evidence
- [ ] DR includes Section 7.3 Production acceptance, L2/runbook ownership, dependency scenarios, RTA/RPA, failback, evidence and sign-off
- [ ] Every exception has an approved human decision and linked risk treatment; UAT has no exception
- [ ] Test preparation, execution, remediation, reporting and approval are scheduled in `plan.md`
- [ ] Estimated elapsed timeline covers every applicable test type, 1/2/3-tester capacity, automation evidence, dependencies, overlaps, confidence and contingency
- [ ] Optional lower-environment pre-OAT is separately identified and scheduled only after Migration and Application Teams agree scenario count and duration
- [ ] Migration Team, Migration Testing Team, Application Team and L2 Operations have each approved this exact Test Plan version
- [ ] Named deliverable approver approved this exact version after all four organizational approvals

**Reviewed by**: {name} | **Date**: {YYYY-MM-DD} | **Outcome**: {Approved / Changes requested}
<!-- This approval is completed only by the named human deliverable approver. -->
<!-- End of canonical Test Plan template. -->
