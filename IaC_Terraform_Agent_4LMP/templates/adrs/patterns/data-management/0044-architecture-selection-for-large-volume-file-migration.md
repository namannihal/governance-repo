<span class="md-content__button md-icon md-status--published" href="#" title="Status: Published"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE4LjUgMmgtMTNDMy42IDIgMiAzLjYgMiA1LjV2MTNDMiAyMC40IDMuNiAyMiA1LjUgMjJIMTZsNi02VjUuNUMyMiAzLjYgMjAuNCAyIDE4LjUgMk0yMCAxNWgtMS41Yy0xLjkgMC0zLjUgMS42LTMuNSAzLjVWMjBINS44Yy0xIDAtMS44LS44LTEuOC0xLjhWNS44QzQgNC44IDQuOCA0IDUuOCA0aDEyLjVjMSAwIDEuOC44IDEuOCAxLjhWMTVtLTQuOS02LjggMS41IDEuNS02IDYtMy41LTMuNSAxLjUtMS41IDIgMnoiIC8+PC9zdmc+) </span> <span class="md-content__button md-icon .md-status--published" title="Valid from 2024-12-12"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE5IDE5SDVWOGgxNG0wLTVoLTFWMWgtMnYySDhWMUg2djJINWEyIDIgMCAwIDAtMiAydjE0YTIgMiAwIDAgMCAyIDJoMTRhMiAyIDAgMCAwIDItMlY1YTIgMiAwIDAgMC0yLTJtLTIuNDcgOC4wNkwxNS40NyAxMGwtNC44OCA0Ljg4LTIuMTItMi4xMi0xLjA2IDEuMDZMMTAuNTkgMTd6IiAvPjwvc3ZnPg==) </span> <span class="md-content__button md-icon actions-date" title="Published on 2024-12-12">![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTkgMTB2Mkg3di0yem00IDB2MmgtMnYtMnptNCAwdjJoLTJ2LTJ6bTItN2EyIDIgMCAwIDEgMiAydjE0YTIgMiAwIDAgMS0yIDJINWEyIDIgMCAwIDEtMi0yVjVhMiAyIDAgMCAxIDItMmgxVjFoMnYyaDhWMWgydjJ6bTAgMTZWOEg1djExek05IDE0djJIN3YtMnptNCAwdjJoLTJ2LTJ6bTQgMHYyaC0ydi0yeiIgLz48L3N2Zz4=)</span> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/edit/main/docs/patterns/data-management/0044-architecture-selection-for-large-volume-file-migration.md" class="md-content__button md-icon" title="Edit this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTEwIDIwSDZWNGg3djVoNXYzLjFsMi0yVjhsLTYtNkg2Yy0xLjEgMC0yIC45LTIgMnYxNmMwIDEuMS45IDIgMiAyaDR6bTEwLjItN2MuMSAwIC4zLjEuNC4ybDEuMyAxLjNjLjIuMi4yLjYgMCAuOGwtMSAxLTIuMS0yLjEgMS0xYy4xLS4xLjItLjIuNC0uMm0wIDMuOUwxNC4xIDIzSDEydi0yLjFsNi4xLTYuMXoiIC8+PC9zdmc+" /></a> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/blob/main/docs/patterns/data-management/0044-architecture-selection-for-large-volume-file-migration.md" class="md-content__button md-icon" title="View source of this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE3IDE4Yy41NiAwIDEgLjQ0IDEgMXMtLjQ0IDEtMSAxLTEtLjQ0LTEtMSAuNDQtMSAxLTFtMC0zYy0yLjczIDAtNS4wNiAxLjY2LTYgNCAuOTQgMi4zNCAzLjI3IDQgNiA0czUuMDYtMS42NiA2LTRjLS45NC0yLjM0LTMuMjctNC02LTRtMCA2LjVhMi41IDIuNSAwIDAgMS0yLjUtMi41IDIuNSAyLjUgMCAwIDEgMi41LTIuNSAyLjUgMi41IDAgMCAxIDIuNSAyLjUgMi41IDIuNSAwIDAgMS0yLjUgMi41TTkuMjcgMjBINlY0aDd2NWg1djQuMDdjLjcuMDggMS4zNi4yNSAyIC40OVY4bC02LTZINmEyIDIgMCAwIDAtMiAydjE2YTIgMiAwIDAgMCAyIDJoNC41YTguMiA4LjIgMCAwIDEtMS4yMy0yIiAvPjwvc3ZnPg==" /></a>

