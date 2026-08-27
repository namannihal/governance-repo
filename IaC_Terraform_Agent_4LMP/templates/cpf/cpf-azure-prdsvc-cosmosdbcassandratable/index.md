---
version: 1.0.1
available_versions:
  - 1.0.1
  - 1.0.0
  - 0.1.0
---

<!-- BEGIN_TF_DOCS -->
# CosmosDb Cassandra Table module


## Overview

- In Cassandra, a table is a schema-defined collection of rows organized by a primary key, stored inside a keyspace, and used to hold application data.
- This terraform module creates Cosmosdb Cassandra Table.

## Prerequisites

- Cosmos DB Cassandra Table is a child resource of Cosmos DB Account. A Cosmos DB Account parent resource and related dependencies must be existing before deploying a Cosmos DB SQL Container. That includes:
  - `Resource Group`, `Virtual Network` (To be called if not existing).
  - `Subnet` to be used by the Private Endpoint.
  - `Network Security Group` to be associated with the Subnet.
  - `Route Table` to be associated with the Subnet.
  - `Key Vault` to store Cosmos DB Account Customer Managed Key (CMK) encryption.
  - `Private Endpoint` to create a private connection to the Key Vault and the Cosmos DB Account.
  - `User Assigned Identity` to be leveraged for both the Cosmos DB Account identity and CMK   encryption.
  - `Cosmos DB Account` is mandatory parent resource.
  - `Cassandra Keyspace` is a mandatory parent resource.

## Guidance

#### Usage

- Tables are also called column families in earlier iterations of Cassandra, are defined within the keyspaces.
- Tables store data in a set of rows and contain a primary key and a set of columns.
- This module deploys CosmosDB Cassandra Table.

#### Security Considerations
Currently, as per LSEG Approved Cosmos DB Cassandra Table [Requirements](https://gitlab.dx1.lseg.com/app/app-51285/cloud-security-controls/azure-clear-listing/-/blob/main/azure/services/Microsoft.DocumentDB/databaseAccounts_kind_GlobalDocumentDB/v2.1.0/markdown/serviceControls.md?ref_type=heads#CDBNSQL-IA_010), there are no security controls for this product. All the controls are related to Cosmos DB.

#### Additional Information

## Security Controls

## Changelog
[azure-prdsvc-terraform-cassandratable](../CHANGELOG.md)

## References

### Microsoft Docs
- [Cassandra](https://learn.microsoft.com/en-us/azure/cosmos-db/cassandra/overview)

### Terraform Docs  
- [azurerm_cosmosdb_cassandra_table](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_cassandra_table)

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
| [azurerm_cosmosdb_cassandra_table.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_cassandra_table) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_analytical_storage_ttl"></a> [analytical_storage_ttl](#input_analytical_storage_ttl) | (Optional) Analytical storage TTL in seconds; null to omit. | `number` | `null` | no |
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_autoscale_max_throughput"></a> [autoscale_max_throughput](#input_autoscale_max_throughput) | (Optional) Max RU/s (used when enable_autoscale_settings=true). | `number` | `null` | no |
| <a name="input_cassandra_keyspace_id"></a> [cassandra_keyspace_id](#input_cassandra_keyspace_id) | (Required) The Resource Id of the Cassandra Keyspace | `string` | n/a | yes |
| <a name="input_cluster_keys"></a> [cluster_keys](#input_cluster_keys) | "(Optional) List of columns for a Cosmos DB Cassandra table.<br/>  list(object({<br/>  name  = (Optional) The name of the column as it will appear in the Cassandra table. This should follow Cassandra naming conventions—typically lowercase, using underscores for separation (e.g., `user_id`, `created_at`). It must be unique within the table and clearly represent the data it stores.<br/>  order_by  = (Optional) where order_by is Asc/Desc (any case).<br/>  }))" | <pre>list(object({<br/>    name     = optional(string, null),<br/>    order_by = optional(string, "Asc")<br/>  }))</pre> | `[]` | no |
| <a name="input_columns"></a> [columns](#input_columns) | "(Required) List of columns for a Cosmos DB Cassandra table.<br/>  list(object({<br/>  name  = (Required) The name of the column as it will appear in the Cassandra table. This should follow Cassandra naming conventions—typically lowercase, using underscores for separation (e.g., `user_id`, `created_at`). It must be unique within the table and clearly represent the data it stores.<br/>  type  = (Required) The data type of the column, compatible with Cassandra types such as `text`, `uuid`, `int`, `timestamp`, `boolean`, etc.<br/>  }))" | <pre>list(object({<br/>    name = string<br/>    type = string<br/>  }))</pre> | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_default_ttl"></a> [default_ttl](#input_default_ttl) | (Optional) Default TTL in seconds; null to omit. | `number` | `null` | no |
| <a name="input_enable_table_autoscale_settings"></a> [enable_table_autoscale_settings](#input_enable_table_autoscale_settings) | (Optional) true => use autoscale_settings, false => use manual throughput. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_partition_keys"></a> [partition_keys](#input_partition_keys) | (Required) Partition key column names (composite supported). | `list(string)` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_throughput"></a> [throughput](#input_throughput) | (Required) Manual RU/s (used when enable_autoscale_settings=false). | `number` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The Resource Id of the cassandra table. |
| <a name="output_name"></a> [name](#output_name) | The name of the cassandra table. |
| <a name="output_resource"></a> [resource](#output_resource) | The Resource information of the cassandra table. |
<!-- END_TF_DOCS -->
