<span class="md-content__button md-icon md-status--published" href="#" title="Status: Published"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE4LjUgMmgtMTNDMy42IDIgMiAzLjYgMiA1LjV2MTNDMiAyMC40IDMuNiAyMiA1LjUgMjJIMTZsNi02VjUuNUMyMiAzLjYgMjAuNCAyIDE4LjUgMk0yMCAxNWgtMS41Yy0xLjkgMC0zLjUgMS42LTMuNSAzLjVWMjBINS44Yy0xIDAtMS44LS44LTEuOC0xLjhWNS44QzQgNC44IDQuOCA0IDUuOCA0aDEyLjVjMSAwIDEuOC44IDEuOCAxLjhWMTVtLTQuOS02LjggMS41IDEuNS02IDYtMy41LTMuNSAxLjUtMS41IDIgMnoiIC8+PC9zdmc+) </span> <span class="md-content__button md-icon .md-status--published" title="Valid from 2024-05-21"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE5IDE5SDVWOGgxNG0wLTVoLTFWMWgtMnYySDhWMUg2djJINWEyIDIgMCAwIDAtMiAydjE0YTIgMiAwIDAgMCAyIDJoMTRhMiAyIDAgMCAwIDItMlY1YTIgMiAwIDAgMC0yLTJtLTIuNDcgOC4wNkwxNS40NyAxMGwtNC44OCA0Ljg4LTIuMTItMi4xMi0xLjA2IDEuMDZMMTAuNTkgMTd6IiAvPjwvc3ZnPg==) </span> <span class="md-content__button md-icon actions-date" title="Published on 2024-05-21">![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTkgMTB2Mkg3di0yem00IDB2MmgtMnYtMnptNCAwdjJoLTJ2LTJ6bTItN2EyIDIgMCAwIDEgMiAydjE0YTIgMiAwIDAgMS0yIDJINWEyIDIgMCAwIDEtMi0yVjVhMiAyIDAgMCAxIDItMmgxVjFoMnYyaDhWMWgydjJ6bTAgMTZWOEg1djExek05IDE0djJIN3YtMnptNCAwdjJoLTJ2LTJ6bTQgMHYyaC0ydi0yeiIgLz48L3N2Zz4=)</span> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/edit/main/docs/patterns/databases/0009-graph-databases.md" class="md-content__button md-icon" title="Edit this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTEwIDIwSDZWNGg3djVoNXYzLjFsMi0yVjhsLTYtNkg2Yy0xLjEgMC0yIC45LTIgMnYxNmMwIDEuMS45IDIgMiAyaDR6bTEwLjItN2MuMSAwIC4zLjEuNC4ybDEuMyAxLjNjLjIuMi4yLjYgMCAuOGwtMSAxLTIuMS0yLjEgMS0xYy4xLS4xLjItLjIuNC0uMm0wIDMuOUwxNC4xIDIzSDEydi0yLjFsNi4xLTYuMXoiIC8+PC9zdmc+" /></a> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/blob/main/docs/patterns/databases/0009-graph-databases.md" class="md-content__button md-icon" title="View source of this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE3IDE4Yy41NiAwIDEgLjQ0IDEgMXMtLjQ0IDEtMSAxLTEtLjQ0LTEtMSAuNDQtMSAxLTFtMC0zYy0yLjczIDAtNS4wNiAxLjY2LTYgNCAuOTQgMi4zNCAzLjI3IDQgNiA0czUuMDYtMS42NiA2LTRjLS45NC0yLjM0LTMuMjctNC02LTRtMCA2LjVhMi41IDIuNSAwIDAgMS0yLjUtMi41IDIuNSAyLjUgMCAwIDEgMi41LTIuNSAyLjUgMi41IDAgMCAxIDIuNSAyLjUgMi41IDIuNSAwIDAgMS0yLjUgMi41TTkuMjcgMjBINlY0aDd2NWg1djQuMDdjLjcuMDggMS4zNi4yNSAyIC40OVY4bC02LTZINmEyIDIgMCAwIDAtMiAydjE2YTIgMiAwIDAgMCAyIDJoNC41YTguMiA4LjIgMCAwIDEtMS4yMy0yIiAvPjwvc3ZnPg==" /></a>

Document Metadata

