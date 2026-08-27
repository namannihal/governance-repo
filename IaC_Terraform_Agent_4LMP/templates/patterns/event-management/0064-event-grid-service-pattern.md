---
id: LMP-PAT-0064
type: Technical Design Pattern
status: published
date: 2024-10-11
valid_from: 2024-10-11
approved_by:
  - CTEF (LMP ARB)
govid: GOVI0003898
govid_url: https://lseg.service-now.com/x/lsegp/cto/record/x_lsegp_eag_governance_item/5bd0e071c3802a54ec253a1c050131b9
pattern_repo: https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvcpat/terraform/azure-prdsvcpat-terraform-eventgrid
tags:
  - Event Management
tech_capabilities:
  - "Platform / Data / Data Management / Distribution & Events"
---

# Event Grid Pattern

- Many applications in the LMP migration require event-driven architectures within the application Subscription.
- Azure Event Grid is a fully managed event routing service that allows for uniform event consumption
  using a publish-subscribe model.
- The current pattern provides an optional automation component for event handling and routing based on various event
  sources.
- If the consumer of the pattern creates multiple Event Grid topics, the same event handling infrastructure can be
  shared.
- The event handling infrastructure should be decoupled and must be able to work independently with events from
  different
  sources under the same application subscription.
- All the resources should be in the non-routable virtual network with private endpoints for all the PaaS services,
  including Event Grid Topics, Function App, and Storage Account, guarded with Network Security Groups.
- Function App should use private link connectivity for private access, Function App pattern can be leveraged to
  implement this for this (As of writing this document the policy for Private endpoint DNS configuration needs SRE
  ticket to be raised to correctly configure the A Records).

| Template details |                          |
|------------------|--------------------------|
| Template name    | Pattern Technical Design |

| Pattern details                                                       |       |
|-----------------------------------------------------------------------|-------|
| [Application tier][^azure-resiliency-design] compatibility            | `TBC` |
| [Data classification][^information-classification-standard] supported | `TBC` |
| LSEG Division applicability                                           | `TBC` |

## Pattern Value Proposition

The pattern will help migration execution teams in the LMP program to easily deploy an event-driven architecture using
Azure Event Grid, which provides a scalable and reliable event routing service for their applications.

### Expected use

For applications that require event-driven architectures for real-time event handling, integration with legacy systems,
and meeting regulatory requirements for event processing.
<br>
This solution would be for deployment to the application subscription to have Event Grid.
<br>

### Unsuitable use

Not suitable for applications that do not require real-time event processing.

### Key requirements

| Area            | Capability                                                                        |
|-----------------|-----------------------------------------------------------------------------------|
| Availability    | Provide opinion on ZRS High Availability and multi-region Fault tolerant designs. |
| Data protection | Data at rest and transit encryption.                                              |

## Pattern Value Assessment

| Value Dimension                                  | Score  |
|--------------------------------------------------|--------|
| Frequency of re-use                              | 2      |
| Developer Productivity                           | 32     |
| Assurance Value: Information & Data Architecture | Medium |
| Assurance Value: Security Architecture           | Medium |
| Assurance Value: Technology                      | Medium |

Assurance Value considers:

- Minimum Entry Criteria coverage e.g. Security Architecture MEC
- Automated assurance compatibility e.g. enforcement via Azure Policy

## Pattern Design

The design involves deploying Event Grid Topics with an option to attach an event handling infrastructure that includes
Event Grid Subscriptions, Storage Queue (due to limitations for Event Grid to deliver messages to
Functions over private endpoint), and Function App.

![Figure 1 - Event Grid design](img/0064-event-grid-hld.png)

### Architecture Decisions

See [LMP Migration Patterns and ADRs][lmp-migration-patterns-adrs].

| Reference | Description | Considered Options | Sources used | Recommended Options | Consequences (pros/cons) |
|-----------|-------------|--------------------|--------------|---------------------|--------------------------|
|           |             |                    |              |                     |                          |

### Services used

MEC relevance: ALZ.MEC7

| # | Service                             | Details including SKU | Reference                                                        |
|---|-------------------------------------|-----------------------|------------------------------------------------------------------|
| 1 | Azure Event Grid System Topic       |                       | [azure-prdsvc-terraform-eventgridsystemtopic]                    |
| 2 | Azure Event Grid Event Subscription |                       | [azure-prdsvc-terraform-eventgrideventsubscription]              |
| 3 | Azure Event Grid Topic              |                       | [azure-prdsvc-terraform-eventgridtopic]                          |
| 4 | User Assigned Identities            |                       | [azure-prdsvc-terraform-userassignedidentity]                    |
| 5 | Azure Role Assignment               |                       | [azure-prdsvc-terraform-roleassignment]                          |

![Figure 2 - Event Grid Topics and Subscriptions](img/0064-event-grid-topics-subscriptions.png)

### Quality Assurance

- Pattern repository is created using the standard scaffolding process defined by the CPF and the metadata associated
  with the pattern is maintained in the centralized repository.
- Pattern utilizes clear listed cloud products that comply with the LSEG security controls.
- Pattern leverage CPF product validation pipelines to ensure consistency, and compliance during the deployment
  process.
- These pipelines likely include automated checks and tests to verify adherence to standards and best practices.
- Pipeline includes code scanning using approved tools like semgrep, checkov, kics, and secret detection to identify
  and address potential security vulnerabilities, issues, and other code quality concerns.
- Pattern is tested in both private and public Landing zones archetypes, ensuring compatibility and functionality
  across different deployment environments.
- Pattern is tested for various deployment options, ensuring they can be deployed in different configurations
  to meet the application requirements, these deployment options will be documented in the readme file in the
  patterns DXOne repository.

### Deployment Constraints

- Event Grid System Topic doesn't allow to deliver Event to Azure Function when public access is disabled and connected
  through Private Endpoints. This would need to be bypassed with Service Bus / Event Hubs / Storage Queue.
  [Consuming Private Endpoints using Event Grid][azure-event-grid-consume-private-endpoints]
