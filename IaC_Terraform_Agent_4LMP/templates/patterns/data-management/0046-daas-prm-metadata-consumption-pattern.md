---
id: LMP-PAT-0046
type: Functional Design Pattern
status: published
approved_by:
  - LMP Migration Architecture Approval
date: 2024-10-31
valid_from: 2024-11-06
developer_productivity_hrs: 5
tags:
  - Data Management
tech_capabilities:
  - Platform / Data / Data Management
---

# Rights (PRM) metadata Consumption Pattern

## Introduction

Rights metadata (Segment and Product definitions) defines how content distributed via Data-as-a-Service (DaaS) should
be grouped into Segments and Content Products. This information mastered in Product & Rights Management (APP-51737)
application but not available directly via this application. PRM dual publish it to DaaS metadata repository (Purview)
and PRM Blob storage in Azure.

Rights metadata include information about:

- Content grouping into Segments (field and table level information)
- Segment grouping into Content Products
- Content Product mapping to Commercial Product via Material Code (MC)
- Client Rules (rights and restrictions for consumer of the product)
- Effective period of each Segment and Product version

This information is required for any application which consume or distribute data via DaaS, also it is required for any
kind of data catalogues we want to expose or publish to customers.

This pattern provides guidance and approved designs for teams to consume rights metadata from DaaS platform. It
reflects the current state of maturity immediately post Release 1.

## Scope

This pattern is applicable to Internal products and applications needing:

- to query rights information about products available on DaaS (e.g. Data Discovery)
- enforce entitlements and product boundaries as part of data consumption or distribution (e.g. DaaS distribution channels)
- run compliance checks and reports for DaaS products (Product Studio II and Rights Management tooling)

The scope of the pattern includes:

- definition of available consumption mechanisms and the types of use case it supports
- outline of pros and cons of the different mechanisms
- a statement on whether the consumption mechanism is approved for internal use

External (non-LSEG) applications are not allowed to consume rights metadata from DaaS, however DaaS products
may include some of rights metadata as part of Content Product or Data Catalogue distribution.

## Pattern Definition

The following consumption patterns are available for use:

### 1. Purview Atlas API

Consume Rights metadata directly from Purview Atlas API using Purview SDK. Use Purview Events Hub to subscribe for
notifications on changes to metadata. You will have to setup filters to filter out notifications not related to your application.

Purview is a central metadata repository for DaaS. Rights and other metadata available via Purview API.

#### Pros

- API based access to rights metadata
- Purview is an authoritative redistribution of rights metadata for DaaS
- Availability of Field and Business Glossary (and other metadata) via the same API
- Strong typed schema for rights metadata

#### Cons

- Purview SLA
- Complex data schema for rights metadata

#### Recommendation

This pattern is approved for use by internal application when these calls are part of internal application flow and not
related to handling client requests. Current Purview SLA doesn't allow use its API as part of flows which requires
high performance and fast response time.

### 2. PRM Azure Blob Storage

Consume Rights metadata from Azure Blob Storage owned by PRM team. This storage contains all version Segment and Product
definitions in published status as JSON files. Consumer can subscribe for Blob Storage change notifications to be
aware of all changes published by PRM.

#### Pros

- Azure Blob Storage is highly available and performant storage
- Each version of PRM definitions stored as a separate JSON file with simple schema
- Blob storage automatically emits notifications on changes to files

#### Cons

- Azure Blob storage is a tactical solution for Release 1
- PRM Blob storage contains only rights metadata, all other metadata (Field Dictionary, Business Glossary, etc.) available
via Purview API
- Blob storage doesn't provide API to query rights metadata

#### Recommendation

It is approved to use by DaaS Distribution Channels. Any other consumers should not use it unless it is approved
with DaaS Architecture team. This Blob storage may be replaced with alternative solution after DaaS Release 1

