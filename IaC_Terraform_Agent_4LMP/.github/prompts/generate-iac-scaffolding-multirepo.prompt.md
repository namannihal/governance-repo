---
agent: agent
version: 1.0.1
model: ['Claude Sonnet 4.6 (copilot)', 'GPT-5.3-Codex (copilot)']
description: >
  Step 3 of 3 (Option B) — Multi-repo IaC scaffolding. Invoked from
  /generate-iac-scaffolding when the user chooses Option B (dedicated Git repo
  per composite module group). Generates all repos, ci/ files, Terraform files,
  per-environment tfvars, and the VS Code workspace file.
tools:vscode, execute, read, agent, edit, search, web, browser, todo
[vscode, execute, read, agent, edit, search, web, browser, todo]
---

# IaC Scaffolding Generator — Option B (Multi-repo)

You are an expert Azure IaC engineer at LSEG. You have been routed here from
`/generate-iac-scaffolding` because the user chose **Option B** (dedicated Git
repository per composite module group). Carry forward the `<app-slug>`,
`<app-id>`, `<org-id>`, `<environments>`, `<cpf-module-count>`, and the already
loaded requirements brief and module plan.

---

## Load inputs

If not already loaded from `/generate-iac-scaffolding`, load these now:

1. **Requirements brief** — `../arch/<app-slug>-requirements.md`
2. **Module plan** — `../arch/<app-slug>-module-plan.md`
3. **Canonical template files** for reference:
   - `templates/infrastructure-main/infrastructure-main/.gitlab-ci.yml`
   - `templates/infrastructure-main/infrastructure-main/ci/module.yml`
   - `templates/infrastructure-main/infrastructure-main/ci/variables.yml`
   - `templates/infrastructure-main/infrastructure-main/terraform/providers.tf`
   - `templates/infrastructure-main/infrastructure-main/terraform/variable.tf`
   - `templates/infrastructure-main/infrastructure-main/terraform/data.tf`
   - `templates/infrastructure-main/infrastructure-main/environments/dev/infra.tfvars`
   - `templates/infrastructure-main/infrastructure-main/environments/prd-01/infra.tfvars`
4. **Platform guides** — `templates/PLATFORM-GUIDES-INDEX.md`
   - If the module plan contains `postgresqlserver`, `rediscache`, or `managedredis`,
     add the following TCP keepalive note to each repo's `README.md`:
     > **TCP keepalive:** Azure Load Balancer and Azure Firewall have a 4-minute TCP idle
     > timeout. Configure TCP keepalive at the application level for any long-running
     > connections to PostgreSQL or Redis. No Terraform configuration is required —
     > this is an application-level concern.
   - Use the **Azure Regions** table to verify subnet CIDRs are within the correct
     `/17` non-routable block for the target region.

---

## Shared Constraints — apply throughout

These rules are identical to Option A in `/generate-iac-scaffolding`. They are
reproduced here so this prompt is self-contained.

### Landing Zone Boundary — Critical Rule

LZ resources are **pre-provisioned by the platform team** and must **only** appear
as `data` blocks in `data.tf`. Never use `module` or `resource` blocks for:
- Resource Groups (app, platform, shared)
- Routable VNet (/23) and its pre-built subnets (Bastion, AGW, Workload)
- Non-Routable VNet (/17) — app team allocates subnets inside it; does not create the VNet
- Azure Firewall (hub-managed)
- Shared/platform Key Vault or shared Log Analytics Workspace

> **Never create with IaC (Azure Policy-managed or LZ-managed):**
> Bastion Host, Bastion Public IP, Windows VM Jump Host, Diagnostic Settings
> — all are managed by Azure Policy DINE or the platform team.

### CPF module source format (mandatory)

Always use the **Artifactory registry** format with a separate `version` constraint.
Never use the legacy `git::https://gitlab.dx1.lseg.com/...?ref=<tag>` format.

```hcl
# CORRECT
source  = "artifactory.lseg.com/app-51310-terraform-module-rel__cpf/<module-name>/azure"
version = ">= x.y.z, < next-major.0.0"

# WRONG — legacy GitLab format, forbidden
source = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/<module>.git?ref=1.2.0"
```

