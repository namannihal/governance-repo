# Migration Spec: {Application Name}

**Feature branch**: `{###-app-slug}` | **Date**: {YYYY-MM-DD} | **Status**: Draft
**Application**: {Application Name} ({APP-ID}) | **Approved R-Type**: {Rehost | Replatform | Refactor | Re-architect}

> This document records the migration scope after the architecture decision is already approved. It should read like a concise implementation brief: as-is context, approved target pattern, backlog scope, and the migration-specific requirements that remain in force. Keep it factual and anchored to architecture evidence; do not re-argue the design here.
>
> If `architecture.md` is missing or its review gate is not cleared, stop and resolve that first. This spec cites the approved R-Type and MEC outcomes from architecture; it does not re-decide them.

## Input

$ARGUMENTS

## 1. As-Is Summary

Describe the application as it exists today: architecture, runtime, key dependencies, integration
points, data stores. Cite the source (discovery document, app-team interview, existing SAD) for
each fact. Mark anything not evidenced as `UNKNOWN — needs app team input`.

| Aspect | As-Is | Source |
|--------|-------|--------|
| Compute/runtime | {...} | {doc/section} |
| Data store(s) | {...} | {doc/section} |
| Key integrations | {...} | {doc/section} |
| Source repositories / projects | {repository/project names and IDs, URLs or locations, source branch/revision, affected paths/modules, assessment access status, implementation write/branch access status, and accountable app-team owner; mark missing values UNKNOWN} | {architecture.md Section 4 IMP-T IDs and source evidence / app-team confirmation} |
| Auth model | {...} | {doc/section} |
| Known constraints/EOL items | {...} | {doc/section} |

## 2. R-Type (from Architecture)

> R-Type is decided in `architecture.md` Section 8, with evidence and a human-approved Decision —
> not re-derived here. This section only records the already-approved outcome.

- **Approved R-Type**: {Rehost | Replatform | Refactor | Re-architect} — from `architecture.md`
  Section 8, Decision {DEC-###}, approved {date} by {reviewer}.
- **If this spec's analysis suggests the approved R-Type no longer fits** (rare — e.g. new
  evidence emerges during `/speckit.clarify`), do not silently override it: log a new Decision
  here referencing the conflict and route it back to `architecture.md` for re-review, per
  Constitution Principle III.

## 3. Standard Backlog (Playbook v1)

This migration's **User Story** backbone comes from the fixed Backlog Playbook, not from ad hoc
scoping — every migration runs the same initial backlog. Tasks under each User Story are the
flexible layer and may be added or reworded per app; **User Stories are not** (see Section 4 for
the reviewed exception path).

**Source**: `docs/backlog-playbook/v1/Backlog-Playbook-v1.csv` (columns: Phase, ID, Work Item Type,
Title, Tags, `R-Type Applicability`). Two tags from the CSV's `Tags` column MUST be carried into
this table, not dropped: `OwningOrg=Shared|MSFT|LSEG` (who owns executing the item) and `GHCP`
(whether the item is suited to GitHub Copilot-assisted execution).

