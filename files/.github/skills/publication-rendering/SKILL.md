---
name: publication-rendering
description: "Regenerate application migration deliverables as source-grounded views without re-deciding architecture, scope, risks, or approvals. Invoked by /speckit.publish."
argument-hint: "Invoked with ready publication entries and authoritative feature sources"
---

# Publication Skill: Rendering

Owns regeneration of applicable framework-managed Markdown deliverables.

## Source ownership

| Deliverable | Authoritative basis |
| --- | --- |
| C-2 | Requirements, architecture, plan, and commercial/license evidence |
| C-3 | Architecture Section 13, plan, Azure Pricing Calculator exports, and Azure FinOps evidence. Exclude Datadog/BigPanda commercial charges; retain only Azure-native observability resources in totals |
| G-2 | Requirements, architecture Section 16, decisions, risks, and plan |
| G-3 | Full-fidelity published copy at `deliverables/G-test-plan.md`, sourced only from canonical feature-root `G-test-plan.md` |
| G-4 | MEC evidence, security requirements, architecture Section 7, and spec Section 5 |
| G-6 | Individual ADR/risk records and their indexes |
| G-7 | Architecture Section 8A and signed calculator evidence |
| G-9 | Approved R-Type ADR and separately supplied governance evidence |
| M-1 | Architecture Section 7A and `plan.md` |
| S-1 | Current-state evidence, architecture Sections 7/12, and implementation evidence |

## Plan → Act → Review

### Plan

- Load only the source sections needed for each view and note unresolved fields.
- Preserve required template headings and tables.

### Act

- Replace stale source-derived content on every run; do not append contradictory snapshots.
- For C-3, price Azure services only. Datadog/BigPanda technical/SAD status may be referenced as
	`Excluded from C-3 - Application Team-owned`, but their license, ingestion, indexing, APM/RUM,
	synthetics or support costs must not appear in Azure totals or completion blockers. Azure Monitor,
	Log Analytics, managed Prometheus, diagnostic storage, networking and egress remain priceable.
- Use `UNKNOWN` or `HUMAN REVIEW REQUIRED` with the missing source and owner instead of guessing.
- Keep links and trace IDs resolvable to current records.
- For G-3, copy the complete canonical feature-root `G-test-plan.md` into
	`deliverables/G-test-plan.md` on every publication run. Preserve all tables, evidence gaps,
	status and approvals exactly; do not summarize, approve, or independently edit the published
	copy. The publication metadata block is added by finalization, not copied as source content.
  Preserve evidence provenance/conflicts, shared human-input actions, asset availability versus
  reuse health, migration impact crosswalk traces, case outlines, estimate boundaries, validation
  stage and actual approval state. Never turn Proposed/Pending content into an approved case or
  complete execution baseline.
  Preserve the source-owned opening Review Brief and detailed supporting tables in order.
  Do not generate a new summary solely in the publication view; if the root lacks one, publish
  faithfully and request a root update. Keep canonical profile/crosswalk links navigable from
  both locations using root-authored repository-root-scoped or controlled source URLs; publication
  does not rewrite the source body. Route broken links to the root author rather than modifying
  only the copy. Do not replace authoritative rows with copied summary ledgers.
- For G-4, render all 30 MEC controls from the independent requirements assessment: Type, Theme,
  criterion, standard applicability, independent applicability/current state, evidence/rationale/
  confidence, target control/maturity, required/actual evidence, remediation owner/date and traces.
  Never collapse the ledger into thematic controls. When a completed human workbook is supplied,
  render its statuses/responses/evidence in a separate comparison table; otherwise state `Not
  supplied — independent assessment complete` without lowering readiness.
- For G-4, render `This Application's MEC Compliance Status` separately and use only `Compliant`,
  `Not Applicable`, `Non-Compliant`, or `Partially-Compliant`. Reconcile those four counts to 30;
  do not mix target maturity values into the compliance summary.
- Preserve target-design semantics: render pattern/CPF-backed controls as Compliant when
	architecture does so, while retaining `Designed` maturity and missing delivery evidence/actions.
- Render Compliance Review State per row and summary counts. Never infer approval from a workbook,
  architecture gate or role title; preserve named Migration Architect, Application Architect and
  Security SME evidence for the exact version or retain Proposed.
- For G-4, render the MEC quality checklist item/pass/open counts, validation date and open IDs from
	`checklists/mec-assessment.md`. Never mark checklist items in the publication view; the checklist
	artifact owns state.
- For G-7, render all eight factors from architecture Section 8A without compressing away the
	derivation. Each Summary **Evidence / Calculation Comment** identifies the workbook-defined unit,
	observed input, material inclusions/exclusions/grouping, arithmetic or V4.1 category mapping, and
	exact grounded source locators. Each Factor Detail preserves the full itemization, evidence/tool
	date, assumptions, proxy limitations, confidence, gap owner and human-review condition. A section
	number alone is not evidence, and the workbook's pre-populated ratings are never source data.
- For G-7, populate Workbook Version and Validation Evidence for every supplied calculator. Preserve
	exact rubric differences and independent support-sheet/total checks; classify factor differences
	as input gaps, analysis defects, source conflicts, version drift or framework gaps. Never let a
	completed workbook silently replace Section 8A or combine rules from different versions.
- For G-7, render the required Spec-Kit Quality Checklist status from
	`checklists/complexity-calculator.md`: item/pass/open counts, last validation and open IDs. Never
	mark an item checked in the publication view; the checklist artifact owns its state.

### Review

- Every assertion resolves to an authoritative source or explicit gap.
- For G-4, independently reconcile summary counts and reject `Evidence Verified` when required
	evidence is absent or unresolved. If human comparison evidence exists, confirm every row was consumed.
- G-4 checklist counts agree with architecture Section 7.4.1 and validator output; Complete requires
	zero unchecked required items.
- For G-7, independently recompute each score and weighted score from the stated input/rating and
	governing rule; verify that the Summary comment and Factor Detail agree and that every locator
	resolves. Confirm governing-version approval or retain `HUMAN REVIEW REQUIRED`.
- G-7 checklist counts agree with Section 8A.Q and `validate-checklists.ps1`; Complete requires zero
	unchecked required items.
- No publication view silently becomes authoritative over its inputs.
- Evidence and approvals remain in their dedicated rerun-safe directories.
- The publication metadata block is left to `finalize-publication.ps1`; do not hand-edit it.