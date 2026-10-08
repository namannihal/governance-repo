---
name: analyze-deliverables
description: "Validate every publication template and deliverable against its authoritative sources and cross-check shared claims across the complete deliverable set. USE FOR: deliverable coherence, template coverage, publication content drift, cross-deliverable consistency. Invoked by /speckit.analyze. Read-only."
argument-hint: "Invoked by /speckit.analyze with the feature artifacts, publication manifest, templates, and generated deliverables"
---

# Analyze Skill: Deliverables Coherence

Owns independent, read-only validation of the complete publication surface. Mechanical hashes and
versions remain owned by `validate-publication.ps1`; this skill validates content, coverage, and
agreement with authoritative feature sources.

## Required Inputs

- `deliverables-template/md-templates/`, including the SAD contract and coverage map.
- `deliverables/manifest.json`, every manifest-referenced output, and publication validator output.
- Authoritative requirement, decision, and risk indexes and records.
- `architecture.md`, `spec.md`, `plan.md`, `tasks.md`, canonical `G-test-plan.md`, implementation
  evidence, and approval evidence when present.

## Deliverable Ownership Ledger

Build one ledger containing every manifest entry exactly once and use these authoritative bases:

| ID | Output | Authoritative basis |
| --- | --- | --- |
| C-2 | `C-license-forecast.md` | Requirements, architecture, plan, and commercial/license evidence |
| C-3 | `C-cost-profile.md` | Architecture Section 13, plan, Azure pricing evidence, and Azure FinOps evidence |
| F-1 | `F-caf-eligibility-assessment.md` | External governance evidence; remain External unless separately governed |
| G-2 | `G-sad-baseline.md` | Requirements, architecture Section 16, SAD contract/coverage map, decisions, risks, and plan |
| G-3 | `deliverables/G-test-plan.md` | Full-fidelity published view of feature-root `G-test-plan.md`; source is reconciled with testing profile, architecture Section 14.1, plan, tasks, evidence, and approvals |
| G-4 | `G-mec-assessment.md` | MEC evidence, security requirements, architecture Section 7, and spec Section 5 |
| G-6 | `G-adr-risk-register.md` | Authoritative decision/risk indexes and individual records |
| G-7 | `complexity-calculator.md` | Architecture Section 8A and signed calculator evidence |
| G-9 | `G-rtype-decision-record.md` | Approved R-Type ADR and separately supplied governance evidence |
| M-1 | `M-migration-plan.md` | Architecture Section 7A and `plan.md` |
| S-1 | `S-devsecops-report.md` | Current-state evidence, architecture Sections 7/12, and implementation evidence |

## Plan → Act → Review

### Plan

1. Inventory every framework template and every manifest entry. Report missing, duplicate, unknown,
   renamed, or untracked items; do not silently ignore a newly introduced template.
2. Record each deliverable's applicability, status, version, required template sections, source
   basis, shared facts, unresolved markers, evidence, and approval state in the ledger.
3. Treat Not Applicable and External entries as validation dispositions, not exclusions: require
   an evidence-backed rationale and validate that no conflicting content was published elsewhere.
4. For G-3, require exactly one authoritative feature-root source and one manifest-tracked
   `deliverables/G-test-plan.md` publication copy; verify their metadata-free content matches.
   Missing or stale publication output is a finding; the intended source/view pair is not a
   duplicate-deliverable defect.

### Act

Validate each deliverable independently:

1. The output preserves all required template headings, tables, identifiers, and metadata
   boundaries. Required rows are populated or explicitly marked `UNKNOWN`, `Pending`, `Not
   Applicable`, or `HUMAN REVIEW REQUIRED` with source and owner; placeholder instructions are not
   presented as completed content.
2. Every substantive assertion, status, total, score, selected option, and trace ID resolves to its
   authoritative basis. Generated deliverables never override requirements, architecture, scope,
   decisions, risks, plans, tasks, evidence, or approvals.
3. Applicability and maturity are honest. Designed controls are not described as implemented or
   tested, Identified risks are not Closed, Proposed decisions are not Approved, and
   Complete/Approved/Revalidated claims have named-human evidence for the exact version.
4. Run `validate-sad-contract.ps1` for G-2 and `validate-publication.ps1` when publication exists;
   include failures as findings rather than editing outputs.

Cross-check shared claims across sources and all applicable deliverables:

5. R-Type, complexity score/category, migration scope, and backlog treatment agree across the
   approved R-Type ADR, architecture, spec, G-7, G-9, M-1, and G-2.
