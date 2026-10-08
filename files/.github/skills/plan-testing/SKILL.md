---
name: plan-testing
description: "Build the application migration Test Plan from approved testing REQ/NFR records and architecture testability decisions. USE FOR: test plan, test schedule, RACI, entry/exit criteria, defect management, test evidence, exceptions, approvals. Invoked by /speckit.plan. DO NOT USE FOR: inventing requirements, changing architecture, or approving exceptions."
argument-hint: "Invoked by /speckit.plan with approved requirements, architecture, migration controls, and delivery schedule"
---

# Planning Domain: Application Test Plan

Owns the canonical feature-root application source `G-test-plan.md`. `/speckit.publish` publishes
its full-fidelity, versioned view as `deliverables/G-test-plan.md`; the view is generated from the
root source and is never edited independently. `plan.md` contains only its handoff, schedule,
dependencies and critical-path integration; it must not duplicate the per-test matrix.
The skill translates approved obligations and design into executable work without relaxing
requirements or redesigning the target.

## Required Inputs

- Testing-related `REQ-*`/`NFR-*` records and their verification methods.
- Architecture testability review, component/flow inventories, Section 7A `MIG-*` controls,
  Section 12 monitoring/recovery/SDLC design, Section 13 test capacity/cost rows, and approved R-Type.
- Existing app test assets, baselines, environments, data, tools, owners, approvers, windows, and
  evidence repository details.
- `docs/testing-strategy/INDEX.md`, source Sections 7.2 (High Availability Testing) and 7.3
  (Disaster Recovery Testing), other relevant source sections, and `G-test-plan.md`.
- The reviewed Architecture Section 14.2 OAT matrix, `docs/testing-strategy/LSEG-L2-OAT-Game-Day-Scenario-Catalog.md`,
  and the `oat-scenario-planning` subskill.
- Evidence-backed test case counts, automation/manual coverage, available Migration/Migration
  Testing/Application/L2 capacity, working calendar, specialist availability, test windows and
  expected external approval/change lead times. If any are unavailable, mark the estimate Low
  confidence and record the assumption/owner rather than silently filling the gap.

## Plan

Resolve every applicable test type into scope, level/coverage, cases/scenarios, owner, environment,
data/access, tooling/automation, entry criteria, exit criteria, acceptance criteria, evidence,
approval, estimated elapsed duration/window, and predecessor/gate. Estimate each applicable test
stream for 1, 2 and 3 active testers, based on observed/proposed automation coverage, case counts,
case complexity, specialist bottlenecks, and operational/customer availability. Separate elapsed
time from person-effort and separate external wait/approval time from execution. Unknowns remain
explicit planning dependencies with owner, lead-time assumption, contingency, and linked ADR/risk.
Do not assume that adding testers reduces elapsed time linearly or that unverified automation
coverage exists.

Use automated execution as the target for unit, connectivity and performance/load testing.
Integration is scenario scope, not a standalone test type. Put integration cases in
Change-Based Functional Testing when the Migration Team performs refactoring, including refactoring
within Re-Host/Re-Platform. Otherwise include them in mandatory UAT, owned and executed by the
Application Team. Preserve UAT in either branch and avoid duplicate scenario counts. Integration
and smoke/regression/functional testing may be semi-automated; identify automated and manual
portions separately, keep manual cases reproducible and evidence-producing, and assign
implementation/execution/maintenance using the approved R-Type-informed RACI. Any automation gap is
scheduled migration work linked to its readiness risk until evidence proves closure.

## Act

Apply `docs/testing-strategy/automation-review-and-scenario-sizing.md`. Consume the per-test
Application Team automation-review ledger, shared human-input actions, asset availability/reuse
inventory, and Architecture Sections 14.3-14.4. Preserve source case IDs and trace migration
impacts to covered/proposed/excluded/pending test scope. Keep the Test Plan
high-level but populate Scenario Scope and Automation Effort for every applicable test type:
family/count bands, verified reusable and uncovered scope, reuse/adapt/build/manual decisions,
person-day effort ranges for deep-dive review, automation, setup, execution, defect/retest,
reporting/handover, maintenance capacity, assumptions/confidence and backlog traces.
Separate automation development from test execution and the 1/2/3-tester elapsed estimates;
developers/performance engineers are not assumed to be supplied by tester capacity.
Schedule unanswered Application Team reviews and jointly review scope/effort before baselining.
Use the LMP strategy's exact test section and Appendix 5 for implementation/execution/maintenance
roles; preserve conditional one-sprint automation enablement, migration-changed unit scope and
Application Team ongoing coverage/maintenance. For performance separately size LSEG baseline
provision, Migration baseline validation, script reuse/adaptation/build and owner-approved workload
execution. Never treat a missing suite as a blanket Migration Team build obligation.

