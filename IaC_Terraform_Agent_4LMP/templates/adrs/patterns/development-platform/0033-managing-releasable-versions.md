<span class="md-content__button md-icon md-status--published" href="#" title="Status: Published"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE4LjUgMmgtMTNDMy42IDIgMiAzLjYgMiA1LjV2MTNDMiAyMC40IDMuNiAyMiA1LjUgMjJIMTZsNi02VjUuNUMyMiAzLjYgMjAuNCAyIDE4LjUgMk0yMCAxNWgtMS41Yy0xLjkgMC0zLjUgMS42LTMuNSAzLjVWMjBINS44Yy0xIDAtMS44LS44LTEuOC0xLjhWNS44QzQgNC44IDQuOCA0IDUuOCA0aDEyLjVjMSAwIDEuOC44IDEuOCAxLjhWMTVtLTQuOS02LjggMS41IDEuNS02IDYtMy41LTMuNSAxLjUtMS41IDIgMnoiIC8+PC9zdmc+) </span> <span class="md-content__button md-icon .md-status--published" title="Valid from 2024-05-17"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE5IDE5SDVWOGgxNG0wLTVoLTFWMWgtMnYySDhWMUg2djJINWEyIDIgMCAwIDAtMiAydjE0YTIgMiAwIDAgMCAyIDJoMTRhMiAyIDAgMCAwIDItMlY1YTIgMiAwIDAgMC0yLTJtLTIuNDcgOC4wNkwxNS40NyAxMGwtNC44OCA0Ljg4LTIuMTItMi4xMi0xLjA2IDEuMDZMMTAuNTkgMTd6IiAvPjwvc3ZnPg==) </span> <span class="md-content__button md-icon actions-date" title="Published on 2024-05-17">![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTkgMTB2Mkg3di0yem00IDB2MmgtMnYtMnptNCAwdjJoLTJ2LTJ6bTItN2EyIDIgMCAwIDEgMiAydjE0YTIgMiAwIDAgMS0yIDJINWEyIDIgMCAwIDEtMi0yVjVhMiAyIDAgMCAxIDItMmgxVjFoMnYyaDhWMWgydjJ6bTAgMTZWOEg1djExek05IDE0djJIN3YtMnptNCAwdjJoLTJ2LTJ6bTQgMHYyaC0ydi0yeiIgLz48L3N2Zz4=)</span> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/edit/main/docs/patterns/development-platform/0033-managing-releasable-versions.md" class="md-content__button md-icon" title="Edit this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTEwIDIwSDZWNGg3djVoNXYzLjFsMi0yVjhsLTYtNkg2Yy0xLjEgMC0yIC45LTIgMnYxNmMwIDEuMS45IDIgMiAyaDR6bTEwLjItN2MuMSAwIC4zLjEuNC4ybDEuMyAxLjNjLjIuMi4yLjYgMCAuOGwtMSAxLTIuMS0yLjEgMS0xYy4xLS4xLjItLjIuNC0uMm0wIDMuOUwxNC4xIDIzSDEydi0yLjFsNi4xLTYuMXoiIC8+PC9zdmc+" /></a> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/blob/main/docs/patterns/development-platform/0033-managing-releasable-versions.md" class="md-content__button md-icon" title="View source of this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE3IDE4Yy41NiAwIDEgLjQ0IDEgMXMtLjQ0IDEtMSAxLTEtLjQ0LTEtMSAuNDQtMSAxLTFtMC0zYy0yLjczIDAtNS4wNiAxLjY2LTYgNCAuOTQgMi4zNCAzLjI3IDQgNiA0czUuMDYtMS42NiA2LTRjLS45NC0yLjM0LTMuMjctNC02LTRtMCA2LjVhMi41IDIuNSAwIDAgMS0yLjUtMi41IDIuNSAyLjUgMCAwIDEgMi41LTIuNSAyLjUgMi41IDAgMCAxIDIuNSAyLjUgMi41IDIuNSAwIDAgMS0yLjUgMi41TTkuMjcgMjBINlY0aDd2NWg1djQuMDdjLjcuMDggMS4zNi4yNSAyIC40OVY4bC02LTZINmEyIDIgMCAwIDAtMiAydjE2YTIgMiAwIDAgMCAyIDJoNC41YTguMiA4LjIgMCAwIDEtMS4yMy0yIiAvPjwvc3ZnPg==" /></a>

