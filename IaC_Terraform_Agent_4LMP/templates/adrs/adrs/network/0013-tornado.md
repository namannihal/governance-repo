<span class="md-content__button md-icon md-status--published" href="#" title="Status: Published"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE4LjUgMmgtMTNDMy42IDIgMiAzLjYgMiA1LjV2MTNDMiAyMC40IDMuNiAyMiA1LjUgMjJIMTZsNi02VjUuNUMyMiAzLjYgMjAuNCAyIDE4LjUgMk0yMCAxNWgtMS41Yy0xLjkgMC0zLjUgMS42LTMuNSAzLjVWMjBINS44Yy0xIDAtMS44LS44LTEuOC0xLjhWNS44QzQgNC44IDQuOCA0IDUuOCA0aDEyLjVjMSAwIDEuOC44IDEuOCAxLjhWMTVtLTQuOS02LjggMS41IDEuNS02IDYtMy41LTMuNSAxLjUtMS41IDIgMnoiIC8+PC9zdmc+) </span> <span class="md-content__button md-icon .md-status--published" title="Valid from 2024-12-05"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE5IDE5SDVWOGgxNG0wLTVoLTFWMWgtMnYySDhWMUg2djJINWEyIDIgMCAwIDAtMiAydjE0YTIgMiAwIDAgMCAyIDJoMTRhMiAyIDAgMCAwIDItMlY1YTIgMiAwIDAgMC0yLTJtLTIuNDcgOC4wNkwxNS40NyAxMGwtNC44OCA0Ljg4LTIuMTItMi4xMi0xLjA2IDEuMDZMMTAuNTkgMTd6IiAvPjwvc3ZnPg==) </span> <span class="md-content__button md-icon actions-date" title="Published on 2024-12-05">![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTkgMTB2Mkg3di0yem00IDB2MmgtMnYtMnptNCAwdjJoLTJ2LTJ6bTItN2EyIDIgMCAwIDEgMiAydjE0YTIgMiAwIDAgMS0yIDJINWEyIDIgMCAwIDEtMi0yVjVhMiAyIDAgMCAxIDItMmgxVjFoMnYyaDhWMWgydjJ6bTAgMTZWOEg1djExek05IDE0djJIN3YtMnptNCAwdjJoLTJ2LTJ6bTQgMHYyaC0ydi0yeiIgLz48L3N2Zz4=)</span> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/edit/main/docs/adrs/network/0013-tornado.md" class="md-content__button md-icon" title="Edit this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTEwIDIwSDZWNGg3djVoNXYzLjFsMi0yVjhsLTYtNkg2Yy0xLjEgMC0yIC45LTIgMnYxNmMwIDEuMS45IDIgMiAyaDR6bTEwLjItN2MuMSAwIC4zLjEuNC4ybDEuMyAxLjNjLjIuMi4yLjYgMCAuOGwtMSAxLTIuMS0yLjEgMS0xYy4xLS4xLjItLjIuNC0uMm0wIDMuOUwxNC4xIDIzSDEydi0yLjFsNi4xLTYuMXoiIC8+PC9zdmc+" /></a> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/blob/main/docs/adrs/network/0013-tornado.md" class="md-content__button md-icon" title="View source of this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE3IDE4Yy41NiAwIDEgLjQ0IDEgMXMtLjQ0IDEtMSAxLTEtLjQ0LTEtMSAuNDQtMSAxLTFtMC0zYy0yLjczIDAtNS4wNiAxLjY2LTYgNCAuOTQgMi4zNCAzLjI3IDQgNiA0czUuMDYtMS42NiA2LTRjLS45NC0yLjM0LTMuMjctNC02LTRtMCA2LjVhMi41IDIuNSAwIDAgMS0yLjUtMi41IDIuNSAyLjUgMCAwIDEgMi41LTIuNSAyLjUgMi41IDAgMCAxIDIuNSAyLjUgMi41IDIuNSAwIDAgMS0yLjUgMi41TTkuMjcgMjBINlY0aDd2NWg1djQuMDdjLjcuMDggMS4zNi4yNSAyIC40OVY4bC02LTZINmEyIDIgMCAwIDAtMiAydjE2YTIgMiAwIDAgMCAyIDJoNC41YTguMiA4LjIgMCAwIDEtMS4yMy0yIiAvPjwvc3ZnPg==" /></a>

