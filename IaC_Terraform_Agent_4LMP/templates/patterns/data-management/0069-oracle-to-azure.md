---
id: LMP-PAT-0069
type: Technical Design Pattern
status: published
valid_from: 2025-07-22
date: 2025-07-03
approved_by:
  - LMP Migration Architecture Approval
tags:
  - Data Management
tech_capabilities:
  - Platform / Data / Data Management
---

# Oracle Exadata / Oracle RAC to Azure Oracle on VM Migration

## Introduction

This document provides a comprehensive hands-on guide for migrating Oracle Exadata and Oracle RAC databases to Oracle
on Azure Virtual Machines (VMs). It includes technical details, migration steps, impact analysis, and equivalent
resource mappings. The guide ensures a seamless migration experience for teams.

### Context and Problem

Organizations using Oracle Exadata or Oracle RAC may face high costs, hardware maintenance, or scalability challenges.
Moving to Azure Oracle on VM can reduce infrastructure complexity, improve scalability, and integrate with cloud-native
services. However, this migration introduces challenges in performance, failovers, and backups.

## Scope

- Migration of Oracle Exadata and Oracle RAC to Azure Oracle on VM.
- Considerations before migration
- Assessment of performance, failovers, and backup impact.
- Step-by-step migration approach.
- Mapping of equivalent Azure resources.
- Best practices and troubleshooting.

## Use Cases

- Cost Optimization – Reduce on-premises hardware and operational expenses.
- Scalability – Improve database scalability with Azure infrastructure.
- Disaster Recovery – Enhance failover and backup strategies using Azure-native services.
- Performance Optimization – Tune workloads to maintain or improve performance on Azure.

## Things to Consider Before Migration

Before migrating from Oracle Exadata / RAC to Azure Oracle on VM, certain features may not work as expected, or may
require workarounds. Below are key considerations:

| Feature                            | Oracle Exadata / RAC        | Oracle Database Appliance (ODA)   | Oracle on Azure VM                                   | Considerations                                    |
|------------------------------------|-----------------------------|-----------------------------------|------------------------------------------------------|---------------------------------------------------|
| Automatic Storage Management (ASM) | Native support              | Native support                    | Supported, available as part of oracle on VM pattern | Need to configure ASM manually                    |
| Exadata Smart Scan                 | Hardware-accelerated        | Not available                     | Not available                                        | Requires SQL tuning for performance optimization  |
| Hybrid Columnar Compression (HCC)  | Native support              | Supported for certain workloads   | Limited to Exadata                                   | Alternative compression methods needed            |
| Oracle RAC                         | Multi-node clustering       | RAC available in HA configuration | Not available                                        | Use Oracle Data Guard for HA instead              |
| Failover Mechanism                 | Automatic failover with RAC | Automatic with RAC or Data Guard  | Requires Data Guard setup                            | Need to configure manual or automatic failover    |
| High-Speed InfiniBand              | Low-latency interconnect    | Standard interconnect             | Standard Azure networking                            | Use Accelerated Networking for better performance |
| Backup & Recovery                  | Integrated Exadata backups  | RMAN, ODA Appliance Manager       | RMAN with Azure Blob Storage                         | Redesign backup strategy                          |
| Workload Performance               | Optimized for Exadata       | Optimized for appliance           | Dependent on Azure VM & storage                      | Requires performance tuning                       |

### Licensing

 If a new license is needed, Razvan Tomozei and Kate Sasenbury are the primary contacts to help assess, validate and
 approve licensing for LSEG. Licenses can be re-used, but the program must be completely removed from one server before
 the license can be transferred to another. Razvan and Kate would need to be informed of this plan so that they could
 maintain appropriate records.

