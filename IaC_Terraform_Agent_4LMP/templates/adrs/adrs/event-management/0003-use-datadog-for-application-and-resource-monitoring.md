<span class="md-content__button md-icon md-status--published" href="#" title="Status: Published"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE4LjUgMmgtMTNDMy42IDIgMiAzLjYgMiA1LjV2MTNDMiAyMC40IDMuNiAyMiA1LjUgMjJIMTZsNi02VjUuNUMyMiAzLjYgMjAuNCAyIDE4LjUgMk0yMCAxNWgtMS41Yy0xLjkgMC0zLjUgMS42LTMuNSAzLjVWMjBINS44Yy0xIDAtMS44LS44LTEuOC0xLjhWNS44QzQgNC44IDQuOCA0IDUuOCA0aDEyLjVjMSAwIDEuOC44IDEuOCAxLjhWMTVtLTQuOS02LjggMS41IDEuNS02IDYtMy41LTMuNSAxLjUtMS41IDIgMnoiIC8+PC9zdmc+) </span> <span class="md-content__button md-icon .md-status--published" title="Valid from 2024-05-25"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE5IDE5SDVWOGgxNG0wLTVoLTFWMWgtMnYySDhWMUg2djJINWEyIDIgMCAwIDAtMiAydjE0YTIgMiAwIDAgMCAyIDJoMTRhMiAyIDAgMCAwIDItMlY1YTIgMiAwIDAgMC0yLTJtLTIuNDcgOC4wNkwxNS40NyAxMGwtNC44OCA0Ljg4LTIuMTItMi4xMi0xLjA2IDEuMDZMMTAuNTkgMTd6IiAvPjwvc3ZnPg==) </span> <span class="md-content__button md-icon actions-date" title="Published on 2024-03-14">![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTkgMTB2Mkg3di0yem00IDB2MmgtMnYtMnptNCAwdjJoLTJ2LTJ6bTItN2EyIDIgMCAwIDEgMiAydjE0YTIgMiAwIDAgMS0yIDJINWEyIDIgMCAwIDEtMi0yVjVhMiAyIDAgMCAxIDItMmgxVjFoMnYyaDhWMWgydjJ6bTAgMTZWOEg1djExek05IDE0djJIN3YtMnptNCAwdjJoLTJ2LTJ6bTQgMHYyaC0ydi0yeiIgLz48L3N2Zz4=)</span> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/edit/main/docs/adrs/event-management/0003-use-datadog-for-application-and-resource-monitoring.md" class="md-content__button md-icon" title="Edit this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTEwIDIwSDZWNGg3djVoNXYzLjFsMi0yVjhsLTYtNkg2Yy0xLjEgMC0yIC45LTIgMnYxNmMwIDEuMS45IDIgMiAyaDR6bTEwLjItN2MuMSAwIC4zLjEuNC4ybDEuMyAxLjNjLjIuMi4yLjYgMCAuOGwtMSAxLTIuMS0yLjEgMS0xYy4xLS4xLjItLjIuNC0uMm0wIDMuOUwxNC4xIDIzSDEydi0yLjFsNi4xLTYuMXoiIC8+PC9zdmc+" /></a> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/blob/main/docs/adrs/event-management/0003-use-datadog-for-application-and-resource-monitoring.md" class="md-content__button md-icon" title="View source of this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE3IDE4Yy41NiAwIDEgLjQ0IDEgMXMtLjQ0IDEtMSAxLTEtLjQ0LTEtMSAuNDQtMSAxLTFtMC0zYy0yLjczIDAtNS4wNiAxLjY2LTYgNCAuOTQgMi4zNCAzLjI3IDQgNiA0czUuMDYtMS42NiA2LTRjLS45NC0yLjM0LTMuMjctNC02LTRtMCA2LjVhMi41IDIuNSAwIDAgMS0yLjUtMi41IDIuNSAyLjUgMCAwIDEgMi41LTIuNSAyLjUgMi41IDAgMCAxIDIuNSAyLjUgMi41IDIuNSAwIDAgMS0yLjUgMi41TTkuMjcgMjBINlY0aDd2NWg1djQuMDdjLjcuMDggMS4zNi4yNSAyIC40OVY4bC02LTZINmEyIDIgMCAwIDAtMiAydjE2YTIgMiAwIDAgMCAyIDJoNC41YTguMiA4LjIgMCAwIDEtMS4yMy0yIiAvPjwvc3ZnPg==" /></a>

Document Metadata