If a version is not yet in the module plan, use `@cpf-genie latest tag for <module-name>`
to retrieve it. Use `>= <latest-tag>, < <next-major>.0.0`.

### Dependency graph — Authoritative source

Extract `## Dependency Graph` from the module plan before writing any TF files.
This section has three tables:
- **Edge table** — output→input references between modules (drives output wiring)
- **Explicit `depends_on` edges** — ordering constraints where no HCL reference exists
- **Deployment tiers** — topological sort (determines which repos can be applied in parallel)

Use only these tables for `depends_on` blocks. If the module plan conflicts with the
guideline's tier table, the module plan wins; note the deviation in a comment.

### `providers.tf` (identical for every repo)

Use `templates/infrastructure-main/infrastructure-main/terraform/providers.tf` as the **version baseline**.
Read it, use its constraints as the starting point, and check whether a newer stable minor version
exists for each provider before generating. Do not downgrade below the template baseline.

**`azapi` and `time` are always required** — CPF modules use `azapi_resource` for ARM operations
not yet covered by the `azurerm` provider, and `time_sleep`/`time_rotating` for soft-delete and
CMK-rotation scenarios. Omitting either causes `terraform init` to fail.

The block below reflects the current template baseline (update versions as needed):

```hcl
terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = { source = "hashicorp/azurerm", version = "~> 4.33" }
    azuread = { source = "hashicorp/azuread", version = "~> 3.0.0" }
    azapi   = { source = "Azure/azapi",       version = "<= 1.15" }  # required by CPF modules internally
    time    = { source = "hashicorp/time",    version = "~> 0.9" }   # required by CPF modules internally
    random  = { source = "hashicorp/random",  version = "3.6.3" }
  }
  backend "azurerm" {
    use_azuread_auth = true
  }
}

provider "azurerm" {
  storage_use_azuread             = true
  resource_provider_registrations = "none"
  features {
    key_vault { purge_soft_delete_on_destroy = false }
  }
}
```

### Security hardening (mandatory in every repo's `main.tf`)

- `public_network_access_enabled = false` — Key Vault, Storage, Function App, PostgreSQL
- `active_directory_auth_enabled = true` + `password_auth_enabled = false` — PostgreSQL
- `enable_key_access = false` + `default_to_oauth_authentication = true` — Storage
- WAF policy `mode = var.waf_mode` defaulting to `"Detection"`; `"Prevention"` in PRD

### Private DNS Zones (Azure Policy-managed)

Do **not** create `module "dns_*"` blocks for standard PaaS zones
(`privatelink.vaultcore.azure.net`, `privatelink.blob.core.windows.net`,
`privatelink.azurewebsites.net`, `privatelink.postgres.database.azure.com`, etc.).
Reference them via `data.azurerm_private_dns_zone.*` in `data.tf`.
Only create DNS module blocks for app-specific zones not covered by platform policy.

### Variable mapping — avoid hardcoded literals

| Value category | Decision |
|---|---|
| Azure platform spec mandates | Keep hardcoded + inline comment |
| LSEG MEC security mandates (`public_network_access_enabled = false`, etc.) | Keep hardcoded |
| Fixed Azure delegation/PE sub-resource IDs (`group_ids`, `service_delegation_name`) | Keep hardcoded |
| Identity block `type = "UserAssigned"` | Keep hardcoded |
| CPF module `context` input | `var.*` (max 5 chars, auto-fill) |
| CPF module `instance` input | `var.*` (2-digit, auto-fill) |
| SKUs, port numbers, timeouts, priorities | `var.*` |
| Pool/listener/rule/settings names | `var.*` |
| Certificate names, worker runtime, DNS zone names | `var.*` |
| CMK rotation durations | `var.*` |

`context`/`instance` generation rules (mandatory for every CPF module or pattern call):
- Declare both inputs as editable variables in `variable.tf` and set defaults in `infra.tfvars`.
- `context` max length is 5 characters.
- `instance` must be a two-digit string (`"01"`, `"02"`, ...).
- Start at `"01"`; increment only when multiple resources of the same type use the same `context`.
- Example: two Key Vault modules with `context = "kv"` use instances `"01"` and `"02"`.