Please check this [article on golden
gate](https://docs.oracle.com/en/middleware/goldengate/core/19.1/gghdb/what-is-oracle-goldengate-non-oracle-databases.html)
to confirm if this is the right product for your needs.

If this is the right product, then approver needs to know the HW details of the pair of servers, source, and target.

- Role: Source/Target
- Type:Cloud/on-premise
- Server model/VM type
- No. of vCPUs/No. of total cores(in case of on-prem)
- Hyperthreading enabled/not enabled
- Multi-AZ enabled/not enabled

[GoldenGate for Heterogeneous
Databases](https://docs.oracle.com/en/middleware/goldengate/core/19.1/gghdb/what-is-oracle-goldengate-non-oracle-databases.html)

### Performace Consideration

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

*Performace analysis is TBD for ODA

**Note:** These values may vary depending on specific configurations, workloads, and infrastructure settings.
**Source:** Based on general knowledge and typical benchmarks. Please verify with official documentation:

- [Oracle Exadata Documentation](https://docs.oracle.com/en/engineered-systems/exadata/)
- [Oracle on Azure Documentation](https://learn.microsoft.com/en-us/azure/virtual-machines/workloads/oracle/)

## Step-by-Step Migration Process

### Pre-Migration Assessment

- Identify source database (Exadata / RAC version, configurations, workload patterns).
- Determine dependencies (applications, integrations, backups, security policies).
- Estimate storage and compute requirements on Azure.
- Validate network connectivity between on-premises and Azure using ExpressRoute or VPN.

### Setup Azure Environment

- Deploy Azure Virtual Machines with Oracle Linux or supported OS.
- Configure disks and storage (Azure Managed Disks, NetApp Files, or ASM).
- Set up networking and security (NSGs, firewalls, ExpressRoute/VPN connectivity).

### Backup and Data Transfer

#### Option 1: Using RMAN (Recommended for full database migration)

- On the source database, take a full RMAN backup:

  `RMAN> BACKUP DATABASE FORMAT '/backupdir/db_%U' TAG 'EXADATA_MIGRATION';`
- Copy the backup files to Azure using AzCopy or SCP:

  `azcopy copy "/backupdir/db_*" "https://storageaccount.blob.core.windows.net/container/"`
- Restore the database on the Azure Oracle VM:

  `RMAN> RESTORE DATABASE FROM TAG 'EXADATA_MIGRATION';`

  `RMAN> RECOVER DATABASE;`
- Open the database:

  `SQL> ALTER DATABASE OPEN RESETLOGS;`

#### Option 2: Using Data Pump (For schema-level migration)

- Export the schemas from the source database:

    `expdp user/password DIRECTORY=backup_dir DUMPFILE=export.dmp LOGFILE=export.log SCHEMAS=SCOTT`
- Copy the dump file to Azure using AzCopy or SCP.
- Import the data into the Azure Oracle VM:

  `impdp user/password DIRECTORY=backup_dir DUMPFILE=export.dmp LOGFILE=import.log SCHEMAS=SCOTT`

#### Option 3: Using Oracle GoldenGate (For minimal downtime migration)

- Install GoldenGate on both source and target environments.
- Before CDC(Change Data Capture) starts, optionally copy base data, if you are migrating the existing data using:<br>

   `bashCopyEditexpdp user/pass directory=expdir dumpfile=data.dmp logfile=exp.log full=y` <br>

  `impdp user/pass directory=impdir dumpfile=data.dmp logfile=imp.log full=y`
- Before starting replication, the entire dataset is exported from the source DB to the target using:

  `ADD EXTRACT ext1, TRANLOG, BEGIN NOW`

  `ADD EXTTRAIL /ogg/dirdat/et, EXTRACT ext1`
- Configure Data Pump process to transfer data:

  `ADD EXTRACT pump1, EXTTRAILSOURCE /ogg/dirdat/et`

  `ADD RMTTRAIL /ogg/dirdat/rt, EXTRACT pump1`
- Set up the Replicat process on the target database:

  `ADD REPLICAT rep1, EXTTRAIL /ogg/dirdat/rt`
- Start the replication processes:

  `START EXTRACT ext1;`

  `START EXTRACT pump1;`

  `START REPLICAT rep1;`
- Once replication is in sync, switch over traffic to Azure Oracle VM.

**Important Note:** Oracle GoldenGate is a fully licensed, enterprise product. It is not free and requires separate
licensing per processor or per instance, depending on Oracle's pricing model.The cost can run into tens or hundreds of
thousands of dollars for large deployments. See [Oracle’s Licensing
Guide](https://docs.oracle.com/en/middleware/goldengate/core/21.3/ogglc/licensing-information.html) for exact terms.

## Troubleshooting

Common Migration Issues and Solutions

| Issue                             | Cause                                       | Solution                                                         |
|-----------------------------------|---------------------------------------------|------------------------------------------------------------------|
| Performance Degradation           | Azure VM configuration differs from Exadata | Optimize SGA/PGA, use Ultra Disks, enable Accelerated Networking |
| Data Guard Configuration Issues   | Misconfigured listener or log shipping      | Verify TNS, standby logs, and Data Guard parameters              |
| GoldenGate Replication Lag        | High network latency                        | Tune network bandwidth, optimize replication parameters          |
| Application Connectivity Failures | TNS settings incorrect                      | Verify listener and firewall rules                               |
| Backup Failures                   | Storage permission issues                   | Ensure proper Azure Blob Storage authentication                  |

## Further Reading

- [Oracle ZDM: Tool to Migrate Oracle onto Oracle
  DB@Azure](https://dev.azure.com/LSEGroup/Migration/_wiki/wikis/Migration.wiki/7569/Oracle-ZDM-Tool-to-Migrate-Oracle-onto-Oracle-DB-Azure)
- [Oracle deployment options in
  Azure](https://dev.azure.com/LSEGroup/Migration/_wiki/wikis/Migration.wiki/7477/Oracle-deployment-options-in-Azure)
- [Oracle on Azure VM - HA and
  DR](https://dev.azure.com/LSEGroup/Migration/_wiki/wikis/Migration.wiki/6801/Oracle-on-Azure-VM-HA-and-DR)
- [Oracle Assessment
  Script](https://dev.azure.com/LSEGroup/Migration/_wiki/wikis/Migration.wiki/854/Oracle-Assessment-Script)
- [Oracle Migration](https://dev.azure.com/LSEGroup/Migration/_wiki/wikis/Migration.wiki/227/Oracle-Migration)
- [Azcopy Overview](https://learn.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-v10?tabs=dnf)

