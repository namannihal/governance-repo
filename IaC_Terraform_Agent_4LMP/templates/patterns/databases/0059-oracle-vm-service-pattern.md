---
id: LMP-PAT-0059
type: Technical Design Pattern
status: published
approved_by:
  - LMP Migration Architecture Approval
  - CTEF (LMP ARB)
valid_from: 2024-08-30
developer_productivity_hrs: 0
date: 2024-03-06
govid: GOVI0001940
govid_url: https://lseg.service-now.com/x/lsegp/cto/record/x_lsegp_eag_governance_item/e2c4af85c3b08a50ec253a1c05013144
pattern_repo: https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvcpat/terraform/azure-prdsvcpat-terraform-oracleonvm
tags:
  - Database
tech_capabilities:
  - Platform / Data / Database / Relational (SQL) Database
---

# Oracle on VM Service Pattern

## Description

The deployment of Oracle on Azure Virtual Machines is a recommended option for Oracle use cases meeting specific criteria.

See [Use of Oracle on Cloud][1] for more details.

This Service Pattern provides a templated deployment of Oracle on VM including the security and networking
services required for common scenarios.

See also [Caching Options for Azure][2] for guidance on technology choices for improving the
scalability and performance of an application's data layer.

[1]: 0010-oracle.md

[2]: ../distributed-cache/0012-cache.md

## Pattern Value Assessment

| Value Dimension                                  | Guide                                                                                                      | Score       |
|--------------------------------------------------|------------------------------------------------------------------------------------------------------------|-------------|
| Frequency of re-use                              | Number of applications projected to reuse this pattern                                                     | 6           |
| Developer Productivity                           | Estimated design & dev effort saved (in hours) by adopting the pattern                                     | 60          |
| Assurance Value: Information & Data Architecture | Qualitative assessment of contribution of pattern to Information & Data Architecture standards conformance | None        |
| Assurance Value: Security Architecture           | Qualitative assessment of contribution of pattern to Security Architecture standards conformance           | Some        |
| Assurance Value: Technology                      | Qualitative assessment of contribution of pattern to Technology standards conformance                      | Significant |

Assurance Value considers:

- Minimum Entry Criteria coverage e.g. Security Architecture MEC
- Automated assurance compatibility e.g. enforcement via Azure Policy

