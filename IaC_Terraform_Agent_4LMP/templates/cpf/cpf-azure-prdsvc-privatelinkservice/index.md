---
version: 1.0.2
available_versions:
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.2.2
  - 0.2.1
---

<!-- BEGIN_TF_DOCS -->
# Private Link Service module

## Overview

This terraform module creates a Private Link Service and associated resources.

## Prerequisites

- An existing `Resource Group`.
- A `Virtual Network` and a `Subnet` for the nat_ip_configuration block.
- `Standard Load Balancer`, where traffic from the Private Link Service should be routed.

## Guidance

#### Usage

- Azure Private Link service is the reference to your own service that is powered by Azure Private Link. Your service that is running behind Azure Standard Load Balancer can be enabled for Private Link access so that consumers to your service can access it privately from their own VNets.
- Up to 8 `nat_ip_configuration` blocks can be created having different `names`.
- If no Subscription IDs are specified then Azure allows every Subscription to see this Private Link Service.

#### Security Considerations

- nat_ip_configuration primary `subnet_id` once assigned can not be changed.

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-APLS-AC_010AZU-APLS-AC_010 | Azure Private Link services by default must use the restricted by RBAC security access optionAzure Private Link services by default must use the restricted by RBAC security access option | Azure Private Link services by default must use the restricted by RBAC security access option (What) within Access security (How) to restrict Private Link connections to a single tenancy and reduce the risk of data exfiltration and unauthorised service or application access (Why)Azure Private Link services by default must use the restricted by RBAC security access option (What) within Access security (How) to restrict Private Link connections to a single tenancy and reduce the risk of data exfiltration and unauthorised service or application access (Why) | TrueTrue | FalseFalse | This control has been implemented by passing the parameters `visibility_subscription_ids = []`, `auto_approval_subscription_ids = []` which by default restricts the Access Security to choose <b>Role-based access control only</b> option on Azure Portal. We do not have a separate parameter for Role-based security control in Terraform registry as well as in ARM and Resource properties in PowerShell, hence, this could not be tested with Pester test case. |
| 2. | AZU-APLS-AC_020 | Private Link service connections between different Entra ID Tenancies must be via the subscription ID security access option and Subscription ID's must be CyberSecurity approved | Private Link service connections between different Entra ID Tenancies must be via the subscription ID security access option Subscription ID's must be CyberSecurity approved (What) within Access security, add subscription (How) to reduce the risk of data exfiltration and unauthorised service or application access (Why) | False | False | This control can be implemented by providing values to any one of the parameters `visibility_subscription_ids`, `auto_approval_subscription_ids` accordingly. Application team can use the parameters whenever needed. Please check the description of the mentioned variables before providing the values.This control has been implemented by passing the parameters `visibility_subscription_ids = []`, `auto_approval_subscription_ids = []` which by default restricts the Access Security to choose <b>Role-based access control only</b> option on Azure Portal. We do not have a separate parameter for Role-based security control in Terraform registry as well as in ARM and Resource properties in PowerShell, hence, this could not be tested with Pester test case. |
| 2. | AZU-APLS-AC_020 | Private Link service connections between different Entra ID Tenancies must be via the subscription ID security access option and Subscription ID's must be CyberSecurity approved | Private Link service connections between different Entra ID Tenancies must be via the subscription ID security access option Subscription ID's must be CyberSecurity approved (What) within Access security, add subscription (How) to reduce the risk of data exfiltration and unauthorised service or application access (Why) | False | False | This control can be implemented by providing values to any one of the parameters `visibility_subscription_ids`, `auto_approval_subscription_ids` accordingly. Application team can use the parameters whenever needed. Please check the description of the mentioned variables before providing the values. |

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames).<br><br>[Azure Private Link Naming Rules & Restrictions](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules#microsoftnetwork).|
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Azure Monitor network insights](https://learn.microsoft.com/en-gb/azure/network-watcher/network-insights-overview#resource-view) <br><br>[Supported Metrics for Azure Private Link](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-network-privatelinkservices-metrics)<br><br>[Cloud monitoring service level objectives](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives) |
| 5. | [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement.<br><br>[Achieving availability while using Private Endpoint](https://learn.microsoft.com/en-gb/azure/private-link/private-link-faq#how-do-i-achieve-availability-while-using-private-endpoint-if-there-are-regional-failures-). |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json). |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package. |

## Changelog

- [azure-prdsvc-terraform-privatelinkservice](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/private-link/private-link-service-overview)

### Terraform Docs

- [azurerm_private_link_service](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_link_service)

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
| [azurerm_private_link_service.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_link_service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_auto_approval_subscription_ids"></a> [auto_approval_subscription_ids](#input_auto_approval_subscription_ids) | (Optional) A list of Subscription UUID/GUID's that will be automatically be able to use this Private Link Service. | `list(string)` | `[]` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_enable_proxy_protocol"></a> [enable_proxy_protocol](#input_enable_proxy_protocol) | (Optional) Should the Private Link Service support the Proxy Protocol? | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_fqdns"></a> [fqdns](#input_fqdns) | (Optional) List of FQDNs allowed for the Private Link Service. | `list(string)` | `[]` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_load_balancer_frontend_ip_configuration_ids"></a> [load_balancer_frontend_ip_configuration_ids](#input_load_balancer_frontend_ip_configuration_ids) | (Required) A list of Frontend IP Configuration IDs from a Standard Load Balancer, where traffic from the Private Link Service should be routed. You can use Load Balancer Rules to direct this traffic to appropriate backend pools where your applications are running. Changing this forces a new resource to be created. | `list(string)` | n/a | yes |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_nat_ip_configurations"></a> [nat_ip_configurations](#input_nat_ip_configurations) | (Required) A map of One or more (up to 8) `nat_ip_configuration` block supports the following:<br/>name                       = "(Required) Specifies the name which should be used for the NAT IP Configuration. Changing this forces a new resource to be created."<br/>primary                    = "(Required) Is this is the Primary IP Configuration? Changing this forces a new resource to be created."<br/>private_ip_address         = "(Optional) Specifies a Private Static IP Address for this IP Configuration."<br/>private_ip_address_version = "(Optional) The version of the IP Protocol which should be used. At this time the only supported value is IPv4. Defaults to IPv4." | <pre>map(object({<br/>    name                       = string<br/>    primary                    = bool<br/>    private_ip_address         = optional(string, null)<br/>    private_ip_address_version = optional(string, "IPv4")<br/>  }))</pre> | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet_id](#input_subnet_id) | (Required) Specifies the ID of the Subnet which should be used for the Private Link Service. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_visibility_subscription_ids"></a> [visibility_subscription_ids](#input_visibility_subscription_ids) | (Optional) A list of Subscription UUID/GUID's that will be able to see this Private Link Service. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The Resource ID of the Private Link Service. |
| <a name="output_name"></a> [name](#output_name) | The Name of the Private Link Service. |
| <a name="output_resource"></a> [resource](#output_resource) | The Private Link Service resource. |
<!-- END_TF_DOCS -->
