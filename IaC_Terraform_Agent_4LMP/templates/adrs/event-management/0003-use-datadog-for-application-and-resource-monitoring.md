---
id: LMP-ADR-0003
type: ADR
status: published
approved_by:
  - LMP Migration Architecture Approval
date: 2024-03-14
valid_from: 2024-05-25
tags:
  - Event Management
  - Application Support
tech_capabilities:
  - Delivery / Operations / Event Management
  - Delivery / Operations / IT Service Management / Application Monitoring
---

# Use Datadog SaaS for Application & Resource monitoring

## Context and Problem Statement

In the current context of application migration to LMP greenfield migration to Azure lseg.com tenant,
application teams need clarifications on the following points to migrate seamlessly.

What is the Strategic Observability destination in LMP Greenfield for Resource Metrics/Logs/Application logs?

## Decision Drivers

LSEG Applications are migrating to Azure under LMP.
These applications would needed to be monitored, especially for the following technology and application areas:

- Infrastructure Resource Metrics which includes (PaaS/Iaas/FaaS) services
- Infrastructure Resource Logs which includes (PaaS/Iaas/FaaS) services
- Application Logs
- Application Traces

## Considered Options

- Azure Monitor
- Datadog SaaS

## Decision Outcome

Chosen option: Datadog SaaS, because

- It is a strategic choice from LSEG

Necessary details can be found below:

- [STAR DA-303 Observability Design](https://lsegroup.sharepoint.com/:f:/r/teams/LMFoundationFM/Shared%20Documents/General/02%20Design%20Docs/3%20Management,%20Cost,%20Governance%20%26%20Policy?csf=1&web=1&e=7FzAUv)
- [STAR DA-303 Observability Tooling Options](https://lsegroup.sharepoint.com/:x:/r/teams/LMFoundationFM/Shared%20Documents/General/02%20Design%20Docs/3%20Management,%20Cost,%20Governance%20%26%20Policy/STAR%20DA-303%20Observability%20Tooling%20Options.xlsx?d=w4fb2793322b14291aa20a55de53814ce&csf=1&web=1&e=sjNCui)
- [STAR DA-051 Datadog SaaS Design](https://lsegroup.sharepoint.com/:w:/r/teams/LMFoundationFM/Shared%20Documents/General/02%20Design%20Docs/6%20DevOps%20Tooling/STAR%20DA-051%20Datadog%20SaaS%20Design.docx?d=w25d8fc3eb1a9458daba99258f4d95460&csf=1&web=1&e=3jxG7s)
- [STAR DA-051 Datadog ResourceLog Integration LLD draft](https://lsegroup.sharepoint.com/:w:/r/teams/LMFoundationFM/Shared%20Documents/General/02%20Design%20Docs/6%20DevOps%20Tooling/STAR%20DA-051%20Datadog%20ResourceLog%20Integration%20LLD%20draft.docx?d=wb9d957dd6bb441d18a8681add6717559&csf=1&web=1&e=Q4RZAL)

### Consequences

- Good, because it is a single repo for all types of observability data like metric, APMs and logs.
- Good, because all security requirements continue to be met
- Good, because the service is provided by a managed SaaS platform
- Good, because it has easy integration with other tools like cloudhealth, Big Panda etc.
- Neutral, because cost can be an added component for applications which don't currently uses Datadog.

Price details can be found in
[Datadog Cost Estimation](https://confluence.refinitiv.com/display/PCP/Datadog+Cost+Estimation)
[Solution for App-ID based Monthly Usage and Bill generation](https://confluence.refinitiv.com/display/PCP/Solution+for+App-ID+based+Monthly+Usage+and+Bill+generation)

- Bad, because single tool vendor dependency.

### Confirmation

The decision was validated by the CTEF process, see [Architecture Governance item - GOVI0001229.](https://lseg.service-now.com/x/lsegp/cto/record/x_lsegp_eag_governance_item/aecf27611b7d7d10a3a9337f034bcb42)

CTEF approval details - can be found in the following ADO items

[Deliverable 27682: App Monitoring Observability Document - Datadog/BigPanda/Azure Monitor](https://dev.azure.com/LSEG/Foundation/_workitems/edit/27682)

[Deliverable 31235: Datadog Observability SaaS](https://dev.azure.com/LSEG/Foundation/_workitems/edit/31235)

## Pros and Cons of the Options

### [Azure Monitor](https://learn.microsoft.com/en-us/azure/azure-monitor/overview)

- Good, because Azure native log collections would be available with less configurations.
- Good, because it provides native capabilities for application performance monitoring.
- Bad, because it is not comprehensive to cover all the facets of Resource logs and application log monitoring like traces.
- Bad, because integration with other CSPs may need application code refactoring.
- Bad, because it only caters to application performance monitoring.
- Bad, because integration with other CSPs may need application code refactoring.

## More Information

We may need to revisit this decision later, to check the possibilities of implementing Open Telemetry in LMP landscape.
This can help to minimize the effect of Single vendor dependency for application & resource metric and log monitoring.

