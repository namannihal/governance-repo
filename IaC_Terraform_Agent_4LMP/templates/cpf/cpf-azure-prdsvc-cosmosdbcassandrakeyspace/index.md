---
version: 1.0.1
available_versions:
  - 1.0.1
  - 1.0.0
  - 0.1.0
---

<!-- BEGIN_TF_DOCS -->
# CosmosDb Cassandra Keyspace module


## Overview

- In Apache Cassandra, a distributed NoSQL database, a keyspace is the top-level namespace that defines data replication and acts as a container for tables.
- This terraform module creates cosmosDb Cassandra Keyspace.

## Prerequisites

- CosmosDb Cassandra Keyspace is a child resource of Cosmos DB Account. A Cosmos DB Account parent resource and related
  dependencies must be existing before deploying a Cosmos DB SQL Container. That includes:
  - `Resource Group`, `Virtual Network` (To be called if not existing).
  - `Subnet` to be used by the Private Endpoint.
  - `Network Security Group` to be associated with the Subnet.
  - `Route Table` to be associated with the Subnet.
  - `Key Vault` to store Cosmos DB Account Customer Managed Key (CMK) encryption.
  - `Private Endpoint` to create a private connection to the Key Vault and the Cosmos DB Account.
  - `User Assigned Identity` to be leveraged for both the Cosmos DB Account identity and CMK   encryption.
  - `Cosmos DB Account` is a mandatory parent resource.

## Guidance

#### Usage
-  The Cassandra keyspace is a namespace that defines how data is replicated on nodes. Typically, a cluster has one
   keyspace per application.
- Replication is controlled on a per-keyspace basis, so data that has different replication requirements typically
  resides in different keyspaces.
- Keyspaces are not designed to be used as a significant map layer within the data model.
- Keyspaces are designed to control data replication for a set of table.
- This module deploys cosmosDb Cassandra Keyspace.

#### Security Considerations
Currently, as per LSEG Approved CosmosDb Cassandra Keyspace
[Requirements](https://gitlab.dx1.lseg.com/app/app-51285/cloud-security-controls/azure-clear-listing/-/blob/main/azure/services/Microsoft.DocumentDB/databaseAccounts_kind_GlobalDocumentDB/v2.1.0/markdown/serviceControls.md?ref_type=heads#CDBNSQL-IA_010),
there are no security controls for this product. All the controls are related to Cosmos DB.

#### Additional Information

## Security Controls

## Changelog
[azure-prdsvc-terraform-cassandrakeyspace](../CHANGELOG.md)

## References

### Microsoft Docs
- [Cassandra](https://learn.microsoft.com/en-us/azure/cosmos-db/cassandra/overview)

### Terraform Docs  
- [azurerm_cosmosdb_cassandra_keyspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_cassandra_keyspace)

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
| [azurerm_cosmosdb_cassandra_keyspace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_cassandra_keyspace) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_cosmosdb"></a> [cosmosdb](#input_cosmosdb) | (Required) The name of the CosmosDb Cassandra Keyspace to create the table within. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_enable_autoscale_settings"></a> [enable_autoscale_settings](#input_enable_autoscale_settings) | Enable Autoscale settings. Allowed values are true and false. Default is false.  This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_max_throughput"></a> [max_throughput](#input_max_throughput) | (Optional) The maximum throughput of the CosmosDb Cassandra Keyspace (RU/s). Must be between 1,000 and 1,000,000. Must be set in increments of 1,000. Conflicts with throughput. | `number` | `1000` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_table_throughput"></a> [table_throughput](#input_table_throughput) | (Required) The throughput of CosmosDb Cassandra Keyspace (RU/s). Must be set in increments of 100. The minimum value is 400. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply. | `number` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The Resource Id of the cosmosDb Cassandra Keyspace. |
| <a name="output_name"></a> [name](#output_name) | The name of the cosmosDb Cassandra Keyspace. |
| <a name="output_resource"></a> [resource](#output_resource) | The resource information of the cosmosDb Cassandra Keyspace. |
<!-- END_TF_DOCS -->
