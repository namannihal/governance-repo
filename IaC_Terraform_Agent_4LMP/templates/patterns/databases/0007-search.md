---
id: LMP-PAT-0007
type: Technology Selection Pattern
status: published
approved_by:
  - LMP Migration Architecture Approval
valid_from: 2024-06-08
developer_productivity_hrs: 5
date: 2024-05-13
tags:
  - Search
tech_capabilities:
  - Platform / Application / Search
---

# Full-Text Document Indexing and Search

## Compatibility

Apps migrating to Azure under LMP have a variety of use cases for data search and indexing.

Telemetry analytics is one of the most common, but some application may also have Apache Lucene-style text
(or vector) search requirements. This pattern covers both.

It does not cover security use cases (e.g. SIEM).

## Recommended Target

- For telemetry analytics, where strategic tooling is unsuitable, Azure Data Explorer is an Azure-native equivalent
- For full text or vector search[^10][^11] use cases (e.g. for semantic similarity), Azure AI Search is an Azure-native
  equivalent that is suitable for many use cases
- For applications that cannot adopt new technology, Elasticsearch is available in either managed or self-managed
  guises, but - at the time of writing - work will be required to adopt the managed Elasticsearch offering

## Decision Tree Diagram

![Decision tree](./img/0001-search-decision-tree.png)

## Notable Differences

| Considerations              | Elastic Search (Managed)                                                                                                                                                                                                                  | Elastic Search (Unmanaged)         | Azure AI Search                                                                                                                                                                                                                                                                                  | Azure Data Explorer                                                                                                                                                                                              |
|-----------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Typical Use Case            | Flexible product that covers a variety of Observability, Security and Search use cases.                                                                                                                                                   | See Elastic Search (managed)       | PaaS that helps developers create their own text/vector search solutions.<br/><br/>Supports integrated chunking and vectorization and sophisticated vector, text and hybrid search queries.<br/><br/>Provides an index on top of an un-indexed data store (such as a database or object storage) | Fully managed data analytics service for real-time analysis on large volumes of data streaming from applications, websites, IoT devices, and more                                                                |
| Client Experience           | Elastic APIs (REST or SDK)                                                                                                                                                                                                                | See Elastic Search (managed)       | Azure AI Search APIs (REST or SDK)                                                                                                                                                                                                                                                               | KQL                                                                                                                                                                                                              |
| Integrations                | Many including Azure services, Kubernetes, message queues, databases [^5]<br/><br/>SDKs for Java, JavaScript, .NET, Python and others                                                                                                     | See Elastic Search (managed)       | SDKs for .NET, Python, JavaScript                                                                                                                                                                                                                                                                | Many e.g. Logstash, Open Telemetry, Azure Functions, Power Apps, JDBC/ODBC, Apache Spark, Kusto Explorer, Jupyter                                                                                                |
| Data ingestion              | Via Elastic Integrations, Beats, Elastic Agent, Logstash.                                                                                                                                                                                 | See Elastic Search (managed)       | Native indexing of Cosmos, SQL DB, Blob Storage, SQL Server on VMs.<br/><br/>Native support for Office, PDF, PNG, JSON, HTML, XML, RTF                                                                                                                                                           | Native support for ApacheAvro, Avro, CSV, JSON, MultiJSON, ORC, Parquet, PSV, RAW, SCsv, SOHsv, TSV, TSVE, TXT, W3CLOGFILE                                                                                       |
| Tiers                       | Offered as e.g. "Elastic Observability" or "Elastic Search"<br/><br/>Standard, Gold, Platinum, Enterprise[^4]                                                                                                                             | N/A                                | Basic (shared infra), Standard (dedicated), Storage Optimized (greater storage, bandwidth and memory)                                                                                                                                                                                            | Production and Dev/Test                                                                                                                                                                                          |
| Deployment model            | Elasticsearch Service is offered as a managed service via Azure Marketplace, including OS updates/patches, OS hardening, in-flight encryption, built-in resiliency, etc.<br/><br/>Offered as Search, Observability and Security variants. | Virtual Machines or Kubernetes[^9] | Charged by Search Unit ("SU") which is a function of no. replicas and no. partitions[^1]                                                                                                                                                                                                         | By cluster and database(s)                                                                                                                                                                                       |
| Pricing                     | Example $622/month[^2]: 105GB hot storage over 3 zones, 800GB warm over 2 zones, 1 zone Kibana (the minimum), 1 zone integration server (the minimum)                                                                                     | N/A                                | Non-linear, difficult to estimate. Examples:<br/><br/>1 x "Standard S1" unit per month $245<br/>1 x "Standard S2" unit per month $980                                                                                                                                                            | By data ingested, retained. Capacity reservations available.<br/><br/>Example $500: 100GB/day, 7 day hot retention, 4.5M read/writes, 1 year reservation, 2 x Engine instances and 2 x Data Management instances |
| Security, Licensing & Legal | Likely to be considered as material outsourcing for regulated products. Vendor security assessment required followed by Procurement.                                                                                                      | N/A                                | N/A                                                                                                                                                                                                                                                                                              | N/A                                                                                                                                                                                                              |
| Scaling                     | Based on preset Azure VM SKUs                                                                                                                                                                                                             | N/A                                | Manual, can take up to an hour                                                                                                                                                                                                                                                                   | Vertical or Horizontal (automatic by e.g. CPU, cache/ingestion utilization)                                                                                                                                      |
| Region availability         | Some regions unavailable, e.g. UK West, Canada East[^3]                                                                                                                                                                                   | N/A                                | Some features not available in UK West and Canada East                                                                                                                                                                                                                                           | Wide availability                                                                                                                                                                                                |
| SLA                         | Appears to be limited to support ticket response times.<br/><br/>Presumably also limited by underlying Azure infrastructure.                                                                                                              | N/A                                | 10% service credit for error rate >= 99.9%                                                                                                                                                                                                                                                       | 10% service credit for uptime <= 99.9%                                                                                                                                                                           |

