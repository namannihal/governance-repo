<span class="md-content__button md-icon md-status--published" href="#" title="Status: Published"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE4LjUgMmgtMTNDMy42IDIgMiAzLjYgMiA1LjV2MTNDMiAyMC40IDMuNiAyMiA1LjUgMjJIMTZsNi02VjUuNUMyMiAzLjYgMjAuNCAyIDE4LjUgMk0yMCAxNWgtMS41Yy0xLjkgMC0zLjUgMS42LTMuNSAzLjVWMjBINS44Yy0xIDAtMS44LS44LTEuOC0xLjhWNS44QzQgNC44IDQuOCA0IDUuOCA0aDEyLjVjMSAwIDEuOC44IDEuOCAxLjhWMTVtLTQuOS02LjggMS41IDEuNS02IDYtMy41LTMuNSAxLjUtMS41IDIgMnoiIC8+PC9zdmc+) </span> <span class="md-content__button md-icon .md-status--published" title="Valid from 2024-10-15"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE5IDE5SDVWOGgxNG0wLTVoLTFWMWgtMnYySDhWMUg2djJINWEyIDIgMCAwIDAtMiAydjE0YTIgMiAwIDAgMCAyIDJoMTRhMiAyIDAgMCAwIDItMlY1YTIgMiAwIDAgMC0yLTJtLTIuNDcgOC4wNkwxNS40NyAxMGwtNC44OCA0Ljg4LTIuMTItMi4xMi0xLjA2IDEuMDZMMTAuNTkgMTd6IiAvPjwvc3ZnPg==) </span> <span class="md-content__button md-icon actions-date" title="Published on 2024-10-15">![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTkgMTB2Mkg3di0yem00IDB2MmgtMnYtMnptNCAwdjJoLTJ2LTJ6bTItN2EyIDIgMCAwIDEgMiAydjE0YTIgMiAwIDAgMS0yIDJINWEyIDIgMCAwIDEtMi0yVjVhMiAyIDAgMCAxIDItMmgxVjFoMnYyaDhWMWgydjJ6bTAgMTZWOEg1djExek05IDE0djJIN3YtMnptNCAwdjJoLTJ2LTJ6bTQgMHYyaC0ydi0yeiIgLz48L3N2Zz4=)</span> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/edit/main/docs/adrs/foundation-platform/0012-subscription-tenancy.md" class="md-content__button md-icon" title="Edit this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTEwIDIwSDZWNGg3djVoNXYzLjFsMi0yVjhsLTYtNkg2Yy0xLjEgMC0yIC45LTIgMnYxNmMwIDEuMS45IDIgMiAyaDR6bTEwLjItN2MuMSAwIC4zLjEuNC4ybDEuMyAxLjNjLjIuMi4yLjYgMCAuOGwtMSAxLTIuMS0yLjEgMS0xYy4xLS4xLjItLjIuNC0uMm0wIDMuOUwxNC4xIDIzSDEydi0yLjFsNi4xLTYuMXoiIC8+PC9zdmc+" /></a> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/blob/main/docs/adrs/foundation-platform/0012-subscription-tenancy.md" class="md-content__button md-icon" title="View source of this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE3IDE4Yy41NiAwIDEgLjQ0IDEgMXMtLjQ0IDEtMSAxLTEtLjQ0LTEtMSAuNDQtMSAxLTFtMC0zYy0yLjczIDAtNS4wNiAxLjY2LTYgNCAuOTQgMi4zNCAzLjI3IDQgNiA0czUuMDYtMS42NiA2LTRjLS45NC0yLjM0LTMuMjctNC02LTRtMCA2LjVhMi41IDIuNSAwIDAgMS0yLjUtMi41IDIuNSAyLjUgMCAwIDEgMi41LTIuNSAyLjUgMi41IDAgMCAxIDIuNSAyLjUgMi41IDIuNSAwIDAgMS0yLjUgMi41TTkuMjcgMjBINlY0aDd2NWg1djQuMDdjLjcuMDggMS4zNi4yNSAyIC40OVY4bC02LTZINmEyIDIgMCAwIDAtMiAydjE2YTIgMiAwIDAgMCAyIDJoNC41YTguMiA4LjIgMCAwIDEtMS4yMy0yIiAvPjwvc3ZnPg==" /></a>

Document Metadata

