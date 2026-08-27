---
id: LMP-PAT-0062
type: Technology Selection Pattern
supersedes: LMP-PAT-0012
status: published
date: 2025-05-22
valid_from: 2025-02-28
approved_by:
  - LMP Migration Architecture Approval
tags:
  - Distributed Cache
  - Database
tech_capabilities:
  - Platform / Data / Distributed Cache
  - Platform / Data / Database
---

# Caching options in Azure

## Compatibility

Apps migrating to Azure under LMP have a variety of use cases for cache.

Data Cache and stream processing are most common use-cases. This pattern covers both with some additional
considerations.

It does not cover security use cases (e.g. SIEM).

## Recommended Target

- For NOSQL database, with Read-heavy workloads, many repeated point reads on large items, many repeated high RU
  queries -
  [Azure Cosmos DB integrated cache][cosmos] is suitable
- For data cache - side cache for a relational database, stream processing/message broker, in-memory data processing(
  Organizing/searching/categorizing data), API caching;
  [Azure cache for Redis][azure-redis] is a managed service. The service is operated by Microsoft, hosted on Azure, and
  usable by any application within or outside of Azure
- For applications that cannot adopt above technologies, [Memcached][memcached] is an open store option. It is available
  in either self-deployment or Azure marketplace offering, but - at the time of writing - work will be required to adopt
  the marketplace.

## Decision Tree Diagram

![Decision tree](img/0062-redis-cache-decision-tree-1.0.png)

## Notable Differences

| Considerations      | Azure Cache for Redis                                                                              | Azure Cosmos DB                                                                                                                                                                                                                                                   |
|---------------------|----------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Typical Use Case    | In-memory datastore/cache- Cache, session store, message broker                                    | Multi-model NoSQL Database with integrated cache    - Primary database, session store                                                                                                                                                                             |
| Client Experience   | Nearly all (community maintained) including .NET, Java, Node, Python, Go, Rust, C, and PHP.        | .NET, Java, Node, Python for SQL (core) API Community maintained SDKs for Cassandra and API for MongoDB                                                                                                                                                           |
| Data Models         | Key-value, stream, time series*, JSON*                                                             | See Elastic Search (managed)                                                                                                                                                                                                                                      |
| Scale-out           | [Yes, up to 10 shards][redis-scaling]                                                              | Yes, unlimited, instant elastic scalability                                                                                                                                                                                                                       |
| Throughput          | 1M+ simultaneous requests                                                                          | Depends on the provisioned configuration                                                                                                                                                                                                                          |
| Data Integrity      | Data stored in-memory. RDB and AOF data persistence limits potential data loss, but not perfectly. | Data Integrity - Data stored in-memory. RDB and AOF data persistence limits potential data loss, but not perfectly. - Data stored on disk. Lossless data store by design.                                                                                         |
| Consistency         | Strong eventual consistency (SEC)                                                                  | Strong, bounded staleness, session, consistent prefix, or eventual consistency                                                                                                                                                                                    |
| Key/Value Latency   | ~1ms or less                                                                                       | P99 under 10ms, P50 as low as 2-3ms                                                                                                                                                                                                                               |
| Pricing             | Hourly                                                                                             | Provisioned Throughput- maximum provisioned throughput, database operations/Request Units (RUs) per second, for a given hour and consumed storage Serverless – billed by the Request Units (RUs) consumed by database operations and the storage consumed by data |
| Scaling             | Based on the provisioned SKU                                                                       | Provisioned throughput<br/> - Manual <br/> Autoscale<br/> - Serverles                                                                                                                                                                                             |
| Region availability | [Available in all regions][azure-redis-regions][^2]                                                | Available in all regions                                                                                                                                                                                                                                          |
| SLA                 | [Up to 99.999%][azure-redis-availability][^1]                                                      | Up to 99.999%[^3]                                                                                                                                                                                                                                                 |

## In-Memory Data Dictionary To Azure Redis Cache