6. Regions, environments, subscriptions, network segments, services, SKUs/tiers, capacity,
   resilience targets, and Azure cost assumptions agree across architecture, C-2, C-3, G-2, M-1,
   and S-1. C-3 excludes Datadog/BigPanda commercial charges while retaining Azure-native
   observability costs.
7. Identity, authentication, authorization, encryption, MEC applicability, threat protection,
   logging, and DevSecOps claims agree across requirements, architecture Section 7, spec Section 5,
   G-2, G-4, and S-1.
7a. For G-4, verify all 30 controls were independently derived from the MEC standard and normal
   application evidence, then agree across requirements, architecture Section 7.4, spec Section 5
   and the published ledger. Report unsupported compliant claims, future-tense implementation
   claims, unresolved evidence locators and status/count mismatches. When a completed human MEC
   workbook is supplied, compare every row/mapping and report dropped findings or ungoverned
   disagreements; absence of such a workbook is not a finding.
7b. Verify every row's `This Application's MEC Compliance Status` is exactly `Compliant`, `Not
   Applicable`, `Non-Compliant`, or `Partially-Compliant`; the four summary counts total 30; and
   applicability, optional human assessment and target maturity are not substituted for this status.
7c. Validate `checklists/mec-assessment.md` as G-4's Security Architect quality contract. Every
   CHK001–CHK042 item is present verbatim and evidence-evaluated; checked items are supported;
   unchecked items name gap/owner/action; counts agree with architecture Section 7.4.1 and G-4.
   A Cleared gate or Complete G-4 with an unchecked required item is a gate finding.
8. Every `MIG-*` transition decision, dependency, wave, cutover, rollback, reconciliation,
   hypercare, and decommission condition agrees across requirements Section 2A, architecture
   Section 7A, plan, M-1, and G-2.
9. Test applicability, environments, acceptance criteria, schedule, tasks, evidence, exceptions,
   and approvals agree across the testing profile, architecture Section 14.1, G-3, plan, tasks,
   M-1, and G-2. Delegate the canonical per-test ledger detail to `analyze-testing` and report any
   cross-deliverable mismatch here.
10. Decision/risk IDs, titles, statuses, owners, review data, consequences, and downstream impacts
    agree between individual records, their indexes, G-6, and every dependent deliverable.
11. Numeric values reconcile within and across outputs: cost subtotals/totals and currencies,
    capacity quantities, RTO/RPO values, complexity factors/total/category, dates, and versioned
    references. Report unsupported precision or incompatible units.
11a. For G-7, verify every Summary Evidence/Calculation Comment and Factor Detail exposes the full
   evidence chain: workbook-defined unit; observed input; included/excluded/grouped items;
   reproducible arithmetic or V4.1 category mapping; exact resolvable source locators and evidence
   date; confidence/proxy limitation; and gap owner/human review where needed. Recompute each
   rating, score and weighted score. A bare section citation, unexplained total, unresolved locator,
   or repository/file/flow proxy presented as the workbook unit is a source-to-output finding.
11b. Inventory every supplied calculator workbook and compare its actual rubric and supporting
   sheets with the framework baseline and Section 8A. Verify declared/governing version provenance,
   independently recompute support totals and detect duplicates/exclusions, and report assumptions
   that conflict with accepted architecture or scope. Classify each disagreement as missing/
   unconsumed input, analysis/rubric defect, source conflict, version drift or framework defect.
   Formula-correct arithmetic does not validate unsupported inputs.
11c. Validate `checklists/complexity-calculator.md` as G-7's quality contract. Every `CHK###` is
   unique and evidence-evaluated; checked items are actually supported; unchecked items retain an
   exact gap/owner; counts agree with architecture Section 8A.Q and G-7. A Complete G-7, Cleared
   architecture gate or final complexity band with an unchecked required item is a gate finding.
12. An `UNKNOWN`, gap, exception, or pending approval in one artifact is not silently asserted as a
    resolved fact elsewhere. Stale claims and contradictory duplicate narratives are findings even
    when both files are structurally valid.

### Review

- Return findings ordered by severity with deliverable ID, exact source and output locations,
  conflicting values or missing fields, authoritative owner, and remediation workflow.
- Distinguish template-shape defects, source-to-output drift, cross-deliverable contradictions,
  evidence gaps, and mechanical publication failures.
- State the complete inventory checked, including External, Pending, Not Applicable, and missing
  entries, so a green result cannot omit a newly introduced template.
- Keep the pass read-only. Route source corrections to their owning workflow and regenerated views
  to `/speckit.publish`.