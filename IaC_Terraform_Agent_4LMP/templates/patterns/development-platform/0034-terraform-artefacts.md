---
id: LMP-PAT-0034
type: Functional Design Pattern
status: published
date: 2024-05-17
valid_from: 2024-05-17
developer_productivity_hrs: 5
approved_by:
  - LMP Migration Architecture Approval
tags:
  - Development Platform
tech_capabilities:
  - Delivery / Development / Design & Development / Development Tools & SDKs
  - Delivery / Operations / Deployment & Administration
---

# Patterns for Managing Terraform Artefacts

A Terraform "stack" or "layer" is typically composed of Cloud Product Framework modules, Service Patterns and additional
resources.

Stacks or Layers represent infrastructure with different lifecycles and/or blast radii.

Examples might be:

- **Foundational shared services**, e.g. an AKS cluster and Key Vault shared by many components
- **Fundamental services** with a larger or riskier blast radius, e.g. ingress controllers
- **Slow/large services** such as API Management (that may otherwise slow down a pipeline that is used frequently)
- **Component specific infrastructure**, e.g. services or secrets used by one component

Each layer should be represented by a different Gitlab project.

## Pattern - Use Terraform Modules to represent Infrastructure Layers

In this pattern, a Terraform module, representing the layer, is built and packaged by a "build" pipeline.

The module is then consumed and deployed by a separate project that also contains per-environment `*.tfvars`
configuration.

Tags can be used to represent the deployment (the combination of versioned Terraform module and configuration). To
rollback, the Gitlab pipeline can be executed for the desired "old" tag.

### Module Build

![Module Build](img/0034-module-build.png)

### Module Deployment

![Module Deployment](img/0034-module-deploy.png)

### Pros and Cons of the Terraform Module Pattern

- **Good**, because we are packaging an artefact rather than depending on a mutable Git commit reference during
  deployment
- **Good**, because the packaged artefact can be directly consumed without needing to be cloned or un-tarred
- **Good**, because the packaged artefact has other convenience features provider by Terraform module registries such as
  usage examples and documentation
- **Neutral**, because whilst there need be no logic in the outermost Terraform module that is published to a registry,
  it still necessitates redeclaration of the variables, but this is easy to do
- **Bad**, because Terraform providers cannot be included in the published artefact and must instead be supplied by the
  consuming module, which must be provided separately, meaning the "outer" or "deploying" Terraform project (that
  consumes the given module) must declare providers, increasing complexity from "just config"

## Pattern - Use Generic Artefacts (e.g. `.tar`) to represent Infrastructure Layers

In this pattern, the approach is similar, but the Terraform Module Registry is avoided in favour of a generic artefact
type.

This approach should be favoured if a Terraform Module Registry is unavailable or if there is a strong preference for
avoiding the redeclaration of Terraform variables (e.g. if the deployable artefact requires a _lot_ of configuration).

![Tar Deployment](img/0034-tar-deploy.png)

### Pros and Cons of the `.tar` Pattern

- **Good**, because we are packaging an artefact rather than depending on a mutable Git commit reference during
  deployment
- **Good**, because the artifact can contain all files, including provider and version declarations
- **Neutral**, because the image used for the deployment job will depend on having `tar` or `zip` available, but for
  many
  build images this will already be the case
- **Bad**, because the deployment pipeline needs to download the artifact and extract it prior to calling terraform,
  adding complexity and execution time
- **Bad**, because a bespoke manifest must be developed, validated and maintained (instead of using native Terraform
  syntax)

