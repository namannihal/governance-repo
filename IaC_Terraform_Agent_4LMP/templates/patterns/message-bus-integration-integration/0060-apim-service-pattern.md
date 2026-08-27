---
id: LMP-PAT-0060
type: Technical Design Pattern
status: published
approved_by:
  - LMP Migration Architecture Approval
  - CTEF (LMP ARB)
valid_from: 2024-09-09
developer_productivity_hrs: 0
date: 2024-08-21
govid: GOVI0002900
govid_url: https://lseg.service-now.com/x/lsegp/cto/record/x_lsegp_eag_governance_item/15204a1fc3c452947e94991c050131de
pattern_repo: https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvcpat/terraform/azure-prdsvcpat-terraform-apim
tags:
  - Message Bus & Integration
tech_capabilities:
  - Platform / Application / Message Bus & Integration / Interfaces & APIs
---

# Azure API Management Service Pattern

## Description

Azure API Management Service provides a persistent management platform for APIs across all environments,
and is expected to be widely applicable for LMP migrations and other scenarios.

This pattern addresses some key design and development aspects providing high value to application teams:

- Pattern addresses persistent management platform for Internal APIs only.
- Authentication and authorization are done using Entra ID
- Minimizes developer effort and deployment complexity for migration execution teams/developers.
- Mitigates risk by exclusively incorporating only GA (generally available) and recommended features into the architecture.
- Ensures secure secret management through a Zero Trust approach.
- Adheres to MEC compliance standards.

See [D&A API Strategy][1] for wider API migration considerations.

[1]: https://lsegroup.sharepoint.com/:p:/r/teams/LSEGLMPAppMigrationApprovers/_layouts/15/Doc.aspx?sourcedoc=%7B4529665B-39E3-4CC4-BE47-920EA4439E4D%7D&file=D&A%20API%20Strategy%20-%20LMP%20SIAs%20=&%20Migrations.pptx=&action=edit&mobileredirect=true

## Pattern Value Assessment

| Value Dimension                                  | Guide                                                                                                      | Score       |
|--------------------------------------------------|------------------------------------------------------------------------------------------------------------|-------------|
| Frequency of re-use                              | Number of applications projected to reuse this pattern                                                     | 70          |
| Developer Productivity                           | Estimated design & dev effort saved (in hours) by adopting the pattern                                     | 100         |
| Assurance Value: Information & Data Architecture | Qualitative assessment of contribution of pattern to Information & Data Architecture standards conformance | Some        |
| Assurance Value: Security Architecture           | Qualitative assessment of contribution of pattern to Security Architecture standards conformance           | Significant |
| Assurance Value: Technology                      | Qualitative assessment of contribution of pattern to Technology standards conformance                      | Some        |

Assurance Value considers:

- Minimum Entry Criteria coverage e.g. Security Architecture MEC
- Automated assurance compatibility e.g. enforcement via Azure Policy

