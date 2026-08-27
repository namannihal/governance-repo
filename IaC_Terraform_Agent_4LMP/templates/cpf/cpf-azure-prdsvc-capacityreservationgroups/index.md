---
version: 2.0.2
available_versions:
  - 2.0.2
  - 2.0.1
  - 2.0.0
  - 1.0.1
  - 1.0.0
---

<!-- BEGIN_TF_DOCS -->
# Capacity Reservation Group module


## Overview

This terraform module creates a Capacity Reservation Group and capacity reservations.

## Prerequisites

- `Resource Group` name is required.

## Guidance

#### Usage

- This module create a capacity reservation group and multiple reservations can be created by the use of `reservations` variable.
- To create reservations just add the objects as needed, sample as below
```
reservations = {
    "reservation1" = {
      sku = {
        name     = "Standard_D2s_v3"
        capacity = 1
      }
      zone = "1"
      tags = null
    }
  }
```

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. |  |  |  |  |  |  |

## Changelog

- [azure-prdsvc-terraform-capacityreservation](CHANGELOG.md)

## References

- [Official Documentation](https://learn.microsoft.com/en-us/azure/virtual-machines/capacity-reservation-overview)

### Terraform Docs

- [azurerm_capacity_reservation_group](https://registry.terraform.io/providers/hashicorp/Azurerm/latest/docs/resources/capacity_reservation_group)
- [azurerm_capacity_reservation](https://registry.terraform.io/providers/hashicorp/Azurerm/latest/docs/resources/capacity_reservation)
=======

## References

### Microsoft Docs

### Terraform Docs

>>>>>>> main

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
| [azurerm_capacity_reservation.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/capacity_reservation) | resource |
| [azurerm_capacity_reservation_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/capacity_reservation_group) | resource |
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
| <a name="input_reservations"></a> [reservations](#input_reservations) | (Optional) reservations for the reservation group being created.<br/>      sku = optional(object({<br/>        name = (Required) Name of the sku, such as Standard_F2. Changing this forces a new resource to be created.<br/>        capacity  = (Required) Specifies the number of instances to be reserved. It must be greater than or equal to 0 and not exceed the quota in the subscription.<br/>      }))<br/>      zone = (Optional) Specifies the Availability Zone for this Capacity Reservation. Changing this forces a new resource to be created.<br/>      tags = (Optional) A mapping of tags to assign to the the reservation. | <pre>map(object({<br/>    sku = optional(object({<br/>      name     = string<br/>      capacity = string<br/>    }))<br/>    zone = optional(string)<br/>    tags = optional(map(any))<br/>  }))</pre> | `{}` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) A mapping of tags to assign to the reservation group. | `map(any)` | `{}` | no |
| <a name="input_zones"></a> [zones](#input_zones) | (Optional) Specifies a list of Availability Zones for this Capacity Reservation Group. Changing this forces a new resource to be created. | `list(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_reservation"></a> [reservation](#output_reservation) | The reservation resource. |
| <a name="output_reservation_group"></a> [reservation_group](#output_reservation_group) | The reservation group resource. |
| <a name="output_reservation_group_id"></a> [reservation_group_id](#output_reservation_group_id) | The ID of the reservation group. |
| <a name="output_reservation_id"></a> [reservation_id](#output_reservation_id) | The ID of the reservation. |
<!-- END_TF_DOCS -->
