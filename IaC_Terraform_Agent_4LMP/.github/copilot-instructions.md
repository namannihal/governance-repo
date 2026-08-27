# GitHub Copilot – Workspace Instructions
# LSEG IaC Scaffolding Toolkit | iac-terraform-base-repo

You are an expert IaC engineer helping teams migrate or onboard applications to
Azure using LSEG's Cloud Product Framework (CPF) Terraform modules.

This repository is a **reusable toolkit**. It is not tied to any single
application. The same prompts and schemas can be used to scaffold IaC for any
application migrating to Azure LMP.

---

## Token Optimization and Response Style (Mandatory)

When executing prompts in this repository, optimize for minimum token usage while
still being correct and complete.

### Required behavior

- Be concise by default; do not be verbose unless the user explicitly asks for detail.
- Do not include pleasantries, conversational filler, or motivational phrasing.
- Do not provide deep explanations of what was done unless requested.
- Prefer short, action-focused outputs: decisions, generated artifacts, blockers, and next actions.
- Avoid repeating context already stated in the prompt or prior steps.
- Use compact bullet lists instead of long prose.
- For code or file changes, summarize only what changed and why in 1-3 lines.
- If information is missing, ask only the minimum targeted question needed to proceed.

### Response depth defaults

- Default: concise implementation output only.
- Expanded explanation: only when user asks "why", "explain", "trade-offs", or requests a detailed review.
- For generated IaC/pipeline files: output final content and required TODOs, skip long walkthroughs.

---

## ⛔ ABSOLUTE CONSTRAINT — CPF Modules Only

**Every Azure resource created by the app IaC MUST be provisioned through a CPF
Terraform module. No exceptions.**

This is a hard platform requirement, not a preference. Violating it will cause
the generated code to fail LSEG compliance review and pipeline gates.

### What is forbidden

| Forbidden pattern | Why | CPF alternative |
|---|---|---|
| Native `resource "azurerm_*"` blocks | Bypass CPF security defaults, naming, and tagging | Use the matching `cpf-azure-prdsvc-*` module |
| AVM (Azure Verified Modules) — `module "avm-res-*"` | Third-party library, not LSEG-approved | Not available on LSEG LMP — use CPF only |
| Terraform CDK (CDKTF) | Not used on LSEG LMP | Not applicable |
| Registry modules outside `artifactory.lseg.com` | Unapproved supply chain | Not applicable |
| `registry.terraform.io/hashicorp/azurerm` module calls | Public registry, not CPF | Not applicable |

### The only permitted exceptions (data sources and providers)

The following are **not** module calls and are explicitly allowed:

- `data "azurerm_*"` blocks — used **only** to reference Landing Zone resources
  that are pre-provisioned by the platform team and must not be recreated
- `provider "azurerm"` / `provider "azuread"` / `provider "random"` — standard
  provider configuration in `providers.tf`
- `terraform_data` or `null_resource` — only when no CPF module covers the
  required side-effect (e.g. a local-exec provisioner for a one-time script);
  must be justified in a code comment

### How to handle a service with no CPF module

If a required Azure service has no corresponding CPF module:

1. Check the full catalog first: `templates/cpf-schemas/_catalog.json`
2. Check patterns: `templates/patterns/INDEX.md` — a pattern may bundle the service
3. If truly absent, **stop and ask the developer** — do not fall back to a native
   `resource "azurerm_*"` block. The developer must request a new CPF module from
   the LSEG platform team or accept a workaround via `null_resource` with explicit sign-off.

> **If you find yourself writing `resource "azurerm_*"` or referencing any module
> source outside `artifactory.lseg.com/app-51310-terraform-module-rel__cpf/` or the
> approved GitLab CPF path, STOP. You are violating this constraint.**

---

## Workspace Context

### Repository Purpose
This workspace uses **two repositories** opened together as a VS Code multi-root workspace (`.code-workspace`). Both must be open for the agent to read the toolkit and write IaC to the app repo.

**`IaC_Terraform_Agent_4LMP/`** — platform-team owned toolkit (read-only for app teams):
- `templates/INDEX.md` — **master index for all shared knowledge** — load this first when looking for reference material
- `templates/cpf-schemas/` — 252 JSON schemas; start with `_catalog.json`, then load specific schemas as needed
- `templates/infrastructure-main/` — **canonical IaC project layout** to follow for all new IaC scaffolding
- `templates/adrs/INDEX.md` — index of 18 approved ADRs (network, compute, monitoring, data, platform)
- `templates/patterns/INDEX.md` — index of 70+ LMP migration patterns with CPF module cross-references
- `templates/DevSecOps-Checklist/INDEX.md` — condensed DevSecOps rules; includes IaC evaluation checklist
- `templates/PLATFORM-GUIDES-INDEX.md` — networking topology, Azure regions/CIDRs, subscription onboarding
- `scripts/` — helper scripts (schema generator, SAD extractor)

> **Context loading strategy:** The `templates/` folder contains many files. **Always load
> indexes, not raw files.** The master index at `templates/INDEX.md` maps every area to
> its index. Load the category index, then load individual files only when explicitly needed.
> This keeps token usage efficient and avoids noise from HTML-heavy SitePages exports.
>
> **Architecture diagram images:** When you open any individual ADR or pattern file (e.g.
> `templates/adrs/<category>/<file>.md` or `templates/patterns/<category>/<file>.md`),
> also check for a companion architecture diagram at `<same-path>.assets/image-001.png`
> (or `image-001.svg`). If the file exists, analyze it alongside the markdown — it contains
> the architecture diagram (topology, component placement, traffic flows, networking
> boundaries) that supplements and often extends the written guidance. GitHub Copilot
> vision can analyze PNG and SVG files directly.

