---
version: 1.0.2
available_versions:
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.4.3
  - 0.4.2
---

<!-- BEGIN_TF_DOCS -->
# Event Grid Domain Topic module

## Overview

This terraform module creates a azurerm_eventgrid_domain_topic and associated resources.

## Prerequisites

- `Resource Group` module if not existing.
- Optional modules and resources:
  - `User Assigned Identity` module for identity of the eventgrid domain.

## Guidance

#### Usage

- This module creates Domain and Domain topic and user can even create multiple topics under same domain name, where user need to pass existing domain, resource group and user assigned identity name
- When input_schema is CustomEventSchema, then input_mapping_fields needs to be populated else enter input_schema as CloudEventSchemaV1_0, EventGridSchema. It will create Domain and further domain topic can be created referencing existing domain
- When you create an event domain, you're given a publishing endpoint similar to if you had created a topic in Event Grid. To publish events to any topic in an event domain, push the events to the domain's endpoint the same way you would for a custom topic. The only difference is that you must specify the topic you'd like the event to be delivered to.
- Domain topic is often considered an auto-managed resource in Event Grid. You can create an event subscription at the domain scope without creating the domain topic. In this case, Event Grid automatically creates the domain topic on your behalf. Of course, you can still choose to create the domain topic manually.

#### Security Considerations

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-EGD-IA_010 | Use a Managed Identity for accessing Azure Resources | Event Grid Domains must enforce the use of a Managed Identity to authenticate to Azure resources where this is supported (What) within targets IAM settings (How) in order to remove the need to store credentials (Why) | True | True | Enforced using the `identity` block. |
| 2. | AZU-EGD-IA_020 | Azure Event Grid Domains must have local authentication methods disabled | Event Grid Domains must have local authentication methods disabled (What) within Overview settings (How) in order to use modern robust and less prone to compromise authentication methods embedded within Entra ID (Why) | True | True | Implemented by setting `local_auth_enabled = false`. |
| 3. | AZU-EGD-AC_010 | Disable Public Network Access | Event Grid Domains must enforce a network guardrail (What) within Networking settings (How) in order to prevent unauthorised access and data exposure to the internet (Why) | True | True | Impelmented by setting `public_network_access_enabled = false` |
| 4. | AZU-EGD-AU_010 | Send all diagnostic log categories to a central SOC Log Analytics workspace | Event Grid must send all diagnostic logs to a central SOC Log Analytics workspace (What) within Diagnostic settings (How) in order to support a security investigation after a security incident (Why) | False | False | To be implemented via policy. |
| 5. | AZU-EGD-AU_020 | Send all diagnostic log categories to a central SOC Storage Account | Event Grid must send all diagnostic logs to a central SOC Storage Account (What) within Diagnostic settings (How) In order to provide an immutable copy to adhere to compliance requirements (Why) | False | False | To be implemented via policy. |
| 6. | AZU-EGD-AU_030 | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval (What) within Diagnostic settings (How) in order to prevent sensitive data leakage to third parties outside of LSEG control (Why) | False | False | To be enforced using the approval process required for CyberSecurity risk assessment. |
| 7. | AZU-EGD-SC_010 | Azure App Deployment must not be able to corrupt the centrally managed private link private DNS zones when making a private endpoint for Event Grid Domains | Event Grid Domains must have an Azure DeployIfNotExists policy to update the centrally managed private link private DNS zones with its private A record (What) via Policy to management group mapping (How) in order to ensure there is no ability for the Azure App Deployment team to have authorisation over these zones that could allow them to corrupt this file and impact service availability (Why) | False | False | To be implemented via policy. |
| 8. | AZU-EGD-SC_020 | Event Grid Domain Subscriptions should only be from approved resources/services | Event Grid Domain Subscriptions should only be to approved resources/services (What) in Domain scope event subscription settings (How) in order to reduce the risk of data exfiltration and unauthorised system access (Why) | False | False | Control cannot be implemented by technical configuration. |
| 9. | AZU-EGD-SC_030 | Headers containing secrets must have the secret flag enabled | Headers containing secrets must have the secret flag enabled (What) in Delivery properties (How) in order to prevent secrets being visible in the Azure portal (Why) | False | False | Control cannot be implemented by technical configuration. |
| 10. | AZU-EGD-SC_040 | Event Grid Domain Event Subscriptions must only connect to Event Grid Domains that belong to the same environment | Event Grid Domain Event Subscriptions must only connect to Event Grid Domains that belong to the same environment (e.g. prod <-> prod, dev <-> dev) (What) within the Subscription settings (How) in order to reduce the risk of data exfiltration and unauthorised system access (Why) | False | False | Control cannot be implemented by technical configuration. |
| 11. | AZU-EGD-SC_050 | Event Grid Domain Event Subscriptions must only connect to Event Grid Domains that belong to the LSEG tenant | Event Grid Domain Event Subscriptions must only connect to Event Grid Domains that belong to the LSEG tenant (What) within the Event Subscription settings (How) in order to reduce the risk of data exfiltration and unauthorised system access (Why) | False | False | Control cannot be implemented by technical configuration. |

## Changelog

- [azure-prdsvc-terraform-eventgriddomain](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation] https://learn.microsoft.com/en-us/azure/event-grid/event-domains

### Terraform Docs

