---
version: 1.1.1
available_versions:
  - 1.1.1
  - 1.1.0
  - 1.0.0
  - 0.7.0
  - 0.6.0
---

<!-- BEGIN_TF_DOCS -->
# Service Bus Subscription module


## Overview

This terraform module creates a Service Bus Subscription and associated resources.

## Prerequisites

- Service Bus Subscription is a child resource of Service Bus Namespace. A Service Bus Namespace parent resource and related dependencies must be existing before deploying a Service Bus Subscription. That includes:
  - `Resource Group`, `Virtual Network` (To be called if not existing).
  - `Subnet` to be used by the Private Endpoint.
  - `Network Security Group` to be associated with the Subnet.
  - `Route Table` to be associated with the Subnet.
  - `Key Vault` to store Service Bus Customer Managed Key (CMK) encryption.
  - `Private Endpoint` to create a private connection to the Key Vault and the Service Bus Namespace.
  - `User Assigned Identity` to be leveraged for both the Service Bus Namespace identity and CMK encryption.
  - `Service Bus Namespace` as the Service Bus Subscription mandatory parent resource.
  - `Service Bus Topic` to be associated with the Service Bus Subscription resource.

## Guidance

#### Usage

- This module must be used only with `Premium` tier Service Bus Namespace and Topics compliant with Security Controls.
- Client Scoped Subscription can only be used for `JMS subscription (Java Message Service)` under Azure Service Bus **Premium** tier.
- Client ID can be `null` or empty, but it must **match the client ID set on the JMS client application**. From the Azure Service Bus perspective, a null client ID and an empty client id have the same behavior. If the client ID is set to null or empty, it is only accessible to client applications whose client ID is also set to null or empty.
- When creating a subscription rule of type `CorrelationFilter` at least one property must be set in the `correlation_filter` block.
- Subscription Rules cannot be created or updated for Client-Affine subscriptions.
- Auto-forwarding cannot be configured on the Subscription as Sessions are enabled.

###### AzureRM 3.x to 4.x Upgrade Notes for service bus subscription

Product Impact -- Low

Users in azurerm 3.x migrating to 4.x need to perform the following changes for the service bus subscription resource:

- The deprecated enable_batched_operations property has been removed in favour of the batched_operations_enabled property.
- The auto_delete_on_idle property now defaults to P10675199DT2H48M5.4775807S.
- The default_message_ttl property now defaults to P10675199DT2H48M5.4775807S.