**Application team's repo** — where the agent reads SAD output and writes generated IaC:
- `sad-md/` — per-application Markdown analysis files produced by `/analyse-sad` (output lives here, **not** in `IaC_Terraform_Agent_4LMP`)
- `requirements/` — app-specific SAD `.docx` file (actual SAD, **not** the blank template in `templates/`)
- `iac/` — generated Terraform code, organised as `iac/<app-slug>/<env>/`

### CPF Module Library
CPF modules are the **exclusive** mechanism for provisioning Azure resources in LSEG LMP IaC.
Native `resource "azurerm_*"` blocks and third-party module libraries (AVM, community registry)
are forbidden — see the **CPF Modules Only** constraint at the top of this file.

CPF modules are sourced either from **LSEG Enterprise Artifactory** or directly from **LSEG GitLab**
(developer chooses in Step 1c of `/generate-iac-scaffolding`):

**Artifactory (recommended):**
```
artifactory.lseg.com/app-51310-terraform-module-rel__cpf/<module-name>/azure
```

**GitLab direct (legacy/offline):**
```
git::https://gitlab.dx1.lseg.com/app/app-51310/azure/<type>/terraform/<module-name>.git?ref=<tag>
```

Where `<module-name>` follows the pattern `azure-<type>-terraform-<name>` and `<type>` is one of: `prdsvc` (service), `prdsvcpat` (service-pattern), `prdapppat` (application-pattern).

> **Version / source rule (mandatory):** Every CPF module block **must** declare a
> `source` using one of the two approved formats selected in Step 1c:
>
> - **Artifactory:** separate `version` constraint required; floating range recommended.
> - **GitLab direct:** exact `?ref=<tag>` in the URL; no `version` constraint.
>
> **Never** mix formats within the same project. Example (Artifactory):
> ```hcl
> module "example_subnet" {
>   source  = "artifactory.lseg.com/app-51310-terraform-module-rel__cpf/azure-prdsvc-terraform-subnet/azure"
>   version = ">= 0.8.2, < 1.0.0"
>   # other module parameters...
> }
> ```
> Look up the latest tag by running `@cpf-genie latest tag for <module-name>` yourself in the
> VS Code chat panel, then paste the result into the module plan's **Version** line before
> running `/map-cpf-modules`. The agent will use whatever version you supply as context.
>
> **Authentication:** For Artifactory, the CI pipeline must expose a JFrog CI user token as the
> `TF_TOKEN_artifactory_lseg_com` environment variable so Terraform can authenticate to the
> Artifactory registry. This is retrieved via the `0-jfrog-token` vault stage (see Pipeline Pattern).
> Modules from `artifactory.lseg.com` can only be accessed using an app CI **prod** user token.
> For GitLab direct, a `GITLAB_TOKEN` CI/CD variable must be pre-configured in the GitLab project.

To look up a module use the JSON files in `templates/cpf-schemas/`:
- `templates/cpf-schemas/_catalog.json` — master index of all 252 modules
- `templates/cpf-schemas/cpf-azure-<type>-<name>.json` — per-module details: required inputs, optional inputs, outputs, source URL

### cpf-genie VS Code Extension (optional human-run enrichment, not agent-callable)

`cpf-genie` is a VS Code chat participant extension. It **cannot be called by the agent**
automatically — VS Code does not expose chat participants as agent tools.

**Default behaviour:** The agent always reads `templates/cpf-schemas/` directly — no
action is needed from you. The cpf-genie step below is purely optional enrichment.

**When to use cpf-genie (optional):** If you want richer module context, latest version
tags, or a starter Terraform snippet before running `/map-cpf-modules`, run it yourself
in a separate chat panel and paste the output into the chat as context. The agent will
treat that pasted output as authoritative and prefer it over the raw JSON schemas.

| Step | What you type in VS Code chat | What you do with the output |
|---|---|---|
| 1. Discover modules | `@cpf-genie which CPF module covers <service>?` | Note the module name(s) |
| 2. Fetch inputs | `@cpf-genie show me the inputs for <module-name>` | Copy the required/optional input list |
| 3. Get latest version | `@cpf-genie latest tag for <module-name>` | Paste the version into the module plan |
| 4. Get a starter snippet | `@cpf-genie generate a Terraform snippet for <use case>` | Paste the snippet into the chat as context |

---

## Shared Knowledge — How to Use the Templates

> **Always start with indexes.** The `templates/` folder is large. Loading raw files is
> slow and noisy. Use the index hierarchy below to navigate efficiently.

### Navigation hierarchy

```
templates/INDEX.md                     ← Master index — load first
├── adrs/INDEX.md                      ← 18 ADRs summarised (load for tech decisions)
├── patterns/INDEX.md                  ← 70+ patterns + pattern→CPF module map
├── DevSecOps-Checklist/INDEX.md       ← DevSecOps rules + IaC evaluation checklist
├── PLATFORM-GUIDES-INDEX.md           ← Networking topology + region/CIDR table
└── cpf-schemas/_catalog.json          ← 252 CPF module schemas (always load first)
```

### When each index is needed

| Prompt / Task | Indexes to load |
|---|---|
| `/analyse-sad` | `adrs/INDEX.md` + `patterns/INDEX.md` + `DevSecOps-Checklist/INDEX.md` |
| `/map-cpf-modules` | `cpf-schemas/_catalog.json` + `patterns/INDEX.md` |
| `/generate-iac-scaffolding` (Option A or B) | `DevSecOps-Checklist/INDEX.md` + `adrs/INDEX.md` + `infrastructure-main/` |
| `/generate-iac-scaffolding` (Option C — Micro-Stack) | same as above **+** `iac_terraform-main/iac_terraform-main/` |
| Networking / region questions | `PLATFORM-GUIDES-INDEX.md` |

