---
name: oat-scenario-planning
description: "Turn the architecture OAT scenario applicability matrix into safe, executable, evidence-producing Operational Acceptance Test cases and scheduled work. USE FOR: OAT runbook scenarios, Game Day plan, operations acceptance cases, Cutover test preparation. Invoked by plan-testing. DO NOT USE FOR: deciding Azure architecture, executing disruptive tests, or approving production changes."
argument-hint: "Invoked with the reviewed OAT applicability matrix, approved design, application owners, and cutover controls"
---

# Planning Subskill: OAT Scenario Planning

Turn the reviewed OAT scenario design into application-specific cases in the canonical
`G-test-plan.md` Operational Acceptance Test Design section and into preparation, execution,
evidence, remediation, and approval work in the delivery plan. Do not infer that a scenario passed
from a proposed plan or source-template status.

## Required inputs

- Reviewed OAT matrix from `oat-scenario-design`, including evidence, applicability, Azure target
  mappings, blockers, and ownership.
- `docs/testing-strategy/LSEG-L2-OAT-Game-Day-Scenario-Catalog.md` and
  `docs/testing-strategy/INDEX.md`.
- Approved architecture and target service inventory, applicable requirements, runbooks,
  environment and monitoring design, change/production policy, cutover schedule, and RACI.
- Named operational and application owners, approved test-data/access prerequisites, repositories,
  current pipeline/tool validation, defect/SII/RAID process, and evidence-retention location.

## Plan

Carry forward every scenario disposition and stable catalog ID. Reconcile scenario IDs with existing
OAT cases, HA/DR cases, implementation tasks, defects and evidence. Do not double-count the same
case; preserve distinct objectives and acceptance for each test type.

## Act

For each Recommended or resolved Conditional scenario, define:

1. Scenario ID, source pillar, application-specific title, operational objective, affected service
   and critical user/service flow.
2. As-is baseline and approved Azure target mapping, including what differs and which target
   mechanism is actually available.
3. Preconditions and health baseline: deployed version/IaC revision, dependencies, test identities,
   data, telemetry, support participants, on-call/escalation, backup/recovery readiness, and
   runbook links.
4. Test environment (Production or DR only with explicit approval; otherwise approved production-
   like environment), normal/pre-authorized/change classification, change owner/reference, approved
   window, impact boundary, communications, stop conditions, rollback/recovery plan, and clean-up.
5. Reproducible steps or approved pipeline/job; expected results and measurable pass/fail criteria;
   actual result; telemetry, logs, screenshots, links and timestamps; status (`Not Started`,
   `In Progress`, `Passed`, `Failed`, `Inconclusive`, or evidence-backed `Not Applicable`).
6. Responsible executor, accountable Application Operations/Application Owner, consulted Migration
   Team and other roles, defect/remediation owner, approver, evidence repository, and dependency.
7. Preparation, execution, issue resolution/retest, evidence publication and sign-off task with
   phase, estimated elapsed duration, dates when known, dependencies, capacity/automation
   assumptions and risk/SII/RAID trace.

Keep separate subsections or labels for:

- Game Day/reliability/monitoring/durability scenarios.
- Standard-change scenarios requiring normal change approval and lead time.
- Validation-only scenarios that do not inherently change a system.

Use the source's Azure examples only as candidate references. Validate current resource support,
tooling, access, policy and job availability. Do not assume a chaos experiment, LSEG CI template,
Azure service health integration, Datadog monitor, or restore workflow exists or is approved.

Per the LMP Testing Strategy, OAT is carried out by the Application Operations Team during Cutover
in Production. Reconcile this baseline with the Game Day catalog's environment recommendations,
normal/pre-authorized changes, and application-specific safety approvals. Do not silently move
mandatory production acceptance to a lower environment; if blocked, record the governance decision
and readiness gap. The Migration Team supports execution, collates results/evidence, and fixes
assigned migration issues per the applicable RACI. Do not assign LSEG operational sign-off to the
Migration Team.

Plan elapsed time separately from tester effort. Use four calendar weeks as the Application
Operations/L2 Production OAT baseline unless current L2 evidence supports a different duration;
include case preparation, agreed execution windows, reporting and review in the estimate, and
record any external booking/change-approval wait separately. Do not shorten this baseline by
assuming additional testers. Estimate 1/2/3-active-tester scenarios for other test streams from
verified case counts and automation/manual split, and preserve Production safety, scarce specialists
and shared-environment constraints.

If proposing a lower-environment **Pre-OAT rehearsal**, mark it optional and separate from the
mandatory Production/Cutover OAT. Schedule it only after Migration and Application Teams jointly
agree scenario IDs/count, environment, readiness criteria, owner and duration. It must not replace
or waive Production OAT, HA, DR, UAT or another required test.

Before the Test Plan is Approved, collect named, dated, evidence-backed approval for the same plan
version from Migration Team, Migration Testing Team, Application Team and L2 Operations. Their
review does not grant the separate Security, change, business or Production authorization needed
for specific execution.

## Review

- All scenarios have exactly one explicit applicability/status and link back to their source IDs.
- Applicable scenarios have concrete steps, testable expectations, safe environment and change
  authorization, support/runbook, evidence, RACI and recovery/stop conditions.
- Non-applicability is supported by evidence; unknown target capability or source access remains an
  owned blocker.
- Game Day does not substitute for HA/DR or other independent testing and does not waive UAT.
- Statuses and results reflect actual execution evidence; no scenario is marked Passed from design
  alone.
- Every required OAT activity is scheduled in the appropriate Testing, Pre-Cutover or Cutover
  phase, respecting Production OAT timing, LSEG operational ownership, named approval and
  dependencies.
- The L2 Production OAT estimate uses the four-calendar-week baseline or an evidenced alternative;
  optional lower-environment pre-OAT is jointly scoped and separately scheduled without substituting
  for mandatory Production OAT.
- OAT elapsed duration, tester capacity, automation coverage and external scheduling waits are
  explicit and consistent with the integrated Test Plan timeline.
