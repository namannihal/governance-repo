# Windows VM + Site Recovery Pattern

This Terraform pattern deploys Windows Virtual Machines (with optional file shares and Azure Backup) and configures Azure Site Recovery (ASR) A2A replication for cross-region disaster recovery.

---

## Architecture Overview

```
Primary Region (e.g. eastus2)                    Secondary Region (e.g. centralus)
─────────────────────────────────────────────    ──────────────────────────────────────
Windows VM (zone-pinned)                         Recovery Services Vault (RSV)
  ├─ OS Disk (CMK encrypted)                       ├─ ASR Fabric (primary)
  ├─ Data Disk(s) (CMK encrypted)                  ├─ ASR Fabric (secondary)
  ├─ User-Assigned Identity (UAI)                  ├─ Protection Container (primary)
  ├─ Disk Encryption Set (DES)                     ├─ Protection Container (secondary)
  ├─ Key Vault (infra)                             ├─ Replication Policy
  ├─ Azure Backup (disk)                           ├─ Container Mapping
  └─ File Share (Storage Account + PE)             ├─ Network Mapping
                                                   ├─ RSV Private Endpoint
ASR Cache Storage (primary region)                 ├─ ASR UAI (for CMK on RSV)
  └─ Blob Private Endpoint                         └─ Replicated VM (azapi)
ASR Cache Storage (secondary/reprotect region)
  └─ Blob Private Endpoint

RBAC (bidirectional, for failover + re-protect):
  RSV system identity → primary infra KV: Key Vault Crypto Service Encryption User
  RSV system identity → secondary infra KV: Key Vault Crypto Service Encryption User
  ASR UAI → secondary infra KV: Key Vault Crypto Service Encryption User
  VM UAI → secondary infra KV: Key Vault Crypto Service Encryption User
  VM UAI → secondary app KV: Key Vault Secrets Officer (if app_key_vault_id_secondary set)
  VM system identity → secondary app KV: Key Vault Secrets Officer (if app_key_vault_id_secondary set)
  RSV system identity → all cache storage accounts: Storage Account Contributor
  RSV system identity → all cache storage accounts: Storage Blob Data Contributor
```

---

## Resources Deployed

### Group 1 — Windows VM & File Share

| Resource | Description |
|---|---|
| `module.azure_prdsvcpat_terraform_windowsvirtualmachine` | Windows VM with OS/data disks, DES, Key Vault, UAI, NSG, PPG, Backup. `timezone = "Eastern Standard Time"`, `identity_type = "SystemAssigned, UserAssigned"` |
| `module.azure_prdsvc_terraform_roleassignment_app_keyvault` | VM UAI → primary app Key Vault: Key Vault Secrets Officer |
| `module.azure_prdsvc_terraform_roleassignment_system_identity_keyvault` | VM system identity → primary app Key Vault: Key Vault Secrets Officer |
| `module.azure_prdsvc_terraform_roleassignment_vm_user_login` | ENTRA group → VM: Virtual Machine User Login |
| `module.azure_prdsvc_terraform_roleassignment_vm_admin_login` | ENTRA group → VM: Virtual Machine Administrator Login |
| `module.azure-prdsvc-storageaccount-vm_files` | CMK-encrypted storage account for Azure File Share. Created only when `storage_account_config` is set on the VM. |
| `module.azure-prdsvc-terraform-privateendpoint` (file) | File (`file`) private endpoint for the VM Files storage account |
| `time_sleep.wait_120_seconds_storage` | 120 s propagation wait after file storage PE creation |
| `module.azure_prdsvc_terraform_resourcenames_vm_fileshare` | Resource naming for the Azure File Share |
| `azapi_resource.windows_vm_storage_share` | Azure File Share created via azapi (`Microsoft.Storage/storageAccounts/fileServices/shares`) |
| `azurerm_virtual_machine_extension.mount_azure_files` | CustomScriptExtension — writes a PowerShell mount script and registers it as a `SYSTEM` scheduled task that runs at every boot. Created only when `mount_azure_files = true`. |

### Group 2 — ASR Cache Storage

