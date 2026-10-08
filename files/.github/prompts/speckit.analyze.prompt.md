You are the orchestrator for the analysis pass. This pass is read-only; it checks the full feature
chain for drift, gaps, and policy violations without rewriting the source artifacts.

## The analysis domains

| Skill | Owns |
|-------|------|
| `analyze-gates` | Gate and status validation across requirements / architecture / spec / plan / tasks |
| `analyze-traceability` | Requirements-to-architecture-to-spec-to-plan-to-task trace checks |
| `analyze-governance` | R-Type drift, backlog drift, scope creep, and evidence gap reports |
| `analyze-testing` | Testing profile-to-architecture-to-Test-Plan-to-task/evidence/approval validation |
| `analyze-artifacts` | Complete core-template inventory and requirements/architecture/spec/plan/task shape validation |
| `analyze-deliverables` | Complete template inventory, source-to-output validation, and cross-deliverable coherence |

## Checks

1. **Modernization creep**: any plan/task item that isn't traceable to the spec's Section 1 (as-is),
   Section 3 (Standard Backlog), an Accepted Section 4 Backlog Delta, or Section 5 (Yes-applicable
   MEC/discovery requirement), or an Approved decision. Flag it.
2. **Backlog drift**: a Section 3 row that doesn't match the CSV filter for the spec's assumed
   R-Type, a new User Story added directly to Section 3, or a Section 3/4 row missing required tags.
3. **R-Type drift**: plan/task assumes a higher R-Type than the spec's Section 2 states or the
   architecture decision does.
4. **Unresolved gates**: missing clearing or invalid state transitions across documents.
5. **Uncatalogued grounding**: architecture citations that do not match the real LSEG catalog entries.
6. **Incomplete layers**: cross-layer contradictions not reflected in the conflict log.
7. **Requirements traceability gaps**: missing requirement IDs, missing targets, or no architecture
   coverage for a named layer.
8. **Broken end-to-end chain**: stale traceability matrix entries or stale downstream impact lists.
9. **Fabricated sign-off**: human-signoff statuses without reviewer names and dates.
10. **Skipped self-review**: review sections missing or left stale while the gate is already Cleared.
11. **Microsoft-documentation overreach**: Microsoft docs used to relax or override LSEG governance.
12. **Backlog Playbook coverage gaps**: missing coverage checks or unclosed Open Points.
13. **Evidence gaps**: rows with no source citations.
14. **SAD & deliverables coverage gaps**: missing, duplicate, renamed, unknown, or untracked
   templates/manifest entries; missing required sections/rows; unresolved fields; or outputs that
   omit a newly introduced template.
15. **Cost & Capacity Profile / SKU validation gaps**: unvalidated SKUs, missing constrained tiers,
    or CPF/MEC conflicts.
16. **Target diagram completeness**: missing C4 Context, C4 Container, or Azure deployment/runtime
   view; generic/alternative service nodes; missing user, ingress, identity, data, external,
   observability or boundary detail; orphan nodes; or relationships without direction, purpose,
   protocol, port and authentication/authorization (or explicit `UNKNOWN`).
17. **Connectivity reconciliation**: any Section 5.1/5.2 `FLOW-*` row absent from the diagrams,
   any user/external diagram relationship absent from the tables, or any Application-to-
   Application Interface Design row missing the SAD 2.6.2 source/destination, exposure,
   protocol/encryption, authentication, security-proxy, purpose, status, evidence or trace data.
18. **Migration-transition completeness**: missing Requirements Section 2A dispositions; missing
   Architecture Section 7A `MIG-*` design; client/interface/data items without transition
   treatment; ambiguous source-of-truth/write ownership; missing reconciliation tolerance,
   rehearsal/go-no-go, rollback authority/timing/data handling/point-of-no-return, hypercare exit,
   or decommission prerequisites; planning/tasks that silently re-decide Section 7A.
19. **Data migration tooling integrity**: missing/incomplete `DATA-SRC-*` profiles; grouped or
   unsupported source-target pairs; missing lifecycle phase decisions; stale/missing Matrix
   provenance; blank/multiple/third-party cells silently selected; superseded/draft pattern misuse;
   CPF/product mismatch (especially Classic DMS outside clear-listed MySQL); or untraced network,
   security, observability, licensing, cost and cleanup consequences.
