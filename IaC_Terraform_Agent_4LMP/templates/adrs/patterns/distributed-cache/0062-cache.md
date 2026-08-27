<span class="md-content__button md-icon md-status--published" href="#" title="Status: Published"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE4LjUgMmgtMTNDMy42IDIgMiAzLjYgMiA1LjV2MTNDMiAyMC40IDMuNiAyMiA1LjUgMjJIMTZsNi02VjUuNUMyMiAzLjYgMjAuNCAyIDE4LjUgMk0yMCAxNWgtMS41Yy0xLjkgMC0zLjUgMS42LTMuNSAzLjVWMjBINS44Yy0xIDAtMS44LS44LTEuOC0xLjhWNS44QzQgNC44IDQuOCA0IDUuOCA0aDEyLjVjMSAwIDEuOC44IDEuOCAxLjhWMTVtLTQuOS02LjggMS41IDEuNS02IDYtMy41LTMuNSAxLjUtMS41IDIgMnoiIC8+PC9zdmc+) </span> <span class="md-content__button md-icon .md-status--published" title="Valid from 2025-02-28"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE5IDE5SDVWOGgxNG0wLTVoLTFWMWgtMnYySDhWMUg2djJINWEyIDIgMCAwIDAtMiAydjE0YTIgMiAwIDAgMCAyIDJoMTRhMiAyIDAgMCAwIDItMlY1YTIgMiAwIDAgMC0yLTJtLTIuNDcgOC4wNkwxNS40NyAxMGwtNC44OCA0Ljg4LTIuMTItMi4xMi0xLjA2IDEuMDZMMTAuNTkgMTd6IiAvPjwvc3ZnPg==) </span> <span class="md-content__button md-icon actions-date" title="Published on 2025-05-22">![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTkgMTB2Mkg3di0yem00IDB2MmgtMnYtMnptNCAwdjJoLTJ2LTJ6bTItN2EyIDIgMCAwIDEgMiAydjE0YTIgMiAwIDAgMS0yIDJINWEyIDIgMCAwIDEtMi0yVjVhMiAyIDAgMCAxIDItMmgxVjFoMnYyaDhWMWgydjJ6bTAgMTZWOEg1djExek05IDE0djJIN3YtMnptNCAwdjJoLTJ2LTJ6bTQgMHYyaC0ydi0yeiIgLz48L3N2Zz4=)</span> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/edit/main/docs/patterns/distributed-cache/0062-cache.md" class="md-content__button md-icon" title="Edit this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTEwIDIwSDZWNGg3djVoNXYzLjFsMi0yVjhsLTYtNkg2Yy0xLjEgMC0yIC45LTIgMnYxNmMwIDEuMS45IDIgMiAyaDR6bTEwLjItN2MuMSAwIC4zLjEuNC4ybDEuMyAxLjNjLjIuMi4yLjYgMCAuOGwtMSAxLTIuMS0yLjEgMS0xYy4xLS4xLjItLjIuNC0uMm0wIDMuOUwxNC4xIDIzSDEydi0yLjFsNi4xLTYuMXoiIC8+PC9zdmc+" /></a> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/blob/main/docs/patterns/distributed-cache/0062-cache.md" class="md-content__button md-icon" title="View source of this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE3IDE4Yy41NiAwIDEgLjQ0IDEgMXMtLjQ0IDEtMSAxLTEtLjQ0LTEtMSAuNDQtMSAxLTFtMC0zYy0yLjczIDAtNS4wNiAxLjY2LTYgNCAuOTQgMi4zNCAzLjI3IDQgNiA0czUuMDYtMS42NiA2LTRjLS45NC0yLjM0LTMuMjctNC02LTRtMCA2LjVhMi41IDIuNSAwIDAgMS0yLjUtMi41IDIuNSAyLjUgMCAwIDEgMi41LTIuNSAyLjUgMi41IDAgMCAxIDIuNSAyLjUgMi41IDIuNSAwIDAgMS0yLjUgMi41TTkuMjcgMjBINlY0aDd2NWg1djQuMDdjLjcuMDggMS4zNi4yNSAyIC40OVY4bC02LTZINmEyIDIgMCAwIDAtMiAydjE2YTIgMiAwIDAgMCAyIDJoNC41YTguMiA4LjIgMCAwIDEtMS4yMy0yIiAvPjwvc3ZnPg==" /></a>

Document Metadata