Document Metadata

|  |  |
|----|----|
| Identifier | **`LMP-ADR-0013`** |
| Type | **ADR** |
| Status | **Published** |
| Approvals | <span class="md-tag">LMP Migration Architecture Approval</span> |
| Published on | **December 05, 2024** |
| Valid From | **December 05, 2024** |
| Authors | <span class="md-source-file__fact"> </span> |
| Tags | <span class="md-tag">Network</span> |
| Technology Capabilities | <span class="md-tag">Infrastructure / Network</span> |

# API Providers to remove dependencies on Tornado (APP-202052) as they migrate to Azure<a href="#api-providers-to-remove-dependencies-on-tornado-app-202052-as-they-migrate-to-azure" class="headerlink" title="Permanent link">¶</a>

## Context and Problem Statement<a href="#context-and-problem-statement" class="headerlink" title="Permanent link">¶</a>

'Eikon Edge Infrastructure Tornado for CP', or Tornado, APP-202052, is a highly fragile, on-premise API proxy for SOAP APIs, with severe associated obsolescence risks. It has suffered numerous outages in recent years, LSEG still retain its source code but no longer have any individuals familiar with it, or with sufficient knowledge to recover it from complete failure. The application is outside the LMP perimeter (Retire R-type).

For the SOAP API Provider applications that leverage it today on-premise, it is providing, in various cases a combination of, i) API federation and ii) site failover, in combination with RIANA/Banana.

In 2024, these functions can easily be provided by CSP PaaS services, and other LSEG strategic services (e.g. RIANA).

From Tornado configuration information, it is believed that the following applications are API providers on Tornado:

