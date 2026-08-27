---
id: LMP-PAT-0087
type: Functional Design Pattern
status: draft
date: 2026-06-23
developer_productivity_hrs: 5
tags:
  - Development Platform
tech_capabilities:
  - Delivery / Development / Design & Development / Development Tools & SDKs
  - Delivery / Operations / Deployment & Administration
---

# Patterns and Anti-Patterns for Infra & App Rollback

## Anti-Patterns to Avoid (Infra & App)

These apply to both application and infrastructure changes.

- **Combining infrastructure and application code in the same repository.** Infra and app have different lifecycles,
review gates, and scope of impact. Holding them in one repo couples changes that should move independently.
- **Tightly coupling build and deploy.** When deployment and rollback require rebuilding from source or altering Git
history, build and release are bound together instead of operating as separate stages.
- **Deploying only the latest commit.** A single-branch repo whose pipeline always deploys HEAD cannot deploy a
previous or pinned-stable version. Rollback to a known-good state is impossible without rebuilding.

> Note: separating infra and app repos is about lifecycle, not about splitting build and release across repos. Build
and release can share a single repository or pipeline, provided the stages stay decoupled.

### Pros and Cons of the Anti-Pattern

These tradeoffs cover all three anti-patterns above: combined infra/app repo, coupled build and deploy, and deploying
only the latest commit.

- **Good**, because it is simple to implement and manage, especially for smaller or less complex setups.
- **Good**, because a combined repo and single pipeline reduce the number of moving parts to wire up and maintain
at the start.
- **Neutral**, because it relies on strong commit message discipline for traceability and team awareness. This is
expected as part of standard best practice.
- **Bad**, because it does not provide a reliable or operationally straightforward rollback mechanism. Rollbacks may
require rebuilding artifacts or modifying Git history.
- **Bad**, because deploying only the latest commit removes the ability to ship a previous or pinned-stable version,
so there is no clean path back to a known-good state.
- **Bad**, because combining infra and app in one repo couples changes with different lifecycles, review gates, and
blast radius, forcing them to move together when they should move independently.
- **Bad**, because it is not well suited to stateful resources or components with associated data.
- **Bad**, because rollback grows more complex once changes land after a release, sometimes forcing workarounds such
as release branches that add operational overhead.
- **Bad**, because tight coupling between build and release limits flexibility and makes artifact-based deployment and
rollback harder to adopt.

## Rollback Approaches: Applicability and Preference

- Use versioned artefacts with decoupled build and release — produce immutable artefacts and deploy a selected version
(no rebuild).
- Separate repos for app and infrastructure, each with independent lifecycle.
- Rollback = redeploy a validated artefact version, never rebuild or alter Git history.
- Any deviation (e.g., coupled build/release or combined repo) must be documented with justification from the
application team.

For **infrastructure** changes, all three are valid. The order of preference is:

1. **Build artefacts** (most preferred)
2. **Release branches**
3. **Tags** (least preferred)

For **application** changes, rollback should use **versioned build artefacts**. Tags and release branches are
infrastructure-only options and are not recommended for application rollback.

The sections below are presented from least to most preferred, building up to the recommended pattern.

## Example using Tags

**Applies to:** infrastructure.
**Preference:** least preferred of the three rollback options.

**Relevant to:** provisioning infrastructure resources, applying configuration changes, and rolling back infrastructure
pipelines.

![Rollback using Tags](img/0087-rollback-antipattern-with-tags.png)

### Rollback Strategy

- Git tags may be used to support rollback scenarios.
- After any change or fix, a **new tag version must be created and used**.
- Teams must ensure the pipeline always references the **latest approved tag**.

### Limitations of Using Tags

- Git tags are immutable and **cannot be updated once created**.
- Any change after a tag creation requires:
    - Creating a new tag version
    - Updating the pipeline to use the new tag
- Tags carry no built artefact, so rollback still depends on the source state at that tag rather than a pre-built,
validated version. This is why tags rank below release branches and artefacts for infrastructure, and are not
recommended for application rollback.

## Example using Release Branches

**Applies to:** infrastructure.
**Preference:** middle option, above tags and below build artefacts.

**Relevant to:** provisioning infrastructure resources, applying configuration changes, and rolling back infrastructure
pipelines.

 A release branch (e.g., `release/1.0`) is created from `main` at a specific release point, while ongoing development
 continues on `main` without interruption.  

- Using release branches is an industry-standard approach for **controlled stabilization and release management**.  
- Release branches are **not used to feed changes back into `main`**.  
- The release process (QA, validation, deployment) is managed within the release branch.  
- Any bug fixes or urgent changes must first be implemented on `main`.  
- Required fixes are then selectively cherry-picked **from `main` into the release branch**.  
- Release branches are **not merged back into `main`** — all changes must originate from `main`.

![Rollback using Release Branches](img/0087-rollback-antipattern-with-release-branches.png)

### Rollback Strategy

- To roll back, re-run the pipeline against the last known-good release branch or commit point (e.g., `release/0.9`).  
- Release branches are used for **controlled stabilization and release management**, not as a source of truth.  
- If a forward fix is required, it must be **implemented on `main` first**, and then selectively cherry-picked into the
 release branch before re-running the pipeline.  
- Avoid making direct commits on the release branch; doing so can introduce drift from `main`.  
- Retain older release branches (and their pipeline history) so a known-good version is always available for
redeployment.  

### Limitations of Using Release Branches

- Any fixes applied directly to a release branch (bypassing `main`) risk being lost in subsequent releases cut from
`main`.  
- Maintaining alignment between `main` and one or more release branches requires discipline to prevent divergence.  
- Managing multiple simultaneous release branches (e.g., hotfixes or parallel versions) increases operational and
branching complexity.  
- Rollback still re-runs a pipeline from source on the branch rather than redeploying a pre-built artefact, which is
why this option ranks below build artefacts for infrastructure.  

