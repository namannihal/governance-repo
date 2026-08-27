<span class="md-content__button md-icon md-status--published" href="#" title="Status: Published"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE4LjUgMmgtMTNDMy42IDIgMiAzLjYgMiA1LjV2MTNDMiAyMC40IDMuNiAyMiA1LjUgMjJIMTZsNi02VjUuNUMyMiAzLjYgMjAuNCAyIDE4LjUgMk0yMCAxNWgtMS41Yy0xLjkgMC0zLjUgMS42LTMuNSAzLjVWMjBINS44Yy0xIDAtMS44LS44LTEuOC0xLjhWNS44QzQgNC44IDQuOCA0IDUuOCA0aDEyLjVjMSAwIDEuOC44IDEuOCAxLjhWMTVtLTQuOS02LjggMS41IDEuNS02IDYtMy41LTMuNSAxLjUtMS41IDIgMnoiIC8+PC9zdmc+) </span> <span class="md-content__button md-icon .md-status--published" title="Valid from 2024-05-21"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE5IDE5SDVWOGgxNG0wLTVoLTFWMWgtMnYySDhWMUg2djJINWEyIDIgMCAwIDAtMiAydjE0YTIgMiAwIDAgMCAyIDJoMTRhMiAyIDAgMCAwIDItMlY1YTIgMiAwIDAgMC0yLTJtLTIuNDcgOC4wNkwxNS40NyAxMGwtNC44OCA0Ljg4LTIuMTItMi4xMi0xLjA2IDEuMDZMMTAuNTkgMTd6IiAvPjwvc3ZnPg==) </span> <span class="md-content__button md-icon actions-date" title="Published on 2024-05-21">![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTkgMTB2Mkg3di0yem00IDB2MmgtMnYtMnptNCAwdjJoLTJ2LTJ6bTItN2EyIDIgMCAwIDEgMiAydjE0YTIgMiAwIDAgMS0yIDJINWEyIDIgMCAwIDEtMi0yVjVhMiAyIDAgMCAxIDItMmgxVjFoMnYyaDhWMWgydjJ6bTAgMTZWOEg1djExek05IDE0djJIN3YtMnptNCAwdjJoLTJ2LTJ6bTQgMHYyaC0ydi0yeiIgLz48L3N2Zz4=)</span> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/edit/main/docs/patterns/databases/0008-document-databases.md" class="md-content__button md-icon" title="Edit this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTEwIDIwSDZWNGg3djVoNXYzLjFsMi0yVjhsLTYtNkg2Yy0xLjEgMC0yIC45LTIgMnYxNmMwIDEuMS45IDIgMiAyaDR6bTEwLjItN2MuMSAwIC4zLjEuNC4ybDEuMyAxLjNjLjIuMi4yLjYgMCAuOGwtMSAxLTIuMS0yLjEgMS0xYy4xLS4xLjItLjIuNC0uMm0wIDMuOUwxNC4xIDIzSDEydi0yLjFsNi4xLTYuMXoiIC8+PC9zdmc+" /></a> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/blob/main/docs/patterns/databases/0008-document-databases.md" class="md-content__button md-icon" title="View source of this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE3IDE4Yy41NiAwIDEgLjQ0IDEgMXMtLjQ0IDEtMSAxLTEtLjQ0LTEtMSAuNDQtMSAxLTFtMC0zYy0yLjczIDAtNS4wNiAxLjY2LTYgNCAuOTQgMi4zNCAzLjI3IDQgNiA0czUuMDYtMS42NiA2LTRjLS45NC0yLjM0LTMuMjctNC02LTRtMCA2LjVhMi41IDIuNSAwIDAgMS0yLjUtMi41IDIuNSAyLjUgMCAwIDEgMi41LTIuNSAyLjUgMi41IDAgMCAxIDIuNSAyLjUgMi41IDIuNSAwIDAgMS0yLjUgMi41TTkuMjcgMjBINlY0aDd2NWg1djQuMDdjLjcuMDggMS4zNi4yNSAyIC40OVY4bC02LTZINmEyIDIgMCAwIDAtMiAydjE2YTIgMiAwIDAgMCAyIDJoNC41YTguMiA4LjIgMCAwIDEtMS4yMy0yIiAvPjwvc3ZnPg==" /></a>

Document Metadata