| Resource | Description |
|---|---|
| `module.azure-prdsvc-storageaccount-asr_cache` | CMK-encrypted ASR cache storage account(s). Created for each entry in `site_recovery.<key>.storage_account_config` where `id` is not set. Keyed as `<vm_key>/<storage_key>`. |
| `data.azapi_resource.asr_blob_service` | Reads live blob service state on every plan to detect soft-delete drift |
| `terraform_data.asr_blob_service_live_state` | Triggers PATCH actions whenever live blob service properties change |
| `azapi_update_resource.asr_blob_service_disable_restore_policy` | Disables Point-in-Time Restore. Runs before soft-delete disable (Azure dependency). |
| `azapi_update_resource.asr_blob_service_disable_soft_delete` | Disables blob/container soft delete, versioning, and change feed |
| `time_sleep.wait_asr_soft_delete_propagation` | 60 s propagation wait after soft-delete settings are patched |
| `module.azure_prdsvc_terraform_asr_blob_privateendpoint` | Blob (`blob`) private endpoint for each cache account |

### Group 3 — ASR Replication

| Resource | Description |
|---|---|
| `data.azurerm_client_config.this` | Reads current subscription/tenant IDs for ARM resource ID construction |
| `data.azapi_resource.site_recovery_source_vm` | Reads live VM `storageProfile` (OS disk ID + data disk LUNs/IDs) to populate `vmManagedDisks` in the replication body |
| `module.azure_prdsvc_terraform_resourcenames_asr_rsv` | Resource naming for the RSV and its sub-resources |
| `module.azure_prdsvc_terraform_userassignedidentity_asr` | UAI for RSV customer-managed key (CMK) in the secondary region |
| `module.azure_prdsvc_terraform_recoveryservicesvault` | Recovery Services Vault in the secondary region. `create_site_recovery_replicated_vm = false` — replication is handled directly by `azapi_resource.asr_replicated_vm`. |
| `module.azure_prdsvc_terraform_asr_rsv_privateendpoint` | RSV private endpoint (`AzureSiteRecovery`). Skipped when `create_rsv_private_endpoint = false`. |
| `time_sleep.wait_asr_rsv_pe_propagation` | 30 s propagation wait after RSV PE creation |
| `azurerm_site_recovery_fabric.asr_primary` | ASR fabric for the primary (source) location |
| `azurerm_site_recovery_fabric.asr_secondary` | ASR fabric for the secondary (recovery) location |
| `azurerm_site_recovery_protection_container.asr_primary` | Protection container in the primary fabric |
| `azurerm_site_recovery_protection_container.asr_secondary` | Protection container in the secondary fabric |
| `azurerm_site_recovery_replication_policy.asr_policy` | Replication policy (RPO retention + app-consistent snapshot frequency) |
| `azurerm_site_recovery_protection_container_mapping.asr_container_mapping` | Maps primary → secondary containers via the replication policy |
| `azurerm_site_recovery_network_mapping.asr_network_mapping` | Maps primary → secondary VNets |
| `azapi_resource.asr_replicated_vm` | EnableReplication (`Microsoft.RecoveryServices/vaults/replicationFabrics/replicationProtectionContainers/replicationProtectedItems`). OS disk always included; data disks included only when their `lun` matches an `additional_disk` entry. `response_export_values = []` and `lifecycle { ignore_changes = [body] }` — Terraform tracks existence only, not body state. This means failover/re-protect operations cause zero Terraform drift. 5-hour create timeout. |

### Group 3 — RBAC for ASR (bidirectional CMK + app secrets)

