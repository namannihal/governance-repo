---
name: requirements-testing
description: "Elicit and validate migration testing requirements and scope as ordinary functional requirements, NFRs, ADRs, and risks. USE FOR: test scope, test applicability, test acceptance criteria, test evidence, UAT, performance/HA/DR/security/OAT testing requirements. Invoked by /speckit.requirements before coverage review. DO NOT USE FOR: selecting test tools or scheduling test execution (use plan-testing)."
argument-hint: "Invoked by /speckit.requirements with app evidence, candidate test assets, and measurable quality targets"
---

# Requirements Domain: Migration Testing

Owns authoritative `requirements/testing-profile.md` plus migration-testing requirement
elicitation across the authoritative `REQ-*` and `NFR-*` records. It does not create a separate
test-requirement ID namespace and does not write the application Test Plan.

Run **Plan → Act → Review**. Load `docs/testing-strategy/INDEX.md` first, then only the relevant
sections of the extracted strategy.

## Required Inputs

- Application behavior, interfaces, users/roles, data stores, deployables, critical flows, and
  migration changes from app-specific evidence.
- Discovery report and the current application source code or pipeline inventory showing what is
  already automated today by test type: framework files, test scripts, CI jobs, execution reports,
  suite baselines, recorded pass/fail evidence, and current ownership. Do not classify a test as
  automated or semi-automated without this evidence; framework names alone are not proof of current
  coverage, maintenance state, or case-count reality.
- Existing test strategy/plans/cases/scripts/results, automation repositories, baselines,
  environments, data, tools, defect history, and named test/approval owners.
- Any supplied application test plans, catalogs, linked repositories/workbooks, run reports, and
  source-code or test inventory, even when their completeness or authority is uncertain. These are
  evidence candidates, not mandatory prerequisites; proceed with available evidence and track gaps.
- Approved or proposed functional, performance, availability, RTO/RPO, security, data-quality,
  operability, cutover, rollback, and acceptance targets.
- `docs/testing-strategy/INDEX.md`, `docs/mec-reference.md`, `docs/gcf-reference.md`, and applicable
  DevSecOps, resiliency, security, data, and transition guidance.

One app-specific source is enough to begin. Missing application facts remain `UNKNOWN — needs
{named owner/team} input`; target thresholds follow the framework rule to propose a sourced,
confidence-rated default before Unknown where defensible.

## Plan

Inventory every strategy test type and assign one disposition:

- `Applicable` — create or link atomic REQ/NFR records.
- `Conditionally Applicable` — retain the exact trigger, especially Refactor/Rearchitect branches;
  architecture resolves it after independently deciding R-Type.
- `Exception proposed` — create a Proposed ADR and Identified risk where exposure remains. UAT may
  not use this disposition.
- `Unknown` — name the missing evidence and owner; link ADR/risk when gate-affecting.

Do not mark a universally expected test `Not Applicable` merely because cases, data, environments,
tools, or owners are missing. Those are readiness gaps.

Record every disposition, condition, REQ/NFR link, environment assumption, evidence, execution and
approval owner, and ADR/risk in `requirements/testing-profile.md`.

Use the profile's Evidence Sources and Conflicts, Test Asset Inventory, and shared Human Input and
Decision Register. Capture source identity/version/date/locator, authority, access, applicability
and freshness; preserve competing claims with their governing rule and downstream impact. Reuse an
AUT follow-up as its action rather than duplicating it. An answer becomes usable only when its
evidence is validated; do not create an ADR for every unanswered fact.

Keep integration testing as scenario scope within the canonical functional/UAT rows, never as a
separate test-type row. For Re-Factor, and for Re-Host/Re-Platform when the Migration Team performs
refactoring, include component interaction scenarios in Change-Based Functional Testing. Otherwise,
include integration scenarios in mandatory UAT owned/executed by the Application Team. UAT remains
mandatory in either branch; avoid duplicate scenario counts. Keep the separate Integration Testing
Complexity assessment for qualifying external standalone business/negative-path cases distinct from
this test-type classification.

## Act

Apply `docs/testing-strategy/automation-review-and-scenario-sizing.md`. Populate the template's
Automation Availability Review with one entry per canonical test type. When as-is evidence is
missing or inaccessible, record Unknown and an explicit Application Team review action with
coordinating owner, needed-by gate/date and requirement/risk trace. Do not treat an unavailable
reference plan or repository as a generation failure, or infer business behavior, coverage, or
approval from its absence. Request repositories, covered/uncovered scenarios,
verified counts, run results, pipeline/data/baseline readiness and maintenance capacity. Capture a
dated answer and evidence; None or Partial must not be inferred from a repository scan.
Carry unresolved, absent and partial coverage into architecture scenario design and planning.
Assign review, implementation, execution and maintenance separately using
`LMP-Migration-Testing-Strategy.md` Sections 2.2, 4, the test-specific section and Appendix 5.
Do not automatically transfer whole legacy-suite creation to Migration. Section 4.1 enablement
is conditional on MEC/maintenance capacity and limited to one sprint; unit additions remain
limited to migration-changed impacted code.

