---
id: LMP-ADR-0011
type: ADR
status: published
approved_by:
  - LMP Migration Architecture Approval
date: 2024-09-09
valid_from: 2024-09-09
tags:
  - Event Management
tech_capabilities:
  - Shared & Corporate / Risk, Audit & Compliance / Records Management
---

# Use Azure Immutable Blob Storage as Audit Log Destination for LMP Applications

## Context and Problem Statement

In order to provide un-tampered evidence to auditors when required, there are regulations, business requirements, and
LSEG policies which may require certain types of application logs to be kept in immutable ways (aka WORM state - Write
Once, Read Many), in addition to Observability and Monitoring requirements.

Audit logs are a subset of observability logs, they can be generated from both infrastructure level and application
level, and broadly split between those required for SIEM (Security Information and Event Management)
monitoring/analysis, and those not of SIEM concerns e.g. transaction history, change logs.

As the time of the writing, there are a few Platform capabilities, ADRs and Patterns covering Observability, Logging and
Auditing concerns for different types of logs, but there is no clear architecture guidance on the 'Immutability' aspect
of application-level logs, especially when the log contents are not in-scope to SIEM requirements. This ADR is aimed to
answer the below questions potentially come from LMP application engineering teams, if they need support strong
immutability requirements for log file storage:

- [LMP-ADR-0003][adr-0003] suggested to use Datadog for Application and Resource monitoring, but Datadog alone doesn't
  support immutability and auditing retention requirements, what should I do?
- If I want my audit log contents to be correlated with other observability logs, but Datadog doesn't meet audit log
  immutability requirements in the same time, what should I do?
- Group SIEM platform may support audit log immutability. If my audit log content are not
  in-scope to SIEM ([SP-0024 - Security Logging - Applications Log Content Guidance][sp-0024]), what should I do?
- If a subset of my audit log scope overlaps with SIEM requirements, what should I do?

A clear architecture decision with documented justification could be useful to help Engineering team answer these
questions, save their time for research and ad-hoc meetings for consultancy. A separate Functional Architecture Pattern
will be created to further help Application engineering teams design compliant and efficient application-level audit
logging solutions.

## Decision Drivers

Multiple choices are available to meet a subset of immutable audit logging requirements, need provide clarity on the
preferred storage destination for Application-level immutable audit logs, for LMP Engineering teams.

## Considered Options

- Datadog
- Azure Immutable Blob Storage
- Azure Log Analytics

## Decision Outcome

**Chosen option**: Azure Immutable Blob Storage

**Because**:

1. No perfect solutions both satisfy the immutability and usability requirements of application-level audit logging.
   Assuming contents in audit log repository won't be heavily monitored and analyzed as other types of observability
   logs, the decision is biased towards Immutability rather than Usability. It supports immutability requirements from a
   wide range of regulations with proven compliance evidence and out-of-the-box operating model.
2. Audit Logs can be kept in the source, without limitations (retention period, cost, etc.) imposed by the SIEM platform
   and Observability platform (Datadog).
3. It offers a clear separation of concerns focusing on immutable storage for auditing, with sufficient flexibility for
   engineering teams to determine optimised log structure, file format, and retention periods.

### Positive Consequences

- As stated above.

### Negative Consequences

- Engineering teams may have to dual-write certain auditing logs into Datadog for Observability & Monitoring use cases,
  and SIEM platform for cyber-security monitoring use cases.
- No central capability to help consume and analyze audit logs (Engineering teams can use cloud native tooling like
  Azure Data Explorer when needed)

## Pros and Cons of the Options

### Datadog

See also: [Datadog Log Archiving to Azure Storage][datadog-to-azure]

- Good, as it can help correlate Audit Logs with other types of logs for observability use cases.
- Good, as it can leverage future Datadog enhancements on automated hydration and dehydration, to benefit audit log
  consumption use cases.
- Bad, as Datadog do not offer immutability with proven compliance evidence of major regulations.
- Bad, as engineering team has to implement process and procedure to differentiate and hydrate audit logs beyond
  Datadog's retention period (this is a current limitation, please see
  this [Jira ticket](https://jira.refinitiv.com/browse/PCP-23535) )

### Azure Immutable Blob Storage

See
also: [Azure Product Documentation: Store business-critical blob data with immutable storage in a write once, read many
(WORM) state][azure-immutable-storage]

- Good, because it provides out-of-the-box policy support for log file immutability, with proven compliance evidence of
  major regulations.
- Good, because the application audit logs can be stored 'in the source', without competing with central platforms'
  resource and capacities (e.g. Datadog or SIEM).
- Good, because it helps separate concerns of immutable audit log storage for application engineering teams, and give
  them flexibility to design, implement and evolve audit log structures and file formats, and implement domain-specific
  regulatory requirements e.g. longer retention periods.
- Bad, because of additional engineering overhead to dual-write Audit logs to dedicated destination in addition to
  Datadog (for Observability use cases e.g. log correlations) and SIEM (for Cyber-Security use cases).
- Bad, as there is no central capability to consume and analyze audit logs (Engineering teams can use cloud native
  tooling like Azure Data Explorer when needed)

### Azure Log Analytics

- Good, because LMP SIEM audit logs and non-SIEM audit logs can be stored and analyzed using the same technology.
- Good, because it can potentially replicate/reuse Cyber SIEM capabilities or best practice where makes sense.
- Bad, as the out-of-the-box features of Azure Log Analytics are optimised for Azure native resources and workloads
  ([Azure Product Documentation: Insights and curated visualizations][azure-insights-overview]),
  its support to Application Logs (aka Custom Logs) are limited and may put constraints and overheads to engineering
  teams which may outweigh the benefits.
- Bad, as engineering team has to configure, monitor and maintain the 'export' feature in order to have immutability and
  retention.

## More Information

A separate Pattern will be provided to help engineering teams identify audit log subjects, and store them in sustainable
and reusable formats.

See Also:

1. [Regulatory Compliance of Azure Immutable Storage][azure-immutable-storage-reg-complance]
2. [Azure Log Analytics: Long-term retention of audit and security data][log-analytics-retention]

[adr-0003]: 0003-use-datadog-for-application-and-resource-monitoring.md

[sp-0024]: https://confluence.refinitiv.com/display/PSAR/SP-0024+-+Security+Logging+-+Applications+Log+Content+Guidance

[datadog-to-azure]: https://confluence.refinitiv.com/display/PCP/Datadog+Log+Archiving+to+Azure+Storage

[azure-immutable-storage]: https://learn.microsoft.com/en-us/azure/storage/blobs/immutable-storage-overview

[azure-immutable-storage-reg-complance]: https://learn.microsoft.com/en-us/azure/storage/blobs/immutable-storage-overview#regulatory-compliance

[log-analytics-retention]: https://learn.microsoft.com/en-us/azure/azure-monitor/logs/logs-data-export?tabs=portal#overview

[azure-insights-overview]: https://learn.microsoft.com/en-gb/azure/azure-monitor/insights/insights-overview#insights-and-curated-visualizations

