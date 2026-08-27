---
id: LMP-PAT-0026
type: Functional Design Pattern
status: published
approved_by:
  - LMP Migration Architecture Approval
date: 2024-09-23
valid_from: 2024-09-23
developer_productivity_hrs: 2
tags:
  - "Network"
tech_capabilities:
  - Infrastructure / Network / Virtual Private Network
---

# ZScaler Private Access Connectivity for Internal Access

This pattern is extracted
from [Foundation STAR DA-801 - ZScaler Private Access App Connector Deployment in ALZ][da-801].

## Requirement / Story

> As an application engineer, I would like to be able to allow my application to, at runtime, receive connections from
> LSEG staff EUC devices so that it can provide service to those users

## Scope

- Application endpoints that _only_ serve IP traffic to LSEG staff on LSEG-managed end-user compute (EUC) devices (e.g.
  Laptop, VDI etc.) for BAU activities.
- As above, but also for operations / break-glass purposes.

Application endpoints that also serve non-LSEG staff identities (customers, other systems etc.) are out of scope.

This pattern is appropriate for describing how to meet the current [Minimum Entry Criteria][mec] §MEC-V3_2-18:

> All systems used by Internal users, must use Zscaler Private Access as the method to provide access from LSEG End User
> Compute devices.

## Background

[ZScaler Private Access][zpa] is a product from ZScaler that is used by LSEG to enable access from LSEG-managed EUC
devices. LSEG-managed devices are configured with a [ZScaler Client Connector][zscaler-client-connector] agent, which
manages the ZScaler configuration of their device and authenticates that user to ZScaler's infrastructure with their
LSEG Entra identity.

The ZScaler Client Connector establishes a tunnel connection to ZScaler's private access infrastructure, and then
configures the EUC device to route certain requests (via DNS and IP routing) down that tunnel. On the LSEG application
side, we deploy a number of [ZScaler App Connectors][zscaler-app-connector] within our infrastructure. The ZScaler
infrastructure is then configured to route client traffic to the correct App Connector based on the client and requested
destination.

## Principles

- App Connectors are deployed into specific ZPA Azure Subscriptions, with multiple connectors deployed into each region.
  These are centrally deployed and managed by the Cloud and CyberSec teams.
- The App Connector initiates a connection out to the ZPA Cloud via the ZPA Subscription Firewall.
- Application traffic from the EUC device flows through ZScaler's cloud in a TLS-encrypted tunnel.
- The application's published DNS name should resolve to an endpoint in the application's routable VNET, typically an
  App GW instance or a private endpoint.
- Once the application URL is onboarded to ZPA, the client connectors will be configured to send traffic through the ZPA
  Cloud and then to the correct regional App Connector. From there, it is routed through the LSEG HUB firewall and to
  the endpoint hosted in the application's routable VNET.
- The application team is responsible for:
    - correctly forwarding the traffic from their App GW or Private Endpoint to the correct infrastructure,
    - maintaining their DNS name, and
    - [onboarding their application with ZPA][zpa-onboarding].

## Deployment Diagram

![Deployment Diagram](img/0026-zpa-connectors.drawio.png)

[mec]: https://lsegroup.sharepoint.com/:x:/s/ats/EVBJWaa7IC1JtYXI-Xa1_iMB0I6_KRiUv9xEVz75HEG40w?e=09KGxB

[zpa]: https://help.zscaler.com/zpa/what-zscaler-private-access

[zscaler-client-connector]: https://www.zscaler.com/products-and-solutions/zscaler-client-connector

[zscaler-app-connector]: https://help.zscaler.com/zpa/about-connectors

[zpa-onboarding]: https://lsegroup.sharepoint.com/sites/CloudCentral/SitePages/ZScaler-Private-Access-(ZPA)-%E2%80%93-Application-Onboarding-Process.aspx

[da-801]: https://lsegroup.sharepoint.com/:w:/r/teams/LMFoundationFM/_layouts/15/Doc.aspx?sourcedoc=%7BA978CABD-79DE-4F79-ACCB-3CBD964E384A%7D&file=STAR%20DA-801%20Zscaler%20Private%20Access%20App%20Connector%20Deployment%20in%20ALZ.docx&action=default&mobileredirect=true

