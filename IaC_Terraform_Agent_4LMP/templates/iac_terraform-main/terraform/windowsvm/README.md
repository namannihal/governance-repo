# Windows VM Module

Deploys one or more Windows Virtual Machines (and their associated infrastructure) into a non-routable virtual network. The module wraps several LSEG pattern/service modules and wires them together to produce a production-ready VM stack per VM key in `windows_vm`.

---

## Resources Created per VM

| Resource | Description |
|---|---|
| Windows Virtual Machine | via `azure_prdsvcpat_terraform_windowsvirtualmachine` (ref 1.1.0) |
| User-assigned Managed Identity | Attached to the VM; used for Key Vault RBAC |
| Disk Encryption Set | Customer-managed key via Key Vault |
| Network Security Group + Route Table | Created by the pattern module per VM |
| Subnet (or existing) | Configurable per VM via `network_config` |
| Azure Backup Vault + Policy | Optional per VM via `azure_backup` |
| Additional Data Disks | Optional per VM via `additional_disk` |
| Key Vault (infra) | Shared; referenced via `key_vault_id` |
| RBAC — Key Vault Secrets Officer | Assigned to both user-assigned and system-assigned identities |
| RBAC — VM User Login | Assigned to the ENTRA group specified by `vm_user_login_group_id` |
| RBAC — VM Administrator Login | Assigned to the ENTRA group specified by `vm_admin_login_group_id` |

## Resources Created per Storage Account (`storage_account_config`)

| Resource | Description |
|---|---|
| Storage Account | via `azure-prdsvc-storageaccount` (ref 1.1.0) |
| Private Endpoint (file) | via `azure-prdsvc-terraform-privateendpoint` (ref 0.7.2) |

## Resources Created per VM (with `file_share_config`)

| Resource | Description |
|---|---|
| Azure File Share | via `azure-prdsvc-terraform-storageshare` (ref 0.3.1), one share per VM |

## Azure Files Mount (optional)

When `mount_azure_files = true` is set on a VM, the module uses a `CustomScriptExtension` to:

