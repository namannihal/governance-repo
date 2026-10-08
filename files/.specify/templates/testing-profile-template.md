# Migration Testing Requirements Profile: {Application Name}

**Feature branch**: `{###-app-slug}` | **Date**: {YYYY-MM-DD} | **Status**: Draft

> This is the authoritative application testing applicability profile. Every strategy test type
> has one disposition and links ordinary `REQ-###`/`NFR-###` records. Missing assets, owners,
> environments, or evidence are readiness gaps, not reasons to omit a mandatory test.

## Testing Requirements Profile

| Test Type | Baseline Applicability | Disposition | R-Type / Scope Condition | Requirement IDs | Required Outcome / Measurable Target | Expected Environment | Evidence / Rationale | Execution Owner | Approval Owner | Linked ADR/Risk |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Connectivity | Required | Unknown | All migrations; cover users, systems and internal components | {REQ/NFR or None yet} | {positive/negative paths and pass criteria} | {PPE/QA/other approved environment} | {source/gap} | {role/team} | {role/team} | {ADR/RSK} |
| Unit | Conditional | Unknown | Continue existing automated suites for all migrations; Migration Team implements or extends unit tests only for code changed during migration and only for impacted code | {REQ/NFR or None yet} | {existing suite remains passing; changed code has approved coverage/pass target} | CI/build pipeline; DEV only when the approved delivery design uses DEV execution | {source/gap} | {role/team} | {role/team} | {ADR/RSK} |
| Data migration verification | Conditional | Unknown | Required for every in-scope data movement; Not Applicable only when evidence proves no data moves | {REQ/NFR or None yet} | {completeness, integrity, security and reconciliation tolerance} | {rehearsal/migration environment} | {source/gap} | {role/team} | {role/team} | {ADR/RSK} |
| Migration tool | Required | Unknown | All migrations | {REQ/NFR or None yet} | {tool fitness and source-environment validation} | {source/test environment} | {source/gap} | {role/team} | {role/team} | {ADR/RSK} |
| Application installation | Required | Unknown | All migrations | {REQ/NFR or None yet} | {deployment/configuration and post-deployment verification} | {target non-production environment} | {source/gap} | {role/team} | {role/team} | {ADR/RSK} |
| Smoke/regression | Required | Unknown | All migrations; depth is application- and change-risk-specific | {REQ/NFR or None yet} | {critical/common behavior and regression pass threshold} | PPE or approved equivalent | {source/gap} | {role/team} | {role/team} | {ADR/RSK} |
| Change-based functional | Conditional | Unknown | Re-Factor, or Re-Host/Re-Platform when the Migration Team performs refactoring that affects dependent behavior; include interaction tests for changed/refactored and dependent unchanged components | {REQ/NFR or None yet} | {changed and dependent unchanged behavior, including integration scenarios, passes} | PPE or approved equivalent | {source/gap; when no Migration-Team refactoring occurs, integration scenarios remain in mandatory App-Team UAT} | {Migration Team for its refactoring; otherwise integration scenarios are owned by LSEG Application Team in UAT} | {role/team} | {ADR/RSK} |
| Full functional | Conditional | Unknown | Rearchitect | {REQ/NFR or None yet} | {user-story and end-to-end behavior passes} | {approved integrated environment} | {source/gap} | {role/team} | {role/team} | {ADR/RSK} |
| Performance and baseline | Required | Unknown | All migrations; level may fall back to latency measurement when governed baseline evidence is unavailable | {REQ/NFR or None yet} | {equal-volumetric comparison, NFRs and tolerable variance} | Production-representative PPE | {source/gap} | {role/team} | {role/team} | {ADR/RSK} |
| High availability | Required | Unknown | All migrations; follow strategy Section 7.2 and approved HA design; Application Owner assesses R-Type, failover mechanisms, redundancy, load balancing and resiliency | {REQ/NFR or None yet} | {approved uptime/SLA, RTO/RPO, redundancy/failover, scalability, resource-utilization, data-loss and degradation goals} | Production-representative PPE; isolated execution window | {Section 7.2 evidence: signed HA plan, cases/pass-fail/background load, PPE/SII, tooling, monitoring, data, entry/exit/results} | {role/team} | {role/team} | {ADR/RSK} |
| Disaster recovery | Required | Unknown | All migrations; follow strategy Section 7.3; LSEG Application L2 executes Production acceptance before customer cutover; lower-environment runs are rehearsal only | {REQ/NFR or None yet} | {RTA/RPA meet approved RTO/RPO; integrity, accuracy, critical functionality, failback and normalization pass} | Production for acceptance; lower environments for rehearsal only | {Section 7.3 evidence: runbook/handover, scenarios, entry readiness, backup/data/tools, results report, defects and sign-off} | {LSEG Application L2 / Migration Team support} | {role/team} | {ADR/RSK} |
| Security testing | Required | Unknown | All migrations; control/scanning/review scope follows applicable security requirements | {REQ/NFR or None yet} | {applicable controls pass; findings meet approved threshold} | PPE except explicitly approved production checks | {source/gap} | {role/team} | {role/team} | {ADR/RSK} |
| Security penetration testing | Required | Unknown | All migrations unless a human-approved Test Exception establishes non-applicability | {REQ/NFR or None yet} | {Critical/High findings remediated or formally accepted} | Production | {source/gap} | LSEG Security Team | {role/team} | {ADR/RSK} |
| Operational acceptance testing | Required | Unknown | All migrations; use the LSEG L2 OAT Game Day catalog as a recommended baseline and assess scenarios against evidenced as-is services and proposed target architecture; LMP strategy execution is by Application Operations in Production during Cutover | {REQ/NFR or None yet} | {applicable, evidence-based OAT scenario outcomes, operational health/alert/runbook/recovery checks, and named sign-off} | Production during Cutover per strategy; production-like/DR only where scenario policy and approvals allow | {L2-OAT catalog IDs, as-is/target applicability evidence, safety/change approval, operations ownership, runbook and evidence path} | LSEG Application Operations | {role/team} | {ADR/RSK} |
| User acceptance testing | Required | Unknown | All migrations; no exemption. Includes integration scenarios when the Migration Team has not performed refactoring; Application Team owns and executes those business-service integration cases. UAT remains mandatory even when refactoring integration is covered by Change-Based Functional Testing. | {REQ/NFR or None yet} | {business scenarios, applicable integration scenarios, defect threshold and sign-off; avoid duplicate case counts} | PPE or approved business-acceptance environment | {source/gap} | LSEG Application Team | {role/team} | N/A |