Populate `G-test-plan.md` with:

0. a one-page `Review Brief` after metadata: proposed scope/exclusions and maturity, evidence
   basis/confidence, artifact quality separately from input completeness, and next gate/exact-version
   boundary. Rank at most five significant CON conflicts and five ACT/AUT human actions by
   material risk/dependency, linking their canonical rows and exact status rather than duplicating
   registers. Surface decision/contact/coordinator/needed-by/impact via those links; use
   `None — reason` for empty lists. Link scope, case mappings, assets, estimate boundaries,
   architecture crosswalk, full registers and approvals. Do not open with the whole case catalog;
1. objectives, scope, exclusions, approved R-Type, and requirement traces;
2. one row per strategy test type, including conditional branches and approved exceptions;
3. test case/version/requirement/defect traceability and automation ownership;
4. environment, monitoring, identity/access, test-data/privacy, and production-test controls;
5. entry, exit, acceptance, go/no-go, and deliverable approval gates;
6. RACI using application roles rather than fabricated person names;
7. defect lifecycle, severity/priority, remediation/retest, unresolved-defect thresholds;
8. results reports, central evidence paths, retention, completion reporting, and audit readiness;
9. delays, dependencies, escalation, exception decisions, risks, SIIs where externally required;
10. scheduled preparation/execution/remediation/reporting/approval work in authoritative backlog
    phases, with explicit capacity scale-up/down and temporary cost where applicable.
11. an estimated elapsed testing timeline covering each applicable test type, one/two/three-tester
    capacity scenarios, verified case count and automation/manual split, duration confidence,
    dependencies, environment/production windows, parallelism, external waits, critical path and a
    separately explained contingency reserve.

### Elapsed-time, capacity and pre-OAT planning

Populate `Estimated Elapsed Testing Timeline and Capacity` with evidence-based ranges from scope
confirmation and entry readiness through preparation/automation adaptation, execution, expected
defect/retest allowance, reporting and review. Explicitly state what is excluded (for example,
security booking, Production/change approval, access provisioning or customer response lead time).
Use the current case-count and automation evidence; a framework or test file is not proven reusable
automation until its scope, run result and owner are verified. Where counts or automation are
unknown, make a conservative, Low-confidence estimate and schedule validation/pilot work to
re-estimate.

Show estimates for 1, 2 and 3 active testers and separately identify L2 Operations, Security,
Application SMEs and business-user capacity. Do not scale durations linearly; preserve serial
dependencies, production windows, scarce specialists, shared environments, data restore/refresh and
approval gates. `plan.md` derives an integrated calendar from dependencies and overlaps rather than
summing test rows. Record dates only when a start date/calendar is evidenced; otherwise use relative
weeks, duration range, owner and needed-by assumption. Reserve explicit contingency for identified
uncertainty instead of burying it in test effort.

Use a four-calendar-week elapsed baseline for Application Operations/L2 Production OAT unless
current L2 evidence supports a different estimate. Do not compress this based only on assigning
more testers. Keep an optional **Pre-OAT lower-environment rehearsal** as a separate work item from
mandatory Production/Cutover OAT. Schedule it only after Migration and Application Teams jointly
agree scenario IDs/count, entry criteria, owner, lower environment, automation/manual split and
timeline. It does not replace or waive Production OAT, HA, DR or UAT.

The completed Test Plan requires recorded approvals from the Migration Team, Migration Testing
Team, Application Team and L2 Operations before its overall status becomes Approved or execution
baseline. Capture named reviewer, decision date, outcome and evidence for each; keep every approval
Pending until actually given. Additional Security, business, change and Production authorizations
remain independent gates.

Complete an evidence-bounded proposal even when human inputs remain open. Keep exact questions,
expected evidence/location, contact/coordinator, needed-by gate, trace links, blocking impact,
status and actual answer in the shared register; do not infer answers or duplicate AUT actions.
Supplied test assets and cases are not reusable/verified solely because a link, catalog or
framework exists. Use proposed case outlines only when source behavior supports them; otherwise
retain the owned action instead of inventing application cases. Reconcile estimates by start/end
boundary, included/excluded phases and external waits before comparing durations; preserve scope
differences rather than forcing estimates to match.