| Resource | Condition | Scope | Role |
|---|---|---|---|
| `azurerm_role_assignment.asr_secondary_cache_contributor` | Always (per cache account) | Each cache storage account | RSV system identity: Storage Account Contributor |
| `azurerm_role_assignment.asr_secondary_cache_blob_data_contributor` | Always (per cache account) | Each cache storage account | RSV system identity: Storage Blob Data Contributor |
| `azurerm_role_assignment.asr_rsv_uai_target_kv_crypto` | `key_vault_id_secondary != null` | Secondary infra KV | ASR UAI: Key Vault Crypto Service Encryption User |
| `azurerm_role_assignment.asr_rsv_system_id_target_kv_crypto` | `key_vault_id_secondary != null` | Secondary infra KV | RSV system identity: Key Vault Crypto Service Encryption User. Required for EUS2→CUS failover direction — RSV encrypts replica disks with the CUS DES key. |
| `azurerm_role_assignment.asr_rsv_system_id_source_kv_crypto` | `key_vault_id_secondary != null` | Primary (source) infra KV (`key_vault_id`) | RSV system identity: Key Vault Crypto Service Encryption User. Required for re-protect (CUS→EUS2) direction — RSV encrypts replica disks with the EUS2 DES key. |
| `azurerm_role_assignment.vm_msi_secondary_kv_crypto` | `key_vault_id_secondary != null` | Secondary infra KV | VM UAI: Key Vault Crypto Service Encryption User. Allows failed-over VM to start up with its disk encryption set in the secondary region. |
| `azurerm_role_assignment.vm_msi_secondary_app_kv_secrets` | `app_key_vault_id_secondary != null` | Secondary app KV | VM UAI: Key Vault Secrets Officer. Allows failed-over VM to read application secrets after failover. |
| `azurerm_role_assignment.vm_system_id_secondary_app_kv_secrets` | `app_key_vault_id_secondary != null` | Secondary app KV | VM system identity: Key Vault Secrets Officer |
| `time_sleep.wait_asr_cache_rbac_propagation` | Always | — | 90 s IAM propagation wait. Re-runs whenever any role assignment changes to prevent ASR error 28143 (vault lacks permission to cache storage before EnableReplication starts). |

---

## Disk Protection

| Disk | Protected | Condition |
|---|---|---|
| OS Disk | Always | Unconditionally included in `vmManagedDisks` |
| Data Disk(s) | When declared | Must have a matching `lun` entry in `windows_vm.<key>.additional_disk`. Disks attached to the VM but not declared in tfvars are **silently excluded**. Set `use_existing_data_disk = false` to replicate OS disk only. |

> **Important:** Every data disk to be replicated must have a corresponding entry in `additional_disk` with a `lun` that matches the disk as seen on the live VM. The live VM storageProfile is read at plan time via `data.azapi_resource.site_recovery_source_vm`.

---

## Module Versions

| Module | Ref |
|---|---|
| `azure-prdsvcpat-terraform-windowsvirtualmachine` | `1.1.0` |
| `azure-prdsvc-terraform-roleassignment` | `0.2.5` |
| `azure-prdsvc-terraform-storageaccount` | `1.1.0` |
| `azure-prdsvc-terraform-privateendpoint` | `0.7.2` |
| `azure-prdsvc-terraform-resourcenames` | `0.2.7` (file share) / `1.2.1` (ASR RSV) |
| `azure-prdsvc-terraform-userassignedidentity` | `0.4.2` |
| `azure-prdsvc-terraform-recoveryservicesvault` | `1.0.0` |

---

## Variables

### Required

| Variable | Type | Description |
|---|---|---|
| `org_id` | `string` | Three-letter org/tenant code (e.g. `a1a`). Validated against `^a[0-9][a-z]$`. |
| `app_id` | `string` | Application ID from Leanix |
| `environment` | `string` | One of `dev`, `ppr`, `qa`, `prd`, `sbx` |
| `location` | `string` | Primary Azure region CLI name (e.g. `eastus2`) |
| `resource_group_id` | `string` | Resource group ID for primary resources |
| `shared_nrtbl_vnet_id` | `string` | Non-routable VNet ID in the shared RG |
| `source_image_id` | `string` | Shared Image Gallery image version ID (applied to all VMs) |
| `windows_vm` | `map(any)` | Map of Windows VM configurations — keyed by VM key (see below) |
| `vm_user_login_group_id` | `string` | ENTRA group object ID for VM User Login role |
| `vm_admin_login_group_id` | `string` | ENTRA group object ID for VM Administrator Login role |

### Optional

