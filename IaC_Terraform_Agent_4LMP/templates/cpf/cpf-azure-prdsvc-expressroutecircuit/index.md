---
version: 1.0.0
available_versions:
  - 1.0.0
  - 0.3.0
  - 0.2.2
  - 0.2.1
  - 0.2.0
---

<!-- BEGIN_TF_DOCS -->
# Express route circuit module

## Overview

This terraform module creates a express route circuit and generate a authorization key.

## Prerequisites

## Guidance

#### Usage

- The Service_provider_name, the peering_location and the bandwidth_in_mbps should be set together and they conflict with express_route_port_id and bandwidth_in_gbps.
- You can migrate from MeteredData to UnlimitedData, but not the other way around.

#### Security Considerations

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-ERC-AU_010 | Send all diagnostic log categories to a central SOC Log Analytics workspace | ExpressRoute Circuits must send all diagnostic logs to a central SOC Log Analytics workspace (What) within Diagnostic setting (How) in order to support a security investigation after a security incident (Why) | False | False | This control will be implemented via policy. |
| 2. | AZU-ERC-AU_020 | Send all diagnostic log categories to a central SOC Storage Account | ExpressRoute Circuits must send all diagnostic logs to a central SOC Storage Account (What) within Diagnostic setting (How) In order to provide an immutable copy to adhere to compliance requirements (Why) | False | False | This control will be implemented via policy. |

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[ExpressRoute monitoring, metrics, and alerts](https://learn.microsoft.com/en-us/azure/expressroute/expressroute-monitoring-metrics-alerts)<br><br>[Cloud monitoring service level objectives](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives)<br><br>[Supported metrics for Microsoft.Network/expressRouteCircuits](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-network-expressroutecircuits-metrics)<br><br>[ExpressRoute metrics](https://learn.microsoft.com/en-us/azure/expressroute/expressroute-monitoring-metrics-alerts#expressroute-metrics) |
| 5. | [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | True | This control will be implemented in the `Virtual Network Gateway module` by following parameters: `type` property as `ExpressRoute`, SKU's supporting zone redundancy for virtual network gateway type `ExpressRoute` are `ErGw1AZ`, `ErGw2AZ`, `ErGw3AZ`.<br><br>Using three `ip_configuration` blocks we can achieve active-active zone redundant gateway with P2S configuration.<br><br>[Create a zone-redundant virtual network gateway in availability zones](https://learn.microsoft.com/en-us/azure/vpn-gateway/create-zone-redundant-vnet-gateway?toc=%2Fazure%2Fexpressroute%2Ftoc.json) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place.<br><br>[Azure built-in roles](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles)<br><br> |

## Changelog

- [azure-prdsvc-terraform-expressroutecircuit](CHANGELOG.md)

## References

### Microsoft Docs

- [Official documentation](https://learn.microsoft.com/en-us/azure/expressroute/expressroute-introduction)

### Terraform Docs

- [azurerm_express_route_circuit](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/express_route_circuit)

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
| [azurerm_express_route_circuit.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/express_route_circuit) | resource |
| [azurerm_express_route_circuit_authorization.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/express_route_circuit_authorization) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_classic_operations"></a> [allow_classic_operations](#input_allow_classic_operations) | (Optional) Allow the circuit to interact with classic (RDFE) resources. | `bool` | `false` | no |
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_authorization_key_name"></a> [authorization_key_name](#input_authorization_key_name) | (Optional) The name of the ExpressRoute circuit authorization. | `string` | `null` | no |
| <a name="input_bandwidth_in_gbps"></a> [bandwidth_in_gbps](#input_bandwidth_in_gbps) | (Optional) The bandwidth in Gbps of the circuit being created on the Express Route Port. | `number` | `null` | no |
| <a name="input_bandwidth_in_mbps"></a> [bandwidth_in_mbps](#input_bandwidth_in_mbps) | (Required) The bandwidth in Mbps of the circuit being created on the Service Provider. | `number` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_express_route_port_id"></a> [express_route_port_id](#input_express_route_port_id) | (Optional) The ID of the Express Route Port this Express Route Circuit is based on. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_peering_location"></a> [peering_location](#input_peering_location) | (Required) The name of the peering location and not the Azure resource location. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_service_provider_name"></a> [service_provider_name](#input_service_provider_name) | (Required) The name of the ExpressRoute Service Provider. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input_sku) | (Required) A sku block for the ExpressRoute circuit as documented below.<br>object ({<br>  tier   = (Required) The service tier. Possible values are Basic, Local, Standard or Premium.<br>  family = (Required) The billing mode for bandwidth. Possible values are MeteredData or UnlimitedData.<br>}) | <pre>object({<br>    tier   = string<br>    family = string<br>  })</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_authorization_key"></a> [authorization_key](#output_authorization_key) | The Authorization Key. |
| <a name="output_authorization_key_id"></a> [authorization_key_id](#output_authorization_key_id) | The ID of the ExpressRoute Circuit Authorization. |
| <a name="output_authorization_use_status"></a> [authorization_use_status](#output_authorization_use_status) | The authorization use status. |
| <a name="output_id"></a> [id](#output_id) | The resource ID of the express route circuit. |
| <a name="output_name"></a> [name](#output_name) | The name of the express route circuit. |
| <a name="output_resource"></a> [resource](#output_resource) | The express route circuit resource. |
| <a name="output_service_key"></a> [service_key](#output_service_key) | The string needed by the service provider to provision the ExpressRoute circuit. |
| <a name="output_service_provider_provisioning_state"></a> [service_provider_provisioning_state](#output_service_provider_provisioning_state) | The ExpressRoute circuit provisioning state from your chosen service provider. Possible values are NotProvisioned, Provisioning, Provisioned, and Deprovisioning. |
<!-- END_TF_DOCS -->
