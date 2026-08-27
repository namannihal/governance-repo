---
id: LMP-ADR-0019
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

# Lower Environment Shutdown for Cost Optimisation

## Context

Lower environments create avoidable cost when left running outside periods of active use.
Non-production compute should not be treated as permanently on by default.
This ADR sets a default position for lower environments while allowing for justified PPE availability
where other application teams depend on it.

## Decision

- **Dev and QA environments MUST be shut down during agreed downtime periods.**
- **PPE environments SHOULD be shut down during agreed downtime periods.**
- PPE may remain available where there is a valid dependency from another application team or another
  justified operational need.
- Where an application team chooses to shut down PPE, it should first consider whether other teams
  depend on that environment.
- If such dependencies exist, agreed uptime and downtime windows should be formalised and
  communicated before the shutdown approach is adopted.
- PPE must not remain permanently on by default through convention or assumption alone.

## Rationale

Dev and QA in cloud environments must minimise cost outside defined usage windows.

PPE environments may be different because they may support
integration, coordinated testing or other cross-team dependencies.
For that reason, the default position is still to shut them down
where possible, but not at the expense of breaking dependent teams.
The key requirement is that, where PPE shutdown is adopted and dependencies exist, availability
expectations are made explicit and agreed.

This keeps the default cost position strong while still allowing justified exceptions to be managed deliberately.

## Consequences

### Good

- Reduces unnecessary lower-environment spend
- Establishes a clear and enforceable default
- Prevents PPE from becoming always-on without justification
- Encourages cross-team dependencies to be made explicit where PPE shutdown is introduced

### Bad

- Teams with shared dependencies will need to coordinate more actively
- Poorly defined uptime windows may disrupt dependent teams

## Implementation Note

- Shutdown and startup should be automated wherever possible.

