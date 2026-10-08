# Changelog

All notable changes to this template repo are recorded here. App repos instantiated from this
template keep their own changelog for app-specific changes — this file is for the template itself.

## 1.47.0 — 2026-10-07

- Corrected Draft and ReadyForReview Test Plan gates: Conditional/Blocked architecture readiness
  and pending approver roles are reviewable only through relevant owned actions, ADR/risk traces,
  contacts/coordinators and needed-by gates. Execution/default prerequisite gates still require
  Ready environments, named humans and exact-version approvals; false approval/evidence and
  stage/status contradictions remain errors.
- Added a source-owned, concise Review Brief before detailed Test Plan tables: proposed scope,
  evidence confidence, separate artifact quality/input completeness, at most five prioritized
  conflicts and human actions, linked case/asset/estimate/crosswalk detail and next approval gate.
  Review validates canonical references/statuses; legacy Drafts warn when navigation is absent.
- Wired planning, analysis and faithful publication guidance; added regression fixtures for owned
  incomplete proposals, unowned dependencies, stale summaries and strict execution behavior.

## 1.46.0 — 2026-10-07

- Added reusable evidence provenance/conflict, shared human-input, test-asset health, case-outline,
  migration impact-to-test crosswalk and estimate-boundary contracts across requirements,
  architecture and planning.
- Added the SPEC testing-evidence handoff: canonical test-type coverage links architecture
  crosswalks, exact requirement/implementation/backlog IDs, supplied/proposed cases and assets,
  shared profile actions, repository readiness and later planning gates without requiring the
  Planning-stage Test Plan or duplicating its case matrix.
- Added Draft/ReadyForReview/Execution Test Plan validation guidance while preserving strict
  Execution as the validator default; incomplete evidence remains visible without being treated as
  a generation failure or approval.
- Updated analysis and publication guidance to preserve cross-artifact traces, full-fidelity draft
  status and the distinction between artifact quality and input completeness.
- Added stage, evidence, scope-boundary and migration-impact regression coverage; refreshed the
  reviewed testing-strategy index contract.

## 1.45.0 — 2026-10-06

- Added per-test Application Team automation review actions, distinguishing unverified evidence
  from confirmed absent/partial coverage, with downstream high-level scenario and effort sizing.
- Updated requirements, architecture, planning and analysis prompts, skills and templates to
  expose scenario volume, reusable/uncovered scope and automation development effort separately
  from execution; activity ownership cites the LMP strategy and preserves one-sprint enablement,
  migration-changed unit scope and Application Team maintenance boundaries.
- Added elapsed testing timelines, 1/2/3-tester capacity scenarios, optional jointly agreed
  lower-environment Pre-OAT and four-party Test Plan approval requirements.
- Extended testing validators and regression fixtures for automation reviews, scenario design,
  effort sizing, capacity estimates and approval completeness; refreshed the strategy index contract.

## 1.44.0 — 2026-10-06

- Added the LSEG L2 Game Day/OAT catalog and dedicated architecture-design and test-planning
  subskills to select operational scenarios from evidenced as-is components and the proposed Azure
  target without assuming applicability, current tooling, or production authorization.
- Added 51 stable OAT scenario IDs to the Architecture and Test Plan templates, requiring
  application-specific evidence, Operations ownership, runbooks, safety controls, and recorded
  disposition.
- Expanded architecture and Test Plan validators and workflow regressions to reject missing OAT
  scenarios/evidence and unsafe production-disruptive tests; refreshed the testing-strategy index
  contract.

## 1.43.1 — 2026-10-05

- Clarified that integration testing is scenario scope within Change-Based Functional Testing when
  the Migration Team performs refactoring, including refactoring under Re-Host/Re-Platform; absent
  Migration-Team refactoring, integration scenarios belong to mandatory Application-Team UAT.
- Updated requirements/architecture/planning templates, testing skills and workflow prompts to
  preserve the split, keep UAT mandatory, and avoid duplicate case counts or a standalone
  Integration Testing type.
- Added profile/Test Plan validator checks and regression cases rejecting standalone integration
  rows or missing functional/UAT ownership branches; updated the testing-strategy index contract.

## 1.43.0 — 2026-10-05

- G-3 is now a framework-managed, versioned publication at `deliverables/G-test-plan.md`, rendered
  in full from the authoritative feature-root `G-test-plan.md` without changing its test scope or
  approval state.
- Publication setup seeds the G-3 view from the canonical source, preserves version history, and
  leaves G-3 Pending without creating a placeholder when the source plan does not exist.
- Finalization and validation reject G-3 source/view drift; analysis and planning guidance now
  distinguish the authoritative root source from its expected published copy.
- Expanded the publication workflow smoke test for G-3 materialization, parity, unchanged reruns,
  content version increments, and pre-plan Pending behavior.

## 1.42.2 — 2026-10-01

- MEC-8 requirements and architecture prompts/skills now explicitly check the latest available
  official vendor or maintainer lifecycle notices online (or supplied authoritative sources when
  offline) for the actual runtime, distribution, framework, package, OS and image versions.
- Record notice and retrieval dates, source locators, support phase and extended-support terms;
  inaccessible, stale or conflicting notices remain `UNKNOWN` with an evidence owner rather than
  an invented EOL date or unsupported compliance claim.

## 1.42.1 — 2026-10-01

- Requirements and architecture MEC-8 guidance now inventory software versions from discovery and
  accessible source/configuration, verify dated support status, and propose evidence-backed uplift
  or replacement candidates with owners, closure checks and human review.
- Unresolved or partially covered currency gaps retain honest MEC statuses; runnable EOL software
  and exception proposals do not silently count as compliance or permit risk-only deferral.
- Clarified that proposed target-design compliance and implementation/current-state evidence are
  distinct, and aligned compute inventory dispositions with security and Section 4 tasks.

## 1.42.0 — 2026-09-30

Added a controlled Security Architect quality checklist for MEC assessments.

- Added `.specify/checklists/mec-assessment.md` with 42 mandatory checks covering standard
  completeness, applicability/status reasoning, evidence quality, LSEG ADR/Pattern/CPF/GCF
  alignment, target design/maturity, traceability, cross-artifact consistency and three-role review.
- `/speckit.architecture` and `architecture-security` now instantiate/evaluate the MEC checklist,
  publish counts/open IDs in Section 7.4.1 and keep the Architecture Review Gate open for unchecked
  required items.
- G-4 readiness, rendering and deliverable analysis consume the same checklist; Complete requires
  zero open items and named Migration Architect, Application Architect and Security SME approval.
- `validate-checklists.ps1` now automatically enforces any same-named controlled checklist baseline;
  `validate-architecture.ps1` validates MEC baseline conformance, counts and gate behavior.

## 1.41.4 — 2026-09-30

Defined architecture-stage MEC status as target-design compliance rather than implementation state.

- Architecture may propose `Compliant` when the selected target fully covers a criterion through
  approved LSEG patterns, CPF controls, platform capabilities or explicit application design and
  no technical blocker exists; implementation proof remains in Target Maturity and actions.
- Architecture Security and Threat Protection now treat pattern-backed CrowdStrike/Qualys controls
  as compliant design for MEC-3/4 unless a named compatibility, licensing, coverage or network
  blocker exists, while retaining onboarding and reports as delivery evidence.
- MEC-8 remains per-component and App Team decision-dependent: unsupported software requires an
  approved uplift or explicit time-bound exception; platform patterns cannot imply currency.

## 1.41.3 — 2026-09-30

Separated evidence-based MEC compliance calculation from human approval.

- Architecture Security now recalculates each application MEC status from all available evidence
  and may propose `Compliant` when all material parts are supported and no contradiction remains;
  missing corroboration stays an action/review condition rather than an automatic downgrade.
- Added `Compliance Review State` to architecture, spec and G-4. Every row defaults to Proposed
  pending named Migration Architect, Application Architect and Security SME review.
- Architecture validation requires 30 valid review-state rows and prevents a Cleared architecture
  gate while any MEC status remains Proposed; G-4 cannot be Complete without all three roles.

## 1.41.2 — 2026-09-30

Standardized the application-level MEC compliance status vocabulary.

- Added the separate `This Application's MEC Compliance Status` field to requirements,
  architecture, spec and G-4 with exactly four values: `Compliant`, `Not Applicable`,
  `Non-Compliant`, and `Partially-Compliant`.
- Kept Independent Applicability and Target Maturity separate so `Unknown`, `Designed`, and
  `Blocked` cannot leak into application compliance status.
- Record validation now rejects missing values, aliases and any fifth status for each MEC row;
  G-4 reports the four application compliance counts separately from target maturity counts.

## 1.41.1 — 2026-09-30

Corrected MEC assessment ownership so SpecKit derives the full assessment from standard inputs.

- `/speckit.requirements` and `requirements-compliance` now evaluate all 30 MEC controls from the
  MEC standard, discovery reports, source/configuration, repositories/pipelines, app-team documents
  and direct answers without requiring a migration-team-completed workbook.
- A supplied completed MEC workbook is optional human comparison evidence applied only after the
  independent result; its absence is not a requirements, architecture, publication or gate gap.
- Requirements, architecture, spec and G-4 templates now lead with independent applicability,
  current state, evidence/rationale and confidence, with human status in a separate optional view.
- Record validation now enforces the independent assessment fields rather than workbook-specific
  baseline fields.

## 1.41.0 — 2026-09-30

Made application-completed MEC workbooks first-class evidence from requirements through G-4.

- Requirements now preserve every workbook row's baseline assessment, application response,
  expected evidence and source mappings, then record an independent applicability/current-state
  result and classify disagreements without overwriting the human baseline.
- Architecture Section 7.4 now carries all 30 controls with target design, evidence and explicit
  maturity (`Designed`, `Implemented`, `Evidence Verified`, `Exception Proposed`, or `Blocked`),
  preventing planned controls from being represented as implemented compliance.
- Replaced the generic G-4 checklist with a workbook-compatible MEC ledger, detail mappings,
  reconciliation summary and evidence-aware remediation plan.
- Strengthened record validation, publication and deliverable analysis so baseline non-compliance,
  unsupported compliance claims and unresolved workbook conflicts cannot silently disappear.

## 1.40.4 — 2026-09-30

Promoted Complexity Calculator quality checks into a controlled reusable framework baseline.

- Added `.specify/checklists/complexity-calculator.md` as the authoritative CHK001–CHK030 catalog
  reused by every application rather than regenerating potentially different mandatory checks.
- `/speckit.checklist` now copies baseline IDs/questions/tags verbatim, evaluates them against the
  application evidence and appends application-specific checks from CHK031.
- `validate-checklists.ps1` now detects missing or paraphrased baseline items while remaining
  generic and extensible to future `.specify/checklists/<domain>.md` baselines.

