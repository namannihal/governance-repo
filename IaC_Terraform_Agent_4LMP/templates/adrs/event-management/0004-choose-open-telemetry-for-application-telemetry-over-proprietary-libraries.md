---
id: LMP-ADR-0004
type: ADR
status: published
approved_by:
  - LMP Migration Architecture Approval
date: 2024-04-26
valid_from: 2024-05-25
tags:
  - Event Management
tech_capabilities:
  - Delivery / Operations / Event Management
  - Delivery / Operations / IT Service Management / Application Monitoring
---

# Choose OpenTelemetry for Application Telemetry over Proprietary Libraries

## Context and Problem Statement

After
having [decided to use DataDog as a default telemetry sink](0003-use-datadog-for-application-and-resource-monitoring.md),
a secondary decision needs to be made about how the data should actually flow to Datadog from the source systems.

There's a number of different contexts in which LSEG operates systems which emit telemetry (logs, metrics and trace
events), and each has different options for integrating with Datadog. We therefore need to decide what our preferred
option is for integration in each context, as well as our general principles.

## Decision Drivers

The main concerns for choosing an approach are:

- Ease of integration
- Capabilities for handling different types of telemetry in different contexts
- Maintainability
- Vendor lock-in / future-proofing
- Compatability with other systems & components

## Considered Options

- OpenTelemetry
- Datadog Integration

## Decision Outcome

Chosen option: OpenTelemetry because it meets our needs whilst not locking our applications to a single vendor.

### Consequences

- Good, because it is an open standard
- Good, because it de-couples the application implementation from the telemetry infrastructure implementation, allowing
  future flexibility with minimal disruption
- Good, because OTel supports enough of our telemetry needs in the short term (and should improve over time)
- Bad, because not quite as seamlessly integrated with all of Datadog's features. Will need to work a little harder per
  application to ensure that the right telemetry is marked up with the correct metadata to enable Datadog's more
  advanced features (APM etc.)

### Confirmation

Applications should implement telemetry via one of the OpenTelemetry SDKs, rather than linking directly to the Datadog
SDK.

