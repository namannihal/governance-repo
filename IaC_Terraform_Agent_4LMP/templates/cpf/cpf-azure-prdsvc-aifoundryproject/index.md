---
version: 1.3.0
available_versions:
  - 1.3.0
  - 1.2.3
  - 1.2.2
  - 1.2.1
  - 1.2.0
---

<!-- BEGIN_TF_DOCS -->
# AI Foundry Project module


## Overview

- This terraform module provisions an Azure AI Foundry project environment, including secure project connections, support for capability hosts, and flexible integration with Azure resources.

## Prerequisites

- An Azure AI Foundry account is required to deploy an AI Foundry project.
- A subnet in an existing virtual network.
- A Key Vault to enable Customer Managed Key Encryption.
- The Key Vault must allow access for the system assigned managed identity.
- The subnet used for network injection must exist and be properly delegated for Microsoft.App/environments to support the Agents service.

## Guidance

#### Usage

- To create multiple AI Foundry projects under an existing AI Foundry account, instantiate this module multiple times with different `instance` and `context` values, passing the same `parent_id` (the resource ID of the existing AI Foundry account). Each project will have its own managed identity (system-assigned or user-assigned), which is used for RBAC assignments to connected resources.
- Each project can define connections to a variety of Azure resources such as storage accounts, search services etc..,. The module supports flexible connection configuration, RBAC role assignments, and enables management of these resources within the project context.
- When redeploying AI Foundry with network injection after deletion, the delegated subnet may remain locked by the soft-deleted resource. The AI Foundry resource must be fully purged before the subnet can be reused for a new deployment. Attempting to deploy without purging will result in deployment failure.

#### Security Considerations

- After Foundry resource is deleted, another resource with the same name cannot be created for 48 hours unless the deleted resource is purged. The SPN must have `Microsoft.CognitiveServices/locations/resourceGroups/deletedAccounts/delete` permissions to purge resources, such as `Cognitive Services Contributor` or `Contributor`. When using `Contributor` role to purge a resource, the role must be assigned at the subscription level. Soft-deleted resources can be purged using the Azure Portal, Azure PowerShell , or Azure CLI.

#### Additional Information

- To proceed with AIFoundry deployment, users must obtain an exemption for control ID AZU-AIF-SC_040 by reaching out to the Cyber team.

## Security Controls

- Security controls are not implemented at the project module level.  
- All relevant security controls are enforced at the Azure AI Foundry account level, in accordance with organizational and platform standards.

## Changelog

- [azure-prdsvc-terraform-aifoundryproject](CHANGELOG.md)

## References

### Microsoft Docs

