---
id: LMP-PAT-0028
type: Functional Design Pattern
status: published
approved_by:
  - LMP Migration Architecture Approval
date: 2024-09-26
valid_from: 2024-09-19
developer_productivity_hrs: 5
tags:
  - Service Delivery
  - Network Access
  - Internet
tech_capabilities:
  - Business / Manufacturing & Delivery / Service Delivery
  - Infrastructure / Network / Data Network
---

# Application Component Dog-Leg - Customer Mitigation (Functional Design Pattern)

## Introduction

This reference architecture describes the approach for mitigating customer impact of any migrating applications that
exposes APIs to customers, and has a convenient, application-layer proxy component, e.g. an API gateway technology.

## Principles

- Application migrations as part of the LMP Migration program, and any consequential customer product migrations must be
  de-coupled

## Scope

All applications that are within LMP Migration program perimeter, and expose their APIs to customers via an
application-layer proxy component (e.g. AWS API Gateway, Kong API Gateway, APIGee API Gateway, etc.) are expected to
follow the approach detailed in this pattern. It is expected that there are roughly 10 applications
exposing customer-facing APIs in this way, some on-premise, some in AWS or Azure Brownfield.

From LMP Tranche 1, it is expected that applications
like [Yield Book API (APP-01100)][app-01100], [Elektron CASE API (APP-250057)][app-250057],
and [Refinitiv Contributions Prices (APP-206266)][app-206266] will follow this approach.

## Approach

This section details the approach that must be taken for every migrating application that meets the criteria discussed
in Scope. Broadly, the aim of the approach is to mitigate any customer impact of the migrating application, by
introducing a "dog-leg" - a network connection between a component in the existing environment, and the new application
in
Azure. In doing so, migration of the application, and migration of any impacted products and customers, are successfully
de-coupled, allowing customer traffic and usage to exercise the migrated application in the new Azure environment,
whilst leaving any consumers intact and uninterrupted.

The approach does mean that the original application will retain some small presence in the original environment (
on-premise, AWS, or Azure Brownfield), at relatively small cost, and may inhibit ability of e.g. data centre teams to
fully decommission the original application. This is seen by the Migration program as a small trade-off, and the ability
to de-couple application migrations from customer migrations is an overall net positive for LSEG.

### Current State

The below diagram describes current state of an on-premise or AWS-based application, "App A", that exposes its API via
an application-layer component, such as an API gateway, prior to any application migration commencing.

![Current State](img/0028-app-current-state.png){: style="width:50%"}

### Application Build

The below diagram describes the next phase, where the migrating application, "App A", is being built in Azure, but
customer traffic is still routed to the prior version on-premise.

A few points to note:

- Diagram describes an "App A LB / APIM / Service Failover" component, and in varying circumstances this component may
  differ. In some cases, it might be an Azure APIM instance, in others it could be a Load Balancer or other component.
- Diagram describes an "App A Family Subscription". In most cases, applications will be deployed in shared subscriptions
  alongside alike applications, whereas in others applications may be deployed in their own subscription
- In some cases the application being migrated may be multi-region in Azure. To de-couple on-premise infrastructure and
  failover entities from applications in Azure, it is best build any regional failover capabilities for the application
  in Azure, and prepare for edge components in the original environment instances to point a component (a virtual DNS,
  FrontDoor etc.)
  that can provide region failover and routing
- To achieve trust between the existing component in the original environment, and the fronting component of the
  migrated application in
  Azure (as above, could be one of several Azure services), use of source IP filtering in the subscription's Azure
  Firewall is recommended. A more complete system-system authentication solution is not recommended in this particular
  case.

![Application Built](img/0028-app-app-built.png){: style="width:50%"}

### Dog-Leg

The below diagram describes the introduction of the Mitigation phase, where customer traffic is routed to the migrated
application in Azure.

A key step in achieving the cutover described is a connectivity request
via [App Conn][app-conn-request]. App
Conn, the replacement of the SBO request form, allows for connectivity to be achieved between disparate points on LSEG
networks.

To deploy the change and have the application component route requests to new endpoints, this is all in the application
team's control as they own the component (e.g. API gateway), so should follow their standard SDLC process.

![Dog-Leg](img/0028-app-dog-leg.png){: style="width:50%"}

### Cutover Process:  big-bang / canary / other approaches

Some application teams may be comfortable cutting all customer traffic over in one change (big bang), whilst in other
cases, especially those with very significant amounts of customer traffic, teams may prefer more staged/phased cutover.

The simplest method of staging cutover is to move API endpoints/methods, or API verbs (GET/POST etc.) in different
phases, e.g. migrate lower-risk or read-only methods first, followed by higher-risk/write methods. This is the
recommended approach for staging
cutover.

For some apps, teams have discussed other cutover approaches, e.g. routing specific customers, or a % of queries to
Azure. This is entirely in the application team's control if needed.

## Further Reading

- [Customer Migrations - Bundles Overview][migrations-bundles-overview]

[app-01100]: https://lseg.leanix.net/LsegPROD/external/applicationId/APP-01100

[app-250057]: https://lseg.leanix.net/LsegPROD/external/applicationId/APP-250057

[app-206266]: https://lseg.leanix.net/LsegPROD/external/applicationId/APP-206266

[app-conn-request]: https://lsegroup.sharepoint.com/sites/CloudCentral/SitePages/AppConn-Connectivity-Request.aspx

[migrations-bundles-overview]: https://lsegroup.sharepoint.com/:p:/r/teams/LSEGLMPAppMigrationApprovers/Shared%20Documents/Architecture%20Docs%20-%20Proposals,%20Strategies%20etc/LMP%20Customer%20Migrations%20-%20%20Bundles.pptx?d=w8bc02e9e8abc4e37876019d68e0c7dba&csf=1&web=1&e=ufXLW8

