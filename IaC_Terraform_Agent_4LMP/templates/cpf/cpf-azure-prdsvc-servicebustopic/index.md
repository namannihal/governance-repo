---
version: 1.1.2
available_versions:
  - 1.1.2
  - 1.1.1
  - 1.1.0
  - 1.0.0
  - 0.6.0
---

<!-- BEGIN_TF_DOCS -->
# Service Bus Topic module


## Overview

This terraform module creates a Service Bus Topic and associated resources.

## Prerequisites

- Service Bus Topic is a child resource of Service Bus Namespace. A Service Bus Namespace parent resource and related dependencies must be existing before deploying a Service Bus Topic. That includes:
  - `Resource Group`, `Virtual Network` (To be called if not existing).
  - `Subnet` to be used by the Private Endpoint.
  - `Network Security Group` to be associated with the Subnet.
  - `Route Table` to be associated with the Subnet.
  - `Key Vault` to store Service Bus Customer Managed Key (CMK) encryption.
  - `Private Endpoint` to create a private connection to the Key Vault and the Service Bus Namespace.
  - `User Assigned Identity` to be leveraged for both the Service Bus Namespace identity and CMK encryption.
  - `Service Bus Namespace` as the Service Bus Topic mandatory parent resource.

## Guidance

#### Usage

###### AzureRM 3.x to 4.x Upgrade Notes for Servicebustopic

Product Impact -- Medium

- The `auto_delete_on_idle` property now defaults to `P10675199DT2H48M5.4775807S`.
- The `default_message_ttl` property now defaults to `P10675199DT2H48M5.4775807S`.
- The `duplicate_detection_history_time_window` property now defaults to `PT10M`.
- The `max_message_size_in_kilobytes` property now defaults to `256`.
- The `max_size_in_megabytes` property now defaults to `5120`.
- The deprecated `enable_batched_operations` property has been removed in favour of the `batched_operations_enabled` property.
- The deprecated `enable_express` property has been removed in favour of the `express_enabled` property.
- The deprecated `enable_partitioning` property has been removed in favour of the `partitioning_enabled` property.

