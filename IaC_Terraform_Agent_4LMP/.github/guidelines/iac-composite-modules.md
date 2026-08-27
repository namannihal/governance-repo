# IaC Composite Module Grouping Guidelines
## LSEG Azure LMP — Terraform Scaffolding

---

## Deployment Topology — Three Options

Before generating any scaffolding, the user must choose one of three deployment
topologies. Options A and B use composite module groups and the same
`ci/module.yml` pipeline template. Option C (Micro-Stack) uses per-layer
Terraform roots and a `ci/stack-orchestrator.yml` pipeline.

### Option A — Mono-repo (single repository)

All composite module groups live in a single repository under
`terraform/modules/<group>/`. One parent pipeline triggers one child pipeline
per environment, and a single `terraform apply` deploys all tiers.

```
iac/<app-slug>/                       ← one Git repo
├── .gitlab-ci.yml                    ← one parent pipeline
├── ci/module.yml                     ← one child pipeline — deploys all tiers
├── environments/<env>/infra.tfvars   ← one tfvars per environment
└── terraform/
    ├── main.tf                       ← calls all composite modules in tier order
    └── modules/
        ├── identity/ · networking/ · observability/    ← Tier 1
        ├── keyvault/                                    ← Tier 2
        ├── storage/ · postgresql/                       ← Tier 3
        ├── compute/                                     ← Tier 4
        └── appgateway/ · access/                        ← Tier 5
```

**One TF state file per environment** (all groups share it).

### Option B — Dedicated repo per module group

Each composite module group is its own Git repository with its own `ci/`,
`environments/`, a **flat** `terraform/` layout (no `modules/` subdirectory),
its own TF state key, and its own pipeline. All repos share the same backend
storage account; only the state file key differs.

```
iac/
├── <app-slug>-identity/              ← own Git repo + pipeline + TF state key
├── <app-slug>-observability/
├── <app-slug>-networking/
├── <app-slug>-keyvault/
├── <app-slug>-storage/
├── <app-slug>-postgresql/
├── <app-slug>-compute/
├── <app-slug>-appgateway/
├── <app-slug>-access/
└── <app-slug>.code-workspace         ← VS Code multi-root workspace (all repos)
```

**One TF state file per group per environment.**
State key pattern: `infra/${ENV}/<app-slug>/<group>/terraform.tfstate`

Cross-tier outputs (e.g. `keyvault_id` needed by `compute`) are passed as plain
variables in downstream `infra.tfvars`, populated after the upstream repo is
applied.

| Consideration | Option A (mono-repo) | Option B (multi-repo) |
|---|---|---|
| Simplicity | Simpler — one repo, one apply | More complex — one repo per group |
| TF state blast radius | All tiers in one state | Isolated per group |
| Pipeline gating | One pipeline for all tiers | Independent pipeline per tier |
| RBAC granularity | One set of pipeline secrets | Separate secrets per tier |
| Cross-tier dependencies | Wired via Terraform outputs | Wired via tfvars (manual step) |
| VS Code experience | Single folder | Multi-root workspace file |

---

## Why Composite Modules?

When a CPF module plan contains more than 10 individual CPF module calls, a flat
`main.tf` becomes difficult to read, test, and maintain. **Composite modules**
(local child modules under `terraform/modules/`) group related CPF module calls
by lifecycle, ownership, and deployment tier. The root `main.tf` then contains
only composite module calls — one block per logical group — making the
dependency graph immediately visible.

---

## When to Apply This Pattern

| Module count in plan | Approach |
|---|---|
| < 10 CPF modules | Flat `main.tf` (single file, all CPF calls) |
| ≥ 10 CPF modules | Composite module layout — `terraform/modules/<group>/` |

Multi-service applications (Function App + Storage + PostgreSQL + AGW + Bastion)
**always** use the composite layout.

---

## Grouping Principles

1. **Lifecycle cohesion** — Resources always deployed and destroyed together
   belong in the same composite module.

2. **Dependency direction** — Composite modules form a directed acyclic graph
   (DAG). The deployment tier table below defines this graph. The parent
   `main.tf` wires composite modules in tier order.

