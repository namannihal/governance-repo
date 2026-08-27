---
id: LMP-PAT-0057
type: Technical Design Pattern
status: published
approved_by:
  - LMP Migration Architecture Approval
  - CTEF (LMP ARB)
valid_from: 2024-11-07
developer_productivity_hrs: 2
date: 2024-09-11
tags:
  - Database
tech_capabilities:
  - Platform / Data / Database / Relational (SQL) Database
govid: GOVI0003000
govid_url: https://lseg.service-now.com/x/lsegp/cto/record/x_lsegp_eag_governance_item/fda2f88ec3e456907e94991c0501315b
pattern_repo: https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvcpat/terraform/azure-prdsvcpat-terraform-terraform-mysqlflexibleserver
---

# Azure Database for MySQL - Flexible Server Service Pattern

## Description

Azure Database for MySQL is a relational database service powered by the MySQL community edition.
The Flexible Server option provides a fully managed database service designed to offer granular control
and flexibility over database management functions and configuration settings.

This Service Pattern provides a templated deployment of Azure Database for MySQL - Flexible Server
including the security and networking services required for common scenarios.

See also [Caching Options for Azure][1] for guidance on technology choices for improving the
scalability and performance of an application's data layer.

[1]: ../distributed-cache/0012-cache.md

## Pattern Value Assessment

| Value Dimension                                  | Guide                                                                                                      | Score       |
|--------------------------------------------------|------------------------------------------------------------------------------------------------------------|-------------|
| Frequency of re-use                              | Number of applications projected to reuse this pattern                                                     | 2           |
| Developer Productivity                           | Estimated design & dev effort saved (in hours) by adopting the pattern                                     | 32          |
| Assurance Value: Information & Data Architecture | Qualitative assessment of contribution of pattern to Information & Data Architecture standards conformance | Some        |
| Assurance Value: Security Architecture           | Qualitative assessment of contribution of pattern to Security Architecture standards conformance           | Significant |
| Assurance Value: Technology                      | Qualitative assessment of contribution of pattern to Technology standards conformance                      | Significant |

Assurance Value considers:

- Minimum Entry Criteria coverage e.g. Security Architecture MEC
- Automated assurance compatibility e.g. enforcement via Azure Policy

