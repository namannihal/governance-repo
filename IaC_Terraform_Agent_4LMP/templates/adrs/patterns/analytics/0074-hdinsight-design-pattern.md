<span class="md-content__button md-icon md-status--published" href="#" title="Status: Published"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE4LjUgMmgtMTNDMy42IDIgMiAzLjYgMiA1LjV2MTNDMiAyMC40IDMuNiAyMiA1LjUgMjJIMTZsNi02VjUuNUMyMiAzLjYgMjAuNCAyIDE4LjUgMk0yMCAxNWgtMS41Yy0xLjkgMC0zLjUgMS42LTMuNSAzLjVWMjBINS44Yy0xIDAtMS44LS44LTEuOC0xLjhWNS44QzQgNC44IDQuOCA0IDUuOCA0aDEyLjVjMSAwIDEuOC44IDEuOCAxLjhWMTVtLTQuOS02LjggMS41IDEuNS02IDYtMy41LTMuNSAxLjUtMS41IDIgMnoiIC8+PC9zdmc+) </span> <span class="md-content__button md-icon .md-status--published" title="Valid from 2025-07-01"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE5IDE5SDVWOGgxNG0wLTVoLTFWMWgtMnYySDhWMUg2djJINWEyIDIgMCAwIDAtMiAydjE0YTIgMiAwIDAgMCAyIDJoMTRhMiAyIDAgMCAwIDItMlY1YTIgMiAwIDAgMC0yLTJtLTIuNDcgOC4wNkwxNS40NyAxMGwtNC44OCA0Ljg4LTIuMTItMi4xMi0xLjA2IDEuMDZMMTAuNTkgMTd6IiAvPjwvc3ZnPg==) </span> <span class="md-content__button md-icon actions-date" title="Published on 2025-06-11">![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTkgMTB2Mkg3di0yem00IDB2MmgtMnYtMnptNCAwdjJoLTJ2LTJ6bTItN2EyIDIgMCAwIDEgMiAydjE0YTIgMiAwIDAgMS0yIDJINWEyIDIgMCAwIDEtMi0yVjVhMiAyIDAgMCAxIDItMmgxVjFoMnYyaDhWMWgydjJ6bTAgMTZWOEg1djExek05IDE0djJIN3YtMnptNCAwdjJoLTJ2LTJ6bTQgMHYyaC0ydi0yeiIgLz48L3N2Zz4=)</span> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/edit/main/docs/patterns/analytics/0074-hdinsight-design-pattern.md" class="md-content__button md-icon" title="Edit this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTEwIDIwSDZWNGg3djVoNXYzLjFsMi0yVjhsLTYtNkg2Yy0xLjEgMC0yIC45LTIgMnYxNmMwIDEuMS45IDIgMiAyaDR6bTEwLjItN2MuMSAwIC4zLjEuNC4ybDEuMyAxLjNjLjIuMi4yLjYgMCAuOGwtMSAxLTIuMS0yLjEgMS0xYy4xLS4xLjItLjIuNC0uMm0wIDMuOUwxNC4xIDIzSDEydi0yLjFsNi4xLTYuMXoiIC8+PC9zdmc+" /></a> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/blob/main/docs/patterns/analytics/0074-hdinsight-design-pattern.md" class="md-content__button md-icon" title="View source of this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE3IDE4Yy41NiAwIDEgLjQ0IDEgMXMtLjQ0IDEtMSAxLTEtLjQ0LTEtMSAuNDQtMSAxLTFtMC0zYy0yLjczIDAtNS4wNiAxLjY2LTYgNCAuOTQgMi4zNCAzLjI3IDQgNiA0czUuMDYtMS42NiA2LTRjLS45NC0yLjM0LTMuMjctNC02LTRtMCA2LjVhMi41IDIuNSAwIDAgMS0yLjUtMi41IDIuNSAyLjUgMCAwIDEgMi41LTIuNSAyLjUgMi41IDAgMCAxIDIuNSAyLjUgMi41IDIuNSAwIDAgMS0yLjUgMi41TTkuMjcgMjBINlY0aDd2NWg1djQuMDdjLjcuMDggMS4zNi4yNSAyIC40OVY4bC02LTZINmEyIDIgMCAwIDAtMiAydjE2YTIgMiAwIDAgMCAyIDJoNC41YTguMiA4LjIgMCAwIDEtMS4yMy0yIiAvPjwvc3ZnPg==" /></a>

