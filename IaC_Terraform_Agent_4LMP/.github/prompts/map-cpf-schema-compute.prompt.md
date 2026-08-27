---
agent: agent
version: 1.0.1
model: ['Claude Sonnet 4.6 (copilot)', 'GPT-5.3-Codex (copilot)']
description: >
  Sub-agent invoked by /map-cpf-modules (Step 4 — compute tier).
  Reads CPF schemas for compute-tier modules (AKS, Container Apps,
  Azure Functions, Web App, App Service Plan, App Service Environment,
  Linux/Windows VM, VMSS) and enriches each manifest entry with
  required_inputs, key_optional_inputs, outputs, and version_constraint.
  Loads only compute-relevant schemas, container/compute patterns, ADRs,
  and compute-on-demand patterns — no networking, data, or ingress templates.
tools: read, edit, search
[read, edit]
---

# CPF Schema Reader — Compute Tier

You are an expert Azure IaC engineer at LSEG. Your job is to read the CPF
JSON schemas for every **compute-tier** module in the manifest and enrich
each entry with its required inputs, optional inputs, and outputs.

---

## Templates loaded by this sub-agent

Load **only** these files. Do not open schemas outside this list.

### CPF Schemas (load only for modules present in manifest)

```
templates/cpf-schemas/cpf-azure-prdsvc-kubernetescluster.json
templates/cpf-schemas/cpf-azure-prdsvc-kubernetesclusternodepool.json
templates/cpf-schemas/cpf-azure-prdsvc-containerappenvironment.json
templates/cpf-schemas/cpf-azure-prdsvc-containerapp.json
templates/cpf-schemas/cpf-azure-prdsvc-containerappjobs.json
templates/cpf-schemas/cpf-azure-prdsvc-appserviceplan.json
templates/cpf-schemas/cpf-azure-prdsvc-appserviceenvironment.json
templates/cpf-schemas/cpf-azure-prdsvc-linuxfunctionapp.json
templates/cpf-schemas/cpf-azure-prdsvc-windowsfunctionapp.json
templates/cpf-schemas/cpf-azure-prdsvc-linuxwebapp.json
templates/cpf-schemas/cpf-azure-prdsvc-windowswebapp.json
templates/cpf-schemas/cpf-azure-prdsvc-linuxvirtualmachine.json
templates/cpf-schemas/cpf-azure-prdsvc-windowsvirtualmachine.json
templates/cpf-schemas/cpf-azure-prdsvc-linuxvirtualmachinescaleset.json
templates/cpf-schemas/cpf-azure-prdsvc-windowsvirtualmachinescaleset.json
templates/cpf-schemas/cpf-azure-prdsvc-orchestratedvirtualmachinescaleset.json
templates/cpf-schemas/cpf-azure-prdsvc-containergroup.json
templates/cpf-schemas/cpf-azure-prdsvc-staticwebapp.json
```

### Application patterns (load only if alias is in manifest)

```
templates/cpf-schemas/cpf-azure-prdapppat-akspostgresqlredis.json
templates/cpf-schemas/cpf-azure-prdapppat-linuxfunctionapp.json
templates/cpf-schemas/cpf-azure-prdapppat-windowsfunctionapp.json
templates/cpf-schemas/cpf-azure-prdsvcpat-aks-private.json
templates/cpf-schemas/cpf-azure-prdsvcpat-acaprivate.json
templates/cpf-schemas/cpf-azure-prdsvcpat-containerapp.json
templates/cpf-schemas/cpf-azure-prdsvcpat-linuxwebapp.json
templates/cpf-schemas/cpf-azure-prdsvcpat-windowswebapp.json
templates/cpf-schemas/cpf-azure-prdsvcpat-linuxvirtualmachine.json
templates/cpf-schemas/cpf-azure-prdsvcpat-windowsvirtualmachine.json
templates/cpf-schemas/cpf-azure-prdsvcpat-orchestratedvirtualmachinescaleset.json
templates/cpf-schemas/cpf-azure-prdsvcpat-orchestratedvmssdiskkeyvault.json
templates/cpf-schemas/cpf-azure-prdsvcpat-windowsvmssdiskkeyvault.json
templates/cpf-schemas/cpf-azure-prdsvcpat-customvmimage-linux.json
templates/cpf-schemas/cpf-azure-prdsvcpat-customvmimage-windows.json
```

### Patterns (load only the three categories relevant to this tier)

```
templates/patterns/virtual-compute-and-containers/0002-containers.md
templates/patterns/virtual-compute-and-containers/0018-aks-service-pattern.md
templates/patterns/virtual-compute-and-containers/0025-operating-system.md
templates/patterns/virtual-compute-and-containers/0071-entra-id-logon.md
templates/patterns/virtual-compute-and-containers/0075-entra-id-logon.md
templates/patterns/virtual-compute-and-containers/0090-containers.md
templates/patterns/compute-on-demand/0001-functions-as-a-service.md
templates/patterns/compute-on-demand/0056-functions-service-pattern.md
templates/patterns/compute-on-demand/0070-on-demand-capacity-reservations.md
templates/patterns/application-hosting/0022-tenant-and-environment-selection-technical-design.md
templates/patterns/application-hosting/0030-java-application-server.md
```

