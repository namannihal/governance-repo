---
version: 1.0.0
available_versions:
  - 1.0.0
  - 0.3.1
  - 0.3.0
  - 0.2.2
  - 0.2.1
---

<!-- BEGIN_TF_DOCS -->
# NAT Gateway Module


## Overview

This terraform module creates a NAT gateway module and associated resources.

## Prerequisites

- An existing `Resource Group`.
- A `Virtual Network` and a `Subnet` for the nat_gateway.

## Guidance

#### Usage

- NAT Gateway can be attached with maxium 16 public ip. Including public ip and public ip prefixes.
- A zone-redundant public IP address can be attached to a "no zone" NAT gateway only, the public ip and NAT Gateway should be in same availability Zone.
- NAT gateway does not support public IP addresses with routing preference "internet".
- NAT gateway is compatible with standard SKU resources (Public ip and public ip prefixes).
- NAT gateway can't be associated with a gateway subnet.
- NAT gateways can't be attached to a single subnet.

#### Security Considerations

- With a NAT gateway, individual VMs or other compute resources, don't need public IP addresses and can remain private. Resources without a public IP address can still reach external sources outside the virtual network with NAT gateway's static public IP addresses or prefixes. You can associate a public IP prefix to ensure that a contiguous set of IPs will be used for outbound. Destination firewall rules can be configured based on this predictable IP list.

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-NGW-SC_010 | NAT Gateway must have a TCP idle timeout of no more than 5 minutes | NAT Gateway must have a TCP idle timeout of no more than 5 minutes (What) within the Configuration settings (How) To reduce the potential of an unauthorised user to gain access to an existing TCP / HTTP session (Why) | True | True | Implemented adding validation for 'idle_timeout_in_minutes' block also enforced the following test case in the pester test case file '$natGateway.IdleTimeoutInMinutes | Should -BeLessOrEqual 5'. |

## SMCF Controls

| S. No. | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|--------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types. <br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc. <br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC <br><br>Documentation | True | This control has been implemented in all the cloud products using resource naming modules. <br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames). <br><br>This is the link specific to Networking resources naming conventions. <br>[Azure NAT Gateway Naming Rules & Restrictions](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules#microsoftnetwork) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC <br><br>Policy | True | Cloud products has a paramter in place to accept the tag values. <br><br>This control will be implemented via Policy that inherits all the mandatory tags to the resources. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties. <br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration | Policies <br><br>IaC <br><br>Policies <br><br>IaC | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection <br><br><br><br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy <br><br><br><br>Documentation <br><br><br><br><br>Documentation | True | This control will be implemented by `DINE` Policy. <br><br>[Monitor Azure NAT Gateway](https://learn.microsoft.com/en-us/azure/nat-gateway/nat-metrics) <br> [Cloud monitoring service level objectives](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives) <br><br>[Supported Metrics for Azure NAT Gateway](https://learn.microsoft.com/en-us/azure/nat-gateway/nat-metrics#metrics-overview) |
| 5. | [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC <br><br>Documentation | True | This control will be implemented by following parameter: `zones` for zone-resiliency. <br><br> [Azure NAT Gateway and Availability Zones](https://learn.microsoft.com/en-us/azure/nat-gateway/nat-availability-zones) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources. <br><br> SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC <br><br>Documentation | False | This control will be implemented as per LSEG standard based on application Team requirement, no locks implemented yet via IaC. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals. | IaC <br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place. |

## Changelog

- [azure-prdsvc-terraform-natgateway](CHANGELOG.md)

## References

### Microsoft Docs

- [official documentation](https://learn.microsoft.com/en-us/azure/nat-gateway/nat-overview).

### Terraform Docs

- [azurerm_availability_set](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway)

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
| [azurerm_nat_gateway.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway) | resource |
| [azurerm_nat_gateway_public_ip_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway_public_ip_association) | resource |
| [azurerm_nat_gateway_public_ip_prefix_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway_public_ip_prefix_association) | resource |
| [azurerm_subnet_nat_gateway_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_nat_gateway_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 71 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_idle_timeout_in_minutes"></a> [idle_timeout_in_minutes](#input_idle_timeout_in_minutes) | (Optional) The idle timeout which should be used in minutes. Must be no more than 5 as per security control requirements. Defaults to 4. | `number` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_public_ip_ids"></a> [public_ip_ids](#input_public_ip_ids) | (Optional) Public ip associated with NAT Gateway. | `list(string)` | `[]` | no |
| <a name="input_public_ip_prefix_ids"></a> [public_ip_prefix_ids](#input_public_ip_prefix_ids) | (Optional) Public ip prefix associated with NAT Gateway. | `list(string)` | `[]` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku_name](#input_sku_name) | (Required) SKU of the NAT gateway. | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet_ids](#input_subnet_ids) | (Optional) Subnet associated with NAT Gateway | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_zones"></a> [zones](#input_zones) | (Optional) Availability zone of NAT gateway. | `list(string)` | <pre>[<br>  "1"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The Resource ID of the NAT Gateway. |
| <a name="output_name"></a> [name](#output_name) | The name of the NAT Gateway. |
| <a name="output_resource"></a> [resource](#output_resource) | The NAT Gateway resource. |
<!-- END_TF_DOCS -->
