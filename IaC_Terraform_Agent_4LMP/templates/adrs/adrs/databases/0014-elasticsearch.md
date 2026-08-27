<span class="md-content__button md-icon md-status--published" href="#" title="Status: Published"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE4LjUgMmgtMTNDMy42IDIgMiAzLjYgMiA1LjV2MTNDMiAyMC40IDMuNiAyMiA1LjUgMjJIMTZsNi02VjUuNUMyMiAzLjYgMjAuNCAyIDE4LjUgMk0yMCAxNWgtMS41Yy0xLjkgMC0zLjUgMS42LTMuNSAzLjVWMjBINS44Yy0xIDAtMS44LS44LTEuOC0xLjhWNS44QzQgNC44IDQuOCA0IDUuOCA0aDEyLjVjMSAwIDEuOC44IDEuOCAxLjhWMTVtLTQuOS02LjggMS41IDEuNS02IDYtMy41LTMuNSAxLjUtMS41IDIgMnoiIC8+PC9zdmc+) </span> <span class="md-content__button md-icon .md-status--published" title="Valid from 2024-12-09"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE5IDE5SDVWOGgxNG0wLTVoLTFWMWgtMnYySDhWMUg2djJINWEyIDIgMCAwIDAtMiAydjE0YTIgMiAwIDAgMCAyIDJoMTRhMiAyIDAgMCAwIDItMlY1YTIgMiAwIDAgMC0yLTJtLTIuNDcgOC4wNkwxNS40NyAxMGwtNC44OCA0Ljg4LTIuMTItMi4xMi0xLjA2IDEuMDZMMTAuNTkgMTd6IiAvPjwvc3ZnPg==) </span> <span class="md-content__button md-icon actions-date" title="Published on 2024-12-09">![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTkgMTB2Mkg3di0yem00IDB2MmgtMnYtMnptNCAwdjJoLTJ2LTJ6bTItN2EyIDIgMCAwIDEgMiAydjE0YTIgMiAwIDAgMS0yIDJINWEyIDIgMCAwIDEtMi0yVjVhMiAyIDAgMCAxIDItMmgxVjFoMnYyaDhWMWgydjJ6bTAgMTZWOEg1djExek05IDE0djJIN3YtMnptNCAwdjJoLTJ2LTJ6bTQgMHYyaC0ydi0yeiIgLz48L3N2Zz4=)</span> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/edit/main/docs/adrs/databases/0014-elasticsearch.md" class="md-content__button md-icon" title="Edit this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTEwIDIwSDZWNGg3djVoNXYzLjFsMi0yVjhsLTYtNkg2Yy0xLjEgMC0yIC45LTIgMnYxNmMwIDEuMS45IDIgMiAyaDR6bTEwLjItN2MuMSAwIC4zLjEuNC4ybDEuMyAxLjNjLjIuMi4yLjYgMCAuOGwtMSAxLTIuMS0yLjEgMS0xYy4xLS4xLjItLjIuNC0uMm0wIDMuOUwxNC4xIDIzSDEydi0yLjFsNi4xLTYuMXoiIC8+PC9zdmc+" /></a> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/blob/main/docs/adrs/databases/0014-elasticsearch.md" class="md-content__button md-icon" title="View source of this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE3IDE4Yy41NiAwIDEgLjQ0IDEgMXMtLjQ0IDEtMSAxLTEtLjQ0LTEtMSAuNDQtMSAxLTFtMC0zYy0yLjczIDAtNS4wNiAxLjY2LTYgNCAuOTQgMi4zNCAzLjI3IDQgNiA0czUuMDYtMS42NiA2LTRjLS45NC0yLjM0LTMuMjctNC02LTRtMCA2LjVhMi41IDIuNSAwIDAgMS0yLjUtMi41IDIuNSAyLjUgMCAwIDEgMi41LTIuNSAyLjUgMi41IDAgMCAxIDIuNSAyLjUgMi41IDIuNSAwIDAgMS0yLjUgMi41TTkuMjcgMjBINlY0aDd2NWg1djQuMDdjLjcuMDggMS4zNi4yNSAyIC40OVY4bC02LTZINmEyIDIgMCAwIDAtMiAydjE2YTIgMiAwIDAgMCAyIDJoNC41YTguMiA4LjIgMCAwIDEtMS4yMy0yIiAvPjwvc3ZnPg==" /></a>

