<span class="md-content__button md-icon md-status--published" href="#" title="Status: Published"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE4LjUgMmgtMTNDMy42IDIgMiAzLjYgMiA1LjV2MTNDMiAyMC40IDMuNiAyMiA1LjUgMjJIMTZsNi02VjUuNUMyMiAzLjYgMjAuNCAyIDE4LjUgMk0yMCAxNWgtMS41Yy0xLjkgMC0zLjUgMS42LTMuNSAzLjVWMjBINS44Yy0xIDAtMS44LS44LTEuOC0xLjhWNS44QzQgNC44IDQuOCA0IDUuOCA0aDEyLjVjMSAwIDEuOC44IDEuOCAxLjhWMTVtLTQuOS02LjggMS41IDEuNS02IDYtMy41LTMuNSAxLjUtMS41IDIgMnoiIC8+PC9zdmc+) </span> <span class="md-content__button md-icon .md-status--published" title="Valid from 2024-05-17"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE5IDE5SDVWOGgxNG0wLTVoLTFWMWgtMnYySDhWMUg2djJINWEyIDIgMCAwIDAtMiAydjE0YTIgMiAwIDAgMCAyIDJoMTRhMiAyIDAgMCAwIDItMlY1YTIgMiAwIDAgMC0yLTJtLTIuNDcgOC4wNkwxNS40NyAxMGwtNC44OCA0Ljg4LTIuMTItMi4xMi0xLjA2IDEuMDZMMTAuNTkgMTd6IiAvPjwvc3ZnPg==) </span> <span class="md-content__button md-icon actions-date" title="Published on 2024-05-17">![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTkgMTB2Mkg3di0yem00IDB2MmgtMnYtMnptNCAwdjJoLTJ2LTJ6bTItN2EyIDIgMCAwIDEgMiAydjE0YTIgMiAwIDAgMS0yIDJINWEyIDIgMCAwIDEtMi0yVjVhMiAyIDAgMCAxIDItMmgxVjFoMnYyaDhWMWgydjJ6bTAgMTZWOEg1djExek05IDE0djJIN3YtMnptNCAwdjJoLTJ2LTJ6bTQgMHYyaC0ydi0yeiIgLz48L3N2Zz4=)</span> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/edit/main/docs/patterns/development-platform/0032-managing-iac-and-package-rollback.md" class="md-content__button md-icon" title="Edit this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTEwIDIwSDZWNGg3djVoNXYzLjFsMi0yVjhsLTYtNkg2Yy0xLjEgMC0yIC45LTIgMnYxNmMwIDEuMS45IDIgMiAyaDR6bTEwLjItN2MuMSAwIC4zLjEuNC4ybDEuMyAxLjNjLjIuMi4yLjYgMCAuOGwtMSAxLTIuMS0yLjEgMS0xYy4xLS4xLjItLjIuNC0uMm0wIDMuOUwxNC4xIDIzSDEydi0yLjFsNi4xLTYuMXoiIC8+PC9zdmc+" /></a> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/blob/main/docs/patterns/development-platform/0032-managing-iac-and-package-rollback.md" class="md-content__button md-icon" title="View source of this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE3IDE4Yy41NiAwIDEgLjQ0IDEgMXMtLjQ0IDEtMSAxLTEtLjQ0LTEtMSAuNDQtMSAxLTFtMC0zYy0yLjczIDAtNS4wNiAxLjY2LTYgNCAuOTQgMi4zNCAzLjI3IDQgNiA0czUuMDYtMS42NiA2LTRjLS45NC0yLjM0LTMuMjctNC02LTRtMCA2LjVhMi41IDIuNSAwIDAgMS0yLjUtMi41IDIuNSAyLjUgMCAwIDEgMi41LTIuNSAyLjUgMi41IDAgMCAxIDIuNSAyLjUgMi41IDIuNSAwIDAgMS0yLjUgMi41TTkuMjcgMjBINlY0aDd2NWg1djQuMDdjLjcuMDggMS4zNi4yNSAyIC40OVY4bC02LTZINmEyIDIgMCAwIDAtMiAydjE2YTIgMiAwIDAgMCAyIDJoNC41YTguMiA4LjIgMCAwIDEtMS4yMy0yIiAvPjwvc3ZnPg==" /></a>

Document Metadata

