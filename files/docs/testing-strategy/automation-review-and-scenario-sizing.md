# Automation review and high-level scenario sizing

This is framework workflow guidance, not a change to the extracted LMP policy. Activity ownership
comes from `LMP-Migration-Testing-Strategy.md`: Sections 2.2, 4, the relevant test section,
and Appendix 5 RACI. The proposed split remains subject to human review.

## Requirements: establish the as-is position with the Application Team

Record one automation review entry per canonical test type in `requirements/testing-profile.md`.
Use `Verified`, `Partial`, `None`, `Unknown`, or `Not Applicable`. Missing repository/discovery
references mean **Unknown**, not **None**. A negative or partial answer needs a dated Application
Team response; a framework name or discovered test file alone does not prove reusable automation.
Evidence-backed N/A concerns test applicability, not missing automation.

Register each supplied plan, catalog, workbook, source repository, test asset and run report with
its version/date and exact locator, scope, authority, access, applicability and freshness. Classify
each claim as source fact, proposed judgment, required human input, or approved decision. A supplied
plan or workbook is evidence of what it states, not automatic authority over current LMP governance,
the independently derived R-Type, or the target architecture. Preserve disagreements as explicit
source conflicts with both claims/locators, affected scope, governing precedence rule, human owner,
downstream impact and a linked action. Do not silently select one source or call missing evidence
evidence of absence.

For every Unknown, Partial or None entry, create a tracked review action with an Application Team
contact, coordinating owner, needed-by gate/date and REQ/NFR plus risk/ADR trace. Ask for suite and
script locations/versions, covered and uncovered scenarios, verified case counts, latest run
results, pipeline execution, test data/baselines, framework/tool approval, maintenance capacity
and handover ownership. Record the response/evidence or `Pending`; do not fabricate a reply.
Follow up unresolved gaps before scope/effort is baselined. Verified entries retain evidence and
the reuse assessment; partial coverage is never extrapolated to unverified scenarios.

Use a shared Human Input and Decision Register in the profile for non-automation gaps and source
conflicts as well. Local `ACT-###` references are trace links, not a new requirement namespace.
An `AUT-##` follow-up is itself the action for its automation row; do not create a second ledger
entry for the same question. Each open action names the exact question, reason, contact and
coordinating owner, expected evidence/location, needed-by date or gate, affected records/assets,
blocking impact, status and actual answer/evidence when received. Unanswered means Pending, never a
guessed response. Do not require a separate ADR for every fact question; link one only when a
decision or risk warrants it.

Keep test-asset availability independent from reuse health: an asset may be reported or linked but
unverified, verified available, unavailable, or unknown, while its use may separately be reuse,
adapt, build, manual, excluded, or undecided. A successful, dated compatible run and coverage
evidence—not a repository name, framework file, or general catalog—support verified reuse. Report
zero verified cases when that is the evidence-backed count; do not convert unknown inventory into
zero or a failure of document generation.

## Architecture: propose reviewable scenario families

Reconcile the actual source component/store/interface/flow and critical-behavior inventories with
the target disposition (retain/change/replace/retire), data/state movement, impacted and dependent
unchanged behavior, requirements, test family/case and evidence status in Architecture Section
14.4. Every in-scope impact has Covered, Proposed, Excluded-with-rationale, or Pending disposition;
Pending links the profile action. For retirement, check callers, consumers, data ownership,
transition and rollback so the case inventory does not invent a target component. Do not fabricate
source paths or infer business behavior from example catalogs.

For each applicable/conditional type, outline a tailored family when actual application evidence
supports it, particularly where automation is None, Partial or Unknown. A pending answer need not
prevent an evidence-bounded proposal, but it prevents confirmed reuse. If behavior or inventory is
not available, carry a named action instead of manufacturing a full case catalog. Preserve the
profile action trace and distinguish verified assets from proposed work.

Use stable scenario references, REQ/NFR and component/flow traces, measurable expected outcomes,
environment and data prerequisites, automation approach (reuse/adapt/build/manual), proposed
volume bands with a derivation and confidence, and implementation/execution/maintenance roles
with exact strategy section/RACI references. Count families separately from detailed test cases;
proposed counts are not verified inventory. Do not write detailed scripts or invent thresholds.

