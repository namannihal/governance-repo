---
version: 0.3.0
available_versions:
  - 0.3.0
  - 0.2.1
  - 0.2.0
  - 0.1.0
---

<!-- BEGIN_TF_DOCS -->
# azure-prdsvc-terraform-virtualnetworkgateway

## Overview

This terraform module creates a virtual network gateway in Vnet gateway subnet.

## Prerequisites

Virtual network gateway required subnet to be named `GatewaySubnet`.

## Guidance

#### Usage

A virtual network gateway serves two purposes: exchange IP routes between the networks and route network traffic. GatewayType ExpressRoute is a virtual network gateway configuration to send network traffic on an ExpressRoute private network connection.

This module currently offer the following development scope

- Deploying Express route gateway.
- Deploying VPN gateway with active-active and active-stand up instance.
- Deploying VPN gateway with BGP setting

| S. No.  | Virtual Network gateway Type | Supported SKU |
|---------|------------------------------|---------------|
| 1. | VPN | Basic, VpnGw1, VpnGw2, VpnGw3, VpnGw4, VpnGw5, VpnGw1AZ, VpnGw2AZ, VpnGw3AZ, VpnGw4AZ, VpnGw5AZ. |
| 2. | Express Route | Standard, HighPerformance, UltraPerformance, ErGw1AZ, ErGw2AZ, ErGw3AZ. |

#### Additional Information

- vpn_type can be either route_based or policy_based.
- A PolicyBased gateway only supports the Basic SKU.
- To build a UltraPerformance ExpressRoute Virtual Network gateway, the associated Public IP needs to be SKU "Basic" not "Standard."
- Not all SKUs (e.g. ErGw1AZ) are available in all regions. If you see StatusCode=400 -- Original Error: Code="InvalidGatewaySkuSpecifiedForGatewayDeploymentType" please try another region.

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-VNG-AU_010 | Send all diagnostic log categories to a central SOC Log Analytics workspace | Virtual network gateway must send all diagnostic logs to a central SOC Log Analytics workspace (What) within Diagnostic settings (How) in order to support a security investigation after a security incident (Why) | False | False | This control will be implemented via policy. |
| 2. | AZU-VNG-AU_020 | Send all diagnostic log categories to a central SOC Storage Account | Virtual network gateway must send all diagnostic logs to a central SOC Storage Account (What) within Diagnostic settings (How) In order to provide an immutable copy to adhere to compliance requirements (Why) | False | False | This control will be implemented via policy. |

## SMCF Controls

