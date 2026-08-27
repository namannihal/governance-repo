---
id: LMP-ADR-0012
type: ADR
status: published
supersedes: LMP-ADR-0006
approved_by:
  - LMP Migration Architecture Approval
date: 2024-10-15
valid_from: 2024-10-15
tags:
  - Foundation Platform
tech_capabilities:
  - Delivery / Operations / Deployment & Administration
---

# Prefer a Subscription per Application family / Environment, unless Application is Quarantined

## Context and Problem Statement

The LMP Migration program is attempting to balance and optimise for a number of outcomes, including drivers that want to
both minimise and maximise the overall number of Azure Subscriptions, and hence levels of sharing of Subscriptions
between applications.

Drivers for minimising Subscriptions:

- Conservation of [RFC 1918 addresses][rfc1918], in relation to LSEG's Routable network space that spans on-premise data
  centres, Azure, AWS, GCP and other provider networks.
- High fixed costs per Azure Subscription. E.g. today's Foundation LZ solution for [NATing][nat] between Routable and
  Non-Routable networks involves use of an Azure Firewall instance per spoke Subscription. Extrapolating, would result
  in extremely high fixed costs were Subscriptions to be mandated per application. See table below for other example
  components with high fixed costs.
- Reduction and minimisation of cross-Subscription traffic & data transfer, which flows through the Azure Firewall and
  hub Subscription, incurring usage costs. Ideally, applications that are chatty with each other could share
  Subscriptions

Examples of high fixed cost Azure services:

| Service                                                                         | Monthly Cost | Annual Cost |
|---------------------------------------------------------------------------------|--------------|-------------|
| **Azure Firewall** (Premium, one unit, before data charges)                     | $1,277.50    | $15,330     |
| **Azure API Management** (Premium SKU, one base unit)                           | $2,795.17    | $33,542     |
| **Azure Cache for Redis** (Enterprise tier, E10/12Mb)                           | $1,150.48    | $13,806     |
| **Azure Database for PostgreSQL** (Flexible server, 16 vCore)                   | $1,203.71    | $14,445     |
| **Azure SQL Managed Instance** (ZRS, 16 vCore, instance pools, 1 year reserved) | $2,611,60    | $31,339     |

Drivers for maximising Subscriptions:

- Minimisation of blast radius
- Isolation of Internet or customer-facing applications - related to blast radius but also involves minimising re.
  Internet-facing attack surface
- Simplification of Subscription ownership - in a simple model of 1 Subscription : 1 application, Subscription ownership
  and application ownership are the same

## Decision Drivers

The decision is driven by requirements to:

- Minimise costs
- Minimise "blast radius" (the scale of the negative impact of a hypothetical bad configuration, change, deployment,
  etc.)
- Ensure that Subscriptions have a single, contactable owner in the case of a security incident, outage or other
  significant
  event
- Minimise cross-Subscription connectivity & data transfer
- Minimise duplication of capabilities across Subscriptions, e.g. caching of same data
- Ensure that applications can be efficiently operated (e.g. observability, maintenance, troubleshooting)
- Ensure that application cost can be efficiently managed (e.g. cost allocation & reporting)
- Ensure that applications can be scaled sufficiently (e.g. Subscription networks have sufficient Routable/Non-Routable
  IP space, or any other potentially limited resources, to scale for up to 5 years of future growth)
- Ensure that applications are secured efficiently (e.g. by limiting read and write access to the right teams)
- Ensure that automation is efficiently achievable (for infrastructure & application deployment and maintenance)

## Considered Options

- Subscription per Application / Environment
- Subscription per Application family / Environment

## Decision Outcome

Two recommended options:

1. Subscription per Application family / Environment - for internal and non-Quarantined applications
2. Subscription per Application / Environment - for Quarantined applications

Option 1 is the default, should be applicable in the majority of cases where a handful of applications, owned by the
same Application Owner, can share a Subscription.
Option 2 applies for any Quarantined applications

In terms of what constitutes a 'handful' (x) of applications, a rough guideline is 1 < x < 10, i.e. when applications
are sharing a Subscription, a rule of thumb should be that no more than 10 applications should share a Subscription,
mainly for scalability reasons.

