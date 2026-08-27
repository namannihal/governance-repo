---
id: LMP-PAT-0022
type: Technology Selection Pattern
status: published
approved_by:
  - LMP Migration Architecture Approval
valid_from: 2024-08-21
developer_productivity_hrs: 5
date: 2024-08-28
tags:
  - Application Hosting
tech_capabilities:
  - Delivery / Operations / Deployment & Administration
---

# Selection of LMP Tenant and Environment

## Compatibility

This advice relates to the Tenants and Environments available in the LMP Azure/Fabric platform and their usage. As such,
it is only relevant to projects looking to use either the LMP Azure tenants or the LMP SaaS capacities.

## Recommended Target

This document is designed to allow Solution Architects (and development teams) to identify which LMP Tenant and which
Environment within that tenant that they should select to deploy assets to, based on the intended usage patterns and the
proposed architecture for the Application being designed/developed. The target tenant/environment is dependent on the
context of whether the App is proposed as part of a strategic LSEG.com deployment or as part of the LSEG SaaS platform,
whether the App requires on-prem/legacy AWS connectivity (and whether it is pre- or post-R1, where SaaS tenants are
proposed to get on-prem/legacy AWS connectivity) and whether there Data Gravity from related applications/data stores
would influence the deployment location.

## Authoritative references

| Reference Type | Reference                                                                                          | Relevance to guidance                                               | Comments |
|----------------|----------------------------------------------------------------------------------------------------|---------------------------------------------------------------------|----------|
| Strategy       | [STAR LMP SIA Environments Tenancy Design v1.2 - working update version][environment-tenancy-star] | Defines the usage of the Tenants within the SIA strategic platform  |          |
| Strategy       | [LMP Fabric Enterprise Landing Zone and Op Model Design][landing-zone-op-model-design]             | Defines the usage of Fabric/Purview Capacities at a strategic level |          |

## Decision Tree Diagrams

**Tenant/Subscription Selector**
This is used for identifying the target Tenant(or SaaS subscription) for an Application
![LMP Tenant, Environment and Subscription selection guide](img/0022-subscription-picker.png)
**Environment Selector**
This is used for identifying the target Environment for an Application within a Tenant (or SaaS subscription) based upon
the stage of the development lifecycle
![LMP Tenant, Environment and Subscription selection guide](img/0022-environment-picker.png)

## Considerations

- **Strategic Production Target**: For business reasons, an Application may be targeted at the SaaS platform or to
  LSEG.com, despite it leading to increased complexity/dependency of architecture (i.e. lack of on-prem connectivity for
  SaaS tenants pre-R1 and likely for all of 2024 leads to the need to "stage" data in LSEG.com via existing
  connectivity)
- **Data Sources**: If an application requires data from On-Prem or Legacy AWS, then there is a current reliance on
  LSEG.com connectivity that will remain until SaaS subscriptions (LMSP1 and LSEG SaaS have such connectivity enabled -
  this is out of scope for R1 and likely for all of 2024.
- **"Data Gravity"**: An application may have no inherent need to be deployed to the SaaS subscriptions, but may be
  closely linked to applications which reside on SaaS due to high levels of read/write traffic to/from SaaS
  applications, for example. In order to minimise data entry/exit costs across
  the SaaS/Azure tenant boundary layer, it would make sense to cluster the applications together. Similarly, support and
  access patterns for an application may influence the choice to deploy to SaaS, as opposed to LSEG.com, despite the
  application architecture itself not having any specific dependency on SaaS-hosted tooling.

[environment-tenancy-star]: https://lsegroup.sharepoint.com/:w:/r/teams/LMDataPlatform/Shared%20Documents/CH%20-%20Tech%20Architecture/Working%20Docs/Solution%20Designs%20(SADs-STARs-etc)/LMP%20SIA%20Tenancy%20(LMSP1,%20SaaS,%20etc)/STAR%20LMP%20SIA%20Environments%20Tenancy%20Design%20v1.2.docx?d=w2eaafee3420a4a949546ab0bf8aed631&csf=1&web=1&e=hFeIzB

[landing-zone-op-model-design]: https://lsegroup.sharepoint.com/:w:/r/teams/LMFoundationFM/Shared%20Documents/NEW%20-%20Fabric%20and%20Purview%20design/LMP%20Fabric%20Enterprise%20Landing%20Zone%20and%20Op%20Model%20Design.docx?d=wbb5bde9b9ad341fe8370e0e29cda3f45&csf=1&web=1&e=T5SzKO

