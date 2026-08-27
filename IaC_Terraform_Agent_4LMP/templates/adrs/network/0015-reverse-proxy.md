---
id: LMP-ADR-0015
type: ADR
status: published
approved_by:
  - LMP Migration Architecture Approval
valid_from: 2024-12-09
date: 2024-12-09
tags:
  - Network
tech_capabilities:
  - Infrastructure / Network
---

# API Providers to remove particular dependencies on 'Eikon Reverse Proxy' (APP-202047) as they migrate to Azure

## Context and Problem Statement

The Eikon Reverse Proxy, [APP-202047][APP-202047], is an old, on-premise API proxy for HTTP APIs, with associated
obsolescence risks and limited ability in terms of support. It was a critical component of the Eikon product ecosystem,
but as Workspace evolves and migrates ever more of its access and web layer to public cloud, the on-premise Reverse
Proxy has an ever-reducing role to play, and consequently the application has been excluded from the LMP perimeter (
Retire R-type).

For the API Provider applications that leverage it today on-premise, it is providing various features:

1. Routing & API federation - from Eikon/Workspace clients
2. Authentication - for Eikon/Workspace client applications
3. Routing & API federation - from internal application clients
4. Site failover - for API providers / backends

Functions 1 and 2, for Eikon/Workspace client applications, remain important regarding product compatibility, until a
major future migration occurs of the Workspace ecosystem to a new, Azure-based routing layer (still in development).
The [Eikon Reverse Proxy Dog-Leg Mitigation pattern][rp-mitigation] must be followed for API provider applications that
serve Eikon/Workspace clients.
However, for functions 3 and 4, in 2024, these can easily be provided by CSP PaaS services and other LSEG strategic
services.

In summary:

- re. 3, all internal client applications must cease use of Reverse Proxy, once API provider has migrated to Azure
- re. 4, all API providers must cater for their own site/region failover, and not rely on Reverse Proxy for this
  function
- re. 1 & 2, the ONLY remaining client applications continuing to leverage Reverse Proxy, after API provider has
  migrated to Azure, are Eikon/Workspace, as per the aforementioned customer mitigation [pattern][rp-mitigation].

From Reverse Proxy configuration data, it is believed the following applications are API providers on Reverse Proxy,
that constitute the scope of this ADR:

| Application                                         | APP-ID                   |
|-----------------------------------------------------|--------------------------|
| Deal Tracker as a Service                           | [APP-204846][APP-204846] |
| APT - Strategic Alerts                              | [APP-205884][APP-205884] |
| Datastream                                          | [APP-200037][APP-200037] |
| Analytics Platform Portfolio Analytics and List API | [APP-204992][APP-204992] |
| Data Cloud API                                      | [APP-202631][APP-202631] |
| Eikon Infrastructure - Jupyter Hub                  | [APP-205826][APP-205826] |
| Workspace Auto Suggest                              | [APP-250295][APP-250295] |
| Search Elasticsearch and Web Services               | [APP-206441][APP-206441] |
| Event Platform                                      | [APP-205230][APP-205230] |
| Economics DBoR                                      | [APP-202029][APP-202029] |

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

Applications that leverage Reverse Proxy on-premise, as an API provider, must remove dependencies in the functional
cases 3 & 4 described above, at the point
they migrate to Azure. Of the above options, all are valid, depending on the API provider scenario.

For Routing & API Federation, for internal services with internal clients, either of the following options are
preferred, depending on the nature of the API:

- Use of Azure APIM Management - for Internal API proxying
- Use of one of several Kong API Gateways - for External API proxying, Data Platform and Workspace instances exist

For regional failover, if relevant, a source-to-target pattern
for [Regional Failover for Private Services][regional-failover] discusses this in more detail:

- Use of Azure LB + RIANA for virtual DNS-based failover - for regional failover of private services
- Use of Azure Route Server / Anycast - for more sophisticated load-balancing and regional failover of private services

### Consequences

- Good, because as each API provider application migrates to Azure, dependency on Reverse Proxy reduces
- Good, because this approach will remove otherwise superfluous flows between Azure and on-premise
- Good, because it will de-couple applications from a legacy shared service, and provide autonomy in operation
- Bad, because it might inflate R-type of migrating application that, on-premise, leveraged Reverse Proxy

### Confirmation

The decision was validated by the D&A architecture community, the LMP architecture community, and Workspace Engineering
team who own Reverse Proxy.

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

[rp-mitigation]: https://app.pages.dx1.lseg.com/app-51723/migration-patterns/mig-pat-source-to-target/patterns/service-delivery/0020-rp-mitigation/

[APP-202047]: https://lseg.leanix.net/LsegPROD/external/applicationId/APP-202047

[APP-204846]: https://lseg.leanix.net/LsegPROD/external/applicationId/APP-204846

[APP-205884]: https://lseg.leanix.net/LsegPROD/external/applicationId/APP-205884

[APP-200037]: https://lseg.leanix.net/LsegPROD/external/applicationId/APP-200037

[APP-204992]: https://lseg.leanix.net/LsegPROD/external/applicationId/APP-204992

[APP-202631]: https://lseg.leanix.net/LsegPROD/external/applicationId/APP-202631

[APP-205826]: https://lseg.leanix.net/LsegPROD/external/applicationId/APP-205826

[APP-250295]: https://lseg.leanix.net/LsegPROD/external/applicationId/APP-250295

[APP-206441]: https://lseg.leanix.net/LsegPROD/external/applicationId/APP-206441

[APP-205230]: https://lseg.leanix.net/LsegPROD/external/applicationId/APP-205230

[APP-202029]: https://lseg.leanix.net/LsegPROD/external/applicationId/APP-202029

