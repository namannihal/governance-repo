---
id: LMP-PAT-0052
type: Functional Design Pattern
status: published
approved_by:
  - LMP Migration Architecture Approval
date: 2024-12-03
valid_from: 2024-12-16
developer_productivity_hrs: 5
tech_capabilities:
  - Platform / Data / Data Management
tags:
  - Data Management
---

# Enforcement of Content Segmentation and Entitlements

## Introduction

DaaS implements content distribution to consumers via multiple distribution channels. Each of these channels
are responsible for enforcing DaaS Product Entitlements and Content Segmentation boundaries defined by Product and
Rights Management (PRM).

## Scope

This pattern covers entitlements model for Content Products delivered over DaaS. It includes Product Level
entitlements (Material Code) and Segment Level entitlements (PRM Segment definition) and responsibility for
entitlements enforcement.

### Out of scope

- Authentication and Authorization of the customer (human and service accounts)
- EntraID accounts mapping to AAA account
- Provisioning of Commercial Products to consumers
- Application level entitlements (internal and external)
- Kong API GW entitlements (including access control to DaaS BULK API via PO)

## Entitlements enforcement steps

Each DaaS Distribution Channel to distribute content to external consumers must follow these steps:

- Obtain information about user's Permission Profile from AAA License Management API
- Check user entitlements on product level (Deployment Method of Material Code + Material Code presence in user's
Permission Profile)
- Obtain information about PRM Segment Definitions included into products provisioned to consumers
- Track the lifecycle of PRM Segment and Product definitions (Effective period, updates, deprecation)
- Enforce fine-grained entitlements on Column / Row / Cell level using Segment Definition
- Track changes to user's permission profile (products provisioning and removal)

![Content Products entitlements enforcement](./img/0052-daas-entitlements-enforcement.png)

Entitlement enforcement steps are grouped into four phases:

### Phase 1 - Obtain user's Permission Profile