## Considerations

- **Managed/Self-Managed trade-off**: There are clear benefits to adoption of a managed service: many architectural
  and operational concerns are taken care[^6], but there are concerns in that (a) data will be held in a third-party
  Subscription and (b) there are known limitations[^7] that may necessitate a self-managed instance. Before we adopt it,
  these concerns must be addressed.

## Alternatives

- **Serverless Elastic Cloud**: *"[Serverless instances](https://docs.elastic.co/serverless) are fully-managed,
  autoscaled, and automatically upgraded by Elastic"*. They are currently in Preview.
- **OpenSearch**: *"[OpenSearch](https://github.com/opensearch-project) is a community-driven, Apache 2.0-licensed
  open source search and analytics suite"*. The software started in 2021 as a fork of Elasticsearch and Kibana, with
  development led by AWS[^8]. Whilst available as [AWS OpenSearch](https://aws.amazon.com/opensearch-service/), there is
  no native Azure Service, and nor is there a compelling marketplace option.

## Further Reading

- [AWS CloudSearch](https://aws.amazon.com/cloudsearch/): A *"simple and cost-effective to set up, manage, and scale
  a search solution for your website or application"*
- [Azure Data Explorer documentation](https://learn.microsoft.com/en-us/azure/data-explorer/)
- [Azure AI Search documentation](https://learn.microsoft.com/en-us/azure/search/)
- [Elastic on Microsoft Azure documentation](https://www.elastic.co/guide/en/cloud/current/ec-azure-marketplace-native.html)
- [Superlinked Vector DB Comparison](https://superlinked.com/vector-db-comparison)
- [Microsoft Sponsored comparison of BigQuery, Snowflake and ADX](https://gigaom.com/report/log-data-analytics-testing/)

[^1]: [Azure AI Search Capacity Planning](https://learn.microsoft.com/en-us/azure/search/search-capacity-planning#partition-and-replica-combinations)
[^2]: [Elastic Pricing Calculator](https://cloud.elastic.co/pricing)
[^3]: [Elastic Region Availability](https://www.elastic.co/guide/en/cloud/current/ec-reference-regions.html)
[^4]: [Elastic Pricing Tiers](https://www.elastic.co/pricing)
[^5]: [Elastic integrations](https://www.elastic.co/integrations/data-integrations)
[^6]: [Elastic: Our Shared Responsibility](https://www.elastic.co/cloud/shared-responsibility)
[^7]: [Elastic Cloud Limitations](https://www.elastic.co/guide/en/cloud/current/ec-restrictions.html)
[^8]: [OpenSearch](https://en.wikipedia.org/wiki/OpenSearch_(software))
[^9]: [Running Elastic Cloud on Kubernetes from Azure Kubernetes Service](https://www.elastic.co/blog/how-to-run-elastic-cloud-on-kubernetes-from-azure-kubernetes-service)
[^10]: [Wikipedia: Vector Databases](https://en.wikipedia.org/wiki/Vector_database)
[^11]: [Vectors in Azure AI Search](https://learn.microsoft.com/en-us/azure/search/vector-search-overview)