- The use of managed identity and private link to delver event in the supported configuration is mentioned in the
  `Deliver Events Using Private Link Service` Section.
- The Data will only be at rest in the middle layers when using a Storage Queue / Service Bus / Event Hub.
  Encryption at rest will be done using Customer Managed Key.

#### Source Endpoints

1. **Azure Storage Accounts**:

    - **Description**: Blob storage events such as blob creation, deletion, and updates.
    - **Configuration**: Use EventHubs / Service Bus / Storage Queue as middle layer to store and deliver events to
      endpoints which don't support delivery of events through private link.
    - **Use Cases**: Suitable for scenarios where data integrity and security are paramount, such as logging and
      auditing
      file changes.

2. **Azure Resource Groups**:

    - **Description**: Resource events like creation, deletion, and updates of resources.
    - **Configuration**: Use EventHubs / Service Bus / Storage Queue as middle layer to store and deliver events to
      endpoints which don't support delivery of events through private link.
    - **Use Cases**: Ideal for tracking infrastructure changes and maintaining compliance with organizational policies.

3. **Azure Subscriptions**:

    - **Description**: Subscription-level events including policy changes and security alerts.
    - **Configuration**: Use EventHubs / Service Bus / Storage Queue as middle layer to store and deliver events to
      endpoints which don't support delivery of events through private link.
    - **Use Cases**: Useful for monitoring and responding to changes in subscription policies and security postures.

4. **Custom Topics**:

    - **Description**: Custom events generated by applications or other Azure services.
    - **Configuration**: Use EventHubs / Service Bus / Storage Queue as middle layer to store and deliver events to
      endpoints which don't support delivery of events through private link.
    - **Use Cases**: Perfect for custom application events that need to be processed or monitored in real-time.

5. **Azure Event Hubs**:

    - **Description**: Events related to data streams and telemetry.
    - **Configuration**: Use EventHubs / Service Bus / Storage Queue as middle layer to store and deliver events to
      endpoints which don't support delivery of events through private link.
    - **Use Cases**: Suitable for real-time data analytics and telemetry data ingestion.

6. **Azure Service Bus**:

    - **Description**: Messaging events such as queue and topic operations.
    - **Configuration**: Use EventHubs / Service Bus / Storage Queue as middle layer to store and deliver events to
      endpoints which don't support delivery of events through private link.
    - **Use Cases**: Ideal for decoupling applications and ensuring reliable message delivery in distributed systems.

7. **Azure IoT Hub**:

    - **Description**: Events from IoT devices and telemetry data.
    - **Configuration**: Use EventHubs / Service Bus / Storage Queue as middle layer to store and deliver events to
      endpoints which don't support delivery of events through private link.
    - **Use Cases**: Useful for processing and analysing IoT data in real-time.

8. **Azure Key Vault**:

    - **Description**: Events related to key, secret, and certificate operations.
    - **Configuration**: Use EventHubs / Service Bus / Storage Queue as middle layer to store and deliver events to
      endpoints which don't support delivery of events through private link.
    - **Use Cases**: Suitable for monitoring and auditing access to sensitive information.

9. **Azure App Configuration**:

    - **Description**: Events related to configuration changes.
    - **Configuration**: Use EventHubs / Service Bus / Storage Queue as middle layer to store and deliver events to
      endpoints which don't support delivery of events through private link.
    - **Use Cases**: Ideal for tracking and responding to configuration changes in applications.

10. **Azure SignalR Service**:

    - **Description**: Events related to connection and message operations.
    - **Configuration**: Use EventHubs / Service Bus / Storage Queue as middle layer to store and deliver events to
      endpoints which don't support delivery of events through private link.
    - **Use Cases**: Useful for real-time communication and monitoring connection status.

11. **Azure Machine Learning**:

    - **Description**: Events related to model training, deployment, and scoring.
    - **Configuration**: Use EventHubs / Service Bus / Storage Queue as middle layer to store and deliver events to
      endpoints which don't support delivery of events through private link.
    - **Use Cases**: Suitable for monitoring and automating machine learning workflows.

12. **Azure Policy**:

    - **Description**: Events related to policy compliance and changes.
    - **Configuration**: Use EventHubs / Service Bus / Storage Queue as middle layer to store and deliver events to
      endpoints which don't support delivery of events through private link.
    - **Use Cases**: Ideal for maintaining and enforcing organizational compliance policies.

13. **Azure Security Center**:

    - **Description**: Security alerts and recommendations.
    - **Configuration**: Use EventHubs / Service Bus / Storage Queue as middle layer to store and deliver events to
      endpoints which don't support delivery of events through private link.
    - **Use Cases**: Useful for monitoring and responding to security threats and vulnerabilities.

14. **Azure DevOps**:

    - **Description**: Events related to build, release, and code repository operations.
    - **Configuration**: Use EventHubs / Service Bus / Storage Queue as middle layer to store and deliver events to
      endpoints which don't support delivery of events through private link.
    - **Use Cases**: Suitable for automating and monitoring DevOps workflows.

15. **Azure Kubernetes Service (AKS)**:

    - **Description**: Events related to cluster operations and workloads.
    - **Configuration**: Use EventHubs / Service Bus / Storage Queue as middle layer to store and deliver events to
      endpoints which don't support delivery of events through private link.
    - **Use Cases**: Ideal for monitoring and managing Kubernetes clusters and workloads.

16. **Azure Logic Apps**:

    - **Description**: Workflow events such as trigger and action executions.
    - **Configuration**: Use EventHubs / Service Bus / Storage Queue as middle layer to store and deliver events to
      endpoints which don't support delivery of events through private link.
    - **Use Cases**: Useful for automating business processes and integrating disparate systems.

17. **Azure Functions**:

    - **Description**: Events related to function executions and errors.
    - **Configuration**: Use EventHubs / Service Bus / Storage Queue as middle layer to store and deliver events to
      endpoints which don't support delivery of events through private link.
    - **Use Cases**: Suitable for serverless compute scenarios and event-driven processing.

