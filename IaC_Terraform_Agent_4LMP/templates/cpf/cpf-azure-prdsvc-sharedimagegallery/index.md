---
version: 1.0.2
available_versions:
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.2.1
  - 0.2.0
---

<!-- BEGIN_TF_DOCS -->
# Azure Compute Gallery module


## Overview

This terraform module creates a Azure Compute Gallery and associated resources.

## Prerequisites

- `Resource Group` must be created to deploy this module.

## Guidance

#### Usage

- Shared community galleries are not supported within LSEG

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. |AZU-ACG-AC_010 | Azure Compute Gallery must be configured for private access only (What) within code deployment parameters (How) in order to limit sharing to LSEG tenants and prevent unauthorised access and data exposure to the internet (Why) | True | False | Implemented by not including `sharing` block which creates a default Private Gallery, introducing sharing block needs additional provider called `Microsoft.Compute/SIGSharing` which is preview feature. Cannot be tested as the `sharingProfile` property wouldn't be available to the resource when the `sharing` block is not used in terraform |

## Changelog

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/virtual-machines/azure-compute-gallery)

### Terraform Docs

- [azurerm_shared_image_gallery](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/shared_image_gallery)

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
| [azurerm_shared_image_gallery.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/shared_image_gallery) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_description"></a> [description](#input_description) | (Optional) A description for this Shared Image Gallery. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The Resource ID of the Compute Gallery. |
| <a name="output_name"></a> [name](#output_name) | The Name of the Compute Gallery. |
| <a name="output_resource"></a> [resource](#output_resource) | The Azure Compute Gallery resource. |
<!-- END_TF_DOCS -->
