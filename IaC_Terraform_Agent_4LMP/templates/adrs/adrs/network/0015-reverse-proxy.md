<span class="md-content__button md-icon md-status--published" href="#" title="Status: Published"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE4LjUgMmgtMTNDMy42IDIgMiAzLjYgMiA1LjV2MTNDMiAyMC40IDMuNiAyMiA1LjUgMjJIMTZsNi02VjUuNUMyMiAzLjYgMjAuNCAyIDE4LjUgMk0yMCAxNWgtMS41Yy0xLjkgMC0zLjUgMS42LTMuNSAzLjVWMjBINS44Yy0xIDAtMS44LS44LTEuOC0xLjhWNS44QzQgNC44IDQuOCA0IDUuOCA0aDEyLjVjMSAwIDEuOC44IDEuOCAxLjhWMTVtLTQuOS02LjggMS41IDEuNS02IDYtMy41LTMuNSAxLjUtMS41IDIgMnoiIC8+PC9zdmc+) </span> <span class="md-content__button md-icon .md-status--published" title="Valid from 2024-12-09"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE5IDE5SDVWOGgxNG0wLTVoLTFWMWgtMnYySDhWMUg2djJINWEyIDIgMCAwIDAtMiAydjE0YTIgMiAwIDAgMCAyIDJoMTRhMiAyIDAgMCAwIDItMlY1YTIgMiAwIDAgMC0yLTJtLTIuNDcgOC4wNkwxNS40NyAxMGwtNC44OCA0Ljg4LTIuMTItMi4xMi0xLjA2IDEuMDZMMTAuNTkgMTd6IiAvPjwvc3ZnPg==) </span> <span class="md-content__button md-icon actions-date" title="Published on 2024-12-09">![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTkgMTB2Mkg3di0yem00IDB2MmgtMnYtMnptNCAwdjJoLTJ2LTJ6bTItN2EyIDIgMCAwIDEgMiAydjE0YTIgMiAwIDAgMS0yIDJINWEyIDIgMCAwIDEtMi0yVjVhMiAyIDAgMCAxIDItMmgxVjFoMnYyaDhWMWgydjJ6bTAgMTZWOEg1djExek05IDE0djJIN3YtMnptNCAwdjJoLTJ2LTJ6bTQgMHYyaC0ydi0yeiIgLz48L3N2Zz4=)</span> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/edit/main/docs/adrs/network/0015-reverse-proxy.md" class="md-content__button md-icon" title="Edit this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTEwIDIwSDZWNGg3djVoNXYzLjFsMi0yVjhsLTYtNkg2Yy0xLjEgMC0yIC45LTIgMnYxNmMwIDEuMS45IDIgMiAyaDR6bTEwLjItN2MuMSAwIC4zLjEuNC4ybDEuMyAxLjNjLjIuMi4yLjYgMCAuOGwtMSAxLTIuMS0yLjEgMS0xYy4xLS4xLjItLjIuNC0uMm0wIDMuOUwxNC4xIDIzSDEydi0yLjFsNi4xLTYuMXoiIC8+PC9zdmc+" /></a> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/blob/main/docs/adrs/network/0015-reverse-proxy.md" class="md-content__button md-icon" title="View source of this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE3IDE4Yy41NiAwIDEgLjQ0IDEgMXMtLjQ0IDEtMSAxLTEtLjQ0LTEtMSAuNDQtMSAxLTFtMC0zYy0yLjczIDAtNS4wNiAxLjY2LTYgNCAuOTQgMi4zNCAzLjI3IDQgNiA0czUuMDYtMS42NiA2LTRjLS45NC0yLjM0LTMuMjctNC02LTRtMCA2LjVhMi41IDIuNSAwIDAgMS0yLjUtMi41IDIuNSAyLjUgMCAwIDEgMi41LTIuNSAyLjUgMi41IDAgMCAxIDIuNSAyLjUgMi41IDIuNSAwIDAgMS0yLjUgMi41TTkuMjcgMjBINlY0aDd2NWg1djQuMDdjLjcuMDggMS4zNi4yNSAyIC40OVY4bC02LTZINmEyIDIgMCAwIDAtMiAydjE2YTIgMiAwIDAgMCAyIDJoNC41YTguMiA4LjIgMCAwIDEtMS4yMy0yIiAvPjwvc3ZnPg==" /></a>

