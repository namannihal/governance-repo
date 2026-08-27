---
id: LMP-PAT-0006
type: Technology Selection Pattern
status: published
approved_by:
  - LMP Migration Architecture Approval
date: 2024-04-30
valid_from: 2024-04-30
developer_productivity_hrs: 5
tags:
  - "Message Bus & Integration"
tech_capabilities:
  - Platform / Application / Message Bus & Integration
  - Platform / Data / Data Management / Integration & Distribution
---

# TIBCO Rendezvous, Messaging & Event Distribution

## Compatibility

The advice in this pattern pertains to the use of messaging and event distribution solutions, including TIBCO
Rendezvous.

## Recommended Targets

As with other technology selections, guidance is towards Azure-native services if there is appetite for adoption of
newer technology.

In this case, recommendations are:

- Azure Event Grid
- Azure Service Bus
- plus alternatives (see decision trees) in more specialist use cases

## Decision Tree Diagram

![Azure Native Decision Tree](./img/azure-native-decision-tree.png)

## Notable Differences

| Similarity |                                | Event Hubs                          | Queue Storage                           | Service Bus                                  | Event Grid                                      |
|------------|--------------------------------|-------------------------------------|-----------------------------------------|----------------------------------------------|-------------------------------------------------|
| 🟢         | **Consumer**                   | Pub/Sub                             | Polling                                 | Polling and "push-style API"[^3]             | Pub/Sub                                         |
| 🟡         | **Protocols**                  | Kafka, AMQP, HTTP                   | HTTP                                    | HTTP, AMQP 1.0                               | HTTP/MQTT                                       |
| 🔴         | **Retention**                  | 90 days, 1TB/CU                     | 500 TB (single Storage Account)         | 1 GB to 80 GB                                | 7 day retention                                 |
| 🟡         | **Message Size**               | 1 MB (Premium)                      | 64 KB (<=200 GB if combined with Blobs) | 256 KB (100 MB with 'large message support') | 512 KB                                          |
| 🟡         | **Queue/Topic/Partition Size** | 5GB-80GB, 10k/ns                    | Unlimited                               | 10,000 topics/queues per namespace           | 100 namespace topics per TU                     |
| 🟡         | **Number of clients**          | 5,000 (AMQP)/ns                     | Unlimited                               | 5,000 concurrent receive requests            | 10,000 sessions per TU                          |
| 🟡         | **Achievable Bandwidth**       | Per Capacity Unit                   | 2,000 messages/sec/queue (1KB messages) | Per Messaging Unit                           | 1,000 messages per second per TU (inbound MQTT) |
| 🟢         | **Delivery guarantee**         | At least once                       | At least once                           | At least once or at most once                | At least once                                   |
| 🟢         | **Transactions**               | No                                  | No                                      | Yes                                          | No                                              |
| 🔴         | **Ordering**                   | Per Partition                       | No                                      | FIFO                                         | No                                              |
| 🟡         | **Tiers/Cost**                 | Basic, Standard, Premium, Dedicated | By Capacity, Redundancy & Operations    | Basic, Standard, Premium (MUs, Partitions)   | Basic, Standard (TUs)                           |
| -          | **Additional Features**        | -                                   | -                                       | Duplicate detection, state management        | -                                               |

## Considerations

### Use of TIBCO Rendezvous

TIBCO Rendezvous is supported[^2] on virtualised and public cloud environments, provided operating system and capacity
requirements are suitable, and **provided multicast/broadcast features are not being used**.

Provided those characteristics are met, and if the application in question is not being rearchitected, it should remain
suitable on cloud.

TIBCO's documentation suggests the following for Rendezvous:

![Decision tree](./img/tibco-decision-tree.png)

### Choice of Azure Native Service

As with other technology choices, consider whether a managed Azure service is beneficial (considering the operational
impact of running bespoke software on IaaS including software and OS installation, upgrades, patching, threat
management, etc.).

Azure-native services can be difficult to differentiate. See the table that follows for the key differences[^3].

> Note that the Azure documentation uses the terms "commands" and "events"[^1] to help differentiate services:
>
> - If the producer expects an action from the consumer, that message is a _command_
> - If the message informs the consumer that an action has taken place, then the message is an _event_.

| Service           | Purpose                         | Strapline                                                      | Type                                 | When to use                                 |
|-------------------|---------------------------------|----------------------------------------------------------------|--------------------------------------|---------------------------------------------|
| **Event Hubs**    | Big data pipeline               | _Receive telemetry from millions of devices_[^6]               | Event streaming (series)             | Telemetry and distributed data streaming    |
| **Queue Storage** | Large volumes of messages       | _Durable queues for large-volume cloud services_[^8]           | Message                              | Basic functionality, large volumes          |
| **Service Bus**   | High-value enterprise messaging | _For high-value messages that can't be lost or duplicated_[^7] | Message                              | Order processing and financial transactions |
| **Event Grid**    | Reactive programming            | _Reliable event delivery at massive scale_[^5]                 | Event distribution (discrete events) | React to status changes                     |

