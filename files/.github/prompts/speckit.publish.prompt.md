You are the orchestrator for application deliverable publication. You generate or refresh the
deliverables under `specs/<NNN>-<app-slug>/deliverables/` from the authoritative feature artifacts.
This command is intentionally rerunnable: use the same `/speckit.publish` command after any
requirements, architecture, scope, plan, task, implementation-evidence, decision, or risk change.

## Publication domains

| Skill | Owns |
| --- | --- |
| `publication-readiness` | Source/gate review, applicability, evidence gaps, and honest status |
| `publication-rendering` | Source-grounded generation of each applicable deliverable |
| `publication-versioning` | Per-deliverable versions, immutable history, provenance, and validation |

## Process

### Phase 1 — Plan

1. Resolve `$ARGUMENTS` to deliverable IDs when the user requests a subset (for example, `cost
   profiles` resolves to C-3), then run `.specify/scripts/powershell/setup-publication.ps1` with
   `-DeliverableId` for that subset and `-Json`. With no subset, publish all deliverables. Setup creates only missing selected views,
   preserves existing publication content/evidence/approvals, fingerprints current sources, and
   retains prior versions and history.
2. Read `deliverables/manifest.json`, then load authoritative indexes and individual records before
   compatibility rollups: `requirements/index.md`, `decisions/index.md`, `risks/index.md`, followed
   by relevant records, `architecture.md`, `spec.md`, `plan.md`, `tasks.md`, `G-test-plan.md`, and
   implementation evidence that exists.
3. `publication-readiness` determines each entry's applicability and highest defensible status.
   Missing evidence produces `UNKNOWN` or `HUMAN REVIEW REQUIRED`; it never produces invented
   content or blocks generation of an explicitly incomplete draft. For G-3, distinguish artifact
   quality from source-input completeness and keep the canonical Test Plan Draft/Ready for
   Review/Approved state honest; open actions, unavailable assets and conflicts do not suppress a
   useful draft or imply approval.

### Phase 2 — Act

4. `publication-rendering` regenerates every applicable framework-managed Markdown view from its
   current sources. Replace stale generated narrative, tables, references, and status values.
   Preserve the template's required shape. Do not redesign architecture, change scope, approve an
   ADR/risk, close a risk, or convert a proposed control into implementation evidence.
5. Keep feature-root `G-test-plan.md` as the sole authoritative test-plan source. Render its full
   current content to the framework-managed `deliverables/G-test-plan.md` G-3 publication view on
   every run; do not author or maintain the two files independently. Preserve the root source and
   its evidence/case/asset/action crosswalk, estimate boundaries, test scope and actual approval
   state. Treat `plan.md` as the source for `M-migration-plan.md`. Keep F-1 CAF eligibility
   `External` unless a separate governance layer explicitly owns and supplies it.
   Preserve the root-owned Review Brief before supporting tables when present. Never author a
   separate publication-only summary; report missing legacy navigation and request a root update
   followed by republishing. Do not turn unresolved readiness or appointments into approval.
5a. For C-3, include only billable Azure services and Azure-native observability dependencies.
   Keep Datadog/BigPanda technical and SAD evidence in their owning artifacts, but mark third-party
   commercial charges `Excluded from C-3 - Application Team-owned`; never add them to Azure totals
   or make them a C-3 completion blocker.
5b. For G-7, preserve Section 8A's reviewer-readable derivation in each Summary Evidence /
   Calculation Comment and Factor Detail: workbook-defined unit, observed input, inclusions/
   exclusions/grouping, arithmetic or V4.1 mapping, exact grounded locators and evidence date,
   confidence/proxy limits, and gap owner/human review. Do not reduce the evidence to section IDs.
   Also compare every supplied calculator workbook's actual rubric and supporting sheets with the
   framework baseline, record the governing version, independently recompute totals, and preserve
   source conflicts/version drift as `HUMAN REVIEW REQUIRED` rather than mixing rules.
6. Store supplied evidence only under `deliverables/evidence/` and human approval records only
   under `deliverables/approvals/`. Regeneration must not delete or overwrite those directories.
7. Update each manifest entry's `applicability`, `status`, and `notes` to match the regenerated
   output. A `Complete`, `Approved`, or `Revalidated` status requires version-specific named-human
   approval evidence; the agent never creates that approval.

### Phase 3 — Review and version

8. `publication-versioning` checks every generated statement against its source and then runs
   `.specify/scripts/powershell/finalize-publication.ps1 -Json`, passing the same `-DeliverableId`
   subset when scoped. Finalization calculates the
   metadata-free content hash. It assigns version 1 on first publication and increments only the
   deliverables whose substantive content changed; unchanged reruns keep the same version.
9. Run `.specify/scripts/powershell/validate-publication.ps1 -Json`, passing the same subset when
   scoped. Fix source drift, missing/stale G-3 published copies, unexpected duplicate publication
   outputs, missing files, broken hashes, non-contiguous history, or unsupported completion status,
   then rerun finalization and validation.
10. Append the publication run and changed deliverable versions to the feature `CHANGELOG.md`.
    Never rewrite prior changelog or manifest history.
11. Report the run number, changed and unchanged versions, incomplete deliverables, missing evidence,
    and approvals still requiring named humans.

Publication outputs are versioned views, not new sources of truth. Upstream corrections are made in
their owning artifacts first and then propagated by rerunning `/speckit.publish`.