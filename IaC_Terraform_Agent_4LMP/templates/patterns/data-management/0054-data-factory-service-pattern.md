---
id: LMP-PAT-0054
type: Technical Design Pattern
status: published
approved_by:
  - LMP Migration Architecture Approval
  - CTEF (LMP ARB)
valid_from: 2024-10-28
developer_productivity_hrs: 0
date: 2024-09-09
govid: GOVI0002987
govid_url: https://lseg.service-now.com/x/lsegp/cto/record/x_lsegp_eag_governance_item/efff8fdd836c1a10ca759030ceaad339
pattern_repo: https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvcpat/terraform/azure-prdsvcpat-terraform-azuredatafactory
tags:
  - Data Management
tech_capabilities:
  - Platform / Data / Data Management / Extract-Transform-Load
  - Platform / Data / Data Management / File Data Ingest
---

# Azure Data Factory Service Pattern

## Description

Azure Data Factory (ADF) is a cloud-based ETL and data integration service that allows the creation of
data-driven workflows for orchestrating data movement and transforming data. ADF allows the creation of
workflows (called pipelines) that can ingest data from disparate data stores. Data can be transformed
within data flows or by using other Azure data services such as Azure Databricks and Azure SQL Database.
Data can be published to a wide variety of data stores.

See [Overview of Azure Data Factory][1] for more information on use of the service within LMP Migration.

[1]: https://dev.azure.com/LSEGroup/Migration/_wiki/wikis/Migration.wiki/774/Overview-of-Azure-Data-Factory

## Pattern Value Assessment

| Value Dimension                                  | Guide                                                                                                      | Score       |
|--------------------------------------------------|------------------------------------------------------------------------------------------------------------|-------------|
| Frequency of re-use                              | Number of applications projected to reuse this pattern                                                     | 70          |
| Developer Productivity                           | Estimated design & dev effort saved (in hours) by adopting the pattern                                     | 100         |
| Assurance Value: Information & Data Architecture | Qualitative assessment of contribution of pattern to Information & Data Architecture standards conformance | Some        |
| Assurance Value: Security Architecture           | Qualitative assessment of contribution of pattern to Security Architecture standards conformance           | Significant |
| Assurance Value: Technology                      | Qualitative assessment of contribution of pattern to Technology standards conformance                      | Significant |

Assurance Value considers:

- Minimum Entry Criteria coverage e.g. Security Architecture MEC
- Automated assurance compatibility e.g. enforcement via Azure Policy

