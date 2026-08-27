---
id: LMP-PAT-0009
type: Technology Selection Pattern
status: published
approved_by:
  - LMP Migration Architecture Approval
date: 2024-05-21
valid_from: 2024-05-21
developer_productivity_hrs: 2
tags:
  - Database
tech_capabilities:
  - Platform / Data / Database / Graph Database
---

# Graph Databases

## Compatibility

This advice pertains to the choice of Graph database in Azure, driven by public Microsoft Azure documentation and
internally produced LMP guidance.

A graph database uses graph structures for semantic queries with nodes, edges, and properties to represent and store
data[^1]

## Recommended Target

Azure Cosmos DB for Gremlin[^2].

## Notable Differences

| Similarity | Consideration        | AWS Neptune                                                                                                     | Azure Cosmos DB for Gremlin                                                                                | Neo4j                            |
|------------|----------------------|-----------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------|----------------------------------|
| 🟡         | Graph Model          | Gremlin compatible[^3], Neo4j openCypher[^4], SPARQL                                                            | Gremlin compatible[^5]                                                                                     | Cypher[^6]                       |
| 🟢         | Latency              | "Millisecond latency". Caching supported[^10].                                                                  | < 10ms for point read/write[^11]                                                                           | Deployment dependent             |
| 🔴         | Data migration       | Neptune Bulk Loader (from Tinkerpop Gremlin)[^14]; Neptune Export service/CLI (as csv, json, Gremlin JSON)[^15] | Java/.NET SDK[^16]                                                                                         | CLI from CSV, SDK & APOC library |
| 🟡         | Max Size             | 128 tebibytes (TiB)[^9]                                                                                         | 20 GB/partition, unlimited per container[^8]                                                               | Deployment dependent             |
| 🟡         | Scaling              | Storage: automatic; Vertically: by class; Horizontally: up to 15 read replicas with auto-scaling                | By partition, automatically, if effective partition keys are chosen                                        | Read replicas, sharding          |
| 🔴         | Pricing model        | Per GB-month & I/O, e.g. 500 GB, 10M requests/month -> ~$12.8k/month                                            | By storage and Request Unit, e.g. 500 GB, 2 regions, 1xCRUD/sec (2.6M/month) -> 400 RUs -> $300/month[^13] | Aura: ~$6k/month[^19]            |
| 🟢         | Deployment model     | PaaS; Serverless[^17]                                                                                           | PaaS; Serverless[^18]                                                                                      | Self-managed or SaaS             |
| 🟢         | SLA                  | e.g. 10% service credit at 99.0%-99.9%[^7]                                                                      | e.g. 10% credit at < 99.99%[^12]                                                                           | Aura: 99.95% availability[^19]   |
| 🟢         | Community            | ~500 Stack Overflow results                                                                                     | ~200 Stack Overflow results                                                                                | ~500 results (72 for Neo4j Aura) |
| 🟡         | DR/High Availability | Availability Zones                                                                                              | Global distribution                                                                                        | Aura: managed                    |

## Considerations

- Neo4j Aura, as a SaaS platform, will require security & procurement review

## Alternatives

- [Cypher for Gremlin](https://github.com/opencypher/cypher-for-gremlin) "adds Cypher support to any Gremlin graph
  database"
- [RedisGraph](https://redis.io/docs/latest/operate/oss_and_stack/stack-with-enterprise/deprecated-features/graph/) is
  now end of life

[^1]: [Graph Database - Wikipedia](https://en.wikipedia.org/wiki/Graph_database)
[^2]: [Apache Tinkerpop Gremlin](https://tinkerpop.apache.org/gremlin.html)
[^3]: [Neptune compatibility with Apache Tinkerpop Gremlin](https://docs.aws.amazon.com/neptune/latest/userguide/access-graph-gremlin-differences.html)
[^4]: [openCypher](https://opencypher.org)
[^5]: [Cosmos DB for Gremlin compatibility with Apache Tinkerpop Gremlin](https://learn.microsoft.com/en-us/azure/cosmos-db/gremlin/support)
[^6]: A [Gremlin Plugin for Neo4j](https://github.com/neo4j-contrib/gremlin-plugin) used to exist but has since been
archived
[^7]: [AWS Neptune SLA](https://aws.amazon.com/neptune/sla/)
[^8]: [Azure Cosmos DB Limits](https://learn.microsoft.com/en-us/azure/cosmos-db/concepts-limits)
[^9]: [AWS Neptune Limits](https://docs.aws.amazon.com/neptune/latest/userguide/limits.html)
[^10]: [Accelerate graph query performance with caching in Amazon Neptune](https://aws.amazon.com/blogs/database/part-2-accelerate-graph-query-performance-with-caching-in-amazon-neptune/)
[^11]: [Azure Cosmos latency](https://learn.microsoft.com/en-us/azure/cosmos-db/monitor-server-side-latency)
[^12]: [Microsoft SLAs for Online Services](https://www.microsoft.com/licensing/docs/view/Service-Level-Agreements-SLA-for-Online-Services?lang=1)
[^13]: [Azure Cosmos Capacity Calculator](https://cosmos.azure.com/capacitycalculator/)
[^14]: [Migrating to AWS Gremlin](https://docs.aws.amazon.com/neptune/latest/userguide/migrating.html)
[^15]: [Exporting from AWS Gremlin](https://docs.aws.amazon.com/neptune/latest/userguide/neptune-data-export.html)
[^16]: [Bulk import in Cosmos DB for Gremlin](https://learn.microsoft.com/en-us/azure/cosmos-db/gremlin/bulk-executor-dotnet)
[^17]: [AWS Neptune Serverless](https://docs.amazonaws.cn/en_us/neptune/latest/userguide/neptune-serverless.html)
[^18]: [Azure Cosmos DB for Gremlin Serverless](https://learn.microsoft.com/en-us/azure/cosmos-db/serverless)
[^19]: [Neo4j Aura on Azure Marketplace](https://appsource.microsoft.com/en-US/product/SaaS/neo4j.neo4j_aura)

