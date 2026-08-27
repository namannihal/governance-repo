---
id: LMP-PAT-0005
type: Technology Selection Pattern
status: superseded
superseded_by: LMP-PAT-0072
valid_to: 2025-07-16
approved_by:
  - LMP Migration Architecture Approval
valid_from: 2024-06-08
developer_productivity_hrs: 0
date: 2024-03-15
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

SQL Server, MySQL, PostgreSQL and Oracle (in their various forms) are all recommended targets.

## Decision Tree Diagram

As a starting point, review the *Selecting an Azure Data Store* decision tree in
the [public Azure documentation](https://learn.microsoft.com/en-us/azure/architecture/guide/technology-choices/data-store-decision-tree).
It helps delineate what is available in Azure for relational, semi-structured, time-series, graph and binary data, etc.
It is deliberately not republished here since it is likely to change more frequently than this pattern.

Combine the advice from that decision tree with the advice given
in [Data Platform Migration Approach](https://dev.azure.com/LSEGroup/Migration/_wiki/wikis/Migration.wiki/217/Data-Platform-Migration-Approach-Technical-).
Within, there is guidance for migrations for multiple scenarios including SQL Server to SQL Managed Instances,
Maria DB to Azure DB, etc. With each, detailed guidance covers seeding, synchronization, cutover, etc.

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

