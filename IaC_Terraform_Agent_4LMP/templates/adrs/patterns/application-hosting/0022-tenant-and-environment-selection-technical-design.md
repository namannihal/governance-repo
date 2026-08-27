<span class="md-content__button md-icon md-status--published" href="#" title="Status: Published"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE4LjUgMmgtMTNDMy42IDIgMiAzLjYgMiA1LjV2MTNDMiAyMC40IDMuNiAyMiA1LjUgMjJIMTZsNi02VjUuNUMyMiAzLjYgMjAuNCAyIDE4LjUgMk0yMCAxNWgtMS41Yy0xLjkgMC0zLjUgMS42LTMuNSAzLjVWMjBINS44Yy0xIDAtMS44LS44LTEuOC0xLjhWNS44QzQgNC44IDQuOCA0IDUuOCA0aDEyLjVjMSAwIDEuOC44IDEuOCAxLjhWMTVtLTQuOS02LjggMS41IDEuNS02IDYtMy41LTMuNSAxLjUtMS41IDIgMnoiIC8+PC9zdmc+) </span> <span class="md-content__button md-icon .md-status--published" title="Valid from 2024-08-21"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE5IDE5SDVWOGgxNG0wLTVoLTFWMWgtMnYySDhWMUg2djJINWEyIDIgMCAwIDAtMiAydjE0YTIgMiAwIDAgMCAyIDJoMTRhMiAyIDAgMCAwIDItMlY1YTIgMiAwIDAgMC0yLTJtLTIuNDcgOC4wNkwxNS40NyAxMGwtNC44OCA0Ljg4LTIuMTItMi4xMi0xLjA2IDEuMDZMMTAuNTkgMTd6IiAvPjwvc3ZnPg==) </span> <span class="md-content__button md-icon actions-date" title="Published on 2024-08-28">![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTkgMTB2Mkg3di0yem00IDB2MmgtMnYtMnptNCAwdjJoLTJ2LTJ6bTItN2EyIDIgMCAwIDEgMiAydjE0YTIgMiAwIDAgMS0yIDJINWEyIDIgMCAwIDEtMi0yVjVhMiAyIDAgMCAxIDItMmgxVjFoMnYyaDhWMWgydjJ6bTAgMTZWOEg1djExek05IDE0djJIN3YtMnptNCAwdjJoLTJ2LTJ6bTQgMHYyaC0ydi0yeiIgLz48L3N2Zz4=)</span> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/edit/main/docs/patterns/application-hosting/0022-tenant-and-environment-selection-technical-design.md" class="md-content__button md-icon" title="Edit this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTEwIDIwSDZWNGg3djVoNXYzLjFsMi0yVjhsLTYtNkg2Yy0xLjEgMC0yIC45LTIgMnYxNmMwIDEuMS45IDIgMiAyaDR6bTEwLjItN2MuMSAwIC4zLjEuNC4ybDEuMyAxLjNjLjIuMi4yLjYgMCAuOGwtMSAxLTIuMS0yLjEgMS0xYy4xLS4xLjItLjIuNC0uMm0wIDMuOUwxNC4xIDIzSDEydi0yLjFsNi4xLTYuMXoiIC8+PC9zdmc+" /></a> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/blob/main/docs/patterns/application-hosting/0022-tenant-and-environment-selection-technical-design.md" class="md-content__button md-icon" title="View source of this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE3IDE4Yy41NiAwIDEgLjQ0IDEgMXMtLjQ0IDEtMSAxLTEtLjQ0LTEtMSAuNDQtMSAxLTFtMC0zYy0yLjczIDAtNS4wNiAxLjY2LTYgNCAuOTQgMi4zNCAzLjI3IDQgNiA0czUuMDYtMS42NiA2LTRjLS45NC0yLjM0LTMuMjctNC02LTRtMCA2LjVhMi41IDIuNSAwIDAgMS0yLjUtMi41IDIuNSAyLjUgMCAwIDEgMi41LTIuNSAyLjUgMi41IDAgMCAxIDIuNSAyLjUgMi41IDIuNSAwIDAgMS0yLjUgMi41TTkuMjcgMjBINlY0aDd2NWg1djQuMDdjLjcuMDggMS4zNi4yNSAyIC40OVY4bC02LTZINmEyIDIgMCAwIDAtMiAydjE2YTIgMiAwIDAgMCAyIDJoNC41YTguMiA4LjIgMCAwIDEtMS4yMy0yIiAvPjwvc3ZnPg==" /></a>