18. **Azure SQL Database**:

    - **Description**: Events related to database operations and security.
    - **Configuration**: Use EventHubs / Service Bus / Storage Queue as middle layer to store and deliver events to
      endpoints which don't support delivery of events through private link.
    - **Use Cases**: Ideal for monitoring and auditing database activities.

19. **Azure Cosmos DB**:

    - **Description**: Events related to database operations and changes.
    - **Configuration**: Use EventHubs / Service Bus / Storage Queue as middle layer to store and deliver events to
      endpoints which don't support delivery of events through private link.
    - **Use Cases**: Suitable for globally distributed applications and real-time data processing.

20. **Azure Data Lake Storage**:

    - **Description**: Events related to data storage and access operations.
    - **Configuration**: Use EventHubs / Service Bus / Storage Queue as middle layer to store and deliver events to
      endpoints which don't support delivery of events through private link.
    - **Use Cases**: Ideal for big data analytics and large-scale data storage.

21. **Azure Synapse Analytics**:

    - **Description**: Events related to data integration and analytics operations.
    - **Configuration**: Use EventHubs / Service Bus / Storage Queue as middle layer to store and deliver events to
      endpoints which don't support delivery of events through private link.
    - **Use Cases**: Suitable for data warehousing and advanced analytics scenarios.

22. **Azure Stream Analytics**:

    - **Description**: Events related to real-time data processing and analytics.
    - **Configuration**: Use EventHubs / Service Bus / Storage Queue as middle layer to store and deliver events to
      endpoints which don't support delivery of events through private link.
    - **Use Cases**: Ideal for processing fast-moving streams of data in real-time.

23. **Azure Automation**:

    - **Description**: Events related to automation runbooks and jobs.
    - **Configuration**: Use EventHubs / Service Bus / Storage Queue as middle layer to store and deliver events to
      endpoints which don't support delivery of events through private link.
    - **Use Cases**: Useful for automating operational tasks and managing infrastructure.

24. **Azure Monitor**:

    - **Description**: Events related to monitoring and alerting.
    - **Configuration**: Use EventHubs / Service Bus / Storage Queue as middle layer to store and deliver events to
      endpoints which don't support delivery of events through private link.
    - **Use Cases**: Suitable for tracking the health and performance of applications and infrastructure.

25. **Azure Application Insights**:

    - **Description**: Events related to application performance and diagnostics.
    - **Configuration**: Use EventHubs / Service Bus / Storage Queue as middle layer to store and deliver events to
      endpoints which don't support delivery of events through private link.
    - **Use Cases**: Ideal for monitoring and improving application performance and reliability.

#### Destination Endpoints

1. **Azure Functions**:

    - **Description**: Serverless compute service to process events.
    - **Configuration**: Delivering events to Azure Functions cannot be delivered using Private link use
      EventHubs / Service Bus / Storage Queue as middle layer to store and deliver the event to the Azure Functions
      Endpoint.
    - **Use Cases**: Suitable for lightweight, event-driven processing tasks such as data transformation or triggering
      workflows.
    - **Note**: Not usable directly as an endpoint due to MEC constraints on public access and limitation of Event grid
      to deliver events to this endpoint over private link.

2. **Azure Logic Apps**:

    - **Description**: Automate workflows and integrate with various services.
    - **Configuration**: Delivering events to Azure Logic Apps cannot be delivered using Private link use
      EventHubs / Service Bus / Storage Queue as middle layer to store and deliver the event to theAzure Logic Apps
      Endpoint.
    - **Use Cases**: Ideal for automating business processes and integrating disparate systems.
    - **Note**: Not usable directly as an endpoint due to MEC constraints on public access and limitation of Event grid
      to deliver events to this endpoint over private link.

3. **Azure Service Bus**:

    - **Description**: Messaging service for reliable message queuing.
    - **Configuration**: Ensure private endpoints and Managed Identities are used to deliver events.
    - **Use Cases**: Best for decoupling applications and ensuring reliable message delivery in distributed systems.

4. **Azure Storage Queues**:

    - **Description**: Simple queue service for message storage and retrieval.
    - **Configuration**: Ensure private endpoints and Managed Identities are used to deliver events.
    - **Use Cases**: Suitable for basic message queuing needs where simplicity and cost-effectiveness are key.

5. **Webhooks**:

    - **Description**: HTTP endpoints for custom event handling.
    - **Configuration**: Ensure proper authentication and authorization mechanisms are in place.
    - **Use Cases**: Useful for integrating with external systems or triggering custom workflows based on events.

6. **Azure Event Hubs**:

    - **Description**: Big data streaming platform and event ingestion service.
    - **Configuration**: Ensure private endpoints and Managed Identities are used to deliver events.
    - **Use Cases**: Suitable for real-time data analytics and telemetry data ingestion.

7. **Azure Stream Analytics**:

    - **Description**: Real-time analytics service for processing fast-moving streams of data.
    - **Configuration**:  Delivering events to Azure Stream Analytics cannot be delivered using Private link use
      EventHubs / Service Bus / Storage Queue as middle layer to store and deliver the event to the Azure Stream
      Analytics Endpoint.
    - **Use Cases**: Ideal for real-time data processing and analytics.
    - **Note**: Not usable directly as an endpoint due to MEC constraints on public access and limitation of Event grid
      to deliver events to this endpoint over private link.

8. **Azure Data Lake Storage**:

    - **Description**: Scalable data storage service for big data analytics.
    - **Configuration**:  Delivering events to Azure Data Lake Storage cannot be delivered using Private link use
      EventHubs / Service Bus / Storage Queue as middle layer to store and deliver the event to the Azure Data Lake
      Storage Endpoint.
    - **Use Cases**: Suitable for storing large volumes of structured and unstructured data.
    - **Note**: Not usable directly as an endpoint due to MEC constraints on public access and limitation of Event grid
      to deliver events to this endpoint over private link.

9. **Azure Synapse Analytics**:

    - **Description**: Analytics service that brings together big data and data warehousing.
    - **Configuration**:  Delivering events to Azure Synapse Analytics cannot be delivered using Private link use
      EventHubs / Service Bus / Storage Queue as middle layer to store and deliver the event to the Azure Synapse
      Analytics Endpoint.
    - **Use Cases**: Ideal for data integration, big data, and advanced analytics.
    - **Note**: Not usable directly as an endpoint due to MEC constraints on public access and limitation of Event grid
      to deliver events to this endpoint over private link.

