---
id: LMP-PAT-0015
type: Technical Design Pattern
status: published
approved_by:
  - LMP Migration Architecture Approval
  - CTEF (LMP ARB)
valid_from: 2024-03-20
developer_productivity_hrs: 4
date: 2024-03-20
govid: GOVI0001830
govid_url: https://lseg.service-now.com/x/lsegp/cto/record/x_lsegp_eag_governance_item/ee69b90483e04e948fb91f80ceaad3a1
pattern_repo: https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvcpat/terraform/azure-prdsvcpat-terraform-rediscache
tags:
  - Database
  - Distributed Cache
  - Message Bus & Integration
tech_capabilities:
  - Platform / Data / Distributed Cache
  - Platform / Data / Database
  - Platform / Data / Data Management / Distribution & Events
  - Platform / Application / Message Bus & Integration
---

# Azure Cache for Redis Service Pattern

## Description

Azure Cache for Redis is a recommended technology for data caching and stream processing.
See [Caching Options for Azure][1] for more details.

This Service Pattern provides a templated deployment of Azure Cache for Redis including the security and networking
services required for common scenarios.

[1]: ../distributed-cache/0012-cache.md

## Pattern Value Assessment

| Value Dimension                                  | Guide                                                                                                      | Score |
|--------------------------------------------------|------------------------------------------------------------------------------------------------------------|-------|
| Frequency of re-use                              | Number of applications projected to reuse this pattern                                                     | 10    |
| Developer Productivity                           | Estimated design & dev effort saved (in hours) by adopting the pattern                                     | 24    |
| Assurance Value: Information & Data Architecture | Qualitative assessment of contribution of pattern to Information & Data Architecture standards conformance | Some  |
| Assurance Value: Security Architecture           | Qualitative assessment of contribution of pattern to Security Architecture standards conformance           | Some  |
| Assurance Value: Technology                      | Qualitative assessment of contribution of pattern to Technology standards conformance                      | Some  |

Assurance Value considers:

- Minimum Entry Criteria coverage e.g. Security Architecture MEC
- Automated assurance compatibility e.g. enforcement via Azure Policy

