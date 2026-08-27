---
version: 0.3.2
available_versions:
  - 0.3.2
  - 0.3.1
  - 0.3.0
  - 0.2.0
  - 0.1.0
---

<!-- BEGIN_TF_DOCS -->
# ExpressRoute Circuit Peering module

## Overview

This terraform module creates Private peering and microsoft peering on express route circuit

## Prerequisites

## Guidance

#### Usage

- Only one Peering of each Type can be created. Attempting to create multiple peerings of the same type will overwrite the original peering.
- Ipv6 can be specified when peering_type is `MicrosoftPeering` or `AzurePrivatePeering`.
- In this module we have used  "microsoft_peering_config_ipv4" block to advertise the community values over microsoft peering.
However, other way to advertise the community value is creating "Route filter" for Microsoft peering.

#### Security Considerations

#### Additional Information

- Currently, "Route Filter" resource type is not been added, if needed a seperate repo will be created for "Route Filter" to advertise the community value over Microsoft peering.

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. |  |  |  |  |  |  |

## Changelog

- [azure-prdsvc-terraform-expressroutecircuitpeering](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/expressroute/expressroute-circuit-peerings)

### Terraform Docs

- [azurerm_virtual_network_gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/express_route_circuit_peering#route_filter_id)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm) | >= 3.51 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | >= 3.51 |

## Resources

| Name | Type |
|------|------|
| [azurerm_express_route_circuit_peering.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/express_route_circuit_peering) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_express_route_circuit_name"></a> [express_route_circuit_name](#input_express_route_circuit_name) | (Required) Name of the express route circuit | `string` | n/a | yes |
| <a name="input_ipv4_enabled"></a> [ipv4_enabled](#input_ipv4_enabled) | (Optional) A boolean value indicating whether the IPv4 peering is enabled. Defaults to true | `bool` | `true` | no |
| <a name="input_ipv6"></a> [ipv6](#input_ipv6) | (Optional) A boolean value indicating whether the IPv6 peering is enabled. Defaults to true | `bool` | `true` | no |
| <a name="input_microsoft_peering_config_ipv4"></a> [microsoft_peering_config_ipv4](#input_microsoft_peering_config_ipv4) | object({ (Optional)<br/>  advertised_public_prefixes = "(Required) A list of Advertised Public Prefixes"<br/>  customer_asn               = "(optional) The CustomerASN of the peering. Defaults to 0<br/>  routing_registry_name      = "(optional) The Routing Registry against which the AS number and prefixes are registered. For example: ARIN, RIPE, AFRINIC etc. Defaults to NONE"<br/>  advertised_communities     = "(optional) The communities of Bgp Peering specified for microsoft peering."<br/>}) | <pre>object({<br/>    advertised_public_prefixes = optional(list(string))<br/>    customer_asn               = optional(number)<br/>    routing_registry_name      = optional(string)<br/>    advertised_communities     = optional(list(string))<br/>  })</pre> | `{}` | no |
| <a name="input_microsoft_peering_config_ipv6"></a> [microsoft_peering_config_ipv6](#input_microsoft_peering_config_ipv6) | object({(optional)<br/>  advertised_public_prefixes = "(Required) A list of Advertised Public Prefixes"<br/>  customer_asn               = "(optional) The CustomerASN of the peering. Defaults to 0<br/>  routing_registry_name      = "(optional) The Routing Registry against which the AS number and prefixes are registered. For example: ARIN, RIPE, AFRINIC etc. Defaults to NONE"<br/>  advertised_communities     = "(optional) The communities of Bgp Peering specified for microsoft peering."<br/>}) | <pre>object({<br/>    advertised_public_prefixes = optional(list(string))<br/>    customer_asn               = optional(number)<br/>    routing_registry_name      = optional(string)<br/>    advertised_communities     = optional(list(string))<br/>  })</pre> | `{}` | no |
| <a name="input_peer_asn"></a> [peer_asn](#input_peer_asn) | (Required) The Either a 16-bit or a 32-bit ASN. Can either be public or private. | `number` | n/a | yes |
| <a name="input_peering_type"></a> [peering_type](#input_peering_type) | (Required) The type of the ExpressRoute Circuit Peering. Acceptable values include AzurePrivatePeering and MicrosoftPeering. | `string` | n/a | yes |
| <a name="input_primary_peer_address_prefix_ipv4"></a> [primary_peer_address_prefix_ipv4](#input_primary_peer_address_prefix_ipv4) | (Required) A /30 subnet for the primary link. Required when config for IPv4. | `string` | n/a | yes |
| <a name="input_primary_peer_address_prefix_ipv6"></a> [primary_peer_address_prefix_ipv6](#input_primary_peer_address_prefix_ipv6) | (Required) A /30 subnet for the primary link. Required when config for IPv6. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_secondary_peer_address_prefix_ipv4"></a> [secondary_peer_address_prefix_ipv4](#input_secondary_peer_address_prefix_ipv4) | (Required) A /30 subnet for the secondary link. Required when config for IPv4. | `string` | n/a | yes |
| <a name="input_secondary_peer_address_prefix_ipv6"></a> [secondary_peer_address_prefix_ipv6](#input_secondary_peer_address_prefix_ipv6) | (Required) A /30 subnet for the secondary link. Required when config for IPv6. | `string` | n/a | yes |
| <a name="input_shared_key"></a> [shared_key](#input_shared_key) | (Optional) The shared key. Can be a maximum of 25 characters. | `string` | `null` | no |
| <a name="input_vlan_id"></a> [vlan_id](#input_vlan_id) | (Required) A valid VLAN ID to establish this peering on. | `number` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_private_peering_asn"></a> [azure_private_peering_asn](#output_azure_private_peering_asn) | The ASN used by Azure. |
| <a name="output_circuit_peering_id"></a> [circuit_peering_id](#output_circuit_peering_id) | The ID of the ExpressRoute Circuit Peering. |
| <a name="output_peering_type"></a> [peering_type](#output_peering_type) | Peering type |
| <a name="output_private_peering_primary_azure_port"></a> [private_peering_primary_azure_port](#output_private_peering_primary_azure_port) | The Primary Port used by Azure for this Peering. |
| <a name="output_private_peering_secondary_azure_port"></a> [private_peering_secondary_azure_port](#output_private_peering_secondary_azure_port) | The secondary Port used by Azure for this Peering. |
| <a name="output_resource"></a> [resource](#output_resource) | The Express Route Circuit Peering Resource. |
<!-- END_TF_DOCS -->