- Wiki link for [AzureRM 4.x Upgrade](https://gitlab.dx1.lseg.com/groups/app/app-51310/azure/prdsvc/terraform/-/wikis/Terraform-AzureRM-Provider-Upgrade:-Version-3.x-to-4.x/ServiceBusSubscription) for details on the upgrade process.

For more details, refer to the official [AzureRM 4.x Upgrade Guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide)

#### Security Considerations

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. |  |  |  |  |  |  |

## Changelog

[azure_prdsvc_terraform_servicebussubscription](CHANGELOG.md)

## References

- [Official Documentation](https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-queues-topics-subscriptions#topics-and-subscriptions)
- [Client Scoping](https://learn.microsoft.com/en-us/azure/service-bus-messaging/java-message-service-20-entities?WT.mc_id=Portal-fx#client-scoping)

### Terraform Docs

- [azurerm_servicebus_subscription](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_subscription)

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
| [azurerm_servicebus_subscription.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_subscription) | resource |
| [azurerm_servicebus_subscription_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_subscription_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_auto_delete_on_idle"></a> [auto_delete_on_idle](#input_auto_delete_on_idle) | (Optional) The idle interval after which the topic is automatically deleted as an ISO 8601 duration. The minimum duration is 5 minutes or `PT5M`. | `string` | `"P10675199DT2H48M5.4775807S"` | no |
| <a name="input_batched_operations_enabled"></a> [batched_operations_enabled](#input_batched_operations_enabled) | (Optional) Boolean flag which controls whether the Subscription supports batched operations. | `bool` | `null` | no |
| <a name="input_client_scoped_subscription"></a> [client_scoped_subscription](#input_client_scoped_subscription) | (Optional) A `client_scoped_subscription` block as defined below.  Used only for `Premium` SKU:<br/>  client_id                               = "(Optional) Specifies the Client ID of the application that created the client-scoped subscription. Changing this forces a new resource to be created."<br/>  is_client_scoped_subscription_shareable = "(Optional) Whether the client scoped subscription is shareable. Defaults to `true` Changing this forces a new resource to be created."<br/>  is_client_scoped_subscription_durable   = "(Optional) Whether the client scoped subscription is durable. This property can only be controlled from the application side." | <pre>object({<br/>    client_id                               = optional(string, null)<br/>    is_client_scoped_subscription_shareable = optional(bool, true)<br/>    is_client_scoped_subscription_durable   = optional(bool)<br/>  })</pre> | `null` | no |
| <a name="input_client_scoped_subscription_enabled"></a> [client_scoped_subscription_enabled](#input_client_scoped_subscription_enabled) | (Optional) whether the subscription is scoped to a client ID. Defaults to `false`. Used only for `Premium` SKU. | `bool` | `false` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_dead_lettering_on_filter_evaluation_error"></a> [dead_lettering_on_filter_evaluation_error](#input_dead_lettering_on_filter_evaluation_error) | (Optional) Boolean flag which controls whether the Subscription has dead letter support on filter evaluation exceptions. Defaults to `true`. | `bool` | `true` | no |
| <a name="input_dead_lettering_on_message_expiration"></a> [dead_lettering_on_message_expiration](#input_dead_lettering_on_message_expiration) | (Optional) Boolean flag which controls whether the Subscription has dead letter support when a message expires. | `bool` | `true` | no |
| <a name="input_default_message_ttl"></a> [default_message_ttl](#input_default_message_ttl) | (Optional) The Default message timespan to live as an ISO 8601 duration. This is the duration after which the message expires, starting from when the message is sent to Service Bus. This is the default value used when TimeToLive is not set on a message itself. | `string` | `"P10675199DT2H48M5.4775807S"` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_forward_dead_lettered_messages_to"></a> [forward_dead_lettered_messages_to](#input_forward_dead_lettered_messages_to) | (Optional) The name of a Queue or Topic to automatically forward Dead Letter messages to. | `string` | `null` | no |
| <a name="input_forward_to"></a> [forward_to](#input_forward_to) | (Optional) The name of a Queue or Topic to automatically forward messages to. | `string` | `null` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_lock_duration"></a> [lock_duration](#input_lock_duration) | (Optional) The lock duration for the subscription as an ISO 8601 duration. The default value is 1 minute or `PT1M` . The maximum value is 5 minutes or `PT5M`. | `string` | `"PT1M"` | no |
| <a name="input_max_delivery_count"></a> [max_delivery_count](#input_max_delivery_count) | (Required) The maximum number of deliveries. Value can range from `1` to `2000` | `number` | n/a | yes |
| <a name="input_name"></a> [name](#input_name) | (Optional) Specifies the name of the ServiceBus Subscription resource. If not provided, the resource name is created leveraging LSEG variables as per standard naming convention. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_requires_session"></a> [requires_session](#input_requires_session) | (Optional) Boolean flag which controls whether this Subscription supports the concept of a session. By default is true, can be false in case FIFO is not required for the specific use case. | `bool` | `true` | no |
| <a name="input_status"></a> [status](#input_status) | (Optional) The status of the Subscription. Possible values are `Active`, `ReceiveDisabled`, or `Disabled`. Defaults to `Active`. | `string` | `"Active"` | no |
| <a name="input_subscription_rules"></a> [subscription_rules](#input_subscription_rules) | (Optional) A map of servicebus_topic_authorization_rule object as defined below. This creates a `azurerm_servicebus_topic_authorization_rule` for each item in the map:<br/>Key   = "(Required) Specifies the name of the ServiceBus Subscription Rule. Changing this forces a new resource to be created."<br/>Value = object({<br/>  filter_type        = "(Required) Type of filter to be applied to a BrokeredMessage. Possible values are `SqlFilter` and `CorrelationFilter`."<br/>  sql_filter         = "(Optional) Represents a filter written in SQL language-based syntax that to be evaluated against a BrokeredMessage. Required when filter_type is set to SqlFilter."<br/>  action             = "(Optional) Represents set of actions written in SQL language-based syntax that is performed against a BrokeredMessage."<br/>  correlation_filter = "(Optional) A correlation_filter block as documented below to be evaluated against a BrokeredMessage. Required when filter_type is set to `CorrelationFilter`.<br/>    Object({<br/>      content_type        = "(Optional) Content type of the message."<br/>      correlation_id      = "(Optional) Identifier of the correlation."<br/>      label               = "(Optional) Application specific label."<br/>      message_id          = "(Optional) Identifier of the message."<br/>      reply_to            = "(Optional) Address of the queue to reply to."<br/>      reply_to_session_id = "(Optional) Session identifier to reply to."<br/>      session_id          = "(Optional) Session identifier."<br/>      to                  = "(Optional) Address to send to."<br/>      properties          = "(Optional) A list of user defined properties to be included in the filter. Specified as a map of name/value pairs."<br/>    })<br/>}) | <pre>map(object({<br/>    filter_type = string<br/>    sql_filter  = optional(string)<br/>    action      = optional(string)<br/>    correlation_filter = optional(object({<br/>      content_type        = optional(string)<br/>      correlation_id      = optional(string)<br/>      label               = optional(string)<br/>      message_id          = optional(string)<br/>      reply_to            = optional(string)<br/>      reply_to_session_id = optional(string)<br/>      session_id          = optional(string)<br/>      to                  = optional(string)<br/>      properties          = optional(map(string))<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_topic_id"></a> [topic_id](#input_topic_id) | (Required) The ID of the ServiceBus Topic to create this Subscription in. Changing this forces a new resource to be created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The ID of the Service Bus Subscription created. |
| <a name="output_name"></a> [name](#output_name) | The Name of the Service Bus Subscription created. |
| <a name="output_resource"></a> [resource](#output_resource) | The Service Bus Subscription resource created. |
<!-- END_TF_DOCS -->
