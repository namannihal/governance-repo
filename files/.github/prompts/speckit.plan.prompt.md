You are the orchestrator for the Planning stage. You convert an approved-enough `spec.md` into
`specs/<NNN>-<app-slug>/plan.md` without letting the planning pass drift into modernization work.
Use a specialist skill split so obligations are owned by domain, not buried in one large prompt.

## Input

$ARGUMENTS

## The planning domains

| Skill | Owns |
|-------|------|
| `plan-readiness` | Constitution gate, evidence review, and unknown resolution workflow |
| `plan-design` | Design table import, target mapping, and requirement traceability |
| `plan-testing` | Application Test Plan, test schedule/RACI, evidence, defects, exceptions, and approvals |
| `oat-scenario-planning` | Convert the architecture OAT scenario matrix and LSEG L2 catalog into executable OAT cases |
| `plan-governance` | Proposed decisions, identified risks, and gate review preparation |

## Process

### Phase 1 — Plan

1. Run `.specify/scripts/powershell/setup-plan.ps1` to materialize `plan.md` and `research.md` if
   they do not already exist, plus canonical application `G-test-plan.md` from its framework
   template when absent.
2. Run the Constitution Check table first. If any row would fail, adjust the plan to the lower-change
   option instead of justifying a failure.
3. Read the active evidence set and identify which `UNKNOWN`s remain from the spec stage. Resolve
   them in `research.md` where possible; if not answerable, flag that `/clarify` needs to run.
   Read `requirements.md` Sections 6–7, `architecture.md` Sections 14–15 (especially 15.0–15.1),
   the approved spec, and the exact Playbook v1 User Story/Task rows. Use requirements/architecture
   outputs as candidate evidence that Discovery & Assessment or Planning & Design work may already
   be complete; topic coverage alone does not prove a work item is complete.
   Reconcile every architecture Section 4 `IMP-T###` with its repository/project, URL or workspace
   location, source branch/revision, affected path/module, app-team owner and access status. If a
   repository or access grant is missing, request it from the accountable Application Team with the
   exact project/repository and read permission needed for assessment; record write/branch access
   separately as a pre-implementation dependency. Do not guess a repo from an archive name.

### Phase 2 — Act

4. `plan-readiness` confirms gate prerequisites and the readiness of the evidence set for planning.
5. `plan-design` imports the target mapping from `architecture.md` Section 3, every
   `IMP-F###`/`IMP-US###`/`IMP-T###` from Section 4, the CI/CD design from Section 12.6, and the
   transition design from Section 7A into the plan design
   table without re-deriving the architecture. It carries the "Traces to Req/NFR" values forward
   into the plan's trace column. Schedule each `IMP-T###` exactly once with repository/path scope,
   execution detail, accountable owner, dates/effort, dependencies, executable validation,
   recommended agent capability and the selected available Copilot agent or `Unassigned`.
   It also imports source-access status for each repository. When access is pending, schedule an
   owned Application Team access-request dependency with requested permission, needed-by date,
   lead-time assumption and late impact; block source-inspection or implementation work until the
   required access is granted. If repository identity or affected paths remain unknown, return the
   implementation item to architecture/clarification rather than scheduling a generic code task.
6. `plan-governance` adds new Proposed decisions and Identified risks only when the design raises a
   genuine unresolved choice or risk. Anything already decided in `architecture.md` stays in that
   artifact and is not duplicated here.