3. **LZ boundary stays at root** — Landing Zone data sources (RGs, VNets,
   LZ subnets) and Azure Policy-managed DNS zones are always declared in
   the root `data.tf`. Pass their IDs/names as *variables* into child modules —
   never declare a `data` block inside a child module for an LZ resource.

4. **Primitive values only across module boundaries** — Pass only `string`,
   `number`, `bool`, or `list(string)` between composite modules. Never pass
   a whole data source object or a complex object returned by a CPF module.

5. **Diagnostics are platform-managed** — Azure Policy (DeployIfNotExists) on
   LSEG LMP automatically creates Diagnostic Settings for every PaaS resource
   and routes logs to the platform Log Analytics Workspace. **Do not** add
   `cpf-azure-prdsvc-monitordiagnosticsetting` CPF module calls in app IaC —
   they will conflict with Policy-managed settings and cause Terraform drift.

6. **Conditional flags live at root** — Feature flags such as
   `deploy_app_service_plan` are declared in
   the root `variable.tf` and passed into the relevant child module. The `count`
   (or `for_each`) logic is implemented **inside** the child module, not at root.

7. **No resource/data blocks in root main.tf** — The root `main.tf` must
   contain only `module` calls (composite module blocks). All CPF module
   calls live inside `terraform/modules/<group>/main.tf`.

---

## Standard Composite Module Groups

The following nine groups cover the standard LSEG LMP multi-service application
pattern. Omit any group whose resources are not required.

| Module name | CPF modules it wraps | Deployment tier | Hard dependencies |
|---|---|---|---|
| `identity` | `userassignedidentity` ×N | **Tier 1** | — |
| `observability` | `loganalyticsworkspace`, `applicationinsights` | **Tier 1** | `identity` |
| `networking` | `networksecuritygroup` ×N, `subnet` ×N, `privatednszone` (app-specific only) | **Tier 1** | — |
| `keyvault` | `keyvault`, `privateendpoint` | **Tier 2** | `identity`, `networking` |
| `storage` | `storageaccount`, `privateendpoint` | **Tier 3** | `keyvault`, `identity` |
| `postgresql` | `postgresqlserver`, `privateendpoint` | **Tier 3** | `keyvault`, `networking` |
| `compute` | `appserviceplan` (cond.), `linuxfunctionapp`, `privateendpoint` | **Tier 4** | `storage`, `postgresql`, `keyvault`, `networking`, `identity`, `observability` |
| `appgateway` | `webapplicationfirewallpolicy`, `publicip`, `applicationgateway` | **Tier 5** | `compute` — **always after compute** |

### Deployment Tier Summary

```
Tier 1 (parallel): identity  ·  networking  ·  observability
Tier 2:            keyvault         (depends on Tier 1)
Tier 3 (parallel): storage  ·  postgresql   (depends on Tier 2)
Tier 4:            compute          (depends on Tier 3)
Tier 5:            appgateway       (depends on Tier 4 — always after compute)
```

The application gateway **must be deployed after compute** so that its backend
pool can reference the private hostname or FQDN produced by the compute module.
Similarly, for AKS or ACA workloads, `appgateway` must wait until the cluster
or container app is running.

---

## File Layout

```
terraform/
├── providers.tf          ← azurerm, azuread, azapi, random providers + backend
├── variable.tf           ← all root variables; child modules receive values via pass-through
├── data.tf               ← ALL LZ data sources + policy-managed DNS zones (root only)
├── main.tf               ← composite module calls only; NO CPF module calls
├── outputs.tf            ← aggregated outputs from child modules
└── modules/
    ├── identity/
    │   ├── main.tf       ← CPF userassignedidentity calls
    │   ├── variables.tf
    │   └── outputs.tf
    ├── observability/
    │   ├── main.tf       ← CPF loganalyticsworkspace + applicationinsights
    │   ├── variables.tf
    │   └── outputs.tf
    ├── networking/
    │   ├── main.tf       ← CPF NSG, subnet, privatednszone (app-specific only)
    │   ├── variables.tf
    │   └── outputs.tf
    ├── keyvault/
    │   ├── main.tf       ← CPF keyvault + privateendpoint
    │   ├── variables.tf
    │   └── outputs.tf
    ├── storage/
    │   ├── main.tf       ← CPF storageaccount + privateendpoint
    │   ├── variables.tf
    │   └── outputs.tf
    ├── postgresql/
    │   ├── main.tf       ← CPF postgresqlserver + privateendpoint
    │   ├── variables.tf
    │   └── outputs.tf
    ├── compute/
    │   ├── main.tf       ← CPF appserviceplan + linuxfunctionapp + privateendpoint
    │   ├── variables.tf
    │   └── outputs.tf
    └── appgateway/
        ├── main.tf       ← CPF waf policy + publicip + applicationgateway
        ├── variables.tf
        └── outputs.tf
```