| **Considerations**         | **In-memory data dictionary**           | **Redis Cache Premium on Azure**                                     | **Redis Cache Enterprise/Flash on Azure**   |
|----------------------------|-----------------------------------------|----------------------------------------------------------------------|---------------------------------------------|
| Cost                       | n/a                                     | By size                                                              |                                             |
| Availability               | n/a                                     | 99.9%                                                                | 99.99% (up to 99.999% with geo replication) |
| Memory                     | 2GB Maximum object size                 | up to 1.2TB                                                          | up to 13TB                                  |
| Cache Coherence            | Must be maintained by application logic | Single highly available cache ensures consistent view of cached data |                                             |
| Searchable by Data content | Yes, with LINQ                          | No                                                                   | Yes, with Redis Search                      |
| Programming Model          | Data Dictionary of application language | Redis client / RedisOM                                               | Redis client / RedisOM                      |

## Considerations

### Azure Cache for Redis

- Useful data types including Lists, Sets, Hashes, Sorted Sets, HyperLogLogs, Streams, and Geospatial
- Lua scripting
- Search functionality with [RediSearch][azure-redis-vector-search][^1]
- Bloom, Cuckoo, count-min sketch, and Top-K filters with [RedisBloom][azure-redis-modules][^1]
- Time series functionality with [RedisTimeSeries][azure-redis-modules][^1]
- Handle JSON formatted data – [RedisJSON][azure-redis-modules][^1]

### In-memory Data Dictionary to Azure Redis Cache

Redis cache is a highly scalable low-latency in-memory cache for Key,Value data provided as a service within Azure. An
external Redis cache supports cloud-friendly application architecture in a number of ways:

- External Redis cache can be shared by a variable number of client processes allowing logic to be elastically scaled
- Single source of cached data eases data management as any data changes need only be
  made in a single place
- Redis caches are scalable up to terabyte scale, allowing cached data volume to grow without
  impacting application logic footprint
- Redis caches can be persistent, recovering quickly from infrastructure failures without
  needing to be repopulated from source systems
- Redis caches can be up to 99.999% available, minimising downtime
- Using a remote data cache imposes a requirement for external connectivity on application
  services, adding extra elements to their provisioning and observability needs.

[^1]: [Microsoft’s Azure cache for Redis documentation](https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/cache-overview)
[^2]: [Microsoft’s RediSearch documentation](https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/cache-redis-modules#redisearch)
[^3]: [Redis’ RedisOM documentation](https://redis.io/docs/latest/integrate/redisom-for-net/)

### Azure Cosmos DB

- Integrated cache that lowers database operations costs in SQL (core) API
- Single-digit latency SLA for reads and writes
- SQL, API for MongoDB, Gremlin, Cassandra, and Table APIs
- Azure Synapse Link for HTAP capability
- Automated global distribution

## Alternatives

- **Garnet**: [Garnet][garnet] is a remote cache store from Microsoft research, MIT
  licensed open source. The Garnet server is written in modern .NET C#, and runs efficiently on almost any platform. It
  works equally well on Windows and Linux. There is no compelling marketplace option.
- **Valkey**: [Valkey][valkey] is an open source (BSD) high-performance key/value datastore.
  It supports a variety of workloads such as caching, message queues, and can act as a primary database.
  Valkey can run as either a standalone daemon or in a cluster, with options for replication and high availability.
- **Memcached**: [Memcached][memcached] is an open source, high-performance, distributed memory
  object caching system, but intended for use in speeding up dynamic web applications by alleviating database load.
  Memcached is an in-memory key-value store for small chunks of arbitrary data (strings, objects)
  from results of database calls,API calls, or page rendering.

[cosmos]: https://learn.microsoft.com/en-us/azure/cosmos-db/integrated-cache

[azure-redis]: https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/cache-overview

[redis-scaling]: https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/cache-best-practices-scale

[azure-redis-vector-search]: https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/cache-overview-vector-similarity

[azure-redis-regions]: https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/cache-overview#availability-by-region

[azure-redis-availability]: https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/cache-high-availability

[azure-redis-modules]: https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/cache-redis-modules

[valkey]: https://valkey.io/

[garnet]: https://microsoft.github.io/garnet/

[memcached]: https://memcached.org/