- [azurerm_eventgrid_domain] https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_domain
- [azurerm_eventgrid_domain_topic] https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_domain_topic
Collapse

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
| [azurerm_eventgrid_domain.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_domain) | resource |
| [azurerm_eventgrid_domain_topic.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_domain_topic) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_create_domain"></a> [create_domain](#input_create_domain) | (Required) Whether to create the domain when the domain already exists. | `bool` | n/a | yes |
| <a name="input_create_domain_topic"></a> [create_domain_topic](#input_create_domain_topic) | (optional) Whether to create the domain topic when the first domain is created. | `bool` | `true` | no |
| <a name="input_domain_var"></a> [domain_var](#input_domain_var) | (optional) A domain_var block supports the following:<br/>input_schema                              = "(optional) Specifies the schema in which incoming events will be published to this domain. Allowed values are CloudEventSchemaV1_0, CustomEventSchema, or EventGridSchema. Defaults to eventgridschema. Changing this forces a new resource to be created."<br/>auto_create_topic_with_first_subscription = "(optional) Whether to create the domain topic when the first event subscription at the scope of the domain topic is created."<br/>auto_delete_topic_with_last_subscription  = "(optional) Whether to delete the domain topic when the last event subscription at the scope of the domain topic is deleted." | <pre>object({<br/>    input_schema                              = optional(string)<br/>    auto_create_topic_with_first_subscription = optional(bool)<br/>    auto_delete_topic_with_last_subscription  = optional(bool)<br/>  })</pre> | <pre>{<br/>  "auto_create_topic_with_first_subscription": false,<br/>  "auto_delete_topic_with_last_subscription": false,<br/>  "input_schema": "EventGridSchema"<br/>}</pre> | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_existing_domain"></a> [existing_domain](#input_existing_domain) | (optional) An existing_domain block supports the following:<br/>existing_event_grid_domain_name = "(Optional) The name of the existing EventGrid Domain."<br/>existing_event_grid_domain_rg   = "(Optional) The name of the existing Resource Group in which the Event Grid Domain exists." | <pre>object({<br/>    existing_event_grid_domain_name = optional(string)<br/>    existing_event_grid_domain_rg   = optional(string)<br/>  })</pre> | `{}` | no |
| <a name="input_identity"></a> [identity](#input_identity) | (optional) An identity block supports the following:<br/>object({<br/>  type         = "(Required) Specifies the type of Managed Service Identity that should be configured on this Event Grid Domain."<br/>  identity_ids = "(optional) A list of User Assigned Managed Identity IDs to be assigned to this Event Grid Domain."<br/>}) | <pre>object({<br/>    type         = string<br/>    identity_ids = list(string)<br/>  })</pre> | <pre>{<br/>  "identity_ids": null,<br/>  "type": "UserAssigned"<br/>}</pre> | no |
| <a name="input_input_mapping_default_values"></a> [input_mapping_default_values](#input_input_mapping_default_values) | (optional) A input_mapping_default_values block as defined below. Changing this forces a new resource to be created.:<br/>event_type   = "(optional) Specifies the default event type of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created."<br/>data_version = "(optional) Specifies the default data version of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created."<br/>subject      = "(optional) Specifies the default subject of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created." | <pre>object({<br/>    event_type   = optional(string)<br/>    data_version = optional(string)<br/>    subject      = optional(string)<br/>  })</pre> | <pre>{<br/>  "data_version": null,<br/>  "event_type": null,<br/>  "subject": null<br/>}</pre> | no |
| <a name="input_input_mapping_fields"></a> [input_mapping_fields](#input_input_mapping_fields) | (optional) An input_mapping_fields block supports the following:<br/>id           = "(optional) Specifies the id of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created."<br/>topic        = "(optional) Specifies the topic of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created."<br/>event_type   = "(optional) Specifies the event type of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created."<br/>event_time   = "(optional) Specifies the event time of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created."<br/>data_version = "(optional) Specifies the data version of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created."<br/>subject      = "(optional) Specifies the subject of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created." | <pre>object({<br/>    id           = optional(string)<br/>    topic        = optional(string)<br/>    event_type   = optional(string)<br/>    event_time   = optional(string)<br/>    data_version = optional(string)<br/>    subject      = optional(string)<br/>  })</pre> | <pre>{<br/>  "data_version": null,<br/>  "event_time": null,<br/>  "event_type": null,<br/>  "id": null,<br/>  "subject": null,<br/>  "topic": null<br/>}</pre> | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_domain_topic_id"></a> [domain_topic_id](#output_domain_topic_id) | The ID of the EventGrid Domain Topic. |
| <a name="output_domain_topic_name"></a> [domain_topic_name](#output_domain_topic_name) | The name of the EventGrid Domain Topic. |
| <a name="output_id"></a> [id](#output_id) | The ID of the EventGrid Domain. |
| <a name="output_name"></a> [name](#output_name) | The name of the EventGrid Domain. |
| <a name="output_primary_access_key"></a> [primary_access_key](#output_primary_access_key) | The Primary Shared Access Key associated with the EventGrid Domain. |
| <a name="output_resource"></a> [resource](#output_resource) | The Event Grid Domain resource. |
| <a name="output_secondary_access_key"></a> [secondary_access_key](#output_secondary_access_key) | The Secondary Shared Access Key associated with the EventGrid Domain. |
<!-- END_TF_DOCS -->
