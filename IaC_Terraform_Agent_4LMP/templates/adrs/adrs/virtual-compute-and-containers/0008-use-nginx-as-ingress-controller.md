<span class="md-content__button md-icon md-status--published" href="#" title="Status: Published"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE4LjUgMmgtMTNDMy42IDIgMiAzLjYgMiA1LjV2MTNDMiAyMC40IDMuNiAyMiA1LjUgMjJIMTZsNi02VjUuNUMyMiAzLjYgMjAuNCAyIDE4LjUgMk0yMCAxNWgtMS41Yy0xLjkgMC0zLjUgMS42LTMuNSAzLjVWMjBINS44Yy0xIDAtMS44LS44LTEuOC0xLjhWNS44QzQgNC44IDQuOCA0IDUuOCA0aDEyLjVjMSAwIDEuOC44IDEuOCAxLjhWMTVtLTQuOS02LjggMS41IDEuNS02IDYtMy41LTMuNSAxLjUtMS41IDIgMnoiIC8+PC9zdmc+) </span> <span class="md-content__button md-icon .md-status--published" title="Valid from 2024-05-25"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE5IDE5SDVWOGgxNG0wLTVoLTFWMWgtMnYySDhWMUg2djJINWEyIDIgMCAwIDAtMiAydjE0YTIgMiAwIDAgMCAyIDJoMTRhMiAyIDAgMCAwIDItMlY1YTIgMiAwIDAgMC0yLTJtLTIuNDcgOC4wNkwxNS40NyAxMGwtNC44OCA0Ljg4LTIuMTItMi4xMi0xLjA2IDEuMDZMMTAuNTkgMTd6IiAvPjwvc3ZnPg==) </span> <span class="md-content__button md-icon actions-date" title="Published on 2024-05-07">![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTkgMTB2Mkg3di0yem00IDB2MmgtMnYtMnptNCAwdjJoLTJ2LTJ6bTItN2EyIDIgMCAwIDEgMiAydjE0YTIgMiAwIDAgMS0yIDJINWEyIDIgMCAwIDEtMi0yVjVhMiAyIDAgMCAxIDItMmgxVjFoMnYyaDhWMWgydjJ6bTAgMTZWOEg1djExek05IDE0djJIN3YtMnptNCAwdjJoLTJ2LTJ6bTQgMHYyaC0ydi0yeiIgLz48L3N2Zz4=)</span> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/edit/main/docs/adrs/virtual-compute-and-containers/0008-use-nginx-as-ingress-controller.md" class="md-content__button md-icon" title="Edit this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTEwIDIwSDZWNGg3djVoNXYzLjFsMi0yVjhsLTYtNkg2Yy0xLjEgMC0yIC45LTIgMnYxNmMwIDEuMS45IDIgMiAyaDR6bTEwLjItN2MuMSAwIC4zLjEuNC4ybDEuMyAxLjNjLjIuMi4yLjYgMCAuOGwtMSAxLTIuMS0yLjEgMS0xYy4xLS4xLjItLjIuNC0uMm0wIDMuOUwxNC4xIDIzSDEydi0yLjFsNi4xLTYuMXoiIC8+PC9zdmc+" /></a> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/blob/main/docs/adrs/virtual-compute-and-containers/0008-use-nginx-as-ingress-controller.md" class="md-content__button md-icon" title="View source of this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE3IDE4Yy41NiAwIDEgLjQ0IDEgMXMtLjQ0IDEtMSAxLTEtLjQ0LTEtMSAuNDQtMSAxLTFtMC0zYy0yLjczIDAtNS4wNiAxLjY2LTYgNCAuOTQgMi4zNCAzLjI3IDQgNiA0czUuMDYtMS42NiA2LTRjLS45NC0yLjM0LTMuMjctNC02LTRtMCA2LjVhMi41IDIuNSAwIDAgMS0yLjUtMi41IDIuNSAyLjUgMCAwIDEgMi41LTIuNSAyLjUgMi41IDAgMCAxIDIuNSAyLjUgMi41IDIuNSAwIDAgMS0yLjUgMi41TTkuMjcgMjBINlY0aDd2NWg1djQuMDdjLjcuMDggMS4zNi4yNSAyIC40OVY4bC02LTZINmEyIDIgMCAwIDAtMiAydjE2YTIgMiAwIDAgMCAyIDJoNC41YTguMiA4LjIgMCAwIDEtMS4yMy0yIiAvPjwvc3ZnPg==" /></a>

