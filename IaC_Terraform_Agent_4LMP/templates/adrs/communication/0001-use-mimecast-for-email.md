---
id: LMP-ADR-0001
type: ADR
status: published
approved_by:
  - LMP Migration Architecture Approval
date: 2023-11-01
valid_from: 2024-05-25
developer_productivity_hrs: 5
tags:
  - Communication
tech_capabilities:
  - Workplace / Communication & Collaboration / Communication
---

# Use Mimecast as a secure email service

## Context and Problem Statement

In the context of the Atlassian suite, an email service is needed to deliver messages securely to users - e.g.
notifications of changed content, password resets and other alerts.

<!-- This is an optional element. Feel free to remove. -->

## Decision Drivers

- Atlassian suite being replatformed to Azure as an accelerated app under LMP

## Considered Options

- Central LSEG Mimecast service
- AWS Simple Email Service (SES)
- Azure Communication Service (ACS)

## Decision Outcome

Chosen option: Central LSEG Mimecast service, because

- only option which meets requirement to prevent emails from being sent to non lseg.com addresses

<!-- This is an optional element. Feel free to remove. -->

### Consequences

- Good, because all security requirements continue to be met
- Good, because the service is provided by a managed LSEG platform
- Bad, because the service is not encapsulated within Azure, meaning we cannot take advantage of Azure native identity,
  observability, etc.

<!-- This is an optional element. Feel free to remove. -->

## Validation

The decision was validated by the CTEF process,
see [Architecture Governance item - GOVI0001229](https://lseg.service-now.com/x/lsegp/cto/record/x_lsegp_eag_governance_item/d2a836221b71f590a3a9337f034bcb00).

<!-- This is an optional element. Feel free to remove. -->

## Pros and Cons of the Options

### Central LSEG Mimecast service

- Good, because supports all security requirements including the ability to prevent email to non-LSEG address

### [AWS Simple Email Service (SES)](https://aws.amazon.com/ses/)

- Bad, because would require cross-cloud traffic & operation

### [Azure Communication Service](https://azure.microsoft.com/en-us/products/communication-services/) (ACS)

See also
the [ACS Cloud Product Framework entry](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-communicationservice).

- Good, because clearlisted as part of the LMP Cloud Product Framework (CPF) model
- Good, because Azure native
- Bad, because non-LSEG addresses cannot be prevented

<!-- This is an optional element. Feel free to remove. -->

## More Information

We may choose to revisit this decision if and when Azure Communication Service hits feature parity with Mimecast given
that there would be some advantages to it being Azure-native (in terms of observability, managed identity
authentication, etc.)

