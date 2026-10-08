# Migration Plan: {Application Name}

**Branch**: `{###-app-slug}` | **Date**: {YYYY-MM-DD} | **Spec**: `specs/{###-app-slug}/spec.md`

> This plan turns the approved architecture and backlog into a practical migration schedule. Keep it decision-ready, concise, and explicit about dependencies, approvals, and timing assumptions. It should read like a senior delivery plan, not a collection of vague placeholders.

## Constitution Check (must pass before Phase 0)

| Principle | Check | Result |
| --- | --- | --- |
| I. Migrate, Don't Modernize | Plan's R-Type matches `architecture.md` Section 8's approved R-Type; any deviation is justified by a named migration blocker, not improvement | Pass / Fail |
| II. Scoped Adoption | Every MEC/discovery requirement implemented traces to spec Section 5 (applies = Yes), which itself traces to `architecture.md` Section 7 | Pass / Fail |
| III. Human-in-the-Loop | No task in this plan depends on a decision/risk still in Proposed/Identified status | Pass / Fail |
| IV. Evidence-Based | Every design choice below cites spec evidence or an approved decision | Pass / Fail |
| V. Least-Change Footprint | No new service/dependency introduced without a migration-necessity or approved-decision trace | Pass / Fail |

If any check fails, resolve it (update spec, log a decision, or narrow the plan) before continuing.
Do not proceed past a failed check by asserting it will be fixed later.

## Phase 0 — Research

Resolve every `UNKNOWN` from the spec. Output: `research.md` (use
`.specify/templates/research-template.md` if present, otherwise inline below).

- {Unknown} → {resolution + source}

## Phase 1 — Implementation Design (inherits Architecture)

The target mapping was already decided in `architecture.md` Section 3 (Component Model / Bill of
Services) and Section 8 (R-Type). **Do not re-derive it here** — import it, then add only the
implementation-level detail architecture didn't need (e.g. exact deployment sequencing, CPF module
inputs, environment-specific config).

