---
id: LMP-PAT-0072
type: Technology Selection Pattern
status: superseded
superseded_by: LMP-PAT-0077
developer_productivity_hrs: 0
date: 2025-07-16
valid_to: 2026-02-26
tags:
  - Database
tech_capabilities:
  - Platform / Data / Database / Relational (SQL) Database
---

# Azure Relational Database Selection

## Compatibility

This advice pertains to the choice of database target in Azure, driven by public Microsoft Azure documentation and
internally produced LMP guidance.

## Recommended Target

SQL Server, MySQL, PostgreSQL, Oracle (in their various forms) are all recommended targets.

## Decision Tree Diagram

As a starting point, review the *Selecting an Azure Data Store* decision tree in
the [public Azure documentation](https://learn.microsoft.com/en-us/azure/architecture/guide/technology-choices/data-store-decision-tree).
It helps delineate what is available in Azure for relational, semi-structured, time-series, graph and binary data, etc.
It is deliberately not republished here since it is likely to change more frequently than this pattern.

Combine the advice from that decision tree with the advice given
in [Data Platform Migration Approach](https://dev.azure.com/LSEGroup/Migration/_wiki/wikis/Migration.wiki/217/Data-Platform-Migration-Approach-Technical-).
Within, there is guidance for migrations for multiple scenarios including SQL Server to SQL Managed Instances,
Maria DB to Azure DB, etc. With each, detailed guidance covers seeding, synchronization, cutover, etc.

## Sybase (SAP ASE) Migration Recommendation

With SAP's announcement of the end of mainstream maintenance for SAP ASE by 2025,
all Sybase (SAP ASE) databases should be migrated to Azure-native relational
database services. The recommended targets are:

- **Azure SQL Database (Platform-as-a-Service)**
- **Azure SQL Managed Instance**

This migration ensures continued support, enhanced scalability, and access
to modern cloud capabilities. Migrating to Azure SQL services is the strategic
direction for all Sybase workloads.

For detailed migration steps and considerations, refer to
the [Sybase Migration Guidance](https://dev.azure.com/LSEGroup/Migration/_wiki/wikis/Migration.wiki/239/Sybase-Migration).

## Considerations

- **Alternative Technology**: As per the general LMP approach, general strategy is to prefer Azure native technology
  where possible and where appropriate to the use case. The referenced guidance covers these scenarios in depth. If
  alternatives
  are needed for specific architectural challenges, they would be treated as exceptional. As and when exceptions crop
  up,
  and where merited, they will be added to this pattern.

## Further Reading

- [Database Strategy](https://lsegroup.sharepoint.com/:w:/r/teams/TechnologyStrategy-Private/Shared%20Documents/Private/2024/Oracle%20Strategy/Q1%202024%20Database%20Strategy%20Update%20-%20v0.6.docx?d=wce03b502f7784d0fba545bc29d9bcc57&csf=1&web=1&e=eLvRf1&isSPOFile=1)
- [Oracle Strategy - D&A Tech Decision Tree](https://lsegroup-my.sharepoint.com/:w:/g/personal/oli_bage_lseg_com/EUP-w7euY4ZIt1YvglQIL5wBTGQJPQT04WIUVtKa9xjOWQ?e=kM3v7d)

## Flowchart: Supported Sybase Versions to Azure SQL

This flowchart provides a concise visual representation of the Sybase
ASE versions generally supported for migration to Azure SQL Database and
Azure SQL Managed Instance.

![Sybase to Azure SQL Compatibility Flowchart](img/sybase_azure_sql_compatibility_flowchart.png)

