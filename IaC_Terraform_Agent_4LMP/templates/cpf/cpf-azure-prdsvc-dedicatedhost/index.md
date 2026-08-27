---
version: 1.0.3
available_versions:
  - 1.0.3
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.2.0
---

<!-- BEGIN_TF_DOCS -->
# __product name__ module


## Overview

This terraform module creates a Dedicated Host and associated resources.

## Prerequisites

- Create a resource group or use existing resource group to manage host groups.
- Create a dedicated host group or use existing dedicated host group to manage dedicated host.

## Guidance

#### Usage

- Create a dedicated host group to define fault domain boundaries and allow grouping of hosts.
- A dedicated host can be configured to host virtual machines of the same size or mixed sizes with in the same series.
- Enable `auto_replace_on_failure` to replace virtual machines automatically on the dedicated host in case of a failure.
- Deploy virtual machines with the host property set to the `dedicated_host_id`.
- Virtual machines must be in the same Azure region as the dedicated host.
- Only specific virtual machine sizes are supported on a dedicated host (ex: Dsv3, Esv3, Fsv2). For more details check the 'dedicated host by region' document below.
- If Maintenance Assignment to Dedicated Host is required, set `maintenance_assignment_required` variable to `true`.

## Security Controls

- Currently, as per LSEG Approved Dedicated Host Requirements, there are no security controls for this product.

## Changelog

- [azure-prdsvc-terraform-dedicatedhost](CHANGELOG.md)

## References

### Microsoft Docs

- [Official documentation](https://learn.microsoft.com/en-us/azure/virtual-machines/dedicated-hosts#groups-hosts-and-vms)
- [Dedicated hosts by region](https://azure.microsoft.com/en-us/pricing/details/virtual-machines/dedicated-host/)

### Terraform Docs

- [azurerm_dedicated_host](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/dedicated_host)
- [Maintenance assignment to Dedicated Host](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/maintenance_assignment_dedicated_host)

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
| [azurerm_dedicated_host.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dedicated_host) | resource |
| [azurerm_maintenance_assignment_dedicated_host.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/maintenance_assignment_dedicated_host) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_auto_replace_on_failure"></a> [auto_replace_on_failure](#input_auto_replace_on_failure) | (Optional) Specifies whether the host should be automatically replaced on failure. Changing this forces a new resource to be created. | `bool` | `true` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_dedicated_host_group_id"></a> [dedicated_host_group_id](#input_dedicated_host_group_id) | (Required) The ID of the Dedicated Host Group in which the Dedicated Host should be created. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_license_type"></a> [license_type](#input_license_type) | (Optional) Specifies the software license type that will be applied to the VMs deployed on the Dedicated Host. Possible values are None, Windows_Server_Hybrid and Windows_Server_Perpetual. Changing this forces a new resource to be created. | `string` | `"None"` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_maintenance_assignment_required"></a> [maintenance_assignment_required](#input_maintenance_assignment_required) | (Optional) Specify whether the Maintenance Configuration should be assigned for this Dedicated Host. Defaults to false. | `bool` | `false` | no |
| <a name="input_maintenance_configuration_id"></a> [maintenance_configuration_id](#input_maintenance_configuration_id) | (Optional) The ID of the Maintenance Configuration to assign to the Dedicated Host. | `string` | `null` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_platform_fault_domain"></a> [platform_fault_domain](#input_platform_fault_domain) | (Required) Specify the fault domain of the Dedicated Host Group in which to create the Dedicated Host. Changing this forces a new resource to be created. | `number` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku_name](#input_sku_name) | (Required) Specify the SKU name of the Dedicated Host. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The Resource ID of the Dedicated Host. |
| <a name="output_name"></a> [name](#output_name) | The Name of the Dedicated Host. |
| <a name="output_resource"></a> [resource](#output_resource) | The Dedicated Host resource. |
<!-- END_TF_DOCS -->
