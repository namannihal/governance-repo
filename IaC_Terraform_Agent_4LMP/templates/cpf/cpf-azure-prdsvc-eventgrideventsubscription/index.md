---
version: 2.0.1
available_versions:
  - 2.0.1
  - 2.0.0
  - 1.1.0
  - 1.0.1
  - 1.0.0
---

<!-- BEGIN_TF_DOCS -->
# Event Grid Event Subscription module

## Overview

This terraform module creates a Event Grid Event Subscription, Event Grid System Topic Event Subscription and associated resources based on the value of create_event_subscription and create_system_topic_event_subscription variables respectively.

## Prerequisites

- `Resource Group` as needed or to be called as module if not existing.
- If `create_system_topic_event_subscription` to `True` then create a custom topic
- If `create_event_subscription` to `True` then create a system topic
- One of `azure_function_endpoint`, `eventhub_endpoint_id`, `hybrid_connection_endpoint`, `hybrid_connection_endpoint_id`, `service_bus_queue_endpoint_id`, `service_bus_topic_endpoint_id`, `storage_queue_endpoint` or `webhook_endpoint` must be specified for endpoint for subscription.

## Guidance

#### Usage

- Event Grid enables you to build event-driven solutions where a publisher service announces its system state changes (events) to subscriber applications.
- Event Grid can be configured to send events to subscribers (push delivery) or subscribers can connect to Event Grid to read events (pull delivery). An event handler is the place where the event is sent. The handler takes some further action to process the event
- Supported event handlers are Azure functions, Event Hubs, Service Bus queues and topics, Relay hybrid connections, Storage queues
- Set `create_system_topic_event_subscription` to `True` if System Topic based Event Subscription to be created
- Set `create_event_subscription` to `True` if Event Subscription to be created for other topics
- If both kind of subscriptions are required for System and Other topics, then set both `create_system_topic_event_subscription` and `create_event_subscription` to `True`
- One of `azure_function_endpoint`, `eventhub_endpoint_id`, `hybrid_connection_endpoint`, `hybrid_connection_endpoint_id`, `service_bus_queue_endpoint_id`, `service_bus_topic_endpoint_id`, `storage_queue_endpoint` or `webhook_endpoint` must be specified.
- `storage_blob_dead_letter_destination` must be specified when a `dead_letter_identity` is specified
- A maximum of total number of `advanced filter` values allowed on event subscription is 25.
- `delivery_property` blocks are only effective when using an `azure_function_endpoint`, `eventhub_endpoint_id`, `hybrid_connection_endpoint_id`, `service_bus_topic_endpoint_id`, or `webhook_endpoint` endpoint specification.

#### Security Considerations

#### Additional Information

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-EGS-SC_010 | Event Grid Custom Topic Event Subscriptions must only connect to Event Grid Custom Topics that belong to the same environment | Event Grid Custom Topic Event Subscriptions must only connect to Event Grid Custom Topics that belong to the same environment (e.g. prod <-> prod, dev <-> dev) (What) within Event Subscription settings (How) to reduce the risk of data exfiltration and unauthorised system access (Why) | False | False | Control cannot be implemented by technical configuration. |
| 2. | AZU-EGS-SC_020 | Headers containing secrets must have the secret flag enabled | Headers containing secrets must have the secret flag enabled (What) in Delivery properties (How) to prevent secrets being visible in the Azure portal (Why) | False | False | Control cannot be implemented by technical configuration. |

## Changelog

