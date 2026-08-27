---
id: LMP-PAT-0027
type: Functional Design Pattern
status: published
approved_by:
  - LMP Migration Architecture Approval
date: 2024-09-20
valid_from: 2024-09-20
developer_productivity_hrs: 2
tags:
  - Service Delivery
  - Network Access
  - Internet
tech_capabilities:
  - Business / Manufacturing & Delivery / Service Delivery
  - Infrastructure / Network / Data Network
---

# F5 Load Balancer Dog-Leg - Customer Mitigation (Functional Design Pattern)

## Introduction

This reference architecture describes the approach for mitigating customer impact of any on-premise applications with
customer-facing APIs, but that i) do not have any application-layer proxy-like component (i.e. all components of the
customer-facing API are part of the migrating application) and ii) we expect there to be significant use of IP
clearlisting on the customer side (this is typical where the product leverages Delivery Direct connectivity, rather than
Internet). In these cases, typically the IP addresses presented to customers are those of a Load Balancer (a Cisco F5),
with associated friendly FQDNs. To mitigate customer impact of the application migration, the on-premise Load Balancer
can be used to de-couple application migration to Azure, and customer migrations.

For Internet-only products, or where IP clearlisting is not common or expected in the customer base, FQDNs can simply be
updated to point directly to Azure infrastructure and IP ranges. This Pattern describes the exception to that, where we
expect IP clearlisting to be commonly used by customers.

## Principles

- Application migrations as part of the LMP Migration program, and any consequential customer product migrations must be
  de-coupled

## Scope

All applications that:

- are within LMP Migration program perimeter
- are currently on-premise
- expose their APIs directly to customers via an F5 Load Balancer (i.e. not via an intermediary proxy application)
- front a product that leverages Delivery Direct (often in addition to Internet)
- we expect customers to utilise IP clearlisting
  In this set of circumstances, applications are expected to follow the approach detailed in this pattern. In the
  entirety of the LMP Migration perimeter, it is expected that there are roughly 5-10 on-premise applications directly
  exposing their APIs to customers, that meet the above criteria, where use of an F5 Load Balancer can be used as a
  routing proxy.

## Approach

This section details the approach that must be taken for every migrating application that meets the criteria discussed
in Scope. Broadly, the aim of the approach is to mitigate any customer impact of the migrating application, by
introducing a 'dog-leg' - a network connection between the FQDNs and IP addresses presented to customers by on-premise
infrastructure, and the new application in
Azure. In doing so, migration of the application, and migration of any impacted products and customers, are successfully
de-coupled, allowing customer traffic and usage to exercise the migrated application in the new Azure environment,
whilst leaving any consumers intact and uninterrupted.

### Current State

The below diagram describes current state of an on-premise application, 'App A', with an API and fronted by a Load
Balancer, prior to any application migration commencing.

![Current State](img/0027-f5-current-state.png){: style="width:35%"}

### Application Build

The below diagram describes the next phase, where the migrating application, 'App A', is being built in Azure, but
customer traffic is still routed to the prior version on-premise.

A few points to note:

- Diagram describes an 'App A LB / APIM / Service Failover' component, and in varying circumstances this component may
  differ. In some cases, it might be an Azure APIM instance, in others it could be a Load Balancer or other component.
- Diagram describes an 'App A Family Subscription'. In most cases, applications will be deployed in shared subscriptions
  alongside alike applications, whereas in others applications may be deployed in their own subscription
- In some cases the application being migrated may be multi-region in Azure. To de-couple on-premise infrastructure and
  failover entities from applications in Azure, it is best build any regional failover capabilities for the application
  in Azure, and prepare for on-premise F5 Load Balancers to point a component (Load Balancer, FrontDoor etc.)
  that can provide region failover and routing
- To achieve trust between the Load Balancer on-premise, and the fronting component of the migrated application in
  Azure (as above, could be one of several Azure services), use source IP filtering in the subscription's Azure Firewall
  is recommended. A more complete system-system authentication solution is not recommended in this particular case.

![Application Built](img/0027-f5-app-built.png){: style="width:35%"}

### Dog-Leg

The below diagram describes the introduction of the Mitigation phase, where customer traffic is routed to the migrated
application in Azure.

There are three major steps to introducing the connectivity between on-premise Load Balancer and new Azure
infrastructure:

- Connectivity request via [App Conn][app-conn-request]. App Conn, the replacement of the SBO request form, allows for
  connectivity to be achieved between disparate points on LSEG networks.
- Raise an Issue in [Metricstream][metricstream]:
    - under the Application Owner
    - 'Moderate' rating
    - with title 'LMP Load Balancer dog-leg - APP-<ID>'
    - with a Due Date of the expected completion of customer migration window of the Bundle that the product is expected
      to be migrated with
- Raise an I&C [Front Door request][i-and-c-frontdoor] - use `CLICK HERE TO SUBMIT AN I&C REQUEST (JIRA)`
    - Technology Business Unit as 'Infrastructure & Cloud'
    - I&C Services as 'Network Product Services'
    - Service Capability as 'Application Network Connectivity'
    - Capability Types as 'Load Balancing'
    - Delivery Service as 'Engineering'
    - Summary as 'LMP LB Dog-leg APP-<ID>'
    - In Description, reference the ID of the Metric stream issue raised in the previous step

The 3rd step is the engagement process with I&C for introducing these changes, and they have requested that Metricstream
issues be raised so that any F5-based dog-legs - that introduce some operational risk - are formally tracked in LSEG
risk management systems.

![Dog-Leg](img/0027-f5-dog-leg.png){: style="width:35%"}

### Cutover Process:  big-bang / canary / other approaches

Some application teams may be comfortable cutting all customer traffic over in one change (big bang), whilst in other
cases, especially those with very significant amounts of customer traffic, teams may prefer more staged/phased cutover.

As on-premise Load Balancers are typically operating at layer 4 in the networking stack, layer 7/HTTP routing techniques
may not be possible, and certainly would increase challenge of coordination with I&C. Therefore in most cases F5-based
dog-legs will be limited to simple/big-bang style for cutover.

## Further Reading

- [Customer Migrations - Bundles Overview][migrations-bundles-overview]

[migrations-bundles-overview]: https://lsegroup.sharepoint.com/:p:/r/teams/LSEGLMPAppMigrationApprovers/Shared%20Documents/Architecture%20Docs%20-%20Proposals,%20Strategies%20etc/LMP%20Customer%20Migrations%20-%20%20Bundles.pptx?d=w8bc02e9e8abc4e37876019d68e0c7dba&csf=1&web=1&e=ufXLW8

[app-conn-request]: https://lsegroup.sharepoint.com/sites/CloudCentral/SitePages/AppConn-Connectivity-Request.aspx

[metricstream]: https://lseg.a04a.metricstream.com/metricstream/auth/dualLogin.jsp

[i-and-c-frontdoor]: https://lsegroup.sharepoint.com/teams/TechOpsServiceDelivery/SitePages/SD-FrontDoor.aspx