Mark `sensitive = true` for variables and outputs containing: admin passwords, connection strings, API keys, tokens — AND infrastructure topology data (full ARM resource IDs, FQDNs, hostnames, private IP addresses, UAI principal IDs, tenant IDs). Resource names and metadata (location, environment) do NOT require `sensitive = true`.

---

## B0 — Cross-stack ownership audit (mandatory when working from a cloned/existing repo)

**If the target repos already contain Terraform files cloned or copied from another
application, run this audit before creating or modifying any file.**

For every `terraform/` folder (flat layout per repo), list every
`module "azure-prdsvc-terraform-*"` block in any `.tf` file. Cross-reference the
**BAS Stack Isolation Rule** table in `.github/guidelines/iac-composite-modules.md`.

| Finding | Resolution |
|---|---|
| A module call belonging to a **dedicated sibling repo** found in the wrong repo (e.g. a Key Vault module in a compute repo; subnet/NSG/routetable modules in a compute repo) | Delete the `.tf` file (or block). Set the corresponding conditional flag to `false` in all tfvars for that repo. Add an input variable to receive the upstream resource's ID from the sibling repo's output. |
| A CPF module call **intrinsically required** by the compute resource with no dedicated sibling repo (e.g. Function App backing storage) | **Keep it** — see the "compute backing-resource exception" in the guidelines. |
| Any CPF module call duplicated across two repos guarded by `count = var.deploy_X ? 1 : 0` | Remove the conditional copy from the repo that doesn't own it. |

Add a `# Cross-stack audit` comment at the top of each affected `main.tf`.

**If working from scratch (new repos), skip this step.**

---

## B1 — Determine the module groups

Use the same composite module groups defined in
`.github/guidelines/iac-composite-modules.md`. Only create repos for groups
that are required by the module plan. Omit `postgresql` if no DB; omit `access`
if no Bastion/Jump Host.

Standard groups and their typical order of first deploy:
```
Tier 1 (parallel): <app-slug>-identity  ·  <app-slug>-networking  ·  <app-slug>-observability
Tier 2:            <app-slug>-keyvault
Tier 3 (parallel): <app-slug>-storage   ·  <app-slug>-postgresql
Tier 4:            <app-slug>-compute
Tier 5 (parallel): <app-slug>-appgateway  ·  <app-slug>-access
```

---

## B2 — Create the directory structure for each repo

Each repo has an **identical wrapper** and a **flat `terraform/`** layout
(there is no `modules/` subdirectory — the CPF module calls go directly in
`terraform/main.tf`).

```
iac/<app-slug>-<group>/
├── .gitignore
├── .gitlab-ci.yml                  ← same parent-pipeline structure as Option A
├── ci/
│   ├── module.yml                  ← identical to Option A template
│   └── variables.yml               ← same variables; TF_CORE_TERRAFORM_PATH = "terraform"
├── environments/
│   ├── dev/infra.tfvars
│   ├── ppr-01/infra.tfvars
│   └── prd-01/infra.tfvars         ← (add ppr-02 if required)
└── terraform/
    ├── providers.tf
    ├── variable.tf
    ├── data.tf                     ← LZ data sources relevant to this group only
    ├── main.tf                     ← FLAT: CPF module calls only (no composite wrapper)
    └── outputs.tf
```

> **The `ci/module.yml` is identical for every repo** — copy it unchanged from
> the template at `templates/infrastructure-main/infrastructure-main/ci/module.yml`.
> The `ci/variables.yml` uses the same `APP_ID` and `ARTIFACTORY_ASSET_ID` as
> Option A, but `TF_CORE_TERRAFORM_PATH` stays `"terraform"` for every repo.

---

## B3 — TF state key convention per repo

Each repo stores its state under a distinct key within the shared storage
container. Use this pattern in each repo's `.gitlab-ci.yml` environment job:

```yaml
TF_CORE_STATE_BACKEND_TF_STATE_FILE_KEY: "infra/${ENV}/<app-slug>/<group>/terraform.tfstate"
```

Example for `edp-uiux-keyvault`:
```yaml
TF_CORE_STATE_BACKEND_TF_STATE_FILE_KEY: "infra/${ENV}/edp-uiux/keyvault/terraform.tfstate"
```

The `TF_CORE_STATE_BACKEND_AZURE_STORAGE_ACCOUNT` and
`TF_CORE_STATE_BACKEND_AZURE_RESOURCE_GROUP` are the **same values** for all repos
— all repos share the same backend storage account. Only the state file key differs.