|  |  |
|----|----|
| Identifier | **`LMP-PAT-0009`** |
| Type | **Technology Selection Pattern** |
| Status | **Published** |
| Approvals | <span class="md-tag">LMP Migration Architecture Approval</span> |
| Published on | **May 21, 2024** |
| Valid From | **May 21, 2024** |
| Authors | <span class="md-source-file__fact"> </span> |
| Tags | <span class="md-tag">Database</span> |
| Technology Capabilities | <span class="md-tag">Platform / Data / Database / Graph Database</span> |

# Graph Databases<a href="#graph-databases" class="headerlink" title="Permanent link">¶</a>

## Compatibility<a href="#compatibility" class="headerlink" title="Permanent link">¶</a>

This advice pertains to the choice of Graph database in Azure, driven by public Microsoft Azure documentation and internally produced LMP guidance.

A graph database uses graph structures for semantic queries with nodes, edges, and properties to represent and store data<sup><a href="#fn:1" class="footnote-ref">1</a></sup>

## Recommended Target<a href="#recommended-target" class="headerlink" title="Permanent link">¶</a>

Azure Cosmos DB for Gremlin<sup><a href="#fn:2" class="footnote-ref">2</a></sup>.

## Notable Differences<a href="#notable-differences" class="headerlink" title="Permanent link">¶</a>

| Similarity | Consideration | AWS Neptune | Azure Cosmos DB for Gremlin | Neo4j |
|----|----|----|----|----|
| 🟡 | Graph Model | Gremlin compatible<sup><a href="#fn:3" class="footnote-ref">3</a></sup>, Neo4j openCypher<sup><a href="#fn:4" class="footnote-ref">4</a></sup>, SPARQL | Gremlin compatible<sup><a href="#fn:5" class="footnote-ref">5</a></sup> | Cypher<sup><a href="#fn:6" class="footnote-ref">6</a></sup> |
| 🟢 | Latency | "Millisecond latency". Caching supported<sup><a href="#fn:10" class="footnote-ref">7</a></sup>. | \< 10ms for point read/write<sup><a href="#fn:11" class="footnote-ref">8</a></sup> | Deployment dependent |
| 🔴 | Data migration | Neptune Bulk Loader (from Tinkerpop Gremlin)<sup><a href="#fn:14" class="footnote-ref">9</a></sup>; Neptune Export service/CLI (as csv, json, Gremlin JSON)<sup><a href="#fn:15" class="footnote-ref">10</a></sup> | Java/.NET SDK<sup><a href="#fn:16" class="footnote-ref">11</a></sup> | CLI from CSV, SDK & APOC library |
| 🟡 | Max Size | 128 tebibytes (TiB)<sup><a href="#fn:9" class="footnote-ref">12</a></sup> | 20 GB/partition, unlimited per container<sup><a href="#fn:8" class="footnote-ref">13</a></sup> | Deployment dependent |
| 🟡 | Scaling | Storage: automatic; Vertically: by class; Horizontally: up to 15 read replicas with auto-scaling | By partition, automatically, if effective partition keys are chosen | Read replicas, sharding |
| 🔴 | Pricing model | Per GB-month & I/O, e.g. 500 GB, 10M requests/month -\> ~\$12.8k/month | By storage and Request Unit, e.g. 500 GB, 2 regions, 1xCRUD/sec (2.6M/month) -\> 400 RUs -\> \$300/month<sup><a href="#fn:13" class="footnote-ref">14</a></sup> | Aura: ~\$6k/month<sup><a href="#fn:19" class="footnote-ref">15</a></sup> |
| 🟢 | Deployment model | PaaS; Serverless<sup><a href="#fn:17" class="footnote-ref">16</a></sup> | PaaS; Serverless<sup><a href="#fn:18" class="footnote-ref">17</a></sup> | Self-managed or SaaS |
| 🟢 | SLA | e.g. 10% service credit at 99.0%-99.9%<sup><a href="#fn:7" class="footnote-ref">18</a></sup> | e.g. 10% credit at \< 99.99%<sup><a href="#fn:12" class="footnote-ref">19</a></sup> | Aura: 99.95% availability<sup><a href="#fn:19" class="footnote-ref">15</a></sup> |
| 🟢 | Community | ~500 Stack Overflow results | ~200 Stack Overflow results | ~500 results (72 for Neo4j Aura) |
| 🟡 | DR/High Availability | Availability Zones | Global distribution | Aura: managed |

## Considerations<a href="#considerations" class="headerlink" title="Permanent link">¶</a>

- Neo4j Aura, as a SaaS platform, will require security & procurement review

## Alternatives<a href="#alternatives" class="headerlink" title="Permanent link">¶</a>

