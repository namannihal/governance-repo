---
id: LMP-PAT-0014
type: Technical Design Pattern
status: published
approved_by:
  - LMP Migration Architecture Approval
  - CTEF (LMP ARB)
valid_from: 2024-03-20
developer_productivity_hrs: 4
date: 2024-03-20
tags:
  - Database
tech_capabilities:
  - Platform / Data / Database / Relational (SQL) Database
  - Platform / Data / Database / NoSQL Database
  - Platform / Data / Database / Unstructured Datastore
govid: GOVI0001919
govid_url: https://lseg.service-now.com/x/lsegp/cto/record/x_lsegp_eag_governance_item/9756c217c3a04610ad0b3e1c05013138
pattern_repo: https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvcpat/terraform/azure-prdsvcpat-terraform-postgresql
---

# Azure Database for PostgreSQL Service Pattern

## Description

Azure Database for PostgreSQL is a recommended technology for database use cases.
See [Azure Relational Database Selection][1] for more details.

This Service Pattern provides a templated deployment of Azure Database for PostgreSQL including the security and
networking
services required for common scenarios.

See also [Caching Options for Azure][2] for guidance on technology choices for improving the
scalability and performance of an application's data layer.

[1]: 0005-relational-databases.md

[2]: ../distributed-cache/0012-cache.md

## Pattern Value Assessment

| Value Dimension                                  | Guide                                                                                                      | Score |
|--------------------------------------------------|------------------------------------------------------------------------------------------------------------|-------|
| Frequency of re-use                              | Number of applications projected to reuse this pattern                                                     | 4     |
| Developer Productivity                           | Estimated design & dev effort saved (in hours) by adopting the pattern                                     | 24    |
| Assurance Value: Information & Data Architecture | Qualitative assessment of contribution of pattern to Information & Data Architecture standards conformance | Some  |
| Assurance Value: Security Architecture           | Qualitative assessment of contribution of pattern to Security Architecture standards conformance           | Some  |
| Assurance Value: Technology                      | Qualitative assessment of contribution of pattern to Technology standards conformance                      | Some  |

Assurance Value considers:

- Minimum Entry Criteria coverage e.g. Security Architecture MEC
- Automated assurance compatibility e.g. enforcement via Azure Policy

