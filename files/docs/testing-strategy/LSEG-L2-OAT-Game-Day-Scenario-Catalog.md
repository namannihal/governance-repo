# LSEG L2 Game Day / OAT Scenario Catalog

**Source**: User-provided LSEG L2 Operational Acceptance Testing (Game Day) scenario list, attributed in the supplied material to Kanishk Grover and last updated by Akhil Pillai on 2026-07-07.
**Use**: Recommended scenario baseline for application-specific OAT design and planning. This catalog is a knowledge reference, not evidence that a scenario applies to, has been implemented for, or has passed for any particular application.
**Source fidelity**: Scenario intent and expected outcomes are summarized for stable indexing. The supplied source's implementation notes, environment indicators, pipeline/job names, and statuses are not treated as current approvals or validated capabilities.

## Application-specific use and safeguards

Use the scenario catalog with the LMP Migration Testing Strategy's OAT requirement: the Application Operations Team performs OAT in Production during Cutover. The catalog recommends Production or Production-like Game Day execution and identifies Production/DR as possible tested environments. Resolve each scenario's allowed environment and change approval from current application policy; do not infer permission to disrupt Production or DR.

For each source scenario, assess the actual as-is implementation and the proposed Azure target separately. Select a scenario only when evidence shows a relevant component, dependency, operational control, or business/service flow. Mark a conditional scenario as applicable only when its trigger is evidenced. Mark Not Applicable only with explicit evidence; record unknown component inventory or missing operational evidence as a readiness gap. Do not copy source statuses such as `OPEN`, `Yes`, `No`, `TBD`, or `Work in Progress` into an application's results or readiness claims.

Every selected scenario needs application-specific steps, expected and actual outcomes, runbook/troubleshooting link, execution evidence, accountable and responsible roles, environment, safety/change approval, defect/SII/RAID links, and disposition. Use the named source identifiers below in the application OAT matrix. Add scenarios for actual application-specific risks not covered by this generic baseline.

OAT is operational readiness validation; it does not replace or waive HA, DR, security, penetration, performance, connectivity, functional, or UAT testing. A scenario may share a technical mechanism with another test, but its objective, evidence, ownership, and acceptance must remain clear and must not be double-counted as separate work without justification.

## Game Day scenarios

The source organizes these 24 scenarios across reliability/resiliency, deployment/rollback, monitoring, and durability.

| Source ID | Pillar / subject | Scenario intent and expected operational evidence |
| --- | --- | --- |
| `L2-OAT-GD-01` | Reliability — availability zone | Review IaC for single points of failure and simulate loss of a zone. Show the designed service remains highly available and has no unintended single point of failure. |
| `L2-OAT-GD-02` | Reliability — virtual machines | Interrupt a VM during an in-flight user request and verify load-balancer failover, service recovery, atomic transaction outcome (succeed or fail), and a critical Operations alarm. |
| `L2-OAT-GD-03` | Reliability — containers | Interrupt a container during an in-flight request; verify recovery, atomic transaction outcome, and a critical Operations alarm. The source calls out adding AKS disruption coverage. |
| `L2-OAT-GD-04` | Reliability — serverless concurrency | Exceed configured concurrent-request limits. Verify the intended autoscale, throttling/denial, or abuse-protection behavior and associated critical alarm. |
| `L2-OAT-GD-05` | Reliability — database zone failure | Interrupt the zone hosting the primary database during an in-flight request. Verify application recovery, atomic transaction outcome, no user-request errors in logs, and a warning Operations alarm. |
| `L2-OAT-GD-06` | Reliability — stress/load | Raise then reduce concurrent requests. Verify scaling or protective denial/lockout behavior, critical alerting, actionable runbook instructions for rogue load, and correct regional routing for multi-region applications. |
| `L2-OAT-GD-07` | Reliability — storage errors | Cause storage endpoint/internal errors using a controlled, configurable test. Verify bounded retries and a warning alarm. |
| `L2-OAT-GD-08` | Reliability — messaging/region failure | Disrupt a region while requests use application messaging. Verify the designed alternate-region service handles requests; the source names Service Bus disruption jobs as examples. |
| `L2-OAT-GD-09` | Reliability — third-party dependency | Simulate an unavailable third-party dependency. Verify agreed end-to-end behavior, expected logs, critical-alarm policy, and service health checks. |
| `L2-OAT-GD-10` | Reliability — application smoke | Execute an application end-to-end smoke path. Verify the flow completes, logs contain no unexpected errors, critical alarms are absent, and service health checks are green. |
| `L2-OAT-GD-11` | Reliability — AKS upgrade | Verify the AKS upgrade process and health outcomes. If the selected AKS pattern uses KMS/key encryption, include the applicable key-rotation process. |
| `L2-OAT-GD-12` | Deployment — IaC drift | Run the IaC pipeline without code changes at OAT start and end. Verify the plan reports no unintended delta between declared IaC and deployed Azure resources. |
| `L2-OAT-GD-13` | Deployment — production application | After production deployment, run the approved automated operational/application checks. Verify the application is fit for use, checks pass, health is green, and runbook deployment instructions are available. |
| `L2-OAT-GD-14` | Monitoring — end-to-end SLO | Disrupt a critical client workflow sufficiently to breach its agreed SLO/SLI. Verify prompt critical alarms for the affected components and named critical workflows. |
| `L2-OAT-GD-15` | Monitoring — upstream service levels | Disrupt an upstream dependency using a safe supported mechanism. Verify alarms when agreed upstream service metrics breach and the runbook identifies support contacts and service levels. |
| `L2-OAT-GD-16` | Monitoring — server/container thresholds | Generate controlled CPU, disk-space, or memory threshold breaches. Verify the configured monitoring tool raises alarms at the documented priority. |
| `L2-OAT-GD-17` | Monitoring — serverless thresholds | Exercise CPU, memory, or timeout thresholds where relevant. Verify alarms and priorities match the runbook. |
| `L2-OAT-GD-18` | Monitoring — database backup | Validate the backup-failure alarm and confirm the backup schedule runs in the intended low-usage window. |
| `L2-OAT-GD-19` | Monitoring — storage capacity | Cause or safely simulate a storage-capacity threshold breach. Verify the configured alert and its documented priority. |
| `L2-OAT-GD-20` | Monitoring — logging | Exercise configured INFO/WARNING/ERROR/DEBUG behavior, verify disabled levels are not emitted, and confirm ERROR records are structured and meaningful. |
| `L2-OAT-GD-21` | Monitoring — incident communications | Confirm incident communication practices are discussed, agreed, and usable by the participating teams. |
| `L2-OAT-GD-22` | Monitoring — service limits/quotas | Stress an agreed account/service-limit threshold for an approved period. Verify the expected alarm is raised before or when the threshold is breached. |
| `L2-OAT-GD-23` | Durability — database restore | Exercise point-in-time and backup restore for the selected database service. Record restore duration, verify restore success, and direct application test requests to the restored database. The source gives Azure SQL Database and Managed Instance jobs as examples, not universal service requirements. |
| `L2-OAT-GD-24` | Durability — object restore | Verify object-level restore is configured and works for the selected storage service. |