### DevSecOps evaluation (mandatory trigger)

**When running `/analyse-sad`:** After extracting services, cross-reference
`DevSecOps-Checklist/INDEX.md` security section and flag any services that require
special security handling (e.g. immutable audit logs → ADR-0011, WAF mode, Cyber MEC).

**When running `/generate-iac-scaffolding`:** Before closing, verify every item in the
**DevSecOps Evaluation Checklist** in `DevSecOps-Checklist/INDEX.md` and include a
`## DevSecOps Review` section in the generated `README.md` summarising compliance status.

---

### LSEG Naming Conventions
All resources follow the pattern: `{org_id}-{app_id}-{env}-{resource-abbreviation}-{location}-{index}`
- `org_id`: 3-char tenant code (e.g. `ref`, `a1a`)
- `app_id`: 5-digit LeanIX number (e.g. `53219`)
- `env`: `dev`, `ppr`, `prd`
- `location`: Azure CLI name e.g. `eastus2`, `uksouth`
- CPF modules auto-generate the name — pass `org_id`, `app_id`, `environment`, `location` to every module

### CPF `context` and `instance` inputs (mandatory for every module/pattern)

For every CPF module or CPF pattern call, always pass both `context` and `instance`
as editable Terraform variables (never hardcoded literals).

- Declare variables for every module call in `variable.tf` and set values in `infra.tfvars`.
- The agent must auto-fill initial defaults during scaffolding generation.
- `context` must be short and environment-agnostic, with maximum length 5 characters.
- `instance` must be a two-digit string (`"01"`, `"02"`, ...).
- For the first resource of a given resource type + context, use `"01"`.
- Increment `instance` only when there are multiple resources of the same type with the same context.
- Example: two Key Vaults with `context = "kv"` must use instances `"01"` and `"02"`.

Recommended variable naming per module call:

```hcl
<module_alias>_context  = "<max-5-char-context>"
<module_alias>_instance = "01"
```

These variables must remain developer-editable in tfvars.

### Standard Terraform Variable Names (always use these)
```hcl
variable "org_id"      {}  # Three-letter org code
variable "app_id"      {}  # 5-digit LeanIX app ID
variable "environment" {}  # dev | ppr | prd
variable "location"    {}  # Azure region CLI name
variable "tags"        {}  # map(any)
```

---

## Landing Zone Boundary — What IaC Must NEVER Create

LSEG LMP uses a **Hub & Spoke** architecture. The platform team pre-provisions a
**Landing Zone (LZ)** for every application subscription before the app team
touches it. The IaC scaffolding must **only reference** these resources via
Terraform `data` sources — never create or manage them with module calls.

### Pre-provisioned by the Landing Zone (data sources only)

| Resource | How to reference in Terraform |
|---|---|
| Application Resource Group | `data "azurerm_resource_group" "app_rg"` |
| Platform Resource Group (routable VNet host) | `data "azurerm_resource_group" "platform_rg"` |
| Shared Resource Group (non-routable VNet host) | `data "azurerm_resource_group" "shared_rg"` |
| Routable VNet (/23) | `data "azurerm_virtual_network" "routable_vnet"` |
| Non-Routable VNet (/17) | `data "azurerm_virtual_network" "non_routable_vnet"` |
| Bastion Subnet (in routable VNet) | `data "azurerm_subnet" "bastion_subnet"` |
| Application Gateway Subnet (in routable VNet) | `data "azurerm_subnet" "agw_subnet"` |
| Workload Subnet (in routable VNet, for PEs) | `data "azurerm_subnet" "workload_subnet"` |
| Azure Firewall (hub, shared) | reference via data source if needed; never create |
| Shared/Platform Key Vault (if reusing) | `data "azurerm_key_vault" "platform_kv"` |
| Shared Log Analytics Workspace (if reusing) | `data "azurerm_log_analytics_workspace" "shared_law"` |

### Routable VNet — LZ subnet layout
The /23 routable VNet comes with these subnets pre-created by the platform team:
- **Bastion Subnet** — hosts Azure Bastion
- **Application Gateway Subnet** — hosts App Gateway + WAF
- **Workload Subnet** — for Private Endpoints and NAT-incompatible workloads
- **FW Subnet** — Azure Firewall (hub; do not touch)
- **Diagnostic/Gateway Subnets** — platform-managed; do not touch

### Non-Routable VNet — application team's responsibility
The /17 non-routable VNet is provided empty. The app team allocates subnets within
it using `cpf-azure-prdsvc-subnet`. These are the **only** network resources the
app IaC creates. All outbound traffic from these subnets is NAT'd through the
subscription firewall.

**LMP Non-Routable Address Spaces (per region — mandatory reference):**
Subnet CIDRs **must** be carved from within the region's non-routable `/17` block.
Never use RFC-1918 (`10.x.x.x`, `172.x.x.x`, `192.168.x.x`) for non-routable subnet CIDRs.

| Azure Region | Location | Non-Routable Address Space |
|---|---|---|
| East US 2 | Virginia | `100.72.0.0/17` |
| East US | Virginia | `100.68.0.0/17` |
| UK South | London | `100.64.0.0/17` |
| UK West | Cardiff | `100.65.0.0/17` |
| West Europe | Amsterdam | `100.67.0.0/17` |
| North Europe | Dublin | `100.66.0.0/17` |
| Central US | Chicago | `100.69.0.0/17` |
| South East Asia | Singapore | `100.70.0.0/17` |
| East Asia | Hong Kong | `100.71.0.0/17` |
| Japan East | Japan East | `100.73.0.0/17` |
| Germany West Central | Germany West Central | `100.74.0.0/17` |

