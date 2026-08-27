<span class="md-content__button md-icon md-status--published" href="#" title="Status: Published"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE4LjUgMmgtMTNDMy42IDIgMiAzLjYgMiA1LjV2MTNDMiAyMC40IDMuNiAyMiA1LjUgMjJIMTZsNi02VjUuNUMyMiAzLjYgMjAuNCAyIDE4LjUgMk0yMCAxNWgtMS41Yy0xLjkgMC0zLjUgMS42LTMuNSAzLjVWMjBINS44Yy0xIDAtMS44LS44LTEuOC0xLjhWNS44QzQgNC44IDQuOCA0IDUuOCA0aDEyLjVjMSAwIDEuOC44IDEuOCAxLjhWMTVtLTQuOS02LjggMS41IDEuNS02IDYtMy41LTMuNSAxLjUtMS41IDIgMnoiIC8+PC9zdmc+) </span> <span class="md-content__button md-icon .md-status--published" title="Valid from 2025-07-22"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE5IDE5SDVWOGgxNG0wLTVoLTFWMWgtMnYySDhWMUg2djJINWEyIDIgMCAwIDAtMiAydjE0YTIgMiAwIDAgMCAyIDJoMTRhMiAyIDAgMCAwIDItMlY1YTIgMiAwIDAgMC0yLTJtLTIuNDcgOC4wNkwxNS40NyAxMGwtNC44OCA0Ljg4LTIuMTItMi4xMi0xLjA2IDEuMDZMMTAuNTkgMTd6IiAvPjwvc3ZnPg==) </span> <span class="md-content__button md-icon actions-date" title="Published on 2025-07-03">![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTkgMTB2Mkg3di0yem00IDB2MmgtMnYtMnptNCAwdjJoLTJ2LTJ6bTItN2EyIDIgMCAwIDEgMiAydjE0YTIgMiAwIDAgMS0yIDJINWEyIDIgMCAwIDEtMi0yVjVhMiAyIDAgMCAxIDItMmgxVjFoMnYyaDhWMWgydjJ6bTAgMTZWOEg1djExek05IDE0djJIN3YtMnptNCAwdjJoLTJ2LTJ6bTQgMHYyaC0ydi0yeiIgLz48L3N2Zz4=)</span> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/edit/main/docs/patterns/data-management/0069-oracle-to-azure.md" class="md-content__button md-icon" title="Edit this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTEwIDIwSDZWNGg3djVoNXYzLjFsMi0yVjhsLTYtNkg2Yy0xLjEgMC0yIC45LTIgMnYxNmMwIDEuMS45IDIgMiAyaDR6bTEwLjItN2MuMSAwIC4zLjEuNC4ybDEuMyAxLjNjLjIuMi4yLjYgMCAuOGwtMSAxLTIuMS0yLjEgMS0xYy4xLS4xLjItLjIuNC0uMm0wIDMuOUwxNC4xIDIzSDEydi0yLjFsNi4xLTYuMXoiIC8+PC9zdmc+" /></a> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/blob/main/docs/patterns/data-management/0069-oracle-to-azure.md" class="md-content__button md-icon" title="View source of this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE3IDE4Yy41NiAwIDEgLjQ0IDEgMXMtLjQ0IDEtMSAxLTEtLjQ0LTEtMSAuNDQtMSAxLTFtMC0zYy0yLjczIDAtNS4wNiAxLjY2LTYgNCAuOTQgMi4zNCAzLjI3IDQgNiA0czUuMDYtMS42NiA2LTRjLS45NC0yLjM0LTMuMjctNC02LTRtMCA2LjVhMi41IDIuNSAwIDAgMS0yLjUtMi41IDIuNSAyLjUgMCAwIDEgMi41LTIuNSAyLjUgMi41IDAgMCAxIDIuNSAyLjUgMi41IDIuNSAwIDAgMS0yLjUgMi41TTkuMjcgMjBINlY0aDd2NWg1djQuMDdjLjcuMDggMS4zNi4yNSAyIC40OVY4bC02LTZINmEyIDIgMCAwIDAtMiAydjE2YTIgMiAwIDAgMCAyIDJoNC41YTguMiA4LjIgMCAwIDEtMS4yMy0yIiAvPjwvc3ZnPg==" /></a>