Document Metadata

|  |  |
|----|----|
| Identifier | **`LMP-PAT-0074`** |
| Type | **Technical Design Pattern** |
| Status | **Published** |
| Approvals | <span class="md-tag">LMP Migration Architecture Approval</span> |
| Governance Reference | **[]()** |
| Pattern Source Repo | []() |
| Published on | **June 11, 2025** |
| Valid From | **July 01, 2025** |
| Authors | <span class="md-source-file__fact"> </span> |
| Tags | <span class="md-tag">Data Analytics & Visualizations</span> |
| Technology Capabilities | <span class="md-tag">Platform / Data / Data Analytics & Visualizations</span> |

# HD Insight Hadoop Cluster Pattern<a href="#hd-insight-hadoop-cluster-pattern" class="headerlink" title="Permanent link">¶</a>

## Introduction<a href="#introduction" class="headerlink" title="Permanent link">¶</a>

Azure HDInsight is a cloud based big data analytics service that enables processing and analytics of large datasets. It leveraged open-source frameworks like Hadoop, Spark, Hive, Kafka, and others. HDInsight enabled you to create optimized clusters for these technologies, providing enterprise-grade security, reliability, and scalability within the Azure environment.

### Context<a href="#context" class="headerlink" title="Permanent link">¶</a>

The pattern will assist migration execution teams in the LMP program to efficiently deploy and manage Hadoop clusters using Azure HDInsight. This service provides a scalable, cost-effective, and secure environment for big data processing. By leveraging HDInsight, teams can focus on data analysis and insights without the overhead of managing infrastructure. The integration with Azure services such as Azure Datalake Storage and Azure Virtual Network ensures seamless data access and enhanced security. Additionally, HDInsight's compatibility with popular big data tools and frameworks allows for flexible and robust data processing solutions.

## Scope<a href="#scope" class="headerlink" title="Permanent link">¶</a>

This Pattern currently focuses on the hadoop cluster. Other available cluster are HDInsight spark cluster, Kafka cluster, interactive query cluster and HBase cluster.

## Use Cases<a href="#use-cases" class="headerlink" title="Permanent link">¶</a>

- LSEG Application that need to process and transform large volumes of structured or unstructured data from various sources.

<!-- -->

- Businesses required a scalable and cost-effective solution for storing and querying large datasets for business intelligence and reporting.

<!-- -->

- Application that are connected with numerous devices generated massive streams of real-time data that needed to be ingested, processed, and analyzed.

## Architectural Design<a href="#architectural-design" class="headerlink" title="Permanent link">¶</a>

The design involves deploying an HDInsight Hadoop cluster with the necessary infrastructure to support big data processing and analytics. This includes provisioning data lake storage, configuring a Virtual Network for secure communication, and setting up cluster scaling policies to optimize resource usage. The design also incorporates Azure Monitor for comprehensive monitoring and logging of cluster activities.

![Figure 1 - HDInsight cluster design](0074-hdinsight-design-pattern.assets/image-001.png)

### Key Considerations<a href="#key-considerations" class="headerlink" title="Permanent link">¶</a>

#### Azure HDInsight clusters should use encryption at host to encrypt data at rest<a href="#azure-hdinsight-clusters-should-use-encryption-at-host-to-encrypt-data-at-rest" class="headerlink" title="Permanent link">¶</a>

- Enabling encryption at host helps protect and safeguard data to meet organizational security and compliance commitments. When enabled encryption at host, data stored on the VM host is encrypted at rest and flows encrypted to the Storage service.
- Encryption at rest which needs customer managed keys (keys from keyvault) is not required for Azure HDInsight Hadoop cluster at this point. Encryption at Host is based on Platform Managed Keys and does not need a customer-deployed Azure Key Vault.

#### Private DNS zone needs to be created to enable private link connectivity to Azure services used by HDInsight cluster<a href="#private-dns-zone-needs-to-be-created-to-enable-private-link-connectivity-to-azure-services-used-by-hdinsight-cluster" class="headerlink" title="Permanent link">¶</a>

