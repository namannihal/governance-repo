---
id: LMP-PAT-0043
type: Functional Design Pattern
status: published
approved_by:
  - LMP Migration Architecture Approval
date: 2024-12-16
valid_from: 2024-12-16
developer_productivity_hrs: 5
tags:
  - "Network"
  - "Internet"
tech_capabilities:
  - Infrastructure / Network / Data Network
---

# Customer Connectivity Hub Connectivity (aka Rejoice/DDN)

## Requirement / Story

> As an application engineer, I need to publish my application from Azure Greenfield onto the existing Delivery Direct
> Network so that customers can access my application at runtime.

## Scope

- IP traffic originating from customers on the existing LSEG Delivery Direct Network.
  Applications will be hosted in the Azure Greenfield Production environment only.
  DNS resolution is out of scope.

## Principles

- Application teams will build their application in the non-routable VNET within the Azure Greenfield environment and
  create an Azure Private Link Service/Endpoint and associated Load balancer.

| **Delivery Direct Qualified Products**                                                                                                                                                                                                                                                                                                                                                                                                              | **DSCP Value / Subnet Reference** |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------|
| Transactions Matching (Including BankStream); FXT Matching, FXALL (Real-time)                                                                                                                                                                                                                                                                                                                                                                       | AF41                              |
| Elektron Real-Time; Elektron as a Service                                                                                                                                                                                                                                                                                                                                                                                                           | AF31                              |
| Autex Trade Route; Contributions (incl. Inhibit Manager / Insertlink / MLIP Spreadsheet Publisher); DataScope Onsite, DataScope Select (Incl. Tick History), DataScope+, DataStream, Dealing Xtra; Eikon; Eikon for Wealth Management, Electronic Trading (RET), Elektron Connect; FXALL (Non real-time); FXT Dealing; Messaging; MRN; RJ-FIX; Remote Support (Beyond Trust); TradeWeb GUI; FIT; REDI; RTN; TWAVE; Transactions Dealing; Workspace; | AF22                              |

## Application Presentation on DDN from Azure Greenfield

![Deployment Diagram](img/0043-application-presentation-on-ddn-from-azure-greenfield.png)

