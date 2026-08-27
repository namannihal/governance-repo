---
version: 1.1.1
available_versions:
  - 1.1.1
  - 1.1.0
  - 1.0.2
  - 1.0.1
  - 1.0.0
---

<!-- BEGIN_TF_DOCS -->
# Azure Monitor Data Collection rule


## Overview

This Terraform module provisions an Azure Monitor Data Collection Rule and Data Collection Rule Assocations, which defines how telemetry and log data are collected from Azure resources. The module can be configured to specify data sources, destinations (such as Log Analytics Workspaces), and transformation rules, enabling flexible and centralized monitoring across Azure environment.

## Prerequisites

To use this module, ensure the following prerequisites are met:

- An existing **Resource Group** in Azure to host the Log Analytics Workspace.
- An existing **Log Analytics Workspace** for collecting and analyzing monitoring data.

## Guidance

#### Usage

#### Security Considerations

#### Additional Information

- Data Collection Endpoint (DCE) is currently not enabled, so Prometheus and Windows Firewall logs data sources are not configured. These data sources will be added when DCE support is enabled.

## Security Controls

| S. No. | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
| ------ | ---------- | --------------| ----------- | ----------- | ------------------- | -------- |
| 1. | AZU-DCR-IA_010 | Use a Managed Identity for accessing Azure Resources| Data Collection Rules must enforce the use of a Managed Identity to authenticate to Azure resources where this is supported (What) within targets Access control settings (How) in order to remove the need to store credentials (Why) | True | True | Control implemented by identity block to enforce manage identity configuration |
| 2. | AZU-DCR-AC_010 |  Data Collection Rules must ensure log, metrics and trace destinations are appropriately secure, approved and within LSEG Entra ID tenants |  Data Collection Rules must ensure log, metrics and trace destinations are appropriately secure, approved and within LSEG Entra ID tenants (What) within Data sources configuration (How) in order to prevent unauthorised access and data exposure to external parties (Why) | False | False | Control implemented by technical configuration setting:False.|
| 3. | AZU-DCR-SC_010 |  Data Collection Rule Associations must only send logs within the same environment |  Data Collection Rule Associations must only send logs within the same environment (e.g. prod <-> prod, dev <-> dev) (What) within Resources settings (How) to reduce the risk of data exfiltration (Why) | False | False | Control implemented by technical configuration setting:False.|

## Changelog

- [azure-prdsvc-terraform-monitordatacollectionrule](CHANGELOG.md)

## References

### Microsoft Docs

