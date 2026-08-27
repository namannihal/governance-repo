---
version: 1.0.3
available_versions:
  - 1.0.3
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.3.1
---

<!-- BEGIN_TF_DOCS -->
# Azure Network Interface Module

## Overview

This terraform module creates Azure Network Interface.

## Prerequisites
- Exisiting `resource_group` and `virtual_network`
- One `network_security_group`to associate with the subnet
- One `route table`
- One `subnet` to configure network interface ip.

## Guidance

#### Usage
- In `Ip_configuration` block `Private_ip _allocation` can be static or dynamic.
- Dynamic means "An IP is automatically assigned during creation of this Network Interface", Static means "User supplied IP address will be used"

###### AzureRM 3.x to 4.x Upgrade Notes for Network Interface

Product Impact -- Low

Users in azurerm 3.x migrating to 4.x  need to perform the following changes
  - The deprecated enable_accelerated_networking property has been removed in favour of the accelerated_networking_enabled property.
  - The deprecated enable_ip_forwarding property has been removed in favour of the ip_forwarding_enabled property.

  - Wiki link for [AzureRM 4.x Upgrade](https://gitlab.dx1.lseg.com/groups/app/app-51310/azure/prdsvc/terraform/-/wikis/Terraform-AzureRM-Provider-Upgrade:-Version-3.x-to-4.x/Network-Interface) for details on the upgrade process.

For more details, refer to the official [AzureRM 4.x Upgrade Guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide)

#### Security Considerations
- Configuring DNS Servers on the Network Interface will override the DNS Servers defined on the Virtual Network.

## Security Controls
- This module is clear listed as no specific security control might be needed for this product in future as well.

## Changelog

- [azure-prdsvc-terraform-networkinterface](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-network-interface?tabs=azure-portal)

### Terraform Docs

- [azurerm_network_interface](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface)

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
| [azurerm_network_interface.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_network_interface"></a> [network_interface](#input_network_interface) | A Network Interface that should be created and attached to this Virtual Machine.<br/>ip_configurations = list(object({<br/>  private_ip_address                                 = "(Optional) The Static IP Address which should be used. When `private_ip_address_allocation` is set to `Static` this field can be configured."<br/>  private_ip_address_version                         = "(Optional) The IP Version to use. Possible values are `IPv4` or `IPv6`. Defaults to `IPv4`."<br/>  private_ip_address_allocation                      = "(Required) The allocation method used for the Private IP Address. Possible values are `Dynamic` and `Static`. Defaults to `Dynamic`."<br/>  subnet_id                                          = "(Optional) The ID of the Subnet where the VM Network Interface should be located in."<br/>  primary                                            = "(Optional) Is this the Primary IP Configuration? Must be `true` for the first `ip_configuration`. Defaults to `false`."<br/>  gateway_load_balancer_frontend_ip_configuration_id = "(Optional) The Frontend IP Configuration ID of a Gateway SKU Load Balancer."<br/>}))<br/>dns_servers                    = "(Optional) A list of IP Addresses defining the DNS Servers which should be used for this Network Interface. Configuring DNS Servers on the Network Interface will override the DNS Servers defined on the Virtual Network."<br/>edge_zone                      = "(Optional) Specifies the Edge Zone within the Azure Region where this Network Interface should exist. Changing this forces a new Network Interface to be created."<br/>accelerated_networking_enabled = "(Optional) Should Accelerated Networking be enabled? Defaults to `false`. Only certain Virtual Machine sizes are supported for Accelerated Networking - [more information can be found in this document](https://docs.microsoft.com/azure/virtual-network/create-vm-accelerated-networking-cli). To use Accelerated Networking in an Availability Set, the Availability Set must be deployed onto an Accelerated Networking enabled cluster."<br/>ip_forwarding_enabled          = "(Optional) Should IP Forwarding be enabled? Defaults to `false`."<br/>internal_dns_name_label        = "(Optional) The (relative) DNS Name used for internal communications between Virtual Machines in the same Virtual Network." | <pre>object({<br/>    ip_configurations = list(object({<br/>      private_ip_address                                 = optional(string)<br/>      private_ip_address_version                         = optional(string, "IPv4")<br/>      private_ip_address_allocation                      = optional(string, "Dynamic")<br/>      subnet_id                                          = optional(string)<br/>      primary                                            = optional(bool, false)<br/>      gateway_load_balancer_frontend_ip_configuration_id = optional(string)<br/>    }))<br/>    dns_servers                    = optional(list(string))<br/>    edge_zone                      = optional(string)<br/>    accelerated_networking_enabled = optional(bool, false)<br/>    ip_forwarding_enabled          = optional(bool, false)<br/>    internal_dns_name_label        = optional(string)<br/><br/>  })</pre> | <pre>{<br/>  "accelerated_networking_enabled": null,<br/>  "dns_servers": null,<br/>  "edge_zone": null,<br/>  "internal_dns_name_label": null,<br/>  "ip_configurations": [<br/>    {<br/>      "gateway_load_balancer_frontend_ip_configuration_id": null,<br/>      "primary": true,<br/>      "private_ip_address": null,<br/>      "private_ip_address_allocation": null,<br/>      "private_ip_address_version": null,<br/>      "subnet_id": null<br/>    }<br/>  ],<br/>  "ip_forwarding_enabled": null<br/>}</pre> | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The id of the network interface. |
| <a name="output_name"></a> [name](#output_name) | The name of the network interface. |
| <a name="output_resource"></a> [resource](#output_resource) | The Network Interface resource. |
<!-- END_TF_DOCS -->