---

## Required Outputs per Composite Module

Each child module's `outputs.tf` must expose at minimum:

| Module | Required outputs |
|---|---|
| `identity` | `uai_<context>_id`, `uai_<context>_principal_id` for each UAI |
| `observability` | `law_id`, `appinsights_instrumentation_key`, `appinsights_connection_string` |
| `networking` | `subnet_<name>_id` for each app-owned subnet; `dns_internal_id` if created |
| `keyvault` | `keyvault_id`, `keyvault_name`, `keyvault_uri` |
| `storage` | `storage_account_id`, `storage_account_name`, `storage_blob_endpoint` |
| `postgresql` | `postgresql_id`, `postgresql_fqdn`, `postgresql_name` |
| `compute` | `funcapp_id`, `funcapp_name`, `funcapp_default_hostname` |
| `appgateway` | `agw_id`, `agw_public_ip_address` |

---

## Root `main.tf` Pattern

The root `main.tf` wires composite modules in dependency order. All LZ resource
references come from root `data.*` and are passed as variables — never re-queried
inside child modules.

```hcl
# ===========================================================================
# Tier 1 — parallel: identity, observability, networking
# ===========================================================================

module "identity" {
  source              = "./modules/identity"
  app_id              = var.app_id
  org_id              = var.org_id
  environment         = var.environment
  location            = var.location
  resource_group_name = data.azurerm_resource_group.app_rg.name
  tags                = var.tags
}

module "observability" {
  source                   = "./modules/observability"
  app_id                   = var.app_id
  org_id                   = var.org_id
  environment              = var.environment
  location                 = var.location
  resource_group_name      = data.azurerm_resource_group.app_rg.name
  uai_funcapp_principal_id = module.identity.uai_funcapp_principal_id
  law_sku                  = var.law_sku
  law_retention_days       = var.law_retention_days
  appinsights_application_type = var.appinsights_application_type
  appinsights_daily_cap_gb     = var.appinsights_daily_cap_gb
  tags                     = var.tags

  depends_on = [module.identity]
}

module "networking" {
  source                     = "./modules/networking"
  app_id                     = var.app_id
  org_id                     = var.org_id
  environment                = var.environment
  location                   = var.location
  shared_resource_group_name = var.shared_resource_group_name
  non_routable_vnet_name     = var.non_routable_vnet_name
  subnet_funcapp_cidr        = var.subnet_funcapp_cidr
  subnet_psql_cidr           = var.subnet_psql_cidr
  # Pass only primitives from LZ data sources:
  agw_subnet_address_prefix  = data.azurerm_subnet.agw_subnet.address_prefixes[0]
  routable_vnet_id           = data.azurerm_virtual_network.routable_vnet.id
  tags                       = var.tags
}

# ===========================================================================
# Tier 2 — keyvault (after identity + networking)
# ===========================================================================

module "keyvault" {
  source = "./modules/keyvault"
  # standard vars ...
  workload_subnet_id     = data.azurerm_subnet.workload_subnet.id
  kv_dns_zone_id         = data.azurerm_private_dns_zone.keyvault.id
  law_id                 = module.observability.law_id
  kv_admin_spn_object_id = var.kv_admin_spn_object_id
  # kv-specific vars ...
  tags = var.tags

  depends_on = [module.networking]
}

# ===========================================================================
# Tier 3 — parallel: storage, postgresql (both after keyvault)
# ===========================================================================

module "storage" {
  source = "./modules/storage"
  # standard vars ...
  keyvault_id              = module.keyvault.keyvault_id
  blob_dns_zone_id         = data.azurerm_private_dns_zone.blob.id
  workload_subnet_id       = data.azurerm_subnet.workload_subnet.id
  uai_storage_principal_id = module.identity.uai_storage_principal_id
  law_id                   = module.observability.law_id
  # storage-specific vars ...
  tags = var.tags

  depends_on = [module.keyvault]
}

module "postgresql" {
  source = "./modules/postgresql"
  # standard vars ...
  subnet_psql_id       = module.networking.subnet_psql_id
  psql_dns_zone_id     = data.azurerm_private_dns_zone.postgresql.id
  workload_subnet_id   = data.azurerm_subnet.workload_subnet.id
  keyvault_id          = module.keyvault.keyvault_id
  law_id               = module.observability.law_id
  # psql-specific vars ...
  tags = var.tags

  depends_on = [module.keyvault, module.networking]
}

# ===========================================================================
# Tier 4 — compute (after storage + postgresql)
# ===========================================================================

module "compute" {
  source = "./modules/compute"
  # standard vars ...
  subnet_funcapp_id               = module.networking.subnet_funcapp_id
  workload_subnet_id              = data.azurerm_subnet.workload_subnet.id
  funcapp_dns_zone_id             = data.azurerm_private_dns_zone.funcapp.id
  storage_account_name            = module.storage.storage_account_name
  keyvault_id                     = module.keyvault.keyvault_id
  uai_funcapp_id                  = module.identity.uai_funcapp_id
  appinsights_instrumentation_key = module.observability.appinsights_instrumentation_key
  appinsights_connection_string   = module.observability.appinsights_connection_string
  law_id                          = module.observability.law_id
  deploy_app_service_plan         = var.deploy_app_service_plan
  # funcapp-specific vars ...
  tags = var.tags

  depends_on = [module.storage, module.postgresql, module.networking, module.keyvault]
}

# ===========================================================================
# Tier 5 — parallel: appgateway (after compute), access (after networking)
# AGW is ALWAYS deployed after the compute tier (VM, AKS, ACA, Function App)
# so its backend pool configuration referencing compute hostnames is valid.
# ===========================================================================

module "appgateway" {
  source = "./modules/appgateway"
  # standard vars ...
  agw_subnet_id  = data.azurerm_subnet.agw_subnet.id
  uai_agw_id     = module.identity.uai_agw_id
  funcapp_name   = module.compute.funcapp_name   # backend pool FQDN
  law_id         = module.observability.law_id
  # waf + agw-specific vars ...
  tags = var.tags

  depends_on = [module.compute] # ← enforces compute → appgateway sequence
}

module "access" {
  source = "./modules/access"
  # standard vars ...
  bastion_subnet_id           = data.azurerm_subnet.bastion_subnet.id
  workload_subnet_id          = data.azurerm_subnet.workload_subnet.id
  deploy_bastion_and_jumphost = var.deploy_bastion_and_jumphost
  # bastion + jumphost-specific vars ...
  tags = var.tags

  depends_on = [module.networking]
}
```

