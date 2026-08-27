---
version: 3.1.3
available_versions:
  - 3.1.3
  - 3.1.2
  - 3.1.1
  - 3.1.0
  - 3.0.3
---

<!-- BEGIN_TF_DOCS -->
# AI Foundry module


## Overview

- This terraform module provisions Azure AI Foundry including optional agent injection, CMK encryption and Open AI model deployment to support AI capabilities. Foundry project is provisioned by another product <azure-prdsvc-terraform-aifoundryproject>.

## Prerequisites

- A subnet with proper delegation in an existing virtual network (required only if using Agents functionality).
- A Key Vault to enable Customer Managed Key Encryption.
- The Key Vault must allow access for the managed identity (system-assigned or user-assigned).
- The subnet used for network injection must exist and be properly delegated for Microsoft.App/environments to support the Agents service.
- Both AI Foundry and Agent subnets must use IP ranges within Class A private address space. Public IP address ranges are not allowed within LSEG. For detailed configuration guidance, refer to (https://learn.microsoft.com/en-us/azure/ai-foundry/agents/how-to/virtual-networks?view=foundry-classic#:~:text=Subnet%20IP%20address%20limitation).

## Guidance

#### Usage

- All Foundry workspace resources should be in the same region as the VNet, including CosmosDB, Storage Account, AI Search, Foundry Account, Project, and Managed Identity. However, you may choose to deploy your model to a different region.
- Customer Managed Key (CMK) encryption for AI Foundry supports both System-Assigned and User-Assigned Managed Identities. The managed identity must be granted appropriate Key Vault permissions (`Key Vault Crypto Officer` and `Key Vault Crypto Service Encryption User` roles).
- The required private endpoints should be provisioned using the private endpoints module. This will automatically create "A" records in the following private DNS zones:  
  - privatelink.cognitiveservices.azure.com  
  - privatelink.services.ai.azure.com  
  - privatelink.openai.azure.com
- After Foundry resource is deleted, another resource with the same name cannot be created for 48 hours unless the deleted resource is purged. Soft-deleted resources can be purged using the Azure Portal, Azure PowerShell , or Azure CLI.

#### Usage-Agents

- Azure AI Foundry feature availability may vary by region.
- Class A subnet ranges for Agents are available in select regions. Supported regions include: Australia East, Brazil South, Canada East, East US, East US 2, France Central, Germany West Central, Italy North, Japan East, South Africa North, South Central US, South India, Spain Central, Sweden Central, UAE North, UK South, West Europe, West US, West US 2, West US 3.
- For AI Foundry, agent delegation to connect to private resources, Microsoft recommends creating subnet delegation within Class A (10.0.0.0/16) address ranges. While Class B (172.16.0.0/12) and Class C (192.168.0.0/16) subnet support for Agents is generally available across all supported regions, these address ranges are not permitted within LSEG due to conflicts with AWS environments and on-premises infrastructure.
- The recommended size of the delegated Agent subnet is /27 (32 addresses) due to the delegation of the subnet to Microsoft.App/environment.
- If agents require connectivity to private resources, subnet delegation must be configured with a routable VNet. Users must obtain approval from the Platform Engineering team, with the help of an SRE request.
- Subnets can be delegated to non-routable VNets without special approvals; however, agents deployed in this configuration will be unable to connect to private resources.
- If there is no requirement to use Agents, Azure AI Foundry can be deployed in any supported region without specifying VNet injection or subnet delegation.
- When redeploying AI Foundry with network injection after deletion, the delegated subnet may remain locked by the soft-deleted resource. The AI Foundry resource must be fully purged before the subnet can be reused for a new deployment. Attempting to deploy without purging will result in deployment failure.

#### Network Egress Requirements

- The Foundry agent service requires outbound connectivity to specific Azure and Microsoft endpoints.

- **Azure Firewall Rules**: The following rules must be configured for outbound traffic:

  | Rule Type | Rule Name | Source | Port | Protocol | Destination | Action |
  |-----------|-----------|--------|------|----------|-------------|--------|
  | Network Rule | Allow-AI-foundry-NetworkRules | Routable-Subnet (e.g. 10.202.154.224/27) | 443 | TCP | `MicrosoftContainerRegistry`, `AzureActiveDirectory` | Allow |
  | Application Rule | Allow-AI-foundry-ApplicationRules | Routable-Subnet (e.g. 10.202.154.224/27) | 443 | HTTPS | `mcr.microsoft.com`, `*.data.mcr.microsoft.com`, `*.azurecontainerapps.io`, `*.ext.azurecontainerapps.dev`, `login.microsoftonline.com`, `*.identity.azure.net` | Allow |

- The rules in the table above represent the baseline required endpoints, but they are not exhaustive. Foundry Agent service relies on Azure Container Apps and other Azure platform services that use dynamic and region-specific endpoints.
- **Recommended Approach**:
  - Configure the Azure Firewall rules listed above
  - Use service tags where applicable
  - Monitor Azure Firewall logs and allow additional endpoints observed during runtime
- **How to confirm completeness in the environment**:
  - Deploy or create the Foundry agent
  - Check Azure Firewall logs
  - Look for `Action: Deny` and new FQDNs
  - Add any newly observed FQDNs to the Azure Firewall allow rules

- Refer to the Wiki for AppConn request creation process to allow Firewall rules [documentation](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-aifoundry/-/wikis/Process-to-create-AppConn-request)

#### RBAC and Foundry Portal Accessibility

- **Azure AI User Role**: The `principal_ids` variable allows assignment of the Azure AI User role to specified users, groups, or service principals. This role grants:
  - Reader access to AI projects and AI accounts.
  - Data actions for AI projects.
  - Access to the AI Foundry Portal interface.

- **ZPA Onboarding Requirement**: ZPA (Zscaler Private Access) onboarding is mandatory for accessing the AI Foundry Portal. Without proper ZPA configuration, users will not be able to utilize the complete functionality of the AI Foundry portal interface. Refer to the Wiki for ZPA onboarding process [documentation](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-aifoundry/-/wikis/Process-to-onboard-Zscaler-Private-Access)

#### Security Considerations

- Azure OpenAI Services must use LSEG-approved OpenAI models. If a model is not currently allowed, a policy exemption for Control ID: AZU-AIF-SC_030 must be requested with the Cyber team. See https://lsegroup.sharepoint.com/sites/LSEG-engineering/SitePages/Approved-Large-Language-Models.aspx for approved models. The models listed in the document are approved for general development and test use only.
- Not all model/SKU combinations are available in every Azure region. Before deploying, always validate that your selected model and SKU are supported in your target region. See https://learn.microsoft.com/en-us/azure/ai-services/openai/concepts/models for details.
- Local authentication methods for AI Foundry are disabled; therefore, keys cannot be used to access the Azure AI Foundry.

#### Additional Information

- To proceed with AIFoundry deployment, users must obtain an exemption for control ID AZU-AIF-SC_040 by reaching out to the Cyber team.
- The SPN must have `Microsoft.CognitiveServices/locations/resourceGroups/deletedAccounts/delete` permissions to purge resources, such as `Cognitive Services Contributor` or `Contributor`. Both roles must be assigned at the subscription level to access the purge functionality; assignment at the resource or resource group level is not sufficient. Reach out to the SRE team to grant the required RBAC role assignment at the subscription level.

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-AIF-IA_010 | AI Foundry must have local authentication methods disabled  | AI Foundry must have local authentication methods disabled (What) within Keys and Endpoint (How) in order to use modern robust and less prone to compromise authentication methods embedded within Entra ID (Why)  | True | True | This control is implemented via the `disable_local_auth` variable. |
| 2. | AZU-AIF-IA_020 | AI Foundry must use a Managed Identity for accessing Azure Resources | AI Foundry must enforce the use of a Managed Identity to authenticate to Azure resources where this is supported (What) within target service access control settings (How) in order to remove the need to store credentials (Why)  | True | True | This control is implemented by setting `identity` block.  |
| 3. | AZU-AIF-AC_010 | AI Foundry must disable Public Network Access | AI Foundry must enforce a network guardrail (What) within Network settings (How) in order to prevent unauthorised access and data exposure to the internet (Why)  | True | True | This control is implemented by setting `publicNetworkAccess = Disabled`.  |
| 4. | AZU-AIF-AU_010 | Send all security and audit diagnostic log categories to a central SOC Log Analytics workspace | AI Foundry must send all security and audit diagnostic logs to a central SOC Log Analytics workspace (What) within Diagnostic settings (How) in order to support a security investigation after a security incident (Why)  | False | False | This control is implemented via policy. |
| 5. | AZU-AIF-AU_020 | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval (What) within Diagnostic settings (How) in order to prevent sensitive data leakage to third parties outside of LSEG control (Why)  | False | False | This control is implemented via policy. |
| 6. | AZU-AIF-SC_010 | Must use a dedicated CMK for AI Foundry encryption key management that is persisted in a Key Vault premium SKU | Use a dedicated AI Foundry LSEG managed encryption at rest key persisted in a Key Vault premium SKU (What) within Encryption (How) in order should Microsoft's key management platform become compromised LSEG can revoke access to exfiltrated encrypted data (Why) | True | True | This control is implemented by setting `encryption` block. |
| 7. | AZU-AIF-SC_020 | Azure App Deployment must not be able to corrupt the centrally managed private link private DNS zones when making a private endpoint for AI Foundry | AI Foundry must have an Azure DeployIfNotExists policy to update the centrally managed private link private DNS zones with its private A record (What) via Policy to management group mapping (How) to ensure there is no ability for the Azure App Deployment team to have authorisation over these zones that could allow them to corrupt this file and impact service availability (Why)  | False | False | This control is implemented via policy. |
| 8. | AZU-AIF-SC_030 | AI Foundry must only use LSEG approved models for Agents and Fine-tuning | AI Foundry must only use LSEG approved models for Agents and Fine-tuning (What) in AI Foundry, Agents/Fine-tuning (How) in order to prevent the use of models posing a risk to LSEG (Why)  | False | False | This control is implemented via Policy. |
| 9. | AZU-AIF-SC_040 |Azure AI Foundry must not be created without CyberSecurity approval | Azure AI Foundry must not be created without CyberSecurity approval (What) by Azure policy assignment (How) to control the use of AI Foundry while issues, approved features, and processes are being defined (Why)  | False | False | This control is implemented via Policy. |

## Changelog

- [azure-prdsvc-terraform-aifoundry](CHANGELOG.md)

## References

### Microsoft Docs

- [Azure AI Foundry](https://learn.microsoft.com/en-us/azure/ai-foundry/what-is-azure-ai-foundry)
- [Customer Managed Key](https://learn.microsoft.com/en-us/azure/ai-foundry/concepts/encryption-keys-portal)
- [OpenAI Models](https://learn.microsoft.com/en-us/azure/ai-services/openai/concepts/models)

### Terraform Docs

- [azurerm_cognitive_account](https://registry.terraform.io/providers/hashicorp/azurerm/4.50.0/docs/resources/cognitive_account)

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
| [azapi_resource.ai_foundry](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource_action.ai_foundry_keys](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource_action) | resource |
| [azurerm_cognitive_deployment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_deployment) | resource |
| [azurerm_key_vault_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_role_assignment.cmk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.spn_owner](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.spn_user](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [time_sleep.wait_for_rbac_propagation](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_key_vault_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_key) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_cmk_name"></a> [cmk_name](#input_cmk_name) | (optional) Customer managed key name to be used (max 127 chars) | `string` | `null` | no |
| <a name="input_cmk_rotation_policy"></a> [cmk_rotation_policy](#input_cmk_rotation_policy) | (Optional) A rotation policy block as defined below<br/>object({<br/>  notify_before_expiry = "(Optional) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>  time_before_expiry   = "(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br/>  time_after_creation  = "(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br/>  expire_after         = "(Optional) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>}) | <pre>object({<br/>    notify_before_expiry = string<br/>    time_before_expiry   = string<br/>    time_after_creation  = optional(string, null)<br/>    expire_after         = string<br/>  })</pre> | <pre>{<br/>  "expire_after": "P365D",<br/>  "notify_before_expiry": "P358D",<br/>  "time_after_creation": null,<br/>  "time_before_expiry": "P7D"<br/>}</pre> | no |
| <a name="input_cognitive_deployments"></a> [cognitive_deployments](#input_cognitive_deployments) | (Optional) cognitive_deployments block supports below values:<br/>map(object({<br/>  deployment_name            = "(Required) The name of the Deployment. Changing this forces a new resource to be created."<br/>  model_format               = "(Optional) The format of the Cognitive Services Account Deployment model. Changing this forces a new resource to be created. Possible values can be found by running 'az cognitiveservices account list-models'. Available values may include models from AI21 Labs, Black Forest Labs, Cohere, Core42, DeepSeek, Meta, Microsoft, Mistral AI, OpenAI, and xAI. Defaults to 'OpenAI'."<br/>  model_name                 = "(Required) The name of the Deployment model. Example : gpt-35-turbo, gpt-35-turbo-instruct, gpt-4, gpt-4-32k, text-embedding-3-small, text-embedding-3-large, text-embedding-ada-002, gpt-35-turbo-16k, gpt-4o, gpt-4o-mini, gpt-4.1. Changing this forces a new resource to be created."<br/>  model_version              = "(Optional) The version of Deployment model. If version is not specified, the default version of the model at the time will be assigned."<br/>  dynamic_throttling_enabled = "(Optional) Whether dynamic throttling is enabled."<br/>  sku = "(Required) SKU block supports below values:<br/>    object({<br/>    name     = "(Required) The name of the SKU. Possible values include Standard, DataZoneBatch, DataZoneStandard, DataZoneProvisionedManaged, GlobalBatch, GlobalProvisionedManaged, GlobalStandard, and ProvisionedManaged. Changing this forces a new resource to be created."<br/>    tier     = "(Optional) Possible values are Free, Basic, Standard, Premium, Enterprise. This property is required only when multiple tiers are available with the SKU name. Changing this forces a new resource to be created."<br/>    size     = "(Optional) The SKU size. When the name field is the combination of tier and some other value, then that can be captured here. Changing this forces a new resource to be created."<br/>    family   = "(Optional) If the service has different generations of hardware, for the same SKU, then that can be captured here. Changing this forces a new resource to be created."<br/>    capacity = "(Optional) Tokens-per-Minute (TPM). The unit of measure for this field is in the thousands of Tokens-per-Minute. Defaults to 1 which means that the limitation is 1000 tokens per minute. If the resources SKU supports scale in/out then the capacity field should be included in the resources' configuration. If the scale in/out is not supported by the resources SKU then this field can be safely omitted."<br/>  })<br/>})) | <pre>map(object({<br/>    deployment_name            = string<br/>    model_format               = optional(string, "OpenAI")<br/>    model_name                 = string<br/>    model_version              = optional(string)<br/>    dynamic_throttling_enabled = optional(bool)<br/>    sku = object({<br/>      name     = string<br/>      tier     = optional(string)<br/>      size     = optional(string)<br/>      family   = optional(string)<br/>      capacity = optional(number, 1)<br/>    })<br/>  }))</pre> | `{}` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_create_role_assignment_aiconnections"></a> [create_role_assignment_aiconnections](#input_create_role_assignment_aiconnections) | (Optional) Whether to create a role assignment to the service identity to allow proper resource deletion when connections are present. | `bool` | `true` | no |
| <a name="input_create_role_assignment_cmk"></a> [create_role_assignment_cmk](#input_create_role_assignment_cmk) | (Optional) Whether to create a role assignment to the service identity to allow access to the key vault keys. | `bool` | `true` | no |
| <a name="input_create_role_assignment_spn_owner"></a> [create_role_assignment_spn_owner](#input_create_role_assignment_spn_owner) | (Optional) Whether to create a role assignment to the SPN to allow owner access to the AI Foundry resource. | `bool` | `true` | no |
| <a name="input_customer_managed_key"></a> [customer_managed_key](#input_customer_managed_key) | (Required) An customer_managed_key block as defined below<br/>object({<br/>  key_vault_id          = "(Required) The resource ID of the Key Vault where the Key Vault Key resides."<br/>  key_vault_uri         = "(Required) The URI of the Key Vault where the Key Vault Key resides."<br/>  expiration_date       = "(Required) Expiration UTC datetime (Y-m-d'T'H:M:S'Z')."<br/>  identity_principal_id = "(Required) The principal ID (object ID) of the User-Assigned Managed Identity for role assignments."<br/>  identity_client_id    = "(Required) The client ID (application ID) of the User-Assigned Managed Identity for encryption."<br/>}) | <pre>object({<br/>    key_vault_id          = string<br/>    key_vault_uri         = string<br/>    expiration_date       = string<br/>    identity_principal_id = string<br/>    identity_client_id    = string<br/>  })</pre> | n/a | yes |
| <a name="input_customsubdomainname"></a> [customsubdomainname](#input_customsubdomainname) | (Required) The subdomain name used for token-based authentication. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_disable_local_auth"></a> [disable_local_auth](#input_disable_local_auth) | (Optional) Specifies whether local authentication is disabled for the Azure AI Foundry resource. Defaults to true as mandated by security control AZU-AIF-IA_010. Setting this to false requires a Cyber exemption. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_identity"></a> [identity](#input_identity) | (Required) An identity block supports the following:<br/>object({<br/>  type         = "(Required) Specifies the type of Managed Service Identity that should be configured on this resource. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned."<br/>  identity_ids = "(Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this resource."<br/>}) | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | <pre>{<br/>  "identity_ids": null,<br/>  "type": "SystemAssigned"<br/>}</pre> | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_key_vault_tags"></a> [key_vault_tags](#input_key_vault_tags) | (Optional) Key Vault related tags to be set on key vault child resources. | `map(any)` | `{}` | no |
| <a name="input_kind"></a> [kind](#input_kind) | (Required) Kind of the resource. For AI Services Account, only 'AIServices' is valid. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_network_injections"></a> [network_injections](#input_network_injections) | (Optional) Controls the Network Injections on this resource. The following properties can be specified:<br/>object({<br/>  subnet_id                         = (Required) Full resource id of the Subnet resource.<br/>  scenario                          = (Required) The scenario for the network injection. Only `agent` is supported.<br/>}) | <pre>object({<br/>    subnet_id = string<br/>    scenario  = string<br/>  })</pre> | `null` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_principal_ids"></a> [principal_ids](#input_principal_ids) | (Optional) Set of principal IDs (user, group, or service principal) to assign the Azure AI User role. | `set(string)` | `[]` | no |
| <a name="input_projectmanagementenabled"></a> [projectmanagementenabled](#input_projectmanagementenabled) | (Optional) Specifies whether this resource support project management as child resources, used as containers for access management, data isolation and cost in AI Foundry. | `bool` | `true` | no |
| <a name="input_rai_policy_name"></a> [rai_policy_name](#input_rai_policy_name) | (Optional) The name of RAI policy. | `string` | `null` | no |
| <a name="input_resource_group_id"></a> [resource_group_id](#input_resource_group_id) | (Required) The resource ID of the Resource Group in which to create the resource. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input_sku) | (Required) Specifies the SKU Name for this AI Services Account. Possible values are F0, F1, S0, S, S1, S2, S3, S4, S5, S6, P0, P1, P2, E0 and DC0. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_version_upgrade_option"></a> [version_upgrade_option](#input_version_upgrade_option) | (Optional) Deployment model version upgrade option. Possible values are OnceNewDefaultVersionAvailable, OnceCurrentVersionExpired, and NoAutoUpgrade. Defaults to OnceNewDefaultVersionAvailable. | `string` | `"OnceNewDefaultVersionAvailable"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_id"></a> [client_id](#output_client_id) | The clientId of the user-assigned managed identity for the Azure AI Foundry resource. |
| <a name="output_id"></a> [id](#output_id) | The ID of the created Azure AI Foundry resource. |
| <a name="output_keys"></a> [keys](#output_keys) | The access keys for the Azure AI Foundry resource. |
| <a name="output_name"></a> [name](#output_name) | The name of the created Azure AI Foundry resource. |
| <a name="output_principal_id"></a> [principal_id](#output_principal_id) | The principalId of the user-assigned managed identity for the Azure AI Foundry resource. |
| <a name="output_resource"></a> [resource](#output_resource) | The Azure AI Foundry resource object. |
<!-- END_TF_DOCS -->