| As-Is Component | Target (Azure) | R-Type applied | Traces to Req/NFR | Source |
| --- | --- | --- | --- | --- |
| {component} | {target service} | {Rehost/Replatform/...} | {REQ-###/NFR-### copied from `architecture.md` Section 3's own trace column} | `architecture.md` Section 3 |

### Architecture-Derived Refactor and Automation Work Schedule

Import every `IMP-F###`, `IMP-US###` and `IMP-T###` from approved `architecture.md` Section 4
without renaming, regrouping or losing the parent hierarchy. Architecture owns the technical
delta; planning adds sequencing, dates, delivery dependencies and execution assignment. Every
`IMP-T###` must be scheduled exactly once unless the architecture gate is reopened and the source
row is changed. Do not substitute a generic Playbook row for an application-specific delta.

`Recommended Agent Capability` is copied from architecture. `Assigned Copilot Agent` records the
actual available agent selected for implementation, or `Unassigned`; it does not replace the
accountable owner and does not imply permission to approve a gate, risk or release.

| Feature ID / Title | User Story ID / Outcome | Architecture Task ID | Domain | Repository / Path / Module | Planned Execution Detail / Deliverable | Accountable Owner | Recommended Agent Capability | Assigned Copilot Agent | Start / End / Effort | Predecessor / Dependency / Gate | Acceptance / Validation Evidence | Traces |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| {IMP-F001 / title} | {IMP-US001 / outcome} | {IMP-T001} | {Application code / Data code / Configuration / CI/CD / Test automation} | {copied scope} | {implementation sequence and artifact; no architecture re-decision} | {team/role} | {copied capability} | {available agent name or Unassigned} | {dates/effort} | {IMP-T### + FS/SS/FF/gate, access/input} | {command/test/gate/report + pass condition} | {Section + REQ/NFR + ADR/pattern/MEC/GCF} |

### Source Repository Access and Readiness

For every repository used by an architecture-derived implementation item, record the source project
and repository name/ID, URL or workspace path, branch/revision, linked `IMP-T###` items, affected
module, access state and accountable Application Team owner. Separate read access required for
assessment from authorized write/branch access required for implementation. If anything is missing,
request it explicitly from the Application Team and schedule it as an owned dependency; do not infer
access from an archive filename, repository listing or prior mention.

| Project / Repository | URL / Workspace Path | Branch / Revision | IMP-T IDs / Affected Module | Assessment Read Access | Implementation Write / Branch Access | Application Team Owner / Contact | Request / Needed-By / Dependency | Status / Blocked Work |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| {project/repo ID and name} | {URL or location} | {branch/revision} | {IMP-T### / path} | {Granted / Requested / Unknown} | {Granted / Requested / Unknown / not yet needed} | {named role/contact or Unknown} | {permission request, predecessor, lead-time, needed-by date} | {status and tasks blocked pending access} |

### Migration Transition Implementation (inherits Architecture Section 7A)

Import every applicable `MIG-###` control. Add dates, durations, named accountable roles, change
records, commands/runbook references and evidence locations. Do not change the approved strategy;
raise a new ADR/change if implementation facts require an architecture revision.

| MIG Control | Architecture Decision / Constraint | Plan Work / Runbook Step | Phase | Owner | Scheduled Window | Evidence Produced | Dependency / Gate | Source |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| {MIG-###} | {client/cutover/data/reconciliation/rollback/hypercare/decommission design} | {implementation work} | {authoritative v1 phase} | {role/team} | {date/time or planning assumption} | {artifact/log/sign-off} | {predecessor/gate} | `architecture.md` Section 7A |

### Application Test Plan Handoff

`G-test-plan.md` in this feature folder is the single canonical application Test Plan. Do not
duplicate its per-test matrix here. This plan schedules and depends on that approved deliverable.
Import each applicable test stream's estimated elapsed duration, 1/2/3-tester capacity scenario,
verified automation/manual split, dependencies and contingency into the integrated schedule without
copying the per-test matrix. Preserve the four-calendar-week L2 Production OAT baseline unless
current evidence supports a change. Keep optional lower-environment pre-OAT separate and schedule
it only after Migration and Application Teams agree the scenario count and window. Do not commit
execution-baseline dates while any required Test Plan approval is pending.

| Test Plan | Status | Requirements/Profile Source | Architecture Testability Source | Schedule / Critical-Path Integration | Exceptions / Risks | Approval Evidence |
| --- | --- | --- | --- | --- | --- | --- |
| `G-test-plan.md` | {Draft/Ready for Review/Approved} | `requirements/testing-profile.md` including automation review + {REQ/NFR IDs} | `architecture.md` Sections 14.1–14.3 | {scenario volume, automation build/adaptation effort, specialist capacity, estimated durations, overlaps, hard gates, critical path and external waits} | {ADR/RSK or None} | {Migration + Migration Testing + Application + L2 names/dates/evidence or Pending} |

Carry Application Team automation-review actions and Migration/Application scope-and-effort
deep-dives into the schedule/backlog. Consume Test Plan person-day effort by review, automation,
setup, execution, retest and report/handover; distinguish it from tester elapsed time and ongoing
maintenance. Assign activities from the exact LMP strategy section/Appendix 5, not a blanket
Migration ownership assumption.

## Migration Delivery Schedule (Backlog Playbook v1)

Act as a senior project manager when producing this schedule. Use the full authoritative v1 phase
names exactly and derive elapsed duration from applicable backlog work, predecessors, team capacity,
parallelism, external wait states, approval lead times, and contingency. Do not use generic phase
labels such as "Engineering" or "Assessment & Design".

Treat phases as overlapping workstreams, not as a strict waterfall. A phase may start when its own
entry criteria and required inputs are ready, even if another phase is still in progress. Use the
actual work-item dependencies to calculate dates. Classify each dependency as Finish-to-Start
(FS), Start-to-Start (SS), Finish-to-Finish (FF), or a documented hard gate, and record overlap or
lag. A phase name alone is never a blocking dependency. Only an explicit governance, security,
environment, testing, or cutover gate may prevent downstream work.

| Control | Plan entry |
| --- | --- |
| Playbook version | v1 |
| Estimation basis | {working calendar, capacity, effort method, parallelism assumptions} |
| Critical path | {phase and work item IDs} |
| Contingency reserve | {working days or percentage, with rationale} |
| Schedule confidence | {High / Medium / Low, with rationale} |

| Playbook Phase | Start | End | Duration | Dependencies / external waits | Owning Org | Critical path? |
| --- | --- | --- | --- | --- | --- | --- |
| Discovery & Assessment | {date} | {date} | {working days/weeks} | {predecessors and Application Team/LSEG waits} | {MSFT/LSEG/Shared} | {Yes/No} |
| Planning & Design | {date} | {date} | {working days/weeks} | {FS/SS/FF/hard gate; overlap or lag} | {MSFT/LSEG/Shared} | {Yes/No} |
| Cloud & DevOps Engineering | {date} | {date} | {working days/weeks} | {FS/SS/FF; approved design inputs and parallel foundation/AppCons-AppConn work} | {MSFT/LSEG/Shared} | {Yes/No} |
| Testing | {date} | {date} | {working days/weeks} | {FS/SS/FF; testable components, Application Team cases and windows} | {MSFT/LSEG/Shared} | {Yes/No} |
| Pre-Cutover | {date} | {date} | {working days/weeks} | {hard gates and parallel readiness work} | {MSFT/LSEG/Shared} | {Yes/No} |
| Cutover | {date} | {date} | {working days} | {hard gate: approved window and rollback readiness} | {MSFT/LSEG/Shared} | {Yes/No} |
| Hypercare | {date} | {date} | {working days/weeks} | {FS/SS; overlap with Customer Migration where applicable} | {MSFT/LSEG/Shared} | {Yes/No} |
| Customer Migration | {date/N/A} | {date/N/A} | {duration/N/A} | Concurrent with or after Cutover; LSEG-owned | LSEG | {Yes/No/N/A} |
| Decommissioning | {date/N/A} | {date/N/A} | {duration/N/A} | Separate LSEG decision; may be months or years later | LSEG | {Yes/No/N/A} |

`Customer Migration` and `Decommissioning` are recognized v1 phases but empty placeholder phases in
the source backlog. Keep them visible and mark them `N/A` when not applicable. Do not treat them as
mandatory sequential predecessors of Hypercare.

### Playbook Work-Item Schedule (User Stories and Tasks)

Populate this ledger directly from `docs/backlog-playbook/v1/Backlog-Playbook-v1.csv` using the
approved R-Type filter. Include every selected **User Story and Task** row; do not stop at the
phase-level summary or User Story level. Preserve the source work-item ID and exact non-empty title.
For each Task, resolve and record its parent User Story ID/title from the Playbook hierarchy. Keep
User Stories in the table too so ownership and GHCP suitability remain visible at both levels.

For every **Discovery & Assessment** and **Planning & Design** row, assess whether the exact
Playbook activity is already evidenced by requirements, architecture, specification or another
existing deliverable. Use one disposition: `Complete — evidenced by prior stage`, `Partially
complete`, `Remaining`, or evidence-backed `N/A`. This is a plan disposition, not an ADO/GitLab
status update. Mark Complete only when the exact output/activity exists and any required named
human approval is recorded; cite the artifact, section/record and approval. A topic mention, a
coverage-table `Yes`, a draft, or parent User Story status does not complete a child Task. A User
Story is Complete only when all applicable child Tasks are Complete or N/A. For partial rows,
state the unmet outcome and schedule only that residual. Complete/N/A rows stay in the ledger for
audit but receive no dates or effort. Ambiguous cases remain partial/remaining with an owner
confirmation dependency. Rows outside these two phases default to Remaining unless direct migration
execution evidence proves completion; requirements/architecture/spec design alone does not prove
later engineering, testing, cutover or operational work was executed.

Copy the source `Tags` field verbatim into `Source Tags`. Parse `OwningOrg=Shared|MSFT|LSEG` into
`Owning Org`, and record `GHCP-Assisted? = Yes` only when the source row contains the exact `GHCP`
tag; otherwise record `No`. Never infer, add or remove GHCP suitability. If `OwningOrg` is absent,
record `Not specified in CSV` and add an owner-resolution dependency rather than inventing one.

| Playbook Phase | Parent User Story ID / Title | Work Item Type | Work Item ID | Exact Work Item Title | R-Type Applicability | Source Tags | Owning Org | GHCP-Assisted? | Plan Disposition | Prior-Stage Evidence / Approval | Residual Plan Work | Owner / Accountable Role | Start / End / Duration | Predecessor / Dependency Type | Evidence / Exit |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| {authoritative v1 phase} | {self for User Story; parent ID/title for Task} | {User Story/Task} | {CSV ID} | {exact non-empty CSV title} | {blank/All/approved R-Type} | {verbatim CSV Tags} | {Shared/MSFT/LSEG/Not specified in CSV} | {Yes/No from exact GHCP tag} | {Complete/Partially complete/Remaining/N/A} | {exact artifact + section/record + approval} | {unmet outcome; None for Complete/N/A} | {team/role; do not fabricate a person} | {N/A if Complete/N/A; otherwise dates/duration} | {ID + FS/SS/FF/gate + lag} | {artifact, report, evidence or approval} |

Rows excluded by approved R-Type or explicit out-of-scope treatment remain visible in a short
exclusion table with their source ID/title, tags and rationale. `Conditional=TechDebt` Tasks remain
excluded unless technical debt is explicitly approved in `spec.md`.

| Excluded Work Item ID | Work Item Type | Exact Work Item Title | Source Tags | Exclusion Rationale |
| --- | --- | --- | --- | --- |
| {CSV ID} | {User Story/Task} | {exact title} | {verbatim CSV Tags} | {R-Type mismatch, unapproved technical debt, or accepted N/A rationale} |

Only `Remaining` rows and the explicit residual work in `Partially complete` rows enter the delivery
schedule and `/speckit.tasks` output. Phase dates/durations are based only on that outstanding work.

### Dependency and Contingency Register

| Dependency / approval | Related phase and work items | Owner | Predecessor | Type (FS/SS/FF/gate) | Overlap / lag | Lead-time assumption | Latest-needed date | Contingency | Late impact / mitigation | Linked risk or decision |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| {Application Team input/review/test} | {phase / IDs} | {owner} | {IDs} | {type} | {days} | {working days / source} | {date} | {days or %} | {impact and action} | {RSK/DEC} |
| {CTEF / AppCons-AppConn / security / foundation / change / customer impact} | {phase / IDs} | {owner} | {IDs} | {type} | {days} | {working days / source} | {date} | {days or %} | {impact and action} | {RSK/DEC} |

Do not assume same-day response for an Application Team or LSEG process dependency without evidence.
When no confirmed service level exists, record the planning assumption, include explicit contingency,
and flag the uncertainty as an Identified risk or Proposed decision where material. Include
`Conditional=TechDebt` backlog rows only when technical debt is explicitly in scope, under
`Cloud & DevOps Engineering`.

### Decisions Required

Only **new** decisions surfaced while turning the architecture into an implementation plan (e.g. a
CPF module choice architecture didn't need to make) go here — anything architecture already
decided stays in `architecture.md`'s own decision trail, not duplicated. Each new item MUST have a
corresponding entry in `decisions.md`, status Proposed, awaiting human review.

- DEC-{NNN}: {summary} — see `decisions.md`

### Risks Identified

Same rule: only new, implementation-level risks. Each MUST have a corresponding entry in
`risks.md`, status Identified, awaiting human review.

- RSK-{NNN}: {summary} — see `risks.md`

## Phase 2 — Review Gate (STOP)

**Do not proceed to task generation until this gate is cleared.**

- [ ] All Decisions Required (above) reviewed and moved out of Proposed by a named human
- [ ] All Risks Identified (above) reviewed and moved out of Identified by a named human
- [ ] Constitution Check re-run and passing
- [ ] Every selected Playbook User Story and child Task appears exactly once in the work-item
    schedule with exact ID/title, parent linkage, source tags, OwningOrg and GHCP disposition
- [ ] Every applicable Discovery & Assessment and Planning & Design User Story and child Task has
    an evidence-backed disposition; completed rows have no scheduled work, and partial rows
    schedule only their explicit residual
- [ ] Every applicable Architecture Section 7A `MIG-###` control has scheduled work, an owner,
  evidence output and dependency/gate; no transition strategy was re-decided in planning
- [ ] Canonical `G-test-plan.md` passes validation, every applicable test is scheduled, and every
    exception/approval is resolved by a named human before task generation

**Reviewed by**: {name} | **Date**: {YYYY-MM-DD} | **Outcome**: {Approved to proceed / Blocked — see notes}

## Phase 3 — Task Handoff

Once Phase 2 is cleared, run `/tasks` to generate `tasks.md` from this plan. Tasks MUST NOT be
generated from a plan with an open Phase 2 gate.

## Progress Tracking

| Phase | Status |
| --- | --- |
| 0. Research | Not Started / In Progress / Complete |
| 1. Implementation Design | Not Started / In Progress / Complete |
| 2. Review Gate | Not Started |
| 3. Tasks Generated | Not Started / Complete |
