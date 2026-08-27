---
version: 1.0.3
available_versions:
  - 1.0.3
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.1.1
---

<!-- BEGIN_TF_DOCS -->
# Azure App Configuration module


## Overview

This Terraform module creates and configures the **Azure App Configuration**.

Azure App Configuration provides a service to centrally manage application settings and feature flags.This makes it easier to centrally configure distributed applications.

App Configuration can be used to store all application settings in a central place with controlled access and RBAC. App Configuration is not intended to store secrets, Key Vault is the service for this purpose.

For more information, refer to the [Azure App Configuration documentation](https://learn.microsoft.com/en-us/azure/azure-app-configuration/).

## Prerequisites

- Ensure that the following prerequisites are met:

  - `Resource Group`
  - `Virtual Network`
  - `Network Security Group`
  - `Subnet`
  - `Key Vault`
  - `Private Endpoint` for Key Vault

## Guidance

#### Usage

- `SKU` is set to `Premium` to leverage advanced features like private link support, increased throughput, and enhanced security.
- `local_auth_enabled` is always set to `false` to disable local authentication and enforce Azure Active Directory-based access for improved security and compliance.
- `public_network_access` is always `disabled` to ensure the App Configuration resource is accessed exclusively via private endpoint, eliminating exposure to the public internet.
- `private endpoint` is created for the configurationStores group to enable secure, private connectivity to the App Configuration resource.
- `time_sleep` resource block is added during validation pipeline testing to allow sufficient time for the App Configuration resource to complete its private endpoint configuration before proceeding.
- `Customer Managed Key (CMK)` is enabled using the encryption block to provide encryption-at-rest with customer control via Azure Key Vault.
- The `identity` configured for the App Configuration resource is UserAssigned, ensuring secure access to the Key Vault and other dependent resources using a managed identity.

- For a complete feature overview, refer to the [Azure App Configuration documentation](https://learn.microsoft.com/en-us/azure/azure-app-configuration/).

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1      | AZU-APPC-IA_010   | Entra ID authentication only must be used | Entra ID authentication only must be used for App Configuration (What) within Access settings (How) in order to use modern robust and less prone to compromise authentication methods embedded within Entra ID (Why) | True | True | Implemented using `local_auth_enabled = false`|
| 2      | AZU-APPC-AC_010   | Azure App Configuration must disable Public Network Access | Azure App Configuration must disable Public Network Access (What) using private endpoints only (How) to ensure secure network isolation and prevent unauthorized access (Why) | True | True | Implemented using `public_network_access = Disabled` |
| 3      | AZU-APPC-AU_010   | Send all security and audit diagnostic log categories to a central SOC Log Analytics workspace | App Configuration must send all security and audit diagnostic logs (What) to a central SOC Log Analytics workspace (How) to enable centralized monitoring and security analysis (Why) | False | False | Diagnostic settings not implemented in module |
| 4      | AZU-APPC-AU_030   | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval | App Configuration diagnostic logs sent to partner solutions (What) must undergo CyberSecurity risk assessment and approval (How) to ensure data protection and compliance requirements (Why) | False | False | Policy control - not module implementation |
| 5      | AZU-APPC-SC_010   | Must use a dedicated CMK for App Configuration encryption key management that is persisted in a Key Vault premium SKU | App Configuration must use a dedicated Customer Managed Key (What) persisted in Key Vault premium SKU (How) to ensure enterprise-grade encryption key management and security (Why) | True | False | This control is implemented via encryption block |
| 6      | AZU-APPC-SC_020   | Azure App Deployment must not be able to corrupt the centrally managed private link private DNS zones when making a private endpoint for Azure App Config | App Configuration private endpoint deployment (What) must not corrupt centrally managed private DNS zones (How) to maintain DNS integrity and prevent service disruption (Why) | False | False | This control will be implemented via policy.|

## Changelog

- [azure-prdsvc-terraform-appconfiguration](CHANGELOG.md)

## References

### Microsoft Docs

[Azure App Configuration](https://learn.microsoft.com/en-us/azure/azure-app-configuration/)

### Terraform Docs

[Azure App Configuration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/app_configuration)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0 |
| <a name="requirement_azapi"></a> [azapi](#requirement_azapi) | >=2.2.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm) | >=4.33 |
| <a name="requirement_time"></a> [time](#requirement_time) | >=0.12.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | >=4.33 |
| <a name="provider_time"></a> [time](#provider_time) | >=0.12.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_app_configuration.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_configuration) | resource |
| [azurerm_key_vault_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_role_assignment.appconf_dataowner](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.this_cmk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [time_sleep.wait_for_role_appconf_dataowner](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_cmk_key_name"></a> [cmk_key_name](#input_cmk_key_name) | (optional) Key name to be used (max 127 chars) | `string` | `null` | no |
| <a name="input_cmk_rotation_policy"></a> [cmk_rotation_policy](#input_cmk_rotation_policy) | (Optional) A rotation policy block as defined below<br/>object({<br/>  notify_before_expiry = "(Optional) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>  time_before_expiry   = "(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br/>  time_after_creation  = "(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br/>  expire_after         = "(Optional) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>}) | <pre>object({<br/>    notify_before_expiry = string<br/>    time_before_expiry   = string<br/>    time_after_creation  = optional(string, null)<br/>    expire_after         = string<br/>  })</pre> | <pre>{<br/>  "expire_after": "P365D",<br/>  "notify_before_expiry": "P358D",<br/>  "time_after_creation": null,<br/>  "time_before_expiry": "P7D"<br/>}</pre> | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_create_role_assignment"></a> [create_role_assignment](#input_create_role_assignment) | Whether to create the Key Vault Crypto Service Encryption User role assignment. Set to false if the role assignment already exists. | `bool` | `true` | no |
| <a name="input_customer_managed_key"></a> [customer_managed_key](#input_customer_managed_key) | (Required) An customer_managed_key block as defined below<br/>object({<br/>  key_vault_id                      = "(Required) The resource ID of the Key Vault where the Key Vault Key resides."<br/>  expiration_date                   = "(Required) Expiration UTC datetime (Y-m-d'T'H:M:S'Z')."<br/>  identity_principal_id             = "(Required) Principal id of the User Assigned Identity which should be used to access the CMK encryption key in the Key Vault. This identity will be granted `Key Vault Crypto Service Encryption User` role on the Key vault. This must be the principal id of one of the `User Assigned Identities` assigned to the storage Account."<br/>  identity_client_id                = "(Required) Client id of the User Assigned Identity which should be used to access the CMK encryption key in the Key Vault."<br/>  }) | <pre>object({<br/>    key_vault_id          = string<br/>    expiration_date       = string<br/>    identity_principal_id = string<br/>    identity_client_id    = string<br/>  })</pre> | n/a | yes |
| <a name="input_data_plane_proxy_authentication_mode"></a> [data_plane_proxy_authentication_mode](#input_data_plane_proxy_authentication_mode) | (Required) The data plane proxy authentication mode. Possible values are `Local` and `Pass-through`.`Local` mode validates authentication locally within the App Configuration service, while `Pass-through` mode forwards authentication to the upstream service. | `string` | `"Pass-through"` | no |
| <a name="input_data_plane_proxy_private_link_delegation_enabled"></a> [data_plane_proxy_private_link_delegation_enabled](#input_data_plane_proxy_private_link_delegation_enabled) | (Required) Whether data plane proxy private link delegation is enabled. Defaults to `true`. When enabled, this allows the App Configuration service to delegate private link connections to downstream services, enabling secure connectivity through private endpoints while maintaining network isolation. This is particularly useful in scenarios where the App Configuration needs to access other Azure services through private links. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_identity"></a> [identity](#input_identity) | (Required) An identity block as defined below<br/>object({<br/>  type         = "(Required) Specifies the type of Managed Service Identity that should be configured on this app configuration. Possible values are 'UserAssigned', or 'SystemAssigned, UserAssigned' (to enable both)."<br/>  identity_ids = "(Optional) A list of User Assigned Managed Identity IDs to be assigned to this app configuration."<br/>}) | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_key_vault_tags"></a> [key_vault_tags](#input_key_vault_tags) | (Optional) Key Vault related tags to be set on key vault child resources. | `map(any)` | `{}` | no |
| <a name="input_local_auth_enabled"></a> [local_auth_enabled](#input_local_auth_enabled) | (Required) Whether local authentication methods is enabled. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_public_network_access"></a> [public_network_access](#input_public_network_access) | (Required) The Public Network Access setting of the App Configuration. Possible values are Enabled and Disabled. | `string` | `"Disabled"` | no |
| <a name="input_purge_protection_enabled"></a> [purge_protection_enabled](#input_purge_protection_enabled) | (Optional) Whether Purge Protection is enabled. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_replica"></a> [replica](#input_replica) | (Optional) A list of replica blocks to create geo-replicated instances of the App Configuration store for enhanced availability.<br/>object({<br/>  name         = "(Required) The name of the replica. Changing this forces a new resource to be created."<br/>  location     = "(Required) The location of the replica."<br/>}) | <pre>list(object({<br/>    name     = string<br/>    location = string<br/>  }))</pre> | `[]` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input_sku) | (Required) The SKU name of the App Configuration. Possible values are free, developer, standard and premium. Defaults to free.Downgrading will force a new resource to be created. | `string` | `"premium"` | no |
| <a name="input_soft_delete_retention_days"></a> [soft_delete_retention_days](#input_soft_delete_retention_days) | (Optional) The number of days that items should be retained for once soft-deleted. This field only works for `standard` sku. This value can be between `1 and 7` days. Defaults to 7. Changing this forces a new resource to be created. | `number` | `7` | no |
| <a name="input_spn_object_id"></a> [spn_object_id](#input_spn_object_id) | (Optional) The object ID of the service principal. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The Resource ID of the azure app configuration. |
| <a name="output_name"></a> [name](#output_name) | The Name of the azure app configuration. |
| <a name="output_resource"></a> [resource](#output_resource) | The azure app configuration resource. |
<!-- END_TF_DOCS -->