---

## B4 — Cross-tier output wiring via tfvars

In Option B there is no shared Terraform graph, so outputs from an upstream repo
cannot be read with `module.<name>.output`. Instead:

1. The upstream repo's `outputs.tf` prints values after `terraform apply`.
2. A human (or automation script) copies those output values into the downstream
   repo's `infra.tfvars` as plain input variables.
3. The downstream repo's `variable.tf` declares those as regular `string`
   (or `list(string)`) variables with an explanatory description.

**Placeholder pattern in downstream `infra.tfvars`** (until upstream is applied):
```hcl
# ── Outputs from <app-slug>-identity (populate after that repo's first apply) ──
uai_funcapp_id           = "[TODO: copy from <app-slug>-identity outputs]"
uai_funcapp_principal_id = "[TODO: copy from <app-slug>-identity outputs]"
uai_storage_principal_id = "[TODO: copy from <app-slug>-identity outputs]"

# ── Outputs from <app-slug>-keyvault ──
keyvault_id   = "[TODO: copy from <app-slug>-keyvault outputs]"
keyvault_name = "[TODO: copy from <app-slug>-keyvault outputs]"
```

**Variable declaration example in downstream `variable.tf`:**
```hcl
# Cross-tier input — populated from <app-slug>-identity outputs
variable "uai_funcapp_id" {
  type        = string
  description = "Resource ID of the Function App User Assigned Identity. Sourced from <app-slug>-identity outputs."
}
```

> LZ data sources (`data.tf`) are still declared per-repo for the resources that
> group needs. For example, `<app-slug>-compute` still needs
> `data.azurerm_subnet.workload_subnet`; it does not need the AGW subnet unless
> it also manages the gateway.

---

## B5 — `.gitlab-ci.yml` per repo

The parent pipeline follows the same structure as Option A. Each repo has its
own parent pipeline file triggering its own `ci/module.yml`.

All four deployment rules apply identically:
- **dev**: trigger on push to `main` AND available as `manual` from web
- **ppr-01**, **ppr-02**: manual, tag only
- **prd-01**: manual, tag only, `VS_VAULT_SELECT: "prod"`

The `TF_CORE_STATE_BACKEND_TF_STATE_FILE_KEY` must include the group segment as
described in **B3** above.

For each environment job, set these variables (use `[TODO]` for values not in the SAD):
```yaml
VS_VAULT_SELECT: "ppe"          # dev/ppr → "ppe", prd → "prod"
VS_AZURE_ACCOUNT: "<org_id>-<app_id>-<env>-<subscription-alias>"
AZURE_ACCOUNT: "<same>"
TF_CORE_STATE_BACKEND_AZURE_RESOURCE_GROUP: "<org_id>-<app_id>-<env>-rg-<app-short>-<location>-01"
TF_CORE_STATE_BACKEND_AZURE_STORAGE_ACCOUNT: "<org_id><app_id><env>sttfst<location-short>01"
TF_CORE_STATE_BACKEND_TF_STATE_FILE_KEY: "infra/${ENV}/<app-slug>/<group>/terraform.tfstate"
KEYVAULT_NAME: "<org_id><app_id><env>kv<app-short><location-short>01"
RUNNER_TAG: "[TODO: confirm with platform team — pattern lsegcom-<env>-<location-short>-linux-runner]"
ENV: "<env>"
```

---

## B6 — Create the VS Code workspace file

After creating all repo folders, create a single `.code-workspace` file at
`iac/<app-slug>.code-workspace`. This lets developers open all module repos in
one VS Code window.

```json
{
  "folders": [
    { "name": "<app-slug>-identity",      "path": "./<app-slug>-identity" },
    { "name": "<app-slug>-observability", "path": "./<app-slug>-observability" },
    { "name": "<app-slug>-networking",    "path": "./<app-slug>-networking" },
    { "name": "<app-slug>-keyvault",      "path": "./<app-slug>-keyvault" },
    { "name": "<app-slug>-storage",       "path": "./<app-slug>-storage" },
    { "name": "<app-slug>-postgresql",    "path": "./<app-slug>-postgresql" },
    { "name": "<app-slug>-compute",       "path": "./<app-slug>-compute" },
    { "name": "<app-slug>-appgateway",    "path": "./<app-slug>-appgateway" },
    { "name": "<app-slug>-access",        "path": "./<app-slug>-access" }
  ],
  "settings": {
    "terraform.languageServer.enable": true
  },
  "extensions": {
    "recommendations": [
      "hashicorp.terraform",
      "github.copilot",
      "github.copilot-chat"
    ]
  }
}
```