A [strawman][strawman] for D&A applications, for tranche 1, has been proposed and can be evolved/modified by D&A
engineering & architecture leadership as required.

### Quarantined Applications

Applications should be 'quarantined' into their own Subscription where they are Internet and/or external
customer-facing, i.e. constitute an external-facing attack surface, require WAF or similar technologies, require PEN
testing.
Applications with public-facing APIs, websites, CDNs, FTP services are all common examples of apps that should be
quarantined by default.

If multiple applications that should be quarantined, have the same owner, and wish to share a Subscription, this is also
acceptable and conforms to the spirit of this ADR. I.e. multiple quarantined applications can share a Subscription if
they have the same owner.

### Application Subnets

Application families that share a Subscription should create multiple Subnets in the Subscriptions Non-Routable network
to house components of each application. I.e. applications should avoid sharing Non-Routable subnets, and any
cross-application traffic should occur via the Subscription's Azure Firewall instance.

The below diagram demonstrates how a 2nd application (APP2) should create its own subnet in Non-Routable network space
to house its components.

![Example Topology](img/0012-subscription-tenancy-topology.png)

### Decision Tree

![Subscription Tenancy Decision Tree](img/0012-subscription-tenancy-decision-tree.png)

### Consequences

- Good, because we promote Subscription sharing where suitable, reducing costs, in the majority of cases
- Good, because we introduce cost overhead to standalone customer-facing applications, incentivising the use of shared
  platforms/capabilities and common interfaces for customer-facing functionality (e.g. APIs, FTP, CDN, etc.)
- Neutral, because the fixed Azure Firewall cost is still likely to be high

## Pros and Cons of the Options

### Subscription per Application / Environment

Example compression ratio - 1:1 - was previously the default option, but now applies only to Quarantined applications.

- Good, because a Subscription is a simple boundary for RBAC, Cost Management, Security and Telemetry
- Good, because Dev/QA/Pre-Prod/Prod environments maintain segregation of duties
- Good, because roles can be granted at Subscription scope, enabling creation of services that assume
  Subscription-level access
- Good, because blast radius is minimised
- Good, because Internet-facing attack surfaces are isolated from rest of the estate
- Bad, because greater number of Subscriptions incur greater fixed costs
- Bad, because greater numbers of Subscriptions are more complex to operate and maintain

### Subscription per Application family / Environment

Example compression ratio - 1:5 (assuming 5 Applications per Application family). This is the default option for
internal and non-Quarantined applications.

- Good, because a Subscription is a simple boundary for RBAC, Cost Management, Security and Telemetry
- Good, because fixed costs are reduced by the compression ratio achieved, based on number of applications sharing the
  Subscription
