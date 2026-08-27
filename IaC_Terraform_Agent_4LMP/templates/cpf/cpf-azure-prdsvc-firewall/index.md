---
version: 0.3.2
available_versions:
  - 0.3.2
  - 0.3.1
  - 0.3.0
  - 0.2.1
  - 0.2.0
---

<!-- BEGIN_TF_DOCS -->
# Firewall module


## Overview

- This terraform module creates a Firewall and associated resources.
Azure Firewall is a cloud-native and intelligent network firewall security service that provides the best of breed threat protection for your cloud workloads running in Azure. It's a fully stateful, firewall as a service with built-in high availability and unrestricted cloud scalability. It provides both east-west and north-south traffic inspection.

## Prerequisites

- An existing `Resource Group`.
- A `Virtual Network` and a `AzureFirewallSubnet` for the Firewall.
- A `Firewall Policy` and `Public IP Address`.

## Guidance

#### Usage

- This module only creates the firewall which must be managed by firewall policy (available as a separate module).
- The ip_configuration, management_ip_configuration and threat_intel_mode can be set only when the sku_name is set to "AZFW_VNet".
- Firewall can have multiple ip_configurations, but *at least one and only one* ip_configuration block may contain a subnet_id.
- A management_ip_configuration block allows force-tunnelling of traffic to be performed by the firewall.
- The Ip configuration Subnet used for the Firewall must have the name *AzureFirewallSubnet* and the subnet mask must be at least a /26.
- The Management Subnet used for the Firewall must have the name *AzureFirewallManagementSubnet* and the subnet mask must be at least a /26.
- The Public IP(s) must have a Static allocation and Standard SKU.

#### Security Considerations

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-FW-SC_010 | Azure Firewall must be deployed to multiple availability zones | Azure Firewall must be deployed to multiple availability zones (What) via Code deployment settings (How) to provide high availability and ensure continuity of service should an availability zone become unavailable (Why) | True  | True | Have used the argument zones under azurerm_firewall resource type with a default value of ["1","2","3"] to ensure high availability within a region. |
| 2. | AZU-FW-SC_020 | Azure Firewall must be managed by Firewall Policy | Azure Firewall must be managed by Firewall Policy (What) in the Overview settings (How) to ensure that the firewall rules are managed in a modern and holistic way (Why) | True | True | Have mandated the argument firewall_policy_id under azurerm_firewall resource type, policy id has to be passed as an input during the run time. Without which, resource creation is not complete. |
| 3. | AZU-FW-AU_010 | Send diagnostic log categories Network Rule log, NAT rule log, Application rule log, Threat Intelligence log, Internal FQDN resolve failure log, Application rule aggregation log, Network rule aggregation log, NAT rule aggregation log to a central SOC Log Analytics workspace | Azure Firewall must send diagnostic log categories Network Rule log, NAT rule log, Application rule log, Threat Intelligence log, Internal FQDN resolve failure log, Application rule aggregation log, Network rule aggregation log, NAT rule aggregation log to a central SOC Log Analytics workspace (What) within its Diagnostic settings (How) in order to support an investigation after a security incident (Why) | False | False | SOC related control: Will be implemented through policy at management group level. |
| 4. | AZU-FW-AU_020 | Azure Firewall must send diagnostic log categories Network Rule log, NAT rule log, Application rule log, Threat Intelligence log, Internal FQDN resolve failure log, Application rule aggregation log, Network rule aggregation log, NAT rule aggregation log to a central SOC Storage Account (immutable storage) with a retention period of at least 365 days | Azure Firewall must send diagnostic log categories Network Rule log, NAT rule log, Application rule log, Threat Intelligence log, Internal FQDN resolve failure log, Application rule aggregation log, Network rule aggregation log, NAT rule aggregation log to a central SOC Storage Account (immutable storage) with a retention period of at least 365 days (What) within its Diagnostic settings (How) in order to provide an immutable copy to adhere to compliance requirements (Why) | False | False | SOC related control: Will be implemented through policy at management group level. |

## SMCF Controls