10. **Azure SQL Database**:

    - **Description**: Managed relational database service.
    - **Configuration**:  Delivering events to Azure Cosmos DB cannot be delivered using Private link use
      EventHubs / Service Bus / Storage Queue as middle layer to store and deliver the event to the Cosmos DB Endpoint.
    - **Use Cases**: Suitable for relational data storage and processing.
    - **Note**: Not usable directly as an endpoint due to MEC constraints on public access and limitation of Event grid
      to deliver events to this endpoint over private link.

11. **Azure Cosmos DB**:

    - **Description**: Globally distributed, multi-model database service.
    - **Configuration**:  Delivering events to Cosmos DB cannot be delivered using Private link use
      EventHubs / Service Bus / Storage Queue as middle layer to store and deliver the event to the Cosmos DB Endpoint.
    - **Use Cases**: Ideal for globally distributed applications and real-time data processing.

#### Deliver Events Using Private Link Service

This section describes how to work around the limitation of push delivery to deliver events using private link service.

**Pull** delivery supports consuming events using private links. Pull delivery is a feature of Event Grid namespaces.
Once you have added a private endpoint connection to a namespace, your consumer application can connect to Event Grid
on a private endpoint to receive events. For more information,
see [configure private endpoints for namespaces][azure-event-grid-configure-private-endpoints-pull]
and [pull delivery overview][azure-event-grid-pull-delivery-overview].

With **push** delivery, it isn't possible to deliver events using
[private endpoints][azure-private-link-private-endpoint-overview].
However, there's a secure alternative using managed identities with public endpoints.

##### Use Managed Identity

If you're using Event Grid basic and your requirements call for a secure way to send events using an encrypted channel
and a known identity of the sender (in this case, Event Grid) using public IP space, you could deliver events to Event
Hubs, Service Bus, or Azure Storage service using an Azure Event Grid custom topic or a domain with system-assigned or
user-assigned managed identity. For details about delivering events using managed identity, see [Event delivery using
a managed identity][azure-event-grid-managed-service-identity].

Under this configuration, the secured traffic from Event Grid to Event Hubs, Service Bus, or Azure Storage,
[stays on the Microsoft backbone][azure-networking-microsoft-global-network]
and a managed identity of Event Grid is used. Configuring your Azure Function or webhook from within your virtual
network
to use an Event Hubs, Service Bus, or Azure Storage via private link ensures the traffic between those services and your
function or webhook stays within your virtual network perimeter.

Data at rest and Data in transit for the same is discussed in the sections below.

![Figure 3 - Deliver Events Via Private link Service](img/0064-deliver-events-via-private-link-service.png)

##### Deliver Events Using Managed Identity

To deliver events using managed identity, follow these steps:

1. **Event Hubs**:

    - Enable system-assigned or user-assigned managed
      identity: [system topics][azure-event-grid-enable-identity-system-topics],
      [custom topics, and domains][azure-event-grid-enable-identity-custom-topics-domains].
    - [Add the identity to the **Azure Event Hubs Data Sender
      ** role on the Event Hubs namespace][azure-event-hubs-authenticate-managed-identity].
    - [Configure the event subscription][azure-event-grid-managed-service-identity-create-subscriptions]
      that uses an event hub as an endpoint to use the system-assigned or user-assigned managed identity.

2. **Service Bus**:

    - Enable system-assigned or user-assigned managed
      identity: [system topics][azure-event-grid-enable-identity-system-topics],
      [custom topics, and domains][azure-event-grid-enable-identity-custom-topics-domains].
    - [Add the identity to the **Azure Service Bus Data Sender
      **][azure-service-bus-managed-service-identity]
      role on the Service Bus namespace.
    - [Configure the event subscription][azure-event-grid-managed-service-identity]
      that
      uses a Service Bus queue or topic as an endpoint to use the system-assigned or user-assigned managed identity.

3. **Storage**:

    - Enable system-assigned or user-assigned managed
      identity: [system topics][azure-event-grid-enable-identity-system-topics],
      [custom topics, and domains][azure-event-grid-enable-identity-custom-topics-domains].
    - [Add the identity to the **Storage Queue Data Message Sender
      **][azure-storage-assign-azure-role-data-access]
      role on Azure Storage queue.
    - [Configure the event subscription][azure-event-grid-managed-service-identity-create-subscriptions]
      that uses a Storage queue as an endpoint to use the system-assigned or user-assigned managed identity.

##### Firewall and Virtual Network Rules

If there's no firewall or virtual network rules configured for the destination Storage account, Event Hubs namespace, or
Service Bus namespace, you can use both user-assigned and system-assigned identities to deliver events.

If a firewall or virtual network rule is configured for the destination Storage account, Event Hubs namespace, or
Service Bus namespace, you can use only the system-assigned managed identity if **Allow Azure services on the trusted
service list to access the storage account** is also enabled on the destinations. You can't use user-assigned managed
identity whether this option is enabled or not.

For more information about delivering events using a managed identity,
see [Event delivery using a managed identity][azure-event-grid-managed-service-identity].

### Non-Viable Configurations as per LSEG Standards

- **Publicly Accessible Endpoints**: Any endpoint that requires public access is non-viable due to security constraints.
- **Endpoints without VNet Integration**: Endpoints that do not support VNet integration are non-viable as they do not
  meet the security requirements.

## Reliability View

Resources:

- [LSEG Azure Resiliency Design Guideline][lseg-azure-resiliency-design-guideline].
- [Azure Well-Architected Reliability design principles][azure-well-architected-reliability].

The following components with the SKUs provide high availability.