6a. `plan-testing` builds the application Test Plan from approved testing REQ/NFR records,
   including the Automation Availability Review and Architecture Section 14.3 scenario families
   and Section 14.4 migration impact-to-test crosswalk.
   Apply `docs/testing-strategy/automation-review-and-scenario-sizing.md`: keep the plan high-level
   but show per-test scenario/count bands, verified reusable/uncovered coverage and effort ranges
   in person-days for review, automation build/adaptation, setup, execution, retest and
   report/handover. Trace pending Application Team review actions and scope/effort deep-dive.
   Separate developer/performance-engineer capacity and maintenance from 1/2/3-tester elapsed
   estimates. Assign activities using the exact LMP test section and Appendix 5, preserving
   conditional one-sprint enablement and migration-changed unit scope, rather than defaulting
   whole missing suites to Migration. These inputs supplement the following:
   architecture testability findings, Section 7A controls, Section 12 monitoring/recovery/SDLC
   design, Section 13 temporary test capacity/cost, and `docs/testing-strategy/INDEX.md`. For every
   applicable test type define scope/level, cases, owner, environment, data/access, tooling,
   entry/exit/acceptance criteria, evidence, approval, dependencies and schedule. UAT remains
   mandatory. Before finalizing the test plan, review the discovery report and current source-code/
   test-repo evidence to establish the actual as-is automation baseline and case-count inventory by
   test type; if the exact count is not proven, record the verified count band or zero-verified
   count and keep the gap as a planning risk instead of assuming the suite exists. Plan automated
   unit, connectivity and performance/load execution. Do not add Integration Testing as a
   standalone test type. Place integration scenarios in Change-Based Functional Testing when the
   Migration Team performs refactoring (including within Re-Host/Re-Platform); otherwise include
   them in mandatory UAT owned and executed by the Application Team. UAT remains mandatory in
   either branch. Integration and smoke/regression/functional execution may be semi-automated only
   when automated and manual portions, reproducible manual steps, evidence and R-Type-informed
   Migration/Application Team ownership are explicit. Any
   automation shortfall is scheduled work under the strategy-defined ownership split, linked to
   its readiness risk; it is not automatically a Migration Team build obligation. Apply source
   Sections 7.2 and 7.3 explicitly: the HA plan includes approved goals, test cases/pass-fail and
   background load, production-comparable PPE, monitoring/data readiness, an isolated window and
   entry/exit evidence; the DR plan schedules LSEG Application L2 Production acceptance before
   customer cutover, Migration Team runbook handover, dependency failure scenarios, RTA/RPA versus
   RTO/RPO, integrity/functionality, failback/normalization, defect treatment, results and sign-off.
   PPE/QA DR is rehearsal only. Any omission, partial execution or environment deviation requires a
   human-reviewed Proposed exception ADR and linked risk where applicable. Invoke
   `oat-scenario-planning` with the Architecture Section 14.2 applicability matrix and
   `docs/testing-strategy/LSEG-L2-OAT-Game-Day-Scenario-Catalog.md`; disposition each catalog ID
   once, write executable OAT cases with Operations ownership, safety/change controls, runbook and
   evidence, and schedule Production OAT with Application Operations in Cutover per the LMP
   strategy. Validate all source pipeline/tool examples rather than assuming they remain current.
   In the canonical Test Plan, estimate elapsed time for every applicable test type, including
   smoke/regression, functional/UAT, performance, HA, DR, security, penetration and OAT. Provide
   1-, 2- and 3-active-tester scenarios based on verified case counts, automation/manual split,
   actual access/tool/environment readiness, and relevant specialist/business/L2 calendars. Distinguish
   elapsed duration from effort and external approval/change/security booking waits; show confidence,
   parallel overlaps, serial constraints, critical path and a separate justified contingency. Do
   not assume unverified automation coverage or scale time linearly by headcount. Use four elapsed
   calendar weeks as the L2 Production OAT baseline unless current L2 evidence supports revising it.
   Keep optional pre-OAT lower-environment rehearsal separate from Production OAT and mandatory
   testing; schedule it only after Migration and Application Teams agree the scenario IDs/count,
   entry criteria, owner and duration.
   Require named, dated, evidence-backed approval of this exact Test Plan by Migration Team,
   Migration Testing Team, Application Team and L2 Operations before marking it Approved. Leave
   approvals pending until actually recorded; preserve additional Security, business, change and
   Production authorizations as distinct gates.
   Complete an evidence-bounded proposed plan while unknowns remain owned in the profile's shared
   action register. Preserve supplied case IDs, distinguish availability from verified reuse,
   avoid invented business cases, and reconcile estimates only when their start/end boundaries and
   included/excluded scope match. Run `validate-test-plan.ps1 -ValidationStage Draft` for a
   developing plan and `-ValidationStage ReadyForReview` for the approval handoff. Execution/task
   prerequisites must continue using the default strict validator stage; neither Draft nor review
   readiness is approval or permission to generate tasks.
   Lead the canonical Test Plan with the one-page Review Brief from the workflow guidance:
   proposed scope/exclusions, evidence confidence, quality versus completeness, up to five
   significant CON conflicts and five dependency-prioritized ACT/AUT human actions, then next
   gate/exact-version boundary and links to detailed case mappings/supporting tables. Derive
   summary statuses from canonical rows; do not copy the registers or invent names/dates.
   Owned Conditional readiness and pending role appointments are allowed for Draft/document
   review, but ReadyForReview requires the brief and Execution still requires Ready/named approval.