## 1.40.3 — 2026-09-30

Added the native Spec-Kit quality-checklist workflow, starting with Complexity Calculator quality.

- Added `/speckit.checklist`, the canonical checklist template and `validate-checklists.ps1` for
  feature-scoped `checklists/*.md` artifacts with stable `CHK###` IDs.
- Made `checklists/complexity-calculator.md` a required quality contract for architecture Section
  8A and G-7, covering completeness, evidence, workbook units, rules, arithmetic, consistency,
  factor readiness and completion approval without turning checklist items into implementation tests.
- Architecture, publication and `/speckit.analyze` now reconcile checklist item/pass/open counts;
  unchecked required items keep the architecture gate and G-7 status open.

## 1.40.2 — 2026-09-30

Added external Complexity Calculator validation and workbook-version reconciliation.

- Architecture now ingests supplied completed calculators and supporting sheets as validation
  evidence, independently checks their counts/formulas, and reconciles assumptions to approved
  requirements, architecture and ADRs rather than accepting the workbook band as authority.
- Section 8A and G-7 now compare the supplied workbook's actual rubric with the framework V4.1
  baseline, require a governing-version decision for material drift, and prohibit mixed-version
  scoring.
- Publication readiness/rendering and deliverable analysis classify calculator differences as
  input gaps, analysis defects, source conflicts, version drift or framework gaps.

## 1.40.1 — 2026-09-30

Made Complexity Calculator V4.1 evidence reviewer-reproducible from architecture through G-7.

- Added a shared layer-finding handoff and factor-owner instructions for observed inputs,
  inclusions/exclusions/grouping, derivation, exact source locators, confidence and review gaps.
- Strengthened architecture Section 8A and G-7 Evidence/Calculation Comments so counts and category
  mappings show their workbook-defined units, arithmetic/rule mapping and grounded provenance.
- Added publication and deliverable-analysis checks that preserve and independently recompute the
  complexity evidence chain instead of accepting section-only citations or unexplained proxies.

## 1.40.0 — 2026-09-30

Extended `/speckit.analyze` to validate the complete publication surface rather than only core
workflow artifacts and publication metadata.

- Added `analyze-deliverables`, with an explicit ledger for all eleven deliverable IDs and their
  authoritative source ownership.
- Added `analyze-artifacts`, with an exhaustive ledger for all core Spec Layer templates and
  explicit requirements/architecture shape, source, gate, and validator checks.
- Added exhaustive template/manifest inventory checks so new, missing, duplicate, renamed, unknown,
  or untracked templates are reported instead of silently skipped.
- Added source-to-output and cross-deliverable reconciliation for R-Type, scope, complexity,
  topology, services/SKUs, cost, resilience, security/MEC, transition, testing, decisions/risks,
  evidence, approvals, maturity, numeric values, and unresolved facts.
- `/speckit.analyze` now explicitly runs both publication and SAD contract validators when those
  surfaces exist.

## 1.39.4 — 2026-09-29

Renamed the G-7 Markdown template to `complexity-calculator.md` and updated active architecture,
requirements, publication-setup and CQM manifest references. The G-7 deliverable ID and the
historical 1.28.0 changelog entry remain unchanged.

## 1.39.3 — 2026-09-29

Added evidence-backed completion assessment for prior-stage Playbook work.

- Specification preserves the full approved-R-Type User Story scope and carries requirements/
  architecture evidence anchors forward without declaring work complete.
- Planning assesses every applicable Discovery & Assessment and Planning & Design User Story and
  child Task individually as Complete, Partially complete, Remaining or evidence-backed N/A. The
  full ledger stays auditable, while only remaining/residual work is scheduled; Complete requires
  the exact output and required human approval, not mere topic coverage.
- Task generation creates executable backlog work only for Remaining and explicit residual
  Partially complete rows. The plan disposition does not synchronize external ADO/GitLab status.

## 1.39.2 — 2026-09-29

- `validate-architecture.ps1` now parses the Section 5.2 interface inventory only up to its
  `####` subsections. Section 5.2.1 Interface Protection Controls rows are keyed by the same
  `FLOW-*` IDs per the template and were previously reported as duplicate flows.

## 1.39.1 — 2026-09-29

- `validate-implementation-backlog.ps1` now parses Feature/User Story/Task rows only from Sections
  4.1–4.3. Section 4.4.2 rows are keyed by `IMP-T###` per the template and were previously
  misread as duplicate, incomplete Tasks. `test-implementation-backlog.ps1` fixture covers 4.4.2.

## 1.39.0 — 2026-09-29

Closed architecture design coverage gaps against the LSEG Architecture Design Document schema and
split oversized layer skills into focused sub-skills.

- New `architecture.md` sections: 1.3 Environment Topology Variances; 3.2 Technology Inventory and
  Lifecycle; 3.3 Infrastructure Requirements Assessment; 5.2.1 Interface Protection Controls
  (datasets per flow, rate limiting, file transfer, malware scanning, email gateway); 5.2.2
  Dependency Governance (critical path, dependency RTO/RPO, agreed load, TPRM); 5.6 Internet
  Perimeter Protection (WAF, DDoS); 6.8 Data Sovereignty and Jurisdiction; 6.9 Data Integrity
  Controls; 7.2.5 End-User Device Profiles and MFA; 7.2.6 Production Operator Access Model; 7.5
  Endpoint and Workload Security Agents; 7.6 Application and Software Security; 7.7 AI and LLM
  Security; 7.8 Security Logging and Threat Detection; 10.1 Guardrail and Policy Exceptions
  Register; 12.1.1 Observability Solution Design; 12.6.4 Target Lifecycle, Currency and Exit;
  13.4A Cost Drivers and Commitment Strategy; 13.8.1 Sustainability Design Rationale.
- Extended 1.1 (application type/nature, internet-facing, highest classification), 1.2 (account
  management), 7.3.2 (customer key isolation), 12.3 (trend/forecast method) and the header
  (authors/contributors).
- WAF Security alignment moved from Section 7.5 to 7.9 so the WAF table closes the chapter.
- New sub-skills: `architecture-security-protection` (7.5–7.8, validates 5.6),
  `architecture-observability` (12.1, 12.1.1, 12.3 monitoring) and `architecture-sustainability`
  (13.8, 13.8.1). Parents invoke and validate them; the orchestrator still dispatches eight layers.
- Layer skills gained explicit reasoning and validation for every new section; the orchestrator
  assembles 10.1 and validates component-level coverage in Section 14.
- `validate-architecture.ps1` now requires the new sections and checks every WAF checklist code
  appears exactly once with a valid disposition and an ADR/RSK when not aligned.
- Deliverables aligned: `G-sad-baseline.md` cites the new sections (and WAF Security at 7.9),
  `G-adr-risk-register.md` adds the Section 10.1 exceptions register and `C-cost-profile.md` adds
  Section 13.4A commitment recommendations and reconciliation to Section 1.3.

## 1.38.0 — 2026-09-29

Replaced the standalone Well-Architected narrative with pillar-by-pillar design and validation.

- Removed `architecture.md` Section 1.3 (Well-Architected Target Narrative).
- Added `docs/waf-reference.md`: WAF checklist codes (SE, RE, OE, PE, CO), owning/contributing
  layer per code, alignment dispositions, and precedence rules (LSEG first; CPF WAF sections before
  generic guidance; non-migration recommendations are justified deviations under Principle I/V).
- Added per-code alignment tables to the owning chapters: 7.5 Security (`architecture-security`),
  12.7 Reliability, 12.8 Operational Excellence and 12.9 Performance Efficiency
  (`architecture-resilience`), and 13.9 Cost Optimization (`architecture-cost`).
- Every architecture layer skill now researches its assigned WAF codes, CPF WAF sections and WAF
  service guides before designing and validates its design against them; the Layer Finding
  contract gains a Well-Architected alignment contributions table.
- The orchestrator merges contributions, validates alignment in Section 14 and the gate checklist;
  `architecture-testing` reconciles SE:11/RE:08/OE:09/PE:06 with Section 14.1.
- Remapped SAD "Application Architecture Description" ownership and replaced the Section 1.3 SAD
  marker with the five new section markers. Existing app `architecture.md` files must be
  regenerated or updated with the new sections to pass `validate-architecture.ps1`.

## 1.37.0 — 2026-09-29

Constrained Section 4 implementation Owners to the two teams in the migration program.

- Required each Feature, User Story and Task Owner to be exactly `Migration Team` or
  `Application Team`; platform, data, integration, security and operations roles are listed as
  Contributors / Consulted instead of migration-program Owners.
- Updated the Section 4 template and two-pass RACI skill to retain the owner rule while allowing
  specialist contribution and Shared RACI participation.
- Extended `validate-implementation-backlog.ps1` and its regression test to reject any Feature,
  User Story or Task whose Owner is outside the allowed teams, and updated task-column handling for
  the separate Contributors / Consulted field.

## 1.36.0 — 2026-09-28

Added a two-pass, R-Type-conditioned code-refactoring responsibility proposal to architecture.

- Added the `architecture-refactoring` cross-cutting skill. It records ownership options for each
  Section 4 implementation task across candidate R-Types before R-Type derivation, then proposes
  the Migration Team/Application Team Responsible/Accountable split after the architecture derives
  its Proposed R-Type.
- Kept the responsibility analysis outside R-Type selection and left the resulting allocation
  Proposed pending human, commercial and capacity confirmation; an Unconfirmed R-Type retains
  conditional ownership alternatives.
- Added Section 4 template ledgers linking each `IMP-T###` to source-matrix scenarios, conditional
  options and the post-R-Type proposed allocation; indexed the LSEG code-refactoring reference.
- Kept orchestration concise by dispatching the focused skill in two passes rather than embedding
  the detailed responsibility matrix analysis in `speckit.architecture.prompt.md`.

## 1.35.0 — 2026-09-28

Made application source-repository identification and access readiness explicit across architecture,
specification, and planning.

- Architecture Section 4 records best-known repository/source locations and owner-attributed gaps.
  Missing source access alone does not block the Architecture Review Gate; access is requested and
  validated during specification, while implementation permissions are tracked during planning.
- Specification captures the affected repository/project inventory and access evidence alongside
  the as-is summary, preserving each architecture `IMP-T###` mapping without guessing paths.
- Planning tracks source repository access as an owned readiness dependency, with requested access,
  Application Team owner, needed-by date and affected work blocked until permission is granted.

## 1.34.0 — 2026-09-28

Added an architecture-derived, agent-ready implementation backlog for migration-required
application refactoring and CI/CD automation.

- Replaced the loose architecture Section 4 change list with stable `IMP-F###`, `IMP-US###` and
  `IMP-T###` Feature/User Story/Task ledgers derived only after target-design reconciliation.
