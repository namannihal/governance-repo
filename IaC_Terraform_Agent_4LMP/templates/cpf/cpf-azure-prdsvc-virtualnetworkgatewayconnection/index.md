---
version: 0.2.2
available_versions:
  - 0.2.2
  - 0.2.1
  - 0.2.0
  - 0.1.0
---

<!-- BEGIN_TF_DOCS -->
# Virtual Network Gateway Connection module

## Overview

This terraform module creates virtual network gateway connection.

## Prerequisites

Virtual Network Gateway and Express Route has to be in-place before creation of this module.

## Guidance

#### Usage

For variable `connection_type`, valid options are IPsec (Site-to-Site), ExpressRoute (ExpressRoute), and Vnet2Vnet (VNet-to-VNet). Each of these connection type requires different mandatory argument.

#### Additional Information

In testing pipeline for this module, terraform apply will not work as this module requires Express Route Circuit to be provisioned before creating the connection between Express Route Circuit and Virtual Network Gateway of `ExpressRoute` type.

#### Security Considerations

## Security Controls

- There are no security Controls available to be implemented.

## Changelog

- [azure-prdsvc-terraform-virtualnetworkgatewayconnection](CHANGELOG.md)

## References

### Microsoft Docs

- [Official documentation](https://learn.microsoft.com/en-us/azure/expressroute/expressroute-howto-linkvnet-portal-resource-manager)

### Terraform Docs

- [azurerm_virtual_network_gateway_connection](https://registry.terraform.io/providers/hashicorp/azurerm/2.48.0/docs/resources/virtual_network_gateway_connection)

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
| [azurerm_virtual_network_gateway_connection.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_gateway_connection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_authorization_key"></a> [authorization_key](#input_authorization_key) | (Required) Authorization key of express route circuit | `string` | n/a | yes |
| <a name="input_connection_mode"></a> [connection_mode](#input_connection_mode) | (Optional) Connection mode to use. Possible values are Default, InitiatorOnly and ResponderOnly | `string` | `"Default"` | no |
| <a name="input_connection_name"></a> [connection_name](#input_connection_name) | (Required) Name of the express route connection | `string` | n/a | yes |
| <a name="input_connection_protocol"></a> [connection_protocol](#input_connection_protocol) | (Optional) The IKE protocol version to use. Possible values are IKEv1 and IKEv2, : Only valid for IPSec connections on virtual network gateways with SKU VpnGw1, VpnGw2, VpnGw3, VpnGw1AZ, VpnGw2AZ or VpnGw3AZ | `string` | `null` | no |
| <a name="input_connection_type"></a> [connection_type](#input_connection_type) | (Required)The type of connection. Valid options are IPsec (Site-to-Site), ExpressRoute (ExpressRoute), and Vnet2Vnet (VNet-to-VNet). | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_custom_bgp_addresses"></a> [custom_bgp_addresses](#input_custom_bgp_addresses) | (Optional) Custom BGP address<br/>object({<br/>  primary   = (Required) primary bgp address<br/>  secondary = (Required) secodnary bgp address<br/>}) | <pre>object({<br/>    primary   = string<br/>    secondary = string<br/>  })</pre> | `null` | no |
| <a name="input_dpd_timeout_seconds"></a> [dpd_timeout_seconds](#input_dpd_timeout_seconds) | (Optional) The dead peer detection timeout of this connection in seconds | `number` | `null` | no |
| <a name="input_egress_nat_rule_ids"></a> [egress_nat_rule_ids](#input_egress_nat_rule_ids) | (Optional) A list of the egress NAT Rule Ids. | `list(string)` | `[]` | no |
| <a name="input_enable_bgp"></a> [enable_bgp](#input_enable_bgp) | (Optional) If true, BGP (Border Gateway Protocol) is enabled for this connection | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_express_route_circuit_id"></a> [express_route_circuit_id](#input_express_route_circuit_id) | (Required) The id of express route circuit | `string` | n/a | yes |
| <a name="input_express_route_gateway_bypass"></a> [express_route_gateway_bypass](#input_express_route_gateway_bypass) | (Optional) If true, data packets will bypass ExpressRoute Gateway for data forwarding This is only valid for ExpressRoute connections. | `bool` | `false` | no |
| <a name="input_gw_connection_shared_key"></a> [gw_connection_shared_key](#input_gw_connection_shared_key) | (Optional) The shared IPSec key. A key could be provided if a Site-to-Site, VNet-to-VNet or ExpressRoute connection is created | `string` | `null` | no |
| <a name="input_ingress_nat_rule_ids"></a> [ingress_nat_rule_ids](#input_ingress_nat_rule_ids) | (Optional) A list of the ingress NAT Rule Ids. | `list(string)` | `[]` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_ipsec_policy"></a> [ipsec_policy](#input_ipsec_policy) | (Optional) ipsec policy<br/>object({<br/>  dh_group         = (Required) The DH group used in IKE phase 1 for initial SA. Valid options are DHGroup1, DHGroup14, DHGroup2, DHGroup2048, DHGroup24, ECP256, ECP384, or None.<br/>  ike_encryption   = (Required) The IKE encryption algorithm. Valid options are AES128, AES192, AES256, DES, DES3, GCMAES128, or GCMAES256.<br/>  ike_integrity    = (Required) The IKE integrity algorithm. Valid options are GCMAES128, GCMAES256, MD5, SHA1, SHA256, or SHA384.<br/>  ipsec_encryption = (Required) The IPSec encryption algorithm. Valid options are AES128, AES192, AES256, DES, DES3, GCMAES128, GCMAES192, GCMAES256, or None.<br/>  ipsec_integrity  = (Required) The IPSec integrity algorithm. Valid options are GCMAES128, GCMAES192, GCMAES256, MD5, SHA1, or SHA256.<br/>  pfs_group        = (Required) The DH group used in IKE phase 2 for new child SA. Valid options are ECP256, ECP384, PFS1, PFS14, PFS2, PFS2048, PFS24, PFSMM, or None.<br/>  sa_datasize      = (Required) The IPSec SA payload size in KB. Must be at least 1024 KB. Defaults to 102400000 KB.<br/>  sa_lifetime      = (Required) The IPSec SA lifetime in seconds. Must be at least 300 seconds. Defaults to 27000 seconds.<br/><br/>}) | <pre>object({<br/>    dh_group         = string<br/>    ike_encryption   = string<br/>    ike_integrity    = string<br/>    ipsec_encryption = string<br/>    ipsec_integrity  = string<br/>    pfs_group        = string<br/>    sa_datasize      = string<br/>    sa_lifetime      = string<br/>  })</pre> | `null` | no |
| <a name="input_local_azure_ip_address_enabled"></a> [local_azure_ip_address_enabled](#input_local_azure_ip_address_enabled) | (Optional) Use private local Azure IP for the connection. | `bool` | `false` | no |
| <a name="input_local_network_gateway_id"></a> [local_network_gateway_id](#input_local_network_gateway_id) | (Optional) The ID of the local network gateway when creating Site-to-Site connection | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_peer_virtual_network_gateway_id"></a> [peer_virtual_network_gateway_id](#input_peer_virtual_network_gateway_id) | (Optional) The ID of the peer virtual network gateway when creating a VNet-to-VNet connection (i.e. when type is Vnet2Vnet). | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_routing_weight"></a> [routing_weight](#input_routing_weight) | (Optional) The routing weight. Defaults to 10 | `number` | `10` | no |
| <a name="input_traffic_selector_policy"></a> [traffic_selector_policy](#input_traffic_selector_policy) | (Optional)traffic selector policy<br/>object({<br/>  local_address_cidrs  = (Required) List of local CIDRs.<br/>  remote_address_cidrs = (Required) List of remote CIDRs.<br/>}) | <pre>object({<br/>    local_address_cidrs  = list(string)<br/>    remote_address_cidrs = list(string)<br/>  })</pre> | `null` | no |
| <a name="input_use_policy_based_traffic_selectors"></a> [use_policy_based_traffic_selectors](#input_use_policy_based_traffic_selectors) | (Optional) If true, policy-based traffic selectors are enabled for this connection. Enabling policy-based traffic selectors requires an ipsec_policy | `bool` | `false` | no |
| <a name="input_virtual_network_gateway_id"></a> [virtual_network_gateway_id](#input_virtual_network_gateway_id) | (Required) The ID of the Virtual Network Gateway in which the connection will be created | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | Virtual Network gateway connection id |
| <a name="output_name"></a> [name](#output_name) | Virtual Network gateway connection name |
| <a name="output_resource"></a> [resource](#output_resource) | The Virtual Network gateway connection resource |
<!-- END_TF_DOCS -->