| Application | APP-ID |
|----|----|
| AAA COMMON PLATFORM CORE | [APP-201864](https://lseg.leanix.net/LsegPROD/external/applicationId/APP-201864) |
| Commodities DBoR Backend | [APP-202978](https://lseg.leanix.net/LsegPROD/external/applicationId/APP-202978) |
| Data Cloud API | [APP-202631](https://lseg.leanix.net/LsegPROD/external/applicationId/APP-202631) |
| EJV | [APP-200016](https://lseg.leanix.net/LsegPROD/external/applicationId/APP-200016) |
| I&A Banking & Research Deals NG | [APP-201872](https://lseg.leanix.net/LsegPROD/external/applicationId/APP-201872) |
| I&A Investment Management CP Estimates | [APP-202549](https://lseg.leanix.net/LsegPROD/external/applicationId/APP-202549) |
| I&A Investment Management Content Economics | [APP-202029](https://lseg.leanix.net/LsegPROD/external/applicationId/APP-202029) |
| Lipper | [APP-200065](https://lseg.leanix.net/LsegPROD/external/applicationId/APP-200065) |
| NDA | [APP-200069](https://lseg.leanix.net/LsegPROD/external/applicationId/APP-200069) |
| News Entry Point | [APP-206271](https://lseg.leanix.net/LsegPROD/external/applicationId/APP-206271) |
| DB Calcs | [APP-204807](https://lseg.leanix.net/LsegPROD/external/applicationId/APP-204807) |
| StreetEvents | [APP-201942](https://lseg.leanix.net/LsegPROD/external/applicationId/APP-201942) |

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

Applications that leverage Tornado on-premise, as an API provider, must remove their dependencies on it at the point they migrate to Azure. Of the above options, all are valid, depending on the on-premise Tornado API provider scenario.

For API proxying, either of the following options are preferred, depending on the nature of the API:

- Use of Azure APIM Management - for Internal API proxying
- Use of one of several Kong API Gateways - for External API proxying, Data Platform and Workspace instances exist

For regional failover, if relevant, a source-to-target pattern for [Regional Failover for Private Services](https://app.pages.dx1.lseg.com/app-51723/migration-patterns/mig-pat-source-to-target/patterns/business-continuity-disaster-recovery/0031-region-failover-private/) discusses this in more detail:

- Use of Azure LB + RIANA for virtual DNS-based failover - for regional failover of private services
- Use of Azure Route Server / Anycast - for more sophisticated load-balancing and regional failover of private services

### Consequences<a href="#consequences" class="headerlink" title="Permanent link">¶</a>

- Good, because as each API provider application migrates to Azure, dependency on Tornado reduces
- Good, because this approach will remove otherwise superfluous flows between Azure and on-premise
- Good, because it will de-couple applications from a legacy shared service, and provide autonomy in operation
- Bad, because it might inflate R-type of migrating application that, on-premise, leveraged Tornado

### Confirmation<a href="#confirmation" class="headerlink" title="Permanent link">¶</a>

The decision was validated by the D&A architecture community, the LMP architecture community, and Tornado Engineering team.

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

<span class="md-source-file__fact"> <span class="md-icon" title="Last update"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIxIDEzLjFjLS4xIDAtLjMuMS0uNC4ybC0xIDEgMi4xIDIuMSAxLTFjLjItLjIuMi0uNiAwLS44bC0xLjMtMS4zYy0uMS0uMS0uMi0uMi0uNC0uMm0tMS45IDEuOC02LjEgNlYyM2gyLjFsNi4xLTYuMXpNMTIuNSA3djUuMmw0IDIuNC0xIDFMMTEgMTNWN3pNMTEgMjEuOWMtNS4xLS41LTktNC44LTktOS45QzIgNi41IDYuNSAyIDEyIDJjNS4zIDAgOS42IDQuMSAxMCA5LjMtLjMtLjEtLjYtLjItMS0uMnMtLjcuMS0xIC4yQzE5LjYgNy4yIDE2LjIgNCAxMiA0Yy00LjQgMC04IDMuNi04IDggMCA0LjEgMy4xIDcuNSA3LjEgNy45bC0uMS4yeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="November 24, 2025 13:53:22 UTC">November 24, 2025</span> </span> <span class="md-source-file__fact"> <span class="md-icon" title="Created"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE0LjQ3IDE1LjA4IDExIDEzVjdoMS41djUuMjVsMy4wOCAxLjgzYy0uNDEuMjgtLjc5LjYyLTEuMTEgMW0tMS4zOSA0Ljg0Yy0uMzYuMDUtLjcxLjA4LTEuMDguMDgtNC40MiAwLTgtMy41OC04LThzMy41OC04IDgtOCA4IDMuNTggOCA4YzAgLjM3LS4wMy43Mi0uMDggMS4wOC42OS4xIDEuMzMuMzIgMS45Mi42NC4xLS41Ni4xNi0xLjEzLjE2LTEuNzIgMC01LjUtNC41LTEwLTEwLTEwUzIgNi41IDIgMTJzNC40NyAxMCAxMCAxMGMuNTkgMCAxLjE2LS4wNiAxLjcyLS4xNi0uMzItLjU5LS41NC0xLjIzLS42NC0xLjkyTTE4IDE1djNoLTN2MmgzdjNoMnYtM2gzdi0yaC0zdi0zeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="December 6, 2024 11:07:16 UTC">December 6, 2024</span> </span>

<a href="../0005-packet-filtering-and-nat/" class="md-footer__link md-footer__link--prev" aria-label="Previous: Use Azure Firewall for Traffic Filtering and Network Address Translation"></a>

<div class="md-footer__button md-icon">

![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIwIDExdjJIOGw1LjUgNS41LTEuNDIgMS40Mkw0LjE2IDEybDcuOTItNy45MkwxMy41IDUuNSA4IDExeiIgLz48L3N2Zz4=)

</div>

<div class="md-footer__title">

<span class="md-footer__direction"> Previous </span>

<div class="md-ellipsis">

Use Azure Firewall for Traffic Filtering and Network Address Translation

</div>

</div>

<a href="../0015-reverse-proxy/" class="md-footer__link md-footer__link--next" aria-label="Next: API Providers to remove particular dependencies on &#39;Eikon Reverse Proxy&#39; (APP-202047) as they migrate to Azure"></a>

<div class="md-footer__title">

<span class="md-footer__direction"> Next </span>

<div class="md-ellipsis">

API Providers to remove particular dependencies on 'Eikon Reverse Proxy' (APP-202047) as they migrate to Azure

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