|  |  |
|----|----|
| Identifier | **`LMP-PAT-0008`** |
| Type | **Technology Selection Pattern** |
| Status | **Published** |
| Approvals | <span class="md-tag">LMP Migration Architecture Approval</span> |
| Published on | **May 21, 2024** |
| Valid From | **May 21, 2024** |
| Authors | <span class="md-source-file__fact"> </span> |
| Tags | <span class="md-tag">Database</span> |
| Technology Capabilities | <span class="md-tag">Platform / Data / Database / NoSQL Database</span><span class="md-tag">Platform / Data / Database / Unstructured Datastore</span> |

# Document Databases<a href="#document-databases" class="headerlink" title="Permanent link">¶</a>

## Compatibility<a href="#compatibility" class="headerlink" title="Permanent link">¶</a>

This advice pertains to the choice of NoSQL database in Azure, particularly for migrations from AWS DynamoDB.

## Recommended Targets<a href="#recommended-targets" class="headerlink" title="Permanent link">¶</a>

- Azure Cosmos DB for NoSQL
- Azure Cosmos DB for MongoDB

## Decision Tree Diagram<a href="#decision-tree-diagram" class="headerlink" title="Permanent link">¶</a>

![Database Selection](0008-document-databases.assets/image-001.png)

## Notable Differences - NoSQL & MongoDB<sup><a href="#fn:3" class="footnote-ref">1</a></sup><a href="#notable-differences-nosql-mongodb" class="headerlink" title="Permanent link">¶</a>

| Similarity | Consideration | DynamoDB | Cosmos DB for NoSQL | Cosmos DB for MongoDB |
|----|----|----|----|----|
| 🟢 | Data Model | Document (JSON) | Document (JSON) | Document (BSON) |
| 🟢 | Data Structure | Table:Item:Attribute | Database:Collection:Document:Field | Database:Collection:Document:Field |
| 🟡 | Query Language Support | SDKs | SQL, SDKs | MQL, SDKs |
| 🟢 | Transaction support | Yes | Yes | Yes |
| 🟢 | Data Migration | Export as Dynamo JSON or Ion | Java/.NET SDK<sup><a href="#fn:8" class="footnote-ref">5</a></sup>, Striim<sup><a href="#fn:9" class="footnote-ref">6</a></sup> | mongodump, mongorestore |
|  | Max size | Unlimited | 20 GB/partition, unlimited per container<sup><a href="#fn:6" class="footnote-ref">7</a></sup> | 20 GB/partition, unlimited per container<sup><a href="#fn:6" class="footnote-ref">7</a></sup> |
| 🟡 | Scaling | Read Units, Compute Units | Provisioned or Serverless, see below | Request Units or vCore, see below |
|  | Pricing model | By storage, write rate, read rate | See tables, below | See tables, below |
| 🟢 | SLA | e.g. Standard Tables 10% credit at \< 99.99%, \> 99.0%<sup><a href="#fn:6" class="footnote-ref">7</a></sup> | e.g. 10% credit at \< 99.99%<sup><a href="#fn:7" class="footnote-ref">8</a></sup> | e.g. 10% credit at \< 99.99%<sup><a href="#fn:7" class="footnote-ref">8</a></sup> |
|  | Community | 500+ Stack Overflow results | 230+ Stack Overflow results | 500+ Stack Overflow results |
|  | DR/High Availability | Availability Zones | Global distribution | Global distribution |
| 🟡 | Consistency Model | Eventual or Strong | Eventual, Consistent Prefix, Session, Bounded Staleness, Strong<sup><a href="#fn:4" class="footnote-ref">9</a></sup> | Mapping of 3 Cosmos levels to Mongo Read and Write concerns<sup><a href="#fn:5" class="footnote-ref">10</a></sup> |

## Notable Differences - NoSQL Provisioned & Serverless<sup><a href="#fn:11" class="footnote-ref">2</a></sup><a href="#notable-differences-nosql-provisioned-serverless" class="headerlink" title="Permanent link">¶</a>

| Similarity | Consideration | Provisioned | Serverless |
|----|----|----|----|
| 🟢 | Query Suitability | All database operations | All database operations |
| 🟡 | Availability | Global | Regional |
| 🟡 | Provisioning | Configured | Automatic |
| 🟡 | Storage<sup><a href="#fn:1" class="footnote-ref">11</a></sup> | Unlimited | \<= 1 TB |
| 🟢 | Latency | \< 10ms point read/writes | \< 10 ms point reads; \< 30 ms point writes |
| 🟡 | Pricing | Per *provisioned* RU/hour | Per *consumed* RU/hour |

### Notable Differences - MongoDB RU & vCore<sup><a href="#fn:13" class="footnote-ref">3</a></sup><a href="#notable-differences-mongodb-ru-vcore" class="headerlink" title="Permanent link">¶</a>