- Required repository/path scope, current-to-target technical delta, explicit boundaries,
  dependencies, executable acceptance, MEC/REQ/ADR/pattern/GCF traces, accountable ownership and
  recommended implementation-agent capability for every architecture Task.
- Added plan and task handoffs that preserve the hierarchy, schedule every architecture Task once,
  and create bounded Copilot work packages without treating agent assignment as governance
  authority.
- Updated implementation orchestration to route work by available agent capability and retain the
  stated validation result before completing an architecture-derived Task.
- Added `validate-implementation-backlog.ps1`, wired it into architecture/task/implementation
  readiness gates, and added positive/negative regression coverage in
  `test-implementation-backlog.ps1`.
- Existing application artifacts must regenerate architecture Section 4 and the corresponding plan
  and tasks ledgers before progressing under this framework version.

## 1.33.0 — 2026-09-23

Separated Application Team-owned Datadog/BigPanda commercial costs from the Azure C-3 Cost
Profile while retaining observability as mandatory requirements, planning and SAD scope.

- Requirements continue to capture measurable telemetry, alerting, ownership and evidence.
- Architecture Section 13 and C-3 now price Azure services only, including Azure Monitor, Log
  Analytics, diagnostic storage, networking and egress where used.
- Datadog/BigPanda licensing, ingestion, indexing, APM/RUM, synthetics and support charges remain
  Application Team-owned SAD/plan evidence and do not block C-3 completion.
- Planning retains technical onboarding, operational acceptance and SAD evidence tasks.
- Publication validation rejects C-3 outputs that price Datadog/BigPanda or omit the explicit
  Application Team-owned exclusion.

## 1.32.0 — 2026-09-23

Added a single rerunnable `/speckit.publish` workflow with independent version tracking for every
materialized application deliverable.

- Added publication readiness, rendering, and versioning skills plus the orchestrator prompt.
- Added setup, finalize, validation, and smoke-test automation. Each changed deliverable receives
  the next integer version; unchanged reruns retain their version.
- Added `deliverables/manifest.json` provenance with source and content hashes, framework version,
  UTC timestamps, publication-run history, and append-only per-deliverable history.
- Kept evidence and exact-version human approvals in rerun-safe directories and retained the
  feature-root Test Plan as the single canonical G-3 artifact.
- Added publication-impact and stale-version obligations to requirements, architecture, specify,
  plan, tasks, implementation, analysis, repository guidance, and Constitution v1.27.0.

## 1.31.0 — 2026-09-23

Expanded Planning from phase/User-Story summaries to a complete Backlog Playbook work-item
schedule with preserved ownership and GHCP-agent suitability.

- Added a mandatory plan ledger containing every selected Playbook User Story and child Task,
  exact source ID/title, Task-to-parent-User-Story linkage, R-Type applicability, verbatim source
  tags, parsed `OwningOrg`, exact GHCP-tag disposition, schedule, dependencies and evidence.
- Kept excluded R-Type, N/A and unapproved technical-debt work visible in an auditable exclusion
  table rather than silently dropping it.
- Updated the planning orchestrator and `plan-design` skill to reject phase-only or User-Story-only
  plans and mechanically reconcile selected User Stories/Tasks and their metadata to the CSV.
- Updated task generation so each Playbook-derived executable task preserves source work-item,
  parent User Story, raw tags, ownership and GHCP disposition. `GHCP=Yes` indicates eligibility for
  GHCP-agent assignment; it never replaces the accountable delivery owner.
- Normalized legacy Markdown table separators in the plan template.

## 1.30.1 — 2026-09-23

Strengthened migration-testing automation evidence and planning across requirements, architecture
and the application Test Plan.

- Required discovery-report plus source/test-repository evidence before classifying as-is testing
  as automated, semi-automated or manual; framework presence alone no longer proves coverage.
- Added per-test-type case-count evidence, with explicit zero-verified/partial/unknown states when
  an authoritative inventory is unavailable.
- Established automated targets for unit, connectivity and performance/load testing. Integration
  and smoke/regression/functional testing may be semi-automated only with reproducible, traceable,
  evidence-producing manual steps and R-Type-informed Migration/Application Team ownership.
- Required automation shortfalls to remain linked risks and explicit migration-scope work through
  requirements, architecture and planning.

## 1.30.0 — 2026-09-22

Added a mandatory SKU/Tier Deployability Reconciliation contract to prevent Azure service tiers
from being selected solely because they are available in Azure or named by a pattern.

- Added Section 3.1 to the architecture template and a matching contribution table to every layer
  finding. Each selected Azure service/tier now records its CPF module/version, mandatory controls
  and settings, applicable MEC/security constraints, resilience/network compatibility, provisioning
  path, deployability disposition, and any ADR/risk needed to resolve a conflict.
- Updated the architecture orchestrator and Compute, Data, Integration, Security, Resilience and
  Cost skills: service-owning layers inspect exact CPF tier behavior; Security verifies mandatory
  controls; Resilience verifies HA/DR compatibility; Cost only prices the reconciled disposition.
- Updated `validate-architecture.ps1` to require a complete Section 3.1 ledger and to reject a
  Conditional, Not deployable or Unknown row without a linked ADR/risk.
- The Event Hubs Premium CMK versus zone-redundancy conflict is the regression example: security
  constraints must surface before Cost, and a tier conflict remains conditional until human review.

## 1.29.0 — 2026-09-21

Integrated the LMP Migration Testing Strategy as a governed source from requirements through tasks.

- Extracted version 2.0 of the canonical DOCX to navigable Markdown with all five embedded media
  files, and added a compact index covering provenance, test applicability, workflow ownership,
  section navigation and interpretation rules.
- Added reproducible Pandoc extraction and drift validation scripts; validation pins the reviewed
  DOCX, Markdown, interpreted index and each media hash through a checked-in contract, and checks
  the heading hierarchy and 24 source tables.
- Added `requirements-testing`, `architecture-testing` and `plan-testing` skills so test scope and
  measurable outcomes remain ordinary REQ/NFR records, architecture performs an independent
  cross-layer testability review, and planning owns the executable application Test Plan.
- Expanded the Test Plan and plan templates with applicability, traceability, environments,
  entry/exit/acceptance criteria, evidence, defects, exceptions, dependencies and named human
  approvals, and carried those controls into task assembly and validation.
- Added authoritative `requirements/testing-profile.md`, a mandatory architecture Section 14.1
  testability matrix, a single materialized application `G-test-plan.md`, stable per-test task
  lifecycle tags, independent `analyze-testing`, stage-specific gate validators, and a positive-
  path workflow smoke test.
- Resolved source conflicts explicitly: existing automated unit suites continue while the
  Migration Team adds/extends tests only for migration-changed impacted code; data verification
  follows actual data movement; Production DR is the acceptance execution; and general security
  testing remains separate from Production penetration testing. UAT remains non-waivable.

## 1.28.0 — 2026-09-21

Aligned complexity evidence and design workflow to the actual `Complexity Calculator-V4.1.xlsx` workbook.

- Verified all eight factors, weights, score values, formulas and final rating bands directly from
  the workbook, and expanded `G-complexity-assessment.md` with exact counting/applicability rules
  plus requirements-to-architecture evidence ownership.
- Requirements now collects raw dependency, component/database-object, integration-test,
  resilience, current DevOps maturity and cutover evidence without selecting target topology or
  assigning workbook ratings.
- Architecture Section 8A finalizes target deployable-object counts, modified scope,
  resilience/cutover categories and all eight ratings with REQ/NFR/profile and ADR/risk traces.
- Workbook ambiguities remain human-review items: integration-test count `5` overlap, undefined
  zero/not-applicable ratings for some factors, and the database narrative/scoring-label mismatch.

## 1.27.2 — 2026-09-21

Removed the `G-change-request.md` deliverable because operational change-request management is
outside this solution-design framework's boundary.

- Removed the change-request row from requirements deliverable coverage.
- Replaced the R-Type template's G-8 escalation path with the framework's design-time governance:
  a Proposed ADR, linked risk where needed, and explicit human review. Downstream operational
  change-control execution remains external to the spec layer.

## 1.27.1 — 2026-09-21

Strengthened lower-environment baseline and scaling identification from requirements through cost
design.

- The requirements prompt and NFR skill now derive each environment's steady/normal-traffic
  baseline target from supplied usage measurements, recording the source window, calculation or
  assumptions, and confidence without prematurely selecting Azure SKUs or instance counts.
- DEV, QA, PPE/PPR, and other lower environments now require explicit scaling dispositions for
  performance/load/stress, HA/failover/DR/resilience, and integration testing. Required events
  capture workload target, duration/frequency, capacity delta, and return-to-baseline condition;
  `Not required` needs rationale and `Unknown` names the missing evidence.
- Architecture Section 13 must carry every lower-environment disposition forward, then design and
  price additional Azure capacity only for required scale events. The independent requirements
  coverage review now keeps the gate open when baseline or scaling evidence is incomplete.

## 1.27.0 — 2026-09-21

Aligned cost profiling with the LMP **Creating Cost Profiles: Step-by-Step** process and removed
the overlapping standalone cost-estimate deliverable.

- Removed `C-cost-estimate.md`; the authoritative deliverable is now the set of per-environment
  Azure Pricing Calculator `.xlsx` exports, with `C-cost-profile.md` retained as their control and
  traceability record rather than a duplicate manually maintained estimate.
- Added USD-only calculator-export rules, baseline profiles for every environment, `PRODBASE` and
  fully ramped `PROD` handling, evidence-triggered lower-environment scaling profiles, Azure SQL
  licensing rules, exact filenames, multi-region sequencing, and one-current-attachment controls.
- Added Planning & Design creation and end-of-Cloud-&-DevOps revalidation/replacement controls,
  current on-premises cost sanity checking, ADO region matching, and mandatory architecture/ADR/
  CPF/MEC reconciliation to the cost skill and architecture template.

## 1.26.2 — 2026-09-20

Addressed two gaps found by a BTABoK (IASA Quality Attributes) review of the architecture
prompts/skills.

- Added a **Quality Attribute Trade-offs** field to `architecture-layer-finding-template.md` and a
  new `architecture.md` Section 11A, populated by the orchestrator from every Layer Finding — so a
  deliberate trade-off (e.g. cost vs. performance) is recorded even when no other layer disagreed
  and Section 11 (Conflict Resolution Log) has nothing to show. Section 14's self-review now checks
  11A for completeness.
- `architecture-transition` now names operational handoff documentation/training and a
  rollback-capable deployment/install package as explicit hypercare/handoff deliverables (owner +
  evidence), rather than assuming Section 12.6's CI/CD design covers them implicitly.

## 1.26.1 — 2026-09-20

Clarified Constitution Principle VI to name reuse's two distinct dimensions in the LSEG migration
context, so agents don't read "reuse" as catalog citation only.

