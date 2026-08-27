<span class="md-content__button md-icon md-status--published" href="#" title="Status: Published"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE4LjUgMmgtMTNDMy42IDIgMiAzLjYgMiA1LjV2MTNDMiAyMC40IDMuNiAyMiA1LjUgMjJIMTZsNi02VjUuNUMyMiAzLjYgMjAuNCAyIDE4LjUgMk0yMCAxNWgtMS41Yy0xLjkgMC0zLjUgMS42LTMuNSAzLjVWMjBINS44Yy0xIDAtMS44LS44LTEuOC0xLjhWNS44QzQgNC44IDQuOCA0IDUuOCA0aDEyLjVjMSAwIDEuOC44IDEuOCAxLjhWMTVtLTQuOS02LjggMS41IDEuNS02IDYtMy41LTMuNSAxLjUtMS41IDIgMnoiIC8+PC9zdmc+) </span> <span class="md-content__button md-icon .md-status--published" title="Valid from 2024-11-06"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE5IDE5SDVWOGgxNG0wLTVoLTFWMWgtMnYySDhWMUg2djJINWEyIDIgMCAwIDAtMiAydjE0YTIgMiAwIDAgMCAyIDJoMTRhMiAyIDAgMCAwIDItMlY1YTIgMiAwIDAgMC0yLTJtLTIuNDcgOC4wNkwxNS40NyAxMGwtNC44OCA0Ljg4LTIuMTItMi4xMi0xLjA2IDEuMDZMMTAuNTkgMTd6IiAvPjwvc3ZnPg==) </span> <span class="md-content__button md-icon actions-date" title="Published on 2024-10-31">![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTkgMTB2Mkg3di0yem00IDB2MmgtMnYtMnptNCAwdjJoLTJ2LTJ6bTItN2EyIDIgMCAwIDEgMiAydjE0YTIgMiAwIDAgMS0yIDJINWEyIDIgMCAwIDEtMi0yVjVhMiAyIDAgMCAxIDItMmgxVjFoMnYyaDhWMWgydjJ6bTAgMTZWOEg1djExek05IDE0djJIN3YtMnptNCAwdjJoLTJ2LTJ6bTQgMHYyaC0ydi0yeiIgLz48L3N2Zz4=)</span> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/edit/main/docs/patterns/data-management/0046-daas-prm-metadata-consumption-pattern.md" class="md-content__button md-icon" title="Edit this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTEwIDIwSDZWNGg3djVoNXYzLjFsMi0yVjhsLTYtNkg2Yy0xLjEgMC0yIC45LTIgMnYxNmMwIDEuMS45IDIgMiAyaDR6bTEwLjItN2MuMSAwIC4zLjEuNC4ybDEuMyAxLjNjLjIuMi4yLjYgMCAuOGwtMSAxLTIuMS0yLjEgMS0xYy4xLS4xLjItLjIuNC0uMm0wIDMuOUwxNC4xIDIzSDEydi0yLjFsNi4xLTYuMXoiIC8+PC9zdmc+" /></a> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/blob/main/docs/patterns/data-management/0046-daas-prm-metadata-consumption-pattern.md" class="md-content__button md-icon" title="View source of this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE3IDE4Yy41NiAwIDEgLjQ0IDEgMXMtLjQ0IDEtMSAxLTEtLjQ0LTEtMSAuNDQtMSAxLTFtMC0zYy0yLjczIDAtNS4wNiAxLjY2LTYgNCAuOTQgMi4zNCAzLjI3IDQgNiA0czUuMDYtMS42NiA2LTRjLS45NC0yLjM0LTMuMjctNC02LTRtMCA2LjVhMi41IDIuNSAwIDAgMS0yLjUtMi41IDIuNSAyLjUgMCAwIDEgMi41LTIuNSAyLjUgMi41IDAgMCAxIDIuNSAyLjUgMi41IDIuNSAwIDAgMS0yLjUgMi41TTkuMjcgMjBINlY0aDd2NWg1djQuMDdjLjcuMDggMS4zNi4yNSAyIC40OVY4bC02LTZINmEyIDIgMCAwIDAtMiAydjE2YTIgMiAwIDAgMCAyIDJoNC41YTguMiA4LjIgMCAwIDEtMS4yMy0yIiAvPjwvc3ZnPg==" /></a>

