---
version: 1.0.2
available_versions:
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.3.3
  - 0.3.2
---

<!-- BEGIN_TF_DOCS -->
# Public IP Module

## Overview

- This terraform module creates a Public IP address in Azure.Public IP addresses allow Internet resources to communicate inbound to Azure resources. Public IP addresses enable Azure resources to communicate to Internet and public-facing Azure services.

## Prerequisites

- A `Resource group`.

## Guidance

#### Usage

- This module only creates a public IP address.
- To perform the deployment, a **Resource Group** must be exist to deploy the Public IP.
- When you set the allocation method to static, you cannot specify the actual IP address assigned to the public IP address resource. Azure assigns the IP address from a pool of available IP addresses in the Azure location the resource is created in.
- At this time, both the Tier and Routing Preference feature are available for standard SKU IPv4 addresses only. They can't be utilized on the same IP address concurrently.
- Azure provides a default outbound access IP for VMs that either aren't assigned a public IP address or are in the back-end pool of an internal basic Azure load balancer. The default outbound access IP mechanism provides an outbound IP address that isn't configurable.
- If this resource is to be associated with a resource that requires disassociation before destruction (such as azurerm_network_interface) it is recommended to set the lifecycle argument create_before_destroy = true. Otherwise, it can fail to disassociate on destruction.

#### Security Considerations

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-PIP-SC_010 | Must use an appropriate idle timeout matched to an applications confidentiality rating | For Highly Restricted and Restricted applications set the idle timeout to no more than 5 minutes, for other classifications set it to no more than 30 minutes (What) within the Configuration blade (How) To reduce the potential of an unauthorised user to gain access to an existing TCP / HTTP session (why)  | False | False | This is a platform level control which will be implemented at ALZ vending. |
| 2. | AZU-PIP-SC_020 | Send all diagnostic log categories to a central SOC Log Analytics workspace | Public IP's must send all diagnostic logs to a central SOC Log Analytics workspace (What) within Diagnostic setting (How) in order to support a security investigation after a security incident (Why) | False | False |  Diagnostics settings will be enabled using a separate module at bundle/pattern level |
| 3. | AZU-PIP-SC_030 | Send all diagnostic log categories to a central SOC Storage Account | Public IP's must send all diagnostic logs to a central SOC Storage Account (What) within Diagnostic setting (How) In order to provide an immutable copy to adhere to compliance requirements (Why) | False | False | Diagnostics settings will be enabled using a separate module at bundle/pattern level |
| 4. | AZU-PIP-SC_040 | Inherit DDoS Protection from VNet | Public IP Addresses should inherit DDoS Protection from a VNet (What) via overview blade then Protect IP address setting (How) In order to be compliant with LSEG’s Azure DDoS strategy (Why) | True | True | Inheriting DDoS protection from a VNet is implemented in code by setting property ddos_protection_mode to VirtualNetworkInherited by default. |

## SMCF Controls