| S. No. | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|--------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types. <br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc. <br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC <br><br>Documentation | True | This control has been implemented in all the cloud products using resource naming modules. <br><br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC <br><br>Policy | True | This control will be implemented using tags parameter. <br><br>This control will be implemented via Policy that inherits all the mandatory tags to the resources. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties. <br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration | Policies <br><br>IaC <br><br>Policies <br><br>IaC | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection <br><br><br><br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy <br><br><br><br>Documentation <br><br><br><br><br>Documentation | True | This control will be implemented by `DINE` Policy. <br><br>[Monitor Azure VPN Gateway](https://learn.microsoft.com/en-us/azure/vpn-gateway/monitor-vpn-gateway) <br><br>[Cloud monitoring service level objectives](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives) <br><br>[Supported Metrics for Azure VPN Gateway](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-network-virtualnetworkgateways-metrics) |
| 5. | [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC <br><br>Documentation | True | This control will be implemented by following parameters: `active-active` virtual network gateway, `scale_units` argument in azurerm_express_route_gateway for redundancy. <br><br>[Highly Available cross-premises and VNet-to-VNet connectivity](https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-highlyavailable) |
| 6. | [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | True | This control will be implemented by following parameters: SKU's supporting zone redundancy for virtual network gateway type `VPN` are `VpnGw1AZ`, `VpnGw2AZ`, `VpnGw3AZ`, `VpnGw4AZ`, `VpnGw5AZ` <br><br>SKU's supporting zone redundancy for virtual network gateway type `ExpressRoute` are `ErGw1AZ`, `ErGw2AZ`, `ErGw3AZ` <br><br>Using three `ip_configuration` blocks we can achieve active-active zone redundant gateway with P2S configuration. <br><br>[Create a zone-redundant virtual network gateway in availability zones](https://learn.microsoft.com/en-us/azure/vpn-gateway/create-zone-redundant-vnet-gateway?toc=%2Fazure%2Fexpressroute%2Ftoc.json) |
| 7. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources. <br><br> SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC <br><br>Documentation | False | This control will be implemented as per LSEG standard based on application team requirement, no locks implemented yet via IaC. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 8. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals. | IaC <br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place. |

## Changelog

- [azure-prdsvc-terraform-virtualnetworkgateway](CHANGELOG.md)

## References

### Microsoft Docs

- [official documentation](https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpngateways)

### Terraform Docs

- [azurerm_virtual_network_gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_gateway)

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
| [azurerm_virtual_network_gateway.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_gateway) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_active_active"></a> [active_active](#input_active_active) | (Optional) VPN gateway instance type. | `bool` | `false` | no |
| <a name="input_address_prefixes"></a> [address_prefixes](#input_address_prefixes) | (Optional) A list of address blocks reserved for virtual network. | `list(string)` | `[]` | no |
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_bgp_settings"></a> [bgp_settings](#input_bgp_settings) | (Optional) A bgp_settings block as defined below.<br>map(object ({<br>  asn               = (Required) The Autonomous System Number (ASN) to use as part of the BGP.<br>  peer_weight       = (Required) The weight added to routes which have been learned through BGP peering. Valid values can be between 0 and 100.<br>  peering_addresses = (Optional) A list of peering addresses as defined below.<br>  map(object({<br>    ip_configuration_name = (Required) The name of the IP configuration of this Virtual Network Gateway. In case there are multiple ip_configuration blocks defined, this property is required to specify.<br>    apipa_addresses       = (Required) A list of Azure custom APIPA addresses assigned to the BGP peer of the Virtual Network Gateway.<br>  }))<br>})) | <pre>map(object({<br>    asn         = number<br>    peer_weight = number<br>    peering_addresses = map(object({<br>      ip_configuration_name = string<br>      apipa_addresses       = list(string)<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_default_local_network_gateway_id"></a> [default_local_network_gateway_id](#input_default_local_network_gateway_id) | (Optional) The ID of the local network gateway through which outbound Internet traffic from the virtual network in which the gateway is created will be routed (forced tunnelling). | `string` | `null` | no |
| <a name="input_edge_zone"></a> [edge_zone](#input_edge_zone) | (Optional) Specifies the Edge Zone within the Azure Region where this Virtual Network Gateway should exist. | `string` | `null` | no |
| <a name="input_enable_bgp"></a> [enable_bgp](#input_enable_bgp) | (Optional) BGP (Border Gateway Protocol) will be enabled for this Virtual Network Gateway. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_generation"></a> [generation](#input_generation) | (Optional) The Generation of the Virtual Network gateway. | `string` | `null` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_ip_configurations"></a> [ip_configurations](#input_ip_configurations) | (Required) One, two or three ip_configuration blocks as defined below. An active-standby gateway requires exactly one ip_configuration block, an active-active gateway requires exactly two ip_configuration blocks whereas an active-active zone redundant gateway with P2S configuration requires exactly three ip_configuration blocks.<br>map(object ({<br>  subnet_id                     = (Required) The ID of the gateway subnet of a virtual network in which the virtual network gateway will be created.<br>  public_ip_address_id          = (Required) The ID of the public IP address to associate with the Virtual Network Gateway.<br>  private_ip_address_allocation = (Required) Defines how the private IP address of the gateways virtual interface is assigned. Valid options are Static or Dynamic. Defaults to Dynamic.<br>})) | <pre>map(object({<br>    subnet_id                     = string<br>    public_ip_address_id          = string<br>    private_ip_address_allocation = string<br>  }))</pre> | n/a | yes |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_private_ip_address_enabled"></a> [private_ip_address_enabled](#input_private_ip_address_enabled) | (Required) Should private IP be enabled on this gateway for connections. | `bool` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input_sku) | (Required) Configuration of the size and capacity of the virtual network gateway. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_type"></a> [type](#input_type) | (Required) The type of the Virtual Network Gateway. | `string` | n/a | yes |
| <a name="input_vpn_type"></a> [vpn_type](#input_vpn_type) | (Optional) The routing type of the Virtual Network Gateway. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The resource ID of the Virtual Network gateway. |
| <a name="output_ip_configuration_pip"></a> [ip_configuration_pip](#output_ip_configuration_pip) | The Id of the public ip. |
| <a name="output_ip_configuration_subnet_id"></a> [ip_configuration_subnet_id](#output_ip_configuration_subnet_id) | The id of the subnet. |
| <a name="output_lng_id"></a> [lng_id](#output_lng_id) | The id of the Local network gateway. |
| <a name="output_name"></a> [name](#output_name) | The name of the Virtual Network gateway. |
| <a name="output_resource"></a> [resource](#output_resource) | The Virtual Network gateway resource. |
| <a name="output_type"></a> [type](#output_type) | The type of the Virtual Network gateway. |
<!-- END_TF_DOCS -->
