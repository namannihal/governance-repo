---
id: LMP-ADR-0014
type: ADR
status: published
date: 2024-12-09
valid_from: 2024-12-09
approved_by:
  - LMP Migration Architecture Approval
tags:
  - Search
tech_capabilities:
  - Platform / Application / Search
---

# Users to remove dependencies on Elastic Search Platform (APP-205238) as they migrate to Azure

## Context and Problem Statement

['Elasticsearch Platform' (APP-205238)][app-205238], is a set of highly fragile, on-premise, centrally-managed
Elasticsearch clusters, with severe associated obsolescence risks. It has suffered numerous outages in recent years, and
the central team that manage it no longer have a sufficient team to operate it. The application is outside the LMP
perimeter (Retire R-type).

For the applications that leverage it today on-premise, it is providing a combination of text/document search use-cases,
in addition to a handful of ELK (Elastic-Logstash-Kibana) style use-cases.

In 2024, these functions can easily be provided by CSP PaaS services, or other LSEG strategic services (e.g. Datadog).

From the ElasticSearch Platform team, it is believed that the following applications leverage it today:

| Application                              | APP-ID                   |
|------------------------------------------|--------------------------|
| Filings in Eikon Analytics Platform      | [APP-204882][app-204882] |
| Research in Eikon Analytics Platform     | [APP-204881][app-204881] |
| Eikon Alerts                             | [APP-202634][app-202634] |
| Commodities / PointConnect               | [APP-204126][app-204126] |
| Datascope Select                         | [APP-200035][app-200035] |
| Events Platform                          | [APP-205230][app-205230] |
| EJV                                      | [APP-200016][app-200016] |
| News Entry Point                         | [APP-206271][app-206271] |
| Elektron Real Time Value Add             | [APP-202032][app-202032] |
| Equity MSR                               | [APP-204556][app-204556] |
| IFR / Capital Markets Insight Publishing | [APP-202652][app-202652] |

## Decision Drivers

The decision is driven by:

- Desire for reduction of obsolescence risks, Path-to-Amber (PtA), etc.
- Desire for simplification of data flows, for applications migrated to Azure - i.e. avoiding unnecessary hops back to
  on-premise, for specific functions
- Desire for de-coupled and autonomous functioning of applications migrated to Azure - to simplify operability

## Considered Options

Relevant options are fully covered in the [Full-Text Document Indexing and Search][search-s2t] source-to-target Pattern.

## Decision Outcome

Applications that leverage ElasticSearch Platform on-premise, as text/document search and indexing capability, must
remove their dependencies on it at the point
they migrate to Azure. Of the options described in the [Full-Text Document Indexing and Search][search-s2t]
source-to-target Pattern, all are valid, depending on the on-premise user scenario.

### Consequences

- Good, because as each user application migrates to Azure, dependency on Elasticsearch Platform reduces
- Good, because this approach will remove otherwise superfluous flows between Azure and on-premise
- Good, because it will de-couple applications from a legacy shared service, and provide autonomy in operation
- Bad, because it might inflate R-type of migrating application that, on-premise, leveraged ElasticSearch Platform

### Confirmation

The decision was validated by the D&A architecture community, the LMP architecture community, and Elasticsearch Platform
Engineering team.

## Pros and Cons of the Options

Covered in the [Full-Text Document Indexing and Search][search-s2t] source-to-target Pattern.

## More Information

Please see the [Full-Text Document Indexing and Search][search-s2t] source-to-target Pattern.

[search-s2t]: ../../patterns/databases/0007-search.md

[app-205238]: https://lseg.leanix.net/LsegPROD/external/applicationId/APP-205238

[app-204882]: https://lseg.leanix.net/LsegPROD/external/applicationId/APP-204882

[app-204881]: https://lseg.leanix.net/LsegPROD/external/applicationId/APP-204881

[app-202634]: https://lseg.leanix.net/LsegPROD/external/applicationId/APP-202634

[app-200035]: https://lseg.leanix.net/LsegPROD/external/applicationId/APP-200035

[app-202652]: https://lseg.leanix.net/LsegPROD/external/applicationId/APP-202652

[app-205230]: https://lseg.leanix.net/LsegPROD/external/applicationId/APP-205230

[app-200016]: https://lseg.leanix.net/LsegPROD/external/applicationId/APP-200016

[app-202032]: https://lseg.leanix.net/LsegPROD/external/applicationId/APP-202032

[app-204126]: https://lseg.leanix.net/LsegPROD/external/applicationId/APP-204126

[app-206271]: https://lseg.leanix.net/LsegPROD/external/applicationId/APP-206271

[app-204556]: https://lseg.leanix.net/LsegPROD/external/applicationId/APP-204556