> Note: For most telemetry use cases, Datadog is preferred over Event Hubs
>
> LSEG's strategic observability platform is Datadog[^9]. Use of Event Hubs for application telemetry
> would be discouraged, although Event Hubs may be a viable option for telemetry in cases where application
> functionality is impacted by the data appearing in telemetry logs.

## Alternatives

In cases where Azure-native technology is unsuitable, many third party options are available, including:

- RabbitMQ
- Nats &
- Nats JetStream
- Kafka
- EventHubs
- Pulsar
- Redis Stream & pub-sub
- Solace VMR
- Solace Appliance
- Aeron (Brokerless)
- ZeroMQ (end of life)

![Decision tree](./img/non-azure-decision-tree.png)

A summary, driven by internal research[^11], is as follows:

|                                            | RabbitMQ                                                                                                                                                    | Nats & Nats JetStream                                                                                        | Kafka                                       | EventHubs                   | Pulsar                                                                                                  | Redis Stream & pub-sub | Solace VMR | Solace Appliance | Aeron (Brokerless) |
|--------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------|---------------------------------------------|-----------------------------|---------------------------------------------------------------------------------------------------------|------------------------|------------|------------------|--------------------|
| **Consumer**                               | Push                                                                                                                                                        | Push, Pull                                                                                                   | Pull                                        | Pull                        | Push                                                                                                    | -                      | Push       | -                | -                  |
| **Complexity**                             | Medium                                                                                                                                                      | Medium                                                                                                       | Medium/Hard                                 | -                           | Medium/High                                                                                             | Simplest               | -          | -                | Highest            |
| **Cost of Running**                        | -                                                                                                                                                           | -                                                                                                            | Medium                                      | Low                         | Low/Medium                                                                                              | High                   | -          | -                | -                  |
| **Maintainability**<br>(admin/monitoring)  | Medium                                                                                                                                                      | -                                                                                                            | Medium/High                                 | Low                         | Medium/High                                                                                             | Medium                 | -          | -                | -                  |
| **Community**<br>(1 = highest, 3 = lowest) | 1                                                                                                                                                           | -                                                                                                            | 1                                           | 2/3                         | 1                                                                                                       | 2                      | 3          | N/A              | 3                  |
|                                            |                                                                                                                                                             |                                                                                                              |                                             |                             |                                                                                                         |                        |            |                  |                    |
| **FEATURES**                               |                                                                                                                                                             |                                                                                                              |                                             |                             |                                                                                                         |                        |            |                  |                    |
| **Stream Processing**                      | &cross;                                                                                                                                                     | &cross;                                                                                                      | &check;                                     | &check;                     | &check;                                                                                                 | -                      | -          | -                | -                  |
| **Durability**                             | &check;                                                                                                                                                     | &cross;                                                                                                      | &check;                                     | &check;                     | &check; (Retention policy configurable per group of Topics)                                             | -                      | -          | -                | -                  |
| **Message Replay**                         | &cross;                                                                                                                                                     | &check;                                                                                                      | &check;                                     | &check;                     | &check;                                                                                                 | -                      | -          | -                | -                  |
| **Delivery Guarantee**                     | At most, least once                                                                                                                                         | At most once, at least once, exactly once                                                                    | At most once, at least once, exactly once   | at least once, exactly once | At most once, at least once, exactly once                                                               | -                      | -          | -                | -                  |
| **Order of Delivery**                      | Guaranteed out-of-the-box                                                                                                                                   | Not guaranteed                                                                                               | Guaranteed only per partition               | Not guaranteed              | Guaranteed (per  message key or per producer)                                                           | -                      | -          | -                | -                  |
| **Schema Registry**                        | &cross;                                                                                                                                                     | &cross;                                                                                                      | &check;                                     | &check;                     | &check;                                                                                                 | -                      | -          | -                | -                  |
|                                            |                                                                                                                                                             |                                                                                                              |                                             |                             |                                                                                                         |                        |            |                  |                    |
| **MESSAGING PATTERN**                      |                                                                                                                                                             |                                                                                                              |                                             |                             |                                                                                                         |                        |            |                  |                    |
| **Point-to-point**                         | &check;                                                                                                                                                     | &check;                                                                                                      | &cross;                                     | &cross;                     | &check;                                                                                                 | &check; (Exclusive)    | -          | -                | -                  |
| **Pub-sub**                                | &check;                                                                                                                                                     | &check;                                                                                                      | &check;                                     | &check;                     | &check;                                                                                                 | &check; (Shared)       | -          | -                | -                  |
| **Req-Reply**                              | &check;                                                                                                                                                     | &check;                                                                                                      | &cross;                                     | &cross;                     | &cross;                                                                                                 | -                      | -          | -                | -                  |
| **Built-in Routing functionality**         | &check;                                                                                                                                                     | &cross;                                                                                                      | &cross;                                     | -                           | &cross;                                                                                                 | -                      | -          | -                | -                  |
| **Advanced Patterns**                      | Most extensive support for advanced patterns and routing support <br>It has pluggable exchange type support that can be used to implement complex patterns. | load-balanced queue subscriber patterns  <br> Dynamic request permissioning <br> request subject obfuscation | Topic partitioning for parallel consumption | -                           | Topic partitioning for parallel consumption <br> Retry and Dead Letter topics <br> Serverless Functions | -                      | -          | -                | -                  |

