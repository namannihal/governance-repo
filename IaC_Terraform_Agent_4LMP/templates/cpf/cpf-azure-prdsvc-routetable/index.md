---
version: 1.0.6
available_versions:
  - 1.0.6
  - 1.0.5
  - 1.0.4
  - 1.0.2
  - 1.0.1
---

<!-- BEGIN_TF_DOCS -->
# Route Table module

## Overview

This terraform module creates a route table with/without routes and optionally associate with subnets.
You can create custom, or user-defined(static) routes in Azure to override Azure's default system routes, or to add more routes to a subnet's route table. In Azure, you create a route table, then associate the route table to zero or more virtual network subnets. Each subnet can have zero or one route table associated to it.
When you create a route table and associate it to a subnet, the table's routes are combined with the subnet's default routes. If there are conflicting route assignments, user-defined routes override the default routes.

## Prerequisites

- Existing `Resource Group`.
- Optionally, `Subnet` in an existing `Virtual Network`.

## Guidance

#### Usage

AzureRM 4.x Upgrade Notes for Route Table

Impact analysis -- Medium

Users migrating from azurerm 3.x to 4.x need to perform the following changes:
  A new optional variable `bgp_route_propagation_enabled` has been introduced with a default value of `true`. This replaces the deprecated `disable_bgp_route_propagation` property.

Wiki link for [AzureRM 4.x Upgrade](https://gitlab.dx1.lseg.com/groups/app/app-51310/azure/prdsvc/terraform/-/wikis/Terraform-AzureRM-Provider-Upgrade:-Version-3.x-to-4.x/Route-Table) for details on the upgrade process.

For more details, refer to the official [AzureRM 4.x Upgrade Guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide)

- In route table below are supported next hop type

    - **VirtualNetworkGateway**: Specify when you want traffic destined for specific address prefixes routed to a virtual network gateway. The virtual network gateway must be created with type VPN.
    - **VnetLocal**: Specify the Virtual network option when you want to override the default routing within a virtual network.
    - **Internet** : Specify the Internet option when you want to explicitly route traffic destined to an address prefix to the Internet.
    - **VirtualAppliance** : When you create a route with the virtual appliance hop type, you also specify a next hop IP address. The IP address can be the private IP address of a network interface attached to a virtual machine. Any network interface attached to a virtual machine that forwards network traffic to an address other than its own must have the Azure Enable IP forwarding option enabled for it.
    - **None** : Specify when you want to drop traffic to an address prefix, rather than forwarding the traffic to a destination.

- Module `azure-prdsvc-terraform-routetable` can be utilised to create Route Table with Routes and associate Route Table with subnets.

#### Security Considerations

#### Additional Information

- Until version 0.4.0, this module creates routes using a dynamic block within the "azurerm_route_table" resource block. While this successfully creates routes, it causes the following known issues:
    - If multiple routes are created along with the route table, they cannot all be deleted at once. Due to the dynamic block, Terraform does not recognize the deletion of all routes simultaneously. Routes must be removed one by one.
    - Any changes to routes object, causes redeployment of routes where "next_hop_in_ip_address" is set to null even when there are no changes in those specific routes.
- To address these issues, a new version 0.5.0 has been released. In this version, the dynamic block for creating routes has been removed and an additional resource block "azurerm_route" has been added for routes creation. This resolves the aforementioned issues.
- If the route table and routes are created using this module with version 0.4.0 or earlier, switching to version 0.5.0 or later can lead to the redeployment of the route table and routes.

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-VN-SC_080 | Subnets (with the exception of those containing Application/Network/NAT Gateways, Bastion or Azure Firewall) within Routable/Non-Routable Virtual Networks must have an attached UDR defining the default route pointing to the Routable Virtual Network firewall | Subnets (with the exception of those containing Application/Network/NAT Gateways, Bastion or Azure Firewall) within Routable/Non-Routable Virtual Networks must have an attached UDR defining the default route pointing to the Routable Virtual Network firewall (What) in the Properties page (How) in order that all required traffic pass through the firewall (Why) | True | False | Route Table and subnet association can be done using this module by providing `subnet_ids`.<br> The association option is also available through `subnet` module while subnet creation, this is also a recommended way as due to security reasons, a Subnet should always be associated with a Route table while creation. Due to same reason, this control is not tested through pester, as it needs a subnet without route table to be created first.

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames). |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Monitor Azure Virtual Network](https://learn.microsoft.com/en-us/azure/virtual-network/monitor-virtual-network). |
| 5. | [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | False | This cannot be implemented at product level.<br><br>[Azure Virtual Network Disaster Recovery guidance ](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-disaster-recovery-guidance) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place.<br><br>[Azure built-in roles](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles) |

## Changelog

- [azure-prdsvc-terraform-routetable](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-networks-udr-overview).

### Terraform Docs

- [azurerm_route_table](https://registry.terraform.io/providers/hashicorp/Azurerm/latest/docs/resources/route_table)

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
| [azurerm_route.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route) | resource |
| [azurerm_route_table.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table) | resource |
| [azurerm_subnet_route_table_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_bgp_route_propagation_enabled"></a> [bgp_route_propagation_enabled](#input_bgp_route_propagation_enabled) | (Optional) Boolean flag which controls propagation of routes learned by BGP on that route table. True means disable. | `bool` | `true` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_route"></a> [route](#input_route) | (Optional) The routes in the route table | <pre>map(object({<br/>    name                   = string<br/>    address_prefix         = string<br/>    next_hop_type          = string<br/>    next_hop_in_ip_address = optional(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_subnet_ids"></a> [subnet_ids](#input_subnet_ids) | (Optional) Subnet associated with Route Table | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The ID of the Route Table. |
| <a name="output_name"></a> [name](#output_name) | The Name of the Route Table. |
| <a name="output_resource"></a> [resource](#output_resource) | The Route Table resource. |
<!-- END_TF_DOCS -->
