You are the orchestrator for the Spec stage of this migration. You do not author every section by
hand; you delegate each domain to a specialist skill and then reconcile the outputs into one
`specs/<NNN>-<app-slug>/spec.md` using `.specify/templates/spec-template.md`.

## Input

$ARGUMENTS

## The spec domains

| Skill | Owns |
|-------|------|
| `specify-as-is` | Evidence capture and Section 1 (As-Is Summary) |
| `specify-backlog` | Section 2–4 (R-Type, backlog, backlog delta) |
| `specify-security` | Section 5 (Security & MEC Alignment copy-forward) |
| `specify-coverage` | Section 6–9 (testing evidence handoff, deferred scope, decisions/risk stubs, review checkpoint) |

## Process

### Phase 1 — Plan

1. Run `.specify/scripts/powershell/check-prerequisites.ps1 -RequireArchitectureReady`. If the
   Architecture Review Gate is not Cleared, STOP and tell the user to complete
   `/speckit.architecture` first — do not bypass the gate by inventing R-Type or MEC conclusions.
2. Run `.specify/scripts/powershell/setup-spec.ps1` to create `spec.md` from the template if it
   does not already exist.
3. Read the ready evidence set: `architecture.md` (especially Sections 3, 4, 8 and its gate),
   `requirements.md`, discovery report(s), relevant SAD excerpts, and the backlog playbook CSV.
   Read `architecture.md` Sections 14.1–14.4 and `requirements/testing-profile.md` when present
   for the testing handoff. The profile may be unavailable during an initial SPEC pass; the
   application `G-test-plan.md` is produced during Planning & Design and is not a SPEC prerequisite.
   Reconcile each in-scope `IMP-T###` with its application repository/project, URL or workspace
   location, branch/revision, affected path/module, accountable app-team owner and source-access
   status. Mark anything unverified as `UNKNOWN — needs app team input` and treat it as a question,
   not a guess. If repository identity or access is missing, ask the app team during specification
   for the specific repository/project and read access needed to assess migration scope; record
   write/branch permission as a separate implementation prerequisite. Do not treat missing source
   access as an architecture-stage blocker. Keep the spec review checkpoint open until source
   evidence is inspected or a named human accepts an explicit, bounded evidence exception.
4. Identify the exact sections each skill needs from the evidence set and list them in the draft's
   review checklist.

### Phase 2 — Act

5. Dispatch each domain skill in order. Prefer one skill per domain rather than mixing concerns in
   one prompt; each skill runs its own internal Plan → Act → Review pass, but it is still acting as
   a specialist for this orchestrator.
6. `specify-as-is` documents the current-state evidence and supports Section 1 with source citations,
   including the repository/project inventory and whether source evidence was accessible.
7. `specify-backlog` applies the approved R-Type, filters the backlog playbook, carries Owning Org
   and GHCP tags from the CSV, and writes any backlog delta as Proposed only in Section 4. It must
   carry architecture-derived implementation IDs and repository/project scope without inventing
   paths; missing repository identity/access becomes a targeted app-team question and explicit
   readiness dependency, not a generic backlog item. Preserve the full selected User Story scope
   even when requirements or architecture appear to cover related work. Keep the requirements and
   architecture source references explicit; do not mark a Playbook item Complete or remove it from
   the spec backlog. Planning assesses completion from the authoritative coverage artifacts.
8. `specify-security` copies forward the architecture security table and preserves traceability to
   the requirement IDs; it does not re-run MEC logic independently.
9. `specify-coverage` assembles Section 6 as a single-row-per-canonical-test-type evidence handoff,
   then handles deferred scope, decision/risk stubs and the final review checkpoint in Sections 7–9.
   Preserve exact REQ/NFR and `IMP-*` IDs, architecture `XWALK-###` / `SCN-##` references,
   supplied-case origin and `AST-###` locators, and shared profile `SRC-###` / `ACT-###` /
   `AUT-##` references when available. Map only exact selected Section 3 User Story IDs; keep the
   full backlog baseline. Do not copy the profile action register, invent cases or repository
   readiness, add a standalone Integration Testing type, write detailed scripts, or treat the
   planning-stage Test Plan as a prerequisite. Keep unknowns as owned actions/readiness gaps.
10. Merge the skill outputs into one coherent `spec.md` without dropping citations or traceability.

### Phase 3 — Review

11. Re-read the whole assembled document for evidence, traceability, backlog compliance, repository
   and source-access traceability for every in-scope architecture implementation item, and gate
   readiness. Confirm access requests name the exact project/repository and permission needed.
12. Fix anything that is plainly fixable before the human gate. Keep unresolved decisions and risks in
    Proposed/Identified status, not as approved scope.
13. Update `requirements.md` Section 5 (Traceability Matrix): for every REQ/NFR ID now referenced in
    `spec.md`, fill in its "Spec.md ref" column.
14. Stop at Section 9 (Review Checkpoint). Do not mark it reviewed or approved yourself — that is a
    human action per Constitution Principle III. Tell the user what remains pending.

Do not proceed to `/plan` work in this same pass if Section 9 is unchecked.

If `deliverables/manifest.json` exists, report which scope-derived deliverables are stale and
require `/speckit.publish` to be rerun. Do not update publication versions in the spec pass.
