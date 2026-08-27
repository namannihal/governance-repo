<span class="md-content__button md-icon md-status--published" href="#" title="Status: Published"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE4LjUgMmgtMTNDMy42IDIgMiAzLjYgMiA1LjV2MTNDMiAyMC40IDMuNiAyMiA1LjUgMjJIMTZsNi02VjUuNUMyMiAzLjYgMjAuNCAyIDE4LjUgMk0yMCAxNWgtMS41Yy0xLjkgMC0zLjUgMS42LTMuNSAzLjVWMjBINS44Yy0xIDAtMS44LS44LTEuOC0xLjhWNS44QzQgNC44IDQuOCA0IDUuOCA0aDEyLjVjMSAwIDEuOC44IDEuOCAxLjhWMTVtLTQuOS02LjggMS41IDEuNS02IDYtMy41LTMuNSAxLjUtMS41IDIgMnoiIC8+PC9zdmc+) </span> <span class="md-content__button md-icon .md-status--published" title="Valid from 2025-05-25"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE5IDE5SDVWOGgxNG0wLTVoLTFWMWgtMnYySDhWMUg2djJINWEyIDIgMCAwIDAtMiAydjE0YTIgMiAwIDAgMCAyIDJoMTRhMiAyIDAgMCAwIDItMlY1YTIgMiAwIDAgMC0yLTJtLTIuNDcgOC4wNkwxNS40NyAxMGwtNC44OCA0Ljg4LTIuMTItMi4xMi0xLjA2IDEuMDZMMTAuNTkgMTd6IiAvPjwvc3ZnPg==) </span> <span class="md-content__button md-icon actions-date" title="Published on 2025-05-03">![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTkgMTB2Mkg3di0yem00IDB2MmgtMnYtMnptNCAwdjJoLTJ2LTJ6bTItN2EyIDIgMCAwIDEgMiAydjE0YTIgMiAwIDAgMS0yIDJINWEyIDIgMCAwIDEtMi0yVjVhMiAyIDAgMCAxIDItMmgxVjFoMnYyaDhWMWgydjJ6bTAgMTZWOEg1djExek05IDE0djJIN3YtMnptNCAwdjJoLTJ2LTJ6bTQgMHYyaC0ydi0yeiIgLz48L3N2Zz4=)</span> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/edit/main/docs/adrs/virtual-compute-and-containers/0009-service-mesh.md" class="md-content__button md-icon" title="Edit this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTEwIDIwSDZWNGg3djVoNXYzLjFsMi0yVjhsLTYtNkg2Yy0xLjEgMC0yIC45LTIgMnYxNmMwIDEuMS45IDIgMiAyaDR6bTEwLjItN2MuMSAwIC4zLjEuNC4ybDEuMyAxLjNjLjIuMi4yLjYgMCAuOGwtMSAxLTIuMS0yLjEgMS0xYy4xLS4xLjItLjIuNC0uMm0wIDMuOUwxNC4xIDIzSDEydi0yLjFsNi4xLTYuMXoiIC8+PC9zdmc+" /></a> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/blob/main/docs/adrs/virtual-compute-and-containers/0009-service-mesh.md" class="md-content__button md-icon" title="View source of this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE3IDE4Yy41NiAwIDEgLjQ0IDEgMXMtLjQ0IDEtMSAxLTEtLjQ0LTEtMSAuNDQtMSAxLTFtMC0zYy0yLjczIDAtNS4wNiAxLjY2LTYgNCAuOTQgMi4zNCAzLjI3IDQgNiA0czUuMDYtMS42NiA2LTRjLS45NC0yLjM0LTMuMjctNC02LTRtMCA2LjVhMi41IDIuNSAwIDAgMS0yLjUtMi41IDIuNSAyLjUgMCAwIDEgMi41LTIuNSAyLjUgMi41IDAgMCAxIDIuNSAyLjUgMi41IDIuNSAwIDAgMS0yLjUgMi41TTkuMjcgMjBINlY0aDd2NWg1djQuMDdjLjcuMDggMS4zNi4yNSAyIC40OVY4bC02LTZINmEyIDIgMCAwIDAtMiAydjE2YTIgMiAwIDAgMCAyIDJoNC41YTguMiA4LjIgMCAwIDEtMS4yMy0yIiAvPjwvc3ZnPg==" /></a>

