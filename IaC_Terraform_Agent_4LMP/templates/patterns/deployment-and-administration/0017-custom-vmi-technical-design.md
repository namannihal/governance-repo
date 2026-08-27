---
id: LMP-PAT-0017
type: Technical Design Pattern
status: published
approved_by:
  - LMP Migration Architecture Approval
  - CTEF (LMP ARB)
valid_from: 2024-08-02
developer_productivity_hrs: 4
date: 2024-08-02
govid: GOVI0002732
govid_url: https://lseg.service-now.com/x/lsegp/cto/record/x_lsegp_eag_governance_item/b21e5229c3af8e182b2b5ccb050131c7
pattern_repo: https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvcpat/terraform/azure-prdsvcpat-terraform-customvmimage
tags:
  - Deployment & Administration
tech_capabilities:
  - Delivery / Operations / Deployment & Administration
---

# Custom VM Image for Application Service Pattern

## Description

The Custom VM Image for Application technical design provides a standardised approach to the creation
and deployment of application-specific virtual machine images.

## Pattern Value Assessment

| Value Dimension                                  | Guide                                                                                                      | Score |
|--------------------------------------------------|------------------------------------------------------------------------------------------------------------|-------|
| Frequency of re-use                              | Number of applications projected to reuse this pattern                                                     | 1     |
| Developer Productivity                           | Estimated design & dev effort saved (in hours) by adopting the pattern                                     | 24    |
| Assurance Value: Information & Data Architecture | Qualitative assessment of contribution of pattern to Information & Data Architecture standards conformance | Some  |
| Assurance Value: Security Architecture           | Qualitative assessment of contribution of pattern to Security Architecture standards conformance           | Some  |
| Assurance Value: Technology                      | Qualitative assessment of contribution of pattern to Technology standards conformance                      | None  |

Assurance Value considers:

- Minimum Entry Criteria coverage e.g. Security Architecture MEC
- Automated assurance compatibility e.g. enforcement via Azure Policy