Document Metadata

|  |  |
|----|----|
| Identifier | **`LMP-ADR-0008`** |
| Type | **ADR** |
| Status | **Published** |
| Approvals | <span class="md-tag">LMP Migration Architecture Approval</span> |
| Published on | **May 07, 2024** |
| Valid From | **May 25, 2024** |
| Authors | <span class="md-source-file__fact"> </span> |
| Tags | <span class="md-tag">Virtual Compute & Containers</span> |
| Technology Capabilities | <span class="md-tag">Infrastructure / Compute / Virtual Compute & Containers</span> |

# Use Ingress-Nginx as a Kubernetes Ingress Controller<a href="#use-ingress-nginx-as-a-kubernetes-ingress-controller" class="headerlink" title="Permanent link">¶</a>

## Context and Problem Statement<a href="#context-and-problem-statement" class="headerlink" title="Permanent link">¶</a>

Almost all applications deployed on Kubernetes will need a solution for getting traffic into the cluster, either from private addresses or from public.

This is typically served by an Ingress Controller, of which there are several options.

## Decision Drivers<a href="#decision-drivers" class="headerlink" title="Permanent link">¶</a>

Choice of technology should be driven by characteristics including:

- Internal and external popularity, usage and skills
- Cost and/or licence
- Ease of use
- Performance

## Considered Options<a href="#considered-options" class="headerlink" title="Permanent link">¶</a>

- Ingress-Nginx
- Azure App Gateway for Containers
- Azure Application Gateway Ingress Controller
- Traefik
- Istio

## Decision Outcome<a href="#decision-outcome" class="headerlink" title="Permanent link">¶</a>

Chosen option: Ingress-Nginx because it is a simple, high performant option, well maintained and community supported.

### Consequences<a href="#consequences" class="headerlink" title="Permanent link">¶</a>

- Good, because it is performant, reliable and flexible
- Good, because it is well maintained and relied upon worldwide
- Neutral, because it does not yet support the more modern Kubernetes Gateway API, but teams may not need it
- Bad, because it is not a managed service, meaning it needs to be deployed, operated and maintained (e.g. with OS and version patches)
- Bad, because it can be difficult to tune / to troubleshoot edge cases
- Bad, because it produces a lot of logging and requires separate integration with OpenTelemetry for metrics

## Pros and Cons of the Options<a href="#pros-and-cons-of-the-options" class="headerlink" title="Permanent link">¶</a>

### [Azure App Gateway for Containers](https://learn.microsoft.com/en-us/azure/application-gateway/for-containers/overview)<a href="#azure-app-gateway-for-containers" class="headerlink" title="Permanent link">¶</a>

- Good, because it is Azure native and a managed service, meaning it doesn't need patching
- Neutral, because it supports the more modern Kubernetes Gateway API, but teams may not need it
- Neutral, because it can either be deployed by hand ("bring your own") or can deploy itself
- Neutral, because it is only recently GA, meaning there may still be bugs/issues/missing features that are hard to discover until it has been in use
- Bad, because it introduces additional cost

### [Azure Application Gateway Ingress Controller](https://learn.microsoft.com/en-us/azure/application-gateway/for-containers/overview)<a href="#azure-application-gateway-ingress-controller" class="headerlink" title="Permanent link">¶</a>

- Bad, because AGIC has evolved into Azure App Gateway for Containers, the more modern approach (see above)

### [Traefik](https://doc.traefik.io/traefik/providers/kubernetes-ingress/)<a href="#traefik" class="headerlink" title="Permanent link">¶</a>

- Neutral, because Gateway API support is currently experimental, but teams may not need it
- Bad, because Traefik has not had strong adoption at LSEG