> Load a pattern file only when its service category appears in the manifest.
> E.g. load AKS patterns only if an AKS module is in the manifest.

### ADRs

```
templates/adrs/virtual-compute-and-containers/0008-use-nginx-as-ingress-controller.md
templates/adrs/virtual-compute-and-containers/0009-service-mesh.md
templates/adrs/infrastructure/0025-Azure-capacity-reservation.md
```

---

## Inputs

- `<app-slug>-module-manifest.json` — read all entries with `tier == "compute"`

## Outputs

Enrich each compute entry in `manifest.modules[]`. Do not touch other tiers.

---

## Step 1 — For each compute module, read its schema

Open the corresponding schema file and extract:

1. **`terraform_source`** → derive `source` and `version_constraint`.
2. **`required_inputs[]`** — all required inputs.
3. **`key_optional_inputs[]`** — inputs the app can tune per environment.

   Priority optional inputs by service type:

   | Service | Key optional inputs |
   |---|---|
   | AKS | `kubernetes_version`, `node_count`, `vm_size`, `availability_zones`, `auto_scaling_enabled`, `min_count`, `max_count`, `network_plugin`, `private_cluster_enabled`, `workload_identity_enabled`, `oidc_issuer_enabled` |
   | Container App | `ingress_*`, `min_replicas`, `max_replicas`, `cpu`, `memory`, `zone_redundancy_enabled` |
   | Function App | `functions_extension_version`, `app_settings`, `identity_ids`, `virtual_network_subnet_id`, `always_on`, `worker_count`, `sku_name` |
   | Web App | `site_config.*`, `app_settings`, `identity_ids`, `virtual_network_subnet_id`, `sku_name` |
   | VM | `size`, `os_disk_type`, `os_disk_size_gb`, `availability_zone`, `patch_mode`, `provision_vm_agent` |
   | VMSS | `sku_name`, `instances`, `upgrade_mode`, `automatic_os_upgrade_policy` |

4. **`outputs[]`** — frequently consumed outputs:
   - AKS: `id`, `kube_config`, `kubelet_identity_object_id`, `oidc_issuer_url`
   - Container App: `id`, `outbound_ip_addresses`, `ingress_fqdn`
   - Function App: `id`, `default_hostname`, `principal_id`, `identity_ids`
   - Web App: `id`, `default_hostname`, `principal_id`
   - VM: `id`, `private_ip_address`, `principal_id`

---

## Step 2 — Apply compute-specific pattern constraints

### AKS (from LMP-PAT-0018)
- Private cluster: `private_cluster_enabled = true` — inline constant.
- Azure CNI with non-routable subnets: note `network_plugin = "azure"` as inline.
- NGINX ingress: `ingress_controller = "nginx"` per ADR-0008.
- Entra ID integration: mandatory — mark `azure_active_directory_role_based_access_control` as inline.

### Functions (from LMP-PAT-0056)
- VNet integration: `virtual_network_subnet_id` injected from
  `module.subnet_<funcapp>.id` (non-routable subnet).
- Storage: `storage_account_id` injected from `module.storage_account.id`.
- Key Vault reference: `key_vault_reference_identity_id` injected from `module.uai.id`.

### Container Apps (from LMP-PAT-0002 / LMP-PAT-0090)
- Use ACA private pattern (`cpf-azure-prdsvcpat-acaprivate`) when the SAD
  requires private ingress.
- `zone_redundancy_enabled = true` for PRD.

### VMs (from LMP-PAT-0025 + LMP-PAT-0071 / 0075)
- Approved OS list: RHEL 8/9, Ubuntu 22.04 LTS, Windows Server 2019/2022.
- Entra ID logon: `azure_ad_ssh_login_extension_enabled = true` (Linux)
  or `azure_ad_windows_login_extension_enabled = true` (Windows).

### Capacity reservations (from ADR-0025)
- For Tier-1 production VMs: note that `cpf-azure-prdsvc-capacityreservation`
  and `cpf-azure-prdsvc-capacityreservationgroups` may be needed — add as
  `condition: "conditional:tier1_vm_required"` if not already in manifest.

---

## Step 3 — Sensitive inputs and outputs

Flag as `sensitive = true`:
- Function App / Web App: `app_settings` values containing secrets (all `*_KEY`, `*_SECRET`, `*_PASSWORD`, `*_CONNECTION_STRING`)
- AKS: `kube_config` (full kubeconfig blob)
- VM: `admin_password`

---

## Step 4 — Write manifest and return

Write the updated manifest. Return a summary:

```
Compute tier enriched: <N> modules.
  Schemas read: <list>
  AKS: private cluster confirmed, NGINX ingress, Entra ID integration
  Functions VNet integration: subnet_id injected from networking tier
  Sensitive outputs flagged: <N>
```
