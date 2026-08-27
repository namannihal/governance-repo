<span class="md-content__button md-icon md-status--published" href="#" title="Status: Published"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE4LjUgMmgtMTNDMy42IDIgMiAzLjYgMiA1LjV2MTNDMiAyMC40IDMuNiAyMiA1LjUgMjJIMTZsNi02VjUuNUMyMiAzLjYgMjAuNCAyIDE4LjUgMk0yMCAxNWgtMS41Yy0xLjkgMC0zLjUgMS42LTMuNSAzLjVWMjBINS44Yy0xIDAtMS44LS44LTEuOC0xLjhWNS44QzQgNC44IDQuOCA0IDUuOCA0aDEyLjVjMSAwIDEuOC44IDEuOCAxLjhWMTVtLTQuOS02LjggMS41IDEuNS02IDYtMy41LTMuNSAxLjUtMS41IDIgMnoiIC8+PC9zdmc+) </span> <span class="md-content__button md-icon .md-status--published" title="Valid from 2024-09-09"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE5IDE5SDVWOGgxNG0wLTVoLTFWMWgtMnYySDhWMUg2djJINWEyIDIgMCAwIDAtMiAydjE0YTIgMiAwIDAgMCAyIDJoMTRhMiAyIDAgMCAwIDItMlY1YTIgMiAwIDAgMC0yLTJtLTIuNDcgOC4wNkwxNS40NyAxMGwtNC44OCA0Ljg4LTIuMTItMi4xMi0xLjA2IDEuMDZMMTAuNTkgMTd6IiAvPjwvc3ZnPg==) </span> <span class="md-content__button md-icon actions-date" title="Published on 2024-09-09">![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTkgMTB2Mkg3di0yem00IDB2MmgtMnYtMnptNCAwdjJoLTJ2LTJ6bTItN2EyIDIgMCAwIDEgMiAydjE0YTIgMiAwIDAgMS0yIDJINWEyIDIgMCAwIDEtMi0yVjVhMiAyIDAgMCAxIDItMmgxVjFoMnYyaDhWMWgydjJ6bTAgMTZWOEg1djExek05IDE0djJIN3YtMnptNCAwdjJoLTJ2LTJ6bTQgMHYyaC0ydi0yeiIgLz48L3N2Zz4=)</span> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/edit/main/docs/adrs/event-management/0011-use-azure-immutable-storage-for-app-auditing-logs.md" class="md-content__button md-icon" title="Edit this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTEwIDIwSDZWNGg3djVoNXYzLjFsMi0yVjhsLTYtNkg2Yy0xLjEgMC0yIC45LTIgMnYxNmMwIDEuMS45IDIgMiAyaDR6bTEwLjItN2MuMSAwIC4zLjEuNC4ybDEuMyAxLjNjLjIuMi4yLjYgMCAuOGwtMSAxLTIuMS0yLjEgMS0xYy4xLS4xLjItLjIuNC0uMm0wIDMuOUwxNC4xIDIzSDEydi0yLjFsNi4xLTYuMXoiIC8+PC9zdmc+" /></a> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/blob/main/docs/adrs/event-management/0011-use-azure-immutable-storage-for-app-auditing-logs.md" class="md-content__button md-icon" title="View source of this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE3IDE4Yy41NiAwIDEgLjQ0IDEgMXMtLjQ0IDEtMSAxLTEtLjQ0LTEtMSAuNDQtMSAxLTFtMC0zYy0yLjczIDAtNS4wNiAxLjY2LTYgNCAuOTQgMi4zNCAzLjI3IDQgNiA0czUuMDYtMS42NiA2LTRjLS45NC0yLjM0LTMuMjctNC02LTRtMCA2LjVhMi41IDIuNSAwIDAgMS0yLjUtMi41IDIuNSAyLjUgMCAwIDEgMi41LTIuNSAyLjUgMi41IDAgMCAxIDIuNSAyLjUgMi41IDIuNSAwIDAgMS0yLjUgMi41TTkuMjcgMjBINlY0aDd2NWg1djQuMDdjLjcuMDggMS4zNi4yNSAyIC40OVY4bC02LTZINmEyIDIgMCAwIDAtMiAydjE2YTIgMiAwIDAgMCAyIDJoNC41YTguMiA4LjIgMCAwIDEtMS4yMy0yIiAvPjwvc3ZnPg==" /></a>