---

## Child Module Internal Structure

### `variables.tf` rules
- Declare every value the module uses — no module may read `var.*` from the root
  scope; it must receive all values via its own `variables.tf`
- Group variables: standard LSEG (app_id, org_id …) → LZ pass-throughs
  (subnet IDs, DNS zone IDs) → service-specific config → feature flags
- Mark sensitive inputs with `sensitive = true`: credentials (passwords, API keys, tokens), AND infrastructure topology data (server IDs, FQDNs, connection endpoints, UAI principal IDs, tenant IDs)

### `main.tf` rules
- Contains **only** CPF module calls for the resources belonging to this group
- Uses `depends_on` internally where CPF module ordering within the group matters
  (e.g. `pe_keyvault` depends on `keyvault`)
- Uses `count = var.<flag> ? 1 : 0` for conditional resources (bastion, ASP)

### `outputs.tf` rules
- Expose every value that another composite module or the root `outputs.tf` needs
- Name outputs as `<resource_type>_<attribute>` (e.g. `keyvault_id`, `funcapp_name`)
- Evaluate every output for sensitivity before declaring it. When the value is required by a downstream module or consumer, mark it `sensitive = true` if it falls into either category:
  - **Credentials:** keys, tokens, passwords, connection strings
  - **Topology data:** full ARM resource IDs, FQDNs, hostnames, private IPs, connection endpoints, UAI/service-principal IDs, tenant IDs
  Resource names, environment names, and location strings do NOT require `sensitive = true`.

