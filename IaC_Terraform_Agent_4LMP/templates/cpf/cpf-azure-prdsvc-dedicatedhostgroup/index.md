---
version: 1.0.2
available_versions:
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.1.1
  - 0.1.0
---

<!-- BEGIN_TF_DOCS -->
# __product name__ module


## Overview

This terraform module creates a Dedicated Host Group and associated resources.

## Prerequisites

- Create a dedicated resource group or use existing resource group to manage host groups.

## Guidance

#### Usage

- Create the dedicated host group, specifying the region, availability zone (if applicable) and fault domain count.
- if using availabity zones, the host group, the virtual machines and the virtual machine scale set must be in the same availability zone.
- Specify the `dedicated_host_group_id` where the virtual machine or virtual machine scale set should run during it's creation.

## Security Controls

- Currently, as per LSEG Approved Dedicated Host Group Requirements, there are no security controls for this product.

## Changelog

- [azure-prdsvc-terraform-dedicatedhostgroup](CHANGELOG.md)

## References

### Microsoft Docs

- [Official documentation](https://learn.microsoft.com/en-us/azure/virtual-machines/dedicated-hosts#groups-hosts-and-vms)
- [Dedicated hosts by region](https://azure.microsoft.com/en-us/pricing/details/virtual-machines/dedicated-host/)

### Terraform Docs

- [azurerm_dedicated_host_group](https://registry.terraform.io/providers/hashicorp/azurerm/4.22.0/docs/resources/dedicated_host_group)

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
| [azurerm_dedicated_host_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dedicated_host_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_automatic_placement_enabled"></a> [automatic_placement_enabled](#input_automatic_placement_enabled) | (Optional) Specifies whether the host group should support automatic placement. Changing this forces a new resource to be created. | `bool` | `false` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_platform_fault_domain_count"></a> [platform_fault_domain_count](#input_platform_fault_domain_count) | (Required) The number of fault domains that the Dedicated Host Group spans. Changing this forces a new resource to be created. | `number` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_zone"></a> [zone](#input_zone) | (Optional) Specifies the Availability Zone in which this Dedicated Host Group should be located. Changing this forces a new Dedicated Host Group to be created. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The Resource ID of the Dedicated Host Group |
| <a name="output_name"></a> [name](#output_name) | The Name of the Dedicated Host Group. |
| <a name="output_resource"></a> [resource](#output_resource) | The Dedicated Host Group resource. |
<!-- END_TF_DOCS -->
