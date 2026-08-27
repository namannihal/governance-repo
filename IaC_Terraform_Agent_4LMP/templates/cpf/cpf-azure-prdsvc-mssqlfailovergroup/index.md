---
version: 1.0.2
available_versions:
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.1.3
  - 0.1.2
---

<!-- BEGIN_TF_DOCS -->
<!-- BEGIN_TF_DOCS -->
# __MSSQL Failover Group__ module


## Overview

This terraform module creates a MSSQL Failover Group and associated resources.

## Prerequisites

- A primary sql server where your databases are hosted as supplied for `variable "server_id"`
- A partner server in a different location as supplied for `variable "partner_server"`
- If your secondary server already exists in a different region to the primary server, the server login and firewall settings must match that of your primary server.

## Guidance

- The Primary server and Partner server must use the same encryption key for Transparent data Encryption which is supplied to the sql server module with `variable "data_encryption_key"` which will be used as  `transparent_data_encryption_key_vault_key_id`
- KV should have Enable soft-delete and purge protection [Enable soft-delete and purge protection for AKV](https://learn.microsoft.com/en-us/azure/azure-sql/database/transparent-data-encryption-byok-overview?view=azuresql#requirements-for-configuring-customer-managed-tde)
- To handle same encryption key scenario define `failover_group == true` in your sqlserver cration module to skip the default cmk creation as part of the sql server module
- Refer [TDE](https://learn.microsoft.com/en-us/azure/azure-sql/database/transparent-data-encryption-tde-overview?view=azuresql) for additional information.
- Refer [Configure a failover group for Azure SQL Database](https://learn.microsoft.com/en-us/azure/azure-sql/database/?view=azuresql)
- [Limitations](https://learn.microsoft.com/en-us/azure/azure-sql/database/failover-group-configure-sql-db?view=azuresql&tabs=azure-portal%2Cazure-powershell-manage&pivots=azure-sql-single-db#limitations)

#### Usage

- refer .tests/DeployTest folder for the TF code on how to use the module
- for cmk the user identity needs to have `"Key Vault Crypto Service Encryption User"` role assignment for encryption.
- cmk for sql server supports only 2048 or 3072 and HSM/RSA-HSM. Please refer for more details [sql server encrytion best practices](https://learn.microsoft.com/en-us/sql/relational-databases/security/encryption/setup-steps-for-extensible-key-management-using-the-azure-key-vault?view=sql-server-ver16&tabs=portal#best-practices)
- Use two different User Assigned Identities for MS SQL And Storage Account, to avoid  conflict.
- The secondary storage account has been creaed in `UK South` in the test deployment due to the limitations with the cross region connectivity while developing this module.

#### Security Considerations

#### Additional Information

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. |  |  |  |  |  |  |

## Changelog

- [azure-prdsvc-terraform-mssqlfailovergroup](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/azure-sql/database/failover-group-sql-db?view=azuresql)

### Terraform Docs

- [azurerm\_mssql\_failover\_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_failover_group)

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
| [azurerm_mssql_failover_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_failover_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_databases"></a> [databases](#input_databases) | (Optional) A set of database names to include in the failover group. | `list(any)` | `[]` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_partner_server"></a> [partner_server](#input_partner_server) | (Required) A partner_server block as defined below. | `string` | `null` | no |
| <a name="input_read_write_endpoint_failover_policy"></a> [read_write_endpoint_failover_policy](#input_read_write_endpoint_failover_policy) | (Required) A read_write_endpoint_failover_policy block as defined below.<br/>  mode          = "(Required) The failover policy of the read-write endpoint for the failover group. Possible values are Automatic or Manual."Automatic""<br/>  grace_minutes = "(Optional) The grace period in minutes, before failover with data loss is attempted for the read-write endpoint. Required when mode is Automatic." | <pre>object({<br/>    mode          = string<br/>    grace_minutes = string<br/>  })</pre> | <pre>{<br/>  "grace_minutes": 80,<br/>  "mode": "Automatic"<br/>}</pre> | no |
| <a name="input_readonly_endpoint_failover_policy_enabled"></a> [readonly_endpoint_failover_policy_enabled](#input_readonly_endpoint_failover_policy_enabled) | (Optional) Whether failover is enabled for the readonly endpoint | `string` | `false` | no |
| <a name="input_server_id"></a> [server_id](#input_server_id) | (Required) The ID of the primary SQL Server on which to create the failover group. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The Resource ID of the azure mssql failover group |
| <a name="output_name"></a> [name](#output_name) | The Name of the azure mssql failover group |
| <a name="output_resource"></a> [resource](#output_resource) | The azure mssql failover group |
<!-- END_TF_DOCS -->