## Pattern 1: Build Versioned Artefacts, Deploy Separately

**Applies to:** infrastructure and application.
**Preference:** most preferred for infrastructure, and the recommended approach for application rollback.

**Relevant to:** building and deploying software packages, and publishing versioned infrastructure artefacts for
reuse across multiple environment deployments.

This is the recommended pattern. For application changes, rollback should always use a versioned build artefact rather
than tags or release branches. For infrastructure changes, it is the preferred option ahead of release branches and
tags.

The key principle is to treat **building a versioned artefact** and **deploying it** as separate, decoupled steps.
This does **not** require two Projects — the same separation can be achieved either within a single repository or
across two Projects:

- **Single Project :** separate the work into distinct pipeline **stages** (e.g. build & publish → deploy).
  This is sufficient for most simple components.
- **Two (or more) Project :** use one Project to publish a versioned artefact (e.g. generic `.tar`, Terraform module
  registry, or OCI artifact registry) and a second Project to configure and deploy the given artefact or collection of
  artefacts.

Use separate Projects only when you have a specific need, such as:

- **Access control / separation of duties** — restrict who can run deployments, or let different teams own the build
  and the deployment.
- **Orchestration** — deploy several components together from a single pipeline.
- **Reuse** — one built artefact (e.g. a shared module or image) is consumed by many different deployments,
environments, or teams.
- **Secrets isolation** — keep sensitive deployment or production credentials out of the build (source) Project.
- **Restricted environments** — deployments must run on locked-down runners with access to a protected network.

For a simple component, building and deploying as separate **stages in the same repository** works perfectly well.

### Pros and Cons of Pattern 1

- **Good**, because still simple
- **Good**, because separation of "build" and "release" concerns has nice properties (e.g. shorter pipeline duration,
  fewer stages, simpler RBAC, no need for optional 'manual' deployment stages)
- **Good**, because rollback procedure is easy to describe and follow ("revert version in this deployment manifest"
  or "use old version as variable in Gitlab GUI when running pipeline")
- **Good**, because rollback redeploys a pre-built, previously validated artefact version rather than rebuilding from
  source, which makes it the preferred option for infrastructure and the recommended approach for application rollback
- **Bad**, because *if* implemented as separate Projects, there are additional GitLab Projects to create and maintain
  (this overhead is avoided when the same build/deploy separation is achieved using stages within a single repository)

## Example of a 'Build' Project Pipeline

![Rollback Build Pipeline](img/0087-rollback-separate-build-pipeline.png)

### Rollback Strategy

- Rollback is performed by selecting and redeploying a **previously published artefact version**.
- The build pipeline is **not re-run** for rollback; only the deploy pipeline is executed with the older version.
- Teams should keep immutable artefact versions in the registry so a known-good version is always available.

The two deployment approaches below — **Type A** (versions committed in a manifest) and **Type B** (versions entered at
runtime) — describe **how the operator selects which artefact version to deploy**, not how the pipeline is structured.
Both apply equally whether build and deploy are separate **stages in a single project** or separate **project**.

## Example 'Deploy' Project - Type A (Commit versions in manifest(s))

- The version to deploy is **written in a file** in the repository.
- To deploy or roll back, **edit the file** and raise a Merge Request; once merged, the pipeline deploys that version.
- The file and its history give a clear, **audit-friendly record** of what is deployed where.

![Rollback via Manifests](img/0087-rollback-mr-separate-deploy-pipeline.png)

### Rollback Strategy

- Identify the last known-good version for the affected environment.
- Update the deployment manifest to that version and raise a Merge Request.
- Merge the change and run the deploy pipeline to redeploy the previous version.
- Use MR history and file diff as the audit trail for the rollback decision.

#### Pros and Cons of Example 1

- **Good**, because development team can prepare a Merge Request, in Draft, ahead of a change window & validate
  pipelines, merge conflicts, etc.
- **Good**, because files in repository listing versions per component, per environment give easily "diff-able"
  comparison of what version is deployed where
- **Neutral**, because operator may need to become familiar with Gitlab merge request GUI and, on occasion, may need to
  troubleshoot a failed merge
- **Neutral**, because deployment pipelines are more complex if true artifacts are not used (e.g. cloning a code repo
  instead of deploying a package, Chart or module), but the latter is preferred for this reason and relatively simple
  to implement
- **Bad**, because harder to see history of pipelines or to get "current state" of what's deployed in which environment
- **Bad**, because operator needs to be familiar enough with Git and/or Gitlab to be able to revert a version number in
  a manifest in the event of failure

## Example 'Deploy' Project Type B (Run pipelines, entering version numbers at runtime)

Instead of maintaining version numbers as committed files in the repository, use the Gitlab interface or API to handle
versions at pipeline execution time.

- There is **no version file** — the operator **types the version** into GitLab when running the deploy pipeline.
- To deploy or roll back, **run the pipeline** and enter the version you want.
- Quick and easy for operators, but the record lives in **pipeline run history** rather than a file.

![Rollback via Pipeline Interface](img/0087-rollback-run-separate-deploy-pipeline.png)

### Rollback Strategy

- Identify the last known-good artefact version for the target environment.
- Re-run the deploy pipeline and enter that older version as the runtime input parameter.
- Verify deployment output and environment health checks before closing the incident.
- Record the selected rollback version and pipeline run ID for audit traceability.

#### Pros and Cons of Example 2

- **Good**, because very simple for operator, removes need to understand and potentially troubleshoot a Merge Request
  issue
- **Bad**, because harder to see history of pipelines or to get "current state" of what's deployed in which environment

