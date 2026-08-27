---
version: 0.5.0
available_versions:
  - 0.5.0
  - 0.4.1
  - 0.4.0
  - 0.3.1
  - 0.3.0
---

<!-- BEGIN_TF_DOCS -->
# Virtual Network Module

## Overview

- This module creates a Virtual Network in Azure.

- Azure Virtual Network (VNet) is the fundamental building block for your private network in Azure. VNet enables many types of Azure resources, such as Azure Virtual Machines (VM), to securely communicate with each other, the internet, and on-premises networks.

- VNet is similar to a traditional network that you'd operate in your own data center, but brings with it additional benefits of Azure's infrastructure such as scale, availability, and isolation.

## Prerequisites

- To perform the deployment, the following are required
  - A **Resource Group** (to deploy the VNet)
  - The Service Principal (SPN) used to deploy this module **must have `Network Contributor` role or equivalent assigned** on the **subscription scope**

## Guidance

#### Usage

- This module only creates a single VNet.
- The `as-number` segment is the Microsoft ASN, which is always `12076` for now. The `community value` must be between `20000` and `49999`. The `Regional community` is set by Azure based on the region of your virtual network.
- `service_endpoint_policy_ids` argument is only available for `Microsoft.Storage` service endpoint as of now. Hence, have not been included in this module yet.
- Since `dns_servers` can be configured both inline and via the separate `azurerm_virtual_network_dns_servers` resource, we have to explicitly set it to empty slice ([]) to remove it.
- Delegating to services may not be available in all regions. Check that the service you are delegating to is available in your region using the Azure CLI. Also, `actions` is specific to each service type. The exact list of actions needs to be retrieved using the aforementioned Azure CLI.
- Azure may add default actions depending on the service delegation name and they can't be changed.
- In order to use `Microsoft.Storage.Global` service endpoint (which allows access to virtual networks in other regions), you must enable the `AllowGlobalTagsForStorage` feature in your subscription. This is currently a preview feature, please see the official documentation below for more information.

#### Security Considerations

- This module does not enable a `DDoS Protection Plan` on the `VNet`. If `DDoS Protection plan` enabling is required, a separate module will be used, Azure only allows one DDoS Protection Plan per region.
- This module does not create `VNet peering`. If `VNet peering` is required, a separate module will be used.
- Network policies, like network security groups (NSG), are not supported for Private Link Endpoints or Private Link Services. In order to deploy a Private Link Endpoint on a given subnet, you must set the `private_endpoint_network_policies_enabled` and `private_link_service_network_policies_enabled` attribute to `false`. This setting is only applicable for the Private Link Endpoint, for all other resources in the subnet access is controlled based via the Network Security Group which can be configured using the `azurerm_subnet_network_security_group_association resource`.