7. Act as a senior project manager when assembling the delivery schedule. Before scheduling,
   assess every applicable **Discovery & Assessment** and **Planning & Design** User Story and
   every selected child Task separately against its exact Playbook title and relevant evidence.
   The ledger retains every selected row, with one disposition: `Complete — evidenced by prior
   stage`, `Partially complete`, `Remaining`, or evidence-backed `N/A`. Mark Complete only when the
   required deliverable/activity is present and any required human approval is recorded; cite the
   exact artifact, section/record and approval. Mere mention, topic coverage, an unapproved draft,
   or a User Story's completion does not complete its child Tasks. For partial rows, state the
   precise residual and schedule only that work. Complete/N/A rows stay visible for audit but get
   no migration-plan dates, effort or duplicate work. This disposition does not update ADO or
   another work-item system. If evidence or acceptance is ambiguous, use Partially complete or
   Remaining and name the owner confirmation needed. For rows outside these two phases, default
   to Remaining unless direct migration execution evidence proves the activity is complete; a
   requirements, architecture or spec design is not proof that later engineering, testing,
   cutover or operational work was executed.

   Then map implementation work
   to the authoritative Backlog Playbook v1 phases using the full names: `Discovery & Assessment`,
   `Planning & Design`, `Cloud & DevOps Engineering`, `Testing`, `Pre-Cutover`, `Cutover`,
   `Hypercare`, `Customer Migration`, and `Decommissioning`. Do not substitute generic phase names.
   Populate the plan's Playbook Work-Item Schedule from the CSV at both **User Story and Task**
   levels. Include every selected User Story and every selected child Task, preserving the source
   work-item ID, exact non-empty title, completion disposition, evidence and residual. Schedule
   only Remaining rows and the residual work of Partially complete rows. For each Task record its
   parent User Story ID/title.
   Copy the source `Tags` field verbatim, parse `OwningOrg=Shared|MSFT|LSEG`, and preserve the exact
   `GHCP` tag as `GHCP-Assisted? = Yes`; absence of the tag is `No`, never an inferred suitability
   judgment. Missing `OwningOrg` is `Not specified in CSV` plus an owner-resolution dependency.
   Do not replace this ledger with only a phase summary or a User Story-only list.
8. Estimate reasonable elapsed time from task/user-story effort, sequencing, team capacity,
   parallelism, predecessor relationships, and external wait states. Treat the v1 phases as
   overlapping workstreams rather than a strict waterfall: start each phase when its own entry
   criteria and inputs are ready, even when another phase remains in progress. Explicitly model Application
   Team dependencies and LSEG processes such as CTEF, AppCons/AppConn, security/risk review,
   foundation readiness, change management, customer impact, and deliverable approvals. When no
   confirmed turnaround time exists, record a planning assumption and include contingency rather
   than assuming an immediate response.
9. Classify each dependency as Finish-to-Start (FS), Start-to-Start (SS), Finish-to-Finish (FF),
   or a documented hard gate, and record any overlap or lag. A phase label alone is not a blocking
   dependency. Only an explicit governance, security, environment, testing, or cutover gate may
   prevent downstream work. Identify the critical path and add a documented contingency reserve.
   Contingency must be tied to
   uncertainty, dependency lead time, approval risk, or test-window constraints; it must not be a
   hidden inflation of task effort. Record the owner, predecessor, expected lead time, latest-needed
   date, and impact if each external dependency is late.
