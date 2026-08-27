<span class="md-content__button md-icon md-status--published" href="#" title="Status: Published"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE4LjUgMmgtMTNDMy42IDIgMiAzLjYgMiA1LjV2MTNDMiAyMC40IDMuNiAyMiA1LjUgMjJIMTZsNi02VjUuNUMyMiAzLjYgMjAuNCAyIDE4LjUgMk0yMCAxNWgtMS41Yy0xLjkgMC0zLjUgMS42LTMuNSAzLjVWMjBINS44Yy0xIDAtMS44LS44LTEuOC0xLjhWNS44QzQgNC44IDQuOCA0IDUuOCA0aDEyLjVjMSAwIDEuOC44IDEuOCAxLjhWMTVtLTQuOS02LjggMS41IDEuNS02IDYtMy41LTMuNSAxLjUtMS41IDIgMnoiIC8+PC9zdmc+) </span> <span class="md-content__button md-icon .md-status--published" title="Valid from 2024-12-20"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE5IDE5SDVWOGgxNG0wLTVoLTFWMWgtMnYySDhWMUg2djJINWEyIDIgMCAwIDAtMiAydjE0YTIgMiAwIDAgMCAyIDJoMTRhMiAyIDAgMCAwIDItMlY1YTIgMiAwIDAgMC0yLTJtLTIuNDcgOC4wNkwxNS40NyAxMGwtNC44OCA0Ljg4LTIuMTItMi4xMi0xLjA2IDEuMDZMMTAuNTkgMTd6IiAvPjwvc3ZnPg==) </span> <span class="md-content__button md-icon actions-date" title="Published on 2024-10-12">![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTkgMTB2Mkg3di0yem00IDB2MmgtMnYtMnptNCAwdjJoLTJ2LTJ6bTItN2EyIDIgMCAwIDEgMiAydjE0YTIgMiAwIDAgMS0yIDJINWEyIDIgMCAwIDEtMi0yVjVhMiAyIDAgMCAxIDItMmgxVjFoMnYyaDhWMWgydjJ6bTAgMTZWOEg1djExek05IDE0djJIN3YtMnptNCAwdjJoLTJ2LTJ6bTQgMHYyaC0ydi0yeiIgLz48L3N2Zz4=)</span> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/edit/main/docs/patterns/compute-on-demand/0070-on-demand-capacity-reservations.md" class="md-content__button md-icon" title="Edit this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTEwIDIwSDZWNGg3djVoNXYzLjFsMi0yVjhsLTYtNkg2Yy0xLjEgMC0yIC45LTIgMnYxNmMwIDEuMS45IDIgMiAyaDR6bTEwLjItN2MuMSAwIC4zLjEuNC4ybDEuMyAxLjNjLjIuMi4yLjYgMCAuOGwtMSAxLTIuMS0yLjEgMS0xYy4xLS4xLjItLjIuNC0uMm0wIDMuOUwxNC4xIDIzSDEydi0yLjFsNi4xLTYuMXoiIC8+PC9zdmc+" /></a> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/blob/main/docs/patterns/compute-on-demand/0070-on-demand-capacity-reservations.md" class="md-content__button md-icon" title="View source of this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE3IDE4Yy41NiAwIDEgLjQ0IDEgMXMtLjQ0IDEtMSAxLTEtLjQ0LTEtMSAuNDQtMSAxLTFtMC0zYy0yLjczIDAtNS4wNiAxLjY2LTYgNCAuOTQgMi4zNCAzLjI3IDQgNiA0czUuMDYtMS42NiA2LTRjLS45NC0yLjM0LTMuMjctNC02LTRtMCA2LjVhMi41IDIuNSAwIDAgMS0yLjUtMi41IDIuNSAyLjUgMCAwIDEgMi41LTIuNSAyLjUgMi41IDAgMCAxIDIuNSAyLjUgMi41IDIuNSAwIDAgMS0yLjUgMi41TTkuMjcgMjBINlY0aDd2NWg1djQuMDdjLjcuMDggMS4zNi4yNSAyIC40OVY4bC02LTZINmEyIDIgMCAwIDAtMiAydjE2YTIgMiAwIDAgMCAyIDJoNC41YTguMiA4LjIgMCAwIDEtMS4yMy0yIiAvPjwvc3ZnPg==" /></a>