|  |  |
|----|----|
| Identifier | **`LMP-PAT-0062`** |
| Type | **Technology Selection Pattern** |
| Status | **Published** |
| Approvals | <span class="md-tag">LMP Migration Architecture Approval</span> |
| Published on | **May 22, 2025** |
| Valid From | **February 28, 2025** |
| Authors | <span class="md-source-file__fact"> </span> |
| Tags | <span class="md-tag">Distributed Cache</span><span class="md-tag">Database</span> |
| Technology Capabilities | <span class="md-tag">Platform / Data / Distributed Cache</span><span class="md-tag">Platform / Data / Database</span> |

# Caching options in Azure<a href="#caching-options-in-azure" class="headerlink" title="Permanent link">¶</a>

## Compatibility<a href="#compatibility" class="headerlink" title="Permanent link">¶</a>

Apps migrating to Azure under LMP have a variety of use cases for cache.

Data Cache and stream processing are most common use-cases. This pattern covers both with some additional considerations.

It does not cover security use cases (e.g. SIEM).

## Recommended Target<a href="#recommended-target" class="headerlink" title="Permanent link">¶</a>

- For NOSQL database, with Read-heavy workloads, many repeated point reads on large items, many repeated high RU queries - [Azure Cosmos DB integrated cache](https://learn.microsoft.com/en-us/azure/cosmos-db/integrated-cache) is suitable
- For data cache - side cache for a relational database, stream processing/message broker, in-memory data processing( Organizing/searching/categorizing data), API caching; [Azure cache for Redis](https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/cache-overview) is a managed service. The service is operated by Microsoft, hosted on Azure, and usable by any application within or outside of Azure
- For applications that cannot adopt above technologies, [Memcached](https://memcached.org/) is an open store option. It is available in either self-deployment or Azure marketplace offering, but - at the time of writing - work will be required to adopt the marketplace.

## Decision Tree Diagram<a href="#decision-tree-diagram" class="headerlink" title="Permanent link">¶</a>

![Decision tree](0062-cache.assets/image-001.png)

## Notable Differences<a href="#notable-differences" class="headerlink" title="Permanent link">¶</a>

<table>
<colgroup>
<col style="width: 33%" />
<col style="width: 33%" />
<col style="width: 33%" />
</colgroup>
<thead>
<tr>
<th>Considerations</th>
<th>Azure Cache for Redis</th>
<th>Azure Cosmos DB</th>
</tr>
</thead>
<tbody>
<tr>
<td>Typical Use Case</td>
<td>In-memory datastore/cache- Cache, session store, message broker</td>
<td>Multi-model NoSQL Database with integrated cache - Primary database, session store</td>
</tr>
<tr>
<td>Client Experience</td>
<td>Nearly all (community maintained) including .NET, Java, Node, Python, Go, Rust, C, and PHP.</td>
<td>.NET, Java, Node, Python for SQL (core) API Community maintained SDKs for Cassandra and API for MongoDB</td>
</tr>
<tr>
<td>Data Models</td>
<td>Key-value, stream, time series*, JSON*</td>
<td>See Elastic Search (managed)</td>
</tr>
<tr>
<td>Scale-out</td>
<td><a href="https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/cache-best-practices-scale">Yes, up to 10 shards</a></td>
<td>Yes, unlimited, instant elastic scalability</td>
</tr>
<tr>
<td>Throughput</td>
<td>1M+ simultaneous requests</td>
<td>Depends on the provisioned configuration</td>
</tr>
<tr>
<td>Data Integrity</td>
<td>Data stored in-memory. RDB and AOF data persistence limits potential data loss, but not perfectly.</td>
<td>Data Integrity - Data stored in-memory. RDB and AOF data persistence limits potential data loss, but not perfectly. - Data stored on disk. Lossless data store by design.</td>
</tr>
<tr>
<td>Consistency</td>
<td>Strong eventual consistency (SEC)</td>
<td>Strong, bounded staleness, session, consistent prefix, or eventual consistency</td>
</tr>
<tr>
<td>Key/Value Latency</td>
<td>~1ms or less</td>
<td>P99 under 10ms, P50 as low as 2-3ms</td>
</tr>
<tr>
<td>Pricing</td>
<td>Hourly</td>
<td>Provisioned Throughput- maximum provisioned throughput, database operations/Request Units (RUs) per second, for a given hour and consumed storage Serverless – billed by the Request Units (RUs) consumed by database operations and the storage consumed by data</td>
</tr>
<tr>
<td>Scaling</td>
<td>Based on the provisioned SKU</td>
<td>Provisioned throughput<br />
- Manual<br />
Autoscale<br />
- Serverles</td>
</tr>
<tr>
<td>Region availability</td>
<td><a href="https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/cache-overview#availability-by-region">Available in all regions</a><sup><a href="#fn:2" class="footnote-ref">2</a></sup></td>
<td>Available in all regions</td>
</tr>
<tr>
<td>SLA</td>
<td><a href="https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/cache-high-availability">Up to 99.999%</a><sup><a href="#fn:1" class="footnote-ref">1</a></sup></td>
<td>Up to 99.999%<sup><a href="#fn:3" class="footnote-ref">3</a></sup></td>
</tr>
</tbody>
</table>

## In-Memory Data Dictionary To Azure Redis Cache<a href="#in-memory-data-dictionary-to-azure-redis-cache" class="headerlink" title="Permanent link">¶</a>

| **Considerations** | **In-memory data dictionary** | **Redis Cache Premium on Azure** | **Redis Cache Enterprise/Flash on Azure** |
|----|----|----|----|
| Cost | n/a | By size |  |
| Availability | n/a | 99.9% | 99.99% (up to 99.999% with geo replication) |
| Memory | 2GB Maximum object size | up to 1.2TB | up to 13TB |
| Cache Coherence | Must be maintained by application logic | Single highly available cache ensures consistent view of cached data |  |
| Searchable by Data content | Yes, with LINQ | No | Yes, with Redis Search |
| Programming Model | Data Dictionary of application language | Redis client / RedisOM | Redis client / RedisOM |

## Considerations<a href="#considerations" class="headerlink" title="Permanent link">¶</a>

### Azure Cache for Redis<a href="#azure-cache-for-redis" class="headerlink" title="Permanent link">¶</a>

- Useful data types including Lists, Sets, Hashes, Sorted Sets, HyperLogLogs, Streams, and Geospatial
- Lua scripting
- Search functionality with [RediSearch](https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/cache-overview-vector-similarity)<sup><a href="#fn:1" class="footnote-ref">1</a></sup>
- Bloom, Cuckoo, count-min sketch, and Top-K filters with [RedisBloom](https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/cache-redis-modules)<sup><a href="#fn:1" class="footnote-ref">1</a></sup>
- Time series functionality with [RedisTimeSeries](https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/cache-redis-modules)<sup><a href="#fn:1" class="footnote-ref">1</a></sup>
- Handle JSON formatted data – [RedisJSON](https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/cache-redis-modules)<sup><a href="#fn:1" class="footnote-ref">1</a></sup>

### In-memory Data Dictionary to Azure Redis Cache<a href="#in-memory-data-dictionary-to-azure-redis-cache_1" class="headerlink" title="Permanent link">¶</a>

Redis cache is a highly scalable low-latency in-memory cache for Key,Value data provided as a service within Azure. An external Redis cache supports cloud-friendly application architecture in a number of ways:

- External Redis cache can be shared by a variable number of client processes allowing logic to be elastically scaled
- Single source of cached data eases data management as any data changes need only be made in a single place
- Redis caches are scalable up to terabyte scale, allowing cached data volume to grow without impacting application logic footprint
- Redis caches can be persistent, recovering quickly from infrastructure failures without needing to be repopulated from source systems
- Redis caches can be up to 99.999% available, minimising downtime
- Using a remote data cache imposes a requirement for external connectivity on application services, adding extra elements to their provisioning and observability needs.

### Azure Cosmos DB<a href="#azure-cosmos-db" class="headerlink" title="Permanent link">¶</a>

- Integrated cache that lowers database operations costs in SQL (core) API
- Single-digit latency SLA for reads and writes
- SQL, API for MongoDB, Gremlin, Cassandra, and Table APIs
- Azure Synapse Link for HTAP capability
- Automated global distribution

## Alternatives<a href="#alternatives" class="headerlink" title="Permanent link">¶</a>

- **Garnet**: [Garnet](https://microsoft.github.io/garnet/) is a remote cache store from Microsoft research, MIT licensed open source. The Garnet server is written in modern .NET C#, and runs efficiently on almost any platform. It works equally well on Windows and Linux. There is no compelling marketplace option.
- **Valkey**: [Valkey](https://valkey.io/) is an open source (BSD) high-performance key/value datastore. It supports a variety of workloads such as caching, message queues, and can act as a primary database. Valkey can run as either a standalone daemon or in a cluster, with options for replication and high availability.
- **Memcached**: [Memcached](https://memcached.org/) is an open source, high-performance, distributed memory object caching system, but intended for use in speeding up dynamic web applications by alleviating database load. Memcached is an in-memory key-value store for small chunks of arbitrary data (strings, objects) from results of database calls,API calls, or page rendering.

<div class="footnote">

------------------------------------------------------------------------

1.  <div id="fn:1">

    [Microsoft’s Azure cache for Redis documentation](https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/cache-overview) <a href="#fnref:1" class="footnote-backref" title="Jump back to footnote 1 in the text">↩︎</a><a href="#fnref2:1" class="footnote-backref" title="Jump back to footnote 1 in the text">↩︎</a><a href="#fnref3:1" class="footnote-backref" title="Jump back to footnote 1 in the text">↩︎</a><a href="#fnref4:1" class="footnote-backref" title="Jump back to footnote 1 in the text">↩︎</a><a href="#fnref5:1" class="footnote-backref" title="Jump back to footnote 1 in the text">↩︎</a>

    </div>

2.  <div id="fn:2">

    [Microsoft’s RediSearch documentation](https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/cache-redis-modules#redisearch) <a href="#fnref:2" class="footnote-backref" title="Jump back to footnote 2 in the text">↩︎</a>

    </div>

3.  <div id="fn:3">

    [Redis’ RedisOM documentation](https://redis.io/docs/latest/integrate/redisom-for-net/) <a href="#fnref:3" class="footnote-backref" title="Jump back to footnote 3 in the text">↩︎</a>

    </div>

</div>

<span class="md-source-file__fact"> <span class="md-icon" title="Last update"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIxIDEzLjFjLS4xIDAtLjMuMS0uNC4ybC0xIDEgMi4xIDIuMSAxLTFjLjItLjIuMi0uNiAwLS44bC0xLjMtMS4zYy0uMS0uMS0uMi0uMi0uNC0uMm0tMS45IDEuOC02LjEgNlYyM2gyLjFsNi4xLTYuMXpNMTIuNSA3djUuMmw0IDIuNC0xIDFMMTEgMTNWN3pNMTEgMjEuOWMtNS4xLS41LTktNC44LTktOS45QzIgNi41IDYuNSAyIDEyIDJjNS4zIDAgOS42IDQuMSAxMCA5LjMtLjMtLjEtLjYtLjItMS0uMnMtLjcuMS0xIC4yQzE5LjYgNy4yIDE2LjIgNCAxMiA0Yy00LjQgMC04IDMuNi04IDggMCA0LjEgMy4xIDcuNSA3LjEgNy45bC0uMS4yeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="October 29, 2025 09:40:37 UTC">October 29, 2025</span> </span> <span class="md-source-file__fact"> <span class="md-icon" title="Created"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE0LjQ3IDE1LjA4IDExIDEzVjdoMS41djUuMjVsMy4wOCAxLjgzYy0uNDEuMjgtLjc5LjYyLTEuMTEgMW0tMS4zOSA0Ljg0Yy0uMzYuMDUtLjcxLjA4LTEuMDguMDgtNC40MiAwLTgtMy41OC04LThzMy41OC04IDgtOCA4IDMuNTggOCA4YzAgLjM3LS4wMy43Mi0uMDggMS4wOC42OS4xIDEuMzMuMzIgMS45Mi42NC4xLS41Ni4xNi0xLjEzLjE2LTEuNzIgMC01LjUtNC41LTEwLTEwLTEwUzIgNi41IDIgMTJzNC40NyAxMCAxMCAxMGMuNTkgMCAxLjE2LS4wNiAxLjcyLS4xNi0uMzItLjU5LS41NC0xLjIzLS42NC0xLjkyTTE4IDE1djNoLTN2MmgzdjNoMnYtM2gzdi0yaC0zdi0zeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="August 1, 2024 15:17:38 UTC">August 1, 2024</span> </span>

<a href="../0015-redis-service-pattern/" class="md-footer__link md-footer__link--prev" aria-label="Previous: Azure Cache for Redis Service Pattern"></a>

<div class="md-footer__button md-icon">

![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIwIDExdjJIOGw1LjUgNS41LTEuNDIgMS40Mkw0LjE2IDEybDcuOTItNy45MkwxMy41IDUuNSA4IDExeiIgLz48L3N2Zz4=)

</div>

<div class="md-footer__title">

<span class="md-footer__direction"> Previous </span>

<div class="md-ellipsis">

Azure Cache for Redis Service Pattern

</div>

</div>

<a href="../../event-management/0003-func-ref-arch-observability/" class="md-footer__link md-footer__link--next" aria-label="Next: Observability (Functional Design Pattern)"></a>

<div class="md-footer__title">

<span class="md-footer__direction"> Next </span>

<div class="md-ellipsis">

Observability (Functional Design Pattern)

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