| Variable | Type | Default | Description |
|---|---|---|---|
| `tags` | `map(any)` | `{}` | Tags applied to all resources |
| `key_vault_tags` | `map(any)` | `{}` | Tags applied to Key Vault resources |
| `key_vault_id` | `string` | `null` | Infrastructure Key Vault ID (primary region) |
| `app_key_vault_id` | `string` | `null` | Application Key Vault ID (primary region) |
| `resource_group_name` | `string` | `null` | Resource group name. Derived from `resource_group_id` if omitted. |
| `privateendpoint_subnet_id` | `string` | `null` | Default subnet ID for private endpoints |
| `firewall_private_ip_address` | `string` | `null` | Firewall private IP for route tables |
| `enable_entra_auth` | `bool` | `true` | Enable ENTRA-based VM login |
| `vm_agent_platform_updates_enabled` | `bool` | `false` | Enable VMAgent platform updates |
| `gi_refresh` | `bool` | `false` | Set `true` during Golden Image refresh — pauses backup protection before VM replacement |
| `manage_asr_cache_soft_delete` | `bool` | `true` | Auto-disable soft delete/versioning on ASR cache accounts. Set `false` if managed externally. |
| `storage_account_config` | `any` | `{}` | **Deprecated.** Legacy top-level storage account config. Use `windows_vm.<key>.storage_account_config` for file shares and `site_recovery.<key>.storage_account_config` for ASR cache accounts. |
| `site_recovery` | `map(object)` | `{}` | ASR configuration keyed by VM key (see below) |

### `windows_vm` map — key fields

```hcl
windows_vm = {
  <vm_key> = {
    context                        = string          # naming context
    instance                       = string          # naming instance (e.g. "01")
    zone                           = optional(string)
    size                           = string          # VM SKU
    admin_username                 = string
    computer_name                  = string
    secure_boot_enabled            = bool
    deploy_proximityplacementgroup = bool
    network_config = {
      use_existing_subnet = bool
      subnet_id           = string
    }
    disk_encryption_set = {
      context         = string
      instance        = string
      expiration_date = string
    }
    key_vault_config = { ... }
    os_disk = {
      storage_account_type = string   # e.g. "Premium_LRS"
      caching              = string   # "ReadWrite" or "ReadOnly"
      disk_size_gb         = number
      # network_access_policy and public_network_access are forced to "DenyAll"/"Disabled"
    }
    additional_disk = {               # required for each data disk to be ASR-protected
      <disk_key> = {
        lun                  = number   # must match live VM disk LUN
        disk_size_gb         = number
        storage_account_type = string
        caching              = string
        availability_zone    = string
        instance             = string
        context              = string
        enable_disk_backup   = bool
      }
    }
    azure_backup    = { ... }         # backup_vault_id, backup_policy_id, backup_vm_name required for gi_refresh
    storage_account_config = { ... }  # file share storage account (optional)
    file_share_config      = { ... }  # Azure File Share settings (optional)
    mount_azure_files      = bool
    mount_drive_letter     = string   # e.g. "Z"
  }
}
```

### `site_recovery` map — key fields

```hcl
site_recovery = {
  <vm_key> = {
    # --- Required ---
    secondary_location            = string   # recovery region CLI name (e.g. "centralus")
    resource_group_name_secondary = string   # resource group in secondary region
    rsv_subnet_id                 = string   # subnet for RSV private endpoint in secondary region
    staging_storage_account_key   = string   # key into storage_account_config for primary cache account
    primary_network_id            = string   # source VNet ARM ID
    target_network_id             = string   # recovery VNet ARM ID
    target_disk_type              = string   # e.g. "Premium_LRS"
    target_replica_disk_type      = string
    expiration_date               = string   # ISO8601, for CMK key expiry

    fabric_name                         = string
    fabric_secondary_name               = string
    protection_container_name           = string
    protection_container_secondary_name = string
    replication_policy_name             = string
    container_mapping_name              = string
    network_mapping_name                = string
    replication_name                    = string   # name of the replicated item resource

    # --- Optional overrides ---
    staging_storage_account_id    = optional(string, null)   # direct SA ARM ID override (skips lookup)
    create_rsv_private_endpoint   = optional(bool, true)
    key_vault_id_secondary        = optional(string, null)   # secondary infra KV — enables bidirectional CMK RBAC
    app_key_vault_id_secondary    = optional(string, null)   # secondary app KV — grants VM identity access post-failover
    target_encryption_set_id      = optional(string, null)
    target_virtual_machine_name   = optional(string, null)   # recovery VM name override
    context                       = optional(string, null)   # overrides VM context for RSV naming
    instance                      = optional(string, null)   # overrides VM instance for RSV naming
    asr_identity_context          = optional(string, null)   # overrides context for ASR UAI naming
    asr_identity_instance         = optional(string, null)   # overrides instance for ASR UAI naming
    use_existing_data_disk        = optional(bool, true)     # set false to replicate OS disk only

    # --- RSV settings ---
    sku                                                  = optional(string, "Standard")
    storage_mode_type                                    = optional(string, "GeoRedundant")
    cross_region_restore_enabled                         = optional(bool, true)
    cross_subscription_restore_state                     = optional(string, "Disabled")
    immutability                                         = optional(string, "Locked")
    recovery_point_retention_in_minutes                  = optional(number, 1440)
    application_consistent_snapshot_frequency_in_minutes = optional(number, 240)
    monitoring = optional(object({
      alerts_for_all_job_failures_enabled            = optional(bool, true)
      alerts_for_critical_operation_failures_enabled = optional(bool, true)
    }), null)

    # --- Cache storage accounts (creates TF-managed accounts; id overrides to existing) ---
    storage_account_config = optional(map(object({
      id                       = optional(string, null)   # set to use an existing account
      context                  = string
      instance                 = string
      location                 = optional(string, null)
      resource_group_name      = optional(string, null)
      account_tier             = optional(string, "Standard")
      account_replication_type = optional(string, "LRS")
      enable_key_access        = optional(bool, false)
      persist_access_key       = optional(bool, false)
      use_asr_uai_for_cmk      = optional(bool, false)   # use ASR UAI instead of VM UAI for cache CMK
      private_endpoint_config  = optional(object({
        is_manual_connection = optional(bool, false)
        static_ip_required   = optional(bool, false)
        subnet_id            = optional(string, null)
      }), {})
    })), {})
  }
}
```