- Good, because an Application family must have a single owner
- Good, because the Foundation platform can already support this model (already supports Subscriptions created for "
  Primary"/"Secondary" applications, and automated from LeanIX "Parent"/"Child" relationships)
- Neutral, because there is currently no LeanIX-native mechanism to model an Application family; and is modelled
  separately in ServiceNow (as "Primary"/"Secondary" is today). In the future automating this from an "app grouping"/"
  app family" feature in LeanIX is a possibility.

## More Information

### Existing Decisions & Reference Material

- [LSEG Operational Data - Application Definition - LMP][App Def]
- [STAR DA-047 - Multiple Apps in a Single Cloud Account][Apps STAR]
- [STAR DA-307 - Subscription Vending and Application Onboarding via Foundation Services Automation][Sub STAR]
- [Heritage Refinitiv Elektron Data Platform ("EDP") AWS Account Strategy][hRef strategy]
- [D&A Subscription sharing strawman][strawman]

- The existing Foundation platform already supports multiple apps per Subscription, via two approaches:
    1. (Strongly Preferred) Primary Application + Additional Applications, via SNOW [process][snow process]
    2. (Strongly Discouraged) Parent-Child Application modelling

![Existing Foundation multi-app support](img/0012-foundation-multi-app-support.png)

[rfc1918]: https://en.wikipedia.org/wiki/Private_network

[nat]: https://app.pages.dx1.lseg.com/app-51723/migration-patterns/mig-pat-source-to-target/adrs/network/0005-packet-filtering-and-nat/

[snow process]: https://lsegroup.sharepoint.com/sites/CloudCentral/SitePages/LMP-Azure---Additional-Application-Onboarding-to-existing-Subscriptions.aspx?xsdata=MDV8MDJ8fDU5YmNiMDkxNjVhYjRkYTc1NzhkMDhkYzljZmU1NTI0fDI4N2U5ZjBlOTFlYzRjZjBiN2E0YzYzODk4MDcyMTgxfDB8MHw2Mzg1NTc4NjMzNDM4MzkxMTd8VW5rbm93bnxWR1ZoYlhOVFpXTjFjbWwwZVZObGNuWnBZMlY4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazkwYUdWeUlpd2lWMVFpT2pFeGZRPT18MXxMMk5vWVhSekx6RTVPbVF4WkRJeU5EWmhMVEU0T0dFdE5HWTBaUzFpTnpVekxUSXdZekF5WXpFNE1ETm1OVjltTldRNFlXVmlOUzAxTlRBMkxUUmhZekV0WW1Sak5pMDNNR014WWpCak5qQTROMk5BZFc1eExtZGliQzV6Y0dGalpYTXZiV1Z6YzJGblpYTXZNVGN5TURFNE9UVXpNemd3T1E9PXwyNDQxNmI4ZDAxNzk0NDYxZjUyYjA4ZGM5Y2ZlNTUyMXxjNGE5OGIyNjk1MTA0Mjg0ODVkYTY3YTU0OGRhZDBhMw%3D%3D&sdata=TTcvQzlmdXJHNUFXTlpoTHFrdWZsY0FGaHN2cXVIdmoyeXdKQXhxQkgrYz0%3D&ovuser=287e9f0e-91ec-4cf0-b7a4-c63898072181%2CPaul.Murphy1%40lseg.com&OR=Teams-HL&CT=1720189537018&clickparams=eyJBcHBOYW1lIjoiVGVhbXMtRGVza3RvcCIsIkFwcFZlcnNpb24iOiI1MC8yNDA1MzEwMTQyMSIsIkhhc0ZlZGVyYXRlZFVzZXIiOmZhbHNlfQ%3D%3D

[strawman]: https://lucid.app/lucidchart/4005bf3a-fa13-4d90-930c-cead13888f21/edit?invitationId=inv_c036f66c-8a90-471f-9ec3-34925c33b3ba&page=Lk6Ox58RwJUS#

[hRef strategy]: https://confluence.refinitiv.com/pages/viewpage.action?spaceKey=FA&title=EDP+AWS+Account+Strategy

[Sub STAR]:  https://lsegroup.sharepoint.com/:w:/r/teams/LSEGLMPAppMigrationApprovers/Shared%20Documents/Architecture%20Docs%20-%20Proposals,%20Strategies%20etc/LMP%20Architecture%20TOR%200.0.1.docx?d=w9a96c749784a4b0ca6d10d41ffa312d1&csf=1&web=1&e=eVwXaJ

[Apps STAR]: https://lsegroup.sharepoint.com/:w:/r/teams/LMFoundationFM/Shared%20Documents/General/02%20Design%20Docs/3%20Management,%20Cost,%20Governance%20%26%20Policy/STAR%20DA-047%20Multiple%20Apps%20in%20Single%20Cloud%20Account.docx?d=w16c2ece18d4c47c9870ff620ec84587b&csf=1&web=1&e=RfgQ10

[App Def]: https://lsegroup.sharepoint.com/:p:/r/teams/LSEGLMPAppMigrationApprovers/Shared%20Documents/Architecture%20Docs%20-%20Proposals,%20Strategies%20etc/LSEG%20Operational%20Data%20-%20Application%20Definition%20-%20LMP.pptx?d=w4c71a677cae7435c97a7d296e9f7891f&csf=1&web=1&e=orbaAX

