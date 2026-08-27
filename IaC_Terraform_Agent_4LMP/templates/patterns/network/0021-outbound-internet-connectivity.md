---
id: LMP-PAT-0021
type: Functional Design Pattern
status: published
approved_by:
  - LMP Migration Architecture Approval
date: 2024-08-19
valid_from: 2024-08-19
developer_productivity_hrs: 2
tags:
  - "Network"
  - "Internet"
tech_capabilities:
  - Infrastructure / Network / Internet Connectivity
---

# Outbound Internet Connectivity

## Requirement / Story

> As an application engineer, I would like to be able to allow my application to, at runtime, initiate connections to
> remote endpoints that are available on the internet.

## Scope

- IP traffic originating from components deployed into either the application's routable or non-routable Virtual
  Networks (VNET )within their own subscriptions.
- DNS resolution is _not in scope_ for this pattern. DNS resolution is covered by
  the [DNS resolution pattern][dns-resolution-pattern].

## Principles

- All traffic will flow through an LSEG-managed [Azure Firewall][azure-firewall] device deployed in the routable VNET of
  the application subscription. This device is responsible for applying the LSEG defined security policy for internet
  traffic, including FQDN filtering.
- The Azure Firewall instance will perform outbound NAT'ing and connection state tracking. There
  are [some limitations (e.g. maximum 2,496 SNAT ports per public IP)][azure-firewall-limitations] that application
  teams should be aware of.
- The Azure Firewall is provided as part of the Azure subscription by the LMP Foundation capability.

## Generic ALZ connectivity to the Internet - Outbound

This pattern is condensed from the [Foundation STAR DA-022A][DA-022A] (Scenario 3 §4.1.3.3).

![Deployment Diagram](img/0021-outbound-internet-deployment-diagram.drawio.png)

[DA-022A]: https://lsegroup.sharepoint.com/:w:/r/teams/LMFoundationFM/_layouts/15/Doc.aspx?sourcedoc=%7B0629DCC7-2C6D-4696-A26C-5EF11962F624%7D

[dns-resolution-pattern]: https://lsegroup.sharepoint.com/:w:/t/LMFoundationFM/ETrCFCVaWqVNrtChO-_nufABqHiCZ3yDaee2zdM2I0OeHg?e=7c6zFv

[azure-firewall]: https://learn.microsoft.com/en-us/azure/firewall/overview

[azure-firewall-limitations]: https://learn.microsoft.com/en-us/azure/firewall/firewall-known-issues

