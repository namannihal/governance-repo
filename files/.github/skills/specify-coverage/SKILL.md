---
name: specify-coverage
description: "Reconcile testing evidence handoff, deferred scope, decision/risk stubs, and the review checkpoint for the spec stage. Owns Sections 6–9 of spec.md."
argument-hint: "Invoked by /speckit.specify to manage deferred scope and final review readiness"
---

# Spec Skill: Coverage and Review

Owns `spec.md` Sections 6–9: the testing evidence handoff, out-of-scope/deferred items,
decision/risk stubs, and the review checkpoint. This skill keeps the spec disciplined, traceable
and prevents scope creep.

## Required Inputs

- Current `spec.md` draft
- Relevant `decisions.md` / `risks.md`
- Architecture decisions and any out-of-scope items already identified
- Architecture Sections 14.1–14.4 and `requirements/testing-profile.md` when available; do not
  require the Planning & Design `G-test-plan.md` for the first SPEC pass

## Plan → Act → Review

### Plan

- Check whether the section includes only explicitly deferred or non-migration work.
- Identify any unresolved design choice or risk that must be carried forward as a stub.

### Act

- Add items to Section 7 only when they are deferred or out of scope.
- Populate Section 6 with exactly one row per canonical test type, linking applicable architecture
  crosswalk/family evidence, exact REQ/NFR and `IMP-*` IDs, case origin/asset locators, shared
  profile source/action IDs, selected Section 3 story IDs, readiness, delivery handoff and approval
  roles. Retain evidence-backed conditional applicability and N/A rules, mandatory UAT, and the
  rule that integration scenarios belong to Change-based functional or UAT, never a standalone type.
- Reuse `requirements/testing-profile.md` as the authoritative evidence and human-input register:
  reference its `SRC-###`, `AST-###`, `ACT-###` and `AUT-##` IDs without copying its action rows.
  If the profile or a source is unavailable, carry an owned readiness gap; do not invent identifiers,
  cases, repository access, detailed scripts, plan effort, execution evidence or approvals.
- Leave Test Plan case detailing, estimates and schedule to Planning & Design; Section 6 is a
  requirements/architecture-to-planning handoff and must not block the initial SPEC pass.
- Add decision/risk stubs to the relevant log when a gap requires a future human decision.
- Keep the review checkpoint explicit and action-oriented.

### Review

- Confirm no spec work is drifting into out-of-scope modernization.
- Verify the Section 6 handoff retains exact identifiers and references without replacing the
  Section 3 backlog, duplicating the shared action register, or claiming a later-stage deliverable.
- Ensure the human review section clearly states what remains pending.
- Keep the Section 9 review checkpoint open if affected source repositories have not been inspected
	and no named human has approved a bounded evidence exception. The architecture gate does not
	require source access, but specification scope must be grounded in source evidence or that
	explicit human disposition.
- Verify all non-obvious decisions or risks are represented in the log, not silently suppressed.
- If publication exists, report scope-driven deliverables requiring `/speckit.publish`; never edit
	generated views or their version history from the spec stage.
