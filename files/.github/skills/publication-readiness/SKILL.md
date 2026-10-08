---
name: publication-readiness
description: "Assess deliverable applicability, source readiness, evidence gaps, gate state, and honest publication status. Invoked by /speckit.publish before rendering."
argument-hint: "Invoked with the active feature artifacts and deliverables/manifest.json"
---

# Publication Skill: Readiness

Owns the evidence and applicability decision for every publication-manifest entry.

## Required Inputs

- Authoritative requirement, decision, and risk indexes and records.
- Current architecture, spec, plan, tasks, Test Plan, evidence, and approvals when present.
- The Test Plan's validation stage and input-completeness summary when available, including
  unresolved human actions, unavailable assets, and source conflicts.
- `deliverables/manifest.json` and all framework deliverable templates.
- For G-7, every supplied application Complexity Calculator workbook and supporting sheet, plus
  its path, declared version, supplied/modified date and author/reviewer metadata when available.
- `checklists/complexity-calculator.md` and the latest `validate-checklists.ps1` result for G-7.
- For G-4, the complete independent 30-row MEC assessment, application evidence, architecture
  Section 7.4 and spec Section 5. Include any completed human workbook only when supplied.
- `checklists/mec-assessment.md` and the latest `validate-checklists.ps1` result for G-4.

## Plan → Act → Review

### Plan

- Establish the latest cleared gate and available implementation/test evidence.
- Compare source readiness with each template's required fields.

### Act

- Set `Applicable`, `Not Applicable`, `Pending`, or `External` with evidence-based notes.
- Set only a defensible status. Missing inputs remain explicit and do not prevent an incomplete
  draft from being generated.
- Keep F-1 External unless separately governed. For G-3, require the canonical feature-root
  `G-test-plan.md` as source and publish its view at `deliverables/G-test-plan.md`; mark it In
  Progress when the source is Draft, readiness validation fails, or named approval is pending.
  Keep known scope, proposed content, unresolved questions, source conflicts, and evidence
  completeness distinct in the published artifact/status notes. Do not treat publication as
  approval or implementation evidence, and do not suppress a useful draft because inputs remain
  unavailable.
  Check the source-owned Review Brief against canonical conflicts/actions, scope and version
  boundary when present. Report missing legacy Draft navigation as a warning and route authoring
  back to `plan-testing`; never invent the brief or suppress the full draft. Owned Conditional
  readiness and pending appointments do not imply execution approval or failed document review.
- For G-7, compare each supplied workbook's actual factor names, weights, guidelines, thresholds/
  formulas and final bands with the framework V4.1 baseline. A filename alone does not establish
  version. Missing governing-version approval or material rule drift keeps G-7 In Progress and the
  affected factors `HUMAN REVIEW REQUIRED`; do not silently select or combine versions.
- Keep G-7 In Progress when the required complexity checklist is missing, invalid or has unchecked
  items. Reconcile checklist counts with architecture Section 8A.Q.
- Keep G-4 In Progress when any independent row lacks evidence/rationale, owner, governance trace,
  target maturity or closure path, or when required implementation evidence is missing. Absence of
  a completed human workbook is not a gap. When one is supplied, unconsumed rows or unresolved
  comparison findings keep G-4 In Progress; workbook metadata alone is not approval evidence.
- Keep G-4 In Progress when the MEC checklist is missing, invalid, its Section 7.4.1 counts are
  stale, or any required item is unchecked.

### Review

- Accepted risks are not represented as Closed unless closure evidence exists.
- Designed controls are not represented as implemented or tested.
- G-4 preserves target-design compliance separately from target maturity and any optional human
  comparison. `Compliant` may coexist with `Designed`; only `Evidence Verified` supports an
  implemented/tested control claim.
- Every G-4 row uses one exact application compliance status (`Compliant`, `Not Applicable`,
  `Non-Compliant`, `Partially-Compliant`) and the four compliance summary counts total 30.
- G-4 cannot be Complete or Approved while any Compliance Review State is Proposed. Approval
  evidence must name the Migration Architect, Application Architect and Security SME and the exact
  G-4 version/date reviewed.
- G-4 checklist counts agree with Section 7.4.1 and zero required items remain open before Complete.
- Complete/Approved/Revalidated requires named-human, version-specific approval evidence.
- Every gap names the needed evidence, accountable role, and linked ADR/risk where applicable.
- A completed calculator is not marked validated merely because its formulas recalculate. Its
  input units, support-sheet arithmetic/deduplication, assumptions and architecture consistency
  must pass review.