1. Convert the storage account key to a secure string at runtime.
2. Create a machine-wide SMB global mapping for the drive letter.
3. Write a mount script under the Windows common application data location, typically `C:\ProgramData\AzureFilesMount\`.
4. Register a Windows Scheduled Task that runs at startup as `SYSTEM`, then start that task immediately so the first mount and all later remounts use the same execution context.

Because the mount uses `New-SmbGlobalMapping`, the mapped drive is visible to all users on the VM rather than only to the account that executed the script.

The drive letter defaults to `Z:` and can be overridden per VM with `mount_drive_letter`.

> **Security note:** The generated mount script contains the storage account key in plaintext. The key is also persisted to Key Vault (via `persist_access_key = true`). For higher security environments, consider modifying the extension payload to retrieve the key from Key Vault at boot time instead.

---

## Required Providers

| Provider | Version |
|---|---|
| `hashicorp/azurerm` | `>= 4.33` |
| `hashicorp/time` | `0.11.1` |
| `hashicorp/random` | `3.6.0` |
| `hashicorp/tls` | `~> 3.0` |
| `azure/azapi` | `~> 2.5.0` |

---

## Inputs

### Common / Platform

| Variable | Type | Required | Description |
|---|---|---|---|
| `org_id` | `string` | Yes | Three-letter organisation code (e.g. `a1a`). |
| `app_id` | `string` | Yes | Leanix APP-ID numeric part (e.g. `52161`). |
| `environment` | `string` | Yes | One of `dev`, `ppr`, `prd`, `tst`, `sbx`. |
| `location` | `string` | Yes | Azure region CLI name (e.g. `eastus2`). |
| `tags` | `map(any)` | No | Tags applied to all resources. |
| `key_vault_tags` | `map(any)` | No | Tags applied only to Key Vault resources. |
| `resource_group_id` | `string` | Yes | Resource ID of the target resource group. |
| `resource_group_name` | `string` | No | Name of the resource group (used by storage sub-modules). |
| `shared_nrtbl_vnet_id` | `string` | Yes | Resource ID of the non-routable VNet. |
| `privateendpoint_subnet_id` | `string` | No | Subnet ID for private endpoints. |
| `firewall_private_ip_address` | `string` | No | Azure Firewall private IP for route tables. |
| `source_image_id` | `string` | Yes | Shared Image Gallery image ID used for all VMs. |
| `key_vault_id` | `string` | No | Infrastructure Key Vault ID (DES keys, storage keys). |
| `app_key_vault_id` | `string` | No | Application Key Vault ID (Secrets Officer RBAC). |
| `enable_entra_auth` | `bool` | No | Enable AAD/Entra login extension. Default: `true`. |
| `vm_user_login_group_id` | `string` | Yes | ENTRA group object ID for VM User Login role. |
| `vm_admin_login_group_id` | `string` | Yes | ENTRA group object ID for VM Administrator Login role. |

### Storage Account (`storage_account_config`)

A map keyed by an arbitrary name (e.g. `windows_shared`). Each entry accepts:

| Field | Type | Required | Description |
|---|---|---|---|
| `context` | `string` | Yes | Context label used in resource naming. |
| `instance` | `string` | Yes | Instance number suffix. |
| `account_tier` | `string` | Yes | `Standard` or `Premium`. |
| `account_replication_type` | `string` | Yes | `LRS`, `ZRS`, `GRS`, etc. |
| `persist_access_key` | `bool` | Yes | Store the primary access key in Key Vault. |
| `enable_key_access` | `bool` | Yes | Enable key-based access on the storage account. |
| `kv_secret_expiration_date` | `string` | Yes | ISO 8601 expiry date for the KV secret. |
| `enable_file_share_AADDS_authentication` | `bool` | Yes | Enable AADDS Kerberos auth for file shares. |
| `primary_vm_identity_key` | `string` | Yes | Key from `windows_vm` whose managed identity owns the storage CMK. |
| `private_endpoint_config.is_manual_connection` | `bool` | Yes | Whether the PE requires manual approval. |
| `private_endpoint_config.static_ip_required` | `bool` | Yes | Whether a static private IP is required for the PE. |

### Windows VM (`windows_vm`)

A map keyed by an arbitrary VM identifier (e.g. `ec_hvprep01`). Each entry accepts:

| Field | Type | Required | Description |
|---|---|---|---|
| `context` | `string` | Yes | Context label used in resource naming. |
| `instance` | `string` | Yes | Instance number suffix. |
| `zone` | `string` | No | Availability zone (e.g. `"1"`). |
| `size` | `string` | Yes | Azure VM SKU (e.g. `Standard_D2ads_v5`). |
| `admin_username` | `string` | Yes | Local admin username. |
| `computer_name` | `string` | Yes | Windows computer name (≤ 15 chars). |
| `secure_boot_enabled` | `bool` | Yes | Enable Secure Boot (Trusted Launch). |
| `deploy_proximityplacementgroup` | `bool` | Yes | Deploy a Proximity Placement Group for the VM. |
| `network_config` | `object` | Yes | Subnet assignment. Set `use_existing_subnet = true` and provide `subnet_id`. |
| `disk_encryption_set` | `object` | Yes | CMK DES config: `context`, `instance`, `expiration_date`. |
| `key_vault_config` | `object` | Yes | KV settings: `deploy_kv_and_pe`, `key_vault_id`, `kv_secret_expiration_in_months`, `network_acls`, `private_endpoint`. |
| `os_disk` | `object` | Yes | `storage_account_type`, `caching`, `disk_size_gb`. |
| `additional_disk` | `map(object)` | No | Additional data disks keyed by disk name. |
| `azure_backup` | `object` | Yes | Backup config: `create_backup_vault`, `create_disk_backup_policy`, `context`, `instance`, `identity_type`, `expiration_date`, `disk_backup_policy`. |
| `storage_account_key` | `string` | No | Key from `storage_account_config` that this VM's file share is created in. Required when `file_share_config` is set. |
| `file_share_config` | `object` | No | `quota` (GiB) and `enabled_protocol` (`SMB`). Creates an Azure File Share for this VM. |
| `mount_azure_files` | `bool` | No | When `true`, mounts the VM's file share via a Windows `CustomScriptExtension`. Default: `false`. |
| `mount_drive_letter` | `string` | No | Drive letter for the Azure Files mount. Default: `Z`. |

---

## Outputs

| Output | Description |
|---|---|
| `windowsvm` | Full VM resource outputs per VM key (sensitive). |
| `userassignedidentity` | User-assigned managed identity outputs per VM key (sensitive). |
| `keyvault` | Key Vault outputs per VM key (sensitive). |
| `keyvault_pe` | Key Vault private endpoint outputs per VM key (sensitive). |
| `networksecuritygroup` | NSG outputs per VM key (sensitive). |
| `routetable` | Route table outputs per VM key (sensitive). |
| `subnet` | Subnet outputs per VM key (sensitive). |
| `diskencryptionset` | Disk encryption set outputs per VM key (sensitive). |
| `proximityplacementgroup` | PPG outputs per VM key (sensitive). |
| `dataprotectionbackupvault` | Backup vault outputs per VM key (sensitive). |
| `dataprotectionbackupinstance` | Backup instance outputs per VM key (sensitive). |

---

## Example `tfvars`

The example below shows a single shared storage account and two VMs. The first VM (`ec_hvprep01`) has an additional data disk, a full backup policy, and Azure Files mounting enabled. The second VM (`ea_calcsrv01`) is a minimal compute-only VM without Azure Files mounting.

```hcl
org_id      = "a1a"
app_id      = "52161"
location    = "eastus2"
environment = "dev"

