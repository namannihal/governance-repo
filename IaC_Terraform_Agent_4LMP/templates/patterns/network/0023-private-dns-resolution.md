---
id: LMP-PAT-0023
type: Functional Design Pattern
status: published
approved_by:
  - LMP Migration Architecture Approval
date: 2024-08-19
valid_from: 2024-08-19
developer_productivity_hrs: 2
tags:
  - "Network"
  - "Domain Services"
tech_capabilities:
  - Infrastructure / Network / Domain Services
---

# Private DNS Resolution

This pattern is condensed from the [Foundation STAR DA-002][star da-002]

## Network Architecture Overview

1. Application Subscriptions:
    - Each application subscription has two VNets:
      a. Routable VNet
      b. Non-routable VNet
    - Both VNets have a private DNS zone attached

2. Hub Networks:
    - Contain outbound and inbound Azure Private Resolvers

## DNS Resolution Process

### Within Application Subscription VNets

- Endpoints use the private IP `168.63.129.16` for DNS resolution within their own VNets. This is the IP address
  the [Azure private resolver can be reached on][168-63-129-16]
- Resolves private DNS names, both in cloud and on premise, as well as internet names

### Cross-Premises Resolution

1. Outbound (Azure to On-Premises):
    - Hub networks use outbound Azure Private Resolvers
    - These resolvers conditionally forward DNS requests to on-premises servers
    - Used for resolving names in on-premises networks

2. Inbound (On-Premises to Azure):
    - Hub networks have inbound Private Resolvers
    - On-premises DNS services (RIANA) conditionally forward DNS requests to Azure Private DNS using these resolvers

![Private DNS](img/0023-private-dns.png)

[star da-002]: https://lsegroup.sharepoint.com/:w:/r/teams/LMFoundationFM/_layouts/15/Doc.aspx?sourcedoc=%7B837C508D-D1E5-459B-B62C-2BB51C2DFD48%7D

[168-63-129-16]: https://learn.microsoft.com/en-us/azure/virtual-network/what-is-ip-address-168-63-129-16