Document Metadata

|  |  |
|----|----|
| Identifier | **`LMP-PAT-0070`** |
| Type | **Technical Design Pattern** |
| Status | **Published** |
| Approvals | <span class="md-tag">LMP Migration Architecture Approval</span> |
| Governance Reference | **[]()** |
| Pattern Source Repo | []() |
| Published on | **October 12, 2024** |
| Valid From | **December 20, 2024** |
| Authors | <span class="md-source-file__fact"> </span> |
| Tags | <span class="md-tag">Compute on Demand</span> |
| Technology Capabilities | <span class="md-tag">Infrastructure / Compute / Compute on Demand</span> |

# On-demand capacity reservation<a href="#on-demand-capacity-reservation" class="headerlink" title="Permanent link">¶</a>

## Introduction<a href="#introduction" class="headerlink" title="Permanent link">¶</a>

On-demand capacity reservations in Azure provide a flexible way to reserve compute capacity without the long-term commitment of traditional reserved instances. This allows you to scale your resources up or down as needed, ensuring that you have the capacity to meet your workload demands.

Capacity reservation has some basic properties that are always defined at the time of creation:

*VM size*: Each reservation is for one virtual machine (VM) size. An example is Standard_D2s_v3.  
*Location*: Each reservation is for one location (region). If that location has availability zones, the reservation can also specify one of the zones.  
*Quantity*: Each reservation has a quantity of instances to be reserved.

### Context and Problem<a href="#context-and-problem" class="headerlink" title="Permanent link">¶</a>

During the patch management or reboot of the VM instance in LSEG environment, the VM are facing the capacity issue. To ensure the VMs have assured capacity in the subscription, there is a need to reserve capacity in Azure by using On Demand Capacity reservation.

Hence to proactively address potential capacity bottlenecks during VM maintenance operations in the LSEG environment, we suggest utilizing Azure's On-Demand Capacity Reservations. This will allocate dedicated capacity to the VMs, ensuring uninterrupted service delivery.

## Scope<a href="#scope" class="headerlink" title="Permanent link">¶</a>

The aim of this pattern is to:

Reserve compute capacity without the long-term commitment of traditional Reserved Instances. This feature is primarily applicable to Azure Virtual Machines.

## Use Cases<a href="#use-cases" class="headerlink" title="Permanent link">¶</a>

### Bursty Workloads<a href="#bursty-workloads" class="headerlink" title="Permanent link">¶</a>

- Allocate dedicated capacity to the VMs,so that the VM will not face the capacity issue after patching or reboot.

<!-- -->

- Providing capacity for sudden spikes in demand, such as during promotional events or unexpected traffic surges.

### Mission-Critical Workloads<a href="#mission-critical-workloads" class="headerlink" title="Permanent link">¶</a>

- Ensuring availability of critical applications during peak usage or maintenance windows. Guaranteeing consistent performance for business-critical services.

### Testing and Development Environments<a href="#testing-and-development-environments" class="headerlink" title="Permanent link">¶</a>

- Allocating dedicated capacity for testing and development activities.

<!-- -->

- Ensuring consistent performance for CI/CD pipelines and other development workflows.

## Functional Requirements<a href="#functional-requirements" class="headerlink" title="Permanent link">¶</a>

On-Demand Capacity Reservations in Azure provide a dynamic way to reserve compute capacity without the long-term commitment of traditional Reserved Instances. Here's the core components for implementing this feature:

### Core Components<a href="#core-components" class="headerlink" title="Permanent link">¶</a>

#### Capacity Reservation Group<a href="#capacity-reservation-group" class="headerlink" title="Permanent link">¶</a>

