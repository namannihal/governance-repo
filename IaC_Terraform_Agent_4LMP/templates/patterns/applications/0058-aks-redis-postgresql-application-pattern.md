---
id: LMP-PAT-0058
type: Technical Design Pattern
status: published
approved_by:
  - LMP Migration Architecture Approval
  - CTEF (LMP ARB)
valid_from: 2024-08-29
developer_productivity_hrs: 0
date: 2024-03-27
govid: GOVI0002077
govid_url: https://lseg.service-now.com/x/lsegp/cto/record/x_lsegp_eag_governance_item/5c0f173ffb858e50bf71f932ceefdcf0
pattern_repo: https://gitlab.dx1.lseg.com/app/app-51310/azure/prdapppat/terraform/azure-prdapppat-terraform-akspostgresqlredis
tags:
  - Applications
tech_capabilities:
  - Platform / Application
---

# AKS+Redis+PostgreSQL Application Pattern

## Description

This Application Pattern provides integrated container management, data cache, and relational database services
meeting the requirements of a number of migration applications.

[Caching Options for Azure][1] explains the benefits of Redis vs other options for data caching.

[1]: ../distributed-cache/0012-cache.md

## Pattern Value Assessment

| Value Dimension                                  | Guide                                                                                                      | Score       |
|--------------------------------------------------|------------------------------------------------------------------------------------------------------------|-------------|
| Frequency of re-use                              | Number of applications projected to reuse this pattern                                                     | 12          |
| Developer Productivity                           | Estimated design & dev effort saved (in hours) by adopting the pattern                                     | 240         |
| Assurance Value: Information & Data Architecture | Qualitative assessment of contribution of pattern to Information & Data Architecture standards conformance | Significant |
| Assurance Value: Security Architecture           | Qualitative assessment of contribution of pattern to Security Architecture standards conformance           | Significant |
| Assurance Value: Technology                      | Qualitative assessment of contribution of pattern to Technology standards conformance                      | Significant |

Assurance Value considers:

- Minimum Entry Criteria coverage e.g. Security Architecture MEC
- Automated assurance compatibility e.g. enforcement via Azure Policy

