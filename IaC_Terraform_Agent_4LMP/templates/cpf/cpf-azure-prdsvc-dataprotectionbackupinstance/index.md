---
version: 3.0.1
available_versions:
  - 3.0.1
  - 3.0.0
  - 2.0.0
  - 1.0.1
  - 1.0.0
---

<!-- BEGIN_TF_DOCS -->
# Azure Backup Vault Protected Item module

## Overview

- This terraform module creates an Azure Backup Vault Protected Item for Managed Disk and PostgreSQL flexible server.

## Prerequisites

- `Resource Group`, `Virtual Network`, and `Route Table` (all three modules to be called if not existing).
- `Subnet` to be used by the Private endpoint and the VM Network Interface IP Configs.
- `Network Security Group` to be associated with the Subnet.
- `Keyvault` module to create a secret.
- `Privateendpoint` module to create a private connection to the Keyvault.
- `Role assignment` module to assign the role to disk, postgreSQL flexible server and resourcegroup.
- `Keyvault Secret` module to store the Password for Windows VM.
- `Disk Encryption` module to enable the encryption.
- `Windows Virtual Machine` module to use enable the backup for virtual machine.
- `Managed Disk`  module to enable the Disk backup.
- Optional modules and resources:
  - `time_sleep` resource block to wait for the secret to get created till private connection is registered in the Private DNS Zone and `random_password` resource block to generate admin_password for Windows VM.
  `User assigned identity` module to create user assigned identity for postgreSQL flexible server.
  `PostgreSQL Flexible Server` module to create a postgreSQL flexible server.
  `Data protection backupvault` module to create postgreSQL flexible server backup policy.

## Guidance

#### Usage

- Azure Managed Disk Backup is a native, cloud-based backup solution that protects your data in managed disks.
- Azure Backup for postgresql flexible  server provides enhanced backup resiliency by protecting the source data from different levels of data loss ranging from accidental deletion to ransomware attacks.
- Disk and PostgreSQL backup instances are configured via map variables using `for_each` to support multiple instances:
  - Set `disk_backup_instances` to a map of instances.
  - Set `postgresql_backup_instances` to a map of instances.
  - Blob storage remains unchanged and uses `blobstorage_backup_instances` (map) with `for_each`.

Example:

```hcl
disk_backup_instances = {
  "disk1" = {
    name                         = "<disk-name>"
    location                     = "<location>"
    vault_id                     = "<vault-id>"
    disk_id                      = "<disk-id>"
    snapshot_resource_group_name = "<rg-name>"
    backup_policy_id             = "<policy-id>"
  }
}

postgresql_backup_instances = {
  "postgresql1" = {
    name             = "<pg-name>"
    location         = "<location>"
    vault_id         = "<vault-id>"
    server_id        = "<server-id>"
    backup_policy_id = "<policy-id>"
  }
}
```

Outputs now expose maps for Disk, PostgreSQL, and Blob instances containing `id` and `name`.

#### Migration

If upgrading from a version that used `count` with single-object variables for Disk and PostgreSQL, follow these steps to avoid resource recreation:

- Use the `for_each` keys expected by the module's state migration:
  - Disk: key `"disk1"` in `disk_backup_instances`.
  - PostgreSQL: key `"postgresql1"` in `postgresql_backup_instances`.

The module includes Terraform `moved` blocks that map the old address `[0]` to these keys, ensuring resources are not recreated.

Recommended:
- Run `terraform plan` to confirm no replacements occur.

#### Security Considerations

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. |  |  |  |  |  |  |

## Changelog

