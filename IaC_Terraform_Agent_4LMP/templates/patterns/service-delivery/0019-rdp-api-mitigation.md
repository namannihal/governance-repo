---
id: LMP-PAT-0019
type: Functional Design Pattern
status: published
approved_by:
  - LMP Migration Architecture Approval
date: 2024-09-13
valid_from: 2024-08-06
developer_productivity_hrs: 0
tags:
  - Service Delivery
  - Network Access
  - Internet
tech_capabilities:
  - Business / Manufacturing & Delivery / Service Delivery
  - Infrastructure / Network / Data Network
---

# RDP API Gateway Dog-Leg - Customer Mitigation (Functional Design Pattern)

## Introduction

This reference architecture describes the approach for mitigating customer impact of any migrating applications that
expose their APIs via the RDP API Gateway (APP-204891).

## Principles

- Application migrations as part of the LMP Migration program, and any consequential customer product migrations must be
  de-coupled

## Scope

All applications that are within LMP Migration program perimeter, and expose their APIs via RDP API Gateway, are
expected to follow the approach detailed in this pattern. It is expected that there are roughly 100 applications
exposing their APIs via RDP API Gateway, the majority being in hRefinitiv AWS, and some hRefinitiv on-premise.

## Approach

This section details the approach that must be taken for every migrating application that meets the criteria discussed
in Scope. Broadly, the aim of the approach is to mitigate any customer impact of the migrating application, by
introducing a 'dog-leg' - a network connection between the RDP API Gateway proxy in AWS, and the new application in
Azure. In doing so, migration of the application, and migration of any impacted products and customers, are successfully
de-coupled, allowing customer traffic and usage to exercise the migrated application in the new Azure environment,
whilst leaving any consumers intact and uninterrupted.

### Current State

The below diagram describes current state of an AWS-based application, 'App A', that exposes its API via RDP API
Gateway, prior to any application migration commencing.

![Current State](img/0019-rdp-api-current-state.png){: style="width:35%"}

### Application Build

The below diagram describes the next phase, where the migrating application, 'App A', is being built in Azure, but
customer traffic is still routed to the prior version in AWS.

A few points to note:

- Diagram describes an 'App A LB / APIM / Service Failover' component, and in varying circumstances this component may
  differ. In some cases, it might be an Azure APIM instance, in others it could be an Azure Traffic Manager, Azure Load
  Balancer or other component.
- Diagram describes an 'App A Family Subscription'. In most cases, applications will be deployed in shared subscriptions
  alongside alike applications, whereas in others applications may be deployed in their own subscription
- In some cases the application being migrated may be multi-region in Azure. To de-couple AWS/proxy infrastructure and
  failover entities from applications in Azure, it is best build any regional failover capabilities for the application
  in Azure, and prepare for regional RDP API Gateway instances to point a component (Load Balancher, FrontDoor etc.)
  that can provide region failover and routing. See Pattern for internal multi-region failover (link TBC)
- To achieve trust between RDP API Gateway in AWS, and the fronting component of the migrated application (as above,
  could be one of several Azure services), use of an LSEG.com Entra Service Principal is recommended. The Service
  Principal must have permission to access/execute the fronting service, with credentials stored on the RDP API Gateway
  side. This is the recommended approach for auth.

![RDP API](img/0019-rdp-api-app-built.png){: style="width:35%"}

### Dog-Leg

The below diagram describes the introduction of the Mitigation phase, where customer traffic is routed to the migrated
application in Azure.

A key step in achieving the cutover described is a connectivity request
via [App Conn](https://lsegroup.sharepoint.com/sites/CloudCentral/SitePages/AppConn-Connectivity-Request.aspx). App
Conn, the replacement of the SBO request form, allows for connectivity to be achieved between disparate points on LSEG
networks.

To deploy the change and have RDP API Gateway route requests to new endpoints, this is in the control of publishing
application teams via RDP API Gateway's standard API SDLC, i.e. Swagger/OpenAPI configuration; the host being routed to
is referenced in these configuration files, so API publishers can control and modify as they would with any standard API
update.

![Dog-Leg](img/0019-rdp-api-dog-leg.png){: style="width:35%"}

### Cutover Process:  big-bang / canary / other approaches

Some application teams may be comfortable cutting all customer traffic over in one change (big bang), whilst in other
cases, especially those with very significant amounts of customer traffic, teams may prefer more staged/phased cutover.

The simplest method of staging cutover is to move API endpoints/methods, or API verbs (GET/POST etc.) in different
phases, e.g. migrate lower-risk or read-only methods first, followed by higher-risk/write methods. This can be
controlled via aforementioned standard API SDLC on RDP API Gateway, and is the recommended approach for staging cutover.

For some apps, teams have discussed other cutover approaches, e.g. routing specific customers, or a % of queries to
Azure. As of Q3 2024, there is no central capability for this, but one application team (QPS) has built a routing layer
in AWS that can perform canary-style routing. If many other apps have the same requirement, a central solution can be
investigated.

## Further Reading

- [RDP API Gateway Customer Mitigation & Migration - More detail](https://confluence.refinitiv.com/pages/viewpage.action?pageId=993129327)
- [Customer Migrations - Bundles Overview](https://lsegroup.sharepoint.com/:p:/r/teams/LSEGLMPAppMigrationApprovers/Shared%20Documents/Architecture%20Docs%20-%20Proposals,%20Strategies%20etc/LMP%20Customer%20Migrations%20-%20%20Bundles.pptx?d=w8bc02e9e8abc4e37876019d68e0c7dba&csf=1&web=1&e=ufXLW8)
- [App Conn request process](https://lsegroup.sharepoint.com/sites/CloudCentral/SitePages/AppConn-Connectivity-Request.aspx)