- [azure-prdsvc-terraform-eventgrideventsubscription](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/event-grid/concepts)
- [Event Handlers](https://learn.microsoft.com/en-us/azure/event-grid/event-handlers)
- [Event Subscriptions](https://learn.microsoft.com/en-us/azure/event-grid/concepts#event-subscriptions)
- [Event Grid Subscription](https://learn.microsoft.com/en-us/azure/event-grid/subscribe-through-portal)

### Terraform Docs

- [azurerm_eventgrid_event_subscription](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_event_subscription)
- [azurerm_eventgrid_system_topic_event_subscription](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_system_topic_event_subscription)

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
| [azurerm_eventgrid_event_subscription.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_event_subscription) | resource |
| [azurerm_eventgrid_system_topic_event_subscription.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_system_topic_event_subscription) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_advanced_filter"></a> [advanced_filter](#input_advanced_filter) | (Optional) Specifies the advanced filter for the event subscription:<br/>    bool_equals                   = "(Optional) Compares a value of an event using a single boolean value."<br/>    number_greater_than           = "(Optional) Compares a value of an event using a single floating point number."<br/>    number_greater_than_or_equals = "(Optional) Compares a value of an event using a single floating point number."<br/>    number_less_than              = "(Optional) Compares a value of an event using a single floating point number."<br/>    number_less_than_or_equals    = "(Optional) Compares a value of an event using a single floating point number."<br/>    number_in                     = "(Optional) Compares a value of an event using multiple floating point numbers."<br/>    number_not_in                 = "(Optional) Compares a value of an event using multiple floating point numbers."<br/>    number_in_range               = "(Optional) Compares a value of an event using multiple floating point number ranges."<br/>    number_not_in_range           = "(Optional) Compares a value of an event using multiple floating point number ranges."<br/>    string_begins_with            = "(Optional) Compares a value of an event using multiple string values."<br/>    string_not_begins_with        = "(Optional) Compares a value of an event using multiple string values."<br/>    string_ends_with              = "(Optional) Compares a value of an event using multiple string values."<br/>    string_not_ends_with          = "(Optional) Compares a value of an event using multiple string values."<br/>    string_contains               = "(Optional) Compares a value of an event using multiple string values."<br/>    string_not_contains           = "(Optional) Compares a value of an event using multiple string values."<br/>    string_in                     = "(Optional) Compares a value of an event using multiple string values."<br/>    string_not_in                 = "(Optional) Compares a value of an event using multiple string values."<br/>    is_not_null                   = "(Optional) Evaluates if a value of an event isn't NULL or undefined."<br/>    is_null_or_undefined          = "(Optional) Evaluates if a value of an event is NULL or undefined." | <pre>object({<br/>    bool_equals = optional(map(object({<br/>      key   = string<br/>      value = bool<br/>    })), null)<br/>    number_greater_than = optional(map(object({<br/>      key   = string<br/>      value = number<br/>    })), null)<br/>    number_greater_than_or_equals = optional(map(object({<br/>      key   = string<br/>      value = number<br/>    })), null)<br/>    number_less_than = optional(map(object({<br/>      key   = string<br/>      value = number<br/>    })), null)<br/>    number_less_than_or_equals = optional(map(object({<br/>      key   = string<br/>      value = number<br/>    })), null)<br/>    number_in = optional(map(object({<br/>      key    = string<br/>      values = list(number)<br/>    })), null)<br/>    number_not_in = optional(map(object({<br/>      key    = string<br/>      values = list(number)<br/>    })), null)<br/>    number_in_range = optional(map(object({<br/>      key    = string<br/>      values = list(list(number))<br/>    })), null)<br/>    number_not_in_range = optional(map(object({<br/>      key    = string<br/>      values = list(list(number))<br/>    })), null)<br/>    string_begins_with = optional(map(object({<br/>      key    = string<br/>      values = list(string)<br/>    })), null)<br/>    string_not_begins_with = optional(map(object({<br/>      key    = string<br/>      values = list(string)<br/>    })), null)<br/>    string_ends_with = optional(map(object({<br/>      key    = string<br/>      values = list(string)<br/>    })), null)<br/>    string_not_ends_with = optional(map(object({<br/>      key    = string<br/>      values = list(string)<br/>    })), null)<br/>    string_contains = optional(map(object({<br/>      key    = string<br/>      values = list(string)<br/>    })), null)<br/>    string_not_contains = optional(map(object({<br/>      key    = string<br/>      values = list(string)<br/>    })), null)<br/>    string_in = optional(map(object({<br/>      key    = string<br/>      values = list(string)<br/>    })), null)<br/>    string_not_in = optional(map(object({<br/>      key    = string<br/>      values = list(string)<br/>    })), null)<br/>    is_not_null = optional(map(object({<br/>      key = string<br/>    })), null)<br/>    is_null_or_undefined = optional(map(object({<br/>      key = string<br/>    })), null)<br/>  })</pre> | `null` | no |
| <a name="input_advanced_filtering_on_arrays_enabled"></a> [advanced_filtering_on_arrays_enabled](#input_advanced_filtering_on_arrays_enabled) | (Optional) Specifies whether advanced filters should be evaluated against an array of values instead of expecting a singular value. Defaults to false. | `bool` | `false` | no |
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_azure_function_endpoint"></a> [azure_function_endpoint](#input_azure_function_endpoint) | (Optional) Specifies the function endpoint details to which the event subscription should be created.<br/>    function_id                       = "(Required) Specifies the ID of the Function where the Event Subscription will receive events. This must be the functions ID in format {function_app.id}/functions/{name}."<br/>    max_events_per_batch              = "(Optional) Maximum number of events per batch."<br/>    preferred_batch_size_in_kilobytes = "(Optional) Preferred batch size in Kilobytes." | <pre>object({<br/>    function_id                       = string<br/>    max_events_per_batch              = optional(number)<br/>    preferred_batch_size_in_kilobytes = optional(number)<br/>  })</pre> | `null` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_create_event_subscription"></a> [create_event_subscription](#input_create_event_subscription) | (Optional) Specifies whether to create Event Subscription. Defaults to false. | `bool` | `false` | no |
| <a name="input_create_system_topic_event_subscription"></a> [create_system_topic_event_subscription](#input_create_system_topic_event_subscription) | (Optional) Specifies whether to create a System Topic Event Subscription. Defaults to false. | `bool` | `false` | no |
| <a name="input_dead_letter_identity"></a> [dead_letter_identity](#input_dead_letter_identity) | (Optional) Specifies the identity details for the event subscription:<br/>    type                   = "(Required) Specifies the type of Managed Service Identity that is used for dead lettering. Allowed value is SystemAssigned, UserAssigned."<br/>    user_assigned_identity = "(Optional) The user identity associated with the resource." | <pre>object({<br/>    type                   = string<br/>    user_assigned_identity = optional(string, null)<br/>  })</pre> | `null` | no |
| <a name="input_delivery_identity"></a> [delivery_identity](#input_delivery_identity) | (Optional) Specifies the identity details for the event subscription:<br/>    type                   = "(Required) Specifies the type of Managed Service Identity that is used for event delivery. Allowed value is SystemAssigned, UserAssigned."<br/>    user_assigned_identity = "(Optional) The user identity associated with the resource." | <pre>object({<br/>    type                   = string<br/>    user_assigned_identity = optional(string, null)<br/>  })</pre> | `null` | no |
| <a name="input_delivery_property"></a> [delivery_property](#input_delivery_property) | (Optional) Specifies the delivery property details for the event subscription:<br/>    header_name  = "(Required) The name of the header to send on to the destination"<br/>    type         = "(Required) Either Static or Dynamic"<br/>    value        = "(Optional) If the type is Static, then provide the value to use"<br/>    source_field = "(Optional) If the type is Dynamic, then provide the payload field to be used as the value. Valid source fields differ by subscription type."<br/>    secret       = "(Optional) True if the value is a secret and should be protected, otherwise false. If True, then this value won't be returned from Azure API calls" | <pre>object({<br/>    header_name  = string<br/>    type         = string<br/>    value        = optional(string)<br/>    source_field = optional(string)<br/>    secret       = optional(bool)<br/>  })</pre> | <pre>{<br/>  "header_name": "header",<br/>  "secret": false,<br/>  "source_field": null,<br/>  "type": "Static",<br/>  "value": null<br/>}</pre> | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_event_delivery_schema"></a> [event_delivery_schema](#input_event_delivery_schema) | (Optional) Specifies the event delivery schema for the event subscription. Possible values include: EventGridSchema, CloudEventSchemaV1_0, CustomInputSchema. Defaults to EventGridSchema. Changing this forces a new resource to be created. | `string` | `"EventGridSchema"` | no |
| <a name="input_expiration_time_utc"></a> [expiration_time_utc](#input_expiration_time_utc) | (Optional) Specifies the expiration time of the event subscription (Datetime Format RFC 3339). | `string` | `null` | no |
| <a name="input_included_event_types"></a> [included_event_types](#input_included_event_types) | (Optional) A list of applicable event types that need to be part of the event subscription. | `list(string)` | `[]` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_labels"></a> [labels](#input_labels) | (Optional) A list of labels to assign to the event subscription. | `list(string)` | `[]` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_resource_endpoint"></a> [resource_endpoint](#input_resource_endpoint) | (Optional) Specifies the resource id of the endpoint to which the event subscription should be created.<br/>    eventhub_endpoint_id          = "(Optional) Specifies the id where the Event Hub is located."<br/>    hybrid_connection_endpoint_id = "(Optional) Specifies the id where the Hybrid Connection is located."<br/>    service_bus_queue_endpoint_id = "(Optional) Specifies the id where the Service Bus Queue is located."<br/>    service_bus_topic_endpoint_id = "(Optional) Specifies the id where the Service Bus Topic is located." | <pre>object({<br/>    eventhub_endpoint_id          = optional(string)<br/>    hybrid_connection_endpoint_id = optional(string)<br/>    service_bus_queue_endpoint_id = optional(string)<br/>    service_bus_topic_endpoint_id = optional(string)<br/>  })</pre> | <pre>{<br/>  "eventhub_endpoint_id": null,<br/>  "hybrid_connection_endpoint_id": null,<br/>  "service_bus_queue_endpoint_id": null,<br/>  "service_bus_topic_endpoint_id": null<br/>}</pre> | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_retry_policy"></a> [retry_policy](#input_retry_policy) | (Optional) Specifies the retry policy for the event subscription:<br/>    max_delivery_attempts = "(Required) Specifies the maximum number of delivery retry attempts for events."<br/>    event_time_to_live    = "(Required) Specifies the time to live (in minutes) for events. Supported range is 1 to 1440." | <pre>object({<br/>    max_delivery_attempts = number<br/>    event_time_to_live    = number<br/>  })</pre> | `null` | no |
| <a name="input_scope"></a> [scope](#input_scope) | (Optional) Specifies the scope at which the EventGrid Event Subscription should be created. Changing this forces a new resource to be created. Required, if create_event_subscription is set to True | `string` | `null` | no |
| <a name="input_storage_blob_dead_letter_destination"></a> [storage_blob_dead_letter_destination](#input_storage_blob_dead_letter_destination) | (Optional) Specifies the storage blob dead letter destination details for the event subscription:<br/>    storage_account_id          = "(Optional) Specifies the id of the storage account id where the storage blob is located."<br/>    storage_blob_container_name = "(Optional) Specifies the name of the Storage blob container that is the destination of the deadletter events." | <pre>object({<br/>    storage_account_id          = optional(string, null)<br/>    storage_blob_container_name = optional(string, null)<br/>  })</pre> | `null` | no |
| <a name="input_storage_queue_endpoint"></a> [storage_queue_endpoint](#input_storage_queue_endpoint) | (Optional) Specifies the storage queue endpoint details to which the event subscription should be created.<br/>    storage_account_id                    = "(Required) Specifies the id of the storage account id where the storage queue is located."<br/>    queue_name                            = "(Required) Specifies the name of the storage queue where the Event Subscription will receive events."<br/>    queue_message_time_to_live_in_seconds = "(Optional) Storage queue message time to live in seconds." | <pre>object({<br/>    storage_account_id                    = string<br/>    queue_name                            = string<br/>    queue_message_time_to_live_in_seconds = optional(number, null)<br/>  })</pre> | `null` | no |
| <a name="input_subject_filter"></a> [subject_filter](#input_subject_filter) | (Optional) Specifies the subject filter for the event subscription:<br/>    subject_begins_with = "(Optional) An optional string to filter events for an event subscription based on a resource path prefix. Wildcard characters are not supported."<br/>    subject_ends_with   = "(Optional) A string to filter events for an event subscription based on a resource path suffix."<br/>    case_sensitive      = "(Optional) Specifies if subject_begins_with and subject_ends_with case sensitive." | <pre>object({<br/>    subject_begins_with = optional(string)<br/>    subject_ends_with   = optional(string)<br/>    case_sensitive      = optional(bool)<br/>  })</pre> | `null` | no |
| <a name="input_system_topic"></a> [system_topic](#input_system_topic) | (Optional) The System Topic where the Event Subscription should be created in. Changing this forces a new Event Subscription to be created. Required if create_system_topic_event_subscription is true | `string` | `null` | no |
| <a name="input_webhook_endpoint"></a> [webhook_endpoint](#input_webhook_endpoint) | (Optional) Specifies the webhook endpoint details to which the event subscription should be created.<br/>    url                               = "(Required) Specifies the url of the webhook where the Event Subscription will receive events."<br/>    base_url                          = "(Computed) The base url of the webhook where the Event Subscription will receive events."<br/>    max_events_per_batch              = "(Optional) Maximum number of events per batch."<br/>    preferred_batch_size_in_kilobytes = "(Optional) Preferred batch size in Kilobytes."<br/>    active_directory_tenant_id        = "(Optional) The Azure Active Directory Tenant ID to get the access token that will be included as the bearer token in delivery requests."<br/>    active_directory_app_id_or_uri    = "(Optional) The Azure Active Directory Application ID or URI to get the access token that will be included as the bearer token in delivery requests." | <pre>object({<br/>    url                               = string<br/>    base_url                          = optional(string, null)<br/>    max_events_per_batch              = optional(number, null)<br/>    preferred_batch_size_in_kilobytes = optional(number, null)<br/>    active_directory_tenant_id        = optional(string, null)<br/>    active_directory_app_id_or_uri    = optional(string, null)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_event_subscription_id"></a> [event_subscription_id](#output_event_subscription_id) | The ID of the Event Grid Event Subscription. |
| <a name="output_event_subscription_name"></a> [event_subscription_name](#output_event_subscription_name) | The name of the Event Grid Event Subscription. |
| <a name="output_event_subscription_resource"></a> [event_subscription_resource](#output_event_subscription_resource) | The Event Grid Event Subscription resource. |
| <a name="output_system_topic_event_subscription_id"></a> [system_topic_event_subscription_id](#output_system_topic_event_subscription_id) | The ID of the Event Grid System Topic Subscription. |
| <a name="output_system_topic_event_subscription_name"></a> [system_topic_event_subscription_name](#output_system_topic_event_subscription_name) | The name of the Event Grid System Topic Event Subscription. |
| <a name="output_system_topic_event_subscription_resource"></a> [system_topic_event_subscription_resource](#output_system_topic_event_subscription_resource) | The Event Grid System Topic Event Subscription resource. |
| <a name="output_system_topic_name"></a> [system_topic_name](#output_system_topic_name) | The name of the Event Grid System Topic. |
| <a name="output_topic_name"></a> [topic_name](#output_topic_name) | The name of the Event Grid Event Subscription. |
<!-- END_TF_DOCS -->