Validate an evolving source with `validate-test-plan.ps1 -ValidationStage Draft`, then
`-ValidationStage ReadyForReview` when preparing the human review handoff. Neither stage approves
the plan or clears execution gates. Existing task-generation and prerequisite callers retain the
default strict `Execution` stage, which requires Approved status and existing organizational
approvals; never pass a looser stage to bypass that gate.
Draft/ReadyForReview may retain Conditional/Blocked architecture readiness and pending approver
roles only with relevant owned actions, ADR/risk trace, contact/coordinator and needed-by gate.
Human names and Ready environments are Execution prerequisites, not document-review prerequisites.
ReadyForReview requires the linked Review Brief; missing legacy Draft navigation is a warning.

### OAT scenarios

Invoke `oat-scenario-planning` with the reviewed Section 14.2 matrix. In `G-test-plan.md`'s
Operational Acceptance Test Design, disposition every catalog ID once and convert recommended
scenarios into reproducible cases with measurable outcomes, approved environment/change class,
Production safety controls, operations RACI, runbook, telemetry, evidence, remediation and
approval. Use source pipeline/tool examples only after validating current availability and approval.
Schedule OAT with Application Operations in Production during Cutover per the LMP strategy; any
production/DR disruption additionally requires explicit change authority, impact boundaries,
communications, stop conditions and recovery readiness. Keep OAT distinct from HA/DR/UAT acceptance.

For High Availability, the Test Plan must include the Application Owner's R-Type-informed
assessment; approved availability/SLA, RTO/RPO, redundancy/failover, scalability, and resource
utilization goals; test scope/types and cases; pass/fail criteria; background load; tooling;
production-comparable PPE; any approved SII for a material environment difference; monitoring;
prepared test data; an isolated PPE execution window; and signed entry/exit criteria. The Migration
Team prepares and conducts the HA tests, with the Application Team providing guidance/support and
the named approver signing the results.

For Disaster Recovery, the plan must identify Production as the acceptance environment and schedule
the LSEG Application L2 Team's execution before customer cutover; lower-environment runs are
rehearsals only. Define the Migration Team-owned DR runbook creation and handover to L2, LSEG DR
Coordinator and Technology Owner, all plausible failure scenarios (including dependency failover while the
application/cloud hosting environment remains in place), Production entry prerequisites, recovery
tools/data/backup readiness, and standard approval. Exit criteria must measure RTA against RTO and
RPA against RPO, validate data integrity/accuracy and critical functionality, test failback and
normalization, resolve/retest defects or record authorized LSEG risk acceptance, and retain the
results report, technical/process learnings, and evidence in the approved repository.

Update `plan.md`'s Application Test Plan Handoff with the canonical path, status, requirement and
architecture sources, schedule integration, exception/risk links, and approval state.

UAT remains mandatory. Other omissions or partial execution require a Proposed exception ADR and
human decision; the plan cannot approve its own exception or risk acceptance.

## Review

- Every testing REQ/NFR appears in at least one test row and evidence output.
- Every applicable strategy test type has a complete execution and approval path.
- No standalone Integration Testing row exists; scenarios follow the Migration-Team-refactoring
  versus Application-Team-UAT split, and UAT remains mandatory.
- Unit, connectivity and performance/load plans are automated; permitted semi-automated integration
  and smoke/regression/functional plans identify their automated/manual split and RACI ownership.
- Environment placement follows the approved design; any deviation is governed before execution.
- Production-only DR, penetration, and OAT constraints are explicit and scheduled safely.
- HA includes all Section 7.2 goals, prerequisites, isolated PPE execution, and exit evidence; DR
  includes Section 7.3 Production acceptance, L2/runbook ownership, dependency scenarios,
  RTA/RPA, failback, defects, evidence and approval.
- Test work appears in the delivery schedule, critical path, dependency register, cost/capacity
  events, and later task handoff.
- Estimated elapsed timeline covers every applicable test and 1/2/3-tester scenarios, is adjusted
  for verified automation and case volume, separates execution from external waits, demonstrates
  realistic overlaps/serial bottlenecks, and carries a justified contingency reserve.
- Production OAT retains its four-calendar-week L2 baseline unless evidenced otherwise. Optional
  lower-environment pre-OAT has an explicit scenario-count/timing agreement by Migration and
  Application Teams and never substitutes for mandatory Production OAT.
- Migration Team, Migration Testing Team, Application Team and L2 Operations approvals are all
  recorded for the same Test Plan version before it is marked Approved.
- Named human approval remains outstanding; successful execution alone does not clear the gate.
- When G-3 has publication metadata, Test Plan content changes require `/speckit.publish`; its
  version increments only after rendering/finalization, and approval is bound to that exact version.