| Similarity | Consideration | Azure Cosmos DB for MongoDB (RU) | Azure Cosmos DB for MongoDB (vCore) |
|----|----|----|----|
| 🟡 | Query Suitability | Mostly point reads | Mostly long-running, complex queries |
| 🟡 | Scaling model | Horizontal, instantaneous | Horizontal and vertical |
| 🟡 | Availability | 99.999% | 99.995% |
| 🔴 | Vector support | N/A | Yes |
| 🟡 | Provisioning | Multi-tenant | Dedicated |
| 🟡 | Pricing | By no. RUs, storage | By CPU, memory, nodes, storage |

## Considerations<a href="#considerations" class="headerlink" title="Permanent link">¶</a>

- For applications that require a NoSQL store, but are not migrating from an existing technology, consider Cosmos DB for NoSQL. According to the documentation: *It offers the best end-to-end experience as we have full control over the interface, service, and the SDK client libraries. Any new feature that is rolled out to Azure Cosmos DB is first available on API for NoSQL accounts*
- The best target in Azure is Cosmosdb. Now Cosmosdb comes with different inbuilt supported APIs for different sources. - NoSQL API: This is native to Azure Cosmos DB and stores data in document format. - MongoDB API: This API implements the wire protocol of MongoDB, an open-source document-oriented database. - PostgreSQL API: This API implements the wire protocol of PostgreSQL, an open-source relational database. - Cassandra API: This API implements the wire protocol of Cassandra, an open-source wide column store. - Gremlin API: This API implements the wire protocol of Gremlin, an open-source graph database. - Table API: This API implements the wire protocol of Azure Table Storage, a service that stores structured NoSQL data.

## Alternatives<a href="#alternatives" class="headerlink" title="Permanent link">¶</a>

