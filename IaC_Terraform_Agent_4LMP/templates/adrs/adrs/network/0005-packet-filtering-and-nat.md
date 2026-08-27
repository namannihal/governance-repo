<span class="md-content__button md-icon md-status--published" href="#" title="Status: Published"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE4LjUgMmgtMTNDMy42IDIgMiAzLjYgMiA1LjV2MTNDMiAyMC40IDMuNiAyMiA1LjUgMjJIMTZsNi02VjUuNUMyMiAzLjYgMjAuNCAyIDE4LjUgMk0yMCAxNWgtMS41Yy0xLjkgMC0zLjUgMS42LTMuNSAzLjVWMjBINS44Yy0xIDAtMS44LS44LTEuOC0xLjhWNS44QzQgNC44IDQuOCA0IDUuOCA0aDEyLjVjMSAwIDEuOC44IDEuOCAxLjhWMTVtLTQuOS02LjggMS41IDEuNS02IDYtMy41LTMuNSAxLjUtMS41IDIgMnoiIC8+PC9zdmc+) </span> <span class="md-content__button md-icon .md-status--published" title="Valid from 2024-05-25"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE5IDE5SDVWOGgxNG0wLTVoLTFWMWgtMnYySDhWMUg2djJINWEyIDIgMCAwIDAtMiAydjE0YTIgMiAwIDAgMCAyIDJoMTRhMiAyIDAgMCAwIDItMlY1YTIgMiAwIDAgMC0yLTJtLTIuNDcgOC4wNkwxNS40NyAxMGwtNC44OCA0Ljg4LTIuMTItMi4xMi0xLjA2IDEuMDZMMTAuNTkgMTd6IiAvPjwvc3ZnPg==) </span> <span class="md-content__button md-icon actions-date" title="Published on 2024-05-07">![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTkgMTB2Mkg3di0yem00IDB2MmgtMnYtMnptNCAwdjJoLTJ2LTJ6bTItN2EyIDIgMCAwIDEgMiAydjE0YTIgMiAwIDAgMS0yIDJINWEyIDIgMCAwIDEtMi0yVjVhMiAyIDAgMCAxIDItMmgxVjFoMnYyaDhWMWgydjJ6bTAgMTZWOEg1djExek05IDE0djJIN3YtMnptNCAwdjJoLTJ2LTJ6bTQgMHYyaC0ydi0yeiIgLz48L3N2Zz4=)</span> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/edit/main/docs/adrs/network/0005-packet-filtering-and-nat.md" class="md-content__button md-icon" title="Edit this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTEwIDIwSDZWNGg3djVoNXYzLjFsMi0yVjhsLTYtNkg2Yy0xLjEgMC0yIC45LTIgMnYxNmMwIDEuMS45IDIgMiAyaDR6bTEwLjItN2MuMSAwIC4zLjEuNC4ybDEuMyAxLjNjLjIuMi4yLjYgMCAuOGwtMSAxLTIuMS0yLjEgMS0xYy4xLS4xLjItLjIuNC0uMm0wIDMuOUwxNC4xIDIzSDEydi0yLjFsNi4xLTYuMXoiIC8+PC9zdmc+" /></a> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/blob/main/docs/adrs/network/0005-packet-filtering-and-nat.md" class="md-content__button md-icon" title="View source of this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE3IDE4Yy41NiAwIDEgLjQ0IDEgMXMtLjQ0IDEtMSAxLTEtLjQ0LTEtMSAuNDQtMSAxLTFtMC0zYy0yLjczIDAtNS4wNiAxLjY2LTYgNCAuOTQgMi4zNCAzLjI3IDQgNiA0czUuMDYtMS42NiA2LTRjLS45NC0yLjM0LTMuMjctNC02LTRtMCA2LjVhMi41IDIuNSAwIDAgMS0yLjUtMi41IDIuNSAyLjUgMCAwIDEgMi41LTIuNSAyLjUgMi41IDAgMCAxIDIuNSAyLjUgMi41IDIuNSAwIDAgMS0yLjUgMi41TTkuMjcgMjBINlY0aDd2NWg1djQuMDdjLjcuMDggMS4zNi4yNSAyIC40OVY4bC02LTZINmEyIDIgMCAwIDAtMiAydjE2YTIgMiAwIDAgMCAyIDJoNC41YTguMiA4LjIgMCAwIDEtMS4yMy0yIiAvPjwvc3ZnPg==" /></a>

Document Metadata

|  |  |
|----|----|
| Identifier | **`LMP-ADR-0005`** |
| Type | **ADR** |
| Status | **Published** |
| Approvals | <span class="md-tag">LMP Migration Architecture Approval</span> |
| Published on | **May 07, 2024** |
| Valid From | **May 25, 2024** |
| Authors | <span class="md-source-file__fact"> </span> |
| Tags | <span class="md-tag">Network</span> |
| Technology Capabilities | <span class="md-tag">Infrastructure / Network</span> |

