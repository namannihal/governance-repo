<span class="md-content__button md-icon md-status--draft" href="#" title="Status: Draft"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCA1MTIgNTEyIj48IS0tISBGb250IEF3ZXNvbWUgRnJlZSA3LjAuMCBieSBAZm9udGF3ZXNvbWUgLSBodHRwczovL2ZvbnRhd2Vzb21lLmNvbSBMaWNlbnNlIC0gaHR0cHM6Ly9mb250YXdlc29tZS5jb20vbGljZW5zZS9mcmVlIChJY29uczogQ0MgQlkgNC4wLCBGb250czogU0lMIE9GTCAxLjEsIENvZGU6IE1JVCBMaWNlbnNlKSBDb3B5cmlnaHQgMjAyNSBGb250aWNvbnMsIEluYy4tLT48cGF0aCBmaWxsPSJjdXJyZW50Q29sb3IiIGQ9Im05OS4zIDI1Ni4xIDY5LjQtMTE5LjljLTUuNi0xMi4yLTguOC0yNS44LTguOC00MC4yIDAtNTMgNDMtOTYgOTYtOTZzOTYgNDMgOTYgOTZjMCAxNC4zLTMuMSAyNy45LTguOCA0MC4ybDQ0LjQgNzYuN2MtMjMuMSAyNi01My43IDQ1LjEtODguNCA1My44TDI1NiAxOTEuOWwtNjguMSAxMTcuNmMyMS41IDYuOCA0NC4zIDEwLjUgNjguMSAxMC41IDcwLjcgMCAxMzMuOC0zMi43IDE3NC45LTg0IDExLjEtMTMuOCAzMS4yLTE2IDQ1LTVzMTYgMzEuMiA1IDQ1QzQyOC4yIDM0MS44IDM0NyAzODQgMjU2LjEgMzg0Yy0zNS40IDAtNjkuNC02LjQtMTAwLjctMTguMWwtNTYuNyA5Ny44Yy00LjcgOC4xLTExLjcgMTQuNy0yMC4xIDE4LjlsLTU1LjQgMjcuN2MtNSAyLjUtMTAuOSAyLjItMTUuNi0uN1MwIDUwMS41IDAgNDk2di01NS40YzAtOC40IDIuMi0xNi43IDYuNS0yNC4xbDYwLTEwMy43Yy0xMi44LTExLjItMjQuNi0yMy41LTM1LjMtMzYuOC0xMS4xLTEzLjgtOC44LTMzLjkgNS00NXMzMy45LTguOCA0NSA1YzUuNyA3LjEgMTEuOCAxMy44IDE4LjIgMjAuMXptMjgxLjggMTUxLjhjMzIuNS0xMyA2Mi40LTMxIDg4LjktNTIuOWwzNS42IDYxLjVjNC4yIDcuMyA2LjUgMTUuNiA2LjUgMjQuMVY0OTZjMCA1LjUtMi45IDEwLjctNy42IDEzLjZzLTEwLjYgMy4yLTE1LjYuN2wtNTUuNC0yNy43Yy04LjQtNC4yLTE1LjQtMTAuOC0yMC4xLTE4Ljl6TTI1NiAxMjhhMzIgMzIgMCAxIDAgMC02NCAzMiAzMiAwIDEgMCAwIDY0IiAvPjwvc3ZnPg==) </span> <span class="md-content__button md-icon actions-date" title="Published on 2024-08-19">![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTkgMTB2Mkg3di0yem00IDB2MmgtMnYtMnptNCAwdjJoLTJ2LTJ6bTItN2EyIDIgMCAwIDEgMiAydjE0YTIgMiAwIDAgMS0yIDJINWEyIDIgMCAwIDEtMi0yVjVhMiAyIDAgMCAxIDItMmgxVjFoMnYyaDhWMWgydjJ6bTAgMTZWOEg1djExek05IDE0djJIN3YtMnptNCAwdjJoLTJ2LTJ6bTQgMHYyaC0ydi0yeiIgLz48L3N2Zz4=)</span> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/edit/main/docs/adrs/infrastructure/0025-Azure-capacity-reservation.md" class="md-content__button md-icon" title="Edit this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTEwIDIwSDZWNGg3djVoNXYzLjFsMi0yVjhsLTYtNkg2Yy0xLjEgMC0yIC45LTIgMnYxNmMwIDEuMS45IDIgMiAyaDR6bTEwLjItN2MuMSAwIC4zLjEuNC4ybDEuMyAxLjNjLjIuMi4yLjYgMCAuOGwtMSAxLTIuMS0yLjEgMS0xYy4xLS4xLjItLjIuNC0uMm0wIDMuOUwxNC4xIDIzSDEydi0yLjFsNi4xLTYuMXoiIC8+PC9zdmc+" /></a> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/blob/main/docs/adrs/infrastructure/0025-Azure-capacity-reservation.md" class="md-content__button md-icon" title="View source of this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE3IDE4Yy41NiAwIDEgLjQ0IDEgMXMtLjQ0IDEtMSAxLTEtLjQ0LTEtMSAuNDQtMSAxLTFtMC0zYy0yLjczIDAtNS4wNiAxLjY2LTYgNCAuOTQgMi4zNCAzLjI3IDQgNiA0czUuMDYtMS42NiA2LTRjLS45NC0yLjM0LTMuMjctNC02LTRtMCA2LjVhMi41IDIuNSAwIDAgMS0yLjUtMi41IDIuNSAyLjUgMCAwIDEgMi41LTIuNSAyLjUgMi41IDAgMCAxIDIuNSAyLjUgMi41IDIuNSAwIDAgMS0yLjUgMi41TTkuMjcgMjBINlY0aDd2NWg1djQuMDdjLjcuMDggMS4zNi4yNSAyIC40OVY4bC02LTZINmEyIDIgMCAwIDAtMiAydjE2YTIgMiAwIDAgMCAyIDJoNC41YTguMiA4LjIgMCAwIDEtMS4yMy0yIiAvPjwvc3ZnPg==" /></a>