## Further Reading

### Kafka

- [Apache Kafka migration to Azure - Azure Architecture Center | Microsoft Learn](https://learn.microsoft.com/en-us/azure/architecture/guide/hadoop/apache-kafka-migration)
- [Migrate Kafka to Azure infrastructure as a service (IaaS)](https://learn.microsoft.com/en-us/azure/architecture/guide/hadoop/apache-kafka-migration#migrate-kafka-to-azure-infrastructure-as-a-service-iaas)
- [Migrate Kafka to Azure Event Hubs for Kafka](https://learn.microsoft.com/en-us/azure/architecture/guide/hadoop/apache-kafka-migration#migrate-kafka-to-azure-event-hubs-for-kafka)
- [Migrate Kafka on Azure HDInsight](https://learn.microsoft.com/en-us/azure/architecture/guide/hadoop/apache-kafka-migration#migrate-kafka-on-azure-hdinsight)
- [Use AKS with Kafka on HDInsight](https://learn.microsoft.com/en-us/azure/architecture/guide/hadoop/apache-kafka-migration#use-aks-with-kafka-on-hdinsight)

### RabbitMQ

- [Integration options for RabbitMQ with Azure Service Bus](https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-integrate-with-rabbitmq)
- [Migrating/Displacing the transport to Service Bus from RabbitMQ](https://programmingwithwolfgang.com/replace-rabbitmq-azure-service-bus-queue/)
- [RabbitMQ Server on Windows Server on Marketplace](https://cloudinfrastructureservices.co.uk/how-to-setup-rabbitmq-on-windows-server-in-azure-aws-gcp/)

### TIBCO Enterprise Message Service on Azure Marketplace

- [TIBCO Enterprise Message Service on Azure Marketplace](https://portal.azure.com/#view/Microsoft_Azure_Marketplace/GalleryItemDetailsBladeNopdl/id/tibco-software.enterprise-message-service/selectionMode~/false/resourceGroupId//resourceGroupLocation//dontDiscardJourney~/false/selectedMenuId/home/launchingContext~/%7B%22galleryItemId%22%3A%22tibco-software.enterprise-message-serviceems840-linux-template%22%2C%22source%22%3A%5B%22GalleryFeaturedMenuItemPart%22%2C%22VirtualizedTileDetails%22%5D%2C%22menuItemId%22%3A%22home%22%2C%22subMenuItemId%22%3A%22Search%20results%22%2C%22telemetryId%22%3A%22db9d9015-e384-4300-964a-46234f46c385%22%7D/searchTelemetryId/cf970bc2-8af4-490c-8271-966a7f9f5d4d)

### Azure Relay

- **Azure Relay**[^10] - "Securely expose services that run in your corporate network without opening a port on your
  firewall, or making intrusive changes to your corporate network infrastructure." Can be used in conjunction with
  Service Bus

[^1]: [Asynchronous messaging options - Azure Architecture Center](https://learn.microsoft.com/en-us/azure/architecture/guide/technology-choices/messaging)
[^2]: [TIBCO Support Guide](https://docs.tibco.com/pub/tibco-support-guide/html/Default.htm?_ga=2.102578753.1338020770.1681169651-862170277.1636594297#virtualized-and-public-cloud-environment-support.htm?TocPath=Support%2520Policies%257C_____4)
[^3]: [Compare Messaging Services](https://learn.microsoft.com/en-us/azure/service-bus-messaging/compare-messaging-services)
[^5]: [Event Grid Overview](https://learn.microsoft.com/en-us/azure/event-grid/overview)
[^6]: [Event Hubs Overview](https://learn.microsoft.com/en-us/azure/event-hubs/)
[^7]: [Service Bus Overview](https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-messaging-overview)
[^8]: [Storage Queues Introduction](https://learn.microsoft.com/en-gb/azure/storage/queues/storage-queues-introduction)
[^9]: [ADR: Use Datadog SaaS for Application & Resource monitoring](../../adrs/event-management/0003-use-datadog-for-application-and-resource-monitoring.md)
[^10]: [Azure Relay Overview](https://learn.microsoft.com/en-us/azure/azure-relay)
[^11]: [Messaging Technology Benchmarking](https://confluence.refinitiv.com/pages/viewpage.action?pageId=1057639104)

