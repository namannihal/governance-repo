<span class="md-content__button md-icon md-status--published" href="#" title="Status: Published"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE4LjUgMmgtMTNDMy42IDIgMiAzLjYgMiA1LjV2MTNDMiAyMC40IDMuNiAyMiA1LjUgMjJIMTZsNi02VjUuNUMyMiAzLjYgMjAuNCAyIDE4LjUgMk0yMCAxNWgtMS41Yy0xLjkgMC0zLjUgMS42LTMuNSAzLjVWMjBINS44Yy0xIDAtMS44LS44LTEuOC0xLjhWNS44QzQgNC44IDQuOCA0IDUuOCA0aDEyLjVjMSAwIDEuOC44IDEuOCAxLjhWMTVtLTQuOS02LjggMS41IDEuNS02IDYtMy41LTMuNSAxLjUtMS41IDIgMnoiIC8+PC9zdmc+) </span> <span class="md-content__button md-icon .md-status--published" title="Valid from 2024-05-17"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE5IDE5SDVWOGgxNG0wLTVoLTFWMWgtMnYySDhWMUg2djJINWEyIDIgMCAwIDAtMiAydjE0YTIgMiAwIDAgMCAyIDJoMTRhMiAyIDAgMCAwIDItMlY1YTIgMiAwIDAgMC0yLTJtLTIuNDcgOC4wNkwxNS40NyAxMGwtNC44OCA0Ljg4LTIuMTItMi4xMi0xLjA2IDEuMDZMMTAuNTkgMTd6IiAvPjwvc3ZnPg==) </span> <span class="md-content__button md-icon actions-date" title="Published on 2024-05-17">![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTkgMTB2Mkg3di0yem00IDB2MmgtMnYtMnptNCAwdjJoLTJ2LTJ6bTItN2EyIDIgMCAwIDEgMiAydjE0YTIgMiAwIDAgMS0yIDJINWEyIDIgMCAwIDEtMi0yVjVhMiAyIDAgMCAxIDItMmgxVjFoMnYyaDhWMWgydjJ6bTAgMTZWOEg1djExek05IDE0djJIN3YtMnptNCAwdjJoLTJ2LTJ6bTQgMHYyaC0ydi0yeiIgLz48L3N2Zz4=)</span> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/edit/main/docs/patterns/development-platform/0034-terraform-artefacts.md" class="md-content__button md-icon" title="Edit this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTEwIDIwSDZWNGg3djVoNXYzLjFsMi0yVjhsLTYtNkg2Yy0xLjEgMC0yIC45LTIgMnYxNmMwIDEuMS45IDIgMiAyaDR6bTEwLjItN2MuMSAwIC4zLjEuNC4ybDEuMyAxLjNjLjIuMi4yLjYgMCAuOGwtMSAxLTIuMS0yLjEgMS0xYy4xLS4xLjItLjIuNC0uMm0wIDMuOUwxNC4xIDIzSDEydi0yLjFsNi4xLTYuMXoiIC8+PC9zdmc+" /></a> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/blob/main/docs/patterns/development-platform/0034-terraform-artefacts.md" class="md-content__button md-icon" title="View source of this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE3IDE4Yy41NiAwIDEgLjQ0IDEgMXMtLjQ0IDEtMSAxLTEtLjQ0LTEtMSAuNDQtMSAxLTFtMC0zYy0yLjczIDAtNS4wNiAxLjY2LTYgNCAuOTQgMi4zNCAzLjI3IDQgNiA0czUuMDYtMS42NiA2LTRjLS45NC0yLjM0LTMuMjctNC02LTRtMCA2LjVhMi41IDIuNSAwIDAgMS0yLjUtMi41IDIuNSAyLjUgMCAwIDEgMi41LTIuNSAyLjUgMi41IDAgMCAxIDIuNSAyLjUgMi41IDIuNSAwIDAgMS0yLjUgMi41TTkuMjcgMjBINlY0aDd2NWg1djQuMDdjLjcuMDggMS4zNi4yNSAyIC40OVY4bC02LTZINmEyIDIgMCAwIDAtMiAydjE2YTIgMiAwIDAgMCAyIDJoNC41YTguMiA4LjIgMCAwIDEtMS4yMy0yIiAvPjwvc3ZnPg==" /></a>