|  |  |
|----|----|
| Identifier | **`LMP-PAT-0032`** |
| Type | **Functional Design Pattern** |
| Status | **Published** |
| Approvals | <span class="md-tag">LMP Migration Architecture Approval</span> |
| Published on | **May 17, 2024** |
| Valid From | **May 17, 2024** |
| Authors | <span class="md-source-file__fact"> </span> |
| Tags | <span class="md-tag">Development Platform</span> |
| Technology Capabilities | <span class="md-tag">Delivery / Development / Design & Development / Development Tools & SDKs</span><span class="md-tag">Delivery / Operations / Deployment & Administration</span> |

# Patterns for Infra-as-Code and Code Rollback<a href="#patterns-for-infra-as-code-and-code-rollback" class="headerlink" title="Permanent link">¶</a>

## Anti-Pattern: "Fix Forward" rollback using single repo for both build & deployment<a href="#anti-pattern-fix-forward-rollback-using-single-repo-for-both-build-deployment" class="headerlink" title="Permanent link">¶</a>

Relevant to e.g. resource creation, resource configuration change or software package deployment

### Pros and Cons of the Anti-Pattern<a href="#pros-and-cons-of-the-anti-pattern" class="headerlink" title="Permanent link">¶</a>

- **Good**, because simple
- **Neutral**, because dependent on good commit message hygiene to keep team up-to-speed with what has happened and why, but commit messages should follow best practice anyway
- **Bad**, because does not provide an acceptable "rollback" procedure that can be included in Change Control requests (an operator cannot always be expected to perform such a rollback without deeper understanding of codebase, Git skills, etc.)
- **Bad**, because does not readily cater for resources with data (other than those that support e.g. soft delete)
- **Bad**, because difficult to rollback if commits have been made to the main branch since the release tag and before the release issue. Alternative approach is to use "release branches", but these, too, lead to a need to merge `release-*` back into main, which can introduce its own operational overhead

### Example using Tags<a href="#example-using-tags" class="headerlink" title="Permanent link">¶</a>

![Rollback Anti-pattern using Tags](0032-managing-iac-and-package-rollback.assets/image-001.png)

### Example using Release Branches<a href="#example-using-release-branches" class="headerlink" title="Permanent link">¶</a>

![Rollback Anti-pattern using Release Branches](0032-managing-iac-and-package-rollback.assets/image-001.png)

## Pattern 1: Build Versioned Artefacts, Deploy Separately<a href="#pattern-1-build-versioned-artefacts-deploy-separately" class="headerlink" title="Permanent link">¶</a>

Use one Project and pipeline to publish a versioned artefact (e.g. generic `.tar`, Terraform module registry, or OCI artifact registry). Use a second Project to configure and deploy the given artefact or collection of artifacts.

For Terraform, implementations include:

- \(1\) publishing a 'generic' Gitlab artefact (e.g. a .tar) and using a before_script to unpack before applying
- \(2\) using GitOps via the Flux Terraform Controller
- \(3\) publishing the Terraform project that is to be installed in multiple environments as a pseudo-module to a module registry

### Pros and Cons of Pattern 1<a href="#pros-and-cons-of-pattern-1" class="headerlink" title="Permanent link">¶</a>

- **Good**, because still simple
- **Good**, because separation of "build" and "release" concerns has nice properties (e.g. shorter pipeline duration, fewer stages, simpler RBAC, no need for optional 'manual' deployment stages)
- **Good**, because rollback procedure is easy to describe and follow ("revert version in this deployment manifest" or "use old version as variable in Gitlab GUI when running pipeline")
- **Bad**, because additional GitLab Projects to create and maintain

### Example of a 'Build' Project Pipeline<a href="#example-of-a-build-project-pipeline" class="headerlink" title="Permanent link">¶</a>

![Rollback Build Pipeline](0032-managing-iac-and-package-rollback.assets/image-001.png)

Separate config or manifest-only "deploy" Project (& Pipeline, if not using GitOps)

### Example 'Deploy' Project - Type A (Commit versions in manifest(s))<a href="#example-deploy-project-type-a-commit-versions-in-manifests" class="headerlink" title="Permanent link">¶</a>

Maintain deployment manifest, containing version numbers per environment, as file(s) in repo.

![Rollback via Manifests](0032-managing-iac-and-package-rollback.assets/image-001.png)

#### Pros and Cons of Example 1<a href="#pros-and-cons-of-example-1" class="headerlink" title="Permanent link">¶</a>

- **Good**, because development team can prepare a Merge Request, in Draft, ahead of a change window & validate pipelines, merge conflicts, etc.
- **Good**, because files in repository listing versions per component, per environment give easily "diff-able" comparison of what version is deployed where
- **Neutral**, because operator may need to become familiar with Gitlab merge request GUI and, on occasion, may need to troubleshoot a failed merge
- **Neutral**, because deployment pipelines are more complex if true artifacts are not used (e.g. cloning a code repo instead of deploying a package, Chart or module), but the latter is preferred for this reason and relatively simple to implement
- **Bad**, because harder to see history of pipelines or to get "current state" of what's deployed in which environment
- **Bad**, because operator needs to be familiar enough with Git and/or Gitlab to be able to revert a version number in a manifest in the event of failure