- A logical container for related capacity reservations.
- Defines the region and availability zone where the reservations will be allocated.

#### Capacity Reservations<a href="#capacity-reservations" class="headerlink" title="Permanent link">¶</a>

- Individual reservations within the group.
- Specify the VM size, quantity, and duration of the reservation.

#### Virtual Machines (VMs)<a href="#virtual-machines-vms" class="headerlink" title="Permanent link">¶</a>

- Instances of the reserved capacity.
- Deployed within the capacity reservation group to leverage the guaranteed capacity.

### Key Features<a href="#key-features" class="headerlink" title="Permanent link">¶</a>

• *Pay-as-you-go*: You only pay for the reserved capacity when it's in use.  
• *No Long-Term Commitment*: Create and delete reservations as needed, offering greater flexibility.  
• *SLA-Backed Capacity*: Once a reservation is created, Azure guarantees the availability of the reserved capacity, ensuring your workloads can run smoothly.  
• *Prioritized Access*: Your VMs using the reserved capacity have priority access to the reserved resources, minimizing the risk of capacity constraints.  
• *Cost Optimization*: While there are no upfront discounts like with reserved instances, on-demand capacity reservations can still help optimize costs by providing consistent pricing and avoiding unexpected spikes in usage.

### Benefits of capacity reservation<a href="#benefits-of-capacity-reservation" class="headerlink" title="Permanent link">¶</a>

• After deployment, capacity is reserved for your use and is always available within the scope of applicable service-level agreements (SLAs).  
• Capacity can be deployed and deleted at any time with no term commitment.  
• Capacity can be combined automatically with reserved instances to use term-commitment discounts.  

### Limitations and restrictions<a href="#limitations-and-restrictions" class="headerlink" title="Permanent link">¶</a>

• Creating capacity reservations requires a quota in the same manner as when you create VMs.  
• Creating capacity reservations is currently limited to certain VM series and sizes. The compute Resource SKUs list advertises the set of supported VM sizes.  
• The following VM series support the creation of capacity reservations:

- Av2
- B
- Bpsv2
- Bsv2 (Intel) and Basv2 (AMD)
- D and Ds series, v2 and newer; AMD and Intel
- Dadsv5
- Dav4 series
- Dasv4 and newer
- Ddv4 and v5 series
- Dds series, v4 and newer
- Dlsv5 and newer series
- Dldsv5 and newer series
- DCsv2 series
- DCasv5 and DCadsv5 series
- DCesv5 and DCedsv5 series
- ECasv5 and ECadsv5 series
- ECesv5 and ECedsv5 series
- Dplsv5 and newer series
- Dps and Dpds series, v5 and newer
- Dplds series, v5 and newer
- Eps and Epds series, v5 and newer
- E series, all versions; AMD and Intel
- Eav4 and Easv4 series
- Easv5 and Eadsv5 series
- Ebdsv5 and Ebsv5 series
- Ed and Eds series, v4 and newer
- F series, all versions
- Fx series
- Lsv3 (Intel) and Lasv3 (AMD)

### How to Use On-Demand Capacity Reservations<a href="#how-to-use-on-demand-capacity-reservations" class="headerlink" title="Permanent link">¶</a>

1.  Create a Capacity Reservation Group: This groups together related reservations for easier management.
2.  Create Capacity Reservations: Specify the VM size, region, availability zone, and quantity of instances to reserve.
3.  Deploy VMs: When deploying VMs, assign them to the created capacity reservation group.

## Decision Tree Diagram<a href="#decision-tree-diagram" class="headerlink" title="Permanent link">¶</a>

![Decision tree](0070-on-demand-capacity-reservations.assets/image-001.png)

### Difference between on-demand capacity reservation and reserved instances<a href="#difference-between-on-demand-capacity-reservation-and-reserved-instances" class="headerlink" title="Permanent link">¶</a>