### [Istio](https://istio.io/latest/docs/tasks/traffic-management/ingress/)<a href="#istio" class="headerlink" title="Permanent link">¶</a>

- Neutral, because Istio may be useful in Service Mesh contexts, but many applications need a general purpose ingress, and do not need Service Mesh

## Further Reading<a href="#further-reading" class="headerlink" title="Permanent link">¶</a>

The [Gateway API](https://gateway-api.sigs.k8s.io) *"represents the next generation of Kubernetes Ingress, Load Balancing, and Service Mesh APIs"* but the SIG has \*"no plans to deprecate \[the Ingress\] API and we expect most Ingress controllers to support it indefinitely".

Ingress-Nginx is already supported by the [AKS Service Pattern](../../../patterns/virtual-compute-and-containers/0018-aks-service-pattern/).

<span class="md-source-file__fact"> <span class="md-icon" title="Last update"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIxIDEzLjFjLS4xIDAtLjMuMS0uNC4ybC0xIDEgMi4xIDIuMSAxLTFjLjItLjIuMi0uNiAwLS44bC0xLjMtMS4zYy0uMS0uMS0uMi0uMi0uNC0uMm0tMS45IDEuOC02LjEgNlYyM2gyLjFsNi4xLTYuMXpNMTIuNSA3djUuMmw0IDIuNC0xIDFMMTEgMTNWN3pNMTEgMjEuOWMtNS4xLS41LTktNC44LTktOS45QzIgNi41IDYuNSAyIDEyIDJjNS4zIDAgOS42IDQuMSAxMCA5LjMtLjMtLjEtLjYtLjItMS0uMnMtLjcuMS0xIC4yQzE5LjYgNy4yIDE2LjIgNCAxMiA0Yy00LjQgMC04IDMuNi04IDggMCA0LjEgMy4xIDcuNSA3LjEgNy45bC0uMS4yeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="December 10, 2024 10:03:44 UTC">December 10, 2024</span> </span> <span class="md-source-file__fact"> <span class="md-icon" title="Created"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE0LjQ3IDE1LjA4IDExIDEzVjdoMS41djUuMjVsMy4wOCAxLjgzYy0uNDEuMjgtLjc5LjYyLTEuMTEgMW0tMS4zOSA0Ljg0Yy0uMzYuMDUtLjcxLjA4LTEuMDguMDgtNC40MiAwLTgtMy41OC04LThzMy41OC04IDgtOCA4IDMuNTggOCA4YzAgLjM3LS4wMy43Mi0uMDggMS4wOC42OS4xIDEuMzMuMzIgMS45Mi42NC4xLS41Ni4xNi0xLjEzLjE2LTEuNzIgMC01LjUtNC41LTEwLTEwLTEwUzIgNi41IDIgMTJzNC40NyAxMCAxMCAxMGMuNTkgMCAxLjE2LS4wNiAxLjcyLS4xNi0uMzItLjU5LS41NC0xLjIzLS42NC0xLjkyTTE4IDE1djNoLTN2MmgzdjNoMnYtM2gzdi0yaC0zdi0zeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="May 14, 2024 14:12:59 UTC">May 14, 2024</span> </span>

<a href="../../user-experience-layer/0007-replace-silverlight-with-react/" class="md-footer__link md-footer__link--prev" aria-label="Previous: Replace Silverlight with React"></a>

<div class="md-footer__button md-icon">

![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIwIDExdjJIOGw1LjUgNS41LTEuNDIgMS40Mkw0LjE2IDEybDcuOTItNy45MkwxMy41IDUuNSA4IDExeiIgLz48L3N2Zz4=)

</div>

<div class="md-footer__title">

<span class="md-footer__direction"> Previous </span>

<div class="md-ellipsis">

Replace Silverlight with React

</div>

</div>

<a href="../0009-service-mesh/" class="md-footer__link md-footer__link--next" aria-label="Next: If a general purpose Service Mesh is required, use Istio"></a>

<div class="md-footer__title">

<span class="md-footer__direction"> Next </span>

<div class="md-ellipsis">

If a general purpose Service Mesh is required, use Istio

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
