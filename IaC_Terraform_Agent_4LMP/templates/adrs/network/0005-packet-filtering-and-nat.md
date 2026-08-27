---
id: LMP-ADR-0005
type: ADR
status: published
approved_by:
  - LMP Migration Architecture Approval
date: 2024-05-07
valid_from: 2024-05-25
tags:
  - Network
tech_capabilities:
  - Infrastructure / Network
---

# Use Azure Firewall for Traffic Filtering and Network Address Translation

## Context and Problem Statement

Given the scale of the LMP migration, it has been imperative to conserve [RFC 1918 addresses](https://en.wikipedia.org/wiki/Private_network).

Specifically, there is a requirement to perform Source Network Address Translation (SNAT) from
 the [Carrier-Grade NAT (CGNAT)](https://en.wikipedia.org/wiki/Carrier-grade_NAT) ranges of 100.64/10
 to RFC 1918 ranges 10/8 to overcome IP exhaustion.

Unlike AWS, there is no Azure-native private NAT capability. As an alternative, the Foundation Landing Zone design employs
 an Azure Firewall per spoke Subscription.

## Decision Drivers

The decision is driven by:

- The need to conserve RFC 1918 addresses, given above
- The need for cost efficiency
- The need for operational efficiency and suitable logging & telemetry
- The need for firewall-type features including FQDN and layer 3/4 filtering

## Considered Options

- Azure Firewall (Standard SKU)
- Azure NAT Gateway
- Network Virtual Appliance (e.g. CheckPoint, Fortinet)
- Virtual Machines with open source tools
- Network Security Groups (NSGs)

## Decision Outcome

Chosen option: Azure Firewall, because

- It is Azure native and CSP-managed
- It meets the requirements
- No other Azure-managed alternative exists

### Consequences

- Good, because it can perform public NAT - SNAT when forwarding 100.64/10 and 10/8 to a public IP
- Good, because it can perform private NAT - SNAT 100.64/10 to 10/8
- Good, because it can also be used for FQDN filtering (to the internet)
- Good, because it can also be used for Layer 3/4 packet filtering
- Good, because it supports granular logging
- Neutral, because it requires us to promote Subscription sharing in order to minimise fixed costs
- Bad, because of the high fixed cost per Subscription (an Azure Firewall is $1.25/hour plus $0.016/GB of
   processed data, meaning a minimum of $912/month or $11k/year/Subscription). If there were 1600 Subscriptions,
   this is a minimum undiscounted cost of $17.5M/year.
- Bad, because it constrains the features we may be able to adopt in the future (e.g. current lack of support for IPv6)
   given our influence over the roadmap is limited

### Confirmation

The decision was validated by the CTEF process, although some of the listed options may not have been formally
 considered during design review.

## Pros and Cons of the Options

### Azure NAT Gateway

- Good, because it is an Azure managed service
- Bad, because it doesn't support private-to-private SNAT, only private-to-public

### Network Virtual Appliance (e.g. CheckPoint, Fortinet)

- Good, because NATing and filtering requirements would be met
- Good, because it would incur no additional data processing costs
- Neutral, because it would mean a licensing arrangement with the chosen vendor
- Bad, because it would be relatively complex to support and operate (a combined effort between Microsoft,
  LSEG Cloud Operations, Network Security & Firewall teams)
- Bad, because the appliances would be deployed on Virtual Machines, requiring maintenance, patching, hardening, etc.

### Virtual Machines with open source tools

- Good, because low cost
- Good, because a combination of tools such as Netfilter/IPtables (for firewalling),
   Squid (for proxy and FQDN filtering) and NetFlow (for traffic analysis) would meet the requirements
- Good, because it would incur no additional data processing costs
- Bad, because open source tooling is typically without enterprise support
- Bad, because the tooling typically requires SMEs to configure, secure and maintain
- Bad, because the solution would be deployed on Virtual Machines, requiring maintenance, patching, hardening, etc.

### Network Security Groups (NSGs)

- Good, because it supports basic logging and metrics
- Good, because it supports Layer 3/4 packet filtering
- Good, because it is easy to deploy and there is nothing to operate
- Good, because free
- Bad, because it does not support FQDN filtering

## More Information

This decision may be revisited when:

- The Azure NAT Gateway service becomes fit-for-purpose and cost effective
- The Azure Firewall costs become untenable
- There is greater appetite for a self-managed solution (e.g. open source tools)
- There is a reduced need for private network traffic

See [ADR 0006 Subscription Sharing](../foundation-platform/0006-subscription-tenancy.md)

