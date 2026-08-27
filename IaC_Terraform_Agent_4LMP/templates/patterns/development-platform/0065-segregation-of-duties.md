---
id: LMP-PAT-0065
type: Functional Design Pattern
status: published
supersedes: LMP-PAT-0035
date: 2025-06-30
valid_from: 2025-05-30
developer_productivity_hrs: 5
approved_by:
  - LMP Migration Architecture Approval
tags:
  - Development Platform
tech_capabilities:
  - Delivery / Development / Design & Development / Development Tools & SDKs
  - Delivery / Operations / Deployment & Administration
---

# Patterns for Managing Segregation of Duties via Gitlab

In many LMP environments there will be a requirement to segregate the permissions of:

- **"Developers"** - who write code (and infrastructure-as-code), run tests and build packages
- **"Operators"** - who take code packages, deploy them and operate them

Such approaches have their origin in ITIL, ISO 27001, Sarbanes-Oxley, PCI-DSS and other regulations; they are common
practice across the Financial Services industry.

## Pattern - Using Gitlab Protected Environments

To achieve natively in Gitlab, use
GitLab's [Protected Environments](https://docs.gitlab.com/ee/ci/environments/protected_environments.html) feature.

It allows us to create "approver" and "deployer" rules, preventing deployers from deploying until approvers have
approved.

To set it up, we do the following:

- Configure Gitlab _Groups_ for (1) approvers and (2) deployers
- Invite the new Groups to your project via **Manage > Members > Invite a Group**

> **Note**: **if the "Invite a Group" button is missing,** make sure to uncheck _Projects in "group name" cannot be
shared with other groups_ in Settings > General > Permissions and group features.

- Configure Gitlab _Environments_ that model your software's environments, e.g. `production`, `uat`
  and `development`. See **Operate > Environments** in Gitlab
- Configure _Protected Environments_ (see **Settings > CI/CD > Protected Environments**), assigning the approver and
  deployer groups created above
- Configure an `environment` in the Gitlab Jobs[^1] that need protection, e.g.:

```yaml
stages:
  - deploy

production:
  stage: deploy
  script:
    - 'echo "Deploying to ${CI_ENVIRONMENT_NAME}"'
  environment:
    name: ${CI_JOB_NAME}
    action: start
```

Now, when a pipeline runs, manual approval will be required (to be granted in **Operate > Environments**) prior to
deployment being permitted.

![Protected Environments](img/0065-environment-protection-01.png)

### Pros and Cons of Protected Environments

- **Good**, because it is native to Gitlab and simple to configure
- **Neutral**, because there have been reports of problems with the "Invite a Group" button being missing, but this
  seems to be controlled by the '_Projects in "group name" cannot be shared with other groups_' setting
- **Neutral**, because control is Gitlab native, requiring operators to be familiar with Gitlab, but this is the Group's
  strategic CI/CD tooling
- **Neutral**, because there are additional Gitlab groups to which users must be added, but this will be required by any
  alternative solution too
- **Neutral**, because a developer could in theory edit a pipeline to remove the `environment`, removing approval, but
  if this is a concern, then `.gitlab-ci.yml` can be referenced in a different project

## Pattern - Using Flux, GitOps & Codeowners files

In this pattern, Flux GitOps is used to synchronise the contents of a GitOps repository, for example one containing a
collection of manifests, with a Kubernetes namespace.

To separate environments:

- A "base" directory contains manifests representative of all environments, but
- "Overlay" directories (e.g. `overlays/uat` and `overlays/prod`) contain files representing environment specific
  differences, typically expressed as `kustomize.yaml` files containing expressions that replace fragments of manifests
  in `base` with environment specifics, e.g. domain names, image names, etc.

To separate approval:

- Approvers can approve merge requests into the branch that is being synchronised. Gitlab Merge Request approvals rules
  can be set to require approval(s) from specific groups on specific branches
- If Merge Requests cannot be pre-prepared prior to a release, `CODEOWNERS` files can be used to limit the groups of
  users that can change production overlays

To separate deployment:

- This becomes unnecessary, because there is no longer a "deployment" stage or pipeline to run. Once the new code is in
  the synchronised branch, the Flux GitOps system will synchronise it, deploying it automatically

![Using Flux GitOps](img/0065-flux-01.png)

### Pros and Cons of the GitOps approach

- **Good**, because there are no deployment pipelines to build and maintain
- **Good**, because the status of the repository implicitly indicates the status of the given environment (unless there
  are issues with synchronizing a deployment)
- **Good**, because Kustomize is native to `kubectl` and it is easy to use `--dry-run` to investigate differences
  between environments
- **Neutral**, because rollback becomes a matter of reverting a merge or applying equal and opposite configuration
  changes, but some operator teams may not be sufficiently familiar with Git
- **Neutral**, because it requires AKS or Kubernetes, but many teams are using AKS and Flux is already used for some
  Foundation deployments
- **Bad**, because some scenarios (e.g. resource removal) can require manual intervention
- **Bad**, because there is an additional tool to learn (Flux, Kustomize) and the Kustomize documentation is imperfect
  for more advanced scenarios

## Pattern - Using a Separate Project for Deployments

An alternative is to use a separate Gitlab project for deployments, controlling access via Gitlab RBAC. For example if a
Developer were granted the `Guest` or `Reporter` roles, they would not be able to run a pipeline.

### Pros and Cons of a Separate Project

- **Good**, because it protects the gitlab-ci.yml file and shared templates from unauthorized changes.
- **Good**, because it restrict deployment permissions to a smaller group of trusted users.
- **Good**, because it improves separation of duties between development and operations.
- **Good**, because it enhances auditability by clearly defining who can trigger deployment.
- **Neutral**, because it requires careful attention to ensure correct RBAC permissions for the group/project.
- **Bad**, because it requires additional overhead to maintain.

## Further Reading

[^1]: [Gitlab Deployment Approvals](https://docs.gitlab.com/ee/ci/environments/deployment_approvals.html)