---

## Sequence-Enforcing `depends_on` Rules

| Consumer module | Must wait for | Why |
|---|---|---|
| `keyvault` | `networking` | Subnet NSGs must exist before PE is placed |
| `storage` | `keyvault` | CMK key must exist before storage creates the encryption key |
| `postgresql` | `keyvault`, `networking` | CMK + delegated subnet must exist |
| `compute` | `storage`, `postgresql`, `keyvault` | Function App needs storage + DB + KV before start |
| `appgateway` | `compute` | Backend pool FQDN / private IP only known after compute deploys |
| `access` | `networking` | Bastion subnet NSG must exist before BastionHost provisions |

> **Rule**: The Application Gateway (or any ingress layer) must **always** be the
> last tier deployed. For AKS workloads, `appgateway` depends on the AKS module.
> For ACA, it depends on the container app module. Never deploy AGW concurrently
> with the compute tier.

---

## When to Escalate to Micro-Stack (Option C)

The composite layout (Options A and B) suits most LSEG LMP applications.
When **two or more** of the following signals are true, propose
**Option C — Micro-Stack** to the user instead:

| Signal | Threshold |
|---|---|
| Total CPF module calls across all composite groups | > 50 |
| Number of composite module groups required | > 8 |
| `terraform plan` wall-clock time (full run) | > 10 minutes |
| Multiple teams own different infrastructure layers | Each team needs an independent release cadence |
| TF state lock contention observed | Two or more teams blocked on concurrent applies |
| Blast radius concern | A failed apply can affect more than one business-critical tier |

**Do not generate Option C without explicit user confirmation.** When approaching
the threshold, flag the concern, show the table above, and wait for confirmation.
When reviewing an existing composite codebase that is approaching these thresholds,
notify the user proactively but do not refactor automatically.

### What changes in Micro-Stack vs. Options A / B

In a Micro-Stack, each infrastructure layer is a **fully independent Terraform root**
with its own `providers.tf`, `variable.tf`, `data.tf`, `main.tf`, and state file.
All layers live as subdirectories under a single repository (`terraform/<layer>/`).
A `ci/stack-orchestrator.yml` child pipeline sequences them in tier order using
GitLab stages + `needs:`. Cross-layer outputs are passed as plain variables in
downstream `infra-<layer>.tfvars` (no `terraform_remote_state`).

| Aspect | Option A (mono-repo composite) | Option B (multi-repo composite) | Option C (Micro-Stack) |
|---|---|---|---|
| Repos | 1 | 1 per group | 1 |
| Terraform roots | 1 per env | 1 per group repo | 1 per layer |
| `modules/` subdirectory | Yes | No | No |
| TF state files per env | 1 | 1 per group | 1 per layer |
| Pipeline coordination | `ci/module.yml` | `ci/module.yml` per repo | `ci/stack-orchestrator.yml` |
| tfvars files | 1 per env | 1 per env per repo | 1 per layer per env |
| Cross-layer wiring | TF output references | Plain variables in tfvars | Plain variables in tfvars |
| Suited for | ≤ 50 CPF modules, single team | ≤ 50 CPF modules, per-tier RBAC | > 50 CPF modules or multi-team ownership |

**Canonical reference implementation:** `templates/iac_terraform-main/iac_terraform-main/`

That folder contains a working Micro-Stack example with:
- Per-layer `terraform/<layer>/` directories (app_gateway, func_app, key_vault, nonrtbl-network)
- Per-layer-per-env tfvars (`environments/dev/terraform-vars/<env>_<region>_<layer>_1.tfvars`)
- Per-env child pipeline with one trigger job per layer
  (`pipelines/iac/dev-eus2-iac-deployment-child.yaml`)