Document Metadata

|  |  |
|----|----|
| Identifier | **`LMP-PAT-0022`** |
| Type | **Technology Selection Pattern** |
| Status | **Published** |
| Approvals | <span class="md-tag">LMP Migration Architecture Approval</span> |
| Published on | **August 28, 2024** |
| Valid From | **August 21, 2024** |
| Authors | <span class="md-source-file__fact"> </span> |
| Tags | <span class="md-tag">Application Hosting</span> |
| Technology Capabilities | <span class="md-tag">Delivery / Operations / Deployment & Administration</span> |

# Selection of LMP Tenant and Environment<a href="#selection-of-lmp-tenant-and-environment" class="headerlink" title="Permanent link">¶</a>

## Compatibility<a href="#compatibility" class="headerlink" title="Permanent link">¶</a>

This advice relates to the Tenants and Environments available in the LMP Azure/Fabric platform and their usage. As such, it is only relevant to projects looking to use either the LMP Azure tenants or the LMP SaaS capacities.

## Recommended Target<a href="#recommended-target" class="headerlink" title="Permanent link">¶</a>

This document is designed to allow Solution Architects (and development teams) to identify which LMP Tenant and which Environment within that tenant that they should select to deploy assets to, based on the intended usage patterns and the proposed architecture for the Application being designed/developed. The target tenant/environment is dependent on the context of whether the App is proposed as part of a strategic LSEG.com deployment or as part of the LSEG SaaS platform, whether the App requires on-prem/legacy AWS connectivity (and whether it is pre- or post-R1, where SaaS tenants are proposed to get on-prem/legacy AWS connectivity) and whether there Data Gravity from related applications/data stores would influence the deployment location.

## Authoritative references<a href="#authoritative-references" class="headerlink" title="Permanent link">¶</a>

