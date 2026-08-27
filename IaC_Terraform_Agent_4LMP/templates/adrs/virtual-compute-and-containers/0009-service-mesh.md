---
id: LMP-ADR-0009
type: ADR
status: published
approved_by:
  - LMP Migration Architecture Approval
date: 2025-05-03
valid_from: 2025-05-25
tags:
  - Virtual Compute & Containers
tech_capabilities:
  - Infrastructure / Compute / Virtual Compute & Containers
---

# If a general purpose Service Mesh is required, use Istio

## Context and Problem Statement

Service Meshes, when used in the right context (see the corresponding Service Mesh Technology Selection Pattern Mapping
Pattern),
are useful for a variety of use cases, particularly in a containerised/microservices context, including:

- (a) introducing mutual transport layer security (mTLS) encryption between services without code changes
- (b) enabling more sophisticated traffic control (e.g. for canary releases or fault injection)
- (c) service-to-service observability

Various service mesh technologies exist. In this ADR we wish to make a recommendation for the default service mesh a
team
should use (a) provided they've decided that they need one and (b) provided they have no specific preferences that lead
them to choose one over another.

**Note**: if *encryption* of data in-flight is the only use case under consideration (as opposed to
*authentication/mTLS*),
a service mesh may introduce unwanted complexity. Instead, alternatives such as inter-node encryption on the CNI should
be considered.

## Decision Drivers

As with most other technology selections, Service Mesh selection should be driven by considerations such as:

- Features
- How well maintained the project is
- Cost/licensing
- Ease of use
- Size of community / availability of support
- Performance

## Considered Options

- Istio
- Open Service Mesh
- Kong Mesh
- Linkerd
- Kuma
- Consul
- Cilium

## Decision Outcome

Chosen option: [Istio](https://istio.io), because:

- It is well integrated with Azure, easy to install, supported by a significant community of users and commercial
  contributors
- It offers a wide set of features with good performance

In circumstances where simplicity is preferred, Linkerd may be a good second choice.

### Consequences

- Good, because it is mature (CNCF Graduated 2023) and well known
- Good, because provided via
  easy-to-install [Azure Kubernetes Service add-on](https://learn.microsoft.com/en-us/azure/aks/istio-about)
- Good, because official Azure support is provided
- Good, because Microsoft handle scaling and config of the control plane
- Good, because it is full flexible/full-featured
- Good, because it is popular (35k Github stars, 500+ StackOverflow questions)
- Good, because performance is good, although not as good as Linkerd, and at the cost of higher CPU impact[^1]
- Good, because forthcoming Ambient Mesh (sidecar-less architecture) will ease CPU requirements
- Good, because Istio is also the Service Mesh offered on Anthos
- Neutral, because OpenSSF scorecard shows 6.6/10, slightly lower than alternatives
- Bad, because Istio can be complex, especially for teams simultaneously learning Kubernetes
- Bad, because does not yet support OpenTelemetry backends

### Confirmation

The decision was proposed by the LMP Architecture team and validated by the Containers Community of Practice.

## Pros and Cons of the Options

### [Open Service Mesh](https://openservicemesh.io)

- Bad, because the project has been archived by the CNCF and should therefore not be considered by new adopters

### [Kong Mesh](https://konghq.com/products/kong-mesh)

- Good, because it is multi-target (cloud, on-prem, containers, Kubernetes)
- Neutral, because it is a commercial product - meaning greater cost, but with enterprise support and an SLA
- Neutral, because it integrates with AWS Certificate Manager, but not with Azure Key Vault, which would be of use for
  LMP
- Neutral, because it is built on top of Kuma/Envoy, two CNCF projects
- Bad, because it is less popular (22 StackOverflow hits) and therefore potentially harder to troubleshoot

### [Linkerd](https://linkerd.io)

- Good, because it is mature (CNCF Graduated 2021)
- Good, because it is often fastest[^1]
- Neutral, because it is simpler than alternatives, but less full-featured as a result (e.g. no Gateway API support)
- Neutral, because it is Kubernetes-only, but most teams using service mesh are likely to be using Kubernetes
- Neutral, because OpenSSF scorecard shows 7.5/10, neither high nor low

### [Kuma](https://kuma.io)

- Good, because supports both Kubernetes and VMs
- Neutral, because it is less mature than other offering (CNCF Sandbox 2020)
- Neutral, because built on top of Envoy, like Istio
- Neutral, because OpenSSF scorecard shows 7.8/10, neither high nor low
- Neutral, because relatively low popularity (3.5k Github stars, 136 StackOverflow hits)

### [Consul](https://www.hashicorp.com/products/consul)

- Good, because it is multi-target (cloud, on-prem, containers, Kubernetes)
- Good, because it is relatively popular (27.8k Github stars, 500+ StackOverflow hits )
- Bad, because uncertainty over HashiCorp's use of the Business Source License and recent acquisition by IBM
- Neutral, because OpenSSF scorecard shows 7.8/10, neither high nor low
- Neutral, because it is a commercial product - meaning greater cost, but enterprise support and an SLA

### [Cilium](https://isovalent.com/projects/service-mesh/)

- Good, because sidecar & proxy free (it uses [eBPF](https://ebpf.io)), improving performance and offering more granular
  network policy control
- Neutral, because although Cilium's architecture (combined data/control plane, no sidecars or proxies) is arguably
  simpler,
  there are potentially eBPF nuances to navigate and understand
- Neutral, because although Cilium is moderately popular (18k Github stars/300 StackOverflow hits, there are just 17
  Stack Overflow for Cilium Service Mesh itself, given that it is a relatively new feature, meaning more limited
  community
  support and resources
- Bad, because for a general purpose Service Mesh, Cilium Service Mesh is not as strong at traffic management (e.g. for
  canaries)
  or for managing external/hybrid traffic

## More Information

- [^1]: [A fairly thorough service mesh performance comparison](https://medium.com/elca-it/service-mesh-performance-evaluation-istio-linkerd-kuma-and-consul-d8a89390d630)
- The [Service Mesh Comparison](https://servicemesh.es) website has up-to-date information comparing
  the various offerings
- Istio is already supported by
  the [
  `azure-prdsvcpat-terraform-aks-private`]([azure-prdsvcpat-terraform-aks-private](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvcpat/terraform/azure-prdsvcpat-terraform-aks-private/-/blob/main/aks-tools/main.tf?ref_type=heads)
  Service Pattern.