- [Data collection rules (DCRs)](https://learn.microsoft.com/en-us/azure/azure-monitor/data-collection/data-collection-rule-overview)

### Terraform Docs

- [azure-prdsvc-terraform-monitordatacollectionrule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_data_collection_rule)

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
| [azurerm_monitor_data_collection_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_data_collection_rule) | resource |
| [azurerm_monitor_data_collection_rule_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_data_collection_rule_association) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_association_targets"></a> [association_targets](#input_association_targets) | (Optional) List of target resources for Data Collection Rule associations.<br/>  target_resource_id = "(Required) Resource ID of the target to associate with the DCR."<br/>  description        = "(Optional) Description for the association target." | <pre>list(object({<br/>    target_resource_id = string<br/>    description        = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_data_collection_endpoint_id"></a> [data_collection_endpoint_id](#input_data_collection_endpoint_id) | (Optional) Resource ID of the Data Collection Endpoint (DCE) to attach to the Data Collection Rule. Required when using logfiles/iislogs/windowsfirewalllogs data sources. | `string` | `null` | no |
| <a name="input_data_flow"></a> [data_flow](#input_data_flow) | (Required) A data flow in a Data Collection Rule defines how collected data streams are routed and optionally transformed before being sent to specified destinations.<br/>object({<br/>  destinations = "(Required) List of destination names where the data streams are sent."<br/>  streams = "(Required) List of streams to route in the data flow."<br/>  built_in_transform = "(Optional) Built-in transformation for the data flow."  <br/>  output_stream = "(Optional) Output stream after transformation for the data flow."<br/>  transform_kql = "(Optional) KQL query to transform the data before transformation."<br/>}) | <pre>list(object({<br/>    destinations       = list(string)<br/>    streams            = list(string)<br/>    built_in_transform = optional(string, null)<br/>    output_stream      = optional(string, null)<br/>    transform_kql      = optional(string, null)<br/>  }))</pre> | `[]` | no |
| <a name="input_data_sources"></a> [data_sources](#input_data_sources) | (Optional) Data sources configuration for the Monitor Data Collection Rule.<br/>object({<br/>  data_import = optional(list(object({<br/>    event_hub_data_source = list(object({<br/>      name           = "(Required) Name of the Event Hub data source."<br/>      stream         = "(Required) Stream name for the Event Hub data source."<br/>      consumer_group = "(Optional) Consumer group for the Event Hub data source."<br/>    }))<br/>  })))<br/>  extension = optional(list(object({<br/>    extension_name     = "(Required) Name of the extension."<br/>    name               = "(Required) Name of the extension data source."<br/>    streams            = "(Required) List of streams for the extension."    <br/>    extension_json     = "(Optional) JSON configuration for the extension."<br/>    input_data_sources = "(Optional) List of input data sources for the extension."<br/>  })))<br/>  iis_log = optional(list(object({<br/>    name            = "(Required) Name of the IIS log data source."<br/>    streams         = "(Required) List of streams for the IIS log."<br/>    log_directories = "(Optional) List of log directories for the IIS log."<br/>  })))<br/>  log_file = optional(list(object({<br/>    name          = "(Required) Name of the log file data source."<br/>    streams       = "(Required) List of streams for the log file."<br/>    file_patterns = "(Required) List of file patterns for the log file."<br/>    format        = "(Required) Format of the log file."<br/>    settings = (Optional)object({<br/>      text = object({<br/>        record_start_timestamp_format = "(Required) Timestamp format for the start of each record."<br/>      })<br/>    })<br/>  })))<br/>  performance_counter = optional(list(object({<br/>    counter_specifiers            = "(Required) List of counter specifiers."<br/>    name                          = "(Required) Name of the performance counter data source."<br/>    sampling_frequency_in_seconds = "(Required) Sampling frequency in seconds."<br/>    streams                       = "(Required) List of streams for the performance counter."<br/>  })))<br/>  platform_telemetry = optional(list(object({<br/>    name    = "(Required) Name of the platform telemetry data source."<br/>    streams = "(Required) List of streams for the platform telemetry."<br/>  })))<br/>  syslog = optional(list(object({<br/>    facility_names = "(Required) List of facility names for syslog."<br/>    log_levels     = "(Required) List of log levels for syslog."<br/>    name           = "(Required) Name of the syslog data source."<br/>    streams        = "(Optional) List of streams for syslog."<br/>  })))<br/>  windows_event_log = optional(list(object({<br/>    name           = "(Required) Name of the Windows event log data source."<br/>    streams        = "(Required) List of streams for the Windows event log."<br/>    x_path_queries = "(Required) List of XPath queries for the Windows event log."<br/>  })))<br/>}) | <pre>object({<br/>    data_import = optional(list(object({<br/>      event_hub_data_source = list(object({<br/>        name           = string<br/>        stream         = string<br/>        consumer_group = optional(string, null)<br/>      }))<br/>    })), null)<br/>    extension = optional(list(object({<br/>      extension_name     = string<br/>      name               = string<br/>      streams            = list(string)<br/>      extension_json     = optional(string, null)<br/>      input_data_sources = optional(list(string), null)<br/>    })), null)<br/>    iis_log = optional(list(object({<br/>      name            = string<br/>      streams         = list(string)<br/>      log_directories = optional(list(string), null)<br/>    })), null)<br/>    log_file = optional(list(object({<br/>      name          = string<br/>      streams       = list(string)<br/>      file_patterns = list(string)<br/>      format        = string<br/>      settings = optional(object({<br/>        text = object({<br/>          record_start_timestamp_format = string<br/>        })<br/>      }), null)<br/>    })), null)<br/>    performance_counter = optional(list(object({<br/>      counter_specifiers            = list(string)<br/>      name                          = string<br/>      sampling_frequency_in_seconds = number<br/>      streams                       = list(string)<br/>    })), null)<br/>    platform_telemetry = optional(list(object({<br/>      name    = string<br/>      streams = list(string)<br/>    })), null)<br/>    syslog = optional(list(object({<br/>      facility_names = list(string)<br/>      log_levels     = list(string)<br/>      name           = string<br/>      streams        = optional(list(string), null)<br/>    })), null)<br/>    windows_event_log = optional(list(object({<br/>      name           = string<br/>      streams        = list(string)<br/>      x_path_queries = list(string)<br/>    })), null)<br/>  })</pre> | `null` | no |
| <a name="input_description"></a> [description](#input_description) | (Optional) Description of the Data Collection Rule. | `string` | `null` | no |
| <a name="input_destinations"></a> [destinations](#input_destinations) | (Optional) Destinations configuration for the Monitor Data Collection Rule.<br/>object({<br/>  azure_monitor_metrics = optional(list(object({<br/>    name = "(Required) Name of the Azure Monitor Metrics destination."<br/>  })))<br/>  event_hub = optional(list(object({<br/>    name                = "(Required) Name of the Event Hub destination."<br/>    event_hub_id       = "(Required) Resource ID of the Event Hub."  <br/>  })))<br/>  event_hub_direct = optional(list(object({<br/>    name                = "(Required) Name of the Event Hub destination."<br/>    event_hub_id       = "(Required) Resource ID of the Event Hub."<br/>  }))<br/>  log_analytics = optional(list(object({<br/>    name                  = "(Required) Name of the Log Analytics destination."<br/>    workspace_resource_id = "(Required) Resource ID of the Log Analytics workspace."<br/>  })))<br/>  monitor_account = optional(list(object({<br/>    monitor_account_id    = "(Required) Resource ID of the Monitor Account."<br/>    name                  = "(Required) Name of the Monitor Account destination."  <br/>  })))<br/>  storage_blob = optional(list(object({<br/>    container_name        = "(Required) Name of the Blob container."<br/>    name                  = "(Required) Name of the Storage Blob destination."<br/>    storage_account_id    = "(Required) Resource ID of the Storage Account."  <br/>  })))<br/>  storage_blob_direct = optional(list(object({<br/>    container_name        = "(Required) Name of the Blob container." <br/>    name                  = "(Required) Name of the Storage Blob destination."<br/>    storage_account_id    = "(Required) Resource ID of the Storage Account."       <br/>  })))<br/>  storage_table_direct = optional(list(object({<br/>    table_name            = "(Required) Name of the Table."<br/>    name                  = "(Required) Name of the Storage Table destination."<br/>    storage_account_id    = "(Required) Resource ID of the Storage Account."<br/>  }))<br/>}) | <pre>object({<br/>    azure_monitor_metrics = optional(list(object({<br/>      name = string<br/>    })), null)<br/>    event_hub = optional(list(object({<br/>      event_hub_id = string<br/>      name         = string<br/>    })), null)<br/>    event_hub_direct = optional(list(object({<br/>      event_hub_id = string<br/>      name         = string<br/>    })), null)<br/>    log_analytics = optional(list(object({<br/>      name                  = string<br/>      workspace_resource_id = string<br/>    })), null)<br/>    monitor_account = optional(list(object({<br/>      monitor_account_id = string<br/>      name               = string<br/>    })), null)<br/>    storage_blob = optional(list(object({<br/>      container_name     = string<br/>      name               = string<br/>      storage_account_id = string<br/>    })), null)<br/>    storage_table_direct = optional(list(object({<br/>      table_name         = string<br/>      name               = string<br/>      storage_account_id = string<br/>    })), null)<br/>    storage_blob_direct = optional(list(object({<br/>      name               = string<br/>      storage_account_id = string<br/>      container_name     = string<br/>    })), null)<br/>  })</pre> | `{}` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_identity"></a> [identity](#input_identity) | (Optional) An identity block as defined below<br/>object({<br/>  type         = "(Required) Specifies the type of Managed Service Identity that should be configured on this Recovery Services Vault. Possible values are `SystemAssigned`, `UserAssigned`."<br/>  identity_ids = "(Optional) A list of User Assigned Managed Identity IDs to be assigned to this Data Collection Rule. Currently, up to 1 identity is supported.. This is required when `type` is set to `UserAssigned`"<br/>}) | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | <pre>{<br/>  "identity_ids": null,<br/>  "type": "SystemAssigned"<br/>}</pre> | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_kind"></a> [kind](#input_kind) | (Optional) The kind of the Data Collection Rule. Possible values are 'Linux', 'Windows', 'AgentDirectToStore', and 'WorkspaceTransforms'. A rule of kind 'Linux' does not allow for windows_event_log data sources. A rule of kind 'Windows' does not allow for syslog data sources. If kind is not specified, all kinds of data sources are allowed. | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) The Azure Region where the Data Collection Rule should exist. Changing this forces a new Data Collection Rule to be created. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) A three letter code representing organization, tenant, or CSP. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) The name of the Resource Group where the Data Collection Rule is created. Changing this forces a new Data Collection Rule to be created. | `string` | n/a | yes |
| <a name="input_stream_declarations"></a> [stream_declarations](#input_stream_declarations) | (Optional) Stream declaration configuration for the Monitor Data Collection Rule.<br/>list(object({<br/>  stream_name = "(Required) Name of the stream."<br/>  columns     = "(Required) List of columns for the stream. Each column has a name and type."<br/>    columns = list(object({<br/>      name = "(Required) Name of the column."<br/>      type = "(Required) Type of the column."<br/>    }))<br/>})) | <pre>list(object({<br/>    stream_name = string<br/>    columns = list(object({<br/>      name = string<br/>      type = string<br/>    }))<br/>  }))</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azurerm_monitor_data_collection_rule_association_id"></a> [azurerm_monitor_data_collection_rule_association_id](#output_azurerm_monitor_data_collection_rule_association_id) | The Resource IDs of the Monitor Data Collection Rule Associations. |
| <a name="output_id"></a> [id](#output_id) | The Resource ID of the Monitor Data Collection Rule. |
| <a name="output_name"></a> [name](#output_name) | The Name of the Monitor Data Collection Rule. |
| <a name="output_resource"></a> [resource](#output_resource) | The Monitor Data Collection Rule resource. |
<!-- END_TF_DOCS -->