| S. No. | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|--------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types. <br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc. <br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC <br><br>Documentation | True | This control has been implemented in all the cloud products using resource naming modules. <br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames). <br><br>This is the link to Azure Firewall naming conventions. <br>[Azure Firewall Naming Rules & Restrictions](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules#microsoftnetwork) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC <br><br>Policy | True | Cloud products has a paramter in place to accept the tag values. <br><br>This control will be implemented via Policy that inherits all the mandatory tags to the resources. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties. <br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration | Policies <br><br>IaC <br><br>Policies <br><br>IaC | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection <br><br><br><br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy <br><br><br><br>Documentation <br><br><br><br><br>Documentation | True | This control will be implemented by `DINE` Policy. <br><br>[Azure Firewall Monitoring](https://learn.microsoft.com/en-us/azure/firewall/firewall-diagnostics) <br> [Cloud monitoring service level objectives](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives) <br><br>[Supported Metrics for Azure Firewall](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-network-azurefirewalls-metrics) |
| 5. | [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC <br><br>Documentation | True | This control will be implemented by following parameter: `zones` for zone-resiliency. <br><br> [Azure Firewall Availability Zones](https://learn.microsoft.com/en-us/azure/firewall/features#availability-zones) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources. <br><br> SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC <br><br>Documentation | False | This control will be implemented as per LSEG standard based on application Team requirement, no locks implemented yet via IaC. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals. | IaC <br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place. |

## Changelog

- [azure-prdsvc-terraform-firewall](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/firewall/overview)

### Terraform Docs

- [azurerm_firewall](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall)

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
| [azurerm_firewall.firewall](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_dns_servers"></a> [dns_servers](#input_dns_servers) | (Required) A list of DNS servers that the Azure Firewall will direct DNS traffic to the for name resolution. | `list(string)` | n/a | yes |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_firewall_policy_id"></a> [firewall_policy_id](#input_firewall_policy_id) | (Required) The ID of the Firewall Policy applied to this Firewall. | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_ip_configurations"></a> [ip_configurations](#input_ip_configurations) | (Optional) An Azure firewall Ip configurations | <pre>map(object({<br>    isPrimary            = bool<br>    subnet_id            = string<br>    public_ip_address_id = string<br>  }))</pre> | `{}` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_managed_by"></a> [managed_by](#input_managed_by) | (Required) Whether the firewall is managed by Policy or Rules (Classic). Valid values are 'Policy' and 'Rules' | `string` | `"Policy"` | no |
| <a name="input_management_ip_configuration"></a> [management_ip_configuration](#input_management_ip_configuration) | (Optional) A management_ip_configuration allows force-tunnelling of traffic to be performed by the firewall. Adding or removing this block or changing the subnet_id in an existing block forces a new resource to be created. Changing this forces a new resource to be created. | <pre>object({<br>    name                 = string<br>    subnet_id            = string<br>    public_ip_address_id = string<br>  })</pre> | `null` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_private_ip_ranges"></a> [private_ip_ranges](#input_private_ip_ranges) | (Optional) A list of SNAT private CIDR IP ranges, or the special string IANAPrivateRanges, which indicates Azure Firewall does not SNAT when the destination IP address is a private range per IANA RFC 1918. | `list(string)` | `null` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku_name](#input_sku_name) | (Required) SKU name of the Firewall. Possible values are `AZFW_Hub` and `AZFW_VNet`. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_sku_tier"></a> [sku_tier](#input_sku_tier) | (Required) SKU tier of the Firewall. Possible values are Premium, Standard and Basic. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_threat_intel_mode"></a> [threat_intel_mode](#input_threat_intel_mode) | (Optional) The operation mode for threat intelligence-based filtering. Possible values are: Off, Alert and Deny. Defaults to Alert. | `string` | `"Alert"` | no |
| <a name="input_virtual_hub"></a> [virtual_hub](#input_virtual_hub) | (Optional) An Azure Virtual WAN Hub with associated security and routing policies configured by Azure Firewall Manager. Use secured virtual hubs to easily create hub-and-spoke and transitive architectures with native security services for traffic governance and protection. | <pre>object({<br>    virtual_hub_id  = string<br>    public_ip_count = number<br>  })</pre> | `null` | no |
| <a name="input_zones"></a> [zones](#input_zones) | (Required) Need to provide all three availability zones(1,2,3) to ensure Azure Firewall is highly redundant. Changing this forces a new Azure Firewall to be created. | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The ID of the created Firewall. |
| <a name="output_name"></a> [name](#output_name) | The name of the created Firewall. |
| <a name="output_resource"></a> [resource](#output_resource) | The Firewall resource. |
<!-- END_TF_DOCS -->
