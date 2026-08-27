---
version: 1.0.1
available_versions:
  - 1.0.1
  - 1.0.0
  - 0.1.2
  - 0.1.1
  - 0.1.0
---

<!-- BEGIN_TF_DOCS -->
# Azure Data Explorer Kusto Database module


## Overview

This terraform module creates a Azure Data Explorer kusto database and kusto database event hub connection. Databases are named entities that hold tables and stored functions. Kusto follows a relation model of storing the data where the upper-level entity is a database.

Azure Data Explorer offers ingestion from Event Hubs, a big data streaming platform and event ingestion service. Event Hubs can process millions of events per second in near real time.we can establish a connection between the event hub and your Azure Data Explorer table.

## Prerequisites

- This module requires the following pre-existing dependent Azure resources:

- Resource Group, Virtual Network (both modules to be called if not existing, if allowed by the deployment permissions).
- Subnet to be used by the Key Vault Private endpoint.
- Network Security Group to be associated with the Subnet.
- Route Table to be associated with the Subnet.
- Key Vault for resource Customer Managed Key encryption.
- Private Endpoint to create a private connection to the Key Vault.
- User Assigned Identity leveraged for both identity and Customer Managed Key encryption.

## Guidance

#### Usage

- This module creates a Azure Data Explorer kusto database with Event hub database connection.

#### Security Considerations

## Security Controls

- This module doesn't have any approved security controls.

## Changelog

- [azure-prdsvc-terraform-kustodatabase](CHANGELOG.md)

## References

### Microsoft Docs

- [Azure Data Explorer Kusto Databse](https://learn.microsoft.com/en-us/azure/data-explorer/kusto/query/schema-entities/databases)

### Terraform Docs

- [azurerm_kusto_database](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_database)
- [azurerm_kusto_database_principal_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_database_principal_assignment)

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
| [azurerm_kusto_database.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_database) | resource |
| [azurerm_kusto_database_principal_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_database_principal_assignment) | resource |
| [azurerm_kusto_eventhub_data_connection.eventhub_connection](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_eventhub_data_connection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster_name](#input_cluster_name) | (Required) Specifies the name of the Kusto Cluster this database will be added to. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_hot_cache_period"></a> [hot_cache_period](#input_hot_cache_period) | (Optional) The time the data that should be kept in cache for fast queries as ISO 8601 timespan. Default is unlimited. For more information see: ISO 8601 Timespan. | `string` | `null` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_kusto_database_principal_assignments"></a> [kusto_database_principal_assignments](#input_kusto_database_principal_assignments) | (Optional) Configuration for Kusto database Principal assignments is below.<br/>    name           = "(Required) The name of the Kusto database principal assignment. Changing this forces a new resource to be created."<br/>    principal_id   = "(Required) The name of the Kusto database. Changing this forces a new resource to be created."<br/>    principal_type = "(Required) The type of the principal. Valid values include App, Group, User. Changing this forces a new resource to be created."<br/>    role           = "(Required) The database role assigned to the principal.  Valid values include Admin, Ingestor, Monitor, UnrestrictedViewer, User and Viewer. Changing this forces a new resource to be created."<br/>    tenant_id      = "(Required) The tenant id in which the principal resides. Changing this forces a new resource to be created." | <pre>map(object({<br/>    name           = string<br/>    principal_id   = string<br/>    principal_type = string<br/>    role           = string<br/>    tenant_id      = string<br/>  }))</pre> | `{}` | no |
| <a name="input_kusto_eventhub_data_connection"></a> [kusto_eventhub_data_connection](#input_kusto_eventhub_data_connection) | (Optional) Configuration for Kusto Eventhub data connection below.<br/>  name                    = "(Required) The name of the Kusto EventHub Data Connection to create. Changing this forces a new resource to be created."<br/>  cluster_name            = "(Required) Specifies the name of the Kusto Cluster this data connection will be added to. Changing this forces a new resource to be created."<br/>  compression             = "(Optional) Specifies compression type for the connection. Allowed values: GZip and None. Defaults to None. Changing this forces a new resource to be created."<br/>  database_name           = "(Required) Specifies the name of the Kusto Database this data connection will be added to. Changing this forces a new resource to be created."<br/>  eventhub_id             = "(Required) Specifies the resource id of the EventHub this data connection will use for ingestion. Changing this forces a new resource to be created."<br/>  event_system_properties = "(Optional) Specifies a list of system properties for the Event Hub."<br/>  consumer_group          = "(Required) Specifies the EventHub consumer group this data connection will use for ingestion. Changing this forces a new resource to be created."<br/>  table_name              = "(Optional) Specifies the target table name used for the message ingestion. Table must exist before resource is created."<br/>  identity_id             = "(Optional) The resource ID of a managed identity (system or user assigned) to be used to authenticate with event hub."<br/>  mapping_rule_name       = "(Optional) Specifies the mapping rule used for the message ingestion. Mapping rule must exist before resource is created."<br/>  data_format             = "(Optional) Specifies the data format of the EventHub messages. Allowed values: APACHEAVRO, AVRO, CSV, JSON, MULTIJSON, ORC, PARQUET, PSV, RAW, SCSV, SINGLEJSON, SOHSV, TSVE, TSV, TXT, and W3CLOGFILE."<br/>  database_routing_type   = "(Optional) Indication for database routing information from the data connection, by default only database routing information is allowed. Allowed values: Single, Multi. Changing this forces a new resource to be created. Defaults to Single." | <pre>map(object({<br/>    name                    = string<br/>    cluster_name            = string<br/>    eventhub_id             = string<br/>    consumer_group          = string<br/>    compression             = optional(string)<br/>    event_system_properties = optional(list(string))<br/>    table_name              = optional(string)<br/>    identity_id             = optional(string)<br/>    mapping_rule_name       = optional(string)<br/>    data_format             = optional(string)<br/>    database_routing_type   = optional(string)<br/>  }))</pre> | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_soft_delete_period"></a> [soft_delete_period](#input_soft_delete_period) | (Optional) The time the data should be kept before it stops being accessible to queries as ISO 8601 timespan. Default is unlimited. For more information see: ISO 8601 Timespan. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eventhub_ids"></a> [eventhub_ids](#output_eventhub_ids) | The IDs of the Event Hub Connection IDs. |
| <a name="output_id"></a> [id](#output_id) | The Kusto database ID. |
| <a name="output_name"></a> [name](#output_name) | The name of the database. |
| <a name="output_resource"></a> [resource](#output_resource) | The Resource of the database. |
<!-- END_TF_DOCS -->
