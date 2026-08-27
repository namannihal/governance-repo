---
id: LMP-PAT-0011
type: Functional Design Pattern
status: published
approved_by:
  - LMP Migration Architecture Approval
date: 2024-05-02
valid_from: 2024-05-02
developer_productivity_hrs: 2
tags:
  - Testing
  - Interfaces & APIs
tech_capabilities:
  - Delivery / Development / Testing
  - Platform / Application / Message Bus & Integration / Interfaces & APIs
---

# System Test Endpoints

## Context

To improve customer experience of LMP-migrated applications, we should be looking to provide the capability for each
migrated service that allows customers to validate that the service is reachable and operating correctly.

There's several levels of maturity that can be defined, each providing an extra level of validation at the cost of
implementation complexity.

Each of these levels can be provided in parallel: a service may choose to implement multiple types of healthchecks for
different scenarios.

## General Principles

### Rate-limiting

To protect the system from malicious or misconfigured clients, each implementation must rate-limit requests to the test
endpoint, using appropriate data about the client. The data available will vary depending on the model implemented and
the specific application, so a decision on what reasonable rate-limiting should be is left to the application
implementing the pattern.

The rate-limiting mechanism will also depend on the protocol. For example, HTTP provides a status code
of `429: Too Many Requests` that can be used to signal to clients to back-off their test request rate.

Applications should also consider implementing a circuit-breaker on their test endpoints, so that during maintenance
windows or incidents, the test endpoint can rapidly return a failure indication without putting any additional load on
the rest of the system (which may be distressed).

## Request / response services

### Level 1a: Simple connectivity check to edge

- Establishes connectivity between the customer and the service edge
- Unauthenticated
- Simple to configure
- We can standardise the location and format of the healthcheck request and response for each protocol (HTTP, FIX etc.)
- Can configure on the edge handler (e.g. APIM)
- No user or identity context, so should rate-limit based on other characteristics (e.g. source IP address)

![Level 1a test flow](img/0011-level1a-flow.drawio.png)

### Level 1b: Simple connectivity check to application

- As 1a. However, edge should forward request to actual application component
- Proves connectivity through to actual application handler, not just edge router / proxy

![Level 1b test flow](img/0011-level1b-flow.drawio.png)

### Level 2: Authentication check

- Expands on Level 1 by requiring the customer authenticates with the service
- Proves both connectivity and that the customer's credentials are correct.
- Simple to configure
- Healthcheck response can provide extra context for debugging issues, e.g. user identity, permissions, group membership
  etc.
- Can rate limit based on user identity, source IP etc.

![Level 2 test flow](img/0011-level2-flow.drawio.png)

### Level 3: System functionality check

- Builds on Level 2, but the healthcheck endpoint does a more exhaustive test of the health of the subsystems that
  compose the whole service
- These tests can be more thorough, e.g. checking that databases can be written to, etc.
- Requires authentication
- Should probably rate-limit, given that there's more load potentially put on the system per check
- More complex to configure for the application. Subsystems and criteria for "health / not healthy" would need to be
  defined
- More costly healthcheck means rate-limiting should probably be a little more aggressive to protect the system

![Level 3 test flow](img/0011-level3-flow.drawio.png)

### Level 4: Full test transaction support

- Builds on Level 3, but also allows a customer to exercise the system in a test context to check that it behaves how
  they expect. E.g. injecting test trades into a trading system.
- Highest level of customer assurance around system functionality
- Very complex to implement: the concept of a test transaction needs to be baked into the design of the system and its
  processes so that test transactions don't interfere with real ones

![Level 4 test flow](img/0011-level4-flow.drawio.png)