#### Additional Information

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-VN-AC_010 | Subnets within a Virtual Network must be protected by NSGs | Subnets must have an associated NSG (What) in the Default properties (How) to ensure network access to resources is controlled by ACLs to protect the resources within the Subnet (Why) | False | False | This control is implemented in the subnet module. |
| 2. | AZU-VN-AC_020 | NSGs must not allow direct public access to resources | NSGs must not allow access from the internet to resources on a Subnet (What) on the Inbound rules page of the NSG (How) to protect resources within the Subnet from direct unauthorised access, instead making use of Azure PaaS Internet gateway resources enforcing front door safeguards and onward routing (Why). | False | False | This control is implemented in the NSG module. |
| 3. | AZU-VN-AC_030 | Inbound rules on NSGs must be configured in accordance with the least privileged principle | Inbound rules on NSGs must be configured in accordance with the least privileged principle (What) in the Inbound Rules settings (How) to ensure only approved traffic is permitted (Why) | False | False | This control is implemented in the NSG module. |
| 4. | AZU-VN-AU_010 | Send all diagnostic log categories to a central Log Analytics workspace | Virtual Networks must send all diagnostic logs to a central Log Analytics workspace (What) within its Diagnostic settings (How) in order to support a security investigation after a security incident involving a Virtual Network (Why) | False | False | This control will be implemented by LSEG DINE policy |
| 5. | AZU-VN-AU_020 | Virtual Networks must send all diagnostic logs to a central SOC Storage Account | Virtual Networks must send all diagnostic logs to a central SOC Storage Account (What) within its Diagnostic settings (How) in order to provide an immutable copy to adhere to compliance requirements (Why) | False | False | This control will be implemented by LSEG DINE policy |
| 6. | AZU-VN-SC_010 | Virtual Networks must only be peered with a Virtual Network that is in the same environment | Virtual Networks must only be peered with a Virtual Network that is within the same environment (e.g. prod <-> prod, dev <-> dev) (What) in the Virtual Network dropdown on the add peering page (How) to reduce the risk of data exfiltration and unauthorised system access (Why). | False | False | This is a platform level control which will be implemented at ALZ vending. |
| 7. | AZU-VN-SC_030 | Bastion deployments must not be part of Virtual Network configuration | Bastion must not be created when creating a Virtual Network (What) using the Security tab or modifying an existing Virtual Network using the Bastion properties page (How). Bastion creations must be a separate deployment conforming to LSEG security standards controls and not configured with Azure default settings (Why). | True | True | Bastion deployment will be done through a separate module. |
| 8. | AZU-VN-SC_040 | Virtual Networks that are public facing must have DDoS protection enabled | Any public facing virtual networks must have a standard DDoS protection plan specified (What) in the DDoS Protection properties of the Virtual Network (How) to protect workloads against DDoS attacks (Why). | True | True | DDoS protection can be enabled in module by setting `ddos_protection_plan`, but enabling it mandatorily for public facing Virtual Network is a platform level check which will be implemented at ALZ vending.
| 9. | AZU-VN-SC_050 | Virtual Networks must only be peered in accordance with LSEG Cloud Security Architecture approved design patterns | Virtual Network peerings must conform to LSEG Cloud Security Architecture approved design patterns (What) in order that correct governance can be enforced to reduce incident blast radius, risk of data exfiltration and unauthorised systems access (Why). | False | False | This is a platform level control which will be implemented at ALZ vending. |
| 10. | AZU-VN-SC_060 | Virtual Networks must not be peered with a Virtual Network that is outside of the Tenant | Virtual Networks must only be peered with a Virtual Network that is within a Subscription that is in the same Tenant (What) in the Subscription dropdown on the add peering page (How) to reduce the risk of data exfiltration and unauthorised system access (Why). | False  | False | This is a platform level control which will be implemented at ALZ vending. |
| 11. | AZU-VN-SC_070 | Non-Routable Virtual Network peerings must not allow forwarded traffic | Non-Routable Virtual Network peerings must be not allow forwarded traffic (What) on the Properties page of the peering (How) so that transitivity is disabled and only traffic from directly peered networks is allowed, preventing undesired routed connections and reducing blast radius (Why) | False | False | This control is implemented in the Virtual Network Peering module. |
| 12. | AZU-VN-SC_080 | Subnets (with the exception of those containing Application/Network/NAT Gateways, Bastion or Azure Firewall) within Routable/Non-Routable Virtual Networks must have an attached UDR defining the default route pointing to the Routable Virtual Network firewall | Subnets (with the exception of those containing Application/Network/NAT Gateways, Bastion or Azure Firewall) within Routable/Non-Routable Virtual Networks must have an attached UDR defining the default route pointing to the Routable Virtual Network firewall (What) in the Properties page (How) in order that all required traffic pass through the firewall (Why) | False | False | This is a platform level control which will be implemented at ALZ vending.
| 13. | AZU-VN-SC_090 | Virtual Networks must use LSEG DNS servers | Virtual Networks must be configured to use LSEG DNS servers (What) in the Properties page (How) so DNS consistency and integrity is maintained (Why). | True | True | Implemented by setting `dns_servers` as a mandatory parameter. List of LSEG DNS servers can be passed to the module during platform deployment. |
| 14. | AZU-VN-SC_100 | Subnets containing Private Endpoints must have Private Endpoint Network Policies set to enabled | Route Table and NSG Subnet Private Endpoint Network Policies must be set to enabled for Subnets that contain Private Endpoints (What) on the Default properties page (How) to allow Private Endpoint access to be subject to UDR and NSG controls rather than bypassing these constructs (Why). | False | False | Private Endpoint Network Policy can be enabled for subnet by setting `private_endpoint_network_policies_enabled = true`. Making sure that it is enabled for each subnet containing private endpoints need to be controlled at platform level, which will be implemented at ALZ vending.|
| 15. | AZU-VN-SC_110 | Non-Routable Virtual Networks must not have a subnet named GatewaySubnet or AzureFirewallSubnet or AzureBastionSubnet | Non-Routable Virtual Networks must not be able to create a subnet with a name 'GatewaySubnet' or 'AzureFirewallSubnet' or 'AzureBastionSubnet' (What) on the Properties page (How) as this subnet is a requirement for a VPN Gateway and Express Route/Azure Firewall/Bastion; resources which would present risks of unauthorised systems access and data exfiltration (Why) | False | False | This is a platform level control which will be implemented at ALZ vending. |
| 16. | AZU-VN-SC_120 | It must not be possible to create a Network or NAT Gateways in a Product Line Virtual Network | It must not be possible to create a Network Gateway (e.g VPN Gateway, Express Route), Local Gateway or NAT Gateway in a Product Line Virtual Network (What) on the Properties page of the Gateway (How) as it presents risks of unauthorised systems access and data exfiltration. Only the Control Plane network can contain these services (Why). | False | False | This is a platform level control which will be implemented at ALZ vending. |

