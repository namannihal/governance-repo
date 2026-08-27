---
version: 1.0.0
available_versions:
  - 1.0.0
  - 0.6.0
  - 0.5.2
  - 0.5.1
  - 0.5.0
---

<!-- BEGIN_TF_DOCS -->
# Azure Backup Protected Item

## Overview

This terraform module creates the Backup Protected Item in the provided Recovery Services Vault to enable backup for VM or File Share .

## Prerequisites

- `Resource Group`, `Virtual Network`(To be called if not existing).
- `Subnet` to be used by the Private endpoint and the VM Network Interface IP Configs.
- `Network Security Group` to be associated with the Subnet.
- `Route Table` to be associated with the Subnet.
- `Keyvault` module to create a secret.
- `Privateendpoint` module to create a private connection to the Keyvault and Storge Account.
- `Role assignment` module to assign "Key Vault Secrets User" role to the client on the created keyvault.
- `Keyvault Secret` module to store the Password for Windows VM.
- `Disk Encryption` module to enable the encryption.
- `Windows Virtual Machine` module to use enable the backup for virtual machine.
- `Storage Account` , `File share` module to enable the file share backup.
- Optional modules and resources:
  - `User Assigned Identity` and `Proximity Placement Group` modules,
  - `time_sleep` resource block to wait for the secret to get created till private connection is registered in the Private DNS Zone and `random_password` resource block to generate admin_password for Windows VM.

## Guidance

#### Usage

- This module is using an existing recovery service vault for testing purposes. Due to the security controls of the recovery service vault, immutability should be `Enabled` or `Unlocked` when deploying the recovery service vault. To fully test the backup protection, the pipeline is unable to delete items due to immutability being enabled.
- The argument `protection_state` is not used in the code because bydefault Azure keeps `protection_state` as IRpending and based on the Backup, the status will change from IRPending > Protected.

#### Security Considerations

## Security Controls

Currently, as per LSEG Approved Backup Protected Item Security Requirements, there are no security controls for this product.

## Changelog

- [azure-prdsvc-terraform-backupprotecteditem](CHANGELOG.md)

## References

### Microsoft Docs

[Azure Backup VM ProtectedItem](https://learn.microsoft.com/en-us/azure/backup/backup-azure-vms-first-look-arm)

[Azure Backup FileShare ProtectedItem](https://learn.microsoft.com/en-us/azure/backup/backup-azure-files?tabs=backup-center)

### Terraform Docs

[Azure Backup VM ProtectedItem](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_protected_vm)

[Azure Backup FileShare ProtectedItem](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_protected_file_share)

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
| [azurerm_backup_container_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_container_storage_account) | resource |
| [azurerm_backup_protected_file_share.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_protected_file_share) | resource |
| [azurerm_backup_protected_vm.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_protected_vm) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_fileshare_backup_policy_id"></a> [fileshare_backup_policy_id](#input_fileshare_backup_policy_id) | (Optional for VM Backup) Specifies the ID of the backup policy to use. The policy must be an Azure File Share backup policy. | `string` | `null` | no |
| <a name="input_fs_backup_enabled"></a> [fs_backup_enabled](#input_fs_backup_enabled) | (Optional) Should Fileshare backup enabled or skip as per input. | `bool` | `true` | no |
| <a name="input_include_disk_luns"></a> [include_disk_luns](#input_include_disk_luns) | (Optional) A list of LUN IDs to include in protection. | `list(number)` | `[]` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_recovery_vault_name"></a> [recovery_vault_name](#input_recovery_vault_name) | (Required) Specifies the name of the Recovery Services Vault to use | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_source_file_share_name"></a> [source_file_share_name](#input_source_file_share_name) | (Optional for VM Backup) Specifies the name of the file share to backup. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_source_vm_id"></a> [source_vm_id](#input_source_vm_id) | (Required) Source VM ID of the virtual machine to protect. | `string` | n/a | yes |
| <a name="input_storage_account_id"></a> [storage_account_id](#input_storage_account_id) | (Optional for VM Backup) Specifies the ID of the storage account of the file share to backup. | `string` | `null` | no |
| <a name="input_vm_backup_enabled"></a> [vm_backup_enabled](#input_vm_backup_enabled) | (Optional) Should Virtual machine backup enabled or skip as per input. | `bool` | `true` | no |
| <a name="input_vm_backup_policy_id"></a> [vm_backup_policy_id](#input_vm_backup_policy_id) | (Optional) The ID of the Azure Backup policy to associate with the protected VM. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azurerm_backup_protected_file_share_id"></a> [azurerm_backup_protected_file_share_id](#output_azurerm_backup_protected_file_share_id) | The ID of the Azure Backup protected file share. |
| <a name="output_azurerm_backup_protected_file_share_resource"></a> [azurerm_backup_protected_file_share_resource](#output_azurerm_backup_protected_file_share_resource) | The Azure Backup Protected File Share Resource |
| <a name="output_azurerm_backup_protected_vm_id"></a> [azurerm_backup_protected_vm_id](#output_azurerm_backup_protected_vm_id) | The ID of the Azure Backup protected VM. |
| <a name="output_azurerm_backup_protected_vm_name"></a> [azurerm_backup_protected_vm_name](#output_azurerm_backup_protected_vm_name) | The Azure Backup protected VM Name |
| <a name="output_azurerm_backup_protected_vm_resource"></a> [azurerm_backup_protected_vm_resource](#output_azurerm_backup_protected_vm_resource) | The Azure Backup protected VM Resource |
| <a name="output_azurerm_storage_account_fileshare_name"></a> [azurerm_storage_account_fileshare_name](#output_azurerm_storage_account_fileshare_name) | The ID of the Azure Backup protected file share. |
<!-- END_TF_DOCS -->
