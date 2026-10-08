---
name: analyze-testing
description: "Independently validate migration testing coverage across requirements/testing-profile.md, architecture Section 14.1, G-test-plan.md, plan.md, tasks.md, ADRs, risks, evidence and approvals. USE FOR: testing traceability review, test-plan completeness, test gate validation, testing drift. Invoked by /speckit.analyze. Read-only."
argument-hint: "Invoked by /speckit.analyze with the complete application feature artifact chain"
---

# Analyze Skill: Migration Testing

Owns independent, read-only testing assurance across the complete feature chain. Do not repair
artifacts during this pass.

## Required Inputs

- `requirements/testing-profile.md` and every linked REQ/NFR record.
- `architecture.md` Sections 14.1-14.4, including migration impact-to-test crosswalks.
- Canonical `G-test-plan.md`, `plan.md`, and `tasks.md`.
- Linked ADR/risk records and available test evidence/approval metadata.
- `docs/testing-strategy/INDEX.md`, including normative conflict resolutions.
- Relevant extracted source sections, including Sections 7.2 (High Availability Testing) and 7.3
  (Disaster Recovery Testing), plus
  `docs/testing-strategy/LSEG-L2-OAT-Game-Day-Scenario-Catalog.md`.

## Plan → Act → Review

### Plan

Build one ledger keyed by canonical test type. Carry disposition, REQ/NFR, design section,
environment, mechanism, Test Plan row, scheduled work, five task tags, evidence, exception/risk,
and approval through the chain. Maintain a separate OAT ledger keyed by all 51 LSEG L2 catalog
scenario IDs; do not collapse scenario dispositions into or double-count them as test types.

### Act

Check:

1. Every canonical test type occurs exactly once in the profile, architecture matrix, and Test Plan.
2. Applicable/conditional rows have valid REQ/NFR records and target-design coverage.
3. No standalone Integration Testing type/row appears in the profile, architecture matrix, Test
   Plan, RACI, or task taxonomy. Integration scenarios are included in Change-Based Functional
   Testing when the Migration Team performs refactoring; otherwise they are included in mandatory
   Application-Team UAT. UAT remains applicable in either branch and scenario counts are not
   duplicated. The separate Integration Testing Complexity assessment is not a test-type row.
4. Unit testing preserves existing automated suites and limits Migration-Team additions/extensions
   to migration-changed impacted code.
5. Data migration testing follows actual data movement; N/A has evidence.
6. HA includes owner assessment and goals, planned scope/cases and pass-fail criteria, background
   load, PPE comparability/SII, tooling, monitoring, test data, safe execution window, entry/exit
   criteria, and signed results.
7. DR names Production acceptance before customer cutover, L2 execution, Migration Team runbook
   ownership/handover, plausible failure scenarios including dependency-only failover, entry
   readiness, RTA/RPA against RTO/RPO, integrity/accuracy/functionality, tested failback, defect
   disposition, retained results/evidence, and named approval. PPE/QA-only DR is a gap.
8. Security testing and penetration testing remain separate.
9. UAT remains applicable, scheduled, tasked, evidenced, and awaiting named human approval.
10. Every applicable Test Plan row has PREP, EXEC, REMEDIATE, EVIDENCE and APPROVAL task tags.
11. Every exception has a reviewed ADR and linked risk; no agent-authored acceptance exists.
12. Test Plan and test-deliverable approvals have names, dates, and outcomes only when performed.
13. Every LSEG L2 OAT catalog ID appears exactly once in Architecture Section 14.2 and the Test
    Plan; each Test Plan disposition matches the architecture assessment. Confirm each scenario has
    separate as-is evidence and proposed-Azure target rationale, maps only evidenced target
    capabilities, and does not treat unknown inventory or tooling as Not Applicable.
14. Recommended/conditional OAT cases have measurable operational outcomes, a feasible method,
    Production/Cutover ownership by Application Operations, runbook/evidence locations, and
    scheduled preparation, execution, remediation/retest, evidence and approval work. Non-applicable
    cases have evidence; blockers have an owner and closure path.
15. Production/DR-disruptive scenarios have explicit approved change authorization, bounded impact,
    communications, stop conditions and recovery readiness. Unauthorized or unsafe scenarios remain
    blocked; no planned case is represented as executed or passed without results evidence.
16. OAT remains operational-readiness assurance and does not substitute for HA, DR, UAT, or any
    other required test objective.
17. The estimated elapsed timeline contains each applicable test type, verified case-count and
    automation/manual basis, and 1/2/3-active-tester estimates; it separates effort, execution
    duration and external waits, explains confidence and bottlenecks, and reconciles critical path,
    parallelism and contingency with `plan.md`.
18. L2 Production OAT retains a four-calendar-week estimate unless current evidence supports a
    different duration. Optional lower-environment pre-OAT is distinct, marked optional, and has a
    jointly agreed Migration/Application scenario count and timeline; it does not reduce mandatory
    OAT scope.
19. Before Test Plan status is Approved, named, dated approvals for the exact plan version exist
    from Migration Team, Migration Testing Team, Application Team and L2 Operations. Pending or
    generic role-only acknowledgement does not count as approval; other required Security,
    business, change and Production authorizations remain separate.

Run the applicable repository validators and report any mismatch between validator results and
artifact claims as a Critical finding.

Also apply `docs/testing-strategy/automation-review-and-scenario-sizing.md`: every test type has
an Automation Availability Review entry, and Unknown/Partial/None has an owned, traced Application
Team follow-up. Negative/partial answers have dated response evidence; unknown remains unknown.
Applicable types have Section 14.3 high-level scenario families and Test Plan scope/automation
person-effort ranges distinct from elapsed time. Check reuse claims, proposed counts, review
actions and backlog traces reconcile. Validate role assignments against the exact LMP sections
and Appendix 5, especially one-sprint enablement, changed-unit scope, performance baseline/script
roles and Application Team maintenance; flag blanket Migration ownership of legacy coverage.
Check Section 14.4 source/target impact dispositions against actual component/flow evidence,
data/state movement, dependent behavior, requirement and scenario/case traces, coverage status,
and owner actions. Verify supplied case identifiers remain unique and separate from family,
classification and repeated-run counts. Reconcile estimates only when scope boundaries match.

### Review

Review the opening `Review Brief` before the supporting matrices. Confirm proposed scope/exclusions,
maturity, evidence confidence, separate quality/completeness and next gate/version boundary are
honest. Check at most five significant conflicts and five human actions are prioritized by risk
and dependency, link existing CON/ACT/AUT rows, and preserve their current statuses. Check any
counts against case/asset evidence; do not equate reported cases with verified reuse. Confirm
contact/coordinator, needed-by and impact resolve through the canonical register and navigation
reaches detailed cases, scope, assets, estimate boundaries, crosswalk and approvals.
Missing legacy Draft navigation is a migration warning; ReadyForReview requires it.
Do not flag honestly owned Conditional readiness or pending role appointments as failed document
review merely because they are not Execution-ready. Invalid/unowned dependencies, unsupported
Verified/Approved/Closed claims and real trace contradictions remain errors at every stage.

Return findings ordered by severity with exact artifact locations, broken trace links, and the
owning workflow pass for remediation. State clearly when all testing checks pass and identify any
residual evidence unavailable to the repository.
