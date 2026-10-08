# Uncommitted Spec Layer Changes - 2026-10-08

Repository: spec-layer-foundation. Comparison: all eligible uncommitted changes against HEAD 80dadeeb16051396e411cef53665a298d10215d4.

Scope: 52 modified files and nine new files (61 total); 4066 lines added and 391 removed. Excluded .github/prompts/onefile.md, all .docx files and all docs/SitePages* paths.

The nine new files were marked with git add -N only; no content was staged. No commit, push, pull or fetch was run. No source file inside the repository was edited. The requested final report path is this file; C:\work\changes.md retains the raw Git output.

## File Summary

| Path | Lines added | Lines removed | One-line summary |
| --- | ---: | ---: | --- |
| [.github/prompts/speckit.analyze.prompt.md](../spec-layer-foundation/.github/prompts/speckit.analyze.prompt.md) | 30 | 6 | Expand testing, automation, review-brief and canonical/published Test Plan integrity analysis. |
| [.github/prompts/speckit.architecture.prompt.md](../spec-layer-foundation/.github/prompts/speckit.architecture.prompt.md) | 31 | 6 | Require OAT and scenario/crosswalk design plus controlled architecture checklist evaluation. |
| [.github/prompts/speckit.checklist.prompt.md](../spec-layer-foundation/.github/prompts/speckit.checklist.prompt.md) | 33 | 6 | Use PathsOnly discovery and controlled gate baselines with separate post-gate checks. |
| [.github/prompts/speckit.clarify.prompt.md](../spec-layer-foundation/.github/prompts/speckit.clarify.prompt.md) | 3 | 1 | Re-evaluate the active gate checklist after clarification updates. |
| [.github/prompts/speckit.plan.prompt.md](../spec-layer-foundation/.github/prompts/speckit.plan.prompt.md) | 76 | 7 | Add spec readiness gate, OAT planning, evidence intake, staged validation and capacity estimates. |
| [.github/prompts/speckit.publish.prompt.md](../spec-layer-foundation/.github/prompts/speckit.publish.prompt.md) | 15 | 6 | Publish a source-faithful G-3 view and require all post-gate checks for deliverable completion. |
| [.github/prompts/speckit.requirements.prompt.md](../spec-layer-foundation/.github/prompts/speckit.requirements.prompt.md) | 34 | 3 | Add automation/evidence follow-up and controlled requirements checklist evaluation. |
| [.github/prompts/speckit.specify.prompt.md](../spec-layer-foundation/.github/prompts/speckit.specify.prompt.md) | 21 | 5 | Carry testing evidence into SPEC without requiring a Test Plan; update checkpoint numbering. |
| [.github/skills/analyze-deliverables/SKILL.md](../spec-layer-foundation/.github/skills/analyze-deliverables/SKILL.md) | 5 | 1 | Distinguish the canonical Test Plan source from its expected published G-3 view. |
| [.github/skills/analyze-testing/SKILL.md](../spec-layer-foundation/.github/skills/analyze-testing/SKILL.md) | 75 | 10 | Audit staged readiness, scenario sizing, OAT, approvals and evidence/action traceability. |
| [.github/skills/architecture-testing/SKILL.md](../spec-layer-foundation/.github/skills/architecture-testing/SKILL.md) | 55 | 4 | Design evidence-based scenario families, OAT applicability and migration impact crosswalks. |
| [.github/skills/oat-scenario-design/SKILL.md](../spec-layer-foundation/.github/skills/oat-scenario-design/SKILL.md) | 82 | 0 | Add evidence-grounded OAT catalog applicability and safe operational testability design. |
| [.github/skills/oat-scenario-planning/SKILL.md](../spec-layer-foundation/.github/skills/oat-scenario-planning/SKILL.md) | 107 | 0 | Add executable OAT scenario planning with ownership, runbooks, safety and evidence. |
| [.github/skills/plan-testing/SKILL.md](../spec-layer-foundation/.github/skills/plan-testing/SKILL.md) | 148 | 10 | Expand evidence intake, review briefs, staged validation, estimates, HA/DR/OAT and approvals. |
| [.github/skills/publication-readiness/SKILL.md](../spec-layer-foundation/.github/skills/publication-readiness/SKILL.md) | 17 | 3 | Require post-gate checklist completion and source-faithful Test Plan publication readiness. |
| [.github/skills/publication-rendering/SKILL.md](../spec-layer-foundation/.github/skills/publication-rendering/SKILL.md) | 15 | 1 | Render the full canonical Test Plan as G-3 without inventing cases, approvals or review content. |
| [.github/skills/requirements-coverage/SKILL.md](../spec-layer-foundation/.github/skills/requirements-coverage/SKILL.md) | 4 | 3 | Move requirements gate checks into the controlled checklist with evidence-backed completion. |
| [.github/skills/requirements-testing/SKILL.md](../spec-layer-foundation/.github/skills/requirements-testing/SKILL.md) | 57 | 10 | Add automation reviews, shared evidence/action registers and integration/HA/DR/OAT rules. |
| [.github/skills/specify-backlog/SKILL.md](../spec-layer-foundation/.github/skills/specify-backlog/SKILL.md) | 7 | 0 | Preserve selected story IDs and repository/readiness traces in the testing evidence handoff. |
| [.github/skills/specify-coverage/SKILL.md](../spec-layer-foundation/.github/skills/specify-coverage/SKILL.md) | 21 | 5 | Validate testing evidence handoff and shared action references without duplicating registers. |
| [.specify/checklists/architecture.md](../spec-layer-foundation/.specify/checklists/architecture.md) | 84 | 0 | Add the controlled architecture review acceptance checklist. |
| [.specify/checklists/complexity-calculator.md](../spec-layer-foundation/.specify/checklists/complexity-calculator.md) | 2 | 1 | Designate five G-7 checks as post-gate items instead of architecture blockers. |
| [.specify/checklists/mec-assessment.md](../spec-layer-foundation/.specify/checklists/mec-assessment.md) | 2 | 1 | Designate three SPEC/G-4 checks as post-gate items instead of architecture blockers. |
| [.specify/checklists/plan.md](../spec-layer-foundation/.specify/checklists/plan.md) | 36 | 0 | Add the controlled plan governance, schedule and testing acceptance checklist. |
| [.specify/checklists/requirements.md](../spec-layer-foundation/.specify/checklists/requirements.md) | 65 | 0 | Add the controlled requirements review acceptance checklist. |
| [.specify/checklists/spec.md](../spec-layer-foundation/.specify/checklists/spec.md) | 41 | 0 | Add the controlled SPEC scope, backlog, human-review and testing-handoff checklist. |
| [.specify/scripts/powershell/README.md](../spec-layer-foundation/.specify/scripts/powershell/README.md) | 15 | 6 | Document doctor, checklist gates, staged validation, UTF-8 behavior and fixture parameters. |
| [.specify/scripts/powershell/check-prerequisites.ps1](../spec-layer-foundation/.specify/scripts/powershell/check-prerequisites.ps1) | 53 | 42 | Enforce controlled checklists; add RequireSpecReady/PathsOnly and non-blocking record syntax. |
| [.specify/scripts/powershell/common.ps1](../spec-layer-foundation/.specify/scripts/powershell/common.ps1) | 98 | 1 | Default text I/O to UTF-8; share gate/checklist parsing and normalize JSON apostrophe escaping. |
| [.specify/scripts/powershell/doctor.ps1](../spec-layer-foundation/.specify/scripts/powershell/doctor.ps1) | 247 | 0 | Add machine, workspace, canonical-input and knowledge-source diagnostics with failure exit 1. |
| [.specify/scripts/powershell/finalize-publication.ps1](../spec-layer-foundation/.specify/scripts/powershell/finalize-publication.ps1) | 9 | 0 | Skip uncreated pending G-3 in bulk runs and reject missing or source-divergent G-3 publication. |
| [.specify/scripts/powershell/setup-publication.ps1](../spec-layer-foundation/.specify/scripts/powershell/setup-publication.ps1) | 13 | 6 | Move G-3 to a managed deliverables view and materialize it only from the canonical source. |
| [.specify/scripts/powershell/sync-records.ps1](../spec-layer-foundation/.specify/scripts/powershell/sync-records.ps1) | 13 | 2 | Preserve existing requirements gate metadata, use full record paths and return explicit exit 0. |
| [.specify/scripts/powershell/test-implementation-backlog.ps1](../spec-layer-foundation/.specify/scripts/powershell/test-implementation-backlog.ps1) | 1 | 1 | BOM only |
| [.specify/scripts/powershell/test-publication-workflow.ps1](../spec-layer-foundation/.specify/scripts/powershell/test-publication-workflow.ps1) | 44 | 5 | Add configurable fixture root and test G-3 versioning, source fidelity and pending activation. |
| [.specify/scripts/powershell/test-testing-workflow.ps1](../spec-layer-foundation/.specify/scripts/powershell/test-testing-workflow.ps1) | 502 | 10 | Add configurable fixture root and extensive staged testing/evidence/contract regressions. |
| [.specify/scripts/powershell/validate-architecture.ps1](../spec-layer-foundation/.specify/scripts/powershell/validate-architecture.ps1) | 146 | 11 | Require sections 14.2-14.4, all OAT dispositions and scenario/crosswalk traces; refine gate checks. |
| [.specify/scripts/powershell/validate-checklists.ps1](../spec-layer-foundation/.specify/scripts/powershell/validate-checklists.ps1) | 12 | 8 | Add IncludePostGate, separate blocking/open IDs and explicit success exit 0. |
| [.specify/scripts/powershell/validate-implementation-backlog.ps1](../spec-layer-foundation/.specify/scripts/powershell/validate-implementation-backlog.ps1) | 1 | 1 | BOM only |
| [.specify/scripts/powershell/validate-publication.ps1](../spec-layer-foundation/.specify/scripts/powershell/validate-publication.ps1) | 13 | 1 | Replace the G-3 duplicate-copy prohibition with managed-path and canonical-content validation. |
| [.specify/scripts/powershell/validate-records.ps1](../spec-layer-foundation/.specify/scripts/powershell/validate-records.ps1) | 20 | 6 | Require decision/disposition, reviewer and date; ignore catalog IDs and return explicit exit 0. |
| [.specify/scripts/powershell/validate-requirements-testing.ps1](../spec-layer-foundation/.specify/scripts/powershell/validate-requirements-testing.ps1) | 158 | 0 | Add staged validation, automation reviews, evidence/action/asset checks and completeness output. |
| [.specify/scripts/powershell/validate-requirements-transition.ps1](../spec-layer-foundation/.specify/scripts/powershell/validate-requirements-transition.ps1) | 1 | 1 | BOM only |
| [.specify/scripts/powershell/validate-sad-contract.ps1](../spec-layer-foundation/.specify/scripts/powershell/validate-sad-contract.ps1) | 9 | 7 | Decode inputs explicitly as UTF-8 and normalize numeric table column counts across runtimes. |
| [.specify/scripts/powershell/validate-test-plan.ps1](../spec-layer-foundation/.specify/scripts/powershell/validate-test-plan.ps1) | 460 | 12 | Add staged readiness, case/asset/estimate/brief checks, OAT/HA/DR contracts and four-party approvals. |
| [.specify/scripts/powershell/validate-testing-strategy.ps1](../spec-layer-foundation/.specify/scripts/powershell/validate-testing-strategy.ps1) | 5 | 0 | Require the canonical HA and DR source headings in extracted strategy Markdown. |
| [.specify/scripts/powershell/validate-testing-tasks.ps1](../spec-layer-foundation/.specify/scripts/powershell/validate-testing-tasks.ps1) | 1 | 1 | BOM only |
| [.specify/templates/architecture-template.md](../spec-layer-foundation/.specify/templates/architecture-template.md) | 133 | 88 | Add OAT/scenario/crosswalk sections and replace inline gate checks with controlled checklist links. |
| [.specify/templates/plan-template.md](../spec-layer-foundation/.specify/templates/plan-template.md) | 19 | 13 | Expand testing schedule/capacity handoff and replace inline plan gate checks with a baseline link. |
| [.specify/templates/requirements-template.md](../spec-layer-foundation/.specify/templates/requirements-template.md) | 7 | 52 | Replace inline requirements gate checks with the controlled checklist and reported open-item count. |
| [.specify/templates/spec-template.md](../spec-layer-foundation/.specify/templates/spec-template.md) | 62 | 10 | Insert testing evidence handoff, renumber later sections and link the controlled SPEC checklist. |
| [.specify/templates/testing-profile-template.md](../spec-layer-foundation/.specify/templates/testing-profile-template.md) | 77 | 5 | Add evidence, conflicts, assets, shared human actions and automation review tables. |
| [AGENTS.md](../spec-layer-foundation/AGENTS.md) | 7 | 0 | Require controlled executable gate checklists and distinguish post-gate deliverable checks. |
| [CHANGELOG.md](../spec-layer-foundation/CHANGELOG.md) | 179 | 0 | Record framework releases and changes through version 1.50.0. |
| [README.md](../spec-layer-foundation/README.md) | 11 | 1 | Document gate baselines, execution-policy prerequisites and machine doctor usage. |
| [VERSION](../spec-layer-foundation/VERSION) | 1 | 2 | Advance the framework version from 1.42.2 to 1.50.0 and remove the trailing blank line. |
| [deliverables-template/md-templates/G-test-plan.md](../spec-layer-foundation/deliverables-template/md-templates/G-test-plan.md) | 301 | 6 | Add review brief, scenario/case evidence, estimates, HA/DR/OAT designs and multi-party approvals. |
| [docs/testing-strategy/INDEX.md](../spec-layer-foundation/docs/testing-strategy/INDEX.md) | 65 | 2 | Expand governing integration, HA/DR/OAT, automation, evidence and staged-review guidance. |
| [docs/testing-strategy/LSEG-L2-OAT-Game-Day-Scenario-Catalog.md](../spec-layer-foundation/docs/testing-strategy/LSEG-L2-OAT-Game-Day-Scenario-Catalog.md) | 95 | 0 | Add the 51-scenario L2 catalog: 24 Game Day, nine standard-change and 18 validation scenarios. |
| [docs/testing-strategy/automation-review-and-scenario-sizing.md](../spec-layer-foundation/docs/testing-strategy/automation-review-and-scenario-sizing.md) | 204 | 0 | Add reusable automation/evidence intake, scenario sizing, ownership and human-input guidance. |
| [docs/testing-strategy/testing-strategy-contract.json](../spec-layer-foundation/docs/testing-strategy/testing-strategy-contract.json) | 18 | 2 | Update the index hash and pin the expanded HA/DR/OAT, evidence and staged-review guidance markers. |

BOM only means byte comparison with HEAD, after the configured Git CRLF-to-LF checkout normalization where applicable, found only an added EF BB BF UTF-8 prefix. Git counts that first-line replacement as +1/-1. Four files match this definition; files with additional substantive edits are not labeled BOM only.

## Compatibility Flags

These are behavior changes and migration risks, not a claim that every item is a defect. Passing smoke tests does not prove compatibility for existing application artifacts.

| Flag | Affected files | Change and potential impact |
| --- | --- | --- |
| High: newly blocking gate checks | [check-prerequisites.ps1](../spec-layer-foundation/.specify/scripts/powershell/check-prerequisites.ps1), new gate baselines and owning prompts | Requirements, architecture, SPEC and plan checklists are now mandatory at their respective gates. Previously cleared application artifacts without these files will fail; instantiate and evaluate the baselines before upgrading the workflow. |
| High: G-3 manifest/path migration | [setup-publication.ps1](../spec-layer-foundation/.specify/scripts/powershell/setup-publication.ps1), [finalize-publication.ps1](../spec-layer-foundation/.specify/scripts/powershell/finalize-publication.ps1), [validate-publication.ps1](../spec-layer-foundation/.specify/scripts/powershell/validate-publication.ps1) | G-3 changes from unmanaged ../G-test-plan.md to managed deliverables/G-test-plan.md. Old manifests fail the new path/managed check; stale published copies fail exact canonical-body comparison. Setup preserves existing views, so a changed canonical source must be rendered before finalization. |
| High: mandatory architecture contract expansion | [validate-architecture.ps1](../spec-layer-foundation/.specify/scripts/powershell/validate-architecture.ps1), [architecture-template.md](../spec-layer-foundation/.specify/templates/architecture-template.md) | Sections 14.2 OAT applicability, 14.3 scenario design and 14.4 impact crosswalk become mandatory, including all 51 OAT IDs and profile/action traces. Existing architecture documents need migration. |
| High: expanded default testing contract | [validate-requirements-testing.ps1](../spec-layer-foundation/.specify/scripts/powershell/validate-requirements-testing.ps1), [validate-test-plan.ps1](../spec-layer-foundation/.specify/scripts/powershell/validate-test-plan.ps1) | Existing calls still default to Execution, but automation/evidence registers, capacity estimates, case/asset/estimate tables, HA/DR/OAT sections and four-party approvals are newly enforced. Older profiles/plans can fail unchanged caller commands. Exact heading/column and wording checks also reject semantically equivalent renamed text. |
| Medium: removed inline checks, now external | [requirements-template.md](../spec-layer-foundation/.specify/templates/requirements-template.md), [architecture-template.md](../spec-layer-foundation/.specify/templates/architecture-template.md), [plan-template.md](../spec-layer-foundation/.specify/templates/plan-template.md), [spec-template.md](../spec-layer-foundation/.specify/templates/spec-template.md) | Inline acceptance checkboxes are removed and moved to controlled baselines; they are not simply waived. Consumers that scan embedded checkboxes must read checklists/ instead. Checklist completion still requires real evidence and human sign-off. |
| Medium: renamed/renumbered SPEC sections | [spec-template.md](../spec-layer-foundation/.specify/templates/spec-template.md), [speckit.specify.prompt.md](../spec-layer-foundation/.github/prompts/speckit.specify.prompt.md) | Section 6 becomes Testing Evidence Handoff; Out of Scope moves 6 to 7, Open Decisions & Risks 7 to 8, and Review Checkpoint 8 to 9. Hard-coded section numbers and anchors need updating. Shared gate parsing now tolerates numeric prefixes. |
| Medium: relaxed completion checks | [validate-checklists.ps1](../spec-layer-foundation/.specify/scripts/powershell/validate-checklists.ps1), [common.ps1](../spec-layer-foundation/.specify/scripts/powershell/common.ps1), MEC/complexity baselines | RequireComplete now excludes baseline Post-Gate Items by default: complexity CHK001/014/020/029/030 and MEC CHK036/037/042. G-7/G-4 completion callers must add IncludePostGate; unchanged callers otherwise enforce a weaker completion definition. |
| Medium: explicit bypass and non-blocking syntax | [check-prerequisites.ps1](../spec-layer-foundation/.specify/scripts/powershell/check-prerequisites.ps1) | New PathsOnly returns exit 0 before gate validation and must only be used for discovery, never approval. Records with a new '- Blocks Progression: No' line cease blocking progression; review that designation explicitly. RequireSpecReady introduces a new signed SPEC gate for planning. |
| Medium: stage-specific removed checks | [validate-test-plan.ps1](../spec-layer-foundation/.specify/scripts/powershell/validate-test-plan.ps1) | Draft/ReadyForReview defer Ready architecture and named appointments only when owned actions exist; Draft no longer globally rejects all template placeholders. ReadyForReview requires a Review Brief; legacy Draft/Execution without one warns. Default Execution remains strict, but callers must not treat Draft validity as execution approval. |
| Medium: integration classification change | Testing prompts, skills, profiles, architecture and Test Plan validators | Standalone Integration Testing rows are rejected; map integration into Change-based functional for Migration-Team refactoring or mandatory Application-Team UAT otherwise. Existing catalogs/RACI rows and duplicate case counts require reconciliation. |
| Medium: stricter human record review | [validate-records.ps1](../spec-layer-foundation/.specify/scripts/powershell/validate-records.ps1) | Final ADRs now require Human Decision, Reviewer and YYYY-MM-DD Review Date; risks leaving Identified require Human Disposition and the same metadata. Previously accepted records lacking these fields now fail. Catalog-prefixed IDs such as LMP-ADR-0010 stop being interpreted as missing application records. |
| Medium: preserved gate approval on sync | [sync-records.ps1](../spec-layer-foundation/.specify/scripts/powershell/sync-records.ps1) | Synchronization no longer resets an existing Requirements Review Gate. This preserves human metadata but can preserve stale approval after requirements change; re-evaluate the checklist and human gate when source meaning changes. |
| Medium: changed success exits | [sync-records.ps1](../spec-layer-foundation/.specify/scripts/powershell/sync-records.ps1), [validate-records.ps1](../spec-layer-foundation/.specify/scripts/powershell/validate-records.ps1), [validate-checklists.ps1](../spec-layer-foundation/.specify/scripts/powershell/validate-checklists.ps1), [doctor.ps1](../spec-layer-foundation/.specify/scripts/powershell/doctor.ps1) | Three existing scripts add explicit exit 0 (failure exit 1 remains); doctor is new with exit 1 on a failed check and 0 otherwise. Wrappers relying on stale LASTEXITCODE or dot-sourcing executable scripts should recheck control flow. G-3 bulk publication now skips a pending absent source, but explicitly requested absent G-3 still fails. |
| Low: added script parameters/output fields | Prerequisite, checklist, testing-profile/Test Plan validators and two workflow runners | New switches: RequireSpecReady, PathsOnly, IncludePostGate; new ValidationStage values Draft/ReadyForReview/Execution; new WorkspaceRoot in testing/publication runners. Existing switches remain. JSON adds gate/checklist status, warnings, input completeness and deferred execution fields; rigid consumers must allow the new schema. |
| Low: shared text/JSON behavior | [common.ps1](../spec-layer-foundation/.specify/scripts/powershell/common.ps1), [validate-sad-contract.ps1](../spec-layer-foundation/.specify/scripts/powershell/validate-sad-contract.ps1), BOM-only scripts | Text cmdlets now default to UTF-8 within the caller script scope; JSON apostrophe escapes are normalized, and SAD column counts are cast to int before signature comparison. Byte-oriented hashes, output snapshots and encoding-dependent consumers may change even when semantic content is unchanged. |
| Low: expanded pinned strategy validation | [validate-testing-strategy.ps1](../spec-layer-foundation/.specify/scripts/powershell/validate-testing-strategy.ps1), [testing-strategy-contract.json](../spec-layer-foundation/docs/testing-strategy/testing-strategy-contract.json) | HA/DR headings and expanded index markers are mandatory, and indexSha256 changes. Deploy the revised index and contract together or every prerequisite gate can fail source-drift validation. |

## Runtime Verification

Executed each script in its own process with -NoLogo -NoProfile -ExecutionPolicy Bypass -File <absolute-script-path> -Json. Tests used their self-contained disposable fixtures outside the framework repo. The real environment was retained for doctor; SPEC_LAYER_APP_ROOT was not fabricated or changed.

Only THREE test-*.ps1 runners exist in this repository, not the requested five. All three were run on both hosts. The remaining two cannot be run without their paths/files; validators were not silently substituted for test runners.

| Script | PowerShell 7.4.1 exit code | Windows PowerShell 5.1.26100.9444 exit code | Result |
| --- | ---: | ---: | --- |
| [doctor.ps1](../spec-layer-foundation/.specify/scripts/powershell/doctor.ps1) | 1 | 1 | Fail: SPEC_LAYER_APP_ROOT unset; optional Pandoc warning |
| [test-implementation-backlog.ps1](../spec-layer-foundation/.specify/scripts/powershell/test-implementation-backlog.ps1) | 0 | 0 | Passed on both runtimes |
| [test-publication-workflow.ps1](../spec-layer-foundation/.specify/scripts/powershell/test-publication-workflow.ps1) | 0 | 0 | Passed on both runtimes |
| [test-testing-workflow.ps1](../spec-layer-foundation/.specify/scripts/powershell/test-testing-workflow.ps1) | 0 | 0 | Passed on both runtimes |
| Requested test runner 4 (not supplied/present) | N/A | N/A | Not run: path/file unavailable |
| Requested test runner 5 (not supplied/present) | N/A | N/A | Not run: path/file unavailable |

Doctor findings on both hosts:

- PowerShell 7: WARN pandoc: Not found. Only export-testing-strategy.ps1 needs it (maintainers re-extracting the testing strategy DOCX).
- PowerShell 7: FAIL app-root: SPEC_LAYER_APP_ROOT is not set. Set it to the external application workspace that will contain specs/, source/target evidence, and deliverables. The framework repository is read-only input and must not receive app artifacts.
- Windows PowerShell 5.1: WARN pandoc: Not found. Only export-testing-strategy.ps1 needs it (maintainers re-extracting the testing strategy DOCX).
- Windows PowerShell 5.1: FAIL app-root: SPEC_LAYER_APP_ROOT is not set. Set it to the external application workspace that will contain specs/, source/target evidence, and deliverables. The framework repository is read-only input and must not receive app artifacts.

On both runtimes, the pinned SAD/testing-strategy hashes, readable complexity workbook, SAD contract validator, testing strategy validator and knowledge-source checks passed. No source repairs, execution-policy changes or environment setup were made. To resolve doctor, set SPEC_LAYER_APP_ROOT to the actual existing external application workspace and rerun; Pandoc is optional for re-extraction only.

Verification limitations: two requested test runners are absent; these tests do not exercise a real existing application migration or prove that all old section/path/schema consumers are compatible. The compatibility flags above remain review items, not automatically approved changes.

## Combined Diff

Generated directly with:

```powershell
git -c core.quotepath=false diff HEAD --stat --patch --output=C:\work\changes.md -- . ':(exclude).github/prompts/onefile.md' ':(exclude,icase)*.docx' ':(exclude)docs/SitePages*'
```

`````diff
 .github/prompts/speckit.analyze.prompt.md          |  36 +-
 .github/prompts/speckit.architecture.prompt.md     |  37 +-
 .github/prompts/speckit.checklist.prompt.md        |  39 +-
 .github/prompts/speckit.clarify.prompt.md          |   4 +-
 .github/prompts/speckit.plan.prompt.md             |  83 +++-
 .github/prompts/speckit.publish.prompt.md          |  21 +-
 .github/prompts/speckit.requirements.prompt.md     |  37 +-
 .github/prompts/speckit.specify.prompt.md          |  26 +-
 .github/skills/analyze-deliverables/SKILL.md       |   6 +-
 .github/skills/analyze-testing/SKILL.md            |  85 +++-
 .github/skills/architecture-testing/SKILL.md       |  59 ++-
 .github/skills/oat-scenario-design/SKILL.md        |  82 ++++
 .github/skills/oat-scenario-planning/SKILL.md      | 107 +++++
 .github/skills/plan-testing/SKILL.md               | 158 ++++++-
 .github/skills/publication-readiness/SKILL.md      |  20 +-
 .github/skills/publication-rendering/SKILL.md      |  16 +-
 .github/skills/requirements-coverage/SKILL.md      |   7 +-
 .github/skills/requirements-testing/SKILL.md       |  67 ++-
 .github/skills/specify-backlog/SKILL.md            |   7 +
 .github/skills/specify-coverage/SKILL.md           |  26 +-
 .specify/checklists/architecture.md                |  84 ++++
 .specify/checklists/complexity-calculator.md       |   3 +-
 .specify/checklists/mec-assessment.md              |   3 +-
 .specify/checklists/plan.md                        |  36 ++
 .specify/checklists/requirements.md                |  65 +++
 .specify/checklists/spec.md                        |  41 ++
 .specify/scripts/powershell/README.md              |  21 +-
 .../scripts/powershell/check-prerequisites.ps1     |  95 ++--
 .specify/scripts/powershell/common.ps1             |  99 +++-
 .specify/scripts/powershell/doctor.ps1             | 247 ++++++++++
 .../scripts/powershell/finalize-publication.ps1    |   9 +
 .specify/scripts/powershell/setup-publication.ps1  |  19 +-
 .specify/scripts/powershell/sync-records.ps1       |  15 +-
 .../powershell/test-implementation-backlog.ps1     |   2 +-
 .../powershell/test-publication-workflow.ps1       |  49 +-
 .../scripts/powershell/test-testing-workflow.ps1   | 512 ++++++++++++++++++++-
 .../scripts/powershell/validate-architecture.ps1   | 157 ++++++-
 .../scripts/powershell/validate-checklists.ps1     |  20 +-
 .../powershell/validate-implementation-backlog.ps1 |   2 +-
 .../scripts/powershell/validate-publication.ps1    |  14 +-
 .specify/scripts/powershell/validate-records.ps1   |  26 +-
 .../powershell/validate-requirements-testing.ps1   | 158 +++++++
 .../validate-requirements-transition.ps1           |   2 +-
 .../scripts/powershell/validate-sad-contract.ps1   |  16 +-
 .specify/scripts/powershell/validate-test-plan.ps1 | 472 ++++++++++++++++++-
 .../powershell/validate-testing-strategy.ps1       |   5 +
 .../scripts/powershell/validate-testing-tasks.ps1  |   2 +-
 .specify/templates/architecture-template.md        | 221 +++++----
 .specify/templates/plan-template.md                |  32 +-
 .specify/templates/requirements-template.md        |  59 +--
 .specify/templates/spec-template.md                |  72 ++-
 .specify/templates/testing-profile-template.md     |  82 +++-
 AGENTS.md                                          |   7 +
 CHANGELOG.md                                       | 179 +++++++
 README.md                                          |  12 +-
 VERSION                                            |   3 +-
 deliverables-template/md-templates/G-test-plan.md  | 307 +++++++++++-
 docs/testing-strategy/INDEX.md                     |  67 ++-
 .../LSEG-L2-OAT-Game-Day-Scenario-Catalog.md       |  95 ++++
 .../automation-review-and-scenario-sizing.md       | 204 ++++++++
 .../testing-strategy-contract.json                 |  20 +-
 61 files changed, 4066 insertions(+), 391 deletions(-)

diff --git a/.github/prompts/speckit.analyze.prompt.md b/.github/prompts/speckit.analyze.prompt.md
index bfa4042..a38c9ea 100644
--- a/.github/prompts/speckit.analyze.prompt.md
+++ b/.github/prompts/speckit.analyze.prompt.md
@@ -57,13 +57,27 @@ chain for drift, gaps, and policy violations without rewriting the source artifa
    security, observability, licensing, cost and cleanup consequences.
 20. **Migration testing integrity**: missing/duplicate testing-profile dispositions; broken
    REQ/NFR-to-Section-14.1-to-`G-test-plan.md` traces; unit-test scope outside migration-changed
-   impacted code; data-testing N/A despite data movement; lower-environment DR substituted for
-   Production acceptance; merged security/penetration scope; missing per-test PREP/EXEC/REMEDIATE/
-   EVIDENCE/APPROVAL tasks; unapproved exceptions; or fabricated/missing approvals.
-21. **Publication version integrity**: stale source fingerprint; missing/duplicate deliverable;
+   impacted code; data-testing N/A despite data movement; incomplete strategy Sections 7.2/7.3
+   coverage (HA goals, assessment, PPE, monitoring/data, entry/exit; DR ownership/runbook,
+   Production entry, dependency scenarios, RTA/RPA, integrity/functionality, failback, evidence and
+   approval); standalone Integration Testing rows instead of integration scenarios within
+   Change-Based Functional Testing for Migration-Team refactoring or mandatory Application-Team
+   UAT otherwise; integration case double-counting; missing/incomplete LSEG L2 OAT catalog
+   dispositions or absent as-is/proposed-Azure scenario rationale, safe environment/change
+   controls, Operations ownership, runbook, or execution evidence; lower-environment DR substituted
+   for Production acceptance; merged security/
+   penetration scope; missing per-test PREP/EXEC/REMEDIATE/EVIDENCE/APPROVAL tasks; unapproved
+   exceptions; missing duration/capacity estimates for applicable tests; unsupported automation
+   assumptions; unrealistic scaling across 1/2/3 tester scenarios; absent contingency/critical
+   path or external waits; omitted optional pre-OAT agreement; failure to preserve the four-week L2
+   Production OAT baseline without evidence; or missing named approval of the exact plan version
+   from Migration, Migration Testing, Application and L2 Operations.
+21. **Publication version integrity**: stale source fingerprint; missing/duplicate manifest entry;
    file/manifest version or hash mismatch; non-contiguous history; changed upstream content not
-   republished; duplicate `G-test-plan.md`; overwritten evidence; or Complete/Approved/Revalidated
-   status without named-human evidence for that exact version.
+   republished; missing/stale G-3 `deliverables/G-test-plan.md` relative to canonical root source;
+   unexpected extra G-3 copies; overwritten evidence; or Complete/Approved/Revalidated status
+   without named-human evidence for that exact version. The root-source/published-view pair is
+   expected and is not a duplicate-deliverable defect.
 22. **Cross-deliverable coherence**: conflicting R-Type, scope, complexity, region, environment,
    service, SKU, capacity, cost, resilience, security/MEC, transition, testing, decision/risk,
    evidence, approval, date, or maturity claims across authoritative sources and publication views;
@@ -89,6 +103,16 @@ chain for drift, gaps, and policy violations without rewriting the source artifa
 5. `analyze-governance` reports scope creep, backlog drift, R-Type drift, and evidence problems.
 5a. `analyze-testing` builds and validates the canonical per-test trace ledger and runs the
    testing-specific repository validators without editing artifacts.
+   Apply `docs/testing-strategy/automation-review-and-scenario-sizing.md`: check per-test
+   Application Team review actions, dated response evidence, Unknown versus confirmed absence,
+   Section 14.3 scenario scope and Test Plan automation/effort sizing and backlog trace.
+   Check assignment against the exact LMP sections/Appendix 5, especially one-sprint enablement,
+   changed-unit scope, performance baseline/script roles and Application Team maintenance.
+   Check the Test Plan's opening Review Brief first: proposed scope, significant conflicts,
+   prioritized next human decisions and version-specific gate must reconcile with canonical
+   CON/ACT/AUT statuses and evidence. Check links to detailed case mappings/supporting tables.
+   Missing legacy Draft navigation warns; ReadyForReview requires it. Owned pending readiness
+   or appointments are not execution approval and are not failed document-review prerequisites.
 5b. `analyze-artifacts` inventories every core `.specify/templates/*-template.md` file, maps it to
    its materialized artifact or workflow consumer, compares current template shape with the active
    feature, and runs every applicable requirements/architecture/plan/task validator. Requirements
diff --git a/.github/prompts/speckit.architecture.prompt.md b/.github/prompts/speckit.architecture.prompt.md
index 439c830..4d4c0bf 100644
--- a/.github/prompts/speckit.architecture.prompt.md
+++ b/.github/prompts/speckit.architecture.prompt.md
@@ -63,7 +63,10 @@ not governed the same way:
   `architecture-transition`.
 - `requirements/testing-profile.md` — the authoritative testing applicability/readiness profile.
    Each layer consumes the rows that exercise its design; `architecture-testing` reconciles all
-   rows into Section 14.1 after R-Type is independently derived.
+rows into Section 14.1 after R-Type is independently derived, uses Section 14.3 for evidenced
+application-specific scenario families, and Section 14.4 for the migration impact-to-test
+crosswalk. Missing source-code, plan, or case evidence remains an owned input gap; it does not
+prevent a reviewable proposed design or permit invented business facts.
 - Canonical SAD v3.4 contract inputs: the live DOCX, `sad-v3.4-contract.json`,
   `sad-v3.4-coverage-map.json`, and `G-sad-baseline.md`. Run `validate-sad-contract.ps1` before
   design; these define publication completeness, not application facts.
@@ -537,14 +540,31 @@ can perform.
    owning architecture section. Before accepting any automation claim, inspect the discovery report
    and current source-code/test-repo evidence to confirm the as-is state, case-count inventory, and
    ownership of each test type; do not assume coverage from framework names alone. Confirm that the
-   target supports automated unit, connectivity and performance/load execution. Integration and
-   smoke/regression/functional execution may be semi-automated only with reproducible manual steps,
-   retained evidence and R-Type-informed RACI ownership. Return gaps to
+   target supports automated unit, connectivity and performance/load execution.
+   Apply `docs/testing-strategy/automation-review-and-scenario-sizing.md`. Consume the per-type
+   Application Team automation review and populate Section 14.3 with tailored high-level scenario
+   families for every applicable/conditional type, especially None/Partial/Unknown coverage.
+   Include REQ/NFR/component evidence, outcomes/environment/data, verified reuse versus proposed
+   adaptation/build/manual scope, proposed volume bands/derivation/confidence and review-action
+   traces. Outline changed-unit boundary/error/mocking families and owner-selected performance
+   workloads/baseline/script gaps for Migration/Application scope and effort deep-dive.
+   Assign implementation/execution/maintenance separately from the exact LMP section/Appendix 5;
+   retain conditional one-sprint enablement and never assign all legacy-suite gaps to Migration.
+   These are proposals, not detailed scripts, executed cases or confirmed automation. Do not add a
+   standalone Integration Testing type to Section 14.1: assign integration scenarios to
+   Change-Based Functional Testing when the Migration Team performs refactoring (including within
+   Re-Host/Re-Platform), otherwise to mandatory Application-Team UAT. UAT remains mandatory in
+   either branch. Integration and smoke/regression/functional execution may be semi-automated only
+   with reproducible manual steps, retained evidence and R-Type-informed RACI ownership. Return gaps to
    Compute, Data, Networking, Integration, Security,
    Resilience, Transition or Cost and rerun that layer's validation. A non-comparable environment,
    missing baseline/evidence route, or unsupported production-only DR/penetration/OAT constraint
    is a Proposed ADR/risk, not a planning assumption. If remediation changes component-change
-   classification, re-evaluate Section 8.
+   classification, re-evaluate Section 8. Use `oat-scenario-design` with the LSEG L2 Game Day
+   catalog and current discovery/architecture evidence; populate Section 14.2 with one
+   evidence-backed applicability disposition for every catalog scenario ID, including as-is and
+   proposed Azure mapping, operational testability, environment/change safety, owner, runbook and
+   evidence. Do not assume listed services, tools, pipelines or scenario statuses apply.
 15. Populate Section 15 (Backlog Playbook Coverage Check) — an independent check, separate from
     Section 14's self-critique. First populate **15.0 Discovery & Assessment Re-validation**: read
     `requirements.md` Section 7's Discovery & Assessment Playbook coverage rows, take every row it
@@ -581,10 +601,15 @@ can perform.
     action needed (accept/reject/supersede a decision; accept/mitigate/escalate a risk with an
     owner) — this is what turns "26 open items across 10 sections" into a checklist a Migration
     Architect or Application Architect can actually work through file by file.
+    Instantiate or re-evaluate `checklists/architecture.md` from the controlled baseline
+    `.specify/checklists/architecture.md` using the `/speckit.checklist` rules, run
+    `validate-checklists.ps1 -ChecklistPath <absolute path> -Json`, and fill the gate's
+    **Checklist status** line. These are the gate's acceptance tests.
     Stop at the Architecture Review Gate. Do not mark it Cleared yourself — that is a human
     action per Constitution Principle III. In your final message to the user, name the two roles
     who clear this gate (Migration Architect / Application Architect), point them at the "Decisions
-    & Risks awaiting your review" table you just populated as the concrete starting point, and also
+    & Risks awaiting your review" table you just populated as the concrete starting point, list
+    every open checklist item grouped by evidence owner, and also
     name: any unresolved conflicts (Section 11), any Section 14 finding not yet resolved, any
     Section 15.2 Open Point not yet closed, and any uncatalogued service/pattern needs. Do not make
     the user re-derive this from the raw section numbers themselves.
diff --git a/.github/prompts/speckit.checklist.prompt.md b/.github/prompts/speckit.checklist.prompt.md
index 13f7875..2fe1274 100644
--- a/.github/prompts/speckit.checklist.prompt.md
+++ b/.github/prompts/speckit.checklist.prompt.md
@@ -11,8 +11,9 @@ $ARGUMENTS
 
 ### Phase 1 — Plan
 
-1. Run `.specify/scripts/powershell/check-prerequisites.ps1 -Json` and identify the active feature
-   directory and available artifacts. Load the constitution when present.
+1. Run `.specify/scripts/powershell/check-prerequisites.ps1 -PathsOnly -Json` and identify the active
+   feature directory and available artifacts. `-PathsOnly` runs no gate checks, so it works at every
+   stage. Load the constitution when present.
 2. Infer the checklist domain, artifact under review, audience and rigor from the arguments. Ask at
    most three targeted questions only when those choices would materially change the checklist.
 3. Read only the relevant artifact sections and authoritative sources. For Complexity Calculator
@@ -57,6 +58,29 @@ $ARGUMENTS
       - append evidence or the exact gap/owner/action after each canonical item;
       - add application-specific checks only from CHK043;
       - unchecked required items keep the Architecture Review Gate and G-4 In Progress.
+9b. A baseline's **Post-Gate Items** line lists checks that test artifacts produced after the
+      Architecture Review Gate (`spec.md`, G-4, G-7). Evaluate them like any other item; while their
+      artifact does not exist yet, leave them unchecked with the note `Post-gate: evaluated by
+      /speckit.publish`. They do not block the Architecture Review Gate; they keep only their
+      deliverable In Progress.
+9c. Gate checklists are the acceptance tests for each command's output. Each uses a controlled
+      baseline with the same copy-verbatim, append-only and evaluation rules as above:
+
+      | Argument | Baseline | Artifact under review | Blocks |
+      |----------|----------|-----------------------|--------|
+      | `requirements` | `.specify/checklists/requirements.md` | `requirements/` records and rollup | `/speckit.architecture` |
+      | `architecture` | `.specify/checklists/architecture.md` | `architecture.md` | `/speckit.specify` |
+      | `spec` | `.specify/checklists/spec.md` | `spec.md` | `/speckit.plan`, `/speckit.tasks` |
+      | `plan` | `.specify/checklists/plan.md` | `plan.md`, `G-test-plan.md` | `/speckit.tasks` |
+
+      The Architecture Review Gate also requires the gate-required items of
+      `checklists/complexity-calculator.md` and `checklists/mec-assessment.md`.
+
+      The owning command evaluates its checklist at the end of every run; invoke this command
+      directly to re-evaluate after later edits or human review actions. Items that depend on a
+      human action (decision/risk review, app-team or migration-team review) stay unchecked until
+      the artifact records that action with a named person and date; the reviewer may check them
+      after confirming. Update the artifact's **Checklist status** line with the new counts.
 
 ### Phase 3 — Review
 
@@ -64,10 +88,13 @@ $ARGUMENTS
     Fix structural failures. Do not mark quality gaps complete merely to make validation green.
    Complexity checklists are automatically compared with the controlled foundation baseline;
    missing or paraphrased canonical items are validation failures.
-11. A required checklist with unchecked items keeps its owning gate/deliverable In Progress. The
-    validator proves checklist integrity and reports completion; it does not replace semantic or
-    human review.
+11. A required checklist with unchecked items keeps its owning gate/deliverable In Progress. For gate
+    checklists, `check-prerequisites.ps1` enforces this with `validate-checklists.ps1
+    -RequireComplete`, which ignores Post-Gate Items; `/speckit.publish` adds `-IncludePostGate`
+    before G-4 or G-7 can be Complete. The validator proves checklist integrity and reports
+    completion; it does not replace semantic or human review.
 12. Report the checklist path, item/pass/open counts, whether created or appended, focus, audience,
-    and every open item grouped by evidence owner. Do not alter architecture, requirements,
+    and every open item grouped by evidence owner. Apart from the owning artifact's **Checklist
+    status** line, which this command keeps current, do not alter architecture, requirements,
     decisions, risks or publication artifacts unless the user separately invokes their owning
     workflow.
diff --git a/.github/prompts/speckit.clarify.prompt.md b/.github/prompts/speckit.clarify.prompt.md
index f9db3f6..d03ef0a 100644
--- a/.github/prompts/speckit.clarify.prompt.md
+++ b/.github/prompts/speckit.clarify.prompt.md
@@ -37,6 +37,8 @@ provides.
 ### Phase 3 — Review
 
 8. Re-read the updated document and confirm every answer has a source and no newly introduced scope
-   expansion.
+   expansion. If the active document has a gate checklist (`checklists/requirements.md`,
+   `checklists/architecture.md` or `checklists/spec.md`), re-evaluate it with the
+   `/speckit.checklist` rules so its state reflects the answers just recorded.
 9. Stop once no answerable `UNKNOWN`s remain in the active document; list any gaps that truly need
    app-team research and leave them explicitly flagged.
diff --git a/.github/prompts/speckit.plan.prompt.md b/.github/prompts/speckit.plan.prompt.md
index e4a5d2b..1c0b549 100644
--- a/.github/prompts/speckit.plan.prompt.md
+++ b/.github/prompts/speckit.plan.prompt.md
@@ -13,12 +13,16 @@ $ARGUMENTS
 | `plan-readiness` | Constitution gate, evidence review, and unknown resolution workflow |
 | `plan-design` | Design table import, target mapping, and requirement traceability |
 | `plan-testing` | Application Test Plan, test schedule/RACI, evidence, defects, exceptions, and approvals |
+| `oat-scenario-planning` | Convert the architecture OAT scenario matrix and LSEG L2 catalog into executable OAT cases |
 | `plan-governance` | Proposed decisions, identified risks, and gate review preparation |
 
 ## Process
 
 ### Phase 1 — Plan
 
+0. Run `.specify/scripts/powershell/check-prerequisites.ps1 -RequireSpecReady -Json`. If it fails
+   (spec checklist open, Review Checkpoint not cleared by a named human, or blocking decisions/risks),
+   STOP and report the failure; do not create or edit `plan.md`.
 1. Run `.specify/scripts/powershell/setup-plan.ps1` to materialize `plan.md` and `research.md` if
    they do not already exist, plus canonical application `G-test-plan.md` from its framework
    template when absent.
@@ -55,6 +59,16 @@ $ARGUMENTS
    genuine unresolved choice or risk. Anything already decided in `architecture.md` stays in that
    artifact and is not duplicated here.
 6a. `plan-testing` builds the application Test Plan from approved testing REQ/NFR records,
+   including the Automation Availability Review and Architecture Section 14.3 scenario families
+   and Section 14.4 migration impact-to-test crosswalk.
+   Apply `docs/testing-strategy/automation-review-and-scenario-sizing.md`: keep the plan high-level
+   but show per-test scenario/count bands, verified reusable/uncovered coverage and effort ranges
+   in person-days for review, automation build/adaptation, setup, execution, retest and
+   report/handover. Trace pending Application Team review actions and scope/effort deep-dive.
+   Separate developer/performance-engineer capacity and maintenance from 1/2/3-tester elapsed
+   estimates. Assign activities using the exact LMP test section and Appendix 5, preserving
+   conditional one-sprint enablement and migration-changed unit scope, rather than defaulting
+   whole missing suites to Migration. These inputs supplement the following:
    architecture testability findings, Section 7A controls, Section 12 monitoring/recovery/SDLC
    design, Section 13 temporary test capacity/cost, and `docs/testing-strategy/INDEX.md`. For every
    applicable test type define scope/level, cases, owner, environment, data/access, tooling,
@@ -63,12 +77,56 @@ $ARGUMENTS
    test-repo evidence to establish the actual as-is automation baseline and case-count inventory by
    test type; if the exact count is not proven, record the verified count band or zero-verified
    count and keep the gap as a planning risk instead of assuming the suite exists. Plan automated
-   unit, connectivity and performance/load execution. Integration and smoke/regression/functional
-   execution may be semi-automated only when automated and manual portions, reproducible manual
-   steps, evidence and R-Type-informed Migration/Application Team ownership are explicit. Any
-   automation shortfall is scheduled migration work linked to the readiness risk. Any omission,
-   partial execution or environment deviation requires a human-reviewed
-   Proposed exception ADR and linked risk where applicable.
+   unit, connectivity and performance/load execution. Do not add Integration Testing as a
+   standalone test type. Place integration scenarios in Change-Based Functional Testing when the
+   Migration Team performs refactoring (including within Re-Host/Re-Platform); otherwise include
+   them in mandatory UAT owned and executed by the Application Team. UAT remains mandatory in
+   either branch. Integration and smoke/regression/functional execution may be semi-automated only
+   when automated and manual portions, reproducible manual steps, evidence and R-Type-informed
+   Migration/Application Team ownership are explicit. Any
+   automation shortfall is scheduled work under the strategy-defined ownership split, linked to
+   its readiness risk; it is not automatically a Migration Team build obligation. Apply source
+   Sections 7.2 and 7.3 explicitly: the HA plan includes approved goals, test cases/pass-fail and
+   background load, production-comparable PPE, monitoring/data readiness, an isolated window and
+   entry/exit evidence; the DR plan schedules LSEG Application L2 Production acceptance before
+   customer cutover, Migration Team runbook handover, dependency failure scenarios, RTA/RPA versus
+   RTO/RPO, integrity/functionality, failback/normalization, defect treatment, results and sign-off.
+   PPE/QA DR is rehearsal only. Any omission, partial execution or environment deviation requires a
+   human-reviewed Proposed exception ADR and linked risk where applicable. Invoke
+   `oat-scenario-planning` with the Architecture Section 14.2 applicability matrix and
+   `docs/testing-strategy/LSEG-L2-OAT-Game-Day-Scenario-Catalog.md`; disposition each catalog ID
+   once, write executable OAT cases with Operations ownership, safety/change controls, runbook and
+   evidence, and schedule Production OAT with Application Operations in Cutover per the LMP
+   strategy. Validate all source pipeline/tool examples rather than assuming they remain current.
+   In the canonical Test Plan, estimate elapsed time for every applicable test type, including
+   smoke/regression, functional/UAT, performance, HA, DR, security, penetration and OAT. Provide
+   1-, 2- and 3-active-tester scenarios based on verified case counts, automation/manual split,
+   actual access/tool/environment readiness, and relevant specialist/business/L2 calendars. Distinguish
+   elapsed duration from effort and external approval/change/security booking waits; show confidence,
+   parallel overlaps, serial constraints, critical path and a separate justified contingency. Do
+   not assume unverified automation coverage or scale time linearly by headcount. Use four elapsed
+   calendar weeks as the L2 Production OAT baseline unless current L2 evidence supports revising it.
+   Keep optional pre-OAT lower-environment rehearsal separate from Production OAT and mandatory
+   testing; schedule it only after Migration and Application Teams agree the scenario IDs/count,
+   entry criteria, owner and duration.
+   Require named, dated, evidence-backed approval of this exact Test Plan by Migration Team,
+   Migration Testing Team, Application Team and L2 Operations before marking it Approved. Leave
+   approvals pending until actually recorded; preserve additional Security, business, change and
+   Production authorizations as distinct gates.
+   Complete an evidence-bounded proposed plan while unknowns remain owned in the profile's shared
+   action register. Preserve supplied case IDs, distinguish availability from verified reuse,
+   avoid invented business cases, and reconcile estimates only when their start/end boundaries and
+   included/excluded scope match. Run `validate-test-plan.ps1 -ValidationStage Draft` for a
+   developing plan and `-ValidationStage ReadyForReview` for the approval handoff. Execution/task
+   prerequisites must continue using the default strict validator stage; neither Draft nor review
+   readiness is approval or permission to generate tasks.
+   Lead the canonical Test Plan with the one-page Review Brief from the workflow guidance:
+   proposed scope/exclusions, evidence confidence, quality versus completeness, up to five
+   significant CON conflicts and five dependency-prioritized ACT/AUT human actions, then next
+   gate/exact-version boundary and links to detailed case mappings/supporting tables. Derive
+   summary statuses from canonical rows; do not copy the registers or invent names/dates.
+   Owned Conditional readiness and pending role appointments are allowed for Draft/document
+   review, but ReadyForReview requires the brief and Execution still requires Ready/named approval.
 7. Act as a senior project manager when assembling the delivery schedule. Before scheduling,
    assess every applicable **Discovery & Assessment** and **Planning & Design** User Story and
    every selected child Task separately against its exact Playbook title and relevant evidence.
@@ -154,9 +212,20 @@ $ARGUMENTS
    date and blocked work. Do not treat a repository archive or name as proof of source access.
    Verify every testing REQ/NFR and applicable strategy test type has scheduled preparation,
    execution, remediation/retest, results/evidence retention, and named human approval work.
+   Check that the Test Plan gives evidence-based elapsed estimates for each applicable test at 1,
+   2 and 3 active testers; explains how verified automation and case volume affect estimates;
+   separates external waits; and models parallel work, critical path and contingency. Confirm
+   optional pre-OAT scope/count/timeline was jointly agreed by Migration and Application Teams and
+   that Production OAT still has the four-week L2 baseline unless evidence justifies a change.
+   Confirm all four required organizational Test Plan approvals are present before Approved status.
+12a. Instantiate or re-evaluate `checklists/plan.md` from the controlled baseline
+   `.specify/checklists/plan.md` using the `/speckit.checklist` rules, run
+   `validate-checklists.ps1 -ChecklistPath <absolute path> -Json`, and fill the Phase 2 gate's
+   **Checklist status** line. These are the gate's acceptance tests.
 13. Stop at Phase 2. Do not mark the gate Cleared yourself — require a named human to review the
    Proposed decisions and Identified risks first.
-14. Report what remains pending, including unconfirmed Application Team/LSEG lead times and
+14. Report what remains pending, starting with every open checklist item grouped by evidence
+   owner, including unconfirmed Application Team/LSEG lead times and
    schedule assumptions, and wait for human sign-off before `/tasks` is allowed to run.
 
 Only after a human has updated the Phase 2 gate to Cleared should `/tasks` be run.
diff --git a/.github/prompts/speckit.publish.prompt.md b/.github/prompts/speckit.publish.prompt.md
index aeee9a9..30a1492 100644
--- a/.github/prompts/speckit.publish.prompt.md
+++ b/.github/prompts/speckit.publish.prompt.md
@@ -26,7 +26,10 @@ requirements, architecture, scope, plan, task, implementation-evidence, decision
    implementation evidence that exists.
 3. `publication-readiness` determines each entry's applicability and highest defensible status.
    Missing evidence produces `UNKNOWN` or `HUMAN REVIEW REQUIRED`; it never produces invented
-   content or blocks generation of an explicitly incomplete draft.
+   content or blocks generation of an explicitly incomplete draft. For G-3, distinguish artifact
+   quality from source-input completeness and keep the canonical Test Plan Draft/Ready for
+   Review/Approved state honest; open actions, unavailable assets and conflicts do not suppress a
+   useful draft or imply approval.
 
 ### Phase 2 — Act
 
@@ -34,9 +37,15 @@ requirements, architecture, scope, plan, task, implementation-evidence, decision
    current sources. Replace stale generated narrative, tables, references, and status values.
    Preserve the template's required shape. Do not redesign architecture, change scope, approve an
    ADR/risk, close a risk, or convert a proposed control into implementation evidence.
-5. Keep the canonical `G-test-plan.md` at the feature root; never create a second copy under
-   `deliverables/`. Treat `plan.md` as the source for `M-migration-plan.md`. Keep F-1 CAF eligibility
+5. Keep feature-root `G-test-plan.md` as the sole authoritative test-plan source. Render its full
+   current content to the framework-managed `deliverables/G-test-plan.md` G-3 publication view on
+   every run; do not author or maintain the two files independently. Preserve the root source and
+   its evidence/case/asset/action crosswalk, estimate boundaries, test scope and actual approval
+   state. Treat `plan.md` as the source for `M-migration-plan.md`. Keep F-1 CAF eligibility
    `External` unless a separate governance layer explicitly owns and supplies it.
+   Preserve the root-owned Review Brief before supporting tables when present. Never author a
+   separate publication-only summary; report missing legacy navigation and request a root update
+   followed by republishing. Do not turn unresolved readiness or appointments into approval.
 5a. For C-3, include only billable Azure services and Azure-native observability dependencies.
    Keep Datadog/BigPanda technical and SAD evidence in their owning artifacts, but mark third-party
    commercial charges `Excluded from C-3 - Application Team-owned`; never add them to Azure totals
@@ -62,9 +71,9 @@ requirements, architecture, scope, plan, task, implementation-evidence, decision
    metadata-free content hash. It assigns version 1 on first publication and increments only the
    deliverables whose substantive content changed; unchanged reruns keep the same version.
 9. Run `.specify/scripts/powershell/validate-publication.ps1 -Json`, passing the same subset when
-   scoped. Fix source drift, duplicate
-   Test Plans, missing outputs, broken hashes, non-contiguous history, or unsupported completion
-   status, then rerun finalization and validation.
+   scoped. Fix source drift, missing/stale G-3 published copies, unexpected duplicate publication
+   outputs, missing files, broken hashes, non-contiguous history, or unsupported completion status,
+   then rerun finalization and validation.
 10. Append the publication run and changed deliverable versions to the feature `CHANGELOG.md`.
     Never rewrite prior changelog or manifest history.
 11. Report the run number, changed and unchanged versions, incomplete deliverables, missing evidence,
diff --git a/.github/prompts/speckit.requirements.prompt.md b/.github/prompts/speckit.requirements.prompt.md
index 6d1607b..0446a9a 100644
--- a/.github/prompts/speckit.requirements.prompt.md
+++ b/.github/prompts/speckit.requirements.prompt.md
@@ -423,10 +423,36 @@ can perform by itself.
    and which gaps remain. Framework names alone are not sufficient evidence; missing inventory,
    missing results, or missing approval must remain an explicit readiness gap and linked risk.
    Set automated target requirements for unit, connectivity and performance/load testing.
-   Integration and smoke/regression/functional testing may be semi-automated only when every manual
-   step is reproducible, traceable, evidence-producing and owned through the R-Type-informed RACI.
+   Apply `docs/testing-strategy/automation-review-and-scenario-sizing.md`. Record one Automation
+   Availability Review entry per canonical type. Missing as-is references require Unknown plus an
+   explicit Application Team review action/contact/coordinator/needed-by gate and REQ/NFR/risk
+   trace. Capture dated answers and suite/run/count/pipeline/maintenance evidence; None/Partial
+   are confirmed responses, not scan assumptions. Carry gaps to architecture scenario design.
+   Assign activities from `LMP-Migration-Testing-Strategy.md` Sections 2.2, 4, the test section and
+   Appendix 5; missing automation does not automatically assign whole legacy-suite creation to
+   Migration. Preserve conditional one-sprint enablement and changed-unit implementation limits.
+   Do not model Integration Testing as a separate test type: for Re-Factor, and for Re-Host/
+   Re-Platform when the Migration Team performs refactoring, include integration scenarios in
+   Change-Based Functional Testing; otherwise include them in mandatory UAT owned/executed by the
+   Application Team. UAT remains mandatory in either branch. Integration and smoke/regression/
+   functional testing may be semi-automated only when every manual step is reproducible, traceable,
+   evidence-producing and owned through the R-Type-informed RACI. Keep integration complexity
+   scoring of qualifying external standalone cases separate from the test-type taxonomy.
    Where the as-is estate falls short, scope the remediation to the Migration Team or Application
    Team and link it to the readiness risk rather than assuming the missing automation exists.
+   Populate the testing profile's evidence-source/conflict table, test-asset inventory, and shared
+   Human Input and Decision Register. Treat supplied plans, catalogs, workbooks, repositories and
+   run reports as evidence candidates, not mandatory prerequisites or automatic authority. Record
+   exact locators, versions/dates, scope, authority, access and freshness; preserve conflicting
+   claims with their governing rule, owner action and downstream impact. Keep human business facts
+   unanswered until their evidence is received and validated. Reuse AUT follow-ups rather than
+   duplicating actions, and distinguish artifact quality from evidence completeness. Run
+   `validate-requirements-testing.ps1 -ValidationStage Draft` while requirements are being drafted;
+   Draft validation does not clear the human requirements gate.
+   Use `docs/testing-strategy/LSEG-L2-OAT-Game-Day-Scenario-Catalog.md` as a recommended OAT
+   knowledge baseline when defining the OAT outcome. Do not turn every generic OAT scenario into a
+   universal requirement; application applicability is resolved against as-is evidence and
+   proposed target design during architecture, then executable cases are planned by `plan-testing`.
 9. For anything non-obvious, add a stub row to Section 4 and a matching entry in `decisions.md`
    (status Proposed) or `risks.md` (status Identified) — do not resolve them here.
 10. Initialize Section 5 (Traceability Matrix) with every REQ-###/NFR-### ID from Sections 1-2,
@@ -475,8 +501,13 @@ can perform by itself.
 14. Fix whatever you can fix by going back to Sections 1–5 — do not just log a fixable gap and
     move on. Only genuine open questions needing the app team's or platform team's answer become
     a Decision, Risk, or `UNKNOWN` after this pass.
+14a. Instantiate or re-evaluate `checklists/requirements.md` from the controlled baseline
+    `.specify/checklists/requirements.md` using the `/speckit.checklist` rules, run
+    `validate-checklists.ps1 -ChecklistPath <absolute path> -Json`, and fill the gate's
+    **Checklist status** line. These are the gate's acceptance tests.
 15. Stop at the Requirements Review Gate. Do not mark it Cleared yourself — that is a human action
-    per Constitution Principle III. Tell the user what's pending: any `UNKNOWN` sources, any "Must"
+    per Constitution Principle III. Tell the user what's pending, starting with every open
+   checklist item grouped by evidence owner, then: any `UNKNOWN` sources, any "Must"
    NFR missing a measurable target, any Section 6 finding not yet resolved, any Section 7.2 or 8.3
    Open Point not yet closed, any MEC row that is Unknown or lacks rationale/evidence, and any open
    decisions/risks.
diff --git a/.github/prompts/speckit.specify.prompt.md b/.github/prompts/speckit.specify.prompt.md
index dbfccc6..f8cf0d0 100644
--- a/.github/prompts/speckit.specify.prompt.md
+++ b/.github/prompts/speckit.specify.prompt.md
@@ -13,7 +13,7 @@ $ARGUMENTS
 | `specify-as-is` | Evidence capture and Section 1 (As-Is Summary) |
 | `specify-backlog` | Section 2–4 (R-Type, backlog, backlog delta) |
 | `specify-security` | Section 5 (Security & MEC Alignment copy-forward) |
-| `specify-coverage` | Section 6–8 (Out of Scope / Deferred, decisions/risk stubs, review checkpoint) |
+| `specify-coverage` | Section 6–9 (testing evidence handoff, deferred scope, decisions/risk stubs, review checkpoint) |
 
 ## Process
 
@@ -26,6 +26,9 @@ $ARGUMENTS
    does not already exist.
 3. Read the ready evidence set: `architecture.md` (especially Sections 3, 4, 8 and its gate),
    `requirements.md`, discovery report(s), relevant SAD excerpts, and the backlog playbook CSV.
+   Read `architecture.md` Sections 14.1–14.4 and `requirements/testing-profile.md` when present
+   for the testing handoff. The profile may be unavailable during an initial SPEC pass; the
+   application `G-test-plan.md` is produced during Planning & Design and is not a SPEC prerequisite.
    Reconcile each in-scope `IMP-T###` with its application repository/project, URL or workspace
    location, branch/revision, affected path/module, accountable app-team owner and source-access
    status. Mark anything unverified as `UNKNOWN — needs app team input` and treat it as a question,
@@ -54,7 +57,14 @@ $ARGUMENTS
    the spec backlog. Planning assesses completion from the authoritative coverage artifacts.
 8. `specify-security` copies forward the architecture security table and preserves traceability to
    the requirement IDs; it does not re-run MEC logic independently.
-9. `specify-coverage` handles deferred scope, decision/risk stubs, and the final review checkpoint.
+9. `specify-coverage` assembles Section 6 as a single-row-per-canonical-test-type evidence handoff,
+   then handles deferred scope, decision/risk stubs and the final review checkpoint in Sections 7–9.
+   Preserve exact REQ/NFR and `IMP-*` IDs, architecture `XWALK-###` / `SCN-##` references,
+   supplied-case origin and `AST-###` locators, and shared profile `SRC-###` / `ACT-###` /
+   `AUT-##` references when available. Map only exact selected Section 3 User Story IDs; keep the
+   full backlog baseline. Do not copy the profile action register, invent cases or repository
+   readiness, add a standalone Integration Testing type, write detailed scripts, or treat the
+   planning-stage Test Plan as a prerequisite. Keep unknowns as owned actions/readiness gaps.
 10. Merge the skill outputs into one coherent `spec.md` without dropping citations or traceability.
 
 ### Phase 3 — Review
@@ -66,10 +76,16 @@ $ARGUMENTS
     Proposed/Identified status, not as approved scope.
 13. Update `requirements.md` Section 5 (Traceability Matrix): for every REQ/NFR ID now referenced in
     `spec.md`, fill in its "Spec.md ref" column.
-14. Stop at Section 8 (Review Checkpoint). Do not mark it reviewed or approved yourself — that is a
-    human action per Constitution Principle III. Tell the user what remains pending.
+13a. Instantiate or re-evaluate `checklists/spec.md` from the controlled baseline
+    `.specify/checklists/spec.md` using the `/speckit.checklist` rules, run
+    `validate-checklists.ps1 -ChecklistPath <absolute path> -Json`, and fill Section 9's
+    **Checklist status** line. These are the checkpoint's acceptance tests.
+14. Stop at Section 9 (Review Checkpoint). Do not mark it reviewed or approved yourself — that is a
+    human action per Constitution Principle III. Tell the user what remains pending, starting with
+    every open checklist item grouped by evidence owner.
 
-Do not proceed to `/plan` work in this same pass if Section 8 is unchecked.
+Do not proceed to `/plan` work in this same pass if `checklists/spec.md` has open items or Section 9
+is not signed by a named human.
 
 If `deliverables/manifest.json` exists, report which scope-derived deliverables are stale and
 require `/speckit.publish` to be rerun. Do not update publication versions in the spec pass.
diff --git a/.github/skills/analyze-deliverables/SKILL.md b/.github/skills/analyze-deliverables/SKILL.md
index 597d941..0ecd37b 100644
--- a/.github/skills/analyze-deliverables/SKILL.md
+++ b/.github/skills/analyze-deliverables/SKILL.md
@@ -28,7 +28,7 @@ Build one ledger containing every manifest entry exactly once and use these auth
 | C-3 | `C-cost-profile.md` | Architecture Section 13, plan, Azure pricing evidence, and Azure FinOps evidence |
 | F-1 | `F-caf-eligibility-assessment.md` | External governance evidence; remain External unless separately governed |
 | G-2 | `G-sad-baseline.md` | Requirements, architecture Section 16, SAD contract/coverage map, decisions, risks, and plan |
-| G-3 | Feature-root `G-test-plan.md` | Testing profile, architecture Section 14.1, plan, tasks, evidence, and approvals |
+| G-3 | `deliverables/G-test-plan.md` | Full-fidelity published view of feature-root `G-test-plan.md`; source is reconciled with testing profile, architecture Section 14.1, plan, tasks, evidence, and approvals |
 | G-4 | `G-mec-assessment.md` | MEC evidence, security requirements, architecture Section 7, and spec Section 5 |
 | G-6 | `G-adr-risk-register.md` | Authoritative decision/risk indexes and individual records |
 | G-7 | `complexity-calculator.md` | Architecture Section 8A and signed calculator evidence |
@@ -46,6 +46,10 @@ Build one ledger containing every manifest entry exactly once and use these auth
    basis, shared facts, unresolved markers, evidence, and approval state in the ledger.
 3. Treat Not Applicable and External entries as validation dispositions, not exclusions: require
    an evidence-backed rationale and validate that no conflicting content was published elsewhere.
+4. For G-3, require exactly one authoritative feature-root source and one manifest-tracked
+   `deliverables/G-test-plan.md` publication copy; verify their metadata-free content matches.
+   Missing or stale publication output is a finding; the intended source/view pair is not a
+   duplicate-deliverable defect.
 
 ### Act
 
diff --git a/.github/skills/analyze-testing/SKILL.md b/.github/skills/analyze-testing/SKILL.md
index 749f920..154baf9 100644
--- a/.github/skills/analyze-testing/SKILL.md
+++ b/.github/skills/analyze-testing/SKILL.md
@@ -12,10 +12,13 @@ artifacts during this pass.
 ## Required Inputs
 
 - `requirements/testing-profile.md` and every linked REQ/NFR record.
-- `architecture.md` Section 14.1.
+- `architecture.md` Sections 14.1-14.4, including migration impact-to-test crosswalks.
 - Canonical `G-test-plan.md`, `plan.md`, and `tasks.md`.
 - Linked ADR/risk records and available test evidence/approval metadata.
 - `docs/testing-strategy/INDEX.md`, including normative conflict resolutions.
+- Relevant extracted source sections, including Sections 7.2 (High Availability Testing) and 7.3
+  (Disaster Recovery Testing), plus
+  `docs/testing-strategy/LSEG-L2-OAT-Game-Day-Scenario-Catalog.md`.
 
 ## Plan → Act → Review
 
@@ -23,7 +26,8 @@ artifacts during this pass.
 
 Build one ledger keyed by canonical test type. Carry disposition, REQ/NFR, design section,
 environment, mechanism, Test Plan row, scheduled work, five task tags, evidence, exception/risk,
-and approval through the chain.
+and approval through the chain. Maintain a separate OAT ledger keyed by all 51 LSEG L2 catalog
+scenario IDs; do not collapse scenario dispositions into or double-count them as test types.
 
 ### Act
 
@@ -31,21 +35,82 @@ Check:
 
 1. Every canonical test type occurs exactly once in the profile, architecture matrix, and Test Plan.
 2. Applicable/conditional rows have valid REQ/NFR records and target-design coverage.
-3. Unit testing preserves existing automated suites and limits Migration-Team additions/extensions
+3. No standalone Integration Testing type/row appears in the profile, architecture matrix, Test
+   Plan, RACI, or task taxonomy. Integration scenarios are included in Change-Based Functional
+   Testing when the Migration Team performs refactoring; otherwise they are included in mandatory
+   Application-Team UAT. UAT remains applicable in either branch and scenario counts are not
+   duplicated. The separate Integration Testing Complexity assessment is not a test-type row.
+4. Unit testing preserves existing automated suites and limits Migration-Team additions/extensions
    to migration-changed impacted code.
-4. Data migration testing follows actual data movement; N/A has evidence.
-5. DR Production acceptance is not replaced by PPE/QA rehearsal.
-6. Security testing and penetration testing remain separate.
-7. UAT remains applicable, scheduled, tasked, evidenced, and awaiting named human approval.
-8. Every applicable Test Plan row has PREP, EXEC, REMEDIATE, EVIDENCE and APPROVAL task tags.
-9. Every exception has a reviewed ADR and linked risk; no agent-authored acceptance exists.
-10. Test Plan and test-deliverable approvals have names, dates, and outcomes only when performed.
+5. Data migration testing follows actual data movement; N/A has evidence.
+6. HA includes owner assessment and goals, planned scope/cases and pass-fail criteria, background
+   load, PPE comparability/SII, tooling, monitoring, test data, safe execution window, entry/exit
+   criteria, and signed results.
+7. DR names Production acceptance before customer cutover, L2 execution, Migration Team runbook
+   ownership/handover, plausible failure scenarios including dependency-only failover, entry
+   readiness, RTA/RPA against RTO/RPO, integrity/accuracy/functionality, tested failback, defect
+   disposition, retained results/evidence, and named approval. PPE/QA-only DR is a gap.
+8. Security testing and penetration testing remain separate.
+9. UAT remains applicable, scheduled, tasked, evidenced, and awaiting named human approval.
+10. Every applicable Test Plan row has PREP, EXEC, REMEDIATE, EVIDENCE and APPROVAL task tags.
+11. Every exception has a reviewed ADR and linked risk; no agent-authored acceptance exists.
+12. Test Plan and test-deliverable approvals have names, dates, and outcomes only when performed.
+13. Every LSEG L2 OAT catalog ID appears exactly once in Architecture Section 14.2 and the Test
+    Plan; each Test Plan disposition matches the architecture assessment. Confirm each scenario has
+    separate as-is evidence and proposed-Azure target rationale, maps only evidenced target
+    capabilities, and does not treat unknown inventory or tooling as Not Applicable.
+14. Recommended/conditional OAT cases have measurable operational outcomes, a feasible method,
+    Production/Cutover ownership by Application Operations, runbook/evidence locations, and
+    scheduled preparation, execution, remediation/retest, evidence and approval work. Non-applicable
+    cases have evidence; blockers have an owner and closure path.
+15. Production/DR-disruptive scenarios have explicit approved change authorization, bounded impact,
+    communications, stop conditions and recovery readiness. Unauthorized or unsafe scenarios remain
+    blocked; no planned case is represented as executed or passed without results evidence.
+16. OAT remains operational-readiness assurance and does not substitute for HA, DR, UAT, or any
+    other required test objective.
+17. The estimated elapsed timeline contains each applicable test type, verified case-count and
+    automation/manual basis, and 1/2/3-active-tester estimates; it separates effort, execution
+    duration and external waits, explains confidence and bottlenecks, and reconciles critical path,
+    parallelism and contingency with `plan.md`.
+18. L2 Production OAT retains a four-calendar-week estimate unless current evidence supports a
+    different duration. Optional lower-environment pre-OAT is distinct, marked optional, and has a
+    jointly agreed Migration/Application scenario count and timeline; it does not reduce mandatory
+    OAT scope.
+19. Before Test Plan status is Approved, named, dated approvals for the exact plan version exist
+    from Migration Team, Migration Testing Team, Application Team and L2 Operations. Pending or
+    generic role-only acknowledgement does not count as approval; other required Security,
+    business, change and Production authorizations remain separate.
 
 Run the applicable repository validators and report any mismatch between validator results and
 artifact claims as a Critical finding.
 
+Also apply `docs/testing-strategy/automation-review-and-scenario-sizing.md`: every test type has
+an Automation Availability Review entry, and Unknown/Partial/None has an owned, traced Application
+Team follow-up. Negative/partial answers have dated response evidence; unknown remains unknown.
+Applicable types have Section 14.3 high-level scenario families and Test Plan scope/automation
+person-effort ranges distinct from elapsed time. Check reuse claims, proposed counts, review
+actions and backlog traces reconcile. Validate role assignments against the exact LMP sections
+and Appendix 5, especially one-sprint enablement, changed-unit scope, performance baseline/script
+roles and Application Team maintenance; flag blanket Migration ownership of legacy coverage.
+Check Section 14.4 source/target impact dispositions against actual component/flow evidence,
+data/state movement, dependent behavior, requirement and scenario/case traces, coverage status,
+and owner actions. Verify supplied case identifiers remain unique and separate from family,
+classification and repeated-run counts. Reconcile estimates only when scope boundaries match.
+
 ### Review
 
+Review the opening `Review Brief` before the supporting matrices. Confirm proposed scope/exclusions,
+maturity, evidence confidence, separate quality/completeness and next gate/version boundary are
+honest. Check at most five significant conflicts and five human actions are prioritized by risk
+and dependency, link existing CON/ACT/AUT rows, and preserve their current statuses. Check any
+counts against case/asset evidence; do not equate reported cases with verified reuse. Confirm
+contact/coordinator, needed-by and impact resolve through the canonical register and navigation
+reaches detailed cases, scope, assets, estimate boundaries, crosswalk and approvals.
+Missing legacy Draft navigation is a migration warning; ReadyForReview requires it.
+Do not flag honestly owned Conditional readiness or pending role appointments as failed document
+review merely because they are not Execution-ready. Invalid/unowned dependencies, unsupported
+Verified/Approved/Closed claims and real trace contradictions remain errors at every stage.
+
 Return findings ordered by severity with exact artifact locations, broken trace links, and the
 owning workflow pass for remediation. State clearly when all testing checks pass and identify any
 residual evidence unavailable to the repository.
diff --git a/.github/skills/architecture-testing/SKILL.md b/.github/skills/architecture-testing/SKILL.md
index c105654..a80b879 100644
--- a/.github/skills/architecture-testing/SKILL.md
+++ b/.github/skills/architecture-testing/SKILL.md
@@ -13,12 +13,14 @@ back to the owning layer; it does not independently redesign that layer.
 ## Required Inputs
 
 - `requirements/index.md` and all testing-related REQ/NFR records.
-- Discovery report and current source-code/test-repo evidence showing the actual as-is automation,
-  manual coverage, and case-count inventory by test type. This evidence is mandatory before the
-  architecture can approve a test strategy as automated, semi-automated, or manual; framework
-  discovery alone is not enough to claim production-ready coverage.
+- Available discovery report, application plans/catalogs, source-code/test-repository evidence,
+  and run reports. These are evidence candidates, not mandatory inputs when absent; framework
+  presence alone is not enough to claim production-ready coverage. Track missing sources as owned
+  questions and keep the architecture reviewable without fabricating business facts.
 - Assembled architecture Sections 2–7A and 12–13 plus the provisional Section 8 R-Type.
 - `docs/testing-strategy/INDEX.md` and only the relevant extracted source sections.
+- `docs/testing-strategy/LSEG-L2-OAT-Game-Day-Scenario-Catalog.md` and the OAT-specific
+  `oat-scenario-design` subskill.
 - Applicable MEC, GCF, DevSecOps, resilience, security, data, transition, ADR, pattern, and CPF
   sources already used by the owning architecture layers.
 
@@ -29,8 +31,36 @@ environment, mechanism under test, observability/evidence path, identity/data pr
 approval dependency. Resolve the strategy's conditional test branches from the provisional R-Type
 only after the target design has independently produced that recommendation.
 
+Do not create an independent Integration Testing row. Ensure the functional/UAT design supports
+integration scenarios in Change-Based Functional Testing when the Migration Team performs
+refactoring (including within Re-Host/Re-Platform); otherwise ensure mandatory UAT supports them
+under Application-Team ownership. Preserve UAT in either branch and avoid duplicate cases.
+
 ## Act
 
+Apply `docs/testing-strategy/automation-review-and-scenario-sizing.md` and consume the profile's
+Evidence Sources and Conflicts, Test Asset Inventory, shared Human Input and Decision Register,
+and Automation Availability Review. Populate Sections 14.3 and 14.4 with high-level, application-specific
+scenario families for every applicable/conditional test type, especially None/Partial/Unknown
+automation. Keep pending Application Team questions open while proposing evidence-grounded scope.
+For each family show stable reference, test type, REQ/NFR/component/flow evidence, expected
+outcome, environment/data needs, verified reuse versus proposed adaptation/build/manual scope,
+proposed volume band/derivation/confidence and review-action trace. Define implementation,
+execution and maintenance separately with exact LMP section/RACI references. Migration and
+Application Teams must deep-dive scope and automation effort before baselining.
+Prioritize changed-unit success/boundary/error/mocking families and owner-selected performance
+workloads/baseline/script gaps; preserve Section 4.1's one-sprint enablement limit and Section 6.2's
+impacted-code boundary. Never assign full legacy-suite creation to Migration by default.
+Reference Section 14.2 for OAT details without duplicate counts. Proposals are not executed
+cases, confirmed automation or detailed scripts.
+
+In Section 14.4, reconcile each evidenced source component/store/interface/flow to its exact target
+disposition, data/state movement, changed and dependent unchanged behavior, REQ/NFR, scenario family
+or supplied case, and Covered/Proposed/Excluded/Pending evidence disposition. Include retirement
+dependency and rollback checks; an unknown inventory remains a tracked action, not an invented
+component or case. Carry these local trace IDs and action IDs into the Test Plan rather than
+claiming generic coverage.
+
 Review and route gaps to the owning design:
 
 - Compute/data/integration/networking: installation, connectivity, migration-tool, data migration,
@@ -57,6 +87,14 @@ R-Type-informed ownership split. Route any automation shortfall to the owning ar
 readiness risk and migration scope.
 Tool examples in the strategy are not selected without normal architecture grounding.
 
+Apply the detailed HA/DR controls in strategy Sections 7.2 and 7.3. For HA, show how the target
+design supports the Application Owner's approved goals, zone/process/dependency fault scenarios,
+redundancy and failover, production-comparable PPE, monitoring, and safe isolated execution. For
+DR, show the Production recovery path and failback/normalization, backup readiness, dependency-only
+failover scenarios where the application hosting environment remains in place, and the telemetry
+and access needed for L2 execution. Lower-environment DR is rehearsal, not acceptance. Record any
+material design or environment gap with its owner and governed ADR/risk.
+
 ## Review
 
 Populate architecture Section 14's Migration testability finding and Section 14.1 with exactly one
@@ -68,9 +106,22 @@ row for every canonical testing-profile test type. Each row contains:
 - observability/evidence path plus data/identity/access prerequisites;
 - readiness and Proposed ADR/risk when Conditional or Blocked.
 
+Carry integration scenarios on the Change-Based Functional Testing or UAT row as applicable; do
+not add a separate integration test type or matrix row.
+
 The summary finding records gaps returned to layers, resulting changes, approvals still required,
 and whether planning has enough design evidence to produce the Test Plan.
 
+### OAT scenario design
+
+Invoke `oat-scenario-design` with discovery evidence and the assembled target architecture. Populate
+Architecture Section 14.2 with exactly one disposition per catalog scenario ID. The matrix must
+distinguish current as-is evidence from proposed Azure target evidence, state why each scenario is
+recommended, conditional, not applicable, or blocked, and identify target testability, safety,
+environment, owner, runbook/evidence and governance gaps. Map only selected Azure services and
+verified capabilities. Return design gaps to owning architecture layers; do not claim a scenario
+has been executed or approved.
+
 Re-run affected layer validation after any design change. If a testability gap changes the
 component-change classification, re-evaluate Section 8 rather than preserving the prior R-Type.
 
diff --git a/.github/skills/oat-scenario-design/SKILL.md b/.github/skills/oat-scenario-design/SKILL.md
new file mode 100644
index 0000000..0ee3def
--- /dev/null
+++ b/.github/skills/oat-scenario-design/SKILL.md
@@ -0,0 +1,82 @@
+---
+name: oat-scenario-design
+description: "Select and assess application-specific Operational Acceptance Testing scenarios from the LSEG L2 Game Day catalog against evidenced as-is systems and the proposed Azure architecture. USE FOR: OAT scenario applicability, architecture design, Game Day operational testability. Invoked by architecture-testing. DO NOT USE FOR: inventing ungrounded infrastructure, executing tests, or scheduling the detailed OAT plan."
+argument-hint: "Invoked with the LSEG L2 OAT catalog, discovery evidence, and assembled target architecture"
+---
+
+# Architecture Subskill: OAT Scenario Design
+
+Produce an evidence-based OAT scenario applicability and testability assessment for the
+architecture-testing skill. The LSEG L2 Game Day catalog is a recommended baseline, not a blanket
+requirement that every scenario applies to every application.
+
+## Required inputs
+
+- `docs/testing-strategy/LSEG-L2-OAT-Game-Day-Scenario-Catalog.md`.
+- Discovery report, application inventories, source/configuration, current operational runbooks,
+  pipelines, monitoring, support model, and current OAT evidence where available.
+- Approved requirements, proposed target Azure architecture and component inventory, Sections
+  7A/12/13, Section 14.1, test profile, relevant ADRs/risks, and LMP testing strategy index.
+- Current LSEG change, production safety, access, CloudOps, and operational policies available in
+  the workspace. Treat catalog pipeline links, tool names, statuses, and access groups as
+  time-sensitive until independently confirmed.
+
+## Plan
+
+Inventory actual as-is components, dependencies, critical workflows, deployment and recovery
+mechanisms, monitoring/alerting, operational runbooks, support ownership, and control evidence.
+Separately inventory only the approved/proposed Azure target services and mechanisms. Do not infer
+that an Azure service is selected from an example in the catalog.
+
+## Act
+
+Assess each source scenario ID (`L2-OAT-GD-*`, `L2-OAT-CHG-*`, and `L2-OAT-VAL-*`) and any
+application-specific additions. Assign one evidence-based disposition:
+
+- `Recommended`: evidenced component/control/flow exists and OAT adds operational assurance.
+- `Conditionally applicable`: name the trigger and evidence needed to resolve it.
+- `Not applicable`: provide evidence the component, feature, operational control, or failure mode
+  does not exist in both relevant scope and target.
+- `Blocked`: applicability or safe testability cannot yet be resolved; name owner and gap.
+
+Create a scenario design matrix containing at least:
+
+| Field | Required content |
+| --- | --- |
+| Catalog ID and scenario | Stable source ID, name, and any app-specific scenario ID |
+| Applicability and rationale | Disposition, trigger, as-is evidence, target evidence, and confidence |
+| Current-to-target mapping | Actual as-is component/flow/control and the approved Azure target counterpart |
+| Operational objective | Failure mode, operational behavior, alert/SLO, recovery, or support capability to prove |
+| Testability and guardrails | Mechanism/simulation, prerequisites, telemetry, safe environment, change approval, rollback/stop conditions |
+| Ownership and evidence | Operations execution/approval roles, migration support/remediation, runbook, results, SII/RAID/risk |
+
+Map target scenarios to the target architecture only where evidenced. Consider applicable Azure
+failure and operations surfaces (for example, zone/region behavior, VM/AKS/serverless, databases,
+storage, messaging, identity, monitoring, quotas and deployment pipelines) without assuming a
+service, feature, Chaos Studio experiment, or LSEG pipeline is selected or available. Check the
+current supported fault-injection mechanism and permissions before proposing any disruption.
+
+Ensure the assessment covers all applicable catalog pillars: reliability/resiliency,
+deployment/rollback, monitoring, durability, security, runbook, operational overhead, DML/technical
+debt, and vendor incident management. Add app-specific scenarios for risks the generic catalog
+does not cover.
+
+Distinguish OAT operational evidence from other test objectives. Reuse a technical mechanism where
+appropriate, but do not treat OAT as a substitute for HA, DR, performance, security, penetration,
+functional, connectivity, or mandatory UAT acceptance. Keep scenario identity, objective, owner,
+and evidence distinct; avoid duplicate case counts.
+
+## Review
+
+- Every catalog entry is explicitly dispositioned; unknowns are Blocked or Conditional, not silently
+  omitted or marked Not Applicable.
+- As-is statements cite observable evidence; proposed-target statements trace to approved design.
+- Azure mapping uses only target services/mechanisms present in the architecture and verifies
+  target-specific capabilities rather than relying on generic service assumptions.
+- Production/DR disruption has explicit authorization, scope, impact limits, stop/rollback plan,
+  recovery readiness, alerting, communications, and change window. Unsafe or unauthorized tests
+  remain blocked and do not count as passed.
+- Operations and application owners are accountable for OAT execution/acceptance per current LSEG
+  RACI; the Migration Team supports and remediates assigned migration defects and collates evidence.
+- The output identifies testability gaps and returns design changes to the owning architecture
+  layer; it does not claim scenario execution or approval.
diff --git a/.github/skills/oat-scenario-planning/SKILL.md b/.github/skills/oat-scenario-planning/SKILL.md
new file mode 100644
index 0000000..14c143d
--- /dev/null
+++ b/.github/skills/oat-scenario-planning/SKILL.md
@@ -0,0 +1,107 @@
+---
+name: oat-scenario-planning
+description: "Turn the architecture OAT scenario applicability matrix into safe, executable, evidence-producing Operational Acceptance Test cases and scheduled work. USE FOR: OAT runbook scenarios, Game Day plan, operations acceptance cases, Cutover test preparation. Invoked by plan-testing. DO NOT USE FOR: deciding Azure architecture, executing disruptive tests, or approving production changes."
+argument-hint: "Invoked with the reviewed OAT applicability matrix, approved design, application owners, and cutover controls"
+---
+
+# Planning Subskill: OAT Scenario Planning
+
+Turn the reviewed OAT scenario design into application-specific cases in the canonical
+`G-test-plan.md` Operational Acceptance Test Design section and into preparation, execution,
+evidence, remediation, and approval work in the delivery plan. Do not infer that a scenario passed
+from a proposed plan or source-template status.
+
+## Required inputs
+
+- Reviewed OAT matrix from `oat-scenario-design`, including evidence, applicability, Azure target
+  mappings, blockers, and ownership.
+- `docs/testing-strategy/LSEG-L2-OAT-Game-Day-Scenario-Catalog.md` and
+  `docs/testing-strategy/INDEX.md`.
+- Approved architecture and target service inventory, applicable requirements, runbooks,
+  environment and monitoring design, change/production policy, cutover schedule, and RACI.
+- Named operational and application owners, approved test-data/access prerequisites, repositories,
+  current pipeline/tool validation, defect/SII/RAID process, and evidence-retention location.
+
+## Plan
+
+Carry forward every scenario disposition and stable catalog ID. Reconcile scenario IDs with existing
+OAT cases, HA/DR cases, implementation tasks, defects and evidence. Do not double-count the same
+case; preserve distinct objectives and acceptance for each test type.
+
+## Act
+
+For each Recommended or resolved Conditional scenario, define:
+
+1. Scenario ID, source pillar, application-specific title, operational objective, affected service
+   and critical user/service flow.
+2. As-is baseline and approved Azure target mapping, including what differs and which target
+   mechanism is actually available.
+3. Preconditions and health baseline: deployed version/IaC revision, dependencies, test identities,
+   data, telemetry, support participants, on-call/escalation, backup/recovery readiness, and
+   runbook links.
+4. Test environment (Production or DR only with explicit approval; otherwise approved production-
+   like environment), normal/pre-authorized/change classification, change owner/reference, approved
+   window, impact boundary, communications, stop conditions, rollback/recovery plan, and clean-up.
+5. Reproducible steps or approved pipeline/job; expected results and measurable pass/fail criteria;
+   actual result; telemetry, logs, screenshots, links and timestamps; status (`Not Started`,
+   `In Progress`, `Passed`, `Failed`, `Inconclusive`, or evidence-backed `Not Applicable`).
+6. Responsible executor, accountable Application Operations/Application Owner, consulted Migration
+   Team and other roles, defect/remediation owner, approver, evidence repository, and dependency.
+7. Preparation, execution, issue resolution/retest, evidence publication and sign-off task with
+   phase, estimated elapsed duration, dates when known, dependencies, capacity/automation
+   assumptions and risk/SII/RAID trace.
+
+Keep separate subsections or labels for:
+
+- Game Day/reliability/monitoring/durability scenarios.
+- Standard-change scenarios requiring normal change approval and lead time.
+- Validation-only scenarios that do not inherently change a system.
+
+Use the source's Azure examples only as candidate references. Validate current resource support,
+tooling, access, policy and job availability. Do not assume a chaos experiment, LSEG CI template,
+Azure service health integration, Datadog monitor, or restore workflow exists or is approved.
+
+Per the LMP Testing Strategy, OAT is carried out by the Application Operations Team during Cutover
+in Production. Reconcile this baseline with the Game Day catalog's environment recommendations,
+normal/pre-authorized changes, and application-specific safety approvals. Do not silently move
+mandatory production acceptance to a lower environment; if blocked, record the governance decision
+and readiness gap. The Migration Team supports execution, collates results/evidence, and fixes
+assigned migration issues per the applicable RACI. Do not assign LSEG operational sign-off to the
+Migration Team.
+
+Plan elapsed time separately from tester effort. Use four calendar weeks as the Application
+Operations/L2 Production OAT baseline unless current L2 evidence supports a different duration;
+include case preparation, agreed execution windows, reporting and review in the estimate, and
+record any external booking/change-approval wait separately. Do not shorten this baseline by
+assuming additional testers. Estimate 1/2/3-active-tester scenarios for other test streams from
+verified case counts and automation/manual split, and preserve Production safety, scarce specialists
+and shared-environment constraints.
+
+If proposing a lower-environment **Pre-OAT rehearsal**, mark it optional and separate from the
+mandatory Production/Cutover OAT. Schedule it only after Migration and Application Teams jointly
+agree scenario IDs/count, environment, readiness criteria, owner and duration. It must not replace
+or waive Production OAT, HA, DR, UAT or another required test.
+
+Before the Test Plan is Approved, collect named, dated, evidence-backed approval for the same plan
+version from Migration Team, Migration Testing Team, Application Team and L2 Operations. Their
+review does not grant the separate Security, change, business or Production authorization needed
+for specific execution.
+
+## Review
+
+- All scenarios have exactly one explicit applicability/status and link back to their source IDs.
+- Applicable scenarios have concrete steps, testable expectations, safe environment and change
+  authorization, support/runbook, evidence, RACI and recovery/stop conditions.
+- Non-applicability is supported by evidence; unknown target capability or source access remains an
+  owned blocker.
+- Game Day does not substitute for HA/DR or other independent testing and does not waive UAT.
+- Statuses and results reflect actual execution evidence; no scenario is marked Passed from design
+  alone.
+- Every required OAT activity is scheduled in the appropriate Testing, Pre-Cutover or Cutover
+  phase, respecting Production OAT timing, LSEG operational ownership, named approval and
+  dependencies.
+- The L2 Production OAT estimate uses the four-calendar-week baseline or an evidenced alternative;
+  optional lower-environment pre-OAT is jointly scoped and separately scheduled without substituting
+  for mandatory Production OAT.
+- OAT elapsed duration, tester capacity, automation coverage and external scheduling waits are
+  explicit and consistent with the integrated Test Plan timeline.
diff --git a/.github/skills/plan-testing/SKILL.md b/.github/skills/plan-testing/SKILL.md
index d3699f1..5775db8 100644
--- a/.github/skills/plan-testing/SKILL.md
+++ b/.github/skills/plan-testing/SKILL.md
@@ -6,8 +6,10 @@ argument-hint: "Invoked by /speckit.plan with approved requirements, architectur
 
 # Planning Domain: Application Test Plan
 
-Owns the canonical application `G-test-plan.md` deliverable. `plan.md` contains only its handoff,
-schedule, dependencies and critical-path integration; it must not duplicate the per-test matrix.
+Owns the canonical feature-root application source `G-test-plan.md`. `/speckit.publish` publishes
+its full-fidelity, versioned view as `deliverables/G-test-plan.md`; the view is generated from the
+root source and is never edited independently. `plan.md` contains only its handoff, schedule,
+dependencies and critical-path integration; it must not duplicate the per-test matrix.
 The skill translates approved obligations and design into executable work without relaxing
 requirements or redesigning the target.
 
@@ -18,26 +20,65 @@ requirements or redesigning the target.
   Section 12 monitoring/recovery/SDLC design, Section 13 test capacity/cost rows, and approved R-Type.
 - Existing app test assets, baselines, environments, data, tools, owners, approvers, windows, and
   evidence repository details.
-- `docs/testing-strategy/INDEX.md` plus relevant source sections and `G-test-plan.md`.
+- `docs/testing-strategy/INDEX.md`, source Sections 7.2 (High Availability Testing) and 7.3
+  (Disaster Recovery Testing), other relevant source sections, and `G-test-plan.md`.
+- The reviewed Architecture Section 14.2 OAT matrix, `docs/testing-strategy/LSEG-L2-OAT-Game-Day-Scenario-Catalog.md`,
+  and the `oat-scenario-planning` subskill.
+- Evidence-backed test case counts, automation/manual coverage, available Migration/Migration
+  Testing/Application/L2 capacity, working calendar, specialist availability, test windows and
+  expected external approval/change lead times. If any are unavailable, mark the estimate Low
+  confidence and record the assumption/owner rather than silently filling the gap.
 
 ## Plan
 
 Resolve every applicable test type into scope, level/coverage, cases/scenarios, owner, environment,
 data/access, tooling/automation, entry criteria, exit criteria, acceptance criteria, evidence,
-approval, dependencies, duration/window, and predecessor/gate. Unknowns remain explicit planning
-dependencies with owner, lead-time assumption, contingency, and linked ADR/risk.
+approval, estimated elapsed duration/window, and predecessor/gate. Estimate each applicable test
+stream for 1, 2 and 3 active testers, based on observed/proposed automation coverage, case counts,
+case complexity, specialist bottlenecks, and operational/customer availability. Separate elapsed
+time from person-effort and separate external wait/approval time from execution. Unknowns remain
+explicit planning dependencies with owner, lead-time assumption, contingency, and linked ADR/risk.
+Do not assume that adding testers reduces elapsed time linearly or that unverified automation
+coverage exists.
 
 Use automated execution as the target for unit, connectivity and performance/load testing.
-Integration and smoke/regression/functional testing may be semi-automated; identify the automated
-and manual portions separately, keep all manual cases reproducible and evidence-producing, and
-assign implementation/execution/maintenance to the Migration Team or Application Team using the
-approved R-Type-informed RACI. Any gap from the target automation model is scheduled migration work
-and remains linked to its readiness risk until evidence proves closure.
+Integration is scenario scope, not a standalone test type. Put integration cases in
+Change-Based Functional Testing when the Migration Team performs refactoring, including refactoring
+within Re-Host/Re-Platform. Otherwise include them in mandatory UAT, owned and executed by the
+Application Team. Preserve UAT in either branch and avoid duplicate scenario counts. Integration
+and smoke/regression/functional testing may be semi-automated; identify automated and manual
+portions separately, keep manual cases reproducible and evidence-producing, and assign
+implementation/execution/maintenance using the approved R-Type-informed RACI. Any automation gap is
+scheduled migration work linked to its readiness risk until evidence proves closure.
 
 ## Act
 
+Apply `docs/testing-strategy/automation-review-and-scenario-sizing.md`. Consume the per-test
+Application Team automation-review ledger, shared human-input actions, asset availability/reuse
+inventory, and Architecture Sections 14.3-14.4. Preserve source case IDs and trace migration
+impacts to covered/proposed/excluded/pending test scope. Keep the Test Plan
+high-level but populate Scenario Scope and Automation Effort for every applicable test type:
+family/count bands, verified reusable and uncovered scope, reuse/adapt/build/manual decisions,
+person-day effort ranges for deep-dive review, automation, setup, execution, defect/retest,
+reporting/handover, maintenance capacity, assumptions/confidence and backlog traces.
+Separate automation development from test execution and the 1/2/3-tester elapsed estimates;
+developers/performance engineers are not assumed to be supplied by tester capacity.
+Schedule unanswered Application Team reviews and jointly review scope/effort before baselining.
+Use the LMP strategy's exact test section and Appendix 5 for implementation/execution/maintenance
+roles; preserve conditional one-sprint automation enablement, migration-changed unit scope and
+Application Team ongoing coverage/maintenance. For performance separately size LSEG baseline
+provision, Migration baseline validation, script reuse/adaptation/build and owner-approved workload
+execution. Never treat a missing suite as a blanket Migration Team build obligation.
+
 Populate `G-test-plan.md` with:
 
+0. a one-page `Review Brief` after metadata: proposed scope/exclusions and maturity, evidence
+   basis/confidence, artifact quality separately from input completeness, and next gate/exact-version
+   boundary. Rank at most five significant CON conflicts and five ACT/AUT human actions by
+   material risk/dependency, linking their canonical rows and exact status rather than duplicating
+   registers. Surface decision/contact/coordinator/needed-by/impact via those links; use
+   `None — reason` for empty lists. Link scope, case mappings, assets, estimate boundaries,
+   architecture crosswalk, full registers and approvals. Do not open with the whole case catalog;
 1. objectives, scope, exclusions, approved R-Type, and requirement traces;
 2. one row per strategy test type, including conditional branches and approved exceptions;
 3. test case/version/requirement/defect traceability and automation ownership;
@@ -49,6 +90,90 @@ Populate `G-test-plan.md` with:
 9. delays, dependencies, escalation, exception decisions, risks, SIIs where externally required;
 10. scheduled preparation/execution/remediation/reporting/approval work in authoritative backlog
     phases, with explicit capacity scale-up/down and temporary cost where applicable.
+11. an estimated elapsed testing timeline covering each applicable test type, one/two/three-tester
+    capacity scenarios, verified case count and automation/manual split, duration confidence,
+    dependencies, environment/production windows, parallelism, external waits, critical path and a
+    separately explained contingency reserve.
+
+### Elapsed-time, capacity and pre-OAT planning
+
+Populate `Estimated Elapsed Testing Timeline and Capacity` with evidence-based ranges from scope
+confirmation and entry readiness through preparation/automation adaptation, execution, expected
+defect/retest allowance, reporting and review. Explicitly state what is excluded (for example,
+security booking, Production/change approval, access provisioning or customer response lead time).
+Use the current case-count and automation evidence; a framework or test file is not proven reusable
+automation until its scope, run result and owner are verified. Where counts or automation are
+unknown, make a conservative, Low-confidence estimate and schedule validation/pilot work to
+re-estimate.
+
+Show estimates for 1, 2 and 3 active testers and separately identify L2 Operations, Security,
+Application SMEs and business-user capacity. Do not scale durations linearly; preserve serial
+dependencies, production windows, scarce specialists, shared environments, data restore/refresh and
+approval gates. `plan.md` derives an integrated calendar from dependencies and overlaps rather than
+summing test rows. Record dates only when a start date/calendar is evidenced; otherwise use relative
+weeks, duration range, owner and needed-by assumption. Reserve explicit contingency for identified
+uncertainty instead of burying it in test effort.
+
+Use a four-calendar-week elapsed baseline for Application Operations/L2 Production OAT unless
+current L2 evidence supports a different estimate. Do not compress this based only on assigning
+more testers. Keep an optional **Pre-OAT lower-environment rehearsal** as a separate work item from
+mandatory Production/Cutover OAT. Schedule it only after Migration and Application Teams jointly
+agree scenario IDs/count, entry criteria, owner, lower environment, automation/manual split and
+timeline. It does not replace or waive Production OAT, HA, DR or UAT.
+
+The completed Test Plan requires recorded approvals from the Migration Team, Migration Testing
+Team, Application Team and L2 Operations before its overall status becomes Approved or execution
+baseline. Capture named reviewer, decision date, outcome and evidence for each; keep every approval
+Pending until actually given. Additional Security, business, change and Production authorizations
+remain independent gates.
+
+Complete an evidence-bounded proposal even when human inputs remain open. Keep exact questions,
+expected evidence/location, contact/coordinator, needed-by gate, trace links, blocking impact,
+status and actual answer in the shared register; do not infer answers or duplicate AUT actions.
+Supplied test assets and cases are not reusable/verified solely because a link, catalog or
+framework exists. Use proposed case outlines only when source behavior supports them; otherwise
+retain the owned action instead of inventing application cases. Reconcile estimates by start/end
+boundary, included/excluded phases and external waits before comparing durations; preserve scope
+differences rather than forcing estimates to match.
+
+Validate an evolving source with `validate-test-plan.ps1 -ValidationStage Draft`, then
+`-ValidationStage ReadyForReview` when preparing the human review handoff. Neither stage approves
+the plan or clears execution gates. Existing task-generation and prerequisite callers retain the
+default strict `Execution` stage, which requires Approved status and existing organizational
+approvals; never pass a looser stage to bypass that gate.
+Draft/ReadyForReview may retain Conditional/Blocked architecture readiness and pending approver
+roles only with relevant owned actions, ADR/risk trace, contact/coordinator and needed-by gate.
+Human names and Ready environments are Execution prerequisites, not document-review prerequisites.
+ReadyForReview requires the linked Review Brief; missing legacy Draft navigation is a warning.
+
+### OAT scenarios
+
+Invoke `oat-scenario-planning` with the reviewed Section 14.2 matrix. In `G-test-plan.md`'s
+Operational Acceptance Test Design, disposition every catalog ID once and convert recommended
+scenarios into reproducible cases with measurable outcomes, approved environment/change class,
+Production safety controls, operations RACI, runbook, telemetry, evidence, remediation and
+approval. Use source pipeline/tool examples only after validating current availability and approval.
+Schedule OAT with Application Operations in Production during Cutover per the LMP strategy; any
+production/DR disruption additionally requires explicit change authority, impact boundaries,
+communications, stop conditions and recovery readiness. Keep OAT distinct from HA/DR/UAT acceptance.
+
+For High Availability, the Test Plan must include the Application Owner's R-Type-informed
+assessment; approved availability/SLA, RTO/RPO, redundancy/failover, scalability, and resource
+utilization goals; test scope/types and cases; pass/fail criteria; background load; tooling;
+production-comparable PPE; any approved SII for a material environment difference; monitoring;
+prepared test data; an isolated PPE execution window; and signed entry/exit criteria. The Migration
+Team prepares and conducts the HA tests, with the Application Team providing guidance/support and
+the named approver signing the results.
+
+For Disaster Recovery, the plan must identify Production as the acceptance environment and schedule
+the LSEG Application L2 Team's execution before customer cutover; lower-environment runs are
+rehearsals only. Define the Migration Team-owned DR runbook creation and handover to L2, LSEG DR
+Coordinator and Technology Owner, all plausible failure scenarios (including dependency failover while the
+application/cloud hosting environment remains in place), Production entry prerequisites, recovery
+tools/data/backup readiness, and standard approval. Exit criteria must measure RTA against RTO and
+RPA against RPO, validate data integrity/accuracy and critical functionality, test failback and
+normalization, resolve/retest defects or record authorized LSEG risk acceptance, and retain the
+results report, technical/process learnings, and evidence in the approved repository.
 
 Update `plan.md`'s Application Test Plan Handoff with the canonical path, status, requirement and
 architecture sources, schedule integration, exception/risk links, and approval state.
@@ -60,12 +185,25 @@ human decision; the plan cannot approve its own exception or risk acceptance.
 
 - Every testing REQ/NFR appears in at least one test row and evidence output.
 - Every applicable strategy test type has a complete execution and approval path.
+- No standalone Integration Testing row exists; scenarios follow the Migration-Team-refactoring
+  versus Application-Team-UAT split, and UAT remains mandatory.
 - Unit, connectivity and performance/load plans are automated; permitted semi-automated integration
   and smoke/regression/functional plans identify their automated/manual split and RACI ownership.
 - Environment placement follows the approved design; any deviation is governed before execution.
 - Production-only DR, penetration, and OAT constraints are explicit and scheduled safely.
+- HA includes all Section 7.2 goals, prerequisites, isolated PPE execution, and exit evidence; DR
+  includes Section 7.3 Production acceptance, L2/runbook ownership, dependency scenarios,
+  RTA/RPA, failback, defects, evidence and approval.
 - Test work appears in the delivery schedule, critical path, dependency register, cost/capacity
   events, and later task handoff.
+- Estimated elapsed timeline covers every applicable test and 1/2/3-tester scenarios, is adjusted
+  for verified automation and case volume, separates execution from external waits, demonstrates
+  realistic overlaps/serial bottlenecks, and carries a justified contingency reserve.
+- Production OAT retains its four-calendar-week L2 baseline unless evidenced otherwise. Optional
+  lower-environment pre-OAT has an explicit scenario-count/timing agreement by Migration and
+  Application Teams and never substitutes for mandatory Production OAT.
+- Migration Team, Migration Testing Team, Application Team and L2 Operations approvals are all
+  recorded for the same Test Plan version before it is marked Approved.
 - Named human approval remains outstanding; successful execution alone does not clear the gate.
 - When G-3 has publication metadata, Test Plan content changes require `/speckit.publish`; its
   version increments only after rendering/finalization, and approval is bound to that exact version.
diff --git a/.github/skills/publication-readiness/SKILL.md b/.github/skills/publication-readiness/SKILL.md
index 7810bb6..eb1546d 100644
--- a/.github/skills/publication-readiness/SKILL.md
+++ b/.github/skills/publication-readiness/SKILL.md
@@ -12,6 +12,8 @@ Owns the evidence and applicability decision for every publication-manifest entr
 
 - Authoritative requirement, decision, and risk indexes and records.
 - Current architecture, spec, plan, tasks, Test Plan, evidence, and approvals when present.
+- The Test Plan's validation stage and input-completeness summary when available, including
+  unresolved human actions, unavailable assets, and source conflicts.
 - `deliverables/manifest.json` and all framework deliverable templates.
 - For G-7, every supplied application Complexity Calculator workbook and supporting sheet, plus
   its path, declared version, supplied/modified date and author/reviewer metadata when available.
@@ -32,19 +34,31 @@ Owns the evidence and applicability decision for every publication-manifest entr
 - Set `Applicable`, `Not Applicable`, `Pending`, or `External` with evidence-based notes.
 - Set only a defensible status. Missing inputs remain explicit and do not prevent an incomplete
   draft from being generated.
-- Keep F-1 External unless separately governed. Keep G-3 canonical at the feature root.
+- Keep F-1 External unless separately governed. For G-3, require the canonical feature-root
+  `G-test-plan.md` as source and publish its view at `deliverables/G-test-plan.md`; mark it In
+  Progress when the source is Draft, readiness validation fails, or named approval is pending.
+  Keep known scope, proposed content, unresolved questions, source conflicts, and evidence
+  completeness distinct in the published artifact/status notes. Do not treat publication as
+  approval or implementation evidence, and do not suppress a useful draft because inputs remain
+  unavailable.
+  Check the source-owned Review Brief against canonical conflicts/actions, scope and version
+  boundary when present. Report missing legacy Draft navigation as a warning and route authoring
+  back to `plan-testing`; never invent the brief or suppress the full draft. Owned Conditional
+  readiness and pending appointments do not imply execution approval or failed document review.
 - For G-7, compare each supplied workbook's actual factor names, weights, guidelines, thresholds/
   formulas and final bands with the framework V4.1 baseline. A filename alone does not establish
   version. Missing governing-version approval or material rule drift keeps G-7 In Progress and the
   affected factors `HUMAN REVIEW REQUIRED`; do not silently select or combine versions.
 - Keep G-7 In Progress when the required complexity checklist is missing, invalid or has unchecked
-  items. Reconcile checklist counts with architecture Section 8A.Q.
+  items, including its Post-Gate Items: run `validate-checklists.ps1 -RequireComplete
+  -IncludePostGate`. Reconcile checklist counts with architecture Section 8A.Q.
 - Keep G-4 In Progress when any independent row lacks evidence/rationale, owner, governance trace,
   target maturity or closure path, or when required implementation evidence is missing. Absence of
   a completed human workbook is not a gap. When one is supplied, unconsumed rows or unresolved
   comparison findings keep G-4 In Progress; workbook metadata alone is not approval evidence.
 - Keep G-4 In Progress when the MEC checklist is missing, invalid, its Section 7.4.1 counts are
-  stale, or any required item is unchecked.
+  stale, or any required item is unchecked, including its Post-Gate Items (`validate-checklists.ps1
+  -RequireComplete -IncludePostGate`).
 
 ### Review
 
diff --git a/.github/skills/publication-rendering/SKILL.md b/.github/skills/publication-rendering/SKILL.md
index 5602aa9..0e8a3ea 100644
--- a/.github/skills/publication-rendering/SKILL.md
+++ b/.github/skills/publication-rendering/SKILL.md
@@ -15,7 +15,7 @@ Owns regeneration of applicable framework-managed Markdown deliverables.
 | C-2 | Requirements, architecture, plan, and commercial/license evidence |
 | C-3 | Architecture Section 13, plan, Azure Pricing Calculator exports, and Azure FinOps evidence. Exclude Datadog/BigPanda commercial charges; retain only Azure-native observability resources in totals |
 | G-2 | Requirements, architecture Section 16, decisions, risks, and plan |
-| G-3 | Canonical feature-root `G-test-plan.md`; never duplicated |
+| G-3 | Full-fidelity published copy at `deliverables/G-test-plan.md`, sourced only from canonical feature-root `G-test-plan.md` |
 | G-4 | MEC evidence, security requirements, architecture Section 7, and spec Section 5 |
 | G-6 | Individual ADR/risk records and their indexes |
 | G-7 | Architecture Section 8A and signed calculator evidence |
@@ -39,6 +39,20 @@ Owns regeneration of applicable framework-managed Markdown deliverables.
 	Log Analytics, managed Prometheus, diagnostic storage, networking and egress remain priceable.
 - Use `UNKNOWN` or `HUMAN REVIEW REQUIRED` with the missing source and owner instead of guessing.
 - Keep links and trace IDs resolvable to current records.
+- For G-3, copy the complete canonical feature-root `G-test-plan.md` into
+	`deliverables/G-test-plan.md` on every publication run. Preserve all tables, evidence gaps,
+	status and approvals exactly; do not summarize, approve, or independently edit the published
+	copy. The publication metadata block is added by finalization, not copied as source content.
+  Preserve evidence provenance/conflicts, shared human-input actions, asset availability versus
+  reuse health, migration impact crosswalk traces, case outlines, estimate boundaries, validation
+  stage and actual approval state. Never turn Proposed/Pending content into an approved case or
+  complete execution baseline.
+  Preserve the source-owned opening Review Brief and detailed supporting tables in order.
+  Do not generate a new summary solely in the publication view; if the root lacks one, publish
+  faithfully and request a root update. Keep canonical profile/crosswalk links navigable from
+  both locations using root-authored repository-root-scoped or controlled source URLs; publication
+  does not rewrite the source body. Route broken links to the root author rather than modifying
+  only the copy. Do not replace authoritative rows with copied summary ledgers.
 - For G-4, render all 30 MEC controls from the independent requirements assessment: Type, Theme,
   criterion, standard applicability, independent applicability/current state, evidence/rationale/
   confidence, target control/maturity, required/actual evidence, remediation owner/date and traces.
diff --git a/.github/skills/requirements-coverage/SKILL.md b/.github/skills/requirements-coverage/SKILL.md
index e71f8c0..a149a27 100644
--- a/.github/skills/requirements-coverage/SKILL.md
+++ b/.github/skills/requirements-coverage/SKILL.md
@@ -97,7 +97,8 @@ Populate:
 - Section 6 (Self-Review Findings)
 - Section 7 (Backlog Playbook Coverage Check)
 - Section 8 (SAD & Deliverables Template Coverage Check)
-- The Requirements Review Gate checklist, with clear unresolved items listed as open points
+- `checklists/requirements.md` (the Requirements Review Gate checklist, from the controlled
+  `.specify/checklists/requirements.md` baseline), with every open item naming its gap and owner
 
 Every Partial/No row in Sections 7 or 8 must have a linked decision or risk entry in the draft log.
 
@@ -112,8 +113,8 @@ Every Partial/No row in Sections 7 or 8 must have a linked decision or risk entr
   units and thresholds where applicable.
 - Every requirement ID appears in traceability, or it is explicitly logged as a gap.
 - No “No/Partial” backlog or deliverable row is left without a named next action.
-- The gate checklist is honest: unresolved `UNKNOWN` and external inputs are named as pending human
-  or platform action, not silently hidden.
+- The gate checklist is honest: no item is checked without cited evidence, and unresolved
+  `UNKNOWN` and external inputs are named as pending human or platform action, not silently hidden.
 - Every Section 2A topic has one disposition; Applicable topics link REQ/NFR records, and Unknown
   topics name an evidence owner and linked ADR/risk where blocking.
 - The requirements set states no application R-Type recommendation; its matrix contains only
diff --git a/.github/skills/requirements-testing/SKILL.md b/.github/skills/requirements-testing/SKILL.md
index 2c34cb7..02f4941 100644
--- a/.github/skills/requirements-testing/SKILL.md
+++ b/.github/skills/requirements-testing/SKILL.md
@@ -24,6 +24,9 @@ sections of the extracted strategy.
   coverage, maintenance state, or case-count reality.
 - Existing test strategy/plans/cases/scripts/results, automation repositories, baselines,
   environments, data, tools, defect history, and named test/approval owners.
+- Any supplied application test plans, catalogs, linked repositories/workbooks, run reports, and
+  source-code or test inventory, even when their completeness or authority is uncertain. These are
+  evidence candidates, not mandatory prerequisites; proceed with available evidence and track gaps.
 - Approved or proposed functional, performance, availability, RTO/RPO, security, data-quality,
   operability, cutover, rollback, and acceptance targets.
 - `docs/testing-strategy/INDEX.md`, `docs/mec-reference.md`, `docs/gcf-reference.md`, and applicable
@@ -50,14 +53,43 @@ tools, or owners are missing. Those are readiness gaps.
 Record every disposition, condition, REQ/NFR link, environment assumption, evidence, execution and
 approval owner, and ADR/risk in `requirements/testing-profile.md`.
 
+Use the profile's Evidence Sources and Conflicts, Test Asset Inventory, and shared Human Input and
+Decision Register. Capture source identity/version/date/locator, authority, access, applicability
+and freshness; preserve competing claims with their governing rule and downstream impact. Reuse an
+AUT follow-up as its action rather than duplicating it. An answer becomes usable only when its
+evidence is validated; do not create an ADR for every unanswered fact.
+
+Keep integration testing as scenario scope within the canonical functional/UAT rows, never as a
+separate test-type row. For Re-Factor, and for Re-Host/Re-Platform when the Migration Team performs
+refactoring, include component interaction scenarios in Change-Based Functional Testing. Otherwise,
+include integration scenarios in mandatory UAT owned/executed by the Application Team. UAT remains
+mandatory in either branch; avoid duplicate scenario counts. Keep the separate Integration Testing
+Complexity assessment for qualifying external standalone business/negative-path cases distinct from
+this test-type classification.
+
 ## Act
 
-Before any test classification is finalized, require an explicit as-is automation audit grounded in
-the discovery report and source-code evidence. The audit must identify which test types have real
-automation today, which are only partially automated or manual, which frameworks prove coverage,
-and what the current evidence base says about case counts, ownership, execution history, and
-approval status. A repository scan that finds JUnit/Jest/pytest/unittest files is only a starting
-signal; it does not establish executable suite health, business coverage, or a trusted count.
+Apply `docs/testing-strategy/automation-review-and-scenario-sizing.md`. Populate the template's
+Automation Availability Review with one entry per canonical test type. When as-is evidence is
+missing or inaccessible, record Unknown and an explicit Application Team review action with
+coordinating owner, needed-by gate/date and requirement/risk trace. Do not treat an unavailable
+reference plan or repository as a generation failure, or infer business behavior, coverage, or
+approval from its absence. Request repositories, covered/uncovered scenarios,
+verified counts, run results, pipeline/data/baseline readiness and maintenance capacity. Capture a
+dated answer and evidence; None or Partial must not be inferred from a repository scan.
+Carry unresolved, absent and partial coverage into architecture scenario design and planning.
+Assign review, implementation, execution and maintenance separately using
+`LMP-Migration-Testing-Strategy.md` Sections 2.2, 4, the test-specific section and Appendix 5.
+Do not automatically transfer whole legacy-suite creation to Migration. Section 4.1 enablement
+is conditional on MEC/maintenance capacity and limited to one sprint; unit additions remain
+limited to migration-changed impacted code.
+
+Before making an automation claim, assess available discovery and source-code evidence. Record
+which test types have verified automation, partial evidence, or remain Unknown, along with known
+case counts, ownership, execution history, and approval state. A repository scan that finds
+framework files is only a starting signal; it does not establish executable suite health, business
+coverage, or a trusted count. Missing evidence stays owned and visible; it does not prevent a
+reviewable requirements draft.
 
 Document this analysis in `requirements/testing-profile.md` and any related risk/ADR entries when
 the evidence is absent or incomplete. Missing as-is evidence must become an explicit readiness gap,
@@ -66,9 +98,13 @@ not a silent acceptance of automation or a guessed case count.
 Apply the framework automation interpretation: Unit, connectivity, and performance/load testing
 have an automated target. Integration and smoke/regression/functional testing may be
 semi-automated, but every manual step must be versioned, reproducible, traceable, evidence-producing,
-and assigned to the Migration Team or Application Team through the R-Type-informed RACI. When the
-as-is estate does not meet that target, create or update the readiness risk and make remediation an
-explicit migration-scope obligation; do not treat missing automation as business-as-usual evidence.
+and assigned to the Migration Team or Application Team through the R-Type-informed RACI. Proposed
+remediation is evidence-bounded and ownership-reviewed; do not silently expand migration scope or
+convert unknown automation into an asserted gap count.
+
+Validate the evolving profile with `validate-requirements-testing.ps1 -ValidationStage Draft`.
+Draft validation reports input completeness separately from structural quality and does not
+represent formal readiness or approval.
 
 Create or update ordinary records:
 
@@ -92,7 +128,11 @@ Cover at minimum:
 2. Conditional change-based or full functional testing based on the eventual R-Type.
 3. Performance baseline validity/reproducibility, equal-volumetric comparison, NFR targets, and
    tolerable variance.
-4. HA, DR, security/penetration, OAT, and mandatory UAT outcomes.
+4. HA, DR, security/penetration, OAT, and mandatory UAT outcomes. For HA, use strategy Section
+   7.2 to define measurable goals for uptime/SLA, RTO/RPO, redundancy/failover, scalability, and
+   resource utilization; keep the exact application thresholds sourced and owner-approved. For
+   DR, use Section 7.3 to require Production acceptance, recovery/normalization outcomes, and
+   accountable Application L2 execution before customer cutover.
 5. Test environment comparability, monitoring, identities/access, representative/versioned test
    data, privacy controls, and test asset ownership.
 6. Entry, exit, and final acceptance criteria; defect severity/priority and unresolved-defect
@@ -113,8 +153,15 @@ cross-cutting; do not route all records only to `architecture-resilience`.
 - Unit, connectivity and performance/load rows carry an automated target; integration and
   smoke/regression/functional rows may be semi-automated only when manual steps, evidence and RACI
   ownership are explicit.
+- The profile has no standalone Integration Testing row; integration scenarios are assigned to
+  Change-Based Functional Testing for Migration-Team refactoring, otherwise to mandatory
+  Application-Team UAT.
 - Data migration verification is Not Applicable only when evidence proves no data movement.
 - Conditional R-Type tests do not influence architecture's independent R-Type selection.
+- HA requirements reflect the Application Owner's assessment of R-Type, failover mechanisms,
+  redundancy, load balancing, and resiliency strategy; missing goals remain owned readiness gaps.
+- DR requirements preserve Production acceptance and validate recovery plus failback/normalization
+  against approved RTO/RPO; PPE/QA rehearsal cannot substitute for the Production test.
 - UAT is mandatory and has observable entry, exit, approval, and evidence obligations.
 - Missing cases/data/tools/environments become requirements/readiness gaps, not silent exemptions.
 - Case-count evidence for each applicable test type must be sourced from the discovery report,
diff --git a/.github/skills/specify-backlog/SKILL.md b/.github/skills/specify-backlog/SKILL.md
index 081a787..4297a1a 100644
--- a/.github/skills/specify-backlog/SKILL.md
+++ b/.github/skills/specify-backlog/SKILL.md
@@ -17,6 +17,8 @@ Delta rows for items that need migration-team review.
 - `docs/backlog-playbook/v1/Backlog-Playbook-v1.csv`
 - Relevant requirement inputs or architecture decisions affecting scope
 - Requirements Section 7 and architecture Sections 15.0–15.1 coverage evidence, when present
+- Architecture Sections 14.1–14.4 and `requirements/testing-profile.md` when present, for exact
+  test-handoff requirement, implementation, source, asset, case and action references
 
 ## Plan → Act → Review
 
@@ -40,6 +42,9 @@ Delta rows for items that need migration-team review.
 - Preserve architecture implementation IDs and repository/project mappings in the spec's scope
 	evidence. Separate assessment read access from implementation write/branch permission; if either
 	is unavailable, record the exact request and owner as an open dependency.
+- Preserve exact REQ/NFR and `IMP-F###` / `IMP-US###` / `IMP-T###` identifiers when linking backlog
+  scope to the Section 6 testing evidence handoff. Do not infer that a playbook story is complete
+  from a test crosswalk or scenario reference; Section 3 remains the complete selected baseline.
 - For undiscovered or new backlog items, add them to Section 4 as Proposed, not to Section 3.
 
 ### Review
@@ -49,5 +54,7 @@ Delta rows for items that need migration-team review.
 	evidence; completion disposition belongs to the plan ledger.
 - Verify every in-scope architecture implementation item maps to a named repository/project and
 	best-known path, or has an owner-attributed unknown and explicit app-team source-access request.
+- Confirm test-handoff references use exact Section 3 work-item IDs and do not lose implementation
+  repository/access readiness or imply a new backlog item.
 - Ensure Section 4 rows remain clearly provisional and require human review.
 - Confirm no item was added directly to the standard backlog without an explicit design or review reason.
diff --git a/.github/skills/specify-coverage/SKILL.md b/.github/skills/specify-coverage/SKILL.md
index 53237ac..5af13b4 100644
--- a/.github/skills/specify-coverage/SKILL.md
+++ b/.github/skills/specify-coverage/SKILL.md
@@ -1,19 +1,22 @@
 ---
 name: specify-coverage
-description: "Review scope, deferred items, decision/risk stubs, and the review checkpoint for the spec stage. Owns Sections 6–8 of spec.md."
+description: "Reconcile testing evidence handoff, deferred scope, decision/risk stubs, and the review checkpoint for the spec stage. Owns Sections 6–9 of spec.md."
 argument-hint: "Invoked by /speckit.specify to manage deferred scope and final review readiness"
 ---
 
 # Spec Skill: Coverage and Review
 
-Owns `spec.md` Sections 6–8: out-of-scope/deferred items, decision/risk stubs, and the review
-checkpoint. This skill keeps the spec disciplined and prevents scope creep.
+Owns `spec.md` Sections 6–9: the testing evidence handoff, out-of-scope/deferred items,
+decision/risk stubs, and the review checkpoint. This skill keeps the spec disciplined, traceable
+and prevents scope creep.
 
 ## Required Inputs
 
 - Current `spec.md` draft
 - Relevant `decisions.md` / `risks.md`
 - Architecture decisions and any out-of-scope items already identified
+- Architecture Sections 14.1–14.4 and `requirements/testing-profile.md` when available; do not
+  require the Planning & Design `G-test-plan.md` for the first SPEC pass
 
 ## Plan → Act → Review
 
@@ -24,15 +27,28 @@ checkpoint. This skill keeps the spec disciplined and prevents scope creep.
 
 ### Act
 
-- Add items to Section 6 only when they are deferred or out of scope.
+- Add items to Section 7 only when they are deferred or out of scope.
+- Populate Section 6 with exactly one row per canonical test type, linking applicable architecture
+  crosswalk/family evidence, exact REQ/NFR and `IMP-*` IDs, case origin/asset locators, shared
+  profile source/action IDs, selected Section 3 story IDs, readiness, delivery handoff and approval
+  roles. Retain evidence-backed conditional applicability and N/A rules, mandatory UAT, and the
+  rule that integration scenarios belong to Change-based functional or UAT, never a standalone type.
+- Reuse `requirements/testing-profile.md` as the authoritative evidence and human-input register:
+  reference its `SRC-###`, `AST-###`, `ACT-###` and `AUT-##` IDs without copying its action rows.
+  If the profile or a source is unavailable, carry an owned readiness gap; do not invent identifiers,
+  cases, repository access, detailed scripts, plan effort, execution evidence or approvals.
+- Leave Test Plan case detailing, estimates and schedule to Planning & Design; Section 6 is a
+  requirements/architecture-to-planning handoff and must not block the initial SPEC pass.
 - Add decision/risk stubs to the relevant log when a gap requires a future human decision.
 - Keep the review checkpoint explicit and action-oriented.
 
 ### Review
 
 - Confirm no spec work is drifting into out-of-scope modernization.
+- Verify the Section 6 handoff retains exact identifiers and references without replacing the
+  Section 3 backlog, duplicating the shared action register, or claiming a later-stage deliverable.
 - Ensure the human review section clearly states what remains pending.
-- Keep the Section 8 review checkpoint open if affected source repositories have not been inspected
+- Keep the Section 9 review checkpoint open if affected source repositories have not been inspected
 	and no named human has approved a bounded evidence exception. The architecture gate does not
 	require source access, but specification scope must be grounded in source evidence or that
 	explicit human disposition.
diff --git a/.specify/checklists/architecture.md b/.specify/checklists/architecture.md
new file mode 100644
index 0000000..17aae17
--- /dev/null
+++ b/.specify/checklists/architecture.md
@@ -0,0 +1,84 @@
+# Architecture Review Gate Checklist Baseline
+
+**Purpose**: Acceptance tests for the output of `/speckit.architecture`; every item must pass before the Architecture Review Gate can be Cleared.
+**Created**: 2026-10-07
+**Feature**: Reusable Spec Layer framework baseline
+**Artifact Under Review**: `architecture.md` with its `decisions/` and `risks/` records
+**Gate Effect**: Required — `check-prerequisites.ps1 -RequireArchitectureReady` blocks `/speckit.specify` while any item is unchecked
+
+> `/speckit.architecture` instantiates these checks into the active feature's
+> `checklists/architecture.md` and evaluates them at the end of every run; `/speckit.checklist
+> architecture` re-evaluates them after later edits. Preserve every baseline ID, question and
+> quality tag verbatim. Add evidence or the exact gap/owner/action after the canonical text.
+> Items that depend on a human review action stay unchecked until the artifact records that action.
+> Resolve each Proposed decision and Identified risk in its own file first; checking an item here
+> never approves a decision or risk.
+
+## Layer Findings And Grounding
+
+- [ ] CHK001 Does every layer skill's Research, Evaluation, Design and Validation output appear in its owning architecture sections, with no layer skipped? [Completeness, Architecture Layer Ownership]
+- [ ] CHK002 Does every layer's design trace to an indexed REQ-###/NFR-### record, or is it flagged as outside the requirements record set rather than silently added? [Traceability, Architecture §1-13]
+- [ ] CHK003 Does every Section 3/9 citation trace to a real `docs/` catalog entry, with no invented ADR/pattern/CPF ID? [Traceability, Architecture §3, §9]
+- [ ] CHK004 Does Section 11 list every conflict found, each with a resolution or an escalation Decision? [Conflict, Architecture §11]
+
+## Target Views And Flows
+
+- [ ] CHK005 Do Sections 2.1, 2.2 and 2.3 show the target context, containers and Azure deployment/runtime topology, with all services, boundaries, ingress hops, identity/data/observability dependencies and external systems evidence-backed or explicitly non-Confirmed with a linked ADR/risk? [Completeness, Architecture §2]
+- [ ] CHK006 Does every Section 5.1/5.2 `FLOW-*` row appear on a directional diagram relationship, and does every user/external relationship map back to exactly one row with purpose, protocol, port, authentication/authorization, exposure and evidence? [Consistency, Architecture §2, §5]
+- [ ] CHK007 Do Sections 3.2, 3.3, 5.2.1, 5.2.2, 5.6, 6.8, 6.9, 7.2.5, 7.2.6 and 7.5–7.8 cover every component, flow, dependency, ingress and data set (or record evidence-backed `None`), with critical dependencies of incompatible RTO/RPO, unagreed load, cross-jurisdiction replicas and AI use each linked to an ADR/risk? [Coverage, Architecture §3, §5-7]
+- [ ] CHK008 Does Section 1.3 record every non-production/DR environment delta reconciled to Section 13.2, and does Section 10.1 consolidate every guardrail/policy exception with an ADR/risk? [Consistency, Architecture §1.3, §10.1]
+
+## Implementation Backlog
+
+- [ ] CHK009 Was Section 4 derived after cross-layer reconciliation, with every migration-required application, data, configuration, runtime/dependency, test-automation and CI/CD delta given unique `IMP-F###`/`IMP-US###`/`IMP-T###` ancestry, repository scope, executable acceptance evidence, traces, accountable ownership and agent capability, or cited compatibility evidence that no change is required? [Completeness, Architecture §4]
+
+## Data And Migration Transition
+
+- [ ] CHK010 Does every `DATA-SRC-###` appear in Sections 6.1, 6.5, 6.6, 6.6.1, 6.7 and 7A.4, and does Section 6.6 have exactly one row for each of the ten lifecycle phases with exact pair, Matrix review date or non-database N/A, local guidance, CPF/provisioning path, hard filters, selection and status? [Completeness, Architecture §6.6]
+- [ ] CHK011 Is every selected migration tool grounded rather than inferred from a blank/grouped Matrix cell, with third-party tooling locally approved or covered by a human ADR and Classic CPF DMS used only for its clear-listed MySQL scenario? [Consistency, Architecture §6.6]
+- [ ] CHK012 Does Section 7A map every Requirements Section 2A topic, Section 5 client/interface and Section 6 data set to a transition design, with no client migration, coexistence, reconciliation, rollback, rehearsal, hypercare or decommission topic silently deferred to planning? [Coverage, Architecture §7A]
+- [ ] CHK013 Does Section 7A define source-of-truth/write ownership, reconciliation tolerance, go/no-go and rollback authority, maximum rollback timing and point-of-no-return treatment, or link each unresolved item to a blocking ADR/risk? [Clarity, Architecture §7A]
+
+## R-Type And Complexity
+
+- [ ] CHK014 Does the Section 8 R-Type recommendation name exactly one R-Type, with its Decision moved out of Proposed by a named human? [Clarity, Architecture §8]
+- [ ] CHK015 Does Section 8A contain all eight Complexity Calculator V4.1 inputs, each with workbook-defined unit, inclusions/exclusions/grouping, derivation, exact rule mapping and grounded source locators, with counts/categories reconciled? [Measurability, Architecture §8A]
+- [ ] CHK016 Does Section 8A record every supplied calculator workbook and compare its rubric/support sheets with the framework baseline, holding version drift or source conflicts at an approved governing version or `HUMAN REVIEW REQUIRED`? [Conflict, Architecture §8A]
+- [ ] CHK017 Does `checklists/complexity-calculator.md` pass `validate-checklists.ps1 -RequireComplete` (every gate-required item checked; its Post-Gate Items wait for G-7), with item/pass/open counts reconciled to Section 8A.Q? [Consistency, Architecture §8A.Q]
+
+## Security, Operability And WAF
+
+- [ ] CHK018 Does `checklists/mec-assessment.md` pass `validate-checklists.ps1 -RequireComplete` (its Post-Gate Items wait for `spec.md` and G-4), and has the app team reviewed the Section 7 MEC table? [Dependency, Architecture §7.4.1]
+- [ ] CHK019 Do Sections 7.9, 12.7, 12.8, 12.9 and 13.9 disposition every WAF checklist code against the actual design, with every `Partially aligned` or `Deviation — risk` row linked to an ADR/risk and every `Deviation — justified` row naming its LSEG source or constitutional principle? [Coverage, Architecture §7.9, §12.7-12.9, §13.9]
+- [ ] CHK020 Does Section 12.6 map every requirements-stage DevSecOps/SDLC row from first commit through production deployment, rollback and handoff, apply the checklist and MEC, and map all GCF gate families to PEP integration, applicability, profile, enforcement, evidence and governed customization/expiry? [Traceability, Architecture §12.6]
+- [ ] CHK021 Are Sections 12.1.1, 12.3 forecasting, 12.6.4, 13.4A and 13.8.1 populated or given explicit evidence owners and ADR/risks? [Completeness, Architecture §12-13]
+- [ ] CHK022 Does Section 14.1 have exactly one row per testing-profile test type, each tracing requirements, resolving R-Type applicability and identifying owning design section, test mechanism, environment/comparability, observability/evidence, prerequisites and readiness, with every Conditional/Blocked row linked to an ADR/risk? [Coverage, Architecture §14.1]
+
+## Cost
+
+- [ ] CHK023 Does Section 13.2 have a row for every environment in the Environment Capacity & Scaling Profile, naming every CPF-/MEC-constrained SKU/tier rather than cost-rightsizing below its floor, with every Section 13.4 "No" carrying a stated reason? [Completeness, Architecture §13.2, §13.4]
+- [ ] CHK024 Does the Section 13.1 Region match the Section 5 Region row and the approved region Decision? [Consistency, Architecture §13.1]
+- [ ] CHK025 Does Section 13.6 price every Section 7A temporary/coexistence resource and source/target overlap (or mark missing quantity/duration for human review), with transition cost separate from steady-state run rate? [Completeness, Architecture §13.6]
+
+## SAD Coverage, Self-Review And Playbook
+
+- [ ] CHK026 Are the SAD business context/App Family, cross-environment/IP/DNS/bandwidth, data/privacy, access/session/authorisation, production-test/EUC/backup protection, per-component operability, 25%/10% TCO controls, FinOps, licensing and sustainability fields populated or given explicit evidence owners and ADR/risks? [Completeness, Architecture §16]
+- [ ] CHK027 Does Section 16 contain every canonical SAD content-heading ID exactly once, with every Partial/No row naming the missing field, evidence owner and linked ADR/risk? [Coverage, Architecture §16]
+- [ ] CHK028 Is the Section 14 Self-Review complete, with every finding corrected or logged as a Decision/Risk/`UNKNOWN` and any Microsoft-documentation use checked for conflicts with LSEG guidance? [Completeness, Architecture §14]
+- [ ] CHK029 Does Section 15.1 have one row per Planning & Design User Story in the Playbook CSV, with every Partial/No row reflected in Section 15.2? [Coverage, Architecture §15.1]
+- [ ] CHK030 Does every Section 15.2 Open Point link to a Decision/Risk? [Traceability, Architecture §15.2]
+
+## Human Review
+
+- [ ] CHK031 Has a named human reviewed every Section 10 decision and risk, recorded in each ADR/risk file rather than in this checklist? [Dependency, Architecture §10]
+
+## Testing Scenarios
+
+- [ ] CHK032 Does Section 14.3 propose scenario families for each applicable test type, trace automation review status/actions and size volume with evidence and confidence, with implementation, execution and maintenance citing the LMP strategy and subject to team scope/effort review? [Coverage, Architecture §14.3]
+
+## Extension Rules
+
+- Preserve CHK001–CHK032 IDs, wording and quality tags in every instantiated application checklist.
+- Add application-specific checks only from CHK033 onward; never insert or renumber baseline IDs.
+- A framework revision may append baseline checks using the next ID and must record the change in
+  `VERSION` and `CHANGELOG.md`.
diff --git a/.specify/checklists/complexity-calculator.md b/.specify/checklists/complexity-calculator.md
index 486450e..5457fc7 100644
--- a/.specify/checklists/complexity-calculator.md
+++ b/.specify/checklists/complexity-calculator.md
@@ -4,7 +4,8 @@
 **Created**: 2026-09-30
 **Feature**: Reusable Spec Layer framework baseline
 **Artifact Under Review**: `architecture.md` Section 8A and `deliverables/complexity-calculator.md` (G-7)
-**Gate Effect**: Required — unchecked baseline items keep the Architecture Review Gate and G-7 In Progress
+**Gate Effect**: Required — unchecked items keep the Architecture Review Gate Not Cleared, except Post-Gate Items, which keep only G-7 In Progress
+**Post-Gate Items**: CHK001, CHK014, CHK020, CHK029, CHK030 — they test G-7, which `/speckit.publish` produces after the Architecture Review Gate; `validate-checklists.ps1 -RequireComplete -IncludePostGate` enforces them for G-7 Complete
 
 > `/speckit.checklist complexity calculator quality` instantiates these checks into the active
 > feature's `checklists/complexity-calculator.md`. Preserve every baseline ID, question and quality
diff --git a/.specify/checklists/mec-assessment.md b/.specify/checklists/mec-assessment.md
index 1152004..3053501 100644
--- a/.specify/checklists/mec-assessment.md
+++ b/.specify/checklists/mec-assessment.md
@@ -4,7 +4,8 @@
 **Created**: 2026-09-30
 **Feature**: Reusable Spec Layer framework baseline
 **Artifact Under Review**: `requirements/MEC-applicability-evidence.md`, `architecture.md` Section 7.4, `spec.md` Section 5 and `deliverables/G-mec-assessment.md` (G-4)
-**Gate Effect**: Required — unchecked baseline items keep the Architecture Review Gate and G-4 In Progress
+**Gate Effect**: Required — unchecked items keep the Architecture Review Gate Not Cleared, except Post-Gate Items, which keep only G-4 In Progress
+**Post-Gate Items**: CHK036, CHK037, CHK042 — they test `spec.md` Section 5 and G-4, which exist only after the Architecture Review Gate; `validate-checklists.ps1 -RequireComplete -IncludePostGate` enforces them for G-4 Complete
 
 > `/speckit.checklist MEC assessment quality` instantiates these checks into the active feature's
 > `checklists/mec-assessment.md`. Preserve every baseline ID, question and quality tag verbatim.
diff --git a/.specify/checklists/plan.md b/.specify/checklists/plan.md
new file mode 100644
index 0000000..a8c0064
--- /dev/null
+++ b/.specify/checklists/plan.md
@@ -0,0 +1,36 @@
+# Plan Phase 2 Review Gate Checklist Baseline
+
+**Purpose**: Acceptance tests for the output of `/speckit.plan`; every item must pass before the Phase 2 Review Gate can be Cleared.
+**Created**: 2026-10-07
+**Feature**: Reusable Spec Layer framework baseline
+**Artifact Under Review**: `plan.md` and the canonical feature-root `G-test-plan.md`
+**Gate Effect**: Required — `check-prerequisites.ps1 -RequireTasksReady` blocks `/speckit.tasks` while any item is unchecked
+
+> `/speckit.plan` instantiates these checks into the active feature's `checklists/plan.md` and
+> evaluates them at the end of every run; `/speckit.checklist plan` re-evaluates them after later
+> edits. Preserve every baseline ID, question and quality tag verbatim. Add evidence or the exact
+> gap/owner/action after the canonical text. Items that depend on a human review action stay
+> unchecked until the artifact records that action.
+
+## Governance
+
+- [ ] CHK001 Has the Constitution Check been re-run, and does it pass? [Consistency, Plan §Constitution Check]
+- [ ] CHK002 Has a named human reviewed every Decision Required and moved it out of Proposed? [Dependency, Plan §Decisions Required]
+- [ ] CHK003 Has a named human reviewed every Risk Identified and moved it out of Identified? [Dependency, Plan §Risks Identified]
+
+## Schedule Completeness
+
+- [ ] CHK004 Does every selected Playbook User Story and child Task appear exactly once in the work-item schedule with exact ID/title, parent linkage, source tags, OwningOrg and GHCP disposition? [Completeness, Plan §Playbook Work-Item Schedule]
+- [ ] CHK005 Does every applicable Discovery & Assessment and Planning & Design User Story and child Task have an evidence-backed disposition, with completed rows unscheduled and partial rows scheduling only their explicit residual? [Coverage, Plan §Migration Delivery Schedule]
+- [ ] CHK006 Does every applicable Architecture Section 7A `MIG-###` control have scheduled work, an owner, evidence output and dependency/gate, with no transition strategy re-decided in planning? [Traceability, Plan §Migration Transition Implementation]
+
+## Testing
+
+- [ ] CHK007 Does canonical `G-test-plan.md` pass validation, with every applicable test scheduled and every exception/approval resolved by a named human? [Completeness, Plan §Application Test Plan Handoff]
+
+## Extension Rules
+
+- Preserve CHK001–CHK007 IDs, wording and quality tags in every instantiated application checklist.
+- Add application-specific checks only from CHK008 onward; never insert or renumber baseline IDs.
+- A framework revision may append baseline checks using the next ID and must record the change in
+  `VERSION` and `CHANGELOG.md`.
diff --git a/.specify/checklists/requirements.md b/.specify/checklists/requirements.md
new file mode 100644
index 0000000..9996536
--- /dev/null
+++ b/.specify/checklists/requirements.md
@@ -0,0 +1,65 @@
+# Requirements Review Gate Checklist Baseline
+
+**Purpose**: Acceptance tests for the output of `/speckit.requirements`; every item must pass before the Requirements Review Gate can be Cleared.
+**Created**: 2026-10-07
+**Feature**: Reusable Spec Layer framework baseline
+**Artifact Under Review**: `requirements/` records, `requirements/index.md`, `requirements/migration-transition.md`, `requirements/testing-profile.md` and the generated `requirements.md`
+**Gate Effect**: Required — `check-prerequisites.ps1 -RequireRequirementsReady` blocks `/speckit.architecture` while any item is unchecked
+
+> `/speckit.requirements` instantiates these checks into the active feature's
+> `checklists/requirements.md` and evaluates them at the end of every run; `/speckit.checklist
+> requirements` re-evaluates them after later edits. Preserve every baseline ID, question and
+> quality tag verbatim. Add evidence or the exact gap/owner/action after the canonical text.
+> Items that depend on a human review action stay unchecked until the artifact records that action.
+
+## Sources And Measurability
+
+- [ ] CHK001 Does every FR/NFR cite a real source (discovery report section, LSEG standard, or explicit `UNKNOWN`)? [Traceability, Requirements §1-2]
+- [ ] CHK002 Does every "Must" NFR have a measurable Metric/Target? [Measurability, Requirements §2]
+- [ ] CHK003 Are at least one Reliability NFR (RTO/RPO/HA) and one Operational Excellence NFR (monitoring/alerting) present, with any inherited default named and sourced? [Completeness, Requirements §2]
+- [ ] CHK004 Have the Section 2 Security, Reliability and Operational Excellence NFRs been reviewed against `docs/mec-reference.md`, `docs/gcf-reference.md`, `docs/DevSecOps-Checklist/INDEX.md`, `docs/resliency-guidance/resliency-guidance.md` and applicable linked topic files? [Coverage, Requirements §2]
+
+## DevSecOps And GCF
+
+- [ ] CHK005 Does every in-scope application/IaC repository have an evidenced GCF current-state row, with every `Not using GCF` or `Unknown` row linked to a target GCF adoption NFR? [Completeness, Requirements §2 DevSecOps]
+- [ ] CHK006 Does every proposed GCF custom threshold/exemption link to application-owner/GCF approval, compensating controls, residual risk, owner and expiry evidence, or to an open ADR/risk? [Traceability, Requirements §2 DevSecOps]
+- [ ] CHK007 Does every applicable DevSecOps checklist domain have an evidenced disposition, with every mandatory `No`/`Unknown` linked to a target REQ/NFR or governed N/A? [Coverage, Requirements §2 DevSecOps]
+
+## Environments And Complexity Evidence
+
+- [ ] CHK008 Does the Environment Capacity & Scaling Profile have one row per environment this migration will build, each with usage evidence, a derived Baseline Load/Concurrency Target, derivation/confidence and Reliability Target (or explicit `UNKNOWN`), with Production at expected steady-state performance and every lower environment at its minimum viable steady/normal-traffic target? [Completeness, Requirements §2 Environment Capacity]
+- [ ] CHK009 Does every lower environment have an explicit scaling disposition for applicable performance/load/stress, HA/failover/DR/resilience and integration-test events, with target, duration/frequency, capacity delta and return-to-baseline condition for each required event? [Measurability, Requirements §2 Lower-Environment Scaling]
+- [ ] CHK010 Does the Complexity Calculator Requirements Evidence cover all eight V4.1 factors, with requirement-owned facts evidenced or owned through an ADR/risk, the target deployable-component count deferred to architecture and no target-design rating guessed? [Completeness, Requirements §2 Complexity Calculator]
+
+## Migration Transition, Data And R-Type Evidence
+
+- [ ] CHK011 Does Section 2A have one disposition per migration-transition topic, with Applicable rows linked to REQ/NFR records, Not Applicable rows citing evidence and every blocking Unknown naming an evidence owner and linked ADR/risk? [Coverage, Requirements §2A]
+- [ ] CHK012 Does Section 2A.1 have one unique `DATA-SRC-###` profile per in-scope source, with engine/version/topology, structure/features, workload/change rate, dependencies, operations/security, downtime/RPO/reconciliation/rollback, network route and tested throughput evidenced or governed as Unknown? [Completeness, Requirements §2A.1]
+- [ ] CHK013 Does the Section 3 R-Type Confirmation Matrix cover every material component and cross-cutting concern, with every potentially forcing Unknown naming its owner, requested evidence, possible R-Type transition and linked ADR/risk, and no Unknown treated as confirmation of Rehost? [Assumption, Requirements §3]
+
+## Testing Scope
+
+- [ ] CHK014 Does `requirements/testing-profile.md` have one validated disposition per canonical test type, with Applicable/Conditionally Applicable rows linked to REQ/NFR records, Migration-Team unit-test additions scoped to migration-changed impacted code, data testing following actual data movement, DR Production acceptance and separate security/penetration testing explicit, and UAT Applicable with no exception? [Coverage, Requirements testing-profile]
+
+## Traceability And Self-Review
+
+- [ ] CHK015 Is the Section 5 Traceability Matrix initialized with every REQ/NFR ID from Sections 1-2? [Traceability, Requirements §5]
+- [ ] CHK016 Is the Section 6 Self-Review complete, with every finding corrected or logged as a Decision/Risk/`UNKNOWN` and no "Fixed in this draft" gap left open? [Completeness, Requirements §6]
+
+## Independent Coverage Checks
+
+- [ ] CHK017 Does Section 7.1 have one row per Discovery & Assessment User Story in the Playbook CSV, with every Partial/No row reflected in Section 7.2? [Coverage, Requirements §7.1]
+- [ ] CHK018 Does every Section 7.2 Open Point link to a Decision/Risk? [Traceability, Requirements §7.2]
+- [ ] CHK019 Does Section 8.1 have one row per canonical SAD content-heading block covering every child question/guidance/table field, and Section 8.2 one row per other `deliverables-template/` file, with every Partial/No row reflected in Section 8.3? [Coverage, Requirements §8.1-8.2]
+- [ ] CHK020 Does every Section 8.3 Open Point link to a Decision/Risk with a specific, assignable action? [Clarity, Requirements §8.3]
+
+## Human Review
+
+- [ ] CHK021 Has a named human reviewed every Section 4 decision and risk, recorded in each ADR/risk file rather than in this checklist? [Dependency, Requirements §4]
+
+## Extension Rules
+
+- Preserve CHK001–CHK021 IDs, wording and quality tags in every instantiated application checklist.
+- Add application-specific checks only from CHK022 onward; never insert or renumber baseline IDs.
+- A framework revision may append baseline checks using the next ID and must record the change in
+  `VERSION` and `CHANGELOG.md`.
diff --git a/.specify/checklists/spec.md b/.specify/checklists/spec.md
new file mode 100644
index 0000000..662bb6a
--- /dev/null
+++ b/.specify/checklists/spec.md
@@ -0,0 +1,41 @@
+# Spec Review Checkpoint Checklist Baseline
+
+**Purpose**: Acceptance tests for the output of `/speckit.specify` and `/speckit.clarify`; every item must pass before planning and task generation.
+**Created**: 2026-10-07
+**Feature**: Reusable Spec Layer framework baseline
+**Artifact Under Review**: `spec.md`
+**Gate Effect**: Required — `check-prerequisites.ps1 -RequireSpecReady` blocks `/speckit.plan`, and `-RequireTasksReady` blocks `/speckit.tasks`, while any item is unchecked
+
+> `/speckit.specify` instantiates these checks into the active feature's `checklists/spec.md` and
+> evaluates them at the end of every run; `/speckit.clarify` and `/speckit.checklist spec`
+> re-evaluate them after later edits. Preserve every baseline ID, question and quality tag
+> verbatim. Add evidence or the exact gap/owner/action after the canonical text. Items that depend
+> on a human review action stay unchecked until the artifact records that action.
+
+## Inherited Scope
+
+- [ ] CHK001 Does `architecture.md` exist with its Architecture Review Gate Cleared, and are Sections 2 and 5 copied from it rather than re-derived? [Consistency, Spec §2, §5]
+- [ ] CHK002 Is the as-is summary confirmed against source evidence, with no unresolved `UNKNOWN` blocking scope? [Completeness, Spec §1]
+- [ ] CHK003 Does the MEC/discovery applicability table match `architecture.md` Section 7? [Consistency, Spec §5]
+
+## Backlog
+
+- [ ] CHK004 Does the Section 3 Standard Backlog table match a correct CSV filter for the approved R-Type? [Consistency, Spec §3]
+- [ ] CHK005 Has the migration team reviewed the Section 4 Backlog Delta, or confirmed it empty? [Dependency, Spec §4]
+
+## Human Review
+
+- [ ] CHK006 Has a named human reviewed every Section 8 decision and risk, recorded in each ADR/risk file rather than in this checklist? [Dependency, Spec §8]
+
+## Backlog And Testing Handoff
+
+- [ ] CHK007 Does the Section 4 Backlog Delta preserve architecture `IMP-*` IDs, exact requirement traces, repository scope and access readiness? [Traceability, Spec §4]
+- [ ] CHK008 Does Section 6 have one row per canonical test type, tracing the applicable architecture crosswalk, supplied/proposed case and asset references, profile actions and readiness, without duplicating the authoritative action register? [Coverage, Spec §6]
+- [ ] CHK009 Is the Test Plan deferred to Planning & Design, with Section 6 claiming no scripts, execution or approval and the review gate left pending human action? [Consistency, Spec §6]
+
+## Extension Rules
+
+- Preserve CHK001–CHK009 IDs, wording and quality tags in every instantiated application checklist.
+- Add application-specific checks only from CHK010 onward; never insert or renumber baseline IDs.
+- A framework revision may append baseline checks using the next ID and must record the change in
+  `VERSION` and `CHANGELOG.md`.
diff --git a/.specify/scripts/powershell/README.md b/.specify/scripts/powershell/README.md
index b7d69ff..97552cb 100644
--- a/.specify/scripts/powershell/README.md
+++ b/.specify/scripts/powershell/README.md
@@ -6,14 +6,15 @@ Windows PowerShell 5.1+ compatible and have no external module dependencies.
 | Script | Purpose | Example |
 |--------|---------|---------|
 | `common.ps1` | Dot-sourced helper functions (repo root, current branch, spec numbering, slug generation, feature paths, JSON/text output). Not run directly. | `. .specify/scripts/powershell/common.ps1` |
+| `doctor.ps1` | Checks the machine before the first run: PowerShell version, effective execution policy, .NET zip support, Git, `SPEC_LAYER_APP_ROOT` (set, outside this repo, a git repo), the pinned SAD/testing-strategy DOCX hashes and OOXML headers (catches cloud placeholders and label-encrypted copies), and the knowledge catalogs. Pandoc and VS Code Copilot Chat are advisory. Exits 1 on any failure. | `powershell -ExecutionPolicy Bypass -File .specify/scripts/powershell/doctor.ps1` |
 | `create-new-feature.ps1` | Computes the next `NNN-slug` feature name, creates/checks out a matching git branch, creates `specs/<NNN-slug>/`, source record folders/indexes, creates the root `CHANGELOG.md` for that feature, and the authoritative `requirements/migration-transition.md` profile. Run first, via `/speckit.requirements`. | `pwsh .specify/scripts/powershell/create-new-feature.ps1 -Description "Payments API migration to Azure" -Json` |
-| `sync-records.ps1` | Migrates legacy rollups when requested and regenerates `requirements.md`, `decisions.md`, and `risks.md` from source record folders. | `pwsh .specify/scripts/powershell/sync-records.ps1 -MigrateExisting -Json` |
-| `validate-records.ps1` | Validates record filenames, unique IDs, ADR structure, immutable-status metadata, REQ/NFR/ADR/RSK references, and the independently derived 30-row MEC assessment contract. | `pwsh .specify/scripts/powershell/validate-records.ps1 -Json` |
+| `sync-records.ps1` | Migrates legacy rollups when requested and regenerates the `requirements/`, `decisions/` and `risks/` indexes from the record folders. It does not generate `requirements.md`, and it keeps an existing Requirements Review Gate block instead of resetting it. | `pwsh .specify/scripts/powershell/sync-records.ps1 -MigrateExisting -Json` |
+| `validate-records.ps1` | Validates record filenames, unique IDs, ADR structure, immutable-status metadata, REQ/NFR/ADR/RSK references (catalog IDs such as `LMP-ADR-0010` are ignored), and the independently derived 30-row MEC assessment contract. A final ADR, or a risk that has left `Identified`, needs its human decision/disposition, a named Reviewer and a YYYY-MM-DD Review Date. | `pwsh .specify/scripts/powershell/validate-records.ps1 -Json` |
 | `validate-requirements-transition.ps1` | Validates all authoritative `migration-transition.md`/Section 2A topic dispositions, requirement links, evidence owners, and ADR/risk links before architecture. | `pwsh .specify/scripts/powershell/validate-requirements-transition.ps1 -Json` |
 | `export-sad-contract.ps1` | Extracts the live canonical SAD DOCX into normalized JSON: SHA-256, all blocks/headings, table schemas, guidance/questions, hierarchy, and media count. | `pwsh .specify/scripts/powershell/export-sad-contract.ps1 -Json` |
 | `validate-sad-contract.ps1` | Detects live DOCX drift and validates exact Markdown baseline heading order, ownership coverage, and required upstream architecture/SAD fields. | `pwsh .specify/scripts/powershell/validate-sad-contract.ps1 -Json` |
 | `validate-architecture.ps1` | Validates mandatory C4 Context, C4 Container, Azure deployment/runtime views, SAD 2.6.2 `FLOW-*` reconciliation, Section 7A migration-transition controls/fields/state diagram, and all eight Complexity Calculator V4.1 inputs in Section 8A. | `pwsh .specify/scripts/powershell/validate-architecture.ps1 -Json` |
-| `validate-checklists.ps1` | Validates Spec-Kit quality-checklist metadata, contiguous unique `CHK###` IDs, traceability density, completion status and conformance to any controlled `.specify/checklists/<domain>.md` baseline. | `pwsh .specify/scripts/powershell/validate-checklists.ps1 -ChecklistPath <path> -Json` |
+| `validate-checklists.ps1` | Validates Spec-Kit quality-checklist metadata, contiguous unique `CHK###` IDs, traceability density, completion status and conformance to any controlled `.specify/checklists/<domain>.md` baseline. `-RequireComplete` fails on open items except the baseline's **Post-Gate Items**; add `-IncludePostGate` to require those too (G-4/G-7 completion). | `pwsh .specify/scripts/powershell/validate-checklists.ps1 -ChecklistPath <path> -Json` |
 | `validate-implementation-backlog.ps1` | Validates architecture `IMP-F###`/`IMP-US###`/`IMP-T###` hierarchy and detail, 1:1 plan scheduling, and 1:N agent work-package coverage in `tasks.md`. | `pwsh .specify/scripts/powershell/validate-implementation-backlog.ps1 -ArchitecturePath <architecture.md> -PlanPath <plan.md> -TasksPath <tasks.md> -Json` |
 | `setup-architecture.ps1` | Detects the current feature, copies `architecture-template.md` to `architecture.md` (without overwriting). Run by `/speckit.architecture`, only after `check-prerequisites.ps1 -RequireRequirementsReady` passes. | `pwsh .specify/scripts/powershell/setup-architecture.ps1 -Json` |
 | `setup-spec.ps1` | Detects the current feature, copies `spec-template.md` to `spec.md` (without overwriting). Run by `/speckit.specify`, only after `check-prerequisites.ps1 -RequireArchitectureReady` passes. | `pwsh .specify/scripts/powershell/setup-spec.ps1 -Json` |
@@ -22,14 +23,22 @@ Windows PowerShell 5.1+ compatible and have no external module dependencies.
 | `finalize-publication.ps1` | Injects publication metadata, increments only changed deliverables, and appends per-deliverable and run history. | `pwsh .specify/scripts/powershell/finalize-publication.ps1 -Json` |
 | `validate-publication.ps1` | Validates source freshness, managed outputs, content hashes, contiguous versions, canonical Test Plan placement, and exact-version approval evidence. | `pwsh .specify/scripts/powershell/validate-publication.ps1 -Json` |
 | `test-publication-workflow.ps1` | Proves initial, unchanged-rerun, and changed-rerun version behavior while preserving evidence. | `pwsh .specify/scripts/powershell/test-publication-workflow.ps1 -Json` |
-| `validate-requirements-testing.ps1` | Validates the canonical application testing profile, dispositions, requirement links, owners, environments, exceptions and resolved unit/data/DR/security rules. | `pwsh .specify/scripts/powershell/validate-requirements-testing.ps1 -Json` |
-| `validate-test-plan.ps1` | Validates the canonical application `G-test-plan.md`, RACI, traceability, environments, exceptions and named approval before tasks. | `pwsh .specify/scripts/powershell/validate-test-plan.ps1 -Json` |
+| `validate-requirements-testing.ps1` | Validates the canonical application testing profile, evidence/conflicts, actions, assets, dispositions, requirement links, owners, environments, exceptions and resolved unit/data/DR/security rules. Supports `Draft`, `ReadyForReview` and `Execution`; the default remains `Execution`. | `pwsh .specify/scripts/powershell/validate-requirements-testing.ps1 -ValidationStage Draft -Json` |
+| `validate-test-plan.ps1` | Validates canonical `G-test-plan.md`, cases, estimates, assets, RACI and evidence. Draft/document review permit owned unresolved readiness and appointment roles; ReadyForReview also requires a linked Review Brief. Reports deferred execution requirements separately. Default `Execution` still requires Ready architecture, named approvers and actual approvals. | `pwsh .specify/scripts/powershell/validate-test-plan.ps1 -ValidationStage ReadyForReview -Json` |
 | `validate-testing-tasks.ps1` | Validates per-test PREP/EXEC/REMEDIATE/EVIDENCE/APPROVAL tasks before implementation. | `pwsh .specify/scripts/powershell/validate-testing-tasks.ps1 -Json` |
 | `export-testing-strategy.ps1` / `validate-testing-strategy.ps1` | Reproducibly extracts the canonical DOCX and detects source, Markdown, index, table and media drift. | `pwsh .specify/scripts/powershell/validate-testing-strategy.ps1 -Json` |
 | `test-testing-workflow.ps1` | Runs a self-contained positive-path smoke test for the testing profile, Test Plan and testing-task validators. | `pwsh .specify/scripts/powershell/test-testing-workflow.ps1 -Json` |
 | `test-implementation-backlog.ps1` | Runs positive and negative architecture-to-plan-to-task regression tests for implementation backlog hierarchy, scheduling and agent handoff. | `pwsh .specify/scripts/powershell/test-implementation-backlog.ps1 -Json` |
-| `check-prerequisites.ps1` | Detects the current feature. Requirements/architecture progression first validates the canonical SAD contract. `-RequireRequirementsReady` also validates `migration-transition.md`; `-RequireArchitectureReady` validates diagrams, transition controls, SAD field markers, all 74 canonical SAD coverage IDs and the architecture implementation backlog. Task and implementation gates also validate plan/task backlog handoffs. Human gates and blocking ADR/risks still apply. | `pwsh .specify/scripts/powershell/check-prerequisites.ps1 -RequireRequirementsReady -Json` |
+| `check-prerequisites.ps1` | Detects the current feature. Requirements/architecture progression first validates the canonical SAD contract. `-RequireRequirementsReady` also validates `migration-transition.md`; `-RequireArchitectureReady` validates diagrams, transition controls, SAD field markers, all 74 canonical SAD coverage IDs and the architecture implementation backlog. Task and implementation gates also validate plan/task backlog handoffs. Each gate checks its Spec-Kit checklists before the human sign-off: `requirements.md`; `architecture.md` plus the gate-required items of `complexity-calculator.md` and `mec-assessment.md`; `spec.md` (`-RequireSpecReady`, used by `/speckit.plan`); `spec.md` and `plan.md` for tasks/implementation. `-PathsOnly` reports feature paths without running any check. Human gates and blocking ADR/risks still apply. | `pwsh .specify/scripts/powershell/check-prerequisites.ps1 -RequireRequirementsReady -Json` |
+
+`common.ps1` makes `Get-Content`/`Set-Content`/`Add-Content`/`Out-File` default to UTF-8 for the
+running script, and scripts containing non-ASCII text carry a UTF-8 BOM, so Windows PowerShell 5.1
+and PowerShell 7 read framework files identically.
 
 All scripts support a `-Json` switch for machine-readable output (via `ConvertTo-Json`); omit it
 for concise human-readable status lines. Scripts that block automation (e.g. an open review gate)
 exit with a non-zero exit code and a clear `Write-Error` message.
+
+The testing and publication workflow runners accept `-WorkspaceRoot` for disposable fixture
+folders in an explicitly chosen workspace; use a location outside the framework and application
+workspaces. Fixtures are removed on completion. Default runner behavior is unchanged.
diff --git a/.specify/scripts/powershell/check-prerequisites.ps1 b/.specify/scripts/powershell/check-prerequisites.ps1
index 1f47e37..f5509fa 100644
--- a/.specify/scripts/powershell/check-prerequisites.ps1
+++ b/.specify/scripts/powershell/check-prerequisites.ps1
@@ -1,13 +1,15 @@
 #requires -Version 5.1
-# Verifies gate/prerequisite state for the current feature before allowing /architecture, /specify, /plan, or /tasks to proceed.
+# Verifies gate/prerequisite state for the current feature before allowing /architecture, /specify, /plan, /tasks or /implement to proceed.
 [CmdletBinding()]
 param(
     [switch]$RequireRequirementsReady,
     [switch]$RequireArchitectureReady,
+    [switch]$RequireSpecReady,
     [switch]$RequireTasksReady,
     [switch]$RequireImplementationReady,
     [switch]$TestOnlyAssumeRequirementsReady,
     [switch]$TestOnlySkipNonTestingValidation,
+    [switch]$PathsOnly,
     [switch]$Json
 )
 
@@ -22,6 +24,14 @@ if (-not $featureDirName) {
 
 $paths = Get-FeaturePaths -FeatureDirName $featureDirName
 
+if ($PathsOnly) {
+    $pathResult = @{ feature = $featureDirName; checklistsDir = (Join-Path $paths.FEATURE_DIR 'checklists') }
+    foreach ($property in $paths.PSObject.Properties) { $pathResult[$property.Name] = $property.Value }
+    $pathResult['availableDocs'] = @('requirements.md', 'architecture.md', 'spec.md', 'plan.md', 'tasks.md', 'G-test-plan.md' | Where-Object { Test-Path -LiteralPath (Join-Path $paths.FEATURE_DIR $_) -PathType Leaf })
+    Write-ScriptResult -Data $pathResult -Json:$Json
+    exit 0
+}
+
 if ($TestOnlySkipNonTestingValidation) {
     $applicationRoot = [System.IO.Path]::GetFullPath((Get-ApplicationRoot)).TrimEnd('\','/')
     $tempRoot = [System.IO.Path]::GetFullPath([System.IO.Path]::GetTempPath()).TrimEnd('\','/')
@@ -31,49 +41,25 @@ if ($TestOnlySkipNonTestingValidation) {
     }
 }
 
-function Get-GateReviewState {
+$gateChecklistsPassed = [System.Collections.Generic.List[string]]::new()
+function Assert-GateChecklistComplete {
     param(
-        [Parameter(Mandatory = $true)][string]$Content,
+        [Parameter(Mandatory = $true)][string]$Name,
         [Parameter(Mandatory = $true)][string]$GateName
     )
-
-    $escapedGateName = [regex]::Escape($GateName)
-    $sectionMatch = [regex]::Match($Content, "(?ms)^##\s+$escapedGateName\b(?<body>.*?)(?=^##\s|\z)")
-    if (-not $sectionMatch.Success -and $GateName -eq '2. Review Gate') {
-        $sectionMatch = [regex]::Match($Content, '(?ms)^##\s+Phase\s+2\s+[—-]\s+Review Gate\b(?<body>.*?)(?=^##\s|\z)')
-    }
-    $gateContent = if ($sectionMatch.Success) { $sectionMatch.Value } else { '' }
-
-    $gateMatch = [regex]::Match($gateContent, "(?m)^\|\s*$escapedGateName\s*\|\s*(?<status>[^|]+?)\s*\|(?:.*)?$")
-    if (-not $gateMatch.Success) {
-        $gateMatch = [regex]::Match($gateContent, "(?m)^\*\*Outcome\*\*:\s*(?<status>[^\r\n]+)")
-    }
-    $reviewerMatch = [regex]::Match($gateContent, '(?m)^\*\*Reviewed by\*\*:\s*(?<reviewer>[^|]+?)\s*\|\s*\*\*Date\*\*:\s*(?<date>\d{4}-\d{2}-\d{2})\s*\|\s*\*\*Outcome\*\*:\s*(?<outcome>[^\r\n]+)')
-
-    $reviewer = if ($reviewerMatch.Success) { $reviewerMatch.Groups['reviewer'].Value.Trim() } else { $null }
-    $reviewDate = if ($reviewerMatch.Success) { $reviewerMatch.Groups['date'].Value } else { $null }
-    $reviewOutcome = if ($reviewerMatch.Success) { $reviewerMatch.Groups['outcome'].Value.Trim() } else { $null }
-    $validDate = $false
-    if ($reviewDate) {
-        $parsedDate = [datetime]::MinValue
-        $validDate = [datetime]::TryParseExact($reviewDate, 'yyyy-MM-dd', [Globalization.CultureInfo]::InvariantCulture, [Globalization.DateTimeStyles]::None, [ref]$parsedDate)
+    if ($TestOnlySkipNonTestingValidation) { return }
+    $checklistPath = Join-Path (Join-Path $paths.FEATURE_DIR 'checklists') "$Name.md"
+    if (-not (Test-Path -LiteralPath $checklistPath -PathType Leaf)) {
+        Write-Error "$GateName checklist missing: $checklistPath. Run /speckit.checklist $Name to instantiate and evaluate it from .specify/checklists/$Name.md."
+        exit 1
     }
-
-    $status = if ($gateMatch.Success) { $gateMatch.Groups['status'].Value.Trim() } else { 'Not Found' }
-    if ($status -match '^(?<state>Cleared|Not Cleared|Pending|Not Started)\b') { $status = $matches['state'] }
-
-    $reviewerNamePart = if ($reviewer) { ($reviewer -replace '\s+\([^)]+\)\s*$','').Trim() } else { $null }
-    $isNamedPerson = $reviewerNamePart -and
-        $reviewerNamePart -match "^[A-Za-z][A-Za-z'.-]+(?:\s+[A-Za-z][A-Za-z'.-]+)+$" -and
-        $reviewerNamePart -notmatch '(?i)\b(?:Team|Lead|Architect|Owner|Manager|Reviewer|Approver|Security|Operations|Testing|Migration|Application|Product|Customer|QA|LSEG|Microsoft)\b'
-
-    return [PSCustomObject]@{
-        Status = $status
-        Reviewer = $reviewer
-        HasNamedReviewer = [bool]$isNamedPerson
-        HasValidReviewDate = $validDate
-        HasApprovedOutcome = $reviewOutcome -match '^(?:Approved|Approved to proceed|Cleared)$'
+    $checklistOutput = & (Join-Path $PSScriptRoot 'validate-checklists.ps1') -ChecklistPath $checklistPath -RequireComplete -Json 2>&1
+    if ($LASTEXITCODE -ne 0) {
+        $detail = try { (($checklistOutput | Out-String) | ConvertFrom-Json).errors -join '; ' } catch { $checklistOutput -join ' ' }
+        Write-Error "$GateName checklist is not complete ($checklistPath): $detail Close every open item (or run /speckit.checklist $Name to re-evaluate) before this gate can pass."
+        exit 1
     }
+    $gateChecklistsPassed.Add($Name)
 }
 
 function Get-BlockingOpenRecordCount {
@@ -101,9 +87,9 @@ function Get-BlockingFolderRecordCount {
     if (-not (Test-Path $Directory)) { return 0 }
     $count = 0
     foreach ($file in Get-ChildItem -LiteralPath $Directory -File -Filter '*.md' | Where-Object { $_.Name -ne 'index.md' }) {
-        $content = Get-Content -LiteralPath $file -Raw
+        $content = Get-Content -LiteralPath $file.FullName -Raw
         $isOpen = ($content -match "(?m)^-\s*Status:\s*$OpenStatus\s*$") -or ($content -match "(?m)^\|\s*\*\*Status\*\*\s*\|\s*$OpenStatus\s*\|\s*$")
-        $isNonBlocking = $content -match '(?mi)^\*\*Blocks Progression\*\*:\s*No\b|^\|\s*\*\*Blocks Progression\*\*\s*\|\s*No\s*\|'
+        $isNonBlocking = $content -match '(?mi)^\*\*Blocks Progression\*\*:\s*No\b|^\|\s*\*\*Blocks Progression\*\*\s*\|\s*No\s*\||^-\s*Blocks Progression:\s*No\b'
         if ($isOpen -and -not $isNonBlocking) { $count++ }
     }
     return $count
@@ -172,6 +158,9 @@ if ($RequireRequirementsReady) {
         exit 1
     }
     $requirementsTestingValidationStatus = 'Passed'
+    if (-not $TestOnlyAssumeRequirementsReady) {
+        Assert-GateChecklistComplete -Name 'requirements' -GateName 'Requirements Review Gate'
+    }
     $reqGate = Get-GateReviewState -Content $reqContent -GateName 'Requirements Review Gate'
 
     if ($TestOnlyAssumeRequirementsReady) {
@@ -205,6 +194,9 @@ if ($RequireRequirementsReady) {
     }
     $implementationBacklogValidationStatus = 'Passed'
 
+    Assert-GateChecklistComplete -Name 'architecture' -GateName 'Architecture Review Gate'
+    Assert-GateChecklistComplete -Name 'complexity-calculator' -GateName 'Architecture Review Gate (Complexity Calculator)'
+    Assert-GateChecklistComplete -Name 'mec-assessment' -GateName 'Architecture Review Gate (MEC assessment)'
     $archContent = Get-Content -Path $paths.ARCHITECTURE -Raw
     $archGate = Get-GateReviewState -Content $archContent -GateName 'Architecture Review Gate'
 
@@ -221,6 +213,19 @@ if ($RequireRequirementsReady) {
     exit 1
 }
 
+$specGateStatus = 'Unknown'
+if ($RequireSpecReady) {
+    Assert-GateChecklistComplete -Name 'spec' -GateName 'Spec Review Checkpoint'
+    $specGate = Get-GateReviewState -Content (Get-Content -Path $paths.SPEC -Raw) -GateName 'Review Checkpoint'
+    if ($specGate.Status -eq 'Cleared' -and $specGate.HasNamedReviewer -and $specGate.HasValidReviewDate -and $specGate.HasApprovedOutcome) {
+        $specGateStatus = 'Cleared'
+    } else {
+        $specGateStatus = $specGate.Status
+        Write-Error "Spec Review Checkpoint (spec.md Review Checkpoint section) requires a named reviewer, a YYYY-MM-DD review date and an Approved outcome. plan.md must not be populated until a named human clears it."
+        exit 1
+    }
+}
+
 $planGateStatus = 'Unknown'
 $testPlanValidationStatus = 'NotRun'
 if ($RequireTasksReady -or $RequireImplementationReady) {
@@ -228,6 +233,8 @@ if ($RequireTasksReady -or $RequireImplementationReady) {
         Write-Error "plan.md not found at $($paths.PLAN). Run setup-plan.ps1 first."
         exit 1
     }
+    Assert-GateChecklistComplete -Name 'spec' -GateName 'Spec Review Checkpoint'
+    Assert-GateChecklistComplete -Name 'plan' -GateName 'Plan Phase 2 Review Gate'
 
     $planContent = Get-Content -Path $paths.PLAN -Raw
     $testPlanValidator = Join-Path $PSScriptRoot 'validate-test-plan.ps1'
@@ -307,11 +314,13 @@ if ($RequireImplementationReady) {
     $testingTasksValidationStatus = 'Passed'
 }
 
+$gateChecklistStatus = if ($gateChecklistsPassed.Count -gt 0) { 'Passed: ' + ($gateChecklistsPassed -join ', ') } else { 'NotRun' }
+
 $decisionsOpen = Get-BlockingFolderRecordCount -Directory $paths.DECISIONS_DIR -OpenStatus 'proposed'
 $risksOpen = Get-BlockingFolderRecordCount -Directory $paths.RISKS_DIR -OpenStatus 'Identified'
 
 if (($decisionsOpen -gt 0 -or $risksOpen -gt 0) -and -not $TestOnlyAssumeRequirementsReady) {
-    Write-Error "$decisionsOpen blocking Proposed decision(s) and $risksOpen blocking Identified risk(s) remain. Resolve them through human review, or set '**Blocks Progression** | No |' on records explicitly scoped as non-blocking."
+    Write-Error "$decisionsOpen blocking Proposed decision(s) and $risksOpen blocking Identified risk(s) remain. Resolve them through human review, or mark records explicitly scoped as non-blocking with 'Blocks Progression: No'."
     exit 1
 }
 
@@ -331,11 +340,13 @@ $result = @{
     implementationBacklogValidationStatus = $implementationBacklogValidationStatus
     sadContractValidationStatus = $sadContractValidationStatus
     spec                    = $paths.SPEC
+    specGateStatus          = $specGateStatus
     plan                    = $paths.PLAN
     planGateStatus          = $planGateStatus
     testPlan                = $paths.TEST_PLAN
     testPlanValidationStatus = $testPlanValidationStatus
     testingTasksValidationStatus = $testingTasksValidationStatus
+    gateChecklistStatus     = $gateChecklistStatus
     decisionsOpen           = $decisionsOpen
     risksOpen               = $risksOpen
 }
diff --git a/.specify/scripts/powershell/common.ps1 b/.specify/scripts/powershell/common.ps1
index 3d016f1..4b45846 100644
--- a/.specify/scripts/powershell/common.ps1
+++ b/.specify/scripts/powershell/common.ps1
@@ -3,6 +3,13 @@
 
 $ErrorActionPreference = 'Stop'
 
+# Windows PowerShell 5.1 reads/writes ANSI by default; framework files are UTF-8. Cloned so the caller's session is untouched.
+$PSDefaultParameterValues = $PSDefaultParameterValues.Clone()
+$PSDefaultParameterValues['Get-Content:Encoding'] = 'UTF8'
+$PSDefaultParameterValues['Set-Content:Encoding'] = 'UTF8'
+$PSDefaultParameterValues['Add-Content:Encoding'] = 'UTF8'
+$PSDefaultParameterValues['Out-File:Encoding'] = 'UTF8'
+
 function Get-RepoRoot {
     # Resolve the framework root from this script's location, independent of the caller's cwd.
     $dir = Split-Path -Parent $PSScriptRoot
@@ -195,6 +202,95 @@ function Get-PublicationSourceState {
     return [PSCustomObject]@{ fingerprint = Get-Sha256ForText -Text $fingerprintInput; sources = $sources }
 }
 
+function Get-GateReviewState {
+    # Reads a human review gate from its own section only, so sign-offs elsewhere in the file never count.
+    param(
+        [Parameter(Mandatory = $true)][AllowEmptyString()][string]$Content,
+        [Parameter(Mandatory = $true)][string]$GateName
+    )
+
+    $escapedGateName = [regex]::Escape($GateName)
+    # Optional numeric prefix: templates renumber sections (e.g. '## 8.' became '## 9. Review Checkpoint').
+    $sectionMatch = [regex]::Match($Content, "(?ms)^##\s+(?:\d+\.\s+)?$escapedGateName\b(?<body>.*?)(?=^##\s|\z)")
+    if (-not $sectionMatch.Success -and $GateName -eq '2. Review Gate') {
+        # \S{1,3} tolerates the em dash however Windows PowerShell 5.1 decoded the file.
+        $sectionMatch = [regex]::Match($Content, '(?ms)^##\s+Phase\s+2\s+\S{1,3}\s+Review Gate\b(?<body>.*?)(?=^##\s|\z)')
+    }
+    $gateContent = if ($sectionMatch.Success) { $sectionMatch.Value } else { '' }
+
+    $gateMatch = [regex]::Match($gateContent, "(?m)^\|\s*$escapedGateName\s*\|\s*(?<status>[^|]+?)\s*\|(?:.*)?$")
+    if (-not $gateMatch.Success) {
+        $gateMatch = [regex]::Match($gateContent, "(?m)^\*\*Outcome\*\*:\s*(?<status>[^\r\n]+)")
+    }
+    $reviewerMatch = [regex]::Match($gateContent, '(?m)^\*\*Reviewed by\*\*:\s*(?<reviewer>[^|]+?)\s*\|\s*\*\*Date\*\*:\s*(?<date>\d{4}-\d{2}-\d{2})\s*\|\s*\*\*Outcome\*\*:\s*(?<outcome>[^\r\n]+)')
+
+    $reviewer = if ($reviewerMatch.Success) { $reviewerMatch.Groups['reviewer'].Value.Trim() } else { $null }
+    $reviewDate = if ($reviewerMatch.Success) { $reviewerMatch.Groups['date'].Value } else { $null }
+    $reviewOutcome = if ($reviewerMatch.Success) { $reviewerMatch.Groups['outcome'].Value.Trim() } else { $null }
+    $validDate = $false
+    if ($reviewDate) {
+        $parsedDate = [datetime]::MinValue
+        $validDate = [datetime]::TryParseExact($reviewDate, 'yyyy-MM-dd', [Globalization.CultureInfo]::InvariantCulture, [Globalization.DateTimeStyles]::None, [ref]$parsedDate)
+    }
+    $hasApprovedOutcome = $reviewOutcome -match '^(?:Approved|Approved to proceed|Cleared)$'
+
+    if ($gateMatch.Success) {
+        $status = $gateMatch.Groups['status'].Value.Trim()
+    } elseif ($reviewOutcome) {
+        # The templates record the decision only on the Reviewed by line; an explicit status row still wins.
+        $status = if ($hasApprovedOutcome) { 'Cleared' } else { $reviewOutcome }
+    } else {
+        $status = 'Not Found'
+    }
+    if ($status -match '^(?<state>Cleared|Not Cleared|Pending|Not Started)\b') { $status = $matches['state'] }
+
+    $reviewerNamePart = if ($reviewer) { ($reviewer -replace '\s+\([^)]+\)\s*$','').Trim() } else { $null }
+    $isNamedPerson = $reviewerNamePart -and
+        $reviewerNamePart -match "^[A-Za-z][A-Za-z'.-]+(?:\s+[A-Za-z][A-Za-z'.-]+)+$" -and
+        $reviewerNamePart -notmatch '(?i)\b(?:Team|Lead|Architect|Owner|Manager|Reviewer|Approver|Security|Operations|Testing|Migration|Application|Product|Customer|QA|LSEG|Microsoft)\b'
+
+    return [PSCustomObject]@{
+        Status = $status
+        Reviewer = $reviewer
+        HasNamedReviewer = [bool]$isNamedPerson
+        HasValidReviewDate = $validDate
+        HasApprovedOutcome = [bool]$hasApprovedOutcome
+    }
+}
+
+function Get-ChecklistState {
+    # Counts checklist items; baseline items listed under **Post-Gate Items** are excluded from requiredOpen.
+    param(
+        [Parameter(Mandatory = $true)][string]$ChecklistPath,
+        [string]$BaselinePath
+    )
+
+    $content = Get-Content -LiteralPath $ChecklistPath -Raw
+    $items = @([regex]::Matches($content, '(?m)^- \[(?<mark>[ xX])\] (?<id>CHK(?<number>\d{3}))\s+(?<text>.+)$'))
+    $postGateIds = @()
+    if ($BaselinePath -and (Test-Path -LiteralPath $BaselinePath -PathType Leaf)) {
+        $baselineContent = Get-Content -LiteralPath $BaselinePath -Raw
+        $postGateLine = [regex]::Match($baselineContent, '(?m)^\*\*Post-Gate Items\*\*:\s*(?<ids>[^\r\n]+)')
+        if ($postGateLine.Success) {
+            $postGateIds = @([regex]::Matches($postGateLine.Groups['ids'].Value, 'CHK\d{3}') | ForEach-Object { $_.Value })
+        }
+    }
+    $openIds = @($items | Where-Object { $_.Groups['mark'].Value -notmatch '[xX]' } | ForEach-Object { $_.Groups['id'].Value })
+    $requiredOpenIds = @($openIds | Where-Object { $_ -notin $postGateIds })
+
+    return [PSCustomObject]@{
+        Content = $content
+        Items = $items
+        ItemCount = $items.Count
+        CheckedCount = $items.Count - $openIds.Count
+        OpenCount = $openIds.Count
+        OpenIds = $openIds
+        PostGateIds = $postGateIds
+        RequiredOpenIds = $requiredOpenIds
+        RequiredOpenCount = $requiredOpenIds.Count
+    }
+}
+
 function Write-ScriptResult {
     # Emits either JSON (-Json) or a human-readable status line per key/value pair.
     param(
@@ -202,7 +298,8 @@ function Write-ScriptResult {
         [switch]$Json
     )
     if ($Json) {
-        $Data | ConvertTo-Json -Depth 5
+        # Windows PowerShell 5.1 escapes ' as \u0027; emit the same JSON as PowerShell 7.
+        ($Data | ConvertTo-Json -Depth 5) -replace '(?<!\\)\\u0027', "'"
     } else {
         foreach ($key in $Data.Keys) {
             Write-Host ("{0}: {1}" -f $key, $Data[$key])
diff --git a/.specify/scripts/powershell/doctor.ps1 b/.specify/scripts/powershell/doctor.ps1
new file mode 100644
index 0000000..313e6bc
--- /dev/null
+++ b/.specify/scripts/powershell/doctor.ps1
@@ -0,0 +1,247 @@
+#requires -Version 5.1
+# Checks that this machine can run the framework scripts and that the hash-pinned canonical inputs are intact.
+[CmdletBinding()]
+param(
+    [switch]$Json
+)
+
+$ErrorActionPreference = 'Stop'
+. (Join-Path $PSScriptRoot 'common.ps1')
+
+$repoRoot = Get-RepoRoot
+$isWindowsHost = [System.Environment]::OSVersion.Platform -eq [System.PlatformID]::Win32NT
+$checks = [System.Collections.Generic.List[object]]::new()
+
+function Add-Check {
+    param(
+        [Parameter(Mandatory = $true)][string]$Name,
+        [Parameter(Mandatory = $true)][ValidateSet('pass', 'warn', 'fail')][string]$Status,
+        [Parameter(Mandatory = $true)][string]$Detail,
+        [string]$Fix
+    )
+    $checks.Add([PSCustomObject]@{ name = $Name; status = $Status; detail = $Detail; fix = $Fix })
+}
+
+# --- Runtime -------------------------------------------------------------------------------------
+
+$psVersion = $PSVersionTable.PSVersion
+Add-Check -Name 'powershell' -Status 'pass' -Detail "$($PSVersionTable.PSEdition) $psVersion"
+
+if ($isWindowsHost) {
+    # Process scope is excluded: the prompts launch each script in a new process that won't inherit it.
+    $effectivePolicy = 'Restricted'
+    foreach ($scope in @('MachinePolicy', 'UserPolicy', 'CurrentUser', 'LocalMachine')) {
+        $policy = [string](Get-ExecutionPolicy -Scope $scope)
+        if ($policy -ne 'Undefined') { $effectivePolicy = $policy; break }
+    }
+    if ($effectivePolicy -in @('Restricted', 'AllSigned')) {
+        Add-Check -Name 'execution-policy' -Status 'fail' `
+            -Detail "Effective policy is '$effectivePolicy'; the unsigned .specify scripts the prompts run will be blocked." `
+            -Fix 'Set-ExecutionPolicy -Scope CurrentUser RemoteSigned (or run each script with powershell -ExecutionPolicy Bypass -File ...)'
+    } else {
+        Add-Check -Name 'execution-policy' -Status 'pass' -Detail "Effective policy is '$effectivePolicy'."
+    }
+}
+
+try {
+    Add-Type -AssemblyName System.IO.Compression.FileSystem
+    Add-Check -Name 'dotnet-zip' -Status 'pass' -Detail 'System.IO.Compression.FileSystem loads (used to read DOCX contracts).'
+} catch {
+    Add-Check -Name 'dotnet-zip' -Status 'fail' -Detail "Cannot load System.IO.Compression.FileSystem: $($_.Exception.Message)" `
+        -Fix 'Install .NET Framework 4.5+ (Windows PowerShell) or use PowerShell 7.'
+}
+
+$git = Get-Command git -ErrorAction SilentlyContinue
+if ($git) {
+    $gitVersion = (& git --version 2>$null) -join ' '
+    Add-Check -Name 'git' -Status 'pass' -Detail $gitVersion
+} else {
+    Add-Check -Name 'git' -Status 'fail' `
+        -Detail 'git is not on PATH. Feature branches cannot be created and only one feature per application workspace can be detected.' `
+        -Fix 'Install Git for Windows (winget install Git.Git) and reopen the terminal.'
+}
+
+$pandoc = Get-Command pandoc -ErrorAction SilentlyContinue
+if ($pandoc) {
+    Add-Check -Name 'pandoc' -Status 'pass' -Detail "Found at $($pandoc.Source)."
+} else {
+    Add-Check -Name 'pandoc' -Status 'warn' `
+        -Detail 'Not found. Only export-testing-strategy.ps1 needs it (maintainers re-extracting the testing strategy DOCX).' `
+        -Fix 'winget install JohnMacFarlane.Pandoc (optional)'
+}
+
+$code = Get-Command code -ErrorAction SilentlyContinue
+if ($code) {
+    # Recent VS Code builds bundle Copilot Chat, so it no longer appears in --list-extensions.
+    $installRoot = Split-Path -Parent (Split-Path -Parent $code.Source)
+    $bundledCandidates = @(Join-Path $installRoot 'resources\app\extensions\copilot') +
+        @(Get-ChildItem -LiteralPath $installRoot -Directory -ErrorAction SilentlyContinue |
+            ForEach-Object { Join-Path $_.FullName 'resources\app\extensions\copilot' })
+    $hasBundled = @($bundledCandidates | Where-Object { Test-Path -LiteralPath $_ -PathType Container }).Count -gt 0
+    $hasExtension = @(& { $ErrorActionPreference = 'Continue'; code --list-extensions 2>$null }) -match '^github\.copilot-chat$'
+    if ($hasBundled -or $hasExtension) {
+        Add-Check -Name 'vscode-copilot' -Status 'pass' -Detail 'VS Code with GitHub Copilot Chat is installed (runs the /speckit.* prompts).'
+    } else {
+        Add-Check -Name 'vscode-copilot' -Status 'warn' -Detail 'VS Code found, but GitHub Copilot Chat was not detected.' `
+            -Fix 'Update VS Code, or: code --install-extension GitHub.copilot-chat'
+    }
+} else {
+    Add-Check -Name 'vscode-copilot' -Status 'warn' -Detail "VS Code 'code' CLI not on PATH; cannot confirm Copilot Chat is installed."
+}
+
+# --- Application workspace -----------------------------------------------------------------------
+
+try {
+    $applicationRoot = Get-ApplicationRoot
+    Add-Check -Name 'app-root' -Status 'pass' -Detail "SPEC_LAYER_APP_ROOT = $applicationRoot"
+    if ($git) {
+        # Windows PowerShell 5.1 turns redirected native stderr into a terminating error under 'Stop'.
+        $insideWorkTree = & { $ErrorActionPreference = 'Continue'; git -C $applicationRoot rev-parse --is-inside-work-tree 2>$null }
+        if ($LASTEXITCODE -eq 0 -and $insideWorkTree -eq 'true') {
+            Add-Check -Name 'app-root-git' -Status 'pass' -Detail 'Application workspace is a git repository.'
+        } else {
+            Add-Check -Name 'app-root-git' -Status 'warn' `
+                -Detail 'Application workspace is not a git repository; create-new-feature.ps1 will skip the NNN-slug branch.' `
+                -Fix "git -C `"$applicationRoot`" init"
+        }
+    }
+} catch {
+    Add-Check -Name 'app-root' -Status 'fail' -Detail $_.Exception.Message `
+        -Fix "`$env:SPEC_LAYER_APP_ROOT = 'C:\work\my-application'   # an existing folder outside this repo"
+}
+
+# --- Canonical inputs ----------------------------------------------------------------------------
+# The gate scripts compare these files to pinned SHA-256 values; any drift blocks every phase.
+
+function Test-CanonicalInput {
+    param(
+        [Parameter(Mandatory = $true)][string]$Name,
+        [Parameter(Mandatory = $true)][string]$Path,
+        [string]$ExpectedSha256,
+        [string]$ContractPath
+    )
+
+    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
+        Add-Check -Name $Name -Status 'fail' -Detail "Missing: $Path" -Fix 'Restore the file from the framework repository (git checkout -- <path>).'
+        return
+    }
+
+    $item = Get-Item -LiteralPath $Path
+    # FILE_ATTRIBUTE_OFFLINE | RECALL_ON_OPEN | RECALL_ON_DATA_ACCESS mark a cloud-only placeholder.
+    $isPlaceholder = ([int64]$item.Attributes -band (0x1000 -bor 0x40000 -bor 0x400000)) -ne 0
+
+    try {
+        $stream = [System.IO.File]::OpenRead($item.FullName)
+        try {
+            $header = New-Object byte[] 4
+            $read = $stream.Read($header, 0, 4)
+        } finally { $stream.Dispose() }
+    } catch {
+        $hint = if ($isPlaceholder) { 'File is a cloud-only placeholder. Make it available offline (OneDrive: Always keep on this device).' } else { $null }
+        Add-Check -Name $Name -Status 'fail' -Detail "Cannot read $($item.Name): $($_.Exception.Message)" -Fix $hint
+        return
+    }
+
+    $magic = [System.BitConverter]::ToString($header, 0, $read).Replace('-', '')
+    if ($magic -eq 'D0CF11E0') {
+        Add-Check -Name $Name -Status 'fail' `
+            -Detail "$($item.Name) is an OLE2 container, not OOXML. A sensitivity label has likely encrypted it, or it was saved in a legacy format." `
+            -Fix 'Restore the original from git (git checkout -- <path>) and keep the clone outside a labelled/synced folder.'
+        return
+    }
+    if ($magic -notlike '504B*') {
+        Add-Check -Name $Name -Status 'fail' -Detail "$($item.Name) is not a ZIP/OOXML file (header $magic)." -Fix 'Restore the file from git.'
+        return
+    }
+
+    if ($ExpectedSha256) {
+        $actual = (Get-FileHash -LiteralPath $item.FullName -Algorithm SHA256).Hash
+        if ($actual -ne $ExpectedSha256) {
+            Add-Check -Name $Name -Status 'fail' `
+                -Detail "$($item.Name) SHA-256 $actual does not match the pinned $ExpectedSha256 in $(Split-Path -Leaf $ContractPath). check-prerequisites.ps1 will block every gate." `
+                -Fix 'Restore the file from git; if the source document was deliberately updated, re-run its export script and review the contract.'
+            return
+        }
+        Add-Check -Name $Name -Status 'pass' -Detail "$($item.Name) matches its pinned SHA-256."
+    } else {
+        Add-Check -Name $Name -Status 'pass' -Detail "$($item.Name) is readable OOXML."
+    }
+}
+
+$sadContractPath = Join-Path $repoRoot 'deliverables-template/md-templates/sad-v3.4-contract.json'
+$sadExpected = $null
+if (Test-Path -LiteralPath $sadContractPath -PathType Leaf) {
+    $sadExpected = (Get-Content -LiteralPath $sadContractPath -Raw | ConvertFrom-Json).sourceSha256
+}
+Test-CanonicalInput -Name 'sad-template' `
+    -Path (Join-Path $repoRoot 'deliverables-template/binary-templates/SAD/LMP Migration SAD (v3.4-final).docx') `
+    -ExpectedSha256 $sadExpected -ContractPath $sadContractPath
+
+$testingContractPath = Join-Path $repoRoot 'docs/testing-strategy/testing-strategy-contract.json'
+$testingExpected = $null
+if (Test-Path -LiteralPath $testingContractPath -PathType Leaf) {
+    $testingExpected = (Get-Content -LiteralPath $testingContractPath -Raw | ConvertFrom-Json).sourceSha256
+}
+Test-CanonicalInput -Name 'testing-strategy' `
+    -Path (Join-Path $repoRoot 'docs/testing-strategy/LMP Migration Testing Strategy.docx') `
+    -ExpectedSha256 $testingExpected -ContractPath $testingContractPath
+
+Test-CanonicalInput -Name 'complexity-calculator' `
+    -Path (Join-Path $repoRoot 'deliverables-template/binary-templates/complexity-calculator/Complexity Calculator-V4.1.xlsx')
+
+# Every gate runs these first, so a hash match alone is not enough (e.g. host-specific decoding bugs).
+foreach ($validator in @('validate-sad-contract', 'validate-testing-strategy')) {
+    try {
+        $validatorOutput = & { $ErrorActionPreference = 'Continue'; & (Join-Path $PSScriptRoot "$validator.ps1") -Json 2>&1 }
+        $validatorExit = $LASTEXITCODE
+    } catch {
+        $validatorOutput = $_.Exception.Message
+        $validatorExit = 1
+    }
+    if ($validatorExit -eq 0) {
+        Add-Check -Name $validator -Status 'pass' -Detail 'Passes on this PowerShell host.'
+    } else {
+        $detail = ((($validatorOutput | Out-String) -replace '\s+', ' ').Trim())
+        if ($detail.Length -gt 300) { $detail = $detail.Substring(0, 300) + '...' }
+        Add-Check -Name $validator -Status 'fail' -Detail "Fails on this PowerShell host, so every gate will fail: $detail" `
+            -Fix 'Restore the canonical DOCX/contract from git, or run the scripts with PowerShell 7 (pwsh).'
+    }
+}
+
+$missingKnowledge = @(
+    'docs/INDEX.md',
+    'docs/adrs/_catalog.json',
+    'docs/patterns/_catalog.json',
+    'docs/cpf/INDEX.md',
+    'docs/mec-reference.md',
+    'docs/backlog-playbook/v1/Backlog-Playbook-v1.csv',
+    'deliverables-template/md-templates/sad-v3.4-coverage-map.json',
+    'deliverables-template/md-templates/G-sad-baseline.md',
+    '.specify/memory/constitution.md'
+) | Where-Object { -not (Test-Path -LiteralPath (Join-Path $repoRoot $_) -PathType Leaf) }
+if ($missingKnowledge.Count -gt 0) {
+    Add-Check -Name 'knowledge-sources' -Status 'fail' -Detail "Missing: $($missingKnowledge -join ', ')" -Fix 'Restore the files from git.'
+} else {
+    Add-Check -Name 'knowledge-sources' -Status 'pass' -Detail 'Indexes, catalogs, MEC reference, Backlog Playbook and constitution are present.'
+}
+
+# --- Report --------------------------------------------------------------------------------------
+
+$failed = @($checks | Where-Object { $_.status -eq 'fail' })
+$warned = @($checks | Where-Object { $_.status -eq 'warn' })
+$overall = if ($failed.Count -gt 0) { 'fail' } elseif ($warned.Count -gt 0) { 'warn' } else { 'pass' }
+
+if ($Json) {
+    [PSCustomObject]@{ status = $overall; frameworkRoot = $repoRoot; checks = $checks } | ConvertTo-Json -Depth 4
+} else {
+    foreach ($check in $checks) {
+        $color = switch ($check.status) { 'pass' { 'Green' } 'warn' { 'Yellow' } default { 'Red' } }
+        Write-Host ("[{0}] {1,-22} {2}" -f $check.status.ToUpperInvariant(), $check.name, $check.detail) -ForegroundColor $color
+        if ($check.status -ne 'pass' -and $check.fix) { Write-Host ("       {0,-22} fix: {1}" -f '', $check.fix) }
+    }
+    Write-Host ''
+    Write-Host ("doctor: {0} ({1} failed, {2} warnings)" -f $overall.ToUpperInvariant(), $failed.Count, $warned.Count)
+}
+
+if ($failed.Count -gt 0) { exit 1 }
+exit 0
diff --git a/.specify/scripts/powershell/finalize-publication.ps1 b/.specify/scripts/powershell/finalize-publication.ps1
index faa4eff..fbde64e 100644
--- a/.specify/scripts/powershell/finalize-publication.ps1
+++ b/.specify/scripts/powershell/finalize-publication.ps1
@@ -23,11 +23,20 @@ if ($DeliverableId -and $selectedEntries.Count -ne $DeliverableId.Count) { Write
 foreach ($entry in $selectedEntries) {
     $path = [System.IO.Path]::GetFullPath((Join-Path $paths.DELIVERABLES_DIR $entry.path))
     if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
+        if ($entry.id -eq 'G-3' -and $entry.applicability -eq 'Pending' -and -not (Test-Path -LiteralPath $paths.TEST_PLAN -PathType Leaf)) {
+            if ($DeliverableId -and 'G-3' -in $DeliverableId) { Write-Error 'Cannot publish G-3 because the canonical feature-root G-test-plan.md is missing.'; exit 1 }
+            continue
+        }
         if ($entry.frameworkManaged) { Write-Error "Managed deliverable $($entry.id) is missing at $path."; exit 1 }
         continue
     }
     $content = Get-Content -LiteralPath $path -Raw
     $baseContent = Get-PublicationContentBody -Content $content
+    if ($entry.id -eq 'G-3') {
+        if (-not (Test-Path -LiteralPath $paths.TEST_PLAN -PathType Leaf)) { Write-Error 'Cannot publish G-3 because the canonical feature-root G-test-plan.md is missing.'; exit 1 }
+        $canonicalBody = Get-PublicationContentBody -Content (Get-Content -LiteralPath $paths.TEST_PLAN -Raw)
+        if ($baseContent -cne $canonicalBody) { Write-Error 'G-3 published content differs from the canonical root G-test-plan.md. Render the source copy before finalization.'; exit 1 }
+    }
     $contentHash = Get-Sha256ForText -Text $baseContent
     $version = [int]$entry.currentVersion
     $history = @($entry.history | Where-Object { $null -ne $_ })
diff --git a/.specify/scripts/powershell/setup-publication.ps1 b/.specify/scripts/powershell/setup-publication.ps1
index e310aab..cba5650 100644
--- a/.specify/scripts/powershell/setup-publication.ps1
+++ b/.specify/scripts/powershell/setup-publication.ps1
@@ -24,7 +24,7 @@ $definitions = @(
     [PSCustomObject]@{ id='C-3'; file='C-cost-profile.md'; template='C-cost-profile.md'; managed=$true; applicability='Applicable'; status='Not Started'; sourceBasis='architecture Section 13, plan, and calculator evidence' },
     [PSCustomObject]@{ id='F-1'; file='F-caf-eligibility-assessment.md'; template='F-caf-eligibility-assessment.md'; managed=$false; applicability='External'; status='Not Generated'; sourceBasis='external governance layer; versioned here only when externally supplied' },
     [PSCustomObject]@{ id='G-2'; file='G-sad-baseline.md'; template='G-sad-baseline.md'; managed=$true; applicability='Applicable'; status='Not Started'; sourceBasis='requirements, architecture Section 16, decisions, risks, and plan' },
-    [PSCustomObject]@{ id='G-3'; file='../G-test-plan.md'; template='G-test-plan.md'; managed=$false; applicability='Applicable'; status='Canonical Source'; sourceBasis='feature-root G-test-plan.md' },
+    [PSCustomObject]@{ id='G-3'; file='G-test-plan.md'; template='G-test-plan.md'; managed=$true; applicability='Applicable'; status='In Progress'; sourceBasis='full-fidelity published copy of feature-root G-test-plan.md' },
     [PSCustomObject]@{ id='G-4'; file='G-mec-assessment.md'; template='G-mec-assessment.md'; managed=$true; applicability='Applicable'; status='Not Started'; sourceBasis='MEC requirements evidence, architecture Section 7, and spec Section 5' },
     [PSCustomObject]@{ id='G-6'; file='G-adr-risk-register.md'; template='G-adr-risk-register.md'; managed=$true; applicability='Applicable'; status='Not Started'; sourceBasis='authoritative decision and risk records' },
     [PSCustomObject]@{ id='G-7'; file='complexity-calculator.md'; template='complexity-calculator.md'; managed=$true; applicability='Pending'; status='Not Started'; sourceBasis='architecture Section 8A and signed calculator evidence' },
@@ -48,8 +48,15 @@ $deliverables = foreach ($definition in $definitions) {
     if ($definition.managed -and $selected) {
         $destination = Join-Path $paths.DELIVERABLES_DIR $definition.file
         if (-not (Test-Path -LiteralPath $destination -PathType Leaf)) {
-            Copy-Item -LiteralPath (Join-Path $templatesDirectory $definition.template) -Destination $destination
-            $materialized.Add($definition.file)
+            if ($definition.id -eq 'G-3') {
+                if (Test-Path -LiteralPath $paths.TEST_PLAN -PathType Leaf) {
+                    Copy-Item -LiteralPath $paths.TEST_PLAN -Destination $destination
+                    $materialized.Add($definition.file)
+                }
+            } else {
+                Copy-Item -LiteralPath (Join-Path $templatesDirectory $definition.template) -Destination $destination
+                $materialized.Add($definition.file)
+            }
         }
     }
     $existing = $existingById[$definition.id]
@@ -60,13 +67,13 @@ $deliverables = foreach ($definition in $definitions) {
         path = $definition.file
         template = $definition.template
         frameworkManaged = $definition.managed
-        applicability = if ($existing -and $existing.applicability) { $existing.applicability } else { $definition.applicability }
-        status = if ($existing -and $existing.status) { $existing.status } else { $definition.status }
+        applicability = if ($definition.id -eq 'G-3' -and -not (Test-Path -LiteralPath $paths.TEST_PLAN -PathType Leaf)) { 'Pending' } elseif ($definition.id -eq 'G-3' -and $existing -and $existing.applicability -eq 'Pending') { 'Applicable' } elseif ($existing -and $existing.applicability) { $existing.applicability } else { $definition.applicability }
+        status = if ($definition.id -eq 'G-3' -and -not (Test-Path -LiteralPath $paths.TEST_PLAN -PathType Leaf)) { 'Not Started' } elseif ($definition.id -eq 'G-3' -and $existing -and $existing.status -in @('Canonical Source','Not Started')) { 'In Progress' } elseif ($existing -and $existing.status) { $existing.status } else { $definition.status }
         sourceBasis = $definition.sourceBasis
         currentVersion = if ($existing -and $null -ne $existing.currentVersion) { [int]$existing.currentVersion } else { 0 }
         contentHash = if ($existing) { $existing.contentHash } else { $null }
         history = $existingHistory
-        notes = if ($existing) { $existing.notes } else { $null }
+        notes = if ($definition.id -eq 'G-3' -and -not (Test-Path -LiteralPath $paths.TEST_PLAN -PathType Leaf)) { 'Pending: canonical feature-root G-test-plan.md does not exist yet; no deliverable copy was created.' } elseif ($definition.id -eq 'G-3') { 'Full-fidelity published copy of canonical feature-root G-test-plan.md; human approval state is unchanged.' } elseif ($existing) { $existing.notes } else { $null }
     }
 }
 
diff --git a/.specify/scripts/powershell/sync-records.ps1 b/.specify/scripts/powershell/sync-records.ps1
index e889a57..0e03c24 100644
--- a/.specify/scripts/powershell/sync-records.ps1
+++ b/.specify/scripts/powershell/sync-records.ps1
@@ -105,13 +105,23 @@ function Write-RecordIndex {
     } | Sort-Object Name)
     $index = @("# $Title Index", '', "Source-of-truth records: $([System.IO.Path]::GetFileName($Directory))", '', '| ID | Title | Source File |', '| --- | --- | --- |')
     foreach ($file in $files) {
-        $first = Get-Content -LiteralPath $file | Where-Object { $_ -match '^#\s+' } | Select-Object -First 1
+        $first = Get-Content -LiteralPath $file.FullName | Where-Object { $_ -match '^#\s+' } | Select-Object -First 1
         $recordTitle = if ($first) { $first -replace '^#\s+', '' } else { $file.BaseName }
         $id = ($file.BaseName -split '-')[0..1] -join '-'
         $index += "| $id | $($recordTitle.Replace('|','/')) | $($file.Name) |"
     }
     if ($Title -like 'Requirements:*') {
-        $index += @('', '## Requirements Review Gate', '', '| Gate | Status |', '| --- | --- |', '| Requirements Review Gate | Not Started - human review required |', '', '**Reviewed by**:  | **Date**:  | **Outcome**: Pending human review')
+        # Keep any human-recorded gate state; only a missing gate gets the default block.
+        $existingGate = $null
+        if (Test-Path -LiteralPath $IndexPath -PathType Leaf) {
+            $gateMatch = [regex]::Match((Get-Content -LiteralPath $IndexPath -Raw), '(?ms)^## Requirements Review Gate\b.*?(?=^## |\z)')
+            if ($gateMatch.Success) { $existingGate = $gateMatch.Value.TrimEnd() }
+        }
+        if ($existingGate) {
+            $index += @('', $existingGate)
+        } else {
+            $index += @('', '## Requirements Review Gate', '', '| Gate | Status |', '| --- | --- |', '| Requirements Review Gate | Not Started - human review required |', '', '**Reviewed by**:  | **Date**:  | **Outcome**: Pending human review')
+        }
     }
     Set-Content -LiteralPath $IndexPath -Value $index -Encoding UTF8
     return $files.Count
@@ -122,3 +132,4 @@ function Write-RecordIndex {
 
 $result = @{ feature = $FeatureDirName; requirements = $reqFiles; decisions = $adrFiles; risks = $riskFiles; migratedRequirements = $reqCount; migratedDecisions = $adrCount; migratedRisks = $riskCount }
 Write-ScriptResult -Data $result -Json:$Json
+exit 0
diff --git a/.specify/scripts/powershell/test-implementation-backlog.ps1 b/.specify/scripts/powershell/test-implementation-backlog.ps1
index ef7e476..ac69cf0 100644
--- a/.specify/scripts/powershell/test-implementation-backlog.ps1
+++ b/.specify/scripts/powershell/test-implementation-backlog.ps1
@@ -1,4 +1,4 @@
-#requires -Version 5.1
+﻿#requires -Version 5.1
 # Self-contained regression tests for architecture-derived implementation backlog validation.
 [CmdletBinding()]
 param([switch]$Json)
diff --git a/.specify/scripts/powershell/test-publication-workflow.ps1 b/.specify/scripts/powershell/test-publication-workflow.ps1
index f9530ff..4beca0a 100644
--- a/.specify/scripts/powershell/test-publication-workflow.ps1
+++ b/.specify/scripts/powershell/test-publication-workflow.ps1
@@ -1,10 +1,10 @@
-#requires -Version 5.1
+﻿#requires -Version 5.1
 # Self-contained smoke test for rerunnable publication and per-deliverable version history.
 [CmdletBinding()]
-param([switch]$Json)
+param([switch]$Json, [string]$WorkspaceRoot = ([System.IO.Path]::GetTempPath()))
 
 $ErrorActionPreference = 'Stop'
-$tempRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("spec-layer-publication-" + [guid]::NewGuid().ToString('N'))
+$tempRoot = Join-Path $WorkspaceRoot ("spec-layer-publication-" + [guid]::NewGuid().ToString('N'))
 $featureName = '001-publication-fixture'
 $featureRoot = Join-Path (Join-Path $tempRoot 'specs') $featureName
 $previousAppRoot = $env:SPEC_LAYER_APP_ROOT
@@ -15,7 +15,11 @@ try {
     New-Item -ItemType Directory -Path (Join-Path $featureRoot 'risks') -Force | Out-Null
     '# Requirements fixture' | Set-Content -LiteralPath (Join-Path $featureRoot 'requirements.md') -Encoding UTF8
     '# Architecture fixture' | Set-Content -LiteralPath (Join-Path $featureRoot 'architecture.md') -Encoding UTF8
-    '# Test Plan fixture' | Set-Content -LiteralPath (Join-Path $featureRoot 'G-test-plan.md') -Encoding UTF8
+    @('# Test Plan fixture','','## Review Brief','','Draft proposal; appointments and environment evidence remain pending.',
+        "[Human inputs](/specs/$featureName/requirements/testing-profile.md#human-input-and-decision-register)",
+        '[Case mappings](#high-level-case-outlines)','','## Test Strategy','','### High-Level Case Outlines','',
+        '| Case ID | Origin | Disposition |','| --- | --- | --- |','| CASE-001 | Proposed | Pending — ACT-001 |') |
+        Set-Content -LiteralPath (Join-Path $featureRoot 'G-test-plan.md') -Encoding UTF8
     '# ADR index fixture' | Set-Content -LiteralPath (Join-Path $featureRoot 'decisions/index.md') -Encoding UTF8
     '# Risk index fixture' | Set-Content -LiteralPath (Join-Path $featureRoot 'risks/index.md') -Encoding UTF8
     $env:SPEC_LAYER_APP_ROOT = $tempRoot
@@ -27,14 +31,21 @@ try {
     & (Join-Path $PSScriptRoot 'validate-publication.ps1') -FeatureDirName $featureName -DeliverableId 'C-3' -Json | Out-Null
 
     & (Join-Path $PSScriptRoot 'setup-publication.ps1') -FeatureDirName $featureName -Json | Out-Null
+    $publishedTestPlanPath = Join-Path $featureRoot 'deliverables/G-test-plan.md'
+    if (-not (Test-Path -LiteralPath $publishedTestPlanPath)) { throw 'Full setup did not publish the canonical G-3 Test Plan under deliverables.' }
+    if ((Get-Content -LiteralPath (Join-Path $featureRoot 'G-test-plan.md') -Raw).Trim() -ne (Get-Content -LiteralPath $publishedTestPlanPath -Raw).Trim()) { throw 'Initial G-3 publication differs from its canonical source.' }
+    $publishedBody = Get-Content -LiteralPath $publishedTestPlanPath -Raw
+    if ($publishedBody.IndexOf('## Review Brief') -ge $publishedBody.IndexOf('## Test Strategy') -or -not $publishedBody.Contains('| CASE-001 | Proposed | Pending — ACT-001 |')) { throw 'Publication lost the source-owned opening brief or detailed pending case mapping.' }
     'Fixture publication content.' | Add-Content -LiteralPath (Join-Path $featureRoot 'deliverables/G-adr-risk-register.md') -Encoding UTF8
     'Evidence survives reruns.' | Set-Content -LiteralPath (Join-Path $featureRoot 'deliverables/evidence/source.txt') -Encoding UTF8
     & (Join-Path $PSScriptRoot 'finalize-publication.ps1') -FeatureDirName $featureName -Json | Out-Null
     & (Join-Path $PSScriptRoot 'validate-publication.ps1') -FeatureDirName $featureName -Json | Out-Null
     $first = Get-Content -LiteralPath (Join-Path $featureRoot 'deliverables/manifest.json') -Raw | ConvertFrom-Json
     $firstG6 = $first.deliverables | Where-Object { $_.id -eq 'G-6' }
+    $firstG3 = $first.deliverables | Where-Object { $_.id -eq 'G-3' }
     if ($firstG6.currentVersion -ne 1) { throw 'First publication did not assign G-6 version 1.' }
     if (@($firstG6.history).Count -ne 1) { throw "First publication produced $(@($firstG6.history).Count) G-6 history entries; expected 1." }
+    if ($firstG3.path -ne 'G-test-plan.md' -or -not $firstG3.frameworkManaged -or $firstG3.currentVersion -ne 1) { throw 'G-3 was not tracked as a managed deliverable version 1.' }
 
     & (Join-Path $PSScriptRoot 'setup-publication.ps1') -FeatureDirName $featureName -Json | Out-Null
     $afterSecondSetup = Get-Content -LiteralPath (Join-Path $featureRoot 'deliverables/manifest.json') -Raw | ConvertFrom-Json
@@ -43,24 +54,52 @@ try {
     & (Join-Path $PSScriptRoot 'finalize-publication.ps1') -FeatureDirName $featureName -Json | Out-Null
     $second = Get-Content -LiteralPath (Join-Path $featureRoot 'deliverables/manifest.json') -Raw | ConvertFrom-Json
     $secondG6 = $second.deliverables | Where-Object { $_.id -eq 'G-6' }
+    $secondG3 = $second.deliverables | Where-Object { $_.id -eq 'G-3' }
     if ($secondG6.currentVersion -ne 1) { throw 'Unchanged rerun incorrectly incremented G-6.' }
     if (@($secondG6.history).Count -ne 1) { throw "Unchanged rerun produced $(@($secondG6.history).Count) G-6 history entries; expected 1." }
+    if ($secondG3.currentVersion -ne 1 -or @($secondG3.history).Count -ne 1) { throw 'Unchanged rerun incorrectly changed G-3 history.' }
 
     'Changed requirement.' | Add-Content -LiteralPath (Join-Path $featureRoot 'requirements.md') -Encoding UTF8
+    'Updated canonical Test Plan.' | Add-Content -LiteralPath (Join-Path $featureRoot 'G-test-plan.md') -Encoding UTF8
     & (Join-Path $PSScriptRoot 'setup-publication.ps1') -FeatureDirName $featureName -Json | Out-Null
     'Regenerated decision content.' | Add-Content -LiteralPath (Join-Path $featureRoot 'deliverables/G-adr-risk-register.md') -Encoding UTF8
+    Copy-Item -LiteralPath (Join-Path $featureRoot 'G-test-plan.md') -Destination $publishedTestPlanPath -Force
     & (Join-Path $PSScriptRoot 'finalize-publication.ps1') -FeatureDirName $featureName -Json | Out-Null
     & (Join-Path $PSScriptRoot 'validate-publication.ps1') -FeatureDirName $featureName -Json | Out-Null
     $third = Get-Content -LiteralPath (Join-Path $featureRoot 'deliverables/manifest.json') -Raw | ConvertFrom-Json
     $thirdG6 = $third.deliverables | Where-Object { $_.id -eq 'G-6' }
+    $thirdG3 = $third.deliverables | Where-Object { $_.id -eq 'G-3' }
     if ($thirdG6.currentVersion -ne 2 -or @($thirdG6.history).Count -ne 2) { throw "Changed rerun produced G-6 version $($thirdG6.currentVersion) with $(@($thirdG6.history).Count) history entries; expected version 2 with 2 entries." }
+    if ($thirdG3.currentVersion -ne 2 -or @($thirdG3.history).Count -ne 2) { throw 'Changed canonical test plan did not increment G-3 to version 2.' }
     if (-not (Test-Path -LiteralPath (Join-Path $featureRoot 'deliverables/evidence/source.txt'))) { throw 'Rerun removed evidence.' }
 
     'Source changed after publication.' | Add-Content -LiteralPath (Join-Path $featureRoot 'requirements.md') -Encoding UTF8
     & (Join-Path $PSScriptRoot 'validate-publication.ps1') -FeatureDirName $featureName -Json 2>$null | Out-Null
     if ($LASTEXITCODE -eq 0) { throw 'Stale source fingerprint was not rejected.' }
 
-    $result = @{ passed=$true; scopedPublication=$true; publicationRuns=$third.publicationRun; g6Version=$thirdG6.currentVersion; g6History=@($thirdG6.history).Count; staleSourceRejected=$true }
+    $pendingFeatureName = '002-publication-pending-test-plan'
+    $pendingFeatureRoot = Join-Path (Join-Path $tempRoot 'specs') $pendingFeatureName
+    foreach ($directory in @('requirements','decisions','risks')) { New-Item -ItemType Directory -Path (Join-Path $pendingFeatureRoot $directory) -Force | Out-Null }
+    '# Pending requirements fixture' | Set-Content -LiteralPath (Join-Path $pendingFeatureRoot 'requirements.md') -Encoding UTF8
+    & (Join-Path $PSScriptRoot 'setup-publication.ps1') -FeatureDirName $pendingFeatureName -Json | Out-Null
+    $pendingDeliverablePath = Join-Path $pendingFeatureRoot 'deliverables/G-test-plan.md'
+    if (Test-Path -LiteralPath $pendingDeliverablePath) { throw 'Publication invented a G-3 deliverable before the canonical Test Plan existed.' }
+    & (Join-Path $PSScriptRoot 'finalize-publication.ps1') -FeatureDirName $pendingFeatureName -Json | Out-Null
+    & (Join-Path $PSScriptRoot 'validate-publication.ps1') -FeatureDirName $pendingFeatureName -Json | Out-Null
+    $pendingManifest = Get-Content -LiteralPath (Join-Path $pendingFeatureRoot 'deliverables/manifest.json') -Raw | ConvertFrom-Json
+    $pendingG3 = $pendingManifest.deliverables | Where-Object { $_.id -eq 'G-3' }
+    if ($pendingG3.applicability -ne 'Pending' -or $pendingG3.status -ne 'Not Started') { throw 'G-3 without a source must remain Pending/Not Started.' }
+    '# Newly authored canonical Test Plan' | Set-Content -LiteralPath (Join-Path $pendingFeatureRoot 'G-test-plan.md') -Encoding UTF8
+    & (Join-Path $PSScriptRoot 'setup-publication.ps1') -FeatureDirName $pendingFeatureName -Json | Out-Null
+    $activatedManifest = Get-Content -LiteralPath (Join-Path $pendingFeatureRoot 'deliverables/manifest.json') -Raw | ConvertFrom-Json
+    $activatedG3 = $activatedManifest.deliverables | Where-Object { $_.id -eq 'G-3' }
+    if ($activatedG3.applicability -ne 'Applicable' -or $activatedG3.status -ne 'In Progress' -or -not (Test-Path -LiteralPath $pendingDeliverablePath)) { throw 'G-3 did not become an In Progress publication when its canonical source was added.' }
+    if ((Get-Content -LiteralPath (Join-Path $pendingFeatureRoot 'G-test-plan.md') -Raw).Trim() -ne (Get-Content -LiteralPath $pendingDeliverablePath -Raw).Trim()) { throw 'Activated G-3 publication differs from its canonical source.' }
+    if ((Get-Content -LiteralPath $pendingDeliverablePath -Raw) -match '## Review Brief') { throw 'Publication invented a brief absent from its canonical source.' }
+    & (Join-Path $PSScriptRoot 'finalize-publication.ps1') -FeatureDirName $pendingFeatureName -Json | Out-Null
+    & (Join-Path $PSScriptRoot 'validate-publication.ps1') -FeatureDirName $pendingFeatureName -Json | Out-Null
+
+    $result = @{ passed=$true; scopedPublication=$true; publicationRuns=$third.publicationRun; g3Version=$thirdG3.currentVersion; g3History=@($thirdG3.history).Count; g6Version=$thirdG6.currentVersion; g6History=@($thirdG6.history).Count; staleSourceRejected=$true; pendingG3Skipped=$true; pendingG3Activated=$true }
     if ($Json) { $result | ConvertTo-Json -Depth 5 } else { $result.GetEnumerator() | ForEach-Object { Write-Host ("{0}: {1}" -f $_.Key, $_.Value) } }
 } finally {
     $env:SPEC_LAYER_APP_ROOT = $previousAppRoot
diff --git a/.specify/scripts/powershell/test-testing-workflow.ps1 b/.specify/scripts/powershell/test-testing-workflow.ps1
index 3b22859..60d144d 100644
--- a/.specify/scripts/powershell/test-testing-workflow.ps1
+++ b/.specify/scripts/powershell/test-testing-workflow.ps1
@@ -1,12 +1,12 @@
-#requires -Version 5.1
+﻿#requires -Version 5.1
 # Self-contained positive-path smoke test for testing profile, Test Plan, and testing task validators.
 [CmdletBinding()]
-param([switch]$Json)
+param([switch]$Json, [string]$WorkspaceRoot = ([System.IO.Path]::GetTempPath()))
 
 $ErrorActionPreference = 'Stop'
 . (Join-Path $PSScriptRoot 'common.ps1')
 
-$tempRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("spec-layer-testing-workflow-" + [guid]::NewGuid().ToString('N'))
+$tempRoot = Join-Path $WorkspaceRoot ("spec-layer-testing-workflow-" + [guid]::NewGuid().ToString('N'))
 New-Item -ItemType Directory -Path $tempRoot -Force | Out-Null
 $requirementsDir = Join-Path $tempRoot 'requirements'
 New-Item -ItemType Directory -Path $requirementsDir -Force | Out-Null
@@ -18,7 +18,7 @@ $types = @(
     @{ Name='Migration tool'; Baseline='Required'; Condition='All migrations'; Environment='Source test environment' },
     @{ Name='Application installation'; Baseline='Required'; Condition='All migrations'; Environment='PPE' },
     @{ Name='Smoke/regression'; Baseline='Required'; Condition='All migrations'; Environment='PPE' },
-    @{ Name='Change-based functional'; Baseline='Conditional'; Condition='Migration changes affect behavior'; Environment='PPE' },
+    @{ Name='Change-based functional'; Baseline='Conditional'; Condition='Integration scenarios for Re-Factor and Migration Team refactoring within Re-Host/Re-Platform; otherwise integration scenarios are mandatory UAT owned by Application Team'; Environment='PPE' },
     @{ Name='Full functional'; Baseline='Conditional'; Condition='Rearchitect'; Environment='PPE' },
     @{ Name='Performance and baseline'; Baseline='Required'; Condition='All migrations'; Environment='Production representative PPE' },
     @{ Name='High availability'; Baseline='Required'; Condition='All migrations'; Environment='Production representative PPE' },
@@ -26,9 +26,19 @@ $types = @(
     @{ Name='Security testing'; Baseline='Required'; Condition='All migrations'; Environment='PPE' },
     @{ Name='Security penetration testing'; Baseline='Required'; Condition='All migrations'; Environment='Production' },
     @{ Name='Operational acceptance testing'; Baseline='Required'; Condition='All migrations'; Environment='Production' },
-    @{ Name='User acceptance testing'; Baseline='Required'; Condition='All migrations no exemption'; Environment='PPE' }
+    @{ Name='User acceptance testing'; Baseline='Required'; Condition='All migrations no exemption; integration scenarios when no Migration Team refactoring occurs are owned and executed by Application Team'; Environment='PPE' }
 )
 $slugs = @('CONNECTIVITY','UNIT','DATA-MIGRATION','MIGRATION-TOOL','INSTALLATION','SMOKE-REGRESSION','CHANGE-FUNCTIONAL','FULL-FUNCTIONAL','PERFORMANCE','HA','DR','SECURITY','PENETRATION','OAT','UAT')
+$oatIds = @()
+foreach ($group in @(@{ prefix='GD'; count=24 }, @{ prefix='CHG'; count=9 }, @{ prefix='VAL'; count=18 })) {
+    for ($number = 1; $number -le $group.count; $number++) { $oatIds += "L2-OAT-$($group.prefix)-$('{0:D2}' -f $number)" }
+}
+$oatArchitectureRows = foreach ($id in $oatIds) {
+    "| $id | Fixture scenario | Recommended | As-is evidence: source baseline recorded | Proposed Azure target: evidenced service mapping | Objective: measurable operational threshold | Production actions: approved change CHG-123; bounded impact; communications; stop conditions; recovery readiness | Application Operations; runbook OAT-001; evidence result link; ADR-0001/RSK-001 |"
+}
+$oatPlanRows = foreach ($id in $oatIds) {
+    "| $id | Fixture scenario | Recommended | As-is evidence: source baseline recorded | Proposed Azure target: evidenced service mapping | Verify observable operational result and measurable threshold; no fault injection | Production during Cutover; approved change CHG-123; bounded impact; communications; stop conditions; recovery readiness | Application Operations; runbook OAT-001; evidence result link; Planned |"
+}
 
 try {
     @('# NFR-001: Testing outcome','', '- ID: NFR-001','- Type: Non-Functional','- Status: Proposed','- Priority: Must','- Source: Test fixture','- Primary Layer(s): architecture-testing','','## Intent / Problem Addressed','','Prove testing workflow validation.','','## Requirement','','The migration shall satisfy the approved testing target.','','## Acceptance Criteria / Metric / Target','','All approved tests pass.','','## Verification','','Review test evidence.') | Set-Content -LiteralPath (Join-Path $requirementsDir 'NFR-001-testing-outcome.md') -Encoding UTF8
@@ -37,6 +47,16 @@ try {
     foreach ($type in $types) {
         $profileLines += "| $($type.Name) | $($type.Baseline) | Applicable | $($type.Condition) | NFR-001 | Approved measurable pass target | $($type.Environment) | Reviewed fixture evidence | Migration Team | Application Owner | N/A |"
     }
+    $profileLines += @('','## Evidence Sources and Conflicts','','| Source ID | Artifact / Version / Date | Exact Locator | Claim / Scope | Evidence Class | Authority / Governing Rule | Access / Applicability / Freshness | Conflict / Action ID |','| --- | --- | --- | --- | --- | --- | --- | --- |','| SRC-001 | Fixture source repository v1.2 / 2026-10-06 | repo/tests @ abc123 | Test suite inventory for fixture behaviors | Sourced fact | Application Team repository; LMP strategy governs test requirements | Readable; fixture scope; current for regression | None |','| SRC-002 | Fixture CI run-123 / 2026-10-06 | CI report run-123 | Three cases passed; remaining cases unverified | Sourced fact | Run report governs only its recorded scope | Available; applicable to fixture; dated | None |','','| Conflict ID | Competing Claims and Source IDs / Locators | Affected Scope | Governing Rule (not assumed source precedence) | Decision Owner / Action ID | Status | Downstream Impact |','| --- | --- | --- | --- | --- | --- | --- |','| None identified | Compared SRC-001 and SRC-002 | Fixture test assets | LMP strategy remains governing | Fixture reviewer; N/A | Resolved with evidence | No conflicting scope/count claims |','','## Test Asset Inventory','','| Asset ID | Asset Type / Supplied Case IDs | Version / Locator / Owner | Reported Availability | Reuse Health | Coverage / Related Families | Latest Run / Result Evidence | Applicability / Compatibility | Validation Action ID |','| --- | --- | --- | --- | --- | --- | --- | --- | --- |','| AST-001 | Test repository / CASE-001 through CASE-015 | v1.2 repo/tests; Application Team | Verified-available | Adapt | 3 verified cases; remaining case families reviewed | 2026-10-06 CI run-123 passed | Fixture flows only; compatible with reviewed build | AUT-01 |','| AST-002 | Existing case catalog / supplied identifiers | version and locator requested; Application Team | Available-unverified | Undecided | Case count and flow coverage unknown | Not run | Applicability needs owner confirmation | AUT-02 |','','## Human Input and Decision Register','','| Action ID | Exact Question / Decision / Conflict to Resolve | Why Needed / Evidence Expected and Location | Contact / Accountable Coordinator | Needed By / Gate | Linked REQ/NFR / ADR / Risk / Flow / Asset | Blocking Impact | Status | Answer / Evidence / Validation |','| --- | --- | --- | --- | --- | --- | --- | --- | --- |')
+    for ($index = 0; $index -lt $types.Count; $index++) {
+        $actionId = "AUT-$('{0:D2}' -f ($index + 1))"
+        $profileLines += "| $actionId | Confirmed partial coverage and uncovered scope for $($types[$index].Name) | Dated case inventory and CI evidence at SRC-002 / run-123 | Application Team contact: Fixture owner; coordinator: Migration Test coordinator | Scope review gate / date confirmed | NFR-001 RSK-001 | Residual cases are sized for review; no coverage inferred beyond run-123 | Validated | Application Team response 2026-10-06; SRC-002 run-123; coverage limited to three cases |"
+    }
+    $profileLines += @('','## Automation Availability Review','','| Review ID | Test Type | Automation Status | Evidence / Application Team Response | Verified Coverage / Uncovered Scope | Application Team Review Action ID / Contact / Owner / Needed By / Status | Requirement / ADR / Risk |','| --- | --- | --- | --- | --- | --- | --- |')
+    for ($index = 0; $index -lt $types.Count; $index++) {
+        $actionId = "AUT-$('{0:D2}' -f ($index + 1))"
+        $profileLines += "| $actionId | $($types[$index].Name) | Partial | Application Team response 2026-10-06: repo/tests run-123 confirms partial coverage | 3 verified cases; remaining negative paths unverified | $actionId; Application Team contact: Fixture owner; owner: Migration Test coordinator; needed-by: scope review; status: Validated | NFR-001 RSK-001 |"
+    }
     $profileLines += @('','## Test Readiness Inputs','','| Readiness Area | Status | Required Evidence / Outcome | Owner | Requirement / ADR / Risk |','| --- | --- | --- | --- | --- |')
     foreach ($area in @('Existing test plans cases scripts and results','Automation repositories and maintenance capacity','Performance baseline and volumetrics','Test environments and production comparability','Monitoring and evidence capture','Test data identities access and privacy controls','Defect thresholds triage and risk acceptance','Named test execution and deliverable approvers')) {
         $profileLines += "| $area | Ready | Reviewed evidence | Application Owner | NFR-001 |"
@@ -47,6 +67,18 @@ try {
     $architecturePath = Join-Path $tempRoot 'architecture.md'
     $architectureLines = @('# Architecture Fixture','','### 14.1 Migration Testability Matrix','','| Test Type | Requirements / Profile Disposition | Resolved Applicability / R-Type Basis | Owning Architecture Section(s) | Target Mechanism Under Test | Approved Environment / Production Comparability | Observability / Evidence Path | Data / Identity / Access Prerequisites | Readiness | ADR/Risk |','| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |')
     foreach ($type in $types) { $architectureLines += "| $($type.Name) | NFR-001 Applicable | Applicable — fixture basis | Section 12 | Approved mechanism | $($type.Environment) | Results repository | Approved prerequisites | Ready | N/A |" }
+    $architectureLines += @('','### 14.2 OAT Scenario Applicability Matrix','','| Catalog ID | Scenario | Applicability | As-is evidence | Proposed Azure target and evidence | Operational objective / testability | Environment, safety, change | Owner, runbook, evidence, ADR/risk |','| --- | --- | --- | --- | --- | --- | --- | --- |')
+    $architectureLines += $oatArchitectureRows
+    $architectureLines += @('','### 14.3 High-Level Test Scenario Design','','| Scenario Reference | Test Type | REQ/NFR / Component / Flow Evidence | Family / Outcome / Environment / Data | Automation Status / Review ID / Reuse-Adapt-Build-Manual | Proposed Volume / Derivation / Confidence | Implementation / Execution / Maintenance / LMP Section-RACI |','| --- | --- | --- | --- | --- | --- | --- |')
+    for ($index = 0; $index -lt $types.Count; $index++) {
+        $architectureLines += "| SCN-$('{0:D2}' -f ($index + 1)) | $($types[$index].Name) | NFR-001 component inventory | Approved positive/negative family; pass threshold; $($types[$index].Environment); representative data | Partial AUT-$('{0:D2}' -f ($index + 1)); reuse verified cases; build uncovered cases after review | 1 family, 3-5 proposed cases from one evidenced component; Low confidence | Implementation: strategy owner; Execution: strategy owner; Maintenance: Application Team; LMP Section 4.1 and test-specific section; Appendix 5; review pending |"
+    }
+    $architectureLines += @('','### 14.4 Migration Impact-to-Test Crosswalk','','| Impact ID | Source Component / Store / Interface / Flow and Evidence Locator | Target Disposition (Retain / Change / Replace / Retire) | Data / State Movement Mechanism or Evidence-backed None | Impacted and Dependent Unchanged Behavior | REQ/NFR and Test Type / Section 14.3 Family or Supplied Case | Coverage Disposition (Covered / Proposed / Excluded / Pending) and Evidence | Owner / Action ID / Gate |','| --- | --- | --- | --- | --- | --- | --- | --- |')
+    for ($index = 0; $index -lt $types.Count; $index++) {
+        $targetDisposition = @('Retain','Change','Replace','Retire')[$index % 4]
+        $coverageDisposition = if ($index -eq 0) { 'Covered — CI run-123 evidence' } else { 'Proposed — high-level family; execution pending' }
+        $architectureLines += "| XWALK-$('{0:D3}' -f ($index + 1)) | Fixture component $($index + 1); source inventory SRC-001 | $targetDisposition — fixture target mapping | No state movement for this fixture flow; SRC-001 inventory and NFR-001 scope | Fixture behavior $($index + 1) and dependent unchanged fixture behavior; source flow inventory SRC-001 | NFR-001; $($types[$index].Name); SCN-$('{0:D2}' -f ($index + 1)) | $coverageDisposition | Migration Team; AUT-$('{0:D2}' -f ($index + 1)); scope review gate |"
+    }
     $architectureLines | Set-Content -LiteralPath $architecturePath -Encoding UTF8
     $planPath = Join-Path $tempRoot 'plan.md'
     @('# Plan Fixture','','### Application Test Plan Handoff','','| Test Plan | Status |','| --- | --- |','| `G-test-plan.md` | Approved |') | Set-Content -LiteralPath $planPath -Encoding UTF8
@@ -54,11 +86,36 @@ try {
     $testPlanLines = @('# G — Test Plan Fixture','','| Property | Value |','| --- | --- |','| **Status** | Approved |','','## Test Strategy','','### Test Types','','| Type | Applicability / R-Type Basis | Scope / Level | REQ/NFR/MIG Traces | Owner / Approver | Environment | Entry Criteria | Exit / Acceptance Criteria | When / Dependency | Results / Evidence | Exception ADR / Risk |','| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |')
     foreach ($type in $types) {
         $applicability = if ($type.Name -eq 'Unit') { 'Applicable — continue existing automated suites; Migration Team covers migration-changed impacted code' } else { 'Applicable — fixture basis' }
-        $testPlanLines += "| $($type.Name) | $applicability | Approved scope | NFR-001 | Migration Team / Application Owner | $($type.Environment) | Entry ready | Pass target met | Scheduled dependency | Results repository | N/A |"
+        $scope = if ($type.Name -eq 'Change-based functional') { 'Integration scenarios for Re-Factor and Migration Team refactoring within Re-Host/Re-Platform' } elseif ($type.Name -eq 'User acceptance testing') { 'Business and integration scenarios when Migration Team refactoring is not performed' } else { 'Approved scope' }
+        $owner = if ($type.Name -eq 'User acceptance testing') { 'LSEG Application Team / Application Owner' } else { 'Migration Team / Application Owner' }
+        $testPlanLines += "| $($type.Name) | $applicability | $scope | NFR-001 | $owner | $($type.Environment) | Entry ready | Pass target met | Scheduled dependency | Results repository | N/A |"
     }
+    $testPlanLines += @('','### Scenario Scope and Automation Effort','','| Scope Reference | Test Type | Scenario References / Count Band / Basis | Verified Reuse / Uncovered Scope / Review Action | Reuse-Adapt-Build-Manual Decision | Effort Range (person-days): Review / Automation / Setup / Execution / Retest / Report-Handover | Implementation / Execution / Maintenance / LMP Section-RACI | Confidence / Assumptions / Backlog Trace |','| --- | --- | --- | --- | --- | --- | --- | --- |')
+    for ($index = 0; $index -lt $types.Count; $index++) {
+        $testPlanLines += "| SIZE-$('{0:D2}' -f ($index + 1)) | $($types[$index].Name) | SCN-$('{0:D2}' -f ($index + 1)); 3-5 proposed cases from component inventory | AUT-$('{0:D2}' -f ($index + 1)); partial run-123 coverage; uncovered negatives pending Application Team review | Reuse verified cases; build/adapt after scope review | Review: 1-2; Automation: 2-4; Setup: 1-2; Execution: 1-2; Retest: 1-2; Report: 1-2 person-days | Implementation: strategy owner; Execution: strategy owner; Maintenance: Application Team; LMP Section 4.1 and Appendix 5 | Low confidence; specialist capacity separate; backlog TEST-PREP |"
+    }
+    $testPlanLines += @('','### High-Level Case Outlines','','Preserve supplied case identifiers and source locators. These fixture outlines are not execution claims. OAT cases remain in the OAT catalog matrix.','','| Case ID | Origin (Supplied / Proposed) | Source Asset / Locator | Test Type / Family / REQ-NFR / Component or Flow | Objective / Preconditions / Data / High-Level Steps | Measurable Expected Outcome | Disposition (Covered / Adapt / Proposed / Excluded / Pending) and Evidence | Environment / Tool / Automation | Owner / Evidence Result Path / Action ID |','| --- | --- | --- | --- | --- | --- | --- | --- | --- |')
+    for ($index = 0; $index -lt $types.Count; $index++) {
+        $disposition = if ($index -eq 0) { 'Covered — CI run-123 verifies fixture subset' } else { 'Adapt — inventory-derived outline; not yet executed' }
+        $testPlanLines += "| CASE-$('{0:D3}' -f ($index + 1)) | Supplied | AST-001 repo/tests v1.2; source CASE-$('{0:D3}' -f ($index + 1)) | $($types[$index].Name); SCN-$('{0:D2}' -f ($index + 1)); NFR-001; fixture component $($index + 1) | Verify evidenced fixture behavior; approved fixture data; invoke listed case and inspect assertion | The fixture-defined pass condition is met; threshold remains NFR-001 | $disposition | $($types[$index].Environment); fixture test runner; partial automation | Migration Team; planned results path; N/A |"
+    }
+    $testPlanLines += @('','### Estimated Elapsed Testing Timeline and Capacity','','Use capacity scenarios of 1, 2 and 3 active testers. Elapsed duration differs from person effort; estimates state verified automation, manual coverage, external approval waits, parallel work, critical path and contingency. Record an integrated window, not a sum of row durations. Optional pre-OAT is a lower-environment rehearsal, only after Migration Team and Application Team agree scenario IDs/count; it does not replace Production OAT.')
+    $testPlanLines += @('| Test Type / Workstream | Applicability | Case-count and automation basis | Elapsed — 1 tester | Elapsed — 2 testers | Elapsed — 3 testers | Dependencies, overlap, wait time, confidence |','| --- | --- | --- | --- | --- | --- | --- |')
+    foreach ($type in $types) {
+        $duration = if ($type.Name -eq 'Operational acceptance testing') { '4 calendar weeks' } else { '1-2 weeks' }
+        $testPlanLines += "| $($type.Name) | Applicable — fixture evidence | Verified cases and automation/manual split recorded; coverage basis documented | $duration | $duration | $duration | Dependencies, overlap, wait time, critical path and contingency; Low confidence |"
+    }
+    $testPlanLines += '| Optional pre-OAT lower-environment rehearsal | Optional — jointly agreed | Scenario IDs/count agreed by Migration Team and Application Team | 1-2 weeks after agreement | 1-2 weeks after agreement | 1 week after agreement | Lower environment; does not replace Production OAT |'
+    $testPlanLines += @('','### Estimate Scope and Boundary Reconciliation','','Estimate boundaries are compared before durations are combined.','','| Estimate ID / Source | Estimate Kind / Value / Confidence | Start Boundary | End Boundary | Included Phases / Work | Excluded Phases / External Waits | Basis / Scope Version / Evidence | Comparison / Reconciliation / Action |','| --- | --- | --- | --- | --- | --- | --- | --- |','| EST-001 | Test execution phase; 2-4 elapsed weeks; Low confidence | Test entry readiness approved | Test results reviewed and handed over | Testing workstream; preparation through review | End-to-end migration phases, customer waits and unbooked external approvals | Fixture case inventory CASE-001 through CASE-015; scope v1; SRC-001 | Phase estimate is not an end-to-end estimate; compare only matching boundaries |','| EST-002 | End-to-end migration; 20 elapsed weeks; Medium confidence | Migration mobilization | Hypercare exit | Discovery through hypercare | Customer-specific external approvals | Schedule baseline v1; SRC-001 | Not directly comparable to EST-001; scope windows differ |')
+    $testPlanLines += @('','### Optional Pre-OAT Scope — Lower Environment','','Optional lower-environment rehearsal in a lower environment; Migration Team and Application Team jointly agree the scenario IDs/count, entry/exit, owners and duration. This rehearsal does not satisfy Production OAT.')
+    $testPlanLines += @('','### High Availability Test Design','','Use LMP strategy Section 7.2. Application Owner assessment based on the R-Type and the approved HA design. Approved uptime/SLA and RTO/RPO goals include redundancy/failover, scalability, and resource utilization. Scope and test cases have pass/fail criteria and background load. Production-comparable PPE, an approved SII, monitoring, and test data are ready. Execute in an isolated PPE window after entry criteria are met. Exit requires all cases passed, defects retested or risk accepted, and a signed Test Execution Results Report.')
+    $testPlanLines += @('','### Disaster Recovery Test Design','','Use LMP strategy Section 7.3. Production acceptance by the L2 Team before customer cutover; Migration Team owns runbook creation and handover to L2. LSEG DR Coordinator and Technology Owner are named. Include dependency failover while the hosting environment remains in place. Production is configured with authentication/authorization, representative test data, selected tools, a trained team, and synchronized backups. Exit measures RTA against RTO and RPA against RPO, data integrity and accuracy, critical functionality, tested failback and normalization, defect retest or risk acceptance, results report, evidence, and sign-off.')
+    $testPlanLines += @('','### Operational Acceptance Test Design','','Use `docs/testing-strategy/LSEG-L2-OAT-Game-Day-Scenario-Catalog.md` and approved Architecture Section 14.2; assess as-is evidence and the proposed Azure target separately. Application Operations executes/accepts OAT in Production during Cutover. Each planned production disruption requires an approved change, bounded impact, communications, stop conditions, and recovery readiness. Record the runbook and evidence; OAT does not replace HA, DR, or UAT.')
+    $testPlanLines += @('| Catalog ID | Scenario | Disposition | As-is evidence | Proposed Azure target / applicability | Executable steps and expected outcome | Environment / change approval / stop-recovery | Operations owner / runbook / evidence / status |','| --- | --- | --- | --- | --- | --- | --- | --- |')
+    $testPlanLines += $oatPlanRows
     $testPlanLines += @('','### Minimum Viable Testing','','| Applicability | Trigger / Evidence Gap | Mandatory Minimum Scope | Approval / Exception | Exit Evidence |','| --- | --- | --- | --- | --- |','| Not Applicable | Full test assets available | Full approved scope applies; UAT remains mandatory and is not waived | N/A — no scope reduction | Per-test execution reports |','','### Automation Strategy and Ownership','','| Scope / Repository | Existing Automation | Migration Change Impact | Build / Pipeline Execution | Framework / Tool Decision | Implementation Owner | Ongoing Maintenance Owner | MEC/GCF / Exception Evidence |','| --- | --- | --- | --- | --- | --- | --- | --- |','| Application | repo/tests version 1.2 | Impacted code | CI pipeline unit-test stage per merge request | pytest 8.4 | Migration Team | Application Team | GCF approved evidence |','','### RACI','','| Test Type / Activity | Migration Team | Migration Test Team | LSEG Application Team / Owner | LSEG L2 / Operations | LSEG Security | Named Deliverable Approver |','| --- | --- | --- | --- | --- | --- | --- |')
     foreach ($type in $types) { $testPlanLines += "| $($type.Name) | R | C | A | I | I | Jane Smith |" }
-    $testPlanLines += @('','### Test Assets and Traceability','','| Asset | Value |','| --- | --- |','| Cases | Approved |','','### Environment Strategy','','| Environment | Purpose |','| --- | --- |','| PPE | Testing |','','### Entry/Exit Criteria','','| Gate | Entry | Exit |','| --- | --- | --- |','| Testing | Ready | Passed |','','### Defect Management','','| Severity | Treatment |','| --- | --- |','| Critical | Blocks |','','### Exceptions, Dependencies and Approvals','','| Item | Outcome |','| --- | --- |','| None | Approved |','','## Test Plan Approval Gate','','**Reviewed by**: Jane Smith | **Date**: 2026-09-21 | **Outcome**: Approved')
+    $testPlanLines += @('','### Test Assets and Traceability','','Keep availability separate from reuse health.','','| Asset ID | Asset Type / Supplied Case IDs | Version / Locator / Owner | Availability (Reported-linked / Available-unverified / Verified-available / Unavailable / Unknown) | Reuse Health (Reuse / Adapt / Build / Manual / Excluded / Undecided) | Verified Coverage / Gaps / Families | Last Run / Result Locator | Compatibility / Applicability Evidence | Maintenance / Retention / Action ID |','| --- | --- | --- | --- | --- | --- | --- | --- | --- |','| AST-001 | Test repo / CASE-001 through CASE-015 | v1.2 repo/tests; Application Team | Verified-available | Adapt | 3 verified; remaining scope separately outlined | 2026-10-06 CI run-123 passed | Compatible fixture build and reviewed tests | Application Team; retain reports; AUT-01 |','| AST-002 | Case inventory | Unknown version/path; Application Team | Available-unverified | Undecided | Exact coverage unknown | Not run | Applicability confirmation pending | Application Team; retain response; AUT-02 |','','### Environment Strategy','','| Environment | Purpose |','| --- | --- |','| PPE | Testing |','','### Entry/Exit Criteria','','| Gate | Entry | Exit |','| --- | --- | --- |','| Testing | Ready | Passed |','','### Defect Management','','| Severity | Treatment |','| --- | --- |','| Critical | Blocks |','','### Exceptions, Dependencies and Approvals','','| Item | Outcome |','| --- | --- |','| None | Approved |','','### Test Plan Review and Approval','','| Required reviewer organization | Review focus | Named reviewer | Decision date | Outcome | Evidence / comments |','| --- | --- | --- | --- | --- | --- |','| Migration Team | Scope and schedule | Jane Smith | 2026-09-21 | Approved | Review record |','| Migration Testing Team | Cases and automation | John Jones | 2026-09-21 | Approved | Review record |','| Application Team | Business and data | Mary Brown | 2026-09-21 | Approved | Review record |','| L2 Operations | Runbooks and operations | Alex White | 2026-09-21 | Approved | Review record |','','## Test Plan Approval Gate','','**Reviewed by**: Jane Smith | **Date**: 2026-09-21 | **Outcome**: Approved')
     $testPlanPath = Join-Path $tempRoot 'G-test-plan.md'
     $testPlanLines | Set-Content -LiteralPath $testPlanPath -Encoding UTF8
 
@@ -72,6 +129,43 @@ try {
     $taskLines | Set-Content -LiteralPath $tasksPath -Encoding UTF8
 
     $results = @()
+    $negativeResults = @()
+
+    $repoRoot = Get-RepoRoot
+    $specTemplate = Get-Content -LiteralPath (Join-Path $repoRoot '.specify/templates/spec-template.md') -Raw
+    $specPrompt = Get-Content -LiteralPath (Join-Path $repoRoot '.github/prompts/speckit.specify.prompt.md') -Raw
+    $specBacklogSkill = Get-Content -LiteralPath (Join-Path $repoRoot '.github/skills/specify-backlog/SKILL.md') -Raw
+    $specCoverageSkill = Get-Content -LiteralPath (Join-Path $repoRoot '.github/skills/specify-coverage/SKILL.md') -Raw
+    $handoffMatch = [regex]::Match($specTemplate, '(?ms)^## 6\. Testing Evidence Handoff\s*$\s*(?<body>.*?)(?=^##\s|\z)')
+    $specContractErrors = [System.Collections.Generic.List[string]]::new()
+    if (-not $handoffMatch.Success) {
+        $specContractErrors.Add('SPEC template is missing Section 6 Testing Evidence Handoff.')
+    } else {
+        $handoff = $handoffMatch.Groups['body'].Value
+        foreach ($column in @('Test Type','Applicability / Condition and Evidence','REQ/NFR / IMP IDs and Repository Readiness','Architecture Crosswalk / Family References','Supplied or Proposed Case / Asset References','Shared Profile Action / Source Evidence','Selected Section 3 User Story Handoff','Preparation / Execution / Retest Handoff','Evidence, Approval Gate and Accountable Roles')) {
+            if ($handoff -notmatch [regex]::Escape($column)) { $specContractErrors.Add("SPEC testing handoff is missing '$column'.") }
+        }
+        foreach ($type in $types) {
+            $typeRowCount = [regex]::Matches($handoff, "(?m)^\|\s*$([regex]::Escape($type.Name))\s*\|").Count
+            if ($typeRowCount -ne 1) { $specContractErrors.Add("SPEC testing handoff must contain exactly one '$($type.Name)' row; found $typeRowCount.") }
+        }
+        $normalizedHandoff = [regex]::Replace($handoff, '\s+', ' ')
+        foreach ($rule in @('Full functional is conditional on Re-architect','UAT remains applicable for every R-Type','Do not add standalone Integration Testing','not a prerequisite')) {
+            if ($normalizedHandoff -notmatch [regex]::Escape($rule)) { $specContractErrors.Add("SPEC testing handoff is missing rule '$rule'.") }
+        }
+    }
+    foreach ($contract in @(
+        @{ Text=$specPrompt; Pattern='`G-test-plan\.md` is produced during Planning & Design and is not a SPEC prerequisite'; Message='SPEC prompt must keep the Planning-stage Test Plan out of the initial SPEC prerequisites.' },
+        @{ Text=$specPrompt; Pattern='Stop at Section 9 \(Review Checkpoint\)'; Message='SPEC prompt must stop at the pending human review checkpoint.' },
+        @{ Text=$specBacklogSkill; Pattern='exact Section 3 work-item IDs'; Message='Backlog skill must preserve exact selected story handoff IDs.' },
+        @{ Text=$specCoverageSkill; Pattern='without copying its action rows'; Message='Coverage skill must reference, not duplicate, shared profile actions.' }
+    )) {
+        if ($contract.Text -notmatch $contract.Pattern) { $specContractErrors.Add($contract.Message) }
+    }
+    $specHandoffPassed = ($specContractErrors.Count -eq 0)
+    $results += @{ name='specTestingEvidenceHandoff'; passed=$specHandoffPassed; errors=@($specContractErrors) }
+    if (-not $specHandoffPassed) { throw "SPEC testing evidence handoff contract failed: $($specContractErrors -join ' ')" }
+
     $requirementsOutput = & (Join-Path $PSScriptRoot 'validate-requirements-testing.ps1') -TestingProfilePath $profilePath -RequirementsDirectory $requirementsDir -Json 2>&1
     $results += @{ name='requirementsTesting'; passed=($LASTEXITCODE -eq 0); output=($requirementsOutput -join "`n") }
     if ($LASTEXITCODE -ne 0) { throw "requirementsTesting positive-path validation failed: $($requirementsOutput -join ' ')" }
@@ -80,6 +174,186 @@ try {
     $results += @{ name='testPlan'; passed=($LASTEXITCODE -eq 0); output=($testPlanOutput -join "`n") }
     if ($LASTEXITCODE -ne 0) { throw "testPlan positive-path validation failed: $($testPlanOutput -join ' ')" }
 
+    $stageProfile = ($profileLines -join "`n").Replace('| None identified | Compared SRC-001 and SRC-002 | Fixture test assets | LMP strategy remains governing | Fixture reviewer; N/A | Resolved with evidence | No conflicting scope/count claims |', '| CON-001 | SRC-001 repo/tests reports 15 identifiers; SRC-002 run-123 verifies three | Fixture case inventory | LMP evidence rule; a run proves only executed cases | Fixture owner; ACT-001 | Open | Blocks case scope confirmation and execution baseline |')
+    $stageProfile = $stageProfile.Replace('## Automation Availability Review', '| ACT-001 | Confirm the missing fixture behavior and expected assertion | Application Team answer and source behavior locator in requirements/testing-profile.md | Application Team contact: Fixture owner; coordinator: Migration Test coordinator | Test scope review gate; date pending | NFR-001 | Blocks case scope confirmation and execution baseline | Requested | Pending |' + "`n" + '## Automation Availability Review')
+    $stagePlan = ($testPlanLines -join "`n").Replace('| **Status** | Approved |', '| **Status** | Draft |')
+    $stagePlan = $stagePlan.Replace('Covered — CI run-123 verifies fixture subset', 'Pending — source behavior confirmation required')
+    $stagePlan = $stagePlan.Replace('Migration Team; planned results path; N/A |', 'Migration Team; planned results path; ACT-001 |')
+    $reviewBrief = @'
+## Review Brief
+
+**Purpose and maturity**: Review the fixture proposal, not an execution baseline.
+**Proposed scope and exclusions**: Fixture families only; mandatory UAT retained.
+**Evidence basis and confidence**: SRC-001 v1.2 and SRC-002 run-123; three verified cases, remaining scope proposed.
+**Artifact quality versus input completeness**: Structurally reviewable; inputs remain unresolved.
+**Next gate and version boundary**: Review fixture source v1; execution and exact-version human approvals remain blocked.
+
+### Significant Conflicts
+
+| Priority / Why Now | Canonical Reference | Current Status | Review Focus / Next Step |
+| --- | --- | --- | --- |
+| First — resolve inventory before sizing | [CON-001](requirements/testing-profile.md#evidence-sources-and-conflicts) | Open | Scope conflict; ACT-001 owns the next decision. |
+
+### Priority Human Actions
+
+| Priority / Why Now | Canonical Reference | Current Status | Review Focus / Next Step |
+| --- | --- | --- | --- |
+| First — acceptance and scope dependency | [ACT-001](requirements/testing-profile.md#human-input-and-decision-register) | Requested | Fixture owner and Migration Test coordinator; test scope review gate; answer the behavior question before execution. |
+
+[Scope](#scenario-scope-and-automation-effort), [Cases](#high-level-case-outlines),
+[Assets](#test-assets-and-traceability), [Estimates](#estimate-scope-and-boundary-reconciliation),
+[Approval](#test-plan-approval-gate).
+
+'@
+    $stagePlan = $stagePlan.Replace('## Test Strategy', $reviewBrief + "`n## Test Strategy")
+    Set-Content -LiteralPath $profilePath -Value $stageProfile -Encoding UTF8
+    Set-Content -LiteralPath $testPlanPath -Value $stagePlan -Encoding UTF8
+    $draftProfileOutput = & (Join-Path $PSScriptRoot 'validate-requirements-testing.ps1') -TestingProfilePath $profilePath -RequirementsDirectory $requirementsDir -ValidationStage Draft -Json 2>&1
+    $draftProfileData = ($draftProfileOutput -join "`n") | ConvertFrom-Json
+    $draftProfilePassed = ($LASTEXITCODE -eq 0 -and $draftProfileData.inputCompleteness.sources -eq 2 -and $draftProfileData.inputCompleteness.openConflicts -eq 1 -and $draftProfileData.inputCompleteness.openActions -eq 1)
+    $results += @{ name='ownedUnknownInputsAcceptedForRequirementsDraft'; passed=$draftProfilePassed }
+    if (-not $draftProfilePassed) { throw "Owned unknown inputs prevented a reviewable requirements draft: $($draftProfileOutput -join ' ')" }
+    $draftStageOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -ValidationStage Draft -Json 2>&1
+    $draftStageData = ($draftStageOutput -join "`n") | ConvertFrom-Json
+    $draftStagePassed = ($LASTEXITCODE -eq 0 -and $draftStageData.validationStage -eq 'Draft' -and $draftStageData.planStatus -eq 'Draft' -and $draftStageData.inputCompleteness.unresolved -eq 1 -and $draftStageData.inputCompleteness.conflicting -eq 1)
+    $results += @{ name='ownedUnknownCaseAcceptedForDraft'; passed=$draftStagePassed }
+    if (-not $draftStagePassed) { throw "Owned unknown case was not accepted as a Draft with incompleteness reported: $($draftStageOutput -join ' ')" }
+    $readyPlan = $stagePlan.Replace('| **Status** | Draft |', '| **Status** | Ready for Review |')
+    Set-Content -LiteralPath $testPlanPath -Value $readyPlan -Encoding UTF8
+    $reviewStageOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -ValidationStage ReadyForReview -Json 2>&1
+    $reviewStageData = ($reviewStageOutput -join "`n") | ConvertFrom-Json
+    $reviewStagePassed = ($LASTEXITCODE -eq 0 -and $reviewStageData.validationStage -eq 'ReadyForReview' -and $reviewStageData.planStatus -eq 'Ready for Review' -and $reviewStageData.inputCompleteness.unresolved -eq 1 -and $reviewStageData.inputCompleteness.conflicting -eq 1)
+    $results += @{ name='ownedUnknownCaseAcceptedForReview'; passed=$reviewStagePassed }
+    if (-not $reviewStagePassed) { throw "Owned unknown case was not reviewable without claiming completeness: $($reviewStageOutput -join ' ')" }
+    $unresolvedEstimate = $stagePlan.Replace('Test entry readiness approved', 'Unknown pending Application Team confirmation').Replace('Phase estimate is not an end-to-end estimate; compare only matching boundaries', 'Scope comparison pending owner confirmation; ACT-001')
+    Set-Content -LiteralPath $testPlanPath -Value $unresolvedEstimate -Encoding UTF8
+    $draftEstimateOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -ValidationStage Draft -Json 2>&1
+    $draftEstimateAccepted = ($LASTEXITCODE -eq 0)
+    $results += @{ name='ownedEstimateBoundaryAcceptedForDraft'; passed=$draftEstimateAccepted }
+    if (-not $draftEstimateAccepted) { throw "Owned unknown estimate boundary prevented a Draft: $($draftEstimateOutput -join ' ')" }
+    $reviewEstimate = $unresolvedEstimate.Replace('| **Status** | Draft |', '| **Status** | Ready for Review |')
+    Set-Content -LiteralPath $testPlanPath -Value $reviewEstimate -Encoding UTF8
+    $reviewEstimateOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -ValidationStage ReadyForReview -Json 2>&1
+    $reviewEstimateAccepted = ($LASTEXITCODE -eq 0)
+    $results += @{ name='ownedEstimateBoundaryAcceptedForReview'; passed=$reviewEstimateAccepted }
+    if (-not $reviewEstimateAccepted) { throw "Owned unknown estimate boundary prevented ReadyForReview: $($reviewEstimateOutput -join ' ')" }
+    $executionEstimate = $unresolvedEstimate.Replace('| **Status** | Draft |', '| **Status** | Approved |')
+    Set-Content -LiteralPath $testPlanPath -Value $executionEstimate -Encoding UTF8
+    $executionEstimateOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -ValidationStage Execution -Json 2>&1
+    $executionEstimateRejected = ($LASTEXITCODE -ne 0 -and ($executionEstimateOutput -join ' ') -match 'Estimate boundaries remain unresolved')
+    $negativeResults += @{ name='unresolvedEstimateBoundaryBlockedFromExecution'; passed=$executionEstimateRejected }
+    if (-not $executionEstimateRejected) { throw 'An unresolved estimate boundary entered the execution baseline.' }
+    Set-Content -LiteralPath $testPlanPath -Value $readyPlan -Encoding UTF8
+    $executionStageOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -ValidationStage Execution -Json 2>&1
+    $executionStageRejected = ($LASTEXITCODE -ne 0 -and ($executionStageOutput -join ' ') -match "Case outline 'CASE-001' is still Proposed/Pending")
+    $negativeResults += @{ name='unresolvedCaseBlockedFromExecution'; passed=$executionStageRejected }
+    if (-not $executionStageRejected) { throw "Execution stage accepted a Pending case: $($executionStageOutput -join ' ')" }
+    $strictDefaultOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
+    $strictDefaultRejected = ($LASTEXITCODE -ne 0 -and ($strictDefaultOutput -join ' ') -match "status must be 'Approved' for validation stage 'Execution'")
+    $negativeResults += @{ name='defaultValidationRemainsExecutionStrict'; passed=$strictDefaultRejected }
+    if (-not $strictDefaultRejected) { throw 'Default Test Plan validation no longer enforces the existing strict execution gate.' }
+    foreach ($stage in @('Draft','ReadyForReview','Execution')) {
+        $approvedPendingPlan = $stagePlan.Replace('| **Status** | Draft |', '| **Status** | Approved |')
+        $approvedPendingPlan = $approvedPendingPlan.Replace('| Migration Testing Team | Cases and automation | John Jones | 2026-09-21 | Approved | Review record |', '| Migration Testing Team | Cases and automation | John Jones | Pending | Pending | Pending |')
+        Set-Content -LiteralPath $testPlanPath -Value $approvedPendingPlan -Encoding UTF8
+        $approvedPendingOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -ValidationStage $stage -Json 2>&1
+        $approvedPendingRejected = ($LASTEXITCODE -ne 0 -and ($approvedPendingOutput -join ' ') -match "cannot be Approved until 'Migration Testing Team'")
+        if ($stage -ne 'Execution') { $approvedPendingRejected = $approvedPendingRejected -and ($approvedPendingOutput -join ' ') -match 'status must be' }
+        $negativeResults += @{ name="approvedStatusCannotBypass${stage}"; passed=$approvedPendingRejected }
+        if (-not $approvedPendingRejected) { throw "An Approved Test Plan bypassed the $stage status gate." }
+    }
+    Set-Content -LiteralPath $testPlanPath -Value $stagePlan -Encoding UTF8
+    $unsupportedVerifiedAsset = $stagePlan.Replace('| AST-002 | Case inventory | Unknown version/path; Application Team | Available-unverified |', '| AST-002 | Case inventory | Unknown version/path; Application Team | Verified-available |')
+    Set-Content -LiteralPath $testPlanPath -Value $unsupportedVerifiedAsset -Encoding UTF8
+    $unsupportedVerifiedOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -ValidationStage Draft -Json 2>&1
+    $unsupportedVerifiedRejected = ($LASTEXITCODE -ne 0 -and ($unsupportedVerifiedOutput -join ' ') -match "cannot be Verified-available")
+    $negativeResults += @{ name='unverifiedAssetCannotBeClaimedVerified'; passed=$unsupportedVerifiedRejected }
+    if (-not $unsupportedVerifiedRejected) { throw 'An asset without a compatible dated run was accepted as verified in Draft.' }
+    $caseWithoutOutcome = ($testPlanLines -join "`n").Replace('The fixture-defined pass condition is met; threshold remains NFR-001', 'Unknown')
+    Set-Content -LiteralPath $testPlanPath -Value $caseWithoutOutcome -Encoding UTF8
+    $caseOutcomeOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -ValidationStage Draft -Json 2>&1
+    $caseOutcomeRejected = ($LASTEXITCODE -ne 0 -and ($caseOutcomeOutput -join ' ') -match "requires a substantive measurable expected outcome")
+    $negativeResults += @{ name='coveredCaseRequiresMeasurableOutcome'; passed=$caseOutcomeRejected }
+    if (-not $caseOutcomeRejected) { throw 'A covered case without a measurable expected outcome was accepted.' }
+    $ownedProfile = $stageProfile.Replace('## Automation Availability Review', '| ACT-002 | Confirm approver appointments and environment prerequisites for fixture | Appointment roster and environment/access evidence at SRC-001 | Application Owner contact; Migration Test coordinator | Execution baseline gate | NFR-001 RSK-001 | Named approval and environment execution readiness | Requested | Pending |' + "`n" + '## Automation Availability Review')
+    $ownedProfile = [regex]::Replace($ownedProfile, '(?m)^(\|\s*AUT-\d+\s*\|.*)\| Validated \| Application Team response.*$', '$1| Requested | Pending |')
+    $ownedProfile = $ownedProfile.Replace('| Partial | Application Team response 2026-10-06: repo/tests run-123 confirms partial coverage |', '| Unknown | Pending current Application Team automation evidence |')
+    $ownedProfile = $ownedProfile.Replace('status: Validated', 'status: Requested')
+    $ownedArchitecture = ($architectureLines -join "`n").Replace('| Ready | N/A |', '| Conditional | RSK-001 |')
+    $ownedPlan = $stagePlan.Replace('| Jane Smith |', '| Pending Application Owner |')
+    $ownedPlan = $ownedPlan.Replace('| 2026-09-21 | Approved | Review record |', '| Pending | Pending | Pending |')
+    $ownedPlan = $ownedPlan.Replace('| Not Applicable | Full test assets available | Full approved scope applies; UAT remains mandatory and is not waived | N/A — no scope reduction | Per-test execution reports |', '| Proposed | Asset inventory confirmation pending; ACT-001 | Application installation; Connectivity; Data migration verification; UAT remains mandatory and is not waived | Proposed ADR-0001 RSK-001; ACT-001 | Per-test execution reports before acceptance |')
+    Set-Content -LiteralPath $profilePath -Value $ownedProfile -Encoding UTF8
+    Set-Content -LiteralPath $architecturePath -Value $ownedArchitecture -Encoding UTF8
+    foreach ($stage in @('Draft','ReadyForReview','Execution')) {
+        $status = switch ($stage) { 'Draft' { 'Draft' }; 'ReadyForReview' { 'Ready for Review' }; 'Execution' { 'Approved' } }
+        Set-Content -LiteralPath $testPlanPath -Value $ownedPlan.Replace('| **Status** | Draft |', "| **Status** | $status |") -Encoding UTF8
+        $output = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -ValidationStage $stage -Json 2>&1
+        $data = ($output -join "`n") | ConvertFrom-Json
+        if ($stage -eq 'Execution') {
+            $passed = $LASTEXITCODE -ne 0 -and ($data.errors -join ' ') -match 'architecture readiness Ready' -and ($data.errors -join ' ') -match 'authorized human deliverable approver'
+            $negativeResults += @{ name='ownedReadinessAndAppointmentsStillBlockExecution'; passed=$passed }
+        } else {
+            $passed = $LASTEXITCODE -eq 0 -and $data.deferredExecutionRequirements.architectureReadiness.Count -eq 15 -and $data.deferredExecutionRequirements.namedApprovers.Count -eq 15
+            $results += @{ name="ownedConditionalReadinessAndPendingAppointmentsAcceptedFor${stage}"; passed=$passed }
+        }
+        if (-not $passed) { throw "Stage-specific owned dependency regression failed for ${stage}: $($output -join ' ')" }
+    }
+    foreach ($mutation in @(
+        @{ name='missingDependencyOwnerRejected'; Profile=$ownedProfile.Replace('Application Owner contact; Migration Test coordinator', 'Unknown'); Plan=$ownedPlan; Architecture=$ownedArchitecture; Pattern='contact/coordinator' },
+        @{ name='missingNeededByGateRejected'; Profile=$ownedProfile.Replace('Execution baseline gate | NFR-001 RSK-001', 'Pending | NFR-001 RSK-001'); Plan=$ownedPlan; Architecture=$ownedArchitecture; Pattern='needed-by gate' },
+        @{ name='unownedConditionalReadinessRejected'; Profile=($profileLines -join "`n"); Plan=$stagePlan; Architecture=$ownedArchitecture; Pattern='unresolved readiness requires' },
+        @{ name='unownedPendingApproverRejected'; Profile=$stageProfile; Plan=$ownedPlan; Architecture=($architectureLines -join "`n"); Pattern='owned appointment action' },
+        @{ name='briefMissingActionRejected'; Profile=$ownedProfile; Plan=$ownedPlan.Replace('[ACT-001]', '[ACT-999]'); Architecture=$ownedArchitecture; Pattern='missing or unowned canonical record' },
+        @{ name='briefMissingConflictRejected'; Profile=$ownedProfile; Plan=$ownedPlan.Replace('[CON-001]', '[CON-999]'); Architecture=$ownedArchitecture; Pattern='missing or unowned canonical record' },
+        @{ name='briefClosedClaimRejected'; Profile=$ownedProfile; Plan=$ownedPlan.Replace('| Requested | Fixture owner', '| Closed | Fixture owner'); Architecture=$ownedArchitecture; Pattern='contradicts the canonical register' },
+        @{ name='briefResolvedConflictClaimRejected'; Profile=$ownedProfile; Plan=$ownedPlan.Replace('| Open | Scope conflict', '| Resolved with evidence | Scope conflict'); Architecture=$ownedArchitecture; Pattern='contradicts the canonical register' },
+        @{ name='invalidReadinessRejectedInDraft'; Profile=$ownedProfile; Plan=$ownedPlan; Architecture=$ownedArchitecture.Replace('| Conditional |', '| Unknown |'); Pattern='invalid readiness' }
+        @{ name='conditionalReadinessWithoutRiskRejected'; Profile=$ownedProfile; Plan=$ownedPlan; Architecture=$ownedArchitecture.Replace('| Conditional | RSK-001 |', '| Conditional | N/A |'); Pattern='unresolved readiness requires' }
+        @{ name='unsupportedClosedActionRejected'; Profile=$ownedProfile.Replace('| Requested | Pending |', '| Closed | Pending |'); Plan=$ownedPlan; Architecture=$ownedArchitecture; Pattern='cannot be Validated/Closed' }
+        @{ name='unownedUnknownAutomationRejected'; Profile=([regex]::Replace($ownedProfile, '(?m)^\| AUT-01 \| Confirmed partial coverage.*\r?\n?', '')); Plan=$ownedPlan; Architecture=$ownedArchitecture; Pattern="automation review 'AUT-01'.*owned profile action" }
+        @{ name='unsupportedVerifiedAutomationRejected'; Profile=$ownedProfile.Replace('| Unknown | Pending current Application Team automation evidence |', '| Verified | Pending current Application Team automation evidence |'); Plan=$ownedPlan; Architecture=$ownedArchitecture; Pattern='cannot be Verified without dated run/result evidence' }
+        @{ name='briefBlankScopeRejected'; Profile=$ownedProfile; Plan=$ownedPlan.Replace('**Proposed scope and exclusions**: Fixture families only; mandatory UAT retained.', '**Proposed scope and exclusions**:'); Architecture=$ownedArchitecture; Pattern="Review Brief requires 'Proposed scope and exclusions'" }
+        @{ name='briefWrongRegisterAnchorRejected'; Profile=$ownedProfile; Plan=$ownedPlan.Replace('testing-profile.md#human-input-and-decision-register', 'testing-profile.md#wrong-register'); Architecture=$ownedArchitecture; Pattern='must link one canonical register record' }
+        @{ name='briefOverloadedPrioritiesRejected'; Profile=$ownedProfile; Plan=$ownedPlan.Replace('| First — acceptance and scope dependency | [ACT-001](requirements/testing-profile.md#human-input-and-decision-register) | Requested | Fixture owner and Migration Test coordinator; test scope review gate; answer the behavior question before execution. |', ((1..6 | ForEach-Object { '| First — dependency | [ACT-001](requirements/testing-profile.md#human-input-and-decision-register) | Requested | Resolve acceptance before execution. |' }) -join "`n")); Architecture=$ownedArchitecture; Pattern='at most five items' }
+    )) {
+        Set-Content -LiteralPath $profilePath -Value $mutation.Profile -Encoding UTF8
+        Set-Content -LiteralPath $testPlanPath -Value $mutation.Plan -Encoding UTF8
+        Set-Content -LiteralPath $architecturePath -Value $mutation.Architecture -Encoding UTF8
+        $output = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -ValidationStage Draft -Json 2>&1
+        $passed = $LASTEXITCODE -ne 0 -and ($output -join ' ') -match $mutation.Pattern
+        $negativeResults += @{ name=$mutation.name; passed=$passed }
+        if (-not $passed) { throw "Regression '$($mutation.name)' failed: $($output -join ' ')" }
+    }
+    Set-Content -LiteralPath $profilePath -Value ($profileLines -join "`n") -Encoding UTF8
+    Set-Content -LiteralPath $architecturePath -Value ($architectureLines -join "`n") -Encoding UTF8
+    Set-Content -LiteralPath $testPlanPath -Value (($testPlanLines -join "`n").Replace('| Jane Smith |', '| Pending Jane Smith |')) -Encoding UTF8
+    $output = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -ValidationStage Execution -Json 2>&1
+    $passed = $LASTEXITCODE -ne 0 -and ($output -join ' ') -match 'authorized human deliverable approver'
+    $negativeResults += @{ name='pendingPersonIsNotExecutionAppointment'; passed=$passed }
+    if (-not $passed) { throw 'A pending named contact was treated as an execution approver appointment.' }
+    Set-Content -LiteralPath $profilePath -Value $stageProfile -Encoding UTF8
+    Set-Content -LiteralPath $architecturePath -Value ($architectureLines -join "`n") -Encoding UTF8
+    $legacyPlan = ($testPlanLines -join "`n").Replace('| **Status** | Approved |', '| **Status** | Draft |')
+    Set-Content -LiteralPath $testPlanPath -Value $legacyPlan -Encoding UTF8
+    $output = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -ValidationStage Draft -Json 2>&1
+    $data = ($output -join "`n") | ConvertFrom-Json
+    $passed = $LASTEXITCODE -eq 0 -and ($data.warnings -join ' ') -match 'missing Review Brief'
+    $results += @{ name='legacyDraftMissingBriefWarns'; passed=$passed }
+    if (-not $passed) { throw 'Legacy Draft without Review Brief was not accepted with a migration warning.' }
+    Set-Content -LiteralPath $testPlanPath -Value $legacyPlan.Replace('| **Status** | Draft |', '| **Status** | Ready for Review |') -Encoding UTF8
+    $output = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -ValidationStage ReadyForReview -Json 2>&1
+    $passed = $LASTEXITCODE -ne 0 -and ($output -join ' ') -match 'requires a concise Review Brief'
+    $negativeResults += @{ name='reviewHandoffRequiresBrief'; passed=$passed }
+    if (-not $passed) { throw 'ReadyForReview accepted a missing Review Brief.' }
+    Set-Content -LiteralPath $testPlanPath -Value $stagePlan.Replace('| First — resolve inventory before sizing | [CON-001](requirements/testing-profile.md#evidence-sources-and-conflicts) | Open | Scope conflict; ACT-001 owns the next decision. |', 'None — no significant conflict requiring this review; full register remains linked.') -Encoding UTF8
+    $output = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -ValidationStage Draft -Json 2>&1
+    $passed = $LASTEXITCODE -eq 0
+    $results += @{ name='briefEmptyPriorityListWithRationaleAccepted'; passed=$passed }
+    if (-not $passed) { throw "An explicit empty priority list was rejected: $($output -join ' ')" }
+    Set-Content -LiteralPath $profilePath -Value ($profileLines -join "`n") -Encoding UTF8
+    Set-Content -LiteralPath $testPlanPath -Value ($testPlanLines -join "`n") -Encoding UTF8
+
     $tasksOutput = & (Join-Path $PSScriptRoot 'validate-testing-tasks.ps1') -TasksPath $tasksPath -TestingProfilePath $profilePath -TestPlanPath $testPlanPath -Json 2>&1
     $results += @{ name='testingTasks'; passed=($LASTEXITCODE -eq 0); output=($tasksOutput -join "`n") }
     if ($LASTEXITCODE -ne 0) { throw "testingTasks positive-path validation failed: $($tasksOutput -join ' ')" }
@@ -100,7 +374,184 @@ try {
     Set-Content -LiteralPath $architecturePath -Value $positiveArchitecture -Encoding UTF8
     Set-Content -LiteralPath $testPlanPath -Value $positiveTestPlan -Encoding UTF8
 
-    $negativeResults = @()
+    $testPlanOriginal = Get-Content -LiteralPath $testPlanPath -Raw
+    foreach ($status in @('Unknown','None','Verified')) {
+        $statusProfile = $positiveProfile.Replace('| Connectivity | Partial | Application Team response 2026-10-06: repo/tests run-123 confirms partial coverage |', "| Connectivity | $status | Application Team response 2026-10-06: fixture evidence for $status |")
+        if ($status -eq 'Unknown') { $statusProfile = $statusProfile.Replace('Application Team response 2026-10-06: fixture evidence for Unknown', 'Pending Application Team response; no referenced assets found') }
+        if ($status -eq 'Verified') { $statusProfile = $statusProfile.Replace('Application Team response 2026-10-06: fixture evidence for Verified', 'Application Team response 2026-10-06: CI run-123 confirms verified coverage') }
+        Set-Content -LiteralPath $profilePath -Value $statusProfile -Encoding UTF8
+        $statusOutput = & (Join-Path $PSScriptRoot 'validate-requirements-testing.ps1') -TestingProfilePath $profilePath -RequirementsDirectory $requirementsDir -Json 2>&1
+        $results += @{ name="automation${status}Accepted"; passed=($LASTEXITCODE -eq 0) }
+        if ($LASTEXITCODE -ne 0) { throw "Automation $status with required evidence/action rejected: $($statusOutput -join ' ')" }
+    }
+    Set-Content -LiteralPath $profilePath -Value $positiveProfile -Encoding UTF8
+    $reviewMutations = @(
+        @{ name='missingPerTypeAutomationReviewRejected'; content=([regex]::Replace($positiveProfile, '(?m)^\| AUT-01 \| Connectivity \|.*\r?\n', '')); expected="Automation review must contain exactly one 'Connectivity' entry" },
+        @{ name='missingApplicationTeamAutomationActionRejected'; content=$positiveProfile.Replace('AUT-01; Application Team contact: Fixture owner; owner: Migration Test coordinator; needed-by: scope review; status: Validated', 'No review scheduled'); expected='requires an Application Team action' },
+        @{ name='unconfirmedAbsentAutomationRejected'; content=$positiveProfile.Replace('| Connectivity | Partial | Application Team response 2026-10-06: repo/tests run-123 confirms partial coverage |', '| Connectivity | None | No files discovered |'); expected='requires dated response/run evidence' },
+        @{ name='automationGapWithoutRiskRejected'; content=$positiveProfile.Replace('| NFR-001 RSK-001 |', '| NFR-001 |'); expected='gap must trace a requirement and ADR/risk' },
+        @{ name='verifiedAutomationWithoutRunEvidenceRejected'; content=$positiveProfile.Replace('| Connectivity | Partial | Application Team response 2026-10-06: repo/tests run-123 confirms partial coverage |', '| Connectivity | Verified | Application Team response 2026-10-06: framework files are present |'); expected="cannot claim Verified without dated run/result evidence" }
+    )
+    foreach ($mutation in $reviewMutations) {
+        Set-Content -LiteralPath $profilePath -Value $mutation.content -Encoding UTF8
+        $mutationOutput = & (Join-Path $PSScriptRoot 'validate-requirements-testing.ps1') -TestingProfilePath $profilePath -RequirementsDirectory $requirementsDir -Json 2>&1
+        $rejected = $LASTEXITCODE -ne 0 -and ($mutationOutput -join ' ') -match [regex]::Escape($mutation.expected)
+        $negativeResults += @{ name=$mutation.name; passed=$rejected }
+        if (-not $rejected) { throw "Automation regression failed: $($mutation.name): $($mutationOutput -join ' ')" }
+    }
+    Set-Content -LiteralPath $profilePath -Value $positiveProfile -Encoding UTF8
+
+    $scenarioMutations = @(
+        @{ name='missingHighLevelScenarioRejected'; content=([regex]::Replace($positiveArchitecture, '(?m)^\| SCN-02 \| Unit \|.*\r?\n', '')); profileContent=([regex]::Replace($positiveProfile, '(?m)^\| AUT-02 \| Confirmed partial coverage.*\r?\n', '')); expected="Section 14.3 'Unit' needs an evidenced scenario family or its owned Application Team action" },
+        @{ name='scenarioAutomationReviewDriftRejected'; content=$positiveArchitecture.Replace('Partial AUT-02;', 'None AUT-99;'); expected="Section 14.3 'Unit' must trace its automation review ID and status" },
+        @{ name='scenarioOwnershipWithoutStrategyRejected'; content=$positiveArchitecture.Replace('LMP Section 4.1 and test-specific section; Appendix 5', 'Assumed assignment'); expected='must separate implementation/execution/maintenance and cite the LMP section/Appendix 5' }
+    )
+    $scenarioPositiveOutput = & (Join-Path $PSScriptRoot 'validate-architecture.ps1') -ArchitecturePath $architecturePath -TestingProfilePath $profilePath -Json 2>&1
+    if (($scenarioPositiveOutput -join ' ') -match 'Section 14\.3|High-Level Test Scenario Design') { throw "Complete scenario fixture rejected: $($scenarioPositiveOutput -join ' ')" }
+    $results += @{ name='highLevelScenarioDesignAccepted'; passed=$true }
+    foreach ($mutation in $scenarioMutations) {
+        Set-Content -LiteralPath $architecturePath -Value $mutation.content -Encoding UTF8
+        if ($mutation.ContainsKey('profileContent')) { Set-Content -LiteralPath $profilePath -Value $mutation.profileContent -Encoding UTF8 }
+        $mutationOutput = & (Join-Path $PSScriptRoot 'validate-architecture.ps1') -ArchitecturePath $architecturePath -TestingProfilePath $profilePath -Json 2>&1
+        $rejected = $LASTEXITCODE -ne 0 -and ($mutationOutput -join ' ') -match [regex]::Escape($mutation.expected)
+        $negativeResults += @{ name=$mutation.name; passed=$rejected }
+        if (-not $rejected) { throw "Scenario regression failed: $($mutation.name): $($mutationOutput -join ' ')" }
+        Set-Content -LiteralPath $profilePath -Value $positiveProfile -Encoding UTF8
+    }
+    Set-Content -LiteralPath $architecturePath -Value $positiveArchitecture -Encoding UTF8
+    $sizingMutations = @(
+        @{ name='missingPerTypeSizingRejected'; content=([regex]::Replace($testPlanOriginal, '(?m)^\| SIZE-09 \| Performance and baseline \|.*\r?\n', '')); expected="Test Plan requires scenario/automation effort for 'Performance and baseline'" },
+        @{ name='missingAutomationBuildEffortRejected'; content=$testPlanOriginal.Replace('Automation: 2-4;', 'Automation: Pending;'); expected='requires a numeric person-day range for Automation' },
+        @{ name='sizingScenarioTraceDriftRejected'; content=$testPlanOriginal.Replace('| SCN-02; 3-5 proposed', '| SCN-99; 3-5 proposed'); expected="Test Plan sizing 'Unit' must reference its Section 14.3 scenario scope" },
+        @{ name='sizingReviewTraceDriftRejected'; content=$testPlanOriginal.Replace('| AUT-02; partial', '| AUT-99; partial'); expected="Test Plan sizing 'Unit' must trace its automation review action" }
+    )
+    foreach ($mutation in $sizingMutations) {
+        Set-Content -LiteralPath $testPlanPath -Value $mutation.content -Encoding UTF8
+        $mutationOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
+        $rejected = $LASTEXITCODE -ne 0 -and ($mutationOutput -join ' ') -match [regex]::Escape($mutation.expected)
+        $negativeResults += @{ name=$mutation.name; passed=$rejected }
+        if (-not $rejected) { throw "Sizing regression failed: $($mutation.name): $($mutationOutput -join ' ')" }
+    }
+    Set-Content -LiteralPath $testPlanPath -Value $testPlanOriginal -Encoding UTF8
+    $missingTimelineType = [regex]::Replace($testPlanOriginal, '(?m)^\|\s*Connectivity\s*\| Applicable — fixture evidence \| Verified cases and automation/manual split recorded; coverage basis documented \|.*\r?\n', '')
+    Set-Content -LiteralPath $testPlanPath -Value $missingTimelineType -Encoding UTF8
+    $missingTimelineTypeOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
+    $negativeResults += @{ name='missingEstimatedTestTypeRejected'; passed=($LASTEXITCODE -ne 0 -and ($missingTimelineTypeOutput -join ' ') -match "Testing timeline must contain exactly one 'Connectivity' row") }
+    if ($LASTEXITCODE -eq 0 -or ($missingTimelineTypeOutput -join ' ') -notmatch "Testing timeline must contain exactly one 'Connectivity' row") { throw 'Test Plan validator did not reject a missing timeline test type.' }
+
+    $missingCapacityScenario = $testPlanOriginal.Replace('Elapsed — 3 testers |', 'Elapsed — 3 testers |').Replace('| Connectivity | Applicable — fixture evidence | Verified cases and automation/manual split recorded; coverage basis documented | 1-2 weeks | 1-2 weeks | 1-2 weeks |', '| Connectivity | Applicable — fixture evidence | Verified cases and automation/manual split recorded; coverage basis documented | 1-2 weeks | 1-2 weeks |  |')
+    Set-Content -LiteralPath $testPlanPath -Value $missingCapacityScenario -Encoding UTF8
+    $missingCapacityOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
+    $negativeResults += @{ name='missingTesterCapacityEstimateRejected'; passed=($LASTEXITCODE -ne 0 -and ($missingCapacityOutput -join ' ') -match "Testing timeline row 'Connectivity' has an unresolved required field") }
+    if ($LASTEXITCODE -eq 0 -or ($missingCapacityOutput -join ' ') -notmatch "Testing timeline row 'Connectivity' has an unresolved required field") { throw 'Test Plan validator did not reject a missing tester-capacity estimate.' }
+
+    $missingRequiredApproval = [regex]::Replace($testPlanOriginal, '(?m)^\|\s*L2 Operations\s*\|.*\r?\n', '')
+    Set-Content -LiteralPath $testPlanPath -Value $missingRequiredApproval -Encoding UTF8
+    $missingRequiredApprovalOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
+    $negativeResults += @{ name='missingL2PlanApprovalRejected'; passed=($LASTEXITCODE -ne 0 -and ($missingRequiredApprovalOutput -join ' ') -match "Test Plan approvals must contain exactly one 'L2 Operations' reviewer row") }
+    if ($LASTEXITCODE -eq 0 -or ($missingRequiredApprovalOutput -join ' ') -notmatch "Test Plan approvals must contain exactly one 'L2 Operations' reviewer row") { throw 'Test Plan validator did not reject a missing L2 approval.' }
+
+    $pendingPlanApproval = $testPlanOriginal.Replace('| Migration Testing Team | Cases and automation | John Jones | 2026-09-21 | Approved | Review record |', '| Migration Testing Team | Cases and automation | John Jones | 2026-09-21 | Pending | Review record |')
+    Set-Content -LiteralPath $testPlanPath -Value $pendingPlanApproval -Encoding UTF8
+    $pendingPlanApprovalOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
+    $negativeResults += @{ name='approvedPlanWithPendingPartyRejected'; passed=($LASTEXITCODE -ne 0 -and ($pendingPlanApprovalOutput -join ' ') -match "Test Plan cannot be Approved until 'Migration Testing Team'") }
+    if ($LASTEXITCODE -eq 0 -or ($pendingPlanApprovalOutput -join ' ') -notmatch "Test Plan cannot be Approved until 'Migration Testing Team'") { throw 'Test Plan validator allowed Approved status with a pending required organization.' }
+    Set-Content -LiteralPath $testPlanPath -Value $testPlanOriginal -Encoding UTF8
+
+    $missingOatPlan = [regex]::Replace($testPlanOriginal, '(?m)^\|\s*L2-OAT-GD-01\s*\|.*\r?\n', '')
+    Set-Content -LiteralPath $testPlanPath -Value $missingOatPlan -Encoding UTF8
+    $missingOatPlanOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
+    $negativeResults += @{ name='missingOatPlanIdRejected'; passed=($LASTEXITCODE -ne 0 -and ($missingOatPlanOutput -join ' ') -match "exactly one disposition row for 'L2-OAT-GD-01'") }
+    if ($LASTEXITCODE -eq 0 -or ($missingOatPlanOutput -join ' ') -notmatch "exactly one disposition row for 'L2-OAT-GD-01'") { throw 'Test Plan validator did not reject a missing OAT scenario ID.' }
+
+    $missingOatAsIs = $testPlanOriginal.Replace('As-is evidence: source baseline recorded', '')
+    Set-Content -LiteralPath $testPlanPath -Value $missingOatAsIs -Encoding UTF8
+    $missingOatAsIsOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
+    $negativeResults += @{ name='missingOatAsIsEvidenceRejected'; passed=($LASTEXITCODE -ne 0 -and ($missingOatAsIsOutput -join ' ') -match "OAT Test Plan row 'L2-OAT-GD-01' has an unresolved required field") }
+    if ($LASTEXITCODE -eq 0 -or ($missingOatAsIsOutput -join ' ') -notmatch "OAT Test Plan row 'L2-OAT-GD-01' has an unresolved required field") { throw 'Test Plan validator did not reject missing OAT as-is evidence.' }
+
+    $missingOatAzure = $testPlanOriginal.Replace('Proposed Azure target: evidenced service mapping', '')
+    Set-Content -LiteralPath $testPlanPath -Value $missingOatAzure -Encoding UTF8
+    $missingOatAzureOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
+    $negativeResults += @{ name='missingOatAzureEvidenceRejected'; passed=($LASTEXITCODE -ne 0 -and ($missingOatAzureOutput -join ' ') -match "OAT Test Plan row 'L2-OAT-GD-01' has an unresolved required field") }
+    if ($LASTEXITCODE -eq 0 -or ($missingOatAzureOutput -join ' ') -notmatch "OAT Test Plan row 'L2-OAT-GD-01' has an unresolved required field") { throw 'Test Plan validator did not reject missing OAT Azure target evidence.' }
+
+    $oatDispositionDrift = $testPlanOriginal.Replace('| L2-OAT-GD-01 | Fixture scenario | Recommended |', '| L2-OAT-GD-01 | Fixture scenario | Not applicable |')
+    Set-Content -LiteralPath $testPlanPath -Value $oatDispositionDrift -Encoding UTF8
+    $oatDispositionDriftOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
+    $negativeResults += @{ name='oatDispositionDriftRejected'; passed=($LASTEXITCODE -ne 0 -and ($oatDispositionDriftOutput -join ' ') -match "OAT Test Plan disposition for 'L2-OAT-GD-01' must match Architecture Section 14.2") }
+    if ($LASTEXITCODE -eq 0 -or ($oatDispositionDriftOutput -join ' ') -notmatch "OAT Test Plan disposition for 'L2-OAT-GD-01' must match Architecture Section 14.2") { throw 'Test Plan validator did not reject OAT disposition drift from architecture.' }
+
+    $unsafeProductionOatPlan = $testPlanOriginal.Replace('Fixture scenario | Recommended | As-is evidence: source baseline recorded | Proposed Azure target: evidenced service mapping | Verify observable operational result and measurable threshold; no fault injection | Production during Cutover; approved change CHG-123; bounded impact; communications; stop conditions; recovery readiness', 'Database failover | Recommended | As-is evidence: source baseline recorded | Proposed Azure target: evidenced service mapping | Disable production database to force failover | Production during Cutover; pending change; no approval, bounded impact, stop conditions, or recovery readiness')
+    Set-Content -LiteralPath $testPlanPath -Value $unsafeProductionOatPlan -Encoding UTF8
+    $unsafeProductionOatPlanOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
+    $unsafeProductionOatPlanRejected = ($LASTEXITCODE -ne 0 -and ($unsafeProductionOatPlanOutput -join ' ') -match "Production-disruptive OAT row 'L2-OAT-GD-01'")
+    $negativeResults += @{ name='unsafeProductionOatPlanRejected'; passed=$unsafeProductionOatPlanRejected }
+    if (-not $unsafeProductionOatPlanRejected) { throw 'Test Plan validator did not reject unsafe production-disruptive OAT execution.' }
+    Set-Content -LiteralPath $testPlanPath -Value $testPlanOriginal -Encoding UTF8
+
+    $standaloneIntegrationProfile = $positiveProfile.Replace('## Evidence Sources and Conflicts', '| Integration Testing | Required | Applicable | All migrations | NFR-001 | Approved measurable pass target | PPE | Reviewed fixture evidence | Migration Team | Application Owner | N/A |' + "`n" + '## Evidence Sources and Conflicts')
+    Set-Content -LiteralPath $profilePath -Value $standaloneIntegrationProfile -Encoding UTF8
+    $standaloneIntegrationProfileOutput = & (Join-Path $PSScriptRoot 'validate-requirements-testing.ps1') -TestingProfilePath $profilePath -RequirementsDirectory $requirementsDir -Json 2>&1
+    $negativeResults += @{ name='standaloneIntegrationProfileRejected'; passed=($LASTEXITCODE -ne 0) }
+    if ($LASTEXITCODE -eq 0) { throw 'Standalone Integration Testing profile row was not rejected.' }
+    Set-Content -LiteralPath $profilePath -Value $positiveProfile -Encoding UTF8
+
+    $standaloneIntegrationPlan = $testPlanOriginal.Replace('| Connectivity | Applicable — fixture basis | Approved scope | NFR-001 |', '| Integration Testing | Applicable — fixture basis | Approved scope | NFR-001 | Migration Team / Application Owner | PPE | Entry ready | Pass target met | Scheduled dependency | Results repository | N/A |' + "`n" + '| Connectivity | Applicable — fixture basis | Approved scope | NFR-001 |')
+    Set-Content -LiteralPath $testPlanPath -Value $standaloneIntegrationPlan -Encoding UTF8
+    $standaloneIntegrationPlanOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
+    $negativeResults += @{ name='standaloneIntegrationPlanRejected'; passed=($LASTEXITCODE -ne 0) }
+    if ($LASTEXITCODE -eq 0) { throw 'Standalone Integration Testing Test Plan row was not rejected.' }
+    Set-Content -LiteralPath $testPlanPath -Value $testPlanOriginal -Encoding UTF8
+
+    $connectivityArchitectureRow = ([regex]::Match($positiveArchitecture, '(?m)^\|\s*Connectivity\s*\|.*$')).Value
+    $integrationArchitectureRow = '| Integration Testing | NFR-001 Applicable | Applicable — fixture basis | Section 12 | Approved mechanism | PPE | Results repository | Approved prerequisites | Ready | N/A |'
+    $standaloneIntegrationArchitecture = $positiveArchitecture.Replace($connectivityArchitectureRow, $connectivityArchitectureRow + "`n" + $integrationArchitectureRow)
+    Set-Content -LiteralPath $architecturePath -Value $standaloneIntegrationArchitecture -Encoding UTF8
+    $standaloneIntegrationArchitectureOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
+    $negativeResults += @{ name='standaloneIntegrationArchitectureRejected'; passed=($LASTEXITCODE -ne 0) }
+    if ($LASTEXITCODE -eq 0) { throw 'Standalone Integration Testing architecture matrix row was not rejected.' }
+    Set-Content -LiteralPath $architecturePath -Value $positiveArchitecture -Encoding UTF8
+
+    $standaloneIntegrationRaci = $testPlanOriginal.Replace('| Connectivity | R | C | A | I | I | Jane Smith |', '| Integration Testing | R | C | A | I | I | Jane Smith |' + "`n" + '| Connectivity | R | C | A | I | I | Jane Smith |')
+    Set-Content -LiteralPath $testPlanPath -Value $standaloneIntegrationRaci -Encoding UTF8
+    $standaloneIntegrationRaciOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
+    $negativeResults += @{ name='standaloneIntegrationRaciRejected'; passed=($LASTEXITCODE -ne 0) }
+    if ($LASTEXITCODE -eq 0) { throw 'Standalone Integration Testing RACI row was not rejected.' }
+    Set-Content -LiteralPath $testPlanPath -Value $testPlanOriginal -Encoding UTF8
+
+    $missingIntegrationBranch = $testPlanOriginal.Replace('Integration scenarios for Re-Factor and Migration Team refactoring within Re-Host/Re-Platform', 'Approved scope')
+    Set-Content -LiteralPath $testPlanPath -Value $missingIntegrationBranch -Encoding UTF8
+    $missingIntegrationBranchOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
+    $negativeResults += @{ name='missingIntegrationBranchRejected'; passed=($LASTEXITCODE -ne 0) }
+    if ($LASTEXITCODE -eq 0) { throw 'Change-based functional row without integration classification was not rejected.' }
+    Set-Content -LiteralPath $testPlanPath -Value $testPlanOriginal -Encoding UTF8
+
+    $missingHaGoal = $positiveTestPlan.Replace('uptime/SLA and RTO/RPO goals', 'uptime goals')
+    Set-Content -LiteralPath $testPlanPath -Value $missingHaGoal -Encoding UTF8
+    $missingHaGoalOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
+    $negativeResults += @{ name='missingHaGoalRejected'; passed=($LASTEXITCODE -ne 0) }
+    if ($LASTEXITCODE -eq 0) { throw 'HA Test Plan without RTO/RPO goals was not rejected.' }
+
+    $missingHaReference = $positiveTestPlan.Replace('Use LMP strategy Section 7.2. ', '')
+    Set-Content -LiteralPath $testPlanPath -Value $missingHaReference -Encoding UTF8
+    $missingHaReferenceOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
+    $negativeResults += @{ name='missingHaSourceReferenceRejected'; passed=($LASTEXITCODE -ne 0) }
+    if ($LASTEXITCODE -eq 0) { throw 'HA Test Plan without its strategy reference was not rejected.' }
+
+    $missingDrNormalization = $positiveTestPlan.Replace('tested failback and normalization', 'tested failback')
+    Set-Content -LiteralPath $testPlanPath -Value $missingDrNormalization -Encoding UTF8
+    $missingDrNormalizationOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
+    $negativeResults += @{ name='missingDrNormalizationRejected'; passed=($LASTEXITCODE -ne 0) }
+    if ($LASTEXITCODE -eq 0) { throw 'DR Test Plan without normalization was not rejected.' }
+
+    $missingDrReference = $positiveTestPlan.Replace('Use LMP strategy Section 7.3. ', '')
+    Set-Content -LiteralPath $testPlanPath -Value $missingDrReference -Encoding UTF8
+    $missingDrReferenceOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
+    $negativeResults += @{ name='missingDrSourceReferenceRejected'; passed=($LASTEXITCODE -ne 0) }
+    if ($LASTEXITCODE -eq 0) { throw 'DR Test Plan without its strategy reference was not rejected.' }
+
+    Set-Content -LiteralPath $testPlanPath -Value $positiveTestPlan -Encoding UTF8
     $profileOriginal = Get-Content -LiteralPath $profilePath -Raw
     $connectivityProfileRow = ([regex]::Match($profileOriginal, '(?m)^\|\s*Connectivity\s*\|.*$')).Value
     Set-Content -LiteralPath $profilePath -Value ($profileOriginal + "`n" + $connectivityProfileRow) -Encoding UTF8
@@ -109,7 +560,6 @@ try {
     if ($LASTEXITCODE -eq 0) { throw 'Duplicate testing profile row was not rejected.' }
     Set-Content -LiteralPath $profilePath -Value $profileOriginal -Encoding UTF8
 
-    $testPlanOriginal = Get-Content -LiteralPath $testPlanPath -Raw
     $traceDrift = $testPlanOriginal.Replace('| Connectivity | Applicable — fixture basis | Approved scope | NFR-001 |', '| Connectivity | Applicable — fixture basis | Approved scope | NFR-999 |')
     Set-Content -LiteralPath $testPlanPath -Value $traceDrift -Encoding UTF8
     $traceOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
@@ -138,10 +588,18 @@ try {
     Set-Content -LiteralPath $architecturePath -Value $architectureOriginal -Encoding UTF8
 
     $architectureValidationFixture = (Get-Content -LiteralPath (Join-Path (Get-RepoRoot) '.specify/templates/architecture-template.md') -Raw).Replace('| Connectivity | {REQ/NFR + disposition} | {Applicable — basis} |', '| Connectivity | NFR-001 Applicable | Exception Approved — invalid mandatory exception |')
+    foreach ($index in 0..($oatIds.Count - 1)) {
+        $architectureValidationFixture = [regex]::Replace($architectureValidationFixture, "(?m)^\|\s*$([regex]::Escape($oatIds[$index]))\s*\|.*$", [System.Text.RegularExpressions.MatchEvaluator]{ param($match) $oatArchitectureRows[$index] })
+    }
     $architectureValidationPath = Join-Path $tempRoot 'architecture-validation-negative.md'
     Set-Content -LiteralPath $architectureValidationPath -Value $architectureValidationFixture -Encoding UTF8
+    $architectureOatPositiveOutput = & (Join-Path $PSScriptRoot 'validate-architecture.ps1') -ArchitecturePath $architectureValidationPath -TestingProfilePath $profilePath -Json 2>&1
+    $architectureOatPositive = (($architectureOatPositiveOutput -join ' ') -notmatch '(?i)(OAT Scenario Applicability Matrix|Section 14\.2|OAT scenario catalog|OAT row)')
+    $results += @{ name='architectureOatCompleteMatrixAccepted'; passed=$architectureOatPositive }
+    if (-not $architectureOatPositive) { throw "Architecture validator rejected the complete OAT matrix: $($architectureOatPositiveOutput -join ' ')" }
     $architectureValidationOutput = & (Join-Path $PSScriptRoot 'validate-architecture.ps1') -ArchitecturePath $architectureValidationPath -TestingProfilePath $profilePath -Json 2>&1
-    $architectureDispositionRejected = ($LASTEXITCODE -ne 0 -and ($architectureValidationOutput -join ' ') -match "Applicable profile row 'Connectivity' must remain Applicable")
+    # Windows PowerShell 5.1 ConvertTo-Json escapes ' as \u0027.
+    $architectureDispositionRejected = ($LASTEXITCODE -ne 0 -and ($architectureValidationOutput -join ' ') -match "Applicable profile row (?:'|\\u0027)Connectivity(?:'|\\u0027) must remain Applicable")
     $negativeResults += @{ name='architectureProfileDispositionMismatchRejected'; passed=$architectureDispositionRejected }
     if (-not $architectureDispositionRejected) { throw 'Architecture validator did not report the mandatory applicability mismatch.' }
 
@@ -166,6 +624,27 @@ try {
     $negativeResults += @{ name='architectureDataSovereigntyRequired'; passed=$missingSovereigntyRejected }
     if (-not $missingSovereigntyRejected) { throw 'Architecture validator did not require the data sovereignty section.' }
 
+    $missingOatArchitecture = [regex]::Replace($architectureValidationFixture, '(?m)^\|\s*L2-OAT-GD-01\s*\|.*\r?\n', '')
+    Set-Content -LiteralPath $architectureValidationPath -Value $missingOatArchitecture -Encoding UTF8
+    $missingOatArchitectureOutput = & (Join-Path $PSScriptRoot 'validate-architecture.ps1') -ArchitecturePath $architectureValidationPath -TestingProfilePath $profilePath -Json 2>&1
+    $missingOatArchitectureRejected = ($LASTEXITCODE -ne 0 -and ($missingOatArchitectureOutput -join ' ') -match "must contain exactly one 'L2-OAT-GD-01'")
+    $negativeResults += @{ name='missingOatArchitectureIdRejected'; passed=$missingOatArchitectureRejected }
+    if (-not $missingOatArchitectureRejected) { throw 'Architecture validator did not reject a missing OAT scenario ID.' }
+
+    $missingOatAzureEvidence = $architectureValidationFixture.Replace('Proposed Azure target: evidenced service mapping', '')
+    Set-Content -LiteralPath $architectureValidationPath -Value $missingOatAzureEvidence -Encoding UTF8
+    $missingOatAzureOutput = & (Join-Path $PSScriptRoot 'validate-architecture.ps1') -ArchitecturePath $architectureValidationPath -TestingProfilePath $profilePath -Json 2>&1
+    $missingOatAzureRejected = ($LASTEXITCODE -ne 0 -and ($missingOatAzureOutput -join ' ') -match "row 'L2-OAT-GD-01' has an unresolved required field")
+    $negativeResults += @{ name='missingOatAzureEvidenceRejected'; passed=$missingOatAzureRejected }
+    if (-not $missingOatAzureRejected) { throw 'Architecture validator did not reject missing Azure target evidence.' }
+
+    $unsafeProductionOat = $architectureValidationFixture.Replace('Fixture scenario | Recommended | As-is evidence: source baseline recorded | Proposed Azure target: evidenced service mapping | Objective: measurable operational threshold | Production actions: approved change CHG-123; bounded impact; communications; stop conditions; recovery readiness', 'Database failover | Recommended | As-is evidence: source baseline recorded | Proposed Azure target: evidenced service mapping | Objective: measurable operational threshold | Production actions: pending change; no bounded impact or stop conditions')
+    Set-Content -LiteralPath $architectureValidationPath -Value $unsafeProductionOat -Encoding UTF8
+    $unsafeProductionOatOutput = & (Join-Path $PSScriptRoot 'validate-architecture.ps1') -ArchitecturePath $architectureValidationPath -TestingProfilePath $profilePath -Json 2>&1
+    $unsafeProductionOatRejected = ($LASTEXITCODE -ne 0 -and ($unsafeProductionOatOutput -join ' ') -match "Production-disruptive OAT row 'L2-OAT-GD-01'")
+    $negativeResults += @{ name='unsafeProductionOatDesignRejected'; passed=$unsafeProductionOatRejected }
+    if (-not $unsafeProductionOatRejected) { throw 'Architecture validator did not reject unsafe production-disruptive OAT design.' }
+
     $badRaci = $testPlanOriginal.Replace('| Connectivity | R | C | A | I | I | Jane Smith |', '| Connectivity | A | C | A | R | I | Jane Smith |')
     Set-Content -LiteralPath $testPlanPath -Value $badRaci -Encoding UTF8
     $raciOutput = & (Join-Path $PSScriptRoot 'validate-test-plan.ps1') -TestPlanPath $testPlanPath -TestingProfilePath $profilePath -ArchitecturePath $architecturePath -PlanPath $planPath -Json 2>&1
@@ -307,8 +786,19 @@ try {
     $gatePlan = (Get-Content -LiteralPath $planPath -Raw) + "`n## 2. Review Gate`n`n**Outcome**: Cleared`n`n**Reviewed by**: Jane Smith | **Date**: 2026-09-21 | **Outcome**: Approved"
     Set-Content -LiteralPath (Join-Path $featureRoot 'plan.md') -Value $gatePlan -Encoding UTF8
     Copy-Item -LiteralPath $testPlanPath -Destination (Join-Path $featureRoot 'G-test-plan.md')
+    # Completed gate checklists so negative cases fail on the condition under test, not on a missing checklist.
+    New-Item -ItemType Directory -Path (Join-Path $featureRoot 'checklists') -Force | Out-Null
+    foreach ($gateChecklist in @('spec', 'plan')) {
+        $baselineText = Get-Content -LiteralPath (Join-Path (Get-RepoRoot) ".specify/checklists/$gateChecklist.md") -Raw
+        Set-Content -LiteralPath (Join-Path $featureRoot "checklists/$gateChecklist.md") -Value ($baselineText -replace '(?m)^- \[ \] (CHK\d{3})', '- [x] $1') -Encoding UTF8
+    }
     $previousAppRoot = $env:SPEC_LAYER_APP_ROOT
+    $previousTemp = $env:TEMP
+    $previousTmp = $env:TMP
     $env:SPEC_LAYER_APP_ROOT = $appRoot
+    # Keep the existing test-only prerequisite restriction scoped to this runner's fixture.
+    $env:TEMP = $tempRoot
+    $env:TMP = $tempRoot
     try {
         @('# Requirements Index','','## Requirements Review Gate','','| Gate | Status |','| --- | --- |','| Requirements Review Gate | Cleared |','','**Reviewed by**: Jane Smith | **Date**: 2026-09-21 | **Outcome**: Approved') | Set-Content -LiteralPath (Join-Path $featureRoot 'requirements/index.md') -Encoding UTF8
         $implementationReadyOutput = & (Join-Path $PSScriptRoot 'check-prerequisites.ps1') -RequireImplementationReady -TestOnlySkipNonTestingValidation -Json 2>&1
@@ -414,6 +904,8 @@ try {
         if (-not $architectureChangesRequestedRejected) { throw 'Architecture gate-local Changes requested outcome was accepted as cleared.' }
     } finally {
         $env:SPEC_LAYER_APP_ROOT = $previousAppRoot
+        $env:TEMP = $previousTemp
+        $env:TMP = $previousTmp
     }
 
     $result = @{ valid=$true; validations=$results; negativeValidations=$negativeResults }
diff --git a/.specify/scripts/powershell/validate-architecture.ps1 b/.specify/scripts/powershell/validate-architecture.ps1
index d6f4089..d8d780b 100644
--- a/.specify/scripts/powershell/validate-architecture.ps1
+++ b/.specify/scripts/powershell/validate-architecture.ps1
@@ -1,4 +1,4 @@
-#requires -Version 5.1
+﻿#requires -Version 5.1
 # Validates target architecture views and their connectivity-table reconciliation.
 [CmdletBinding()]
 param(
@@ -45,6 +45,7 @@ if (-not $TestingProfilePath -or -not (Test-Path -LiteralPath $TestingProfilePat
 }
 
 $content = Get-Content -LiteralPath $ArchitecturePath -Raw
+$architectureGateCleared = (Get-GateReviewState -Content $content -GateName 'Architecture Review Gate').Status -eq 'Cleared'
 $errors = [System.Collections.Generic.List[string]]::new()
 $warnings = [System.Collections.Generic.List[string]]::new()
 
@@ -84,6 +85,9 @@ $requiredSections = [ordered]@{
     'Migration Transition & Cutover Design' = '##\s+7A\.\s+Migration Transition\s*&\s*Cutover Design\s*$'
     'Complexity Calculator V4.1 Inputs' = '###\s+8A\.\s+Complexity Calculator V4\.1 Inputs\s*$'
     'Migration Testability Matrix' = '###\s+14\.1\s+Migration Testability Matrix\s*$'
+    'OAT Scenario Applicability Matrix' = '###\s+14\.2\s+OAT Scenario Applicability Matrix\s*$'
+    'High-Level Test Scenario Design' = '###\s+14\.3\s+High-Level Test Scenario Design\s*$'
+    'Migration Impact-to-Test Crosswalk' = '###\s+14\.4\s+Migration Impact-to-Test Crosswalk\s*$'
     'Environment Topology Variances' = '###\s+1\.3\s+Environment Topology Variances\s*$'
     'Technology Inventory and Lifecycle' = '###\s+3\.2\s+Technology Inventory and Lifecycle\s*$'
     'Infrastructure Requirements Assessment' = '###\s+3\.3\s+Infrastructure Requirements Assessment\s*$'
@@ -139,7 +143,7 @@ if ($null -ne $mecBody) {
                 $proposedCount++
             }
         }
-        if ($proposedCount -gt 0 -and $content -match '(?m)^\*\*Outcome\*\*:\s*Cleared\b') {
+        if ($proposedCount -gt 0 -and $architectureGateCleared) {
             Add-ValidationError "Architecture Review Gate cannot be Cleared while $proposedCount MEC compliance rows remain Proposed."
         }
     }
@@ -168,6 +172,7 @@ if (-not (Test-Path -LiteralPath $mecChecklistPath -PathType Leaf)) {
     }
     $mecCheckedCount = @($mecChecklistItems | Where-Object { $_.Groups['mark'].Value -match '[xX]' }).Count
     $mecOpenCount = $mecChecklistItems.Count - $mecCheckedCount
+    $mecRequiredOpenCount = (Get-ChecklistState -ChecklistPath $mecChecklistPath -BaselinePath $mecBaselinePath).RequiredOpenCount
     $mecStatusSection = [regex]::Match($content, '(?ms)^####\s+7\.4\.1\s+MEC Assessment Quality Checklist\s*\r?\n(?<body>.*?)(?=^###\s)')
     if (-not $mecStatusSection.Success) {
         Add-ValidationError 'Architecture is missing Section 7.4.1 MEC Assessment Quality Checklist.'
@@ -182,8 +187,8 @@ if (-not (Test-Path -LiteralPath $mecChecklistPath -PathType Leaf)) {
             }
         }
     }
-    if ($mecOpenCount -gt 0 -and $content -match '(?m)^\*\*Outcome\*\*:\s*Cleared\b') {
-        Add-ValidationError "Architecture Review Gate cannot be Cleared while $mecOpenCount required MEC checklist item(s) remain unchecked."
+    if ($mecRequiredOpenCount -gt 0 -and $architectureGateCleared) {
+        Add-ValidationError "Architecture Review Gate cannot be Cleared while $mecRequiredOpenCount gate-required MEC checklist item(s) remain unchecked."
     }
 }
 
@@ -257,6 +262,136 @@ if ($null -ne $testabilitySection) {
     }
 }
 
+$scenarioSection = Get-SectionContent -HeadingPattern '###\s+14\.3\s+High-Level Test Scenario Design'
+if ($null -eq $scenarioSection) {
+    Add-ValidationError 'Missing Section 14.3 High-Level Test Scenario Design.'
+} else {
+    $profileActionsSection = [regex]::Match($testingProfileContent, '(?ms)^##\s+Human Input and Decision Register\s*$\s*(?<body>.*?)(?=^##\s|\z)')
+    $profileActionIds = @()
+    if ($profileActionsSection.Success) {
+        $profileActionIds = @([regex]::Matches($profileActionsSection.Groups['body'].Value, '(?mi)^\|\s*(?<id>ACT-\d{3}|AUT-\d{2,})\s*\|') | ForEach-Object { $_.Groups['id'].Value })
+    }
+    $scenarioRefs = @()
+    foreach ($testType in $canonicalTestTypes) {
+        $typeRow = [regex]::Match($testabilitySection, "(?mi)^\|\s*$([regex]::Escape($testType))\s*\|(?<rest>.*)$")
+        $typeCells = @($typeRow.Groups['rest'].Value.TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
+        if ($typeCells.Count -lt 2 -or $typeCells[1] -match '^Not Applicable|^Exception Approved') { continue }
+        $rows = @([regex]::Matches($scenarioSection, "(?mi)^\|\s*(?<id>[^|]+)\s*\|\s*$([regex]::Escape($testType))\s*\|(?<rest>.*)$"))
+        if ($rows.Count -eq 0) {
+            $reviewRow = [regex]::Match($testingProfileContent, "(?mi)^\|\s*(?<id>AUT-\d{2,})\s*\|\s*$([regex]::Escape($testType))\s*\|")
+            if (-not $reviewRow.Success -or $profileActionIds -notcontains $reviewRow.Groups['id'].Value) {
+                Add-ValidationError "Section 14.3 '$testType' needs an evidenced scenario family or its owned Application Team action."
+            }
+            continue
+        }
+        foreach ($row in $rows) {
+            $scenarioRef = $row.Groups['id'].Value.Trim()
+            if ($scenarioRef -notmatch '^[A-Za-z][A-Za-z0-9._-]+$') { Add-ValidationError "Section 14.3 '$testType' has invalid stable family reference '$scenarioRef'." }
+            $scenarioRefs += $scenarioRef
+            $cells = @($row.Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
+            if ($cells.Count -ne 5) { Add-ValidationError "Section 14.3 '$testType' requires all five design fields."; continue }
+            foreach ($index in 0..4) {
+                if (-not $cells[$index] -or $cells[$index] -match '^\{.*\}$') { Add-ValidationError "Section 14.3 '$testType' has an unresolved design field."; break }
+            }
+            if ($cells[0] -notmatch '\b(?:REQ|NFR)-\d{3}\b') { Add-ValidationError "Section 14.3 '$testType' requires requirement traces." }
+            $reviewRow = [regex]::Match($testingProfileContent, "(?mi)^\|\s*(?<id>AUT-\d{2,})\s*\|\s*$([regex]::Escape($testType))\s*\|\s*(?<status>[^|]+)\s*\|")
+            if (-not $reviewRow.Success -or $cells[2] -notmatch "\b$([regex]::Escape($reviewRow.Groups['id'].Value))\b" -or $cells[2] -notmatch "\b$([regex]::Escape($reviewRow.Groups['status'].Value.Trim()))\b") {
+                Add-ValidationError "Section 14.3 '$testType' must trace its automation review ID and status."
+            }
+            if ($cells[4] -notmatch '(?i)Section\s+\d' -or $cells[4] -notmatch '(?i)Appendix 5' -or $cells[4] -notmatch '(?i)implementation' -or $cells[4] -notmatch '(?i)execution' -or $cells[4] -notmatch '(?i)maintenance') {
+                Add-ValidationError "Section 14.3 '$testType' must separate implementation/execution/maintenance and cite the LMP section/Appendix 5."
+            }
+        }
+    }
+    foreach ($duplicate in @($scenarioRefs | Group-Object | Where-Object { $_.Count -gt 1 })) {
+        Add-ValidationError "Section 14.3 family reference '$($duplicate.Name)' is duplicated."
+    }
+}
+
+$impactSection = Get-SectionContent -HeadingPattern $requiredSections['Migration Impact-to-Test Crosswalk']
+if ($null -ne $impactSection) {
+    $impactHeader = ([regex]::Match($impactSection, '(?m)^\|.*\|\s*$')).Value
+    foreach ($column in @('Impact ID','Source Component / Store / Interface / Flow and Evidence Locator','Target Disposition (Retain / Change / Replace / Retire)','Data / State Movement Mechanism or Evidence-backed None','Impacted and Dependent Unchanged Behavior','REQ/NFR and Test Type / Section 14.3 Family or Supplied Case','Coverage Disposition (Covered / Proposed / Excluded / Pending) and Evidence','Owner / Action ID / Gate')) {
+        if ($impactHeader -notmatch [regex]::Escape($column)) { Add-ValidationError "Section 14.4 is missing required column '$column'." }
+    }
+    $impactRows = @([regex]::Matches($impactSection, '(?mi)^\|\s*(?<id>XWALK-\d{3})\s*\|(?<rest>.*)$'))
+    if ($impactRows.Count -eq 0) { Add-ValidationError 'Section 14.4 must contain at least one evidenced impact row or an explicit tracked inventory gap.' }
+    $impactIds = @()
+    $profileRequirementIds = @()
+    foreach ($testType in $canonicalTestTypes) {
+        $profileRow = [regex]::Match($testingProfileContent, "(?mi)^\|\s*$([regex]::Escape($testType))\s*\|(?<rest>.*)$")
+        if (-not $profileRow.Success) { continue }
+        $profileCells = @($profileRow.Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
+        if ($profileCells.Count -ge 4) { $profileRequirementIds += @([regex]::Matches($profileCells[3], '\b(?:REQ|NFR)-\d{3}\b') | ForEach-Object { $_.Value }) }
+    }
+    $profileRequirementIds = @($profileRequirementIds | Select-Object -Unique)
+    $scenarioReferenceSet = @()
+    if ($null -ne $scenarioSection) { $scenarioReferenceSet = @([regex]::Matches($scenarioSection, '(?mi)^\|\s*(?<id>[A-Za-z][A-Za-z0-9._-]+)\s*\|\s*(?:Connectivity|Unit|Data migration verification|Migration tool|Application installation|Smoke/regression|Change-based functional|Full functional|Performance and baseline|High availability|Disaster recovery|Security testing|Security penetration testing|Operational acceptance testing|User acceptance testing)\s*\|') | ForEach-Object { $_.Groups['id'].Value }) }
+    $profileActionIds = @()
+    $profileActionsSection = [regex]::Match($testingProfileContent, '(?ms)^##\s+Human Input and Decision Register\s*$\s*(?<body>.*?)(?=^##\s|\z)')
+    if ($profileActionsSection.Success) { $profileActionIds = @([regex]::Matches($profileActionsSection.Groups['body'].Value, '(?mi)^\|\s*(?<id>ACT-\d{3}|AUT-\d{2,})\s*\|') | ForEach-Object { $_.Groups['id'].Value }) }
+    foreach ($impactRow in $impactRows) {
+        $impactId = $impactRow.Groups['id'].Value
+        $impactIds += $impactId
+        $cells = @($impactRow.Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
+        if ($cells.Count -ne 7) { Add-ValidationError "Section 14.4 row '$impactId' requires all seven impact-to-test fields."; continue }
+        if ($cells[0] -match '(?i)^(?:N/?A|Unknown|TBD|\{.*\})$' -and $cells[6] -notmatch '\b(?:ACT-\d{3}|AUT-\d{2,})\b') { Add-ValidationError "Section 14.4 row '$impactId' must identify its source inventory item or link an owner action." }
+        if ($cells[1] -notmatch '^(?:Retain|Change|Replace|Retire)\b') { Add-ValidationError "Section 14.4 row '$impactId' must distinguish Retain, Change, Replace, or Retire." }
+        if ($cells[2] -match '(?i)^(?:N/?A|Unknown|TBD|\{.*\})$') { Add-ValidationError "Section 14.4 row '$impactId' must state a data/state movement mechanism or cite evidence-backed no movement." }
+        if ($cells[3] -match '(?i)^(?:N/?A|Unknown|TBD|\{.*\})$' -and $cells[6] -notmatch '\b(?:ACT-\d{3}|AUT-\d{2,})\b') { Add-ValidationError "Section 14.4 row '$impactId' must identify affected/dependent behavior or an owner action." }
+        $impactRequirementIds = @([regex]::Matches($cells[4], '\b(?:REQ|NFR)-\d{3}\b') | ForEach-Object { $_.Value } | Select-Object -Unique)
+        $coverageDispositionMatch = [regex]::Match($cells[5], '^(?<value>Covered|Proposed|Excluded|Pending)(?:\s+[—:-]\s*(?<detail>.*))?$')
+        if (-not $coverageDispositionMatch.Success) { Add-ValidationError "Section 14.4 row '$impactId' has invalid coverage disposition '$($cells[5])'." }
+        $coverageDisposition = if ($coverageDispositionMatch.Success) { $coverageDispositionMatch.Groups['value'].Value } else { $null }
+        if ($coverageDisposition -eq 'Excluded' -and ($coverageDispositionMatch.Groups['detail'].Value -match '(?i)^(?:N/?A|None|Unknown|TBD|\{.*\})$' -or $coverageDispositionMatch.Groups['detail'].Value.Length -lt 8)) { Add-ValidationError "Section 14.4 excluded row '$impactId' requires applicability evidence." }
+        $hasCanonicalType = $false
+        foreach ($testType in $canonicalTestTypes) { if ($cells[4] -match [regex]::Escape($testType)) { $hasCanonicalType = $true; break } }
+        $hasCaseTrace = $cells[4] -match '\b(?:SCN-[A-Za-z0-9_-]+|CASE-[A-Za-z0-9._-]+|L2-OAT-[A-Z]+-\d{2})\b'
+        if ($coverageDisposition -in @('Covered','Proposed') -and ($impactRequirementIds.Count -eq 0 -or -not $hasCanonicalType -or -not $hasCaseTrace)) { Add-ValidationError "Section 14.4 row '$impactId' must link REQ/NFR, canonical test type and a family/supplied case." }
+        foreach ($requirementId in $impactRequirementIds) {
+            if ($profileRequirementIds -notcontains $requirementId) { Add-ValidationError "Section 14.4 row '$impactId' references '$requirementId' absent from the authoritative testing profile." }
+        }
+        $scenarioIds = @([regex]::Matches($cells[4], '\bSCN-[A-Za-z0-9_-]+\b') | ForEach-Object { $_.Value })
+        foreach ($scenarioId in $scenarioIds) { if ($scenarioReferenceSet -notcontains $scenarioId) { Add-ValidationError "Section 14.4 row '$impactId' references missing Section 14.3 family '$scenarioId'." } }
+        if ($coverageDisposition -eq 'Pending' -and $cells[6] -notmatch '\b(?:ACT-\d{3}|AUT-\d{2,})\b') { Add-ValidationError "Pending Section 14.4 row '$impactId' must link a human action." }
+        foreach ($actionId in @([regex]::Matches($cells[6], '\b(?:ACT-\d{3}|AUT-\d{2,})\b') | ForEach-Object { $_.Value })) {
+            if ($profileActionIds -notcontains $actionId) { Add-ValidationError "Section 14.4 row '$impactId' references missing profile action '$actionId'." }
+        }
+    }
+    foreach ($duplicate in @($impactIds | Group-Object | Where-Object { $_.Count -gt 1 })) { Add-ValidationError "Section 14.4 impact ID '$($duplicate.Name)' is duplicated." }
+}
+
+$oatSection = Get-SectionContent -HeadingPattern $requiredSections['OAT Scenario Applicability Matrix']
+$oatCatalogPath = Join-Path (Get-RepoRoot) 'docs/testing-strategy/LSEG-L2-OAT-Game-Day-Scenario-Catalog.md'
+if (-not (Test-Path -LiteralPath $oatCatalogPath -PathType Leaf)) {
+    Add-ValidationError "LSEG L2 OAT scenario catalog is missing: $oatCatalogPath"
+} elseif ($null -ne $oatSection) {
+    $oatHeader = ([regex]::Match($oatSection, '(?m)^\|.*\|\s*$')).Value
+    foreach ($column in @('Catalog ID','Scenario','Applicability','As-is evidence','Proposed Azure target and evidence','Operational objective / testability','Environment, safety, change','Owner, runbook, evidence, ADR/risk')) {
+        if ($oatHeader -notmatch [regex]::Escape($column)) { Add-ValidationError "Section 14.2 OAT matrix is missing required column '$column'." }
+    }
+    $oatIds = @()
+    foreach ($group in @(@{ prefix='GD'; count=24 }, @{ prefix='CHG'; count=9 }, @{ prefix='VAL'; count=18 })) {
+        for ($number = 1; $number -le $group.count; $number++) {
+            $oatIds += "L2-OAT-$($group.prefix)-$('{0:D2}' -f $number)"
+        }
+    }
+    foreach ($oatId in $oatIds) {
+        $rows = @([regex]::Matches($oatSection, "(?mi)^\|\s*$([regex]::Escape($oatId))\s*\|(?<rest>.*)$"))
+        if ($rows.Count -ne 1) { Add-ValidationError "Section 14.2 must contain exactly one '$oatId' scenario row (found $($rows.Count))."; continue }
+        $cells = @($rows[0].Groups['rest'].Value.TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
+        if ($cells.Count -lt 7) { Add-ValidationError "Section 14.2 row '$oatId' is missing required fields."; continue }
+        if ($cells[1] -notin @('Recommended','Conditionally applicable','Not applicable','Blocked')) { Add-ValidationError "Section 14.2 row '$oatId' has invalid applicability '$($cells[1])'." }
+        if ($cells[1] -eq 'Not applicable' -and $cells[2] -match '(?i)^(?:N/?A|None|Unknown|TBD|\{.*\})$') { Add-ValidationError "Section 14.2 Not applicable row '$oatId' requires evidence that its condition does not apply." }
+        foreach ($index in 0..6) { if (-not $cells[$index] -or $cells[$index] -match '^\{.*\}$') { Add-ValidationError "Section 14.2 row '$oatId' has an unresolved required field."; break } }
+        if (($cells[0] + ' ' + $cells[5]) -match '(?i)production.*(?:failover|inject|terminate|disable|shutdown|restart|deny|block|chaos|disrupt)|(?:failover|inject|terminate|disable|shutdown|restart|deny|block|chaos|disrupt).*production') {
+            foreach ($safeguard in @('approved change','bounded impact','communications','stop conditions','recovery readiness')) {
+                if ($cells[5] -notmatch "(?i)$([regex]::Escape($safeguard))") { Add-ValidationError "Production-disruptive OAT row '$oatId' must document '$safeguard'." }
+            }
+        }
+    }
+}
+
 $complexitySection = Get-SectionContent -HeadingPattern $requiredSections['Complexity Calculator V4.1 Inputs']
 if ($null -ne $complexitySection) {
     $complexityFactors = @(
@@ -316,6 +451,7 @@ if ($null -ne $complexitySection) {
                 if ($checklistItem.Groups['mark'].Value -match '[xX]') { $checkedCount++ }
             }
             $openCount = $checklistItems.Count - $checkedCount
+            $requiredOpenCount = (Get-ChecklistState -ChecklistPath $complexityChecklistPath -BaselinePath $complexityBaselinePath).RequiredOpenCount
             $statusRow = [regex]::Match($complexitySection, '(?mi)^\|\s*`?checklists/complexity-calculator\.md`?\s*\|(?<rest>.*)$')
             if (-not $statusRow.Success) {
                 Add-ValidationError 'Section 8A.Q must contain a status row for checklists/complexity-calculator.md.'
@@ -336,17 +472,16 @@ if ($null -ne $complexitySection) {
                     if (-not [int]::TryParse($statusCells[3], [ref]$reportedOpen) -or $reportedOpen -ne $openCount) {
                         Add-ValidationError "Section 8A.Q reports open count '$($statusCells[3])' but checklist contains $openCount unchecked items."
                     }
-                    if ($openCount -eq 0 -and $statusCells[5] -notmatch '^Pass\b') {
-                        Add-ValidationError 'Section 8A.Q disposition must be Pass when no checklist items are open.'
+                    if ($requiredOpenCount -eq 0 -and $statusCells[5] -notmatch '^Pass\b') {
+                        Add-ValidationError 'Section 8A.Q disposition must be Pass when no gate-required checklist items are open.'
                     }
-                    if ($openCount -gt 0 -and $statusCells[5] -notmatch '^Blocked\b') {
-                        Add-ValidationError 'Section 8A.Q disposition must be Blocked when checklist items remain open.'
+                    if ($requiredOpenCount -gt 0 -and $statusCells[5] -notmatch '^Blocked\b') {
+                        Add-ValidationError 'Section 8A.Q disposition must be Blocked when gate-required checklist items remain open.'
                     }
                 }
             }
-            $gateOutcome = [regex]::Match($content, '(?mi)^\*\*Outcome\*\*:\s*(?<value>.+)$')
-            if ($gateOutcome.Success -and $gateOutcome.Groups['value'].Value.Trim() -match '^Cleared\b' -and $openCount -gt 0) {
-                Add-ValidationError "Architecture Review Gate is Cleared but the required Complexity quality checklist has $openCount open item(s)."
+            if ($architectureGateCleared -and $requiredOpenCount -gt 0) {
+                Add-ValidationError "Architecture Review Gate is Cleared but the required Complexity quality checklist has $requiredOpenCount gate-required open item(s)."
             }
         }
     }
diff --git a/.specify/scripts/powershell/validate-checklists.ps1 b/.specify/scripts/powershell/validate-checklists.ps1
index ae21ae9..6bd0d72 100644
--- a/.specify/scripts/powershell/validate-checklists.ps1
+++ b/.specify/scripts/powershell/validate-checklists.ps1
@@ -1,4 +1,4 @@
-#requires -Version 5.1
+﻿#requires -Version 5.1
 # Validates Spec-Kit quality checklist structure and reports completion.
 [CmdletBinding()]
 param(
@@ -6,6 +6,7 @@ param(
     [string]$ChecklistPath,
     [string]$BaselinePath,
     [switch]$RequireComplete,
+    [switch]$IncludePostGate,
     [switch]$Json
 )
 
@@ -116,15 +117,14 @@ foreach ($file in $checklistFiles) {
         }
     }
 
-    $checkedCount = 0
-    foreach ($itemMatch in $itemMatches) {
-        if ($itemMatch.Groups['mark'].Value -match '[xX]') { $checkedCount++ }
-    }
-    $openCount = $itemMatches.Count - $checkedCount
+    $state = Get-ChecklistState -ChecklistPath $file.FullName -BaselinePath $effectiveBaselinePath
+    $checkedCount = $state.CheckedCount
+    $openCount = $state.OpenCount
     $gateEffectMatch = [regex]::Match($content, '(?mi)^\*\*Gate Effect\*\*:\s*(?<value>.+)$')
     $gateEffect = if ($gateEffectMatch.Success) { $gateEffectMatch.Groups['value'].Value.Trim() } else { 'Unknown' }
-    if ($RequireComplete -and $openCount -gt 0) {
-        $errors.Add("$($file.Name): $openCount required checklist item(s) remain unchecked.")
+    $blockingOpenIds = if ($IncludePostGate) { $state.OpenIds } else { $state.RequiredOpenIds }
+    if ($RequireComplete -and $blockingOpenIds.Count -gt 0) {
+        $errors.Add("$($file.Name): $($blockingOpenIds.Count) required checklist item(s) remain unchecked: $($blockingOpenIds -join ', ').")
     }
 
     $results.Add([PSCustomObject]@{
@@ -132,6 +132,8 @@ foreach ($file in $checklistFiles) {
         itemCount = $itemMatches.Count
         checkedCount = $checkedCount
         openCount = $openCount
+        requiredOpenIds = @($state.RequiredOpenIds)
+        postGateOpenIds = @($state.OpenIds | Where-Object { $_ -in $state.PostGateIds })
         completionPercent = [math]::Round(($checkedCount / $itemMatches.Count) * 100, 2)
         traceabilityPercent = $traceabilityPercent
         gateEffect = $gateEffect
@@ -144,9 +146,11 @@ foreach ($file in $checklistFiles) {
 $result = @{
     valid = $errors.Count -eq 0
     requireComplete = [bool]$RequireComplete
+    includePostGate = [bool]$IncludePostGate
     checklistCount = $results.Count
     checklists = @($results)
     errors = @($errors)
 }
 Write-ScriptResult -Data $result -Json:$Json
 if ($errors.Count -gt 0) { exit 1 }
+exit 0
diff --git a/.specify/scripts/powershell/validate-implementation-backlog.ps1 b/.specify/scripts/powershell/validate-implementation-backlog.ps1
index d6c27c2..125a54e 100644
--- a/.specify/scripts/powershell/validate-implementation-backlog.ps1
+++ b/.specify/scripts/powershell/validate-implementation-backlog.ps1
@@ -1,4 +1,4 @@
-#requires -Version 5.1
+﻿#requires -Version 5.1
 # Validates architecture-derived implementation Features, User Stories and Tasks through execution handoff.
 [CmdletBinding()]
 param(
diff --git a/.specify/scripts/powershell/validate-publication.ps1 b/.specify/scripts/powershell/validate-publication.ps1
index 929fcec..7eb5ee1 100644
--- a/.specify/scripts/powershell/validate-publication.ps1
+++ b/.specify/scripts/powershell/validate-publication.ps1
@@ -28,11 +28,16 @@ if ($manifest) {
     }
     $externalEntry = $manifest.deliverables | Where-Object { $_.id -eq 'F-1' }
     if ($externalEntry.applicability -ne 'External') { $errors.Add('F-1 must remain External unless a separate governance layer explicitly owns it.') }
+    $testPlanEntry = @($manifest.deliverables | Where-Object { $_.id -eq 'G-3' })
+    if ($testPlanEntry.Count -eq 1 -and ($testPlanEntry[0].path -ne 'G-test-plan.md' -or -not $testPlanEntry[0].frameworkManaged)) {
+        $errors.Add('G-3 must be a framework-managed deliverable at deliverables/G-test-plan.md, sourced from the canonical feature-root G-test-plan.md.')
+    }
     $selectedEntries = @($manifest.deliverables | Where-Object { $_.path -and (-not $DeliverableId -or $_.id -in $DeliverableId) })
     if ($DeliverableId -and $selectedEntries.Count -ne $DeliverableId.Count) { $errors.Add('One or more requested deliverable IDs are missing or have no publishable path.') }
     foreach ($entry in $selectedEntries) {
         $outputPath = [System.IO.Path]::GetFullPath((Join-Path $paths.DELIVERABLES_DIR $entry.path))
         if (-not (Test-Path -LiteralPath $outputPath -PathType Leaf)) {
+            if ($entry.id -eq 'G-3' -and $entry.applicability -eq 'Pending' -and -not (Test-Path -LiteralPath $paths.TEST_PLAN -PathType Leaf) -and -not ($DeliverableId -and 'G-3' -in $DeliverableId)) { continue }
             if ($entry.frameworkManaged) { $errors.Add("Managed deliverable $($entry.id) is missing at $outputPath.") }
             continue
         }
@@ -40,6 +45,14 @@ if ($manifest) {
         if ($content -notmatch '<!-- speckit-publication-metadata:start -->') { $errors.Add("Deliverable $($entry.id) has no publication metadata block."); continue }
         if ($content -notmatch "\*\*Deliverable Version:\*\*\s+$($entry.currentVersion)\s") { $errors.Add("Deliverable $($entry.id) version does not match its manifest entry.") }
         $baseContent = Get-PublicationContentBody -Content $content
+        if ($entry.id -eq 'G-3') {
+            if (-not (Test-Path -LiteralPath $paths.TEST_PLAN -PathType Leaf)) {
+                $errors.Add('G-3 publication exists but the canonical feature-root G-test-plan.md is missing.')
+            } else {
+                $canonicalBody = Get-PublicationContentBody -Content (Get-Content -LiteralPath $paths.TEST_PLAN -Raw)
+                if ($baseContent -cne $canonicalBody) { $errors.Add('G-3 publication content differs from the canonical feature-root G-test-plan.md.') }
+            }
+        }
         if ($entry.id -eq 'C-3' -and $baseContent -match '(?i)Datadog|BigPanda') {
             if ($baseContent -notmatch '(?is)Excluded from C-3.{0,160}Application Team|Application Team.{0,160}Excluded from C-3') {
                 $errors.Add('C-3 references Datadog/BigPanda without declaring their commercial charges excluded and Application Team-owned.')
@@ -59,7 +72,6 @@ if ($manifest) {
     if ($manifest.sourceFingerprint -ne $currentSourceState.fingerprint) { $errors.Add('Publication sources changed after the last publish pass. Re-run /speckit.publish.') }
 }
 
-if (Test-Path -LiteralPath (Join-Path $paths.DELIVERABLES_DIR 'G-test-plan.md') -PathType Leaf) { $errors.Add('deliverables/G-test-plan.md duplicates the canonical feature-root G-test-plan.md.') }
 foreach ($directory in @($paths.DELIVERABLES_EVIDENCE_DIR, $paths.DELIVERABLES_APPROVALS_DIR)) {
     if (-not (Test-Path -LiteralPath $directory -PathType Container)) { $errors.Add("Required rerun-safe directory is missing: $directory") }
 }
diff --git a/.specify/scripts/powershell/validate-records.ps1 b/.specify/scripts/powershell/validate-records.ps1
index 57f6fbd..c923475 100644
--- a/.specify/scripts/powershell/validate-records.ps1
+++ b/.specify/scripts/powershell/validate-records.ps1
@@ -15,6 +15,14 @@ $errors = [System.Collections.Generic.List[string]]::new()
 
 function Add-ValidationError { param([string]$Message); $errors.Add($Message) }
 function Get-RecordFiles { param([string]$Directory, [string]$Pattern); if (Test-Path $Directory) { @(Get-ChildItem -LiteralPath $Directory -File -Filter '*.md' | Where-Object { $_.Name -ne 'index.md' -and $_.Name -match $Pattern } | Sort-Object Name) } else { @() } }
+function Test-HumanReviewRecorded {
+    # A review counts only when the decision/disposition, reviewer and YYYY-MM-DD date cells are all filled in.
+    param([string]$Content, [string]$DecisionField)
+    $decision = $Content -match ('(?m)^\|\s*' + [regex]::Escape($DecisionField) + '\s*\|\s*[^|\s\[{][^|]*\|')
+    $reviewer = $Content -match '(?m)^\|\s*Reviewer\s*\|\s*[^|\s\[{-][^|]*\|'
+    $date = $Content -match '(?m)^\|\s*Review Date\s*\|\s*\d{4}-\d{2}-\d{2}\s*\|'
+    return ($decision -and $reviewer -and $date)
+}
 
 $reqFiles = Get-RecordFiles $paths.REQUIREMENTS_DIR '^(REQ|NFR)-\d{3}-[^.]+\.md$'
 $mecFiles = @(Get-ChildItem -LiteralPath $paths.REQUIREMENTS_DIR -File -Filter 'MEC-*.md' -ErrorAction SilentlyContinue)
@@ -29,7 +37,7 @@ $reqIds = @{}
 foreach ($file in $reqFiles) {
     $id = ($file.BaseName -split '-')[0..1] -join '-'
     if ($reqIds.ContainsKey($id)) { Add-ValidationError "Duplicate requirement ID: $id" } else { $reqIds[$id] = $file.FullName }
-    $content = Get-Content -LiteralPath $file -Raw
+    $content = Get-Content -LiteralPath $file.FullName -Raw
     foreach ($required in @('## Intent / Problem Addressed','## Requirement')) { if ($content -notmatch [regex]::Escape($required)) { Add-ValidationError "$($file.Name) missing heading: $required" } }
     if ($content -match '\b(TBD|TODO|\{[^}]+\})\b') { Add-ValidationError "$($file.Name) contains unresolved placeholder text." }
 }
@@ -38,11 +46,11 @@ $adrIds = @{}
 foreach ($file in $adrFiles) {
     $id = ($file.BaseName -split '-')[0..1] -join '-'
     if ($adrIds.ContainsKey($id)) { Add-ValidationError "Duplicate ADR ID: $id" } else { $adrIds[$id] = $file.FullName }
-    $content = Get-Content -LiteralPath $file -Raw
+    $content = Get-Content -LiteralPath $file.FullName -Raw
     foreach ($required in @('## Context and Problem Statement','## Decision Drivers','## Considered Options','## Decision Outcome','### Positive Consequences','### Negative Consequences','## Pros and Cons of the Options','## Links')) { if ($content -notmatch [regex]::Escape($required)) { Add-ValidationError "$($file.Name) missing MADR heading: $required" } }
     if ($content -notmatch '(?m)^- Status:\s+(proposed|accepted|rejected|deprecated|superseded by)') { Add-ValidationError "$($file.Name) has invalid or missing MADR Status." }
     if ($content -match '(?m)^- Status:\s+(accepted|rejected|deprecated|superseded by)') {
-        if ($content -notmatch '(?m)^\| Reviewer \|\s*[^|{}-]+\s*\|') { Add-ValidationError "$($file.Name) is final but has no named human reviewer." }
+        if (-not (Test-HumanReviewRecorded -Content $content -DecisionField 'Human Decision')) { Add-ValidationError "$($file.Name) is final but its Human Review table lacks a recorded Human Decision, named Reviewer or YYYY-MM-DD Review Date." }
     }
 }
 
@@ -50,9 +58,13 @@ $riskIds = @{}
 foreach ($file in $riskFiles) {
     $id = ($file.BaseName -split '-')[0..1] -join '-'
     if ($riskIds.ContainsKey($id)) { Add-ValidationError "Duplicate risk ID: $id" } else { $riskIds[$id] = $file.FullName }
+    $content = Get-Content -LiteralPath $file.FullName -Raw
+    if ($content -match '(?m)^- Status:\s*(?!Identified\b)\S') {
+        if (-not (Test-HumanReviewRecorded -Content $content -DecisionField 'Human Disposition')) { Add-ValidationError "$($file.Name) has left Identified but its Human Disposition table lacks a recorded disposition, named Reviewer or YYYY-MM-DD Review Date." }
+    }
 }
 
-$mecText = ($mecFiles | ForEach-Object { Get-Content -LiteralPath $_ -Raw }) -join "`n"
+$mecText = ($mecFiles | ForEach-Object { Get-Content -LiteralPath $_.FullName -Raw }) -join "`n"
 $mecIds = @([regex]::Matches($mecText, 'MEC-v3_3-(\d+)') | ForEach-Object { [int]$_.Groups[1].Value } | Sort-Object -Unique)
 if ($mecIds.Count -ne 30 -or (1..30 | Where-Object { $_ -notin $mecIds }).Count -gt 0) {
     Add-ValidationError 'MEC evidence records must contain all MEC-v3_3-1 through MEC-v3_3-30 IDs.'
@@ -106,8 +118,9 @@ if ($mecFiles.Count -gt 0) {
 
 $allIds = @($reqIds.Keys + $adrIds.Keys + $riskIds.Keys)
 foreach ($file in @($reqFiles + $adrFiles + $riskFiles)) {
-    $content = Get-Content -LiteralPath $file -Raw
-    foreach ($match in [regex]::Matches($content, '\b(REQ|NFR|ADR|RSK)-\d{3,4}\b')) {
+    $content = Get-Content -LiteralPath $file.FullName -Raw
+    # Lookbehind skips catalog IDs such as LMP-ADR-0010, which are not this feature's records.
+    foreach ($match in [regex]::Matches($content, '(?<![A-Za-z0-9-])(REQ|NFR|ADR|RSK)-\d{3,4}\b')) {
         $id = $match.Value
         if ($id -notin $allIds -and $id -notmatch '^NFR-COMPLIANCE-') { Add-ValidationError "$($file.Name) references missing record: $id" }
     }
@@ -116,3 +129,4 @@ foreach ($file in @($reqFiles + $adrFiles + $riskFiles)) {
 $result = @{ feature = $FeatureDirName; requirements = $reqFiles.Count; decisions = $adrFiles.Count; risks = $riskFiles.Count; mecControls = $mecIds.Count; errors = $errors }
 if ($Json) { $result | ConvertTo-Json -Depth 5 } else { $result | Format-List }
 if ($errors.Count -gt 0) { exit 1 }
+exit 0
diff --git a/.specify/scripts/powershell/validate-requirements-testing.ps1 b/.specify/scripts/powershell/validate-requirements-testing.ps1
index d05df41..0afd538 100644
--- a/.specify/scripts/powershell/validate-requirements-testing.ps1
+++ b/.specify/scripts/powershell/validate-requirements-testing.ps1
@@ -4,6 +4,8 @@
 param(
     [string]$TestingProfilePath,
     [string]$RequirementsDirectory,
+    [ValidateSet('Draft','ReadyForReview','Execution')]
+    [string]$ValidationStage = 'Execution',
     [switch]$Json
 )
 
@@ -25,6 +27,8 @@ if (-not $RequirementsDirectory) { $RequirementsDirectory = Split-Path -Parent $
 
 $content = Get-Content -LiteralPath $TestingProfilePath -Raw
 $errors = [System.Collections.Generic.List[string]]::new()
+$warnings = [System.Collections.Generic.List[string]]::new()
+$inputCompleteness = [ordered]@{ sources = 0; verifiedAssets = 0; unresolvedAssets = 0; openConflicts = 0; openActions = 0 }
 $requiredTypes = @(
     'Connectivity', 'Unit', 'Data migration verification', 'Migration tool',
     'Application installation', 'Smoke/regression', 'Change-based functional',
@@ -104,6 +108,157 @@ if (-not $profileMatch.Success) {
             $errors.Add('Disaster recovery acceptance must explicitly occur in Production; lower environments are rehearsal only.')
         }
     }
+
+    if (@([regex]::Matches($profile, '(?mi)^\|\s*Integration(?:\s+testing)?\s*\|')).Count -gt 0) {
+        $errors.Add('Integration is scenario scope, not a standalone testing-profile test type; place it under Change-based functional or mandatory UAT.')
+    }
+    $changeFunctionalRow = [regex]::Match($profile, '(?mi)^\|\s*Change-based functional\s*\|(?<rest>.*)$')
+    if ($changeFunctionalRow.Success) {
+        $changeFunctionalText = $changeFunctionalRow.Value
+        foreach ($term in @('integration', 'Re-Factor', 'Re-Host/Re-Platform', 'Migration Team', 'UAT', 'Application Team')) {
+            if ($changeFunctionalText -notmatch [regex]::Escape($term)) {
+                $errors.Add("Change-based functional testing must define the integration ownership branch and include '$term'.")
+            }
+        }
+    }
+    $uatRow = [regex]::Match($profile, '(?mi)^\|\s*User acceptance testing\s*\|(?<rest>.*)$')
+    if ($uatRow.Success -and ($uatRow.Value -notmatch '(?i)integration' -or $uatRow.Value -notmatch '(?i)Application Team')) {
+        $errors.Add('Mandatory UAT must include applicable integration scenarios under Application Team ownership.')
+    }
+}
+
+$automationReview = [regex]::Match($content, '(?ms)^##\s+Automation Availability Review\s*$\s*(?<body>.*?)(?=^##\s|\z)')
+if (-not $automationReview.Success) {
+    $errors.Add('Missing required Automation Availability Review section.')
+} else {
+    $reviewIds = @()
+    foreach ($testType in $requiredTypes) {
+        $rows = @([regex]::Matches($automationReview.Groups['body'].Value, "(?mi)^\|\s*(?<id>AUT-\d{2,})\s*\|\s*$([regex]::Escape($testType))\s*\|(?<rest>.*)$"))
+        if ($rows.Count -ne 1) { $errors.Add("Automation review must contain exactly one '$testType' entry."); continue }
+        $reviewIds += $rows[0].Groups['id'].Value
+        $cells = @($rows[0].Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
+        if ($cells.Count -ne 5) { $errors.Add("Automation review '$testType' must contain all five review fields."); continue }
+        $status = $cells[0]
+        if ($status -notin @('Verified','Partial','None','Unknown','Not Applicable')) { $errors.Add("Automation review '$testType' has invalid status '$status'.") }
+        foreach ($index in 1..4) {
+            if (-not $cells[$index] -or $cells[$index] -match '^\{.*\}$') { $errors.Add("Automation review '$testType' has an unresolved required field."); break }
+        }
+        if ($status -in @('Partial','None','Verified') -and ($cells[1] -notmatch '\b\d{4}-\d{2}-\d{2}\b' -or $cells[1] -match '(?i)^\s*(?:Unknown|Pending|None|N/?A)\s*$')) {
+            $errors.Add("Automation review '$testType' status '$status' requires dated response/run evidence.")
+        }
+        if ($status -in @('Unknown','Partial','None')) {
+            if ($cells[3] -notmatch '(?i)Application Team' -or $cells[3] -notmatch '(?i)owner|coordinator' -or $cells[3] -notmatch '(?i)needed.by') {
+                $errors.Add("Automation review '$testType' requires an Application Team action/contact, coordinating owner and needed-by gate/date.")
+            }
+            if ($cells[4] -notmatch '\b(?:REQ|NFR)-\d{3}\b' -or $cells[4] -notmatch '\b(?:ADR-\d{4}|RSK-\d{3})\b') {
+                $errors.Add("Automation review '$testType' gap must trace a requirement and ADR/risk.")
+            }
+        }
+        if ($status -eq 'Not Applicable') {
+            $typeRow = [regex]::Match($profileMatch.Groups['body'].Value, "(?mi)^\|\s*$([regex]::Escape($testType))\s*\|(?<rest>.*)$")
+            $typeCells = @($typeRow.Groups['rest'].Value.TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
+            if ($typeCells.Count -lt 2 -or $typeCells[1] -ne 'Not Applicable') { $errors.Add("Automation review '$testType' cannot be Not Applicable when testing applicability is not Not Applicable.") }
+        }
+    }
+    if (@($reviewIds | Select-Object -Unique).Count -ne $reviewIds.Count) { $errors.Add('Automation review IDs must be unique.') }
+}
+
+$sourceSection = [regex]::Match($content, '(?ms)^##\s+Evidence Sources and Conflicts\s*$\s*(?<body>.*?)(?=^##\s|\z)')
+$assetSection = [regex]::Match($content, '(?ms)^##\s+Test Asset Inventory\s*$\s*(?<body>.*?)(?=^##\s|\z)')
+$actionSection = [regex]::Match($content, '(?ms)^##\s+Human Input and Decision Register\s*$\s*(?<body>.*?)(?=^##\s|\z)')
+$modernSections = @(
+    @{ Name='Evidence Sources and Conflicts'; Match=$sourceSection },
+    @{ Name='Test Asset Inventory'; Match=$assetSection },
+    @{ Name='Human Input and Decision Register'; Match=$actionSection }
+)
+foreach ($section in $modernSections) {
+    if (-not $section.Match.Success) {
+        if ($ValidationStage -eq 'Draft') { $warnings.Add("Legacy profile is missing '$($section.Name)'; migrate it before review.") }
+        else { $errors.Add("Testing profile is missing required section '$($section.Name)'.") }
+    }
+}
+
+$sourceIds = @()
+$conflictIds = @()
+if ($sourceSection.Success) {
+    $sourceBody = $sourceSection.Groups['body'].Value
+    $sourceRows = @([regex]::Matches($sourceBody, '(?mi)^\|\s*(?<id>SRC-\d{3})\s*\|(?<rest>.*)$'))
+    foreach ($sourceRow in $sourceRows) {
+        $cells = @($sourceRow.Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
+        if ($cells.Count -ne 7) { $errors.Add("Evidence source '$($sourceRow.Groups['id'].Value)' must contain all seven provenance fields (found $($cells.Count))."); continue }
+        if ($cells[0] -match '(?i)^(?:N/?A|Unknown|TBD|\{.*\})$' -or $cells[1] -match '(?i)^(?:N/?A|Unknown|TBD|\{.*\})$') { $errors.Add("Evidence source '$($sourceRow.Groups['id'].Value)' needs an artifact/version and exact locator or explicit follow-up.") }
+        if ($cells[3] -notin @('Sourced fact','Proposed judgment','Human input','Approved decision')) { $errors.Add("Evidence source '$($sourceRow.Groups['id'].Value)' has invalid evidence class '$($cells[3])'.") }
+        if ($cells[4] -match '(?i)^(?:N/?A|Unknown|TBD|\{.*\})$') { $errors.Add("Evidence source '$($sourceRow.Groups['id'].Value)' must name governing authority or the human action needed.") }
+        $sourceIds += $sourceRow.Groups['id'].Value
+        $inputCompleteness.sources++
+    }
+    if (@($sourceIds | Select-Object -Unique).Count -ne $sourceIds.Count) { $errors.Add('Evidence Source IDs must be unique.') }
+    $conflictRows = @([regex]::Matches($sourceBody, '(?mi)^\|\s*(?<id>CON-\d{3})\s*\|(?<rest>.*)$'))
+    foreach ($conflictRow in $conflictRows) {
+        $cells = @($conflictRow.Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
+        if ($cells.Count -ne 6) { $errors.Add("Source conflict '$($conflictRow.Groups['id'].Value)' must contain all six resolution fields."); continue }
+        if ($cells[0] -notmatch '\bSRC-\d{3}\b.*\bSRC-\d{3}\b' -or $cells[0] -match '\bSRC-(\d{3})\b.*\bSRC-\1\b') { $errors.Add("Source conflict '$($conflictRow.Groups['id'].Value)' must cite two distinct competing source IDs and locators.") }
+        if ($cells[2] -match '(?i)^(?:N/?A|Unknown|TBD|\{.*\})$' -and $cells[3] -notmatch '\b(?:ACT-\d{3}|AUT-\d{2,})\b') { $errors.Add("Unresolved source conflict '$($conflictRow.Groups['id'].Value)' must identify its owner action.") }
+        if ($cells[4] -notin @('Open','Resolved with evidence')) { $errors.Add("Source conflict '$($conflictRow.Groups['id'].Value)' has invalid status '$($cells[4])'.") }
+        if ($cells[4] -eq 'Open') { $inputCompleteness.openConflicts++ }
+        $conflictIds += $conflictRow.Groups['id'].Value
+    }
+    if (@($conflictIds | Select-Object -Unique).Count -ne $conflictIds.Count) { $errors.Add('Source Conflict IDs must be unique.') }
+}
+
+$registeredActions = @{}
+if ($actionSection.Success) {
+    $actionRows = @([regex]::Matches($actionSection.Groups['body'].Value, '(?mi)^\|\s*(?<id>ACT-\d{3}|AUT-\d{2,})\s*\|(?<rest>.*)$'))
+    foreach ($actionRow in $actionRows) {
+        $actionId = $actionRow.Groups['id'].Value
+        $cells = @($actionRow.Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
+        if ($cells.Count -ne 8) { $errors.Add("Human input action '$actionId' must contain all eight action fields (found $($cells.Count))."); continue }
+        if ($registeredActions.ContainsKey($actionId)) { $errors.Add("Human input action ID '$actionId' is duplicated.") } else { $registeredActions[$actionId] = $true }
+        if ($cells[0] -match '(?i)^(?:N/?A|Unknown|TBD|\{.*\})$' -or $cells[1] -match '(?i)^(?:N/?A|Unknown|TBD|\{.*\})$') { $errors.Add("Action '$actionId' must state a specific question and expected evidence.") }
+        if ($cells[2] -match '(?i)^(?:N/?A|Unknown|TBD|\{.*\})$' -or $cells[3] -match '(?i)^(?:N/?A|Unknown|TBD|\{.*\})$') { $errors.Add("Action '$actionId' must name a contact/accountable coordinator and needed-by date or gate.") }
+        if ($cells[6] -notin @('Requested','Answered-unvalidated','Validated','Closed')) { $errors.Add("Action '$actionId' has invalid status '$($cells[6])'.") }
+        if ($cells[6] -in @('Validated','Closed') -and ($cells[7] -match '(?i)^(?:Pending|Unknown|N/?A|\{.*\})$' -or $cells[7] -notmatch '(?i)(?:https?://|(?:SRC|AST|CASE|REQ|NFR|ADR|RSK|report|result|evidence|record)[-/#])')) { $errors.Add("Action '$actionId' cannot be Validated/Closed without an answer and evidence locator.") }
+        if ($cells[6] -in @('Requested','Answered-unvalidated')) { $inputCompleteness.openActions++ }
+    }
+    $autActions = @($actionRows | Where-Object { $_.Groups['id'].Value -match '^AUT-' } | ForEach-Object { $_.Groups['id'].Value })
+    if (@($autActions | Select-Object -Unique).Count -ne $autActions.Count) { $errors.Add('Automation review action IDs must be unique in the shared action register.') }
+}
+
+if ($assetSection.Success) {
+    $assetRows = @([regex]::Matches($assetSection.Groups['body'].Value, '(?mi)^\|\s*(?<id>AST-\d{3})\s*\|(?<rest>.*)$'))
+    $assetIds = @()
+    foreach ($assetRow in $assetRows) {
+        $assetId = $assetRow.Groups['id'].Value
+        $cells = @($assetRow.Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
+        if ($cells.Count -ne 8) { $errors.Add("Test asset '$assetId' must contain all eight inventory fields (found $($cells.Count))."); continue }
+        if ($cells[2] -notin @('Reported-linked','Available-unverified','Verified-available','Unavailable','Unknown')) { $errors.Add("Test asset '$assetId' has invalid availability '$($cells[2])'.") }
+        if ($cells[3] -notin @('Reuse','Adapt','Build','Manual','Excluded','Undecided')) { $errors.Add("Test asset '$assetId' has invalid reuse health '$($cells[3])'.") }
+        if ($cells[2] -eq 'Verified-available' -and ($cells[5] -notmatch '\b20\d{2}-\d{2}-\d{2}\b' -or $cells[5] -notmatch '(?i)\b(?:run|result|report)\b')) { $errors.Add("Test asset '$assetId' cannot be Verified-available without dated run/result evidence.") }
+        if ($cells[2] -in @('Available-unverified','Unavailable','Unknown') -and $cells[7] -notmatch '\b(?:ACT-\d{3}|AUT-\d{2,})\b') { $errors.Add("Unverified test asset '$assetId' needs an action to confirm availability or report the gap.") }
+        foreach ($actionId in @([regex]::Matches($cells[7], '\b(?:ACT-\d{3}|AUT-\d{2,})\b') | ForEach-Object { $_.Value })) {
+            if (-not $registeredActions.ContainsKey($actionId) -and $actionId -notmatch '^AUT-' ) { $errors.Add("Test asset '$assetId' references missing action '$actionId'.") }
+        }
+        $assetIds += $assetId
+        if ($cells[2] -eq 'Verified-available') { $inputCompleteness.verifiedAssets++ }
+        if ($cells[2] -in @('Reported-linked','Available-unverified','Unavailable','Unknown')) { $inputCompleteness.unresolvedAssets++ }
+    }
+    if (@($assetIds | Select-Object -Unique).Count -ne $assetIds.Count) { $errors.Add('Test Asset IDs must be unique.') }
+}
+
+if ($automationReview.Success) {
+    foreach ($testType in $requiredTypes) {
+        $reviewRow = [regex]::Match($automationReview.Groups['body'].Value, "(?mi)^\|\s*(?<id>AUT-\d{2,})\s*\|\s*$([regex]::Escape($testType))\s*\|(?<rest>.*)$")
+        if (-not $reviewRow.Success) { continue }
+        $reviewCells = @($reviewRow.Groups['rest'].Value.TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
+        if ($reviewCells.Count -lt 5) { continue }
+        $status = $reviewCells[0]
+        $needsAction = $status -in @('Unknown','Partial','None')
+        if ($needsAction -and $reviewCells[3] -notmatch "\b$([regex]::Escape($reviewRow.Groups['id'].Value))\b") { $errors.Add("Automation review '$($reviewRow.Groups['id'].Value)' must link its shared action ID.") }
+        if ($needsAction -and -not $registeredActions.ContainsKey($reviewRow.Groups['id'].Value) -and $ValidationStage -ne 'Draft') { $errors.Add("Automation review '$($reviewRow.Groups['id'].Value)' requires a matching action in Human Input and Decision Register.") }
+        if ($status -eq 'Verified' -and ($reviewCells[1] -notmatch '\b20\d{2}-\d{2}-\d{2}\b' -or $reviewCells[1] -notmatch '(?i)\b(?:run|result|report)\b' -or $reviewCells[2] -match '(?i)^(?:Unknown|Pending|N/?A|\{.*\})$')) {
+            $errors.Add("Automation review '$($reviewRow.Groups['id'].Value)' cannot claim Verified without dated run/result evidence and a stated verified coverage scope.")
+        }
+    }
 }
 
 $readinessMatch = [regex]::Match($content, '(?ms)^##\s+Test Readiness Inputs\s*$\s*(?<body>.*?)(?=^##\s|\z)')
@@ -126,9 +281,12 @@ if ($content -match '\{[^{}\r\n]+\}') { $errors.Add('Testing profile contains un
 
 $result = @{
     testingProfilePath = [System.IO.Path]::GetFullPath($TestingProfilePath)
+    validationStage = $ValidationStage
     valid = ($errors.Count -eq 0)
     errorCount = $errors.Count
     errors = @($errors)
+    warnings = @($warnings)
+    inputCompleteness = $inputCompleteness
 }
 Write-ScriptResult -Data $result -Json:$Json
 if ($errors.Count -gt 0) { exit 1 }
diff --git a/.specify/scripts/powershell/validate-requirements-transition.ps1 b/.specify/scripts/powershell/validate-requirements-transition.ps1
index 6fa2ea6..d628b24 100644
--- a/.specify/scripts/powershell/validate-requirements-transition.ps1
+++ b/.specify/scripts/powershell/validate-requirements-transition.ps1
@@ -1,4 +1,4 @@
-#requires -Version 5.1
+﻿#requires -Version 5.1
 # Validates the migration-transition requirements profile before architecture begins.
 [CmdletBinding()]
 param(
diff --git a/.specify/scripts/powershell/validate-sad-contract.ps1 b/.specify/scripts/powershell/validate-sad-contract.ps1
index e27a0b8..6412591 100644
--- a/.specify/scripts/powershell/validate-sad-contract.ps1
+++ b/.specify/scripts/powershell/validate-sad-contract.ps1
@@ -30,11 +30,12 @@ $tempContract = Join-Path ([System.IO.Path]::GetTempPath()) ("sad-contract-" + [
 try {
     & $exporterPath -DocxPath $DocxPath -OutputPath $tempContract -Json | Out-Null
     if (-not (Test-Path -LiteralPath $tempContract -PathType Leaf)) { throw 'Failed to export live SAD contract.' }
-    $expected = Get-Content -LiteralPath $ContractPath -Raw | ConvertFrom-Json
-    $actual = Get-Content -LiteralPath $tempContract -Raw | ConvertFrom-Json
-    $coverage = Get-Content -LiteralPath $CoveragePath -Raw | ConvertFrom-Json
-    $baseline = Get-Content -LiteralPath $BaselinePath -Raw
-    $architecture = Get-Content -LiteralPath $ArchitectureTemplatePath -Raw
+    # -Encoding UTF8: Windows PowerShell 5.1 otherwise decodes these BOM-less files as ANSI.
+    $expected = Get-Content -LiteralPath $ContractPath -Raw -Encoding UTF8 | ConvertFrom-Json
+    $actual = Get-Content -LiteralPath $tempContract -Raw -Encoding UTF8 | ConvertFrom-Json
+    $coverage = Get-Content -LiteralPath $CoveragePath -Raw -Encoding UTF8 | ConvertFrom-Json
+    $baseline = Get-Content -LiteralPath $BaselinePath -Raw -Encoding UTF8
+    $architecture = Get-Content -LiteralPath $ArchitectureTemplatePath -Raw -Encoding UTF8
 
     if ($actual.sourceSha256 -ne $expected.sourceSha256) {
         $errors.Add("Canonical SAD DOCX SHA-256 changed ($($expected.sourceSha256) -> $($actual.sourceSha256)); regenerate/review the contract and ownership map.")
@@ -50,8 +51,9 @@ try {
     $expectedHeadingSignature = @($expected.headings | ForEach-Object { "$($_.headingLevel)|$($_.style)|$($_.text)" }) -join "`n"
     if ($actualHeadingSignature -ne $expectedHeadingSignature) { $errors.Add('Canonical SAD heading hierarchy changed.') }
 
-    $actualTableSignature = @($actual.tables | ForEach-Object { "$($_.headingPath -join ' > ')|$($_.columnCount)|$($_.header -join ' | ')" }) -join "`n"
-    $expectedTableSignature = @($expected.tables | ForEach-Object { "$($_.headingPath -join ' > ')|$($_.columnCount)|$($_.header -join ' | ')" }) -join "`n"
+    # [int]: the checked-in contract stores 5.0, which 5.1 renders as "5.0" but the live export as "5".
+    $actualTableSignature = @($actual.tables | ForEach-Object { "$($_.headingPath -join ' > ')|$([int]$_.columnCount)|$($_.header -join ' | ')" }) -join "`n"
+    $expectedTableSignature = @($expected.tables | ForEach-Object { "$($_.headingPath -join ' > ')|$([int]$_.columnCount)|$($_.header -join ' | ')" }) -join "`n"
     if ($actualTableSignature -ne $expectedTableSignature) { $errors.Add('Canonical SAD table schemas changed.') }
 
     $contentHeadings = @($expected.headings | Where-Object {
diff --git a/.specify/scripts/powershell/validate-test-plan.ps1 b/.specify/scripts/powershell/validate-test-plan.ps1
index 3c57b64..35fa6c3 100644
--- a/.specify/scripts/powershell/validate-test-plan.ps1
+++ b/.specify/scripts/powershell/validate-test-plan.ps1
@@ -1,4 +1,4 @@
-#requires -Version 5.1
+﻿#requires -Version 5.1
 # Validates the canonical application G-test-plan.md before task generation.
 [CmdletBinding()]
 param(
@@ -6,6 +6,8 @@ param(
     [string]$TestingProfilePath,
     [string]$ArchitecturePath,
     [string]$PlanPath,
+    [ValidateSet('Draft','ReadyForReview','Execution')]
+    [string]$ValidationStage = 'Execution',
     [switch]$Json
 )
 
@@ -29,9 +31,86 @@ $content = Get-Content -LiteralPath $TestPlanPath -Raw
 $profile = Get-Content -LiteralPath $TestingProfilePath -Raw
 $architecture = Get-Content -LiteralPath $ArchitecturePath -Raw
 $plan = Get-Content -LiteralPath $PlanPath -Raw
+$statusMatch = [regex]::Match($content, '(?mi)^\|\s*\*\*Status\*\*\s*\|\s*(?<status>[^|]+?)\s*\|')
+$planStatus = if ($statusMatch.Success) { $statusMatch.Groups['status'].Value.Trim() } else { $null }
 $errors = [System.Collections.Generic.List[string]]::new()
+$warnings = [System.Collections.Generic.List[string]]::new()
+$inputCompleteness = [ordered]@{ verified = 0; unresolved = 0; unavailable = 0; conflicting = 0 }
 $testTypes = @('Connectivity','Unit','Data migration verification','Migration tool','Application installation','Smoke/regression','Change-based functional','Full functional','Performance and baseline','High availability','Disaster recovery','Security testing','Security penetration testing','Operational acceptance testing','User acceptance testing')
 $resolvedPlanDispositions = @{}
+$deferredReadiness = [System.Collections.Generic.List[string]]::new()
+$deferredApprovers = [System.Collections.Generic.List[string]]::new()
+$actionsSectionMatch = [regex]::Match($profile, '(?ms)^##\s+Human Input and Decision Register\s*$\s*(?<body>.*?)(?=^##\s|\z)')
+$profileActionRows = @([regex]::Matches($actionsSectionMatch.Groups['body'].Value, '(?mi)^\|\s*(?<id>ACT-\d{3}|AUT-\d{2,})\s*\|(?<rest>.*)$'))
+$ownedActions = @{}
+foreach ($actionRow in $profileActionRows) {
+    $actionId = $actionRow.Groups['id'].Value
+    $actionCells = @($actionRow.Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
+    if ($ownedActions.ContainsKey($actionId)) { $errors.Add("Profile action '$actionId' is duplicated."); continue }
+    if ($actionCells.Count -ne 8 -or @($actionCells | Where-Object { -not $_ -or $_ -match '(?i)^(?:Unknown|TBD|N/?A|None|\{.*\})$' }).Count -gt 0 -or
+        $actionCells[2] -match '(?i)(?:^|:\s*)(?:Pending|Unknown|TBD)(?:$|[;,])' -or $actionCells[3] -match '(?i)^Pending$' -or
+        $actionCells[6] -notin @('Requested','Answered-unvalidated','Validated','Closed')) {
+        $errors.Add("Profile action '$actionId' requires a substantive question, evidence, contact/coordinator, needed-by gate, trace, impact and valid status.")
+        continue
+    }
+    if ($actionCells[6] -in @('Validated','Closed') -and ($actionCells[7] -match '(?i)^Pending$' -or $actionCells[7] -notmatch '(?i)(?:https?://|(?:SRC|AST|CASE|REQ|NFR|ADR|RSK|report|result|evidence|record)[-/#])')) {
+        $errors.Add("Profile action '$actionId' cannot be Validated/Closed without an answer and evidence locator.")
+        continue
+    }
+    $ownedActions[$actionId] = $actionCells
+}
+
+function Test-OwnedDependency {
+    param([string]$Trace, [switch]$Appointment)
+    $traceIds = @([regex]::Matches($Trace, '\b(?:ACT-\d{3}|AUT-\d{2,}|REQ-\d{3}|NFR-\d{3}|ADR-\d{4}|RSK-\d{3})\b') | ForEach-Object { $_.Value })
+    foreach ($actionId in $ownedActions.Keys) {
+        $cells = $ownedActions[$actionId]
+        if ($cells[6] -notin @('Requested','Answered-unvalidated')) { continue }
+        if ($Appointment -and ($cells[0] + ' ' + $cells[5]) -notmatch '(?i)approv|appoint|authority|roster|named') { continue }
+        # Existing plans can trace the authoritative action through its REQ/NFR or ADR/risk.
+        $actionTrace = @($actionId) + @([regex]::Matches($cells[4], '\b(?:REQ-\d{3}|NFR-\d{3}|ADR-\d{4}|RSK-\d{3})\b') | ForEach-Object { $_.Value })
+        if (@($traceIds | Where-Object { $actionTrace -contains $_ }).Count -gt 0) { return $true }
+    }
+    return $false
+}
+
+$automationReviewSection = [regex]::Match($profile, '(?ms)^##\s+Automation Availability Review\s*$\s*(?<body>.*?)(?=^##\s|\z)')
+foreach ($reviewRow in @([regex]::Matches($automationReviewSection.Groups['body'].Value, '(?mi)^\|\s*(?<id>AUT-\d{2,})\s*\|(?<rest>.*)$'))) {
+    $cells = @($reviewRow.Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
+    if ($cells.Count -ne 6) { $errors.Add("Automation review '$($reviewRow.Groups['id'].Value)' requires all review fields."); continue }
+    if ($cells[1] -in @('Unknown','Partial','None') -and -not $ownedActions.ContainsKey($reviewRow.Groups['id'].Value)) { $errors.Add("Unresolved automation review '$($reviewRow.Groups['id'].Value)' requires an owned profile action.") }
+    if ($cells[1] -eq 'Verified' -and ($cells[2] -notmatch '\b20\d{2}-\d{2}-\d{2}\b' -or $cells[2] -notmatch '(?i)\b(?:run|result|report)\b')) { $errors.Add("Automation review '$($reviewRow.Groups['id'].Value)' cannot be Verified without dated run/result evidence.") }
+}
+
+$sizingMatch = [regex]::Match($content, '(?ms)^###\s+Scenario Scope and Automation Effort\s*$\s*(?<body>.*?)(?=^###\s|^##\s|\z)')
+if (-not $sizingMatch.Success) {
+    $errors.Add('Test Plan missing Scenario Scope and Automation Effort section.')
+} else {
+    $designMatch = [regex]::Match($architecture, '(?ms)^###\s+14\.3\s+High-Level Test Scenario Design\s*$\s*(?<body>.*?)(?=^###\s|^##\s|\z)')
+    foreach ($testType in $testTypes) {
+        $scopeRow = [regex]::Match($content, "(?mi)^\|\s*$([regex]::Escape($testType))\s*\|\s*(?<applicability>[^|]+)\|")
+        if ($scopeRow.Success -and $scopeRow.Groups['applicability'].Value.Trim() -match '^Not Applicable|^Exception Approved') { continue }
+        $rows = @([regex]::Matches($sizingMatch.Groups['body'].Value, "(?mi)^\|\s*[^|]+\s*\|\s*$([regex]::Escape($testType))\s*\|(?<rest>.*)$"))
+        if ($rows.Count -eq 0) { $errors.Add("Test Plan requires scenario/automation effort for '$testType'."); continue }
+        foreach ($row in $rows) {
+            $cells = @($row.Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
+            if ($cells.Count -ne 6) { $errors.Add("Test Plan sizing '$testType' requires all six scope/effort fields."); continue }
+            foreach ($index in 0..5) {
+                if (-not $cells[$index] -or $cells[$index] -match '^\{.*\}$') { $errors.Add("Test Plan sizing '$testType' has an unresolved field."); break }
+            }
+            $designRows = @([regex]::Matches($designMatch.Groups['body'].Value, "(?mi)^\|\s*(?<id>[^|]+)\s*\|\s*$([regex]::Escape($testType))\s*\|"))
+            if ($designRows.Count -eq 0 -or -not @($designRows | Where-Object { $cells[0].Contains($_.Groups['id'].Value.Trim()) }).Count) {
+                $errors.Add("Test Plan sizing '$testType' must reference its Section 14.3 scenario scope.")
+            }
+            $reviewRow = [regex]::Match($profile, "(?mi)^\|\s*(?<id>AUT-\d{2,})\s*\|\s*$([regex]::Escape($testType))\s*\|")
+            if (-not $reviewRow.Success -or $cells[1] -notmatch "\b$([regex]::Escape($reviewRow.Groups['id'].Value))\b") { $errors.Add("Test Plan sizing '$testType' must trace its automation review action.") }
+            foreach ($effortPhase in @('Review','Automation','Setup','Execution','Retest','Report')) {
+                if ($cells[3] -notmatch "(?i)\b$effortPhase\s*[:=]\s*\d") { $errors.Add("Test Plan sizing '$testType' requires a numeric person-day range for $effortPhase.") }
+            }
+            if ($cells[4] -notmatch '(?i)Section\s+\d' -or $cells[4] -notmatch '(?i)Appendix 5') { $errors.Add("Test Plan sizing '$testType' requires LMP section/RACI ownership evidence.") }
+        }
+    }
+}
 
 function Get-NormalizedApplicability {
     param([string]$Value)
@@ -46,21 +125,132 @@ function Test-IsNamedPerson {
     if (-not $Value) { return $false }
     $namePart = ($Value -replace '\s+\([^)]+\)\s*$','').Trim()
     return $namePart -match "^[A-Za-z][A-Za-z'.-]+(?:\s+[A-Za-z][A-Za-z'.-]+)+$" -and
-        $namePart -notmatch '(?i)\b(?:Team|Lead|Architect|Owner|Manager|Reviewer|Approver|Security|Operations|Testing|Migration|Application|Product|Customer|QA|LSEG|Microsoft)\b'
+        $namePart -notmatch '(?i)\b(?:Pending|Unknown|TBD|Unassigned|Appointment|Named|Team|Lead|Architect|Owner|Manager|Reviewer|Approver|Security|Operations|Testing|Migration|Application|Product|Customer|QA|LSEG|Microsoft)\b'
 }
 
-foreach ($heading in @('## Test Strategy','### Test Types','### Minimum Viable Testing','### Automation Strategy and Ownership','### RACI','### Test Assets and Traceability','### Environment Strategy','### Entry/Exit Criteria','### Defect Management','### Exceptions, Dependencies and Approvals','## Test Plan Approval Gate')) {
+foreach ($heading in @('## Test Strategy','### Test Types','### Estimated Elapsed Testing Timeline and Capacity','### Optional Pre-OAT Scope — Lower Environment','### High Availability Test Design','### Disaster Recovery Test Design','### Operational Acceptance Test Design','### Minimum Viable Testing','### Automation Strategy and Ownership','### RACI','### Test Assets and Traceability','### Environment Strategy','### Entry/Exit Criteria','### Defect Management','### Exceptions, Dependencies and Approvals','### Test Plan Review and Approval','## Test Plan Approval Gate')) {
     if ($content -notmatch "(?m)^$([regex]::Escape($heading))\s*$") { $errors.Add("Test Plan missing required heading: $heading") }
 }
 
 $testSectionMatch = [regex]::Match($content, '(?ms)^###\s+Test Types\s*$\s*(?<body>.*?)(?=^###\s|^##\s|\z)')
+$haSectionMatch = [regex]::Match($content, '(?ms)^###\s+High Availability Test Design\s*$\s*(?<body>.*?)(?=^###\s|^##\s|\z)')
+$drSectionMatch = [regex]::Match($content, '(?ms)^###\s+Disaster Recovery Test Design\s*$\s*(?<body>.*?)(?=^###\s|^##\s|\z)')
+$oatSectionMatch = [regex]::Match($content, '(?ms)^###\s+Operational Acceptance Test Design\s*$\s*(?<body>.*?)(?=^###\s|^##\s|\z)')
+$timelineMatch = [regex]::Match($content, '(?ms)^###\s+Estimated Elapsed Testing Timeline and Capacity\s*$\s*(?<body>.*?)(?=^###\s|^##\s|\z)')
+$preOatScopeMatch = [regex]::Match($content, '(?ms)^###\s+Optional Pre-OAT Scope\s+[—-]\s+Lower Environment\s*$\s*(?<body>.*?)(?=^###\s|^##\s|\z)')
+$reviewApprovalsMatch = [regex]::Match($content, '(?ms)^###\s+Test Plan Review and Approval\s*$\s*(?<body>.*?)(?=^###\s|^##\s|\z)')
 $raciMatch = [regex]::Match($content, '(?ms)^###\s+RACI\s*$\s*(?<body>.*?)(?=^###\s|^##\s|\z)')
 $mvtMatch = [regex]::Match($content, '(?ms)^###\s+Minimum Viable Testing\s*$\s*(?<body>.*?)(?=^###\s|^##\s|\z)')
 $automationMatch = [regex]::Match($content, '(?ms)^###\s+Automation Strategy and Ownership\s*$\s*(?<body>.*?)(?=^###\s|^##\s|\z)')
 $architectureTestabilityMatch = [regex]::Match($architecture, '(?ms)^###\s+14\.1\s+Migration Testability Matrix\s*$\s*(?<body>.*?)(?=^###\s|^##\s|\z)')
+$architectureOatMatch = [regex]::Match($architecture, '(?ms)^###\s+14\.2\s+OAT Scenario Applicability Matrix\s*$\s*(?<body>.*?)(?=^###\s|^##\s|\z)')
 if (-not $testSectionMatch.Success) { $errors.Add('Test Plan Test Types table is missing.') }
+if (-not $haSectionMatch.Success) { $errors.Add('Test Plan High Availability Test Design section is missing.') }
+if (-not $drSectionMatch.Success) { $errors.Add('Test Plan Disaster Recovery Test Design section is missing.') }
+if (-not $oatSectionMatch.Success) { $errors.Add('Test Plan Operational Acceptance Test Design section is missing.') }
+if (-not $timelineMatch.Success) { $errors.Add('Test Plan Estimated Elapsed Testing Timeline and Capacity section is missing.') }
+if (-not $preOatScopeMatch.Success) { $errors.Add('Test Plan optional lower-environment Pre-OAT scope section is missing.') }
+if (-not $reviewApprovalsMatch.Success) { $errors.Add('Test Plan multi-party Review and Approval section is missing.') }
 if (-not $raciMatch.Success) { $errors.Add('Test Plan RACI table is missing.') }
 if (-not $architectureTestabilityMatch.Success) { $errors.Add('Architecture Section 14.1 testability matrix is missing.') }
+if (-not $architectureOatMatch.Success) { $errors.Add('Architecture Section 14.2 OAT scenario applicability matrix is missing.') }
+foreach ($tableName in @($profile,$testSectionMatch.Groups['body'].Value,$architectureTestabilityMatch.Groups['body'].Value,$raciMatch.Groups['body'].Value)) {
+    if ($tableName -is [string] -and $tableName -match '(?mi)^\|\s*Integration(?:\s+testing)?\s*\|') {
+        $errors.Add('Integration is scenario scope, not a standalone test type/RACI row; place it under Change-based functional or mandatory UAT.')
+        break
+    }
+}
+if ($testSectionMatch.Success) {
+    $changeFunctionalRow = [regex]::Match($testSectionMatch.Groups['body'].Value, '(?mi)^\|\s*Change-based functional\s*\|(?<rest>.*)$')
+    if ($changeFunctionalRow.Success) {
+        $changeFunctionalText = $changeFunctionalRow.Value
+        foreach ($term in @('integration', 'Refactor', 'Re-Host/Re-Platform', 'Migration Team')) {
+            if ($changeFunctionalText -notmatch [regex]::Escape($term)) {
+                $errors.Add("Change-based functional Test Plan row must include integration scenarios for Migration-Team refactoring and '$term'.")
+            }
+        }
+    }
+    $uatRow = [regex]::Match($testSectionMatch.Groups['body'].Value, '(?mi)^\|\s*User acceptance testing\s*\|(?<rest>.*)$')
+    if ($uatRow.Success -and ($uatRow.Value -notmatch '(?i)integration' -or $uatRow.Value -notmatch '(?i)Application Team')) {
+        $errors.Add('Mandatory UAT Test Plan row must include applicable integration scenarios under Application Team ownership.')
+    }
+}
+
+if ($oatSectionMatch.Success) {
+    $oatDesign = $oatSectionMatch.Groups['body'].Value
+    foreach ($term in @('LSEG-L2-OAT-Game-Day-Scenario-Catalog.md','Architecture Section 14.2','as-is','Azure target','Application Operations','Production','Cutover','runbook','change')) {
+        if ($oatDesign -notmatch [regex]::Escape($term)) { $errors.Add("OAT Test Plan section must include '$term'.") }
+    }
+    $oatIds = @()
+    foreach ($group in @(@{ prefix='GD'; count=24 }, @{ prefix='CHG'; count=9 }, @{ prefix='VAL'; count=18 })) {
+        for ($number = 1; $number -le $group.count; $number++) {
+            $oatIds += "L2-OAT-$($group.prefix)-$('{0:D2}' -f $number)"
+        }
+    }
+    foreach ($oatId in $oatIds) {
+        $rows = @([regex]::Matches($oatDesign, "(?mi)^\|\s*$([regex]::Escape($oatId))\s*\|(?<rest>.*)$"))
+        if ($rows.Count -ne 1) { $errors.Add("OAT Test Plan must contain exactly one disposition row for '$oatId' (found $($rows.Count))."); continue }
+        $cells = @($rows[0].Groups['rest'].Value.TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
+        if ($cells.Count -lt 7) { $errors.Add("OAT Test Plan row '$oatId' is missing required fields."); continue }
+        if ($architectureOatMatch.Success) {
+            $architectureRows = @([regex]::Matches($architectureOatMatch.Groups['body'].Value, "(?mi)^\|\s*$([regex]::Escape($oatId))\s*\|(?<rest>.*)$"))
+            if ($architectureRows.Count -ne 1) { $errors.Add("Architecture Section 14.2 must contain exactly one '$oatId' scenario row (found $($architectureRows.Count)).") }
+            else {
+                $architectureOatCells = @($architectureRows[0].Groups['rest'].Value.TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
+                if ($architectureOatCells.Count -lt 2 -or $architectureOatCells[1] -ne $cells[1]) { $errors.Add("OAT Test Plan disposition for '$oatId' must match Architecture Section 14.2.") }
+            }
+        }
+        if ($cells[1] -notin @('Recommended','Conditionally applicable','Not applicable','Blocked')) { $errors.Add("OAT Test Plan row '$oatId' has invalid disposition '$($cells[1])'.") }
+        if ($cells[1] -eq 'Not applicable' -and $cells[2] -match '(?i)^(?:N/?A|None|Unknown|TBD|\{.*\})$') { $errors.Add("OAT Not applicable row '$oatId' requires evidence that the scenario does not apply.") }
+        foreach ($index in 0..6) { if (-not $cells[$index] -or $cells[$index] -match '^\{.*\}$') { $errors.Add("OAT Test Plan row '$oatId' has an unresolved required field."); break } }
+        if ($cells[5] -match '(?i)production' -and ($cells[0] + ' ' + $cells[4]) -match '(?i)failover|inject|terminate|disable|shutdown|restart|deny|block|chaos|disrupt') {
+            foreach ($safeguard in @('approved change','bounded impact','communications','stop conditions','recovery readiness')) {
+                if ($cells[5] -notmatch "(?i)$([regex]::Escape($safeguard))") { $errors.Add("Production-disruptive OAT row '$oatId' must document '$safeguard'.") }
+            }
+        }
+    }
+}
+
+if ($timelineMatch.Success) {
+    $timeline = $timelineMatch.Groups['body'].Value
+    $timelineHeader = ([regex]::Match($timeline, '(?m)^\|.*\|\s*$')).Value
+    foreach ($column in @('Test Type / Workstream','Applicability','Case-count and automation basis','Elapsed — 1 tester','Elapsed — 2 testers','Elapsed — 3 testers','Dependencies, overlap, wait time, confidence')) {
+        if ($timelineHeader -notmatch [regex]::Escape($column)) { $errors.Add("Testing timeline is missing required column '$column'.") }
+    }
+    foreach ($term in @('1, 2 and 3 active testers','effort','automation','external','parallel','critical path','contingency','not a sum','Optional pre-OAT','lower-environment','Migration Team','Application Team','scenario IDs/count','does not replace')) {
+        if ($timeline -notmatch [regex]::Escape($term)) { $errors.Add("Testing timeline must document '$term'.") }
+    }
+    foreach ($testType in $testTypes) {
+        $timelineRows = @([regex]::Matches($timeline, "(?mi)^\|\s*$([regex]::Escape($testType))\s*\|(?<rest>.*)$"))
+        if ($timelineRows.Count -ne 1) { $errors.Add("Testing timeline must contain exactly one '$testType' row (found $($timelineRows.Count))."); continue }
+        $cells = @($timelineRows[0].Groups['rest'].Value.TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
+        if ($cells.Count -lt 6) { $errors.Add("Testing timeline row '$testType' is missing capacity or evidence fields."); continue }
+        foreach ($index in 0..5) {
+            if (-not $cells[$index] -or $cells[$index] -match '^\{.*\}$') { $errors.Add("Testing timeline row '$testType' has an unresolved required field."); break }
+        }
+        if ($testType -eq 'Operational acceptance testing' -and $timeline -notmatch '(?i)4 calendar weeks') { $errors.Add('Testing timeline must preserve the four-calendar-week L2 Production OAT baseline unless current L2 evidence revises it.') }
+    }
+    if ($timeline -notmatch '(?i)pre-OAT.{0,160}(?:agree|agreement).{0,120}(?:scenario IDs/count|scenario count|number of scenarios)') { $errors.Add('Optional pre-OAT must require a joint scenario-count agreement before scheduling.') }
+}
+
+if ($preOatScopeMatch.Success) {
+    $preOatScope = $preOatScopeMatch.Groups['body'].Value
+    foreach ($term in @('optional','Migration Team','Application Team','scenario IDs/count','lower environment','entry/exit','duration','does not satisfy Production OAT')) {
+        if ($preOatScope -notmatch [regex]::Escape($term)) { $errors.Add("Optional Pre-OAT scope must document '$term'.") }
+    }
+}
+
+if ($reviewApprovalsMatch.Success) {
+    $reviewApprovals = $reviewApprovalsMatch.Groups['body'].Value
+    foreach ($organization in @('Migration Team','Migration Testing Team','Application Team','L2 Operations')) {
+        $approvalRows = @([regex]::Matches($reviewApprovals, "(?mi)^\|\s*$([regex]::Escape($organization))\s*\|(?<rest>.*)$"))
+        if ($approvalRows.Count -ne 1) { $errors.Add("Test Plan approvals must contain exactly one '$organization' reviewer row (found $($approvalRows.Count))."); continue }
+        $cells = @($approvalRows[0].Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
+        if ($cells.Count -lt 5 -or @($cells | Where-Object { -not $_ -or $_ -match '^\{.*\}$' }).Count -gt 0) { $errors.Add("Test Plan approval row '$organization' is incomplete or contains unresolved placeholders."); continue }
+        if ($cells[3] -notin @('Pending','Approved','Changes requested')) { $errors.Add("Test Plan approval row '$organization' has invalid outcome '$($cells[3])'.") }
+        if ($cells[3] -eq 'Approved' -and (-not (Test-IsNamedPerson -Value $cells[1]) -or $cells[2] -notmatch '^\d{4}-\d{2}-\d{2}$' -or $cells[4] -match '(?i)^(?:Pending|N/?A|None)$')) { $errors.Add("Approved Test Plan row '$organization' requires a named reviewer, ISO date and evidence link.") }
+    }
+}
 
 foreach ($testType in $testTypes) {
     $profileRows = @([regex]::Matches($profile, "(?mi)^\|\s*$([regex]::Escape($testType))\s*\|(?<rest>.*)$"))
@@ -86,7 +276,8 @@ foreach ($testType in $testTypes) {
             foreach ($architectureId in $architectureIds) { if ($profileIds -notcontains $architectureId) { $errors.Add("Architecture row '$testType' adds requirement '$architectureId' absent from the authoritative profile.") } }
             foreach ($index in 0..8) { if (-not $cells[$index] -or $cells[$index] -match '^\{.*\}$') { $errors.Add("Test Plan row '$testType' has an unresolved required field."); break } }
             if ($profileDisposition -eq 'Exception Proposed' -and $cells[9] -notmatch '\bADR-\d{4}\b.*\bRSK-\d{3}\b|\bRSK-\d{3}\b.*\bADR-\d{4}\b') { $errors.Add("Excepted Test Plan row '$testType' must link both ADR and risk.") }
-            if ($profileDisposition -eq 'Unknown') { $errors.Add("Testing profile row '$testType' remains Unknown and cannot produce an Approved Test Plan.") }
+            if ($profileDisposition -eq 'Unknown' -and $ValidationStage -eq 'Execution') { $errors.Add("Testing profile row '$testType' remains Unknown and cannot produce an execution-baseline Test Plan.") }
+            elseif ($profileDisposition -eq 'Unknown' -and -not (Test-OwnedDependency -Trace ($profileRows[0].Value + ' ' + $planRows[0].Value))) { $errors.Add("Unknown profile row '$testType' requires an owned action before review.") }
             $architectureApplicability = if ($architectureCells.Count -ge 2) { $architectureCells[1] } else { '' }
             $normalizedArchitectureApplicability = Get-NormalizedApplicability -Value $architectureApplicability
             $normalizedPlanApplicability = Get-NormalizedApplicability -Value $cells[0]
@@ -100,7 +291,14 @@ foreach ($testType in $testTypes) {
             }
             if ($profileDisposition -eq 'Not Applicable' -and ($normalizedPlanApplicability -ne 'Not Applicable' -or $normalizedArchitectureApplicability -ne 'Not Applicable')) { $errors.Add("Not Applicable profile row '$testType' is inconsistent downstream.") }
             if ($profileDisposition -eq 'Exception Proposed' -and ($normalizedPlanApplicability -ne 'Exception Approved' -or $normalizedArchitectureApplicability -ne 'Exception Approved')) { $errors.Add("Exception Proposed profile row '$testType' requires an approved exception disposition in architecture and Test Plan.") }
-            if ($architectureCells.Count -ge 8 -and $architectureCells[7] -ne 'Ready') { $errors.Add("Approved Test Plan row '$testType' requires architecture readiness Ready, found '$($architectureCells[7])'.") }
+            if ($architectureCells.Count -lt 9) { $errors.Add("Architecture row '$testType' must contain all testability fields.") }
+            elseif (@($architectureCells[0..8] | Where-Object { -not $_ -or $_ -match '^\{.*\}$' }).Count -gt 0) { $errors.Add("Architecture row '$testType' has an unresolved required testability field.") }
+            elseif ($architectureCells[7] -notin @('Ready','Conditional','Blocked')) { $errors.Add("Architecture row '$testType' has invalid readiness '$($architectureCells[7])'.") }
+            elseif ($architectureCells[7] -ne 'Ready') {
+                if ($ValidationStage -eq 'Execution') { $errors.Add("Approved Test Plan row '$testType' requires architecture readiness Ready, found '$($architectureCells[7])'.") }
+                elseif ($architectureCells[8] -notmatch '\b(?:ADR-\d{4}|RSK-\d{3})\b' -or -not (Test-OwnedDependency -Trace $architectureRows[0].Value)) { $errors.Add("Architecture row '$testType' with unresolved readiness requires an ADR/risk and an owned profile action with a needed-by gate.") }
+                else { $deferredReadiness.Add($testType) }
+            }
         }
     }
     $raciRows = if ($raciMatch.Success) { @([regex]::Matches($raciMatch.Groups['body'].Value, "(?mi)^\|\s*$([regex]::Escape($testType))\s*\|(?<rest>.*)$")) } else { @() }
@@ -125,7 +323,12 @@ foreach ($testType in $testTypes) {
             } else {
                 if ($accountableCount -ne 1) { $errors.Add("RACI row '$testType' must have exactly one accountable role (found $accountableCount).") }
                 if ($responsibleCount -lt 1) { $errors.Add("RACI row '$testType' must have at least one responsible role.") }
-                if (-not (Test-IsNamedPerson -Value $raciCells[5])) { $errors.Add("RACI row '$testType' must name the authorized human deliverable approver, not only a placeholder or generic role.") }
+                if (-not (Test-IsNamedPerson -Value $raciCells[5])) {
+                    if ($ValidationStage -eq 'Execution') { $errors.Add("RACI row '$testType' must name the authorized human deliverable approver, not only a placeholder or generic role.") }
+                    elseif ($raciCells[5] -notmatch '(?i)\b(?:Owner|Lead|Coordinator|Manager|Approver|Operations|Security|Team)\b' -or
+                        -not (Test-OwnedDependency -Trace ($raciRows[0].Value + ' ' + $planRows[0].Value) -Appointment)) { $errors.Add("RACI row '$testType' requires an approver role/contact and an owned appointment action with a needed-by gate.") }
+                    else { $deferredApprovers.Add($testType) }
+                }
             }
         }
     }
@@ -137,7 +340,7 @@ if ($mvtMatch.Success) {
         $mvtCells = @($mvtRows[0].Trim('|') -split '\|' | ForEach-Object { $_.Trim() })
         $incompleteMvtCells = @($mvtCells | Where-Object { -not $_ -or $_ -match '^\{.*\}$' })
         if ($mvtCells.Count -lt 5 -or $incompleteMvtCells.Count -gt 0) { $errors.Add('Minimum Viable Testing row is incomplete or contains placeholders.') }
-        if ($mvtCells[0] -eq 'Proposed') { $errors.Add('An Approved Test Plan cannot retain Proposed Minimum Viable Testing.') }
+        if ($mvtCells[0] -eq 'Proposed' -and $planStatus -eq 'Approved') { $errors.Add('An Approved Test Plan cannot retain Proposed Minimum Viable Testing.') }
         if ($mvtCells[0] -eq 'Approved' -and $mvtCells[3] -notmatch '\bADR-\d{4}\b.*\bRSK-\d{3}\b|\bRSK-\d{3}\b.*\bADR-\d{4}\b') { $errors.Add('Approved Minimum Viable Testing requires an ADR and linked risk.') }
         $mvtText = $mvtCells -join ' '
         if ($mvtText -notmatch '(?i)UAT.*(?:mandatory|no exemption|not waived)|(?:mandatory|no exemption|not waived).*UAT') { $errors.Add('Minimum Viable Testing disposition must state that UAT remains mandatory and is not waived.') }
@@ -182,19 +385,264 @@ $unitRow = [regex]::Match($testSectionMatch.Groups['body'].Value, '(?mi)^\|\s*Un
 if ($unitRow -notmatch '(?i)existing automated suites' -or $unitRow -notmatch '(?i)migration-changed|impacted code') { $errors.Add('Unit Test Plan scope must continue existing suites and limit Migration Team changes to migration-changed, impacted code.') }
 $drRow = [regex]::Match($testSectionMatch.Groups['body'].Value, '(?mi)^\|\s*Disaster recovery\s*\|(?<rest>.*)$').Groups['rest'].Value
 if ($drRow -notmatch '(?i)Production') { $errors.Add('Disaster recovery acceptance must be planned in Production.') }
+if ($haSectionMatch.Success) {
+    $haDesign = $haSectionMatch.Groups['body'].Value
+    foreach ($check in @(
+        @{ Label='the LMP strategy Section 7.2 source reference'; Pattern='(?i)Section 7\.2' },
+        @{ Label='Application Owner and R-Type assessment'; Pattern='(?is)Application Owner.*R-Type' },
+        @{ Label='approved uptime/SLA and RTO/RPO goals'; Pattern='(?is)(?:uptime.*SLA|SLA.*uptime).*RTO/RPO|RTO/RPO.*(?:uptime.*SLA|SLA.*uptime)' },
+        @{ Label='redundancy/failover, scalability, and resource-utilization goals'; Pattern='(?is)redundancy.*failover.*scalability.*resource utilization' },
+        @{ Label='scope/cases, pass/fail criteria, and background load'; Pattern='(?is)(?:scope|cases).*pass/fail.*background load' },
+        @{ Label='production-comparable PPE, approved SII, monitoring, and test data'; Pattern='(?is)PPE.*SII.*monitoring.*test data' },
+        @{ Label='isolated execution window and entry/exit criteria'; Pattern='(?is)isolated.*entry.*exit' },
+        @{ Label='defect treatment and signed Test Execution Results Report'; Pattern='(?is)defects?.*(?:retest|risk.accepted).*Test\s+Execution\s+Results\s+Report' }
+    )) {
+        if ($haDesign -notmatch $check.Pattern) { $errors.Add("HA Test Design must include $($check.Label).") }
+    }
+}
+if ($drSectionMatch.Success) {
+    $drDesign = $drSectionMatch.Groups['body'].Value
+    foreach ($check in @(
+        @{ Label='the LMP strategy Section 7.3 source reference'; Pattern='(?i)Section 7\.3' },
+        @{ Label='L2 Production acceptance before customer cutover'; Pattern='(?is)Production.*L2.*before customer cutover|L2.*Production.*before customer cutover' },
+        @{ Label='Migration Team runbook creation and handover to L2'; Pattern='(?is)Migration Team.*runbook.*handover to L2' },
+        @{ Label='LSEG DR Coordinator and Technology Owner'; Pattern='(?is)DR Coordinator.*Technology Owner' },
+        @{ Label='dependency failover while the hosting environment remains in place'; Pattern='(?is)dependency failover.*hosting environment remains in place' },
+        @{ Label='Production readiness, representative data, tools, trained team, and synchronized backups'; Pattern='(?is)Production.*(?:authentication|authorization).*test data.*tools.*team.*backup' },
+        @{ Label='RTA/RTO and RPA/RPO measures'; Pattern='(?is)RTA.*RTO.*RPA.*RPO' },
+        @{ Label='data integrity/accuracy, critical functionality, and tested failback/normalization'; Pattern='(?is)integrity.*accuracy.*critical functionality.*failback.*normalization' },
+        @{ Label='defect disposition, results report, evidence, and sign-off'; Pattern='(?is)defects?.*(?:retest|risk acceptance).*results report.*evidence.*sign.off' }
+    )) {
+        if ($drDesign -notmatch $check.Pattern) { $errors.Add("DR Test Design must include $($check.Label).") }
+    }
+}
 if ($content -match '(?mi)^\|\s*Security\s*/\s*penetration\s*\|') { $errors.Add('Security testing and security penetration testing must be separate Test Plan rows.') }
 
 if ($plan -notmatch '(?m)^###\s+Application Test Plan Handoff\s*$' -or $plan -notmatch '(?m)^\|\s*`G-test-plan\.md`\s*\|') { $errors.Add('plan.md does not contain the canonical G-test-plan.md handoff row.') }
 
-$statusMatch = [regex]::Match($content, '(?mi)^\|\s*\*\*Status\*\*\s*\|\s*(?<status>[^|]+?)\s*\|')
-if (-not $statusMatch.Success -or $statusMatch.Groups['status'].Value.Trim() -ne 'Approved') { $errors.Add('Test Plan status must be Approved before task generation.') }
+$requiredStatus = switch ($ValidationStage) {
+    'Draft' { 'Draft' }
+    'ReadyForReview' { 'Ready for Review' }
+    'Execution' { 'Approved' }
+}
+if (-not $statusMatch.Success -or $planStatus -ne $requiredStatus) {
+    $errors.Add("Test Plan status must be '$requiredStatus' for validation stage '$ValidationStage'.")
+}
+if ($planStatus -eq 'Approved' -and $reviewApprovalsMatch.Success) {
+    foreach ($organization in @('Migration Team','Migration Testing Team','Application Team','L2 Operations')) {
+        $approvalRow = [regex]::Match($reviewApprovalsMatch.Groups['body'].Value, "(?mi)^\|\s*$([regex]::Escape($organization))\s*\|(?<rest>.*)$")
+        if (-not $approvalRow.Success) { continue }
+        $approvalCells = @($approvalRow.Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
+        if ($approvalCells.Count -lt 4 -or $approvalCells[3] -ne 'Approved') { $errors.Add("Test Plan cannot be Approved until '$organization' records Approved for this version.") }
+    }
+}
 $approvalSection = [regex]::Match($content, '(?ms)^##\s+Test Plan Approval Gate\s*$\s*(?<body>.*?)(?=^##\s|\z)')
 $reviewMatch = if ($approvalSection.Success) { [regex]::Match($approvalSection.Value, '(?m)^\*\*Reviewed by\*\*:\s*(?<name>[^|{}]+?)\s*\|\s*\*\*Date\*\*:\s*(?<date>\d{4}-\d{2}-\d{2})\s*\|\s*\*\*Outcome\*\*:\s*Approved\s*$') } else { [regex]::Match('', 'a^') }
 $testPlanReviewer = if ($reviewMatch.Success) { $reviewMatch.Groups['name'].Value.Trim() } else { $null }
-if (-not $reviewMatch.Success -or -not (Test-IsNamedPerson -Value $testPlanReviewer)) { $errors.Add('Test Plan requires a named human reviewer, ISO date, and Approved outcome.') }
-if ($content -match '\{[^{}\r\n]+\}') { $errors.Add('Test Plan contains unresolved template placeholders.') }
+if ($ValidationStage -eq 'Execution' -and (-not $reviewMatch.Success -or -not (Test-IsNamedPerson -Value $testPlanReviewer))) { $errors.Add('Test Plan requires a named human reviewer, ISO date, and Approved outcome.') }
+if ($ValidationStage -ne 'Draft' -and $content -match '\{[^{}\r\n]+\}') { $errors.Add('Test Plan contains unresolved template placeholders.') }
+
+$caseSectionMatch = [regex]::Match($content, '(?ms)^###\s+High-Level Case Outlines\s*$\s*(?<body>.*?)(?=^###\s|^##\s|\z)')
+$estimateBoundaryMatch = [regex]::Match($content, '(?ms)^###\s+Estimate Scope and Boundary Reconciliation\s*$\s*(?<body>.*?)(?=^###\s|^##\s|\z)')
+$assetSectionMatch = [regex]::Match($content, '(?ms)^###\s+Test Assets and Traceability\s*$\s*(?<body>.*?)(?=^###\s|^##\s|\z)')
+$actionIds = @()
+if ($actionsSectionMatch.Success) {
+    $actionIds += @([regex]::Matches($actionsSectionMatch.Groups['body'].Value, '(?mi)^\|\s*(?<id>ACT-\d{3}|AUT-\d{2,})\s*\|') | ForEach-Object { $_.Groups['id'].Value })
+}
+$actionIds += @([regex]::Matches($profile, '(?mi)^\|\s*(?<id>AUT-\d{2,})\s*\|') | ForEach-Object { $_.Groups['id'].Value })
+$actionIds = @($actionIds | Select-Object -Unique)
+if ($actionsSectionMatch.Success) {
+    foreach ($actionRow in $profileActionRows) {
+        $actionCells = @($actionRow.Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
+        if ($actionCells.Count -ge 7 -and $ValidationStage -eq 'Execution' -and $actionCells[6] -in @('Requested','Answered-unvalidated') -and $actionCells[5] -match '(?i)execution|case scope|test scope|mandatory approval|target disposition') {
+            $errors.Add("Open action '$($actionRow.Groups['id'].Value)' blocks the Test Plan execution baseline: $($actionCells[0])")
+        }
+    }
+}
+
+foreach ($section in @(
+    @{ Name='High-Level Case Outlines'; Match=$caseSectionMatch },
+    @{ Name='Estimate Scope and Boundary Reconciliation'; Match=$estimateBoundaryMatch },
+    @{ Name='Test Assets and Traceability'; Match=$assetSectionMatch }
+)) {
+    if (-not $section.Match.Success) {
+        if ($ValidationStage -eq 'Draft') { $warnings.Add("Legacy or incomplete draft is missing '$($section.Name)'; migrate it before review.") }
+        else { $errors.Add("Test Plan missing required section '$($section.Name)'.") }
+    }
+}
+
+$caseRows = @()
+if ($caseSectionMatch.Success) {
+    $caseBody = $caseSectionMatch.Groups['body'].Value
+    $caseHeader = ([regex]::Match($caseBody, '(?m)^\|.*\|\s*$')).Value
+    foreach ($column in @('Case ID','Origin (Supplied / Proposed)','Source Asset / Locator','Test Type / Family / REQ-NFR / Component or Flow','Objective / Preconditions / Data / High-Level Steps','Measurable Expected Outcome','Disposition (Covered / Adapt / Proposed / Excluded / Pending) and Evidence','Environment / Tool / Automation','Owner / Evidence Result Path / Action ID')) {
+        if ($caseHeader -notmatch [regex]::Escape($column)) { $errors.Add("High-Level Case Outlines is missing required column '$column'.") }
+    }
+    $caseRows = @([regex]::Matches($caseBody, '(?mi)^\|\s*(?<id>[^|]+)\s*\|\s*(?<rest>.*)$') | Where-Object { $_.Groups['id'].Value.Trim() -notmatch '^(?:Case ID|-+)$' })
+    $seenCaseIds = @{}
+    foreach ($caseRow in $caseRows) {
+        $caseId = $caseRow.Groups['id'].Value.Trim()
+        $cells = @($caseRow.Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
+        if ($cells.Count -ne 8) { $errors.Add("Case outline '$caseId' must contain all eight detail fields."); continue }
+        if (-not $caseId -or $caseId -match '^\{.*\}$') { $errors.Add('Case outline requires a stable supplied or proposed ID.') }
+        elseif ($seenCaseIds.ContainsKey($caseId)) { $errors.Add("Case ID '$caseId' is duplicated; supplied IDs must be preserved once.") }
+        else { $seenCaseIds[$caseId] = $true }
+        if ($cells[0] -notin @('Supplied','Proposed')) { $errors.Add("Case outline '$caseId' has invalid origin '$($cells[0])'.") }
+        foreach ($field in @(@('source/trace',$cells[1] + ' ' + $cells[2]), @('objective',$cells[3]), @('measurable expected outcome',$cells[4]), @('environment/tool/automation',$cells[6]), @('owner/evidence path',$cells[7]))) {
+            if (-not $field[1].Trim() -or $field[1] -match '(?i)^\s*(?:N/?A|Unknown|TBD|Pending|\{.*\})\s*$') {
+                if ($cells[5] -notmatch '^(?:Pending|Proposed)\b' -or $cells[7] -notmatch '\b(?:ACT-\d{3}|AUT-\d{2,})\b') {
+                    $errors.Add("Case outline '$caseId' requires a substantive $($field[0]) or an owned Proposed/Pending action.")
+                }
+            }
+        }
+        if ($cells[5] -notmatch '(?i)^(Covered|Adapt|Proposed|Excluded|Pending)(?:\s+[—:-].*)?$') { $errors.Add("Case outline '$caseId' has invalid disposition '$($cells[5])'.") }
+        if ($ValidationStage -eq 'Execution' -and $cells[5] -match '^(?:Proposed|Pending)\b') { $errors.Add("Case outline '$caseId' is still Proposed/Pending and cannot enter the execution baseline.") }
+        if ($cells[0] -eq 'Supplied' -and ($cells[1] -match '(?i)^(?:N/?A|Unknown|Pending|\{.*\})$' -or $cells[1] -notmatch '(?i)(?:version|commit|hash|SRC-|AST-|https?://|[/\\])')) { $errors.Add("Supplied case '$caseId' must retain a source asset locator/version.") }
+        if ($cells[5] -match '^(?:Pending|Proposed)' -and $cells[7] -notmatch '\b(?:ACT-\d{3}|AUT-\d{2,})\b') { $errors.Add("Unresolved case '$caseId' must link an owned action.") }
+        foreach ($actionId in @([regex]::Matches($cells[7], '\b(?:ACT-\d{3}|AUT-\d{2,})\b') | ForEach-Object { $_.Value })) {
+            if ($actionIds -notcontains $actionId) { $errors.Add("Case '$caseId' references missing profile action '$actionId'.") }
+            elseif ($cells[5] -match '^(?:Pending|Proposed)' -and -not $ownedActions.ContainsKey($actionId)) { $errors.Add("Unresolved case '$caseId' references unowned profile action '$actionId'.") }
+        }
+        if (($cells[5] + ' ' + $cells[6]) -match '(?i)\b(?:Executed|Passed|Failed)\b' -and $cells[6] -notmatch '(?i)(?:dated|run|result|report|evidence)') { $errors.Add("Case '$caseId' cannot claim execution outcome without result evidence.") }
+    }
+    foreach ($testType in $testTypes) {
+        $typeRows = @($caseRows | Where-Object { $_.Groups['rest'].Value -match "(?i)\b$([regex]::Escape($testType))\b" })
+        $scopeRow = [regex]::Match($sizingMatch.Groups['body'].Value, "(?mi)^\|\s*[^|]+\s*\|\s*$([regex]::Escape($testType))\s*\|(?<rest>.*)$")
+        $scopeHasAction = $scopeRow.Success -and $scopeRow.Groups['rest'].Value -match '\b(?:ACT-\d{3}|AUT-\d{2,})\b'
+        if ($typeRows.Count -eq 0 -and -not $scopeHasAction) { $errors.Add("Test type '$testType' needs an evidence-based case outline or an owned action for missing case-design inputs.") }
+    }
+}
 
-$result = @{ testPlanPath = [System.IO.Path]::GetFullPath($TestPlanPath); valid = ($errors.Count -eq 0); errorCount = $errors.Count; errors = @($errors) }
+if ($estimateBoundaryMatch.Success) {
+    $estimateBody = $estimateBoundaryMatch.Groups['body'].Value
+    $estimateHeader = ([regex]::Match($estimateBody, '(?m)^\|.*\|\s*$')).Value
+    foreach ($column in @('Estimate ID / Source','Estimate Kind / Value / Confidence','Start Boundary','End Boundary','Included Phases / Work','Excluded Phases / External Waits','Basis / Scope Version / Evidence','Comparison / Reconciliation / Action')) {
+        if ($estimateHeader -notmatch [regex]::Escape($column)) { $errors.Add("Estimate boundary reconciliation is missing required column '$column'.") }
+    }
+    $estimateRows = @([regex]::Matches($estimateBody, '(?mi)^\|\s*EST-\d{3}\s*\|(?<rest>.*)$'))
+    if ($estimateRows.Count -eq 0) { $errors.Add('Estimate boundary reconciliation requires at least one estimate record.') }
+    $estimateIds = @()
+    foreach ($estimateRow in $estimateRows) {
+        $estimateId = ([regex]::Match($estimateRow.Value, '^\|\s*(?<id>EST-\d{3})')).Groups['id'].Value
+        $estimateIds += $estimateId
+        $cells = @($estimateRow.Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
+        if ($cells.Count -ne 7) { $errors.Add('Estimate boundary record requires kind/value, start/end, included/excluded scope, evidence and reconciliation fields.'); continue }
+        $unresolvedEstimate = @($cells[0..5] | Where-Object { $_ -match '(?i)unknown|TBD' }).Count -gt 0
+        $estimateActions = @([regex]::Matches($cells[6], '\b(?:ACT-\d{3}|AUT-\d{2,})\b') | ForEach-Object { $_.Value })
+        if ($cells[0] -eq $cells[1]) {
+            $errors.Add('Estimate boundary record must distinguish its source from the estimate or comparison.')
+        }
+        if ($unresolvedEstimate -and $estimateActions.Count -eq 0) {
+            $errors.Add('Unresolved estimate boundaries need a specific owner action; unknown scope is not treated as a zero-length estimate.')
+        }
+        elseif ($unresolvedEstimate -and $ValidationStage -eq 'Execution') {
+            $errors.Add('Estimate boundaries remain unresolved and cannot enter the execution baseline.')
+        }
+        foreach ($actionId in $estimateActions) {
+            if ($actionIds -notcontains $actionId) { $errors.Add("Estimate record references missing profile action '$actionId'.") }
+        }
+    }
+    foreach ($duplicate in @($estimateIds | Group-Object | Where-Object { $_.Count -gt 1 })) { $errors.Add("Estimate ID '$($duplicate.Name)' is duplicated.") }
+}
+
+if ($assetSectionMatch.Success) {
+    $assetBody = $assetSectionMatch.Groups['body'].Value
+    $assetHeader = ([regex]::Match($assetBody, '(?m)^\|.*\|\s*$')).Value
+    foreach ($column in @('Asset ID','Asset Type / Supplied Case IDs','Version / Locator / Owner','Availability','Reuse Health','Verified Coverage / Gaps / Families','Last Run / Result Locator','Compatibility / Applicability Evidence','Maintenance / Retention / Action ID')) {
+        if ($assetHeader -notmatch [regex]::Escape($column)) { $errors.Add("Test Assets and Traceability is missing required column '$column'.") }
+    }
+    $assetRows = @([regex]::Matches($assetBody, '(?mi)^\|\s*AST-\d{3}\s*\|(?<rest>.*)$'))
+    if ($assetRows.Count -eq 0 -and $ValidationStage -ne 'Draft') { $errors.Add('Test Asset Inventory requires a row or an explicit Unknown/Unavailable inventory record.') }
+    $seenAssetIds = @{}
+    foreach ($assetRow in $assetRows) {
+        $assetId = ([regex]::Match($assetRow.Value, '^\|\s*(?<id>AST-\d{3})')).Groups['id'].Value
+        $cells = @($assetRow.Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
+        if ($cells.Count -ne 8) { $errors.Add("Test asset '$assetId' must contain all eight inventory details."); continue }
+        if ($seenAssetIds.ContainsKey($assetId)) { $errors.Add("Test asset ID '$assetId' is duplicated.") } else { $seenAssetIds[$assetId] = $true }
+        if ($cells[2] -notin @('Reported-linked','Available-unverified','Verified-available','Unavailable','Unknown')) { $errors.Add("Test asset '$assetId' has invalid availability '$($cells[2])'.") }
+        if ($cells[3] -notin @('Reuse','Adapt','Build','Manual','Excluded','Undecided')) { $errors.Add("Test asset '$assetId' has invalid reuse health '$($cells[3])'.") }
+        if ($cells[2] -eq 'Verified-available' -and ($cells[5] -notmatch '\b20\d{2}-\d{2}-\d{2}\b' -or $cells[5] -notmatch '(?i)\b(?:run|result|report)\b')) { $errors.Add("Test asset '$assetId' cannot be Verified-available without a dated compatible run/result locator.") }
+        if ($cells[2] -in @('Unknown','Unavailable','Available-unverified') -and $cells[7] -notmatch '\b(?:ACT-\d{3}|AUT-\d{2,})\b') { $errors.Add("Unverified test asset '$assetId' must link an owner action.") }
+        foreach ($actionId in @([regex]::Matches($cells[7], '\b(?:ACT-\d{3}|AUT-\d{2,})\b') | ForEach-Object { $_.Value })) {
+            if ($actionIds -notcontains $actionId) { $errors.Add("Test asset '$assetId' references missing profile action '$actionId'.") }
+        }
+    }
+}
+
+$profileAssetSection = [regex]::Match($profile, '(?ms)^##\s+Test Asset Inventory\s*$\s*(?<body>.*?)(?=^##\s|\z)')
+if ($profileAssetSection.Success) {
+    $profileAssetRows = @([regex]::Matches($profileAssetSection.Groups['body'].Value, '(?mi)^\|\s*AST-\d{3}\s*\|(?<rest>.*)$'))
+    foreach ($assetRow in $profileAssetRows) {
+        $cells = @($assetRow.Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
+        if ($cells.Count -ge 6 -and $cells[2] -eq 'Verified-available' -and ($cells[5] -notmatch '\b20\d{2}-\d{2}-\d{2}\b' -or $cells[5] -notmatch '(?i)\b(?:run|result|report)\b')) { $errors.Add('Profile test asset cannot be Verified-available without a dated compatible run/result locator.') }
+        if ($cells.Count -ge 3 -and $cells[2] -eq 'Verified-available') { $inputCompleteness.verified++ }
+        if ($cells.Count -ge 3 -and $cells[2] -in @('Reported-linked','Available-unverified','Unavailable','Unknown')) { $inputCompleteness.unavailable++ }
+    }
+}
+$profileConflictSection = [regex]::Match($profile, '(?ms)^##\s+Evidence Sources and Conflicts\s*$\s*(?<body>.*?)(?=^##\s|\z)')
+if ($profileConflictSection.Success) {
+    $inputCompleteness.conflicting = @([regex]::Matches($profileConflictSection.Groups['body'].Value, '(?mi)^\|\s*CON-\d{3}\s*\|(?<rest>.*)$') | Where-Object {
+        $cells = @($_.Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
+        $cells.Count -ge 5 -and $cells[4] -eq 'Open'
+    }).Count
+}
+$inputCompleteness.unresolved = @($profileActionRows | Where-Object {
+    $cells = @($_.Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
+    $cells.Count -ge 7 -and $cells[6] -in @('Requested','Answered-unvalidated')
+}).Count
+$briefMatch = [regex]::Match($content, '(?ms)^##\s+Review Brief\s*$\s*(?<body>.*?)(?=^##\s|\z)')
+if (-not $briefMatch.Success) {
+    if ($ValidationStage -eq 'ReadyForReview') { $errors.Add('ReadyForReview requires a concise Review Brief before Test Strategy.') }
+    else { $warnings.Add('Legacy Test Plan is missing Review Brief; add linked review navigation before the next human review.') }
+} else {
+    $brief = $briefMatch.Groups['body'].Value
+    $strategyHeading = [regex]::Match($content, '(?m)^##\s+Test Strategy\s*$')
+    if ($strategyHeading.Success -and $briefMatch.Index -gt $strategyHeading.Index) { $errors.Add('Review Brief must precede Test Strategy and detailed test tables.') }
+    foreach ($label in @('Purpose and maturity','Proposed scope and exclusions','Evidence basis and confidence','Artifact quality versus input completeness','Next gate and version boundary')) {
+        if ($brief -notmatch "(?m)^\*\*$([regex]::Escape($label))\*\*:[ \t]*\S") { $errors.Add("Review Brief requires '$label'.") }
+    }
+    $briefStatuses = @{}
+    foreach ($actionId in $ownedActions.Keys) { $briefStatuses[$actionId] = $ownedActions[$actionId][6] }
+    foreach ($conflict in @([regex]::Matches($profileConflictSection.Groups['body'].Value, '(?mi)^\|\s*(?<id>CON-\d{3})\s*\|(?<rest>.*)$'))) {
+        $cells = @($conflict.Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
+        if ($cells.Count -ge 5) { $briefStatuses[$conflict.Groups['id'].Value] = $cells[4] }
+    }
+    foreach ($id in @([regex]::Matches($brief, '\b(?:ACT-\d{3}|AUT-\d{2,}|CON-\d{3})\b') | ForEach-Object { $_.Value } | Select-Object -Unique)) {
+        if (-not $briefStatuses.ContainsKey($id)) { $errors.Add("Review Brief references missing or unowned canonical record '$id'.") }
+    }
+    foreach ($sectionName in @('Significant Conflicts','Priority Human Actions')) {
+        $section = [regex]::Match($brief, "(?ms)^###\s+$([regex]::Escape($sectionName))\s*$\s*(?<body>.*?)(?=^###\s|\z)")
+        if (-not $section.Success) { $errors.Add("Review Brief requires '$sectionName'."); continue }
+        $rows = @([regex]::Matches($section.Groups['body'].Value, '(?m)^\|\s*(?<rest>.*)$') | Where-Object { $_.Value -notmatch '^\|\s*(?:Priority / Why Now|---)' })
+        if ($rows.Count -gt 5) { $errors.Add("Review Brief '$sectionName' must prioritize at most five items; link the full register.") }
+        if ($rows.Count -eq 0 -and $section.Value -notmatch '(?i)None\s+[—:-]\s+\S') { $errors.Add("Review Brief '$sectionName' requires prioritized rows or 'None — reason'.") }
+        foreach ($row in $rows) {
+            $cells = @($row.Groups['rest'].Value.Trim().TrimEnd('|') -split '\|' | ForEach-Object { $_.Trim() })
+            if ($cells.Count -ne 4 -or @($cells | Where-Object { -not $_ -or $_ -match '^\{.*\}$' }).Count -gt 0) { $errors.Add("Review Brief '$sectionName' requires priority, linked canonical reference, current status and next step."); continue }
+            $idPattern = if ($sectionName -eq 'Significant Conflicts') { '\bCON-\d{3}\b' } else { '\b(?:ACT-\d{3}|AUT-\d{2,})\b' }
+            $ids = @([regex]::Matches($cells[1], $idPattern) | ForEach-Object { $_.Value })
+            $registerAnchor = if ($sectionName -eq 'Significant Conflicts') { 'evidence-sources-and-conflicts' } else { 'human-input-and-decision-register' }
+            if ($ids.Count -ne 1 -or $cells[1] -notmatch "\]\([^)]+testing-profile\.md#$registerAnchor\)") { $errors.Add("Review Brief '$sectionName' must link one canonical register record per row."); continue }
+            if ($briefStatuses.ContainsKey($ids[0]) -and $cells[2] -ne $briefStatuses[$ids[0]]) { $errors.Add("Review Brief status for '$($ids[0])' contradicts the canonical register.") }
+        }
+    }
+    foreach ($anchor in @('#scenario-scope-and-automation-effort','#high-level-case-outlines','#test-assets-and-traceability','#estimate-scope-and-boundary-reconciliation','#test-plan-approval-gate')) {
+        if ($brief -notmatch [regex]::Escape("]($anchor)")) { $errors.Add("Review Brief must link supporting detail '$anchor'.") }
+    }
+}
+if ($deferredReadiness.Count -gt 0) { $warnings.Add("$($deferredReadiness.Count) test types have owned unresolved architecture readiness; resolve before Execution.") }
+if ($deferredApprovers.Count -gt 0) { $warnings.Add("$($deferredApprovers.Count) test types have owned pending approver appointments; named humans are required before Execution.") }
+$result = @{
+    testPlanPath = [System.IO.Path]::GetFullPath($TestPlanPath)
+    validationStage = $ValidationStage
+    planStatus = $planStatus
+    valid = ($errors.Count -eq 0)
+    errorCount = $errors.Count
+    errors = @($errors)
+    warnings = @($warnings)
+    inputCompleteness = $inputCompleteness
+    deferredExecutionRequirements = @{ architectureReadiness = @($deferredReadiness); namedApprovers = @($deferredApprovers) }
+}
 Write-ScriptResult -Data $result -Json:$Json
 if ($errors.Count -gt 0) { exit 1 }
 exit 0
diff --git a/.specify/scripts/powershell/validate-testing-strategy.ps1 b/.specify/scripts/powershell/validate-testing-strategy.ps1
index f5783fc..8980780 100644
--- a/.specify/scripts/powershell/validate-testing-strategy.ps1
+++ b/.specify/scripts/powershell/validate-testing-strategy.ps1
@@ -51,6 +51,11 @@ $headingCounts = @{
 if ($headingCounts.level1 -ne $contract.counts.level1Headings) { $errors.Add("Expected $($contract.counts.level1Headings) level-one headings including the generated TOC; found $($headingCounts.level1).") }
 if ($headingCounts.level2 -ne $contract.counts.level2Headings) { $errors.Add("Expected $($contract.counts.level2Headings) level-two headings; found $($headingCounts.level2).") }
 if ($headingCounts.level3 -ne $contract.counts.level3Headings) { $errors.Add("Expected $($contract.counts.level3Headings) level-three headings; found $($headingCounts.level3).") }
+foreach ($requiredSection in @('High Availability Testing','Disaster Recovery Testing')) {
+    if ($markdown -notmatch "(?m)^##\s+$([regex]::Escape($requiredSection))\s*$") {
+        $errors.Add("Testing strategy Markdown is missing source section '$requiredSection'.")
+    }
+}
 
 Add-Type -AssemblyName System.IO.Compression.FileSystem
 $archive = [System.IO.Compression.ZipFile]::OpenRead($DocxPath)
diff --git a/.specify/scripts/powershell/validate-testing-tasks.ps1 b/.specify/scripts/powershell/validate-testing-tasks.ps1
index d14fbb2..7f096f8 100644
--- a/.specify/scripts/powershell/validate-testing-tasks.ps1
+++ b/.specify/scripts/powershell/validate-testing-tasks.ps1
@@ -1,4 +1,4 @@
-#requires -Version 5.1
+﻿#requires -Version 5.1
 # Validates per-test preparation, execution, remediation, evidence, and approval tasks.
 [CmdletBinding()]
 param(
diff --git a/.specify/templates/architecture-template.md b/.specify/templates/architecture-template.md
index 4fb6f98..91d40fb 100644
--- a/.specify/templates/architecture-template.md
+++ b/.specify/templates/architecture-template.md
@@ -711,7 +711,7 @@ Maturity remains `Designed`. This table is copied verbatim into `spec.md` Sectio
 
 | Checklist | Items | Passed | Open | Last Validation | Open IDs / Gate Effect |
 | --- | ---: | ---: | ---: | --- | --- |
-| `checklists/mec-assessment.md` | {n} | {n} | {n} | {YYYY-MM-DD / validator result} | {CHK IDs or None}; unchecked required items keep this gate Not Cleared and G-4 In Progress |
+| `checklists/mec-assessment.md` | {n} | {n} | {n} | {YYYY-MM-DD / validator result} | {CHK IDs or None}; unchecked gate-required items keep this gate Not Cleared; open Post-Gate Items (CHK036, CHK037, CHK042) keep only G-4 In Progress |
 
 ### 7.5 Endpoint and Workload Security Agents
 
@@ -914,13 +914,14 @@ the controlled `.specify/checklists/complexity-calculator.md` baseline. It tests
 Section 8A and G-7 are complete, clear, consistent, measurable, evidence-grounded and reviewable;
 it does not test implementation behavior. Generate and evaluate it through `/speckit.checklist
 complexity calculator quality`. Unchecked items retain their exact gap and evidence owner and keep
-the Architecture Review Gate and G-7 status open.
+the Architecture Review Gate and G-7 status open. The baseline's **Post-Gate Items** test G-7, which
+`/speckit.publish` produces after this gate, so they keep only G-7 open.
 
 | Checklist | Gate Effect | Items | Passed | Open | Validator / Evidence | Disposition |
 | --- | --- | ---: | ---: | ---: | --- | --- |
-| `checklists/complexity-calculator.md` | Required | {count} | {checked count} | {unchecked count} | `validate-checklists.ps1`; {last reviewed date/reviewer} | {Pass / Blocked — open CHK IDs} |
+| `checklists/complexity-calculator.md` | Required | {count} | {checked count} | {unchecked count} | `validate-checklists.ps1`; {last reviewed date/reviewer} | {Pass / Blocked — open gate-required CHK IDs; list open Post-Gate Items separately} |
 
-`Pass` requires every item checked from objective artifact evidence. Do not check an item merely
+`Pass` requires every gate-required item checked from objective artifact evidence. Do not check an item merely
 because its gap is documented; documented Unknowns make the output honest but leave the associated
 quality item open. A Cleared architecture gate or Complete G-7 with an unchecked required item is
 invalid.
@@ -1363,6 +1364,7 @@ can see.
 | **Data source profiles and migration tooling** | {Every DATA-SRC profile is complete enough for exact source-target selection; all ten lifecycle phases cite Matrix/local/CPF evidence; blank/multiple/third-party/no-row cases are handled; Classic DMS is used only for clear-listed MySQL; rejected candidates and cross-layer consequences are recorded} | {Fixed in this draft / Logged as Decision or Risk / None found} |
 | **Cost/SKU validation** | {Any Section 13 SKU/tier that a CPF module or Yes-applicable MEC criterion constrains, not flagged as such in the "SKU/Tier Constrained By" column; any non-production environment priced at a different SKU/tier than production despite no CPF/MEC constraint allowing that difference; any Section 13.4 "No" with no stated reason} | {Fixed in this draft / Logged as Risk / None found} |
 | **Migration testability** | {Whether every testing-profile row maps to a target mechanism, environment, observability/evidence path, identity/data prerequisite and owning architecture section; include R-Type resolution and production-only constraints} | {Fixed in this draft / Logged as Decision or Risk / Ready for planning} |
+| **OAT scenario design** | {Whether all LSEG L2 catalog scenarios are dispositioned against evidenced as-is components and proposed Azure target, with safety, Operations, runbook, and evidence requirements} | {Fixed in this draft / Logged as Decision or Risk / Ready for planning} |
 
 ### 14.1 Migration Testability Matrix
 
@@ -1375,6 +1377,12 @@ The resolved-applicability cell must begin with exactly `Applicable`, `Not Appli
 `Exception Approved`, optionally followed by ` — {basis}`. An Applicable profile row cannot become
 an exception. A conditional profile row resolves to Applicable or Not Applicable here.
 
+Use exactly the canonical test types in the profile; do not add a separate Integration Testing row.
+Map integration scenarios into Change-Based Functional Testing when the Migration Team performs
+refactoring, including refactoring within Re-Host/Re-Platform. Otherwise, map them into mandatory
+UAT owned by the Application Team. Preserve UAT in either branch and avoid counting the same case
+twice.
+
 | Test Type | Requirements / Profile Disposition | Resolved Applicability / R-Type Basis | Owning Architecture Section(s) | Target Mechanism Under Test | Approved Environment / Production Comparability | Observability / Evidence Path | Data / Identity / Access Prerequisites | Readiness | ADR/Risk |
 | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
 | Connectivity | {REQ/NFR + disposition} | {Applicable — basis} | {Sections 2/5/7} | {flows/endpoints/auth/error paths} | {environment/comparability} | {telemetry/report/repository} | {accounts/data/access} | {Ready/Conditional/Blocked} | {N/A or ADR/RSK} |
@@ -1398,6 +1406,113 @@ an exception. A conditional profile row resolves to Applicable or Not Applicable
 > gap and move on. Only genuine open questions that need the app team's, platform team's, or a
 > named human's answer belong as a Decision, Risk, or `UNKNOWN` after this pass.
 
+### 14.2 OAT Scenario Applicability Matrix
+
+**Source**: `docs/testing-strategy/LSEG-L2-OAT-Game-Day-Scenario-Catalog.md`. Invoke
+`oat-scenario-design`. Assess each source ID against current as-is evidence and the proposed Azure
+target separately. Keep every ID, including non-applicable and blocked scenarios. Use one
+disposition: `Recommended`, `Conditionally applicable`, `Not applicable`, or `Blocked`. N/A needs
+evidence; missing inventory, target capability, safe test method, or owner is a gap. Map only
+services and fault mechanisms evidenced in the target design. A recommendation is not evidence of
+execution or approval.
+
+| Catalog ID | Scenario | Applicability | As-is evidence | Proposed Azure target and evidence | Operational objective / testability | Environment, safety, change | Owner, runbook, evidence, ADR/risk |
+| --- | --- | --- | --- | --- | --- | --- | --- |
+| L2-OAT-GD-01 | Availability-zone failover | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-GD-02 | VM interruption during request | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-GD-03 | Container interruption during request | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-GD-04 | Serverless concurrency limit | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-GD-05 | Database zone failure | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-GD-06 | High-concurrency stress and recovery | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-GD-07 | Storage internal errors | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-GD-08 | Messaging region failure | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-GD-09 | Third-party dependency outage | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-GD-10 | Application smoke | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-GD-11 | AKS upgrade and conditional key rotation | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-GD-12 | IaC no-change drift check | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-GD-13 | Production deployment operational checks | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-GD-14 | Critical workflow SLO breach alert | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-GD-15 | Upstream service-level breach alert | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-GD-16 | Server/container resource threshold alert | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-GD-17 | Serverless resource/timeout alert | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-GD-18 | Database backup failure alert | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-GD-19 | Storage capacity threshold alert | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-GD-20 | Log levels and error quality | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-GD-21 | Incident communications | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-GD-22 | Account/service quota threshold alert | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-GD-23 | Database point-in-time/backup restore | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-GD-24 | Object restore | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-CHG-01 | Recreate application IaC stack | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-CHG-02 | Golden-image refresh (self-managed compute) | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-CHG-03 | Database schema deployment | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-CHG-04 | Infrastructure deployment rollback | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-CHG-05 | Blue/green application deployment | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-CHG-06 | Application deployment rollback | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-CHG-07 | Database deployment rollback | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-CHG-08 | Vertical VM scaling | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-CHG-09 | Add disk/extend LVM capacity | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-VAL-01 | DR documentation and RTA/RTO evidence | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-VAL-02 | Encryption at rest/in transit | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-VAL-03 | Infrastructure/production access control | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-VAL-04 | Access approver groups and reviews | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-VAL-05 | Logging compliance | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-VAL-06 | Password rotation/secrets management | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-VAL-07 | Certificate uniqueness and renewal | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-VAL-08 | Third-party vulnerabilities/licensing | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-VAL-09 | One Policy Engine pipeline/report | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-VAL-10 | Terraform module scan/CPF drift | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-VAL-11 | Mandatory resource tagging | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-VAL-12 | Runbook and support contacts | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-VAL-13 | Manual operational activities/RAID | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-VAL-14 | CloudOps onboarding checklist | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-VAL-15 | Datadog monitor hygiene | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-VAL-16 | DML/technical debt and SIIs | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-VAL-17 | Azure account/subscription outage | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+| L2-OAT-VAL-18 | Third-party outage response | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target evidence} | {objective} | {safety/change} | {owner/runbook/evidence/ADR/RSK} |
+
+### 14.3 High-Level Test Scenario Design
+
+Apply `docs/testing-strategy/automation-review-and-scenario-sizing.md` and the profile's Automation
+Availability Review. For each applicable/conditional canonical type, propose a high-level family
+only where application behavior, a component, flow, migration change, or governing test obligation
+supports it. Where business facts or source inventory are missing, retain the gap as an owned
+action instead of inventing a case catalog. Preserve supplied case IDs and source locators when
+available; a proposed family is not an executed case or confirmed asset reuse. Keep family counts
+distinct from verified case counts. Reference Section 14.2 for OAT without duplicate counts.
+
+| Scenario Reference | Test Type | REQ/NFR / Component / Flow Evidence | Family / Outcome / Environment / Data | Automation Status / Review ID / Reuse-Adapt-Build-Manual | Proposed Volume / Derivation / Confidence | Implementation / Execution / Maintenance / LMP Section-RACI |
+| --- | --- | --- | --- | --- | --- | --- |
+| {stable family reference or ACT-### if evidence is insufficient} | {canonical type} | {REQ/NFR and actual component/flow/source locator; or exact evidence gap} | {evidenced behavior and outcome, or question that must be answered before case design} | {profile status and AUT-ID; verified assets versus proposed work} | {evidence-based family/case band and derivation, or Unknown; confidence} | {separate proposed roles; exact strategy section and Appendix 5; action owner/gate when unresolved} |
+
+Unit: preserve existing suites and identify success/boundary/error/mocking families for
+migration-changed impacted units only; do not automatically assign all legacy gaps to Migration.
+Performance: outline owner-selected workload levels, baseline/volumetric inputs, script
+reuse/adaptation/build, telemetry and comparison outcomes; owner approval and baseline validation
+remain explicit. Section 4.1 enablement is conditional on MEC and maintenance capacity and limited
+to one sprint; Application Team coverage growth/maintenance is separate work. Planning estimates
+review, automation development, setup and execution separately; no detailed test scripts here.
+
+### 14.4 Migration Impact-to-Test Crosswalk
+
+Reconcile each evidenced source component, store, interface/flow and critical behavior affected by
+the approved target change. Import the component and flow inventories; do not invent source paths
+or infer business behavior from framework examples. For each row state whether the source asset is
+retained, changed, replaced or retired; how data/state moves when applicable; the affected and
+dependent unchanged behavior; the matching requirement and Section 14.3 family or supplied case;
+and whether coverage is already evidenced, proposed, excluded with rationale, or pending a human
+answer. For retirements, check callers, consumers, data ownership and transition/rollback controls;
+do not create phantom target cases. Every pending row points to an action in
+`requirements/testing-profile.md`. Applicability follows the independent architecture/R-Type and
+governing LMP strategy; do not change either to match a supplied plan.
+
+| Impact ID | Source Component / Store / Interface / Flow and Evidence Locator | Target Disposition (Retain / Change / Replace / Retire) | Data / State Movement Mechanism or Evidence-backed None | Impacted and Dependent Unchanged Behavior | REQ/NFR and Test Type / Section 14.3 Family or Supplied Case | Coverage Disposition (Covered / Proposed / Excluded / Pending) and Evidence | Owner / Action ID / Gate |
+| --- | --- | --- | --- | --- | --- | --- | --- |
+| XWALK-001 | {actual architecture inventory ID, name and source locator} | {Retain / Change / Replace / Retire; approved target reference} | {migration/reconciliation mechanism or evidence that no state moves} | {affected behavior and dependent unchanged components/flows} | {REQ/NFR; canonical type; SCN reference or supplied case ID} | {Covered / Proposed / Excluded / Pending; current evidence locator and gap} | {accountable role; ACT-### or N/A with evidence; needed-by gate} |
+
+Coverage is assessed relative to available evidence, separately from input completeness. An
+evidence-bounded proposal may be ready for human review while rows remain Proposed/Pending; it is
+not execution-ready until required decisions, cases, evidence, and approvals are resolved.
+
 ## 15. Backlog Playbook Coverage Check
 
 An independent check that this document actually covers what the Backlog Playbook expects
@@ -1486,12 +1601,12 @@ supplies facts for another application.
 >    `Proposed`/`proposed`, fill in its `## Human Review` table (`Human Decision`, `Reviewer`,
 >    `Review Date`), and change its `Status` field to `accepted`, `rejected`, or `superseded`.
 >    Open `risks/RSK-####.md` for each row still `Identified`, and move it to `Accepted`,
->    `Mitigated`, or `Escalated` with a named owner. Checking a box below does **not** approve a
->    decision or risk — editing its own file does.
-> 2. **Only after every decision/risk above is resolved**, work through the checklist below against
->    the assembled document itself. When every box is true, fill in **Reviewed by / Date /
->    Outcome** at the very bottom of this section — that line is what marks the whole gate Cleared,
->    the same way `requirements.md`'s Requirements Review Gate is marked Cleared.
+>    `Mitigated`, or `Escalated` with a named owner. Checking a checklist item does **not**
+>    approve a decision or risk — editing its own file does.
+> 2. **Only after every decision/risk above is resolved**, confirm `checklists/architecture.md`
+>    against the assembled document itself. When every item is checked, fill in **Reviewed by /
+>    Date / Outcome** at the very bottom of this section — that line is what marks the whole gate
+>    Cleared, the same way `requirements.md`'s Requirements Review Gate is marked Cleared.
 
 ### Decisions & Risks awaiting your review
 
@@ -1505,84 +1620,14 @@ make the reviewer cross-reference Section 10 themselves:
 
 ### Checklist
 
-- [ ] Every layer skill produced a complete Layer Finding (Research, Evaluation, Design, Validation — none skipped)
-- [ ] Every layer's design traces back to an indexed REQ-###/NFR-### record (or is flagged as
-  outside the requirements record set, not silently added)
-- [ ] Every Section 3/9 citation traces to a real `docs/` catalog entry (no invented ADR/pattern/CPF IDs)
-- [ ] Section 4 was derived after cross-layer reconciliation; every migration-required application,
-  data, configuration, runtime/dependency, test-automation and CI/CD delta has unique
-  `IMP-F###`/`IMP-US###`/`IMP-T###` ancestry, repository scope, executable acceptance evidence,
-  traces, accountable ownership and agent capability, or cited compatibility evidence proves no
-  change is required
-- [ ] Sections 2.1, 2.2 and 2.3 show the target context, containers and Azure deployment/runtime
-  topology; all services, boundaries, ingress hops, identity/data/observability dependencies and
-  external systems are evidence-backed or explicitly non-Confirmed with a linked ADR/risk
-- [ ] Every Section 5.1/5.2 `FLOW-*` row appears on a directional diagram relationship and every
-  user/external relationship maps back to exactly one row with purpose, protocol, port,
-  authentication/authorization, exposure and evidence
-- [ ] Section 7A maps every Requirements Section 2A topic, Section 5 client/interface and Section 6
-  data set to a transition design; no client migration, coexistence, reconciliation, rollback,
-  rehearsal, hypercare or decommission topic is silently deferred to planning
-- [ ] Section 7A defines source-of-truth/write ownership, reconciliation tolerance, go/no-go and
-  rollback authority, maximum rollback timing and point-of-no-return treatment, or links each
-  unresolved item to a blocking ADR/risk
-- [ ] Every `DATA-SRC-###` appears in Sections 6.1, 6.5, 6.6, 6.6.1, 6.7 and 7A.4; Section 6.6
-  has exactly one row for each of the ten lifecycle phases with exact pair, Matrix review date or
-  non-database N/A, local guidance, CPF/provisioning path, hard filters, selection and status
-- [ ] No selected tool is inferred from a blank/grouped Matrix cell; third-party tooling has local
-  approval or human ADR; Classic CPF DMS is used only for its clear-listed MySQL scenario
-- [ ] Section 11 lists every conflict found, with a resolution or an escalation Decision — none silently dropped
-- [ ] Section 8 R-Type recommendation reviewed and its Decision moved out of Proposed
-- [ ] Section 8A contains all eight Complexity Calculator V4.1 inputs; each evidence/calculation
-  comment shows the workbook-defined unit, inclusions/exclusions/grouping, derivation, exact rule
-  mapping and grounded source locators; counts/categories reconcile
-- [ ] Section 8A records every supplied calculator workbook and compares its actual rubric/support
-  sheets with the framework baseline; version drift and source conflicts have a governing version
-  approval or remain `HUMAN REVIEW REQUIRED`.
-- [ ] `checklists/complexity-calculator.md` exists, passes `validate-checklists.ps1`, and every
-  required item is checked before this gate is Cleared; its item/pass/open counts reconcile to
-  Section 8A.Q and G-7
-- [ ] All Section 10 decisions/risks reviewed by a named human
-- [ ] Section 14.1 has exactly one row per testing-profile test type; every row traces requirements,
-  resolves R-Type applicability, identifies an owning design section and test mechanism,
-  environment/comparability, observability/evidence, prerequisites and readiness; every
-  Conditional/Blocked row links an ADR/risk
-- [ ] Section 7 MEC table reviewed by the app team
-- [ ] Sections 3.2, 3.3, 5.2.1, 5.2.2, 5.6, 6.8, 6.9, 7.2.5, 7.2.6 and 7.5–7.8 cover every
-  component, flow, dependency, ingress and data set (or record evidence-backed `None`); critical
-  dependencies with incompatible RTO/RPO, unagreed load, cross-jurisdiction replicas and AI use
-  each link an ADR/risk
-- [ ] Section 1.3 records every non-production/DR environment delta and reconciles to Section 13.2;
-  Section 10.1 consolidates every guardrail/policy exception with an ADR/risk
-- [ ] Sections 12.1.1, 12.3 forecasting, 12.6.4, 13.4A and 13.8.1 are populated or carry explicit
-  evidence owners and ADR/risks
-- [ ] Sections 7.9, 12.7, 12.8, 12.9 and 13.9 disposition every WAF checklist code for their
-  pillar against the actual design; every `Partially aligned` or `Deviation — risk` row links an
-  ADR/risk and every `Deviation — justified` row names its LSEG source or constitutional principle
-- [ ] Section 12.6 maps every requirements-stage DevSecOps/SDLC row from first commit through
-  production deployment, rollback and handoff; applies the checklist and MEC; and maps all GCF
-  gate families to PEP integration, applicability, profile, enforcement, evidence and governed
-  customization/expiry
-- [ ] Section 13 (Cost & Capacity Profile) has a Section 13.2 row for every environment named in
-  indexed Environment Capacity & Scaling Profile records, with every CPF-/MEC-constrained
-  SKU/tier named as such (not silently cost-rightsized below its floor), and every Section 13.4
-  "No" carrying a stated reason
-- [ ] Section 13.1's Region matches Section 5's Region row and the approved region Decision
-- [ ] Section 13.6 prices every Section 7A temporary/coexistence resource and source/target overlap,
-  or explicitly marks missing quantity/duration for human review; transition cost is separate from
-  steady-state run rate
-- [ ] SAD business context/App Family, cross-environment/IP/DNS/bandwidth, full data/privacy,
-  access/session/authorisation, production-test/EUC/backup protection, per-component operability,
-  exact 25%/10% TCO controls, FinOps, licensing, and sustainability fields are populated or carry
-  explicit evidence owners and ADR/risks
-- [ ] Section 14 (Self-Review) completed with no unresolved "Fixed in this draft" gaps left open —
-  every finding is either corrected above or explicitly logged as a Decision/Risk/`UNKNOWN`, and
-  any Microsoft-documentation use was checked for conflicts with LSEG guidance
-- [ ] Section 15.1 (Backlog Playbook Coverage) has one row per Planning & Design User Story in the
-  Playbook CSV, with every Partial/No row reflected in Section 15.2
-- [ ] Section 15.2 (Open Points & Topics) has no row without a linked Decision/Risk
-- [ ] Section 16 contains every canonical SAD content-heading ID exactly once, and every Partial/No
-  row names the missing field, evidence owner and linked ADR/risk
+This gate's acceptance tests are the Spec-Kit checklist `checklists/architecture.md`, instantiated
+from the controlled baseline `.specify/checklists/architecture.md`. `/speckit.architecture`
+evaluates it at the end of every run; run `/speckit.checklist architecture` after later edits. The
+reviewer confirms every item before signing below, and `check-prerequisites.ps1` blocks
+`/speckit.specify` while any item here, or any gate-required item in
+`checklists/complexity-calculator.md` or `checklists/mec-assessment.md`, is unchecked.
+
+**Checklist status**: {n} items, {n} open — {open CHK IDs or None}
 
 **Reviewed by**: {name} | **Date**: {YYYY-MM-DD} | **Outcome**: {Approved to proceed / Changes requested}
 
diff --git a/.specify/templates/plan-template.md b/.specify/templates/plan-template.md
index 07e7934..27c599c 100644
--- a/.specify/templates/plan-template.md
+++ b/.specify/templates/plan-template.md
@@ -78,10 +78,22 @@ raise a new ADR/change if implementation facts require an architecture revision.
 
 `G-test-plan.md` in this feature folder is the single canonical application Test Plan. Do not
 duplicate its per-test matrix here. This plan schedules and depends on that approved deliverable.
+Import each applicable test stream's estimated elapsed duration, 1/2/3-tester capacity scenario,
+verified automation/manual split, dependencies and contingency into the integrated schedule without
+copying the per-test matrix. Preserve the four-calendar-week L2 Production OAT baseline unless
+current evidence supports a change. Keep optional lower-environment pre-OAT separate and schedule
+it only after Migration and Application Teams agree the scenario count and window. Do not commit
+execution-baseline dates while any required Test Plan approval is pending.
 
 | Test Plan | Status | Requirements/Profile Source | Architecture Testability Source | Schedule / Critical-Path Integration | Exceptions / Risks | Approval Evidence |
 | --- | --- | --- | --- | --- | --- | --- |
-| `G-test-plan.md` | {Draft/Ready for Review/Approved} | `requirements/testing-profile.md` + {REQ/NFR IDs} | `architecture.md` Section 14.1 | {Testing/Pre-Cutover/Cutover rows and dependencies} | {ADR/RSK or None} | {named approver/date or Pending} |
+| `G-test-plan.md` | {Draft/Ready for Review/Approved} | `requirements/testing-profile.md` including automation review + {REQ/NFR IDs} | `architecture.md` Sections 14.1–14.3 | {scenario volume, automation build/adaptation effort, specialist capacity, estimated durations, overlaps, hard gates, critical path and external waits} | {ADR/RSK or None} | {Migration + Migration Testing + Application + L2 names/dates/evidence or Pending} |
+
+Carry Application Team automation-review actions and Migration/Application scope-and-effort
+deep-dives into the schedule/backlog. Consume Test Plan person-day effort by review, automation,
+setup, execution, retest and report/handover; distinguish it from tester elapsed time and ongoing
+maintenance. Assign activities from the exact LMP strategy section/Appendix 5, not a blanket
+Migration ownership assumption.
 
 ## Migration Delivery Schedule (Backlog Playbook v1)
 
@@ -196,18 +208,12 @@ Same rule: only new, implementation-level risks. Each MUST have a corresponding
 
 **Do not proceed to task generation until this gate is cleared.**
 
-- [ ] All Decisions Required (above) reviewed and moved out of Proposed by a named human
-- [ ] All Risks Identified (above) reviewed and moved out of Identified by a named human
-- [ ] Constitution Check re-run and passing
-- [ ] Every selected Playbook User Story and child Task appears exactly once in the work-item
-    schedule with exact ID/title, parent linkage, source tags, OwningOrg and GHCP disposition
-- [ ] Every applicable Discovery & Assessment and Planning & Design User Story and child Task has
-    an evidence-backed disposition; completed rows have no scheduled work, and partial rows
-    schedule only their explicit residual
-- [ ] Every applicable Architecture Section 7A `MIG-###` control has scheduled work, an owner,
-  evidence output and dependency/gate; no transition strategy was re-decided in planning
-- [ ] Canonical `G-test-plan.md` passes validation, every applicable test is scheduled, and every
-    exception/approval is resolved by a named human before task generation
+This gate's acceptance tests are the Spec-Kit checklist `checklists/plan.md`, instantiated from the
+controlled baseline `.specify/checklists/plan.md`. `/speckit.plan` evaluates it at the end of every
+run; run `/speckit.checklist plan` after later edits. The reviewer confirms every item before
+signing below, and `check-prerequisites.ps1` blocks `/speckit.tasks` while any item is unchecked.
+
+**Checklist status**: {n} items, {n} open — {open CHK IDs or None}
 
 **Reviewed by**: {name} | **Date**: {YYYY-MM-DD} | **Outcome**: {Approved to proceed / Blocked — see notes}
 
diff --git a/.specify/templates/requirements-template.md b/.specify/templates/requirements-template.md
index cfd92cd..f4358cc 100644
--- a/.specify/templates/requirements-template.md
+++ b/.specify/templates/requirements-template.md
@@ -475,58 +475,13 @@ cell.
 
 **Do not proceed to `/speckit.architecture` until this gate is cleared.**
 
-- [ ] Every FR/NFR cites a real source (discovery report section, LSEG standard, or explicit `UNKNOWN`)
-- [ ] Every "Must" NFR has a measurable Metric/Target
-- [ ] Every in-scope application/IaC repository has an evidenced GCF current-state row; every
-  `Not using GCF` or `Unknown` row links to a target GCF adoption NFR
-- [ ] Every proposed GCF custom threshold/exemption links to application-owner/GCF approval,
-  compensating controls, residual risk, owner, and expiry evidence or an open ADR/risk
-- [ ] Every applicable DevSecOps checklist domain has an evidenced disposition and every mandatory
-  `No`/`Unknown` links to a target REQ/NFR or governed N/A
-- [ ] At least one Reliability NFR (RTO/RPO/HA) and one Operational Excellence NFR (monitoring/
-  alerting) are present — inherited-default is acceptable only if named and sourced
-- [ ] Section 2 Security, Reliability, and Operational Excellence NFRs reviewed against
-  `docs/mec-reference.md`, `docs/gcf-reference.md`, `docs/DevSecOps-Checklist/INDEX.md`,
-  `docs/resliency-guidance/resliency-guidance.md`, and applicable linked topic files
-- [ ] Section 5 (Traceability Matrix) initialized with every REQ/NFR ID from Sections 1-2
-- [ ] Section 6 (Self-Review) completed with no unresolved "Fixed in this draft" gaps left open —
-  every finding is either corrected above or explicitly logged as a Decision/Risk/`UNKNOWN`
-- [ ] Section 7.1 (Backlog Playbook Coverage) has one row per Discovery & Assessment User Story
-  in the Playbook CSV, with every Partial/No row reflected in Section 7.2
-- [ ] Section 7.2 (Open Points & Topics) has no row without a linked Decision/Risk
-- [ ] Section 8.1 (SAD Baseline Coverage) has one row per canonical SAD content-heading block,
-  covering every child question/guidance/table field,
-  and Section 8.2 has one row per other `deliverables-template/` file, with every Partial/No row
-  reflected in Section 8.3
-- [ ] Section 8.3 (Open Points & Topics) has no row without a linked Decision/Risk, and no action
-  left vague/unassignable
-- [ ] Section 2's Environment Capacity & Scaling Profile has one row per environment this
-  migration will build, each with supplied usage evidence, a derived Baseline Load/Concurrency
-  Target, derivation/confidence, and Reliability Target (or an explicit `UNKNOWN`) — Production's
-  target is expected steady-state performance; every lower environment, including DEV and PPE/PPR,
-  has the minimum viable target for steady/normal traffic. Each lower environment also has an
-  explicit scaling disposition for applicable performance/load/stress, HA/failover/DR/resilience,
-  and integration-test events; required events include target, duration/frequency, capacity delta,
-  and return-to-baseline condition.
-- [ ] Section 2's Complexity Calculator Requirements Evidence covers all eight V4.1 factors;
-  requirement-owned facts are evidenced or have an owner/ADR/risk, target deployable-component
-  count is explicitly deferred to architecture, and no target-design rating is guessed
-- [ ] Section 2A has one disposition for every migration-transition topic; every Applicable row
-  links REQ/NFR records, every Not Applicable row cites evidence, and every blocking Unknown names
-  an evidence owner and linked ADR/risk
-- [ ] Section 2A.1 has one unique `DATA-SRC-###` profile per in-scope source, with exact
-  engine/version/topology, structure/features, workload/change rate, dependencies, operations/
-  security, downtime/RPO/reconciliation/rollback, network route and tested throughput evidenced or
-  governed as Unknown
-- [ ] Section 3's R-Type Confirmation Matrix covers every material component and cross-cutting
-  concern; every potentially forcing Unknown names its owner, requested evidence, possible R-Type
-  transition, and linked ADR/risk; no Unknown is treated as confirmation of Rehost
-- [ ] `requirements/testing-profile.md` has one validated disposition for every canonical test
-  type; Applicable/Conditionally Applicable rows link REQ/NFR records; unit testing preserves
-  existing suites and scopes Migration-Team additions to migration-changed impacted code; data
-  testing follows actual data movement; DR Production acceptance and separate security/
-  penetration testing are explicit; UAT is Applicable with no exception
-- [ ] All Section 4 decisions/risks reviewed by a named human
+This gate's acceptance tests are the Spec-Kit checklist `checklists/requirements.md`, instantiated
+from the controlled baseline `.specify/checklists/requirements.md`. `/speckit.requirements`
+evaluates it at the end of every run; run `/speckit.checklist requirements` after later edits. The
+reviewer confirms every item before signing below, and `check-prerequisites.ps1` blocks
+`/speckit.architecture` while any item is unchecked.
+
+**Checklist status**: {n} items, {n} open — {open CHK IDs or None}
 
 **Reviewed by**: {name} | **Date**: {YYYY-MM-DD} | **Outcome**: {Approved to proceed / Changes requested}
 
diff --git a/.specify/templates/spec-template.md b/.specify/templates/spec-template.md
index c66ce35..a2670ef 100644
--- a/.specify/templates/spec-template.md
+++ b/.specify/templates/spec-template.md
@@ -106,7 +106,59 @@ when a completed workbook was supplied; `Not supplied` is valid and never blocks
 | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
 | MEC-v3_3-## | {title} | Applicable / Not Applicable / Unknown | Compliant / Not Applicable / Non-Compliant / Partially-Compliant | {Proposed pending three-role review / Approved with names/date} | {source + reasoning + confidence} | {finding or Not supplied} | {target design} | {Designed / Implemented / Evidence Verified / Exception Proposed / Blocked} | {required evidence + actual locator/gap} | {action/role/date} | {ADR/pattern or N/A} | {REQ/NFR/ADR/RSK/IMP} |
 
-## 6. Out of Scope / Deferred Modernization Ideas
+## 6. Testing Evidence Handoff
+
+This section carries the architecture and requirements evidence into planning; it is not an
+application Test Plan or an execution claim. Use `docs/testing-strategy/INDEX.md`,
+`architecture.md` Sections 14.1–14.4, and `requirements/testing-profile.md` when available.
+The testing profile is an optional input to this first SPEC pass; the application `G-test-plan.md`
+is produced during Planning & Design and is not a prerequisite. Keep unresolved evidence as a
+named action/readiness gap. Do not write detailed scripts, duplicate the profile's human-input
+register, or create a competing test case/coverage ledger.
+
+Keep exactly one row for each canonical test type below, including conditional and evidence-backed
+Not Applicable types. Do not add standalone Integration Testing: integration scenarios belong to
+Change-based functional when the Migration Team performs refactoring, otherwise to mandatory UAT.
+Full functional is conditional on Re-architect; use Not Applicable only when the approved R-Type
+and evidence establish that condition does not apply. Data migration verification is Not Applicable
+only when evidence establishes no in-scope data/state movement. UAT remains applicable for every
+R-Type. Preserve those conditions rather than treating missing inputs as Not Applicable.
+
+In the evidence columns, preserve exact IDs and locators: REQ/NFR IDs, architecture `XWALK-###`
+and `SCN-##` references, `IMP-F###` / `IMP-US###` / `IMP-T###` IDs, profile `SRC-###`,
+`AST-###`, supplied case IDs and `ACT-###` / `AUT-##` actions. For each implementation ID, retain
+its repository/project, path/module, assessment read-access and implementation write/branch-access
+readiness from Section 1 or the architecture evidence; do not infer missing values. A case is
+identified as `Supplied` only with its source asset/locator; a `Proposed` family is not an
+execution-ready case. Link applicable, R-Type-filtered Section 3 User Story IDs without removing
+or marking any baseline story complete.
+
+| Test Type | Applicability / Condition and Evidence | REQ/NFR / IMP IDs and Repository Readiness | Architecture Crosswalk / Family References | Supplied or Proposed Case / Asset References | Shared Profile Action / Source Evidence | Selected Section 3 User Story Handoff | Preparation / Execution / Retest Handoff | Evidence, Approval Gate and Accountable Roles |
+| --- | --- | --- | --- | --- | --- | --- | --- | --- |
+| Connectivity | {Applicable; user/system/component positive and negative paths; evidence} | {exact IDs; repository/project, path and separate read/write access status, or N/A with evidence} | {XWALK-### / SCN-## or pending architecture evidence} | {Supplied case ID + AST-###/locator; Proposed family; or pending} | {ACT-### / AUT-## and SRC-###, or pending; no duplicate action} | {exact selected Section 3 User Story ID(s), or unresolved mapping} | {preparation; execution; retest work handed to /plan; no dates or completion claim} | {result/evidence locator; approval gate; role(s), or pending} |
+| Unit | {Existing automated suites always continue; new Migration-Team unit scope is conditional and limited to migration-changed impacted code} | {exact IDs and repository readiness, or pending} | {XWALK-### / SCN-## or pending} | {Supplied case/AST reference or Proposed family; or pending} | {ACT-### / AUT-##; SRC-###; or pending} | {exact selected story ID(s), or unresolved mapping} | {preparation; execution; retest handoff} | {CI/build evidence; approval gate and roles} |
+| Data migration verification | {Conditional; Applicable if data/state moves; Not Applicable only with evidence of none} | {exact IDs and repository readiness, or pending} | {XWALK-### / SCN-## or evidence-backed N/A} | {Supplied case/AST reference or Proposed family; or pending} | {ACT-### / AUT-##; SRC-###; or pending} | {exact selected story ID(s), or unresolved mapping} | {preparation; execution; reconciliation/retest handoff} | {reconciliation evidence; approval gate and roles} |
+| Migration tool | {Applicable; tool fitness and source-environment validation} | {exact IDs and repository readiness, or pending} | {XWALK-### / SCN-## or pending} | {Supplied case/AST reference or Proposed family; or pending} | {ACT-### / AUT-##; SRC-###; or pending} | {exact selected story ID(s), or unresolved mapping} | {preparation; execution; retest handoff} | {tool validation evidence; approval gate and roles} |
+| Application installation | {Applicable; deployment/configuration and post-deployment behavior} | {exact IDs and repository readiness, or pending} | {XWALK-### / SCN-## or pending} | {Supplied case/AST reference or Proposed family; or pending} | {ACT-### / AUT-##; SRC-###; or pending} | {exact selected story ID(s), or unresolved mapping} | {preparation; execution; retest handoff} | {deployment evidence; approval gate and roles} |
+| Smoke/regression | {Applicable; critical/common behavior and regression depth from evidence} | {exact IDs and repository readiness, or pending} | {XWALK-### / SCN-## or pending} | {Supplied case/AST reference or Proposed family; or pending} | {ACT-### / AUT-##; SRC-###; or pending} | {exact selected story ID(s), or unresolved mapping} | {preparation; execution; retest handoff} | {results evidence; approval gate and roles} |
+| Change-based functional | {Conditional: Re-Factor or Migration-Team refactoring; otherwise integration scenarios stay in UAT} | {exact IDs and repository readiness, or evidence-backed N/A} | {XWALK-### / SCN-## or evidence-backed N/A} | {Supplied case/AST reference or Proposed family; avoid duplicate UAT counts} | {ACT-### / AUT-##; SRC-###; or pending} | {exact selected story ID(s), or unresolved mapping} | {preparation; execution; retest handoff, or N/A rationale} | {results evidence; approval gate and roles} |
+| Full functional | {Conditional on Re-architect; otherwise evidence-backed Not Applicable} | {exact IDs and repository readiness, or evidence-backed N/A} | {XWALK-### / SCN-## or evidence-backed N/A} | {Supplied case/AST reference or Proposed family; or evidence-backed N/A} | {ACT-### / AUT-##; SRC-###; or pending} | {exact selected story ID(s), or evidence-backed N/A} | {preparation; execution; retest handoff, or N/A rationale} | {results evidence; approval gate and roles} |
+| Performance and baseline | {Applicable; equal-volumetric comparison and approved measurable targets} | {exact IDs and repository readiness, or pending} | {XWALK-### / SCN-## or pending} | {Supplied case/AST reference or Proposed family; or pending} | {ACT-### / AUT-##; SRC-###; or pending} | {exact selected story ID(s), or unresolved mapping} | {baseline/script preparation; execution; retest handoff} | {baseline/results evidence; approval gate and roles} |
+| High availability | {Applicable; approved HA design and failure scenarios} | {exact IDs and repository readiness, or pending} | {XWALK-### / SCN-## or pending} | {Supplied case/AST reference or Proposed family; or pending} | {ACT-### / AUT-##; SRC-###; or pending} | {exact selected story ID(s), or unresolved mapping} | {preparation; execution; recovery/retest handoff} | {results evidence; approval gate and roles} |
+| Disaster recovery | {Applicable; Production acceptance remains distinct from lower-environment rehearsal} | {exact IDs and repository readiness, or pending} | {XWALK-### / SCN-## or pending} | {Supplied case/AST reference or Proposed family; or pending} | {ACT-### / AUT-##; SRC-###; or pending} | {exact selected story ID(s), or unresolved mapping} | {runbook preparation; Production execution; recovery/retest handoff} | {RTO/RPO and results evidence; approval gate and L2 roles} |
+| Security testing | {Applicable; control/scanning/review scope from requirements} | {exact IDs and repository readiness, or pending} | {XWALK-### / SCN-## or pending} | {Supplied case/AST reference or Proposed family; or pending} | {ACT-### / AUT-##; SRC-###; or pending} | {exact selected story ID(s), or unresolved mapping} | {preparation; execution; remediation/retest handoff} | {findings evidence; approval gate and security roles} |
+| Security penetration testing | {Applicable; any exception requires its governed decision and evidence} | {exact IDs and repository readiness, or pending} | {XWALK-### / SCN-## or pending} | {Supplied case/AST reference or Proposed family; or pending} | {ACT-### / AUT-##; SRC-###; or pending} | {exact selected story ID(s), or unresolved mapping} | {authorization/preparation; execution; remediation/retest handoff} | {production evidence; approval gate and LSEG Security role} |
+| Operational acceptance testing | {Applicable; assess L2 OAT catalog IDs against as-is and target evidence} | {exact IDs and repository readiness, or pending} | {XWALK-### / SCN-## and Section 14.2 catalog IDs, or pending} | {Supplied case/AST reference or Proposed family; do not duplicate OAT cases} | {ACT-### / AUT-##; SRC-###; or pending} | {exact selected story ID(s), or unresolved mapping} | {runbook/change preparation; Production execution; retest handoff} | {runbook/results/change evidence; approval gate and Application Operations role} |
+| User acceptance testing | {Applicable for every R-Type; no exemption; integration scenarios here when no Migration-Team refactoring} | {exact IDs and repository readiness, or pending} | {XWALK-### / SCN-## or pending} | {Supplied case/AST reference or Proposed family; avoid duplicate functional counts} | {ACT-### / AUT-##; SRC-###; or pending} | {exact selected story ID(s), or unresolved mapping} | {business-user preparation; execution; defect/retest handoff} | {acceptance evidence; approval gate and LSEG Application Team role} |
+
+The shared profile's Human Input and Decision Register is authoritative for each open question.
+Carry its exact action ID and preserve the exact question, respondent/contact, needed-by gate and
+blocking impact there; do not copy action rows into this spec. A pending profile is not a missing
+prerequisite for the first SPEC run: record the unavailability and owned follow-up, keep the SPEC
+review gate pending, and complete detailed case outlines, Test Plan estimates, schedules and
+execution/approval tasks in their later planning stages.
+
+## 7. Out of Scope / Deferred Modernization Ideas
 
 Anything that surfaced during analysis that would improve the application but is **not** required
 to migrate it goes here, not into scope. This section exists so good ideas aren't lost — and
@@ -114,7 +166,7 @@ aren't smuggled into the migration either.
 
 - {Idea} — {why it's deferred, e.g., "not required for migration; revisit post-migration"}
 
-## 7. Open Decisions & Risks
+## 8. Open Decisions & Risks
 
 Do not resolve these here — log them via `.specify/templates/decision-log-template.md` and
 `.specify/templates/risk-register-template.md` and link them below. Per Constitution Principle
@@ -125,14 +177,14 @@ III, none of these are final until a named human reviews them.
 | Decision | DEC-001 | {summary} | Proposed |
 | Risk | RSK-001 | {summary} | Identified |
 
-## 8. Review Checkpoint
+## 9. Review Checkpoint
 
-- [ ] `architecture.md` exists and its Architecture Review Gate is Cleared (this spec's Section 2/5
-  are copied from it, not re-derived)
-- [ ] As-is summary confirmed against source evidence (no unresolved `UNKNOWN` blocking scope)
-- [ ] Section 3 Standard Backlog table matches a correct CSV filter for the approved R-Type
-- [ ] Section 4 Backlog Delta reviewed by the migration team (or confirmed empty)
-- [ ] MEC/discovery applicability table matches `architecture.md` Section 7
-- [ ] All Section 7 decisions/risks reviewed by a named human before `/plan` proceeds
+This checkpoint's acceptance tests are the Spec-Kit checklist `checklists/spec.md`, instantiated
+from the controlled baseline `.specify/checklists/spec.md`. `/speckit.specify` evaluates it at the
+end of every run; `/speckit.clarify` and `/speckit.checklist spec` re-evaluate it after later edits.
+The reviewer confirms every item before signing below, and `check-prerequisites.ps1` blocks
+`/speckit.plan` and `/speckit.tasks` while any item is unchecked or this checkpoint is not signed.
+
+**Checklist status**: {n} items, {n} open — {open CHK IDs or None}
 
 **Reviewed by**: {name} | **Date**: {YYYY-MM-DD} | **Outcome**: {Approved / Changes requested}
diff --git a/.specify/templates/testing-profile-template.md b/.specify/templates/testing-profile-template.md
index 57595b2..d22687d 100644
--- a/.specify/templates/testing-profile-template.md
+++ b/.specify/templates/testing-profile-template.md
@@ -16,21 +16,88 @@
 | Migration tool | Required | Unknown | All migrations | {REQ/NFR or None yet} | {tool fitness and source-environment validation} | {source/test environment} | {source/gap} | {role/team} | {role/team} | {ADR/RSK} |
 | Application installation | Required | Unknown | All migrations | {REQ/NFR or None yet} | {deployment/configuration and post-deployment verification} | {target non-production environment} | {source/gap} | {role/team} | {role/team} | {ADR/RSK} |
 | Smoke/regression | Required | Unknown | All migrations; depth is application- and change-risk-specific | {REQ/NFR or None yet} | {critical/common behavior and regression pass threshold} | PPE or approved equivalent | {source/gap} | {role/team} | {role/team} | {ADR/RSK} |
-| Change-based functional | Conditional | Unknown | Refactor, or any lower R-Type with migration code changes that affect dependent behavior | {REQ/NFR or None yet} | {changed and dependent unchanged behavior passes} | PPE or approved equivalent | {source/gap} | {role/team} | {role/team} | {ADR/RSK} |
+| Change-based functional | Conditional | Unknown | Re-Factor, or Re-Host/Re-Platform when the Migration Team performs refactoring that affects dependent behavior; include interaction tests for changed/refactored and dependent unchanged components | {REQ/NFR or None yet} | {changed and dependent unchanged behavior, including integration scenarios, passes} | PPE or approved equivalent | {source/gap; when no Migration-Team refactoring occurs, integration scenarios remain in mandatory App-Team UAT} | {Migration Team for its refactoring; otherwise integration scenarios are owned by LSEG Application Team in UAT} | {role/team} | {ADR/RSK} |
 | Full functional | Conditional | Unknown | Rearchitect | {REQ/NFR or None yet} | {user-story and end-to-end behavior passes} | {approved integrated environment} | {source/gap} | {role/team} | {role/team} | {ADR/RSK} |
 | Performance and baseline | Required | Unknown | All migrations; level may fall back to latency measurement when governed baseline evidence is unavailable | {REQ/NFR or None yet} | {equal-volumetric comparison, NFRs and tolerable variance} | Production-representative PPE | {source/gap} | {role/team} | {role/team} | {ADR/RSK} |
-| High availability | Required | Unknown | All migrations; scenarios follow approved HA design | {REQ/NFR or None yet} | {failover/redundancy targets without excess loss or degradation} | Production-representative PPE | {source/gap} | {role/team} | {role/team} | {ADR/RSK} |
-| Disaster recovery | Required | Unknown | All migrations; production pre-customer-cutover execution is canonical, with lower-environment rehearsals allowed as additional preparation only | {REQ/NFR or None yet} | {RTA/RPA meet RTO/RPO and normalization succeeds} | Production for acceptance; lower environments for rehearsal only | {source/gap} | {role/team} | {role/team} | {ADR/RSK} |
+| High availability | Required | Unknown | All migrations; follow strategy Section 7.2 and approved HA design; Application Owner assesses R-Type, failover mechanisms, redundancy, load balancing and resiliency | {REQ/NFR or None yet} | {approved uptime/SLA, RTO/RPO, redundancy/failover, scalability, resource-utilization, data-loss and degradation goals} | Production-representative PPE; isolated execution window | {Section 7.2 evidence: signed HA plan, cases/pass-fail/background load, PPE/SII, tooling, monitoring, data, entry/exit/results} | {role/team} | {role/team} | {ADR/RSK} |
+| Disaster recovery | Required | Unknown | All migrations; follow strategy Section 7.3; LSEG Application L2 executes Production acceptance before customer cutover; lower-environment runs are rehearsal only | {REQ/NFR or None yet} | {RTA/RPA meet approved RTO/RPO; integrity, accuracy, critical functionality, failback and normalization pass} | Production for acceptance; lower environments for rehearsal only | {Section 7.3 evidence: runbook/handover, scenarios, entry readiness, backup/data/tools, results report, defects and sign-off} | {LSEG Application L2 / Migration Team support} | {role/team} | {ADR/RSK} |
 | Security testing | Required | Unknown | All migrations; control/scanning/review scope follows applicable security requirements | {REQ/NFR or None yet} | {applicable controls pass; findings meet approved threshold} | PPE except explicitly approved production checks | {source/gap} | {role/team} | {role/team} | {ADR/RSK} |
 | Security penetration testing | Required | Unknown | All migrations unless a human-approved Test Exception establishes non-applicability | {REQ/NFR or None yet} | {Critical/High findings remediated or formally accepted} | Production | {source/gap} | LSEG Security Team | {role/team} | {ADR/RSK} |
-| Operational acceptance testing | Required | Unknown | All migrations | {REQ/NFR or None yet} | {operations acceptance criteria pass} | Production | {source/gap} | LSEG operations role | {role/team} | {ADR/RSK} |
-| User acceptance testing | Required | Unknown | All migrations; no exemption | {REQ/NFR or None yet} | {business scenarios, defect threshold and sign-off} | PPE or approved business-acceptance environment | {source/gap} | LSEG Application Team | {role/team} | N/A |
+| Operational acceptance testing | Required | Unknown | All migrations; use the LSEG L2 OAT Game Day catalog as a recommended baseline and assess scenarios against evidenced as-is services and proposed target architecture; LMP strategy execution is by Application Operations in Production during Cutover | {REQ/NFR or None yet} | {applicable, evidence-based OAT scenario outcomes, operational health/alert/runbook/recovery checks, and named sign-off} | Production during Cutover per strategy; production-like/DR only where scenario policy and approvals allow | {L2-OAT catalog IDs, as-is/target applicability evidence, safety/change approval, operations ownership, runbook and evidence path} | LSEG Application Operations | {role/team} | {ADR/RSK} |
+| User acceptance testing | Required | Unknown | All migrations; no exemption. Includes integration scenarios when the Migration Team has not performed refactoring; Application Team owns and executes those business-service integration cases. UAT remains mandatory even when refactoring integration is covered by Change-Based Functional Testing. | {REQ/NFR or None yet} | {business scenarios, applicable integration scenarios, defect threshold and sign-off; avoid duplicate case counts} | PPE or approved business-acceptance environment | {source/gap} | LSEG Application Team | {role/team} | N/A |
 
 Allowed dispositions are `Applicable`, `Conditionally Applicable`, `Not Applicable`,
 `Exception Proposed`, and `Unknown`. `Not Applicable` is valid only for a conditional baseline
 whose condition is proven false. A required baseline can be omitted only as `Exception Proposed`
 with a Proposed ADR and linked risk; UAT can never use either disposition.
 
+## Evidence Sources and Conflicts
+
+Register supplied plans, catalogs, workbooks, case repositories, run reports, source-code
+inventories, and links as evidence. A locator or file presence establishes availability only; it
+does not prove applicability, freshness, coverage, or reuse. Distinguish sourced facts, proposed
+judgments, unanswered human inputs, and approved decisions. Record competing claims separately
+and use the governing authority/precedence rule rather than preferring the newest or most detailed
+uploaded plan automatically.
+
+| Source ID | Artifact / Version / Date | Exact Locator | Claim / Scope | Evidence Class | Authority / Governing Rule | Access / Applicability / Freshness | Conflict / Action ID |
+| --- | --- | --- | --- | --- | --- | --- | --- |
+| SRC-001 | {artifact/version/date or Unknown} | {page/section/path/row/case IDs} | {specific claim and affected scope} | {Sourced fact / Proposed judgment / Human input / Approved decision} | {governing source and precedence, or action needed} | {accessible/unverified; scope and freshness} | {None or ACT-###} |
+
+| Conflict ID | Competing Claims and Source IDs / Locators | Affected Scope | Governing Rule (not assumed source precedence) | Decision Owner / Action ID | Status | Downstream Impact |
+| --- | --- | --- | --- | --- | --- | --- |
+| CON-001 | {claim A SRC-### locator; claim B SRC-### locator} | {test type, flow, asset or estimate} | {approved governance/architecture source or unresolved} | {role and ACT-###} | {Open / Resolved with evidence} | {scope, test, schedule or decision affected} |
+
+## Test Asset Inventory
+
+Keep asset availability separate from its reuse health. `Reported/linked` and
+`Available-unverified` are not verified automation. Record actual identifiers and versions when
+supplied; framework presence alone is not a run result. Use the shared Human Input and Decision
+Register for verification follow-up rather than duplicating actions here.
+
+| Asset ID | Asset Type / Supplied Case IDs | Version / Locator / Owner | Reported Availability | Reuse Health | Coverage / Related Families | Latest Run / Result Evidence | Applicability / Compatibility | Validation Action ID |
+| --- | --- | --- | --- | --- | --- | --- | --- | --- |
+| AST-001 | {plan, catalog, repo, case IDs, scripts, results, baseline, data or environment} | {version/location/owner or Unknown} | {Reported-linked / Available-unverified / Verified-available / Unavailable / Unknown} | {Reuse / Adapt / Build / Manual / Excluded / Undecided} | {verified coverage and gaps; do not infer counts} | {dated run/report locator or Not run} | {applicability and target fit evidence or Unknown} | {ACT-### or N/A with reason} |
+
+## Human Input and Decision Register
+
+Use stable local `ACT-###` references; this is not a new requirement namespace. Reuse `AUT-###`
+as the action reference for an existing automation follow-up rather than creating a duplicate
+action. Questions do not become facts until an answer and its evidence are recorded and validated.
+Open actions may remain in a Draft or reviewable proposal when an accountable owner, expected
+evidence, needed-by gate/date, and impact are explicit.
+
+| Action ID | Exact Question / Decision / Conflict to Resolve | Why Needed / Evidence Expected and Location | Contact / Accountable Coordinator | Needed By / Gate | Linked REQ/NFR / ADR / Risk / Flow / Asset | Blocking Impact | Status | Answer / Evidence / Validation |
+| --- | --- | --- | --- | --- | --- | --- | --- | --- |
+| ACT-001 | {specific question; use AUT-## for its existing follow-up} | {reason and expected evidence/location} | {contact role/person and coordinating owner} | {date or named gate; state if date is unknown} | {existing IDs, or None} | {decision/test/schedule affected} | {Requested / Answered-unvalidated / Validated / Closed} | {actual answer/evidence locator or Pending} |
+
+## Automation Availability Review
+
+Apply `docs/testing-strategy/automation-review-and-scenario-sizing.md`. One entry per canonical
+test type; `Unknown` means unverified, not absent. `None`/`Partial` require a dated Application
+Team answer/evidence. Unknown/Partial/None require an Application Team follow-up action, contact,
+coordinating owner, needed-by gate/date and REQ/NFR plus ADR/risk trace. Ask about repositories,
+covered/uncovered scenarios, verified counts, run history, pipeline, data/baselines and maintenance
+capacity. Do not claim Verified from framework names. N/A requires applicability evidence.
+
+| Review ID | Test Type | Automation Status | Evidence / Application Team Response | Verified Coverage / Uncovered Scope | Application Team Review Action ID / Contact / Owner / Needed By / Status | Requirement / ADR / Risk |
+| --- | --- | --- | --- | --- | --- | --- |
+| AUT-01 | Connectivity | Unknown | {Pending answer; evidence location/date} | {verified count and gaps} | {AUT-01 action/contact/coordinator/gate/status} | {REQ/NFR + ADR/RSK} |
+| AUT-02 | Unit | Unknown | {Pending answer; evidence location/date} | {existing suites and migration-changed units} | {AUT-02 action/contact/coordinator/gate/status} | {REQ/NFR + ADR/RSK} |
+| AUT-03 | Data migration verification | Unknown | {Pending answer; evidence location/date} | {verified count and gaps} | {AUT-03 action/contact/coordinator/gate/status} | {REQ/NFR + ADR/RSK} |
+| AUT-04 | Migration tool | Unknown | {Pending answer; evidence location/date} | {verified count and gaps} | {AUT-04 action/contact/coordinator/gate/status} | {REQ/NFR + ADR/RSK} |
+| AUT-05 | Application installation | Unknown | {Pending answer; evidence location/date} | {verified count and gaps} | {AUT-05 action/contact/coordinator/gate/status} | {REQ/NFR + ADR/RSK} |
+| AUT-06 | Smoke/regression | Unknown | {Pending answer; evidence location/date} | {verified count and gaps} | {AUT-06 action/contact/coordinator/gate/status} | {REQ/NFR + ADR/RSK} |
+| AUT-07 | Change-based functional | Unknown | {Pending answer; evidence location/date} | {verified count and gaps} | {AUT-07 action/contact/coordinator/gate/status} | {REQ/NFR + ADR/RSK} |
+| AUT-08 | Full functional | Unknown | {Pending answer; evidence location/date} | {verified count and gaps} | {AUT-08 action/contact/coordinator/gate/status} | {REQ/NFR + ADR/RSK} |
+| AUT-09 | Performance and baseline | Unknown | {Pending answer; baseline/script evidence/date} | {workloads, baseline validity, reusable/uncovered scripts} | {AUT-09 action/contact/coordinator/gate/status} | {REQ/NFR + ADR/RSK} |
+| AUT-10 | High availability | Unknown | {Pending answer; evidence location/date} | {verified count and gaps} | {AUT-10 action/contact/coordinator/gate/status} | {REQ/NFR + ADR/RSK} |
+| AUT-11 | Disaster recovery | Unknown | {Pending answer; evidence location/date} | {verified count and gaps} | {AUT-11 action/contact/coordinator/gate/status} | {REQ/NFR + ADR/RSK} |
+| AUT-12 | Security testing | Unknown | {Pending answer; evidence location/date} | {verified count and gaps} | {AUT-12 action/contact/coordinator/gate/status} | {REQ/NFR + ADR/RSK} |
+| AUT-13 | Security penetration testing | Unknown | {Pending answer; evidence location/date} | {verified count and gaps} | {AUT-13 action/contact/coordinator/gate/status} | {REQ/NFR + ADR/RSK} |
+| AUT-14 | Operational acceptance testing | Unknown | {Pending answer; evidence location/date} | {verified catalog coverage and gaps} | {AUT-14 action/contact/coordinator/gate/status} | {REQ/NFR + ADR/RSK} |
+| AUT-15 | User acceptance testing | Unknown | {Pending answer; evidence location/date} | {verified count and gaps} | {AUT-15 action/contact/coordinator/gate/status} | {REQ/NFR + ADR/RSK} |
+
 ## Test Readiness Inputs
 
 | Readiness Area | Status | Required Evidence / Outcome | Owner | Requirement / ADR / Risk |
@@ -52,8 +119,13 @@ with a Proposed ADR and linked risk; UAT can never use either disposition.
 - [ ] Every Exception Proposed row links a Proposed ADR and Identified risk
 - [ ] UAT is Applicable and cannot be exempted
 - [ ] Unit testing follows the migration-change rule and preserves existing automated suites
+- [ ] Integration is not a standalone test type: Migration-Team refactoring is covered by Change-Based Functional Testing; otherwise integration scenarios are included in mandatory Application-Team UAT
 - [ ] Security testing and penetration testing remain separate
+- [ ] HA disposition and evidence follow strategy Section 7.2, including owner assessment, approved goals, PPE, monitoring/data, entry/exit, and results
 - [ ] DR acceptance is planned for Production; lower-environment DR is rehearsal only
+- [ ] DR disposition and evidence follow strategy Section 7.3, including L2 execution, runbook handover, dependency scenarios, RTA/RPA, failback, defects, and sign-off
+- [ ] OAT outcomes consider the LSEG L2 Game Day catalog; applicability is evidence-based, not assumed universal, and Application Operations owns Production Cutover acceptance
 - [ ] Every Unknown and readiness gap names an owner and ADR/risk where progression is blocked
+- [ ] Each test type has an automation review entry; unanswered/partial/absent coverage has a tracked Application Team follow-up and dated answers are evidence-backed
 
 **Reviewed by**: {name} | **Date**: {YYYY-MM-DD} | **Outcome**: {Approved / Changes requested}
diff --git a/AGENTS.md b/AGENTS.md
index 5100bd1..a541f3d 100644
--- a/AGENTS.md
+++ b/AGENTS.md
@@ -131,6 +131,13 @@ built on top of this repo, not folded back into it.
   reviewer name/date. See constitution Principle III. The Architecture Review Gate, `/speckit.plan`'s
   Phase 2 gate, and `/speckit.tasks`'s prerequisite check all enforce this mechanically
   (`check-prerequisites.ps1 -RequireArchitectureReady` / `-RequireTasksReady`) — do not bypass them.
+- **Every gate has executable acceptance tests.** Gate criteria live once, as controlled Spec-Kit
+  checklist baselines in `.specify/checklists/` (`requirements`, `architecture`, `spec`, `plan`),
+  not as inline lists in templates. The producing command instantiates and evaluates its checklist,
+  checking an item only with cited evidence; `check-prerequisites.ps1` refuses to progress while
+  any item is open. A checked item never approves a decision or risk. Items that test artifacts
+  produced after a gate (`spec.md`, G-4, G-7) are listed under the baseline's **Post-Gate Items**
+  and block only their deliverable, never the gate itself.
 - **Templates are shared shape.** Don't fork `.specify/templates/*.md` per app; if the shape needs
   to change, that's a change to this template repo (bump `VERSION`, update `CHANGELOG.md`).
 - **Generated app artifacts evolve with a local changelog.** Each `specs/<NNN>-<app-slug>/` feature
diff --git a/CHANGELOG.md b/CHANGELOG.md
index d4c9006..391803a 100644
--- a/CHANGELOG.md
+++ b/CHANGELOG.md
@@ -3,6 +3,185 @@
 All notable changes to this template repo are recorded here. App repos instantiated from this
 template keep their own changelog for app-specific changes — this file is for the template itself.
 
+## 1.50.0 — 2026-10-08
+
+Fixes found by an end-to-end run of requirements → architecture → specify → plan on a mock
+application.
+
+**Gates that could never clear**
+
+- The Architecture Review Gate, Spec Review Checkpoint and Plan Phase 2 gate could not be cleared
+  as their templates instruct: the gate reader only accepted a status table row the templates never
+  ask for. `Get-GateReviewState` (now in `common.ps1`) also reads the decision from the **Reviewed
+  by … | Outcome** line; an explicit status row still takes precedence. `validate-architecture.ps1`
+  uses the same reader, so its "Cleared while items are open" checks now actually run.
+- No gate worked on Windows PowerShell 5.1. Three validators did not parse (UTF-8 scripts without a
+  BOM) and `validate-sad-contract.ps1` mis-decoded its contract and compared `5.0` with `5`.
+  Scripts with non-ASCII text now carry a BOM, `common.ps1` defaults content cmdlets to UTF-8 for
+  the running script, and the SAD validator reads UTF-8 and compares column counts as integers.
+  Record, index and gate readers now pass full paths: 5.1 binds a `FileInfo` to `-LiteralPath` as
+  its bare file name, so `validate-records`, `sync-records` and the open decision/risk count failed
+  with "Cannot find path" once 5.1 got past the first gate check.
+
+**Checklist enforcement**
+
+- Architecture-gate deadlock: some Complexity Calculator and MEC items test G-7, G-4 or `spec.md`,
+  which exist only after the gate. Baselines now declare them as **Post-Gate Items**
+  (Complexity CHK001/014/020/029/030, MEC CHK036/037/042). `validate-checklists.ps1 -RequireComplete`
+  ignores them; `-IncludePostGate` (used by `/speckit.publish`) enforces them for G-4/G-7.
+- The Architecture Review Gate now enforces the gate-required items of the Complexity Calculator and
+  MEC checklists directly, not only through architecture CHK017/CHK018.
+- Checklists are checked before the human sign-off, so open items are reported first.
+- New `check-prerequisites.ps1 -RequireSpecReady`: `/speckit.plan` now stops until the spec
+  checklist is complete and a named human has signed the Review Checkpoint.
+- New `check-prerequisites.ps1 -PathsOnly`: `/speckit.checklist` uses it, so re-evaluation works
+  before `spec.md` exists and while decisions are open.
+- `/speckit.checklist` may update the owning artifact's **Checklist status** line (previously
+  contradicted by its own step 12).
+- Reworded architecture CHK001 (layer outputs in their owning sections, not separate Layer Finding
+  files), CHK014 (exactly one R-Type), CHK017/CHK018 (post-gate aware).
+
+**Records**
+
+- `validate-records.ps1` accepted a blank Reviewer cell and never checked risks. Final ADRs, and
+  risks that have left `Identified`, now need a recorded decision/disposition, a named reviewer and
+  a YYYY-MM-DD date. Catalog IDs such as `LMP-ADR-0010` are no longer read as local records.
+- `sync-records.ps1` keeps an existing Requirements Review Gate block instead of resetting it to
+  Not Started.
+- The risk template's `- Blocks Progression: No` is now recognised as non-blocking.
+- `validate-records.ps1`, `validate-checklists.ps1` and `sync-records.ps1` exit 0 explicitly on
+  success, so in-process callers no longer read a stale exit code.
+- `test-testing-workflow.ps1` loads and passes on Windows PowerShell 5.1 (BOM; matches the `\u0027`
+  quote escaping of 5.1 `ConvertTo-Json`), and its fixture includes completed spec/plan checklists.
+
+**Doctor**
+
+- `doctor.ps1` now runs `validate-sad-contract.ps1` and `validate-testing-strategy.ps1`, so it can no
+  longer pass on a host where every gate would fail.
+
+Migration note: existing `checklists/architecture.md` files must re-copy CHK001, CHK014, CHK017 and
+CHK018 from the baseline (`/speckit.checklist architecture`).
+
+**Merged with 1.43.0–1.47.0 (testing evidence, OAT scenarios, Test Plan stages)**
+
+- Their new gate criteria live in the checklist baselines rather than inline template lists:
+  spec CHK007–CHK009 (Backlog Delta `IMP-*` preservation, Section 6 Testing Evidence Handoff, Test
+  Plan deferral) and architecture CHK032 (Section 14.3 scenario families). Spec CHK006 now cites
+  Section 8 decisions/risks after their renumbering.
+- The gate reader accepts an optional section number before a gate heading, so both the new
+  `## 9. Review Checkpoint` and older `## 8. Review Checkpoint` specs are read.
+- `Write-ScriptResult` emits `'` instead of Windows PowerShell 5.1's `\u0027`, so `-Json` output
+  is identical on both hosts and the new Test Plan/OAT negative tests pass on 5.1.
+
+## 1.49.0 — 2026-10-07
+
+Gate criteria are now Spec-Kit checklists that the gates execute, instead of inline checkbox lists
+that nothing read.
+
+- Moved the Requirements Review Gate, Architecture Review Gate, Spec Review Checkpoint and Plan
+  Phase 2 Review Gate lists into controlled baselines `.specify/checklists/requirements.md` (21),
+  `architecture.md` (31), `spec.md` (6) and `plan.md` (7). Criteria are unchanged; each is now a
+  numbered `CHK###` quality question with a section reference. Templates point to the checklist and
+  carry a **Checklist status** line.
+- `/speckit.requirements`, `/speckit.architecture`, `/speckit.specify` and `/speckit.plan` evaluate
+  their checklist before stopping at the gate and report open items by evidence owner;
+  `/speckit.clarify` and `/speckit.checklist <name>` re-evaluate after later edits.
+- `check-prerequisites.ps1` now requires `checklists/requirements.md` for `-RequireRequirementsReady`,
+  `architecture.md` for `-RequireArchitectureReady`, and `spec.md` plus `plan.md` for
+  `-RequireTasksReady`/`-RequireImplementationReady`, each passing `validate-checklists.ps1
+  -RequireComplete`. Reports `gateChecklistStatus`.
+- Migration note: features already past a gate must run `/speckit.checklist <name>` for each gate
+  they have cleared before the next `check-prerequisites.ps1` run succeeds.
+
+## 1.48.0 — 2026-10-07
+
+- Added `.specify/scripts/powershell/doctor.ps1`, a read-only environment check to run before the
+  first `/speckit.requirements`. It reports PowerShell version, effective execution policy
+  (excluding Process scope, which the prompts' child processes do not inherit), .NET zip support,
+  Git, and `SPEC_LAYER_APP_ROOT` validity.
+- The doctor also verifies the hash-pinned SAD v3.4 and testing-strategy DOCX files and the
+  Complexity Calculator workbook are readable OOXML, so a cloud placeholder or sensitivity-label
+  encrypted copy is reported up front instead of failing every gate in `check-prerequisites.ps1`.
+- Pandoc and VS Code Copilot Chat are advisory checks. Supports `-Json`; exits 1 on any failure.
+## 1.47.0 — 2026-10-07
+
+- Corrected Draft and ReadyForReview Test Plan gates: Conditional/Blocked architecture readiness
+  and pending approver roles are reviewable only through relevant owned actions, ADR/risk traces,
+  contacts/coordinators and needed-by gates. Execution/default prerequisite gates still require
+  Ready environments, named humans and exact-version approvals; false approval/evidence and
+  stage/status contradictions remain errors.
+- Added a source-owned, concise Review Brief before detailed Test Plan tables: proposed scope,
+  evidence confidence, separate artifact quality/input completeness, at most five prioritized
+  conflicts and human actions, linked case/asset/estimate/crosswalk detail and next approval gate.
+  Review validates canonical references/statuses; legacy Drafts warn when navigation is absent.
+- Wired planning, analysis and faithful publication guidance; added regression fixtures for owned
+  incomplete proposals, unowned dependencies, stale summaries and strict execution behavior.
+
+## 1.46.0 — 2026-10-07
+
+- Added reusable evidence provenance/conflict, shared human-input, test-asset health, case-outline,
+  migration impact-to-test crosswalk and estimate-boundary contracts across requirements,
+  architecture and planning.
+- Added the SPEC testing-evidence handoff: canonical test-type coverage links architecture
+  crosswalks, exact requirement/implementation/backlog IDs, supplied/proposed cases and assets,
+  shared profile actions, repository readiness and later planning gates without requiring the
+  Planning-stage Test Plan or duplicating its case matrix.
+- Added Draft/ReadyForReview/Execution Test Plan validation guidance while preserving strict
+  Execution as the validator default; incomplete evidence remains visible without being treated as
+  a generation failure or approval.
+- Updated analysis and publication guidance to preserve cross-artifact traces, full-fidelity draft
+  status and the distinction between artifact quality and input completeness.
+- Added stage, evidence, scope-boundary and migration-impact regression coverage; refreshed the
+  reviewed testing-strategy index contract.
+
+## 1.45.0 — 2026-10-06
+
+- Added per-test Application Team automation review actions, distinguishing unverified evidence
+  from confirmed absent/partial coverage, with downstream high-level scenario and effort sizing.
+- Updated requirements, architecture, planning and analysis prompts, skills and templates to
+  expose scenario volume, reusable/uncovered scope and automation development effort separately
+  from execution; activity ownership cites the LMP strategy and preserves one-sprint enablement,
+  migration-changed unit scope and Application Team maintenance boundaries.
+- Added elapsed testing timelines, 1/2/3-tester capacity scenarios, optional jointly agreed
+  lower-environment Pre-OAT and four-party Test Plan approval requirements.
+- Extended testing validators and regression fixtures for automation reviews, scenario design,
+  effort sizing, capacity estimates and approval completeness; refreshed the strategy index contract.
+
+## 1.44.0 — 2026-10-06
+
+- Added the LSEG L2 Game Day/OAT catalog and dedicated architecture-design and test-planning
+  subskills to select operational scenarios from evidenced as-is components and the proposed Azure
+  target without assuming applicability, current tooling, or production authorization.
+- Added 51 stable OAT scenario IDs to the Architecture and Test Plan templates, requiring
+  application-specific evidence, Operations ownership, runbooks, safety controls, and recorded
+  disposition.
+- Expanded architecture and Test Plan validators and workflow regressions to reject missing OAT
+  scenarios/evidence and unsafe production-disruptive tests; refreshed the testing-strategy index
+  contract.
+
+## 1.43.1 — 2026-10-05
+
+- Clarified that integration testing is scenario scope within Change-Based Functional Testing when
+  the Migration Team performs refactoring, including refactoring under Re-Host/Re-Platform; absent
+  Migration-Team refactoring, integration scenarios belong to mandatory Application-Team UAT.
+- Updated requirements/architecture/planning templates, testing skills and workflow prompts to
+  preserve the split, keep UAT mandatory, and avoid duplicate case counts or a standalone
+  Integration Testing type.
+- Added profile/Test Plan validator checks and regression cases rejecting standalone integration
+  rows or missing functional/UAT ownership branches; updated the testing-strategy index contract.
+
+## 1.43.0 — 2026-10-05
+
+- G-3 is now a framework-managed, versioned publication at `deliverables/G-test-plan.md`, rendered
+  in full from the authoritative feature-root `G-test-plan.md` without changing its test scope or
+  approval state.
+- Publication setup seeds the G-3 view from the canonical source, preserves version history, and
+  leaves G-3 Pending without creating a placeholder when the source plan does not exist.
+- Finalization and validation reject G-3 source/view drift; analysis and planning guidance now
+  distinguish the authoritative root source from its expected published copy.
+- Expanded the publication workflow smoke test for G-3 materialization, parity, unchanged reruns,
+  content version increments, and pre-plan Pending behavior.
+
 ## 1.42.2 — 2026-10-01
 
 - MEC-8 requirements and architecture prompts/skills now explicitly check the latest available
diff --git a/README.md b/README.md
index 5c29b19..967fcd6 100644
--- a/README.md
+++ b/README.md
@@ -95,6 +95,7 @@ this template's shared shape. If an app genuinely needs a different shape, that'
 |------|---------|
 | `.specify/memory/constitution.md` | The principles + Workflow Order every requirements/architecture/spec/plan/tasks run must satisfy |
 | `.specify/templates/` | Requirements, architecture, spec, plan, tasks, decision-log, risk-register templates |
+| `.specify/checklists/` | Controlled Spec-Kit checklist baselines. `requirements`, `architecture`, `spec` and `plan` are each gate's acceptance tests (the owning command evaluates them; `check-prerequisites.ps1` blocks the next command until every item passes); `mec-assessment` and `complexity-calculator` test G-4 and G-7 |
 | `.specify/scripts/powershell/` | Framework automation used by the prompts; writes only to `SPEC_LAYER_APP_ROOT` |
 | `.github/prompts/` | Slash-command prompts (Spec-Kit workflow) |
 | `.github/skills/requirements-transition/` | Elicits client/user migration, cutover, coexistence, data transition/reconciliation, rollback, hypercare, and decommission requirements into authoritative `migration-transition.md` (Section 2A compatibility view) and ordinary REQ/NFR records |
@@ -124,5 +125,14 @@ unchanged deliverables keep their versions.
 ## Requirements
 
 - Git
-- PowerShell 5.1+ (Windows PowerShell or PowerShell 7)
+- PowerShell 5.1+ (Windows PowerShell or PowerShell 7), with an execution policy that allows
+  local unsigned scripts (for example `RemoteSigned` for the current user)
 - VS Code + GitHub Copilot (or another agent that reads `.github/prompts/*.prompt.md`)
+- Optional: Pandoc, only to re-extract the testing strategy DOCX
+
+No Python packages are required. Run the doctor once per machine, after setting
+`SPEC_LAYER_APP_ROOT`:
+
+```powershell
+powershell -ExecutionPolicy Bypass -File .specify/scripts/powershell/doctor.ps1
+```
diff --git a/VERSION b/VERSION
index 1cd7146..5a5c721 100644
--- a/VERSION
+++ b/VERSION
@@ -1,2 +1 @@
-1.42.2
-
+1.50.0
diff --git a/deliverables-template/md-templates/G-test-plan.md b/deliverables-template/md-templates/G-test-plan.md
index 21dbf21..b34918b 100644
--- a/deliverables-template/md-templates/G-test-plan.md
+++ b/deliverables-template/md-templates/G-test-plan.md
@@ -9,9 +9,55 @@
 
 ---
 
+## Review Brief
+
+Keep this opening to approximately one page. It is navigation into the authoritative evidence,
+not another register: rank at most five significant conflicts and five next human actions by
+scope/acceptance risk and dependency order, not ID order or a blanket Critical priority.
+Use `None — reason` when a list is empty; keep remaining items in the linked registers.
+
+**Purpose and maturity**: {what this review should decide; current Draft/Ready for Review/Approved
+status; proposal versus execution baseline}
+
+**Proposed scope and exclusions**: {evidence-bounded scope, unchanged mandatory obligations,
+exclusions with basis; link families/cases rather than listing every case}
+
+**Evidence basis and confidence**: {source/version/locators, reported versus verified assets and
+unique cases versus families; unknown counts remain Unknown; stale or missing inputs lower confidence}
+
+**Artifact quality versus input completeness**: {stage validation result separately from
+verified/unresolved/unavailable/conflicting inputs, with dated evidence basis; no unsupported completeness percentage}
+
+**Next gate and version boundary**: {what humans are being asked to review now, what remains
+blocked for execution, exact source/published version and approvals that must be renewed after changes}
+
+### Significant Conflicts
+
+| Priority / Why Now | Canonical Reference | Current Status | Review Focus / Next Step |
+| --- | --- | --- | --- |
+| {risk and dependent scope; maximum five rows} | {CON-ID linked to /specs/feature-directory/requirements/testing-profile.md#evidence-sources-and-conflicts} | {exact register status} | {decision needed, affected scope; link related ACT/AUT action, do not copy competing-claim ledger} |
+
+### Priority Human Actions
+
+| Priority / Why Now | Canonical Reference | Current Status | Review Focus / Next Step |
+| --- | --- | --- | --- |
+| {dependency/impact ordering; maximum five rows} | {ACT/AUT-ID linked to /specs/feature-directory/requirements/testing-profile.md#human-input-and-decision-register} | {exact register status} | {question/decision, contact/accountable role, needed-by gate and impact via canonical row; do not invent appointment or date} |
+
+**Supporting detail**: [Scope and effort](#scenario-scope-and-automation-effort) ·
+[Case mappings](#high-level-case-outlines) · [Asset inventory](#test-assets-and-traceability) ·
+[Estimate boundaries](#estimate-scope-and-boundary-reconciliation) ·
+[Migration impacts](/specs/{feature-directory}/architecture.md#144-migration-impact-to-test-crosswalk) ·
+[All conflicts](/specs/{feature-directory}/requirements/testing-profile.md#evidence-sources-and-conflicts) ·
+[All human inputs](/specs/{feature-directory}/requirements/testing-profile.md#human-input-and-decision-register) ·
+[Approval boundary](#test-plan-approval-gate).
+
+Replace cross-file feature-directory placeholders with the actual repository-root feature path
+or controlled source URL; preserve the same body and local anchors in the published copy.
+
 ## Test Strategy
 
-**Canonical application artifact**: this feature's `G-test-plan.md`.
+**Authoritative application source**: feature-root `G-test-plan.md`.
+**Published deliverable**: `deliverables/G-test-plan.md`, generated from this source by `/speckit.publish`.
 
 **Sources**: `docs/testing-strategy/INDEX.md`, `requirements/testing-profile.md`, approved
 `REQ-*`/`NFR-*` records, and `architecture.md` Section 14.1. Testing scope must not be inferred only
@@ -34,7 +80,7 @@ from R-Type, and this deliverable must not approve its own exceptions or risks.
 | Migration tool | Applicable — universal baseline | {tool fitness and source validation} | {IDs} | {roles} | {env} | {criteria} | {criteria} | Before migration use | {report/path} | {N/A or ADR/RSK} |
 | Application installation | Applicable — universal baseline | {deployment/configuration and post-deploy behavior} | {IDs} | {roles} | {env} | {criteria} | {criteria} | Every applicable deploy | {report/path} | {N/A or ADR/RSK} |
 | Smoke/regression | Applicable — universal baseline | {critical/common behavior and regression depth} | {IDs} | {roles} | PPE | {criteria} | {criteria} | Before cutover | {report/path} | {N/A or ADR/RSK} |
-| Change-based functional | {Applicable/Not Applicable — resolved migration-change basis} | {changed and dependent unchanged components} | {IDs} | {roles} | PPE | {criteria} | {criteria} | {window/gate} | {report/path} | {N/A or ADR/RSK} |
+| Change-based functional | {Applicable/Not Applicable — resolved migration-change basis} | {for Re-Factor, or lower R-Type with Migration-Team refactoring: changed/refactored components and dependent unchanged components, including integration scenarios} | {IDs} | {Migration Team for its refactoring; otherwise N/A — integration scenarios belong to App-Team UAT} | PPE | {criteria} | {criteria} | {window/gate} | {report/path} | {N/A or ADR/RSK} |
 | Full functional | {Applicable/Not Applicable — resolved R-Type basis} | {user-story/end-to-end behavior} | {IDs} | {roles} | {env} | {criteria} | {criteria} | {window/gate} | {report/path} | {N/A or ADR/RSK} |
 | Performance and baseline | Applicable — universal baseline | {latency/load/capacity/stress/endurance and equal-volume comparison} | {IDs} | {roles} | PPE | {valid baseline/NFRs/monitoring} | {targets/tolerable variance} | Before cutover | {report/path} | {N/A or ADR/RSK} |
 | High availability | Applicable — universal baseline | {component/application failure scenarios} | {IDs} | {roles} | PPE | {production-comparable setup} | {availability/loss/degradation targets} | Before cutover | {report/path} | {N/A or ADR/RSK} |
@@ -42,11 +88,228 @@ from R-Type, and this deliverable must not approve its own exceptions or risks.
 | Security testing | Applicable — universal baseline | {vulnerability/configuration/code/control checks} | {IDs} | {roles} | PPE except approved production checks | {criteria} | {approved findings threshold} | Pre-cutover | {report/path} | {N/A or ADR/RSK} |
 | Security penetration testing | Applicable — universal baseline unless exception approved | {production penetration scope} | {IDs} | {LSEG security role / approver} | Production | {authorization/window/entry criteria} | {Critical/High disposition} | Pre-cutover | {report/path} | {N/A or ADR/RSK} |
 | Operational acceptance testing | Applicable — universal baseline | {operational readiness scenarios} | {IDs} | {roles} | Production | {criteria/change approval} | {operations acceptance} | Cutover | {report/path} | {N/A or ADR/RSK} |
-| User acceptance testing | Applicable — universal baseline; no exemption | {business scenarios and integration} | {IDs} | {roles} | PPE | {criteria} | {business acceptance/defect threshold} | Before cutover | {report/path} | N/A |
+| User acceptance testing | Applicable — universal baseline; no exemption | {business scenarios and integration scenarios when Migration Team refactoring is not performed; do not duplicate cases already counted under Change-Based Functional Testing} | {IDs} | {LSEG Application Team owns and executes business and applicable integration scenarios} | PPE | {criteria} | {business acceptance/defect threshold} | Before cutover | {report/path} | N/A |
 | Migration rehearsal | Section 7A | {MIG sequence, timing, roles and evidence capture} | {IDs} | {roles} | Production-like | {criteria} | {all controls within thresholds} | Before go/no-go | {report/path} | {N/A or ADR/RSK} |
 | Rollback/backout | Section 7A | {trigger, authority, traffic/application/data recovery and point of no return} | {IDs} | {roles} | Production-like | {criteria} | {recovery target/evidence} | Before cutover approval | {report/path} | {N/A or ADR/RSK} |
 | Client migration / hypercare | Section 7A | {compatibility, adoption, telemetry, incidents, defects and data quality} | {IDs} | {roles} | {pilot/production} | {criteria} | {wave/hypercare acceptance} | {window/gate} | {report/path} | {N/A or ADR/RSK} |
 
+### Scenario Scope and Automation Effort
+
+Consume the profile's Automation Availability Review and Architecture Section 14.3 using
+`docs/testing-strategy/automation-review-and-scenario-sizing.md`. Keep this plan high-level:
+one sizing row per applicable canonical test type when supported by application evidence; where a
+business fact or asset inventory is missing, carry the linked action and mark scope/basis Unknown
+rather than inventing cases. Show verified reusable coverage separately from reported or linked
+assets and uncovered scope. Unknown automation remains pending Application Team confirmation, never
+an assumed negative answer.
+Migration and Application Teams jointly deep-dive scenario scope, effort and automation decisions
+before baselining; specialized L2/Security ownership remains as prescribed by the LMP strategy.
+
+| Scope Reference | Test Type | Scenario References / Count Band / Basis | Verified Reuse / Uncovered Scope / Review Action | Reuse-Adapt-Build-Manual Decision | Effort Range (person-days): Review / Automation / Setup / Execution / Retest / Report-Handover | Implementation / Execution / Maintenance / LMP Section-RACI | Confidence / Assumptions / Backlog Trace |
+| --- | --- | --- | --- | --- | --- | --- | --- |
+| {scope reference} | {canonical type; repeat for each applicable type} | {architecture family IDs, proposed/verified counts distinguished and derivation} | {asset/run evidence, coverage gaps, AUT-ID and Application Team response/follow-up} | {reuse/adapt/build scope; reproducible manual portion} | {six separate effort ranges; zero with reason for no work} | {separate roles, ongoing maintenance capacity, exact strategy section and Appendix 5} | {confidence/drivers/exclusions, review gate and backlog item} |
+
+### High-Level Case Outlines
+
+Preserve supplied case identifiers and their source/version/locator. Use stable local IDs only for
+proposed outlines. These are reviewable objectives, not detailed scripts or execution evidence.
+Use an evidence-backed outline only when the actual component/flow and behavior are known; otherwise
+link the owned action that must establish the missing fact. Keep OAT catalog cases in the OAT table
+and reference catalog IDs rather than counting them twice. Case disposition is separate from
+execution result.
+
+| Case ID | Origin (Supplied / Proposed) | Source Asset / Locator | Test Type / Family / REQ-NFR / Component or Flow | Objective / Preconditions / Data / High-Level Steps | Measurable Expected Outcome | Disposition (Covered / Adapt / Proposed / Excluded / Pending) and Evidence | Environment / Tool / Automation | Owner / Evidence Result Path / Action ID |
+| --- | --- | --- | --- | --- | --- | --- | --- | --- |
+| {supplied ID unchanged or stable local CASE-###} | {Supplied / Proposed} | {asset/version/locator or proposed basis} | {canonical type, SCN reference, REQ/NFR and evidenced component/flow} | {objective, preconditions, data and high-level steps; no invented business facts} | {source-backed result or action needed to define it} | {disposition/evidence; do not claim execution} | {environment/tool and verified/proposed/manual} | {accountable role; planned result path or Pending; ACT-### if open} |
+
+Especially for Unit and Performance, expose automation creation/adaptation effort separately
+from execution. Developer/performance-engineer availability is not implied by 1/2/3 tester capacity.
+Retain existing unit suites; Migration additions cover only migration-changed impacted code.
+For performance separately size baseline acquisition/validation, workload scripts, data/telemetry
+setup and owner-approved workload execution. Section 4.1 framework recommendation, 2-3 sample
+cases and knowledge transfer are conditional and limited to one sprint, not a commitment to build
+every missing suite; Application Team adoption, coverage growth and maintenance are separate.
+Feed these work packages into elapsed estimates and scheduled backlog, retaining Low confidence
+and open review gates where evidence is incomplete.
+
+### Estimated Elapsed Testing Timeline and Capacity
+
+Provide evidence-based elapsed-time estimates for every canonical test type and separately for
+optional pre-OAT. Estimates cover the window from agreed scope and entry readiness through
+execution, expected defect/retest allowance, reporting and review; show external approval,
+procurement, change-window and customer wait time separately. These are planning ranges, not
+commitments or effort estimates. Do not add row durations to calculate the end date: record actual
+predecessor gates, parallel work, resource/environment conflicts, critical path and dated
+assumptions in `plan.md`.
+
+Use capacity scenarios of 1, 2 and 3 active testers. State whether they are dedicated full-time
+equivalents and identify specialist and operational contributors separately. Do not scale duration
+linearly when constrained by a shared environment, serial data movement, security approval,
+Production windows, L2 availability or business-user calendars. For each row record verified case
+counts, automation/manual split, reuse/build assumptions, and confidence/rationale. If coverage is
+not evidenced, size conservatively as unverified rather than assuming automation exists; re-estimate
+when inventory and pilot results are available. State a separate contingency reserve and its basis.
+
+| Test Type / Workstream | Applicability | Case-count and automation basis | Elapsed — 1 tester | Elapsed — 2 testers | Elapsed — 3 testers | Dependencies, overlap, wait time, confidence |
+| --- | --- | --- | --- | --- | --- | --- |
+| Connectivity | {Applicable / N/A + evidence} | {verified cases; automated/manual; reuse/build} | {range} | {range} | {range} | {entry, overlap, approvals, confidence} |
+| Unit | {Applicable / N/A + evidence} | {migration-changed impacted code; existing suite coverage} | {range} | {range} | {range} | {CI cadence, code availability, confidence} |
+| Data migration verification | {Applicable / N/A + evidence} | {source count; reconciliation automation/manual split} | {range} | {range} | {range} | {data readiness, serial/parallel work, confidence} |
+| Migration tool | {Applicable / N/A + evidence} | {tool/mode cases; automated/manual split} | {range} | {range} | {range} | {access, source window, confidence} |
+| Application installation | {Applicable / N/A + evidence} | {target components/environments; IaC/pipeline reuse} | {range} | {range} | {range} | {foundation, environment, confidence} |
+| Smoke/regression | {Applicable / N/A + evidence} | {critical-path cases; automated/manual split} | {range} | {range} | {range} | {build/deploy gates, confidence} |
+| Change-based functional | {Applicable / N/A + evidence} | {migration-changed functional cases; integration only for Migration-Team refactoring} | {range} | {range} | {range} | {test data, dependencies, shared PPE, confidence} |
+| Full functional | {Applicable / N/A + evidence} | {case count and automation basis} | {range or N/A} | {range or N/A} | {range or N/A} | {R-Type basis, confidence} |
+| Performance and baseline | {Applicable / N/A + evidence} | {workload scripts, automation coverage, baseline readiness} | {range} | {range} | {range} | {PPE exclusivity, data/tool readiness, confidence} |
+| High availability | {Applicable / N/A + evidence} | {HA cases, reusable scripts, manual fault-control steps} | {range} | {range} | {range} | {isolated PPE window, monitoring, confidence} |
+| Disaster recovery | {Applicable / N/A + evidence} | {DR cases, runbook automation/manual execution} | {range} | {range} | {range} | {L2 calendar, Production/change window, hard gate, confidence} |
+| Security testing | {Applicable / N/A + evidence} | {continuous automated scans plus manual assurance and retest} | {range} | {range} | {range} | {tool/access/findings turnaround, confidence} |
+| Security penetration testing | {Applicable / approved exception only} | {authorized scope, specialist execution and remediation/retest} | {range} | {range} | {range} | {security slot and Production authorization waits separately} |
+| Operational acceptance testing | {Applicable / N/A + evidence} | {approved OAT scenarios; automation/manual split; L2 capacity} | {4 calendar weeks unless evidence revises} | {4 calendar weeks unless evidence revises} | {4 calendar weeks unless evidence revises} | {Application Operations/L2 Production/Cutover calendar and change windows; do not shorten by assumed tester count} |
+| User acceptance testing | Applicable — mandatory for every R-Type | {business case count; automated/manual split; business-user capacity} | {range} | {range} | {range} | {named business users, approval window, hard gate} |
+| Migration rehearsal and rollback/backout | {Applicable / N/A + evidence} | {MIG-### sequence, rehearsal and rollback checks; automated/manual split} | {range} | {range} | {range} | {environment/data refresh, cutover gate, confidence} |
+| Optional pre-OAT lower-environment rehearsal | Optional — only when Migration Team and Application Team agree | {jointly agreed scenario IDs/count, exclusions, automation/manual split} | {range after scope agreement} | {range after scope agreement} | {range after scope agreement} | {lower environment; agreed scope/window/owner; never substitutes for Production OAT} |
+
+Record the proposed integrated window, not a sum of this table: `{range at 1 tester}` versus
+`{range at 2–3 testers}`, including the 4-week L2 OAT block, critical path, overlaps and external
+waits. Identify low-confidence drivers and re-estimate after the case-count/automation inventory,
+environment rehearsal and named-team calendars are confirmed.
+
+### Estimate Scope and Boundary Reconciliation
+
+State exactly what each estimate includes and excludes. A phase estimate and an end-to-end estimate
+are not contradictory until their start/end boundaries, included work, calendars, dependencies and
+external waits are compared. Distinguish source-evidenced constraints from proposed estimates;
+reconcile changed approved scope by re-estimating rather than silently changing a baseline. Keep
+the LMP four-calendar-week Production OAT baseline as an L2 elapsed-time reference unless current
+L2 evidence revises it; it is not a whole-project timeline or a confirmed calendar booking.
+
+| Estimate ID / Source | Estimate Kind / Value / Confidence | Start Boundary | End Boundary | Included Phases / Work | Excluded Phases / External Waits | Basis / Scope Version / Evidence | Comparison / Reconciliation / Action |
+| --- | --- | --- | --- | --- | --- | --- | --- |
+| EST-001 | {phase or end-to-end; effort or elapsed; range/confidence} | {entry event/date or relative point} | {exit event/date or relative point} | {included work and overlap} | {excluded work, calendar, approval or external waits} | {case/family volume, reuse health, capacity, source locator, scope version} | {compatible, incomparable boundaries, source conflict, or ACT-### to confirm} |
+
+### Optional Pre-OAT Scope — Lower Environment
+
+This is an optional rehearsal workstream, not a replacement for the mandatory Application
+Operations Production OAT during Cutover and not a new canonical test type. Keep it `Not agreed`
+until the Migration Team and Application Team jointly approve the scenario IDs/count, objectives,
+lower environment, data/access, owners, entry/exit criteria, automated/manual split and elapsed
+window. Record the agreement and linked work in the tables below. If not agreed, state the reason
+and leave it unscheduled; do not infer scenario volume or approval.
+
+| Decision field | Proposed value / required agreement |
+| --- | --- |
+| Current decision | {Not agreed / Agreed / Declined + rationale} |
+| Selected OAT scenario IDs and count | {Jointly agreed IDs/count, or Pending} |
+| Lower environment and production comparability | {environment, constraints and evidence} |
+| Entry/exit criteria, data, access and safety | {readiness and pass/fail criteria} |
+| Owners and evidence | {Migration Team / Application Team roles, reports and evidence path} |
+| Elapsed window and dependencies | {1/2/3 tester estimate, agreed dates/window, dependencies and confidence} |
+| Agreement record | {named Migration and Application approvers, dates and evidence, or Pending} |
+
+### High Availability Test Design
+
+Use `docs/testing-strategy/LMP-Migration-Testing-Strategy.md` Section 7.2. Record:
+
+- Application Owner assessment based on R-Type, failover mechanisms, redundancy, load balancing,
+  and implemented resiliency.
+- Approved HA goals and success metrics: uptime/SLA, RTO/RPO, redundancy/failover, scalability,
+  resource utilization, data loss, and performance degradation. Do not invent thresholds.
+- Scope, test types/cases, pass/fail criteria, background load, selected/provisioned tooling, and
+  reusable functional/performance automation where suitable.
+- Production-comparable PPE configuration, approved SII and plan entry for any material
+  production difference, complete monitoring, and prepared test data.
+- A safe PPE window with no concurrent activities, named execution/support/approval roles, and
+  signed entry/exit criteria. Entry must confirm approved goals/cases/plan, PPE/monitoring, and
+  application access. Exit must confirm all HA cases and goals pass, defects are fixed/retested or
+  formally risk-accepted, and the HA report and Test Execution Results Report are approved.
+
+### Disaster Recovery Test Design
+
+Use `docs/testing-strategy/LMP-Migration-Testing-Strategy.md` Section 7.3. Production execution by
+the LSEG Application L2 Team before customer cutover is the DR acceptance test; lower environments
+are rehearsals only. Record:
+
+- Migration Team ownership of DR cases and runbook creation/handover to L2; LSEG employee
+  ownership of the DR Coordinator and Technology Owner roles; and the L2 team's readiness and
+  execution role.
+- Production recovery steps and all plausible failure scenarios, including dependency failover
+  while the application/cloud hosting environment remains in place.
+- Entry approval, understood recovery plan and objectives, fully provisioned Production setup
+  (including authentication/authorization), representative test data, selected tools, trained team,
+  and configured/in-sync backup systems.
+- Exit measures for RTA <= RTO and RPA <= RPO; restored-data integrity/accuracy; critical
+  functionality; tested failback and recovery normalization; completed test documentation and
+  technical/process learnings;
+  resolved/retested defects or authorized LSEG risk acceptance; results report, evidence link,
+  and standard deliverable sign-off.
+
+### Operational Acceptance Test Design
+
+Use `docs/testing-strategy/LSEG-L2-OAT-Game-Day-Scenario-Catalog.md` and the approved
+Architecture Section 14.2 matrix; invoke `oat-scenario-planning`. Keep one row for every catalog
+ID, preserving the architecture disposition. For each recommended scenario, complete the as-is
+and target mapping, executable steps, measurable expected result, environment and change approval,
+stop/recovery controls, Operations owner, runbook and evidence. `Not applicable` requires evidence;
+unknown is a blocker. Source statuses and tooling examples are not test results or current approvals.
+Per the LMP strategy, Application Operations executes/accepts OAT in Production during Cutover.
+Destructive Production/DR actions also require explicit authorization and safeguards. OAT does not
+replace HA, DR, UAT, or other test obligations.
+
+| Catalog ID | Scenario | Disposition | As-is evidence | Proposed Azure target / applicability | Executable steps and expected outcome | Environment / change approval / stop-recovery | Operations owner / runbook / evidence / status |
+| --- | --- | --- | --- | --- | --- | --- | --- |
+| L2-OAT-GD-01 | Availability-zone failover | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-GD-02 | VM interruption during request | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-GD-03 | Container interruption during request | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-GD-04 | Serverless concurrency limit | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-GD-05 | Database zone failure | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-GD-06 | High-concurrency stress and recovery | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-GD-07 | Storage internal errors | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-GD-08 | Messaging region failure | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-GD-09 | Third-party dependency outage | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-GD-10 | Application smoke | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-GD-11 | AKS upgrade and conditional key rotation | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-GD-12 | IaC no-change drift check | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-GD-13 | Production deployment operational checks | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-GD-14 | Critical workflow SLO breach alert | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-GD-15 | Upstream service-level breach alert | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-GD-16 | Server/container resource threshold alert | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-GD-17 | Serverless resource/timeout alert | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-GD-18 | Database backup failure alert | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-GD-19 | Storage capacity threshold alert | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-GD-20 | Log levels and error quality | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-GD-21 | Incident communications | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-GD-22 | Account/service quota threshold alert | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-GD-23 | Database point-in-time/backup restore | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-GD-24 | Object restore | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-CHG-01 | Recreate application IaC stack | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-CHG-02 | Golden-image refresh (self-managed compute) | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-CHG-03 | Database schema deployment | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-CHG-04 | Infrastructure deployment rollback | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-CHG-05 | Blue/green application deployment | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-CHG-06 | Application deployment rollback | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-CHG-07 | Database deployment rollback | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-CHG-08 | Vertical VM scaling | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-CHG-09 | Add disk/extend LVM capacity | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-VAL-01 | DR documentation and RTA/RTO evidence | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-VAL-02 | Encryption at rest/in transit | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-VAL-03 | Infrastructure/production access control | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-VAL-04 | Access approver groups and reviews | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-VAL-05 | Logging compliance | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-VAL-06 | Password rotation/secrets management | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-VAL-07 | Certificate uniqueness and renewal | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-VAL-08 | Third-party vulnerabilities/licensing | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-VAL-09 | One Policy Engine pipeline/report | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-VAL-10 | Terraform module scan/CPF drift | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-VAL-11 | Mandatory resource tagging | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-VAL-12 | Runbook and support contacts | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-VAL-13 | Manual operational activities/RAID | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-VAL-14 | CloudOps onboarding checklist | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-VAL-15 | Datadog monitor hygiene | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-VAL-16 | DML/technical debt and SIIs | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-VAL-17 | Azure account/subscription outage | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+| L2-OAT-VAL-18 | Third-party outage response | {Recommended/Conditionally applicable/Not applicable/Blocked} | {evidence} | {target} | {steps/pass criteria} | {environment/change/safety} | {owner/runbook/evidence/status} |
+
 ### Minimum Viable Testing
 
 | Applicability | Trigger / Evidence Gap | Mandatory Minimum Scope | Approval / Exception | Exit Evidence |
@@ -89,11 +352,20 @@ and governed like application code.
 Every applicable test type and deliverable approval must have exactly one accountable role and at
 least one responsible role. Do not fabricate individual names.
 
+Integration is scenario scope, not a separate test type or RACI row. Assign integration scenarios to
+Change-Based Functional Testing when the Migration Team performs refactoring; otherwise assign them
+to mandatory UAT under the LSEG Application Team. UAT remains mandatory in both cases.
+
 ### Test Assets and Traceability
 
-| Asset / Control | Version / Location | Owner | Requirements / Cases / Defects Linked | Maintenance / Retention | Status / Gap / ADR-Risk |
-| --- | --- | --- | --- | --- | --- |
-| {test plan/case/script/baseline/data/tool/result/evidence repository} | {version/path} | {role/team} | {IDs/links} | {rule} | {status/gap} |
+Keep reported availability separate from verified reuse health. A framework, repository link or
+catalog listing is not proof that a compatible suite runs or covers the proposed target. Only a
+dated run/result or equivalent evidence supports `Verified-available`; zero verified cases is a
+valid, explicit finding.
+
+| Asset ID | Asset Type / Supplied Case IDs | Version / Locator / Owner | Availability (Reported-linked / Available-unverified / Verified-available / Unavailable / Unknown) | Reuse Health (Reuse / Adapt / Build / Manual / Excluded / Undecided) | Verified Coverage / Gaps / Families | Last Run / Result Locator | Compatibility / Applicability Evidence | Maintenance / Retention / Action ID |
+| --- | --- | --- | --- | --- | --- | --- | --- | --- |
+| AST-001 | {test plan/case/script/baseline/data/tool/result/environment; preserve IDs} | {version/path/contact} | {availability state and evidence} | {reuse decision, separate from availability} | {verified counts/families and uncovered scope} | {dated result or Not run} | {fit evidence or Unknown} | {owner/retention and ACT-### or N/A with reason} |
 
 ### Environment Strategy
 
@@ -133,12 +405,35 @@ risk acceptance by an authorized human. Preserve test-case-to-defect links and r
 | --- | --- | --- | --- | --- | --- | --- |
 | {test exception/dependency/delay/approval} | {condition} | {ADR/RSK/SII/ADO reference} | {role/team} | {action/evidence} | {date/gate} | {Pending/approved outcome with reviewer/date} |
 
+### Test Plan Review and Approval
+
+The complete Test Plan, including scope, timeline, assumptions, capacity, optional pre-OAT
+recommendation and outstanding risks, must be reviewed and approved by all four delivery parties
+below before the overall Test Plan is marked Approved or used as an execution baseline. Record an
+individual's name, decision date, outcome and evidence link for each approval. Pending is not
+approval. Additional Security, business, change or Production authorizations remain required where
+applicable.
+
+| Required reviewer organization | Review focus | Named reviewer | Decision date | Outcome | Evidence / comments |
+| --- | --- | --- | --- | --- | --- |
+| Migration Team | Migration scope, dependencies, schedule, readiness and delivery ownership | {name / Pending} | {YYYY-MM-DD / Pending} | {Pending / Approved / Changes requested} | {link / Pending} |
+| Migration Testing Team | Test design, automation, case inventory, estimates, evidence and execution readiness | {name / Pending} | {YYYY-MM-DD / Pending} | {Pending / Approved / Changes requested} | {link / Pending} |
+| Application Team | Business scope, application assumptions, test data, available SMEs, optional pre-OAT agreement and acceptance | {name / Pending} | {YYYY-MM-DD / Pending} | {Pending / Approved / Changes requested} | {link / Pending} |
+| L2 Operations | Operational scenarios, runbooks, OAT/DR ownership, Production windows and four-week OAT plan | {name / Pending} | {YYYY-MM-DD / Pending} | {Pending / Approved / Changes requested} | {link / Pending} |
+
 ## Test Plan Approval Gate
 
 - [ ] Every testing-profile row is represented and traced to REQ/NFR records
+- [ ] No standalone Integration Testing row is created; integration scenarios follow the Migration-Team-refactoring versus App-Team-UAT split, with UAT mandatory in either case
 - [ ] Every applicable test has scope, environment, entry/exit criteria, evidence and RACI
+- [ ] HA includes Section 7.2 goals, assessment, cases, PPE, monitoring/data, isolated window and signed exit evidence
+- [ ] DR includes Section 7.3 Production acceptance, L2/runbook ownership, dependency scenarios, RTA/RPA, failback, evidence and sign-off
 - [ ] Every exception has an approved human decision and linked risk treatment; UAT has no exception
 - [ ] Test preparation, execution, remediation, reporting and approval are scheduled in `plan.md`
+- [ ] Estimated elapsed timeline covers every applicable test type, 1/2/3-tester capacity, automation evidence, dependencies, overlaps, confidence and contingency
+- [ ] Optional lower-environment pre-OAT is separately identified and scheduled only after Migration and Application Teams agree scenario count and duration
+- [ ] Migration Team, Migration Testing Team, Application Team and L2 Operations have each approved this exact Test Plan version
+- [ ] Named deliverable approver approved this exact version after all four organizational approvals
 
 **Reviewed by**: {name} | **Date**: {YYYY-MM-DD} | **Outcome**: {Approved / Changes requested}
 <!-- This approval is completed only by the named human deliverable approver. -->
diff --git a/docs/testing-strategy/INDEX.md b/docs/testing-strategy/INDEX.md
index 95246b5..92a60c7 100644
--- a/docs/testing-strategy/INDEX.md
+++ b/docs/testing-strategy/INDEX.md
@@ -93,10 +93,61 @@ source revision that changes them requires review through `validate-testing-stra
 | Data migration verification | The strategy matrix marks it broadly while MVT and Backlog wording say "if applicable." | Required for every in-scope data movement. `Not Applicable` requires evidence that no application data, files, durable messages, or state are moved. If data moves and testing cannot be completed, use `Exception Proposed`, not N/A. |
 | Disaster recovery environment | The strategy requires Production before customer cutover; Backlog rows also name PPE/QA. | Production DR execution is the acceptance test. PPE/QA activities are additional rehearsals and cannot satisfy the production DR deliverable. |
 | Security versus penetration | The strategy separates general security testing in PPE from penetration testing in Production; some backlog labels are broader. | Maintain two distinct rows, plans, tasks, evidence sets, owners, and approvals. General security testing normally runs in PPE; penetration testing runs in Production. |
+| Integration testing classification | [Source Section 6.6.1](LMP-Migration-Testing-Strategy.md#functional-testing-change-based-functional-testinglimited-functional-testing-re-factor-only) defines Refactor functional testing as extending Re-Host/Re-Platform functional tests to cover interaction between unchanged and refactored components; it does not establish Integration Testing as an independent canonical test type. | Do not create a standalone Integration Testing row in the testing profile, architecture matrix, Test Plan, RACI, or task taxonomy. Include integration scenarios in Change-Based Functional Testing when the Migration Team performs refactoring (including refactoring activities within Re-Host/Re-Platform). Otherwise, keep integration scenarios within mandatory UAT, owned and executed by the Application Team. UAT remains mandatory in either case; do not duplicate or double-count the same scenario across categories. This classification rule does not remove the separate Integration Testing Complexity assessment of qualifying external standalone business/negative-path cases. |
+| Operational Acceptance Testing | The LMP strategy assigns OAT to Application Operations during Cutover in Production. The LSEG L2 Game Day catalog is a generic recommended scenario baseline with Production/DR and production-like examples, not proof that each scenario applies or is authorized for every app. | Use the [LSEG L2 OAT Game Day Scenario Catalog](LSEG-L2-OAT-Game-Day-Scenario-Catalog.md) with discovery/as-is evidence and the proposed Azure architecture. Disposition every catalog ID, map only evidenced Azure services, name operational outcomes and runbooks, and resolve environment, change approval, safety, ownership and evidence. The Architecture stage assesses applicability/testability; Planning turns selected cases into executable, scheduled OAT. Do not claim execution from the catalog or substitute OAT for HA/DR/UAT or other test obligations. |
 | UAT | The strategy explicitly forbids exemption. | UAT is Applicable for every R-Type. Missing cases, users, data, or environment are blocking readiness gaps, never N/A or an exception. |
 
 ## Automation interpretation
 
+Apply [Automation review and high-level scenario sizing](automation-review-and-scenario-sizing.md)
+through Requirements, Architecture, Planning and Analyze. Every test type needs an as-is review
+entry; missing evidence triggers an explicit Application Team review action, not a "no automation"
+assumption. None/Partial/Unknown coverage requires a provisional architecture scenario proposal
+and visible reuse/adapt/build effort. Assign activities from the extracted strategy's relevant
+sections and Appendix 5, including Section 4.1's one-sprint enablement boundary, rather than
+assuming the Migration Team creates or maintains every missing suite.
+
+The application profile is also the reusable evidence-intake and human-input layer. Register
+supplied plans, catalogs, linked workbooks/repositories, source inventories and run evidence with
+version/date/locator, scope, authority, access, applicability and freshness. Preserve source
+conflicts with competing claims and locators, governing rule, owner action and downstream impact;
+an uploaded plan does not supersede the LMP strategy or independently derived architecture.
+Record business facts only when supported by evidence or a validated human answer. Missing inputs
+remain visible, owned unknowns and do not prevent a useful Draft or Ready-for-Review proposal.
+
+Reuse the profile's shared human-input register for questions across requirements, architecture and
+planning; existing AUT follow-ups link to that action rather than creating duplicate rows or a new
+requirement namespace. Keep test-asset availability separate from reuse health: linked or
+framework-present assets are not verified until scope, compatible dated run/results and coverage
+are evidenced. In the Test Plan, preserve supplied case IDs and distinguish unique cases from
+families, grouped classifications and repeated runs. Outline proposed cases only from evidenced
+application behavior; otherwise retain an owned question/action.
+
+Architecture Section 14.4 maps evidenced source components, stores, interfaces and flows to
+Retain/Change/Replace/Retire decisions, state movement, affected and dependent unchanged behavior,
+requirements, families/supplied cases, coverage disposition and owner action. Reconcile duration
+estimates only when their start/end boundary, included/excluded phases and waits match; an L2 OAT
+window and full migration timeline are not conflicting merely because durations differ. Keep
+governing LMP recovery obligations independent from an example workbook's DR N/A or a workbook's
+proposed R-Type.
+
+Validation stages separate structure/readiness from execution approval. `Draft` permits owned
+unknown inputs; `ReadyForReview` establishes a reviewable proposal but not formal approval;
+`Execution` remains strict, requires the Approved Test Plan and existing approvals, and is the
+default for backward-compatible task-generation/prerequisite validation. Publication preserves the
+full source and honest status; it does not approve a draft or fail publication solely because
+evidence remains incomplete.
+
+Draft and document review defer production readiness and named appointments only when relevant
+profile actions own the unresolved dependencies, contacts/coordinators and needed-by gates.
+Execution still requires Ready architecture rows and named per-test approvers; contradictions and
+unsupported verified/approved claims remain errors in every stage. Lead the Test Plan with the
+concise linked Review Brief described in
+[the workflow guidance](automation-review-and-scenario-sizing.md#reader-first-review-path):
+proposed scope, material conflicts, prioritized human actions and the next version-specific gate
+first; detailed case mappings and supporting ledgers follow. Legacy Drafts warn if it is absent;
+ReadyForReview requires it. Publication preserves, rather than invents, this source-owned brief.
+
 The strategy requires maintained automation but does not prescribe one automation level for every
 test type. The framework applies the following minimum automation model unless application evidence
 or a human-approved exception requires a stricter treatment:
@@ -106,8 +157,8 @@ or a human-approved exception requires a stricter treatment:
 | Unit | Automated | Existing automated suites continue; migration-changed impacted code receives automated unit coverage in the approved CI/build pipeline. |
 | Connectivity | Automated | Approved and prohibited network, identity and service paths are exercised repeatably with machine-verifiable pass/fail evidence. |
 | Performance/load | Automated | Repeatable workload scripts, telemetry capture and threshold evaluation are versioned and executable through approved delivery controls. |
-| Integration | Semi-automated permitted | Automate repeatable setup, invocation and assertions where feasible; document any manual orchestration, observation or approval steps with an accountable owner. |
-| Smoke/regression and functional | Semi-automated permitted | Automate stable critical paths where feasible; retain versioned manual steps, expected results, evidence capture and named execution/approval ownership for the remainder. |
+| Integration scenarios within functional testing or UAT | Semi-automated permitted | Integration is scenario scope, not a standalone canonical test type. Place scenarios in Change-Based Functional Testing when the Migration Team refactors; otherwise include them in mandatory Application-Team UAT. Automate repeatable setup, invocation and assertions where feasible; document manual orchestration, observation or approval steps with an accountable owner. |
+| Smoke/regression and functional | Semi-automated permitted | Automate stable critical paths where feasible; retain versioned manual steps, expected results, evidence capture and named execution/approval ownership for the remainder. Change-Based Functional Testing includes integration coverage for refactored components and their unchanged dependencies. |
 
 `Semi-automated` does not mean unstructured manual testing. Every manual step remains reproducible,
 traceable to a requirement/case/defect, assigned through the application RACI, and represented in
@@ -126,6 +177,9 @@ manual coverage to the Migration Team or Application Team according to the appro
 | [5 Minimum Viable Testing](LMP-Migration-Testing-Strategy.md#minimum-viable-testing) | Governed fallback when specifications/cases are unavailable | Requirements, ADR/risk, planning |
 | [6 Functional Testing](LMP-Migration-Testing-Strategy.md#testing-functional) | Tool, unit, data, installation, connectivity, regression, Refactor/Rearchitect criteria | Requirements, architecture, planning |
 | [7 Non-Functional Testing](LMP-Migration-Testing-Strategy.md#testing-non-functional) | Performance, HA, DR, security, penetration, OAT | NFRs, architecture layers, planning |
+| [LSEG L2 OAT Game Day Scenario Catalog](LSEG-L2-OAT-Game-Day-Scenario-Catalog.md) | 24 Game Day, 9 standard-change, and 18 validation-only recommendations; use stable scenario IDs and application evidence | Architecture OAT applicability via `oat-scenario-design`; OAT scenario planning via `oat-scenario-planning`; operations runbooks |
+| [7.2 High Availability Testing](LMP-Migration-Testing-Strategy.md#high-availability-testing) | Application Owner assessment; HA goals; test-plan contents; PPE, tooling, monitoring, data, execution window, entry/exit criteria | Requirements, architecture resilience, planning, analysis |
+| [7.3 Disaster Recovery Testing](LMP-Migration-Testing-Strategy.md#disaster-recovery-testing) | Production DR execution, L2 ownership, runbook handover, scenarios, entry/exit criteria, failback, evidence and approval | Requirements, architecture resilience/transition, planning, analysis |
 | [8 UAT](LMP-Migration-Testing-Strategy.md#user-acceptance-testing-uat) | Mandatory business acceptance, entry/exit criteria | Requirements, transition, planning |
 | [9 Test Process](LMP-Migration-Testing-Strategy.md#test-process) | Management, execution, data, delays, acceptance | Planning, tasks |
 | [10 Exceptions](LMP-Migration-Testing-Strategy.md#test-exception-process) | Mandatory Decision work item and governance review | ADRs, risks, planning |
@@ -149,3 +203,12 @@ manual coverage to the Migration Team or Application Team according to the appro
   and human resolution; do not silently choose either source.
 - Apply the normative resolutions above before raising an application ADR. Raise an ADR only when
   the application proposes to deviate from the resolved rule or newer binding evidence conflicts.
+- For HA planning and assurance, consult [Section 7.2](LMP-Migration-Testing-Strategy.md#high-availability-testing)
+  and carry its owner assessment, approved goals, complete test plan, production-comparable PPE,
+  monitoring/data preparation, isolated execution window, and entry/exit evidence into the
+  requirements, architecture, and Test Plan.
+- For DR planning and assurance, consult [Section 7.3](LMP-Migration-Testing-Strategy.md#disaster-recovery-testing).
+  Production execution by the Application L2 Team before customer cutover is the acceptance test;
+  a lower-environment rehearsal is additional evidence only. Preserve runbook handover, dependency
+  failure scenarios, backup readiness, RTA/RPA against RTO/RPO, failback/normalization, defect
+  closure or approved risk acceptance, results evidence, and named approval.
diff --git a/docs/testing-strategy/LSEG-L2-OAT-Game-Day-Scenario-Catalog.md b/docs/testing-strategy/LSEG-L2-OAT-Game-Day-Scenario-Catalog.md
new file mode 100644
index 0000000..9d2242b
--- /dev/null
+++ b/docs/testing-strategy/LSEG-L2-OAT-Game-Day-Scenario-Catalog.md
@@ -0,0 +1,95 @@
+# LSEG L2 Game Day / OAT Scenario Catalog
+
+**Source**: User-provided LSEG L2 Operational Acceptance Testing (Game Day) scenario list, attributed in the supplied material to Kanishk Grover and last updated by Akhil Pillai on 2026-07-07.
+**Use**: Recommended scenario baseline for application-specific OAT design and planning. This catalog is a knowledge reference, not evidence that a scenario applies to, has been implemented for, or has passed for any particular application.
+**Source fidelity**: Scenario intent and expected outcomes are summarized for stable indexing. The supplied source's implementation notes, environment indicators, pipeline/job names, and statuses are not treated as current approvals or validated capabilities.
+
+## Application-specific use and safeguards
+
+Use the scenario catalog with the LMP Migration Testing Strategy's OAT requirement: the Application Operations Team performs OAT in Production during Cutover. The catalog recommends Production or Production-like Game Day execution and identifies Production/DR as possible tested environments. Resolve each scenario's allowed environment and change approval from current application policy; do not infer permission to disrupt Production or DR.
+
+For each source scenario, assess the actual as-is implementation and the proposed Azure target separately. Select a scenario only when evidence shows a relevant component, dependency, operational control, or business/service flow. Mark a conditional scenario as applicable only when its trigger is evidenced. Mark Not Applicable only with explicit evidence; record unknown component inventory or missing operational evidence as a readiness gap. Do not copy source statuses such as `OPEN`, `Yes`, `No`, `TBD`, or `Work in Progress` into an application's results or readiness claims.
+
+Every selected scenario needs application-specific steps, expected and actual outcomes, runbook/troubleshooting link, execution evidence, accountable and responsible roles, environment, safety/change approval, defect/SII/RAID links, and disposition. Use the named source identifiers below in the application OAT matrix. Add scenarios for actual application-specific risks not covered by this generic baseline.
+
+OAT is operational readiness validation; it does not replace or waive HA, DR, security, penetration, performance, connectivity, functional, or UAT testing. A scenario may share a technical mechanism with another test, but its objective, evidence, ownership, and acceptance must remain clear and must not be double-counted as separate work without justification.
+
+## Game Day scenarios
+
+The source organizes these 24 scenarios across reliability/resiliency, deployment/rollback, monitoring, and durability.
+
+| Source ID | Pillar / subject | Scenario intent and expected operational evidence |
+| --- | --- | --- |
+| `L2-OAT-GD-01` | Reliability — availability zone | Review IaC for single points of failure and simulate loss of a zone. Show the designed service remains highly available and has no unintended single point of failure. |
+| `L2-OAT-GD-02` | Reliability — virtual machines | Interrupt a VM during an in-flight user request and verify load-balancer failover, service recovery, atomic transaction outcome (succeed or fail), and a critical Operations alarm. |
+| `L2-OAT-GD-03` | Reliability — containers | Interrupt a container during an in-flight request; verify recovery, atomic transaction outcome, and a critical Operations alarm. The source calls out adding AKS disruption coverage. |
+| `L2-OAT-GD-04` | Reliability — serverless concurrency | Exceed configured concurrent-request limits. Verify the intended autoscale, throttling/denial, or abuse-protection behavior and associated critical alarm. |
+| `L2-OAT-GD-05` | Reliability — database zone failure | Interrupt the zone hosting the primary database during an in-flight request. Verify application recovery, atomic transaction outcome, no user-request errors in logs, and a warning Operations alarm. |
+| `L2-OAT-GD-06` | Reliability — stress/load | Raise then reduce concurrent requests. Verify scaling or protective denial/lockout behavior, critical alerting, actionable runbook instructions for rogue load, and correct regional routing for multi-region applications. |
+| `L2-OAT-GD-07` | Reliability — storage errors | Cause storage endpoint/internal errors using a controlled, configurable test. Verify bounded retries and a warning alarm. |
+| `L2-OAT-GD-08` | Reliability — messaging/region failure | Disrupt a region while requests use application messaging. Verify the designed alternate-region service handles requests; the source names Service Bus disruption jobs as examples. |
+| `L2-OAT-GD-09` | Reliability — third-party dependency | Simulate an unavailable third-party dependency. Verify agreed end-to-end behavior, expected logs, critical-alarm policy, and service health checks. |
+| `L2-OAT-GD-10` | Reliability — application smoke | Execute an application end-to-end smoke path. Verify the flow completes, logs contain no unexpected errors, critical alarms are absent, and service health checks are green. |
+| `L2-OAT-GD-11` | Reliability — AKS upgrade | Verify the AKS upgrade process and health outcomes. If the selected AKS pattern uses KMS/key encryption, include the applicable key-rotation process. |
+| `L2-OAT-GD-12` | Deployment — IaC drift | Run the IaC pipeline without code changes at OAT start and end. Verify the plan reports no unintended delta between declared IaC and deployed Azure resources. |
+| `L2-OAT-GD-13` | Deployment — production application | After production deployment, run the approved automated operational/application checks. Verify the application is fit for use, checks pass, health is green, and runbook deployment instructions are available. |
+| `L2-OAT-GD-14` | Monitoring — end-to-end SLO | Disrupt a critical client workflow sufficiently to breach its agreed SLO/SLI. Verify prompt critical alarms for the affected components and named critical workflows. |
+| `L2-OAT-GD-15` | Monitoring — upstream service levels | Disrupt an upstream dependency using a safe supported mechanism. Verify alarms when agreed upstream service metrics breach and the runbook identifies support contacts and service levels. |
+| `L2-OAT-GD-16` | Monitoring — server/container thresholds | Generate controlled CPU, disk-space, or memory threshold breaches. Verify the configured monitoring tool raises alarms at the documented priority. |
+| `L2-OAT-GD-17` | Monitoring — serverless thresholds | Exercise CPU, memory, or timeout thresholds where relevant. Verify alarms and priorities match the runbook. |
+| `L2-OAT-GD-18` | Monitoring — database backup | Validate the backup-failure alarm and confirm the backup schedule runs in the intended low-usage window. |
+| `L2-OAT-GD-19` | Monitoring — storage capacity | Cause or safely simulate a storage-capacity threshold breach. Verify the configured alert and its documented priority. |
+| `L2-OAT-GD-20` | Monitoring — logging | Exercise configured INFO/WARNING/ERROR/DEBUG behavior, verify disabled levels are not emitted, and confirm ERROR records are structured and meaningful. |
+| `L2-OAT-GD-21` | Monitoring — incident communications | Confirm incident communication practices are discussed, agreed, and usable by the participating teams. |
+| `L2-OAT-GD-22` | Monitoring — service limits/quotas | Stress an agreed account/service-limit threshold for an approved period. Verify the expected alarm is raised before or when the threshold is breached. |
+| `L2-OAT-GD-23` | Durability — database restore | Exercise point-in-time and backup restore for the selected database service. Record restore duration, verify restore success, and direct application test requests to the restored database. The source gives Azure SQL Database and Managed Instance jobs as examples, not universal service requirements. |
+| `L2-OAT-GD-24` | Durability — object restore | Verify object-level restore is configured and works for the selected storage service. |
+
+## Standard change scenarios
+
+The source categorizes these as scenarios requiring a normal change request, lead time, and appropriate approvals. Its table labels the environment as not Production/DR for these examples; the application owner and change authority must confirm the actual safe environment.
+
+| Source ID | Pillar / subject | Scenario intent and expected operational evidence |
+| --- | --- | --- |
+| `L2-OAT-CHG-01` | Deployment — infrastructure | Delete and recreate the application environment stack from its template (base infrastructure excluded). Verify deployment and health checks succeed, logs are clean, and template location is in the runbook. |
+| `L2-OAT-CHG-02` | Deployment — machine image | If self-managed compute is used, verify the approved LSEG golden image and infrastructure auto-refresh process. Treat source pipeline links/status as time-sensitive examples requiring current confirmation. |
+| `L2-OAT-CHG-03` | Deployment — database schema | Remove/recreate the test schema and deploy database changes from the approved template. Verify environment health and runbook instructions. |
+| `L2-OAT-CHG-04` | Rollback — infrastructure | Force or simulate a failed infrastructure deployment and execute documented rollback. Verify automated tests, health checks, and runbook instructions. |
+| `L2-OAT-CHG-05` | Deployment — blue/green application | Deploy a new version while the old one serves users. Confirm in-flight old-version requests finish before new-version traffic is accepted and automated operational checks pass. |
+| `L2-OAT-CHG-06` | Rollback — application | Simulate an application deployment failure. Verify rollback is operationally efficient and post-rollback application health checks pass. |
+| `L2-OAT-CHG-07` | Rollback — database | Simulate a failed database deployment and follow documented rollback/restore. The source describes Azure SQL restore-to-new-test-database examples; map to the chosen target database capability. |
+| `L2-OAT-CHG-08` | Scaling — vertical VM | Scale a VM up and back down using the approved IaC process. If direct scaling is not testable, the source suggests controlled CPU, memory, disk-I/O, and network-pressure experiments as an alternate operational check. |
+| `L2-OAT-CHG-09` | Scaling — storage capacity | Add disk capacity and extend applicable volumes (source examples include LVM). Verify automation, dependent services, low manual effort, and return to baseline without data loss. Select only when the target uses an applicable self-managed volume model. |
+
+## Validation-only scenarios
+
+These scenarios are checks, confirmations, or checklist exercises that do not inherently require a system change. Separate any actual fault injection or privilege change into its approved change scenario.
+
+| Source ID | Pillar / subject | Validation intent and expected evidence |
+| --- | --- | --- |
+| `L2-OAT-VAL-01` | ITDR — DR documentation | Verify DR capability/RTO documentation is current (the source mentions LeanIX), and recovery evidence has accurate timestamps to calculate RTA against RTO. |
+| `L2-OAT-VAL-02` | Security — encryption | Verify applicable infrastructure resources are encrypted in transit and at rest using approved compliance evidence. |
+| `L2-OAT-VAL-03` | Security — access management | Verify infrastructure write access is limited to authorized RE roles and production change/deployment access follows the approved SRE/PE support model. Track stale operator eligibility as an SII where required. |
+| `L2-OAT-VAL-04` | Security — group approvers | Verify required CloudOps approver groups can approve application/operator/JIT access and complete periodic reviews without disrupting support access. |
+| `L2-OAT-VAL-05` | Security — logging compliance | Verify log levels and observability records meet documented regulatory and application requirements. |
+| `L2-OAT-VAL-06` | Security — password rotation | Verify secrets are not hard-coded, rotation policy is active, and the approved LSEG password-management solution is used. |
+| `L2-OAT-VAL-07` | Security — certificates | Verify certificates are unique to application/environment, renewal is automated or expiry notification is timely, and ownership is explicit. |
+| `L2-OAT-VAL-08` | Security — third-party software | Verify production third-party components are vulnerability-scanned and appropriately licensed/open source, with no trial-only production dependency. |
+| `L2-OAT-VAL-09` | Cloud compliance — OPE | Verify One Policy Engine is integrated into application/infrastructure pipelines and reports are evaluated for critical/minor non-compliances; confirm whether approved BAS templates already provide the control. |
+| `L2-OAT-VAL-10` | Cloud compliance — Terraform module scan | Verify infrastructure pipelines scan module versions against current CPF guidance and check drift; confirm coverage from the currently approved BAS template rather than assuming it. |
+| `L2-OAT-VAL-11` | Cloud governance — tagging | Verify all applicable cloud resources have mandatory LSEG tags using approved tagging validation evidence. |
+| `L2-OAT-VAL-12` | Runbook — support documentation | Verify required Engineering, RE, and ASM runbook sections are complete and support/escalation contacts have current on-call/hotline details. The supplied checklist calls out API/backend monitoring, OaC, OAT automation, cost metrics, ServiceNow, quotas, monitor quality, zero-touch, Azure lights-off, and go-live readiness. |
+| `L2-OAT-VAL-13` | Operational overhead — manual activity | Inventory deployment/BAU manual work, minimize it, and raise RAID items for activities that cannot be automated with the technical constraint recorded. |
+| `L2-OAT-VAL-14` | CloudOps onboarding checklist | Validate each relevant checklist item: DXOne health checks; Datadog workflow; downtime scheduler; GitLab CI metrics; synthetic tests; API/backend monitoring; OaC; OAT automation; cost metrics; ServiceNow; quota report; monitor quality; zero-touch adoption; Azure lights-off; go-live checklist. |
+| `L2-OAT-VAL-15` | Monitoring — Datadog hygiene | Verify monitors do not flap or remain in No Data, production alert priorities are correctly tagged, and every alert has a clear resolution path. Use the current approved monitoring workflow. |
+| `L2-OAT-VAL-16` | Deficiencies — DML/technical debt | Verify application deficiencies/technical debt are documented and each required item has an associated SII; the source assigns DML accountability/responsibility to the App Team. |
+| `L2-OAT-VAL-17` | Vendor incidents — Azure account/subscription | Verify service-health/account outage detection and the documented Azure support engagement and incident recovery process. |
+| `L2-OAT-VAL-18` | Vendor incidents — third party | For each material third-party dependency, verify outage detection and the agreed incident/recovery protocol in the support runbook. |
+
+## Source interpretation notes
+
+- The supplied material is a reusable Game Day template with generic minimum recommendations. It explicitly encourages application-specific additions; it does not provide a ready-approved test plan for every app.
+- It contains scenario statuses and operational implementation notes that may be stale. Confirm current repos, jobs, supported Azure Chaos Studio experiments, LSEG tooling, access groups, policy, and support contacts before use.
+- Production/DR destructive or disruption scenarios require explicit authorization, impact boundaries, rollback/recovery readiness, monitoring, communications, and approved change windows. Use non-production or simulations when the production risk is not approved; record when that does not satisfy a mandatory production acceptance test.
+- LMP strategy OAT is owned/executed by Application Operations in Production during Cutover. The Migration Team supports, collates evidence, and addresses its assigned findings per the applicable RACI. Resolve Game Day-specific RACI and change authority with the application owner.
+- Exact Azure scenario mechanics must match the actual target resources. Do not translate a VM/LVM/SQL/Service Bus example into an Azure scenario unless that service is in the approved architecture.
diff --git a/docs/testing-strategy/automation-review-and-scenario-sizing.md b/docs/testing-strategy/automation-review-and-scenario-sizing.md
new file mode 100644
index 0000000..5c0562f
--- /dev/null
+++ b/docs/testing-strategy/automation-review-and-scenario-sizing.md
@@ -0,0 +1,204 @@
+# Automation review and high-level scenario sizing
+
+This is framework workflow guidance, not a change to the extracted LMP policy. Activity ownership
+comes from `LMP-Migration-Testing-Strategy.md`: Sections 2.2, 4, the relevant test section,
+and Appendix 5 RACI. The proposed split remains subject to human review.
+
+## Requirements: establish the as-is position with the Application Team
+
+Record one automation review entry per canonical test type in `requirements/testing-profile.md`.
+Use `Verified`, `Partial`, `None`, `Unknown`, or `Not Applicable`. Missing repository/discovery
+references mean **Unknown**, not **None**. A negative or partial answer needs a dated Application
+Team response; a framework name or discovered test file alone does not prove reusable automation.
+Evidence-backed N/A concerns test applicability, not missing automation.
+
+Register each supplied plan, catalog, workbook, source repository, test asset and run report with
+its version/date and exact locator, scope, authority, access, applicability and freshness. Classify
+each claim as source fact, proposed judgment, required human input, or approved decision. A supplied
+plan or workbook is evidence of what it states, not automatic authority over current LMP governance,
+the independently derived R-Type, or the target architecture. Preserve disagreements as explicit
+source conflicts with both claims/locators, affected scope, governing precedence rule, human owner,
+downstream impact and a linked action. Do not silently select one source or call missing evidence
+evidence of absence.
+
+For every Unknown, Partial or None entry, create a tracked review action with an Application Team
+contact, coordinating owner, needed-by gate/date and REQ/NFR plus risk/ADR trace. Ask for suite and
+script locations/versions, covered and uncovered scenarios, verified case counts, latest run
+results, pipeline execution, test data/baselines, framework/tool approval, maintenance capacity
+and handover ownership. Record the response/evidence or `Pending`; do not fabricate a reply.
+Follow up unresolved gaps before scope/effort is baselined. Verified entries retain evidence and
+the reuse assessment; partial coverage is never extrapolated to unverified scenarios.
+
+Use a shared Human Input and Decision Register in the profile for non-automation gaps and source
+conflicts as well. Local `ACT-###` references are trace links, not a new requirement namespace.
+An `AUT-##` follow-up is itself the action for its automation row; do not create a second ledger
+entry for the same question. Each open action names the exact question, reason, contact and
+coordinating owner, expected evidence/location, needed-by date or gate, affected records/assets,
+blocking impact, status and actual answer/evidence when received. Unanswered means Pending, never a
+guessed response. Do not require a separate ADR for every fact question; link one only when a
+decision or risk warrants it.
+
+Keep test-asset availability independent from reuse health: an asset may be reported or linked but
+unverified, verified available, unavailable, or unknown, while its use may separately be reuse,
+adapt, build, manual, excluded, or undecided. A successful, dated compatible run and coverage
+evidence—not a repository name, framework file, or general catalog—support verified reuse. Report
+zero verified cases when that is the evidence-backed count; do not convert unknown inventory into
+zero or a failure of document generation.
+
+## Architecture: propose reviewable scenario families
+
+Reconcile the actual source component/store/interface/flow and critical-behavior inventories with
+the target disposition (retain/change/replace/retire), data/state movement, impacted and dependent
+unchanged behavior, requirements, test family/case and evidence status in Architecture Section
+14.4. Every in-scope impact has Covered, Proposed, Excluded-with-rationale, or Pending disposition;
+Pending links the profile action. For retirement, check callers, consumers, data ownership,
+transition and rollback so the case inventory does not invent a target component. Do not fabricate
+source paths or infer business behavior from example catalogs.
+
+For each applicable/conditional type, outline a tailored family when actual application evidence
+supports it, particularly where automation is None, Partial or Unknown. A pending answer need not
+prevent an evidence-bounded proposal, but it prevents confirmed reuse. If behavior or inventory is
+not available, carry a named action instead of manufacturing a full case catalog. Preserve the
+profile action trace and distinguish verified assets from proposed work.
+
+Use stable scenario references, REQ/NFR and component/flow traces, measurable expected outcomes,
+environment and data prerequisites, automation approach (reuse/adapt/build/manual), proposed
+volume bands with a derivation and confidence, and implementation/execution/maintenance roles
+with exact strategy section/RACI references. Count families separately from detailed test cases;
+proposed counts are not verified inventory. Do not write detailed scripts or invent thresholds.
+
+| Test type | Candidate families to tailor to evidenced application scope |
+| --- | --- |
+| Connectivity | Allowed and denied user/service/component paths, identity and endpoint resolution |
+| Unit | Migration-changed units: success, boundary, error handling, mocks and regression; retain existing suites |
+| Data migration verification | Completeness, integrity, reconciliation, duplicates and replay for actual data movements |
+| Migration tool | Supported migration modes, permissions, failure handling and source-environment fitness |
+| Application installation | Deployment/configuration, dependencies, startup and post-deployment verification |
+| Smoke/regression | Critical journeys and unchanged behavior exposed to migration changes |
+| Change-based functional | Changed components and unchanged dependencies, including integration for Migration-Team refactoring |
+| Full functional | Rearchitect user stories and end-to-end positive/negative business flows |
+| Performance and baseline | Owner-selected latency, component/critical-flow/whole-app load, capacity, stress or endurance |
+| High availability | Applicable process/zone/dependency faults, failover, background load and recovery metrics |
+| Disaster recovery | Recovery, dependency-only failover, integrity, critical functions and failback/normalization |
+| Security testing | Applicable identity, authorization, configuration, code and vulnerability controls |
+| Security penetration testing | Authorized target attack surface; scope and execution reviewed with LSEG Security |
+| Operational acceptance testing | Reviewed L2 catalog scenarios; reference Section 14.2 without duplicating counts |
+| User acceptance testing | Application-Team business acceptance and integration when no Migration-Team refactoring occurs |
+
+These are candidate families, not universally mandated cases. Exclusions need applicability evidence.
+Keep Integration within functional testing/UAT. OAT, HA and DR retain distinct acceptance purposes,
+and Production-only testing requires its own authorization and safety controls.
+
+In the Test Plan, preserve supplied case IDs and source locators; use stable local IDs for proposed
+high-level outlines. Each case outline records origin, actual asset/component/flow and requirement
+trace, objective/preconditions/data/steps at a high level, measurable expected outcome, covered/
+adapt/proposed/excluded/pending disposition, environment/tool/automation, owner, evidence-result
+path and action. Do not call a proposed case executed or passed. Keep OAT catalog IDs in the OAT
+matrix and count them once. For an applicable type with no defensible outline, provide the action
+that identifies the missing evidence and blocks execution scope confirmation rather than inventing
+business behavior. Counts distinguish unique cases, scenario families, groups/classes and repeated
+runs; reconcile contradictory workbook/reference totals and do not count duplicated classifications
+as unique cases.
+
+### Unit and performance ownership boundaries
+
+Section 4.1 makes automation shared responsibility. When MEC prerequisites and Application Team
+maintenance capacity are met, Migration Team framework recommendation, two to three generic
+automated samples and knowledge transfer are limited to **one sprint**. Application Team adoption,
+continued coverage growth and maintenance are separate work. Do not assign creation of an entire
+missing legacy suite to Migration by default. Unmet prerequisites follow the Test Exception process.
+
+For unit tests (Section 6.2 and the INDEX normative resolution), Migration developers implement or
+extend tests only for migration-changed, impacted code. Application-wide legacy gaps need an
+Application Team decision and capacity, not automatic migration scope expansion.
+
+For performance (Section 7.1), the Application Owner determines testing level and supplies NFRs;
+LSEG supplies baseline metrics/scripts and test flows/assets. Migration Team assesses scope,
+validates baseline reproducibility and produces/adapts workload scripts and performs migration
+performance testing with Application support. Separate missing baseline acquisition, workload
+script creation/adaptation, data/telemetry setup and execution. Compare equal volumetrics; additional
+future-load tests are separate. Missing multiuser baseline uses the strategy's governed
+latency-measurement fallback, not invented load results or silently waived performance testing.
+
+## Planning: expose size, work and decisions without writing detailed cases
+
+The high-level Test Plan consumes the review ledger and Architecture Section 14.3. For each
+applicable test type, show scenario-family scope/count bands, verified reusable coverage and
+uncovered scope, reuse/adapt/build/manual decisions, and effort ranges in person-days for:
+scope/deep-dive review, automation implementation/adaptation, data/environment setup, execution,
+defect/retest and reporting/handover. Record no-build scope as zero with rationale.
+
+Identify ongoing maintenance capacity separately. Explain estimation drivers (units/flows,
+complexity, data sets, protocols, load profiles and run length), uncertainty and exclusions.
+Translate effort into the existing 1/2/3-tester elapsed ranges without linear compression of
+specialist, L2, environment or approval bottlenecks. Never assume tester capacity is developer or
+performance-engineer capacity; book those roles separately. Trace to backlog work and the four-party
+plan review. Migration and Application Teams deep-dive scope, effort and automation decisions;
+their review does not reassign L2/Security execution or waive the strategy's acceptance gates.
+
+Reconcile estimate reports by their explicit start/end boundaries, included/excluded phases,
+calendar, external waits, dependencies, case/asset basis, version and confidence. An L2 OAT window
+and end-to-end migration duration measure different scopes; do not force equality or inherit a
+single-region example's DR N/A. Keep R-Type sourced independently from the approved architecture
+and governing migration strategy; a conflicting workbook/plan becomes an owned source conflict,
+not an automatic architecture change. Separate evidence-based source constraints from proposed
+estimates, and re-estimate after approved scope changes.
+
+## Stage-aware readiness and honest reporting
+
+The Test Plan validator accepts `-ValidationStage Draft`, `ReadyForReview`, or `Execution`; omitting
+the parameter preserves strict Execution behavior for existing task-generation and prerequisite
+callers. Draft checks structure and traceability without claiming approval. ReadyForReview checks
+that the proposal and unresolved facts are reviewable and owned; it does not claim input completeness
+or formal approval. Only Execution requires an Approved plan, all four named/date/evidence-backed
+organizational approvals, the named overall human approval, and resolved execution-blocking inputs.
+An Approved status never relaxes any requirement. Existing prerequisite checks keep using the
+default strict stage before task generation.
+
+Architecture Section 14.1 `Conditional`/`Blocked` readiness is not a Draft or document-review
+failure when it has an ADR/risk and a relevant owned profile action. Link that action directly
+or through matching authoritative REQ/NFR/ADR/risk IDs; it must state the question, expected
+evidence/location, contact/accountable coordinator, needed-by gate, blocking impact and honest
+status. A generic unresolved dependency without that trace still fails. A pending per-test
+approver must identify the intended role/contact and an owned appointment/authority action;
+the coordinating role is not a human appointment. Only Execution requires `Ready` architecture
+readiness and named per-test approvers. Do not fabricate dates, appointments, answers or approval
+evidence to make a document review pass. Invalid readiness, contradictory applicability/traces,
+unsupported Verified/Approved/Closed claims and stage/status mismatches remain errors at every stage.
+
+Report two separate results: artifact quality relative to evidence available and input completeness
+(verified, unresolved, unavailable, or conflicting). A structurally sound proposal can be ready for
+human review while source facts remain open, but it is not execution-ready. Publication renders the
+complete source and its real status; it does not approve or silently reject a useful Draft because
+evidence is unavailable.
+
+## Reader-first review path
+
+Author a concise `## Review Brief` immediately after Test Plan metadata and before Test Strategy.
+Aim for one page: purpose and current maturity; proposed scope and exclusions; source/version
+evidence basis and confidence; artifact quality separately from input completeness; and the next
+human gate with the exact version/approval boundary. Say what reviewers are being asked to decide
+now and what is still blocked for execution. Counts are optional and must distinguish reported
+from verified inventory, unique cases from families/repeated runs, and unknown from zero; never
+invent a completeness percentage. Scope and timing proposals are not verified input or approval.
+
+Use `Significant Conflicts` and `Priority Human Actions` tables, each with at most five ranked
+items: priority/why now, a linked canonical CON or ACT/AUT record, its exact current status, and
+review focus/next step. Prioritize material scope/governance/acceptance conflicts and actions that
+unblock dependent decisions before downstream sizing or scheduling; not alphabetical/ID order,
+and not every question marked Critical. Include the needed decision, contact/accountable role,
+needed-by gate and impact through the linked canonical row, not a second copied register.
+Use `None — reason` when there are no significant items; link the full register for the remainder.
+
+Link directly to detailed scope/effort, high-level case mappings, assets, estimate boundaries,
+architecture impact crosswalk, all profile conflicts/human inputs and the approval gate. Keep
+supporting tables in their existing sections; the opening must not list the whole case catalog.
+Keep cross-file links repository-root-scoped or use controlled source URLs when authoring so the
+unchanged source body remains navigable from `deliverables/`; local section anchors work in both.
+Replace the template's feature-directory link placeholders with the actual owning feature.
+Reconcile brief status, scope, confidence and any counts against authoritative rows at every
+review. Existing Drafts without a brief warn rather than failing; ReadyForReview requires it.
+Legacy execution plans retain strict readiness/approval checks and a navigation migration warning.
+Publication copies the full canonical source, including its brief when present; it must not
+invent or independently update a brief in the published copy. Update the root, record the
+application change and republish; changed versions need fresh version-specific approval.
diff --git a/docs/testing-strategy/testing-strategy-contract.json b/docs/testing-strategy/testing-strategy-contract.json
index 75e1859..84077cf 100644
--- a/docs/testing-strategy/testing-strategy-contract.json
+++ b/docs/testing-strategy/testing-strategy-contract.json
@@ -5,7 +5,7 @@
   "markdownFile": "LMP-Migration-Testing-Strategy.md",
   "markdownSha256": "9255CB6C754FF1D37E8B9B87ED57EBA8F7D0CD1F95AFE8884EC9E0BD22B7DAF2",
   "indexFile": "INDEX.md",
-  "indexSha256": "2858196F4FCB3B414CBBCB1C42E4217703423E7BB1A88EF4820BC85D498DB6D5",
+  "indexSha256": "AA4724471120C3060A3BB8ED8549E143815A0B5369BEC72E624A2494BCFCC0EC",
   "counts": {
     "level1Headings": 16,
     "level2Headings": 45,
@@ -19,9 +19,25 @@
     "plan-testing",
     "Normative conflict resolutions",
     "Existing automated unit suites continue",
+    "7.2 High Availability Testing",
+    "7.3 Disaster Recovery Testing",
+    "HA planning and assurance",
+    "Production execution by the Application L2 Team",
     "Production DR execution is the acceptance test",
     "Security versus penetration",
-    "UAT is Applicable for every R-Type"
+    "Integration testing classification",
+    "Do not create a standalone Integration Testing row",
+    "UAT is Applicable for every R-Type",
+    "LSEG L2 OAT Game Day Scenario Catalog",
+    "24 Game Day, 9 standard-change, and 18 validation-only recommendations",
+    "Architecture OAT applicability via `oat-scenario-design`",
+    "OAT scenario planning via `oat-scenario-planning`",
+    "Automation review and high-level scenario sizing",
+    "explicit Application Team review action",
+    "reusable evidence-intake and human-input layer",
+    "Architecture Section 14.4",
+    "`Draft` permits owned",
+    "does not approve a draft or fail publication solely because"
   ],
   "media": [
     { "file": "image1.png", "sha256": "D109069972F0F1F7804D70A09EB33D06ABF3D010D6F2F06E0F460B74030C34C0" },
`````