tags = {
  mnd-applicationid      = "app-52161"
  mnd-applicationname    = "estimates_azure_dbor_dev"
  mnd-costcentre         = "52161"
  mnd-dataclassification = "restricted"
  mnd-envsubtype         = "test"
  mnd-envtype            = "dev"
  mnd-lifecycle          = "live"
  mnd-owner              = "tf-tf-indiaestimatestech@lseg.com"
  mnd-projectcode        = "P009707"
  mnd-supportgroup       = "appopsfls_content_techops"
  cloud_provider         = "azure"
  opt-datadog            = "require"
}

key_vault_tags = {
  mnd-applicationid      = "app-52161"
  mnd-applicationname    = "estimates_azure_dbor_dev"
  mnd-costcentre         = "52161"
  mnd-dataclassification = "restricted"
  mnd-envsubtype         = "test"
  mnd-envtype            = "dev"
  mnd-lifecycle          = "live"
  mnd-owner              = "tf-tf-indiaestimatestech@lseg.com"
  mnd-projectcode        = "P009707"
  mnd-supportgroup       = "appopsfls_content_techops"
  cloud_provider         = "azure"
  opt-datadog            = "require"
}

# ── Platform Dependencies ────────────────────────────────────────────────────
resource_group_id           = "/subscriptions/<subscription-id>/resourceGroups/a1a-52161-dev-rg-estimates-eus2-01"
resource_group_name         = "a1a-52161-dev-rg-estimates-eus2-01"
shared_nrtbl_vnet_id        = "/subscriptions/<subscription-id>/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01"
privateendpoint_subnet_id   = "/subscriptions/<subscription-id>/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01/subnets/a1a-52161-dev-snet-ecpec-eus2-01"
firewall_private_ip_address = "10.93.196.68"
key_vault_id                = "/subscriptions/<subscription-id>/resourceGroups/a1a-52161-dev-rg-estimates-eus2-01/providers/Microsoft.KeyVault/vaults/a1a52161devkvinfeus201"
app_key_vault_id            = "/subscriptions/<subscription-id>/resourceGroups/a1a-52161-dev-rg-estimates-eus2-01/providers/Microsoft.KeyVault/vaults/a1a52161devkvappeus201"
source_image_id             = "/subscriptions/<subscription-id>/resourceGroups/a1a-52161-dev-rg-estimates-eus2-01/providers/Microsoft.Compute/galleries/a1a52161devsigvmimageeus201/images/windows-server-2022-standard-x64-application/versions/1.0.0"

