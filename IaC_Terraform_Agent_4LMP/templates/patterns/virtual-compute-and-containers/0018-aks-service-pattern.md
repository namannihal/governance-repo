---
id: LMP-PAT-0018
type: Technical Design Pattern
status: published
approved_by:
  - CTEF (LMP ARB)
date: 2024-08-05
valid_from: 2024-08-05
developer_productivity_hrs: 4
tags:
  - Virtual Compute & Containers
tech_capabilities:
  - Infrastructure / Compute / Virtual Compute & Containers
govid: GOVI0001950
govid_url: https://lseg.service-now.com/x/lsegp/cto/record/x_lsegp_eag_governance_item/0734dd1983fcc6503408b1c8beaad361
pattern_repo: https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvcpat/terraform/azure-prdsvcpat-terraform-aks-private
---

# Azure Kubernetes Service (AKS) Service Pattern

## Description

Azure Kubernetes Service (AKS) is a recommended technology for container compute hosting use cases.
See [Container hosting to Azure][1] for more details.

This Service Pattern provides a templated deployment of AKS including the required networking, security and LSEG
Platform GitOps componentry.

[1]: 0002-containers.md

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