- **Dimension 1 — catalog reuse**: adopt an existing `docs/adrs/`/`docs/patterns/`/`docs/cpf/`
  entry rather than re-designing the same capability.
- **Dimension 2 — as-is source/IaC reuse**: while analyzing the as-is application's own source code
  and infrastructure (not just its documentation), identify logic/integration/data-access/
  infrastructure patterns that repeat across as-is modules or services, and propose a single common
  reusable unit for the target — a shared IaC module and/or a shared application library/service —
  instead of carrying the as-is duplication forward unchanged.
- Both dimensions stay evidence-bounded and subordinate to Principle V (Least-Change Footprint).

## 1.26.0 — 2026-09-20

Added Constitution Principle VI: **Decompose for Structure, Reuse to Eliminate Repetition**,
sourced from the IASA Body of Knowledge "Decomposition" skill.

- Every architecture layer skill must decompose its layer into components grouped by related
  responsibility before choosing products/SKUs, and flag any pattern repeated across two or more
  components/layers as a reuse candidate for a single shared component/interface — citing an
  applicable LSEG ADR/pattern/CPF module where one exists.
- Reuse is evidence-bounded: it requires an actually-observed repeat, never a single occurrence or
  speculative future-proofing, and never overrides Principle V (Least-Change Footprint).
- A decomposition/reuse trade-off against migration complexity or footprint must be logged as a
  Decision, not resolved silently.
- Updated `architecture-template.md`'s Architecture Reasoning Order (Application design step) and
  Section 11 conflict-resolution guidance to reference the new principle.

## 1.25.8 — 2026-09-18

Expanded the MEC evidence contract from applicability-only to a reviewable applicability-to-target
treatment chain.

- The authoritative `requirements/MEC-applicability-evidence.md` record must now include, for
  every MEC criterion, an Applicability Rationale plus a Proposed Target Treatment / Out-of-Scope
  Rationale. Applicable treatment remains Proposed until architecture review; Unknown rows state
  the conditional response and evidence owner.
- Aligned the requirements prompt, requirements template, and `requirements-compliance` skill.
  `architecture-security` remains the owner of detailed target-control confirmation in
  `architecture.md` Section 7.

## 1.25.7 — 2026-09-18

Clarified the MEC evidence handoff so requirements-stage applicability is not mistaken for
architecture-stage target-control coverage.

- `speckit.requirements.prompt.md` now requires the authoritative
  `requirements/MEC-applicability-evidence.md` record to state that it assesses applicability from
  the evidenced current-state application profile and feeds the target-design assessment; it also
  removes a duplicated applicability-matrix instruction.
- `architecture-security` now consumes that record explicitly and owns the proposed Azure
  solution's per-control "how it is met" assessment in `architecture.md` Section 7, routing
  unresolved target controls to ADRs/risks without silently changing applicability.

## 1.25.6 — 2026-09-18

Made the Architecture Review Gate actionable for the humans who actually clear it (Migration
Architect / Application Architect), instead of a bare checklist with no stated owner or process.

- `architecture-template.md`'s Gate now opens with who clears it and the two-level process:
  resolve every Proposed decision/Identified risk in its own `decisions/`/`risks/` file first
  (checking a box here does not approve anything), then work the Checklist, then sign
  Reviewed by/Date/Outcome.
- Added a **Decisions & Risks awaiting your review** table right in the Gate — every open
  Section 10 row listed with its exact file to edit and the action needed, so the reviewer
  doesn't have to cross-reference Section 10 themselves.
- `speckit.architecture.prompt.md` step 18 now requires the orchestrator to populate that table
  and name the reviewer roles in its final message, rather than a generic "here's what's pending".

## 1.25.5 — 2026-09-18

Added a Discovery & Assessment evidence-closure check to `architecture.md` Section 15, so
architecture-stage work that resolves a Discovery & Assessment Playbook gap left `Partial` by
`requirements.md` Section 7 gets confirmed and cited, instead of that gap silently going stale.

- `architecture-template.md` Section 15 now opens with **15.0 Discovery & Assessment
  Re-validation**: one row per Discovery & Assessment User Story `requirements.md` Section 7 left
  Partial/No, checking whether this architecture document's own Sections 1–14 now supply the
  missing evidence (cited) or the gap is still open. This does not duplicate or re-derive Section
  7's own check — Discovery & Assessment coverage remains requirements.md's authoritative check.
- `speckit.architecture.prompt.md`'s step 15 now populates 15.0 before 15.1.

## 1.25.4 — 2026-09-18

Closed a silent gap where `architecture.md` Section 15 (Backlog Playbook Coverage Check) could
degrade into a prose summary instead of the required one-row-per-Playbook-User-Story table,
undetected by any validation script.

- `validate-architecture.ps1` now cross-checks Section 15.1 against
  `docs/backlog-playbook/v1/Backlog-Playbook-v1.csv` (`Phase = "Planning & Design"`,
  `Work Item Type = "User Story"`): every Work Item ID must appear exactly once, and Section 15.2
  (Open Points & Topics) must exist whenever any row is Partial/No.
- This mirrors the existing SAD-contract validation pattern (Section 16) so Section 15 gets the
  same mechanical enforcement instead of relying on a manual `/speckit.analyze` pass to catch it.

## 1.25.3 — 2026-09-18

Corrected 1.25.2: the evidenced-latency/networking-integration-with-external-systems test gates
**only** Fast-Path eligibility. The dedicated-vs-shared subscription question is a separate, common
architecture decision evaluated on its own standard criteria (isolation/blast-radius, compliance,
cost, quota, team/App-Family ownership) — it must not inherit its answer from the Fast-Path test.

- `docs/PLATFORM-GUIDES-INDEX.md` now states the two evaluations separately: a Fast-Path
  eligibility rule under Fast-Path Subscriptions, and a dedicated-vs-shared rule under Additional
  Application Onboarding.
- `architecture-networking`'s Evaluation/Design/Validation steps now treat Fast-Path eligibility
  and dedicated-vs-shared subscription as two independent findings, each with its own criteria and
  confidence level.
- `requirements-nfr` now scopes its latency/networking-integration evidence prompt explicitly to
  Fast-Path eligibility, and notes it has no bearing on the separate subscription-ownership choice.

## 1.25.2 — 2026-09-18

Made the standard landing zone (hub-and-spoke) the default subscription-model recommendation,
reserving Fast-Path shared subscriptions for applications with an evidenced, specific latency or
networking-integration requirement.

- `docs/PLATFORM-GUIDES-INDEX.md`'s Fast-Path Subscriptions section now states this default rule
  explicitly, so it isn't proposed merely for onboarding speed/convenience.
- `architecture-networking`'s Evaluation/Design/Validation steps now apply and check this rule:
  Fast-Path requires a cited NFR/REQ evidencing the specific driver, or the standard landing zone
  is proposed instead.
- `requirements-nfr` now prompts for this evidence during requirements drafting, so architecture
  has something concrete to cite rather than inferring the driver itself.

## 1.25.1 — 2026-09-18

Clarified that the target Azure deployment/runtime view (and Container view) must give each
distinct Azure managed service its own diagram node, never a combined "data"/"data stores" box.

- `architecture-template.md`'s Section 2 diagram rules now explicitly forbid one node listing
  multiple managed services (e.g. Flexible Server/Blob/Cosmos DB/Service Bus/Event Hubs together),
  even when every service is Proposed rather than Confirmed.
- `speckit.architecture.prompt.md`'s Phase 2 assembly step and Phase 3 diagram-completeness review
  both call this out explicitly, so the orchestrator both draws and validates one-node-per-service.
- `architecture-data`'s Diagram contributions guidance now states this as a hard rule instead of
  an implied default.

## 1.25.0 — 2026-09-18

Made requirements and architecture drafting propose defensible defaults instead of defaulting to
`UNKNOWN` for target-design judgments, so a first pass gives Architects a working recommendation
to review rather than a blank checklist.

- Constitution Principle IV now distinguishes Category 1 (as-is/business facts, still `UNKNOWN`
  when the app team hasn't supplied them) from Category 2 (target-design judgments — SKUs,
  sizing, NFR targets, security/resiliency/CI-CD design, cost estimates), which now require a
  sourced `Proposed` recommendation with rationale and confidence level.
- `speckit.requirements.prompt.md` and `speckit.architecture.prompt.md` carry the same Category
  1/2 discipline up front, before any layer skill or requirement drafting step runs.
- Every `architecture-*` and `requirements-*` layer skill's Unknown-handling instruction now
  points at this discipline, so a missing SKU, target, or control design gets a reasoned proposal
  first and `UNKNOWN` only when no defensible basis exists even at low confidence.
- This does not relax evidence discipline for as-is facts (ownership, populations, contractual
  SLAs) — those remain ungoverned Unknowns exactly as before; only target-design judgments gain
  the propose-first behavior.

## 1.24.0 — 2026-09-18

Broadened GCF-specific treatment into an end-to-end CI/CD automation and SDLC design.

- Added the DevSecOps Checklist to the master knowledge index and required requirements and
  architecture to reconcile it with GCF and MEC.
- Requirements now assesses repository, pipeline, testing, artifact, IaC, deployment, rollback,
  secrets, documentation and handoff controls as well as current GCF use.
- Architecture Section 12.6 now designs the full commit-to-production lifecycle; GCF remains the
  required quality/security gate solution within that broader design.
- Checklist-linked delivery patterns are resolved through the catalog to current published
  successors, avoiding superseded rollback and segregation-of-duties sources.

## 1.23.0 — 2026-09-18

Made GCF the required target for application and IaC CI/CD quality/security gates.

- Requirements now records per-repository as-is GCF evidence and creates a target GCF adoption NFR
  whenever current PEP-based use is absent or unproven.
- Architecture now designs PEP integration, gate applicability, profiles, pipeline enforcement,
  evidence, remediation ownership, and approved time-bounded customization in Section 12.6.
- Delegated compliance, NFR, security, and resilience skills enforce the same behavior so prompt
  orchestration cannot lose the requirement.

## 1.22.0 — 2026-09-17

Added GCF v3 as a first-class SDLC quality and security knowledge source.

- Added a condensed gate reference for application code, testing, container images, IaC, PAR,
  evidence, pipeline ordering, applicability, and current profile baselines.
- Required application design and engineering to assess every gate and trace its applicability,
  selected profile, configuration, evidence, ownership, and remediation treatment.
- Documented that relaxed profiles and exemptions require governed application/GCF approval and
  expiry handling; they are not informal pipeline overrides.

## 1.21.7 — 2026-09-17

Fixed requirements-gate readiness detection for generated rollups.

- `check-prerequisites.ps1` now reads the authoritative application `requirements.md` rollup,
  rather than the source-record `requirements/index.md`.