**Filter for this spec's R-Type ({approved R-Type})**: include every row where `R-Type
Applicability` is blank, `All`, or equals the approved R-Type. If the approved R-Type is
**Rearchitect**, also include rows tagged `Refactor` — rearchitecture supersedes refactor-level
prep, it doesn't skip it.

| Phase | User Story | Work Item ID | R-Type Applicability | Owning Org | GHCP-Assisted? | Included? |
|-------|------------|--------------|------------------------|------------|-----------------|-----------|
| Discovery & Assessment | {title from CSV} | {ID} | blank / All / Refactor / Rearchitect | Shared / MSFT / LSEG | Yes / No | Yes |
| Planning & Design | {title from CSV} | {ID} | {...} | {...} | {...} | Yes |
| ... | ... | ... | ... | ... | ... | ... |

> Populate this table by filtering the CSV for the approved R-Type — do not hand-author User
> Stories here. Carry `Owning Org` and `GHCP-Assisted?` straight from the row's `Tags` column
> (`OwningOrg=...` and the presence/absence of the `GHCP` tag) — never leave them blank when the
> source row has them, and never infer a `GHCP` value the CSV doesn't state. If a Refactor/
> Rearchitect placeholder User Story from the CSV genuinely doesn't apply to this app, mark it
> "No" and say why in a note rather than omitting the row silently.
>
> This is the complete scope baseline, not a completion ledger. Do not mark a User Story complete
> or remove it because requirements or architecture cover related topics. Preserve exact evidence
> anchors for those outputs; `/speckit.plan` assesses each applicable User Story and child Task
> individually and schedules only evidenced residual work.

## 4. Backlog Delta (New User Stories — requires migration team review)

Use this **only** when analysis surfaces a genuine need for a User Story that does not exist
anywhere in the Backlog Playbook (not even as a Refactor/Rearchitect placeholder). This is a
reviewed exception, not a routine way to define scope — most app-specific detail belongs as a
Task under an existing Section 3 User Story, not a new row here.

| ID | Proposed User Story | Phase | Owning Org | GHCP-Assisted? | Why the Playbook doesn't cover this | Status |
|----|----------------------|-------|------------|-----------------|--------------------------------------|--------|
| DELTA-001 | {title} | {phase} | Shared / MSFT / LSEG | Yes / No | {reasoning — must be a migration necessity, not an improvement} | Proposed — pending migration team review |

- Every row here MUST also get a `decisions.md` entry (status Proposed, Category "Scope") per
  Constitution Principle III — a new User Story is a design decision, not a task-level detail.
- `Owning Org` and `GHCP-Assisted?` are mandatory here too, same as Section 3 — a new User Story
  still needs an owner and a Copilot-suitability call before the migration team can review it.
- Do not treat a DELTA row as in-scope for `/plan` until the migration team has reviewed it and
  changed Status to **Accepted — added to backlog** or **Rejected — reverted to Playbook scope
  only** (named reviewer, per the linked decision).
- If this table is empty, say "None — Section 3 Playbook backlog covers this app" rather than
  leaving it blank.

## 5. Migration-Relevant Requirements (MEC / Discovery)

> This table is **copied from `architecture.md` Section 7.4** verbatim — same 30 rows, same
> independent/current/target distinctions, optional human comparison and traces, no re-derivation here.

Preserve the architecture's target-design compliance result and target maturity. Include a human comparison only
when a completed workbook was supplied; `Not supplied` is valid and never blocks the spec.

| MEC ID | Criterion | Independent Applicability | This Application's MEC Compliance Status | Compliance Review State | Evidence / Rationale / Confidence | Optional Human Comparison | Target Control Design | Target Maturity | Expected / Actual Evidence | Action / Owner / Due | ADR/Pattern | Traces to Req/NFR/Risk |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| MEC-v3_3-## | {title} | Applicable / Not Applicable / Unknown | Compliant / Not Applicable / Non-Compliant / Partially-Compliant | {Proposed pending three-role review / Approved with names/date} | {source + reasoning + confidence} | {finding or Not supplied} | {target design} | {Designed / Implemented / Evidence Verified / Exception Proposed / Blocked} | {required evidence + actual locator/gap} | {action/role/date} | {ADR/pattern or N/A} | {REQ/NFR/ADR/RSK/IMP} |

## 6. Testing Evidence Handoff

This section carries the architecture and requirements evidence into planning; it is not an
application Test Plan or an execution claim. Use `docs/testing-strategy/INDEX.md`,
`architecture.md` Sections 14.1–14.4, and `requirements/testing-profile.md` when available.
The testing profile is an optional input to this first SPEC pass; the application `G-test-plan.md`
is produced during Planning & Design and is not a prerequisite. Keep unresolved evidence as a
named action/readiness gap. Do not write detailed scripts, duplicate the profile's human-input
register, or create a competing test case/coverage ledger.

Keep exactly one row for each canonical test type below, including conditional and evidence-backed
Not Applicable types. Do not add standalone Integration Testing: integration scenarios belong to
Change-based functional when the Migration Team performs refactoring, otherwise to mandatory UAT.
Full functional is conditional on Re-architect; use Not Applicable only when the approved R-Type
and evidence establish that condition does not apply. Data migration verification is Not Applicable
only when evidence establishes no in-scope data/state movement. UAT remains applicable for every
R-Type. Preserve those conditions rather than treating missing inputs as Not Applicable.

In the evidence columns, preserve exact IDs and locators: REQ/NFR IDs, architecture `XWALK-###`
and `SCN-##` references, `IMP-F###` / `IMP-US###` / `IMP-T###` IDs, profile `SRC-###`,
`AST-###`, supplied case IDs and `ACT-###` / `AUT-##` actions. For each implementation ID, retain
its repository/project, path/module, assessment read-access and implementation write/branch-access
readiness from Section 1 or the architecture evidence; do not infer missing values. A case is
identified as `Supplied` only with its source asset/locator; a `Proposed` family is not an
execution-ready case. Link applicable, R-Type-filtered Section 3 User Story IDs without removing
or marking any baseline story complete.