Document Metadata

|  |  |
|----|----|
| Identifier | **`LMP-ADR-0009`** |
| Type | **ADR** |
| Status | **Published** |
| Approvals | <span class="md-tag">LMP Migration Architecture Approval</span> |
| Published on | **May 03, 2025** |
| Valid From | **May 25, 2025** |
| Authors | <span class="md-source-file__fact"> </span> |
| Tags | <span class="md-tag">Virtual Compute & Containers</span> |
| Technology Capabilities | <span class="md-tag">Infrastructure / Compute / Virtual Compute & Containers</span> |

# If a general purpose Service Mesh is required, use Istio<a href="#if-a-general-purpose-service-mesh-is-required-use-istio" class="headerlink" title="Permanent link">¶</a>

## Context and Problem Statement<a href="#context-and-problem-statement" class="headerlink" title="Permanent link">¶</a>

Service Meshes, when used in the right context (see the corresponding Service Mesh Technology Selection Pattern Mapping Pattern), are useful for a variety of use cases, particularly in a containerised/microservices context, including:

- \(a\) introducing mutual transport layer security (mTLS) encryption between services without code changes
- \(b\) enabling more sophisticated traffic control (e.g. for canary releases or fault injection)
- © service-to-service observability

Various service mesh technologies exist. In this ADR we wish to make a recommendation for the default service mesh a team should use (a) provided they've decided that they need one and (b) provided they have no specific preferences that lead them to choose one over another.

**Note**: if *encryption* of data in-flight is the only use case under consideration (as opposed to *authentication/mTLS*), a service mesh may introduce unwanted complexity. Instead, alternatives such as inter-node encryption on the CNI should be considered.

## Decision Drivers<a href="#decision-drivers" class="headerlink" title="Permanent link">¶</a>

As with most other technology selections, Service Mesh selection should be driven by considerations such as:

- Features
- How well maintained the project is
- Cost/licensing
- Ease of use
- Size of community / availability of support
- Performance

## Considered Options<a href="#considered-options" class="headerlink" title="Permanent link">¶</a>

- Istio
- Open Service Mesh
- Kong Mesh
- Linkerd
- Kuma
- Consul
- Cilium

## Decision Outcome<a href="#decision-outcome" class="headerlink" title="Permanent link">¶</a>