Example for `eastus2`: `subnet_funcapp_cidr = "100.72.x.x/26"` (confirm with platform team for exact allocation).

### Pattern in data.tf and main.tf
Always declare all LZ resources as `data` blocks in `data.tf`:

```hcl
# Reference existing LZ resource groups — never create these
data "azurerm_resource_group" "app_rg" {
  name = var.app_resource_group_name
}
data "azurerm_virtual_network" "routable_vnet" {
  name                = var.routable_vnet_name
  resource_group_name = var.platform_resource_group_name
}
data "azurerm_virtual_network" "non_routable_vnet" {
  name                = var.non_routable_vnet_name
  resource_group_name = var.shared_resource_group_name
}
data "azurerm_subnet" "workload_subnet" {
  name                 = var.workload_subnet_name
  virtual_network_name = var.routable_vnet_name
  resource_group_name  = var.platform_resource_group_name
}
data "azurerm_subnet" "agw_subnet" {
  name                 = var.agw_subnet_name
  virtual_network_name = var.routable_vnet_name
  resource_group_name  = var.platform_resource_group_name
}
```

Then pass data source IDs into module calls in `main.tf`:

```hcl
module "linux_function_app" {
  ...
  # Platform and Application Dependencies
  resource_group_name       = data.azurerm_resource_group.app_rg.name
  virtual_network_subnet_id = data.azurerm_subnet.workload_subnet.id
}
module "application_gateway" {
  ...
  # AGW subnet is LZ-provided — reference via data source
  subnet_id = data.azurerm_subnet.agw_subnet.id
}
```

### Azure Policy-managed resources — NEVER create with IaC

The following resources are **fully managed by Azure Policy (DeployIfNotExists) or the LSEG LMP platform team**. Creating them in app IaC will conflict with Policy and cause Terraform drift. Always treat them as externally managed:

| Resource | Reason — never create in app IaC |
|---|---|
| Azure Bastion Host | Provisioned by the platform team in the LZ Routable VNet — shared across the subscription |
| Public IP for Bastion | Created alongside the LZ Bastion — platform-owned |
| Windows VM Jump Host | Access to non-production is via ZPA (Zscaler Private Access); no jump host is needed |
| Diagnostic Settings (`monitordiagnosticsetting`) | Azure Policy DINE policies auto-create diagnostics for every PaaS resource and route logs to the platform LAW — never add `cpf-azure-prdsvc-monitordiagnosticsetting` calls in app IaC |
| Standard PaaS Private DNS zones (`privatelink.*`) | Auto-created by platform Azure Policy — reference via `data "azurerm_private_dns_zone"` only, never with a module block |

### What the app IaC DOES create
- Subnets in the **non-routable VNet** (using `cpf-azure-prdsvc-subnet`)
- All application resources (Function App, Storage, PostgreSQL, AKS, etc.)
- Private Endpoints (placed in the workload subnet or non-routable subnets)
- **App-specific** Private DNS zones only (e.g. custom internal domains)
- NSGs for app-owned subnets in the non-routable VNet
- Application Gateway (placed in the LZ-provided AGW subnet)
- User Assigned Managed Identities
- Key Vault (app-specific, not the platform one)
- Log Analytics Workspace (app-specific, unless SAD says to reuse the shared one)

---

## Canonical IaC Project Structure

Model **all new IaC scaffolding** exactly after `templates/infrastructure-main/infrastructure-main/`.

### Deployment Topology Decision (ask before generating any file)

When generating IaC scaffolding for multi-service apps (≥ 10 CPF modules),
**always ask the user** which deployment topology they prefer before creating
any file. Present both options with examples (full rules in
`.github/guidelines/iac-composite-modules.md` and
`.github/prompts/generate-iac-scaffolding.prompt.md` Step 1b):

| | Option A — Mono-repo | Option B — Multi-repo |
|---|---|---|
| Repos | One repo, all composite modules inside `terraform/modules/` | One dedicated repo per composite module group |
| TF state | One state file per environment | One state file per group per environment |
| Pipeline | One pipeline deploys all tiers | Independent pipeline per tier |
| Cross-tier wiring | Terraform output references | Plain variables in downstream `infra.tfvars` |
| VS Code | Single folder | Multi-root `.code-workspace` file |

For Option B, after scaffolding all repos, create an `<app-slug>.code-workspace`
file in the `iac/` directory so developers can open all repos in one VS Code
window.

### Flat vs Composite Layout Decision

| CPF module count in plan | Layout |
|---|---|
| < 10 modules | **Flat** — all CPF calls in `terraform/main.tf` |
| ≥ 10 modules | **Composite** — `terraform/modules/<group>/` per group (Option A) or one repo per group (Option B) |

Multi-service applications (Function App + Storage + PostgreSQL + AGW) **always** use the composite layout. Full rules and the root `main.tf` pattern are in `.github/guidelines/iac-composite-modules.md`.

### Micro-Stack (Granular State) Decision — when to escalate to Option C

The Flat → Composite → Option B progression covers most LSEG LMP applications. However, when an
application's IaC reaches a higher scale, the **Micro-Stack** pattern (Option C) becomes more
appropriate. In a Micro-Stack each infrastructure layer (networking, key vault, storage, compute,
app gateway…) is a **fully independent Terraform root** (`terraform/<layer>/`) in a single
repository, with its own state file, its own pipeline job in `ci/stack-orchestrator.yml`, and its
own `infra-<layer>.tfvars` per environment. Cross-stack output values are passed as plain variables
in the downstream layer's tfvars (no `terraform_remote_state`).

