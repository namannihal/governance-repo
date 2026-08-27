---
version: 0.8.5
available_versions:
  - 0.8.5
  - 0.8.4
  - 0.8.3
  - 0.8.2
  - 0.8.1
---

<!-- BEGIN_TF_DOCS -->
# Subnet Module

## Overview

This module creates a `Subnet` in a `Virtual Network` in Azure. This module creates a subnet & subnet delegation.
Subnets enable you to segment the virtual network into one or more subnetworks. You allocate a portion of the virtual network's address space to each subnet. You can then deploy Azure resources in a specific subnet.

## Prerequisites
- The `virtual network` has been created in the `Resource Group`.
- `Network Security Group` and `Route Table` to be created.
- The `Service Principal (SPN)` used to deploy this module must have `Network Contributor` role or equivalent assigned on the subscription scope.

## Guidance

#### Usage

- **The latest tag - 0.8.0 was published for AzAPI 2.x.x upgrade. Application teams to not use this version until all the products using AzAPI are published in 2.x.x.**
- This module have an option to associate subnet to a network security group during the subnet creation itself by passing `network_security_group_id`.
- This module have an option to associate subnet to a route table during the subnet creation itself by passing `route_table_id`.
- This module is having 3 examples one is supported all features of subnet and second one is used to deploy special subnets such as: Gateway Subnet, firewall subnet and Bastion subnet etc, and the third one deploys multiple subnet at once in a Virtual Network.

#### Security Considerations

- Network policies, like network security groups (NSG), are not supported for Private Link Endpoints or Private Link Services. In order to deploy a Private Link Endpoint on a given subnet, you must set the `private_endpoint_network_policies_enabled` and `private_link_service_network_policies_enabled` attribute to `false`. This setting is only applicable for the Private Link Endpoint, for all other resources in the subnet access is controlled based via the Network Security Group.
- Delegating to services may not be available in all regions. Check that the service you are delegating to is available in your region using the Azure CLI. Also, `actions` is specific to each service type. The exact list of actions needs to be retrieved using the aforementioned Azure CLI.
- Azure may add default actions and service endpoints as required, depending on the Service Delegation or Service Endpoints added. These changes can't be modified. To ensure Terraform state is not affected by these changes and to prevent unwanted modifications to dependant resources, we have added `delegations` and `serviceEndpoints` to `ignore_body_changes`.

#### Additional Information