---

## Providers

| Provider | Version |
|---|---|
| `hashicorp/azurerm` | `>= 4.33` |
| `azure/azapi` | `~> 2.5.0` |
| `hashicorp/time` | `0.11.1` |

Terraform version: `>= 1.5.0`

Backend: Azure Storage (`use_azuread_auth = true`)

---

## Outputs

| Output | Sensitive | Description |
|---|---|---|
| `keyvault` | Yes | Key Vault module outputs per VM key |
| `keyvault_pe` | Yes | Key Vault private endpoint outputs per VM key |
| `userassignedidentity` | Yes | User-assigned identity outputs per VM key |
| `networksecuritygroup` | Yes | NSG outputs per VM key |
| `routetable` | Yes | Route table outputs per VM key |
| `subnet` | Yes | Subnet outputs per VM key |
| `diskencryptionset` | Yes | Disk encryption set outputs per VM key |
| `proximityplacementgroup` | Yes | PPG outputs per VM key |
| `windowsvm` | Yes | Windows VM resource outputs per VM key |
| `dataprotectionbackupvault` | Yes | Backup vault outputs per VM key |
| `dataprotectionbackupinstance` | Yes | Backup instance outputs per VM key |
| `recovery_services_vault_id` | No | RSV ARM IDs per VM key |
| `recovery_services_vault_name` | No | RSV names per VM key |
| `recovery_services_vault_resource` | Yes | Full RSV resource outputs per VM key |
| `site_recovery_replication_name` | No | ASR replicated item resource names per VM key |
| `site_recovery_failover_automation` | No | Structured output for the failover-couchdb-automation pipeline: RSV name, RG, fabric names, container names, policy name, replication name, promoted/standby regions, cache storage account name/ID |
| `asr_cache_storage_account_name` | No | Cache storage account names per `<vm_key>/<storage_key>` |

---

## Initialisation & Deployment

### First-time init

```powershell
cd terraform/windowsvm_site_recovery

# Unset GIT_DIR if running inside a git repo (avoids "$GIT_DIR too big" error)
Remove-Item Env:GIT_DIR -ErrorAction SilentlyContinue

terraform init -backend-config="backend.tfvars"
```

> **After `terraform init -upgrade`:** If a `blob_properties_stable_override.tf` override file exists in `$TF_DATA_DIR/modules/azure-prdsvc-storageaccount-asr_cache/`, it must be recreated — `init -upgrade` wipes the `.terraform/` module cache.

### Plan

```powershell
$env:TF_DATA_DIR = "C:\tfdata\windowsvm_site_recovery"
terraform plan -var-file="../../environments/<env>/terraform-vars/<region>/<env>_<region>_windowsvm_site_recovery_1.tfvars"
```

