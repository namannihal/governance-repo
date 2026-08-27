---
id: LMP-ADR-0017
type: ADR
status: published
date: 2026-05-01
valid_from: 2026-05-01
approved_by:
  - LMP Migration Architecture Approval
tags:
  - Foundation Platform
tech_capabilities:
- Delivery / Operations / Deployment & Administration
---

# Azure Reservations for Production Baseload

## Context

Azure Reservations or Reserved Instances (RIs) are a cost optimisation mechanism for
committed Azure compute usage. They provide a billing discount for eligable resources and
should be considered for stable, predictable production demand.

RIs are not recommended for non-production environments or for demand that is elastic, autoscaled, temporary
(under 1 year), or otherwise uncertain.
Microsoft allows eligible reservations to be exchanged but this is processed as a refund
and repurchase, with the new reservation starting a new term from the point of exchange and
only within the same product family.

This ADR sets the policy for when Azure RIs should and should not be used. Capacity
assurance is out of scope and is covered by the relevant [Capacity Reservation ADR](https://app.pages.dx1.lseg.com/app-51723/migration-patterns/mig-pat-source-to-target/adrs/infrastructure/0025-Azure-capacity-reservation/).

## Decision

- If applicable, Application teams **MUST** first identify:
    - **baseload**: the minimum compute footprint continuously required for production
    - **elastic load**: variable demand driven by autoscale, peak events, batch windows, failover patterns, or temporary
  growth
- Reserved Instances **SHOULD** be used only for stable production baseload that can be evidenced from actual usage
and mapped to the target SKU, region, and scope.
- Reserved Instances **MUST NOT** be used for elastic, autoscaled, burst, or intermittently consumed demand.
- Reserved Instances **MUST NOT** be used in non-production environments, these are expected to be shutdown outside of
active use, see [LMP-ADR-0017](https://app.pages.dx1.lseg.com/app-51723/migration-patterns/mig-pat-source-to-target/adrs/foundation-platform/0017-reserved-instances-for-production-baseload/).
- Reserved Instances **MUST NOT** be used to cover theoretical maximum scale.
- The default commitment term for eligible baseload is **1 year**.
- A **3-year** Reserved Instance **MAY** be used where the team can evidence stable multi-year demand and low
likelihood of material SKU or architecture change.
- Exchange flexibility **MAY** be used where an existing RI remains appropriate but needs adjustment.
- Reservation coverage **MUST** be reviewed periodically to confirm that purchased commitment still matches actual
stable consumption.
- Where guaranteed compute availability is required, teams **MUST** refer to the relevant Capacity Reservation ADR, as
this ADR does not cover capacity assurance.

## Consequences

### Positive

- RIs are applied only where they fit the workload shape.
- Stable production baseload can benefit from lower cost through committed usage discounts.
- Non-production environments are protected from unnecessary long-term commitment.
- Elastic demand remains outside RI coverage.
- The policy gives a clear default of **1-year RI** for eligible baseload.
- A controlled route remains available for **3-year RI** where evidence supports it.

### Negative

- Teams must assess baseload and reservation fit before purchase.
- Some workloads may realise less discount where the default is **1-year** rather than **3-year**.
- RI coverage requires periodic review to confirm that it still matches actual stable consumption.

## References

- Microsoft Learn – [What are Azure Reservations?](https://learn.microsoft.com/en-us/azure/cost-management-billing/reservations/save-compute-costs-reservations)
- Microsoft Learn – [Self-service exchanges and refunds for Azure Reservations](https://learn.microsoft.com/en-us/azure/cost-management-billing/reservations/exchange-and-refund-azure-reservations)
- Related ADR –
  [On-demand capacity reservation](https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/-/blob/234ca8bc50dde81506af033e2031570636685f64/docs/patterns/compute-on-demand/0070-on-demand-capacity-reservations.md)
- Relarted ADR - [Lower Environment Shutdown for Cost Optimisation](https://app.pages.dx1.lseg.com/app-51723/migration-patterns/mig-pat-source-to-target/adrs/foundation-platform/0019-lower-env-shutdown/)

