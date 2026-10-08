---
name: oat-scenario-design
description: "Select and assess application-specific Operational Acceptance Testing scenarios from the LSEG L2 Game Day catalog against evidenced as-is systems and the proposed Azure architecture. USE FOR: OAT scenario applicability, architecture design, Game Day operational testability. Invoked by architecture-testing. DO NOT USE FOR: inventing ungrounded infrastructure, executing tests, or scheduling the detailed OAT plan."
argument-hint: "Invoked with the LSEG L2 OAT catalog, discovery evidence, and assembled target architecture"
---

# Architecture Subskill: OAT Scenario Design

Produce an evidence-based OAT scenario applicability and testability assessment for the
architecture-testing skill. The LSEG L2 Game Day catalog is a recommended baseline, not a blanket
requirement that every scenario applies to every application.

## Required inputs

- `docs/testing-strategy/LSEG-L2-OAT-Game-Day-Scenario-Catalog.md`.
- Discovery report, application inventories, source/configuration, current operational runbooks,
  pipelines, monitoring, support model, and current OAT evidence where available.
- Approved requirements, proposed target Azure architecture and component inventory, Sections
  7A/12/13, Section 14.1, test profile, relevant ADRs/risks, and LMP testing strategy index.
- Current LSEG change, production safety, access, CloudOps, and operational policies available in
  the workspace. Treat catalog pipeline links, tool names, statuses, and access groups as
  time-sensitive until independently confirmed.

## Plan

Inventory actual as-is components, dependencies, critical workflows, deployment and recovery
mechanisms, monitoring/alerting, operational runbooks, support ownership, and control evidence.
Separately inventory only the approved/proposed Azure target services and mechanisms. Do not infer
that an Azure service is selected from an example in the catalog.

## Act

Assess each source scenario ID (`L2-OAT-GD-*`, `L2-OAT-CHG-*`, and `L2-OAT-VAL-*`) and any
application-specific additions. Assign one evidence-based disposition:

- `Recommended`: evidenced component/control/flow exists and OAT adds operational assurance.
- `Conditionally applicable`: name the trigger and evidence needed to resolve it.
- `Not applicable`: provide evidence the component, feature, operational control, or failure mode
  does not exist in both relevant scope and target.
- `Blocked`: applicability or safe testability cannot yet be resolved; name owner and gap.

Create a scenario design matrix containing at least:

| Field | Required content |
| --- | --- |
| Catalog ID and scenario | Stable source ID, name, and any app-specific scenario ID |
| Applicability and rationale | Disposition, trigger, as-is evidence, target evidence, and confidence |
| Current-to-target mapping | Actual as-is component/flow/control and the approved Azure target counterpart |
| Operational objective | Failure mode, operational behavior, alert/SLO, recovery, or support capability to prove |
| Testability and guardrails | Mechanism/simulation, prerequisites, telemetry, safe environment, change approval, rollback/stop conditions |
| Ownership and evidence | Operations execution/approval roles, migration support/remediation, runbook, results, SII/RAID/risk |

Map target scenarios to the target architecture only where evidenced. Consider applicable Azure
failure and operations surfaces (for example, zone/region behavior, VM/AKS/serverless, databases,
storage, messaging, identity, monitoring, quotas and deployment pipelines) without assuming a
service, feature, Chaos Studio experiment, or LSEG pipeline is selected or available. Check the
current supported fault-injection mechanism and permissions before proposing any disruption.

Ensure the assessment covers all applicable catalog pillars: reliability/resiliency,
deployment/rollback, monitoring, durability, security, runbook, operational overhead, DML/technical
debt, and vendor incident management. Add app-specific scenarios for risks the generic catalog
does not cover.

Distinguish OAT operational evidence from other test objectives. Reuse a technical mechanism where
appropriate, but do not treat OAT as a substitute for HA, DR, performance, security, penetration,
functional, connectivity, or mandatory UAT acceptance. Keep scenario identity, objective, owner,
and evidence distinct; avoid duplicate case counts.

## Review

- Every catalog entry is explicitly dispositioned; unknowns are Blocked or Conditional, not silently
  omitted or marked Not Applicable.
- As-is statements cite observable evidence; proposed-target statements trace to approved design.
- Azure mapping uses only target services/mechanisms present in the architecture and verifies
  target-specific capabilities rather than relying on generic service assumptions.
- Production/DR disruption has explicit authorization, scope, impact limits, stop/rollback plan,
  recovery readiness, alerting, communications, and change window. Unsafe or unauthorized tests
  remain blocked and do not count as passed.
- Operations and application owners are accountable for OAT execution/acceptance per current LSEG
  RACI; the Migration Team supports and remediates assigned migration defects and collates evidence.
- The output identifies testability gaps and returns design changes to the owning architecture
  layer; it does not claim scenario execution or approval.