Document Metadata

|  |  |
|----|----|
| Identifier | **`LMP-PAT-0069`** |
| Type | **Technical Design Pattern** |
| Status | **Published** |
| Approvals | <span class="md-tag">LMP Migration Architecture Approval</span> |
| Governance Reference | **[]()** |
| Pattern Source Repo | []() |
| Published on | **July 03, 2025** |
| Valid From | **July 22, 2025** |
| Authors | <span class="md-source-file__fact"> </span> |
| Tags | <span class="md-tag">Data Management</span> |
| Technology Capabilities | <span class="md-tag">Platform / Data / Data Management</span> |

# Oracle Exadata / Oracle RAC to Azure Oracle on VM Migration<a href="#oracle-exadata-oracle-rac-to-azure-oracle-on-vm-migration" class="headerlink" title="Permanent link">¶</a>

## Introduction<a href="#introduction" class="headerlink" title="Permanent link">¶</a>

This document provides a comprehensive hands-on guide for migrating Oracle Exadata and Oracle RAC databases to Oracle on Azure Virtual Machines (VMs). It includes technical details, migration steps, impact analysis, and equivalent resource mappings. The guide ensures a seamless migration experience for teams.

### Context and Problem<a href="#context-and-problem" class="headerlink" title="Permanent link">¶</a>

Organizations using Oracle Exadata or Oracle RAC may face high costs, hardware maintenance, or scalability challenges. Moving to Azure Oracle on VM can reduce infrastructure complexity, improve scalability, and integrate with cloud-native services. However, this migration introduces challenges in performance, failovers, and backups.

## Scope<a href="#scope" class="headerlink" title="Permanent link">¶</a>

- Migration of Oracle Exadata and Oracle RAC to Azure Oracle on VM.
- Considerations before migration
- Assessment of performance, failovers, and backup impact.
- Step-by-step migration approach.
- Mapping of equivalent Azure resources.
- Best practices and troubleshooting.

## Use Cases<a href="#use-cases" class="headerlink" title="Permanent link">¶</a>

- Cost Optimization – Reduce on-premises hardware and operational expenses.
- Scalability – Improve database scalability with Azure infrastructure.
- Disaster Recovery – Enhance failover and backup strategies using Azure-native services.
- Performance Optimization – Tune workloads to maintain or improve performance on Azure.

## Things to Consider Before Migration<a href="#things-to-consider-before-migration" class="headerlink" title="Permanent link">¶</a>

Before migrating from Oracle Exadata / RAC to Azure Oracle on VM, certain features may not work as expected, or may require workarounds. Below are key considerations:

| Feature | Oracle Exadata / RAC | Oracle Database Appliance (ODA) | Oracle on Azure VM | Considerations |
|----|----|----|----|----|
| Automatic Storage Management (ASM) | Native support | Native support | Supported, available as part of oracle on VM pattern | Need to configure ASM manually |
| Exadata Smart Scan | Hardware-accelerated | Not available | Not available | Requires SQL tuning for performance optimization |
| Hybrid Columnar Compression (HCC) | Native support | Supported for certain workloads | Limited to Exadata | Alternative compression methods needed |
| Oracle RAC | Multi-node clustering | RAC available in HA configuration | Not available | Use Oracle Data Guard for HA instead |
| Failover Mechanism | Automatic failover with RAC | Automatic with RAC or Data Guard | Requires Data Guard setup | Need to configure manual or automatic failover |
| High-Speed InfiniBand | Low-latency interconnect | Standard interconnect | Standard Azure networking | Use Accelerated Networking for better performance |
| Backup & Recovery | Integrated Exadata backups | RMAN, ODA Appliance Manager | RMAN with Azure Blob Storage | Redesign backup strategy |
| Workload Performance | Optimized for Exadata | Optimized for appliance | Dependent on Azure VM & storage | Requires performance tuning |