20. **Migration testing integrity**: missing/duplicate testing-profile dispositions; broken
   REQ/NFR-to-Section-14.1-to-`G-test-plan.md` traces; unit-test scope outside migration-changed
   impacted code; data-testing N/A despite data movement; incomplete strategy Sections 7.2/7.3
   coverage (HA goals, assessment, PPE, monitoring/data, entry/exit; DR ownership/runbook,
   Production entry, dependency scenarios, RTA/RPA, integrity/functionality, failback, evidence and
   approval); standalone Integration Testing rows instead of integration scenarios within
   Change-Based Functional Testing for Migration-Team refactoring or mandatory Application-Team
   UAT otherwise; integration case double-counting; missing/incomplete LSEG L2 OAT catalog
   dispositions or absent as-is/proposed-Azure scenario rationale, safe environment/change
   controls, Operations ownership, runbook, or execution evidence; lower-environment DR substituted
   for Production acceptance; merged security/
   penetration scope; missing per-test PREP/EXEC/REMEDIATE/EVIDENCE/APPROVAL tasks; unapproved
   exceptions; missing duration/capacity estimates for applicable tests; unsupported automation
   assumptions; unrealistic scaling across 1/2/3 tester scenarios; absent contingency/critical
   path or external waits; omitted optional pre-OAT agreement; failure to preserve the four-week L2
   Production OAT baseline without evidence; or missing named approval of the exact plan version
   from Migration, Migration Testing, Application and L2 Operations.
21. **Publication version integrity**: stale source fingerprint; missing/duplicate manifest entry;
   file/manifest version or hash mismatch; non-contiguous history; changed upstream content not
   republished; missing/stale G-3 `deliverables/G-test-plan.md` relative to canonical root source;
   unexpected extra G-3 copies; overwritten evidence; or Complete/Approved/Revalidated status
   without named-human evidence for that exact version. The root-source/published-view pair is
   expected and is not a duplicate-deliverable defect.
22. **Cross-deliverable coherence**: conflicting R-Type, scope, complexity, region, environment,
   service, SKU, capacity, cost, resilience, security/MEC, transition, testing, decision/risk,
   evidence, approval, date, or maturity claims across authoritative sources and publication views;
   unresolved facts silently presented as resolved; or numeric totals/units that do not reconcile.
23. **Core template drift**: missing, duplicate, renamed, unknown, or unmapped
   `.specify/templates/*-template.md` entries; generated requirements, architecture, spec, plan,
   tasks, records, profiles, or changelog missing required headings/tables/fields; obsolete template
   shape retained after a framework update; or applicable repository validators not run/reported.

## Process

### Phase 1 — Plan

1. Read the indexed feature chain first: `requirements/index.md`, `decisions/index.md`, and
   `risks/index.md`; then load only relevant record files plus `architecture.md`, `spec.md`,
   `plan.md`, and `tasks.md`. Generated rollups are compatibility views, not authoritative sources.
2. Build a list of the checks above and determine which ones are relevant to the current feature.

### Phase 2 — Act

3. `analyze-gates` validates the gating sequence and status transitions.
4. `analyze-traceability` checks the chain from requirement to design to backlog to task.
5. `analyze-governance` reports scope creep, backlog drift, R-Type drift, and evidence problems.
5a. `analyze-testing` builds and validates the canonical per-test trace ledger and runs the
   testing-specific repository validators without editing artifacts.
   Apply `docs/testing-strategy/automation-review-and-scenario-sizing.md`: check per-test
   Application Team review actions, dated response evidence, Unknown versus confirmed absence,
   Section 14.3 scenario scope and Test Plan automation/effort sizing and backlog trace.
   Check assignment against the exact LMP sections/Appendix 5, especially one-sprint enablement,
   changed-unit scope, performance baseline/script roles and Application Team maintenance.
   Check the Test Plan's opening Review Brief first: proposed scope, significant conflicts,
   prioritized next human decisions and version-specific gate must reconcile with canonical
   CON/ACT/AUT statuses and evidence. Check links to detailed case mappings/supporting tables.
   Missing legacy Draft navigation warns; ReadyForReview requires it. Owned pending readiness
   or appointments are not execution approval and are not failed document-review prerequisites.
5b. `analyze-artifacts` inventories every core `.specify/templates/*-template.md` file, maps it to
   its materialized artifact or workflow consumer, compares current template shape with the active
   feature, and runs every applicable requirements/architecture/plan/task validator. Requirements
   and architecture must be named explicitly in the inventory and result summary.
5c. `analyze-deliverables` inventories every publication template and manifest entry, validates each
   output against its authoritative basis, and reconciles shared claims across all deliverables.
   A newly introduced template must be reported as mapped or untracked, never silently skipped.
5d. When `deliverables/manifest.json` exists, run `validate-publication.ps1` and include its
   version/provenance findings without regenerating outputs. Run `validate-sad-contract.ps1` for
   G-2 and include its contract/coverage findings.
6. For each issue, record Severity, Location, Issue, and Suggested Fix.

### Phase 3 — Review

7. Produce the findings table in a human-readable format and do not silently fix anything.
8. Recommend follow-up work via the relevant downstream pass (`/specify`, `/plan`, `/tasks`,
   `/decisions`, `/risks`, or `/speckit.publish`) rather than implicitly resolving the issue here.
