# DevSecOps Checklist — Index

> **Agent usage:** This index summarises the LSEG DevSecOps checklist categories and their
> key rules. When **generating IaC scaffolding** or **reviewing a SAD**, evaluate the relevant
> categories below and apply the mandatory rules. Load individual files only when the user
> asks for full details on a specific topic.
>
> **Mandatory trigger:** The `/generate-iac-scaffolding` prompt **must** evaluate sections
> marked ⚡ (IaC-impacting) before emitting any Terraform or pipeline code.

---

## Master Compliance Checklist

The authoritative checklist covering all categories is:
📄 [compliance/checklist.md](compliance/checklist.md)

Use this file when doing a full DevSecOps review. The sections below are
condensed summaries for quick agent-side evaluation.

---

## ⚡ Infrastructure as Code (IaC)

**File:** [iac/TERRAFORM_STATE_MANAGEMENT.md](iac/TERRAFORM_STATE_MANAGEMENT.md)

| Rule | Mandatory? | IaC Impact |
|------|-----------|------------|
| CPF modules used for all supported resources | ✅ Mandatory | All resource blocks must be CPF module calls |
| CPF modules referenced from Artifactory (not GitLab) | ✅ Mandatory | `source = "artifactory.lseg.com/..."` |
| `terraform-core` CI template used | ✅ Mandatory | `ci/module.yml` must extend `.terraform-core` |
| Approved providers enforced via `required_providers` | ✅ Mandatory | `providers.tf` must pin azurerm ~> 4.33 |
| Environment-specific tfvars files | ✅ Mandatory | `environments/<env>/infra.tfvars` per env |
| Remote state with Azure Blob + state locking | ✅ Mandatory | `backend "azurerm"` with `use_azuread_auth = true` |
| Sensitive variables marked `sensitive = true` | ✅ Mandatory | All passwords/secrets/keys in `variable.tf` |
| State encryption at rest | ✅ Mandatory | Azure Storage encryption (built-in) |
| Separate state key per environment | ✅ Mandatory | `TF_CORE_STATE_BACKEND_TF_STATE_FILE_KEY` per env |

---

## ⚡ Security Practices

**File:** [security/SECURITY_PRACTICES.md](security/SECURITY_PRACTICES.md)

| Rule | Mandatory? | IaC Impact |
|------|-----------|------------|
| No secrets in source control | ✅ Mandatory | No `default =` for passwords/keys in `variable.tf` |
| Secrets stored in Key Vault | ✅ Mandatory | Use `cpf-azure-prdsvc-keyvault` |
| Public network access disabled on PaaS resources | ✅ Mandatory | `public_network_access_enabled = false` |
| Managed Identity for service-to-service auth | ✅ Mandatory | `cpf-azure-prdsvc-userassignedidentity` |
| SCF (Security Control Framework) compliance | ✅ Mandatory | Document SCF control implementation during SAD analysis |
| No credentials in pipeline logs | ✅ Mandatory | Use `$MASKED_VAR` or vault-retrieved secrets only |
| Cyber Minimum Entry Criteria met | ✅ Mandatory | Review before PRD deployment |

---

## ⚡ CI/CD Pipeline

**Files:** [cicd/PIPELINE_CONFIGURATIONS.md](cicd/PIPELINE_CONFIGURATIONS.md) · [cicd/DEPLOYMENT_STRATEGIES.md](cicd/DEPLOYMENT_STRATEGIES.md) · [cicd/DEPLOYMENT_SAFETY.md](cicd/DEPLOYMENT_SAFETY.md) · [cicd/DOWNSTREAM_PIPELINES.md](cicd/DOWNSTREAM_PIPELINES.md) · [cicd/TEMPLATES_REF.md](cicd/TEMPLATES_REF.md)

| Rule | Mandatory? | IaC Impact |
|------|-----------|------------|
| GCF (GitLab Compliance Framework) enabled | ✅ Mandatory | Repository-level setting |
| Protected branch configured | ✅ Mandatory | `main` branch protected |
| Deployments to non-dev only from protected branch | ✅ Mandatory | `rules: - if: $CI_COMMIT_BRANCH == $CI_DEFAULT_BRANCH` |
| Self-approval disabled on MRs | ✅ Mandatory | GitLab repository setting |
| CI pipeline must pass before MR merge | ✅ Mandatory | Merge request setting |
| Semantic versioning used | ✅ Mandatory | `ci/variables.yml` version tags |
| Versioned artifacts published to Artifactory | ✅ Mandatory | `0-upload-bams-scripts` job |
| Artifacts promoted through envs in order (DEV→PPR→PRD) | ✅ Mandatory | Pipeline stage ordering |
| Automated rollback mechanism for IaC | ✅ Mandatory | `terraform-destroy` job in `ci/module.yml` |
| Runner tooling setup automated | ✅ Mandatory | LSEG DX1 shared runners handle this |