- [Azure AI Foundry](https://learn.microsoft.com/en-us/azure/ai-foundry/what-is-azure-ai-foundry)
- [Azure AI Foundry Project](https://learn.microsoft.com/en-us/azure/ai-foundry/how-to/create-projects?tabs=ai-foundry)
- [Customer Managed Key](https://learn.microsoft.com/en-us/azure/ai-foundry/concepts/encryption-keys-portal)
- [OpenAI Models](https://learn.microsoft.com/en-us/azure/ai-services/openai/concepts/models)

### Terraform Docs

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0 |
| <a name="requirement_azapi"></a> [azapi](#requirement_azapi) | >= 2.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm) | >= 4.33 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azapi"></a> [azapi](#provider_azapi) | >= 2.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | >= 4.33 |
| <a name="provider_time"></a> [time](#provider_time) | n/a |

## Resources

| Name | Type |
|------|------|
| [azapi_resource.ai_foundry_project](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.capability_host](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.connection](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) | resource |
| [azurerm_role_assignment.cosmosdb_operator](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.search_index_data_contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.search_service_contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.storage_blob_data_contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [time_sleep.wait_project_provisioning](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [time_sleep.wait_rbac_propagation_60s](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_capability_host"></a> [capability_host](#input_capability_host) | (Optional) Capability host configuration for AI Foundry project.<br/>object({<br/>  capability_host_kind        = "(Required) The kind of capability host."<br/>  vector_store_connections    = "(Required) List of vector store connection names. Must not be empty if provided."<br/>  storage_connections         = "(Required) List of storage connection names. Must not be empty if provided."<br/>  thread_storage_connections  = "(Required) List of thread storage connection names. Must not be empty if provided."<br/>}) | <pre>object({<br/>    capability_host_kind       = string<br/>    vector_store_connections   = list(string)<br/>    storage_connections        = list(string)<br/>    thread_storage_connections = list(string)<br/>  })</pre> | `null` | no |
| <a name="input_capability_host_name"></a> [capability_host_name](#input_capability_host_name) | (Optional) The name of the capability host resource. | `string` | `"caphostproject"` | no |
| <a name="input_connection_principal_id"></a> [connection_principal_id](#input_connection_principal_id) | (Optional) UAMI object ID used for project connection RBAC role assignments. | `string` | n/a | yes |
| <a name="input_connections"></a> [connections](#input_connections) | (Optional) Connections configurations for AI Foundry project.<br/>map(object({<br/>  category     = "(Required) The category of the connection."<br/>  target       = "(Required) The target endpoint of the connection."<br/>  authtype     = "(Required) The authentication type for the connection."<br/>  resource_id  = "(Required) The resource ID of the Azure resource to connect to."<br/>  is_shared_to_all = "(Optional) Whether a specific project connection can be accessed across all projects. Defaults to true"<br/>  api_key      = "(Optional) API key for ApiKey authType. When provided, module sends credentials.key."<br/>  credentials  = "(Optional) Credentials object for the selected authType, as key/value pairs."<br/>})) | <pre>map(object({<br/>    category         = string<br/>    target           = string<br/>    authtype         = any<br/>    resource_id      = string<br/>    is_shared_to_all = optional(bool, true)<br/>    api_key          = optional(string)<br/>    credentials      = optional(map(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_create_role_assignment_blob_data_contributor"></a> [create_role_assignment_blob_data_contributor](#input_create_role_assignment_blob_data_contributor) | (Optional) Whether to create a role assignment to the UAMI on storage account for connections | `bool` | `true` | no |
| <a name="input_create_role_assignment_cosmosdb_operator"></a> [create_role_assignment_cosmosdb_operator](#input_create_role_assignment_cosmosdb_operator) | (Optional) Whether to create a role assignment to the UAMI on cosmos db for connections | `bool` | `true` | no |
| <a name="input_create_role_assignment_search_index_data_contributor"></a> [create_role_assignment_search_index_data_contributor](#input_create_role_assignment_search_index_data_contributor) | (Optional) Whether to create a role assignment to the UAMI on search service for connections | `bool` | `true` | no |
| <a name="input_create_role_assignment_search_service_contributor"></a> [create_role_assignment_search_service_contributor](#input_create_role_assignment_search_service_contributor) | (Optional) Whether to create a role assignment to the UAMI on search service for connections | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input_description) | (Required) Description for the AI Foundry project. | `string` | n/a | yes |
| <a name="input_displayname"></a> [displayname](#input_displayname) | (Required) Display name for the AI Foundry project. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_identity"></a> [identity](#input_identity) | (Required) An identity block supports the following:<br/>object({<br/>  type         = "(Required) Specifies the type of Managed Service Identity that should be configured on this resource. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned."<br/>  identity_ids = "(Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this resource."<br/>}) | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | <pre>{<br/>  "identity_ids": null,<br/>  "type": "SystemAssigned"<br/>}</pre> | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_key_vault_tags"></a> [key_vault_tags](#input_key_vault_tags) | (Optional) Key Vault related tags to be set on key vault child resources. | `map(any)` | `{}` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_parent_id"></a> [parent_id](#input_parent_id) | (Required) The resource ID of the AI Foundry account in which to create the project. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_principal_ids"></a> [principal_ids](#input_principal_ids) | (Optional) Set of principal IDs (user, group, or service principal) to assign the Azure AI User role. | `set(string)` | `[]` | no |
| <a name="input_sku"></a> [sku](#input_sku) | (Required) Specifies the SKU Name for this AI Services Account. Possible values are F0, F1, S0, S, S1, S2, S3, S4, S5, S6, P0, P1, P2, E0 and DC0. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The ID of the created Azure AI Foundry Project resource. |
| <a name="output_internal_id"></a> [internal_id](#output_internal_id) | The internal ID (GUID) of the Azure AI Foundry project used for resource namespacing. |
| <a name="output_name"></a> [name](#output_name) | The name of the created Azure AI Foundry Project resource. |
| <a name="output_resource"></a> [resource](#output_resource) | The Azure AI Foundry Project resource object. |
| <a name="output_user_assigned_identities"></a> [user_assigned_identities](#output_user_assigned_identities) | The user-assigned managed identities with their principal IDs and client IDs. |
<!-- END_TF_DOCS -->