# Use Azure Firewall for Traffic Filtering and Network Address Translation<a href="#use-azure-firewall-for-traffic-filtering-and-network-address-translation" class="headerlink" title="Permanent link">¶</a>

## Context and Problem Statement<a href="#context-and-problem-statement" class="headerlink" title="Permanent link">¶</a>

Given the scale of the LMP migration, it has been imperative to conserve [RFC 1918 addresses](https://en.wikipedia.org/wiki/Private_network).

Specifically, there is a requirement to perform Source Network Address Translation (SNAT) from the [Carrier-Grade NAT (CGNAT)](https://en.wikipedia.org/wiki/Carrier-grade_NAT) ranges of 100.64/10 to RFC 1918 ranges 10/8 to overcome IP exhaustion.

Unlike AWS, there is no Azure-native private NAT capability. As an alternative, the Foundation Landing Zone design employs an Azure Firewall per spoke Subscription.

## Decision Drivers<a href="#decision-drivers" class="headerlink" title="Permanent link">¶</a>

The decision is driven by:

- The need to conserve RFC 1918 addresses, given above
- The need for cost efficiency
- The need for operational efficiency and suitable logging & telemetry
- The need for firewall-type features including FQDN and layer ¾ filtering

## Considered Options<a href="#considered-options" class="headerlink" title="Permanent link">¶</a>

- Azure Firewall (Standard SKU)
- Azure NAT Gateway
- Network Virtual Appliance (e.g. CheckPoint, Fortinet)
- Virtual Machines with open source tools
- Network Security Groups (NSGs)

## Decision Outcome<a href="#decision-outcome" class="headerlink" title="Permanent link">¶</a>

Chosen option: Azure Firewall, because

- It is Azure native and CSP-managed
- It meets the requirements
- No other Azure-managed alternative exists

### Consequences<a href="#consequences" class="headerlink" title="Permanent link">¶</a>

- Good, because it can perform public NAT - SNAT when forwarding 100.64/10 and 10/8 to a public IP
- Good, because it can perform private NAT - SNAT 100.64/10 to 10/8
- Good, because it can also be used for FQDN filtering (to the internet)
- Good, because it can also be used for Layer ¾ packet filtering
- Good, because it supports granular logging
- Neutral, because it requires us to promote Subscription sharing in order to minimise fixed costs
- Bad, because of the high fixed cost per Subscription (an Azure Firewall is \$1.25/hour plus \$0.016/GB of processed data, meaning a minimum of \$912/month or \$11k/year/Subscription). If there were 1600 Subscriptions, this is a minimum undiscounted cost of \$17.5M/year.
- Bad, because it constrains the features we may be able to adopt in the future (e.g. current lack of support for IPv6) given our influence over the roadmap is limited

### Confirmation<a href="#confirmation" class="headerlink" title="Permanent link">¶</a>

The decision was validated by the CTEF process, although some of the listed options may not have been formally considered during design review.

## Pros and Cons of the Options<a href="#pros-and-cons-of-the-options" class="headerlink" title="Permanent link">¶</a>

### Azure NAT Gateway<a href="#azure-nat-gateway" class="headerlink" title="Permanent link">¶</a>

- Good, because it is an Azure managed service
- Bad, because it doesn't support private-to-private SNAT, only private-to-public

### Network Virtual Appliance (e.g. CheckPoint, Fortinet)<a href="#network-virtual-appliance-eg-checkpoint-fortinet" class="headerlink" title="Permanent link">¶</a>

- Good, because NATing and filtering requirements would be met
- Good, because it would incur no additional data processing costs
- Neutral, because it would mean a licensing arrangement with the chosen vendor
- Bad, because it would be relatively complex to support and operate (a combined effort between Microsoft, LSEG Cloud Operations, Network Security & Firewall teams)
- Bad, because the appliances would be deployed on Virtual Machines, requiring maintenance, patching, hardening, etc.

### Virtual Machines with open source tools<a href="#virtual-machines-with-open-source-tools" class="headerlink" title="Permanent link">¶</a>

- Good, because low cost
- Good, because a combination of tools such as Netfilter/IPtables (for firewalling), Squid (for proxy and FQDN filtering) and NetFlow (for traffic analysis) would meet the requirements
- Good, because it would incur no additional data processing costs
- Bad, because open source tooling is typically without enterprise support
- Bad, because the tooling typically requires SMEs to configure, secure and maintain
- Bad, because the solution would be deployed on Virtual Machines, requiring maintenance, patching, hardening, etc.

### Network Security Groups (NSGs)<a href="#network-security-groups-nsgs" class="headerlink" title="Permanent link">¶</a>

- Good, because it supports basic logging and metrics
- Good, because it supports Layer ¾ packet filtering
- Good, because it is easy to deploy and there is nothing to operate
- Good, because free
- Bad, because it does not support FQDN filtering

## More Information<a href="#more-information" class="headerlink" title="Permanent link">¶</a>

This decision may be revisited when:

- The Azure NAT Gateway service becomes fit-for-purpose and cost effective
- The Azure Firewall costs become untenable
- There is greater appetite for a self-managed solution (e.g. open source tools)
- There is a reduced need for private network traffic

See [ADR 0006 Subscription Sharing](../../foundation-platform/0006-subscription-tenancy/)

<span class="md-source-file__fact"> <span class="md-icon" title="Last update"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIxIDEzLjFjLS4xIDAtLjMuMS0uNC4ybC0xIDEgMi4xIDIuMSAxLTFjLjItLjIuMi0uNiAwLS44bC0xLjMtMS4zYy0uMS0uMS0uMi0uMi0uNC0uMm0tMS45IDEuOC02LjEgNlYyM2gyLjFsNi4xLTYuMXpNMTIuNSA3djUuMmw0IDIuNC0xIDFMMTEgMTNWN3pNMTEgMjEuOWMtNS4xLS41LTktNC44LTktOS45QzIgNi41IDYuNSAyIDEyIDJjNS4zIDAgOS42IDQuMSAxMCA5LjMtLjMtLjEtLjYtLjItMS0uMnMtLjcuMS0xIC4yQzE5LjYgNy4yIDE2LjIgNCAxMiA0Yy00LjQgMC04IDMuNi04IDggMCA0LjEgMy4xIDcuNSA3LjEgNy45bC0uMS4yeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="December 10, 2024 10:03:44 UTC">December 10, 2024</span> </span> <span class="md-source-file__fact"> <span class="md-icon" title="Created"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE0LjQ3IDE1LjA4IDExIDEzVjdoMS41djUuMjVsMy4wOCAxLjgzYy0uNDEuMjgtLjc5LjYyLTEuMTEgMW0tMS4zOSA0Ljg0Yy0uMzYuMDUtLjcxLjA4LTEuMDguMDgtNC40MiAwLTgtMy41OC04LThzMy41OC04IDgtOCA4IDMuNTggOCA4YzAgLjM3LS4wMy43Mi0uMDggMS4wOC42OS4xIDEuMzMuMzIgMS45Mi42NC4xLS41Ni4xNi0xLjEzLjE2LTEuNzIgMC01LjUtNC41LTEwLTEwLTEwUzIgNi41IDIgMTJzNC40NyAxMCAxMCAxMGMuNTkgMCAxLjE2LS4wNiAxLjcyLS4xNi0uMzItLjU5LS41NC0xLjIzLS42NC0xLjkyTTE4IDE1djNoLTN2MmgzdjNoMnYtM2gzdi0yaC0zdi0zeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="May 9, 2024 10:21:25 UTC">May 9, 2024</span> </span>

<a href="../../infrastructure/0025-Azure-capacity-reservation/" class="md-footer__link md-footer__link--prev" aria-label="Previous: Azure Capacity Reservations for Critical Workloads"></a>

<div class="md-footer__button md-icon">

![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIwIDExdjJIOGw1LjUgNS41LTEuNDIgMS40Mkw0LjE2IDEybDcuOTItNy45MkwxMy41IDUuNSA4IDExeiIgLz48L3N2Zz4=)

</div>

<div class="md-footer__title">

<span class="md-footer__direction"> Previous </span>

<div class="md-ellipsis">

Azure Capacity Reservations for Critical Workloads

</div>

</div>

<a href="../0013-tornado/" class="md-footer__link md-footer__link--next" aria-label="Next: API Providers to remove dependencies on Tornado (APP-202052) as they migrate to Azure"></a>

<div class="md-footer__title">

<span class="md-footer__direction"> Next </span>

<div class="md-ellipsis">

API Providers to remove dependencies on Tornado (APP-202052) as they migrate to Azure

</div>

</div>

<div class="md-footer__button md-icon">

![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTQgMTF2MmgxMmwtNS41IDUuNSAxLjQyIDEuNDJMMTkuODQgMTJsLTcuOTItNy45MkwxMC41IDUuNSAxNiAxMXoiIC8+PC9zdmc+)

</div>

<div class="md-footer-meta md-typeset">

<div class="md-footer-meta__inner md-grid">

<div class="md-copyright">

Made with <a href="https://squidfunk.github.io/mkdocs-material/" target="_blank" rel="noopener">Material for MkDocs</a>

</div>

</div>

</div>

<div class="md-dialog" md-component="dialog">

<div class="md-dialog__inner md-typeset">

</div>

</div>