Document Metadata

|  |  |
|----|----|
| Identifier | **`LMP-PAT-0033`** |
| Type | **Functional Design Pattern** |
| Status | **Published** |
| Approvals | <span class="md-tag">LMP Migration Architecture Approval</span> |
| Published on | **May 17, 2024** |
| Valid From | **May 17, 2024** |
| Authors | <span class="md-source-file__fact"> </span> |
| Tags | <span class="md-tag">Development Platform</span> |
| Technology Capabilities | <span class="md-tag">Delivery / Development / Design & Development / Development Tools & SDKs</span><span class="md-tag">Delivery / Operations / Deployment & Administration</span> |

# Patterns for Managing Versions of Code & Configuration<a href="#patterns-for-managing-versions-of-code-configuration" class="headerlink" title="Permanent link">¶</a>

## Pattern 1: Config/Code monorepo per Infra Layer<a href="#pattern-1-configcode-monorepo-per-infra-layer" class="headerlink" title="Permanent link">¶</a>

IaC (e.g. Terraform) and IaC config (e.g. `dev.tfvars`, `uat.tfvars`, `prod.tfvars`) in same repo.

### Pros and Cons of Pattern 1<a href="#pros-and-cons-of-pattern-1" class="headerlink" title="Permanent link">¶</a>

- **Good**, because it has simplicity; "everything in one place"
- **Bad**, because it is difficult if environments are widely different (e.g "v1" in prod, "v2" in dev) because code can become difficult to manage, e.g. requiring lots of conditionals
- **Bad**, because it becomes yet more difficult when there are more environments

![Code & Config Monorepo](0033-managing-releasable-versions.assets/image-001.png)

## Pattern 2: Separate Code Repo & Config Repos<a href="#pattern-2-separate-code-repo-config-repos" class="headerlink" title="Permanent link">¶</a>

IaC in one repo, IaC config in separate repo

### Pros and Cons of Pattern 2<a href="#pros-and-cons-of-pattern-2" class="headerlink" title="Permanent link">¶</a>

- **Good**, because it is easier for an operator, potentially unfamiliar with a code repo, to understand and edit versions for release/rollback
- **Good**, because pipelines can be dedicated to config linting / validation, ignoring code, making them simpler and faster
- **Neutral**, because applications with lots of stacks, components or environments, config files may become numerous, and may need linting, but this is a good practice anyway
- **Neutral**, because may require third "version" number to represent combination of code and config, but this is not required in most cases
- **Bad**, because additional repositories to create and maintain
- **Bad**, because application code and config, kept separately, need stricter versioning (e.g. with semver) to keep aligned (e.g. v2x.x config with v2.x.x code)

![Separate Code & Config - Helm Chart](0033-managing-releasable-versions.assets/image-001.png)

### Example - Helm - Deploy via Pipeline - Single Config Repo with Values file per Environment<a href="#example-helm-deploy-via-pipeline-single-config-repo-with-values-file-per-environment" class="headerlink" title="Permanent link">¶</a>

To "deploy", operator could either approve and merge a Merge Request or run a pipeline via either GUI or API, specifying values.

![Separate Code & Config - Helm Values](0033-managing-releasable-versions.assets/image-001.png)

#### Pros and Cons of Example 1<a href="#pros-and-cons-of-example-1" class="headerlink" title="Permanent link">¶</a>

- **Good**, because flat, complete values files easy to diff between environments
- **Neutral**, because requires solution to segregate duties (e.g. preventing developer deployments to production) e.g. CODEOWNERS or Gitlab Protected Environments
- **Bad**, because multiple pipelines to maintain

### Example - Helm - Deploy via Flux GitOps - Single Config Repo with Overlays per Environment<a href="#example-helm-deploy-via-flux-gitops-single-config-repo-with-overlays-per-environment" class="headerlink" title="Permanent link">¶</a>

To "deploy", operator could approve and merge a Merge Request, wait for synchronisation, then verify.

