---
version: 1.0.2
available_versions:
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.1.2
  - 0.1.1
---

<!-- BEGIN_TF_DOCS -->
# Azure Database Migration Service Module


## Overview

This Terraform module creates and configures the **Azure Database Migration Service (Classic)** and provisions a **Database Migration Project**.

Azure Database Migration Service is a fully managed service designed to enable seamless migrations from multiple database sources to Azure data platforms with minimal downtime.

The Database Migration Project defines the source and target platforms for the migration and manages the migration process.

The Classic service is used for migrating MySQL, PostgreSQL, MongoDB to Azure Database for MySQL, and Azure Database for PostgreSQL, Azure Cosmos DM. However, only MySQL migration is supported and clear listed. Current product doesn't support MSSQL Migration

For more information, refer to the [Azure Database Migration Service documentation](https://learn.microsoft.com/en-us/azure/dms/).

## Prerequisites

- Ensure that the following prerequisites are met:

  - A **Resource Group** name is required.
  - A **Virtual Network** with a subnet is required to host the Database Migration Service.
  - **Route Table** define below three routes before starting the database migration service deployment
   
```
   route = {
    "routekey1" = {
      name                   = "route1"
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "Firewall Private IP"
    }
    "routekey2" = {
      name                   = "route2"
      address_prefix         = "10.0.0.0/8"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "Firewall Private IP"
    }
    "routekey3" = {
      name                   = "route3"
      address_prefix         = "172.16.0.0/12"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "Firewall Private IP"
    }
  }
```
  - **Network Security Group(NSG)** define below three outbound rules before starting the database migration service deployment

```
   security_rules = {
    "AllowAzureMonitorOutbound" = {
      name                                       = "AllowAzureMonitorOutbound"
      description                                = "Allow Azure Monitor for DMS"
      priority                                   = 300
      direction                                  = "Outbound"
      access                                     = "Allow"
      protocol                                   = "Tcp"
      source_port_range                          = "*"
      destination_port_ranges                    = ["443"]
      source_address_prefix                      = "*"
      destination_address_prefix                 = "AzureMonitor"
      source_application_security_group_ids      = []
      destination_application_security_group_ids = []
    }
    "AllowServiceBusOutbound" = {
      name                                       = "AllowServiceBusOutbound"
      description                                = "Allow Service Bus for DMS"
      priority                                   = 200
      direction                                  = "Outbound"
      access                                     = "Allow"
      protocol                                   = "Tcp"
      source_port_range                          = "*"
      destination_port_ranges                    = ["443"]
      source_address_prefix                      = "*"
      destination_address_prefix                 = "ServiceBus"
      source_application_security_group_ids      = []
      destination_application_security_group_ids = []
    }
    "AllowStorageOutbound" = {
      name                                       = "AllowStorageOutbound"
      description                                = "Allow Storage for DMS"
      priority                                   = 100
      direction                                  = "Outbound"
      access                                     = "Allow"
      protocol                                   = "Tcp"
      source_port_range                          = "*"
      destination_port_ranges                    = ["443"]
      source_address_prefix                      = "*"
      destination_address_prefix                 = "Storage"
      source_application_security_group_ids      = []
      destination_application_security_group_ids = []
    }
   }
```
  - Add the below service endpoints to the **Subnet** module to avoid DMS deployment connectivity issues
```
     Microsoft.Sql
     Microsoft.Storage
     Microsoft.EventHub
     Microsoft.ServiceBus
```
  - The source database must be accessible from the Database Migration Service.
  - The target database must be provisioned and accessible.

**Note:** The creation of the Virtual Network and Subnet can be managed by a separate Terraform module.

## Guidance

- This module is tested locally with the supported database migration scenarios. Ensure that the source and target databases are configured correctly before initiating the migration.
- The Classic service supports migrations for MySQL, PostgreSQL, MongoDB to Azure Database for MySQL, and Azure Database for PostgreSQL, Azure Cosmos DM. However, only MySQL migration is supported and clear listed. Current product doesn't support MSSQL Migration and other services migrations except MySQL migration.
- The `source_platform` and `target_platform` values must match the supported combinations. For example:
- `source_platform = "MySQL"` and `target_platform = "MySQL"` for SQL Server to Azure SQL Database migrations.
 for now it only supports this
- For a complete list of supported platforms, refer to the [Azure Database Migration Service documentation](https://learn.microsoft.com/en-us/azure/dms/).

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1      | AZU-DMS-SC_010   | Network connections to the Data Migration Service control and data planes must use TLS encryption | Data Migration Service must enforce network flow encryption in transit using TLS (What) within New Migration (How) in order to use modern techniques to establish robust encrypted data channels over untrusted networks (Why)                  |NA  | NO                 |   |
| 2      | AZU-DMS-SC_020   | Data Migration Service must only use LSEG approved database types     | Data Migration Service must only use LSEG approved database types (What) within code deployment parameters (How) in order to ensure only LSEG Security Architecture approved database migration resources are used (Why)                        |   NA      | N/A                 |  |
| 3      | AZU-DMS-SC_030   | Data Migration Service must only copy data within the same environment | Data Migration Service must only copy data within the same environment (e.g. prod <-> prod, dev <-> dev) (What) within New Migration (How) to ensure confidential business data in production is appropriately protected (Why)                  | NA | N/A                 |  |

## Changelog

- [azure-prdsvc-terraform-databasemigrationservice](CHANGELOG.md)

## References

### Microsoft Docs

- [Azure Database Migration Service](https://learn.microsoft.com/en-us/azure/dms/)
- [Database Migration Project](https://learn.microsoft.com/en-us/azure/dms/tutorial-sql-server-to-azure-sql)

### Terraform Docs

- [Azure Database Migration Service](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/database_migration_service)
- [Database Migration Project](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/database_migration_project)

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
| [azurerm_database_migration_project.projects](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/database_migration_project) | resource |
| [azurerm_database_migration_service.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/database_migration_service) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_projects"></a> [projects](#input_projects) | A map of projects with their respective configurations | <pre>map(object({<br/>    name            = string<br/>    source_platform = string<br/>    target_platform = string<br/>  }))</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku_name](#input_sku_name) | (Required) The SKU of the DMS instance. | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet_id](#input_subnet_id) | (Required) The ID of the subnet. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The Resource ID of the Data Migration Service |
| <a name="output_name"></a> [name](#output_name) | The Name of the database migration service. |
| <a name="output_resource"></a> [resource](#output_resource) | The Data Migration Service resource. |
<!-- END_TF_DOCS -->