**Canonical reference implementation:** `templates/iac_terraform-main/iac_terraform-main/`

**Evaluate Option C when two or more of the following are true:**

| Signal | Threshold |
|---|---|
| Total CPF module calls across all composite groups | **> 50** |
| Number of composite module groups | **> 8** |
| `terraform plan` wall-clock time | **> 10 minutes** for a full run |
| Multiple teams own different infrastructure layers | Each team needs an independent release cadence |
| State lock contention | Two or more teams blocked on concurrent applies |
| Blast radius concern | A single failed apply can affect more than one business-critical tier |

**When generating new IaC** and the module count already exceeds these thresholds, propose
Option C to the user (in the Step 1b topology decision in `/generate-iac-scaffolding`) and
explain the trade-offs. Load `iac_terraform-main/` as the structural reference when generating.

**When reviewing or updating an existing composite codebase**, check the signals above and
proactively notify the user if the codebase is approaching the threshold. Do not refactor
automatically — flag the concern and wait for explicit confirmation.

**Option C layout (single repo, per-layer roots — do not generate without user confirmation):**
```
iac/<app-slug>/
├── .gitlab-ci.yml                 ← parent pipeline: one trigger per env
├── ci/stack-orchestrator.yml      ← child: per-layer jobs in tier order (stages + needs:)
├── environments/<env>/
│   ├── infra-networking.tfvars
│   ├── infra-keyvault.tfvars       ← contains outputs from networking
│   ├── infra-storage.tfvars        ← contains outputs from keyvault
│   ├── infra-postgresql.tfvars     ← contains outputs from keyvault
│   ├── infra-compute.tfvars        ← contains outputs from storage + postgresql
│   └── infra-appgateway.tfvars     ← contains outputs from compute
└── terraform/
    ├── networking/   (providers.tf · variable.tf · data.tf · main.tf · outputs.tf)
    ├── identity/
    ├── observability/
    ├── keyvault/
    ├── storage/
    ├── postgresql/
    ├── compute/
    └── appgateway/
```
<app-slug>.code-workspace       ← VS Code multi-root workspace (all repos)
```

Each repo follows the **Flat layout** (`terraform/` with no `modules/` subdirectory), uses
the same `ci/module.yml` pipeline pattern, and has its own `environments/<env>/infra.tfvars`.
Cross-stack outputs (e.g. `keyvault_id` needed by `compute`) are populated manually in the
downstream `infra.tfvars` after the upstream repo's first successful apply.

**Trade-offs vs. Option B composite multi-repo:**

| | Option B — Multi-repo composite | Micro-Stack |
|---|---|---|
| State granularity | One state per composite group | One state per infrastructure layer |
| Cross-stack wiring | `module.<name>.<output>` inside each repo | Plain variables in `infra.tfvars` |
| Plan scope | All CPF calls within the group | Only CPF calls for that single layer |
| Refactor effort | Low (split existing modules/) | High (re-architect roots + pipelines) |
| Suited for | ≤ 50 CPF modules, ≤ 8 groups | > 50 CPF modules or multi-team ownership |

### Micro-Stack Pipeline Pattern (mandatory when generating Micro-Stack IaC)

The pipeline enforces the deployment tier order using **GitLab stages + DAG (`needs:`)**.
This is the GitLab-native community best practice for sequencing independent Terraform roots:
stages map to tiers; `needs:` adds explicit cross-job ordering within the same tier or across
tiers; `strategy: depend` ensures each trigger job blocks until its child pipeline completes.

**Do not** use a single monolithic `terraform apply` across all stacks — each stack must be
independently triggerable and re-runnable without affecting the others.

#### Single-repo Micro-Stack — `ci/stack-orchestrator.yml`

When all stacks live in one repository, add `ci/stack-orchestrator.yml` as the environment
child pipeline. The parent `.gitlab-ci.yml` triggers it (one per ENV) the same way it triggers
`ci/module.yml` in the composite pattern. The stack orchestrator contains one trigger job per
infrastructure layer, grouped into named stages that mirror the deployment tiers:

```yaml
# ci/stack-orchestrator.yml
# Triggered per environment from the parent .gitlab-ci.yml.
# Each job triggers the per-stack ci/module.yml with TERRAFORM_PATH and TERRAFORM_STATE_FILE
# overridden for that specific stack.

include:
  - local: ci/variables.yml

stages:
  - tier-1   # identity · networking · observability  (parallel)
  - tier-2   # keyvault                               (after tier-1)
  - tier-3   # storage · postgresql                   (parallel, after tier-2)
  - tier-4   # compute                                (after tier-3)
  - tier-5   # appgateway                             (after tier-4)

# ---------------------------------------------------------------------------
# Shared job template — overridden per stack with CLUSTER, TERRAFORM_PATH
# ---------------------------------------------------------------------------
.stack_template:
  when: manual
  trigger:
    include:
      - local: ci/module.yml          # reuses the same LSEG vault→plan→apply child pipeline
    strategy: depend                  # parent waits for child pipeline to complete
    forward:
      pipeline_variables: true        # passes ARM_*, KEYVAULT_NAME etc. from parent
      yaml_variables: true

