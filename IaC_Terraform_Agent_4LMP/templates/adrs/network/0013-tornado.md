---
id: LMP-ADR-0013
type: ADR
status: published
approved_by:
  - LMP Migration Architecture Approval
date: 2024-12-05
valid_from: 2024-12-05
tags:
  - Network
tech_capabilities:
  - Infrastructure / Network
---

# API Providers to remove dependencies on Tornado (APP-202052) as they migrate to Azure

## Context and Problem Statement

'Eikon Edge Infrastructure Tornado for CP', or Tornado, APP-202052, is a highly fragile, on-premise API proxy for SOAP
APIs, with severe associated obsolescence risks.
It has suffered numerous outages in recent years, LSEG still retain its source code but no longer have any individuals
familiar with it, or with sufficient knowledge to recover it from complete failure. The application is outside the LMP
perimeter (Retire R-type).

For the SOAP API Provider applications that leverage it today on-premise, it is providing, in various cases a
combination of, i) API federation and ii) site failover, in combination with RIANA/Banana.

In 2024, these functions can easily be provided by CSP PaaS services, and other LSEG strategic services (e.g. RIANA).

From Tornado configuration information, it is believed that the following applications are API providers on Tornado:

| Application                                 | APP-ID                   |
|---------------------------------------------|--------------------------|
| AAA COMMON PLATFORM CORE                    | [APP-201864][APP-201864] |
| Commodities DBoR Backend                    | [APP-202978][APP-202978] |
| Data Cloud API                              | [APP-202631][APP-202631] |
| EJV                                         | [APP-200016][APP-200016] |
| I&A Banking & Research Deals NG             | [APP-201872][APP-201872] |
| I&A Investment Management CP Estimates      | [APP-202549][APP-202549] |
| I&A Investment Management Content Economics | [APP-202029][APP-202029] |
| Lipper                                      | [APP-200065][APP-200065] |
| NDA                                         | [APP-200069][APP-200069] |
| News Entry Point                            | [APP-206271][APP-206271] |
| DB Calcs                                    | [APP-204807][APP-204807] |
| StreetEvents                                | [APP-201942][APP-201942] |

## Decision Drivers

The decision is driven by:

- Desire for reduction of obsolescence risks, Path-to-Amber (PtA), etc.
- Desire for simplification of data flows, for applications migrated to Azure - i.e. avoiding unnecessary hops back to
  on-premise, for specific functions
- Desire for de-coupled and autonomous functioning of applications migrated to Azure - to simplify operability

## Considered Options

- Use of Azure APIM Management
- Use of one of several Kong API Gateways
- Use of Azure LB + RIANA for virtual DNS-based failover
- Use of Azure Route Server / Anycast

## Decision Outcome

Applications that leverage Tornado on-premise, as an API provider, must remove their dependencies on it at the point
they migrate to Azure. Of the above options, all are valid, depending on the on-premise Tornado API provider scenario.

For API proxying, either of the following options are preferred, depending on the nature of the API:

- Use of Azure APIM Management - for Internal API proxying
- Use of one of several Kong API Gateways - for External API proxying, Data Platform and Workspace instances exist

For regional failover, if relevant, a source-to-target pattern
for [Regional Failover for Private Services][regional-failover] discusses this in more detail:

- Use of Azure LB + RIANA for virtual DNS-based failover - for regional failover of private services
- Use of Azure Route Server / Anycast - for more sophisticated load-balancing and regional failover of private services

### Consequences

- Good, because as each API provider application migrates to Azure, dependency on Tornado reduces
- Good, because this approach will remove otherwise superfluous flows between Azure and on-premise
- Good, because it will de-couple applications from a legacy shared service, and provide autonomy in operation
- Bad, because it might inflate R-type of migrating application that, on-premise, leveraged Tornado

### Confirmation

The decision was validated by the D&A architecture community, the LMP architecture community, and Tornado Engineering
team.

## Pros and Cons of the Options

### Azure API Management

Pros/cons are described in more detail in the [D&A API Strategy][api-strategy].

### External Kong API Gateways

Pros/cons are described in more detail in the [D&A API Strategy][api-strategy].

### Azure LB + RIANA

Options are described in more detail in the source-to-target pattern
for [Regional Failover for Private Services][regional-failover].

### Azure Route Server / Anycast

Options are described in more detail in the source-to-target pattern
for [Regional Failover for Private Services][regional-failover].

## More Information

This decision may be revisited when:

- Microsoft have shared with LSEG a lower-cost, simpler PaaS API Gateway technology, due for public launch in 2025

[api-strategy]: https://lsegroup.sharepoint.com/:p:/r/teams/LSEGLMPAppMigrationApprovers/_layouts/15/Doc2.aspx?action=edit&sourcedoc=%7B4529665b-39e3-4cc4-be47-920ea4439e4d%7D&wdOrigin=TEAMS-MAGLEV.teamsSdk_ns.rwc&wdExp=TEAMS-TREATMENT&wdhostclicktime=1733400854744&web=1

[regional-failover]: https://app.pages.dx1.lseg.com/app-51723/migration-patterns/mig-pat-source-to-target/patterns/business-continuity-disaster-recovery/0031-region-failover-private/

[APP-201864]: https://lseg.leanix.net/LsegPROD/external/applicationId/APP-201864
[APP-202978]: https://lseg.leanix.net/LsegPROD/external/applicationId/APP-202978
[APP-202631]: https://lseg.leanix.net/LsegPROD/external/applicationId/APP-202631
[APP-200016]: https://lseg.leanix.net/LsegPROD/external/applicationId/APP-200016
[APP-201872]: https://lseg.leanix.net/LsegPROD/external/applicationId/APP-201872
[APP-202549]: https://lseg.leanix.net/LsegPROD/external/applicationId/APP-202549
[APP-202029]: https://lseg.leanix.net/LsegPROD/external/applicationId/APP-202029
[APP-200065]: https://lseg.leanix.net/LsegPROD/external/applicationId/APP-200065
[APP-200069]: https://lseg.leanix.net/LsegPROD/external/applicationId/APP-200069
[APP-206271]: https://lseg.leanix.net/LsegPROD/external/applicationId/APP-206271
[APP-204807]: https://lseg.leanix.net/LsegPROD/external/applicationId/APP-204807
[APP-201942]: https://lseg.leanix.net/LsegPROD/external/applicationId/APP-201942