Omit any folder for groups that are not in scope for this application.
Place the `.code-workspace` file **one level above** all the repo folders:

```
iac/
├── <app-slug>-identity/
├── <app-slug>-networking/
├── <app-slug>-keyvault/
├── <app-slug>-storage/
├── <app-slug>-postgresql/
├── <app-slug>-compute/
├── <app-slug>-appgateway/
├── <app-slug>-access/
└── <app-slug>.code-workspace     ← open this to get all repos in one VS Code window
```

---

## B7 — Generate `main.tf` content rules for each repo (flat layout)

Each repo's `terraform/main.tf` contains only the CPF module calls that belong to
that group. Apply the same rules as the Flat layout in Option A Step 10:

1. Set `source` to the Artifactory registry path + separate `version` constraint.
2. Pass `app_id`, `org_id`, `environment`, `location` to every module.
3. **LZ resources** — inject via `data.<type>.<label>.<attribute>`.
4. **Wire outputs from upstream modules to inputs of downstream modules** using the
   **Edge table** from the module plan's `## Dependency Graph` section. For every row
   in that table, the producer module's output must appear as the consumer's input:
   `module.<producer>.<output_name>`.
5. **Add `depends_on`** only for rows in the module plan's **Explicit `depends_on` edges**
   table. Terraform infers ordering from output→input wiring for all other cases.
6. Wrap conditional modules in `count = var.<flag> ? 1 : 0`.
7. Add tier comments from the module plan's **Deployment tiers** table.

**Security hardening rules — enforce in every repo's `main.tf`:**
- `public_network_access_enabled = false` on: Key Vault, Storage, Function App, PostgreSQL
- `active_directory_auth_enabled = true` + `password_auth_enabled = false` on PostgreSQL
- `enable_key_access = false` + `default_to_oauth_authentication = true` on Storage
- WAF policy `mode = var.waf_mode` defaulting to `"Detection"`; `"Prevention"` in PRD

**Application Gateway sequencing rule (always enforce):**
The `<app-slug>-appgateway` repo depends on `<app-slug>-compute` having been applied
first. Document this in `README.md` and in the deployment order section.

**Private DNS Zone rule (Azure Policy-managed):**
Do NOT create `module "dns_*"` blocks for standard PaaS zones. Reference them via
`data.azurerm_private_dns_zone.*` in root `data.tf`. Only create DNS module blocks
for app-specific zones not covered by platform policy.

**`data.tf` pattern for each repo:**
```hcl
data "azurerm_client_config" "current" {}

# Only include LZ data sources this group actually needs.
# Example for the compute repo:
data "azurerm_resource_group" "app_rg" {
  name = var.app_resource_group_name
}
data "azurerm_subnet" "workload_subnet" {
  name                 = var.workload_subnet_name
  virtual_network_name = var.routable_vnet_name
  resource_group_name  = var.platform_resource_group_name
}
data "azurerm_private_dns_zone" "funcapp" {
  name                = "privatelink.azurewebsites.net"
  resource_group_name = var.private_dns_zones_resource_group_name
}
```

**`infra.tfvars` — LMP non-routable subnet CIDR rule (mandatory):**
All app-owned subnet CIDRs must be carved from the region's LMP non-routable `/17` block.
Never use RFC-1918 addresses (`10.x.x.x`, `172.x.x.x`, `192.168.x.x`).

| Region | Non-Routable Space |
|---|---|
| East US 2 | `100.72.0.0/17` |
| East US | `100.68.0.0/17` |
| UK South | `100.64.0.0/17` |
| UK West | `100.65.0.0/17` |
| West Europe | `100.67.0.0/17` |
| North Europe | `100.66.0.0/17` |
| Central US | `100.69.0.0/17` |
| South East Asia | `100.70.0.0/17` |
| East Asia | `100.71.0.0/17` |
| Japan East | `100.73.0.0/17` |
| Germany West Central | `100.74.0.0/17` |