# ── Entra Auth ───────────────────────────────────────────────────────────────
enable_entra_auth       = true
vm_user_login_group_id  = "<entra-group-object-id-user-login>"
vm_admin_login_group_id = "<entra-group-object-id-admin-login>"

# ── Storage Account ──────────────────────────────────────────────────────────
# One shared storage account whose file shares are used by all VMs.
storage_account_config = {
  windows_shared = {
    context                                = "wvm"
    instance                               = "01"
    account_tier                           = "Standard"
    account_replication_type               = "ZRS"
    persist_access_key                     = true
    enable_key_access                      = true
    kv_secret_expiration_date              = "2028-08-27T09:49:40Z"
    enable_file_share_AADDS_authentication = false
    # The managed identity from this VM is used as the CMK identity for the storage account.
    primary_vm_identity_key = "ec_hvprep01"
    private_endpoint_config = {
      is_manual_connection = false
      static_ip_required   = false
    }
  }
}

# ── Windows VMs ──────────────────────────────────────────────────────────────
windows_vm = {

  # ── VM 1: ec_hvprep01 ─────────────────────────────────────────────────────
  # Full example: additional data disk, weekly backup retention, Azure Files mount on Z:
  ec_hvprep01 = {
    context  = "hvprep"
    instance = "01"
    zone     = "1"

    size                           = "Standard_D2ads_v5"
    admin_username                 = "lsegadmin"
    computer_name                  = "hvprepdeveus201"
    secure_boot_enabled            = true
    deploy_proximityplacementgroup = true

    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/<subscription-id>/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01/subnets/a1a-52161-dev-snet-ecapp-eus2-01"
    }

    disk_encryption_set = {
      context         = "hvprep"
      instance        = "01"
      expiration_date = "2028-12-27T09:49:40Z"
    }

    key_vault_config = {
      deploy_kv_and_pe               = false
      key_vault_id                   = "/subscriptions/<subscription-id>/resourceGroups/a1a-52161-dev-rg-estimates-eus2-01/providers/Microsoft.KeyVault/vaults/a1a52161devkvinfeus201"
      kv_secret_expiration_in_months = 12
      network_acls = {
        bypass = "AzureServices"
      }
      private_endpoint = {
        static_ip_required = false
      }
    }

    os_disk = {
      storage_account_type = "Standard_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }

    # Optional additional data disk
    additional_disk = {
      data_disk_1 = {
        instance                       = "01"
        context                        = "hvprep"
        enable_disk_backup             = true
        storage_account_type           = "StandardSSD_LRS"
        availability_zone              = "1"
        caching                        = "ReadWrite"
        lun                            = 0
        disk_size_gb                   = "1024"
        disk_encryption_set_id         = null
        ultra_ssd_disk_iops_read_write = null
        ultra_ssd_disk_mbps_read_write = null
      }
    }

    azure_backup = {
      create_backup_vault       = true
      create_disk_backup_policy = true
      context                   = "hvprep"
      instance                  = "01"
      identity_type             = "SystemAssigned"
      expiration_date           = "2026-12-27T09:49:40Z"
      disk_backup_policy = {
        backup_repeating_time_intervals = ["R/2023-11-22T11:40:16+00:00/P1D"]
        default_retention_duration      = "P7D"
        time_zone                       = "Eastern Standard Time"
        retention_rule = [
          {
            name     = "Weekly"
            duration = "P7D"
            priority = 20
            criteria = {
              absolute_criteria = "FirstOfWeek"
            }
          }
        ]
      }
    }

    # Azure Files — file share created and mounted on Z:
    storage_account_key = "windows_shared"
    file_share_config = {
      quota            = 200
      enabled_protocol = "SMB"
    }
    mount_azure_files  = true
    mount_drive_letter = "Z"
  }

  # ── VM 2: ea_calcsrv01 ────────────────────────────────────────────────────
  # Minimal example: no additional disk, simple backup, Azure Files mount disabled.
  ea_calcsrv01 = {
    context  = "calcsrv"
    instance = "01"
    zone     = "1"

    size                           = "Standard_D4ads_v5"
    admin_username                 = "lsegadmin"
    computer_name                  = "calcsrvdeveus201"
    secure_boot_enabled            = true
    deploy_proximityplacementgroup = true

    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/<subscription-id>/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01/subnets/a1a-52161-dev-snet-eaapp-eus2-01"
    }

    disk_encryption_set = {
      context         = "calcsrv"
      instance        = "01"
      expiration_date = "2028-12-27T09:49:40Z"
    }

    key_vault_config = {
      deploy_kv_and_pe               = false
      key_vault_id                   = "/subscriptions/<subscription-id>/resourceGroups/a1a-52161-dev-rg-estimates-eus2-01/providers/Microsoft.KeyVault/vaults/a1a52161devkvinfeus201"
      kv_secret_expiration_in_months = 12
      network_acls = {
        bypass = "AzureServices"
      }
      private_endpoint = {
        static_ip_required = false
      }
    }

    os_disk = {
      storage_account_type = "Standard_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }

    azure_backup = {
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "calcsrv"
      instance                  = "01"
      identity_type             = "SystemAssigned"
      expiration_date           = "2028-08-27T09:49:40Z"
    }

    # Azure Files — file share created but NOT auto-mounted (mount_azure_files omitted / false)
    storage_account_key = "windows_shared"
    file_share_config = {
      quota            = 100
      enabled_protocol = "SMB"
    }
    mount_azure_files  = false
  }
}
```

---

## Azure Files Mount — How It Works

```
storage_account_config
  └── windows_shared (Standard ZRS)
        └── Private Endpoint (file) → non-routable subnet
              │
              ├── File Share: <vm-context>-<instance>  (per VM)
              │     quota = 200 GiB, SMB
              │
              └── Access Key → Key Vault secret