Document Metadata

|  |  |
|----|----|
| Identifier | **`LMP-ADR-0015`** |
| Type | **ADR** |
| Status | **Published** |
| Approvals | <span class="md-tag">LMP Migration Architecture Approval</span> |
| Published on | **December 09, 2024** |
| Valid From | **December 09, 2024** |
| Authors | <span class="md-source-file__fact"> </span> |
| Tags | <span class="md-tag">Network</span> |
| Technology Capabilities | <span class="md-tag">Infrastructure / Network</span> |

# API Providers to remove particular dependencies on 'Eikon Reverse Proxy' (APP-202047) as they migrate to Azure<a href="#api-providers-to-remove-particular-dependencies-on-eikon-reverse-proxy-app-202047-as-they-migrate-to-azure" class="headerlink" title="Permanent link">¶</a>

## Context and Problem Statement<a href="#context-and-problem-statement" class="headerlink" title="Permanent link">¶</a>

The Eikon Reverse Proxy, [APP-202047](https://lseg.leanix.net/LsegPROD/external/applicationId/APP-202047), is an old, on-premise API proxy for HTTP APIs, with associated obsolescence risks and limited ability in terms of support. It was a critical component of the Eikon product ecosystem, but as Workspace evolves and migrates ever more of its access and web layer to public cloud, the on-premise Reverse Proxy has an ever-reducing role to play, and consequently the application has been excluded from the LMP perimeter ( Retire R-type).

For the API Provider applications that leverage it today on-premise, it is providing various features:

1.  Routing & API federation - from Eikon/Workspace clients
2.  Authentication - for Eikon/Workspace client applications
3.  Routing & API federation - from internal application clients
4.  Site failover - for API providers / backends

Functions 1 and 2, for Eikon/Workspace client applications, remain important regarding product compatibility, until a major future migration occurs of the Workspace ecosystem to a new, Azure-based routing layer (still in development). The [Eikon Reverse Proxy Dog-Leg Mitigation pattern](https://app.pages.dx1.lseg.com/app-51723/migration-patterns/mig-pat-source-to-target/patterns/service-delivery/0020-rp-mitigation/) must be followed for API provider applications that serve Eikon/Workspace clients. However, for functions 3 and 4, in 2024, these can easily be provided by CSP PaaS services and other LSEG strategic services.

In summary:

- re. 3, all internal client applications must cease use of Reverse Proxy, once API provider has migrated to Azure
- re. 4, all API providers must cater for their own site/region failover, and not rely on Reverse Proxy for this function
- re. 1 & 2, the ONLY remaining client applications continuing to leverage Reverse Proxy, after API provider has migrated to Azure, are Eikon/Workspace, as per the aforementioned customer mitigation [pattern](https://app.pages.dx1.lseg.com/app-51723/migration-patterns/mig-pat-source-to-target/patterns/service-delivery/0020-rp-mitigation/).

From Reverse Proxy configuration data, it is believed the following applications are API providers on Reverse Proxy, that constitute the scope of this ADR:

| Application | APP-ID |
|----|----|
| Deal Tracker as a Service | [APP-204846](https://lseg.leanix.net/LsegPROD/external/applicationId/APP-204846) |
| APT - Strategic Alerts | [APP-205884](https://lseg.leanix.net/LsegPROD/external/applicationId/APP-205884) |
| Datastream | [APP-200037](https://lseg.leanix.net/LsegPROD/external/applicationId/APP-200037) |
| Analytics Platform Portfolio Analytics and List API | [APP-204992](https://lseg.leanix.net/LsegPROD/external/applicationId/APP-204992) |
| Data Cloud API | [APP-202631](https://lseg.leanix.net/LsegPROD/external/applicationId/APP-202631) |
| Eikon Infrastructure - Jupyter Hub | [APP-205826](https://lseg.leanix.net/LsegPROD/external/applicationId/APP-205826) |
| Workspace Auto Suggest | [APP-250295](https://lseg.leanix.net/LsegPROD/external/applicationId/APP-250295) |
| Search Elasticsearch and Web Services | [APP-206441](https://lseg.leanix.net/LsegPROD/external/applicationId/APP-206441) |
| Event Platform | [APP-205230](https://lseg.leanix.net/LsegPROD/external/applicationId/APP-205230) |
| Economics DBoR | [APP-202029](https://lseg.leanix.net/LsegPROD/external/applicationId/APP-202029) |

## Decision Drivers<a href="#decision-drivers" class="headerlink" title="Permanent link">¶</a>

The decision is driven by:

- Desire for reduction of obsolescence risks, Path-to-Amber (PtA), etc.
- Desire for simplification of data flows, for applications migrated to Azure - i.e. avoiding unnecessary hops back to on-premise, for specific functions
- Desire for de-coupled and autonomous functioning of applications migrated to Azure - to simplify operability

## Considered Options<a href="#considered-options" class="headerlink" title="Permanent link">¶</a>

- Use of Azure APIM Management
- Use of one of several Kong API Gateways
- Use of Azure LB + RIANA for virtual DNS-based failover
- Use of Azure Route Server / Anycast

## Decision Outcome<a href="#decision-outcome" class="headerlink" title="Permanent link">¶</a>

Applications that leverage Reverse Proxy on-premise, as an API provider, must remove dependencies in the functional cases 3 & 4 described above, at the point they migrate to Azure. Of the above options, all are valid, depending on the API provider scenario.

For Routing & API Federation, for internal services with internal clients, either of the following options are preferred, depending on the nature of the API:

- Use of Azure APIM Management - for Internal API proxying
- Use of one of several Kong API Gateways - for External API proxying, Data Platform and Workspace instances exist

For regional failover, if relevant, a source-to-target pattern for [Regional Failover for Private Services](https://app.pages.dx1.lseg.com/app-51723/migration-patterns/mig-pat-source-to-target/patterns/business-continuity-disaster-recovery/0031-region-failover-private/) discusses this in more detail:

- Use of Azure LB + RIANA for virtual DNS-based failover - for regional failover of private services
- Use of Azure Route Server / Anycast - for more sophisticated load-balancing and regional failover of private services

### Consequences<a href="#consequences" class="headerlink" title="Permanent link">¶</a>

- Good, because as each API provider application migrates to Azure, dependency on Reverse Proxy reduces
- Good, because this approach will remove otherwise superfluous flows between Azure and on-premise
- Good, because it will de-couple applications from a legacy shared service, and provide autonomy in operation
- Bad, because it might inflate R-type of migrating application that, on-premise, leveraged Reverse Proxy

### Confirmation<a href="#confirmation" class="headerlink" title="Permanent link">¶</a>

The decision was validated by the D&A architecture community, the LMP architecture community, and Workspace Engineering team who own Reverse Proxy.

## Pros and Cons of the Options<a href="#pros-and-cons-of-the-options" class="headerlink" title="Permanent link">¶</a>

### Azure API Management<a href="#azure-api-management" class="headerlink" title="Permanent link">¶</a>

Pros/cons are described in more detail in the [D&A API Strategy](https://lsegroup.sharepoint.com/:p:/r/teams/LSEGLMPAppMigrationApprovers/_layouts/15/Doc2.aspx?action=edit&sourcedoc=%7B4529665b-39e3-4cc4-be47-920ea4439e4d%7D&wdOrigin=TEAMS-MAGLEV.teamsSdk_ns.rwc&wdExp=TEAMS-TREATMENT&wdhostclicktime=1733400854744&web=1).

### External Kong API Gateways<a href="#external-kong-api-gateways" class="headerlink" title="Permanent link">¶</a>

Pros/cons are described in more detail in the [D&A API Strategy](https://lsegroup.sharepoint.com/:p:/r/teams/LSEGLMPAppMigrationApprovers/_layouts/15/Doc2.aspx?action=edit&sourcedoc=%7B4529665b-39e3-4cc4-be47-920ea4439e4d%7D&wdOrigin=TEAMS-MAGLEV.teamsSdk_ns.rwc&wdExp=TEAMS-TREATMENT&wdhostclicktime=1733400854744&web=1).

### Azure LB + RIANA<a href="#azure-lb-riana" class="headerlink" title="Permanent link">¶</a>

Options are described in more detail in the source-to-target pattern for [Regional Failover for Private Services](https://app.pages.dx1.lseg.com/app-51723/migration-patterns/mig-pat-source-to-target/patterns/business-continuity-disaster-recovery/0031-region-failover-private/).

### Azure Route Server / Anycast<a href="#azure-route-server-anycast" class="headerlink" title="Permanent link">¶</a>

Options are described in more detail in the source-to-target pattern for [Regional Failover for Private Services](https://app.pages.dx1.lseg.com/app-51723/migration-patterns/mig-pat-source-to-target/patterns/business-continuity-disaster-recovery/0031-region-failover-private/).

## More Information<a href="#more-information" class="headerlink" title="Permanent link">¶</a>

This decision may be revisited when:

- Microsoft have shared with LSEG a lower-cost, simpler PaaS API Gateway technology, due for public launch in 2025

<span class="md-source-file__fact"> <span class="md-icon" title="Last update"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIxIDEzLjFjLS4xIDAtLjMuMS0uNC4ybC0xIDEgMi4xIDIuMSAxLTFjLjItLjIuMi0uNiAwLS44bC0xLjMtMS4zYy0uMS0uMS0uMi0uMi0uNC0uMm0tMS45IDEuOC02LjEgNlYyM2gyLjFsNi4xLTYuMXpNMTIuNSA3djUuMmw0IDIuNC0xIDFMMTEgMTNWN3pNMTEgMjEuOWMtNS4xLS41LTktNC44LTktOS45QzIgNi41IDYuNSAyIDEyIDJjNS4zIDAgOS42IDQuMSAxMCA5LjMtLjMtLjEtLjYtLjItMS0uMnMtLjcuMS0xIC4yQzE5LjYgNy4yIDE2LjIgNCAxMiA0Yy00LjQgMC04IDMuNi04IDggMCA0LjEgMy4xIDcuNSA3LjEgNy45bC0uMS4yeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="August 27, 2025 09:23:44 UTC">August 27, 2025</span> </span> <span class="md-source-file__fact"> <span class="md-icon" title="Created"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE0LjQ3IDE1LjA4IDExIDEzVjdoMS41djUuMjVsMy4wOCAxLjgzYy0uNDEuMjgtLjc5LjYyLTEuMTEgMW0tMS4zOSA0Ljg0Yy0uMzYuMDUtLjcxLjA4LTEuMDguMDgtNC40MiAwLTgtMy41OC04LThzMy41OC04IDgtOCA4IDMuNTggOCA4YzAgLjM3LS4wMy43Mi0uMDggMS4wOC42OS4xIDEuMzMuMzIgMS45Mi42NC4xLS41Ni4xNi0xLjEzLjE2LTEuNzIgMC01LjUtNC41LTEwLTEwLTEwUzIgNi41IDIgMTJzNC40NyAxMCAxMCAxMGMuNTkgMCAxLjE2LS4wNiAxLjcyLS4xNi0uMzItLjU5LS41NC0xLjIzLS42NC0xLjkyTTE4IDE1djNoLTN2MmgzdjNoMnYtM2gzdi0yaC0zdi0zeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="March 10, 2025 11:42:40 UTC">March 10, 2025</span> </span>

<a href="../0013-tornado/" class="md-footer__link md-footer__link--prev" aria-label="Previous: API Providers to remove dependencies on Tornado (APP-202052) as they migrate to Azure"></a>

<div class="md-footer__button md-icon">

![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIwIDExdjJIOGw1LjUgNS41LTEuNDIgMS40Mkw0LjE2IDEybDcuOTItNy45MkwxMy41IDUuNSA4IDExeiIgLz48L3N2Zz4=)

</div>

<div class="md-footer__title">

<span class="md-footer__direction"> Previous </span>

<div class="md-ellipsis">

API Providers to remove dependencies on Tornado (APP-202052) as they migrate to Azure

</div>

</div>

<a href="../../user-experience-layer/0007-replace-silverlight-with-react/" class="md-footer__link md-footer__link--next" aria-label="Next: Replace Silverlight with React"></a>

<div class="md-footer__title">

<span class="md-footer__direction"> Next </span>

<div class="md-ellipsis">

Replace Silverlight with React

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
