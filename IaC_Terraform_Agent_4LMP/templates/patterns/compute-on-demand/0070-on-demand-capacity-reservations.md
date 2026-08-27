---
id: LMP-PAT-0070
type: Technical Design Pattern
status: published
approved_by:
  - LMP Migration Architecture Approval
valid_from: 2024-12-20
date: 2024-10-12
tags:
  - Compute on Demand
tech_capabilities:
  - Infrastructure / Compute / Compute on Demand
---

# On-demand capacity reservation

## Introduction

On-demand capacity reservations in Azure provide a flexible way to reserve compute capacity without the long-term
commitment of traditional reserved instances. This allows you to scale your resources up or down as needed, ensuring
that you have the capacity to meet your workload demands.

Capacity reservation has some basic properties that are always defined at the time of creation:

*VM size*: Each reservation is for one virtual machine (VM) size. An example is Standard_D2s_v3.<br>
*Location*: Each reservation is for one location (region). If that location has availability zones, the reservation
can also specify one of the zones.<br>
*Quantity*: Each reservation has a quantity of instances to be reserved.

### Context and Problem

During the patch management or reboot of the VM instance in LSEG environment, the VM are facing the capacity issue.
To ensure the VMs have assured capacity in the subscription, there is a need to reserve capacity in Azure by using
On Demand Capacity reservation.

Hence to proactively address potential capacity bottlenecks during VM maintenance operations in the LSEG environment,
we suggest utilizing Azure's On-Demand Capacity Reservations. This will allocate dedicated capacity to the VMs,
ensuring uninterrupted service delivery.

## Scope

The aim of this pattern is to:

 Reserve compute capacity without the long-term commitment of traditional Reserved Instances. This feature is
 primarily applicable to Azure Virtual Machines.

## Use Cases

### Bursty Workloads

- Allocate dedicated capacity to the VMs,so that the VM will not face the capacity issue after patching or reboot.

- Providing capacity for sudden spikes in demand, such as during promotional events or unexpected traffic surges.

### Mission-Critical Workloads

- Ensuring availability of critical applications during peak usage or maintenance windows.
Guaranteeing consistent performance for business-critical services.

### Testing and Development Environments

- Allocating dedicated capacity for testing and development activities.

- Ensuring consistent performance for CI/CD pipelines and other development workflows.

## Functional Requirements

On-Demand Capacity Reservations in Azure provide a dynamic way to reserve compute capacity without the long-term
commitment of traditional Reserved Instances. Here's the core components for implementing this feature:

### Core Components

#### Capacity Reservation Group

- A logical container for related capacity reservations.
- Defines the region and availability zone where the reservations will be allocated.

#### Capacity Reservations

- Individual reservations within the group.
- Specify the VM size, quantity, and duration of the reservation.

#### Virtual Machines (VMs)

- Instances of the reserved capacity.
- Deployed within the capacity reservation group to leverage the guaranteed capacity.

### Key Features

• *Pay-as-you-go*: You only pay for the reserved capacity when it's in use.<br>
• *No Long-Term Commitment*: Create and delete reservations as needed, offering greater flexibility.<br>
• *SLA-Backed Capacity*: Once a reservation is created, Azure guarantees the availability of the reserved capacity,
ensuring your workloads can run smoothly.<br>
• *Prioritized Access*: Your VMs using the reserved capacity have priority access to the reserved resources,
minimizing the risk of capacity constraints.<br>
• *Cost Optimization*: While there are no upfront discounts like with reserved instances, on-demand capacity
reservations can still help optimize costs by providing consistent pricing and avoiding unexpected spikes in usage.

### Benefits of capacity reservation

• After deployment, capacity is reserved for your use and is always available within the scope of applicable
service-level agreements (SLAs).<br>
• Capacity can be deployed and deleted at any time with no term commitment.<br>
• Capacity can be combined automatically with reserved instances to use term-commitment discounts.<br>

### Limitations and restrictions

• Creating capacity reservations requires a quota in the same manner as when you create VMs.<br>
• Creating capacity reservations is currently limited to certain VM series and sizes. The compute Resource SKUs list
advertises the set of supported VM sizes.<br>
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

### How to Use On-Demand Capacity Reservations

1. Create a Capacity Reservation Group: This groups together related reservations for easier management.
2. Create Capacity Reservations: Specify the VM size, region, availability zone, and quantity of instances to reserve.
3. Deploy VMs: When deploying VMs, assign them to the created capacity reservation group.

## Decision Tree Diagram

![Decision tree](img/0070-decision-tree.png)

### Difference between on-demand capacity reservation and reserved instances

|On-demand capacity reservation                                                               | Reserved Instances                                                                                                                        |
|---------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------|
| No term commitment required. Can be created and deleted as per the customer requirement.    | Fixed-term commitment of either 1 or 3 years.                                                                                             |
| Can be deployed per region or per availability zone.                                        | Only available at the regional level.                                                                                                     |
| Charged at pay-as-you-go rates for the underlying VM size                                   | Significant cost savings over pay-as-you-go rates                                                                                         |
| Provides capacity guarantee in the specified location (region or availability zone).        | Doesn't provide a capacity guarantee. Customers can choose Capacity priority to gain better access, but that option doesn't carry an SLA. |

## Further Reading

[Capacity Reservation Documentation - MS Learn](https://learn.microsoft.com/en-us/azure/virtual-machines/capacity-reservation-overview#difference-between-on-demand-capacity-reservation-and-reserved-instances)