Document Metadata

|  |  |
|----|----|
| Identifier | **`LMP-PAT-0034`** |
| Type | **Functional Design Pattern** |
| Status | **Published** |
| Approvals | <span class="md-tag">LMP Migration Architecture Approval</span> |
| Published on | **May 17, 2024** |
| Valid From | **May 17, 2024** |
| Authors | <span class="md-source-file__fact"> </span> |
| Tags | <span class="md-tag">Development Platform</span> |
| Technology Capabilities | <span class="md-tag">Delivery / Development / Design & Development / Development Tools & SDKs</span><span class="md-tag">Delivery / Operations / Deployment & Administration</span> |

# Patterns for Managing Terraform Artefacts<a href="#patterns-for-managing-terraform-artefacts" class="headerlink" title="Permanent link">¶</a>

A Terraform "stack" or "layer" is typically composed of Cloud Product Framework modules, Service Patterns and additional resources.

Stacks or Layers represent infrastructure with different lifecycles and/or blast radii.

Examples might be:

- **Foundational shared services**, e.g. an AKS cluster and Key Vault shared by many components
- **Fundamental services** with a larger or riskier blast radius, e.g. ingress controllers
- **Slow/large services** such as API Management (that may otherwise slow down a pipeline that is used frequently)
- **Component specific infrastructure**, e.g. services or secrets used by one component

Each layer should be represented by a different Gitlab project.

## Pattern - Use Terraform Modules to represent Infrastructure Layers<a href="#pattern-use-terraform-modules-to-represent-infrastructure-layers" class="headerlink" title="Permanent link">¶</a>

In this pattern, a Terraform module, representing the layer, is built and packaged by a "build" pipeline.

The module is then consumed and deployed by a separate project that also contains per-environment `*.tfvars` configuration.

Tags can be used to represent the deployment (the combination of versioned Terraform module and configuration). To rollback, the Gitlab pipeline can be executed for the desired "old" tag.

### Module Build<a href="#module-build" class="headerlink" title="Permanent link">¶</a>

![Module Build](0034-terraform-artefacts.assets/image-001.png)

### Module Deployment<a href="#module-deployment" class="headerlink" title="Permanent link">¶</a>

![Module Deployment](0034-terraform-artefacts.assets/image-001.png)

### Pros and Cons of the Terraform Module Pattern<a href="#pros-and-cons-of-the-terraform-module-pattern" class="headerlink" title="Permanent link">¶</a>

- **Good**, because we are packaging an artefact rather than depending on a mutable Git commit reference during deployment
- **Good**, because the packaged artefact can be directly consumed without needing to be cloned or un-tarred
- **Good**, because the packaged artefact has other convenience features provider by Terraform module registries such as usage examples and documentation
- **Neutral**, because whilst there need be no logic in the outermost Terraform module that is published to a registry, it still necessitates redeclaration of the variables, but this is easy to do
- **Bad**, because Terraform providers cannot be included in the published artefact and must instead be supplied by the consuming module, which must be provided separately, meaning the "outer" or "deploying" Terraform project (that consumes the given module) must declare providers, increasing complexity from "just config"

## Pattern - Use Generic Artefacts (e.g. `.tar`) to represent Infrastructure Layers<a href="#pattern-use-generic-artefacts-eg-tar-to-represent-infrastructure-layers" class="headerlink" title="Permanent link">¶</a>

In this pattern, the approach is similar, but the Terraform Module Registry is avoided in favour of a generic artefact type.

This approach should be favoured if a Terraform Module Registry is unavailable or if there is a strong preference for avoiding the redeclaration of Terraform variables (e.g. if the deployable artefact requires a *lot* of configuration).

![Tar Deployment](0034-terraform-artefacts.assets/image-001.png)