Allowed dispositions are `Applicable`, `Conditionally Applicable`, `Not Applicable`,
`Exception Proposed`, and `Unknown`. `Not Applicable` is valid only for a conditional baseline
whose condition is proven false. A required baseline can be omitted only as `Exception Proposed`
with a Proposed ADR and linked risk; UAT can never use either disposition.

## Evidence Sources and Conflicts

Register supplied plans, catalogs, workbooks, case repositories, run reports, source-code
inventories, and links as evidence. A locator or file presence establishes availability only; it
does not prove applicability, freshness, coverage, or reuse. Distinguish sourced facts, proposed
judgments, unanswered human inputs, and approved decisions. Record competing claims separately
and use the governing authority/precedence rule rather than preferring the newest or most detailed
uploaded plan automatically.

| Source ID | Artifact / Version / Date | Exact Locator | Claim / Scope | Evidence Class | Authority / Governing Rule | Access / Applicability / Freshness | Conflict / Action ID |
| --- | --- | --- | --- | --- | --- | --- | --- |
| SRC-001 | {artifact/version/date or Unknown} | {page/section/path/row/case IDs} | {specific claim and affected scope} | {Sourced fact / Proposed judgment / Human input / Approved decision} | {governing source and precedence, or action needed} | {accessible/unverified; scope and freshness} | {None or ACT-###} |

| Conflict ID | Competing Claims and Source IDs / Locators | Affected Scope | Governing Rule (not assumed source precedence) | Decision Owner / Action ID | Status | Downstream Impact |
| --- | --- | --- | --- | --- | --- | --- |
| CON-001 | {claim A SRC-### locator; claim B SRC-### locator} | {test type, flow, asset or estimate} | {approved governance/architecture source or unresolved} | {role and ACT-###} | {Open / Resolved with evidence} | {scope, test, schedule or decision affected} |

## Test Asset Inventory

Keep asset availability separate from its reuse health. `Reported/linked` and
`Available-unverified` are not verified automation. Record actual identifiers and versions when
supplied; framework presence alone is not a run result. Use the shared Human Input and Decision
Register for verification follow-up rather than duplicating actions here.

| Asset ID | Asset Type / Supplied Case IDs | Version / Locator / Owner | Reported Availability | Reuse Health | Coverage / Related Families | Latest Run / Result Evidence | Applicability / Compatibility | Validation Action ID |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| AST-001 | {plan, catalog, repo, case IDs, scripts, results, baseline, data or environment} | {version/location/owner or Unknown} | {Reported-linked / Available-unverified / Verified-available / Unavailable / Unknown} | {Reuse / Adapt / Build / Manual / Excluded / Undecided} | {verified coverage and gaps; do not infer counts} | {dated run/report locator or Not run} | {applicability and target fit evidence or Unknown} | {ACT-### or N/A with reason} |

## Human Input and Decision Register

Use stable local `ACT-###` references; this is not a new requirement namespace. Reuse `AUT-###`
as the action reference for an existing automation follow-up rather than creating a duplicate
action. Questions do not become facts until an answer and its evidence are recorded and validated.
Open actions may remain in a Draft or reviewable proposal when an accountable owner, expected
evidence, needed-by gate/date, and impact are explicit.

| Action ID | Exact Question / Decision / Conflict to Resolve | Why Needed / Evidence Expected and Location | Contact / Accountable Coordinator | Needed By / Gate | Linked REQ/NFR / ADR / Risk / Flow / Asset | Blocking Impact | Status | Answer / Evidence / Validation |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| ACT-001 | {specific question; use AUT-## for its existing follow-up} | {reason and expected evidence/location} | {contact role/person and coordinating owner} | {date or named gate; state if date is unknown} | {existing IDs, or None} | {decision/test/schedule affected} | {Requested / Answered-unvalidated / Validated / Closed} | {actual answer/evidence locator or Pending} |

## Automation Availability Review

Apply `docs/testing-strategy/automation-review-and-scenario-sizing.md`. One entry per canonical
test type; `Unknown` means unverified, not absent. `None`/`Partial` require a dated Application
Team answer/evidence. Unknown/Partial/None require an Application Team follow-up action, contact,
coordinating owner, needed-by gate/date and REQ/NFR plus ADR/risk trace. Ask about repositories,
covered/uncovered scenarios, verified counts, run history, pipeline, data/baselines and maintenance
capacity. Do not claim Verified from framework names. N/A requires applicability evidence.

| Review ID | Test Type | Automation Status | Evidence / Application Team Response | Verified Coverage / Uncovered Scope | Application Team Review Action ID / Contact / Owner / Needed By / Status | Requirement / ADR / Risk |
| --- | --- | --- | --- | --- | --- | --- |
| AUT-01 | Connectivity | Unknown | {Pending answer; evidence location/date} | {verified count and gaps} | {AUT-01 action/contact/coordinator/gate/status} | {REQ/NFR + ADR/RSK} |
| AUT-02 | Unit | Unknown | {Pending answer; evidence location/date} | {existing suites and migration-changed units} | {AUT-02 action/contact/coordinator/gate/status} | {REQ/NFR + ADR/RSK} |
| AUT-03 | Data migration verification | Unknown | {Pending answer; evidence location/date} | {verified count and gaps} | {AUT-03 action/contact/coordinator/gate/status} | {REQ/NFR + ADR/RSK} |
| AUT-04 | Migration tool | Unknown | {Pending answer; evidence location/date} | {verified count and gaps} | {AUT-04 action/contact/coordinator/gate/status} | {REQ/NFR + ADR/RSK} |
| AUT-05 | Application installation | Unknown | {Pending answer; evidence location/date} | {verified count and gaps} | {AUT-05 action/contact/coordinator/gate/status} | {REQ/NFR + ADR/RSK} |
| AUT-06 | Smoke/regression | Unknown | {Pending answer; evidence location/date} | {verified count and gaps} | {AUT-06 action/contact/coordinator/gate/status} | {REQ/NFR + ADR/RSK} |
| AUT-07 | Change-based functional | Unknown | {Pending answer; evidence location/date} | {verified count and gaps} | {AUT-07 action/contact/coordinator/gate/status} | {REQ/NFR + ADR/RSK} |
| AUT-08 | Full functional | Unknown | {Pending answer; evidence location/date} | {verified count and gaps} | {AUT-08 action/contact/coordinator/gate/status} | {REQ/NFR + ADR/RSK} |
| AUT-09 | Performance and baseline | Unknown | {Pending answer; baseline/script evidence/date} | {workloads, baseline validity, reusable/uncovered scripts} | {AUT-09 action/contact/coordinator/gate/status} | {REQ/NFR + ADR/RSK} |
| AUT-10 | High availability | Unknown | {Pending answer; evidence location/date} | {verified count and gaps} | {AUT-10 action/contact/coordinator/gate/status} | {REQ/NFR + ADR/RSK} |
| AUT-11 | Disaster recovery | Unknown | {Pending answer; evidence location/date} | {verified count and gaps} | {AUT-11 action/contact/coordinator/gate/status} | {REQ/NFR + ADR/RSK} |
| AUT-12 | Security testing | Unknown | {Pending answer; evidence location/date} | {verified count and gaps} | {AUT-12 action/contact/coordinator/gate/status} | {REQ/NFR + ADR/RSK} |
| AUT-13 | Security penetration testing | Unknown | {Pending answer; evidence location/date} | {verified count and gaps} | {AUT-13 action/contact/coordinator/gate/status} | {REQ/NFR + ADR/RSK} |
| AUT-14 | Operational acceptance testing | Unknown | {Pending answer; evidence location/date} | {verified catalog coverage and gaps} | {AUT-14 action/contact/coordinator/gate/status} | {REQ/NFR + ADR/RSK} |
| AUT-15 | User acceptance testing | Unknown | {Pending answer; evidence location/date} | {verified count and gaps} | {AUT-15 action/contact/coordinator/gate/status} | {REQ/NFR + ADR/RSK} |

## Test Readiness Inputs

| Readiness Area | Status | Required Evidence / Outcome | Owner | Requirement / ADR / Risk |
| --- | --- | --- | --- | --- |
| Existing test plans, cases, scripts and results | Unknown | {versioned inventory and reuse assessment} | {role/team} | {REQ/ADR/RSK} |
| Automation repositories and maintenance capacity | Unknown | {repository, ownership, pipeline and maintenance evidence} | {role/team} | {REQ/NFR/ADR/RSK} |
| Performance baseline and volumetrics | Unknown | {freshness, reproducibility, workload and comparison evidence} | {role/team} | {NFR/ADR/RSK} |
| Test environments and production comparability | Unknown | {region/topology/size/configuration comparison} | {role/team} | {NFR/ADR/RSK} |
| Monitoring and evidence capture | Unknown | {telemetry, reports, repository and retention} | {role/team} | {REQ/NFR/ADR/RSK} |
| Test data, identities, access and privacy controls | Unknown | {representative/versioned data and approved controls} | {role/team} | {REQ/NFR/ADR/RSK} |
| Defect thresholds, triage and risk acceptance | Unknown | {severity/priority, exit threshold and authority} | {role/team} | {REQ/NFR/ADR/RSK} |
| Named test execution and deliverable approvers | Unknown | {application roles and authorized approvers} | {role/team} | {REQ/ADR/RSK} |

## Review Gate

- [ ] Every test type has one valid disposition and cited rationale
- [ ] Every Applicable or Conditionally Applicable row links at least one REQ/NFR
- [ ] Every Not Applicable row proves a conditional baseline does not apply
- [ ] Every Exception Proposed row links a Proposed ADR and Identified risk
- [ ] UAT is Applicable and cannot be exempted
- [ ] Unit testing follows the migration-change rule and preserves existing automated suites
- [ ] Integration is not a standalone test type: Migration-Team refactoring is covered by Change-Based Functional Testing; otherwise integration scenarios are included in mandatory Application-Team UAT
- [ ] Security testing and penetration testing remain separate
- [ ] HA disposition and evidence follow strategy Section 7.2, including owner assessment, approved goals, PPE, monitoring/data, entry/exit, and results
- [ ] DR acceptance is planned for Production; lower-environment DR is rehearsal only
- [ ] DR disposition and evidence follow strategy Section 7.3, including L2 execution, runbook handover, dependency scenarios, RTA/RPA, failback, defects, and sign-off
- [ ] OAT outcomes consider the LSEG L2 Game Day catalog; applicability is evidence-based, not assumed universal, and Application Operations owns Production Cutover acceptance
- [ ] Every Unknown and readiness gap names an owner and ADR/risk where progression is blocked
- [ ] Each test type has an automation review entry; unanswered/partial/absent coverage has a tracked Application Team follow-up and dated answers are evidence-backed

**Reviewed by**: {name} | **Date**: {YYYY-MM-DD} | **Outcome**: {Approved / Changes requested}