## Standard change scenarios

The source categorizes these as scenarios requiring a normal change request, lead time, and appropriate approvals. Its table labels the environment as not Production/DR for these examples; the application owner and change authority must confirm the actual safe environment.

| Source ID | Pillar / subject | Scenario intent and expected operational evidence |
| --- | --- | --- |
| `L2-OAT-CHG-01` | Deployment — infrastructure | Delete and recreate the application environment stack from its template (base infrastructure excluded). Verify deployment and health checks succeed, logs are clean, and template location is in the runbook. |
| `L2-OAT-CHG-02` | Deployment — machine image | If self-managed compute is used, verify the approved LSEG golden image and infrastructure auto-refresh process. Treat source pipeline links/status as time-sensitive examples requiring current confirmation. |
| `L2-OAT-CHG-03` | Deployment — database schema | Remove/recreate the test schema and deploy database changes from the approved template. Verify environment health and runbook instructions. |
| `L2-OAT-CHG-04` | Rollback — infrastructure | Force or simulate a failed infrastructure deployment and execute documented rollback. Verify automated tests, health checks, and runbook instructions. |
| `L2-OAT-CHG-05` | Deployment — blue/green application | Deploy a new version while the old one serves users. Confirm in-flight old-version requests finish before new-version traffic is accepted and automated operational checks pass. |
| `L2-OAT-CHG-06` | Rollback — application | Simulate an application deployment failure. Verify rollback is operationally efficient and post-rollback application health checks pass. |
| `L2-OAT-CHG-07` | Rollback — database | Simulate a failed database deployment and follow documented rollback/restore. The source describes Azure SQL restore-to-new-test-database examples; map to the chosen target database capability. |
| `L2-OAT-CHG-08` | Scaling — vertical VM | Scale a VM up and back down using the approved IaC process. If direct scaling is not testable, the source suggests controlled CPU, memory, disk-I/O, and network-pressure experiments as an alternate operational check. |
| `L2-OAT-CHG-09` | Scaling — storage capacity | Add disk capacity and extend applicable volumes (source examples include LVM). Verify automation, dependent services, low manual effort, and return to baseline without data loss. Select only when the target uses an applicable self-managed volume model. |

## Validation-only scenarios

These scenarios are checks, confirmations, or checklist exercises that do not inherently require a system change. Separate any actual fault injection or privilege change into its approved change scenario.