- Wiki link for [AzureRM 4.x Upgrade](https://gitlab.dx1.lseg.com/groups/app/app-51310/azure/prdsvc/terraform/-/wikis/Terraform-AzureRM-Provider-Upgrade:-Version-3.x-to-4.x/Servicebustopic) for details on the upgrade process.

For more details, refer to the official [AzureRM 4.x Upgrade Guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide)

#### Others

- This module must be used only with `Premium` tier Service Bus Namespace compliant with Security Controls.
- Partitioning is available at namespace creation for the Premium messaging SKU, and all queues and topics in that namespace will be partitioned. Any previously migrated partitioned entities in Premium namespaces will continue to work as expected. When partitioning is enabled in the Premium SKU, the amount of partitions is specified during namespace creation.
- Service Bus `Premium` namespaces do not support Express Entities, so `enable_express` is set to false.
- At least one of the 3 permissions below needs to be set for Service Bus Topic Authorization Rules: `listen`, `send` or `manage`.

#### Security Considerations

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-SB-AC_010 | All Service Bus Topic client access should be authorised using Service Bus Topic level access permissions | All Service Bus Topic client access should be authorised using Topic level access permissions (What) within Access control settings (How) in order to align all access permissions to least privilege such that if the client access credentials were compromised then the blast radius would be reduced (Why) | False | False | Control cannot be implemented by technical configuration setting. |

## Changelog

[azure_prdsvc_terraform_servicebustopic](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-queues-topics-subscriptions#topics-and-subscriptions)

### Terraform Docs

- [azurerm_servicebus_topic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_topic)

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
| [azurerm_servicebus_topic.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_topic) | resource |
| [azurerm_servicebus_topic_authorization_rule.name](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_topic_authorization_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_authorization_rules"></a> [authorization_rules](#input_authorization_rules) | (Optional) A map of servicebus_topic_authorization_rule object as defined below. This creates a `azurerm_servicebus_topic_authorization_rule` for each item in the map:<br/>Key   = "(Required) Specifies the name of the Service Bus Topic Authorization Rule. Should be unique for each Topic."<br/>Value = object({<br/>  listen = "(Optional) Grants listen access to this Authorization Rule. Defaults to `false`."<br/>  send   = "(Optional) Grants send access to this Authorization Rule. Defaults to `false`."<br/>  manage = "(Optional) Grants manage access to this Authorization Rule. When this property is `true` - both `listen` and `send` must be too. Defaults to `false`."<br/>}) | <pre>map(object({<br/>    listen = optional(bool)<br/>    send   = optional(bool)<br/>    manage = optional(bool)<br/>  }))</pre> | `{}` | no |
| <a name="input_auto_delete_on_idle"></a> [auto_delete_on_idle](#input_auto_delete_on_idle) | (Optional) The ISO 8601 timespan duration of the idle interval after which the topic is automatically deleted, minimum of 5 minutes. | `string` | `"P10675199DT2H48M5.4775807S"` | no |
| <a name="input_batched_operations_enabled"></a> [batched_operations_enabled](#input_batched_operations_enabled) | (Optional) Boolean flag which controls whether server-side batched operations are enabled. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_default_message_ttl"></a> [default_message_ttl](#input_default_message_ttl) | (Optional) The ISO 8601 timespan duration of TTL of messages sent to this topic if no TTL value is set on the message itself. | `string` | `"P10675199DT2H48M5.4775807S"` | no |
| <a name="input_duplicate_detection_history_time_window"></a> [duplicate_detection_history_time_window](#input_duplicate_detection_history_time_window) | (Optional) The ISO 8601 timespan duration during which duplicates can be detected. Defaults to 10 minutes (`PT10M`). | `string` | `"PT10M"` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_express_enabled"></a> [express_enabled](#input_express_enabled) | (Optional) Boolean flag which controls whether the topic is an Express Topic. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_max_message_size_in_kilobytes"></a> [max_message_size_in_kilobytes](#input_max_message_size_in_kilobytes) | (Optional) Integer value which controls the maximum size of a message allowed on the topic for Premium SKU. Value must be between `1024` and `102400`. | `number` | `256` | no |
| <a name="input_max_size_in_megabytes"></a> [max_size_in_megabytes](#input_max_size_in_megabytes) | (Optional) Integer value which controls the size of memory allocated for the topic. Defaults to `1024`. | `number` | `5120` | no |
| <a name="input_name"></a> [name](#input_name) | (Optional) Specifies the name of the ServiceBus Topic resource. If not provided, the resource name is created leveraging LSEG variables as per standard naming convention. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_namespace_id"></a> [namespace_id](#input_namespace_id) | (Required) The ID of the Service Bus Namespace to create this topic in. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_partitioning_enabled"></a> [partitioning_enabled](#input_partitioning_enabled) | (Optional) Boolean flag which controls whether to enable the topic to be partitioned across multiple message brokers. Changing this forces a new resource to be created. | `bool` | `false` | no |
| <a name="input_requires_duplicate_detection"></a> [requires_duplicate_detection](#input_requires_duplicate_detection) | (Optional) Boolean flag which controls whether the Topic requires duplicate detection. | `bool` | `true` | no |
| <a name="input_status"></a> [status](#input_status) | (Optional) The Status of the Service Bus Topic. Acceptable values are `Active` or `Disabled`. Defaults to `Active`. | `string` | `"Active"` | no |
| <a name="input_support_ordering"></a> [support_ordering](#input_support_ordering) | (Optional) Boolean flag which controls whether the topic supports ordering. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The ID of the Service Bus Topic created. |
| <a name="output_name"></a> [name](#output_name) | The Name of the Service Bus Topic created. |
| <a name="output_resource"></a> [resource](#output_resource) | The Service Bus Topic resource created. |
<!-- END_TF_DOCS -->