| S. No. | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|--------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types. <br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc. <br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC <br><br>Documentation | True | This control has been implemented in all the cloud products using resource naming modules. <br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames). <br><br>This is the link to Azure Public IP naming conventions. <br>[Azure Public IP Naming Rules & Restrictions](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules#microsoftnetwork) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC <br><br>Policy | True | Cloud products has a parameter in place to accept the tag values. <br><br>This control will be implemented via Policy that inherits all the mandatory tags to the resources. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties. <br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration | Policies <br><br>IaC <br><br>Policies <br><br>IaC | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection <br><br><br><br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy <br><br><br><br>Documentation <br><br><br><br><br>Documentation | True | This control will be implemented by `DINE` Policy. <br><br>[Cloud monitoring service level objectives](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives) <br> [Monitoring Public IP addresses](https://learn.microsoft.com/en-us/azure/virtual-network/ip-services/monitor-public-ip) <br><br>[Supported Metrics for Azure Public IP](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-network-publicipaddresses-metrics) |
| 5. | [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC <br><br>Documentation | True | This control will be implemented by following parameter: `zones` for zone-resiliency. <br><br> [Availability Zones for Azure Public IP addresses](https://learn.microsoft.com/en-us/azure/virtual-network/ip-services/public-ip-addresses#availability-zone) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources. <br><br> SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC <br><br>Documentation | False | This control will be implemented as per LSEG standard based on application Team requirement, no locks implemented yet via IaC. <br><br>[Lock your resources to protect your infrastructure](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals. | IaC <br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place. <br><br>[RBAC built-in roles](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles) |

## Changelog

- [azure-prdsvc-terraform-publicip](CHANGELOG.md)

## References

### Microsoft Docs

- [Azure Public IP official documentation](https://learn.microsoft.com/en-us/azure/virtual-network/ip-services/public-ip-addresses)

### Terraform Docs

- [azurerm_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip)

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
| [azurerm_public_ip.pipn](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocation_method"></a> [allocation_method](#input_allocation_method) | (Required) Defines the allocation method for this IP address. Possible values are Static or Dynamic. | `string` | `"Static"` | no |
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_ddos_protection_mode"></a> [ddos_protection_mode](#input_ddos_protection_mode) | (Optional) The DDoS protection mode of the public IP. Possible values are Disabled, Enabled, and VirtualNetworkInherited. Defaults to VirtualNetworkInherited. | `string` | `"VirtualNetworkInherited"` | no |
| <a name="input_ddos_protection_plan_id"></a> [ddos_protection_plan_id](#input_ddos_protection_plan_id) | (Optional) The ID of DDoS protection plan associated with the public IP. | `string` | `null` | no |
| <a name="input_domain_name_label"></a> [domain_name_label](#input_domain_name_label) | (Optional) Label for the Domain Name. Will be used to make up the FQDN. If a domain name label is specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_idle_timeout_in_minutes"></a> [idle_timeout_in_minutes](#input_idle_timeout_in_minutes) | (Optional) Specifies the timeout for the TCP idle connection. The value can be set between 4 and 30 minutes. | `number` | `null` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_ip_tags"></a> [ip_tags](#input_ip_tags) | (Optional) A mapping of IP tags to assign to the public IP. | `map(any)` | `{}` | no |
| <a name="input_ip_version"></a> [ip_version](#input_ip_version) | (Optional) The IP Version to use, IPv6 or IPv4. | `string` | `"IPv4"` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_public_ip_prefix_id"></a> [public_ip_prefix_id](#input_public_ip_prefix_id) | (Optional) The ID of DDoS protection plan associated with the public IP. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_reverse_fqdn"></a> [reverse_fqdn](#input_reverse_fqdn) | (Optional) A fully qualified domain name that resolves to this public IP address. If the reverseFqdn is specified, then a PTR DNS record is created pointing from the IP address in the in-addr.arpa domain to the reverse FQDN. | `bool` | `null` | no |
| <a name="input_sku"></a> [sku](#input_sku) | (Optional) The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic. | `string` | `"Standard"` | no |
| <a name="input_sku_tier"></a> [sku_tier](#input_sku_tier) | (Optional) The SKU Tier that should be used for the Public IP. Possible values are Regional and Global. Defaults to Regional. | `string` | `"Regional"` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_zones"></a> [zones](#input_zones) | (Optional) The availability zone to allocate the Public IP in. Possible values are 1, 2, 3. Defaults to null. | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_fqdn"></a> [fqdn](#output_fqdn) | Fully qualified domain name of the A DNS record associated with the public IP. domain_name_label must be specified to get the fqdn. This is the concatenation of the domain_name_label and the regionalized DNS zone. |
| <a name="output_id"></a> [id](#output_id) | The Public IP ID. |
| <a name="output_ip_address"></a> [ip_address](#output_ip_address) | The IP address value that was allocated. |
| <a name="output_name"></a> [name](#output_name) | The Public IP name. |
| <a name="output_resource"></a> [resource](#output_resource) | The Public IP resource. |
<!-- END_TF_DOCS -->
