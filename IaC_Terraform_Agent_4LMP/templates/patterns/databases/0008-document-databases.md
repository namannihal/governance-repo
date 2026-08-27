---
id: LMP-PAT-0008
type: Technology Selection Pattern
status: published
approved_by:
  - LMP Migration Architecture Approval
date: 2024-05-21
valid_from: 2024-05-21
developer_productivity_hrs: 5
tags:
  - Database
tech_capabilities:
  - Platform / Data / Database / NoSQL Database
  - Platform / Data / Database / Unstructured Datastore
---

# Document Databases

## Compatibility

This advice pertains to the choice of NoSQL database in Azure, particularly for migrations from AWS DynamoDB.

## Recommended Targets

- Azure Cosmos DB for NoSQL
- Azure Cosmos DB for MongoDB

## Decision Tree Diagram

![Database Selection](./img/database-selection.png)

## Notable Differences - NoSQL & MongoDB[^3]

| Similarity | Consideration          | DynamoDB                                                 | Cosmos DB for NoSQL                                                 | Cosmos DB for MongoDB                                           |
|------------|------------------------|----------------------------------------------------------|---------------------------------------------------------------------|-----------------------------------------------------------------|
| 🟢         | Data Model             | Document (JSON)                                          | Document (JSON)                                                     | Document (BSON)                                                 |
| 🟢         | Data Structure         | Table:Item:Attribute                                     | Database:Collection:Document:Field                                  | Database:Collection:Document:Field                              |
| 🟡         | Query Language Support | SDKs                                                     | SQL, SDKs                                                           | MQL, SDKs                                                       |
| 🟢         | Transaction support    | Yes                                                      | Yes                                                                 | Yes                                                             |
| 🟢         | Data Migration         | Export as Dynamo JSON or Ion                             | Java/.NET SDK[^8], Striim[^9]                                       | mongodump, mongorestore                                         |
|            | Max size               | Unlimited                                                | 20 GB/partition, unlimited per container[^6]                        | 20 GB/partition, unlimited per container[^6]                    |
| 🟡         | Scaling                | Read Units, Compute Units                                | Provisioned or Serverless, see below                                | Request Units or vCore, see below                               |
|            | Pricing model          | By storage, write rate, read rate                        | See tables, below                                                   | See tables, below                                               |
| 🟢         | SLA                    | e.g. Standard Tables 10% credit at < 99.99%, > 99.0%[^6] | e.g. 10% credit at < 99.99%[^7]                                     | e.g. 10% credit at < 99.99%[^7]                                 |
|            | Community              | 500+ Stack Overflow results                              | 230+  Stack Overflow results                                        | 500+ Stack Overflow results                                     |
|            | DR/High Availability   | Availability Zones                                       | Global distribution                                                 | Global distribution                                             |
| 🟡         | Consistency Model      | Eventual or Strong                                       | Eventual, Consistent Prefix, Session, Bounded Staleness, Strong[^4] | Mapping of 3 Cosmos levels to Mongo Read and Write concerns[^5] |

## Notable Differences - NoSQL Provisioned & Serverless[^11]

| Similarity | Consideration     | Provisioned               | Serverless                                |
|------------|-------------------|---------------------------|-------------------------------------------|
| 🟢         | Query Suitability | All database operations   | All database operations                   |
| 🟡         | Availability      | Global                    | Regional                                  |
| 🟡         | Provisioning      | Configured                | Automatic                                 |
| 🟡         | Storage[^1]       | Unlimited                 | <= 1 TB                                   |
| 🟢         | Latency           | < 10ms point read/writes  | < 10 ms point reads; < 30 ms point writes |
| 🟡         | Pricing           | Per *provisioned* RU/hour | Per *consumed* RU/hour                    |

### Notable Differences - MongoDB RU & vCore[^13]

| Similarity | Consideration     | Azure Cosmos DB for MongoDB (RU) | Azure Cosmos DB for MongoDB (vCore)  |
|------------|-------------------|----------------------------------|--------------------------------------|
| 🟡         | Query Suitability | Mostly point reads               | Mostly long-running, complex queries |
| 🟡         | Scaling model     | Horizontal, instantaneous        | Horizontal and vertical              |
| 🟡         | Availability      | 99.999%                          | 99.995%                              |
| 🔴         | Vector support    | N/A                              | Yes                                  |
| 🟡         | Provisioning      | Multi-tenant                     | Dedicated                            |
| 🟡         | Pricing           | By no. RUs, storage              | By CPU, memory, nodes, storage       |

## Considerations

- For applications that require a NoSQL store, but are not migrating from an existing technology, consider Cosmos DB for
  NoSQL. According to the documentation: *It offers the best end-to-end experience as we have full control over the
  interface, service, and the SDK client libraries.
  Any new feature that is rolled out to Azure Cosmos DB is first available on API for NoSQL accounts*
- The best target in Azure is Cosmosdb. Now Cosmosdb comes with different inbuilt supported APIs for different sources.
    - NoSQL API: This is native to Azure Cosmos DB and stores data in document format.
    - MongoDB API: This API implements the wire protocol of MongoDB, an open-source document-oriented database.
    - PostgreSQL API: This API implements the wire protocol of PostgreSQL, an open-source relational database.
    - Cassandra API: This API implements the wire protocol of Cassandra, an open-source wide column store.
    - Gremlin API: This API implements the wire protocol of Gremlin, an open-source graph database.
    - Table API: This API implements the wire protocol of Azure Table Storage, a service that stores structured NoSQL
      data.

## Alternatives

- [Mongo Atlas](https://www.mongodb.com/products/platform/atlas-database)[^2]
- [Apache Cassandra on Azure](https://learn.microsoft.com/en-gb/azure/cosmos-db/cassandra/choose-service)

## References

[^1]: [Azure Cosmos DB Limits](https://learn.microsoft.com/en-us/azure/cosmos-db/concepts-limits)
[^2]: [Azure Cosmos DB for MongoDB vs MongoDB Atlas](https://learn.microsoft.com/en-us/azure/cosmos-db/mongodb/cosmos-db-vs-mongodb-atlas)
[^3]: [Migrate your application from Amazon DynamoDB to Azure Cosmos DB](https://learn.microsoft.com/en-us/azure/cosmos-db/nosql/dynamo-to-cosmos)
[^4]: [Consistency levels in Azure Cosmos DB](https://learn.microsoft.com/en-us/azure/cosmos-db/consistency-levels)
[^5]: [Consistency levels for Azure Cosmos DB and the API for MongoDB](https://learn.microsoft.com/en-us/azure/cosmos-db/mongodb/consistency-mapping)
[^6]: [Amazon DynamoDB Service Level Agreement](https://aws.amazon.com/dynamodb/sla/)
[^7]: [Microsoft SLAs for Online Services](https://www.microsoft.com/licensing/docs/view/Service-Level-Agreements-SLA-for-Online-Services?lang=1)
[^8]: [Cosmos DB Bulk Ingestion Library](https://github.com/Azure-Samples/azure-cosmosdb-bulkingestion)
[^9]: [Migrate data to Azure Cosmos DB for NoSQL account using Striim](https://learn.microsoft.com/en-us/azure/cosmos-db/nosql/migrate-data-striim)
[^11]: [How to choose between provisioned throughput and serverless](https://learn.microsoft.com/en-us/azure/cosmos-db/throughput-serverless)
[^13]: [What is RU-based and vCore-based Azure Cosmos DB for MongoDB?](https://learn.microsoft.com/en-us/azure/cosmos-db/mongodb/choose-model)