| Service                                   | Sku | Availability                                                                                                        | Remarks                                                                                                                                                                                                                                                                                                                                                          |
|-------------------------------------------|-----|---------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Event Grid System Topic and Subscriptions |     | Resilient from Zonal failures.<br>If deployed in region with region pairs it will be resilient to regional outages. | It supports availability zone out of the box if the region deployed to has availability zone support.<br> For paired regions , Azure manages the geo fail over in case of any region outages. Client side fail over support is not supported for System Topics. [Client-side failover implementation in Azure Event Grid][azure-event-grid-client-side-failover] |
| Event Grid Custom Topic and Subscriptions |     | Resilient from Zonal failures.<br>If deployed in region with region pairs it will be resilient to regional outages. | It supports availability zone out of the box if the region deployed to has availability zone support.<br> For paired regions , Azure manages the geo fail over in case of any region outages. Client side fail over support is not supported for System Topics. [Client-side failover implementation in Azure Event Grid][azure-event-grid-client-side-failover] |

### Service Level Achievement

| Scenario          | SLA    | SLO | RTO     | RPO       | Cost factor | Design details                    |
|-------------------|--------|-----|---------|-----------|-------------|-----------------------------------|
| Standard          | 99.9%  |     | < 4 hrs | Near Zero | 1           | Use of Zone Redundant components. |
| High Availability | 99.99% |     | 2-8 hrs | Near Zero |             |                                   |

### Recovery Pattern

Pattern consumers should use non-paired regions as the primary and secondary region and is advised to use separate
Zone redundant deployments for the services in each region. When paired regions are used Microsoft managed fail-overs
may not be meeting the RTO s, and customer planned fail-overs are not in GA for Event Grid. Failing over to a paired
region may cause capacity issues in case of a regional disaster, since many workloads will be struggling to find
capacity in the paired region. The Event Grid workloads will be deployed along with the applications which interact with
it in the secondary region and DR should be planned in line with application DR strategies.

Pattern consumers must consider the data replication strategies across the region.

| Recovery Pattern                  | Design compatibility | Comments                                                                                                                       |
|-----------------------------------|----------------------|--------------------------------------------------------------------------------------------------------------------------------|
| Active-Active<br>(Tiers 1, 2)     | [ ]                  |                                                                                                                                |
| Active-Passive<br>(Tiers 1, 2, 3) | [x]                  | Consumer should use non paired regions for deploying stand alone ZRS resources and manage the fail overs and data replication. |
| Warm Standby<br>(Tiers 2, 3, 4)   | [x]                  | Consumer should use non paired regions for deploying stand alone ZRS resources and manage the fail overs and data replication. |
| Pilot Light<br>(Tiers 3, 4, 5)    | [x]                  |                                                                                                                                |

## Security View

Resources:

- [LSEG Secure Design Principles][lseg-secure-design-principles]
- [LSEG LMP Secure Design Patterns][lseg-lmp-secure-design-patterns]
- [Azure Well-Architected Security design principles][azure-well-architected-security].
- [Event Grid Security and Authorisation][azure-event-grid-security-authorization]
- [Event Grid Security Baseline][azure-event-grid-security-baseline]

1. Pattern disables public accesses of the PaaS services and use Private Endpoints.
2. Services which have VNet Integration are enabled for the same. (eg: Function App endpoints).
3. User Identities should be given access only via manual process which should be laid down separately using PIM / PAM.
   The process as such would be out of scope for this pattern.

### Access Control - LSEG Users and Systems

MEC relevance: MEC-V3_2-19, MEC-V3_2-20

| Access Type                                                        | Role(s)                | Destination(s)/Servers                    | Authentication method(s) | Server-side credential protection (if not using a Group-wide approved AuthN system) |
|--------------------------------------------------------------------|------------------------|-------------------------------------------|--------------------------|-------------------------------------------------------------------------------------|
| LSEG End Users                                                     | NA                     | NA                                        | NA                       | NA(Not intended for end-users only to be used by applications)                      |
| IT Operations Users                                                | NA                     | NA                                        | NA                       | NA(Not intended for end-users only to be used by applications)                      |
| Internal applications / Service Account / Robotic Process Accounts | Event Grid Data Sender | Event Grid Topic                          | Entra ID                 |                                                                                     |
| Event Grid Service                                                 | Event Grid Data Sender | Event Grid Topic on Destination endpoints | Managed Identity         |                                                                                     |

### Secret / Password Protection

MEC relevance: MEC-V3_2-26

| Concern              | Response                                                                                                                                                                   |
|----------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Secrets storage      | [ ] Azure Key Vault <br> [x] Other: `Event Grid by itself does not consume any secrets however the endpoints based on the configuration may use.`                          |
| Secrets distribution | [ ] Distributed at deployment time <br> [*] Retrieved on demand `Used During deployment - retrieved from hashicorp vault`                                                  |
| Secrets protection   | [ ] Local vault or secure store on host <br> [ ] Stored on host's local file system (either as separate file or part of a configuration file) <br> [ ] Held in memory only |

### Data at Rest Protection

MEC relevance: MEC-V3_2-25, MEC-V3_2-23

| Concern                     | Response                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
|-----------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Encryption deployment level | [x] Storage (e.g. full disk encryption, SAN encryption) <br> [ ] Transparent database encryption <br> [ ] Application (e.g. column-level encryption) `Event Grid uses Microsoft-managed keys for data-at-rest encryption by default(Responsibility lies with Microsoft for this), However any data that is stored in the Storage Queue/ Event Hubs/ Service bus as destination endpoint for Delivering event thorugh private link, needs to be encrypted- This is out of scope for the pattern.` |
| Encryption key usage        | [x] Symmetric key <br> [ ] Asymmetric key pair <br> `Provide details of encryption algorithm, cipher, key lengths:` <br> <br>                                                                                                                                                                                                                                                                                                                                                                    |
| Key generation              | [ ] HSM (FIPS-140 Level 3 or above)<br> [x] Azure Key Vault <br> [ ] Other (describe below)                                                                                                                                                                                                                                                                                                                                                                                                      |
| Key storage                 | [ ] HSM (FIPS-140 Level 3 or above) <br> [x] Azure Key Vault <br> [ ] Other (describe below)                                                                                                                                                                                                                                                                                                                                                                                                     |
| Key rotation / deletion     | Event Grid keys used for data-at-rest will be rotated by Microsoft as these are Microsoft-managed keys.                                                                                                                                                                                                                                                                                                                                                                                          |