| Test Type | Applicability / Condition and Evidence | REQ/NFR / IMP IDs and Repository Readiness | Architecture Crosswalk / Family References | Supplied or Proposed Case / Asset References | Shared Profile Action / Source Evidence | Selected Section 3 User Story Handoff | Preparation / Execution / Retest Handoff | Evidence, Approval Gate and Accountable Roles |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Connectivity | {Applicable; user/system/component positive and negative paths; evidence} | {exact IDs; repository/project, path and separate read/write access status, or N/A with evidence} | {XWALK-### / SCN-## or pending architecture evidence} | {Supplied case ID + AST-###/locator; Proposed family; or pending} | {ACT-### / AUT-## and SRC-###, or pending; no duplicate action} | {exact selected Section 3 User Story ID(s), or unresolved mapping} | {preparation; execution; retest work handed to /plan; no dates or completion claim} | {result/evidence locator; approval gate; role(s), or pending} |
| Unit | {Existing automated suites always continue; new Migration-Team unit scope is conditional and limited to migration-changed impacted code} | {exact IDs and repository readiness, or pending} | {XWALK-### / SCN-## or pending} | {Supplied case/AST reference or Proposed family; or pending} | {ACT-### / AUT-##; SRC-###; or pending} | {exact selected story ID(s), or unresolved mapping} | {preparation; execution; retest handoff} | {CI/build evidence; approval gate and roles} |
| Data migration verification | {Conditional; Applicable if data/state moves; Not Applicable only with evidence of none} | {exact IDs and repository readiness, or pending} | {XWALK-### / SCN-## or evidence-backed N/A} | {Supplied case/AST reference or Proposed family; or pending} | {ACT-### / AUT-##; SRC-###; or pending} | {exact selected story ID(s), or unresolved mapping} | {preparation; execution; reconciliation/retest handoff} | {reconciliation evidence; approval gate and roles} |
| Migration tool | {Applicable; tool fitness and source-environment validation} | {exact IDs and repository readiness, or pending} | {XWALK-### / SCN-## or pending} | {Supplied case/AST reference or Proposed family; or pending} | {ACT-### / AUT-##; SRC-###; or pending} | {exact selected story ID(s), or unresolved mapping} | {preparation; execution; retest handoff} | {tool validation evidence; approval gate and roles} |
| Application installation | {Applicable; deployment/configuration and post-deployment behavior} | {exact IDs and repository readiness, or pending} | {XWALK-### / SCN-## or pending} | {Supplied case/AST reference or Proposed family; or pending} | {ACT-### / AUT-##; SRC-###; or pending} | {exact selected story ID(s), or unresolved mapping} | {preparation; execution; retest handoff} | {deployment evidence; approval gate and roles} |
| Smoke/regression | {Applicable; critical/common behavior and regression depth from evidence} | {exact IDs and repository readiness, or pending} | {XWALK-### / SCN-## or pending} | {Supplied case/AST reference or Proposed family; or pending} | {ACT-### / AUT-##; SRC-###; or pending} | {exact selected story ID(s), or unresolved mapping} | {preparation; execution; retest handoff} | {results evidence; approval gate and roles} |
| Change-based functional | {Conditional: Re-Factor or Migration-Team refactoring; otherwise integration scenarios stay in UAT} | {exact IDs and repository readiness, or evidence-backed N/A} | {XWALK-### / SCN-## or evidence-backed N/A} | {Supplied case/AST reference or Proposed family; avoid duplicate UAT counts} | {ACT-### / AUT-##; SRC-###; or pending} | {exact selected story ID(s), or unresolved mapping} | {preparation; execution; retest handoff, or N/A rationale} | {results evidence; approval gate and roles} |
| Full functional | {Conditional on Re-architect; otherwise evidence-backed Not Applicable} | {exact IDs and repository readiness, or evidence-backed N/A} | {XWALK-### / SCN-## or evidence-backed N/A} | {Supplied case/AST reference or Proposed family; or evidence-backed N/A} | {ACT-### / AUT-##; SRC-###; or pending} | {exact selected story ID(s), or evidence-backed N/A} | {preparation; execution; retest handoff, or N/A rationale} | {results evidence; approval gate and roles} |
| Performance and baseline | {Applicable; equal-volumetric comparison and approved measurable targets} | {exact IDs and repository readiness, or pending} | {XWALK-### / SCN-## or pending} | {Supplied case/AST reference or Proposed family; or pending} | {ACT-### / AUT-##; SRC-###; or pending} | {exact selected story ID(s), or unresolved mapping} | {baseline/script preparation; execution; retest handoff} | {baseline/results evidence; approval gate and roles} |
| High availability | {Applicable; approved HA design and failure scenarios} | {exact IDs and repository readiness, or pending} | {XWALK-### / SCN-## or pending} | {Supplied case/AST reference or Proposed family; or pending} | {ACT-### / AUT-##; SRC-###; or pending} | {exact selected story ID(s), or unresolved mapping} | {preparation; execution; recovery/retest handoff} | {results evidence; approval gate and roles} |
| Disaster recovery | {Applicable; Production acceptance remains distinct from lower-environment rehearsal} | {exact IDs and repository readiness, or pending} | {XWALK-### / SCN-## or pending} | {Supplied case/AST reference or Proposed family; or pending} | {ACT-### / AUT-##; SRC-###; or pending} | {exact selected story ID(s), or unresolved mapping} | {runbook preparation; Production execution; recovery/retest handoff} | {RTO/RPO and results evidence; approval gate and L2 roles} |
| Security testing | {Applicable; control/scanning/review scope from requirements} | {exact IDs and repository readiness, or pending} | {XWALK-### / SCN-## or pending} | {Supplied case/AST reference or Proposed family; or pending} | {ACT-### / AUT-##; SRC-###; or pending} | {exact selected story ID(s), or unresolved mapping} | {preparation; execution; remediation/retest handoff} | {findings evidence; approval gate and security roles} |
| Security penetration testing | {Applicable; any exception requires its governed decision and evidence} | {exact IDs and repository readiness, or pending} | {XWALK-### / SCN-## or pending} | {Supplied case/AST reference or Proposed family; or pending} | {ACT-### / AUT-##; SRC-###; or pending} | {exact selected story ID(s), or unresolved mapping} | {authorization/preparation; execution; remediation/retest handoff} | {production evidence; approval gate and LSEG Security role} |
| Operational acceptance testing | {Applicable; assess L2 OAT catalog IDs against as-is and target evidence} | {exact IDs and repository readiness, or pending} | {XWALK-### / SCN-## and Section 14.2 catalog IDs, or pending} | {Supplied case/AST reference or Proposed family; do not duplicate OAT cases} | {ACT-### / AUT-##; SRC-###; or pending} | {exact selected story ID(s), or unresolved mapping} | {runbook/change preparation; Production execution; retest handoff} | {runbook/results/change evidence; approval gate and Application Operations role} |
| User acceptance testing | {Applicable for every R-Type; no exemption; integration scenarios here when no Migration-Team refactoring} | {exact IDs and repository readiness, or pending} | {XWALK-### / SCN-## or pending} | {Supplied case/AST reference or Proposed family; avoid duplicate functional counts} | {ACT-### / AUT-##; SRC-###; or pending} | {exact selected story ID(s), or unresolved mapping} | {business-user preparation; execution; defect/retest handoff} | {acceptance evidence; approval gate and LSEG Application Team role} |

The shared profile's Human Input and Decision Register is authoritative for each open question.
Carry its exact action ID and preserve the exact question, respondent/contact, needed-by gate and
blocking impact there; do not copy action rows into this spec. A pending profile is not a missing
prerequisite for the first SPEC run: record the unavailability and owned follow-up, keep the SPEC
review gate pending, and complete detailed case outlines, Test Plan estimates, schedules and
execution/approval tasks in their later planning stages.

## 7. Out of Scope / Deferred Modernization Ideas

Anything that surfaced during analysis that would improve the application but is **not** required
to migrate it goes here, not into scope. This section exists so good ideas aren't lost — and
aren't smuggled into the migration either.

- {Idea} — {why it's deferred, e.g., "not required for migration; revisit post-migration"}

## 8. Open Decisions & Risks

Do not resolve these here — log them via `.specify/templates/decision-log-template.md` and
`.specify/templates/risk-register-template.md` and link them below. Per Constitution Principle
III, none of these are final until a named human reviews them.

| Type | ID | Summary | Status |
|------|----|---------| -------|
| Decision | DEC-001 | {summary} | Proposed |
| Risk | RSK-001 | {summary} | Identified |

## 9. Review Checkpoint

- [ ] `architecture.md` exists and its Architecture Review Gate is Cleared (this spec's Section 2/5
  are copied from it, not re-derived)
- [ ] As-is summary confirmed against source evidence (no unresolved `UNKNOWN` blocking scope)
- [ ] Section 3 Standard Backlog table matches a correct CSV filter for the approved R-Type
- [ ] Section 4 Backlog Delta reviewed by the migration team (or confirmed empty); architecture
  `IMP-*` IDs, exact requirement traces, repository scope and access readiness are preserved
- [ ] Section 5 MEC/discovery applicability table matches `architecture.md` Section 7
- [ ] Section 6 has one row per canonical test type and traces applicable architecture crosswalk,
  supplied/proposed case and asset references, profile actions, and readiness without duplicating
  the authoritative action register
- [ ] Test Plan is deferred to Planning & Design; Section 6 does not claim scripts, execution or
  approval and the SPEC review gate remains pending human action
- [ ] All Section 8 decisions/risks reviewed by a named human before `/plan` proceeds

**Reviewed by**: {name} | **Date**: {YYYY-MM-DD} | **Outcome**: {Approved / Changes requested}
