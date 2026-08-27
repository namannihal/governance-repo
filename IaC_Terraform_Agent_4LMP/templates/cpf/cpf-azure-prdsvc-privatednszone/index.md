---
version: 1.0.1
available_versions:
  - 1.0.1
  - 1.0.0
  - 0.4.3
  - 0.4.2
  - 0.4.1
---

<!-- BEGIN_TF_DOCS -->
# Private DNS Zone Module

## Overview

- Azure Private DNS provides a reliable, secure DNS service to manage and resolve domain names in a virtual network without the need to add a custom DNS solution.
- By using private DNS zones, you can use your own custom domain names rather than the Azure-provided names available today.
- You can link a private DNS zone to one or more virtual networks by creating virtual network links. You can also enable the auto-registration feature to automatically manage the lifecycle of the DNS records for the virtual machines that get deployed in a virtual network.

## Prerequisites

- An existing `Resource Group` is required (referenced by name).  A `Virtual Network` needs to exist first, if not already, to link to the DNS Zone.

## Guidance

#### Usage

- This module is not leveraging the LSEG naming module because the naming restrictions for a Private DNS Zone name.
- The resource name must be the name of the DNS Zone itself,
- Single-labeled private DNS zones (like `.com`, `.ca`) are NOT supported,
- Private DNS zone must have two or more labels. For example `contoso.com` has two labels separated by a dot,
- A private DNS zone can have a maximum of 34 labels.
- You can link virtual networks to this Private DNS zone after zone has been created.
- If you are going to be using the Private DNS Zone with a Private Endpoint the name of the Private DNS Zone must follow the `Private DNS Zone name` schema in the `product documentation` (link given below in the references section) in order for the two resources to be connected successfully.
- `private_dns_zone_vnet_links` - The name must begin with a `letter` or `number`, end with a `letter`, `number or underscore`, and may contain only `letters`, `numbers`, `underscores`, `periods`, or `hyphens`.

#### Security Considerations

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-PDZ-IA\_010 | Azure App Development must not be able to alter the centrally managed DNS Hub VNet | Azure App Development must not be able to alter the centrally managed DNS Hub VNet in the process of linking a product private DNS zone to this VNet (What) by using a DeployIfNotExists policy in the management group mapping (How) to ensure there is no ability for the Azure app development team to have authorisation over the shared DNS Hub VNet to prevent accidental or malicious change of this shared resource (Why)** | False | False  | This control will be implemented via policy. |

## Changelog

- [azure-prdsvc-terraform-privatednszone](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-dns#virtual-network-and-on-premises-workloads-using-a-dns-forwarder)

### Terraform Docs

- [azurerm\_private\_dns\_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone)
- [azurerm\_private\_dns\_zone\_virtual\_network\_link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone\_virtual\_network\_link)

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
| [azurerm_private_dns_zone.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_private_dns_zone_name"></a> [private_dns_zone_name](#input_private_dns_zone_name) | (Required) The name of the Private DNS Zone. <br></br>&#8226; Name must have `1-63 characters`, `2 to 34 labels`, Each label is a set of characters separated by a period. For example, contoso.com has 2 labels. | `string` | n/a | yes |
| <a name="input_private_dns_zone_vnet_links"></a> [private_dns_zone_vnet_links](#input_private_dns_zone_vnet_links) | "(Optional) Map containing Private DNS Zone vnet links Objects."<br/>map(object({<br/>  vnet_id              = (Required) The ID of the Virtual Network that should be linked to the DNS Zone. Changing this forces a new resource to be created.<br/>  registration_enabled = (Optional) Is auto-registration of virtual machine records in the virtual network in the Private DNS zone enabled ?<br/>})) | <pre>map(object({<br/>    vnet_id              = string<br/>    registration_enabled = optional(bool, false)<br/>  }))</pre> | `{}` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_soa_record"></a> [soa_record](#input_soa_record) | "(Required) An `soa_record` for the Private DNS Zone. Changing this forces a new resource to be created."<br/>object({<br/>  email        = (Required) The email contact for the SOA record.<br/>  expire_time  = (Optional) The expire time for the SOA record. Defaults to 2419200.<br/>  minimum_ttl  = (Optional) The minimum Time To Live for the SOA record. By convention, it is used to determine the negative caching duration. Defaults to 300.<br/>  refresh_time = (Optional) The refresh time for the SOA record. Defaults to 3600.<br/>  retry_time   = (Optional) The retry time for the SOA record. Defaults to 300.<br/>  ttl          = (Optional) The Time To Live of the SOA Record in seconds. Defaults to 3600.<br/>}) | <pre>object({<br/>    email        = string<br/>    expire_time  = optional(string)<br/>    minimum_ttl  = optional(number)<br/>    refresh_time = optional(number)<br/>    retry_time   = optional(number)<br/>    ttl          = optional(number)<br/>  })</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns_zone_vnet_link_ids"></a> [dns_zone_vnet_link_ids](#output_dns_zone_vnet_link_ids) | Resource IDs of the Private DNS Zone Virtual Network Link. |
| <a name="output_dns_zone_vnet_link_ids_map"></a> [dns_zone_vnet_link_ids_map](#output_dns_zone_vnet_link_ids_map) | Map of Resource IDs of the Private DNS Zone Virtual Network Link. |
| <a name="output_id"></a> [id](#output_id) | The ID of the Private DNS Zone. |
| <a name="output_name"></a> [name](#output_name) | The name of the Private DNS Zone. |
| <a name="output_resource"></a> [resource](#output_resource) | The Private DNS Zone resource. |
<!-- END_TF_DOCS -->