DaaS components should use [AAA License Management API](https://confluence.refinitiv.com/display/PCS/License+Management+API+V2-+Design+Specification)
(part of AAA Provisioning Platform) to get information about user's Permission Profile.
Permission Profile should include information about Material Codes assigned to specific users and "Deployment Method"
for each of the Material Code.

Sample fragment of AAA License Management API response:

```json
{
  "licenseEntitlements": [
    {
      "licenseId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      "accountId": "GEUS2-57138",
      "product": {
        "id": "string",
        "deploymentMethod": "string",
        "name": "string",
        "description": "string",
        "addOn": true,
        "productFamily": "string",
        "category": "string"
      },
      "version": 0,
      "licenseEntitlementId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      "uuid": "string",
      "username": "string",
      "status": "string"
    }
  ]
}
```

Deployment Methods for DaaS:

| ID | Name     | Description                |
|----|----------|----------------------------|
| 9  | BULK     | DaaS BULK Distribution     |
| 10 | DATABASE | DaaS Database Distribution |

Other AAA API's (ACL API, ODPS or Entitlements Platform API) should NOT be used to obtain user's permission
profile because they don't include all required information about Material Codes and "Deployment Method".

### Phase 2 - Build snapshot of PRM active Products and Segments version

PRM Product and Segment definitions has own lifecycle status controlled by:

- Effective Period of Segment and Product definition (Effective From, Effective To fields)
- Status of the Product version

DaaS components are responsible for:

- identifying active version of Product and Segment based on fields EffectiveFrom, EffectiveTo, Status
- handling status of segment s and products "Active", "Cancelled" and "End Of Life"
- handling segment and product version promotion according to the active period

### Phase 3 - Product level (coarse-grained) entitlements enforcement

Coarse grained entitlements enforcement on Content / Commercial Product level.

Each DaaS Content Product must be assigned with CPQ Material Code to control access to this Content Product.
Distribution Channel need to obtain Permission Profile (from AAA) of the user and verify that

- "Deployment Method" of the Material Code matches to the value associated with this Distribution Channel (TODO: add values)
- user is entitled (MC for requested product presented in permission profile) for the requested product (Material Code level)

Sample fragment of Product Definition (ESG Global) to include two segments into product mapped to Material Code 9300000131

```json
{
  "Header": {
    "Name": "ESG Global - DaaS bulk datafeed",
    "BillingSystems": [
      {
        "System": "Sap",
        "BillingId": "9300000131"
      }
    ],
    "EffectiveFrom": "2024-10-31T00:00:00Z",
    "EffectiveTo": "2024-11-01T23:59:59Z",
    "GoLiveDate": "2024-09-10T00:00:00Z"
  },
  "SelectedSegments": [
    {
      "Id": "a34b6a0a-473f-437b-d516-08dcbd20a9e5",
      "Name": "RCS R1"
    },
    {
      "Id": "3fddf860-a6be-486d-d518-08dcbd20a9e5",
      "Name": "[ESG] Measure Values, AsReported and Source Data (excluding Scores and Controversies) - R1"
    }
 ]
}
```

### Phase 4 - Content Segment boundaries (fine-grained) entitlements enforcement

Fine grained entitlements enforcement (Segment boundaries) on Column / Row / Cell level.

Distribution Channel is responsible for Segment boundaries control and enforcement of fine-grained entitlements.
Distribution Channel should read Segment Definitions from Purview or PRM Blob Storage [pat-0046: Consumption of PRM metadata](./0046-daas-prm-metadata-consumption-pattern.md)
for each DaaS Content Product provisioned to customer.

This information should be used to control user access to a particular Column / Row / Cell of the corresponding
Content Products. The exact approach to enforce entitlements depends on the nature of the Distribution Channel (e.g. SQL
query injection, database view creation, etc.).

Sample fragment of Segment Definition ([ESG] Equity Instrument CUSIP) to include 3 columns from the table Instrument and
apply filters on top of them:

```json
{
      "ColumnConfigurations": [
          {
            "ColumnName": "EffectiveFromTimestamp",
            "ColumnDataType": "timestamp",
            "IsIncludedInOutput": true,
            "Filter": {
              "$type": "LessThanOrEqualTo",
              "Value": "CurrentUTCDate"
            }
          },
          {
            "ColumnName": "PermId",
            "ColumnDataType": "long",
            "IsIncludedInOutput": true,
            "Filter": null
          },
          {
            "ColumnName": "AdminStatusCode",
            "ColumnDataType": "string",
            "IsIncludedInOutput": false,
            "Filter": {
              "$type": "Equals",
              "Value": "Published"
            }
          }
        ],
        "TableName": "Instrument"
      }
}
```

### Notes

It is recommended to use capabilities provided by DaaS Distribution Channels to handle PRM definitions
(rather than to implement them again):

- Manifest Manager - manages lifecycle of the PRM segments and products
- SQL query builder - transform PRM segment definition into queries

## Further Reading

- [pat-0046: Consumption of PRM metadata](./0046-daas-prm-metadata-consumption-pattern.md)
- [pat-0024: Internal Web Authentication / SSO using OIDC and Microsoft Entra](../identity-and-access-management/0024-internal-web-authentication-entra-and-oidc.md)
- [DaaS ADR Standardised Segmentation Patterns](https://gitlab.dx1.lseg.com/app/app-51783/lmp/-/blob/main/data-platform/docs/adrs/2024-01-08-standardised-segmentation-patterns.md)
- [AAA Provisioning Platform License Management API](https://confluence.refinitiv.com/display/PCS/License+Management+API+V2-+Design+Specification)
- [SAD Data-as-a-Service Release 1](https://lsegroup.sharepoint.com/:b:/r/teams/LMDataPlatform/Shared%20Documents/CH%20-%20Tech%20Architecture/Published%20Docs/Solution%20Designs/DaaS%20R1/Prod%20Design/Data%20Intelligence%20-%20Data-as-a-Service%20Release%201%20-%20Prod.pdf?csf=1&web=1&e=XfJcjr)

