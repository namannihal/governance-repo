<!-- BEGIN_TF_DOCS -->
# MSSQL ElasticPool Module

[[_TOC_]]

## Overview

This terraform module creates a **MSSQL ElasticPool** and associated resources.

Azure SQL Database elastic pools are a simple, cost-effective solution for managing and scaling multiple databases with varying and unpredictable usage demands. The databases in an elastic pool are on a single server and share a set number of resources at a set price. Elastic pools in SQL Database enable software-as-a-service (SaaS) developers to optimize the price performance for a group of databases within a prescribed budget while delivering performance elasticity for each database.

For more information, refer to the [MSSQL ElasticPool documentation](https://learn.microsoft.com/en-us/azure/azure-sql/database/elastic-pool-overview?view=azuresql-db).

## Prerequisites

- `Network Security Group`
- `Subnet`
- `User Assigned Identity` for Storage
- `User Assigned Identity` for MSSQL Server
- `Key Vault`
- `Private Endpoint` for Key Vault
- - `Storage Account` is required to be created from which a `Storage Container` is created which is to be linked to MS SQL server.
- `Private Endpoint` for Storage Blob
- `MS SQL Server` is required to be craeted which is to be linked to MS SQL Elasticpool.
- `MS SQL Elasticpool` to be linked to `MSSQL Database` using variable `elastic_pool_id`
elastic\_pool\_id= module.azure-prdsvc-terraform-mssqlelasticpool.id
MSSQL Database module link(https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-mssqldatabase)
## Guidance

#### Usage

- This module deploys an Azure MSSQL Elastic Pool associated with an existing SQL Server.
- Elastic pools provide cost-effective resource sharing for multiple databases with varying usage patterns.
- The module requires an existing SQL Server and resource group to deploy the elastic pool.

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. |  |  |  |  |  |  |

## Changelog

- [azure-prdsvc-terraform-mssqlelasticpool](CHANGELOG.md)

## References

### Microsoft Docs

[MSSQL ElasticPool](https://learn.microsoft.com/en-us/azure/azure-sql/database/elastic-pool-overview?view=azuresql-db)

### Terraform Docs

[MSSQL ElasticPool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_elasticpool)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=4.33 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=4.33 |

## Resources

| Name | Type |
|------|------|
| [azurerm_mssql_elasticpool.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_elasticpool) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app\_id](#input\_app\_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input\_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_enclave_type"></a> [enclave\_type](#input\_enclave\_type) | (Optional) Specifies the type of enclave to be used by the elastic pool. When enclave\_type is not specified (e.g., the default) enclaves are not enabled on the elastic pool. <br/>Possible values are Default or VBS. All databases that are added to the elastic pool must have the same enclave\_type as the elastic pool. <br/>enclave\_type is not supported for DC-series SKUs. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_license_type"></a> [license\_type](#input\_license\_type) | (Optional) Specifies the license type applied to this database. Possible values are LicenseIncluded and BasePrice. | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_maintenance_configuration_name"></a> [maintenance\_configuration\_name](#input\_maintenance\_configuration\_name) | (Optional) The name of the Public Maintenance Configuration window to apply to the elastic pool. <br/>Valid values include SQL\_Default, SQL\_EastUS\_DB\_1, SQL\_EastUS2\_DB\_1, SQL\_SoutheastAsia\_DB\_1, SQL\_AustraliaEast\_DB\_1, SQL\_NorthEurope\_DB\_1, SQL\_SouthCentralUS\_DB\_1, SQL\_WestUS2\_DB\_1, SQL\_UKSouth\_DB\_1, SQL\_WestEurope\_DB\_1, SQL\_EastUS\_DB\_2, SQL\_EastUS2\_DB\_2, SQL\_WestUS2\_DB\_2, SQL\_SoutheastAsia\_DB\_2, SQL\_AustraliaEast\_DB\_2, SQL\_NorthEurope\_DB\_2, SQL\_SouthCentralUS\_DB\_2, SQL\_UKSouth\_DB\_2, SQL\_WestEurope\_DB\_2, SQL\_AustraliaSoutheast\_DB\_1, SQL\_BrazilSouth\_DB\_1, SQL\_CanadaCentral\_DB\_1, SQL\_CanadaEast\_DB\_1, SQL\_CentralUS\_DB\_1, SQL\_EastAsia\_DB\_1, SQL\_FranceCentral\_DB\_1, SQL\_GermanyWestCentral\_DB\_1, SQL\_CentralIndia\_DB\_1, SQL\_SouthIndia\_DB\_1, SQL\_JapanEast\_DB\_1, SQL\_JapanWest\_DB\_1, SQL\_NorthCentralUS\_DB\_1, SQL\_UKWest\_DB\_1, SQL\_WestUS\_DB\_1, SQL\_AustraliaSoutheast\_DB\_2, SQL\_BrazilSouth\_DB\_2, SQL\_CanadaCentral\_DB\_2, SQL\_CanadaEast\_DB\_2, SQL\_CentralUS\_DB\_2, SQL\_EastAsia\_DB\_2, SQL\_FranceCentral\_DB\_2, SQL\_GermanyWestCentral\_DB\_2, SQL\_CentralIndia\_DB\_2, SQL\_SouthIndia\_DB\_2, SQL\_JapanEast\_DB\_2, SQL\_JapanWest\_DB\_2, SQL\_NorthCentralUS\_DB\_2, SQL\_UKWest\_DB\_2, SQL\_WestUS\_DB\_2, SQL\_WestCentralUS\_DB\_1, SQL\_FranceSouth\_DB\_1, SQL\_WestCentralUS\_DB\_2, SQL\_FranceSouth\_DB\_2, SQL\_SwitzerlandNorth\_DB\_1, SQL\_SwitzerlandNorth\_DB\_2, SQL\_BrazilSoutheast\_DB\_1, SQL\_UAENorth\_DB\_1, SQL\_BrazilSoutheast\_DB\_2, SQL\_UAENorth\_DB\_2, SQL\_SouthAfricaNorth\_DB\_1, SQL\_SouthAfricaNorth\_DB\_2, SQL\_WestUS3\_DB\_1, SQL\_WestUS3\_DB\_2. <br/>Defaults to SQL\_Default. | `string` | `"SQL_Default"` | no |
| <a name="input_max_size_bytes"></a> [max\_size\_bytes](#input\_max\_size\_bytes) | (Optional) The max data size of the elastic pool in bytes. Conflicts with max\_size\_gb. One of either max\_size\_gb or max\_size\_bytes must be specified. | `number` | `null` | no |
| <a name="input_max_size_gb"></a> [max\_size\_gb](#input\_max\_size\_gb) | (Optional) The max data size of the elastic pool in gigabytes. Conflicts with max\_size\_bytes. One of either max\_size\_gb or max\_size\_bytes must be specified. | `number` | `null` | no |
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_per_database_settings"></a> [per\_database\_settings](#input\_per\_database\_settings) | (Required) A per\_database\_settings block as defined below.<br/>object({<br/>  min\_capacity = "(Required) The minimum capacity all databases are guaranteed."<br/>  max\_capacity = "(Required) The maximum capacity any one database can consume."<br/>}) | <pre>object({<br/>    min_capacity = number<br/>    max_capacity = number<br/>  })</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_server_name"></a> [server\_name](#input\_server\_name) | (Required) The name of the SQL Server on which to create the elastic pool. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | (Required) A sku block as defined below.<br/>object({<br/>  name     = "(Required) Specifies the SKU Name for this Elasticpool. The name of the SKU, will be either vCore based or DTU based. Possible DTU based values are BasicPool, StandardPool, PremiumPool while possible vCore based values are GP\_Gen4, GP\_Gen5, GP\_Fsv2, GP\_DC, BC\_Gen4, BC\_Gen5, BC\_DC, HS\_PRMS, or HS\_Gen5"<br/>  tier     = "(Required) The tier of the particular SKU. Possible values are GeneralPurpose, BusinessCritical, Basic, Standard, Premium, or HyperScale."<br/>  family   = "(Optional) The family of hardware Gen4, Gen5, Fsv2, MOPRMS, PRMS, or DC"<br/>  capacity = "(Required) The scale up/out capacity, representing server's compute units."<br/>}) | <pre>object({<br/>    name     = string<br/>    tier     = string<br/>    family   = optional(string, null)<br/>    capacity = number<br/>  })</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_zone_redundant"></a> [zone\_redundant](#input\_zone\_redundant) | (Optional) Whether or not this elastic pool is zone redundant. tier needs to be Premium for DTU based or BusinessCritical for vCore based sku. | `bool` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The Resource ID of the MS SQL Elastic Pool. |
| <a name="output_name"></a> [name](#output\_name) | The Name of the MS SQL Elastic Pool. |
| <a name="output_resource"></a> [resource](#output\_resource) | The MS SQL Elastic Pool resource. |
<!-- END_TF_DOCS -->