- Data at rest encryption:
    - Event Grid also encrypts data at rest using Microsoft-managed keys.
    - When using Storage Queue as an endpoint to deliver events via private link, encryption at rest needs to be handled
      using CMK, for this the pattern can be leveraged further enhancing security.

### Data at transit Protection

- TLS encryption:
    - All data sent to and from Event Grid is automatically encrypted using TLS, which is the industry-standard for
      secure communication over the internet.
- Additional configuration needed:
    - By default, Event Grid uses TLS encryption for data in transit automatically,
      TLS 1.2 Needs to be configured for Event grid Topics and Domains- Pattern currently doest support this,
      will be added to the Deployable Code(IaC) as part of the next iteration.

### Data Backup

MEC relevance: MEC-V3_2-27

| Concern                                                      | Response                                                                                                     |
|--------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------|
| Backup technology                                            | [ ] Atlas <br> [ ] Azure backup <br> [ ] Other <br> [ ] No - provided by SaaS solution [x] Not Applicable    |
| Backup protection against unauthorised modification/deletion | `Event grid does not store any data how ever based on the endpoint configure data backup must be configured` |
| Backup access management                                     | `Event grid does not store any data how ever based on the endpoint configure data backup must be configured` |

## Operational Excellence View

`Describe how the pattern design includes features that contribute to the Operational Excellence of any consuming application.`

See [Azure Well-Architected Operational Excellence design principles][azure-well-architected-operational-excellence].

### DevOps Practices

MEC relevance:  DEV.MEC\*

| Secrets distribution | [ ] Distributed at deployment time <br> [*] Retrieved on demand |
| Secrets protection | [x] Local vault or secure store on host <br> [ ] Stored on host's local file system (either as
separate file or part of a configuration file) <br> [ ] Held in memory only |

### Monitoring and Observability

Pattern supports Monitoring and observability through DataDog, during deployment of SFTP
storage and dependent services are assigning following tags required for datadog monitoring.

```toml
 mnd-applicationid = "app-${var.app_id}"
cloud_provider = "azure"
```

1. Logging of Azure Resource Log (Diagnostic logs) is to be handled centrally managed policy as per STAR mentioned
   in Datadog design doc and observability doc.
2. Application teams are needed to onboard the app to Datadog platform.
3. Integration with Datadog will be centrally managed and will be complete transparent to application teams deploying
   the pattern.
4. As per current design, audit/ security logs will be sent to Log Analytics workspace in Hub Network through central
   policy of Landing Zone.
5. Monitoring and alert process is the ownership of application team, application team is recommended to make desired
   dashboards and implement alert mechanism so that application events which indicate security issues are identified and
   have been communicated.

MEC relevance: ALZ.MEC5

`Provide details to support any MEC exception requests here`

## Cost Optimisation View

`Describe how the pattern design includes features that contribute to the cost optimisation of any consuming application.`

| Scenario                                    | Average Monthly Cost |
|---------------------------------------------|----------------------|
| Basic Tier with Custom Topics               | $120                 |
| Standard Tier with High Throughput and MQTT | $350                 |
| Event Grid with Claim-Check Pattern         | $180                 |
| Event Grid with Competing Consumers Pattern | $220                 |

MEC relevance: ALZ.MEC4

See [Choose the right Event Grid tier for your solution][azure-event-grid-choose-right-tier].
See [Azure Well-Architected Cost Optimization design principles][azure-well-architected-cost-optimization].

## Performance Efficiency View

`Describe how the pattern design includes features that contribute to the performance efficiency any consuming application.`

See [Azure Well-Architected Performance Efficiency design principles][azure-well-architected-performance-efficiency].

## Client Migration View

`Include any details relevant to the migration of clients from existing to LMP infrastructure`

## Minimum Entry Criteria (MEC) compliance

**Criteria ID, Criteria Title** - as per MEC baseline.

**Compliance** - indicate whether the design is:

- compliant (🟢) or
- non-compliant (🔴) or
- the criteria are not applicable (🟡)

**Explanation** - provide evidence / commentary to support the Compliance assessment.

### Cyber Security MEC

MEC
baseline: [2888825445AzureLZHostedApps-CyberMinimumEntryCriteria-v3_2_0_2-FINAL][cybersecurity-mec-baseline]