---

## B8 — Validate and summarise for Option B

### B8a — Terraform static validation (mandatory)

For **every** repo generated, run a backend-free syntax and schema check.
Fix all errors before printing the summary.

```bash
for repo in iac/<app-slug>-*/; do
  echo "--- Validating $repo ---"
  terraform -chdir="${repo}terraform" init -backend=false
  terraform -chdir="${repo}terraform" validate
done
```

**Interpreting results:**

| Result | Action |
|---|---|
| `Success! The configuration is valid.` | Proceed |
| `Error: Reference to undeclared input variable` | Add the missing `variable` block |
| `Error: An argument named "..." is not expected here` | Check CPF module schema in `templates/cpf-schemas/` |
| `Error: Unsupported block type` | Fix misspelled resource type or block name |
| `Error: Invalid provider configuration` | Fix `required_providers` version constraint syntax |
| `Error: Could not load plugin` / `provider ... not available` | A CPF module requires `azapi` or `time` that is missing from `required_providers` — add both entries to `providers.tf` |

All repos must produce `Success! The configuration is valid.` before proceeding.

### Summary

1. Print the full directory tree for all repos created under `iac/`
2. Print the path to the `.code-workspace` file and how to open it:
   `code iac/<app-slug>.code-workspace`
3. List the deployment order:
   ```
   Deployment order:
   Tier 1 (parallel): <app-slug>-identity · <app-slug>-networking · <app-slug>-observability
   Tier 2:            <app-slug>-keyvault  (after Tier 1 outputs are filled in tfvars)
   Tier 3 (parallel): <app-slug>-storage · <app-slug>-postgresql
   Tier 4:            <app-slug>-compute
   Tier 5 (parallel): <app-slug>-appgateway · <app-slug>-access
   ```
4. List all `[TODO]` cross-tier output placeholders in tfvars that must be
   populated from upstream repo outputs before the downstream repo can be planned.
5. Print next steps:
   ```
   Next steps:
   1. Open the workspace: code iac/<app-slug>.code-workspace
   2. For each repo, fill all [TODO] LZ placeholders in infra.tfvars
   3. Deploy Tier 1 repos first (can run in parallel across GitLab pipelines)
   4. After each tier applies, copy outputs into downstream repos' infra.tfvars
   5. Continue tier by tier until all repos are deployed
   ```

---

## Final Step — DevSecOps Pre-flight Review

Before closing, load `templates/DevSecOps-Checklist/INDEX.md` and verify every item
in the **DevSecOps Evaluation Checklist** section. For each item that is not met,
either fix the generated code or document a known exception.

Then generate a `## DevSecOps Review` section in each repo's `README.md` with the
following table (mark each item ✅ compliant, ⚠️ partial, or ❌ not applicable):

```markdown
## DevSecOps Review

| Category | Rule | Status | Notes |
|----------|------|--------|-------|
| IaC | CPF modules from Artifactory | ✅ | All modules source from artifactory.lseg.com |
| IaC | Approved provider versions | ✅ | azurerm ~> 4.33 |
| IaC | Remote state with AAD auth | ✅ | use_azuread_auth = true |
| IaC | Separate state key per env | ✅ | TF_CORE_STATE_BACKEND_TF_STATE_FILE_KEY per env |
| Security | Public network access disabled | ✅ | All PaaS resources |
| Security | Key Vault for secrets | ✅ | cpf-azure-prdsvc-keyvault |
| Security | Managed Identity auth | ✅ | cpf-azure-prdsvc-userassignedidentity |
| Security | WAF mode | ✅ | Detection (DEV), Prevention (PRD) |
| Security | PostgreSQL AD auth only | ✅ / N/A | password_auth_enabled = false |
| Security | Storage OAuth only | ✅ / N/A | enable_key_access = false |
| Pipeline | LSEG DX1 shared runners | ✅ | tags: ["LSEG"] |
| Pipeline | JFrog token via vault | ✅ | 0-jfrog-token job |
| Pipeline | Destroy job is manual | ✅ | terraform-destroy: when: manual |
| Tags | Datadog opt-in tag | ✅ | opt-datadog: require |
```
