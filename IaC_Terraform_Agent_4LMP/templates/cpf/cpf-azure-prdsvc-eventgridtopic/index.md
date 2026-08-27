---
version: 1.0.2
available_versions:
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.3.2
  - 0.3.1
---

<!-- BEGIN_TF_DOCS -->
# Event Grid Topic module

## Overview

This terraform module creates a Event Grid Topic and associated resources.

## Prerequisites

- `Resource Group` module as needed if not existing.

## Guidance

#### Usage

- When `input_schema` is `CustomEventSchema`, then `input_mapping_fields` needs to be populated else enter `input_schema` as `CloudEventSchemaV1_0`, `EventGridSchema`.

#### Security Considerations

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-EGCt-IA_010 | Use a Managed Identity for accessing Azure Resources | Event Grid Custom Topics must enforce the use of a Managed Identity to authenticate to Azure resources where this is supported (What) within targets IAM settings (How) in order to remove the need to store credentials (Why) | True | True | Enforced using the `identity` block. |
| 2. | AZU-EGCT-IA_020 | Azure Event Grid Domains must have local authentication methods disabled | Event Grid Custom Topics must have local authentication methods disabled (What) within Overview settings (How) in order to use modern robust and less prone to compromise authentication methods embedded within Entra ID (Why) | True | True | Implemented by setting `local_auth_enabled = false`. |
| 3. | AZU-EGCT-AC_010 | Disable Public Network Access | Event Grid Domains must enforce a network guardrail (What) within Networking settings (How) in order to prevent unauthorised access and data exposure to the internet (Why) | True | True | Impelmented by setting `public_network_access_enabled = false` |
| 4. | AZU-EGCT-AU_010 | Send all diagnostic log categories to a central SOC Log Analytics workspace | Event Grid Custom Topics must send all diagnostic logs to a central SOC Log Analytics workspace (What) within namespace Diagnostic settings (How) in order to support a security investigation after a security incident (Why) | False | False | To be implemented via policy. |
| 5. | AZU-EGCT-AU_020 | Send all diagnostic log categories to a central SOC Storage Account | Event Grid Custom Topics must send all diagnostic logs to a central SOC Storage Account (What) within namespace Diagnostic settings (How) In order to provide an immutable copy to adhere to compliance requirements (Why) | False | False | To be implemented via policy. |
| 6. | AZU-EGCT-AU_030 | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval (What) within Diagnostic settings (How) in order to prevent sensitive data leakage to third parties outside of LSEG control (Why) | False | False | To be enforced using the approval process required for CyberSecurity risk assessment. |
| 7. | AZU-EGCT-SC_010 | Azure App Deployment must not be able to corrupt the centrally managed private link private DNS zones when making a private endpoint for Event Grid Domains | Event Grid Custom Topics must have an Azure DeployIfNotExists policy to update the centrally managed private link private DNS zones with its private A record (What) via Policy to management group mapping (How) to ensure there is no ability for the Azure App Deployment team to have authorisation over these zones that could allow them to corrupt this file and impact service availability (Why) | False | False | To be implemented via policy. |
| 8. | AZU-EGCT-SC_020 | Event Grid Custom Topic Event Subscriptions must only connect to Event Grid Custom Topics that belong to the LSEG tenant | Event Grid Custom Topic Event Subscriptions must only connect to Event Grid Custom Topics that belong to the LSEG tenant (What) within Event Subscription settings (How) to reduce the risk of data exfiltration and unauthorised system access (Why) | False | False | Control cannot be implemented by technical configuration. |
| 9. | AZU-EGCT-SC_030 | Headers containing secrets must have the secret flag enabled | Headers containing secrets must have the secret flag enabled (What) in Delivery properties (How) to prevent secrets being visible in the Azure portal (Why) | False | False | Control cannot be implemented by technical configuration. |
| 10. | AZU-EGCT-SC_040 | Event Grid Custom Topic Event Subscriptions must only connect to Event Grid Custom Topics that belong to the same environment | Event Grid Custom Topic Event Subscriptions must only connect to Event Grid Custom Topics that belong to the same environment (e.g. prod <-> prod, dev <-> dev) (What) within Event Subscription settings (How) to reduce the risk of data exfiltration and unauthorised system access (Why) | False | False | Control cannot be implemented by technical configuration. |

