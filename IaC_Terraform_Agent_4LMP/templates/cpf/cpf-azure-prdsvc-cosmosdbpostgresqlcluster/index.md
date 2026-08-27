---
version: 1.0.1
available_versions:
  - 1.0.1
  - 1.0.0
  - 0.2.2
  - 0.2.1
  - 0.2.0
---

<!-- BEGIN_TF_DOCS -->
# Cosmos DB PostgreSQL Cluster module

## Overview

This terraform module creates a cosmosdb with postgrescluster and associated resources.

## Prerequisites

- Exisiting `resource_group`.
- One `random_password` resource block to geneate the password.

## Guidance

#### Usage

- `administrator_login_password` variable is required when `source_resource_id` variable is not set.
- `coordinator_storage_quota_in_mb` is required when `source_resource_id` is not set.
- `coordinator_vcore_count` is required when `source_resource_id` is not set.

#### Security Considerations

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-CDBP-AC_010 |  Disable Public Network Access | Cosmos DB PostgreSQL must enforce a network guardrail (What) within Networking settings (How) in order to prevent unauthorised access and data exposure to the internet (Why) | True | True | Control implemented by setting `node_public_ip_access_enabled` variable as `false` by default. |
|2.| AZU-CDBP-AU_010 | Send all diagnostic log categories to a central SOC Log Analytics workspace |  Cosmos DB PostgreSQL must send all diagnostic logs to a central SOC Log Analytics workspace (What) within Diagnostic settings (How) in order to support a security investigation after a security incident (Why) | False | False | This Security control will be implemented by Policy. |
|3.| AZU-CCBP-AU_020 | Send all diagnostic log categories to a central SOC Storage Account | Cosmos DB PostgreSQL must send all diagnostic logs to a central SOC Storage Account (What) within Diagnostic settings (How) In order to provide an immutable copy to adhere to compliance requirements (Why) | False | False | This Security control will be implemented by Policy. |
|4.| AZU-CDBP-AU_030 |  Must send diagnostic log categories to approved partner solutions only | Cosmos DB PostgreSQL must send diagnostic log categories to approved partner solutions only (What) within Diagnostic settings (How) in order to prevent sensitive data leakage to third parties outside of LSEG control (Why) | False | False | This Security control will be implemented by Policy |
|5.| AZU-CDBP-AU_040 | Must log connections | Cosmos DB PostgreSQL must log connections (What) via Coordinator node parameters (How) in order to support a security investigation after a security incident (Why) | True | False | Control implemented by setting the `log_connections` parameter as `ON` while creating node and coordinator configurations. The log connections is enforced in code, but there is no PowerShell command to check coordinator node parameter values in Pester post-deployment test.|
|6.| AZU-CDBP-AU_050 | Must log connection source hostname as well as IP address | Must log connection source hostname as well as IP address (What) via Coordinator node parameters (How) Auditing settings (How) in order to support a security investigation after a security incident (Why) | True | False | Control implemented by setting the `log_hostname` parameter as `ON` while creating node and coordinator configurations. The log hostname is enforced in code, but there is no PowerShell command to check coordinator node parameter values in Pester post-deployment test.|
|7.| AZU-CDBP-CP_010 | Cosmos DB PostgreSQL maintenance schedule should be reviewed against requirements and set accordingly |   Cosmos DB PostgreSQL maintenance schedule should be reviewed against requirements and set accordingly (What) via Maintenance settings (How) to ensure that maintenance occurs outside of core business service hours (Why) | True | False | Implemented using variable `maintenance_window`, the value can be set as per the requirement. This cannot be tested using Pester tests. |
|8.|AZU-CDBP-SC_010 | Must use a dedicated CMK for Cosmos DB PostgreSQL Transparent Data Encryption that is persisted in an HSM backed Key Vault | Use a dedicated Cosmos DB PostgreSQL LSEG managed encryption at rest key persisted in an HSM backed Key Vault (What) via deployment settings (How) in order should Microsoft's key management platform become compromised LSEG can revoke access to exfiltrated encrypted data | False | False | No identity block and Transparent Data Encryption available for this module, will be implement by LSEG team. |
|9.| AZU-CDBP-SC_030 | Cosmos DB PostgreSQL must not be able to corrupt the centrally managed private link private DNS zones when making a private endpoint for Event Hubs | Cosmos DB PostgreSQL must have an Azure DeployIfNotExists policy to update the centrally managed private link private DNS zones with its private A record (What) via Policy to management group mapping (How) to ensure there is no ability for the Azure App Deployment team to have authorisation over these zones that could allow them to corrupt this file and impact service availability (Why | False | False | Will be deploy using Azure policy by lseg team. |
|10.| AZU-CDBP-SC_040 | Cosmos DB PostgreSQL must have a data classification tag | Cosmos DB PostgreSQL must have a data classification tag (What) via Tags settings (How) in order to differentiate assets technical control requirements and to assist Security Operations in prioritising possible data breach mitigation responses | True | False | Tags can be added to the product using variable `tags`. Data classification tag should be added during the deployment as per the data within the cosmosdb postgresql cluster. This cannot be tested using Pester tests. |
|11.| AZU-CDBP-SC_050 | Cosmos DB PostgreSQL must have the Citus password rotated so they are distinct from the original value stored in the Terraform state file, meet LSEG complexity requirements and are stored in the LSEG approved secrets management system | Cosmos DB PostgreSQL must have the Citus password rotated so they are distinct from the original value stored in the Terraform state file, meet LSEG complexity requirements and are stored in the LSEG approved secrets management system (What) via Overview reset password (How) in order to protect secrets by using a secure storage mechanism (Why) | False | False | Control implemented by technical configuration setting: False.This will be implemented with rationale: LSEG standard. |
|12.| AZU-CDBP-SC_060 | Cosmos DB PostgreSQL consumers must persist the connection strings as a secret in a Key Vault |  Cosmos DB PostgreSQL consumers must persist the connection strings as a secret in a Key Vault (What) as part of consuming service configuration (How) in order to ensure the security of credentials (Why) | False | False | Control implemented by technical configuration setting: False. Consumers can persist the connection strings as a secret in a Key Vault using Keyvault secret (module_name) module. |
|13. | AZU-CDBP-SI_010 | Cosmos DB PostgreSQL versions must be kept to within n-2 versions | Cosmos DB PostgreSQL versions must be kept to within n-2 versions (What) via rest API (How) in order to keep up to date with vulnerability remediations (Why) | False | False | Control implemented by technical configuration setting: False |

## Changelog

- [azure-prdsvc-terraform-cosmosdbpostgresqlcluster](../CHANGELOG.md)

## References

### Microsoft Docs

- [Official documentation](https://learn.microsoft.com/en-us/azure/cosmos-db/postgresql/introduction)

### Terraform Docs

- [azurerm_cosmosdb_postgresql_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_postgresql_cluster)

- [azurerm_cosmosdb_postgresql_coordinator_configuration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_postgresql_coordinator_configuration)

- [azurerm_cosmosdb_postgresql_node_configuration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_postgresql_node_configuration)

- [azurerm_cosmosdb_postgresql_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_postgresql_role)

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
| [azurerm_cosmosdb_postgresql_cluster.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_postgresql_cluster) | resource |
| [azurerm_cosmosdb_postgresql_coordinator_configuration.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_postgresql_coordinator_configuration) | resource |
| [azurerm_cosmosdb_postgresql_node_configuration.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_postgresql_node_configuration) | resource |
| [azurerm_cosmosdb_postgresql_role.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_postgresql_role) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_administrator_login_password"></a> [administrator_login_password](#input_administrator_login_password) | (Optional) The password of the administrator login. This is required when source_resource_id is not set. | `string` | `null` | no |
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_citus_version"></a> [citus_version](#input_citus_version) | (Optional) The citus extension version on the Azure Cosmos DB for PostgreSQL Cluster. Possible values are 8.3, 9.0, 9.1, 9.2, 9.3, 9.4, 9.5, 10.0, 10.1, 10.2, 11.0, 11.1, 11.2, 11.3 and 12.1. | `string` | `null` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_coordinator_configuration"></a> [coordinator_configuration](#input_coordinator_configuration) | (Optional) map(object({<br/>  name  = "(Required) The name of the Coordinator Configuration on Azure Cosmos DB for PostgreSQL Cluster. Changing this forces a new resource to be created."<br/>  value = "(Required) The value of the Coordinator Configuration on Azure Cosmos DB for PostgreSQL Cluster."<br/>  })) | <pre>map(object({<br/>    name  = string<br/>    value = string<br/>  }))</pre> | `{}` | no |
| <a name="input_coordinator_public_ip_access_enabled"></a> [coordinator_public_ip_access_enabled](#input_coordinator_public_ip_access_enabled) | (Optional) Is public access enabled on coordinator? Defaults to true. | `bool` | `true` | no |
| <a name="input_coordinator_server_edition"></a> [coordinator_server_edition](#input_coordinator_server_edition) | (Optional) The edition of the coordinator server. Possible values are BurstableGeneralPurpose, BurstableMemoryOptimized, GeneralPurpose and MemoryOptimized. Defaults to GeneralPurpose. | `string` | `"GeneralPurpose"` | no |
| <a name="input_coordinator_storage_quota_in_mb"></a> [coordinator_storage_quota_in_mb](#input_coordinator_storage_quota_in_mb) | (Optional) The coordinator storage allowed for the Azure Cosmos DB for PostgreSQL Cluster. Possible values are 32768, 65536, 131072, 262144, 524288, 1048576, 2097152, 4194304, 8388608, 16777216, and 33554432. | `string` | `null` | no |
| <a name="input_coordinator_vcore_count"></a> [coordinator_vcore_count](#input_coordinator_vcore_count) | (Optional) The coordinator vCore count for the Azure Cosmos DB for PostgreSQL Cluster. Possible values are 1, 2, 4, 8, 16, 32, 64 and 96. | `string` | `null` | no |
| <a name="input_cosmosdb_postgresql_role"></a> [cosmosdb_postgresql_role](#input_cosmosdb_postgresql_role) | (Optional) map(object({<br/>  name     = "(Required) The name which should be used for this Azure Cosmos DB for PostgreSQL Role. Changing this forces a new resource to be created."<br/>  password = "(Required) The password of the Azure Cosmos DB for PostgreSQL Role. Changing this forces a new resource to be created."<br/>  })) | <pre>map(object({<br/>    name     = string<br/>    password = string<br/>  }))</pre> | `{}` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_ha_enabled"></a> [ha_enabled](#input_ha_enabled) | (Optional) Is high availability enabled for the Azure Cosmos DB for PostgreSQL cluster? Defaults to false. | `bool` | `false` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_maintenance_window"></a> [maintenance_window](#input_maintenance_window) | object({<br/>  day_of_week  = "(Optional) The day of week for maintenance window, where the week starts on a Sunday, i.e. Sunday = 0, Monday = 1. Defaults to 0."<br/>  start_hour   = "(Optional) The start hour for maintenance window. Defaults to 0."<br/>  start_minute = "(Optional) The start minute for maintenance window. Defaults to 0."<br/>  }) | <pre>object({<br/>    day_of_week  = string<br/>    start_hour   = string<br/>    start_minute = string<br/>  })</pre> | `null` | no |
| <a name="input_node_configuration"></a> [node_configuration](#input_node_configuration) | (Optional) map(object({<br/>  name  = "(Required) The name of the Node Configuration on Azure Cosmos DB for PostgreSQL Cluster. Changing this forces a new resource to be created."<br/>  value = "(Required) The value of the Node Configuration on Azure Cosmos DB for PostgreSQL Cluster."<br/>  })) | <pre>map(object({<br/>    name  = string<br/>    value = string<br/>  }))</pre> | `{}` | no |
| <a name="input_node_count"></a> [node_count](#input_node_count) | (Required) The worker node count of the Azure Cosmos DB for PostgreSQL Cluster. Possible value is between 0 and 20 except 1. | `number` | n/a | yes |
| <a name="input_node_public_ip_access_enabled"></a> [node_public_ip_access_enabled](#input_node_public_ip_access_enabled) | (Optional) Is public access enabled on worker nodes. Defaults to false. | `bool` | `false` | no |
| <a name="input_node_server_edition"></a> [node_server_edition](#input_node_server_edition) | (Optional) The edition of the node server. Possible values are BurstableGeneralPurpose, BurstableMemoryOptimized, GeneralPurpose and MemoryOptimized. Defaults to MemoryOptimized. | `string` | `"MemoryOptimized"` | no |
| <a name="input_node_storage_quota_in_mb"></a> [node_storage_quota_in_mb](#input_node_storage_quota_in_mb) | (Optional) The storage quota in MB on each worker node. Possible values are 32768, 65536, 131072, 262144, 524288, 1048576, 2097152, 4194304, 8388608 and 16777216. | `string` | `null` | no |
| <a name="input_node_vcores"></a> [node_vcores](#input_node_vcores) | (Optional) The vCores count on each worker node. Possible values are 1, 2, 4, 8, 16, 32, 64, 96 and 104. | `string` | `null` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_point_in_time_in_utc"></a> [point_in_time_in_utc](#input_point_in_time_in_utc) | (Optional) The date and time in UTC (ISO8601 format) for the Azure Cosmos DB for PostgreSQL cluster restore. | `string` | `null` | no |
| <a name="input_preferred_primary_zone"></a> [preferred_primary_zone](#input_preferred_primary_zone) | (Optional) The preferred primary availability zone for the Azure Cosmos DB for PostgreSQL cluster. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_shards_on_coordinator_enabled"></a> [shards_on_coordinator_enabled](#input_shards_on_coordinator_enabled) | (Optional) Is shards on coordinator enabled for the Azure Cosmos DB for PostgreSQL cluster | `string` | `null` | no |
| <a name="input_source_location"></a> [source_location](#input_source_location) | (Optional) The Azure region of the source Azure Cosmos DB for PostgreSQL cluster for read replica clusters. | `string` | `null` | no |
| <a name="input_source_resource_id"></a> [source_resource_id](#input_source_resource_id) | (Optional) The resource ID of the source Azure Cosmos DB for PostgreSQL cluster for read replica clusters. | `string` | `null` | no |
| <a name="input_sql_version"></a> [sql_version](#input_sql_version) | (Optional) The major PostgreSQL version on the Azure Cosmos DB for PostgreSQL cluster. Possible values are 11, 12, 13, 14, 15 and 16. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_coordinator_id"></a> [coordinator_id](#output_coordinator_id) | The ID of the created coordinator. |
| <a name="output_coordinator_resource"></a> [coordinator_resource](#output_coordinator_resource) | The created coordinator resource. |
| <a name="output_id"></a> [id](#output_id) | The ID of the created cluster. |
| <a name="output_name"></a> [name](#output_name) | The ID of the created cluster. |
| <a name="output_node_id"></a> [node_id](#output_node_id) | The ID of the created node. |
| <a name="output_node_resource"></a> [node_resource](#output_node_resource) | The created node resource. |
| <a name="output_resource"></a> [resource](#output_resource) | The created Cosmos DB PostgreSQL Cluster resource. |
| <a name="output_role_id"></a> [role_id](#output_role_id) | The ID of the created role. |
| <a name="output_role_resource"></a> [role_resource](#output_role_resource) | The created role resource. |
<!-- END_TF_DOCS -->
