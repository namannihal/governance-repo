# Linux VM Module

Deploys one or more Linux virtual machines and the supporting storage, private endpoint, RBAC, and Azure Files mount automation used by the Estimates environments.

The module wraps several LSEG pattern/service modules and drives them from the `linux_vm_config` and `storage_account_config` maps.

## Resources Created per VM

| Resource | Description |
|---|---|
| Linux Virtual Machine | via `azure-prdsvcpat-terraform-linuxvirtualmachine` (ref `1.1.0`) |
| User-assigned Managed Identity | Attached to the VM; used for Key Vault RBAC and storage CMK wiring |
| Disk Encryption Set | Customer-managed key via Key Vault |
| Network Security Group + Route Table | Created by the pattern module per VM |
| Subnet (or existing) | Controlled by each VM's `network_config` |
| Azure Backup resources | Optional per VM via `azure_backup` |
| RBAC: Key Vault Secrets Officer | Assigned to both user-assigned and system-assigned identities |
| RBAC: Virtual Machine User Login | Assigned to `vm_user_login_group_id` |
| RBAC: Virtual Machine Administrator Login | Assigned to `vm_admin_login_group_id` |
| Bootstrap VM extension | Optional standalone Linux `CustomScript` extension that can set timezone and mount Azure Files after VM and storage deployment |

## Resources Created per Storage Account

| Resource | Description |
|---|---|
| Storage Account | via `azure-prdsvc-terraform-storageaccount` (ref `1.1.0`) |
| Private Endpoint (file) | via `azure-prdsvc-terraform-privateendpoint` (ref `0.7.2`) |

## Resources Created per VM with `file_share_config`

| Resource | Description |
|---|---|
| Azure File Share | via `azure-prdsvc-terraform-storageshare` (ref `0.3.1`), one share per VM |

## Azure Files Mount for RHEL 9

When `timezone` and/or `mount_azure_files = true` is set on a VM, the module creates one standalone Azure VM extension using:

- publisher: `Microsoft.Azure.Extensions`
- type: `CustomScript`

The extension runs on the guest VM and can:

1. Set the Linux timezone when `timezone` is provided.
2. Verify the VM is RHEL 9 style with `dnf` available.
3. Install `cifs-utils`.
4. Create the credentials file under `/etc/smbcredentials`, trying the standard Azure Files SMB username format first and falling back to `localhost\\<storage-account>` if needed.
5. Create the mount path, defaulting to `/app`.
6. Write a persistent `/etc/fstab` entry for the Azure Files share.
7. Mount the share immediately.

This is implemented as a single standalone `Microsoft.Azure.Extensions` / `CustomScript` handler per VM because Azure Linux VMs do not support multiple extensions with the same handler on one VM.
The extension is managed outside the wrapped Linux VM child module so it can depend on the storage account, private endpoint, and file share resources without creating a Terraform dependency cycle.

Current dev convention:

- mount point: `/app`
- `uid = 1010`
- `gid = 100`

Because the mount is persisted in `/etc/fstab`, it survives reboot after the first extension run.

Security note:

- The generated credentials file contains the storage account key in plaintext on the VM.
- The storage account key is also persisted to Key Vault when `persist_access_key = true` is enabled for the storage account config.

## Required Providers

| Provider | Version |
|---|---|
| `hashicorp/azurerm` | `>= 4.33` |
| `hashicorp/azuread` | `~> 2.47.0` |
| `hashicorp/time` | `0.11.1` |
| `hashicorp/random` | `3.6.0` |
| `hashicorp/tls` | `~> 3.0` |
| `azure/azapi` | `~> 2.5.0` |

## Key Inputs

### Common / Platform

