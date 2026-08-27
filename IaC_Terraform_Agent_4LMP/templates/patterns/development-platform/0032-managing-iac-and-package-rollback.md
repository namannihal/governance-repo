---
id: LMP-PAT-0032
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

# Patterns for Infra-as-Code and Code Rollback

## Anti-Pattern: "Fix Forward" rollback using single repo for both build & deployment

Relevant to e.g. resource creation, resource configuration change or software package deployment

### Pros and Cons of the Anti-Pattern

- **Good**, because simple
- **Neutral**, because dependent on good commit message hygiene to keep team up-to-speed with what has happened and why,
  but commit messages should follow best practice anyway
- **Bad**, because does not provide an acceptable "rollback" procedure that can be included in Change Control requests
  (an operator cannot always be expected to perform such a rollback without deeper understanding of codebase, Git
  skills, etc.)
- **Bad**, because does not readily cater for resources with data (other than those that support e.g. soft delete)
- **Bad**, because difficult to rollback if commits have been made to the main branch since the release tag and before
  the release issue. Alternative approach is to use "release branches", but these, too, lead to a need to merge
  `release-*` back into main, which can introduce its own operational overhead

### Example using Tags

![Rollback Anti-pattern using Tags](img/0032-rollback-antipattern-with-tags.png)

### Example using Release Branches

![Rollback Anti-pattern using Release Branches](img/0032-rollback-antipattern-with-release-branches.png)

## Pattern 1: Build Versioned Artefacts, Deploy Separately

Use one Project and pipeline to publish a versioned artefact (e.g. generic `.tar`, Terraform module registry,
or OCI artifact registry). Use a second Project to configure and deploy the given artefact or collection of artifacts.

For Terraform, implementations include:

- (1) publishing a 'generic' Gitlab artefact (e.g. a .tar) and using a before_script to unpack before applying
- (2) using GitOps via the Flux Terraform Controller
- (3) publishing the Terraform project that is to be installed in multiple environments as a pseudo-module to a module
  registry

### Pros and Cons of Pattern 1

- **Good**, because still simple
- **Good**, because separation of "build" and "release" concerns has nice properties (e.g. shorter pipeline duration,
  fewer stages, simpler RBAC, no need for optional 'manual' deployment stages)
- **Good**, because rollback procedure is easy to describe and follow ("revert version in this deployment manifest"
  or "use old version as variable in Gitlab GUI when running pipeline")
- **Bad**, because additional GitLab Projects to create and maintain

### Example of a 'Build' Project Pipeline

![Rollback Build Pipeline](img/0032-rollback-separate-build-pipeline.png)

Separate config or manifest-only "deploy" Project (& Pipeline, if not using GitOps)

### Example 'Deploy' Project - Type A (Commit versions in manifest(s))

Maintain deployment manifest, containing version numbers per environment, as file(s) in repo.

![Rollback via Manifests](img/0032-rollback-mr-separate-deploy-pipeline.png)

#### Pros and Cons of Example 1

- **Good**, because development team can prepare a Merge Request, in Draft, ahead of a change window & validate
  pipelines, merge conflicts, etc.
- **Good**, because files in repository listing versions per component, per environment give easily "diff-able"
  comparison of what version is deployed where
- **Neutral**, because operator may need to become familiar with Gitlab merge request GUI and, on occasion, may need to
  troubleshoot a failed merge
- **Neutral**, because deployment pipelines are more complex if true artifacts are not used (e.g. cloning a code repo
  instead of deploying a package, Chart or module), but the latter is preferred for this reason and relatively simple to
  implement
- **Bad**, because harder to see history of pipelines or to get "current state" of what's deployed in which environment
- **Bad**, because operator needs to be familiar enough with Git and/or Gitlab to be able to revert a version number in
  a manifest in the event of failure

### Example 'Deploy' Project Type B (Run pipelines, entering version numbers at runtime)

Instead of maintaining version numbers as committed files in the repository, use the Gitlab interface or API to handle
versions at pipeline execution time.

![Rollback via Pipeline Interface](img/0032-rollback-run-separate-deploy-pipeline.png)

#### Pros and Cons of Example 2

- **Good**, because very simple for operator, removes need to understand and potentially troubleshoot a Merge Request
  issue
- **Bad**, because harder to see history of pipelines or to get "current state" of what's deployed in which environment