| Reference Type | Reference | Relevance to guidance | Comments |
|----|----|----|----|
| Strategy | [STAR LMP SIA Environments Tenancy Design v1.2 - working update version](https://lsegroup.sharepoint.com/:w:/r/teams/LMDataPlatform/Shared%20Documents/CH%20-%20Tech%20Architecture/Working%20Docs/Solution%20Designs%20(SADs-STARs-etc)/LMP%20SIA%20Tenancy%20(LMSP1,%20SaaS,%20etc)/STAR%20LMP%20SIA%20Environments%20Tenancy%20Design%20v1.2.docx?d=w2eaafee3420a4a949546ab0bf8aed631&csf=1&web=1&e=hFeIzB) | Defines the usage of the Tenants within the SIA strategic platform |  |
| Strategy | [LMP Fabric Enterprise Landing Zone and Op Model Design](https://lsegroup.sharepoint.com/:w:/r/teams/LMFoundationFM/Shared%20Documents/NEW%20-%20Fabric%20and%20Purview%20design/LMP%20Fabric%20Enterprise%20Landing%20Zone%20and%20Op%20Model%20Design.docx?d=wbb5bde9b9ad341fe8370e0e29cda3f45&csf=1&web=1&e=T5SzKO) | Defines the usage of Fabric/Purview Capacities at a strategic level |  |

## Decision Tree Diagrams<a href="#decision-tree-diagrams" class="headerlink" title="Permanent link">¶</a>

**Tenant/Subscription Selector** This is used for identifying the target Tenant(or SaaS subscription) for an Application ![LMP Tenant, Environment and Subscription selection guide](0022-tenant-and-environment-selection-technical-design.assets/image-001.png) **Environment Selector** This is used for identifying the target Environment for an Application within a Tenant (or SaaS subscription) based upon the stage of the development lifecycle ![LMP Tenant, Environment and Subscription selection guide](0022-tenant-and-environment-selection-technical-design.assets/image-001.png)

## Considerations<a href="#considerations" class="headerlink" title="Permanent link">¶</a>

- **Strategic Production Target**: For business reasons, an Application may be targeted at the SaaS platform or to LSEG.com, despite it leading to increased complexity/dependency of architecture (i.e. lack of on-prem connectivity for SaaS tenants pre-R1 and likely for all of 2024 leads to the need to "stage" data in LSEG.com via existing connectivity)
- **Data Sources**: If an application requires data from On-Prem or Legacy AWS, then there is a current reliance on LSEG.com connectivity that will remain until SaaS subscriptions (LMSP1 and LSEG SaaS have such connectivity enabled - this is out of scope for R1 and likely for all of 2024.
- **"Data Gravity"**: An application may have no inherent need to be deployed to the SaaS subscriptions, but may be closely linked to applications which reside on SaaS due to high levels of read/write traffic to/from SaaS applications, for example. In order to minimise data entry/exit costs across the SaaS/Azure tenant boundary layer, it would make sense to cluster the applications together. Similarly, support and access patterns for an application may influence the choice to deploy to SaaS, as opposed to LSEG.com, despite the application architecture itself not having any specific dependency on SaaS-hosted tooling.

<span class="md-source-file__fact"> <span class="md-icon" title="Last update"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIxIDEzLjFjLS4xIDAtLjMuMS0uNC4ybC0xIDEgMi4xIDIuMSAxLTFjLjItLjIuMi0uNiAwLS44bC0xLjMtMS4zYy0uMS0uMS0uMi0uMi0uNC0uMm0tMS45IDEuOC02LjEgNlYyM2gyLjFsNi4xLTYuMXpNMTIuNSA3djUuMmw0IDIuNC0xIDFMMTEgMTNWN3pNMTEgMjEuOWMtNS4xLS41LTktNC44LTktOS45QzIgNi41IDYuNSAyIDEyIDJjNS4zIDAgOS42IDQuMSAxMCA5LjMtLjMtLjEtLjYtLjItMS0uMnMtLjcuMS0xIC4yQzE5LjYgNy4yIDE2LjIgNCAxMiA0Yy00LjQgMC04IDMuNi04IDggMCA0LjEgMy4xIDcuNSA3LjEgNy45bC0uMS4yeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="May 30, 2025 16:15:49 UTC">May 30, 2025</span> </span> <span class="md-source-file__fact"> <span class="md-icon" title="Created"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE0LjQ3IDE1LjA4IDExIDEzVjdoMS41djUuMjVsMy4wOCAxLjgzYy0uNDEuMjgtLjc5LjYyLTEuMTEgMW0tMS4zOSA0Ljg0Yy0uMzYuMDUtLjcxLjA4LTEuMDguMDgtNC40MiAwLTgtMy41OC04LThzMy41OC04IDgtOCA4IDMuNTggOCA4YzAgLjM3LS4wMy43Mi0uMDggMS4wOC42OS4xIDEuMzMuMzIgMS45Mi42NC4xLS41Ni4xNi0xLjEzLjE2LTEuNzIgMC01LjUtNC41LTEwLTEwLTEwUzIgNi41IDIgMTJzNC40NyAxMCAxMCAxMGMuNTkgMCAxLjE2LS4wNiAxLjcyLS4xNi0uMzItLjU5LS41NC0xLjIzLS42NC0xLjkyTTE4IDE1djNoLTN2MmgzdjNoMnYtM2gzdi0yaC0zdi0zeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="September 11, 2024 11:33:10 UTC">September 11, 2024</span> </span>

<a href="../../analytics/0074-hdinsight-design-pattern/" class="md-footer__link md-footer__link--prev" aria-label="Previous: HD Insight Hadoop Cluster Pattern"></a>

<div class="md-footer__button md-icon">

![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIwIDExdjJIOGw1LjUgNS41LTEuNDIgMS40Mkw0LjE2IDEybDcuOTItNy45MkwxMy41IDUuNSA4IDExeiIgLz48L3N2Zz4=)

</div>

<div class="md-footer__title">

<span class="md-footer__direction"> Previous </span>

<div class="md-ellipsis">

HD Insight Hadoop Cluster Pattern

</div>

</div>

<a href="../0030-java-application-server/" class="md-footer__link md-footer__link--next" aria-label="Next: Java Application Servers"></a>

<div class="md-footer__title">

<span class="md-footer__direction"> Next </span>

<div class="md-ellipsis">

Java Application Servers

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