|  |  |
|----|----|
| Identifier | **`LMP-ADR-0012`** |
| Type | **ADR** |
| Status | **Published** |
| Approvals | <span class="md-tag">LMP Migration Architecture Approval</span> |
| Published on | **October 15, 2024** |
| Valid From | **October 15, 2024** |
| Authors | <span class="md-source-file__fact"> </span> |
| Tags | <span class="md-tag">Foundation Platform</span> |
| Technology Capabilities | <span class="md-tag">Delivery / Operations / Deployment & Administration</span> |

# Prefer a Subscription per Application family / Environment, unless Application is Quarantined<a href="#prefer-a-subscription-per-application-family-environment-unless-application-is-quarantined" class="headerlink" title="Permanent link">¶</a>

## Context and Problem Statement<a href="#context-and-problem-statement" class="headerlink" title="Permanent link">¶</a>

The LMP Migration program is attempting to balance and optimise for a number of outcomes, including drivers that want to both minimise and maximise the overall number of Azure Subscriptions, and hence levels of sharing of Subscriptions between applications.

Drivers for minimising Subscriptions:

- Conservation of [RFC 1918 addresses](https://en.wikipedia.org/wiki/Private_network), in relation to LSEG's Routable network space that spans on-premise data centres, Azure, AWS, GCP and other provider networks.
- High fixed costs per Azure Subscription. E.g. today's Foundation LZ solution for [NATing](https://app.pages.dx1.lseg.com/app-51723/migration-patterns/mig-pat-source-to-target/adrs/network/0005-packet-filtering-and-nat/) between Routable and Non-Routable networks involves use of an Azure Firewall instance per spoke Subscription. Extrapolating, would result in extremely high fixed costs were Subscriptions to be mandated per application. See table below for other example components with high fixed costs.
- Reduction and minimisation of cross-Subscription traffic & data transfer, which flows through the Azure Firewall and hub Subscription, incurring usage costs. Ideally, applications that are chatty with each other could share Subscriptions

Examples of high fixed cost Azure services:

| Service | Monthly Cost | Annual Cost |
|----|----|----|
| **Azure Firewall** (Premium, one unit, before data charges) | \$1,277.50 | \$15,330 |
| **Azure API Management** (Premium SKU, one base unit) | \$2,795.17 | \$33,542 |
| **Azure Cache for Redis** (Enterprise tier, E10/12Mb) | \$1,150.48 | \$13,806 |
| **Azure Database for PostgreSQL** (Flexible server, 16 vCore) | \$1,203.71 | \$14,445 |
| **Azure SQL Managed Instance** (ZRS, 16 vCore, instance pools, 1 year reserved) | \$2,611,60 | \$31,339 |

Drivers for maximising Subscriptions:

- Minimisation of blast radius
- Isolation of Internet or customer-facing applications - related to blast radius but also involves minimising re. Internet-facing attack surface
- Simplification of Subscription ownership - in a simple model of 1 Subscription : 1 application, Subscription ownership and application ownership are the same

## Decision Drivers<a href="#decision-drivers" class="headerlink" title="Permanent link">¶</a>

The decision is driven by requirements to:

- Minimise costs
- Minimise "blast radius" (the scale of the negative impact of a hypothetical bad configuration, change, deployment, etc.)
- Ensure that Subscriptions have a single, contactable owner in the case of a security incident, outage or other significant event
- Minimise cross-Subscription connectivity & data transfer
- Minimise duplication of capabilities across Subscriptions, e.g. caching of same data
- Ensure that applications can be efficiently operated (e.g. observability, maintenance, troubleshooting)
- Ensure that application cost can be efficiently managed (e.g. cost allocation & reporting)
- Ensure that applications can be scaled sufficiently (e.g. Subscription networks have sufficient Routable/Non-Routable IP space, or any other potentially limited resources, to scale for up to 5 years of future growth)
- Ensure that applications are secured efficiently (e.g. by limiting read and write access to the right teams)
- Ensure that automation is efficiently achievable (for infrastructure & application deployment and maintenance)

## Considered Options<a href="#considered-options" class="headerlink" title="Permanent link">¶</a>

- Subscription per Application / Environment
- Subscription per Application family / Environment

## Decision Outcome<a href="#decision-outcome" class="headerlink" title="Permanent link">¶</a>

Two recommended options:

1.  Subscription per Application family / Environment - for internal and non-Quarantined applications
2.  Subscription per Application / Environment - for Quarantined applications

Option 1 is the default, should be applicable in the majority of cases where a handful of applications, owned by the same Application Owner, can share a Subscription. Option 2 applies for any Quarantined applications

In terms of what constitutes a 'handful' (x) of applications, a rough guideline is 1 \< x \< 10, i.e. when applications are sharing a Subscription, a rule of thumb should be that no more than 10 applications should share a Subscription, mainly for scalability reasons.

A [strawman](https://lucid.app/lucidchart/4005bf3a-fa13-4d90-930c-cead13888f21/edit?invitationId=inv_c036f66c-8a90-471f-9ec3-34925c33b3ba&page=Lk6Ox58RwJUS#) for D&A applications, for tranche 1, has been proposed and can be evolved/modified by D&A engineering & architecture leadership as required.

### Quarantined Applications<a href="#quarantined-applications" class="headerlink" title="Permanent link">¶</a>

Applications should be 'quarantined' into their own Subscription where they are Internet and/or external customer-facing, i.e. constitute an external-facing attack surface, require WAF or similar technologies, require PEN testing. Applications with public-facing APIs, websites, CDNs, FTP services are all common examples of apps that should be quarantined by default.

If multiple applications that should be quarantined, have the same owner, and wish to share a Subscription, this is also acceptable and conforms to the spirit of this ADR. I.e. multiple quarantined applications can share a Subscription if they have the same owner.

### Application Subnets<a href="#application-subnets" class="headerlink" title="Permanent link">¶</a>

Application families that share a Subscription should create multiple Subnets in the Subscriptions Non-Routable network to house components of each application. I.e. applications should avoid sharing Non-Routable subnets, and any cross-application traffic should occur via the Subscription's Azure Firewall instance.

The below diagram demonstrates how a 2<sup>nd</sup> application (APP2) should create its own subnet in Non-Routable network space to house its components.

![Example Topology](0012-subscription-tenancy.assets/image-001.png)

### Decision Tree<a href="#decision-tree" class="headerlink" title="Permanent link">¶</a>

![Subscription Tenancy Decision Tree](0012-subscription-tenancy.assets/image-001.png)

### Consequences<a href="#consequences" class="headerlink" title="Permanent link">¶</a>

- Good, because we promote Subscription sharing where suitable, reducing costs, in the majority of cases
- Good, because we introduce cost overhead to standalone customer-facing applications, incentivising the use of shared platforms/capabilities and common interfaces for customer-facing functionality (e.g. APIs, FTP, CDN, etc.)
- Neutral, because the fixed Azure Firewall cost is still likely to be high

## Pros and Cons of the Options<a href="#pros-and-cons-of-the-options" class="headerlink" title="Permanent link">¶</a>

### Subscription per Application / Environment<a href="#subscription-per-application-environment" class="headerlink" title="Permanent link">¶</a>

Example compression ratio - 1:1 - was previously the default option, but now applies only to Quarantined applications.

- Good, because a Subscription is a simple boundary for RBAC, Cost Management, Security and Telemetry
- Good, because Dev/QA/Pre-Prod/Prod environments maintain segregation of duties
- Good, because roles can be granted at Subscription scope, enabling creation of services that assume Subscription-level access
- Good, because blast radius is minimised
- Good, because Internet-facing attack surfaces are isolated from rest of the estate
- Bad, because greater number of Subscriptions incur greater fixed costs
- Bad, because greater numbers of Subscriptions are more complex to operate and maintain

### Subscription per Application family / Environment<a href="#subscription-per-application-family-environment" class="headerlink" title="Permanent link">¶</a>

Example compression ratio - 1:5 (assuming 5 Applications per Application family). This is the default option for internal and non-Quarantined applications.

- Good, because a Subscription is a simple boundary for RBAC, Cost Management, Security and Telemetry
- Good, because fixed costs are reduced by the compression ratio achieved, based on number of applications sharing the Subscription
- Good, because an Application family must have a single owner
- Good, because the Foundation platform can already support this model (already supports Subscriptions created for " Primary"/"Secondary" applications, and automated from LeanIX "Parent"/"Child" relationships)
- Neutral, because there is currently no LeanIX-native mechanism to model an Application family; and is modelled separately in ServiceNow (as "Primary"/"Secondary" is today). In the future automating this from an "app grouping"/" app family" feature in LeanIX is a possibility.

## More Information<a href="#more-information" class="headerlink" title="Permanent link">¶</a>

### Existing Decisions & Reference Material<a href="#existing-decisions-reference-material" class="headerlink" title="Permanent link">¶</a>

- [LSEG Operational Data - Application Definition - LMP](https://lsegroup.sharepoint.com/:p:/r/teams/LSEGLMPAppMigrationApprovers/Shared%20Documents/Architecture%20Docs%20-%20Proposals,%20Strategies%20etc/LSEG%20Operational%20Data%20-%20Application%20Definition%20-%20LMP.pptx?d=w4c71a677cae7435c97a7d296e9f7891f&csf=1&web=1&e=orbaAX)
- [STAR DA-047 - Multiple Apps in a Single Cloud Account](https://lsegroup.sharepoint.com/:w:/r/teams/LMFoundationFM/Shared%20Documents/General/02%20Design%20Docs/3%20Management,%20Cost,%20Governance%20%26%20Policy/STAR%20DA-047%20Multiple%20Apps%20in%20Single%20Cloud%20Account.docx?d=w16c2ece18d4c47c9870ff620ec84587b&csf=1&web=1&e=RfgQ10)
- [STAR DA-307 - Subscription Vending and Application Onboarding via Foundation Services Automation](https://lsegroup.sharepoint.com/:w:/r/teams/LSEGLMPAppMigrationApprovers/Shared%20Documents/Architecture%20Docs%20-%20Proposals,%20Strategies%20etc/LMP%20Architecture%20TOR%200.0.1.docx?d=w9a96c749784a4b0ca6d10d41ffa312d1&csf=1&web=1&e=eVwXaJ)
- [Heritage Refinitiv Elektron Data Platform ("EDP") AWS Account Strategy](https://confluence.refinitiv.com/pages/viewpage.action?spaceKey=FA&title=EDP+AWS+Account+Strategy)
- [D&A Subscription sharing strawman](https://lucid.app/lucidchart/4005bf3a-fa13-4d90-930c-cead13888f21/edit?invitationId=inv_c036f66c-8a90-471f-9ec3-34925c33b3ba&page=Lk6Ox58RwJUS#)

<!-- -->

- The existing Foundation platform already supports multiple apps per Subscription, via two approaches: 1. (Strongly Preferred) Primary Application + Additional Applications, via SNOW [process](https://lsegroup.sharepoint.com/sites/CloudCentral/SitePages/LMP-Azure---Additional-Application-Onboarding-to-existing-Subscriptions.aspx?xsdata=MDV8MDJ8fDU5YmNiMDkxNjVhYjRkYTc1NzhkMDhkYzljZmU1NTI0fDI4N2U5ZjBlOTFlYzRjZjBiN2E0YzYzODk4MDcyMTgxfDB8MHw2Mzg1NTc4NjMzNDM4MzkxMTd8VW5rbm93bnxWR1ZoYlhOVFpXTjFjbWwwZVZObGNuWnBZMlY4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazkwYUdWeUlpd2lWMVFpT2pFeGZRPT18MXxMMk5vWVhSekx6RTVPbVF4WkRJeU5EWmhMVEU0T0dFdE5HWTBaUzFpTnpVekxUSXdZekF5WXpFNE1ETm1OVjltTldRNFlXVmlOUzAxTlRBMkxUUmhZekV0WW1Sak5pMDNNR014WWpCak5qQTROMk5BZFc1eExtZGliQzV6Y0dGalpYTXZiV1Z6YzJGblpYTXZNVGN5TURFNE9UVXpNemd3T1E9PXwyNDQxNmI4ZDAxNzk0NDYxZjUyYjA4ZGM5Y2ZlNTUyMXxjNGE5OGIyNjk1MTA0Mjg0ODVkYTY3YTU0OGRhZDBhMw%3D%3D&sdata=TTcvQzlmdXJHNUFXTlpoTHFrdWZsY0FGaHN2cXVIdmoyeXdKQXhxQkgrYz0%3D&ovuser=287e9f0e-91ec-4cf0-b7a4-c63898072181%2CPaul.Murphy1%40lseg.com&OR=Teams-HL&CT=1720189537018&clickparams=eyJBcHBOYW1lIjoiVGVhbXMtRGVza3RvcCIsIkFwcFZlcnNpb24iOiI1MC8yNDA1MzEwMTQyMSIsIkhhc0ZlZGVyYXRlZFVzZXIiOmZhbHNlfQ%3D%3D) 2. (Strongly Discouraged) Parent-Child Application modelling

![Existing Foundation multi-app support](0012-subscription-tenancy.assets/image-001.png)

<span class="md-source-file__fact"> <span class="md-icon" title="Last update"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIxIDEzLjFjLS4xIDAtLjMuMS0uNC4ybC0xIDEgMi4xIDIuMSAxLTFjLjItLjIuMi0uNiAwLS44bC0xLjMtMS4zYy0uMS0uMS0uMi0uMi0uNC0uMm0tMS45IDEuOC02LjEgNlYyM2gyLjFsNi4xLTYuMXpNMTIuNSA3djUuMmw0IDIuNC0xIDFMMTEgMTNWN3pNMTEgMjEuOWMtNS4xLS41LTktNC44LTktOS45QzIgNi41IDYuNSAyIDEyIDJjNS4zIDAgOS42IDQuMSAxMCA5LjMtLjMtLjEtLjYtLjItMS0uMnMtLjcuMS0xIC4yQzE5LjYgNy4yIDE2LjIgNCAxMiA0Yy00LjQgMC04IDMuNi04IDggMCA0LjEgMy4xIDcuNSA3LjEgNy45bC0uMS4yeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="March 13, 2025 10:48:28 UTC">March 13, 2025</span> </span> <span class="md-source-file__fact"> <span class="md-icon" title="Created"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE0LjQ3IDE1LjA4IDExIDEzVjdoMS41djUuMjVsMy4wOCAxLjgzYy0uNDEuMjgtLjc5LjYyLTEuMTEgMW0tMS4zOSA0Ljg0Yy0uMzYuMDUtLjcxLjA4LTEuMDguMDgtNC40MiAwLTgtMy41OC04LThzMy41OC04IDgtOCA4IDMuNTggOCA4YzAgLjM3LS4wMy43Mi0uMDggMS4wOC42OS4xIDEuMzMuMzIgMS45Mi42NC4xLS41Ni4xNi0xLjEzLjE2LTEuNzIgMC01LjUtNC41LTEwLTEwLTEwUzIgNi41IDIgMTJzNC40NyAxMCAxMCAxMGMuNTkgMCAxLjE2LS4wNiAxLjcyLS4xNi0uMzItLjU5LS41NC0xLjIzLS42NC0xLjkyTTE4IDE1djNoLTN2MmgzdjNoMnYtM2gzdi0yaC0zdi0zeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="October 16, 2024 10:19:51 UTC">October 16, 2024</span> </span>

<a href="../0006-subscription-tenancy/" class="md-footer__link md-footer__link--prev" aria-label="Previous: Prefer a Subscription per Application family-Environment (or App-Environment, if no Application family exists)"></a>

<div class="md-footer__button md-icon">

![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIwIDExdjJIOGw1LjUgNS41LTEuNDIgMS40Mkw0LjE2IDEybDcuOTItNy45MkwxMy41IDUuNSA4IDExeiIgLz48L3N2Zz4=)

</div>

<div class="md-footer__title">

<span class="md-footer__direction"> Previous </span>

<div class="md-ellipsis">

Prefer a Subscription per Application family-Environment (or App-Environment, if no Application family exists)

</div>

</div>

<a href="../0017-reserved-instances-for-production-baseload/" class="md-footer__link md-footer__link--next" aria-label="Next: Azure Reservations for Production Baseload"></a>

<div class="md-footer__title">

<span class="md-footer__direction"> Next </span>

<div class="md-ellipsis">

Azure Reservations for Production Baseload

</div>

</div>

<div class="md-footer__button md-icon">

![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTQgMTF2MmgxMmwtNS41IDUuNSAxLjQyIDEuNDJMMTkuODQgMTJsLTcuOTItNy45MkwxMC41IDUuNSAxNiAxMXoiIC8+PC9zdmc+)

</div>

<div class="md-footer-meta md-typeset">

<div class="md-footer-meta__inner md-grid">

<div class="md-copyright">

Made with <a href="https://squidfunk.github.io/mkdocs-material/" target="_blank" rel="noopener">Material for MkDocs</a>

</div>

</div>

</div>

<div class="md-dialog" md-component="dialog">

<div class="md-dialog__inner md-typeset">

</div>

</div>