Document Metadata

|  |  |
|----|----|
| Identifier | **`LMP-PAT-0046`** |
| Type | **Functional Design Pattern** |
| Status | **Published** |
| Approvals | <span class="md-tag">LMP Migration Architecture Approval</span> |
| Published on | **October 31, 2024** |
| Valid From | **November 06, 2024** |
| Authors | <span class="md-source-file__fact"> </span> |
| Tags | <span class="md-tag">Data Management</span> |
| Technology Capabilities | <span class="md-tag">Platform / Data / Data Management</span> |

# Rights (PRM) metadata Consumption Pattern<a href="#rights-prm-metadata-consumption-pattern" class="headerlink" title="Permanent link">¶</a>

## Introduction<a href="#introduction" class="headerlink" title="Permanent link">¶</a>

Rights metadata (Segment and Product definitions) defines how content distributed via Data-as-a-Service (DaaS) should be grouped into Segments and Content Products. This information mastered in Product & Rights Management (APP-51737) application but not available directly via this application. PRM dual publish it to DaaS metadata repository (Purview) and PRM Blob storage in Azure.

Rights metadata include information about:

- Content grouping into Segments (field and table level information)
- Segment grouping into Content Products
- Content Product mapping to Commercial Product via Material Code (MC)
- Client Rules (rights and restrictions for consumer of the product)
- Effective period of each Segment and Product version

This information is required for any application which consume or distribute data via DaaS, also it is required for any kind of data catalogues we want to expose or publish to customers.

This pattern provides guidance and approved designs for teams to consume rights metadata from DaaS platform. It reflects the current state of maturity immediately post Release 1.

## Scope<a href="#scope" class="headerlink" title="Permanent link">¶</a>

This pattern is applicable to Internal products and applications needing:

- to query rights information about products available on DaaS (e.g. Data Discovery)
- enforce entitlements and product boundaries as part of data consumption or distribution (e.g. DaaS distribution channels)
- run compliance checks and reports for DaaS products (Product Studio II and Rights Management tooling)

The scope of the pattern includes:

- definition of available consumption mechanisms and the types of use case it supports
- outline of pros and cons of the different mechanisms
- a statement on whether the consumption mechanism is approved for internal use

External (non-LSEG) applications are not allowed to consume rights metadata from DaaS, however DaaS products may include some of rights metadata as part of Content Product or Data Catalogue distribution.

## Pattern Definition<a href="#pattern-definition" class="headerlink" title="Permanent link">¶</a>

The following consumption patterns are available for use:

### 1. Purview Atlas API<a href="#1-purview-atlas-api" class="headerlink" title="Permanent link">¶</a>

Consume Rights metadata directly from Purview Atlas API using Purview SDK. Use Purview Events Hub to subscribe for notifications on changes to metadata. You will have to setup filters to filter out notifications not related to your application.

Purview is a central metadata repository for DaaS. Rights and other metadata available via Purview API.

#### Pros<a href="#pros" class="headerlink" title="Permanent link">¶</a>

- API based access to rights metadata
- Purview is an authoritative redistribution of rights metadata for DaaS
- Availability of Field and Business Glossary (and other metadata) via the same API
- Strong typed schema for rights metadata

#### Cons<a href="#cons" class="headerlink" title="Permanent link">¶</a>

- Purview SLA
- Complex data schema for rights metadata

#### Recommendation<a href="#recommendation" class="headerlink" title="Permanent link">¶</a>

This pattern is approved for use by internal application when these calls are part of internal application flow and not related to handling client requests. Current Purview SLA doesn't allow use its API as part of flows which requires high performance and fast response time.

### 2. PRM Azure Blob Storage<a href="#2-prm-azure-blob-storage" class="headerlink" title="Permanent link">¶</a>

Consume Rights metadata from Azure Blob Storage owned by PRM team. This storage contains all version Segment and Product definitions in published status as JSON files. Consumer can subscribe for Blob Storage change notifications to be aware of all changes published by PRM.

#### Pros<a href="#pros_1" class="headerlink" title="Permanent link">¶</a>

