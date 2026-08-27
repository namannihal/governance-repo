---
version: 1.0.2
available_versions:
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.6.3
  - 0.6.2
---

<!-- BEGIN_TF_DOCS -->
## Network Security group module with security rules

## Overview

This terraform module creates a `network security group` and associated resources. A network security group contains security rules that allow or deny inbound network traffic to, or outbound network traffic from, several types of Azure resources. For each rule, you can specify source and destination, port, and protocol.

## Prerequisites

- Existing `Resource Group`.
- Create `Virtual Network`, `Subnet`.

## Guidance

#### Usage

- This module creates the `Network security group` with option to create additional security rules.
- NSGs are applied to network interface or virtual machine.

#### Security Considerations

- NSGs have security rules (inbound & outbound) which are attached to Subnets.
- Existing Azure Custom Policy has `Deny` effect on the "subnet creation without NSGs associated".

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-VN-AC_020 | NSGs must not allow direct public access to resources. | NSGs must not allow access from the internet to resources on a Subnet (What) on the Inbound rules page of the NSG (How) to protect resources within the Subnet from direct unauthorised access, instead making use of Azure PaaS Internet gateway resources enforcing front door safeguards and onward routing (Why). | True | False | This rule is added by default. |
| 2. | AZU-VN-AC_030 | Inbound rules on NSGs must be configured in accordance with the least privileged principle | Inbound rules on NSGs must be configured in accordance with the least privileged principle (What) in the Inbound Rules settings (How) to ensure only approved traffic is permitted (Why) | True | False | The default rules are added adhering to least privelege principle. |

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames). |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Monitor Azure Virtual Network](https://learn.microsoft.com/en-us/azure/virtual-network/monitor-virtual-network). |
| 5. | [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | False | This cannot be implemented at product level. |

## Changelog

- [azure-prdsvc-terraform-networksecuritygroup](CHANGELOG.md)

## References

### Microsoft Docs
- [Azure Network Security group](https://learn.microsoft.com/en-us/azure/virtual-network/network-security-groups-overview)

### Terraform Docs
- [azurerm_network_security_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group)

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
| [azurerm_network_security_group.nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_subnet_network_security_group_association.nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 71 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_security_rules"></a> [security_rules](#input_security_rules) | list(object({<br/>  name                                       = "(Required) The name of the security rule."<br/>  description                                = "(Optional) A description for this rule. Restricted to 140 characters."<br/>  protocol                                   = "(Required) Network protocol this rule applies to. Possible values include Tcp, Udp, Icmp, Esp, Ah or * (which matches all)."<br/>  source_port_range                          = "(Optional) Source Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if source_port_ranges is not specified."<br/>  source_port_ranges                         = "(Optional) List of source ports or port ranges. This is required if source_port_range is not specified."<br/>  destination_port_range                     = "(Optional) Destination Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if destination_port_ranges is not specified."<br/>  destination_port_ranges                    = "(Optional) List of destination ports or port ranges. This is required if destination_port_range is not specified."<br/>  source_address_prefix                      = "(Optional) CIDR or source IP range or * to match any IP. Tags such as VirtualNetwork, AzureLoadBalancer and Internet can also be used. This is required if source_address_prefixes is not specified."<br/>  source_address_prefixes                    = "(Optional) List of source address prefixes. Tags may not be used. This is required if source_address_prefix is not specified."<br/>  source_application_security_group_ids      = "(Optional) A List of source Application Security Group IDs"<br/>  destination_address_prefix                 = "(Optional) CIDR or destination IP range or * to match any IP. Tags such as VirtualNetwork, AzureLoadBalancer and Internet can also be used. This is required if destination_address_prefixes is not specified."<br/>  destination_address_prefixes               = "(Optional) List of destination address prefixes. Tags may not be used. This is required if destination_address_prefix is not specified."<br/>  destination_application_security_group_ids = "(Optional) A List of destination Application Security Group IDs"<br/>  access                                     = "(Required) Specifies whether network traffic is allowed or denied. Possible values are Allow and Deny."<br/>  priority                                   = "(Required) Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule."<br/>  direction                                  = "(Required) The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are Inbound and Outbound."<br/>})) | <pre>map(object({<br/>    name                                       = string<br/>    description                                = optional(string)<br/>    protocol                                   = string<br/>    source_port_range                          = optional(string)<br/>    source_port_ranges                         = optional(list(string))<br/>    destination_port_range                     = optional(string)<br/>    destination_port_ranges                    = optional(list(string))<br/>    source_address_prefix                      = optional(string)<br/>    source_address_prefixes                    = optional(list(string))<br/>    source_application_security_group_ids      = optional(list(string))<br/>    destination_address_prefix                 = optional(string)<br/>    destination_address_prefixes               = optional(list(string))<br/>    destination_application_security_group_ids = optional(list(string))<br/>    access                                     = string<br/>    priority                                   = number<br/>    direction                                  = string<br/>  }))</pre> | `{}` | no |
| <a name="input_subnet_ids"></a> [subnet_ids](#input_subnet_ids) | (Optional) IDs of the subnets AzNetworkSecurityGroup can connect to. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The ID of the created Network Security Group. |
| <a name="output_name"></a> [name](#output_name) | The name of the created Network Security Group. |
| <a name="output_resource"></a> [resource](#output_resource) | The Network Security Group resource. |
<!-- END_TF_DOCS -->
