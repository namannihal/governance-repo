---
id: LMP-PAT-0016
type: Technical Design Pattern
status: published
approved_by:
  - LMP Migration Architecture Approval
  - CTEF (LMP ARB)
valid_from: 2024-08-02
developer_productivity_hrs: 2
date: 2024-08-02
govid: GOVI0002372
govid_url: https://lseg.service-now.com/x/lsegp/cto/record/x_lsegp_eag_governance_item/393f9715fb16c21873defee6beefdc9b
pattern_repo: https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvcpat/terraform/azure-prdsvcpat-terraform-mssqlmanagedinstance
tags:
  - Database
tech_capabilities:
  - Platform / Data / Database / Relational (SQL) Database
---

# Azure SQL Managed Instance Service Pattern

## Description

Azure SQL Managed Instance is a recommended technology for database use cases.
See [Azure Relational Database Selection][1] for more details.

Azure SQL Managed Instance is a PaaS service that has compatibility with the latest Enterprise Edition
SQL Server database engine, providing a native virtual network (VNet) implementation that addresses common
security concerns, and a business model favourable to existing SQL Server customers.

Azure SQL Managed Instance is commonly employed to enable a low-friction, lift-and-shift approach for the migration of
existing
SQL Server workloads to Azure PaaS.

See [Features comparison][2] for a detailed comparison with Azure SQL Database.

This Service Pattern provides a templated deployment of Azure SQL Managed Instance including the security and networking
services required for common scenarios.

See also [Caching Options for Azure][3] for guidance on technology choices for improving the
scalability and performance of an application's data layer.

[1]: 0005-relational-databases.md

[2]: https://learn.microsoft.com/en-us/azure/azure-sql/database/features-comparison?view=azuresql

[3]: ../distributed-cache/0012-cache.md

## Pattern Value Assessment

| Value Dimension                                  | Guide                                                                                                      | Score       |
|--------------------------------------------------|------------------------------------------------------------------------------------------------------------|-------------|
| Frequency of re-use                              | Number of applications projected to reuse this pattern                                                     | 5           |
| Developer Productivity                           | Estimated design & dev effort saved (in hours) by adopting the pattern                                     | 32          |
| Assurance Value: Information & Data Architecture | Qualitative assessment of contribution of pattern to Information & Data Architecture standards conformance | Some        |
| Assurance Value: Security Architecture           | Qualitative assessment of contribution of pattern to Security Architecture standards conformance           | Significant |
| Assurance Value: Technology                      | Qualitative assessment of contribution of pattern to Technology standards conformance                      | Significant |

Assurance Value considers:

- Minimum Entry Criteria coverage e.g. Security Architecture MEC
- Automated assurance compatibility e.g. enforcement via Azure Policy