- **privatelink.azurehdinsight.net**: This allows the HDInsight cluster to connect privately (via Private Link) to HDInsight control plane endpoints (like cluster management, monitoring, and other APIs).
- **privatelink.blob.core.windows.net**: Used for private access to Azure Blob Storage, which HDInsight often uses as default storage.
- **privatelink.database.windows.net**: Enables private access to Azure SQL Database, which HDInsight can use for Hive metastore or other metadata services.
- **privatelink.dfs.core.windows.net**: Required for private access to Azure Data Lake Storage Gen2.

#### Disable network polices for private link service on Hadoop subnet<a href="#disable-network-polices-for-private-link-service-on-hadoop-subnet" class="headerlink" title="Permanent link">¶</a>

Disabling `privateEndpointNetworkPolicies` on the Hadoop subnet allows:

- The Private Endpoint to be created and function correctly.
- DNS resolution and traffic flow to the private IP of the endpoint without interference from NSG/UDR rules. Without this, HDInsight cluster wouldn’t be able to communicate with services like Blob Storage or SQL Database via Private Link.

#### Create SQL Server and databases with private endpoint<a href="#create-sql-server-and-databases-with-private-endpoint" class="headerlink" title="Permanent link">¶</a>

- SQL authentication is required as it is currently the supported method for this connection. HDInsight uses SQL authentication to connect to Azure SQL DB Hive metastore.

#### Create User-assigned managed identity and provide storage blob data owner<a href="#create-user-assigned-managed-identity-and-provide-storage-blob-data-owner" class="headerlink" title="Permanent link">¶</a>

