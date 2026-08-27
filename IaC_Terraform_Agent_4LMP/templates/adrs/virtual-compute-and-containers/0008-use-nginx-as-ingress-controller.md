---
id: LMP-ADR-0008
type: ADR
status: published
approved_by:
  - LMP Migration Architecture Approval
date: 2024-05-07
valid_from: 2024-05-25
tags:
  - Virtual Compute & Containers
tech_capabilities:
  - Infrastructure / Compute / Virtual Compute & Containers
---

# Use Ingress-Nginx as a Kubernetes Ingress Controller

## Context and Problem Statement

Almost all applications deployed on Kubernetes will need a solution for getting traffic into the cluster,
 either from private addresses or from public.

This is typically served by an Ingress Controller, of which there are several options.

## Decision Drivers

Choice of technology should be driven by characteristics including:

- Internal and external popularity, usage and skills
- Cost and/or licence
- Ease of use
- Performance

## Considered Options

- Ingress-Nginx
- Azure App Gateway for Containers
- Azure Application Gateway Ingress Controller
- Traefik
- Istio

## Decision Outcome

Chosen option: Ingress-Nginx because it is a simple, high performant option, well maintained and community supported.

### Consequences

- Good, because it is performant, reliable and flexible
- Good, because it is well maintained and relied upon worldwide
- Neutral, because it does not yet support the more modern Kubernetes Gateway API, but teams may not need it
- Bad, because it is not a managed service, meaning it needs to be deployed, operated and maintained
 (e.g. with OS and version patches)
- Bad, because it can be difficult to tune / to troubleshoot edge cases
- Bad, because it produces a lot of logging and requires separate integration with OpenTelemetry for metrics

## Pros and Cons of the Options

### [Azure App Gateway for Containers](https://learn.microsoft.com/en-us/azure/application-gateway/for-containers/overview)

- Good, because it is Azure native and a managed service, meaning it doesn't need patching
- Neutral, because it supports the more modern Kubernetes Gateway API, but teams may not need it
- Neutral, because it can either be deployed by hand ("bring your own") or can deploy itself
- Neutral, because it is only recently GA, meaning there may still be bugs/issues/missing features that are hard to
 discover until it has been in use
- Bad, because it introduces additional cost

### [Azure Application Gateway Ingress Controller](https://learn.microsoft.com/en-us/azure/application-gateway/for-containers/overview)

- Bad, because AGIC has evolved into Azure App Gateway for Containers, the more modern approach (see above)

### [Traefik](https://doc.traefik.io/traefik/providers/kubernetes-ingress/)

- Neutral, because Gateway API support is currently experimental, but teams may not need it
- Bad, because Traefik has not had strong adoption at LSEG

### [Istio](https://istio.io/latest/docs/tasks/traffic-management/ingress/)

- Neutral, because Istio may be useful in Service Mesh contexts, but many applications need a general purpose ingress,
 and do not need Service Mesh

## Further Reading

The [Gateway API](https://gateway-api.sigs.k8s.io) *"represents the next generation of Kubernetes Ingress, Load
 Balancing, and Service Mesh APIs"* but the SIG has *"no plans to deprecate [the Ingress] API and we expect most
Ingress controllers to support it indefinitely".

Ingress-Nginx is already supported by the [AKS Service Pattern](../../patterns/virtual-compute-and-containers/0018-aks-service-pattern.md).

