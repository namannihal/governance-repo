---
version: 1.0.3
available_versions:
  - 1.0.3
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.1.0
---

<!-- BEGIN_TF_DOCS -->
# Monitor Action Group ReadME


## Overview

An Azure Monitor Action Group is a collection of notification preferences and automated actions that get triggered when an alert fires in Azure Monitor.

Action Groups define "what happens when an alert is triggered" - they're the response mechanism for your monitoring alerts.

## Key Features

This Terraform module supports all Azure Monitor Action Group receiver types:

### 📧 **Notification Receivers**

- **`email_receiver`** - Send email notifications to specified addresses
- **`sms_receiver`** - Send SMS messages to phone numbers
- **`azure_app_push_receiver`** - Push notifications to Azure mobile app
- **`voice_receiver`** - Voice calls to phone numbers

### 🔗 **Integration Receivers**

- **`webhook_receiver`** - HTTP POST to external endpoints (with optional Azure AD authentication)
- **`itsm_receiver`** - Integration with IT Service Management systems
- **`event_hub_receiver`** - Send alert data to Azure Event Hubs

### ⚙️ **Automation Receivers**

- **`automation_runbook_receiver`** - Execute Azure Automation runbooks
- **`logic_app_receiver`** - Trigger Azure Logic Apps workflows
- **`azure_function_receiver`** - Execute Azure Functions for custom responses

### 🛡️ **Role-Based Receivers**

- **`arm_role_receiver`** - Notify users with specific Azure RBAC roles

## Prerequisites

- Create a dedicated resource group or use existing resource group to create action groups.

## Guidance

#### Usage

- Define the `azurerm_monitor_action_group` resource in your Terraform configuration.
- Specify the required parameters such as `name`, `resource_group_name`, and notification receivers (email, SMS, webhook, etc.).
- Reference the action group in your alert rules or other monitoring resources.
- Apply the Terraform configuration to provision the action group in Azure.

###### AzureRM 3.x to 4.x Upgrade Notes for Monitor Action Group

Product Impact -- Low

Users in azurerm 3.x migrating to 4.x need to perform the following changes for the Monitor Action Group:

- The deprecated event_hub_receiver.event_hub_id property has been removed in favour of the event_hub_receiver.event_hub_name and event_hub_receiver.event_hub_namespace properties.