Document Metadata

|  |  |
|----|----|
| Identifier | **`LMP-ADR-0014`** |
| Type | **ADR** |
| Status | **Published** |
| Approvals | <span class="md-tag">LMP Migration Architecture Approval</span> |
| Published on | **December 09, 2024** |
| Valid From | **December 09, 2024** |
| Authors | <span class="md-source-file__fact"> </span> |
| Tags | <span class="md-tag">Search</span> |
| Technology Capabilities | <span class="md-tag">Platform / Application / Search</span> |

# Users to remove dependencies on Elastic Search Platform (APP-205238) as they migrate to Azure<a href="#users-to-remove-dependencies-on-elastic-search-platform-app-205238-as-they-migrate-to-azure" class="headerlink" title="Permanent link">¶</a>

## Context and Problem Statement<a href="#context-and-problem-statement" class="headerlink" title="Permanent link">¶</a>

['Elasticsearch Platform' (APP-205238)](https://lseg.leanix.net/LsegPROD/external/applicationId/APP-205238), is a set of highly fragile, on-premise, centrally-managed Elasticsearch clusters, with severe associated obsolescence risks. It has suffered numerous outages in recent years, and the central team that manage it no longer have a sufficient team to operate it. The application is outside the LMP perimeter (Retire R-type).

For the applications that leverage it today on-premise, it is providing a combination of text/document search use-cases, in addition to a handful of ELK (Elastic-Logstash-Kibana) style use-cases.

In 2024, these functions can easily be provided by CSP PaaS services, or other LSEG strategic services (e.g. Datadog).

From the ElasticSearch Platform team, it is believed that the following applications leverage it today:

| Application | APP-ID |
|----|----|
| Filings in Eikon Analytics Platform | [APP-204882](https://lseg.leanix.net/LsegPROD/external/applicationId/APP-204882) |
| Research in Eikon Analytics Platform | [APP-204881](https://lseg.leanix.net/LsegPROD/external/applicationId/APP-204881) |
| Eikon Alerts | [APP-202634](https://lseg.leanix.net/LsegPROD/external/applicationId/APP-202634) |
| Commodities / PointConnect | [APP-204126](https://lseg.leanix.net/LsegPROD/external/applicationId/APP-204126) |
| Datascope Select | [APP-200035](https://lseg.leanix.net/LsegPROD/external/applicationId/APP-200035) |
| Events Platform | [APP-205230](https://lseg.leanix.net/LsegPROD/external/applicationId/APP-205230) |
| EJV | [APP-200016](https://lseg.leanix.net/LsegPROD/external/applicationId/APP-200016) |
| News Entry Point | [APP-206271](https://lseg.leanix.net/LsegPROD/external/applicationId/APP-206271) |
| Elektron Real Time Value Add | [APP-202032](https://lseg.leanix.net/LsegPROD/external/applicationId/APP-202032) |
| Equity MSR | [APP-204556](https://lseg.leanix.net/LsegPROD/external/applicationId/APP-204556) |
| IFR / Capital Markets Insight Publishing | [APP-202652](https://lseg.leanix.net/LsegPROD/external/applicationId/APP-202652) |

## Decision Drivers<a href="#decision-drivers" class="headerlink" title="Permanent link">¶</a>

The decision is driven by:

- Desire for reduction of obsolescence risks, Path-to-Amber (PtA), etc.
- Desire for simplification of data flows, for applications migrated to Azure - i.e. avoiding unnecessary hops back to on-premise, for specific functions
- Desire for de-coupled and autonomous functioning of applications migrated to Azure - to simplify operability

## Considered Options<a href="#considered-options" class="headerlink" title="Permanent link">¶</a>

Relevant options are fully covered in the [Full-Text Document Indexing and Search](../../../patterns/databases/0007-search/) source-to-target Pattern.

## Decision Outcome<a href="#decision-outcome" class="headerlink" title="Permanent link">¶</a>

Applications that leverage ElasticSearch Platform on-premise, as text/document search and indexing capability, must remove their dependencies on it at the point they migrate to Azure. Of the options described in the [Full-Text Document Indexing and Search](../../../patterns/databases/0007-search/) source-to-target Pattern, all are valid, depending on the on-premise user scenario.

### Consequences<a href="#consequences" class="headerlink" title="Permanent link">¶</a>

- Good, because as each user application migrates to Azure, dependency on Elasticsearch Platform reduces
- Good, because this approach will remove otherwise superfluous flows between Azure and on-premise
- Good, because it will de-couple applications from a legacy shared service, and provide autonomy in operation
- Bad, because it might inflate R-type of migrating application that, on-premise, leveraged ElasticSearch Platform

### Confirmation<a href="#confirmation" class="headerlink" title="Permanent link">¶</a>

The decision was validated by the D&A architecture community, the LMP architecture community, and Elasticsearch Platform Engineering team.

## Pros and Cons of the Options<a href="#pros-and-cons-of-the-options" class="headerlink" title="Permanent link">¶</a>

Covered in the [Full-Text Document Indexing and Search](../../../patterns/databases/0007-search/) source-to-target Pattern.

## More Information<a href="#more-information" class="headerlink" title="Permanent link">¶</a>

Please see the [Full-Text Document Indexing and Search](../../../patterns/databases/0007-search/) source-to-target Pattern.

<span class="md-source-file__fact"> <span class="md-icon" title="Last update"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIxIDEzLjFjLS4xIDAtLjMuMS0uNC4ybC0xIDEgMi4xIDIuMSAxLTFjLjItLjIuMi0uNiAwLS44bC0xLjMtMS4zYy0uMS0uMS0uMi0uMi0uNC0uMm0tMS45IDEuOC02LjEgNlYyM2gyLjFsNi4xLTYuMXpNMTIuNSA3djUuMmw0IDIuNC0xIDFMMTEgMTNWN3pNMTEgMjEuOWMtNS4xLS41LTktNC44LTktOS45QzIgNi41IDYuNSAyIDEyIDJjNS4zIDAgOS42IDQuMSAxMCA5LjMtLjMtLjEtLjYtLjItMS0uMnMtLjcuMS0xIC4yQzE5LjYgNy4yIDE2LjIgNCAxMiA0Yy00LjQgMC04IDMuNi04IDggMCA0LjEgMy4xIDcuNSA3LjEgNy45bC0uMS4yeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="May 23, 2025 14:27:18 UTC">May 23, 2025</span> </span> <span class="md-source-file__fact"> <span class="md-icon" title="Created"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE0LjQ3IDE1LjA4IDExIDEzVjdoMS41djUuMjVsMy4wOCAxLjgzYy0uNDEuMjgtLjc5LjYyLTEuMTEgMW0tMS4zOSA0Ljg0Yy0uMzYuMDUtLjcxLjA4LTEuMDguMDgtNC40MiAwLTgtMy41OC04LThzMy41OC04IDgtOCA4IDMuNTggOCA4YzAgLjM3LS4wMy43Mi0uMDggMS4wOC42OS4xIDEuMzMuMzIgMS45Mi42NC4xLS41Ni4xNi0xLjEzLjE2LTEuNzIgMC01LjUtNC41LTEwLTEwLTEwUzIgNi41IDIgMTJzNC40NyAxMCAxMCAxMGMuNTkgMCAxLjE2LS4wNiAxLjcyLS4xNi0uMzItLjU5LS41NC0xLjIzLS42NC0xLjkyTTE4IDE1djNoLTN2MmgzdjNoMnYtM2gzdi0yaC0zdi0zeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="December 13, 2024 10:07:40 UTC">December 13, 2024</span> </span>

<a href="../../communication/0001-use-mimecast-for-email/" class="md-footer__link md-footer__link--prev" aria-label="Previous: Use Mimecast as a secure email service"></a>

<div class="md-footer__button md-icon">

![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIwIDExdjJIOGw1LjUgNS41LTEuNDIgMS40Mkw0LjE2IDEybDcuOTItNy45MkwxMy41IDUuNSA4IDExeiIgLz48L3N2Zz4=)

</div>

<div class="md-footer__title">

<span class="md-footer__direction"> Previous </span>

<div class="md-ellipsis">

Use Mimecast as a secure email service

</div>

</div>

<a href="../../deployment-and-administration/0016-use-dxone-shared-runners-to-deploy-to-environments/" class="md-footer__link md-footer__link--next" aria-label="Next: Use DXOne Shared Runners to Deploy to Environments"></a>

<div class="md-footer__title">

<span class="md-footer__direction"> Next </span>

<div class="md-ellipsis">

Use DXOne Shared Runners to Deploy to Environments

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