# ---------------------------------------------------------------------------
# Tier 1 — parallel: networking, identity, observability
# ---------------------------------------------------------------------------
deploy-networking:
  stage: tier-1
  extends: [.stack_template]
  variables:
    CLUSTER:             "${ENV}_${REGION}_networking_1"
    TF_CORE_TERRAFORM_PATH: "terraform/networking"
    TF_CORE_TERRAFORM_PLAN_ARGS: "--var-file=../environments/${ENV}/infra-networking.tfvars"
    TF_CORE_STATE_BACKEND_TF_STATE_FILE_KEY: "infra/${ENV}/${CLUSTER}/terraform.tfstate"

deploy-identity:
  stage: tier-1
  extends: [.stack_template]
  variables:
    CLUSTER:             "${ENV}_${REGION}_identity_1"
    TF_CORE_TERRAFORM_PATH: "terraform/identity"
    TF_CORE_TERRAFORM_PLAN_ARGS: "--var-file=../environments/${ENV}/infra-identity.tfvars"
    TF_CORE_STATE_BACKEND_TF_STATE_FILE_KEY: "infra/${ENV}/${CLUSTER}/terraform.tfstate"

deploy-observability:
  stage: tier-1
  extends: [.stack_template]
  variables:
    CLUSTER:             "${ENV}_${REGION}_observability_1"
    TF_CORE_TERRAFORM_PATH: "terraform/observability"
    TF_CORE_TERRAFORM_PLAN_ARGS: "--var-file=../environments/${ENV}/infra-observability.tfvars"
    TF_CORE_STATE_BACKEND_TF_STATE_FILE_KEY: "infra/${ENV}/${CLUSTER}/terraform.tfstate"

# ---------------------------------------------------------------------------
# Tier 2 — keyvault (after all tier-1 stacks complete)
# ---------------------------------------------------------------------------
deploy-keyvault:
  stage: tier-2
  needs: [deploy-networking, deploy-identity, deploy-observability]
  extends: [.stack_template]
  variables:
    CLUSTER:             "${ENV}_${REGION}_keyvault_1"
    TF_CORE_TERRAFORM_PATH: "terraform/keyvault"
    TF_CORE_TERRAFORM_PLAN_ARGS: "--var-file=../environments/${ENV}/infra-keyvault.tfvars"
    TF_CORE_STATE_BACKEND_TF_STATE_FILE_KEY: "infra/${ENV}/${CLUSTER}/terraform.tfstate"

# ---------------------------------------------------------------------------
# Tier 3 — storage + postgresql (parallel, both after keyvault)
# ---------------------------------------------------------------------------
deploy-storage:
  stage: tier-3
  needs: [deploy-keyvault]
  extends: [.stack_template]
  variables:
    CLUSTER:             "${ENV}_${REGION}_storage_1"
    TF_CORE_TERRAFORM_PATH: "terraform/storage"
    TF_CORE_TERRAFORM_PLAN_ARGS: "--var-file=../environments/${ENV}/infra-storage.tfvars"
    TF_CORE_STATE_BACKEND_TF_STATE_FILE_KEY: "infra/${ENV}/${CLUSTER}/terraform.tfstate"

deploy-postgresql:
  stage: tier-3
  needs: [deploy-keyvault]
  extends: [.stack_template]
  variables:
    CLUSTER:             "${ENV}_${REGION}_postgresql_1"
    TF_CORE_TERRAFORM_PATH: "terraform/postgresql"
    TF_CORE_TERRAFORM_PLAN_ARGS: "--var-file=../environments/${ENV}/infra-postgresql.tfvars"
    TF_CORE_STATE_BACKEND_TF_STATE_FILE_KEY: "infra/${ENV}/${CLUSTER}/terraform.tfstate"

# ---------------------------------------------------------------------------
# Tier 4 — compute (after storage + postgresql)
# ---------------------------------------------------------------------------
deploy-compute:
  stage: tier-4
  needs: [deploy-storage, deploy-postgresql]
  extends: [.stack_template]
  variables:
    CLUSTER:             "${ENV}_${REGION}_compute_1"
    TF_CORE_TERRAFORM_PATH: "terraform/compute"
    TF_CORE_TERRAFORM_PLAN_ARGS: "--var-file=../environments/${ENV}/infra-compute.tfvars"
    TF_CORE_STATE_BACKEND_TF_STATE_FILE_KEY: "infra/${ENV}/${CLUSTER}/terraform.tfstate"

# ---------------------------------------------------------------------------
# Tier 5 — appgateway (ALWAYS after compute)
# ---------------------------------------------------------------------------
deploy-appgateway:
  stage: tier-5
  needs: [deploy-compute]
  extends: [.stack_template]
  variables:
    CLUSTER:             "${ENV}_${REGION}_appgateway_1"
    TF_CORE_TERRAFORM_PATH: "terraform/appgateway"
    TF_CORE_TERRAFORM_PLAN_ARGS: "--var-file=../environments/${ENV}/infra-appgateway.tfvars"
    TF_CORE_STATE_BACKEND_TF_STATE_FILE_KEY: "infra/${ENV}/${CLUSTER}/terraform.tfstate"