- Azure Blob Storage is highly available and performant storage
- Each version of PRM definitions stored as a separate JSON file with simple schema
- Blob storage automatically emits notifications on changes to files

#### Cons<a href="#cons_1" class="headerlink" title="Permanent link">¶</a>

- Azure Blob storage is a tactical solution for Release 1
- PRM Blob storage contains only rights metadata, all other metadata (Field Dictionary, Business Glossary, etc.) available via Purview API
- Blob storage doesn't provide API to query rights metadata

#### Recommendation<a href="#recommendation_1" class="headerlink" title="Permanent link">¶</a>

It is approved to use by DaaS Distribution Channels. Any other consumers should not use it unless it is approved with DaaS Architecture team. This Blob storage may be replaced with alternative solution after DaaS Release 1

<span class="md-source-file__fact"> <span class="md-icon" title="Last update"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIxIDEzLjFjLS4xIDAtLjMuMS0uNC4ybC0xIDEgMi4xIDIuMSAxLTFjLjItLjIuMi0uNiAwLS44bC0xLjMtMS4zYy0uMS0uMS0uMi0uMi0uNC0uMm0tMS45IDEuOC02LjEgNlYyM2gyLjFsNi4xLTYuMXpNMTIuNSA3djUuMmw0IDIuNC0xIDFMMTEgMTNWN3pNMTEgMjEuOWMtNS4xLS41LTktNC44LTktOS45QzIgNi41IDYuNSAyIDEyIDJjNS4zIDAgOS42IDQuMSAxMCA5LjMtLjMtLjEtLjYtLjItMS0uMnMtLjcuMS0xIC4yQzE5LjYgNy4yIDE2LjIgNCAxMiA0Yy00LjQgMC04IDMuNi04IDggMCA0LjEgMy4xIDcuNSA3LjEgNy45bC0uMS4yeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="May 30, 2025 16:15:49 UTC">May 30, 2025</span> </span> <span class="md-source-file__fact"> <span class="md-icon" title="Created"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE0LjQ3IDE1LjA4IDExIDEzVjdoMS41djUuMjVsMy4wOCAxLjgzYy0uNDEuMjgtLjc5LjYyLTEuMTEgMW0tMS4zOSA0Ljg0Yy0uMzYuMDUtLjcxLjA4LTEuMDguMDgtNC40MiAwLTgtMy41OC04LThzMy41OC04IDgtOCA4IDMuNTggOCA4YzAgLjM3LS4wMy43Mi0uMDggMS4wOC42OS4xIDEuMzMuMzIgMS45Mi42NC4xLS41Ni4xNi0xLjEzLjE2LTEuNzIgMC01LjUtNC41LTEwLTEwLTEwUzIgNi41IDIgMTJzNC40NyAxMCAxMCAxMGMuNTkgMCAxLjE2LS4wNiAxLjcyLS4xNi0uMzItLjU5LS41NC0xLjIzLS42NC0xLjkyTTE4IDE1djNoLTN2MmgzdjNoMnYtM2gzdi0yaC0zdi0zeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="November 29, 2024 15:45:36 UTC">November 29, 2024</span> </span>

<a href="../0045-azcopy-for-large-volume-file-migration-from-onprem-to-azure/" class="md-footer__link md-footer__link--prev" aria-label="Previous: Using Azure AzCopy for Large Volume File Migration from On-Premises to Azure"></a>

<div class="md-footer__button md-icon">

![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIwIDExdjJIOGw1LjUgNS41LTEuNDIgMS40Mkw0LjE2IDEybDcuOTItNy45MkwxMy41IDUuNSA4IDExeiIgLz48L3N2Zz4=)

</div>

<div class="md-footer__title">

<span class="md-footer__direction"> Previous </span>

<div class="md-ellipsis">

Using Azure AzCopy for Large Volume File Migration from On-Premises to Azure

</div>

</div>

<a href="../0049-secure-file-transfer-sftp-service-pattern/" class="md-footer__link md-footer__link--next" aria-label="Next: Secure File Transfer SFTP Service Pattern"></a>

<div class="md-footer__title">

<span class="md-footer__direction"> Next </span>

<div class="md-ellipsis">

Secure File Transfer SFTP Service Pattern

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
