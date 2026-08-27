---
version: 1.0.2
available_versions:
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.2.2
  - 0.2.1
---

<!-- BEGIN_TF_DOCS -->
# Azure Databricks Access Connector module


## Overview

- This terraform module creates a Azure databricks access connector and associated resources.The Access Connector for Azure Databricks is a first-party Azure resource that lets you connect managed identities to an Azure Databricks account.

## Prerequisites

## Guidance

#### Usage

- This module is deploying Azure databricks access connector using System Assigned Identity.

#### Security Considerations

- Each access connector for Azure Databricks can contain either one system-assigned managed identity or one user-assigned managed identity. If you want to use multiple managed identities, create a separate access connector for each.

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-ACDB-IA_010 |  Access connector for Azure Databricks must use a Managed Identity for accessing Azure Resources  | Access connector for Azure Databricks must enforce the use of a Managed Identity to authenticate to Azure resources where this is supported (What) within target service access control settings (How) in order to remove the need to store credentials (Why) | True | True | This Security Control is implemented by using `identity` block in code. |

## Changelog

- [azure-prdsvc-terraform-databricksaccessconnector](CHANGELOG.md)

## References

### Microsoft Docs

- [Azure Databricks Access Connector](https://azuremarketplace.microsoft.com/en-us/marketplace/apps/microsoft.accessconnector?tab=overview)

### Terraform Docs

- [azurerm_databricks_access_connector](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/databricks_access_connector)

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
| [azurerm_databricks_access_connector.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/databricks_access_connector) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_identity"></a> [identity](#input_identity) | (Required) An identity block as defined below<br/>object({<br/>  type         = "(Required) Specifies the type of Managed Service Identity that should be configured on this Azure databricks access connector. Possible values are `UserAssigned` or `UserAssigned`."<br/>  identity_ids = "(Required) Specifies User Assigned Managed Identity IDs to be assigned to this Azure databricks access connector. This is required when `type` is set to `UserAssigned`."<br/>}) | <pre>object({<br/>    type         = string<br/>    identity_ids = list(string)<br/>  })</pre> | <pre>{<br/>  "identity_ids": null,<br/>  "type": "SystemAssigned"<br/>}</pre> | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input_name) | (Required) Specifies the name of the Databricks Access Connector resource. Changing this forces a new resource to be created.. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The Resource ID of the azurerm_databricks_access_connector. |
| <a name="output_identity"></a> [identity](#output_identity) | The Resource ID of the azurerm_databricks_access_connector. |
| <a name="output_name"></a> [name](#output_name) | The Resource Name of the azurerm_databricks_access_connector. |
| <a name="output_principal_id"></a> [principal_id](#output_principal_id) | The Principal ID of the System Assigned Managed Service Identity that is configured on this Access Connector.. |
| <a name="output_resource"></a> [resource](#output_resource) | The azurerm_databricks_access_connector resource. |
| <a name="output_tenant_id"></a> [tenant_id](#output_tenant_id) | The Tenant ID of the System Assigned Managed Service Identity that is configured on this Access Connector.. |
<!-- END_TF_DOCS -->