| On-demand capacity reservation | Reserved Instances |
|----|----|
| No term commitment required. Can be created and deleted as per the customer requirement. | Fixed-term commitment of either 1 or 3 years. |
| Can be deployed per region or per availability zone. | Only available at the regional level. |
| Charged at pay-as-you-go rates for the underlying VM size | Significant cost savings over pay-as-you-go rates |
| Provides capacity guarantee in the specified location (region or availability zone). | Doesn't provide a capacity guarantee. Customers can choose Capacity priority to gain better access, but that option doesn't carry an SLA. |

## Further Reading<a href="#further-reading" class="headerlink" title="Permanent link">¶</a>

[Capacity Reservation Documentation - MS Learn](https://learn.microsoft.com/en-us/azure/virtual-machines/capacity-reservation-overview#difference-between-on-demand-capacity-reservation-and-reserved-instances)

<span class="md-source-file__fact"> <span class="md-icon" title="Last update"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIxIDEzLjFjLS4xIDAtLjMuMS0uNC4ybC0xIDEgMi4xIDIuMSAxLTFjLjItLjIuMi0uNiAwLS44bC0xLjMtMS4zYy0uMS0uMS0uMi0uMi0uNC0uMm0tMS45IDEuOC02LjEgNlYyM2gyLjFsNi4xLTYuMXpNMTIuNSA3djUuMmw0IDIuNC0xIDFMMTEgMTNWN3pNMTEgMjEuOWMtNS4xLS41LTktNC44LTktOS45QzIgNi41IDYuNSAyIDEyIDJjNS4zIDAgOS42IDQuMSAxMCA5LjMtLjMtLjEtLjYtLjItMS0uMnMtLjcuMS0xIC4yQzE5LjYgNy4yIDE2LjIgNCAxMiA0Yy00LjQgMC04IDMuNi04IDggMCA0LjEgMy4xIDcuNSA3LjEgNy45bC0uMS4yeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="February 18, 2025 12:03:23 UTC">February 18, 2025</span> </span> <span class="md-source-file__fact"> <span class="md-icon" title="Created"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE0LjQ3IDE1LjA4IDExIDEzVjdoMS41djUuMjVsMy4wOCAxLjgzYy0uNDEuMjgtLjc5LjYyLTEuMTEgMW0tMS4zOSA0Ljg0Yy0uMzYuMDUtLjcxLjA4LTEuMDguMDgtNC40MiAwLTgtMy41OC04LThzMy41OC04IDgtOCA4IDMuNTggOCA4YzAgLjM3LS4wMy43Mi0uMDggMS4wOC42OS4xIDEuMzMuMzIgMS45Mi42NC4xLS41Ni4xNi0xLjEzLjE2LTEuNzIgMC01LjUtNC41LTEwLTEwLTEwUzIgNi41IDIgMTJzNC40NyAxMCAxMCAxMGMuNTkgMCAxLjE2LS4wNiAxLjcyLS4xNi0uMzItLjU5LS41NC0xLjIzLS42NC0xLjkyTTE4IDE1djNoLTN2MmgzdjNoMnYtM2gzdi0yaC0zdi0zeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="December 19, 2024 15:54:01 UTC">December 19, 2024</span> </span>

<a href="../0056-functions-service-pattern/" class="md-footer__link md-footer__link--prev" aria-label="Previous: Azure Functions Service Pattern"></a>

<div class="md-footer__button md-icon">

![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIwIDExdjJIOGw1LjUgNS41LTEuNDIgMS40Mkw0LjE2IDEybDcuOTItNy45MkwxMy41IDUuNSA4IDExeiIgLz48L3N2Zz4=)

</div>

<div class="md-footer__title">

<span class="md-footer__direction"> Previous </span>

<div class="md-ellipsis">

Azure Functions Service Pattern

</div>

</div>

<a href="../../data-analytics-and-visualizations/0047-machine-learning-migrations/" class="md-footer__link md-footer__link--next" aria-label="Next: Machine learning workloads migration to Azure"></a>

<div class="md-footer__title">

<span class="md-footer__direction"> Next </span>

<div class="md-ellipsis">

Machine learning workloads migration to Azure

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