### Pros and Cons of the `.tar` Pattern<a href="#pros-and-cons-of-the-tar-pattern" class="headerlink" title="Permanent link">¶</a>

- **Good**, because we are packaging an artefact rather than depending on a mutable Git commit reference during deployment
- **Good**, because the artifact can contain all files, including provider and version declarations
- **Neutral**, because the image used for the deployment job will depend on having `tar` or `zip` available, but for many build images this will already be the case
- **Bad**, because the deployment pipeline needs to download the artifact and extract it prior to calling terraform, adding complexity and execution time
- **Bad**, because a bespoke manifest must be developed, validated and maintained (instead of using native Terraform syntax)

<span class="md-source-file__fact"> <span class="md-icon" title="Last update"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIxIDEzLjFjLS4xIDAtLjMuMS0uNC4ybC0xIDEgMi4xIDIuMSAxLTFjLjItLjIuMi0uNiAwLS44bC0xLjMtMS4zYy0uMS0uMS0uMi0uMi0uNC0uMm0tMS45IDEuOC02LjEgNlYyM2gyLjFsNi4xLTYuMXpNMTIuNSA3djUuMmw0IDIuNC0xIDFMMTEgMTNWN3pNMTEgMjEuOWMtNS4xLS41LTktNC44LTktOS45QzIgNi41IDYuNSAyIDEyIDJjNS4zIDAgOS42IDQuMSAxMCA5LjMtLjMtLjEtLjYtLjItMS0uMnMtLjcuMS0xIC4yQzE5LjYgNy4yIDE2LjIgNCAxMiA0Yy00LjQgMC04IDMuNi04IDggMCA0LjEgMy4xIDcuNSA3LjEgNy45bC0uMS4yeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="May 30, 2025 16:15:49 UTC">May 30, 2025</span> </span> <span class="md-source-file__fact"> <span class="md-icon" title="Created"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE0LjQ3IDE1LjA4IDExIDEzVjdoMS41djUuMjVsMy4wOCAxLjgzYy0uNDEuMjgtLjc5LjYyLTEuMTEgMW0tMS4zOSA0Ljg0Yy0uMzYuMDUtLjcxLjA4LTEuMDguMDgtNC40MiAwLTgtMy41OC04LThzMy41OC04IDgtOCA4IDMuNTggOCA4YzAgLjM3LS4wMy43Mi0uMDggMS4wOC42OS4xIDEuMzMuMzIgMS45Mi42NC4xLS41Ni4xNi0xLjEzLjE2LTEuNzIgMC01LjUtNC41LTEwLTEwLTEwUzIgNi41IDIgMTJzNC40NyAxMCAxMCAxMGMuNTkgMCAxLjE2LS4wNiAxLjcyLS4xNi0uMzItLjU5LS41NC0xLjIzLS42NC0xLjkyTTE4IDE1djNoLTN2MmgzdjNoMnYtM2gzdi0yaC0zdi0zeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="October 11, 2024 08:31:52 UTC">October 11, 2024</span> </span>

<a href="../0033-managing-releasable-versions/" class="md-footer__link md-footer__link--prev" aria-label="Previous: Patterns for Managing Versions of Code &amp;amp; Configuration"></a>

<div class="md-footer__button md-icon">

![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIwIDExdjJIOGw1LjUgNS41LTEuNDIgMS40Mkw0LjE2IDEybDcuOTItNy45MkwxMy41IDUuNSA4IDExeiIgLz48L3N2Zz4=)

</div>

<div class="md-footer__title">

<span class="md-footer__direction"> Previous </span>

<div class="md-ellipsis">

Patterns for Managing Versions of Code & Configuration

</div>

</div>

<a href="../0035-segregation-of-duties/" class="md-footer__link md-footer__link--next" aria-label="Next: Patterns for Managing Segregation of Duties via Gitlab"></a>

<div class="md-footer__title">

<span class="md-footer__direction"> Next </span>

<div class="md-ellipsis">

Patterns for Managing Segregation of Duties via Gitlab

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
