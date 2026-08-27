---
version: 0.3.1
available_versions:
  - 0.3.1
  - 0.3.0
  - 0.2.1
  - 0.2.0
  - 0.1.0
---

<!-- BEGIN_TF_DOCS -->
# Virtual Network Peering module

## Overview
- This terraform module creates a Peering between two Virtual Networks.
- Virtual network peering enables to seamlessly connect two or more Virtual Networks in Azure. The virtual networks appear as one for connectivity purposes. The traffic between virtual machines in peered virtual networks uses the Microsoft backbone infrastructure. Like traffic between virtual machines in the same network, traffic is routed through Microsoft's private network only.

## Prerequisites
- Exisiting `resource_group`
- two `Virtual network`

## Guidance
#### Usage
- For peered virtual networks, resources in either virtual network can directly connect with resources in the peered virtual network.
- use_remote_gateways can be set to control if remote gateways can be used on the local virtual network. If the flag is set to true, and allow_gateway_transit on the remote peering is also true, virtual network will use gateways of remote virtual network for transit. Only one peering can have this flag set to true. This flag cannot be set if virtual network already has a gateway.
- use_remote_gateways must be set to false if using Global Virtual Network Peerings.
- Virtual Network peerings cannot be created, updated or deleted concurrently.
- This module only creates a peering from source Vnet to destination Vnet, the reverse peering is not done. For creating a reverse peering, module can be called again with required properties as input.

#### Security Considerations

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-VN-SC_010 | Virtual Networks must only be peered with a Virtual Network that is in the same environment | Virtual Networks must only be peered with a Virtual Network that is within the same environment (e.g. prod <-> prod, dev <-> dev) (What) in the Virtual Network dropdown on the add peering page (How) to reduce the risk of data exfiltration and unauthorised system access (Why) | False | False | This is a platform level control which will be implemented at ALZ vending. |
| 2. | AZU-VN-SC_050 | Virtual Networks must only be peered in accordance with LSEG Cloud Security Architecture approved design patterns | Virtual Network peerings must conform to LSEG Cloud Security Architecture approved design patterns (What) in order that correct governance can be enforced to reduce incident blast radius, risk of data exfiltration and unauthorised systems access (Why) | False | False | This is a platform level control which will be implemented at ALZ vending. |
| 3. | AZU-VN-SC_060 | Virtual Networks must not be peered with a Virtual Network that is outside of the Tenant | Virtual Networks must only be peered with a Virtual Network that is within a Subscription that is in the same Tenant (What) in the Subscription dropdown on the add peering page (How) to reduce the risk of data exfiltration and unauthorised system access (Why) | False | False | This is a platform level control which will be implemented at ALZ vending. |
| 4. | AZU-VN-SC_070 | Non-Routable Virtual Network peerings must not allow forwarded traffic | Non-Routable Virtual Network peerings must be not allow forwarded traffic (What) on the Properties page of the peering (How) so that transitivity is disabled and only traffic from directly peered networks is allowed, preventing undesired routed connections and reducing blast radius (Why) | True | True | Implemented by setting `allow_forwarded_traffic` as `false` by default, but it can be enabled to support peerings other than spoke. |

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames)|
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Collect Diagnostics and send to Log Analytics]<br><br>[Monitoring Azure virtual network](https://learn.microsoft.com/en-us/azure/virtual-network/monitor-virtual-network)<br><br>[Cloud monitoring service level objectives ](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives)<br><br>[Monitoring Azure virtual network data reference](https://learn.microsoft.com/en-us/azure/virtual-network/monitor-virtual-network-reference) |
| 5.| [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | True | Replica of a virtual network in a given region be re-created in another region to ensure BCDR.<br><br>[Virtual Network – Business Continuity](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-disaster-recovery-guidance)
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |

## Changelog

- [azure-prdsvc-terraform-virtualnetworkpeering](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-peering-overview)

### Terraform Docs

- [azurerm_virtual_network_peering](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering)

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
| [azurerm_virtual_network_peering.vnet_peering](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network.virtual_network](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_forwarded_traffic"></a> [allow_forwarded_traffic](#input_allow_forwarded_traffic) | (Optional) Controls if forwarded traffic from VMs in the remote virtual network is allowed. Defaults to false. | `bool` | `false` | no |
| <a name="input_allow_gateway_transit"></a> [allow_gateway_transit](#input_allow_gateway_transit) | (Optional) Controls gatewayLinks can be used in the remote virtual network’s link to the local virtual network. Defaults to false. | `bool` | `false` | no |
| <a name="input_allow_virtual_network_access"></a> [allow_virtual_network_access](#input_allow_virtual_network_access) | (Optional) Controls if the VMs in the remote virtual network can access VMs in the local virtual network. Defaults to true. | `bool` | `true` | no |
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_remote_virtual_network_id"></a> [remote_virtual_network_id](#input_remote_virtual_network_id) | (Required) The full Azure resource ID of the remote virtual network. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_use_remote_gateways"></a> [use_remote_gateways](#input_use_remote_gateways) | (Optional) Controls if remote gateways can be used on the local virtual network. This flag cannot be set if virtual network already has a gateway. Defaults to false. | `bool` | `false` | no |
| <a name="input_virtual_network_id"></a> [virtual_network_id](#input_virtual_network_id) | (Required) The full Azure resource ID of the virtual network. Changing this forces a new resource to be created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The generated ID of the Virtual Network Peering. |
| <a name="output_name"></a> [name](#output_name) | The name of the Virtual Network Peering. |
| <a name="output_resource"></a> [resource](#output_resource) | The Virtual Network Peering resource. |
| <a name="output_virtual_network_name"></a> [virtual_network_name](#output_virtual_network_name) | The name of the Virtual Network. |
<!-- END_TF_DOCS -->