| Variable | Type | Required | Description |
|---|---|---|---|
| `org_id` | `string` | Yes | Three-letter organisation code. |
| `app_id` | `string` | Yes | Leanix APP ID numeric portion. |
| `environment` | `string` | Yes | Environment name such as `dev`, `ppr`, `prd`, `tst`, `sbx`. |
| `location` | `string` | Yes | Azure region CLI name, such as `eastus2`. |
| `tags` | `map(any)` | No | Common tags applied to resources. |
| `key_vault_tags` | `map(any)` | No | Tags applied to Key Vault resources. |
| `resource_group_id` | `string` | Yes | Resource ID of the target resource group. |
| `resource_group_name` | `string` | No | Resource group name used by storage submodules. |
| `shared_nrtbl_vnet_id` | `string` | Yes | Non-routable VNet resource ID. |
| `privateendpoint_subnet_id` | `string` | Yes | Subnet ID for storage private endpoints. |
| `firewall_private_ip_address` | `string` | No | Firewall private IP used by the wrapped pattern. |
| `key_vault_id` | `string` | No | Infrastructure Key Vault ID. |
| `app_key_vault_id` | `string` | No | Application Key Vault ID for Secrets Officer RBAC. |
| `vm_user_login_group_id` | `string` | Yes | ENTRA group object ID for VM User Login. |
| `vm_admin_login_group_id` | `string` | Yes | ENTRA group object ID for VM Administrator Login. |

### Storage Account Map: `storage_account_config`

Each key represents one storage account definition.

| Field | Type | Required | Description |
|---|---|---|---|
| `context` | `string` | Yes | Naming context for the storage account. |
| `instance` | `string` | Yes | Naming instance suffix. |
| `account_tier` | `string` | Yes | Storage tier such as `Standard`. |
| `account_replication_type` | `string` | Yes | Replication type such as `ZRS`. |
| `persist_access_key` | `bool` | Yes | Persist the storage key to Key Vault. |
| `enable_key_access` | `bool` | Yes | Enable key-based access. |
| `kv_secret_expiration_date` | `string` | Yes | Secret expiry date in ISO 8601 format. |
| `enable_file_share_AADDS_authentication` | `bool` | No | Enable AADDS auth for file shares. |
| `primary_vm_identity_key` | `string` | Yes | VM key whose user-assigned identity is used for CMK ownership. |
| `private_endpoint_config.is_manual_connection` | `bool` | Yes | Whether PE approval is manual. |
| `private_endpoint_config.static_ip_required` | `bool` | Yes | Whether the PE must use a static IP. |

### Linux VM Map: `linux_vm_config`

Each key represents one Linux VM definition.

| Field | Type | Required | Description |
|---|---|---|---|
| `context` | `string` | Yes | Naming context for the VM. |
| `instance` | `string` | Yes | Naming instance suffix. |
| `context_private_key` | `string` | Yes | Private key naming input passed to the wrapped module. |
| `instance_private_key` | `string` | Yes | Private key instance suffix. |
| `context_public_key` | `string` | Yes | Public key naming input passed to the wrapped module. |
| `instance_public_key` | `string` | Yes | Public key instance suffix. |
| `admin_username` | `string` | Yes | Admin username for the VM. |
| `username` | `string` | Yes | Standard username field passed to the wrapped module. |
| `computer_name` | `string` | Yes | Hostname / computer name. |
| `size` | `string` | Yes | Azure VM SKU. |
| `zone` | `string` | No | Availability zone. |
| `source_image_id` | `string` | Yes | Shared Image Gallery image ID. |
| `network_config` | `object` | Yes | Existing subnet or networking configuration. |
| `os_disk` | `object` | Yes | OS disk configuration. |
| `disk_encryption_set` | `object` | Yes | DES configuration values. |
| `key_vault_config` | `object` | Yes | Key Vault settings for the wrapped VM pattern. |
| `termination_notification` | `object` | Yes | Spot/termination notification settings. |
| `azure_backup` | `object` | Yes | Backup configuration passed through to the wrapped module. |
| `timezone` | `string` | No | When set, the standalone Linux bootstrap `CustomScript` extension applies the requested timezone. |
| `storage_account_key` | `string` | No | Key from `storage_account_config` to host this VM's file share. |
| `file_share_config` | `object` | No | File share settings, typically `quota` and optional `enabled_protocol`. |
| `mount_azure_files` | `bool` | No | When `true`, the standalone Linux bootstrap `CustomScript` extension mounts the file share. |
| `mount_point` | `string` | No | Mount target path. Default: `/app`. |
| `mount_uid` | `number` | No | UID applied to the mounted share. Default: `1010`. |
| `mount_gid` | `number` | No | GID applied to the mounted share. Default: `100`. |

## Example tfvars

This example mirrors the current dev pattern: one shared storage account and two RHEL 9 app servers mounting their Azure Files share at `/app`.