- [Mongo Atlas](https://www.mongodb.com/products/platform/atlas-database)<sup><a href="#fn:2" class="footnote-ref">4</a></sup>
- [Apache Cassandra on Azure](https://learn.microsoft.com/en-gb/azure/cosmos-db/cassandra/choose-service)

## References<a href="#references" class="headerlink" title="Permanent link">¶</a>

<div class="footnote">

------------------------------------------------------------------------

1.  <div id="fn:3">

    [Migrate your application from Amazon DynamoDB to Azure Cosmos DB](https://learn.microsoft.com/en-us/azure/cosmos-db/nosql/dynamo-to-cosmos) <a href="#fnref:3" class="footnote-backref" title="Jump back to footnote 1 in the text">↩︎</a>

    </div>

2.  <div id="fn:11">

    [How to choose between provisioned throughput and serverless](https://learn.microsoft.com/en-us/azure/cosmos-db/throughput-serverless) <a href="#fnref:11" class="footnote-backref" title="Jump back to footnote 2 in the text">↩︎</a>

    </div>

3.  <div id="fn:13">

    [What is RU-based and vCore-based Azure Cosmos DB for MongoDB?](https://learn.microsoft.com/en-us/azure/cosmos-db/mongodb/choose-model) <a href="#fnref:13" class="footnote-backref" title="Jump back to footnote 3 in the text">↩︎</a>

    </div>

4.  <div id="fn:2">

    [Azure Cosmos DB for MongoDB vs MongoDB Atlas](https://learn.microsoft.com/en-us/azure/cosmos-db/mongodb/cosmos-db-vs-mongodb-atlas) <a href="#fnref:2" class="footnote-backref" title="Jump back to footnote 4 in the text">↩︎</a>

    </div>

5.  <div id="fn:8">

    [Cosmos DB Bulk Ingestion Library](https://github.com/Azure-Samples/azure-cosmosdb-bulkingestion) <a href="#fnref:8" class="footnote-backref" title="Jump back to footnote 5 in the text">↩︎</a>

    </div>

6.  <div id="fn:9">

    [Migrate data to Azure Cosmos DB for NoSQL account using Striim](https://learn.microsoft.com/en-us/azure/cosmos-db/nosql/migrate-data-striim) <a href="#fnref:9" class="footnote-backref" title="Jump back to footnote 6 in the text">↩︎</a>

    </div>

7.  <div id="fn:6">

    [Amazon DynamoDB Service Level Agreement](https://aws.amazon.com/dynamodb/sla/) <a href="#fnref:6" class="footnote-backref" title="Jump back to footnote 7 in the text">↩︎</a><a href="#fnref2:6" class="footnote-backref" title="Jump back to footnote 7 in the text">↩︎</a><a href="#fnref3:6" class="footnote-backref" title="Jump back to footnote 7 in the text">↩︎</a>

    </div>

8.  <div id="fn:7">

    [Microsoft SLAs for Online Services](https://www.microsoft.com/licensing/docs/view/Service-Level-Agreements-SLA-for-Online-Services?lang=1) <a href="#fnref:7" class="footnote-backref" title="Jump back to footnote 8 in the text">↩︎</a><a href="#fnref2:7" class="footnote-backref" title="Jump back to footnote 8 in the text">↩︎</a>

    </div>

9.  <div id="fn:4">

    [Consistency levels in Azure Cosmos DB](https://learn.microsoft.com/en-us/azure/cosmos-db/consistency-levels) <a href="#fnref:4" class="footnote-backref" title="Jump back to footnote 9 in the text">↩︎</a>

    </div>

10. <div id="fn:5">

    [Consistency levels for Azure Cosmos DB and the API for MongoDB](https://learn.microsoft.com/en-us/azure/cosmos-db/mongodb/consistency-mapping) <a href="#fnref:5" class="footnote-backref" title="Jump back to footnote 10 in the text">↩︎</a>

    </div>

11. <div id="fn:1">

    [Azure Cosmos DB Limits](https://learn.microsoft.com/en-us/azure/cosmos-db/concepts-limits) <a href="#fnref:1" class="footnote-backref" title="Jump back to footnote 11 in the text">↩︎</a>

    </div>

</div>

<span class="md-source-file__fact"> <span class="md-icon" title="Last update"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIxIDEzLjFjLS4xIDAtLjMuMS0uNC4ybC0xIDEgMi4xIDIuMSAxLTFjLjItLjIuMi0uNiAwLS44bC0xLjMtMS4zYy0uMS0uMS0uMi0uMi0uNC0uMm0tMS45IDEuOC02LjEgNlYyM2gyLjFsNi4xLTYuMXpNMTIuNSA3djUuMmw0IDIuNC0xIDFMMTEgMTNWN3pNMTEgMjEuOWMtNS4xLS41LTktNC44LTktOS45QzIgNi41IDYuNSAyIDEyIDJjNS4zIDAgOS42IDQuMSAxMCA5LjMtLjMtLjEtLjYtLjItMS0uMnMtLjcuMS0xIC4yQzE5LjYgNy4yIDE2LjIgNCAxMiA0Yy00LjQgMC04IDMuNi04IDggMCA0LjEgMy4xIDcuNSA3LjEgNy45bC0uMS4yeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="May 30, 2025 16:15:49 UTC">May 30, 2025</span> </span> <span class="md-source-file__fact"> <span class="md-icon" title="Created"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE0LjQ3IDE1LjA4IDExIDEzVjdoMS41djUuMjVsMy4wOCAxLjgzYy0uNDEuMjgtLjc5LjYyLTEuMTEgMW0tMS4zOSA0Ljg0Yy0uMzYuMDUtLjcxLjA4LTEuMDguMDgtNC40MiAwLTgtMy41OC04LThzMy41OC04IDgtOCA4IDMuNTggOCA4YzAgLjM3LS4wMy43Mi0uMDggMS4wOC42OS4xIDEuMzMuMzIgMS45Mi42NC4xLS41Ni4xNi0xLjEzLjE2LTEuNzIgMC01LjUtNC41LTEwLTEwLTEwUzIgNi41IDIgMTJzNC40NyAxMCAxMCAxMGMuNTkgMCAxLjE2LS4wNiAxLjcyLS4xNi0uMzItLjU5LS41NC0xLjIzLS42NC0xLjkyTTE4IDE1djNoLTN2MmgzdjNoMnYtM2gzdi0yaC0zdi0zeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="July 3, 2024 13:01:40 UTC">July 3, 2024</span> </span>

<a href="../0007-search/" class="md-footer__link md-footer__link--prev" aria-label="Previous: Full-Text Document Indexing and Search"></a>

<div class="md-footer__button md-icon">

![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIwIDExdjJIOGw1LjUgNS41LTEuNDIgMS40Mkw0LjE2IDEybDcuOTItNy45MkwxMy41IDUuNSA4IDExeiIgLz48L3N2Zz4=)

</div>

<div class="md-footer__title">

<span class="md-footer__direction"> Previous </span>

<div class="md-ellipsis">

Full-Text Document Indexing and Search

</div>

</div>

<a href="../0009-graph-databases/" class="md-footer__link md-footer__link--next" aria-label="Next: Graph Databases"></a>

<div class="md-footer__title">

<span class="md-footer__direction"> Next </span>

<div class="md-ellipsis">

Graph Databases

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
