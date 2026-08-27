---
version: 1.0.2
available_versions:
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.7.5
  - 0.7.4
---

<!-- BEGIN_TF_DOCS -->
# Private Endpoint Module

## Overview

This terraform module creates Private Endpoint for a set of resources' instance(s) compatible with:

- Either Azure Private Link enabled Azure PaaS Services such as Key Vault, Storage Account,
- Or a Private Link Service linked Azure Load Balancer.

A Private Endpoint:

- Is a network interface (NIC) that uses a private IP address from a set Virtual Network's subnet,
- This network interface allows the consumers that can access this VNet's subnet to connect to the target service privately and securely,
- Enables users to bring the service into their Virtual Network

## Prerequisites

- A `Key Vault` needs to be created first, if not exists, to store sensitive information.

## Guidance

#### Usage

- The **subnet** the Private Endpoint is deployed to must have `"privateEndpointNetworkPolicies": "Disabled"`,
- This can be verified with this [`az cli` command](https://docs.microsoft.com/en-us/cli/azure/network/vnet/subnet?view=azure-cli-latest#az-network-vnet-subnet-show):

```cli
az network vnet subnet show --resource-group <rg_name> --vnet-name <vnet_name> --name <subnet_name> --query "privateEndpointNetworkPolicies"
```

- This module is designed to be integrated with other modules that deploy secured Azure resources from a network standpoint. When integrated with other modules, the module is designed to create multiple Private Endpoints using the same private link resource.
- Some resource types (such as `Storage Account`) only support 1 subresource per private endpoint.
- One of `private_connection_resource_id` or `private_connection_resource_alias` must be specified. Changing this forces a new resource to be created.
- The `request message` can be a maximum of `140` characters in length. Only valid if `is_manual_connection` is set to `true`.
- Your private endpoint must be in the same region as your virtual network, but can be in a different region from the private link resource that you are connecting to.
- `member_name` is a `required` variable though it says `optional` in the TF documentation.
- `private_ip_address` should be within the PE Subnet.
- The `request_message` is only valid if `is_manual_connection` is set to `true`. When connected to an SQL resource the `request_message` maximum length is `128`.
- The argument `subresource_names` using the variable `group_ids` is set as a mandatory one.

<b>Important Note</b>

- During the creation of the Private Endpoint, when you insert any TAG into the resource, the deployment of the Private Endpoint and Private Endpoint NIC will take in account this change and will deploy the TAGS (take in account that PE and PE NIC are different deployments that happen from our side). However, TAGS are independent from each other, which means that, after deployment, if you change the TAGS in one resource, this will not update over the other resources.

This has been discussed and confirmed with the MS support engineer, and this is an expected behavior from the TAGS on the Portal.

#### Security Considerations

- If you are trying to connect the Private Endpoint to a remote resource without having the correct `RBAC permissions` on the remote resource set `is_manual_connection` value to `True`.

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-PE-SC_010 | Private Endpoints must only connect to target resources that belong to the same environment | Private Endpoints must only connect to target resources that belong to the same environment (e.g. prod <-> prod, dev <-> dev) (What) within the Resources settings (How) to reduce the risk of data exfiltration and unauthorised system access (Why) | False | False | This is a platform level control which will be implemented at ALZ vending. |
| 2. | AZU-PE-SC_020 | Private Endpoints must only connect to PaaS services that belong to a related application and when there is a distinct business purpose |  Private Endpoints must only connect to PaaS services that belong to a related application and when there is a distinct business purpose (What) within the Resource settings (How) to reduce the risk of data exfiltration and unauthorised PaaS resource access (Why) | False | False | This control cannot be implemented by technical configuration setting. |
| 3. | AZU-PE-SC_030 | Private Endpoints must only connect to Private Link Services that belong to the same LSEG Azure tenant | Private Endpoints must only connect to Private Link Services that belong to the same LSEG Azure tenant (What) within the Resource settings (How) to reduce the risk of data exfiltration and unauthorised systems access (Why) | False | False | This is a platform level control which will be implemented at ALZ vending. |

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br><br>Documentation<br><br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br><br>[Azure Monitor network insights](https://learn.microsoft.com/en-gb/azure/network-watcher/network-insights-overview#resource-view)<br><br><br> [Cloud monitoring service level objectives](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives)<br><br>[Supported Metrics for Azure Private Link](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-network-privatelinkservices-metrics)<br><br>[Supported Metrics for Azure Private Endpoint](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-network-privateendpoints-metrics) |
| 5. | [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | False | There are no explicit properties in code covering this control. <br><br>[Achieving availability while using Private Endpoint](https://learn.microsoft.com/en-gb/azure/private-link/private-link-faq#how-do-i-achieve-availability-while-using-private-endpoint-if-there-are-regional-failures-) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement.<br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place.<br><br>[Azure RBAC permissions for Azure Private Link](https://learn.microsoft.com/en-us/azure/private-link/rbac-permissions) |

## Changelog

- [azure-prdsvc-terraform-privateendpoint](CHANGELOG.md)

## References

### Microsoft Docs

- [Azure Private Link availability](https://docs.microsoft.com/en-us/azure/private-link/availability).
- [Private-Link Resource](https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-overview#private-link-resource).
- [Azure Private Link Service](https://docs.microsoft.com/en-us/azure/private-link/private-link-service-overview).
- [Manage network policies for private endpoints](https://docs.microsoft.com/en-us/azure/private-link/disable-private-endpoint-network-policy).

### Terraform Docs

- [azurerm_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint)

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
| [azurerm_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_group_ids"></a> [group_ids](#input_group_ids) | (Required) A list of subresource names which the Private Endpoint is able to connect to. subresource_names corresponds to group_id. | `list(string)` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_ip_configuration"></a> [ip_configuration](#input_ip_configuration) | (Optional) An ip_configuration block as defined below<br/>map(object({<br/>  private_ip_address = "(Required) Specifies the static IP address within the private endpoint's subnet to be used. Changing this forces a new resource to be created."<br/>  subresource_name   = "(Optional) Specifies the subresource this IP address applies to."<br/>  member_name        = "(Optional) Specifies the member name this IP address applies to."<br/>})) | <pre>map(object({<br/>    private_ip_address = string<br/>    subresource_name   = optional(string)<br/>    member_name        = optional(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_is_manual_connection"></a> [is_manual_connection](#input_is_manual_connection) | (Required) Does the Private Endpoint require Manual Approval from the remote resource owner? Changing this forces a new resource to be created. | `bool` | n/a | yes |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_private_connection_resource_alias"></a> [private_connection_resource_alias](#input_private_connection_resource_alias) | (Optional) The Service Alias of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. One of private_connection_resource_id or private_connection_resource_alias must be specified. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_private_connection_resource_id"></a> [private_connection_resource_id](#input_private_connection_resource_id) | (Optional) The ID of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. One of `private_connection_resource_id` or `private_connection_resource_alias` must be specified. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_request_message"></a> [request_message](#input_request_message) | (Optional) A message passed to the owner of the remote resource when the private endpoint attempts to establish the connection to the remote resource. The provider allows a maximum request message length of `140` characters, however the request message maximum length is dependent on the service the private endpoint is connected to. Only valid if `is_manual_connection` is set to true. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_static_ip_required"></a> [static_ip_required](#input_static_ip_required) | (Required) Whether a Static IP is required to be assigned to Private Endpoint or not. | `bool` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet_id](#input_subnet_id) | (Required) The ID of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_custom_dns_configs"></a> [custom_dns_configs](#output_custom_dns_configs) | The custom DNS configuartions name associated with the private_endpoint. |
| <a name="output_custom_network_interface_name"></a> [custom_network_interface_name](#output_custom_network_interface_name) | The custom network interface name associated with the private_endpoint. |
| <a name="output_id"></a> [id](#output_id) | The resource ID of the created Private Endpoint. |
| <a name="output_name"></a> [name](#output_name) | The name of the created Private Endpoint. |
| <a name="output_resource"></a> [resource](#output_resource) | The Private Endpoint resource. |
<!-- END_TF_DOCS -->