- The checker now recognizes the generated heading-and-Outcome gate format and normalizes
  descriptive states such as `Cleared - approved for early architecture` to `Cleared`.

## 1.21.6 — 2026-09-17

Removed dangling `agent:` frontmatter references from all `.github/prompts/speckit.*.prompt.md`
files.

- Each prompt referenced a custom chat-mode agent (e.g. `agent: speckit.architecture`) that has no
  corresponding custom agent definition anywhere in this repo, since this framework keeps full
  instructions in the prompt body rather than a paired `.github/agents/*.agent.md` file.
- In an app workspace where a vanilla `specify init` also created `.github/agents/*.agent.md`
  files for overlapping command names (plan, tasks, implement, analyze, clarify, constitution,
  specify), VS Code could resolve the frontmatter reference to that unrelated vanilla agent
  definition instead of running this framework's own instructions — and for the framework-only
  commands (architecture, requirements, decisions, risks), the reference resolved to nothing at
  all, leaving the chat input unusable.
- Prompt files no longer declare an `agent:` field; they run under the current/default agent,
  which matches how their bodies were already written (self-contained instructions, no dependency
  on an external custom agent mode).

## 1.21.5 — 2026-09-17

Established an overall-application-first recovery objective hierarchy.

- Architecture now requires one overall application RTO/RPO before resilience design and treats
  that pair as the mandatory end-to-end outcome.
- Recovery analysis prioritizes databases, object/file storage, durable caches, and durable
  messaging because state recovery normally determines aggregate RTO/RPO.
- Per-service RTO/RPO is supporting detail, required only for separately approved targets or
  components on the critical recovery path; arbitrary values for every stateless service are not
  required.
- Architecture Section 12.4 now provides a mandatory overall-application row followed by optional
  stateful dependency/service rows.

## 1.21.4 — 2026-09-17

Normalized generated requirement, decision, risk, and gate table separators so regenerated index
files satisfy the repository Markdown table-style checks.

## 1.21.3 — 2026-09-17

Made R-Type an explicit output of completed application architecture reasoning.

- The architecture template now requires application outcomes and REQ/NFRs first, applicable LSEG
  ADRs/patterns/CPF/MEC/resiliency guidance second, reconciled application design third, exact
  change classification fourth, and the R-Type proposal last.
- The shared Layer Finding and all eight architecture skills now design for requirement and LSEG
  fit before reporting exact changes and an R-Type signal; provisional R-Type hypotheses cannot
  constrain layer design.
- The architecture orchestrator may classify Rehost only when the completed cross-layer design
  proves no higher migration-necessary change, and it drafts Section 8 only after all design,
  conflict, transition, and cost reasoning is complete.
- Requirements now prepares component-level change signals and evidence requests but does not
  recommend the application R-Type or create its R-Type ADR.
- Constitution Principle I now clarifies that R-Type is derived after architecture reasoning.

## 1.21.2 — 2026-09-17

Strengthened provisional and final R-Type evidence requirements.

- Requirements intake and the requirements template now require a component-level R-Type
  Confirmation Matrix covering compute, data/storage, messaging/interfaces, identity, network,
  MEC/security, resiliency, operability/licensing, and migration transition.
- R-Type ADRs must provide an owner-attributed evidence request pack that states exactly what
  artifact, measurement, assessment, or test can confirm, de-escalate, or escalate each component.
- Requirements and architecture gates now remain open when a potentially R-Type-forcing fact is
  Unknown; Unknowns cannot be treated as evidence for Rehost or automatic escalation.
- Explicit constitutional R-Type examples must be applied before the generic Rehost default.

## 1.21.1 — 2026-09-16

Clarified skill-first evidence intake across the Spec-Kit workflow.

- Constitution Principle IV, the architecture template, and the requirements/architecture
  orchestrator prompts now require agents to use an applicable existing workspace or installed
  skill/tool before custom analysis of Word, Excel, PDF, image, diagram, or other non-Markdown
  evidence.
- When no suitable capability exists, agents must record the limitation, request an accessible
  export/transcription or app-team clarification, and retain unsupported facts as `UNKNOWN` rather
  than inventing an extraction pipeline or inferring evidence.

## 1.21.0 — 2026-09-15

Added evidence-driven source profiling and deterministic data migration tool selection.

- Requirements now create one `DATA-SRC-###` profile per distinct database/store/file set/durable
  queue, capturing exact engine/version/topology, schema/features, scale, workload/change rate,
  dependencies, operations/security, downtime/RPO/reconciliation/rollback and network throughput.
- `architecture-data` now selects tools separately for discovery, target/SKU, app-access/database/
  performance assessment, schema, offline/online movement, validation/reconciliation and
  postmigration optimization using published LSEG guidance and CPF constraints before the current
  Microsoft DMS Tools Matrix (reviewed 2026-08-18).
- Architecture Sections 6.5–6.7 record profile fitness, exact source-target Matrix provenance,
  hard filters, selected/rejected tools and deployment/network/security/operability/license/cost/
  cleanup consequences.
- Validators reject incomplete source profiles, missing lifecycle phases, ungoverned blank/no-row/
  third-party decisions, missing CPF paths, and Classic DMS outside its clear-listed MySQL scope.

## 1.20.0 — 2026-09-15

Made canonical LMP Migration SAD v3.4 coverage exhaustive and mechanically verifiable.

- Added `export-sad-contract.ps1` and checked-in `sad-v3.4-contract.json`, extracted directly from
  the live DOCX: 322 content blocks, 116 styled/numbered headings (74 canonical content headings),
  75 tables, 36 guidance/questions, 4 media assets, and source SHA-256.
- Added `sad-v3.4-coverage-map.json`, `architecture-sad-coverage`, and Architecture Section 16 so
  every canonical content heading and its child questions/table fields maps to upstream evidence,
  an owning skill, and a governed gap when incomplete.
- Expanded architecture outputs for SAD business/IBS/criticality/App Family/deployment context,
  five WAF pillars, cross-environment/IP/DNS/bandwidth, full data/privacy/transfers, detailed
  access/session/authorization/data protection, per-component operability, exact 25%/10% TCO
  controls, FinOps evidence, licensing, pattern requests, risk IDs, and sustainability.
- Corrected stale SAD source references and aligned `G-sad-baseline.md` table schemas and heading
  sequence to the live canonical DOCX; the Eikon/Jupyter SAD remains a non-normative depth benchmark.
- Added `validate-sad-contract.ps1` for canonical DOCX/baseline drift detection and extended
  `validate-architecture.ps1` to require all canonical SAD IDs and architecture field markers.

## 1.19.0 — 2026-09-15

Added first-class client, application-cutover, and data-migration transition design before planning.

- New `requirements-transition` skill and mandatory Requirements Section 2A disposition profile
  cover migration units/waves, client/user migration, coexistence, data seed/delta/freeze/
  reconciliation, cutover windows, rehearsals, go/no-go, rollback, hypercare, and decommission.
- New eighth architecture layer, `architecture-transition`, owns Section 7A and coordinates the
  transition across target compute, data, networking, integration, security, and resilience.
- Architecture Data now supplies per-store migration constraints; Cost prices migration-only
  resources and source/target overlap; Planning imports stable `MIG-###` controls without
  re-deciding strategy.
- SAD, test-plan, migration-plan, and task templates now carry client-wave, reconciliation,
  rollback, hypercare, handoff, and decommission evidence through execution.
- Added `validate-requirements-transition.ps1` and expanded `validate-architecture.ps1`; gate
  automation rejects missing transition topics, controls, decisive rollback/data fields, or state
  diagrams.

## 1.18.0 — 2026-09-15

Raised target-architecture output to SAD-ready topology and connectivity detail.

- Architecture Layer Findings now return structured elements, boundaries, and directional
  relationships with stable IDs, protocol/port, authentication, exposure, status, evidence, and
  requirement traces; each owning layer supplies its part of the model.
- `architecture-template.md` now requires C4 Context, C4 Container, and Azure deployment/runtime
  views focused on the target solution, plus end-user connectivity and SAD 2.6.2 Application-to-
  Application Interface Design tables that reconcile one-to-one with diagram `FLOW-*` IDs.
- `/speckit.architecture` extracts user, interface, component, and boundary inventories from SAD/
  discovery evidence before layer dispatch and rejects invented or ambiguous target services.
- Added `validate-architecture.ps1`; architecture gate progression now checks mandatory views,
  interface columns, placeholders, and diagram/table flow reconciliation.
- `/speckit.analyze` now reports target-diagram and connectivity-reconciliation gaps.

## 1.14.1 — 2026-09-14

Hardened workflow gates so an unreviewed template cannot advance an artifact.

- `.specify/scripts/powershell/check-prerequisites.ps1`: requires the gate row's exact status to
  be `Cleared`, a non-placeholder named reviewer, and a valid ISO review date. It now blocks when
  an entry in `decisions.md` remains Proposed or an entry in `risks.md` remains Identified, unless
  that specific entry explicitly records `Blocks Progression = No`.
- `.specify/templates/{requirements,architecture,plan}-template.md`: changed default persisted
  gate status from a menu containing `Cleared` to `Not Started`.
- `.specify/templates/{decision-log,risk-register}-template.md`: added a machine-readable
  `Blocks Progression` field, defaulting to `Yes`.
- `.specify/memory/constitution.md` and `.specify/scripts/powershell/README.md`: document the
  default blocking behavior and its narrowly scoped non-blocking exception.

## 1.15.0 — 2026-09-14

Added a formal Core Principles of Good Requirements contract to the requirements workflow.

- `.github/prompts/speckit.requirements.prompt.md`: requires every requirement to be clear,
  outcome-focused, active voice, atomic, verifiable, and explicit about intent; requires the
  reviewer to reject vague or implementation-prescriptive wording.
- `.github/skills/requirements-functional/SKILL.md`: validates functional requirement intent,
  atomicity, active voice, measurable acceptance, and what-versus-how separation.
- `.github/skills/requirements-nfr/SKILL.md`: validates atomic NFRs, intent, measurable targets,
  and deterministic pass/fail verification.
- `.github/skills/requirements-compliance/SKILL.md`: applies the same quality contract to
  compliance controls and their evidence paths.
- `.github/skills/requirements-coverage/SKILL.md`: adds an independent requirement-quality review.
- `.specify/templates/requirements-template.md`: adds the principles and an
  `Intent / Problem Addressed` column to functional, NFR, and compliance tables.

## 1.16.0 — 2026-09-14

Merged compliance requirements into the functional and non-functional requirement model.

- `.github/prompts/speckit.requirements.prompt.md` and
  `.github/skills/requirements-compliance/SKILL.md`: compliance controls now become atomic
  Section 1 behavior or Section 2 Security/Reliability/Operational Excellence NFRs; no standalone
  compliance section or `NFR-COMPLIANCE-###` IDs are created.
