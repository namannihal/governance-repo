---
id: LMP-PAT-0042
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

# Azure Greenfield to Azure non-Greenfield connectivity

## Requirement / Story

> As an application engineer, I need to consume services hosted in an Azure non-Greenfield subscription from my Azure
> Greenfield subscription, at runtime. I need to initiate the session from Azure Greenfield.

## Scope

- IP traffic originating from components deployed in either the application’s routable or non-routable Virtual Network (
  VNET) within the Azure Greenfield subscription.
- DNS resolution is out of scope.

## Principles

- In the Azure non-Greenfield subscription, the ‘provider service’ creates an Azure Private Link Service that is
  associated with an Azure Load Balancer, which is in turn, associated with VM2 or services residing within the
  providing service VNET.
- The application engineer creates a local Azure Private Endpoint that is 'attached' to the Azure Private Service; this
  creates a virtual IP in the subnet.
- The application engineer targets the local virtual IP to consume the 'provider service'.
- The traffic flow is forwarded through the Microsoft Azure backbone.
- Traffic can only be established from the Greenfield subscription to the non-Greenfield 'provider service'.
- Overlapping IP addresses of the VNETs are permitted as the Microsoft Private Link service caters for this.

## General ALZ connectivity between Azure subscriptions

![Deployment Diagram](img/0042-azure_greenfield_non_azure_greenfield.png)

## Scenarios Covered

> As well as Greenfield to non-Greenfield connectivity, this pattern covers all inter/intra Azure connectivity i.e.

- Greenfield to Greenfield
- Non-Greenfield to Greenfield
- Non-Greenfield to Non-Greenfield