- [Cypher for Gremlin](https://github.com/opencypher/cypher-for-gremlin) "adds Cypher support to any Gremlin graph database"
- [RedisGraph](https://redis.io/docs/latest/operate/oss_and_stack/stack-with-enterprise/deprecated-features/graph/) is now end of life

<div class="footnote">

------------------------------------------------------------------------

1.  <div id="fn:1">

    [Graph Database - Wikipedia](https://en.wikipedia.org/wiki/Graph_database) <a href="#fnref:1" class="footnote-backref" title="Jump back to footnote 1 in the text">↩︎</a>

    </div>

2.  <div id="fn:2">

    [Apache Tinkerpop Gremlin](https://tinkerpop.apache.org/gremlin.html) <a href="#fnref:2" class="footnote-backref" title="Jump back to footnote 2 in the text">↩︎</a>

    </div>

3.  <div id="fn:3">

    [Neptune compatibility with Apache Tinkerpop Gremlin](https://docs.aws.amazon.com/neptune/latest/userguide/access-graph-gremlin-differences.html) <a href="#fnref:3" class="footnote-backref" title="Jump back to footnote 3 in the text">↩︎</a>

    </div>

4.  <div id="fn:4">

    [openCypher](https://opencypher.org) <a href="#fnref:4" class="footnote-backref" title="Jump back to footnote 4 in the text">↩︎</a>

    </div>

5.  <div id="fn:5">

    [Cosmos DB for Gremlin compatibility with Apache Tinkerpop Gremlin](https://learn.microsoft.com/en-us/azure/cosmos-db/gremlin/support) <a href="#fnref:5" class="footnote-backref" title="Jump back to footnote 5 in the text">↩︎</a>

    </div>

6.  <div id="fn:6">

    A [Gremlin Plugin for Neo4j](https://github.com/neo4j-contrib/gremlin-plugin) used to exist but has since been archived <a href="#fnref:6" class="footnote-backref" title="Jump back to footnote 6 in the text">↩︎</a>

    </div>

7.  <div id="fn:10">

    [Accelerate graph query performance with caching in Amazon Neptune](https://aws.amazon.com/blogs/database/part-2-accelerate-graph-query-performance-with-caching-in-amazon-neptune/) <a href="#fnref:10" class="footnote-backref" title="Jump back to footnote 7 in the text">↩︎</a>

    </div>

8.  <div id="fn:11">

    [Azure Cosmos latency](https://learn.microsoft.com/en-us/azure/cosmos-db/monitor-server-side-latency) <a href="#fnref:11" class="footnote-backref" title="Jump back to footnote 8 in the text">↩︎</a>

    </div>

9.  <div id="fn:14">

    [Migrating to AWS Gremlin](https://docs.aws.amazon.com/neptune/latest/userguide/migrating.html) <a href="#fnref:14" class="footnote-backref" title="Jump back to footnote 9 in the text">↩︎</a>

    </div>

10. <div id="fn:15">

    [Exporting from AWS Gremlin](https://docs.aws.amazon.com/neptune/latest/userguide/neptune-data-export.html) <a href="#fnref:15" class="footnote-backref" title="Jump back to footnote 10 in the text">↩︎</a>

    </div>

11. <div id="fn:16">

    [Bulk import in Cosmos DB for Gremlin](https://learn.microsoft.com/en-us/azure/cosmos-db/gremlin/bulk-executor-dotnet) <a href="#fnref:16" class="footnote-backref" title="Jump back to footnote 11 in the text">↩︎</a>

    </div>

12. <div id="fn:9">

    [AWS Neptune Limits](https://docs.aws.amazon.com/neptune/latest/userguide/limits.html) <a href="#fnref:9" class="footnote-backref" title="Jump back to footnote 12 in the text">↩︎</a>

    </div>

13. <div id="fn:8">

    [Azure Cosmos DB Limits](https://learn.microsoft.com/en-us/azure/cosmos-db/concepts-limits) <a href="#fnref:8" class="footnote-backref" title="Jump back to footnote 13 in the text">↩︎</a>

    </div>

14. <div id="fn:13">

    [Azure Cosmos Capacity Calculator](https://cosmos.azure.com/capacitycalculator/) <a href="#fnref:13" class="footnote-backref" title="Jump back to footnote 14 in the text">↩︎</a>

    </div>

15. <div id="fn:19">

    [Neo4j Aura on Azure Marketplace](https://appsource.microsoft.com/en-US/product/SaaS/neo4j.neo4j_aura) <a href="#fnref:19" class="footnote-backref" title="Jump back to footnote 15 in the text">↩︎</a><a href="#fnref2:19" class="footnote-backref" title="Jump back to footnote 15 in the text">↩︎</a>

    </div>

16. <div id="fn:17">

    [AWS Neptune Serverless](https://docs.amazonaws.cn/en_us/neptune/latest/userguide/neptune-serverless.html) <a href="#fnref:17" class="footnote-backref" title="Jump back to footnote 16 in the text">↩︎</a>

    </div>

17. <div id="fn:18">

    [Azure Cosmos DB for Gremlin Serverless](https://learn.microsoft.com/en-us/azure/cosmos-db/serverless) <a href="#fnref:18" class="footnote-backref" title="Jump back to footnote 17 in the text">↩︎</a>

    </div>

18. <div id="fn:7">

    [AWS Neptune SLA](https://aws.amazon.com/neptune/sla/) <a href="#fnref:7" class="footnote-backref" title="Jump back to footnote 18 in the text">↩︎</a>

    </div>

19. <div id="fn:12">

    [Microsoft SLAs for Online Services](https://www.microsoft.com/licensing/docs/view/Service-Level-Agreements-SLA-for-Online-Services?lang=1) <a href="#fnref:12" class="footnote-backref" title="Jump back to footnote 19 in the text">↩︎</a>

    </div>

</div>

<span class="md-source-file__fact"> <span class="md-icon" title="Last update"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIxIDEzLjFjLS4xIDAtLjMuMS0uNC4ybC0xIDEgMi4xIDIuMSAxLTFjLjItLjIuMi0uNiAwLS44bC0xLjMtMS4zYy0uMS0uMS0uMi0uMi0uNC0uMm0tMS45IDEuOC02LjEgNlYyM2gyLjFsNi4xLTYuMXpNMTIuNSA3djUuMmw0IDIuNC0xIDFMMTEgMTNWN3pNMTEgMjEuOWMtNS4xLS41LTktNC44LTktOS45QzIgNi41IDYuNSAyIDEyIDJjNS4zIDAgOS42IDQuMSAxMCA5LjMtLjMtLjEtLjYtLjItMS0uMnMtLjcuMS0xIC4yQzE5LjYgNy4yIDE2LjIgNCAxMiA0Yy00LjQgMC04IDMuNi04IDggMCA0LjEgMy4xIDcuNSA3LjEgNy45bC0uMS4yeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="May 30, 2025 16:15:49 UTC">May 30, 2025</span> </span> <span class="md-source-file__fact"> <span class="md-icon" title="Created"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE0LjQ3IDE1LjA4IDExIDEzVjdoMS41djUuMjVsMy4wOCAxLjgzYy0uNDEuMjgtLjc5LjYyLTEuMTEgMW0tMS4zOSA0Ljg0Yy0uMzYuMDUtLjcxLjA4LTEuMDguMDgtNC40MiAwLTgtMy41OC04LThzMy41OC04IDgtOCA4IDMuNTggOCA4YzAgLjM3LS4wMy43Mi0uMDggMS4wOC42OS4xIDEuMzMuMzIgMS45Mi42NC4xLS41Ni4xNi0xLjEzLjE2LTEuNzIgMC01LjUtNC41LTEwLTEwLTEwUzIgNi41IDIgMTJzNC40NyAxMCAxMCAxMGMuNTkgMCAxLjE2LS4wNiAxLjcyLS4xNi0uMzItLjU5LS41NC0xLjIzLS42NC0xLjkyTTE4IDE1djNoLTN2MmgzdjNoMnYtM2gzdi0yaC0zdi0zeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="June 7, 2024 12:18:49 UTC">June 7, 2024</span> </span>

<a href="../0008-document-databases/" class="md-footer__link md-footer__link--prev" aria-label="Previous: Document Databases"></a>

<div class="md-footer__button md-icon">

![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIwIDExdjJIOGw1LjUgNS41LTEuNDIgMS40Mkw0LjE2IDEybDcuOTItNy45MkwxMy41IDUuNSA4IDExeiIgLz48L3N2Zz4=)

</div>

<div class="md-footer__title">

<span class="md-footer__direction"> Previous </span>

<div class="md-ellipsis">

Document Databases

</div>

</div>

<a href="../0010-oracle/" class="md-footer__link md-footer__link--next" aria-label="Next: Use of Oracle on Cloud"></a>

<div class="md-footer__title">

<span class="md-footer__direction"> Next </span>

<div class="md-ellipsis">

Use of Oracle on Cloud

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
