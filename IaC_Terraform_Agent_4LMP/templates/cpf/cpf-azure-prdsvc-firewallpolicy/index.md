---
version: 0.3.3
available_versions:
  - 0.3.3
  - 0.3.2
  - 0.3.1
  - 0.3.0
  - 0.2.0
---

<!-- BEGIN_TF_DOCS -->
# Azure Firewall Policy module

## Overview

This terraform module creates a Azure firewall policy (without TLS Inspection Feature) for Azure firewall premium SKU.

## Prerequisites

- `Resource Group`

## Guidance

#### Usage

The module currently include the following features

- IDPS(Intrusion detection and prevention system)
- URL filtering
- DNS Proxy
- Threat Intelligency
- Application rule collection
- NAT rule collection
- Network rule collection

#### Security Considerations

### Additional Information

The module does not currently include the following features

- TLS inspection
- Explicit proxy (currently in Preview)

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1.| AZU-FW-AC_010 | It must not be possible to create Rule Collection Groups of type DNAT in Firewall Policies attached to the Control Plane Hub | It must not be possible to create Rule Collection Groups of type DNAT in Firewall Policies attached to the Control Plane Hub (What) via the Rule collections settings (How) in order to disable unused network device services as per LSEG Security standard (Why) | False | False | Since "Dnat" action is the only allowed option in NAT settings, it cannot be disabled. However, nat_rule_collection block being an optional in terraform, it can be skipped during the resource provision. It meets the end goal. |
| 2.| AZU-FW-AC_020 | Network Rules must not allow inbound connectivity from the internet | Network Rules must not allow inbound connectivity from the internet (What) via the Rule settings (How) to reduce service exposure to bad actors on the internet (Why) | True | True | Added a condition to validation block of variable "network_rule_collection" having the argument source_addresses shouldn't include internet sources such as "0.0.0.0/0" ,"0.0.0.0", "*". |
| 3.| AZU-FW-AC_030 | LSEG CyberSecurity must approve all rules to be applied to the firewall | LSEG CyberSecurity must approve all rules to be applied to the firewall (What) via ServiceNow (How) as per LSEG Security standard (Why) | False | False | Control implemented by technical configuration setting: False |
| 4.| AZU-FW-AC_040 | It must not be possible to create Application Rules with Destination Type of Web Categories | It must not be possible to create Application Rules with Destination Type of Web Categories (What) via the Rule Settings (How) in order to disable functionality which allows network access out to a generic grouping of Internet destinations (Why) | True | True | Passed "null" value to the argument web_categories of "application_rule_collection" block which skips the resource from having the values of web category field. |
| 5.| AZU-FW-SC_030 | Azure Firewall Policies must have threat intelligence configured in alert mode | Azure Firewall Policies must have threat intelligence configured in alert mode (What) via the Threat Intelligence settings (How) to detect traffic passing through the firewall to and from malicious sources (Why) | True | True | Have implemented threat_intelligence_mode = "Alert" under resource type "azurerm_firewall_policy". Since there is a restriction in SKU name and firewall is fully governed by firewall policy. Value to be passed as "Alert" to threat_intel_mode in Azure Firewall module. |
| 6.| AZU-FW-SC_040 | Azure Firewall Policies must have LSEG DNS servers specified | Azure Firewall Policies must have LSEG DNS servers specified (What) in the DNS settings (How) in order to ensure consistent DNS resolution for Application Rules so that the correct effect (allow/deny) is applied (Why) | True | True | Added the variable dnsservers a required one to the dns block of resource type azurerm_firewall_policy. It prompts server IP addresses during resource provisioning. |
| 7.| AZU-FW-SC_050 | Azure Firewall DNS Proxy must be disabled | Azure Firewall DNS Proxy must be disabled (What) in the DNS settings (How) in order to disable unused network device services as per LSEG Security standard (Why) | True | True | Implemented the argument proxy_enabled = false to the dns block of resource type azurerm_firewall_policy. |

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Cloud monitoring service level objectives ](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives)<br><br>[Supported Metrics for Azure Firewall ](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-network-azurefirewalls-metrics) |
| 5.| [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | True | This control will be implemented by the firewall policy itself. High availability is built in by default, so there's no need to configure. <br><br>[Built-in high availability ](https://learn.microsoft.com/en-us/azure/firewall-manager/policy-overview#built-in-high-availability) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place. <br><br>[Azure built-in roles ](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles) |

## Changelog

- [azure-prdsvc-terraform-firewallpolicy](CHANGELOG.md)

## References

### Microsoft Docs

- [official documentation](https://learn.microsoft.com/en-us/azure/firewall-manager/policy-overview)

### Terraform Docs

- [azurerm_virtual_network](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall_policy)

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
| [azurerm_firewall_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall_policy) | resource |
| [azurerm_firewall_policy_rule_collection_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall_policy_rule_collection_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_application_rule_collection"></a> [application_rule_collection](#input_application_rule_collection) | (Optional) List of Application rule collection for the Azure Firewall Policy | <pre>map(object({<br>    name     = string #(Required) The name which should be used for this application rule collection.<br>    action   = string #(Required) The action to take for the application rules in this collection. Possible values are Allow and Deny.<br>    priority = number #Required) The priority of the application rule collection. The range is 100 - 65000.<br>    rule = map(object({<br>      name                  = string       #(Required) The name which should be used for this rule.<br>      description           = string       #(Optional) The description which should be used for this rule.<br>      source_addresses      = list(string) #(Optional) Specifies a list of source IP addresses (including CIDR, IP range and *).<br>      source_ip_groups      = list(string) #(Optional) Specifies a list of source IP groups.<br>      destination_addresses = list(string) #(Optional) Specifies a list of destination IP addresses (including CIDR, IP range and *).<br>      destination_fqdns     = list(string) #(Optional) Specifies a list of destination FQDNs. Conflicts with destination_urls.<br>      terminate_tls         = bool         #(Optional) Boolean specifying if TLS shall be terminated (true) or not (false). Must be true when using destination_urls. Needs Premium SKU for Firewall Policy.<br>      web_categories        = list(string) #(Optional) Specifies a list of web categories to which access is denied or allowed depending on the value of action above. Needs Premium SKU for Firewall Policy.<br>      protocols = list(object({<br>        type = string #(Required) Protocol type. Possible values are Http and Https.<br>        port = number #(Required) Port number of the protocol. Range is 0-64000.<br>      }))<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_auto_learn_private_ranges_enabled"></a> [auto_learn_private_ranges_enabled](#input_auto_learn_private_ranges_enabled) | (Optional) Whether enable auto learn private ip range | `bool` | `false` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_dnsservers"></a> [dnsservers](#input_dnsservers) | (Required) A list of custom DNS servers' IP addresses. | `list(string)` | n/a | yes |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_insight_setting"></a> [insight_setting](#input_insight_setting) | (Optional) logging and monitoring setting for Azure firewall Policy<br> object({<br> enabled                            = (Required) Whether the insights functionality is enabled for this Firewall Policy.<br> default_log_analytics_workspace_id = (Required) The ID of the default Log Analytics Workspace that the Firewalls associated with this Firewall Policy will send their logs to, when there is no location matches in the log_analytics_workspace.<br> retention_in_days                  = (Required) The log retention period in days.<br> log_analytics_workspace            = (Required) A list of log_analytics_workspace block as defined below.<br> log_analytics_workspace_id         = (Required) The ID of the Log Analytics Workspace that the Firewalls associated with this Firewall Policy will send their logs to when their locations match the firewall_location.<br> firewall_location                  = (Required) The location of the Firewalls, that when matches this Log Analytics Workspace will be used to consume their logs.<br> }) | <pre>map(object({<br>    enabled                            = bool<br>    default_log_analytics_workspace_id = string<br>    retention_in_days                  = number<br>    log_analytics_workspace = map(object({<br>      log_analytics_workspace_id = string<br>      firewall_location          = string<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_intrusion_detection_setting"></a> [intrusion_detection_setting](#input_intrusion_detection_setting) | (Optional) IDPS setting for Azure firewall Policy<br>object({<br> mode                  = (Required) In which mode you want to run intrusion detection: Off, Alert or Deny.<br> private_ranges        = (Required) A list of Private IP address ranges to identify traffic direction. By default, only ranges defined by IANA RFC 1918 are considered private IP addresses.<br> signature_overrides   = (Required) One or more signature_overrides blocks as defined below.<br> signature_id          = (Required) 12-digit number (id) which identifies your signature.<br> signature_state       = (Required) state can be any of Off, Alert or Deny.<br> traffic_bypass        = (Required) One or more traffic_bypass blocks as defined below.<br> name                  = (Required) The name which should be used for this bypass traffic setting. <br> protocol              = (Required) The protocols any of ANY, TCP, ICMP, UDP that shall be bypassed by intrusion detection.<br> description           = (Required) The description for this bypass traffic setting.<br> destination_addresses = (Required) Specifies a list of destination IP addresses that shall be bypassed by intrusion detection.<br> destination_ip_groups = (Required) Specifies a list of destination IP groups that shall be bypassed by intrusion detection.<br> destination_ports     = (Required) Specifies a list of destination IP ports that shall be bypassed by intrusion detection.<br> source_addresses      = (Required) Specifies a list of source addresses that shall be bypassed by intrusion detection.<br> source_ip_groups      = (Required) Specifies a list of source IP groups that shall be bypassed by intrusion detection.<br> }) | <pre>map(object({<br>    mode           = string<br>    private_ranges = list(string)<br>    signature_overrides = map(object({<br>      signature_id    = number<br>      signature_state = string<br>    }))<br>    traffic_bypass = map(object({<br>      name                  = string<br>      protocol              = string<br>      description           = string<br>      destination_addresses = list(string)<br>      destination_ip_groups = list(string)<br>      destination_ports     = list(string)<br>      source_addresses      = list(string)<br>      source_ip_groups      = list(string)<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_nat_rule_collection"></a> [nat_rule_collection](#input_nat_rule_collection) | (optional) List of NAT rule collection for the Azure Firewall Policy | <pre>map(object({<br>    name     = string #(Required) The name which should be used for this NAT rule collection.<br>    action   = string #(Required) The action to take for the NAT rules in this collection. Currently, the only possible value is Dnat.<br>    priority = number #Required) The priority of the NAT rule collection. The range is 100 - 65000.<br>    rule = map(object({<br>      name                = string       #(Required) The name which should be used for this rule.<br>      protocols           = list(string) #(Required) Specifies a list of network protocols this rule applies to. Possible values are TCP, UDP.<br>      source_addresses    = list(string) # (Optional) Specifies a list of source IP addresses (including CIDR, IP range and *).<br>      source_ip_groups    = list(string) # (Optional) Specifies a list of source IP groups.<br>      destination_address = string       # (Optional) The destination IP address (including CIDR).<br>      destination_ports   = list(string) # (Optional) Specifies a list of destination ports. Only one destination port is supported in a NAT rule.<br>      translated_fqdn     = string       # (Optional) Specifies the translated FQDN.<br>      translated_port     = number       # (Required) Specifies the translated port.<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_network_rule_collection"></a> [network_rule_collection](#input_network_rule_collection) | (Optional) List of Network rule collection for the Azure Firewall Policy | <pre>map(object({<br>    name     = string #(Required) The name which should be used for this network rule collection.<br>    action   = string #(Required) The action to take for the network rules in this collection. Possible values are Allow and Deny.<br>    priority = number #(Required) The priority of the network rule collection. The range is 100 - 65000.<br>    rule = map(object({<br>      name                  = string       #(Required) The name which should be used for this rule.<br>      protocols             = list(string) #(Required) Specifies a list of network protocols this rule applies to. Possible values are Any, TCP, UDP, ICMP.<br>      destination_ports     = list(string) #(Required) Specifies a list of destination ports.<br>      source_addresses      = list(string) #(Optional) Specifies a list of source IP addresses (including CIDR, IP range and *).<br>      source_ip_groups      = list(string) #(Optional) Specifies a list of source IP groups.<br>      destination_addresses = list(string) #(Optional) Specifies a list of destination IP addresses (including CIDR, IP range and *) or Service Tags.<br>      destination_ip_groups = list(string) #(Optional) Specifies a list of destination IP groups.<br>      destination_fqdns     = list(string) # (Optional) Specifies a list of destination FQDNs.<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_priority"></a> [priority](#input_priority) | (Required) The priority of the Firewall Policy Rule Collection Group. The range is 100-65000. | `number` | n/a | yes |
| <a name="input_private_ip_ranges"></a> [private_ip_ranges](#input_private_ip_ranges) | (Required) A list of private IP ranges to which traffic will not be SNAT | `list(string)` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input_sku) | (Required) The SKU Tier of the Firewall Policy. Possible values are Standard, Premium and Basic | `string` | n/a | yes |
| <a name="input_sql_redirect_allowed"></a> [sql_redirect_allowed](#input_sql_redirect_allowed) | (Optional) Whether SQL Redirect traffic filtering is allowed. Enabling this flag Requires no rule using ports between 11000-11999 | `bool` | `false` | no |
| <a name="input_state"></a> [state](#input_state) | (Optional) state can be any of Off, Alert or Deny | `string` | `"Off"` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_threat_intelligence_setting"></a> [threat_intelligence_setting](#input_threat_intelligence_setting) | (Optional)threat intelligence IDPS setting for Azure firewall Policy<br> object({<br>   threat_intelligence_allowlist_fqdn        = (Required) A list of FQDNs that will be skipped for threat detection.<br>   threat_intelligence_allowlist_ip_address  = (Required) A list of IP addresses or CIDR ranges that will be skipped for threat detection.<br> }) | <pre>map(object({<br>    threat_intelligence_allowlist_fqdn       = list(string)<br>    threat_intelligence_allowlist_ip_address = list(string)<br>  }))</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_fwpolicy_collection_group_id"></a> [fwpolicy_collection_group_id](#output_fwpolicy_collection_group_id) | The name of the firewall policy rule collection group id. |
| <a name="output_fwpolicy_collection_group_name"></a> [fwpolicy_collection_group_name](#output_fwpolicy_collection_group_name) | The name of the firewall policy rule collection group name. |
| <a name="output_id"></a> [id](#output_id) | The ID of the firewall policy. |
| <a name="output_name"></a> [name](#output_name) | The name of the firewall policy. |
| <a name="output_resource"></a> [resource](#output_resource) | The Firewall Policy resource. |
<!-- END_TF_DOCS -->
