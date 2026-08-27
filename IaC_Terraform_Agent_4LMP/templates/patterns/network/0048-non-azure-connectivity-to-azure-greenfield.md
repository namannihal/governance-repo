---
id: LMP-PAT-0048
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

# Non-Azure Connectivity to Azure Greenfield

## Requirement / Story

> As an application engineer, I need to publish my application to other non-Azure endpoints in other cloud service
> providers. Specific requirements around security, encryption, latency and availability would preclude internet as the
> transport in some cases. I need the traffic to use internal networks. The client-side of the application will initiate
> the sessions and my application will respond.

## Scope

- IP traffic originating from components deployed a non-Azure cloud provider.
- Traffic will traverse the internet WAN and not use the internet.
- DNS resolution is out of scope.

## Principles

- Application teams will build their application in the non-routable VNET within the Azure Greenfield environment.
- The application will be presented to the internal systems/WAN using approved Cloud Product Framework resources – i.e.
  Application Gateway, Private Link Endpoints.
- Application teams are responsible for raising change requests for firewall changes at both ends of the session. This
  will be in the form of a Service Now ticket (requiring source IP, destination, protocol etc.).
- Inbound traffic to the Azure Greenfield service will traverse the Azure Control Plane Hub firewalls. Traffic is then
  forwarded to the application presentation resource, not the Application Spoke Firewall. No NAT takes place on this
  type of flow on any firewalls.

## General ALZ connectivity between an Azure subscription & other CSP

![Deployment Diagram](img/0048-non-azure-connectivity-to-azure-greenfield.png)