### Apply

```powershell
$env:TF_DATA_DIR = "C:\tfdata\windowsvm_site_recovery"
terraform apply -var-file="../../environments/<env>/terraform-vars/<region>/<env>_<region>_windowsvm_site_recovery_1.tfvars"
```

> **Note:** Initial replication (`azapi_resource.asr_replicated_vm`) has a 5-hour create timeout. The resource uses `lifecycle { ignore_changes = [body] }` so subsequent plans show no changes after ASR modifies replication state (failover, re-protect, etc.).

---

## Targeted Destroy (single VM)

To destroy only a specific VM and its sub-resources:

```powershell
terraform destroy `
  -target 'module.azure_prdsvcpat_terraform_windowsvirtualmachine["<vm_key>"]' `
  -var-file="../../environments/<env>/terraform-vars/<region>/<env>_<region>_windowsvm_site_recovery_1.tfvars"
```

> Without `-auto-approve`, Terraform will display the destroy plan and prompt for confirmation before proceeding.

---

## Golden Image (GI) Refresh Runbook

When replacing a VM with a new golden image, disk backup protection must be paused or Terraform cannot delete the old VM.

1. Set `gi_refresh = true` in the tfvars.
2. Run `terraform apply` — Terraform removes backup protection before destroying/recreating the VM.
3. After the new VM is created and healthy, set `gi_refresh = false`.
4. Run `terraform apply` again — Terraform re-enables backup protection.

Each VM's `azure_backup` block must contain `backup_vault_id`, `backup_policy_id`, and `backup_vm_name` for this flow to work.

For a full end-to-end refresh including ASR reset and CouchDB reinstall, see the [failover-couchdb-automation README](../../failover-couchdb-automation/README.md) — Section 3: Golden Image Refresh.

---

## ASR Cache Account Soft-Delete Management

ASR requires blob soft delete, container soft delete, versioning, and point-in-time restore to be **disabled** on cache storage accounts. This is handled automatically by a two-step PATCH sequence:

1. `azapi_update_resource.asr_blob_service_disable_restore_policy` — disables Point-in-Time Restore first (Azure requires this before soft delete can be disabled).
2. `azapi_update_resource.asr_blob_service_disable_soft_delete` — disables blob/container soft delete, versioning, and change feed.

`terraform_data.asr_blob_service_live_state` triggers both PATCH actions whenever Azure or a Policy re-enables any of these settings between applies, ensuring drift is corrected on the next `terraform apply`.

Set `manage_asr_cache_soft_delete = false` only if the accounts are managed externally.

---

## Known Constraints

- `create_site_recovery_replicated_vm = false` is forced in the RSV module. `azapi_resource.asr_replicated_vm` handles EnableReplication directly to bypass azurerm provider errors 150153 and 150353.
- `azapi_resource.asr_replicated_vm` uses `response_export_values = []` — Terraform reads nothing back from the ASR API. Combined with `lifecycle { ignore_changes = [body] }`, Terraform tracks only whether the resource exists, not its body state. Failover and re-protect operations cause **zero Terraform drift**.
- Data disks are included in replication only when their live VM LUN matches an entry in `windows_vm.<key>.additional_disk`. Unmatched LUNs are silently skipped. Set `use_existing_data_disk = false` to exclude all data disks.
- Bidirectional CMK RBAC (both failover EUS2→CUS and re-protect CUS→EUS2) requires `key_vault_id_secondary` to be set. Without it, the three RSV/VM Crypto role assignments are skipped and ASR will return error 539 on the first replication attempt.
- `app_key_vault_id_secondary` is required if the failed-over VM must access application secrets from a secondary-region Key Vault. Without it, apps on the recovered VM fail to start even if disk encryption is healthy.
- The RSV private endpoint requires `rsv_subnet_id` in the secondary region. Set `create_rsv_private_endpoint = false` to skip it.
- The `$GIT_DIR` environment variable must be unset before running `terraform init` from inside a git working directory on Windows, otherwise nested module cloning fails with `fatal: '$GIT_DIR' too big`.
- A 90 s IAM propagation sleep (`time_sleep.wait_asr_cache_rbac_propagation`) runs before `azapi_resource.asr_replicated_vm` to prevent ASR error 28143 (vault system identity not yet authorised on cache storage).