Before making an automation claim, assess available discovery and source-code evidence. Record
which test types have verified automation, partial evidence, or remain Unknown, along with known
case counts, ownership, execution history, and approval state. A repository scan that finds
framework files is only a starting signal; it does not establish executable suite health, business
coverage, or a trusted count. Missing evidence stays owned and visible; it does not prevent a
reviewable requirements draft.

Document this analysis in `requirements/testing-profile.md` and any related risk/ADR entries when
the evidence is absent or incomplete. Missing as-is evidence must become an explicit readiness gap,
not a silent acceptance of automation or a guessed case count.

Apply the framework automation interpretation: Unit, connectivity, and performance/load testing
have an automated target. Integration and smoke/regression/functional testing may be
semi-automated, but every manual step must be versioned, reproducible, traceable, evidence-producing,
and assigned to the Migration Team or Application Team through the R-Type-informed RACI. Proposed
remediation is evidence-bounded and ownership-reviewed; do not silently expand migration scope or
convert unknown automation into an asserted gap count.

Validate the evolving profile with `validate-requirements-testing.ps1 -ValidationStage Draft`.
Draft validation reports input completeness separately from structural quality and does not
represent formal readiness or approval.

Create or update ordinary records:

- `REQ-*`: test capability and workflow outcomes such as executing connectivity paths, reconciling
  migrated data, performing UAT, retaining evidence, obtaining approval, tracing cases to
  requirements/defects, and following the exception process.
- `NFR-*`: measurable pass rates, coverage, latency/throughput/variance, RTO/RPO/RTA/RPA, data-loss
  and reconciliation tolerances, defect thresholds, evidence retention, environment equivalence,
  execution duration, and acceptance/exit thresholds.

Keep each obligation atomic. Verification names the applicable test and evidence, but requirements
must not select tools, Azure SKUs, topology, schedules, or runbook commands.

Cover at minimum:

1. Connectivity, migration tool, installation, and smoke/regression testing. Continue existing
  automated unit suites for every migration; create or extend Migration-Team unit-test scope only
  for code changed during migration and only for impacted code. Require data migration
  verification whenever application data, files, durable messages, or state moves; permit an
  evidence-backed N/A only when no data movement is in scope.
2. Conditional change-based or full functional testing based on the eventual R-Type.
3. Performance baseline validity/reproducibility, equal-volumetric comparison, NFR targets, and
   tolerable variance.
4. HA, DR, security/penetration, OAT, and mandatory UAT outcomes. For HA, use strategy Section
   7.2 to define measurable goals for uptime/SLA, RTO/RPO, redundancy/failover, scalability, and
   resource utilization; keep the exact application thresholds sourced and owner-approved. For
   DR, use Section 7.3 to require Production acceptance, recovery/normalization outcomes, and
   accountable Application L2 execution before customer cutover.
5. Test environment comparability, monitoring, identities/access, representative/versioned test
   data, privacy controls, and test asset ownership.
6. Entry, exit, and final acceptance criteria; defect severity/priority and unresolved-defect
   thresholds; requirement-case-defect traceability.
7. Per-test results reports, central evidence, named approvers, and exception/risk treatment.
8. Automation applicability and maintainability, reconciled with current GCF/MEC controls.

Tag records with every architecture layer that must make the outcome testable. Testing is
cross-cutting; do not route all records only to `architecture-resilience`.

## Review

- Every strategy test type has a cited disposition, owner, environment assumption, measurable
  success path, and evidence expectation.
- Universal tests are not incorrectly conditioned on the provisional R-Type.
- Unit-test applicability follows migration code changes rather than R-Type, while existing
  automated suites remain in execution scope.
- Unit, connectivity and performance/load rows carry an automated target; integration and
  smoke/regression/functional rows may be semi-automated only when manual steps, evidence and RACI
  ownership are explicit.
- The profile has no standalone Integration Testing row; integration scenarios are assigned to
  Change-Based Functional Testing for Migration-Team refactoring, otherwise to mandatory
  Application-Team UAT.
- Data migration verification is Not Applicable only when evidence proves no data movement.
- Conditional R-Type tests do not influence architecture's independent R-Type selection.
- HA requirements reflect the Application Owner's assessment of R-Type, failover mechanisms,
  redundancy, load balancing, and resiliency strategy; missing goals remain owned readiness gaps.
- DR requirements preserve Production acceptance and validate recovery plus failback/normalization
  against approved RTO/RPO; PPE/QA rehearsal cannot substitute for the Production test.
- UAT is mandatory and has observable entry, exit, approval, and evidence obligations.
- Missing cases/data/tools/environments become requirements/readiness gaps, not silent exemptions.
- Case-count evidence for each applicable test type must be sourced from the discovery report,
  current test repos, or a named test-lead inventory. If the exact count is unavailable, record the
  evidence gap and the current known count band (for example, zero verified cases, partial inventory,
  or not yet extracted), rather than pretending that automated coverage exists.
- Every exception is a Proposed ADR with human review and a linked risk where applicable.
- Every test obligation traces to application behavior, a quality target, a migration control, or
  a cited strategy mandate; no generic test scope is invented.
- Return created functional records to `requirements-functional` validation and non-functional
  records to `requirements-nfr` validation before the independent coverage review.