---

## Repository Management

**Files:** [repository_management/BRANCHING_STRATEGIES.md](repository_management/BRANCHING_STRATEGIES.md) · [repository_management/BRANCH_PROTECTION.md](repository_management/BRANCH_PROTECTION.md) · [repository_management/GITLAB_GIT_FLOW.md](repository_management/GITLAB_GIT_FLOW.md) · [repository_management/GITLAB_RBAC.md](repository_management/GITLAB_RBAC.md) · [repository_management/MERGE_REQUESTS.md](repository_management/MERGE_REQUESTS.md) · [repository_management/MERGE_REQUEST_TEMPLATES.md](repository_management/MERGE_REQUEST_TEMPLATES.md) · [repository_management/REPOSITORY_HYGIENE.md](repository_management/REPOSITORY_HYGIENE.md) · [repository_management/REPOSITORY_STRUCTURE.md](repository_management/REPOSITORY_STRUCTURE.md)

| Rule | Summary |
|------|---------|
| GitFlow or Trunk-Based Development | Both approved. Trunk-based recommended for IaC repos. |
| Standard branch naming | `feature/`, `hotfix/`, `release/` prefixes |
| No long-lived stale branches | Delete feature branches after merge |
| RBAC enforced in GitLab | Maintainer+ required for protected branch pushes |
| MR templates used | Standardise review checklists |

---

## Conventions

**Files:** [conventions/COMMIT_CONVENTION.md](conventions/COMMIT_CONVENTION.md) · [conventions/GIT_TAGGING.md](conventions/GIT_TAGGING.md) · [conventions/NAMING_CONVENTION.md](conventions/NAMING_CONVENTION.md) · [conventions/VERSIONING_CONVENTION.md](conventions/VERSIONING_CONVENTION.md) · [conventions/CROSSLINKING_ISSUES.md](conventions/CROSSLINKING_ISSUES.md)

| Convention | Rule |
|-----------|------|
| Commit messages | Conventional Commits format: `feat:`, `fix:`, `chore:`, `docs:` |
| Git tags | Semantic versioning: `v1.2.3` on release commits |
| Resource naming | LSEG pattern: `{org_id}-{app_id}-{env}-{resource-abbr}-{location}-{index}` (auto-generated by CPF modules) |
| Versioning | SemVer: `MAJOR.MINOR.PATCH` |
| Issue cross-linking | Reference GitLab issue in commit: `Closes #123` |

---

## Artifact Management

**File:** [artifact_management/ARTIFACT_MANAGEMENT.md](artifact_management/ARTIFACT_MANAGEMENT.md)

| Rule | Summary |
|------|---------|
| Enterprise Artifactory for all artefacts | No public registries (npm, Docker Hub) for production |
| Versioned builds publish to Artifactory | `bams-upload` job in CI pipeline |
| Deployments consume from Artifactory | `TF_TOKEN_artifactory_lseg_com` for Terraform modules |

---

## Documentation

**Files:** [documentation/API_DOCUMENTATION.md](documentation/API_DOCUMENTATION.md) · [documentation/CHANGELOGS.md](documentation/CHANGELOGS.md) · [documentation/DOCUMENTATION_PRACTICES.md](documentation/DOCUMENTATION_PRACTICES.md)

| Rule | Summary |
|------|---------|
| API documentation | OpenAPI spec required for all REST APIs |
| Changelog maintained | `CHANGELOG.md` updated on each release |
| README with deployment plan | Agreed by app + ops team |

---

## DevSecOps Evaluation Checklist for IaC Generation

> When generating IaC scaffolding, confirm the following before completing:

- [ ] **IaC:** All resources use CPF modules from Artifactory
- [ ] **IaC:** `providers.tf` uses approved provider versions and Artifactory network mirror
- [ ] **IaC:** State stored in Azure Blob with `use_azuread_auth = true`
- [ ] **IaC:** Separate state key per environment
- [ ] **Security:** `public_network_access_enabled = false` on all PaaS resources
- [ ] **Security:** Key Vault used for all secrets (no `default =` for sensitive vars)
- [ ] **Security:** Managed Identity for service-to-service auth
- [ ] **Security:** WAF in Prevention mode for PRD (Detection for DEV)
- [ ] **Security:** PostgreSQL: AD auth only, password auth disabled
- [ ] **Security:** Storage: OAuth auth only, key access disabled
- [ ] **Pipeline:** `tags: ["LSEG"]` on all GitLab jobs
- [ ] **Pipeline:** `0-jfrog-token` job included in `vault` stage
- [ ] **Pipeline:** `terraform-destroy` job is manual-only
- [ ] **Pipeline:** Environment-specific `infra.tfvars` files generated for each env
- [ ] **Tags:** `opt-datadog: require` in all resource tags
