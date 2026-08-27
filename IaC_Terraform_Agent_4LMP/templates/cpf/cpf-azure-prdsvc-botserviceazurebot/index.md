---
version: 1.0.2
available_versions:
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.6.0
  - 0.5.1
---

<!-- BEGIN_TF_DOCS -->
# Bot Service module


## Overview

This terraform module creates a Azure AI Bot service and associated resources.

Bot is as a web application that has a conversational interface. Your users connect to your bot through a channel, such as Facebook, Slack, Microsoft Teams, or a custom application.

- Depending on how the bot is configured and how it's registered with the channel, interactions can be in text or speech and can include images and video.
- The bot processes the user's input to interpret what the user has asked for or said.
- The bot evaluates input and performs relevant tasks, such as ask the user for additional information or access services on behalf of the user.
- The bot responds to the user to let them know what the bot is doing or has done.

## Prerequisites

- An exisiting `Resource Group`.
- A `key vault` needs to be deployed to store the Customer Managed Key.
- A Subnet in the targeted Virtual Network for various private endpoints created for the dependent resources.
- A `user managed identity` as data encryption for bot service with a Customer Managed Key requires user-assigned managed identity.

## Guidance

#### Usage

- This module is tested locally with `UserassignedMSI` bot type with streaming endpoint enabled.
- In this module, we have enabled CMK as per the controls. To achieve this, we added the `Key Vault Crypto Service Encryption User` role to the Azure-defined Bot Service CMEK Prod Service Principal. Since the Service Principal ID varies by tenant, please ensure that you update the `bot_cmek_prod_id` if you are using this module in a different tenant.
- In this module, we have enabled the Entra ID authentication feature using the bot connection block. This has been tested for CPF using the existing app spn secret. To use the same perform below steps

1. `CLIENT-ID` has been obtained using data block `data "azurerm_client_config" "current" {}`and `CLIENT-Secret` has been obtained using below block, the way the value for this has been passed is thorugh utilizing the TF environment variables which has been set on the pipeline code to export the secret value as TF ENV variable from the vault, this allows use the secret used for init generated in auth stage rather than reengineering the task to get the value from vault. `- export TF_VAR_ARM_CLIENT_SECRET=$(echo $CREDS | jq -r .data.data.ARM_CLIENT_SECRET)`
2. Add a variable as needed

```
    variable "ARM_CLIENT_SECRET" {
    type        = string
    description = "(Optional) ARM client secret for bot connection."
    }
```
3. Add the bot_connection variables to the module block as below

```
    create_botconnection = true
    bot_connection       = {
        service_provider_name = "Aad"
        client_id             = data.azurerm_client_config.current.client_id
        client_secret         = var.ARM_CLIENT_SECRET
    }
```
- when using the spn for the bot connection please make sure the app spn has the action `Microsoft.BotService/listAuthServiceProviders/action` granted to the spn permissions over the subscription scope. LSEG tenants has the `Role : Custom-Subscription-Resources-Constrained-Contributor-1.0.0` has the relevant permissions and need to get cyber approval to get this role added to app spn.

Alternatively if you don't want to use the app spn, please follow the below steps for any new spn thats created. This is one of the approaches
1. A dedicated SPN should be created on the tenant.
2. Get the spn permission added as described above.
3. Store the `CLIENT-ID` and `CLIENT-Secret` of SPN in Key Vault.
4. Use data blocks to fetch secret from key vault in the .tests/deploytest/main.tf.
```
 data "azurerm_key_vault" "this" {
   name                = "mykeyvault"
   resource_group_name = "keyvault-resource-group"
 }

 data "azurerm_key_vault_secret" "this1" {
   name         = "CLIENT-ID"
   key_vault_id = data.azurerm_key_vault.this.id
 }

 data "azurerm_key_vault_secret" "this2" {
   name         = "CLIENT-Secret"
   key_vault_id = data.azurerm_key_vault.this.id
 }

```
5. Set the bot_connection variables as
```
    create_botconnection = true
    bot_connection       = {
      service_provider_name = "Aad"
      client_id             = data.azurerm_key_vault_secret.this1.value
      client_secret         = data.azurerm_key_vault_secret.this2.value
    }
```