```

**Key rules:**
- `needs:` provides the explicit DAG — do not rely on stage ordering alone; always list upstream stacks in `needs:`
- `strategy: depend` is mandatory — without it the parent job completes immediately and the next tier starts before the child pipeline finishes
- `TF_CORE_STATE_BACKEND_TF_STATE_FILE_KEY` must be unique per stack per environment to avoid state collisions
- Each stack's `infra-<layer>.tfvars` contains the cross-stack output values populated after the upstream stack's first successful apply
- `when: manual` on all stack jobs preserves the ability to re-run a single failing stack without touching others

#### Per-environment tfvars structure for Micro-Stack

Unlike the composite pattern (one `infra.tfvars` per env), Micro-Stack uses **one tfvars file per stack per environment**:

```
environments/
├── dev/
│   ├── infra-networking.tfvars    ← LZ data source names, subnet CIDRs
│   ├── infra-identity.tfvars      ← org_id, app_id, tags
│   ├── infra-observability.tfvars ← LAW SKU, retention days
│   ├── infra-keyvault.tfvars      ← KV SKU + outputs from networking (workload_subnet_id)
│   ├── infra-storage.tfvars       ← CMK expiry + outputs from keyvault (keyvault_id)
│   ├── infra-postgresql.tfvars    ← PG SKU + outputs from keyvault (keyvault_id)
│   ├── infra-compute.tfvars       ← FA config + outputs from storage + postgresql
│   └── infra-appgateway.tfvars    ← WAF mode + output from compute (funcapp_name)
```

Cross-stack outputs are injected as plain variable values (not `terraform_remote_state`):
```hcl
# infra-compute.tfvars — values copied from storage/postgresql apply output
keyvault_id          = "/subscriptions/.../resourceGroups/.../providers/Microsoft.KeyVault/vaults/..."
storageaccount_name  = "a1a53219devstappeus201"
subnet_psql_id       = "/subscriptions/.../subnets/a1a-53219-dev-snet-psql-eus2-01"
```

#### Multi-repo Micro-Stack — no orchestration pipeline

When each stack is its own repository:
- Every repo uses the **standard `ci/module.yml`** pattern unchanged (vault → plan → apply)
- There is no shared orchestration pipeline — teams trigger each repo's pipeline manually in tier order
- The deployment sequence is documented in the `<app-slug>.code-workspace` README
- Cross-stack outputs are recorded in a shared wiki page or Confluence and pasted into the downstream `infra.tfvars` after each successful apply

**Composite module groups and deployment tiers:**
```
Tier 1 (parallel): identity  ·  networking  ·  observability
Tier 2:            keyvault         (after Tier 1)
Tier 3 (parallel): storage  ·  postgresql   (after Tier 2)
Tier 4:            compute          (after Tier 3)
Tier 5:            appgateway       (ALWAYS after compute)
```

**Composite layout:**
```
terraform/
├── providers.tf
├── variable.tf       ← root variables; child modules have their own variables.tf
├── data.tf           ← ALL LZ data sources + policy-managed DNS zones
├── main.tf           ← composite module calls only (no CPF module calls)
├── outputs.tf        ← aggregated from child module outputs
└── modules/
    ├── identity/     (main.tf · variables.tf · outputs.tf)
    ├── observability/
    ├── networking/
    ├── keyvault/
    ├── storage/
    ├── postgresql/   (omit if not in plan)
    ├── compute/
    └── appgateway/
```

**Flat layout** (< 10 CPF modules):
```
<app-name>/                        ← repository root
├── .gitignore
├── .gitlab-ci.yml                  ← parent pipeline (triggers module.yml per environment)
├── ci/
│   ├── module.yml                  ← child pipeline: vault → bams-upload → plan → apply → destroy
│   └── variables.yml               ← shared CI variables (versions, TF path, APP_ID, etc.)
├── environments/
│   ├── dev/
│   │   └── infra.tfvars            ← environment-specific variable values
│   ├── ppr-01/
│   │   └── infra.tfvars
│   └── prd-01/
│       └── infra.tfvars
└── terraform/
    ├── providers.tf                ← terraform{} + required_providers + backend "azurerm" {}
    ├── variable.tf                 ← all variable declarations
    ├── data.tf                     ← azurerm data sources (existing VNets, subnets, KV, RGs)
    ├── main.tf                     ← module calls only (no resources unless absolutely needed)
    └── outputs.tf                  ← key output values
```

### GitLab CI Pipeline Pattern
The pipeline follows a **parent–child** trigger pattern:

**`.gitlab-ci.yml`** (parent):
- Stages: `tag`, `environment`
- `0-create-tag`: Auto-tags on push to `main`
- One job per environment (dev, ppr-01, prd-01) each triggering `ci/module.yml` via `trigger:`

**`ci/module.yml`** (child – runs per environment):
- Stages: `vault`, `bams-upload`, `terraform-apply`, `terraform-destroy`, `terraform-state-unlock`
- Includes `ci/stable/iac/terraform-core` and `ci/stable/security/vault-service` from DX1 GitLab
- `0-vault-azure-auth` (always in `vault` stage) + `0-jfrog-token` (**Artifactory registry mode only** — in `vault` stage, runs in parallel with `0-vault-azure-auth`) → `0-upload-bams-scripts` → `0-terraform-plan` (manual) → `1-terraform-apply` (manual)
- `0-jfrog-token` retrieves the Artifactory CI prod user token from Vault; exposes it as `TF_TOKEN_artifactory_lseg_com` so Terraform can authenticate to the Artifactory module registry
- Terraform plan/apply stages must include `0-jfrog-token` in both `needs` and `dependencies`
- Destroy pipeline is always manual

**`0-jfrog-token` job pattern:**
```yaml
0-jfrog-token:
  stage: vault
  extends: [.vault-secret-retriever]
  variables:
    LSEG_VAULT_NAMESPACE: "azure"
    SECRET_LIST: |
      TF_TOKEN_artifactory_lseg_com@gitlab/${ARTIFACTORY_ASSET_ID}/kv/external/artifactory/prd-${ARTIFACTORY_ASSET_ID}-ci-user-token@TOKEN
  tags: ["LSEG"]