| Source ID | Pillar / subject | Validation intent and expected evidence |
| --- | --- | --- |
| `L2-OAT-VAL-01` | ITDR — DR documentation | Verify DR capability/RTO documentation is current (the source mentions LeanIX), and recovery evidence has accurate timestamps to calculate RTA against RTO. |
| `L2-OAT-VAL-02` | Security — encryption | Verify applicable infrastructure resources are encrypted in transit and at rest using approved compliance evidence. |
| `L2-OAT-VAL-03` | Security — access management | Verify infrastructure write access is limited to authorized RE roles and production change/deployment access follows the approved SRE/PE support model. Track stale operator eligibility as an SII where required. |
| `L2-OAT-VAL-04` | Security — group approvers | Verify required CloudOps approver groups can approve application/operator/JIT access and complete periodic reviews without disrupting support access. |
| `L2-OAT-VAL-05` | Security — logging compliance | Verify log levels and observability records meet documented regulatory and application requirements. |
| `L2-OAT-VAL-06` | Security — password rotation | Verify secrets are not hard-coded, rotation policy is active, and the approved LSEG password-management solution is used. |
| `L2-OAT-VAL-07` | Security — certificates | Verify certificates are unique to application/environment, renewal is automated or expiry notification is timely, and ownership is explicit. |
| `L2-OAT-VAL-08` | Security — third-party software | Verify production third-party components are vulnerability-scanned and appropriately licensed/open source, with no trial-only production dependency. |
| `L2-OAT-VAL-09` | Cloud compliance — OPE | Verify One Policy Engine is integrated into application/infrastructure pipelines and reports are evaluated for critical/minor non-compliances; confirm whether approved BAS templates already provide the control. |
| `L2-OAT-VAL-10` | Cloud compliance — Terraform module scan | Verify infrastructure pipelines scan module versions against current CPF guidance and check drift; confirm coverage from the currently approved BAS template rather than assuming it. |
| `L2-OAT-VAL-11` | Cloud governance — tagging | Verify all applicable cloud resources have mandatory LSEG tags using approved tagging validation evidence. |
| `L2-OAT-VAL-12` | Runbook — support documentation | Verify required Engineering, RE, and ASM runbook sections are complete and support/escalation contacts have current on-call/hotline details. The supplied checklist calls out API/backend monitoring, OaC, OAT automation, cost metrics, ServiceNow, quotas, monitor quality, zero-touch, Azure lights-off, and go-live readiness. |
| `L2-OAT-VAL-13` | Operational overhead — manual activity | Inventory deployment/BAU manual work, minimize it, and raise RAID items for activities that cannot be automated with the technical constraint recorded. |
| `L2-OAT-VAL-14` | CloudOps onboarding checklist | Validate each relevant checklist item: DXOne health checks; Datadog workflow; downtime scheduler; GitLab CI metrics; synthetic tests; API/backend monitoring; OaC; OAT automation; cost metrics; ServiceNow; quota report; monitor quality; zero-touch adoption; Azure lights-off; go-live checklist. |
| `L2-OAT-VAL-15` | Monitoring — Datadog hygiene | Verify monitors do not flap or remain in No Data, production alert priorities are correctly tagged, and every alert has a clear resolution path. Use the current approved monitoring workflow. |
| `L2-OAT-VAL-16` | Deficiencies — DML/technical debt | Verify application deficiencies/technical debt are documented and each required item has an associated SII; the source assigns DML accountability/responsibility to the App Team. |
| `L2-OAT-VAL-17` | Vendor incidents — Azure account/subscription | Verify service-health/account outage detection and the documented Azure support engagement and incident recovery process. |
| `L2-OAT-VAL-18` | Vendor incidents — third party | For each material third-party dependency, verify outage detection and the agreed incident/recovery protocol in the support runbook. |

## Source interpretation notes

- The supplied material is a reusable Game Day template with generic minimum recommendations. It explicitly encourages application-specific additions; it does not provide a ready-approved test plan for every app.
- It contains scenario statuses and operational implementation notes that may be stale. Confirm current repos, jobs, supported Azure Chaos Studio experiments, LSEG tooling, access groups, policy, and support contacts before use.
- Production/DR destructive or disruption scenarios require explicit authorization, impact boundaries, rollback/recovery readiness, monitoring, communications, and approved change windows. Use non-production or simulations when the production risk is not approved; record when that does not satisfy a mandatory production acceptance test.
- LMP strategy OAT is owned/executed by Application Operations in Production during Cutover. The Migration Team supports, collates evidence, and addresses its assigned findings per the applicable RACI. Resolve Game Day-specific RACI and change authority with the application owner.
- Exact Azure scenario mechanics must match the actual target resources. Do not translate a VM/LVM/SQL/Service Bus example into an Azure scenario unless that service is in the approved architecture.