## Changelog

- [azure-prdsvc-terraform-eventgridtopic](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/event-grid/custom-topics)

### Terraform Docs

- [azurerm_eventgrid_topic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_topic)

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
| [azurerm_eventgrid_topic.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_topic) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_custom_topic_var"></a> [custom_topic_var](#input_custom_topic_var) | (Optional) A custom_topic_var block supports the following:<br/>input_schema = "(Optional) Specifies the schema in which incoming events will be published to this domain. Allowed values are CloudEventSchemaV1_0, CustomEventSchema, or EventGridSchema. Defaults to eventgridschema. Changing this forces a new resource to be created." | <pre>object({<br/>    input_schema = optional(string)<br/>  })</pre> | <pre>{<br/>  "input_schema": "EventGridSchema"<br/>}</pre> | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_identity"></a> [identity](#input_identity) | (Optional) An identity block supports the following:<br/>object({<br/>  type         = "(Required) Specifies the type of Managed Service Identity that should be configured on this Event Grid ."<br/>  identity_ids = "(Optional) A list of User Assigned Managed Identity IDs to be assigned to this Event Grid ."<br/>}) | <pre>object({<br/>    type         = string<br/>    identity_ids = list(string)<br/>  })</pre> | <pre>{<br/>  "identity_ids": null,<br/>  "type": "UserAssigned"<br/>}</pre> | no |
| <a name="input_input_mapping_default_values"></a> [input_mapping_default_values](#input_input_mapping_default_values) | (Optional) A input_mapping_default_values block as defined below. Changing this forces a new resource to be created.:<br/>event_type   = "(Optional) Specifies the default event type of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created."<br/>data_version = "(Optional) Specifies the default data version of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created."<br/>subject      = "(Optional) Specifies the default subject of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created." | <pre>object({<br/>    event_type   = optional(string)<br/>    data_version = optional(string)<br/>    subject      = optional(string)<br/>  })</pre> | <pre>{<br/>  "data_version": null,<br/>  "event_type": null,<br/>  "subject": null<br/>}</pre> | no |
| <a name="input_input_mapping_fields"></a> [input_mapping_fields](#input_input_mapping_fields) | (Optional) An input_mapping_fields block supports the following:<br/>id           = "(Optional) Specifies the id of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created."<br/>topic        = "(Optional) Specifies the topic of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created."<br/>event_type   = "(Optional) Specifies the event type of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created."<br/>event_time   = "(Optional) Specifies the event time of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created."<br/>data_version = "(Optional) Specifies the data version of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created."<br/>subject      = "(Optional) Specifies the subject of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created." | <pre>object({<br/>    id           = optional(string)<br/>    topic        = optional(string)<br/>    event_type   = optional(string)<br/>    event_time   = optional(string)<br/>    data_version = optional(string)<br/>    subject      = optional(string)<br/>  })</pre> | <pre>{<br/>  "data_version": null,<br/>  "event_time": null,<br/>  "event_type": null,<br/>  "id": null,<br/>  "subject": null,<br/>  "topic": null<br/>}</pre> | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoint"></a> [endpoint](#output_endpoint) | The Endpoint associated with the EventGrid Topic. |
| <a name="output_id"></a> [id](#output_id) | The ID of the Event Grid Topic. |
| <a name="output_identity_details"></a> [identity_details](#output_identity_details) | The identity details of the EventGrid Topic. |
| <a name="output_name"></a> [name](#output_name) | The name of the Event Grid Topic. |
| <a name="output_primary_access_key"></a> [primary_access_key](#output_primary_access_key) | The Primary Shared Access Key associated with the EventGrid Topic. |
| <a name="output_resource"></a> [resource](#output_resource) | The EventGrid Topic resource. |
| <a name="output_secondary_access_key"></a> [secondary_access_key](#output_secondary_access_key) | The Secondary Shared Access Key associated with the EventGrid Topic. |
<!-- END_TF_DOCS -->