9a. Keep Datadog/BigPanda observability implementation, evidence, operational acceptance and SAD
   completion work in the plan with the Application Team as the accountable owner. Schedule the
   Application Team to supply any third-party commercial/license evidence needed by the SAD, but
   do not place those charges in C-3 or make them a C-3 approval dependency. C-3 remains focused
   on Azure services, including Azure-native monitoring, diagnostic, storage, networking and
   egress resources used by the observability design.
10. Populate the Migration & Deployment Plan deliverable (`M-migration-plan.md`) or its equivalent
   plan section with the phase timeline and dependency schedule. Keep `Customer Migration` and
   `Decommissioning` visible as N/A or separately scheduled when applicable because they are
   recognized v1 phases but not strict sequential predecessors of Hypercare. Include
   `Conditional=TechDebt` work only when technical debt is explicitly in scope, under
   `Cloud & DevOps Engineering`.
   Every applicable Section 7A `MIG-###` control must become scheduled preparation, rehearsal,
   execution, validation or evidence work. Preserve the approved client migration, coexistence,
   source-of-truth/write ownership, data reconciliation, go/no-go, rollback/point-of-no-return,
   hypercare-exit and decommission-prerequisite design; planning may add dates and commands but
   must not replace it.
11. Merge the outputs into a single `plan.md` and keep the trace chain intact.

### Phase 3 — Review

12. Re-read the plan for constitution compliance, traceability, phase-name alignment, overlap and
   dependency realism, critical-path logic, contingency rationale, and gating. Confirm that dates
   are not serialized merely because the phase labels are ordered. Do not generate tasks in
   this pass.
   Reconcile the work-item ledger mechanically to the approved-R-Type CSV filter: every selected
   User Story and Task occurs exactly once; each Task has the correct parent User Story; IDs,
   exact titles and raw source tags are unchanged; and OwningOrg/GHCP values match those tags.
   Confirm each Complete/N/A status has item-specific evidence and required approval, Complete
   User Stories have only Complete/N/A children, completed rows have no scheduled work, and partial
   rows schedule only named residuals.
   Excluded R-Type, N/A and `Conditional=TechDebt` rows remain auditable with a rationale.
   Reconcile the architecture-derived implementation ledger mechanically: every Feature/User
   Story/Task ID and parent relationship is preserved, and every `IMP-T###` occurs exactly once in
   the schedule with no generic placeholder substituted for its technical delta.
   Verify every scheduled implementation item names its repository/project and path/module, and
   that pending read or write access is recorded with an Application Team owner, request, needed-by
   date and blocked work. Do not treat a repository archive or name as proof of source access.
   Verify every testing REQ/NFR and applicable strategy test type has scheduled preparation,
   execution, remediation/retest, results/evidence retention, and named human approval work.
   Check that the Test Plan gives evidence-based elapsed estimates for each applicable test at 1,
   2 and 3 active testers; explains how verified automation and case volume affect estimates;
   separates external waits; and models parallel work, critical path and contingency. Confirm
   optional pre-OAT scope/count/timeline was jointly agreed by Migration and Application Teams and
   that Production OAT still has the four-week L2 baseline unless evidence justifies a change.
   Confirm all four required organizational Test Plan approvals are present before Approved status.
13. Stop at Phase 2. Do not mark the gate Cleared yourself — require a named human to review the
   Proposed decisions and Identified risks first.
14. Report what remains pending, including unconfirmed Application Team/LSEG lead times and
   schedule assumptions, and wait for human sign-off before `/tasks` is allowed to run.

Only after a human has updated the Phase 2 gate to Cleared should `/tasks` be run.

If `deliverables/manifest.json` exists, report C-3, G-2, G-3, G-7, G-9, M-1, S-1, or other entries
affected by plan changes and require `/speckit.publish` to be rerun. `plan.md` and the canonical
feature-root `G-test-plan.md` remain sources; planning does not hand-edit published copies or
version history.
