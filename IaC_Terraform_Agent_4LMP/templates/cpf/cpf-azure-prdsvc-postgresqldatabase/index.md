---
version: 1.0.2
available_versions:
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.2.4
  - 0.2.3
---

<!-- BEGIN_TF_DOCS -->
# PostgreSQL Flexible Server Database module


## Overview

This terraform module creates a azurerm postgresql flexible server database and associated resources.

## Prerequisites

- A key vault to store sensitive information.
- A Postgre Flexible Server with required configurations and [dependencies](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-postgresqlserver/-/blob/main/README.md) deployed to host the database.

## Guidance

#### Usage

- This module deploys the Azure PostgreSQL Flexible Server Database which will be associated with `PostgreSQL Flexible Server`.

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-PSQLF-SC_020 | Use a minimum of TLS version 1.2 for network connections to the PostgreSQL Database control and data planes | PostgreSQL Server / database must enforce a minimum TLS version of 1.2 (What) within its Network settings (How) in order to use modern techniques to establish robust encrypted data channels over untrusted networks (Why) | True | False  | This control is implemented by default in PostgreSQL Server module as only `TLSV1.2` and `TLSV1.3` protocols are supported in Azure PostgreSQL Flexible Server module of which `TLSV1.2` is the minimum one.|

## Changelog

[azure-prdsvc-terraform-postgresqldatabase](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/overview)

### Terraform Docs

- [azurerm_postgresql_flexible_server_database](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_database)

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
| [azurerm_postgresql_flexible_server_database.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_database) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_charset"></a> [charset](#input_charset) | (optional) Specifies the Charset for the Azure PostgreSQL Flexible Server database. | `string` | `null` | no |
| <a name="input_collation"></a> [collation](#input_collation) | (optional) Specifies the Collation for the Azure PostgreSQL Flexible Server database. | `string` | `null` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_database_name"></a> [database_name](#input_database_name) | (Optional) Custom name for the PostgreSQL Flexible Server database. If null, module-generated naming is used. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_server_id"></a> [server_id](#input_server_id) | (Required) Specifies the PostgreSQL Flexible server ID to associate it with database. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The ID of the PostgreSQL Flexible Server Database. |
| <a name="output_name"></a> [name](#output_name) | The name of the PostgreSQL Flexible Server Database. |
| <a name="output_resource"></a> [resource](#output_resource) | The Postgresql Flexible Server Database resource. |
<!-- END_TF_DOCS -->