- `.specify/templates/requirements-template.md`: removed the standalone compliance section,
  retained the complete MEC applicability matrix under Section 2, and renumbered later sections.
- Downstream architecture/spec/task/SAD guidance now traces MEC controls to ordinary REQ/NFR IDs.

## 1.17.0 — 2026-09-14

Added folder-based source records with generated compatibility rollups for complex migrations.

- New `requirements/`, `decisions/`, and `risks/` source folders with indexes; individual records
  are authoritative and existing rollup filenames remain generated compatibility views.
- Added `sync-records.ps1` for migration and rollup generation and `validate-records.ps1` for ID,
  filename, ADR, and cross-reference validation.
- Updated scaffolding, prerequisite gates, prompts, and register/traceability skills to read indexes
  first and validate individual records.
- Added record templates for requirements and risks; ADR records use the full MADR template.
- Added a single-feature-folder fallback for external workspaces without Git.

## 1.14.0 — 2026-09-14

Added a seventh architecture layer, **Cost & Capacity Profile**, so `architecture.md` produces a
per-environment Azure cost estimate from public pricing — rightsized per environment, aligned to
the region already decided, and gated by CPF module and Security/MEC SKU-tier constraints so a
security-mandated SKU (e.g. Azure Key Vault Premium-only) is never silently downgraded to save
cost.

- `.specify/templates/requirements-template.md`: new **Environment Capacity & Scaling Profile**
  subsection in Section 2 — the app team must supply, per environment (Production and every
  non-production environment this migration will build), a Baseline Load/Concurrency Target,
  Reliability Target (RTO/RPO/HA), and any Scaling/Burst Event. Production's baseline is sized to
  its *expected* performance target; every non-production environment's is sized to its *minimum
  viable* capacity — optimistic, not conservative. Input Sources, gate checklist, and Progress
  Tracking updated.
- New `.github/skills/architecture-cost/SKILL.md`: owns `architecture.md` Section 13. Dispatched
  **last**, after Compute, Data, Networking, Integration, Security, and Resilience, since it
  prices their decisions. Before any rightsizing, checks every priced service's CPF module
  (`docs/cpf/`) and Section 7's Security & MEC Alignment findings for a SKU/tier constraint that
  overrides cost minimization — rightsizing may only vary capacity/instance-count parameters
  within whatever range the CPF module and MEC criteria leave open, never substitute a
  cheaper SKU/tier a security/compliance requirement forbids. Non-production environments (Dev in
  particular) are assumed to apply Azure Well-Architected Framework-aligned off-hours
  shutdown/deallocation unless a named CPF/service reason prevents it.
- `.specify/templates/architecture-template.md`: new **Section 13 (Cost & Capacity Profile)** —
  13.1 Pricing Basis & Region Alignment (must match Section 5's Region), 13.2 Per-Environment
  Baseline Cost Profile (with an explicit "SKU/Tier Constrained By" column), 13.3 Scaling/Burst
  Cost Profile, 13.4 Non-Production Cost Optimisation, 13.5 Summary. Old Section 13 (Self-Review)
  and Section 14 (Backlog Playbook Coverage Check) renumbered to 14 and 15; Layer Ownership, gate
  checklist, and Progress Tracking updated; Section 14's Self-Review gained a Cost/SKU validation
  review row.
- `.github/prompts/speckit.architecture.prompt.md`: seven-layer table (was six), explicit
  last-dispatched ordering for `architecture-cost`, and every Section 13/14 cross-reference
  renumbered to 14/15.
- `.github/prompts/speckit.requirements.prompt.md`: added the per-environment performance/
  reliability input as a required (not optional) input, and a Phase 2 drafting step for the new
  Environment Capacity & Scaling Profile subsection.
- `.github/prompts/speckit.analyze.prompt.md`: renumbered existing Section 13/14 references to
  14/15; added a new check for missing Section 13.2 environment rows, an unflagged CPF-/MEC-
  constrained SKU/tier, a Region mismatch against Section 5, an invented scaling event, or an
  unexplained Section 13.4 "No".
- `.github/skills/architecture-{compute,data,integration,networking,resilience,security}/SKILL.md`:
  fixed the generic "orchestrator's Section 13" self-review cross-reference to Section 14;
  `architecture-security` also gained a Constraints note that a security-mandated SKU/tier binds
  Section 13 in every environment.
- `deliverables-template/md-templates/C-cost-estimate.md` and `C-cost-profile.md`: noted as
  restating `architecture.md` Section 13 rather than re-deciding any SKU/tier; cost-estimate
  template now repeats its table per environment with a "SKU/Tier Constrained By" column.
- `.specify/memory/constitution.md` (Principle IV), `AGENTS.md`, and `docs/INDEX.md`: updated for
  the new layer/section numbering and the cost/rightsizing/SKU-validation discipline.

## 1.13.1 — 2026-09-14

`deliverables-template/md-templates/G-sad-baseline.md` had drifted from the actual SAD template it
is supposed to mirror — it only had 7 flat, generic sections (Architecture Overview, Component
Model, Network Architecture, Data Architecture, Security Architecture, Cost & Sustainability,
Operational Architecture) against the real
`deliverables-template/binary-templates/SAD/LMP Migration SAD (v3.4-final).docx`, which has 9
top-level sections and ~40 subsections (Overview; Proposed Solution incl. Bill of Services,
Deployment, Integration, Networking, Architectural Decisions, Design Risks, Regulatory Impact,
MEC, LSEG Standards; Data View; Security View incl. Access Control and Data Protection; End-to-End
Operability; Total Cost of Ownership incl. Third Party License Details, previously missing
entirely; Cutover Methodology; Client Migration; Sustainability).

- `deliverables-template/md-templates/G-sad-baseline.md`: rewritten section-for-section to match
  the v3.4-final docx's heading hierarchy 1:1 (Sections 1–9, same order/subsections), each
  annotated with which upstream spec-kit artifact (`architecture.md` layer section,
  `requirements.md` REQ/NFR, `decisions.md`/`risks.md`) sources it, per this repo's existing
  traceability convention. The previously well-aligned TCO content (§6, incl. its
  `⚠️ HUMAN REVIEW REQUIRED` thresholds) is preserved verbatim under the new Section 6, with the
  previously-missing §6.4 Third Party License Details table added.
- `.specify/templates/requirements-template.md` Section 9.1 and
  `.github/prompts/speckit.requirements.prompt.md` Phase 3 step 11: updated to check coverage
  against the new 9-section structure instead of the stale 7-section one, and to flag it as a
  finding if a future SAD docx revision drifts from this template again.
- `.specify/memory/constitution.md` Principle IV: updated the SAD/Deliverables coverage-check
  bullet to reference the corrected section list.

## 1.13.0 — 2026-09-14

`requirements.md` gains a second independent coverage check — this time against
`deliverables-template/`, the actual final deliverables (SAD baseline, MEC assessment, DevSecOps
report, test plan, cost deliverables, etc.) a migration must eventually produce — so a gap that
would otherwise only surface once `architecture.md` or the SAD itself is being drafted is caught
and assigned to the migration team as a concrete action while requirements are still open.

- `.specify/templates/requirements-template.md`: new **Section 9 (SAD & Deliverables Template
  Coverage Check)** — 9.1 checks Sections 1–3 against every structural section of
  `deliverables-template/md-templates/G-sad-baseline.md` (and, if supplied, an actual filled-in
  SAD document for this app); 9.2 checks the remaining `deliverables-template/` files, marking
  those legitimately owned by a later phase (`architecture.md`/`spec.md`/`plan.md`) as `N/A` and
  `F-caf-eligibility-assessment.md` as permanently out of scope (per `AGENTS.md`); 9.3 (Open
  Points & Topics) captures every Partial/No row with a concrete, assignable action for the
  migration team, linked to a real `decisions.md`/`risks.md` entry. Input Sources, gate checklist,
  and Progress Tracking updated.
- `.github/prompts/speckit.requirements.prompt.md`: Phase 3 (Review) gained a step to populate
  Section 9; Required Inputs now also notes an optional existing filled-in SAD document.
- `.github/prompts/speckit.analyze.prompt.md`: added a check for missing Section 9 coverage rows,
  unresolved Partial/No rows with no Open Point, or an Open Point with no linked Decision/Risk or
  a vague/unassignable action.
- `.specify/memory/constitution.md`: Principle IV gained a bullet requiring this second
  independent, external-checklist-based coverage validation; Workflow Order Step 1 updated to
  match.
- `docs/INDEX.md`: added a row pointing to `deliverables-template/md-templates/` and its dual use
  as a Section 9 coverage-check source.

## 1.12.0 — 2026-09-12

`requirements.md` and `architecture.md` each gain an independent Backlog Playbook coverage check —
validating the drafted document against the Playbook's own User Stories, not just each
document's internal self-review, so a topic neither Section 7 nor Section 13 thought to check for
still gets caught.

- `.specify/templates/requirements-template.md`: new **Section 8 (Backlog Playbook Coverage
  Check)** — 8.1 lists one row per `Phase = "Discovery & Assessment"` User Story from
  `docs/backlog-playbook/v1/Backlog-Playbook-v1.csv` with a Yes/Partial/No coverage call against
  Sections 1–3; 8.2 (Open Points & Topics) captures every Partial/No row with the specific source
  document or decision needed to close it, linked to a real `decisions.md`/`risks.md` entry. Gate
  checklist and Progress Tracking updated.
- `.specify/templates/architecture-template.md`: new **Section 14 (Backlog Playbook Coverage
  Check)** — same shape, filtered to `Phase = "Planning & Design"` User Stories, checked against
  the assembled document's sections. Layer Ownership's cross-layer-synthesis row, gate checklist,
  and Progress Tracking updated.
- `.github/prompts/speckit.requirements.prompt.md` and `speckit.architecture.prompt.md`: Phase 3
  (Review) gained a step to populate the new coverage-check section before stopping at the gate.
- `.github/prompts/speckit.analyze.prompt.md`: added a check for missing Playbook coverage rows,
  unresolved Partial/No rows with no Open Point, or an Open Point with no linked Decision/Risk.
- `.specify/memory/constitution.md`: Principle IV gained a bullet requiring this independent,
  external-checklist-based coverage validation; Workflow Order Steps 1–2 updated to match.
- `docs/INDEX.md`: Backlog Playbook row now notes its dual use (Standard Backlog filtering +
  coverage-check source).

## 1.11.2 — 2026-09-12

- Added `docs/tech-selection/tech-selection-overview.md`, a local Markdown normalization of the
  Tech Selection Patterns workbook's primary decision sheet. The architecture index, orchestrator,
  and compute/data/integration layer skills now use this local source to guide Azure technology
  selection without depending on a FastLane checkout.

## 1.11.1 — 2026-09-12

- `.github/prompts/speckit.architecture.prompt.md` and the compute, data, and integration layer
  skills now consume a pinned FastLane constitution's normalized Tech Selection Overview when it is
  available. The table makes `Adopt` recommendations directly usable and requires a proposed
  decision/risk plus human Architect review for deviations, unresolved, and unlisted choices.

## 1.11.0 — 2026-09-12

`/speckit.architecture` and its six layer skills now follow the same **Plan → Act → Review**
discipline just added to `/speckit.requirements`, and every layer skill may now also consult
Microsoft official documentation as a secondary research source.

- `.github/skills/architecture-*/SKILL.md` (all six — compute, data, networking, integration,
  security, resilience): added a Plan→Act→Review framing note (Plan = Required Inputs + Research;
  Act = Evaluation + Design; Review = Validation); added Microsoft official documentation (Azure
  Architecture Center, Microsoft Learn, Well-Architected Framework guidance) as a **secondary**
  Research source, used only to fill a gap the LSEG knowledge base doesn't cover — LSEG
  ADRs/patterns/CPF modules/MEC criteria always take precedence on conflict; added a Validation
  check confirming no Microsoft-documentation use silently overrode LSEG governance.
- `.specify/templates/architecture-layer-finding-template.md`: Research field now documents
  Microsoft-documentation use and the LSEG-precedence rule.
- `.specify/templates/architecture-template.md`: new **Section 13 (Self-Review Findings)** — the
  orchestrator's own whole-document Review pass (LSEG knowledge coverage per layer, Microsoft-
  documentation grounding, cross-layer conflicts not already in Section 11, completeness,
  traceability); Input Sources table gained a Microsoft-documentation row; Layer Ownership note
  reframed around Plan→Act→Review; gate checklist and Progress Tracking updated accordingly.
