<a href="https://app.pages.dx1.lseg.com/app-51723/migration-patterns/mig-pat-source-to-target/LMP-PAT-0065" class="md-content__button md-icon md-status--superseded" title="Status: Superseded by LMP-PAT-0065"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIxLjUgMTQuNSAxNiAyMGwtNS41LTUuNSAxLjQxLTEuNDFMMTUgMTYuMTdWMTAuNUMxNSA4IDEzIDYgMTAuNSA2SDRWNGg2LjVhNi41IDYuNSAwIDAgMSA2LjUgNi41djUuNjdsMy4wOS0zLjA5eiIgLz48L3N2Zz4=" /></a> <span class="md-content__button md-icon md-status--superseded" title="Valid between 2024-05-20 and 2025-05-30">![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE5IDE5SDVWOGgxNG0wLTVoLTFWMWgtMnYySDhWMUg2djJINWEyIDIgMCAwIDAtMiAydjE0YTIgMiAwIDAgMCAyIDJoMTRhMiAyIDAgMCAwIDItMlY1YTIgMiAwIDAgMC0yLTJNOS4zMSAxN2wyLjQ0LTIuNDRMMTQuMTkgMTdsMS4wNi0xLjA2LTIuNDQtMi40NCAyLjQ0LTIuNDRMMTQuMTkgMTBsLTIuNDQgMi40NEw5LjMxIDEwbC0xLjA2IDEuMDYgMi40NCAyLjQ0LTIuNDQgMi40NHoiIC8+PC9zdmc+)</span> <span class="md-content__button md-icon actions-date" title="Published on 2024-05-20">![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTkgMTB2Mkg3di0yem00IDB2MmgtMnYtMnptNCAwdjJoLTJ2LTJ6bTItN2EyIDIgMCAwIDEgMiAydjE0YTIgMiAwIDAgMS0yIDJINWEyIDIgMCAwIDEtMi0yVjVhMiAyIDAgMCAxIDItMmgxVjFoMnYyaDhWMWgydjJ6bTAgMTZWOEg1djExek05IDE0djJIN3YtMnptNCAwdjJoLTJ2LTJ6bTQgMHYyaC0ydi0yeiIgLz48L3N2Zz4=)</span> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/edit/main/docs/patterns/development-platform/0035-segregation-of-duties.md" class="md-content__button md-icon" title="Edit this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTEwIDIwSDZWNGg3djVoNXYzLjFsMi0yVjhsLTYtNkg2Yy0xLjEgMC0yIC45LTIgMnYxNmMwIDEuMS45IDIgMiAyaDR6bTEwLjItN2MuMSAwIC4zLjEuNC4ybDEuMyAxLjNjLjIuMi4yLjYgMCAuOGwtMSAxLTIuMS0yLjEgMS0xYy4xLS4xLjItLjIuNC0uMm0wIDMuOUwxNC4xIDIzSDEydi0yLjFsNi4xLTYuMXoiIC8+PC9zdmc+" /></a> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/blob/main/docs/patterns/development-platform/0035-segregation-of-duties.md" class="md-content__button md-icon" title="View source of this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE3IDE4Yy41NiAwIDEgLjQ0IDEgMXMtLjQ0IDEtMSAxLTEtLjQ0LTEtMSAuNDQtMSAxLTFtMC0zYy0yLjczIDAtNS4wNiAxLjY2LTYgNCAuOTQgMi4zNCAzLjI3IDQgNiA0czUuMDYtMS42NiA2LTRjLS45NC0yLjM0LTMuMjctNC02LTRtMCA2LjVhMi41IDIuNSAwIDAgMS0yLjUtMi41IDIuNSAyLjUgMCAwIDEgMi41LTIuNSAyLjUgMi41IDAgMCAxIDIuNSAyLjUgMi41IDIuNSAwIDAgMS0yLjUgMi41TTkuMjcgMjBINlY0aDd2NWg1djQuMDdjLjcuMDggMS4zNi4yNSAyIC40OVY4bC02LTZINmEyIDIgMCAwIDAtMiAydjE2YTIgMiAwIDAgMCAyIDJoNC41YTguMiA4LjIgMCAwIDEtMS4yMy0yIiAvPjwvc3ZnPg==" /></a>