Document Metadata

|  |  |
|----|----|
| Identifier | **`LMP-ADR-0025`** |
| Type | **ADR** |
| Status | **Draft** |
| Published on | **August 19, 2024** |
| Authors | <span class="md-source-file__fact"> </span> |
| Tags | <span class="md-tag">Compute on Demand</span> |
| Technology Capabilities | <span class="md-tag">Delivery / Operations / IT Service Management / Capacity Management</span> |

# Azure Capacity Reservations for Critical Workloads<a href="#azure-capacity-reservations-for-critical-workloads" class="headerlink" title="Permanent link">¶</a>

## Context and Problem Statement<a href="#context-and-problem-statement" class="headerlink" title="Permanent link">¶</a>

As part of our cloud infrastructure strategy, we rely heavily on Azure Virtual Machines (VMs) to support critical workloads across data and analytics platforms. These workloads demand predictable performance and guaranteed availability, especially during peak periods or disaster recovery scenarios.

Standard VM provisioning has led to capacity constraints and deployment delays. Azure Capacity Reservations allow us to reserve compute capacity in specific regions and availability zones for selected VM sizes, ensuring availability when needed.

### Real-World Scenarios<a href="#real-world-scenarios" class="headerlink" title="Permanent link">¶</a>

- If Azure region runs out of capacity due to high demand, any action that deallocates a VM (updating a golden image) may result in losing the capacity to another user.
- If the host hypervisor fails, the VM may not be reallocated without a reservation.
- Capacity Reservations provide SLA-backed guarantees that VMs can be reallocated and gain priority over standard deployments.

## Decision Drivers<a href="#decision-drivers" class="headerlink" title="Permanent link">¶</a>

- High availability and disaster recovery requirements
- Predictable usage patterns for Tier 1, Tier2 and IBS workloads
- Performance sensitivity of critical applications
- Need for cost optimization and governance
- Centralized infrastructure planning and control

## Decision Outcome<a href="#decision-outcome" class="headerlink" title="Permanent link">¶</a>

We will adopt a tiered and cost-optimized strategy for VM provisioning using **Azure Capacity Reservations** in combination with **Azure Reserved Instances**:

- **Tier 1, Tier 2, and IBS Critical Workloads** should define a **baseline (baseload) number of instances** required for continuous operation . These baseline instances should use **Capacity Reservations** to guarantee availability and **Reserved Instances** to optimize cost (Strongly recommended).

<!-- -->

- **Elastic or Max Capacity** (used during peak loads or scaling events) can be provisioned using **Spot VMs** or **On-Demand VMs**, depending on workload tolerance and cost considerations.

<!-- -->

- **Tier 3,Tier 4 and Tier 5 Workloads** may decide based on specific requirements and could use **Capacity Reservations** for baseline workloads to ensure availability and reduce risk.

### Example Scenario<a href="#example-scenario" class="headerlink" title="Permanent link">¶</a>

A Tier 1 analytics platform requires 20 VMs for baseline operations and can scale up to 50 VMs during peak hours.

- The team reserves 20 VMs using **Azure Capacity Reservations** to ensure guaranteed availability.
- These 20 VMs are also covered by **Azure Reserved Instances** to reduce cost.
- The additional 30 VMs are provisioned using **Spot** or **On-Demand VMs** to handle elastic demand.

This strategy ensures high availability, cost efficiency, and disaster recovery readiness. It also protects against real-world risks such as:

- Losing VM capacity during image updates or deallocation
- Inability to reallocate VMs after hypervisor failure
- Competing with other users during regional capacity shortages

![Capacity Reservation Decision Tree](0025-Azure-capacity-reservation.assets/image-001.svg)

## Consequences<a href="#consequences" class="headerlink" title="Permanent link">¶</a>