- Azure HDInsight supports only user-assigned managed identities. HDInsight doesn't support system-assigned managed identities.
- Creating a User Assigned Managed Identity (UAMI) and assigning it the `Storage Blob Data Owner` role is a key step for secure, fine-grained access to Azure Data Lake Storage (ADLS) Gen2 from an Azure HDInsight cluster.
- The UAMI acts as the identity of the cluster to authenticate securely with ADLS — without embedding secrets or keys.
- Follow the [hdinsight-managed-identities](https://learn.microsoft.com/en-us/azure/hdinsight/hdinsight-managed-identities) for more details.

#### Add outbound FQDN's to Azure Firewall to restrict outbound traffic<a href="#add-outbound-fqdns-to-azure-firewall-to-restrict-outbound-traffic" class="headerlink" title="Permanent link">¶</a>

When outbound traffic is restricted (e.g. by using Azure Firewall, NSG, or Route Tables) to secure HDInsight cluster, some required FQDNs must be explicitly allowed. These are critical for the cluster to function because HDInsight depends on multiple Azure services and public endpoints for control plane and data plane operations. Follow the [hdinsight-restrict-outbound-traffic](https://learn.microsoft.com/en-us/azure/hdinsight/hdinsight-restrict-outbound-traffic) for more details.

### Security Controls<a href="#security-controls" class="headerlink" title="Permanent link">¶</a>

HD Insight Hadoop Cluster [security controls](https://gitlab.dx1.lseg.com/app/app-51285/cloud-security-controls/azure-clear-listing/-/blob/main/azure/services/Microsoft.HDInsight/clusters/kind/Hadoop/v2.0.0/markdown/serviceControls.md?ref_type=heads)

### Benefits of Azure HDInsights Hadoop Cluster<a href="#benefits-of-azure-hdinsights-hadoop-cluster" class="headerlink" title="Permanent link">¶</a>

- **Fully Managed Service:** Azure handled the complexities of cluster setup, configuration, patching, and monitoring, reducing operational overhead and allowing users to focus on data analysis.
- **Easy Deployment:** Clusters could be provisioned quickly without the need to install or manage hardware.
- **Scalability:** Users could easily scale the number of nodes up or down based on workload demands, optimizing costs.
- **Cost-Effectiveness:** The pay-as-you-go model allowed users to pay only for the compute resources they consumed. Decoupled storage and compute enabled independent scaling and cost optimization.
- **Integration with Azure Ecosystem:** Seamlessly integrated with other Azure services like Azure Storage (Blob and Data Lake Storage), Azure SQL Database, Azure Data Factory, and Azure Monitor, creating comprehensive data solutions.
- **Support for Open-Source Frameworks:** Provided a managed environment for popular big data frameworks like Apache Hadoop, Spark, Hive, Kafka, HBase, and others, ensuring compatibility and access to a rich ecosystem of tools and libraries.
- **Security and Compliance:** Offered enterprise-grade security features, including Azure Virtual Network integration, encryption at rest and in transit, integration with Azure Active Directory, and compliance with various industry standards.
- **Global Availability:** Available in numerous Azure regions worldwide, ensuring proximity to data and users.
- **High Availability:** Offered features like multiple head nodes and gateway nodes to minimize downtime within a region.

## Further Reading<a href="#further-reading" class="headerlink" title="Permanent link">¶</a>

[HDInsight Hadoop Cluster Security Controls](https://gitlab.dx1.lseg.com/app/app-51285/cloud-security-controls/azure-clear-listing/-/blob/main/azure/services/Microsoft.HDInsight/clusters/kind/Hadoop/v2.0.0/markdown/serviceControls.md?ref_type=heads)

<span class="md-source-file__fact"> <span class="md-icon" title="Last update"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIxIDEzLjFjLS4xIDAtLjMuMS0uNC4ybC0xIDEgMi4xIDIuMSAxLTFjLjItLjIuMi0uNiAwLS44bC0xLjMtMS4zYy0uMS0uMS0uMi0uMi0uNC0uMm0tMS45IDEuOC02LjEgNlYyM2gyLjFsNi4xLTYuMXpNMTIuNSA3djUuMmw0IDIuNC0xIDFMMTEgMTNWN3pNMTEgMjEuOWMtNS4xLS41LTktNC44LTktOS45QzIgNi41IDYuNSAyIDEyIDJjNS4zIDAgOS42IDQuMSAxMCA5LjMtLjMtLjEtLjYtLjItMS0uMnMtLjcuMS0xIC4yQzE5LjYgNy4yIDE2LjIgNCAxMiA0Yy00LjQgMC04IDMuNi04IDggMCA0LjEgMy4xIDcuNSA3LjEgNy45bC0uMS4yeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="December 17, 2025 11:12:31 UTC">December 17, 2025</span> </span> <span class="md-source-file__fact"> <span class="md-icon" title="Created"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE0LjQ3IDE1LjA4IDExIDEzVjdoMS41djUuMjVsMy4wOCAxLjgzYy0uNDEuMjgtLjc5LjYyLTEuMTEgMW0tMS4zOSA0Ljg0Yy0uMzYuMDUtLjcxLjA4LTEuMDguMDgtNC40MiAwLTgtMy41OC04LThzMy41OC04IDgtOCA4IDMuNTggOCA4YzAgLjM3LS4wMy43Mi0uMDggMS4wOC42OS4xIDEuMzMuMzIgMS45Mi42NC4xLS41Ni4xNi0xLjEzLjE2LTEuNzIgMC01LjUtNC41LTEwLTEwLTEwUzIgNi41IDIgMTJzNC40NyAxMCAxMCAxMGMuNTkgMCAxLjE2LS4wNiAxLjcyLS4xNi0uMzItLjU5LS41NC0xLjIzLS42NC0xLjkyTTE4IDE1djNoLTN2MmgzdjNoMnYtM2gzdi0yaC0zdi0zeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="May 28, 2025 11:48:59 UTC">May 28, 2025</span> </span>

<a href="../../../adrs/virtual-compute-and-containers/0009-service-mesh/" class="md-footer__link md-footer__link--prev" aria-label="Previous: If a general purpose Service Mesh is required, use Istio"></a>

<div class="md-footer__button md-icon">

![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIwIDExdjJIOGw1LjUgNS41LTEuNDIgMS40Mkw0LjE2IDEybDcuOTItNy45MkwxMy41IDUuNSA4IDExeiIgLz48L3N2Zz4=)

</div>

<div class="md-footer__title">

<span class="md-footer__direction"> Previous </span>

<div class="md-ellipsis">

If a general purpose Service Mesh is required, use Istio

</div>

</div>

<a href="../../application-hosting/0022-tenant-and-environment-selection-technical-design/" class="md-footer__link md-footer__link--next" aria-label="Next: Selection of LMP Tenant and Environment"></a>

<div class="md-footer__title">

<span class="md-footer__direction"> Next </span>

<div class="md-ellipsis">

Selection of LMP Tenant and Environment

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