- Wiki link for [AzureRM 4.x Upgrade](https://gitlab.dx1.lseg.com/groups/app/app-51310/azure/prdsvc/terraform/-/wikis/Terraform-AzureRM-Provider-Upgrade:-Version-3.x-to-4.x/Monitor-Action-Group) for details on the upgrade process.

For more details, refer to the official [AzureRM 4.x Upgrade Guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide)

## Security Controls

- Currently, as per LSEG Approved Monitor Action Group Requirements, there are no security controls for this product.

## Changelog

- [azure-prdsvc-terraform-monitoractiongroup](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documenation] (<https://learn.microsoft.com/en-us/azure/azure-monitor/alerts/action-groups>)

### Terraform Docs

- [azurerm_monitor_action_group] (https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group.html)

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
| [azurerm_monitor_action_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_arm_role_receivers"></a> [arm_role_receivers](#input_arm_role_receivers) | (Optional) A list of ARM role receivers for the action group.<br/>list(object({<br/>  name                    = "(Required) The name of the ARM role receiver."<br/>  role_id                 = "(Required) The ARM role ID to notify."<br/>  use_common_alert_schema = "(Optional) Whether to use the common alert schema for ARM role notifications."<br/>})) | <pre>list(object({<br/>    name                    = string<br/>    role_id                 = string<br/>    use_common_alert_schema = optional(bool, false)<br/>  }))</pre> | `[]` | no |
| <a name="input_automation_runbook_receivers"></a> [automation_runbook_receivers](#input_automation_runbook_receivers) | (Optional) A list of automation runbook receivers for the action group.<br/>list(object({<br/>  name                    = "(Required) The name of the automation runbook receiver."<br/>  automation_account_id   = "(Required) The resource ID of the automation account."<br/>  runbook_name            = "(Required) The name of the runbook to execute."<br/>  webhook_resource_id     = "(Required) The resource ID of the webhook."<br/>  is_global_runbook       = "(Required) Whether the runbook is a global runbook."<br/>  service_uri             = "(Required) The URI of the webhook service."<br/>  use_common_alert_schema = "(Optional) Whether to use the common alert schema for automation runbook notifications."<br/>})) | <pre>list(object({<br/>    name                    = string<br/>    automation_account_id   = string<br/>    runbook_name            = string<br/>    webhook_resource_id     = string<br/>    is_global_runbook       = bool<br/>    service_uri             = string<br/>    use_common_alert_schema = optional(bool, false)<br/>  }))</pre> | `[]` | no |
| <a name="input_azure_app_push_receivers"></a> [azure_app_push_receivers](#input_azure_app_push_receivers) | (Optional) A list of Azure app push receivers for the action group.<br/>list(object({<br/>  name          = "(Required) The name of the Azure app push receiver."<br/>  email_address = "(Required) The email address associated with the Azure mobile app account."<br/>})) | <pre>list(object({<br/>    name          = string<br/>    email_address = string<br/>  }))</pre> | `[]` | no |
| <a name="input_azure_function_receivers"></a> [azure_function_receivers](#input_azure_function_receivers) | (Optional) A list of Azure Function receivers for the action group.<br/>list(object({<br/>  name                    = "(Required) The name of the Azure Function receiver."<br/>  function_app_id         = "(Required) The resource ID of the Azure Function App."<br/>  function_name           = "(Required) The name of the Azure Function to invoke."<br/>  function_key            = "(Required) The key for the Azure Function."<br/>  use_common_alert_schema = "(Optional) Whether to use the common alert schema for Azure Function notifications."<br/>})) | <pre>list(object({<br/>    name                    = string<br/>    function_app_id         = string<br/>    function_name           = string<br/>    function_key            = string<br/>    use_common_alert_schema = optional(bool, false)<br/>  }))</pre> | `[]` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 71 chars). | `string` | `null` | no |
| <a name="input_email_receivers"></a> [email_receivers](#input_email_receivers) | (Optional) A list of email receivers for the action group.<br/>list(object({<br/>  name                    = "(Required) The name of the email receiver."<br/>  email_address          = "(Required) The email address of the receiver."<br/>  use_common_alert_schema = "(Optional) Whether to use the common alert schema for email notifications."<br/>})) | <pre>list(object({<br/>    name                    = string<br/>    email_address           = string<br/>    use_common_alert_schema = optional(bool, false)<br/>  }))</pre> | `[]` | no |
| <a name="input_enabled"></a> [enabled](#input_enabled) | (Optional) Whether the action group is enabled. When disabled, no notifications will be sent. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_event_hub_receivers"></a> [event_hub_receivers](#input_event_hub_receivers) | (Optional) A list of Event Hub receivers for the action group.<br/>list(object({<br/>  name                    = "(Required) The name of the Event Hub receiver."<br/>  event_hub_namespace     = "(Optional) The name of the Event Hub namespace."<br/>  event_hub_name          = "(Optional) The name of the Event Hub."<br/>  subscription_id         = "(Optional) The subscription ID where the Event Hub is located."<br/>  tenant_id               = "(Optional) The tenant ID for the Event Hub."<br/>  use_common_alert_schema = "(Optional) Whether to use the common alert schema for Event Hub notifications."<br/>})) | <pre>list(object({<br/>    name                    = string<br/>    event_hub_name          = optional(string, null)<br/>    event_hub_namespace     = optional(string, null)<br/>    subscription_id         = optional(string, null)<br/>    tenant_id               = optional(string, null)<br/>    use_common_alert_schema = optional(bool, false)<br/>  }))</pre> | `[]` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_itsm_receivers"></a> [itsm_receivers](#input_itsm_receivers) | (Optional) A list of ITSM (IT Service Management) receivers for the action group.<br/>list(object({<br/>  name                    = "(Required) The name of the ITSM receiver."<br/>  workspace_id            = "(Required) The workspace ID of the ITSM connection."<br/>  connection_id           = "(Required) The connection ID of the ITSM connection."<br/>  ticket_configuration    = "(Required) The JSON string that defines the ticket configuration."<br/>  region                  = "(Required) The region of the ITSM connection." <br/>})) | <pre>list(object({<br/>    name                 = string<br/>    workspace_id         = string<br/>    connection_id        = string<br/>    ticket_configuration = string<br/>    region               = string<br/>  }))</pre> | `[]` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_logic_app_receivers"></a> [logic_app_receivers](#input_logic_app_receivers) | (Optional) A list of logic app receivers for the action group.<br/>list(object({<br/>  name                    = "(Required) The name of the logic app receiver."<br/>  resource_id             = "(Required) The resource ID of the logic app."<br/>  callback_url            = "(Required) The callback URL of the logic app."<br/>  use_common_alert_schema = "(Optional) Whether to use the common alert schema for logic app notifications."<br/>})) | <pre>list(object({<br/>    name                    = string<br/>    resource_id             = string<br/>    callback_url            = string<br/>    use_common_alert_schema = optional(bool, false)<br/>  }))</pre> | `[]` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_short_name"></a> [short_name](#input_short_name) | (Required) A short name for the action group. This will be used for SMS and other notifications that have character limits. | `string` | n/a | yes |
| <a name="input_sms_receivers"></a> [sms_receivers](#input_sms_receivers) | (Optional) A list of SMS receivers for the action group.<br/>list(object({<br/>  name         = "(Required) The name of the SMS receiver."<br/>  country_code = "(Required) The country code for the phone number (e.g., '1' for US, '44' for UK)."<br/>  phone_number = "(Required) The phone number without the country code."<br/>})) | <pre>list(object({<br/>    name         = string<br/>    country_code = string<br/>    phone_number = string<br/>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_voice_receivers"></a> [voice_receivers](#input_voice_receivers) | (Optional) A list of voice call receivers for the action group.<br/>list(object({<br/>  name         = "(Required) The name of the voice receiver."<br/>  country_code = "(Required) The country code for the phone number (e.g., '1' for US, '44' for UK)."<br/>  phone_number = "(Required) The phone number without the country code."<br/>})) | <pre>list(object({<br/>    name         = string<br/>    country_code = string<br/>    phone_number = string<br/>  }))</pre> | `[]` | no |
| <a name="input_webhook_receivers"></a> [webhook_receivers](#input_webhook_receivers) | (Optional) A list of webhook receivers for the action group.<br/>list(object({<br/>  name                    = "(Required) The name of the webhook receiver."<br/>  service_uri             = "(Required) The URI where the webhook payload will be sent."<br/>  use_common_alert_schema = "(Optional) Whether to use the common alert schema for webhook notifications."<br/>  aad_auth                = "(Optional) Azure AD authentication settings for the webhook receiver. Includes:<br/>    object_id      = "(Required) The Azure AD object ID of the service principal or managed identity to authenticate the webhook."<br/>    identifier_uri = "(Optional) The Azure AD application identifier URI."<br/>    tenant_id      = "(Optional) The Azure AD tenant ID."<br/>  )<br/>})) | <pre>list(object({<br/>    name                    = string<br/>    service_uri             = string<br/>    use_common_alert_schema = optional(bool, false)<br/>    aad_auth = optional(object({<br/>      object_id      = string<br/>      identifier_uri = optional(string, null)<br/>      tenant_id      = optional(string, null)<br/>    }), null)<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The ID of the created Monitor Action Group. |
| <a name="output_name"></a> [name](#output_name) | The name of the created Monitor Action Group. |
| <a name="output_resource"></a> [resource](#output_resource) | The name of the resource group where the Monitor Action Group is created. |
| <a name="output_short_name"></a> [short_name](#output_short_name) | The short name of the Monitor Action Group. |
<!-- END_TF_DOCS -->
