---
version: 0.2.1
available_versions:
  - 0.2.1
  - 0.2.0
  - 0.1.1
  - 0.1.0
---

<!-- BEGIN_TF_DOCS -->
# Azure DNSZone module

## Overview

This terraform module creates a Azure DNSZone and associated resources. DNS zone is used to host the DNS records for a particular domain. To start hosting your domain in Azure DNS, you need to create a DNS zone for that domain name. Each DNS record for your domain is then created inside this DNS zone.

## Prerequisites

- `Resource Group Name ` is required.

## Guidance

#### Usage

This module is not leveraging the LSEG naming module because the naming restrictions for a DNS Zone name are:

- The name of the zone must be unique within the resource group, and the zone must not exist already. Otherwise, the operation fails.

- The same zone name can be reused in a different resource group or a different Azure subscription.

- Where multiple zones share the same name, each instance is assigned different name server addresses. Only one set of addresses can be configured with the domain name registrar.

- For CNAME and A record, `record` or `target_resource_id` must be specified not both.

#### Security Considerations

## Security Controls
DNS Zone Product does not have any security controls available now. If any security controls are identified in this product new version will be added.

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Azure DNS metrics and alerts](https://learn.microsoft.com/en-us/azure/dns/dns-alerts-metrics)<br><br>[Cloud monitoring service level objectives ](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives)<br><br>[Supported Metrics for Azure DNS Zones](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-network-dnszones-metrics) |
| 5.| [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | False | The Azure DNS manual failover solution for disaster recovery uses the standard DNS mechanism to fail over to the backup site. The manual option via Azure DNS works best when used in conjunction with the cold standby or the pilot light approach .<br><br>[Disaster recovery using Azure DNS and Traffic Manager](https://learn.microsoft.com/en-us/azure/reliability/reliability-traffic-manager) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place.<br><br>[RBAC built-in roles](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles) |

## Changelog

- [azure-prdsvc-terraform-dnszone](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/dns/dns-zones-records)

### Terraform Docs

- [azurerm_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_zone)

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
| [azurerm_dns_a_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_a_record) | resource |
| [azurerm_dns_cname_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_cname_record) | resource |
| [azurerm_dns_zone.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_zone) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_a_record_enable"></a> [a_record_enable](#input_a_record_enable) | (Optional) A record configuration block as defined below. These value are required only when you need to create a records for the DNS Zone. | `bool` | `true` | no |
| <a name="input_a_records"></a> [a_records](#input_a_records) | "(Required) An `cname_record` for the Azure DNS Zone. Changing this forces a new resource to be created."<br>object({<br>  name                = (Required) The name of the DNS A Record. Changing this forces a new resource to be created.<br>  ttl                 = (Required) The Time To Live (TTL) of the DNS record in seconds.<br>  records             = (Optional) List of IPv4 Addresses. Conflicts with target_resource_id.<br>  target_resource_id  = (Optional) The Azure resource id of the target object. Conflicts with records.<br>}) | <pre>map(object({<br>    name               = string<br>    ttl                = optional(number)<br>    records            = optional(list(string), [])<br>    target_resource_id = optional(number)<br>  }))</pre> | n/a | yes |
| <a name="input_cname_record_enable"></a> [cname_record_enable](#input_cname_record_enable) | (Optional) A CNAME record configuration block as defined below. These value are required only when you need to create a records for the DNS Zone. | `bool` | `true` | no |
| <a name="input_cname_records"></a> [cname_records](#input_cname_records) | "(Required) An `cname_record` for the Azure DNS Zone. Changing this forces a new resource to be created."<br>object({<br>  name               = (Required) The name of the DNS CNAME Record. Changing this forces a new resource to be created.<br>  ttl                = (Required) The Time To Live (TTL) of the DNS record in seconds.<br>  record             = (Optional) The target of the CNAME.<br>  target_resource_id = (Optional) The Azure resource id of the target object. Conflicts with record.<br>}) | <pre>map(object({<br>    name               = string<br>    ttl                = optional(number)<br>    record             = optional(string)<br>    target_resource_id = optional(number)<br>  }))</pre> | n/a | yes |
| <a name="input_dns_zone_name"></a> [dns_zone_name](#input_dns_zone_name) | (Required) The name of the Azure DNS Zone. <br></br>&#8226; Name must have `1-63 characters`, `2 to 34 labels`, Each label is a set of characters separated by a period. For example, contoso.com has 2 labels. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_soa_record"></a> [soa_record](#input_soa_record) | "(Required) An `soa_record` for the Azure DNS Zone. Changing this forces a new resource to be created."<br>object({<br>  email        = (Required) The email contact for the SOA record.<br>  expire_time  = (Optional) The expire time for the SOA record. Defaults to 2419200.<br>  minimum_ttl  = (Optional) The minimum Time To Live for the SOA record. By convention, it is used to determine the negative caching duration. Defaults to 300.<br>  refresh_time = (Optional) The refresh time for the SOA record. Defaults to 3600.<br>  retry_time   = (Optional) The retry time for the SOA record. Defaults to 300.<br>  ttl          = (Optional) The Time To Live of the SOA Record in seconds. Defaults to 3600.<br>}) | <pre>object({<br>    email        = string<br>    expire_time  = optional(string)<br>    minimum_ttl  = optional(number)<br>    refresh_time = optional(number)<br>    retry_time   = optional(number)<br>    ttl          = optional(number)<br>  })</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_a_record_fqdn"></a> [a_record_fqdn](#output_a_record_fqdn) | A list of DNS A Record FQDN. |
| <a name="output_a_record_id"></a> [a_record_id](#output_a_record_id) | A list of DNS A Record ID. |
| <a name="output_cname_record_fqdn"></a> [cname_record_fqdn](#output_cname_record_fqdn) | The FQDN of the DNS CNAME Record. |
| <a name="output_cname_record_id"></a> [cname_record_id](#output_cname_record_id) | The DNS CNAME Record ID. |
| <a name="output_id"></a> [id](#output_id) | The ID of the Azure DNS Zone. |
| <a name="output_name"></a> [name](#output_name) | The name of the Azure DNS Zone. |
| <a name="output_resource"></a> [resource](#output_resource) | The Azure DNS Zone resource. |
<!-- END_TF_DOCS -->