|  |  |
|----|----|
| Identifier | **`LMP-ADR-0003`** |
| Type | **ADR** |
| Status | **Published** |
| Approvals | <span class="md-tag">LMP Migration Architecture Approval</span> |
| Published on | **March 14, 2024** |
| Valid From | **May 25, 2024** |
| Authors | <span class="md-source-file__fact"> </span> |
| Tags | <span class="md-tag">Event Management</span><span class="md-tag">Application Support</span> |
| Technology Capabilities | <span class="md-tag">Delivery / Operations / Event Management</span><span class="md-tag">Delivery / Operations / IT Service Management / Application Monitoring</span> |

# Use Datadog SaaS for Application & Resource monitoring<a href="#use-datadog-saas-for-application-resource-monitoring" class="headerlink" title="Permanent link">¶</a>

## Context and Problem Statement<a href="#context-and-problem-statement" class="headerlink" title="Permanent link">¶</a>

In the current context of application migration to LMP greenfield migration to Azure lseg.com tenant, application teams need clarifications on the following points to migrate seamlessly.

What is the Strategic Observability destination in LMP Greenfield for Resource Metrics/Logs/Application logs?

## Decision Drivers<a href="#decision-drivers" class="headerlink" title="Permanent link">¶</a>

LSEG Applications are migrating to Azure under LMP. These applications would needed to be monitored, especially for the following technology and application areas:

- Infrastructure Resource Metrics which includes (PaaS/Iaas/FaaS) services
- Infrastructure Resource Logs which includes (PaaS/Iaas/FaaS) services
- Application Logs
- Application Traces

## Considered Options<a href="#considered-options" class="headerlink" title="Permanent link">¶</a>

- Azure Monitor
- Datadog SaaS

## Decision Outcome<a href="#decision-outcome" class="headerlink" title="Permanent link">¶</a>

Chosen option: Datadog SaaS, because

- It is a strategic choice from LSEG

Necessary details can be found below:

- [STAR DA-303 Observability Design](https://lsegroup.sharepoint.com/:f:/r/teams/LMFoundationFM/Shared%20Documents/General/02%20Design%20Docs/3%20Management,%20Cost,%20Governance%20%26%20Policy?csf=1&web=1&e=7FzAUv)
- [STAR DA-303 Observability Tooling Options](https://lsegroup.sharepoint.com/:x:/r/teams/LMFoundationFM/Shared%20Documents/General/02%20Design%20Docs/3%20Management,%20Cost,%20Governance%20%26%20Policy/STAR%20DA-303%20Observability%20Tooling%20Options.xlsx?d=w4fb2793322b14291aa20a55de53814ce&csf=1&web=1&e=sjNCui)
- [STAR DA-051 Datadog SaaS Design](https://lsegroup.sharepoint.com/:w:/r/teams/LMFoundationFM/Shared%20Documents/General/02%20Design%20Docs/6%20DevOps%20Tooling/STAR%20DA-051%20Datadog%20SaaS%20Design.docx?d=w25d8fc3eb1a9458daba99258f4d95460&csf=1&web=1&e=3jxG7s)
- [STAR DA-051 Datadog ResourceLog Integration LLD draft](https://lsegroup.sharepoint.com/:w:/r/teams/LMFoundationFM/Shared%20Documents/General/02%20Design%20Docs/6%20DevOps%20Tooling/STAR%20DA-051%20Datadog%20ResourceLog%20Integration%20LLD%20draft.docx?d=wb9d957dd6bb441d18a8681add6717559&csf=1&web=1&e=Q4RZAL)

### Consequences<a href="#consequences" class="headerlink" title="Permanent link">¶</a>

- Good, because it is a single repo for all types of observability data like metric, APMs and logs.
- Good, because all security requirements continue to be met
- Good, because the service is provided by a managed SaaS platform
- Good, because it has easy integration with other tools like cloudhealth, Big Panda etc.
- Neutral, because cost can be an added component for applications which don't currently uses Datadog.

Price details can be found in [Datadog Cost Estimation](https://confluence.refinitiv.com/display/PCP/Datadog+Cost+Estimation) [Solution for App-ID based Monthly Usage and Bill generation](https://confluence.refinitiv.com/display/PCP/Solution+for+App-ID+based+Monthly+Usage+and+Bill+generation)

- Bad, because single tool vendor dependency.

### Confirmation<a href="#confirmation" class="headerlink" title="Permanent link">¶</a>

The decision was validated by the CTEF process, see [Architecture Governance item - GOVI0001229.](https://lseg.service-now.com/x/lsegp/cto/record/x_lsegp_eag_governance_item/aecf27611b7d7d10a3a9337f034bcb42)

CTEF approval details - can be found in the following ADO items

[Deliverable 27682: App Monitoring Observability Document - Datadog/BigPanda/Azure Monitor](https://dev.azure.com/LSEG/Foundation/_workitems/edit/27682)

[Deliverable 31235: Datadog Observability SaaS](https://dev.azure.com/LSEG/Foundation/_workitems/edit/31235)

## Pros and Cons of the Options<a href="#pros-and-cons-of-the-options" class="headerlink" title="Permanent link">¶</a>

### [Azure Monitor](https://learn.microsoft.com/en-us/azure/azure-monitor/overview)<a href="#azure-monitor" class="headerlink" title="Permanent link">¶</a>

- Good, because Azure native log collections would be available with less configurations.
- Good, because it provides native capabilities for application performance monitoring.
- Bad, because it is not comprehensive to cover all the facets of Resource logs and application log monitoring like traces.
- Bad, because integration with other CSPs may need application code refactoring.
- Bad, because it only caters to application performance monitoring.
- Bad, because integration with other CSPs may need application code refactoring.

## More Information<a href="#more-information" class="headerlink" title="Permanent link">¶</a>

We may need to revisit this decision later, to check the possibilities of implementing Open Telemetry in LMP landscape. This can help to minimize the effect of Single vendor dependency for application & resource metric and log monitoring.

<span class="md-source-file__fact"> <span class="md-icon" title="Last update"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIxIDEzLjFjLS4xIDAtLjMuMS0uNC4ybC0xIDEgMi4xIDIuMSAxLTFjLjItLjIuMi0uNiAwLS44bC0xLjMtMS4zYy0uMS0uMS0uMi0uMi0uNC0uMm0tMS45IDEuOC02LjEgNlYyM2gyLjFsNi4xLTYuMXpNMTIuNSA3djUuMmw0IDIuNC0xIDFMMTEgMTNWN3pNMTEgMjEuOWMtNS4xLS41LTktNC44LTktOS45QzIgNi41IDYuNSAyIDEyIDJjNS4zIDAgOS42IDQuMSAxMCA5LjMtLjMtLjEtLjYtLjItMS0uMnMtLjcuMS0xIC4yQzE5LjYgNy4yIDE2LjIgNCAxMiA0Yy00LjQgMC04IDMuNi04IDggMCA0LjEgMy4xIDcuNSA3LjEgNy45bC0uMS4yeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="December 10, 2024 10:03:44 UTC">December 10, 2024</span> </span> <span class="md-source-file__fact"> <span class="md-icon" title="Created"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE0LjQ3IDE1LjA4IDExIDEzVjdoMS41djUuMjVsMy4wOCAxLjgzYy0uNDEuMjgtLjc5LjYyLTEuMTEgMW0tMS4zOSA0Ljg0Yy0uMzYuMDUtLjcxLjA4LTEuMDguMDgtNC40MiAwLTgtMy41OC04LThzMy41OC04IDgtOCA4IDMuNTggOCA4YzAgLjM3LS4wMy43Mi0uMDggMS4wOC42OS4xIDEuMzMuMzIgMS45Mi42NC4xLS41Ni4xNi0xLjEzLjE2LTEuNzIgMC01LjUtNC41LTEwLTEwLTEwUzIgNi41IDIgMTJzNC40NyAxMCAxMCAxMGMuNTkgMCAxLjE2LS4wNiAxLjcyLS4xNi0uMzItLjU5LS41NC0xLjIzLS42NC0xLjkyTTE4IDE1djNoLTN2MmgzdjNoMnYtM2gzdi0yaC0zdi0zeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="March 21, 2024 13:24:46 UTC">March 21, 2024</span> </span>

<a href="../../development-tools-and-sdks/0002-jdk-distribution/" class="md-footer__link md-footer__link--prev" aria-label="Previous: Use Microsoft OpenJDK as preferred JVM distribution"></a>

<div class="md-footer__button md-icon">

![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIwIDExdjJIOGw1LjUgNS41LTEuNDIgMS40Mkw0LjE2IDEybDcuOTItNy45MkwxMy41IDUuNSA4IDExeiIgLz48L3N2Zz4=)

</div>

<div class="md-footer__title">

<span class="md-footer__direction"> Previous </span>

<div class="md-ellipsis">

Use Microsoft OpenJDK as preferred JVM distribution

</div>

</div>

<a href="../0004-choose-open-telemetry-for-application-telemetry-over-proprietary-libraries/" class="md-footer__link md-footer__link--next" aria-label="Next: Choose OpenTelemetry for Application Telemetry over Proprietary Libraries"></a>

<div class="md-footer__title">

<span class="md-footer__direction"> Next </span>

<div class="md-ellipsis">

Choose OpenTelemetry for Application Telemetry over Proprietary Libraries

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