- `.github/prompts/speckit.architecture.prompt.md`: restructured into explicit **Phase 1 (Plan)**
  — shared setup, research-scope checklist — **Phase 2 (Act)** — dispatch layers, resolve
  conflicts, assemble — **Phase 3 (Review)** — critique the assembled document and populate
  Section 13, then stop at the gate.
- `.github/prompts/speckit.analyze.prompt.md`: added a check for a skipped/stale architecture
  self-review, and a check for Microsoft documentation being used to override (rather than
  supplement) LSEG governance.
- `.specify/memory/constitution.md`: Principle III now states the Plan→Act→Review requirement for
  both `/speckit.requirements` and `/speckit.architecture` (including each layer skill's own
  internal cycle) and the Microsoft-documentation-as-secondary-source rule; Workflow Order Step 2
  description updated to match.

## 1.10.0 — 2026-09-12

Requirements are now produced **Plan → Act → Review**, not drafted once and handed to the human
gate — Review is a real self-critique pass, catching gaps before a human has to find them.

- `.specify/templates/requirements-template.md`: new **Section 7 (Self-Review Findings)** — a
  mandatory critique of the Section 1–6 draft checking (1) LSEG knowledge coverage (were the
  `docs/` catalogs actually relevant to this app's profile consulted, not just the obvious one),
  (2) conflicting requirements (two FR/NFR/Compliance rows pulling in opposite directions), (3)
  completeness (mandatory NFR rows, Must/Metric pairing, unasked askable `UNKNOWN`s), and (4)
  traceability (every ID represented in Section 6). Fixable gaps get fixed before presenting the
  document; only genuine open questions become a Decision/Risk/`UNKNOWN`. Gate checklist and
  Progress Tracking updated accordingly.
- `.github/prompts/speckit.requirements.prompt.md`: restructured into explicit **Phase 1 (Plan)**
  — work out which LSEG knowledge areas actually apply to this app before drafting — **Phase 2
  (Act)** — draft Sections 1–6 — **Phase 3 (Review)** — critique that draft and populate Section 7.
- `.github/prompts/speckit.analyze.prompt.md`: added a check for a skipped or stale self-review
  (Section 7 missing/empty, or the Requirements Review Gate `Cleared` while a finding still implies
  an unresolved gap).
- `.specify/memory/constitution.md`: Workflow Order's Step 1 description now notes the Plan → Act
  → Review structure.

## 1.9.0 — 2026-09-11

Added end-to-end traceability across the whole artifact chain — every requirement and decision now
carries a visible "what does this actually impact?" trail through architecture, spec, plan, tasks,
and risks, instead of each phase only citing its immediate predecessor.

- `.specify/templates/architecture-template.md`: added a **"Traces to Req/NFR"** column to Sections
  3 (Component Model), 4 (App-Level Changes), 5 (Integration & Networking), 6 (Data View), and 7
  (Security & MEC Alignment) — every design row now cites the `requirements.md` ID it implements.
- `.specify/templates/requirements-template.md`: new **Section 6 (Traceability Matrix)** — one
  table per REQ/NFR/NFR-COMPLIANCE ID with columns for its `architecture.md`, `spec.md`, and
  `plan.md`/`tasks.md` reference, updated in place by each later phase rather than tracked
  separately. Gate checklist now requires it to be initialized before proceeding.
- `.specify/templates/decision-log-template.md`, `risk-register-template.md`: added **Traces
  From** (the requirement that prompted the entry) and **Downstream Impact** (every later artifact
  that depends on it, updated as those artifacts are created) fields.
- `.specify/templates/plan-template.md`, `tasks-template.md`: design/task rows now carry forward
  the REQ/NFR ID from their source instead of citing only the immediate predecessor document.
- `.specify/templates/spec-template.md`: Section 5's table shape aligned exactly to
  `architecture.md` Section 7's (including the trace column) so the "copied verbatim" instruction
  is structurally true, not just a stated intent.
- Every `.github/prompts/speckit.*.prompt.md`: updated to carry trace citations forward, update
  `decisions.md`/`risks.md` Downstream Impact as later artifacts reference them, and keep
  `requirements.md`'s Traceability Matrix current as each phase runs.
- `.github/prompts/speckit.analyze.prompt.md`: new check for a broken end-to-end chain — a
  Traceability Matrix row stuck at "Not yet reached" once its artifact exists, a trace citation
  that doesn't match a real ID, or a stale/empty Downstream Impact field.
- `.specify/memory/constitution.md`: Principle IV extended with the end-to-end traceability mandate
  and an extensibility rule — any deliverable added to the workflow later must plug into the same
  Traces-From/Traces-to/Downstream-Impact convention, not invent its own tracking shape.

## 1.8.0 — 2026-09-11

Strengthened `requirements-template.md` so resiliency, disaster recovery, and operational
requirements are never skipped as an afterthought.

- Section 2 (Non-Functional Requirements): added mandatory Reliability seed rows (NFR-001 RTO/RPO,
  NFR-002 HA/DR failover) and a mandatory Operational Excellence seed row (NFR-003 monitoring/
  alerting) — every application needs at least one of each, even a Rehost inheriting the platform
  default, and that default must be named and sourced, not left blank.
- Section 3 (Compliance & Standards Requirements): added dedicated **Resiliency / Disaster
  Recovery** (citing `docs/resliency-guidance/resliency-guidance.md`, MEC-v3_3-11, MEC-v3_3-27)
  and **Operational Standards** (citing MEC-v3_3-10 patch management, MEC-v3_3-28/29 logging) rows
  alongside the existing DevSecOps and MEC rows.
- Requirements Review Gate: added a check that at least one Reliability and one Operational
  Excellence NFR are present, and that Section 3 was reviewed against the resiliency guidance doc
  as well as MEC/DevSecOps documentation.
- `.github/prompts/speckit.requirements.prompt.md`: process steps updated to call these out as
  mandatory, not optional examples to delete.

## 1.7.0 — 2026-09-11

Added a **Requirements & NFR phase** before Architecture — the discovery report and LSEG knowledge
now flow into a dedicated, evidence-grounded requirements document first, which `architecture.md`'s
six layer skills consume as their primary input instead of re-eliciting requirements themselves.
Also hardened every requirements/architecture skill to ask the user for missing inputs rather than
proceeding on assumptions.

- `.specify/templates/requirements-template.md`: new artifact produced before `architecture.md`.
  Functional requirements use [EARS](https://alistairmavin.com/ears/) syntax (Ubiquitous,
  Event-driven, State-driven, Unwanted behavior, Optional feature, Complex); non-functional
  requirements are organized by the **Azure Well-Architected Framework**'s five pillars
  (Reliability, Security, Cost Optimization, Operational Excellence, Performance Efficiency —
  chosen over a generic quality model since it's Azure-native and maps directly onto the six
  architecture layer skills); both use MoSCoW prioritization. A dedicated **Compliance & Standards
  Requirements** section captures named LSEG standards (e.g. DevSecOps standards compliance, MEC)
  separately from app-specific NFRs. Every row tags which architecture layer(s) should consume it.
- `.github/prompts/speckit.requirements.prompt.md`: new first command. Explicitly required to ask
  the user for the discovery report / additional documentation / an existing requirements file if
  not already provided — never fabricate requirements from assumptions. Stops at a Requirements
  Review Gate.
- `.github/skills/architecture-*/SKILL.md` (all six): added a "Required Inputs" section instructing
  the skill to ask the user for missing discovery-report/documentation/`requirements.md` inputs if
  invoked standalone, and a `requirements.md` bullet as the primary Research source (each layer
  reads only the rows tagged with its own name).
- `.specify/templates/architecture-template.md`, `architecture-layer-finding-template.md`:
  `requirements.md` added as the primary Input Source; Layer Finding contract gained a
  "Requirements traced" field; Architecture Review Gate checklist gained a requirements-traceability
  check.
- `.specify/scripts/powershell/`: `create-new-feature.ps1` now copies `requirements-template.md`
  (not `architecture-template.md`) at feature creation — that now happens at the Requirements step;
  new `setup-architecture.ps1` copies `architecture-template.md` → `architecture.md` once gated;
  `check-prerequisites.ps1` gained `-RequireRequirementsReady`, checking `requirements.md`'s
  Requirements Review Gate before `/speckit.architecture` may proceed; `common.ps1`'s
  `Get-FeaturePaths` gained a `REQUIREMENTS` path.
- `.github/prompts/speckit.architecture.prompt.md`: Phase 0 now checks the Requirements Review Gate
  and runs `setup-architecture.ps1` instead of creating the feature itself; consumes `requirements.md`
  as the primary input across all layer dispatches.
- `.github/prompts/speckit.clarify.prompt.md`, `speckit.analyze.prompt.md`: extended to cover
  `requirements.md` as the earliest active document, and to flag requirements-traceability gaps.
- `.specify/memory/constitution.md`: Workflow Order gained Step 1 (`/speckit.requirements`,
  Requirements Review Gate), renumbering all later steps; Principle II now cites `requirements.md`
  Section 3 as where compliance scoping begins; Principle III's stop-and-review rule now includes
  `/requirements`.

## 1.6.0 — 2026-09-11

Decomposed the Architecture phase into an orchestrator + six domain skills — a single prompt
doing research/evaluation/design/validation for compute, data, networking, integration, security,
and operability all at once wasn't credible; each now gets its own pass, with the orchestrator
responsible for reconciling contradictions between them.

- `.github/skills/architecture-compute/SKILL.md`, `-data/`, `-networking/`, `-integration/`,
  `-security/`, `-resilience/`: six new skills (native `.github/skills/*/SKILL.md`
  discovery/auto-invocation), each documenting its own Research → Evaluation → Design →
  Validation process, which `docs/` catalogs it consults, which `architecture.md` section(s) it
  owns, and — critically — the constraints/dependencies it has on the *other* layers.
- `.specify/templates/architecture-layer-finding-template.md`: new shared contract every skill
  returns its findings in (Research/Evaluation/Design/Validation/Constraints/Dependencies/
  Decisions/Risks/Conflict signal), so the orchestrator can merge them mechanically instead of
  re-reading free-form prose.
- `.github/prompts/speckit.architecture.prompt.md`: rewritten as a true orchestrator — Phase 0
  (shared setup/research), Phase 1 (dispatch all six layer skills), Phase 2 (**Conflict
  Resolution** — collect every layer's constraints/conflict signals, resolve by constitutional
  rule where possible, escalate to a human Decision where not), Phase 3 (assemble + self-check),
  Phase 4 (gate).
- `.specify/templates/architecture-template.md`: added a **Layer Ownership** table (which skill
  owns which section), **Section 11 (Conflict Resolution Log)**, **Section 12 (Operability &
  Resilience)**, per-layer rows in Progress Tracking, and gate checklist items for layer
  completeness and conflict logging.
- `.specify/memory/constitution.md`: Principle III extended — the orchestrator may only resolve a
  cross-layer conflict by applying another constitutional principle as the tie-breaker; anything
  else is escalated to a human Decision, never settled by the orchestrator's own preference.
  Workflow Order's Step 1 description updated accordingly.
- `.github/prompts/speckit.analyze.prompt.md`: added a check for incomplete/unreconciled layers
  (a Layer Finding not Complete while its section already has content, or a cross-layer
  contradiction missing from Section 11).

## 1.5.0 — 2026-09-11

Added an **Architecture phase** that runs before scope is written down — the constitution's new
**Workflow Order** section: `/speckit.architecture` → `/speckit.specify` → `/speckit.plan` →
`/speckit.tasks` → `/speckit.implement`, each gated in turn.

- `docs/INDEX.md`: new master index into every LSEG knowledge source under `docs/` — ADR and
  pattern catalogs (`docs/adrs/`, `docs/patterns/`), the 268-module CPF catalog (`docs/cpf/`),
  `docs/mec-reference.md`, `docs/PLATFORM-GUIDES-INDEX.md` (networking/regions/subscriptions),
  `docs/treatment-strategies/`, `docs/CAF/`, `docs/resliency-guidance/`, and
  `docs/backlog-playbook/`. States a grounding rule: every citation must be a real catalog entry,
  never invented.
- `.specify/templates/architecture-template.md`: new artifact produced before `spec.md`. Captures
  Input Sources, Target Solution Overview, C4 Diagrams (Mermaid `C4Context`/`C4Container`/
  `C4Component`), Component Model / Bill of Services (grounded in CPF modules), App-Level Changes
  Required, Integration & Networking, Data View, Security & MEC Alignment, R-Type Recommendation,
  Architectural Grounding (ADRs/patterns applied), Open Decisions & Risks, and an Architecture
  Review Gate (human sign-off) — modeled on the LMP Migration SAD's section shape, condensed to
  what a migrate-first decision actually needs.
- `.github/prompts/speckit.architecture.prompt.md`: new orchestrator-architect prompt. Takes a
  discovery report + other source docs, grounds every target-service/ADR/pattern claim in
  `docs/INDEX.md`'s catalogs, defaults R-Type to Rehost, and stops at the Architecture Review Gate.
- `.specify/templates/spec-template.md`: Section 2 (R-Type) and Section 5 (MEC) now **cite**
  `architecture.md` instead of re-deciding — spec.md can't be written until architecture's gate is
  Cleared. Renamed "Assumed R-Type" → "Approved R-Type" throughout.
- `.specify/templates/plan-template.md`: Phase 1 now **inherits** the target design from
  `architecture.md` Section 3 instead of re-deriving it; only new implementation-level decisions
  get logged at plan time.
- `.specify/scripts/powershell/`: `create-new-feature.ps1` now copies `architecture-template.md`
  (not `spec-template.md`) when a feature is created; new `setup-spec.ps1` copies `spec-template.md`
  → `spec.md` once gated; `check-prerequisites.ps1` gained `-RequireArchitectureReady`, checking
  `architecture.md`'s Architecture Review Gate before `/speckit.specify` may proceed;
  `common.ps1`'s `Get-FeaturePaths` gained an `ARCHITECTURE` path.
- `.github/prompts/speckit.specify.prompt.md`, `speckit.plan.prompt.md`, `speckit.clarify.prompt.md`,
  `speckit.analyze.prompt.md`: updated for the new gate ordering, citation-not-re-derivation
  discipline, and uncatalogued-reference / R-Type-mismatch checks.
- `.specify/memory/constitution.md`: new **Workflow Order** section; Principles II–IV extended to
  reference `architecture.md`'s gate and `docs/INDEX.md`'s catalog-grounding requirement.
- `README.md`: core idea, instantiation steps, and layout table updated for the Architecture phase.

## 1.4.0 — 2026-09-11

- `.specify/templates/spec-template.md`: Sections 3 (Standard Backlog) and 4 (Backlog Delta) now
  have `Owning Org` and `GHCP-Assisted?` columns, carried straight from the Backlog Playbook CSV's
  `Tags` column (`OwningOrg=Shared|MSFT|LSEG` and the `GHCP` tag) instead of being dropped when a
  row is copied into a spec. New Backlog Delta rows must also state both.
- `.github/prompts/speckit.specify.prompt.md`: instructed to carry the two tags over verbatim, not
  infer a `GHCP` value the CSV doesn't state.
- `.github/prompts/speckit.analyze.prompt.md`: Backlog drift check now also flags a Section 3/4
  row missing or mismatching its Owning Org / GHCP-Assisted? value.

## 1.3.0 — 2026-09-11

- `.specify/memory/constitution.md` (Principle I): added the Standard Backlog bullet — every
  migration runs the same fixed User Story backbone from
  `docs/backlog-playbook/v1/Backlog-Playbook-v1.csv`, filtered by R-Type; Tasks flex per app, User
  Stories don't, and a new User Story requires a Decision entry + migration-team review.
- `.specify/templates/spec-template.md`: replaced the freeform Section 3 (Migration Scope) with
  **Section 3 (Standard Backlog)** — a table populated by filtering the Backlog Playbook CSV by
  `R-Type Applicability` (blank/All always; Refactor rows also for Rearchitect) — and a new
  **Section 4 (Backlog Delta)**, a reviewed exception path for User Stories the Playbook doesn't
  cover. Sections renumbered 5–8 accordingly (MEC/Discovery, Out of Scope, Decisions & Risks,
  Review Checkpoint), with the checkpoint now confirming the backlog filter and any delta review.
- `.specify/templates/decision-log-template.md`: added a "Scope" decision category for Backlog
  Delta entries.
- `.github/prompts/speckit.specify.prompt.md`, `speckit.analyze.prompt.md`: updated to populate/
  check the new Section 3/4 backlog structure and flag backlog drift (unreviewed new User Stories,
  wrong R-Type filter) alongside existing modernization-creep and sign-off checks.
- `README.md`: added the Backlog Playbook to the core-idea flow and layout table.

## 1.2.0 — 2026-09-11

- `.specify/templates/decision-log-template.md`: adopted the [MADR](https://adr.github.io/madr/)
  (Markdown Architectural Decision Records) community schema — Context and Problem Statement,
  Decision Drivers, Considered Options, Decision Outcome, Consequences, Pros/Cons per option —
  extended with this repo's own migration-governance fields (R-Type Impact, Evidence/Links) and
  the human-only Decision/Reviewer/Review Date gate. Status Key now cross-references MADR's
  proposed/accepted/rejected/superseded equivalents. The minimal Nygard-style ADR fields
  (Status/Context/Decision/Consequences) remain fully covered for lightweight decisions.
- `.github/prompts/speckit.decisions.prompt.md`: field names updated to match (Considered Options,
  Decision Outcome, Evidence/Links).

## 1.1.0 — 2026-09-11

- `.specify/memory/constitution.md`: added **Application Treatment Strategies (R-Types)** section
  — shared Rehost/Replatform/Refactor/Rearchitect definitions, per-tier escalation triggers, and
  an escalation-discipline rule (apply the "needed for migration?" test to every change, even
  inside Refactor/Rearchitect). Principle I now points here for R-Type justification. Sourced from
  the LSEG Migration Wiki Application Treatment Strategies (R-Types & Complexity) page.
- `.specify/templates/spec-template.md`: Section 2 (R-Type Justification) now points to the
  constitution's R-Type definitions/escalation triggers.

## 1.0.0 — 2026-09-11

Initial version.

- `.specify/memory/constitution.md`: 5 principles — Migrate Don't Modernize (NON-NEGOTIABLE),
  Scoped Adoption of Security & Discovery Requirements, Human-in-the-Loop Governance
  (NON-NEGOTIABLE), Evidence-Based Traceability, Least-Change Footprint.
- `.specify/templates/`: spec, plan, tasks, decision-log, risk-register templates, all wired to
  the constitution's migrate-first bias and human-approval gates.
- `.specify/scripts/powershell/`: `create-new-feature.ps1`, `setup-plan.ps1`,
  `check-prerequisites.ps1`, `common.ps1` — sequential `NNN-app-slug` numbering, git branch
  automation, and a hard gate check blocking `/tasks` until the plan's Phase 2 Review Gate is
  `Cleared`.
- `.github/prompts/`: `speckit.constitution`, `speckit.specify`, `speckit.clarify`,
  `speckit.plan`, `speckit.tasks`, `speckit.decisions`, `speckit.risks`, `speckit.analyze`,
  `speckit.implement`.
- `docs/mec-reference.md`: condensed MEC v3.3 (April 2026) 30-criteria catalog, sourced from
  `AzureLZHostedApps-CyberMinimumEntryCriteria-v3_3.xlsx`, framed for migration-scoping rather than
  full control implementation detail.