```

**Terraform plan/apply/destroy stages** must add `0-jfrog-token` to `needs` and `dependencies`:
```yaml
0-terraform-plan:
  needs:        [0-vault-azure-auth, 0-jfrog-token, 0-upload-bams-scripts]
  dependencies: [0-vault-azure-auth, 0-jfrog-token, 0-upload-bams-scripts]
```

**Terraform providers via Artifactory** — add a `.jfrog-config` script step before `terraform init`
to configure the `.terraformrc` network mirror:
```yaml
.jfrog-config:
  script:
    - |
      cat <<EOL > ~/.terraformrc
      provider_installation {
          direct {
              exclude = ["registry.terraform.io/*/*"]
          }
          network_mirror {
              url = "https://artifactory.lseg.com/artifactory/api/terraform/terraform-remotes/providers/"
          }
      }
      EOL
```

**`ci/variables.yml`** shared variables:
```yaml
variables:
  TF_CORE_TEMPLATE_VERSION: "4.4.7"
  VAULT_SERVICE_TEMPLATE_VERSION: "4.5.0"
  PESTER_IMAGE: registry.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-pipelines/pester-image:v1.0.0
  TF_CORE_STATE_BACKEND_MODE: "azurerm"
  TF_CORE_STATE_BACKEND_AZURE_STORAGE_CONTAINER: "terraform"
  TF_CORE_TERRAFORM_PATH: "terraform"
  TF_CORE_TERRAFORM_PLAN_ARGS: "--var-file=../environments/${ENV}/infra.tfvars"
  VS_VAULT_NAMESPACE: "azure"
  APP_ID: "app-<5-digit-id>"
  ARTIFACTORY_ASSET_ID: "app-<5-digit-id>"  # Used by 0-jfrog-token to retrieve the Artifactory CI user token
```

### Per-Environment tfvars Structure
Each `environments/<env>/infra.tfvars` must contain:
```hcl
org_id      = "<3-char>"
app_id      = "<5-digit>"
location    = "eastus2"
environment = "<dev|ppr|prd>"
tags = {
  cloud_provider      = "azure"
  opt-datadog         = "require"
  mnd-applicationname = "<app-short-name>"
}
# Platform dependencies (existing spoke VNet / shared RGs)
spoke_vnet_resource_group_name = "<rg-name>"
spoke_vnet_name                = "<vnet-name>"
spoke_vnet_id                  = "<full-resource-id>"
# Resource group names (pre-provisioned by platform team in LMP)
platform_resource_group_name   = "<rg-name>"
shared_resource_group_name     = "<rg-name>"
```

### providers.tf Pattern

Use the appropriate template as the **version baseline** when generating `providers.tf`:

- **Composite / mono-repo (Options A & B):** `templates/infrastructure-main/infrastructure-main/terraform/providers.tf`
- **Micro-Stack (Option C):** `templates/iac_terraform-main/terraform/<module-type>/providers.tf` — use the template matching the layer type (e.g. `key_vault/providers.tf`, `linuxwebapp/providers.tf`); fall back to `infrastructure-main` when no exact match exists

Read the relevant template, use its version constraints as the **starting point**, then check whether a newer stable minor version is available for each provider (e.g. a later `azurerm ~> 4.x`). Update the constraint if a newer version is confirmed; do not downgrade below the template baseline.

**`azapi` and `time` are always required.** Many CPF modules use them internally.
Omitting either from `required_providers` causes `terraform init` to fail.

The block below reflects the current `infrastructure-main` baseline (update versions as needed):

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

---

## Security Rules (always apply)

- Public network access MUST be disabled on Key Vault, Storage, PostgreSQL, Function App
- All secrets MUST be stored in Key Vault; never hard-code
- Sensitive Terraform **variables AND outputs** MUST be marked `sensitive = true`:
  - **Always sensitive (credentials):** passwords, API keys, tokens, connection strings, secrets
  - **Always sensitive (topology):** server/resource IDs (full ARM ID paths), FQDNs, hostnames, private IP addresses, connection endpoints, UAI/service-principal IDs, tenant IDs — these expose infrastructure topology and aid targeted attacks
  - **Not sensitive:** resource names, environment names, location strings, tag maps
  When generating `outputs.tf`, evaluate every output against this classification before declaring it.
- Use User-Assigned Managed Identity for service-to-service auth (no connection strings with passwords)
- PostgreSQL: enable `active_directory_auth_enabled = true`, `password_auth_enabled = false`
- Storage: `enable_key_access = false`, `default_to_oauth_authentication = true`
- WAF policy must be in Detection mode for DEV, Prevention for PRD

---

## How to Use the Prompt Files in `.github/prompts/`

Run them in sequence from VS Code Copilot Chat:

1. **`/analyse-sad`** — extracts services, constraints, environments from a SAD docx

2. **(Optional) Run cpf-genie manually** — if you want richer module context or
   latest version tags, use the `@cpf-genie` extension in a **separate chat panel**
   for each service identified in step 1, then paste the output into the chat before
   running `/map-cpf-modules`. The agent cannot call `@cpf-genie` itself.
   If you skip this step, the agent reads `templates/cpf-schemas/` automatically.
   Example queries:
   ```
   @cpf-genie which CPF module covers Azure Service Bus?
   @cpf-genie show me the inputs for cpf-azure-prdsvc-keyvault
   @cpf-genie latest tag for azure-prdsvc-terraform-keyvault
   ```

3. **`/map-cpf-modules`** — maps detected services to specific CPF modules with required inputs.
   If you supplied cpf-genie output in step 2, the agent will use it; otherwise it falls back
   to reading `templates/cpf-schemas/` directly.

4. **`/generate-iac-scaffolding`** — generates the full directory tree + all Terraform files + CI pipeline