![Separate Code & Config - Helm GitOps](0033-managing-releasable-versions.assets/image-001.png)

#### Pros and Cons of Example 2<a href="#pros-and-cons-of-example-2" class="headerlink" title="Permanent link">¶</a>

- **Good**, because no pipelines to build, maintain or control with RBAC
- **Good**, because State of repo naturally synchronised with state of cluster
- **Good**, because Available via AKS, used as the mechanism to deploy Foundation add-ons such as ingress-nginx
- **Neutral**, because less easy to diff between environments, but still possible by inspecting kustomization.yaml or by doing --dry-run and then diffing
- **Neutral**, because more difficult in a "git flow" type model (with multiple branches) than in a trunk based flow, but a trunk based flow is generally adequate for config with 'overlays' used instead to "override" config per environment
- **Bad**, because there is a learning curve: operators and developers may be more familiar with pipelines

<span class="md-source-file__fact"> <span class="md-icon" title="Last update"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIxIDEzLjFjLS4xIDAtLjMuMS0uNC4ybC0xIDEgMi4xIDIuMSAxLTFjLjItLjIuMi0uNiAwLS44bC0xLjMtMS4zYy0uMS0uMS0uMi0uMi0uNC0uMm0tMS45IDEuOC02LjEgNlYyM2gyLjFsNi4xLTYuMXpNMTIuNSA3djUuMmw0IDIuNC0xIDFMMTEgMTNWN3pNMTEgMjEuOWMtNS4xLS41LTktNC44LTktOS45QzIgNi41IDYuNSAyIDEyIDJjNS4zIDAgOS42IDQuMSAxMCA5LjMtLjMtLjEtLjYtLjItMS0uMnMtLjcuMS0xIC4yQzE5LjYgNy4yIDE2LjIgNCAxMiA0Yy00LjQgMC04IDMuNi04IDggMCA0LjEgMy4xIDcuNSA3LjEgNy45bC0uMS4yeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="May 30, 2025 16:15:49 UTC">May 30, 2025</span> </span> <span class="md-source-file__fact"> <span class="md-icon" title="Created"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE0LjQ3IDE1LjA4IDExIDEzVjdoMS41djUuMjVsMy4wOCAxLjgzYy0uNDEuMjgtLjc5LjYyLTEuMTEgMW0tMS4zOSA0Ljg0Yy0uMzYuMDUtLjcxLjA4LTEuMDguMDgtNC40MiAwLTgtMy41OC04LThzMy41OC04IDgtOCA4IDMuNTggOCA4YzAgLjM3LS4wMy43Mi0uMDggMS4wOC42OS4xIDEuMzMuMzIgMS45Mi42NC4xLS41Ni4xNi0xLjEzLjE2LTEuNzIgMC01LjUtNC41LTEwLTEwLTEwUzIgNi41IDIgMTJzNC40NyAxMCAxMCAxMGMuNTkgMCAxLjE2LS4wNiAxLjcyLS4xNi0uMzItLjU5LS41NC0xLjIzLS42NC0xLjkyTTE4IDE1djNoLTN2MmgzdjNoMnYtM2gzdi0yaC0zdi0zeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="October 11, 2024 08:31:52 UTC">October 11, 2024</span> </span>

<a href="../0032-managing-iac-and-package-rollback/" class="md-footer__link md-footer__link--prev" aria-label="Previous: Patterns for Infra-as-Code and Code Rollback"></a>

<div class="md-footer__button md-icon">

![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIwIDExdjJIOGw1LjUgNS41LTEuNDIgMS40Mkw0LjE2IDEybDcuOTItNy45MkwxMy41IDUuNSA4IDExeiIgLz48L3N2Zz4=)

</div>

<div class="md-footer__title">

<span class="md-footer__direction"> Previous </span>

<div class="md-ellipsis">

Patterns for Infra-as-Code and Code Rollback

</div>

</div>

<a href="../0034-terraform-artefacts/" class="md-footer__link md-footer__link--next" aria-label="Next: Patterns for Managing Terraform Artefacts"></a>

<div class="md-footer__title">

<span class="md-footer__direction"> Next </span>

<div class="md-ellipsis">

Patterns for Managing Terraform Artefacts

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