When generating Micro-Stack IaC, follow the `/generate-iac-scaffolding` prompt's
**Option C** section, using `iac_terraform-main/` as the structural reference.

---

## BAS Stack Isolation Rule

> **Each BAS stack folder owns exactly the CPF module calls for its own resource type.
> No stack may contain CPF module calls that are the responsibility of a dedicated
> sibling stack.**

This rule applies to all three BAS deployment topologies (Option A composite, Option B
multi-repo, and Option C Micro-Stack). The folder names below reflect common LSEG LMP
naming; substitute the actual folder names used in the target repo.

### The rule

| Stack role (example folder name) | Owns | Must NOT contain |
|---|---|---|
| Key Vault stack (e.g. `key_vault/`) | `cpf-azure-prdsvc-keyvault`, `cpf-azure-prdsvc-privateendpoint` (vault PE) | — |
| Compute stack (e.g. `func_app/`, `aks/`, `vm/`) | The compute resource and **its own** backing resources: `cpf-azure-prdsvc-storageaccount` (FA backing storage only), `cpf-azure-prdsvc-appserviceplan`, `cpf-azure-prdsvc-userassignedidentity` (compute identity) | Any module owned by a sibling stack: `cpf-azure-prdsvc-keyvault`, vault `cpf-azure-prdsvc-privateendpoint`, `cpf-azure-prdsvc-subnet`, `cpf-azure-prdsvc-networksecuritygroup`, `cpf-azure-prdsvc-routetable` |
| Networking stack (e.g. `nonrtbl-network/`, `networking/`) | `cpf-azure-prdsvc-subnet`, `cpf-azure-prdsvc-networksecuritygroup`, `cpf-azure-prdsvc-routetable` | — |
| App Gateway stack (e.g. `app_gateway/`, `ingress/`) | `cpf-azure-prdsvc-applicationgateway`, `cpf-azure-prdsvc-webapplicationfirewallpolicy`, `cpf-azure-prdsvc-publicip` | — |

**General principle:** If a dedicated stack exists for a resource type, every other
stack must receive that resource's ID as an input variable — never provision it inline.

### The compute backing-resource exception

A compute stack may include CPF module calls for resources that are **intrinsically
coupled** to the compute resource and have no dedicated sibling stack. The canonical
example is the Azure Functions backing storage account:

- `cpf-azure-prdsvc-storageaccount` inside a `func_app/` stack — **correct and required**.
  Azure Functions needs a dedicated storage account (for code, state, and trigger metadata)
  deployed in the same Terraform root as the Function App itself. This is not a violation.

The test: if removing the module call would break the compute resource at plan time
(it is a required input), it belongs in the compute stack. If it can be provisioned
before the compute stack and passed in as an ID, it belongs in its own stack.

### The legacy conditional-guard anti-pattern

Pre-BAS composite repos (e.g. cloned from an existing app) commonly embed CPF module calls
in the wrong stack folder, guarded by a conditional flag to make them skippable:

```hcl
# ANTI-PATTERN — keyvault module call inside func_app/ stack
module "azure-prdsvc-terraform-keyvault" {
  count  = var.key_vault_config.deploy_kv_and_pe ? 1 : 0   # ← conditional guard
  source = "git::https://..."
  ...
}
```

This pattern was designed for mono-repo or composite layouts (Options A/B) where all
resources share one state file. In BAS, it is dead code — the resource is already
deployed by its dedicated stack, and the flag in tfvars disables it.

**Do not carry forward this pattern when scaffolding or migrating to BAS.**
Remove the conditional-guarded CPF call from the wrong stack. The consuming stack
receives the upstream resource's ID via a plain input variable in its tfvars
(populated from the upstream stack's `outputs.tf` after first apply).

This applies to any resource type with a dedicated stack: Key Vault, networking
(subnet/NSG/routetable), storage, identity, observability, and so on.

### Migration audit (cloned repo)

When working from a **cloned or existing repo** instead of generating from scratch,
always run the cross-stack audit described in Step 1a of
`generate-iac-scaffolding.prompt.md` (Options A/B) or Step C1.5 of
`generate-iac-scaffolding-microstack.prompt.md` (Option C / BAS) before generating
or modifying any file.