```hcl
org_id      = "a1a"
app_id      = "52161"
location    = "eastus2"
environment = "dev"

resource_group_id           = "/subscriptions/<subscription-id>/resourceGroups/a1a-52161-dev-rg-estimates-eus2-01"
resource_group_name         = "a1a-52161-dev-rg-estimates-eus2-01"
shared_nrtbl_vnet_id        = "/subscriptions/<subscription-id>/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01"
privateendpoint_subnet_id   = "/subscriptions/<subscription-id>/resourceGroups/a1a-52161-dev-rg-platform-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-rtbl-eus2-01/subnets/a1a-52161-dev-snet-workload-eus2-06"
firewall_private_ip_address = "10.93.196.68"
key_vault_id                = "/subscriptions/<subscription-id>/resourceGroups/a1a-52161-dev-rg-estimates-eus2-01/providers/Microsoft.KeyVault/vaults/a1a52161devkvinfeus201"
app_key_vault_id            = "/subscriptions/<subscription-id>/resourceGroups/a1a-52161-dev-rg-estimates-eus2-01/providers/Microsoft.KeyVault/vaults/a1a52161devkvappeus201"

vm_user_login_group_id  = "<entra-user-group-object-id>"
vm_admin_login_group_id = "<entra-admin-group-object-id>"

storage_account_config = {
  linux_shared = {
    context                                = "app"
    instance                               = "01"
    account_tier                           = "Standard"
    persist_access_key                     = true
    enable_key_access                      = true
    account_replication_type               = "ZRS"
    kv_secret_expiration_date              = "2026-12-31T23:59:59Z"
    enable_file_share_AADDS_authentication = false
    primary_vm_identity_key                = "ec_appsrv01"
    private_endpoint_config = {
      is_manual_connection = false
      static_ip_required   = false
    }
  }
}

linux_vm_config = {
  ec_appsrv01 = {
    context                        = "appsrv"
    instance                       = "01"
    context_private_key            = "pvkappsrv"
    instance_private_key           = "01"
    context_public_key             = "pbkappsrv"
    instance_public_key            = "01"
    admin_username                 = "lsegadmin"
    username                       = "lsegadmin"
    computer_name                  = "estdevappsrv01"
    size                           = "Standard_E16ads_v5"
    zone                           = "1"
    secure_boot_enabled            = true
    priority                       = "Regular"
    timezone                       = "Eastern Standard Time"
    vtpm_enabled                   = true
    enable_systemassigned_identity = true
    source_image_id                = "/subscriptions/<subscription-id>/resourceGroups/.../images/rhel-server-9-standard-x64-application/versions/1.0.0"
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/<subscription-id>/resourceGroups/.../subnets/a1a-52161-dev-snet-ecapp-eus2-01"
    }
    disk_encryption_set = {
      context         = "appsrv"
      instance        = "01"
      key_type        = "RSA-HSM"
      key_size        = "2048"
      expiration_date = "2026-08-25T16:10:00Z"
    }
    termination_notification = {
      enabled = false
      timeout = "PT5M"
    }
    key_vault_config = {
      deploy_kv_and_pe               = false
      kv_secret_expiration_in_months = 12
      key_vault_id                   = "/subscriptions/<subscription-id>/resourceGroups/.../vaults/a1a52161devkvinfeus201"
      network_acls = {
        bypass = "AzureServices"
      }
      private_endpoint = {
        static_ip_required = false
      }
    }
    azure_backup = {
      enable_backup             = false
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "appsrv"
      instance                  = "01"
      identity_type             = "SystemAssigned"
      expiration_date           = "2026-08-27T09:49:40Z"
      disk_backup_policy        = null
    }
    storage_account_key = "linux_shared"
    file_share_config = {
      quota = 150
    }
    mount_azure_files = true
    mount_point       = "/app"
    mount_uid         = 1010
    mount_gid         = 100
  }
}
```

## Notes

- The current mount automation is intended for RHEL 9 images.
- Linux VMs can only have one `Microsoft.Azure.Extensions.CustomScript` handler active in this design, so timezone and mount steps are intentionally combined into the same extension payload.
- The bootstrap extension is intentionally managed outside the wrapped VM child module so it can safely depend on storage resources and avoid Terraform graph cycles.
- The module root currently does not define explicit outputs in this repository folder.
- `terraform fmt -write=false terraform/linuxvm/main.tf` is a useful first check when editing the extension command payload, because nested heredocs and shell quoting can break HCL parsing.