- [azure-prdsvc-terraform-dataprotectionbackupinstance](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/backup/disk-backup-overview)
- [Azure Backup Vault Disk Protection](https://learn.microsoft.com/en-us/azure/backup/backup-managed-disks)
- [Azure PostgreSQL Flexible Server](https://learn.microsoft.com/en-us/azure/backup/backup-azure-database-postgresql-flex-overview)

### Terraform Docs

- [azurerm_data_protection_backup_instance_disk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_protection_backup_instance_disk)
- [azurerm_data_protection_backup_instance_postgresql_flexible_server](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_protection_backup_instance_postgresql_flexible_server)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm) | >=4.33 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | >=4.33 |

## Resources

| Name | Type |
|------|------|
| [azurerm_data_protection_backup_instance_blob_storage.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_protection_backup_instance_blob_storage) | resource |
| [azurerm_data_protection_backup_instance_disk.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_protection_backup_instance_disk) | resource |
| [azurerm_data_protection_backup_instance_postgresql_flexible_server.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_protection_backup_instance_postgresql_flexible_server) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_blobstorage_backup_instances"></a> [blobstorage_backup_instances](#input_blobstorage_backup_instances) | (Optional) Map of Blob Storage Backup Instances to create. If null, no blob storage backup instances will be created.<br/>map(object({<br/>  name               = "(Required) Specifies the name of the Backup Instance for the Blob Storage. Changing this forces a new resource to be created."<br/>  location           = "(Required) The location of the source storage account. Changing this forces a new resource to be created."<br/>  vault_id           = "(Required) The ID of the Backup Vault within which the Blob Storage Backup Instance should exist. Changing this forces a new resource to be created."<br/>  storage_account_id = "(Required) The ID of the source storage account. Changing this forces a new resource to be created."<br/>  backup_policy_id   = "(Required) The ID of the Backup Policy."<br/>  storage_account_container_names = "(Optional) The list of the container names of the source Storage Account."<br/>})) | <pre>map(object({<br/>    name                            = string<br/>    location                        = string<br/>    vault_id                        = string<br/>    storage_account_id              = string<br/>    backup_policy_id                = string<br/>    storage_account_container_names = optional(list(string), [])<br/>  }))</pre> | `null` | no |
| <a name="input_disk_backup_instances"></a> [disk_backup_instances](#input_disk_backup_instances) | (Optional) Map of Disk Backup Instances to create. If null, no disk backup instances will be created.<br/>map(object({<br/>  name                   = "(Required) The name which should be used for this Backup Instance Disk. Changing this forces a new Backup Instance Disk to be created."<br/>  location              = "(Required) The Azure Region where the Backup Instance Disk should exist. Changing this forces a new Backup Instance Disk to be created."<br/>  vault_id               = "(Required) The ID of the Backup Vault within which the Backup Instance Disk should exist. Changing this forces a new Backup Instance Disk to be created."<br/>  disk_id                = "(Required) The ID of the source Disk. Changing this forces a new Backup Instance Disk to be created."<br/>  snapshot_resource_group_name = "(Required) The name of the Resource Group where snapshots are stored. Changing this forces a new Backup Instance Disk to be created."<br/>  backup_policy_id        = "(Required) The ID of the Backup Policy."<br/>})) | <pre>map(object({<br/>    name                         = string<br/>    location                     = string<br/>    vault_id                     = string<br/>    disk_id                      = string<br/>    snapshot_resource_group_name = string<br/>    backup_policy_id             = string<br/>  }))</pre> | `null` | no |
| <a name="input_postgresql_backup_instances"></a> [postgresql_backup_instances](#input_postgresql_backup_instances) | (Optional) Map of PostgreSQL Flexible Server Backup Instances to create. If null, no PostgreSQL backup instances will be created.<br/>map(object({<br/>  name             = "(Required) Specifies the name of the Backup Instance for the PostgreSQL Flexible Server. Changing this forces a new resource to be created."<br/>  location         = "(Required) The location of the source database. Changing this forces a new resource to be created."<br/>  vault_id         = "(Required) The ID of the Backup Vault within which the PostgreSQL Flexible Server Backup Instance should exist. Changing this forces a new resource to be created."<br/>  server_id        = "(Required) The ID of the source server. Changing this forces a new resource to be created."<br/>  backup_policy_id = "(Required) The ID of the Backup Policy."<br/>})) | <pre>map(object({<br/>    name             = string<br/>    location         = string<br/>    vault_id         = string<br/>    server_id        = string<br/>    backup_policy_id = string<br/>  }))</pre> | `null` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_blobstorage_backup_instance_resources"></a> [blobstorage_backup_instance_resources](#output_blobstorage_backup_instance_resources) | The Azure Data Protection Backup Instance resources for Blob Storage. |
| <a name="output_blobstorage_backup_instances"></a> [blobstorage_backup_instances](#output_blobstorage_backup_instances) | Map of Blob Storage Backup Instances with their IDs and names. |
| <a name="output_disk_backup_instance_resources"></a> [disk_backup_instance_resources](#output_disk_backup_instance_resources) | The Azure Data Protection Backup Disk Instance resources. |
| <a name="output_disk_backup_instances"></a> [disk_backup_instances](#output_disk_backup_instances) | Map of Disk Backup Instances with their IDs and names. |
| <a name="output_postgresql_backup_instance_resources"></a> [postgresql_backup_instance_resources](#output_postgresql_backup_instance_resources) | The Azure Data Protection Backup Instance resources for PostgreSQL Flexible Server. |
| <a name="output_postgresql_backup_instances"></a> [postgresql_backup_instances](#output_postgresql_backup_instances) | Map of PostgreSQL Flexible Server Backup Instances with their IDs and names. |
<!-- END_TF_DOCS -->