## SMCF Controls

| S. No. | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|--------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types. <br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc. <br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC <br><br>Documentation | True | This control has been implemented in all the cloud products using resource naming modules. <br><br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC <br><br>Policy | True | This control will be implemented using tags parameter. <br><br>This control will be implemented via Policy that inherits all the mandatory tags to the resources. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties. <br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration | Policies <br><br>IaC <br><br>Policies <br><br>IaC | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection <br><br><br><br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy <br><br><br><br>Documentation <br><br><br><br><br>Documentation | True | This control will be implemented by `DINE` Policy. <br><br>[Azure Virtual Network Monitoring](https://learn.microsoft.com/en-us/azure/virtual-network/monitor-virtual-network) <br><br>[Cloud monitoring service level objectives](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives) <br><br>[Supported Metrics for Azure Virtual Network ](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-network-virtualnetworks-metrics) |
| 5. | [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC <br><br>Documentation | True | This control will be implemented using the module `Virtual Network Gateway` with the attribute `type` as Express Route for connecting On-prem and azure virtual network. Similarly `type` VPN as a site to site failover connection with in the resource block `azurerm_virtual_network_gateway`. <br><br>[Highly available hybrid network architecture](https://learn.microsoft.com/en-us/azure/architecture/reference-architectures/hybrid-networking/expressroute-vpn-failover?toc=%2Fazure%2Fvirtual-network%2Ftoc.json) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources. <br><br> SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC <br><br>Documentation | False | This control will be implemented as per LSEG standard based on application team requirement, no locks implemented yet via IaC. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals. | IaC <br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place. |

## Changelog

- [azure-prdsvc-terraform-virtualnetwork](CHANGELOG.md)

## References

### Microsoft Docs

- [official documentation](https://learn.microsoft.com/en-us/azure/storage/common/storage-network-security?tabs=azure-cli#enabling-access-to-virtual-networks-in-other-regions-preview).

### Terraform Docs

- [azurerm\_virtual\_network](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network).
- [azurerm\_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet).

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
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_space"></a> [address_space](#input_address_space) | (Required) Virtual network address space in the format of CIDR range. | `list(string)` | n/a | yes |
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_bgp_community"></a> [bgp_community](#input_bgp_community) | (Optional) The BGP community attribute in format <br>`<as-number>:<community-value>`</br>. | `string` | `"12076:20000"` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_ddos_protection_plan"></a> [ddos_protection_plan](#input_ddos_protection_plan) | (Optional) A ddos_protection_plan block to enable ddos protection."<br/>object({<br/>  id     = "(Required) The ID of DDoS Protection Plan."<br/>  enable = "(Required) Enable/disable DDoS Protection Plan on Virtual Network."<br/>}) | <pre>object({<br/>    id     = string<br/>    enable = bool<br/>  })</pre> | `null` | no |
| <a name="input_dns_servers"></a> [dns_servers](#input_dns_servers) | (Required) Virtual network DNS server IP addresses. | `list(string)` | n/a | yes |
| <a name="input_edge_zone"></a> [edge_zone](#input_edge_zone) | (Optional) Specifies the Edge Zone within the Azure Region where this Virtual Network should exist. Changing this forces a new Virtual Network to be created. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_flow_timeout_in_minutes"></a> [flow_timeout_in_minutes](#input_flow_timeout_in_minutes) | (Optional) The flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes. | `number` | `5` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The Virtual network ID. |
| <a name="output_location"></a> [location](#output_location) | The location of the Virtual network. |
| <a name="output_name"></a> [name](#output_name) | The name of the Virtual network. |
| <a name="output_resource"></a> [resource](#output_resource) | The Virtual Network resource. |
| <a name="output_resource_group_name"></a> [resource_group_name](#output_resource_group_name) | The name of Resource group in which the Virtual Network has been created. |
| <a name="output_vnet"></a> [vnet](#output_vnet) | Details of the Virtual network. |
<!-- END_TF_DOCS -->