Chosen option: [Istio](https://istio.io), because:

- It is well integrated with Azure, easy to install, supported by a significant community of users and commercial contributors
- It offers a wide set of features with good performance

In circumstances where simplicity is preferred, Linkerd may be a good second choice.

### Consequences<a href="#consequences" class="headerlink" title="Permanent link">¶</a>

- Good, because it is mature (CNCF Graduated 2023) and well known
- Good, because provided via easy-to-install [Azure Kubernetes Service add-on](https://learn.microsoft.com/en-us/azure/aks/istio-about)
- Good, because official Azure support is provided
- Good, because Microsoft handle scaling and config of the control plane
- Good, because it is full flexible/full-featured
- Good, because it is popular (35k Github stars, 500+ StackOverflow questions)
- Good, because performance is good, although not as good as Linkerd, and at the cost of higher CPU impact<sup><a href="#fn:1" class="footnote-ref">1</a></sup>
- Good, because forthcoming Ambient Mesh (sidecar-less architecture) will ease CPU requirements
- Good, because Istio is also the Service Mesh offered on Anthos
- Neutral, because OpenSSF scorecard shows 6.6/10, slightly lower than alternatives
- Bad, because Istio can be complex, especially for teams simultaneously learning Kubernetes
- Bad, because does not yet support OpenTelemetry backends

### Confirmation<a href="#confirmation" class="headerlink" title="Permanent link">¶</a>

The decision was proposed by the LMP Architecture team and validated by the Containers Community of Practice.

## Pros and Cons of the Options<a href="#pros-and-cons-of-the-options" class="headerlink" title="Permanent link">¶</a>

### [Open Service Mesh](https://openservicemesh.io)<a href="#open-service-mesh" class="headerlink" title="Permanent link">¶</a>

- Bad, because the project has been archived by the CNCF and should therefore not be considered by new adopters

### [Kong Mesh](https://konghq.com/products/kong-mesh)<a href="#kong-mesh" class="headerlink" title="Permanent link">¶</a>

- Good, because it is multi-target (cloud, on-prem, containers, Kubernetes)
- Neutral, because it is a commercial product - meaning greater cost, but with enterprise support and an SLA
- Neutral, because it integrates with AWS Certificate Manager, but not with Azure Key Vault, which would be of use for LMP
- Neutral, because it is built on top of Kuma/Envoy, two CNCF projects
- Bad, because it is less popular (22 StackOverflow hits) and therefore potentially harder to troubleshoot

### [Linkerd](https://linkerd.io)<a href="#linkerd" class="headerlink" title="Permanent link">¶</a>

- Good, because it is mature (CNCF Graduated 2021)
- Good, because it is often fastest<sup><a href="#fn:1" class="footnote-ref">1</a></sup>
- Neutral, because it is simpler than alternatives, but less full-featured as a result (e.g. no Gateway API support)
- Neutral, because it is Kubernetes-only, but most teams using service mesh are likely to be using Kubernetes
- Neutral, because OpenSSF scorecard shows 7.5/10, neither high nor low

### [Kuma](https://kuma.io)<a href="#kuma" class="headerlink" title="Permanent link">¶</a>

- Good, because supports both Kubernetes and VMs
- Neutral, because it is less mature than other offering (CNCF Sandbox 2020)
- Neutral, because built on top of Envoy, like Istio
- Neutral, because OpenSSF scorecard shows 7.8/10, neither high nor low
- Neutral, because relatively low popularity (3.5k Github stars, 136 StackOverflow hits)

### [Consul](https://www.hashicorp.com/products/consul)<a href="#consul" class="headerlink" title="Permanent link">¶</a>

- Good, because it is multi-target (cloud, on-prem, containers, Kubernetes)
- Good, because it is relatively popular (27.8k Github stars, 500+ StackOverflow hits )
- Bad, because uncertainty over HashiCorp's use of the Business Source License and recent acquisition by IBM
- Neutral, because OpenSSF scorecard shows 7.8/10, neither high nor low
- Neutral, because it is a commercial product - meaning greater cost, but enterprise support and an SLA

### [Cilium](https://isovalent.com/projects/service-mesh/)<a href="#cilium" class="headerlink" title="Permanent link">¶</a>

- Good, because sidecar & proxy free (it uses [eBPF](https://ebpf.io)), improving performance and offering more granular network policy control
- Neutral, because although Cilium's architecture (combined data/control plane, no sidecars or proxies) is arguably simpler, there are potentially eBPF nuances to navigate and understand
- Neutral, because although Cilium is moderately popular (18k Github stars/300 StackOverflow hits, there are just 17 Stack Overflow for Cilium Service Mesh itself, given that it is a relatively new feature, meaning more limited community support and resources
- Bad, because for a general purpose Service Mesh, Cilium Service Mesh is not as strong at traffic management (e.g. for canaries) or for managing external/hybrid traffic

## More Information<a href="#more-information" class="headerlink" title="Permanent link">¶</a>

- 
- The [Service Mesh Comparison](https://servicemesh.es) website has up-to-date information comparing the various offerings
- Istio is already supported by the \[ `azure-prdsvcpat-terraform-aks-private`\]([azure-prdsvcpat-terraform-aks-private](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvcpat/terraform/azure-prdsvcpat-terraform-aks-private/-/blob/main/aks-tools/main.tf?ref_type=heads) Service Pattern.

<div class="footnote">

------------------------------------------------------------------------

1.  <div id="fn:1">

    [A fairly thorough service mesh performance comparison](https://medium.com/elca-it/service-mesh-performance-evaluation-istio-linkerd-kuma-and-consul-d8a89390d630) <a href="#fnref:1" class="footnote-backref" title="Jump back to footnote 1 in the text">↩︎</a><a href="#fnref2:1" class="footnote-backref" title="Jump back to footnote 1 in the text">↩︎</a>

    </div>

</div>

<span class="md-source-file__fact"> <span class="md-icon" title="Last update"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIxIDEzLjFjLS4xIDAtLjMuMS0uNC4ybC0xIDEgMi4xIDIuMSAxLTFjLjItLjIuMi0uNiAwLS44bC0xLjMtMS4zYy0uMS0uMS0uMi0uMi0uNC0uMm0tMS45IDEuOC02LjEgNlYyM2gyLjFsNi4xLTYuMXpNMTIuNSA3djUuMmw0IDIuNC0xIDFMMTEgMTNWN3pNMTEgMjEuOWMtNS4xLS41LTktNC44LTktOS45QzIgNi41IDYuNSAyIDEyIDJjNS4zIDAgOS42IDQuMSAxMCA5LjMtLjMtLjEtLjYtLjItMS0uMnMtLjcuMS0xIC4yQzE5LjYgNy4yIDE2LjIgNCAxMiA0Yy00LjQgMC04IDMuNi04IDggMCA0LjEgMy4xIDcuNSA3LjEgNy45bC0uMS4yeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="December 17, 2025 11:12:31 UTC">December 17, 2025</span> </span> <span class="md-source-file__fact"> <span class="md-icon" title="Created"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE0LjQ3IDE1LjA4IDExIDEzVjdoMS41djUuMjVsMy4wOCAxLjgzYy0uNDEuMjgtLjc5LjYyLTEuMTEgMW0tMS4zOSA0Ljg0Yy0uMzYuMDUtLjcxLjA4LTEuMDguMDgtNC40MiAwLTgtMy41OC04LThzMy41OC04IDgtOCA4IDMuNTggOCA4YzAgLjM3LS4wMy43Mi0uMDggMS4wOC42OS4xIDEuMzMuMzIgMS45Mi42NC4xLS41Ni4xNi0xLjEzLjE2LTEuNzIgMC01LjUtNC41LTEwLTEwLTEwUzIgNi41IDIgMTJzNC40NyAxMCAxMCAxMGMuNTkgMCAxLjE2LS4wNiAxLjcyLS4xNi0uMzItLjU5LS41NC0xLjIzLS42NC0xLjkyTTE4IDE1djNoLTN2MmgzdjNoMnYtM2gzdi0yaC0zdi0zeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="May 14, 2024 12:41:22 UTC">May 14, 2024</span> </span>

<a href="../0008-use-nginx-as-ingress-controller/" class="md-footer__link md-footer__link--prev" aria-label="Previous: Use Ingress-Nginx as a Kubernetes Ingress Controller"></a>

<div class="md-footer__button md-icon">

![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIwIDExdjJIOGw1LjUgNS41LTEuNDIgMS40Mkw0LjE2IDEybDcuOTItNy45MkwxMy41IDUuNSA4IDExeiIgLz48L3N2Zz4=)

</div>

<div class="md-footer__title">

<span class="md-footer__direction"> Previous </span>

<div class="md-ellipsis">

Use Ingress-Nginx as a Kubernetes Ingress Controller

</div>

</div>

<a href="../../../patterns/analytics/0074-hdinsight-design-pattern/" class="md-footer__link md-footer__link--next" aria-label="Next: HD Insight Hadoop Cluster Pattern"></a>

<div class="md-footer__title">

<span class="md-footer__direction"> Next </span>

<div class="md-ellipsis">

HD Insight Hadoop Cluster Pattern

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