- This module utilizes the Azure [AzAPI Provider](https://registry.terraform.io/providers/Azure/azapi/latest/docs) in place of [azurerm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs) to create Subnet. Currently, the [azurerm\_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) resource does not support the association of subnet and network security group during the subnet creation itself.
- Terraform currently provides both a standalone Subnet resource, and allows for Subnets to be defined in-line within the Virtual Network resource. At this time you cannot use a Virtual Network with in-line Subnets in conjunction with any Subnet resources. Doing so will cause a conflict of Subnet configurations and will overwrite Subnet's.
- Currently only a single address prefix can be set, as the `Multiple Subnet Address Prefixes Feature`(document below) is not yet in public preview or general availability.
- `AnotherOperationInProgress` errors have been observed in scenarios requiring multiple updates to the VNet in quick succession through AzAPI. Therefore an option have been added to the module, to create multiple subnets (with associated configuration) at once in a virtual network by providing variable `subnets`. This not only improves reliability, but also significantly increases performance.
    1. Multiple subnet creation should be used when creating subnets in Virtual network which does not contains any existing subnet. As per the azapi behavior, if subnets are being created using multiple subnet creation option i.e. by passing variable `subnets`, the existing subnets within the virtual network gets deleted. The reason is, if subnets are defined separately, when updating the vnet which has no definition of its subnets, its request body won't contain any subnets definitions, so existing subnets will be removed.
    2. If a new subnet has to be created in Virtual Network with existing subnets then use the single subnet creation.
    3. If multiple subnet needs to be created in Virtual Network with existing subnets, then subnet module can be called multiple times creating one subnet in each call, and add dependency of one subnet module call on another to avoid `AnotherOperationInProgress` error.
- Although the module provides an option to create special subnets like such as: Gateway Subnet, firewall subnet and Bastion subnet etc, there is a policy in place denying their creation. Please reach out to landing zone team, before proceeding with creation of special subnets.
- The multiple subnet creation example is commented in validation template, due to the unavailability of two vnets in greenfield environment for testing as of now. The scenario has been tested in LMSP0.

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-VN-AC_010 | Subnets within a Virtual Network must be protected by NSGs | Subnets must have an associated NSG (What) in the Default properties (How) to ensure network access to resources is controlled by ACLs to protect the resources within the Subnet (Why) | True | True | NSG association with Subnet is optional in the module to support those containing Application/Network/NAT Gateways, Bastion or Azure Firewall. For any other subnet being created using this module, it is required to associate NSG during the subnet creation itself by providing variable `network_security_group_id`. |
| 2. | AZU-VN-SC_080 | Subnets (with the exception of those containing Application/Network/NAT Gateways, Bastion or Azure Firewall) within Routable/Non-Routable Virtual Networks must have an attached UDR defining the default route pointing to the Routable Virtual Network firewall | Subnets (with the exception of those containing Application/Network/NAT Gateways, Bastion or Azure Firewall) within Routable/Non-Routable Virtual Networks must have an attached UDR defining the default route pointing to the Routable Virtual Network firewall (What) in the Properties page (How) in order that all required traffic pass through the firewall (Why). | False | False | Route table association with Subnet is optional in the module to support those containing Application/Network/NAT Gateways, Bastion or Azure Firewall. For any other subnet being created using this module, it is required to associate route table during the subnet creation itself by providing variable `route_table_id`. |
| 3. | AZU-VN-SC_100 | Subnets containing Private Endpoints must have Private Endpoint Network Policies set to enabled | Route Table and NSG Subnet Private Endpoint Network Policies must be set to enabled for Subnets that contain Private Endpoints (What) on the Default properties page (How) to allow Private Endpoint access to be subject to UDR and NSG controls rather than bypassing these constructs (Why). | False | False | Private Endpoint Network Policy can be enabled for subnet by setting `private_endpoint_network_policies_enabled = true`. Making sure that it is enabled for each subnet containing private endpoints need to be controlled at platform level, which will be implemented at ALZ vending.|

## SMCF Controls

| S. No. | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|--------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types. <br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc. <br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC <br><br>Documentation | True | This control has been implemented in all the cloud products using resource naming modules. <br><br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties. <br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration | Policies <br><br>IaC <br><br>Policies <br><br>IaC | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 3. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection <br><br><br><br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy <br><br><br><br>Documentation <br><br><br><br><br>Documentation | True | This control will be implemented by `DINE` Policy. <br><br>[Monitoring Azure Virtual Network](https://learn.microsoft.com/en-us/azure/virtual-network/monitor-virtual-network) <br><br>[Cloud monitoring service level objectives](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives) <br><br>[Supported Metrics for Azure Virtual Network ](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-network-virtualnetworks-metrics) |
| 4. | [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC <br><br>Documentation | True | This control can be implemented using the module `Virtual Network Gateway` with type `Express Route` for connecting On-prem and azure virtual network. Type `VPN` used as a site to site failover connection. <br><br>[Highly available hybrid network architecture](https://learn.microsoft.com/en-us/azure/architecture/reference-architectures/hybrid-networking/expressroute-vpn-failover?toc=%2Fazure%2Fvirtual-network%2Ftoc.json) |
| 5. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources. <br><br> SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC <br><br>Documentation | False | This control will be implemented as per LSEG standard based on application team requirement, no locks implemented yet via IaC. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 6. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals. | IaC <br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place. |

## Changelog

- [azure-prdsvc-terraform-subnet](CHANGELOG.md)

## References

### Microsoft Docs

- [Official documentation](https://learn.microsoft.com/en-us/azure/virtual-network/quick-create-portal#create-a-subnet)
- [AzAPI](https://learn.microsoft.com/en-us/azure/templates/microsoft.network/2023-04-01/virtualnetworks/subnets?pivots=deployment-language-terraform)  

### Terraform Docs

- [azapi_resource](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/azapi_resource)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0 |
| <a name="requirement_azapi"></a> [azapi](#requirement_azapi) | >=1.9 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azapi"></a> [azapi](#provider_azapi) | >=1.9 |

## Resources

| Name | Type |
|------|------|
| [azapi_resource.snet](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_update_resource.vnet](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/update_resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_prefix"></a> [address_prefix](#input_address_prefix) | (Optional) The address prefix to use for the subnet. | `string` | `null` | no |
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_default_outbound_access"></a> [default_outbound_access](#input_default_outbound_access) | (Optional) Specifies the default outbound access setting for the subnet. | `bool` | `false` | no |
| <a name="input_delegation"></a> [delegation](#input_delegation) | (Optional) The Delegation to add to the Subnet. | <pre>list(object({<br/>    delegation_name         = string<br/>    service_delegation_name = string<br/>  }))</pre> | `[]` | no |
| <a name="input_enforce_private_link_endpoint_network_policies"></a> [enforce_private_link_endpoint_network_policies](#input_enforce_private_link_endpoint_network_policies) | (Optional) Enable or disable network policies for the Private Endpoint on the subnet. | `string` | `"Disabled"` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_network_security_group_id"></a> [network_security_group_id](#input_network_security_group_id) | (Optional) The ID of Network Security Group (NSG) to be associated with the subnet. For security reasons, a NSG should always be associated with a subnet, unless it is not supported. | `string` | `null` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_private_link_service_network_policies_enabled"></a> [private_link_service_network_policies_enabled](#input_private_link_service_network_policies_enabled) | (Optional) Enable or disable network policies for the Private Link Service on the subnet. | `bool` | `false` | no |
| <a name="input_route_table_id"></a> [route_table_id](#input_route_table_id) | (Optional) The ID of Route Table (UDR) to be associated with the subnet. For security reasons, a Route table should always be associated with a subnet, unless it is not supported. | `string` | `null` | no |
| <a name="input_service_endpoints"></a> [service_endpoints](#input_service_endpoints) | (Optional) The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web. | `list(string)` | `[]` | no |
| <a name="input_special_subnet_name"></a> [special_subnet_name](#input_special_subnet_name) | (Optional) Used for Azure reserved subnet names. | `string` | `null` | no |
| <a name="input_subnets"></a> [subnets](#input_subnets) | (Optional) Pass subnets in bulk as an alternative to passing subnets individually (must use one mechanism or other). | <pre>map(object({<br/>    instance                                       = string<br/>    address_prefix                                 = string<br/>    special_subnet_name                            = optional(string, null)<br/>    service_endpoints                              = optional(list(string), [])<br/>    cidr_newbits                                   = optional(number, 0)<br/>    cidr_netnum                                    = optional(number, 0)<br/>    routable_cidr                                  = optional(string, null)<br/>    network_security_group_id                      = optional(string, null)<br/>    route_table_id                                 = optional(string, null)<br/>    enforce_private_link_endpoint_network_policies = optional(bool, false)<br/>    private_link_service_network_policies_enabled  = optional(bool, false)<br/>    delegation = optional(list(object({<br/>      delegation_name           = string<br/>      service_delegation_name   = string<br/>      service_delegation_action = list(string)<br/>    })), [])<br/>  }))</pre> | `null` | no |
| <a name="input_virtual_network_id"></a> [virtual_network_id](#input_virtual_network_id) | (Required) The Resource Id of the virtual network to which to attach the subnet. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | Id of the created subnet. |
| <a name="output_multiple_subnets_resource"></a> [multiple_subnets_resource](#output_multiple_subnets_resource) | The Multiple Subnets resource. |
| <a name="output_name"></a> [name](#output_name) | Name of the created subnet. |
| <a name="output_resource"></a> [resource](#output_resource) | The Subnet resource. |
| <a name="output_subnet_ip"></a> [subnet_ip](#output_subnet_ip) | The address prefix IP within this subnet |
<!-- END_TF_DOCS -->