| Test type | Candidate families to tailor to evidenced application scope |
| --- | --- |
| Connectivity | Allowed and denied user/service/component paths, identity and endpoint resolution |
| Unit | Migration-changed units: success, boundary, error handling, mocks and regression; retain existing suites |
| Data migration verification | Completeness, integrity, reconciliation, duplicates and replay for actual data movements |
| Migration tool | Supported migration modes, permissions, failure handling and source-environment fitness |
| Application installation | Deployment/configuration, dependencies, startup and post-deployment verification |
| Smoke/regression | Critical journeys and unchanged behavior exposed to migration changes |
| Change-based functional | Changed components and unchanged dependencies, including integration for Migration-Team refactoring |
| Full functional | Rearchitect user stories and end-to-end positive/negative business flows |
| Performance and baseline | Owner-selected latency, component/critical-flow/whole-app load, capacity, stress or endurance |
| High availability | Applicable process/zone/dependency faults, failover, background load and recovery metrics |
| Disaster recovery | Recovery, dependency-only failover, integrity, critical functions and failback/normalization |
| Security testing | Applicable identity, authorization, configuration, code and vulnerability controls |
| Security penetration testing | Authorized target attack surface; scope and execution reviewed with LSEG Security |
| Operational acceptance testing | Reviewed L2 catalog scenarios; reference Section 14.2 without duplicating counts |
| User acceptance testing | Application-Team business acceptance and integration when no Migration-Team refactoring occurs |

These are candidate families, not universally mandated cases. Exclusions need applicability evidence.
Keep Integration within functional testing/UAT. OAT, HA and DR retain distinct acceptance purposes,
and Production-only testing requires its own authorization and safety controls.

In the Test Plan, preserve supplied case IDs and source locators; use stable local IDs for proposed
high-level outlines. Each case outline records origin, actual asset/component/flow and requirement
trace, objective/preconditions/data/steps at a high level, measurable expected outcome, covered/
adapt/proposed/excluded/pending disposition, environment/tool/automation, owner, evidence-result
path and action. Do not call a proposed case executed or passed. Keep OAT catalog IDs in the OAT
matrix and count them once. For an applicable type with no defensible outline, provide the action
that identifies the missing evidence and blocks execution scope confirmation rather than inventing
business behavior. Counts distinguish unique cases, scenario families, groups/classes and repeated
runs; reconcile contradictory workbook/reference totals and do not count duplicated classifications
as unique cases.

### Unit and performance ownership boundaries

Section 4.1 makes automation shared responsibility. When MEC prerequisites and Application Team
maintenance capacity are met, Migration Team framework recommendation, two to three generic
automated samples and knowledge transfer are limited to **one sprint**. Application Team adoption,
continued coverage growth and maintenance are separate work. Do not assign creation of an entire
missing legacy suite to Migration by default. Unmet prerequisites follow the Test Exception process.

For unit tests (Section 6.2 and the INDEX normative resolution), Migration developers implement or
extend tests only for migration-changed, impacted code. Application-wide legacy gaps need an
Application Team decision and capacity, not automatic migration scope expansion.

For performance (Section 7.1), the Application Owner determines testing level and supplies NFRs;
LSEG supplies baseline metrics/scripts and test flows/assets. Migration Team assesses scope,
validates baseline reproducibility and produces/adapts workload scripts and performs migration
performance testing with Application support. Separate missing baseline acquisition, workload
script creation/adaptation, data/telemetry setup and execution. Compare equal volumetrics; additional
future-load tests are separate. Missing multiuser baseline uses the strategy's governed
latency-measurement fallback, not invented load results or silently waived performance testing.

## Planning: expose size, work and decisions without writing detailed cases

The high-level Test Plan consumes the review ledger and Architecture Section 14.3. For each
applicable test type, show scenario-family scope/count bands, verified reusable coverage and
uncovered scope, reuse/adapt/build/manual decisions, and effort ranges in person-days for:
scope/deep-dive review, automation implementation/adaptation, data/environment setup, execution,
defect/retest and reporting/handover. Record no-build scope as zero with rationale.

Identify ongoing maintenance capacity separately. Explain estimation drivers (units/flows,
complexity, data sets, protocols, load profiles and run length), uncertainty and exclusions.
Translate effort into the existing 1/2/3-tester elapsed ranges without linear compression of
specialist, L2, environment or approval bottlenecks. Never assume tester capacity is developer or
performance-engineer capacity; book those roles separately. Trace to backlog work and the four-party
plan review. Migration and Application Teams deep-dive scope, effort and automation decisions;
their review does not reassign L2/Security execution or waive the strategy's acceptance gates.