Document Metadata

|  |  |
|----|----|
| Identifier | **`LMP-PAT-0044`** |
| Type | **Technology Selection Pattern** |
| Status | **Published** |
| Approvals | <span class="md-tag">LMP Migration Architecture Approval</span> |
| Published on | **December 12, 2024** |
| Valid From | **December 12, 2024** |
| Authors | <span class="md-source-file__fact"> </span> |
| Tags | <span class="md-tag">Data Management</span> |
| Technology Capabilities | <span class="md-tag">Platform / Data / Data Management</span> |

# Architectural Selection for Large Volume File Migration from On-Premises to Azure<a href="#architectural-selection-for-large-volume-file-migration-from-on-premises-to-azure" class="headerlink" title="Permanent link">¶</a>

## Context and Problem<a href="#context-and-problem" class="headerlink" title="Permanent link">¶</a>

Many migration projects need to copy large (e.g. size between 10GB to 10+TB) or extra large (larger than tens of TB) file sets from on-prem to Azure storage destinations, before they can cut over to the new Azure-based workload. The following scenarios are frequently observed:

- Historical files ingested from 3<sup>rd</sup> party files. They need to be available for future data curation/aggregation process and workflows.
- Historical files generated in respond to customer requests, stored in a form ready to be distributed to customers upon requests.
- Database dumps which represent a snapshot of database contents.

Such scenarios are typically single-way, one-off file copy operations rather than regular and continuous BAU workloads. There are a few choices from Azure that could be used for the data transfer solution:

- Network-based data transfer mechanisms: - Scripted transfer via intermediate compute node, e.g. Azure VM + NFS Mount + AzCopy, etc.. - Managed data pipeline, e.g. Azure Data Factory. - Other migration options for niche use cases (i.e. other solutions mentioned in ['Choose an Azure solution for data transfer'](https://learn.microsoft.com/en-us/azure/storage/common/storage-choose-data-transfer-solution)) from Azure Blob Storage Documentation.
- Offline disk transfer (e.g. [Azure Databox](https://learn.microsoft.com/en-us/azure/databox/)).

Engineering teams need determine the technology choice from these options, and need balance the potential contentions among the below factors:

- Network and Hardware capacity.
- Acceptable duration of the file migration.
- Projected duration for the migration.
- Risks to other mission-critical workloads relying on the shared infrastructures.

## Scope<a href="#scope" class="headerlink" title="Permanent link">¶</a>

This pattern is designed to help engineering teams determine the suitable architecture in consistent ways for the fore-mentioned file migration scenarios. It will cover key considerations required for the decision-making process, guidance for estimating network transfer durations, and pointers to other Reference Architecture patterns for secure and consistent design.

## Out-of-scope<a href="#out-of-scope" class="headerlink" title="Permanent link">¶</a>

This pattern will not specify architecture design for each recommended file migration pattern. They will be covered by separate patterns over time, and links will be included when they are ready.

## Solution<a href="#solution" class="headerlink" title="Permanent link">¶</a>

### High Level Triage<a href="#high-level-triage" class="headerlink" title="Permanent link">¶</a>

It's sensible to triage your migration architecture before diving into this pattern. Please consider the below questions:

#### 1. Network or Offline Migration?<a href="#1-network-or-offline-migration" class="headerlink" title="Permanent link">¶</a>

**PREREQUISITE TO ANY NETWORK-BASED DATA MIGRATION:** Please work with both Data Center and Cloud Network team to understand the available bandwidth, and agree the migration window and allowable bandwidth for your file migration.

If the total volume is larger than **10 TB**, network-based file transfer will likely take days or weeks **if you can only preserve less than 1Gbps bandwidth, even if you are approved to use the bandwidth for the entire migration window**. In such case, you may want consult LMP Architecture team for high level triage, to see if special arrangement for premium bandwidth or offline / physical transfer via Databox are required.

Note: the below table from Microsoft (<https://learn.microsoft.com/en-us/azure/storage/common/storage-solution-large-dataset-low-network>) can help understand how long your migration is likely to take.

**Remember they are theoretical numbers under perfect situations.**

![Network or Offline Transfer](0044-architecture-selection-for-large-volume-file-migration.assets/image-001.png)

#### 2. BAU Business Process or Ad-hoc Operation?<a href="#2-bau-business-process-or-ad-hoc-operation" class="headerlink" title="Permanent link">¶</a>

If your data migration is part of a regular BAU process, this pattern may not solve your problem, as it doesn't cover additional requirements (e.g. operational resilience) and it relies on pre-approved, one-off migration window and allowable bandwidth rather than something you can use regularly.

### Detailed Analysis<a href="#detailed-analysis" class="headerlink" title="Permanent link">¶</a>

Before you start designing the solution, the below information should be gathered and analyzed in order to determine the most appropriate architecture:

1.  Do you need to apply ETL to any of the file contents during the migration?
2.  What are your source data center location and your target Azure region?
3.  What's the approved connectivity type and bandwidth for network-based network migration, between your DC and target Azure region?
4.  What's the approved file migration window? What's your desired target migration duration?
5.  File set characteristics: 1. Are there active modifications to existing files in the file set? 2. What's the total volume, rough number of files, average size? 3. Will there have source file changes during the migration? What's the speed of file changes if they can't be stopped during the migration?

If network-based transfer is preferred following high level triage, use the below decision diagram to determine the suggested solutions:

![Decision Tree for Migration Solution](0044-architecture-selection-for-large-volume-file-migration.assets/image-001.png)

### Test and Simulate Network-based Migration<a href="#test-and-simulate-network-based-migration" class="headerlink" title="Permanent link">¶</a>

#### Cloud Connectivity<a href="#cloud-connectivity" class="headerlink" title="Permanent link">¶</a>

- ExpressRoute Direct are available among on-prem Data Center and Azure Cloud Regions. The maximum available bandwidth depends on the source data center and your target cloud region, and the bandwidth are always shared by all subscriptions and across PROD and non-PROD environments, so you can't assume you can always use the maximum bandwidth available.
- At the time of writing, migrating data over internet is being accessed and we may update the pattern when the solution is approved.

#### Bandwidth and Testing<a href="#bandwidth-and-testing" class="headerlink" title="Permanent link">¶</a>

As suggested by Network Architecture team, the following components will affect your available bandwidth. These need to be considered in conjunction with approved bandwidth and time window for your data migration operation.

##### Factors May Affect Bandwidth<a href="#factors-may-affect-bandwidth" class="headerlink" title="Permanent link">¶</a>

- Source factors: - Limiting factors for the local data center (DC): local data store configuration, local VM, local ports on physical servers, switches, routers, etc., including peak hours on local hardware.
- Pipe factors: - Network connectivity between the local DC and the specific Azure region (10Gb or 100Gb), including peak hours on this link. - Azure Firewall SKU for the specific subscription. By default, it's the Standard SKU with a 2Gbps limit per subscription.
- Destination factors: - Various Azure SKUs have different limiting factors. For example, for Azure VMs - VM size & family (ranging from 1Gbps to 40Gbps, or even 100Gbps) - VM disk subsystems
- Traffic Control factors: i.e. any throttling or other policies enforced on the network or other hardware.

**Summary:** Actual bandwidth between your source and destination is determined by the most restrictive factors mentioned above. You may need conduct testing and simulation to better project your actual migration duration.

##### Test and Simulate Your Migration<a href="#test-and-simulate-your-migration" class="headerlink" title="Permanent link">¶</a>

Given the factors listed above, you may want test and verify the actual bandwidth and throughput as highlighted in the below diagram. The recommended architecture for network-based file transfer is explained as below:

##### Summary<a href="#summary" class="headerlink" title="Permanent link">¶</a>

- **Architecture:** Host your migration workload on Azure (pull files from on-prem). Provision or reuse on-prem VM to mount your on-prem file volumes and for Azure-based workloads to read files from.
- **Connectivity:** Leverage ExpressRoute Direct between your data center and cloud region, understand your approved maximum allowable network bandwidth and migration (or testing) window. Host your Azure migration workload in non-routable vNET and access your storage account via Private Endpoints.
- **Housekeeping**: Destroy your VMs used for the testing when no longer needed.

![Test the actual throughput](0044-architecture-selection-for-large-volume-file-migration.assets/image-001.png)

The actual throughput will also be affected by additional compute overhead, e.g. those occurring from your migration scripts. You may want to design test cases to simulate your actual migration workload to fine tune your solutions.

**Please remember the networks and other infrastructure hardware are shared by many services across production and non-production environments, so you MUST strictly follow approved time window and allowed bandwidth for your testing.**

## Further Reading<a href="#further-reading" class="headerlink" title="Permanent link">¶</a>

1.  [LMP-PAT-0045](https://app.pages.dx1.lseg.com/app-51723/migration-patterns/mig-pat-source-to-target/patterns/data-management/0045-azcopy-for-large-volume-file-migration-from-onprem-to-azure/): Using Azure AzCopy for Large Volume File Migration from On-Premises to Azure
2.  [Choose an Azure solution for data transfer](https://learn.microsoft.com/en-us/azure/storage/common/storage-solution-large-dataset-low-network)
3.  [Azure Databox Offline Transfer](https://learn.microsoft.com/en-us/azure/databox/)

<span class="md-source-file__fact"> <span class="md-icon" title="Last update"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIxIDEzLjFjLS4xIDAtLjMuMS0uNC4ybC0xIDEgMi4xIDIuMSAxLTFjLjItLjIuMi0uNiAwLS44bC0xLjMtMS4zYy0uMS0uMS0uMi0uMi0uNC0uMm0tMS45IDEuOC02LjEgNlYyM2gyLjFsNi4xLTYuMXpNMTIuNSA3djUuMmw0IDIuNC0xIDFMMTEgMTNWN3pNMTEgMjEuOWMtNS4xLS41LTktNC44LTktOS45QzIgNi41IDYuNSAyIDEyIDJjNS4zIDAgOS42IDQuMSAxMCA5LjMtLjMtLjEtLjYtLjItMS0uMnMtLjcuMS0xIC4yQzE5LjYgNy4yIDE2LjIgNCAxMiA0Yy00LjQgMC04IDMuNi04IDggMCA0LjEgMy4xIDcuNSA3LjEgNy45bC0uMS4yeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="May 30, 2025 16:15:49 UTC">May 30, 2025</span> </span> <span class="md-source-file__fact"> <span class="md-icon" title="Created"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE0LjQ3IDE1LjA4IDExIDEzVjdoMS41djUuMjVsMy4wOCAxLjgzYy0uNDEuMjgtLjc5LjYyLTEuMTEgMW0tMS4zOSA0Ljg0Yy0uMzYuMDUtLjcxLjA4LTEuMDguMDgtNC40MiAwLTgtMy41OC04LThzMy41OC04IDgtOCA4IDMuNTggOCA4YzAgLjM3LS4wMy43Mi0uMDggMS4wOC42OS4xIDEuMzMuMzIgMS45Mi42NC4xLS41Ni4xNi0xLjEzLjE2LTEuNzIgMC01LjUtNC41LTEwLTEwLTEwUzIgNi41IDIgMTJzNC40NyAxMCAxMCAxMGMuNTkgMCAxLjE2LS4wNiAxLjcyLS4xNi0uMzItLjU5LS41NC0xLjIzLS42NC0xLjkyTTE4IDE1djNoLTN2MmgzdjNoMnYtM2gzdi0yaC0zdi0zeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="November 25, 2024 10:02:15 UTC">November 25, 2024</span> </span>

<a href="../0036-daas-consumption-pattern/" class="md-footer__link md-footer__link--prev" aria-label="Previous: Data-as-a-Service Consumption Pattern"></a>

<div class="md-footer__button md-icon">

![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIwIDExdjJIOGw1LjUgNS41LTEuNDIgMS40Mkw0LjE2IDEybDcuOTItNy45MkwxMy41IDUuNSA4IDExeiIgLz48L3N2Zz4=)

</div>

<div class="md-footer__title">

<span class="md-footer__direction"> Previous </span>

<div class="md-ellipsis">

Data-as-a-Service Consumption Pattern

</div>

</div>

<a href="../0045-azcopy-for-large-volume-file-migration-from-onprem-to-azure/" class="md-footer__link md-footer__link--next" aria-label="Next: Using Azure AzCopy for Large Volume File Migration from On-Premises to Azure"></a>

<div class="md-footer__title">

<span class="md-footer__direction"> Next </span>

<div class="md-ellipsis">

Using Azure AzCopy for Large Volume File Migration from On-Premises to Azure

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