- **Good**: Guaranteed availability for critical workloads
- **Good**: Improved deployment reliability and disaster recovery performance
- **Good**: Cost optimization through strategic reservation planning
- **Bad**: Potential underutilization if reservations are not actively managed
- **Bad**: Requires governance and quarterly review

## Confirmation<a href="#confirmation" class="headerlink" title="Permanent link">¶</a>

Implementation will be confirmed through:

- Quarterly reviews by the Cloud Infrastructure team
- Monitoring usage and reservation alignment
- Integration with cost management and governance tools

## More Information<a href="#more-information" class="headerlink" title="Permanent link">¶</a>

### Implementation Plan<a href="#implementation-plan" class="headerlink" title="Permanent link">¶</a>

1.  Identify eligible workloads
2.  Define reservation scope (VM sizes, regions, zones)
3.  Define baseline instance requirements for Tier 1, Tier2 and IBS workloads
4.  Create Capacity Reservations for baseline
5.  Monitor and adjust quarterly
6.  Integrate with cost management and governance processes

### References<a href="#references" class="headerlink" title="Permanent link">¶</a>

- [Azure Capacity Reservations Overview](https://learn.microsoft.com/en-us/azure/virtual-machines/capacity-reservation-overview)
- [Modify Reservations](https://learn.microsoft.com/en-us/azure/virtual-machines/capacity-reservation-modify)
- [Associate VMs](https://learn.microsoft.com/en-us/azure/virtual-machines/capacity-reservation-associate-vm)
- [Terraform Registry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/capacity_reservation)

<span class="md-source-file__fact"> <span class="md-icon" title="Last update"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIxIDEzLjFjLS4xIDAtLjMuMS0uNC4ybC0xIDEgMi4xIDIuMSAxLTFjLjItLjIuMi0uNiAwLS44bC0xLjMtMS4zYy0uMS0uMS0uMi0uMi0uNC0uMm0tMS45IDEuOC02LjEgNlYyM2gyLjFsNi4xLTYuMXpNMTIuNSA3djUuMmw0IDIuNC0xIDFMMTEgMTNWN3pNMTEgMjEuOWMtNS4xLS41LTktNC44LTktOS45QzIgNi41IDYuNSAyIDEyIDJjNS4zIDAgOS42IDQuMSAxMCA5LjMtLjMtLjEtLjYtLjItMS0uMnMtLjcuMS0xIC4yQzE5LjYgNy4yIDE2LjIgNCAxMiA0Yy00LjQgMC04IDMuNi04IDggMCA0LjEgMy4xIDcuNSA3LjEgNy45bC0uMS4yeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="September 22, 2025 07:26:50 UTC">September 22, 2025</span> </span> <span class="md-source-file__fact"> <span class="md-icon" title="Created"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE0LjQ3IDE1LjA4IDExIDEzVjdoMS41djUuMjVsMy4wOCAxLjgzYy0uNDEuMjgtLjc5LjYyLTEuMTEgMW0tMS4zOSA0Ljg0Yy0uMzYuMDUtLjcxLjA4LTEuMDguMDgtNC40MiAwLTgtMy41OC04LThzMy41OC04IDgtOCA4IDMuNTggOCA4YzAgLjM3LS4wMy43Mi0uMDggMS4wOC42OS4xIDEuMzMuMzIgMS45Mi42NC4xLS41Ni4xNi0xLjEzLjE2LTEuNzIgMC01LjUtNC41LTEwLTEwLTEwUzIgNi41IDIgMTJzNC40NyAxMCAxMCAxMGMuNTkgMCAxLjE2LS4wNiAxLjcyLS4xNi0uMzItLjU5LS41NC0xLjIzLS42NC0xLjkyTTE4IDE1djNoLTN2MmgzdjNoMnYtM2gzdi0yaC0zdi0zeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="September 22, 2025 07:26:50 UTC">September 22, 2025</span> </span>

<a href="../../foundation-platform/0019-lower-env-shutdown/" class="md-footer__link md-footer__link--prev" aria-label="Previous: ADR: Lower Environment Shutdown for Cost Optimisation"></a>

<div class="md-footer__button md-icon">

![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIwIDExdjJIOGw1LjUgNS41LTEuNDIgMS40Mkw0LjE2IDEybDcuOTItNy45MkwxMy41IDUuNSA4IDExeiIgLz48L3N2Zz4=)

</div>

<div class="md-footer__title">

<span class="md-footer__direction"> Previous </span>

<div class="md-ellipsis">

ADR: Lower Environment Shutdown for Cost Optimisation

</div>

</div>

<a href="../../network/0005-packet-filtering-and-nat/" class="md-footer__link md-footer__link--next" aria-label="Next: Use Azure Firewall for Traffic Filtering and Network Address Translation"></a>

<div class="md-footer__title">

<span class="md-footer__direction"> Next </span>

<div class="md-ellipsis">

Use Azure Firewall for Traffic Filtering and Network Address Translation

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