### Licensing<a href="#licensing" class="headerlink" title="Permanent link">¶</a>

If a new license is needed, Razvan Tomozei and Kate Sasenbury are the primary contacts to help assess, validate and approve licensing for LSEG. Licenses can be re-used, but the program must be completely removed from one server before the license can be transferred to another. Razvan and Kate would need to be informed of this plan so that they could maintain appropriate records.

Please check this [article on golden gate](https://docs.oracle.com/en/middleware/goldengate/core/19.1/gghdb/what-is-oracle-goldengate-non-oracle-databases.html) to confirm if this is the right product for your needs.

If this is the right product, then approver needs to know the HW details of the pair of servers, source, and target.

- Role: Source/Target
- Type:Cloud/on-premise
- Server model/VM type
- No. of vCPUs/No. of total cores(in case of on-prem)
- Hyperthreading enabled/not enabled
- Multi-AZ enabled/not enabled

[GoldenGate for Heterogeneous Databases](https://docs.oracle.com/en/middleware/goldengate/core/19.1/gghdb/what-is-oracle-goldengate-non-oracle-databases.html)

### Performace Consideration<a href="#performace-consideration" class="headerlink" title="Permanent link">¶</a>

| Factor               | Oracle Exadata & RAC   | Oracle on Azure VM     |
|----------------------|------------------------|------------------------|
| Performance (IOPS)   | 200,000+               | 80,000-100,000         |
| Latency              | ~0.3 ms                | ~1-2 ms                |
| Throughput           | 12 GB/s                | 3-6 GB/s               |
| High Availability    | Oracle RAC, Data Guard | Pacemaker, Data Guard  |
| Failover Time        | Seconds                | Seconds to minutes     |
| Backup Strategy      | RMAN, Data Guard       | RMAN, Azure Backup     |
| Disaster Recovery    | Active Data Guard      | Azure Site Recovery    |
| Key Management (TDE) | Oracle Key Vault (OKV) | Oracle Key Vault (OKV) |

\*Performace analysis is TBD for ODA

**Note:** These values may vary depending on specific configurations, workloads, and infrastructure settings. **Source:** Based on general knowledge and typical benchmarks. Please verify with official documentation:

- [Oracle Exadata Documentation](https://docs.oracle.com/en/engineered-systems/exadata/)
- [Oracle on Azure Documentation](https://learn.microsoft.com/en-us/azure/virtual-machines/workloads/oracle/)

## Step-by-Step Migration Process<a href="#step-by-step-migration-process" class="headerlink" title="Permanent link">¶</a>

### Pre-Migration Assessment<a href="#pre-migration-assessment" class="headerlink" title="Permanent link">¶</a>

- Identify source database (Exadata / RAC version, configurations, workload patterns).
- Determine dependencies (applications, integrations, backups, security policies).
- Estimate storage and compute requirements on Azure.
- Validate network connectivity between on-premises and Azure using ExpressRoute or VPN.

### Setup Azure Environment<a href="#setup-azure-environment" class="headerlink" title="Permanent link">¶</a>

- Deploy Azure Virtual Machines with Oracle Linux or supported OS.
- Configure disks and storage (Azure Managed Disks, NetApp Files, or ASM).
- Set up networking and security (NSGs, firewalls, ExpressRoute/VPN connectivity).

### Backup and Data Transfer<a href="#backup-and-data-transfer" class="headerlink" title="Permanent link">¶</a>

#### Option 1: Using RMAN (Recommended for full database migration)<a href="#option-1-using-rman-recommended-for-full-database-migration" class="headerlink" title="Permanent link">¶</a>

- On the source database, take a full RMAN backup:

  `RMAN> BACKUP DATABASE FORMAT '/backupdir/db_%U' TAG 'EXADATA_MIGRATION';` - Copy the backup files to Azure using AzCopy or SCP:

  `azcopy copy "/backupdir/db_*" "https://storageaccount.blob.core.windows.net/container/"` - Restore the database on the Azure Oracle VM:

  `RMAN> RESTORE DATABASE FROM TAG 'EXADATA_MIGRATION';`

  `RMAN> RECOVER DATABASE;` - Open the database:

  `SQL> ALTER DATABASE OPEN RESETLOGS;`

#### Option 2: Using Data Pump (For schema-level migration)<a href="#option-2-using-data-pump-for-schema-level-migration" class="headerlink" title="Permanent link">¶</a>

- Export the schemas from the source database:

  `expdp user/password DIRECTORY=backup_dir DUMPFILE=export.dmp LOGFILE=export.log SCHEMAS=SCOTT` - Copy the dump file to Azure using AzCopy or SCP. - Import the data into the Azure Oracle VM:

  `impdp user/password DIRECTORY=backup_dir DUMPFILE=export.dmp LOGFILE=import.log SCHEMAS=SCOTT`

#### Option 3: Using Oracle GoldenGate (For minimal downtime migration)<a href="#option-3-using-oracle-goldengate-for-minimal-downtime-migration" class="headerlink" title="Permanent link">¶</a>

- Install GoldenGate on both source and target environments.

- Before CDC(Change Data Capture) starts, optionally copy base data, if you are migrating the existing data using:  

  `bashCopyEditexpdp user/pass directory=expdir dumpfile=data.dmp logfile=exp.log full=y`  

  `impdp user/pass directory=impdir dumpfile=data.dmp logfile=imp.log full=y` - Before starting replication, the entire dataset is exported from the source DB to the target using:

  `ADD EXTRACT ext1, TRANLOG, BEGIN NOW`

  `ADD EXTTRAIL /ogg/dirdat/et, EXTRACT ext1` - Configure Data Pump process to transfer data:

  `ADD EXTRACT pump1, EXTTRAILSOURCE /ogg/dirdat/et`

  `ADD RMTTRAIL /ogg/dirdat/rt, EXTRACT pump1` - Set up the Replicat process on the target database:

  `ADD REPLICAT rep1, EXTTRAIL /ogg/dirdat/rt` - Start the replication processes:

  `START EXTRACT ext1;`

  `START EXTRACT pump1;`

  `START REPLICAT rep1;` - Once replication is in sync, switch over traffic to Azure Oracle VM.

**Important Note:** Oracle GoldenGate is a fully licensed, enterprise product. It is not free and requires separate licensing per processor or per instance, depending on Oracle's pricing model.The cost can run into tens or hundreds of thousands of dollars for large deployments. See [Oracle’s Licensing Guide](https://docs.oracle.com/en/middleware/goldengate/core/21.3/ogglc/licensing-information.html) for exact terms.

## Troubleshooting<a href="#troubleshooting" class="headerlink" title="Permanent link">¶</a>

Common Migration Issues and Solutions

| Issue | Cause | Solution |
|----|----|----|
| Performance Degradation | Azure VM configuration differs from Exadata | Optimize SGA/PGA, use Ultra Disks, enable Accelerated Networking |
| Data Guard Configuration Issues | Misconfigured listener or log shipping | Verify TNS, standby logs, and Data Guard parameters |
| GoldenGate Replication Lag | High network latency | Tune network bandwidth, optimize replication parameters |
| Application Connectivity Failures | TNS settings incorrect | Verify listener and firewall rules |
| Backup Failures | Storage permission issues | Ensure proper Azure Blob Storage authentication |

## Further Reading<a href="#further-reading" class="headerlink" title="Permanent link">¶</a>

- [Oracle ZDM: Tool to Migrate Oracle onto Oracle DB@Azure](https://dev.azure.com/LSEGroup/Migration/_wiki/wikis/Migration.wiki/7569/Oracle-ZDM-Tool-to-Migrate-Oracle-onto-Oracle-DB-Azure)
- [Oracle deployment options in Azure](https://dev.azure.com/LSEGroup/Migration/_wiki/wikis/Migration.wiki/7477/Oracle-deployment-options-in-Azure)
- [Oracle on Azure VM - HA and DR](https://dev.azure.com/LSEGroup/Migration/_wiki/wikis/Migration.wiki/6801/Oracle-on-Azure-VM-HA-and-DR)
- [Oracle Assessment Script](https://dev.azure.com/LSEGroup/Migration/_wiki/wikis/Migration.wiki/854/Oracle-Assessment-Script)
- [Oracle Migration](https://dev.azure.com/LSEGroup/Migration/_wiki/wikis/Migration.wiki/227/Oracle-Migration)
- [Azcopy Overview](https://learn.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-v10?tabs=dnf)

<span class="md-source-file__fact"> <span class="md-icon" title="Last update"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIxIDEzLjFjLS4xIDAtLjMuMS0uNC4ybC0xIDEgMi4xIDIuMSAxLTFjLjItLjIuMi0uNiAwLS44bC0xLjMtMS4zYy0uMS0uMS0uMi0uMi0uNC0uMm0tMS45IDEuOC02LjEgNlYyM2gyLjFsNi4xLTYuMXpNMTIuNSA3djUuMmw0IDIuNC0xIDFMMTEgMTNWN3pNMTEgMjEuOWMtNS4xLS41LTktNC44LTktOS45QzIgNi41IDYuNSAyIDEyIDJjNS4zIDAgOS42IDQuMSAxMCA5LjMtLjMtLjEtLjYtLjItMS0uMnMtLjcuMS0xIC4yQzE5LjYgNy4yIDE2LjIgNCAxMiA0Yy00LjQgMC04IDMuNi04IDggMCA0LjEgMy4xIDcuNSA3LjEgNy45bC0uMS4yeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="November 24, 2025 13:53:22 UTC">November 24, 2025</span> </span> <span class="md-source-file__fact"> <span class="md-icon" title="Created"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE0LjQ3IDE1LjA4IDExIDEzVjdoMS41djUuMjVsMy4wOCAxLjgzYy0uNDEuMjgtLjc5LjYyLTEuMTEgMW0tMS4zOSA0Ljg0Yy0uMzYuMDUtLjcxLjA4LTEuMDguMDgtNC40MiAwLTgtMy41OC04LThzMy41OC04IDgtOCA4IDMuNTggOCA4YzAgLjM3LS4wMy43Mi0uMDggMS4wOC42OS4xIDEuMzMuMzIgMS45Mi42NC4xLS41Ni4xNi0xLjEzLjE2LTEuNzIgMC01LjUtNC41LTEwLTEwLTEwUzIgNi41IDIgMTJzNC40NyAxMCAxMCAxMGMuNTkgMCAxLjE2LS4wNiAxLjcyLS4xNi0uMzItLjU5LS41NC0xLjIzLS42NC0xLjkyTTE4IDE1djNoLTN2MmgzdjNoMnYtM2gzdi0yaC0zdi0zeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="June 23, 2025 14:35:39 UTC">June 23, 2025</span> </span>

<a href="../0068-aws-to-azure/" class="md-footer__link md-footer__link--prev" aria-label="Previous: AWS to Azure Data Migration"></a>

<div class="md-footer__button md-icon">

![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIwIDExdjJIOGw1LjUgNS41LTEuNDIgMS40Mkw0LjE2IDEybDcuOTItNy45MkwxMy41IDUuNSA4IDExeiIgLz48L3N2Zz4=)

</div>

<div class="md-footer__title">

<span class="md-footer__direction"> Previous </span>

<div class="md-ellipsis">

AWS to Azure Data Migration

</div>

</div>

<a href="../0076-Mysqlmigration/" class="md-footer__link md-footer__link--next" aria-label="Next: AWS MySQL to Azure MySQL Database Migration"></a>

<div class="md-footer__title">

<span class="md-footer__direction"> Next </span>

<div class="md-ellipsis">

AWS MySQL to Azure MySQL Database Migration

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