Document Metadata

|  |  |
|----|----|
| Identifier | **`LMP-PAT-0035`** |
| Type | **Functional Design Pattern** |
| Status | **Superseded** |
| Approvals | <span class="md-tag">LMP Migration Architecture Approval</span> |
| Published on | **May 20, 2024** |
| Valid From | **May 20, 2024** |
| Valid To | **May 30, 2025** |
| Superseded By | **[LMP-PAT-0065](https://app.pages.dx1.lseg.com/app-51723/migration-patterns/mig-pat-source-to-target/LMP-PAT-0065)** |
| Authors | <span class="md-source-file__fact"> </span> |
| Tags | <span class="md-tag">Development Platform</span> |
| Technology Capabilities | <span class="md-tag">Delivery / Development / Design & Development / Development Tools & SDKs</span><span class="md-tag">Delivery / Operations / Deployment & Administration</span> |

# Patterns for Managing Segregation of Duties via Gitlab<a href="#patterns-for-managing-segregation-of-duties-via-gitlab" class="headerlink" title="Permanent link">¶</a>

In many LMP environments there will be a requirement to segregate the permissions of:

- **"Developers"** - who write code (and infrastructure-as-code), run tests and build packages
- **"Operators"** - who take code packages, deploy them and operate them

Such approaches have their origin in ITIL, ISO 27001, Sarbanes-Oxley, PCI-DSS and other regulations; they are common practice across the Financial Services industry.

## Pattern - Using Gitlab Protected Environments<a href="#pattern-using-gitlab-protected-environments" class="headerlink" title="Permanent link">¶</a>

To achieve natively in Gitlab, use GitLab's [Protected Environments](https://docs.gitlab.com/ee/ci/environments/protected_environments.html) feature.

It allows us to create "approver" and "deployer" rules, preventing deployers from deploying until approvers have approved.

To set it up, we do the following:

- Configure Gitlab *Groups* for (1) approvers and (2) deployers
- Invite the new Groups to your project via **Manage \> Members \> Invite a Group**

> **Note**: **if the "Invite a Group" button is missing,** make sure to uncheck *Projects in "group name" cannot be shared with other groups* in Settings \> General \> Permissions and group features.

- Configure Gitlab *Environments* that model your software's environments, e.g. `production`, `uat` and `development`. See **Operate \> Environments** in Gitlab
- Configure *Protected Environments* (see **Settings \> CI/CD \> Protected Environments**), assigning the approver and deployer groups created above
- Configure an `environment` in the Gitlab Jobs<sup><a href="#fn:1" class="footnote-ref">1</a></sup> that need protection, e.g.:

<div class="language-yaml highlight">

<table class="highlighttable">
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<tbody>
<tr>
<td class="linenos"><div class="linenodiv">
<pre><code> 1
 2
 3
 4
 5
 6
 7
 8
 9
10</code></pre>
</div></td>
<td class="code"><div>
<pre><code>stages:
  - deploy
&#10;production:
  stage: deploy
  script:
    - &#39;echo &quot;Deploying to ${CI_ENVIRONMENT_NAME}&quot;&#39;
  environment:
    name: ${CI_JOB_NAME}
    action: start</code></pre>
</div></td>
</tr>
</tbody>
</table>

</div>

Now, when a pipeline runs, manual approval will be required (to be granted in **Operate \> Environments**) prior to deployment being permitted.

![Protected Environments](0035-segregation-of-duties.assets/image-001.png)

### Pros and Cons of Protected Environments<a href="#pros-and-cons-of-protected-environments" class="headerlink" title="Permanent link">¶</a>

- **Good**, because it is native to Gitlab and simple to configure
- **Neutral**, because there have been reports of problems with the "Invite a Group" button being missing, but this seems to be controlled by the '*Projects in "group name" cannot be shared with other groups*' setting
- **Neutral**, because control is Gitlab native, requiring operators to be familiar with Gitlab, but this is the Group's strategic CI/CD tooling
- **Neutral**, because there are additional Gitlab groups to which users must be added, but this will be required by any alternative solution too
- **Neutral**, because a developer could in theory edit a pipeline to remove the `environment`, removing approval, but if this is a concern, then `.gitlab-ci.yml` can be referenced in a different project

## Pattern - Using Flux, GitOps & Codeowners files<a href="#pattern-using-flux-gitops-codeowners-files" class="headerlink" title="Permanent link">¶</a>

In this pattern, Flux GitOps is used to synchronise the contents of a GitOps repository, for example one containing a collection of manifests, with a Kubernetes namespace.

To separate environments:

- A "base" directory contains manifests representative of all environments, but
- "Overlay" directories (e.g. `overlays/uat` and `overlays/prod`) contain files representing environment specific differences, typically expressed as `kustomize.yaml` files containing expressions that replace fragments of manifests in `base` with environment specifics, e.g. domain names, image names, etc.

To separate approval:

- Approvers can approve merge requests into the branch that is being synchronised. Gitlab Merge Request approvals rules can be set to require approval(s) from specific groups on specific branches
- If Merge Requests cannot be pre-prepared prior to a release, `CODEOWNERS` files can be used to limit the groups of users that can change production overlays

To separate deployment:

- This becomes unnecessary, because there is no longer a "deployment" stage or pipeline to run. Once the new code is in the synchronised branch, the Flux GitOps system will synchronise it, deploying it automatically

![Using Flux GitOps](0035-segregation-of-duties.assets/image-001.png)

### Pros and Cons of the GitOps approach<a href="#pros-and-cons-of-the-gitops-approach" class="headerlink" title="Permanent link">¶</a>

- **Good**, because there are no deployment pipelines to build and maintain
- **Good**, because the status of the repository implicitly indicates the status of the given environment (unless there are issues with synchronizing a deployment)
- **Good**, because Kustomize is native to `kubectl` and it is easy to use `--dry-run` to investigate differences between environments
- **Neutral**, because rollback becomes a matter of reverting a merge or applying equal and opposite configuration changes, but some operator teams may not be sufficiently familiar with Git
- **Neutral**, because it requires AKS or Kubernetes, but many teams are using AKS and Flux is already used for some Foundation deployments
- **Bad**, because some scenarios (e.g. resource removal) can require manual intervention
- **Bad**, because there is an additional tool to learn (Flux, Kustomize) and the Kustomize documentation is imperfect for more advanced scenarios

## Anti-Pattern - Using a Separate Project for Deployments<a href="#anti-pattern-using-a-separate-project-for-deployments" class="headerlink" title="Permanent link">¶</a>

An alternative is to use a separate Gitlab project for deployments, controlling access via Gitlab RBAC. For example if a Developer were granted the `Guest` or `Reporter` roles, they would not be able to run a pipeline.

### Pros and Cons of a Separate Project<a href="#pros-and-cons-of-a-separate-project" class="headerlink" title="Permanent link">¶</a>

- **Neutral**, because it doesn't depend on Gitlab-specific features, but Gitlab is the Group's strategic CI/CD tooling
- **Bad**, because it requires an additional repository in addition to those representing code and config
- **Bad**, because although the 'Guest' and 'Reporter' roles would prevent a developer from running a pipeline, they would also restrict access to other features that require at least the Developer role<sup><a href="#fn:2" class="footnote-ref">2</a></sup> such as Merge Request reviews which may be useful in the context of release preparation.

## Further Reading<a href="#further-reading" class="headerlink" title="Permanent link">¶</a>

<div class="footnote">

------------------------------------------------------------------------

1.  <div id="fn:1">

    [Gitlab Deployment Approvals](https://docs.gitlab.com/ee/ci/environments/deployment_approvals.html) <a href="#fnref:1" class="footnote-backref" title="Jump back to footnote 1 in the text">↩︎</a>

    </div>

2.  <div id="fn:2">

    [Gitlab Permissions and roles](https://docs.gitlab.com/ee/user/permissions.html) <a href="#fnref:2" class="footnote-backref" title="Jump back to footnote 2 in the text">↩︎</a>

    </div>

</div>

<span class="md-source-file__fact"> <span class="md-icon" title="Last update"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIxIDEzLjFjLS4xIDAtLjMuMS0uNC4ybC0xIDEgMi4xIDIuMSAxLTFjLjItLjIuMi0uNiAwLS44bC0xLjMtMS4zYy0uMS0uMS0uMi0uMi0uNC0uMm0tMS45IDEuOC02LjEgNlYyM2gyLjFsNi4xLTYuMXpNMTIuNSA3djUuMmw0IDIuNC0xIDFMMTEgMTNWN3pNMTEgMjEuOWMtNS4xLS41LTktNC44LTktOS45QzIgNi41IDYuNSAyIDEyIDJjNS4zIDAgOS42IDQuMSAxMCA5LjMtLjMtLjEtLjYtLjItMS0uMnMtLjcuMS0xIC4yQzE5LjYgNy4yIDE2LjIgNCAxMiA0Yy00LjQgMC04IDMuNi04IDggMCA0LjEgMy4xIDcuNSA3LjEgNy45bC0uMS4yeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="October 29, 2025 09:40:37 UTC">October 29, 2025</span> </span> <span class="md-source-file__fact"> <span class="md-icon" title="Created"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE0LjQ3IDE1LjA4IDExIDEzVjdoMS41djUuMjVsMy4wOCAxLjgzYy0uNDEuMjgtLjc5LjYyLTEuMTEgMW0tMS4zOSA0Ljg0Yy0uMzYuMDUtLjcxLjA4LTEuMDguMDgtNC40MiAwLTgtMy41OC04LThzMy41OC04IDgtOCA4IDMuNTggOCA4YzAgLjM3LS4wMy43Mi0uMDggMS4wOC42OS4xIDEuMzMuMzIgMS45Mi42NC4xLS41Ni4xNi0xLjEzLjE2LTEuNzIgMC01LjUtNC41LTEwLTEwLTEwUzIgNi41IDIgMTJzNC40NyAxMCAxMCAxMGMuNTkgMCAxLjE2LS4wNiAxLjcyLS4xNi0uMzItLjU5LS41NC0xLjIzLS42NC0xLjkyTTE4IDE1djNoLTN2MmgzdjNoMnYtM2gzdi0yaC0zdi0zeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="October 11, 2024 08:31:52 UTC">October 11, 2024</span> </span>

<a href="../0034-terraform-artefacts/" class="md-footer__link md-footer__link--prev" aria-label="Previous: Patterns for Managing Terraform Artefacts"></a>

<div class="md-footer__button md-icon">

![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIwIDExdjJIOGw1LjUgNS41LTEuNDIgMS40Mkw0LjE2IDEybDcuOTItNy45MkwxMy41IDUuNSA4IDExeiIgLz48L3N2Zz4=)

</div>

<div class="md-footer__title">

<span class="md-footer__direction"> Previous </span>

<div class="md-ellipsis">

Patterns for Managing Terraform Artefacts

</div>

</div>

<a href="../0065-segregation-of-duties/" class="md-footer__link md-footer__link--next" aria-label="Next: Patterns for Managing Segregation of Duties via Gitlab"></a>

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
