---
version: 1.0.2
available_versions:
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.6.0
  - 0.5.3
---

<!-- BEGIN_TF_DOCS -->
# Disk Encryption Set module


## Overview

This terraform module creates a Disk Encryption Set and associated resources - A CMK, and a unique User-Assigned Managed Identity.

The Disk Encryption Set is an Azure resource introduced for simplifying the key management for managed disks.
When configured with a Disk Encryption Set (DES), Azure Disk Storage Server-Side Encryption (SSE) supports customer-managed keys (CMK).

## Prerequisites

- `Network Security Group`
- `Subnet`
- `Key Vault`
- `Private Endpoint` for Key Vault

## Guidance

#### Usage

- The module creates the Key Vault Key associated with the Disk Encryption Set main resource in the specified Key Vault.
- When a disk encryption set is created, a User-Assigned managed identity is created in Azure Active Directory (AD) and associated with the Disk Encryption Set.
- The module grants the managed identity permission to perform operations in the Key Vault by assigning the `"Key Vault Crypto Service Encryption User"` role to the managed identity.
- This module offers users the flexibility to either create a new `User Assigned` managed identity or utilize an existing one, if the user wants to create a new `User Assigned` Managed Identity then attributes `uai_principal_id`  and `identity.identity_ids` should be `null`.

#### Security Considerations

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-DES-IA_010 | Use a unique User Assigned Managed Identity for accessing Key Vault | Disk Encryption Set must enforce the use of a unique User Assigned Managed Identity to authenticate to Azure Key Vault (What) in the Key settings (How) to restrict the blast radius should the management of the identity be compromised (Why) | True | True | This control is implemented via `identity {}` block in `azurerm_disk_encryption_set` terraform resource. |
| 2. | AZU-DES-SC_010 | Must use a dedicated CMK for Disk Encryption Set Transparent Data Encryption that is persisted in a Premium SKU HSM backed Key Vault | Use a dedicated Disk Encryption Set LSEG managed encryption at rest key persisted in a Premium SKU HSM backed Key Vault (What) via the Key settings (How) in order should Microsoft's key management platform become compromised LSEG can revoke access to exfiltrated encrypted data (Why) | True | True  | Implemented using a dedicated azurerm_key_vault_key block in azurerm_disk_encryption_set terraform resource. |
| 3. | AZU-DES-SC_020 | Disk Encryption Set must enable Auto key rotation | Disk Encryption Set must enable Auto key rotation (What) via the Key settings (How) in order should the key become compromised LSEG can renew and update all effected virtual machines (Why) | True | True  | Implemented by adding rotation_policy block for azurerm_key_vault_key and setting `auto_key_rotation_enabled` to true inside azurerm_disk_encryption_set terraform resource. |

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json). |
| 5. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package.<br><br>[Virtual Machine RBAC](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles). |

## Changelog

- [azure-prdsvc-terraform-diskencryptionset](CHANGELOG.md)

## References

### Microsoft Docs

- [Server-side encryption of Azure Disk Storage](https://learn.microsoft.com/en-us/azure/virtual-machines/disk-encryption)

### Terraform Docs

- [azurerm_disk_encryption_set](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_encryption_set)

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
| [azurerm_disk_encryption_set.DES](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_encryption_set) | resource |
| [azurerm_key_vault_key.KEK](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_role_assignment.rbac](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.rbac1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_cmk_key_name"></a> [cmk_key_name](#input_cmk_key_name) | (optional) Key name to be used (max 127 chars) | `string` | `null` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 71 chars). | `string` | `null` | no |
| <a name="input_create_role_assignments"></a> [create_role_assignments](#input_create_role_assignments) | (Optional) Whether to create role assignments for Key Vault Crypto Service Encryption User. Set to false if the role assignments are managed externally. | `bool` | `true` | no |
| <a name="input_encryption_type"></a> [encryption_type](#input_encryption_type) | (Optional) The type of key used to encrypt the data of the disk. Changing this forces a new resource to be created. | `string` | `"EncryptionAtRestWithCustomerKey"` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_expiration_date"></a> [expiration_date](#input_expiration_date) | (Optional) Expiration date of the Key | `string` | `"2026-01-01T16:10:00Z"` | no |
| <a name="input_identity"></a> [identity](#input_identity) | (Optional) An identity block as defined below. Defaults to SystemAssigned managed identity.<br/>object({<br/>  type         = "(Optional) Specifies the type of Managed Service Identity that should be configured on this Disk Encryption Set. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned` (to enable both). Defaults to `SystemAssigned`."<br/>  identity_ids = "(Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Disk Encryption Set. This is required when `type` is set to `UserAssigned` or `SystemAssigned, UserAssigned`."<br/>}) | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | <pre>{<br/>  "identity_ids": null,<br/>  "type": "SystemAssigned"<br/>}</pre> | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_key_size"></a> [key_size](#input_key_size) | (Optional) Size of the Key | `number` | `2048` | no |
| <a name="input_key_type"></a> [key_type](#input_key_type) | (Optional) Type of the Key | `string` | `"RSA-HSM"` | no |
| <a name="input_key_vault_id"></a> [key_vault_id](#input_key_vault_id) | (Required) ID of the existing Key vault to store the DES Key Vault Key for Encryption. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_rotation_policy"></a> [rotation_policy](#input_rotation_policy) | (Optional) A rotation policy block as defined below<br/>object({<br/>  notify_before_expiry = "(Required) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>  time_before_expiry   = "(Required) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br/>  time_after_creation  = "(Optional) Rotate automatically at a duration after create as an ISO 8601 duration."<br/>  expire_after         = "(Required) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>}) | <pre>object({<br/>    notify_before_expiry = string<br/>    time_before_expiry   = string<br/>    time_after_creation  = optional(string, null)<br/>    expire_after         = string<br/>  })</pre> | <pre>{<br/>  "expire_after": "P365D",<br/>  "notify_before_expiry": "P358D",<br/>  "time_after_creation": null,<br/>  "time_before_expiry": "P7D"<br/>}</pre> | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_uai_principal_id"></a> [uai_principal_id](#input_uai_principal_id) | (Optional) Principal id of the User Assigned Identity which should be used to access the CMK encryption key in the Key Vault. This identity will be granted `Key Vault Crypto Service Encryption User` role on the Key vault. This must be the principal id of one of the `User Assigned Identities` assigned to the storage Account. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The ID of the created Disk Encryption Set. |
| <a name="output_key_vault_key_id"></a> [key_vault_key_id](#output_key_vault_key_id) | The Key Vault Key ID associated to the Disk Encryption Set. |
| <a name="output_name"></a> [name](#output_name) | The Name of the created Disk Encryption Set. |
| <a name="output_resource"></a> [resource](#output_resource) | The Disk Encryption Set resource. |
<!-- END_TF_DOCS -->