### Example 'Deploy' Project Type B (Run pipelines, entering version numbers at runtime)<a href="#example-deploy-project-type-b-run-pipelines-entering-version-numbers-at-runtime" class="headerlink" title="Permanent link">¶</a>

Instead of maintaining version numbers as committed files in the repository, use the Gitlab interface or API to handle versions at pipeline execution time.

![Rollback via Pipeline Interface](0032-managing-iac-and-package-rollback.assets/image-001.png)

#### Pros and Cons of Example 2<a href="#pros-and-cons-of-example-2" class="headerlink" title="Permanent link">¶</a>

- **Good**, because very simple for operator, removes need to understand and potentially troubleshoot a Merge Request issue
- **Bad**, because harder to see history of pipelines or to get "current state" of what's deployed in which environment

<span class="md-source-file__fact"> <span class="md-icon" title="Last update"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIxIDEzLjFjLS4xIDAtLjMuMS0uNC4ybC0xIDEgMi4xIDIuMSAxLTFjLjItLjIuMi0uNiAwLS44bC0xLjMtMS4zYy0uMS0uMS0uMi0uMi0uNC0uMm0tMS45IDEuOC02LjEgNlYyM2gyLjFsNi4xLTYuMXpNMTIuNSA3djUuMmw0IDIuNC0xIDFMMTEgMTNWN3pNMTEgMjEuOWMtNS4xLS41LTktNC44LTktOS45QzIgNi41IDYuNSAyIDEyIDJjNS4zIDAgOS42IDQuMSAxMCA5LjMtLjMtLjEtLjYtLjItMS0uMnMtLjcuMS0xIC4yQzE5LjYgNy4yIDE2LjIgNCAxMiA0Yy00LjQgMC04IDMuNi04IDggMCA0LjEgMy4xIDcuNSA3LjEgNy45bC0uMS4yeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="May 30, 2025 16:15:49 UTC">May 30, 2025</span> </span> <span class="md-source-file__fact"> <span class="md-icon" title="Created"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE0LjQ3IDE1LjA4IDExIDEzVjdoMS41djUuMjVsMy4wOCAxLjgzYy0uNDEuMjgtLjc5LjYyLTEuMTEgMW0tMS4zOSA0Ljg0Yy0uMzYuMDUtLjcxLjA4LTEuMDguMDgtNC40MiAwLTgtMy41OC04LThzMy41OC04IDgtOCA4IDMuNTggOCA4YzAgLjM3LS4wMy43Mi0uMDggMS4wOC42OS4xIDEuMzMuMzIgMS45Mi42NC4xLS41Ni4xNi0xLjEzLjE2LTEuNzIgMC01LjUtNC41LTEwLTEwLTEwUzIgNi41IDIgMTJzNC40NyAxMCAxMCAxMGMuNTkgMCAxLjE2LS4wNiAxLjcyLS4xNi0uMzItLjU5LS41NC0xLjIzLS42NC0xLjkyTTE4IDE1djNoLTN2MmgzdjNoMnYtM2gzdi0yaC0zdi0zeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="October 11, 2024 08:31:52 UTC">October 11, 2024</span> </span>

<a href="../../deployment-and-administration/0073-app-deployment-cloudpc-company-portal-design-pattern/" class="md-footer__link md-footer__link--prev" aria-label="Previous: Application deployment using Cloud PC W365 and Company Portal Pattern"></a>

<div class="md-footer__button md-icon">

![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIwIDExdjJIOGw1LjUgNS41LTEuNDIgMS40Mkw0LjE2IDEybDcuOTItNy45MkwxMy41IDUuNSA4IDExeiIgLz48L3N2Zz4=)

</div>

<div class="md-footer__title">

<span class="md-footer__direction"> Previous </span>

<div class="md-ellipsis">

Application deployment using Cloud PC W365 and Company Portal Pattern

</div>

</div>

<a href="../0033-managing-releasable-versions/" class="md-footer__link md-footer__link--next" aria-label="Next: Patterns for Managing Versions of Code &amp;amp; Configuration"></a>

<div class="md-footer__title">

<span class="md-footer__direction"> Next </span>

<div class="md-ellipsis">

Patterns for Managing Versions of Code & Configuration

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