- If you want to not use this altogether just ignore this as the `variable "bot_connection"` is set to use `null` by default.
- The available service providers for bot connection are wunderlist,google,pinterest,appFigures,facebook,SkypeForBusiness,outlook,SharePointOnline,Aadb2c,Aadv2,Aadv2WithCerts,FactSet,linkedin,trello,SharepointServer,oauth2,slack,zendesk,DynamicsCrmOnline,Aad,smartsheet,flickr,Office365,onedrive,basecamp,instagram,mailchimp,Office365User,echosign,live,oauth2generic,spotify,tumblr,AWeber,marketo,dropbox,box,yammer,intuit,uservoice,salesforce,todoist,github,docusign,stripe,bitly,lithium,sugarcrm

Use `key_vault_tags` variable to define additional Key Vault Keys/Secret related tags in your product, and you can not have more than 2 tags (key-value pairs), as the product gets a default of 13 tags and Key Vault child resources support only 15 tags as the maximum limit. Reference link - [Key tags](https://learn.microsoft.com/en-us/azure/key-vault/keys/about-keys-details#key-tags)

- Use the `tags` variable to define additional tags related to the product (core). Note that the product already has a default of 13 tags, so if you are adding multiple additional tags (key-value pairs), ensure the total count does not exceed the limit supported by Azure resources. [Azure Resources Tag Limitation](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/tag-support)

#### Security Considerations

- `public_network_access_enabled` to the bot service has been hardcoded to false, So the module will only be usable via self hosted agents. If you try to run the module via Microsoft hosted agent you will see errors.

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-AAIBOT-IA_010 | Azure Bot Services resources must have local authentication methods disabled | Azure Bot Services must have local authentication methods disabled (What) within code deployment settings (How) in order to use modern robust and less prone to compromise authentication methods embedded within Entra ID (Why) | True | True | This control is implemented by setting `local_auth_enabled` = false. |
| 2. | AZU-AAIBOT-IA_020 | Use a Managed Identity for accessing Azure Resources |  Azure Bot Services must enforce the use of a Managed Identity to authenticate to Azure resources where this is supported (What) within targets Access control settings (How) in order to remove the need to store credentials (Why) | False | False | This control could not implemente via terraform. |
| 3. | AZU-AAIBOT-IA_030 | Azure Bot Service must be of type User Assigned Managed Identity | Azure Bot Service must be of type User Assigned Managed Identity (What) within code deployment settings (How) in order to remove the need to store credentials (Why) | True | True | This control is implemented by harcoding the `microsoft_app_type` variable as `UserAssignedMSI` in `main.tf`|
| 4. | AZU-AAIBOT-IA_040 | User Assigned Managed identities associated with Bot Service must be from the LSEG tenant | User Assigned Managed identities associated with Bot Service must be from the LSEG tenant (What) via deployment settings (How) to ensure only LSEG approved User Managed Identities are used (Why) | True | False | This control is implemented by user assigned identity block. |
| 5.| AZU-AAIBOT-IA_050 | Entra ID authentication only must be used | Entra ID authentication only must be used for Azure Bot Services (What) within Configuration > OAuth Connection settings (How) in order to use modern robust and less prone to compromise authentication methods embedded within Entra ID (Why) | False | False |  we have enabled the Entra ID authentication feature using the bot connection block. However, we are unable to test this locally due to a limitation that requires a dedicated SPN to enable AD Authentication for the bot service, which must exist in the portal with a client secret. As a workaround, we have added code to store the client_secret in Key Vault with a dummy value. |
| 6. | AZU-AAIBOT-IA_060 | Entra ID identity provider must enforce app registration type as an existing app registration in the LSEG tenant | Entra ID identity provider must enforce app registration type as an existing app registration in the LSEG tenant (What) within Configuration > OAuth Connection settings (How) in order to ensure only LSEG approved apps are used (Why) | False | False | This control is implemented by LSEG Standard. |
| 7. | AZU-AAIBOT-IA_070 | Azure Bot channels must use tokens for authentication rather than secrets | Azure Bot channels must use tokens for authentication rather than secrets (What) within application settings (How) to prevent use of the master key for authentication (Why) | True | False | This control is implemented by `enhanced_authentication_enabled` set to true. |
| 8. | AZU-AAIBOT-AC_010 | Disable Public Network Access | Azure Bot Services must enforce a network guardrail (What) within Networking settings (How) in order to prevent unauthorised access and data exposure to the internet (Why) | True | True | This control is implemented by `public_network_access_disabled` set to false . |
| 9. | AZU-AAIBOT-AU_010 | Send all diagnostic log categories to a central SOC Log Analytics workspace | Azure Bot Services must send all diagnostic logs to a central SOC Log Analytics workspace (What) within Diagnostics Settings (How) in order to support a security investigation after a security incident (Why) | False | False | This control is implemented via DINE policy. |
| 10. | AZU-AAIBOT-AU_020 | end all diagnostic log categories to a central SOC Storage Account | Azure Bot Services must send all diagnostic logs to a central SOC Storage Account (What) within Diagnostic Settings (How) in order to provide an immutable copy to adhere to compliance requirements (Why) | False | False | This control is implemented via DINE policy. |
| 11. | AZU-AAIBOT-AU_030 | Sending diagnostic logs to partner categories is after Cyber Security Risk Assessment and approval |  Sending diagnostic logs to partner categories is after CyberSecurity Risk Assessment and approval (What) within Diagnostic Settings (How) in order to prevent sensitive data leakage to third parties outside of LSEG control (Why) | False | False | This control is implemented via DINE policy. |
| 12. | AZU-AAIBOT-SC_010 | Must use a dedicated CMK for Speech Service encryption key management that is persisted in a Key Vault premium SKU | Use a dedicated Speech Service LSEG managed encryption at rest key persisted in a Key Vault premium SKU  (What) within Encryption settings (How) in order should Microsoft's key management platform become compromised LSEG can revoke access to exfiltrated encrypted data (Why) | True | False | This control is implemented via key_vault_id. |
| 13. | AZU-AAIBOT-SC_020 | Network connections to the Azure Bot Service control and data planes must use TLS encryption | Azure Bot Service must enforce network flow encryption in transit using TLS (What) within Configuration settings (How) in order to use modern techniques to establish robust encrypted data channels over untrusted networks (Why) | True | False | This control is implemented by using validation for `endpoint` variable and set to use only `https`. |
| 14. | AZU-AAIBOT-SC_030 | Azure App Deployment must not be able to corrupt the centrally managed private link private DNS zones when making a private endpoint for Azure Bot Service Bot resources | Azure Bot Service resources must have an Azure DeployIfNotExists policy to update the centrally managed private link private DNS zones with its private A record (What) via Policy to management group mapping (How) to ensure there is no ability for the Azure App Deployment team to have authorisation over these zones that could allow them to corrupt this file and impact service availability (Why) | False | False | This control is implemented by LSEG Standard. |
| 15. | AZU-AAIBOT-SC_040 | Azure App Deployment must not be able to corrupt the centrally managed private link private DNS zones when making a private endpoint for Azure Bot Service Token resources | AAzure Bot Service resources must have an Azure DeployIfNotExists policy to update the centrally managed private link private DNS zones with its private A record (What) via Policy to management group mapping (How) to ensure there is no ability for the Azure App Deployment team to have authorisation over these zones that could allow them to corrupt this file and impact service availability (Why) | False | False | This control is implemented by LSEG Standard. |
| 16. | AZU-AAIBOT-SC_050 | Azure Bot Services must use only approved channels | Azure Bot Services must use only approved channels (What) within Channels settings (How) in order to prevent unauthorised access and data exposure (Why) | True | False | This control is implemented by using approved channels such as `azurerm_bot_channel_directline` and `azurerm_bot_channel_ms_teams` block. |
| 17. | AZU-AAIBOT-SC_060 | Azure Bot Services direct line channels must enable enhanced authentication | Azure Bot Services direct line channels must enable enhanced authentication (What) within Channels settings (How) to reduce the risk of identity spoofing (Why) | True | False | This control is implemented by `enhanced_authentication_enabled` set to true. |
| 18. | AZU-AAIBOT-SC_070 | Azure Bot Services direct line channels enhanced authentication must only use allowed origins | Azure Bot Services direct line channels enhanced authentication must only use allowed origins (What) within Channels settings (How) to only accept tokens from trusted sources (Why) | True | False | This control is implemented by using validation for `trusted origins` variable and set to use only `https`. |
| 19. | AZU-AAIBOT-SC_080 | Azure Bot Services direct line channels must disable file upload | Azure Bot Services direct line channels must disable file upload (What) within Channels settings (How) to maintain Bot integrity and prevent the transfer of malicious files (Why) | True | False | This control is implemented by `user_upload_enabled` set to `false`. |
| 20. | AZU-AAIBOT-SC_090 | Azure Bot Services direct line channels must use the latest version of the Direct Line protocol | Azure Bot Services direct line channels must use the latest version of the Direct Line protocol (What) within Channel settings (How) to ensure the latest security features are available (Why) | True | False | This control is implemented by `v3_allowed` set to `true`. |

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module. |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Monitor metrics on Azure AI Bot](https://learn.microsoft.com/en-us/azure/bot-service/monitor-bot-service?view=azure-bot-service-4.0)<br><br>[Supported Metrics for Azure AI Bot](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-botservice-botservices-metrics)<br><br>[Cloud monitoring service level objectives](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives) |
| 5. | [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | False | This control cannot be implemented via terraform.<br><br>[Reliability guidance for Azure AI Bot Service](https://learn.microsoft.com/en-us/azure/bot-service/bot-service-reliability-guidance?view=azure-bot-service-4.0). |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json). |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package.<br><br>[Bot Framework authentication basics](https://learn.microsoft.com/en-us/azure/bot-service/bot-builder-authentication-basics?view=azure-bot-service-4.0). |

## Changelog

- [azure-prdsvc-terraform-botservice](CHANGELOG.md)

## References

### Microsoft Docs

- [Azure AI Bot Service](https://azure.microsoft.com/en-us/products/ai-services/ai-bot-service)

### Terraform Docs

- [azurerm_bot_service_azure_bot](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bot_service_azure_bot)

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
| [azurerm_bot_channel_directline.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bot_channel_directline) | resource |
| [azurerm_bot_channel_ms_teams.teams_channel](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bot_channel_ms_teams) | resource |
| [azurerm_bot_connection.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bot_connection) | resource |
| [azurerm_bot_service_azure_bot.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bot_service_azure_bot) | resource |
| [azurerm_key_vault_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_role_assignment.cmk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_bot_cmek_prod_id"></a> [bot_cmek_prod_id](#input_bot_cmek_prod_id) | (Required) The object ID of the Azure-defined `Bot Service CMEK Prod` Service Principal. In order to utilize CMEK, the product will assign it the `Key Vault Crypto Service Encryption User` role. Curently in .tests/deployTest/main.tf object ID is of Bot Service CMEK Prod of lsegroup tenant, change this if deploying in another tenant. | `string` | n/a | yes |
| <a name="input_bot_connection"></a> [bot_connection](#input_bot_connection) | (Required) Bot Connection supports below values:<br/>  name                  = "(Optional) Specifies the name of the Bot Connection. Changing this forces a new resource to be created. Must be globally unique."<br/>  service_provider_name = "(Required) The name of the service provider that will be associated with this connection. Changing this forces a new resource to be created."<br/>  client_id             = "(Required) The Client ID that will be used to authenticate with the service provider."<br/>  client_secret         = "(Required) The Client Secret that will be used to authenticate with the service provider."<br/>  Scopes                = "(Optional) The Scopes at which the connection should be applied."<br/>  parameters            = "(Optional) A map of additional parameters to apply to the connection." | <pre>object({<br/>    name                  = optional(string)<br/>    service_provider_name = string<br/>    client_id             = string<br/>    client_secret         = string<br/>    scopes                = optional(string)<br/>    parameters            = optional(string)<br/>  })</pre> | <pre>{<br/>  "client_id": null,<br/>  "client_secret": null,<br/>  "name": "AD Authentication",<br/>  "parameters": null,<br/>  "scopes": null,<br/>  "service_provider_name": null<br/>}</pre> | no |
| <a name="input_cmk_expiration_date"></a> [cmk_expiration_date](#input_cmk_expiration_date) | (Required) Expiration UTC datetime (Y-m-d'T'H:M:S'Z'). | `string` | n/a | yes |
| <a name="input_cmk_key_name"></a> [cmk_key_name](#input_cmk_key_name) | (optional) Key name to be used (max 127 chars) | `string` | `null` | no |
| <a name="input_cmk_rotation_policy"></a> [cmk_rotation_policy](#input_cmk_rotation_policy) | (Optional) A rotation policy block as defined below<br/>object({<br/>  notify_before_expiry = "(Required) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>  time_before_expiry   = "(Required) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br/>  time_after_creation  = "(Optional) Rotate automatically at a duration after create as an ISO 8601 duration."<br/>  expire_after         = "(Required) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>}) | <pre>object({<br/>    notify_before_expiry = string<br/>    time_before_expiry   = string<br/>    time_after_creation  = optional(string, null)<br/>    expire_after         = string<br/>  })</pre> | <pre>{<br/>  "expire_after": "P365D",<br/>  "notify_before_expiry": "P351D",<br/>  "time_after_creation": "P358D",<br/>  "time_before_expiry": null<br/>}</pre> | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_create_botconnection"></a> [create_botconnection](#input_create_botconnection) | (Optional) Whether or not to create bot connection service. | `bool` | `false` | no |
| <a name="input_create_directlinechannel"></a> [create_directlinechannel](#input_create_directlinechannel) | (Optional) Whether or not to create direct line channel | `bool` | `true` | no |
| <a name="input_create_msteamschannel"></a> [create_msteamschannel](#input_create_msteamschannel) | (Optional) Whether or not to create ms teams channel | `bool` | `true` | no |
| <a name="input_create_role_assignment"></a> [create_role_assignment](#input_create_role_assignment) | Whether to create the Key Vault Crypto Service Encryption User role assignment. Set to false if the role assignment already exists. | `bool` | `true` | no |
| <a name="input_developer_app_insights_api_key"></a> [developer_app_insights_api_key](#input_developer_app_insights_api_key) | (Optional) The Application Insights API Key to associate with this Azure Bot Service. | `string` | `null` | no |
| <a name="input_developer_app_insights_application_id"></a> [developer_app_insights_application_id](#input_developer_app_insights_application_id) | (Optional) The resource ID of the Application Insights instance to associate with this Azure Bot Service. | `string` | `null` | no |
| <a name="input_developer_app_insights_key"></a> [developer_app_insights_key](#input_developer_app_insights_key) | (Optional) The Application Insights API Key to associate with this Azure Bot Service. | `string` | `null` | no |
| <a name="input_direct_line_sites"></a> [direct_line_sites](#input_direct_line_sites) | A Direct Line site represents a client application that you want to connect to your bot. | <pre>list(object({<br/>    name                        = string<br/>    enabled                     = optional(bool)<br/>    user_upload_enabled         = optional(bool)<br/>    endpoint_parameters_enabled = optional(bool)<br/>    storage_enabled             = optional(bool)<br/>    v1_allowed                  = optional(bool)<br/>    v3_allowed                  = optional(bool)<br/>    trusted_origins             = optional(list(string))<br/>  }))</pre> | <pre>[<br/>  {<br/>    "enabled": true,<br/>    "endpoint_parameters_enabled": false,<br/>    "name": null,<br/>    "storage_enabled": false,<br/>    "trusted_origins": null,<br/>    "user_upload_enabled": false,<br/>    "v1_allowed": false,<br/>    "v3_allowed": true<br/>  }<br/>]</pre> | no |
| <a name="input_display_name"></a> [display_name](#input_display_name) | (Optional) The name that the Azure Bot Service will be displayed as. This defaults to the value set for name if not specified. | `string` | `null` | no |
| <a name="input_endpoint"></a> [endpoint](#input_endpoint) | (Optional) The Azure Bot Service endpoint.Please ensure if you are changing endpoint URL as per the security controls URL should be start with https. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_icon_url"></a> [icon_url](#input_icon_url) | (Optional) The Icon Url of the Azure Bot Service. | `string` | `null` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_key_vault_id"></a> [key_vault_id](#input_key_vault_id) | (Required) ID of the existing Key vault to store the Customer Managed Key for Transparent Data Encryption. | `string` | n/a | yes |
| <a name="input_key_vault_tags"></a> [key_vault_tags](#input_key_vault_tags) | (Optional) Key Vault related tags to be set on key vault child resources. | `map(any)` | `{}` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_luis_app_ids"></a> [luis_app_ids](#input_luis_app_ids) | (Optional) A list of LUIS App IDs to associate with this Azure Bot Service. | `list(string)` | `[]` | no |
| <a name="input_luis_key"></a> [luis_key](#input_luis_key) | (Optional) The LUIS key to associate with this Azure Bot Service. | `string` | `null` | no |
| <a name="input_microsoft_app_id"></a> [microsoft_app_id](#input_microsoft_app_id) | (Required) The Microsoft Application ID for the Azure Bot Service. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_microsoft_app_msi_id"></a> [microsoft_app_msi_id](#input_microsoft_app_msi_id) | (Optional) The ID of the Microsoft App Managed Identity for this Azure Bot Service. Changing this forces a new resource to be created.. | `string` | `null` | no |
| <a name="input_microsoft_app_tenant_id"></a> [microsoft_app_tenant_id](#input_microsoft_app_tenant_id) | (Optional) The Tenant ID of the Microsoft App for this Azure Bot Service. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_ms_teams_channel"></a> [ms_teams_channel](#input_ms_teams_channel) | (Required) MS Teams Channel supports below values:<br/>  calling_web_hook       = "(Optional) Specifies the webhook for Microsoft Teams channel calls."<br/>  deployment_environment = "(Optional) The deployment environment for Microsoft Teams channel calls. Possible values are CommercialDeployment and GCCModerateDeployment. Defaults to CommercialDeployment."<br/>  enable_calling         = "(Optional) Specifies whether to enable Microsoft Teams channel calls. This defaults to false." | <pre>object({<br/>    calling_web_hook       = optional(string)<br/>    deployment_environment = optional(string)<br/>    enable_calling         = optional(bool)<br/>  })</pre> | <pre>{<br/>  "calling_web_hook": null,<br/>  "deployment_environment": "CommercialDeployment",<br/>  "enable_calling": false<br/>}</pre> | no |
| <a name="input_name"></a> [name](#input_name) | (Required) The name which should be used for this Azure Bot Service. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input_sku) | (Required) The SKU of the Azure Bot Service. Accepted values are F0 or S1. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_streaming_endpoint_enabled"></a> [streaming_endpoint_enabled](#input_streaming_endpoint_enabled) | (Optional) Whether the Azure Bot Service Streaming Endpoint should be enabled. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The ID of the created azure bot service. |
| <a name="output_name"></a> [name](#output_name) | The ID of the created azure bot service. |
| <a name="output_resource"></a> [resource](#output_resource) | The Resource of the created azure bot service. |
<!-- END_TF_DOCS -->
