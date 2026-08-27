---
id: LMP-PAT-0055
type: Technical Design Pattern
status: published
approved_by:
  - LMP Migration Architecture Approval
  - CTEF (LMP ARB)
valid_from: 2024-11-13
developer_productivity_hrs: 2
date: 2024-09-09
tags:
  - Database
tech_capabilities:
  - Platform / Data / Database / NoSQL Database
govid: GOVI0002988
govid_url: https://lseg.service-now.com/x/lsegp/cto/record/x_lsegp_eag_governance_item/acd52f95832cd210743609a8beaad340
pattern_repo: https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvcpat/terraform/azure-prdsvcpat-terraform-cosmosdb
---

# Azure Cosmos DB Service Pattern

## Description

Azure Cosmos DB is a multi-model database that can support a wide range of models, including relational,
document, graph, and vector store.

This Service Pattern provides a templated deployment of Azure Cosmos DB including the security and networking
services required for common scenarios.

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

