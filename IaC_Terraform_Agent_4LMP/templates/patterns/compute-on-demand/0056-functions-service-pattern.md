---
id: LMP-PAT-0056
type: Technical Design Pattern
status: published
approved_by:
  - LMP Migration Architecture Approval
  - CTEF (LMP ARB)
valid_from: 2024-11-13
developer_productivity_hrs: 4
date: 2024-09-09
tags:
  - Compute on Demand
tech_capabilities:
  - Infrastructure / Compute / Compute on Demand
govid: GOVI0002988
govid_url: https://lseg.service-now.com/x/lsegp/cto/record/x_lsegp_eag_governance_item/acd52f95832cd210743609a8beaad340
pattern_repo: https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvcpat/terraform/azure-prdsvcpat-terraform-cosmosdb
---

# Azure Functions Service Pattern

## Description

Azure Functions is a serverless compute service that allows you to run event-triggered code without having to explicitly
provision or manage infrastructure.

See the [Functions-as-a-Service (FaaS) Technology Selection Pattern][1] for further details.

[1]: ../compute-on-demand/0001-functions-as-a-service.md

## Pattern Value Assessment

| Value Dimension                                  | Guide                                                                                                      | Score       |
|--------------------------------------------------|------------------------------------------------------------------------------------------------------------|-------------|
| Frequency of re-use                              | Number of applications projected to reuse this pattern                                                     | 2           |
| Developer Productivity                           | Estimated design & dev effort saved (in hours) by adopting the pattern                                     | 24          |
| Assurance Value: Information & Data Architecture | Qualitative assessment of contribution of pattern to Information & Data Architecture standards conformance | Some        |
| Assurance Value: Security Architecture           | Qualitative assessment of contribution of pattern to Security Architecture standards conformance           | Significant |
| Assurance Value: Technology                      | Qualitative assessment of contribution of pattern to Technology standards conformance                      | Significant |

Assurance Value considers:

- Minimum Entry Criteria coverage e.g. Security Architecture MEC
- Automated assurance compatibility e.g. enforcement via Azure Policy