windows_vm[ec_hvprep01]
  mount_azure_files  = true
  mount_drive_letter = "Z"
        │
        └── azurerm_virtual_machine_extension (CustomScriptExtension)
              PowerShell:
                 1. Convert storage key to secure string
                 2. Remove any existing mapping on Z:
                 3. New-SmbGlobalMapping Z: \\<account>.file.core.windows.net\<share>
          3. Write %ProgramData%\AzureFilesMount\mount-azure-files.ps1
          4. Register scheduled task at startup as SYSTEM
          5. Start scheduled task immediately and log to mount-azure-files.log
                   (re-runs the global mapping on every machine boot)
```

### Enabling / disabling per VM

| `mount_azure_files` | `file_share_config` | Result |
|---|---|---|
| `true` | present | Share created **and** mounted; scheduled task installed for persistence. |
| `false` or omitted | present | Share created, mount **skipped**. |
| omitted | omitted | No share, no mount. |

`mount_drive_letter` is only consulted when `mount_azure_files = true`. It accepts any free single letter (`A`–`Z`). Defaults to `Z`.

---

## Module Source References

| Module | Source | Ref |
|---|---|---|
| Windows VM Pattern | `azure-prdsvcpat-terraform-windowsvirtualmachine` | `1.1.0` |
| Role Assignment | `azure-prdsvc-terraform-roleassignment` | `0.2.5` |
| Storage Account | `azure-prdsvc-terraform-storageaccount` | `1.1.0` |
| Private Endpoint | `azure-prdsvc-terraform-privateendpoint` | `0.7.2` |
| Storage Share | `azure-prdsvc-terraform-storageshare` | `0.3.1` |