| Criteria ID | Criteria Title                                                                  | Compliance | Explanation                                                                                                                                                                                                                  |
|-------------|---------------------------------------------------------------------------------|------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| MEC-V3_2-1  | Web Application Firewall                                                        | 🟡         | The pattern cannot be applied to Internet facing solutions, the architecture in the pattern is defined to run in a private endpoint connection hosted in a non-routable network.                                             |
| MEC-V3_2-2  | Segmentation                                                                    | 🟢         | The architecture document shows trust boundaries like the subscriptions, the network separations via private endpoints and other means. This will be helpful in preventing the lateral movement.                             |
| MEC-V3_2-3  | Anti-malware Deployment                                                         | 🟡         | The pattern covers PaaS components and the concept of container images is not applicable here.                                                                                                                               |
| MEC-V3_2-4  | Vulnerability Management Tooling                                                | 🟡         | The pattern covers PaaS components and the concept of container images is not applicable here.                                                                                                                               |
| MEC-V3_2-5  | Hardened Configuration                                                          | 🟢         | The pattern covers PaaS components and the landing zone has azure policies in place controlling the secure deployment of the resources. Any update to the related policies will have the impact on the component.            |
| MEC-V3_2-6  | Secure Configuration - Containers                                               | 🟡         | The pattern covers PaaS components and the concept of container images is not applicable here.                                                                                                                               |
| MEC-V3_2-7  | Static Code Assessment                                                          | 🟡         | The code to deploy the pattern is stored in DX1, where continuous code assessments are done. Additional code to build the applications on top of the pattern needs to be checked in to ensure that the scanning is in place. |
| MEC-V3_2-8  | Software Currency                                                               | 🟢         | The components in use in the pattern are PaaS.                                                                                                                                                                               |
| MEC-V3_2-9  | Software Vulnerability Assessment                                               | 🟡         | There are no open source components being deployed as part of the pattern.                                                                                                                                                   |
| MEC-V3_2-10 | Patch Management                                                                | 🟡         | Any patching on the component is part of the cloud platform services. This process is done without interruptions to the service.                                                                                             |
| MEC-V3_2-11 | Resilient Architectures for Ease of Patch Application and Incident Preparedness | 🟢         | Any patching on the component is part of the cloud platform services. This process is done without interruptions to the service.                                                                                             |
| MEC-V3_2-12 | Rapid Perimeter Blocking Request                                                | 🟡         | The pattern is focused on cloud-native components. These components can be isolated via the firewalls or other mechanisms in the underlying architecture.                                                                    |
| MEC-V3_2-13 | Infrastructure as Code Implementation                                           | 🟢         | The pattern will be deployed as per the standard DX1 processes.                                                                                                                                                              |
| MEC-V3_2-14 | Protocols                                                                       | 🟢         | The pattern is focused on cloud-native component. The pattern components communicate internally in Azure which is always using encryption.                                                                                   |
| MEC-V3_2-15 | Confidentiality In Transit                                                      | 🟢         | The pattern is focused on cloud-native component. The pattern components communicate internally in Azure which is always using encryption.                                                                                   |
| MEC-V3_2-16 | Compensating Controls for Non-Compliant Applications                            | 🟡         | The pattern uses PaaS component. Hardening of the component is controlled by Azure and by platform using the Azure policies.                                                                                                 |
| MEC-V3_2-17 | Internal API Authentication                                                     | 🟡         | The pattern does not expose any APIs.                                                                                                                                                                                        |
| MEC-V3_2-18 | Client Access                                                                   | 🟡         | The pattern is not meant to be used by end-user connections, it's always meant to be used by applications.                                                                                                                   |
| MEC-V3_2-19 | Workforce Authentication - Approved SSO Methods                                 | 🟡         | The pattern is not meant to be used by end-user connections, it's always meant to be used by applications.                                                                                                                   |
| MEC-V3_2-20 | Approved IAM Authorisation Patterns                                             | 🟡         | The pattern is not meant to be used by end-user connections, it's always meant to be used by applications.                                                                                                                   |
| MEC-V3_2-21 | Access Certification - Internal Users                                           | 🟡         | This integration should be managed by applications using the pattern.                                                                                                                                                        |
| MEC-V3_2-22 | Secure Administration: Access Path                                              | 🟡         | The privileged access management is explicitly out of scope for the pattern. It needs to be fulfilled by the application using the pattern.                                                                                  |
| MEC-V3_2-23 | Credential Rotation                                                             | 🟢         | All systems must be ready in configuration and standard procedures, to rotate any credentials that are known or suspected to have been compromised.                                                                          |
| MEC-V3_2-24 | Customer Authentication - Authentication Methods                                | 🟡         | The pattern is not customer facing. The applications need to cater for the authentication. The pattern allows for the use of passwords to cater the legacy applications.                                                     |
| MEC-V3_2-25 | Confidentiality At Rest                                                         | 🟢         | Data will be encrypted at rest and during transit as stated in the pattern.                                                                                                                                                  |
| MEC-V3_2-26 | Secrets Management                                                              | 🟢         | Key vault will be used for secret storage as mentioned in the pattern.                                                                                                                                                       |
| MEC-V3_2-27 | Appropriate Backups                                                             | 🟢         | All components for an application must be backed up in accordance with the requirements of the Backup Data Retention Standard.                                                                                               |
| MEC-V3_2-28 | Application Log Collection                                                      | 🟢         | Logging of Azure Resource Log (Diagnostic logs) is to be handled centrally managed policy as per Datadog design doc and observability doc.                                                                                   |
| MEC-V3_2-29 | Log Event Awareness                                                             | 🟢         | The infrastructure events are taken to GSOC by Azure backend. There is not particular compliance required specifically from pattern side.                                                                                    |
| MEC-V3_2-30 | Extrinsic Security Assurance                                                    | 🟡         | There are no internet facing resource exposed as per the pattern so penetration testing is not applicable.                                                                                                                   |

### Other MEC

MEC
baseline: [FoundationPillar-MinimumEntryCriteria-v0_2][foundation-pillar-mec-baseline]

| Criteria ID | Criteria Title                                                     | Compliance | Explanation |
|-------------|--------------------------------------------------------------------|------------|-------------|
| ALZ.MEC1    | Application Identification                                         |            |             |
| ALZ.MEC2    | Asset Tagging and Naming                                           |            |             |
| ALZ.MEC3    | Obtain Governance approval and ID                                  |            |             |
| ALZ.MEC4    | Cost-Efficiency and budget                                         |            |             |
| ALZ.MEC5    | Application Observability                                          |            |             |
| ALZ.MEC6    | Disaster Recovery Plan and Test                                    |            |             |
| ALZ.MEC7    | Whitelisted Services and Regions                                   |            |             |
| ALZ.MEC8    | Application runbooks and playbooks                                 |            |             |
| ALZ.MEC9    | Use of DNS                                                         |            |             |
| ALZ.MEC10   | RIANA for DNS namespace management                                 |            |             |
| ALZ.MEC11   | Connectivity management                                            |            |             |
| ALZ.MEC12   | RIANA for IP private address space management                      |            |             |
| ALZ.MEC13   | Application service IP addressing for private line customer access |            |             |
| ALZ.MEC14   | Predict application bandwidth consumption                          |            |             |
| ALZ.MEC15   | Understand application connectivity dependencies                   |            |             |
| ALZ.MEC16   | Instrument application to provide network telemetry                |            |             |
| DEV.MEC19.1 | DXOne CI/CD Platform used                                          |            |             |
| DEV.MEC19.2 | Automated Testing                                                  |            |             |
| DEV.MEC19.3 | Automated Code Security Analysis                                   |            |             |
| DEV.MEC19.4 | Automated Artifact Security Analysis                               |            |             |
| DEV.MEC19.5 | Automated IaC Security Analysis                                    |            |             |
| DEV.MEC19.6 | CI/CD Change Management Integration                                |            |             |

