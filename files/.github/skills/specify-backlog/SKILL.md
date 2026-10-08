---
name: specify-backlog
description: "Apply the approved R-Type to the backlog playbook, carry CSV tags forward, and draft backlog delta items only as Proposed. Owns Sections 2–4 of spec.md."
argument-hint: "Invoked by /speckit.specify to apply the approved migration pattern and backlog filtering rules"
---

# Spec Skill: Backlog and R-Type

Owns `spec.md` Sections 2–4: the approved R-Type recommendation, the standard backlog, and backlog
Delta rows for items that need migration-team review.

## Required Inputs

- Approved architecture decision for the R-Type
- `architecture.md` Section 8 (R-Type Recommendation) and any associated decision ID
- `architecture.md` Section 4 architecture-derived `IMP-F###` / `IMP-US###` / `IMP-T###` hierarchy, including repository/project/path and access metadata
- `docs/backlog-playbook/v1/Backlog-Playbook-v1.csv`
- Relevant requirement inputs or architecture decisions affecting scope
- Requirements Section 7 and architecture Sections 15.0–15.1 coverage evidence, when present
- Architecture Sections 14.1–14.4 and `requirements/testing-profile.md` when present, for exact
  test-handoff requirement, implementation, source, asset, case and action references

## Plan → Act → Review

### Plan

- Confirm the R-Type is approved and not still `Proposed`.
- Inventory each in-scope Section 4 implementation item and verify repository/project identity,
  best-known path/module, accountable app-team owner and source-access status. Prepare targeted
  app-team questions for missing repository details or access; do not infer a project from an
  archive filename or component label.
- Determine which backlog rows are in scope for the approved migration pattern.

### Act

- Filter the CSV using the approved R-Type and carry through the Owning Org / GHCP tags.
- Keep the spec backlog as the complete scope baseline. Do not mark an item Complete, remove it,
  or infer that a whole User Story is complete because requirements or architecture discuss the
    topic. Planning assesses each User Story and child Task from the authoritative requirements and
    architecture coverage artifacts; do not introduce a separate per-row completion field in spec.md.
- Add backlog items only where they are directly in scope.
- Preserve architecture implementation IDs and repository/project mappings in the spec's scope
	evidence. Separate assessment read access from implementation write/branch permission; if either
	is unavailable, record the exact request and owner as an open dependency.
- Preserve exact REQ/NFR and `IMP-F###` / `IMP-US###` / `IMP-T###` identifiers when linking backlog
  scope to the Section 6 testing evidence handoff. Do not infer that a playbook story is complete
  from a test crosswalk or scenario reference; Section 3 remains the complete selected baseline.
- For undiscovered or new backlog items, add them to Section 4 as Proposed, not to Section 3.

### Review

- Verify no backlog row is inserted without its required tags or traceability.
- Verify every filtered User Story remains in the baseline, including rows with likely upstream
	evidence; completion disposition belongs to the plan ledger.
- Verify every in-scope architecture implementation item maps to a named repository/project and
	best-known path, or has an owner-attributed unknown and explicit app-team source-access request.
- Confirm test-handoff references use exact Section 3 work-item IDs and do not lose implementation
  repository/access readiness or imply a new backlog item.
- Ensure Section 4 rows remain clearly provisional and require human review.
- Confirm no item was added directly to the standard backlog without an explicit design or review reason.
