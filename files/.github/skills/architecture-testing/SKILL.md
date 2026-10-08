---
name: architecture-testing
description: "Review the assembled target architecture for migration testability and treatment-specific testing coverage. USE FOR: architecture testability review, test environment design assurance, performance/HA/DR/security/OAT/UAT enablement, R-Type testing matrix validation. Invoked by /speckit.architecture during Review. DO NOT USE FOR: selecting the R-Type, writing requirements, or producing the Test Plan."
argument-hint: "Invoked after the eight architecture layers and provisional Section 8 R-Type recommendation are assembled"
---

# Architecture Review Skill: Migration Testability

This is a cross-layer Review skill, not a ninth design layer. It checks whether the assembled
architecture can satisfy indexed testing REQ/NFR records and the LMP strategy. It may send a gap
back to the owning layer; it does not independently redesign that layer.

## Required Inputs

- `requirements/index.md` and all testing-related REQ/NFR records.
- Available discovery report, application plans/catalogs, source-code/test-repository evidence,
  and run reports. These are evidence candidates, not mandatory inputs when absent; framework
  presence alone is not enough to claim production-ready coverage. Track missing sources as owned
  questions and keep the architecture reviewable without fabricating business facts.
- Assembled architecture Sections 2–7A and 12–13 plus the provisional Section 8 R-Type.
- `docs/testing-strategy/INDEX.md` and only the relevant extracted source sections.
- `docs/testing-strategy/LSEG-L2-OAT-Game-Day-Scenario-Catalog.md` and the OAT-specific
  `oat-scenario-design` subskill.
- Applicable MEC, GCF, DevSecOps, resilience, security, data, transition, ADR, pattern, and CPF
  sources already used by the owning architecture layers.

## Plan

Build a testability checklist keyed by requirement ID, test type, owning layer, target component,
environment, mechanism under test, observability/evidence path, identity/data prerequisite, and
approval dependency. Resolve the strategy's conditional test branches from the provisional R-Type
only after the target design has independently produced that recommendation.

Do not create an independent Integration Testing row. Ensure the functional/UAT design supports
integration scenarios in Change-Based Functional Testing when the Migration Team performs
refactoring (including within Re-Host/Re-Platform); otherwise ensure mandatory UAT supports them
under Application-Team ownership. Preserve UAT in either branch and avoid duplicate cases.

## Act

Apply `docs/testing-strategy/automation-review-and-scenario-sizing.md` and consume the profile's
Evidence Sources and Conflicts, Test Asset Inventory, shared Human Input and Decision Register,
and Automation Availability Review. Populate Sections 14.3 and 14.4 with high-level, application-specific
scenario families for every applicable/conditional test type, especially None/Partial/Unknown
automation. Keep pending Application Team questions open while proposing evidence-grounded scope.
For each family show stable reference, test type, REQ/NFR/component/flow evidence, expected
outcome, environment/data needs, verified reuse versus proposed adaptation/build/manual scope,
proposed volume band/derivation/confidence and review-action trace. Define implementation,
execution and maintenance separately with exact LMP section/RACI references. Migration and
Application Teams must deep-dive scope and automation effort before baselining.
Prioritize changed-unit success/boundary/error/mocking families and owner-selected performance
workloads/baseline/script gaps; preserve Section 4.1's one-sprint enablement limit and Section 6.2's
impacted-code boundary. Never assign full legacy-suite creation to Migration by default.
Reference Section 14.2 for OAT details without duplicate counts. Proposals are not executed
cases, confirmed automation or detailed scripts.

In Section 14.4, reconcile each evidenced source component/store/interface/flow to its exact target
disposition, data/state movement, changed and dependent unchanged behavior, REQ/NFR, scenario family
or supplied case, and Covered/Proposed/Excluded/Pending evidence disposition. Include retirement
dependency and rollback checks; an unknown inventory remains a tracked action, not an invented
component or case. Carry these local trace IDs and action IDs into the Test Plan rather than
claiming generic coverage.