[^information-classification-standard]: <https://lsegroup.sharepoint.com/sites/ats/Shared%20Documents/Forms/AllItems.aspx?id=%2Fsites%2Fats%2FShared%20Documents%2FStandards%2FLSEG%20Standards%2FInformation%20Security%2FApproved%2FLSEG%20Cyber%20Security%20Standard%20%2D%20Information%20Classification%20Handling%20%28v2%2E0%29%2Epdf&parent=%2Fsites%2Fats%2FShared%20Documents%2FStandards%2FLSEG%20Standards%2FInformation%20Security%2FApproved>

[^azure-resiliency-design]: <https://lsegroup.sharepoint.com/:w:/r/teams/LSEGLMPAppMigrationApprovers/_layouts/15/Doc.aspx?sourcedoc=%7B4791AECB-781E-47C0-9665-0143A2C168CD%7D&file=Azure%20Resiliency%20Design%20Guideline.docx&action=default&mobileredirect=true&DefaultItemOpen=1>

[lmp-migration-patterns-adrs]: https://app.pages.dx1.lseg.com/app-51723/migration-patterns/mig-pat-source-to-target/

[azure-prdsvc-terraform-eventgridsystemtopic]: https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-eventgridsystemtopic

[azure-prdsvc-terraform-eventgrideventsubscription]: https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-eventgrideventsubscription

[azure-prdsvc-terraform-eventgridtopic]: https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-eventgridtopic

[azure-prdsvc-terraform-userassignedidentity]: https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-userassignedidentity

[azure-prdsvc-terraform-roleassignment]: https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-roleassignment

[azure-event-grid-consume-private-endpoints]: https://learn.microsoft.com/en-us/azure/event-grid/consume-private-endpoints

[azure-event-grid-configure-private-endpoints-pull]: https://learn.microsoft.com/en-us/azure/event-grid/configure-private-endpoints-pull

[azure-event-grid-pull-delivery-overview]: https://learn.microsoft.com/en-us/azure/event-grid/pull-delivery-overview

[azure-private-link-private-endpoint-overview]: https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-overview

[azure-event-grid-managed-service-identity]: https://learn.microsoft.com/en-us/azure/event-grid/managed-service-identity

[azure-networking-microsoft-global-network]: https://learn.microsoft.com/en-us/azure/networking/microsoft-global-network#get-the-premium-cloud-network

[azure-event-grid-enable-identity-system-topics]: https://learn.microsoft.com/en-us/azure/event-grid/enable-identity-system-topics

[azure-event-grid-enable-identity-custom-topics-domains]: https://learn.microsoft.com/en-us/azure/event-grid/enable-identity-custom-topics-domains

[azure-event-hubs-authenticate-managed-identity]: https://learn.microsoft.com/en-us/azure/event-hubs/authenticate-managed-identity#to-assign-azure-roles-using-the-azure-portal

[azure-event-grid-managed-service-identity-create-subscriptions]: https://learn.microsoft.com/en-us/azure/event-grid/managed-service-identity#create-event-subscriptions-that-use-an-identity

[azure-service-bus-managed-service-identity]: https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-managed-service-identity#azure-built-in-roles-for-azure-service-bus

[azure-storage-assign-azure-role-data-access]: https://learn.microsoft.com/en-us/azure/storage/blobs/assign-azure-role-data-access

[lseg-azure-resiliency-design-guideline]: https://lsegroup.sharepoint.com/:w:/r/teams/LSEGLMPAppMigrationApprovers/Shared%20Documents/Architecture%20Docs%20-%20Proposals,%20Strategies%20etc/Azure%20Resiliency%20Design%20Guideline%20v0.5.docx?d=wf885c5b4691d4c3d94823f4e01d9e126&csf=1&web=1&e=IpvBNF

[azure-well-architected-reliability]: https://learn.microsoft.com/en-us/azure/well-architected/reliability/principles

[azure-event-grid-client-side-failover]: https://learn.microsoft.com/en-us/azure/event-grid/custom-disaster-recovery-client-side

[lseg-secure-design-principles]: https://confluence.refinitiv.com/display/PSAR/Secure+Design+Principles

[lseg-lmp-secure-design-patterns]: https://confluence.refinitiv.com/display/PSAR/LMP+-+Secure+Design+Patterns

[azure-well-architected-security]: https://learn.microsoft.com/en-us/azure/well-architected/security/principles

[azure-event-grid-security-authorization]: https://learn.microsoft.com/en-us/azure/event-grid/security-authorization

[azure-event-grid-security-baseline]: https://learn.microsoft.com/en-us/security/benchmark/azure/baselines/event-grid-security-baseline

[azure-well-architected-operational-excellence]: https://learn.microsoft.com/en-us/azure/well-architected/operational-excellence/principles

[azure-event-grid-choose-right-tier]: https://learn.microsoft.com/en-us/azure/event-grid/choose-right-tier

[azure-well-architected-cost-optimization]: https://learn.microsoft.com/en-us/azure/well-architected/cost-optimization/principles

[azure-well-architected-performance-efficiency]: https://learn.microsoft.com/en-us/azure/well-architected/performance-efficiency/principles

[cybersecurity-mec-baseline]: https://lsegroup.sharepoint.com/sites/ats/SiteAssets/SitePages/LMP-Migration-Architecture/2888825445AzureLZHostedApps-CyberMinimumEntryCriteria-v3_2_0_2-FINAL.xlsx?web=1

[foundation-pillar-mec-baseline]: https://lsegroup.sharepoint.com/:x:/r/teams/LMFoundationFM/Shared%20Documents/General/00%20Foundation%20Mgmt/00.%20Foundation%20Management%20Office/03.%20MEC/Foundation%20Pillar-MinimumEntryCriteria-v0_2.xlsx?d=wa885d4265ff8405b951637f2eb533e2f&csf=1&web=1&e=dS4Yz2