Document Metadata

|  |  |
|----|----|
| Identifier | **`LMP-ADR-0011`** |
| Type | **ADR** |
| Status | **Published** |
| Approvals | <span class="md-tag">LMP Migration Architecture Approval</span> |
| Published on | **September 09, 2024** |
| Valid From | **September 09, 2024** |
| Authors | <span class="md-source-file__fact"> </span> |
| Tags | <span class="md-tag">Event Management</span> |
| Technology Capabilities | <span class="md-tag">Shared & Corporate / Risk, Audit & Compliance / Records Management</span> |

# Use Azure Immutable Blob Storage as Audit Log Destination for LMP Applications<a href="#use-azure-immutable-blob-storage-as-audit-log-destination-for-lmp-applications" class="headerlink" title="Permanent link">¶</a>

## Context and Problem Statement<a href="#context-and-problem-statement" class="headerlink" title="Permanent link">¶</a>

In order to provide un-tampered evidence to auditors when required, there are regulations, business requirements, and LSEG policies which may require certain types of application logs to be kept in immutable ways (aka WORM state - Write Once, Read Many), in addition to Observability and Monitoring requirements.

Audit logs are a subset of observability logs, they can be generated from both infrastructure level and application level, and broadly split between those required for SIEM (Security Information and Event Management) monitoring/analysis, and those not of SIEM concerns e.g. transaction history, change logs.

As the time of the writing, there are a few Platform capabilities, ADRs and Patterns covering Observability, Logging and Auditing concerns for different types of logs, but there is no clear architecture guidance on the 'Immutability' aspect of application-level logs, especially when the log contents are not in-scope to SIEM requirements. This ADR is aimed to answer the below questions potentially come from LMP application engineering teams, if they need support strong immutability requirements for log file storage:

- [LMP-ADR-0003](../0003-use-datadog-for-application-and-resource-monitoring/) suggested to use Datadog for Application and Resource monitoring, but Datadog alone doesn't support immutability and auditing retention requirements, what should I do?
- If I want my audit log contents to be correlated with other observability logs, but Datadog doesn't meet audit log immutability requirements in the same time, what should I do?
- Group SIEM platform may support audit log immutability. If my audit log content are not in-scope to SIEM ([SP-0024 - Security Logging - Applications Log Content Guidance](https://confluence.refinitiv.com/display/PSAR/SP-0024+-+Security+Logging+-+Applications+Log+Content+Guidance)), what should I do?
- If a subset of my audit log scope overlaps with SIEM requirements, what should I do?

A clear architecture decision with documented justification could be useful to help Engineering team answer these questions, save their time for research and ad-hoc meetings for consultancy. A separate Functional Architecture Pattern will be created to further help Application engineering teams design compliant and efficient application-level audit logging solutions.

## Decision Drivers<a href="#decision-drivers" class="headerlink" title="Permanent link">¶</a>

Multiple choices are available to meet a subset of immutable audit logging requirements, need provide clarity on the preferred storage destination for Application-level immutable audit logs, for LMP Engineering teams.

## Considered Options<a href="#considered-options" class="headerlink" title="Permanent link">¶</a>

- Datadog
- Azure Immutable Blob Storage
- Azure Log Analytics

## Decision Outcome<a href="#decision-outcome" class="headerlink" title="Permanent link">¶</a>

**Chosen option**: Azure Immutable Blob Storage

**Because**:

1.  No perfect solutions both satisfy the immutability and usability requirements of application-level audit logging. Assuming contents in audit log repository won't be heavily monitored and analyzed as other types of observability logs, the decision is biased towards Immutability rather than Usability. It supports immutability requirements from a wide range of regulations with proven compliance evidence and out-of-the-box operating model.
2.  Audit Logs can be kept in the source, without limitations (retention period, cost, etc.) imposed by the SIEM platform and Observability platform (Datadog).
3.  It offers a clear separation of concerns focusing on immutable storage for auditing, with sufficient flexibility for engineering teams to determine optimised log structure, file format, and retention periods.

### Positive Consequences<a href="#positive-consequences" class="headerlink" title="Permanent link">¶</a>

- As stated above.

### Negative Consequences<a href="#negative-consequences" class="headerlink" title="Permanent link">¶</a>

- Engineering teams may have to dual-write certain auditing logs into Datadog for Observability & Monitoring use cases, and SIEM platform for cyber-security monitoring use cases.
- No central capability to help consume and analyze audit logs (Engineering teams can use cloud native tooling like Azure Data Explorer when needed)

## Pros and Cons of the Options<a href="#pros-and-cons-of-the-options" class="headerlink" title="Permanent link">¶</a>

### Datadog<a href="#datadog" class="headerlink" title="Permanent link">¶</a>

See also: [Datadog Log Archiving to Azure Storage](https://confluence.refinitiv.com/display/PCP/Datadog+Log+Archiving+to+Azure+Storage)

- Good, as it can help correlate Audit Logs with other types of logs for observability use cases.
- Good, as it can leverage future Datadog enhancements on automated hydration and dehydration, to benefit audit log consumption use cases.
- Bad, as Datadog do not offer immutability with proven compliance evidence of major regulations.
- Bad, as engineering team has to implement process and procedure to differentiate and hydrate audit logs beyond Datadog's retention period (this is a current limitation, please see this [Jira ticket](https://jira.refinitiv.com/browse/PCP-23535) )

### Azure Immutable Blob Storage<a href="#azure-immutable-blob-storage" class="headerlink" title="Permanent link">¶</a>

See also: [Azure Product Documentation: Store business-critical blob data with immutable storage in a write once, read many (WORM) state](https://learn.microsoft.com/en-us/azure/storage/blobs/immutable-storage-overview)

- Good, because it provides out-of-the-box policy support for log file immutability, with proven compliance evidence of major regulations.
- Good, because the application audit logs can be stored 'in the source', without competing with central platforms' resource and capacities (e.g. Datadog or SIEM).
- Good, because it helps separate concerns of immutable audit log storage for application engineering teams, and give them flexibility to design, implement and evolve audit log structures and file formats, and implement domain-specific regulatory requirements e.g. longer retention periods.
- Bad, because of additional engineering overhead to dual-write Audit logs to dedicated destination in addition to Datadog (for Observability use cases e.g. log correlations) and SIEM (for Cyber-Security use cases).
- Bad, as there is no central capability to consume and analyze audit logs (Engineering teams can use cloud native tooling like Azure Data Explorer when needed)

### Azure Log Analytics<a href="#azure-log-analytics" class="headerlink" title="Permanent link">¶</a>

- Good, because LMP SIEM audit logs and non-SIEM audit logs can be stored and analyzed using the same technology.
- Good, because it can potentially replicate/reuse Cyber SIEM capabilities or best practice where makes sense.
- Bad, as the out-of-the-box features of Azure Log Analytics are optimised for Azure native resources and workloads ([Azure Product Documentation: Insights and curated visualizations](https://learn.microsoft.com/en-gb/azure/azure-monitor/insights/insights-overview#insights-and-curated-visualizations)), its support to Application Logs (aka Custom Logs) are limited and may put constraints and overheads to engineering teams which may outweigh the benefits.
- Bad, as engineering team has to configure, monitor and maintain the 'export' feature in order to have immutability and retention.

## More Information<a href="#more-information" class="headerlink" title="Permanent link">¶</a>

A separate Pattern will be provided to help engineering teams identify audit log subjects, and store them in sustainable and reusable formats.

See Also:

1.  [Regulatory Compliance of Azure Immutable Storage](https://learn.microsoft.com/en-us/azure/storage/blobs/immutable-storage-overview#regulatory-compliance)
2.  [Azure Log Analytics: Long-term retention of audit and security data](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/logs-data-export?tabs=portal#overview)

<span class="md-source-file__fact"> <span class="md-icon" title="Last update"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIxIDEzLjFjLS4xIDAtLjMuMS0uNC4ybC0xIDEgMi4xIDIuMSAxLTFjLjItLjIuMi0uNiAwLS44bC0xLjMtMS4zYy0uMS0uMS0uMi0uMi0uNC0uMm0tMS45IDEuOC02LjEgNlYyM2gyLjFsNi4xLTYuMXpNMTIuNSA3djUuMmw0IDIuNC0xIDFMMTEgMTNWN3pNMTEgMjEuOWMtNS4xLS41LTktNC44LTktOS45QzIgNi41IDYuNSAyIDEyIDJjNS4zIDAgOS42IDQuMSAxMCA5LjMtLjMtLjEtLjYtLjItMS0uMnMtLjcuMS0xIC4yQzE5LjYgNy4yIDE2LjIgNCAxMiA0Yy00LjQgMC04IDMuNi04IDggMCA0LjEgMy4xIDcuNSA3LjEgNy45bC0uMS4yeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="December 16, 2024 10:10:33 UTC">December 16, 2024</span> </span> <span class="md-source-file__fact"> <span class="md-icon" title="Created"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE0LjQ3IDE1LjA4IDExIDEzVjdoMS41djUuMjVsMy4wOCAxLjgzYy0uNDEuMjgtLjc5LjYyLTEuMTEgMW0tMS4zOSA0Ljg0Yy0uMzYuMDUtLjcxLjA4LTEuMDguMDgtNC40MiAwLTgtMy41OC04LThzMy41OC04IDgtOCA4IDMuNTggOCA4YzAgLjM3LS4wMy43Mi0uMDggMS4wOC42OS4xIDEuMzMuMzIgMS45Mi42NC4xLS41Ni4xNi0xLjEzLjE2LTEuNzIgMC01LjUtNC41LTEwLTEwLTEwUzIgNi41IDIgMTJzNC40NyAxMCAxMCAxMGMuNTkgMCAxLjE2LS4wNiAxLjcyLS4xNi0uMzItLjU5LS41NC0xLjIzLS42NC0xLjkyTTE4IDE1djNoLTN2MmgzdjNoMnYtM2gzdi0yaC0zdi0zeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="December 16, 2024 10:10:33 UTC">December 16, 2024</span> </span>

<a href="../0010-app-migration-datadog-onboarding-RACI-in-LMP/" class="md-footer__link md-footer__link--prev" aria-label="Previous: Share Datadog &amp;amp; BigPanda responsibilities between Platform Engineering, Application and LMP Migration Teams"></a>

<div class="md-footer__button md-icon">

![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIwIDExdjJIOGw1LjUgNS41LTEuNDIgMS40Mkw0LjE2IDEybDcuOTItNy45MkwxMy41IDUuNSA4IDExeiIgLz48L3N2Zz4=)

</div>

<div class="md-footer__title">

<span class="md-footer__direction"> Previous </span>

<div class="md-ellipsis">

Share Datadog & BigPanda responsibilities between Platform Engineering, Application and LMP Migration Teams

</div>

</div>

<a href="../../foundation-platform/0006-subscription-tenancy/" class="md-footer__link md-footer__link--next" aria-label="Next: Prefer a Subscription per Application family-Environment (or App-Environment, if no Application family exists)"></a>

<div class="md-footer__title">

<span class="md-footer__direction"> Next </span>

<div class="md-ellipsis">

Prefer a Subscription per Application family-Environment (or App-Environment, if no Application family exists)

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