Review and route gaps to the owning design:

- Compute/data/integration/networking: installation, connectivity, migration-tool, data migration,
  representative workload, negative-path, and component-failure testability.
- Security: identities, authorization cases, test-data protection, scanning/review/penetration
  constraints, production-test controls, and Critical/High remediation evidence.
- Resilience: performance monitoring, HA fault injection/failover, DR and normalization, RTA/RPA,
  OAT evidence, and CI/CD test execution/report retention.
- Transition: UAT, rehearsal, reconciliation, go/no-go, rollback, and acceptance evidence.
- Cost: temporary production-like capacity, test windows, scale-up/down, tooling/licensing, and
  evidence-retention costs.

Require explicit architecture treatment for production-comparability deviations. A missing or
non-comparable environment, baseline, test data route, monitoring path, recovery mechanism, or
production-only test constraint is a Proposed ADR and usually a risk, not a planning assumption.
Before approving the automation model, verify that the current as-is state is evidence-backed from
the discovery report and source-code inventory, and that the planned case-count baseline is explicit
for each test type. If the current count cannot be proven, record the range or zero-verified count,
not an assumed number.
Ensure the target design can run unit, connectivity and performance/load tests automatically.
Integration and smoke/regression/functional tests may remain semi-automated only when the design
supports repeatable setup/execution, retained machine and manual evidence, and the approved
R-Type-informed ownership split. Route any automation shortfall to the owning architecture layer,
readiness risk and migration scope.
Tool examples in the strategy are not selected without normal architecture grounding.

Apply the detailed HA/DR controls in strategy Sections 7.2 and 7.3. For HA, show how the target
design supports the Application Owner's approved goals, zone/process/dependency fault scenarios,
redundancy and failover, production-comparable PPE, monitoring, and safe isolated execution. For
DR, show the Production recovery path and failback/normalization, backup readiness, dependency-only
failover scenarios where the application hosting environment remains in place, and the telemetry
and access needed for L2 execution. Lower-environment DR is rehearsal, not acceptance. Record any
material design or environment gap with its owner and governed ADR/risk.

## Review

Populate architecture Section 14's Migration testability finding and Section 14.1 with exactly one
row for every canonical testing-profile test type. Each row contains:

- resolved R-Type applicability and requirement/profile traces;
- owning architecture sections and target mechanism under test;
- approved environment and production-comparability disposition;
- observability/evidence path plus data/identity/access prerequisites;
- readiness and Proposed ADR/risk when Conditional or Blocked.

Carry integration scenarios on the Change-Based Functional Testing or UAT row as applicable; do
not add a separate integration test type or matrix row.

The summary finding records gaps returned to layers, resulting changes, approvals still required,
and whether planning has enough design evidence to produce the Test Plan.

### OAT scenario design

Invoke `oat-scenario-design` with discovery evidence and the assembled target architecture. Populate
Architecture Section 14.2 with exactly one disposition per catalog scenario ID. The matrix must
distinguish current as-is evidence from proposed Azure target evidence, state why each scenario is
recommended, conditional, not applicable, or blocked, and identify target testability, safety,
environment, owner, runbook/evidence and governance gaps. Map only selected Azure services and
verified capabilities. Return design gaps to owning architecture layers; do not claim a scenario
has been executed or approved.

Re-run affected layer validation after any design change. If a testability gap changes the
component-change classification, re-evaluate Section 8 rather than preserving the prior R-Type.

Confirm the WAF testing-related rows — SE:11 (Section 7.9), RE:08 (12.7), OE:09 (12.8) and PE:06
(12.9) — reconcile with the Section 14.1 rows for security/penetration, HA/DR, functional and
performance testing; return any contradiction to the owning layer. Where Section 7.7 records AI/LLM
use, confirm security testing covers its threats (e.g. prompt-injection and excessive-agency cases).