Reconcile estimate reports by their explicit start/end boundaries, included/excluded phases,
calendar, external waits, dependencies, case/asset basis, version and confidence. An L2 OAT window
and end-to-end migration duration measure different scopes; do not force equality or inherit a
single-region example's DR N/A. Keep R-Type sourced independently from the approved architecture
and governing migration strategy; a conflicting workbook/plan becomes an owned source conflict,
not an automatic architecture change. Separate evidence-based source constraints from proposed
estimates, and re-estimate after approved scope changes.

## Stage-aware readiness and honest reporting

The Test Plan validator accepts `-ValidationStage Draft`, `ReadyForReview`, or `Execution`; omitting
the parameter preserves strict Execution behavior for existing task-generation and prerequisite
callers. Draft checks structure and traceability without claiming approval. ReadyForReview checks
that the proposal and unresolved facts are reviewable and owned; it does not claim input completeness
or formal approval. Only Execution requires an Approved plan, all four named/date/evidence-backed
organizational approvals, the named overall human approval, and resolved execution-blocking inputs.
An Approved status never relaxes any requirement. Existing prerequisite checks keep using the
default strict stage before task generation.

Architecture Section 14.1 `Conditional`/`Blocked` readiness is not a Draft or document-review
failure when it has an ADR/risk and a relevant owned profile action. Link that action directly
or through matching authoritative REQ/NFR/ADR/risk IDs; it must state the question, expected
evidence/location, contact/accountable coordinator, needed-by gate, blocking impact and honest
status. A generic unresolved dependency without that trace still fails. A pending per-test
approver must identify the intended role/contact and an owned appointment/authority action;
the coordinating role is not a human appointment. Only Execution requires `Ready` architecture
readiness and named per-test approvers. Do not fabricate dates, appointments, answers or approval
evidence to make a document review pass. Invalid readiness, contradictory applicability/traces,
unsupported Verified/Approved/Closed claims and stage/status mismatches remain errors at every stage.

Report two separate results: artifact quality relative to evidence available and input completeness
(verified, unresolved, unavailable, or conflicting). A structurally sound proposal can be ready for
human review while source facts remain open, but it is not execution-ready. Publication renders the
complete source and its real status; it does not approve or silently reject a useful Draft because
evidence is unavailable.

## Reader-first review path

Author a concise `## Review Brief` immediately after Test Plan metadata and before Test Strategy.
Aim for one page: purpose and current maturity; proposed scope and exclusions; source/version
evidence basis and confidence; artifact quality separately from input completeness; and the next
human gate with the exact version/approval boundary. Say what reviewers are being asked to decide
now and what is still blocked for execution. Counts are optional and must distinguish reported
from verified inventory, unique cases from families/repeated runs, and unknown from zero; never
invent a completeness percentage. Scope and timing proposals are not verified input or approval.

Use `Significant Conflicts` and `Priority Human Actions` tables, each with at most five ranked
items: priority/why now, a linked canonical CON or ACT/AUT record, its exact current status, and
review focus/next step. Prioritize material scope/governance/acceptance conflicts and actions that
unblock dependent decisions before downstream sizing or scheduling; not alphabetical/ID order,
and not every question marked Critical. Include the needed decision, contact/accountable role,
needed-by gate and impact through the linked canonical row, not a second copied register.
Use `None — reason` when there are no significant items; link the full register for the remainder.

Link directly to detailed scope/effort, high-level case mappings, assets, estimate boundaries,
architecture impact crosswalk, all profile conflicts/human inputs and the approval gate. Keep
supporting tables in their existing sections; the opening must not list the whole case catalog.
Keep cross-file links repository-root-scoped or use controlled source URLs when authoring so the
unchanged source body remains navigable from `deliverables/`; local section anchors work in both.
Replace the template's feature-directory link placeholders with the actual owning feature.
Reconcile brief status, scope, confidence and any counts against authoritative rows at every
review. Existing Drafts without a brief warn rather than failing; ReadyForReview requires it.
Legacy execution plans retain strict readiness/approval checks and a navigation migration warning.
Publication copies the full canonical source, including its brief when present; it must not
invent or independently update a brief in the published copy. Update the root, record the
application change and republish; changed versions need fresh version-specific approval.
