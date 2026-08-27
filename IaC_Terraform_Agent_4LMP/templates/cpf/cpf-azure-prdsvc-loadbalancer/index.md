---
version: 1.1.0
available_versions:
  - 1.1.0
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.5.2
---

<!-- BEGIN_TF_DOCS -->
# Load Balancer Module

## Overview

This terraform module creates a [**Azure Load Balancer**](https://docs.microsoft.com/en-us/azure/load-balancer/load-balancer-overview) and its associated load balancing rules.

An Azure Load Balancer can be public or internal (private). A public load balancer uses public IP and public IP prefix as frontend IP(s), whereas an internal (private) Load Balancer uses private IP(s) as frontend IP(s).

## Prerequisites

- `Subnet` is  required in already existing `virtual network` for Load Balancer.

## Guidance

#### Usage

- This Module can only deploy an **internal load balancer**. An internal (or private) load balancer is used where private IPs are needed at the frontend only. Internal load balancers are used to load balance traffic inside a virtual network. A load balancer frontend can be accessed from an on-premises network in a hybrid scenario. To deploy Internal Load balancer, Virtual Network and a subnet for the Frontend IP(s) are required.

- Whenever load balancer rules are created then the module will associate them with all backend address pools by default.

- NAT Pool cannot be used with virtual machines, instead use the azurerm_lb_nat_rule resource.

#### Security Considerations

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-LB-AC_010 | Disable public network access | Load Balancer must enforce a network guardrail (What) within deployment settings (How) in order to prevent unauthorised access and data exposure to the internet (Why) | True | True | Implemented by setting `public_ip_address_id = null` and `public_ip_prefix_id = null` for each `frontend_ip_configuration` |
| 2. | AZU-LB-AU_010 | Send all diagnostic log categories to a central SOC Log Analytics workspace | Load Balancer must send all diagnostic logs to a central SOC Log Analytics workspace (What) within Diagnostic settings (How) in order to support a security investigation after a security incident (Why) | False | False | This control will be implemented via policy. |
| 3. | AZU-LB-AU_020 | Send all diagnostic log categories to a central SOC Storage Account | Load Balancer must send all diagnostic logs to a central SOC Storage Account (What) within Diagnostic settings (How) in order to support a security investigation after a security incident (Why) | False | False | This control will be implemented via policy. |

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Monitor Azure Load Balancer](https://learn.microsoft.com/en-us/azure/load-balancer/monitor-load-balancer)<br><br>[Cloud monitoring service level objectives](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives)<br><br>[Supported Metrics for Azure Load Balancer](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-network-loadbalancers-metrics) |
| 5. | [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | True | This control will be implemented by selecting the right combination of `sku` and `sku_tier`.<br><br>[Load Balancer and Availability Zones](https://learn.microsoft.com/en-us/azure/load-balancer/load-balancer-standard-availability-zones)<br><br>[Cross region (Global) Load Balancer](https://learn.microsoft.com/en-us/azure/load-balancer/cross-region-overview) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place. |

## Changelog

- [azure-prdsvc-terraform-loadbalancer](../CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentaion](https://learn.microsoft.com/en-us/azure/load-balancer/load-balancer-overview)

### Terraform Docs

- [azurerm_lb](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb)
- [azurerm_lb_backend_address_pool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_backend_address_pool)
- [azurerm_lb_backend_address_pool_address](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_backend_address_pool_address)
- [azurerm_lb_nat_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_nat_rule)
- [azurerm_lb_probe](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_probe)
- [azurerm_lb_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_rule)

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
| [azurerm_lb.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb) | resource |
| [azurerm_lb_backend_address_pool.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_backend_address_pool) | resource |
| [azurerm_lb_nat_pool.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_nat_pool) | resource |
| [azurerm_lb_nat_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_nat_rule) | resource |
| [azurerm_lb_probe.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_probe) | resource |
| [azurerm_lb_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_backend_pool_names"></a> [backend_pool_names](#input_backend_pool_names) | (Optional) List of backend pool names for the Load Balancer. | `list(string)` | `[]` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_lb_frontend_ip_configurations"></a> [lb_frontend_ip_configurations](#input_lb_frontend_ip_configurations) | "(Optional) List containing load balancer frontend ip configuration parameters"<br/>object({<br/>  name                                               = "(Required) Specifies the name of the frontend IP configuration."<br/>  subnet_id                                          = "(Required)The ID of the Subnet which should be associated with the IP Configuration."<br/> zones                                              = "(Optional) Specifies a list of Availability Zones in which the IP Address for this Load Balancer should be located."<br/> private_ip_address                                 = "(Optional) Private IP Address to assign to the Load Balancer. The last one and first four IPs in any range are reserved and cannot be manually assigned."<br/> private_ip_address_allocation                      = "(Optional) The allocation method for the Private IP Address used by this Load Balancer. Possible values as Dynamic and Static."<br/>  gateway_load_balancer_frontend_ip_configuration_id = "(Optional) The Frontend IP Configuration ID of a Gateway SKU Load Balancer."<br/>}) | <pre>list(object({<br/>    subnet_id                                          = string<br/>    name                                               = string<br/>    zones                                              = optional(list(number))<br/>    private_ip_address                                 = optional(string)<br/>    private_ip_address_allocation                      = optional(string, "Dynamic")<br/>    private_ip_address_version                         = optional(string, "IPv4")<br/>    gateway_load_balancer_frontend_ip_configuration_id = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_lb_nat_pools"></a> [lb_nat_pools](#input_lb_nat_pools) | "(Optional) Map containing load balancer nat pool parameters"<br/>object({<br/>  protocol                       = "(Required) The transport protocol for the external endpoint. Possible values are Udp or Tcp."<br/>  frontend_ip_configuration_name = "(Required) frontend ip name of the load balancer"<br/>  frontend_port_start            = "(Required) The first port number in the range of external ports that will be used to provide Inbound NAT to NICs associated with this Load Balancer. Possible values range between 1 and 65534."<br/>  frontend_port_end              = "(Required) The last port number in the range of external ports that will be used to provide Inbound NAT to NICs associated with this Load Balancer. Possible values range between 1 and 65534"<br/>  backend_port                   = "(Required) The port used for internal connections on the endpoint.Values between 0 and 65535."<br/>}) | <pre>map(object({<br/>    protocol                       = string<br/>    frontend_ip_configuration_name = string<br/>    frontend_port_start            = number<br/>    frontend_port_end              = number<br/>    backend_port                   = number<br/>  }))</pre> | `{}` | no |
| <a name="input_lb_nat_rules"></a> [lb_nat_rules](#input_lb_nat_rules) | (Optional) Map containing load balancer nat rules<br/>object({<br/>  protocol                       = "(Required) The transport protocol for the external endpoint. Possible values are `\"Tcp, Udp or All\"<br/>  frontend_ip_configuration_name = "(Required) frontend ip name of the load balancer"<br/>  backend_pool_name              = "(Required) backendpool name of the load balancer"<br/>  frontend_port                  = "(Required) port used for External connections on the endpoint. Values between 0 and 65534."<br/>  backend_port                   = "(Required) The port used for internal connections on the endpoint.Values between 0 and 65535."<br/>  idle_timeout_in_minutes        = "(Optional) Specifies the idle timeout in minutes for TCP connections. Values are between 4 and 30 minutes"<br/>  enable_floating_ip             = "(Optional) Are the Floating IPs enabled for this Load Balncer Rule? A `\"floating\"` IP is reassigned to a secondary server in case the primary server fails. Required to configure a SQL AlwaysOn Availability Group. Defaults to false"<br/>  enable_tcp_reset               = "(Optional) Is TCP Reset enabled for this Load Balancer Rule? Defaults to false."<br/>})<br/>` | <pre>map(object({<br/>    protocol                       = string<br/>    frontend_ip_configuration_name = string<br/>    frontend_port                  = number<br/>    backend_port                   = number<br/>    idle_timeout_in_minutes        = optional(number)<br/>    enable_floating_ip             = optional(bool, false)<br/>    enable_tcp_reset               = optional(bool, false)<br/>  }))</pre> | `{}` | no |
| <a name="input_lb_probes"></a> [lb_probes](#input_lb_probes) | "(Required) Map containing load balancer probes parameters"<br/>object({<br/>  protocol            = "(Required) The transport protocol for the external endpoint. Possible values are Udp or Tcp."<br/>  port                = "(Required) Port on which the Probe queries the backend endpoint. Values between 0 and 65535, inclusive."<br/> request_path        = "(Optional) The URI used for requesting health status from the backend endpoint. Required if probe_protocol is set to Http"<br/> interval_in_seconds = "(Optional) The interval, in seconds between probes to the backend endpoint for health status."<br/> number_of_probes    = "(Optional, deprecated) The number of failed probe attempts after which the backend endpoint is removed from rotation."<br/> probe_threshold     = "(Optional) The number of consecutive successful or failed probes that allow or deny traffic to this endpoint."<br/>}) | <pre>map(object({<br/>    protocol            = string<br/>    port                = number<br/>    request_path        = optional(string)<br/>    interval_in_seconds = optional(number)<br/>    number_of_probes    = optional(number)<br/>    probe_threshold     = optional(number)<br/>  }))</pre> | n/a | yes |
| <a name="input_lb_rules"></a> [lb_rules](#input_lb_rules) | (Optional) Map containing load balancer rule and probe<br/>  object({<br/>  frontend_ip_configuration_name = "(Required) frontend ip name of the load balancer"<br/>  backend_pool_name              = "(Required) backendpool name of the load balancer"<br/> protocol                       = "(Required) The transport protocol for the external endpoint. Possible values are `\"Tcp, Udp or All\"<br/>  frontend_port                  = "(Required) The port for the external endpoint. Port numbers for each Rule must be unique within the Load Balancer. Set this frontend port to 0 if lb_protocol is set to `\"All\"`. Values between `\"0 and 65535\"<br/>  backend_port                   = "(Required) The port used for internal connections on the endpoint. Set this backend port to 0 if lb_protocol is set to \"All\".<br/>  probe_name                     = "(Optional) The name of a Probe used by this Load Balancing Rule."<br/> enable_floating_ip             = "(Optional) Are the Floating IPs enabled for this Load Balncer Rule? A `\"floating\"` IP is reassigned to a secondary server in case the primary server fails. Required to configure a SQL AlwaysOn Availability Group. Defaults to false"<br/> disable_outbound_snat          = "(Optional) Is snat enabled for this Load Balancer Rule? Default false." <br/> enable_tcp_reset               = "(Optional) Is TCP Reset enabled for this Load Balancer Rule? Defaults to false."<br/> load_distribution              = "(Optional) Specifies the load balancing distribution type to be used by the Load Balancer. Possible values are `\"Default,SourceIP,SourceIPProtocol\"`."<br/>  idle_timeout_in_minutes        = "(Optional) Specifies the idle timeout in minutes for TCP connections. Values are between 4 and 30 minutes"<br/>}) | <pre>map(object({<br/>    frontend_ip_configuration_name = string<br/>    backend_pool_name              = string<br/>    protocol                       = string<br/>    frontend_port                  = string<br/>    backend_port                   = number<br/>    probe_name                     = optional(string)<br/>    enable_floating_ip             = optional(bool, false)<br/>    disable_outbound_snat          = optional(bool, false)<br/>    enable_tcp_reset               = optional(bool, false)<br/>    load_distribution              = optional(string)<br/>    idle_timeout_in_minutes        = optional(number)<br/>  }))</pre> | `{}` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input_sku) | (Optional) The SKU of the Azure Load Balancer. Accepted values are Basic and Standard. Defaults to Basic. | `string` | `"Standard"` | no |
| <a name="input_sku_tier"></a> [sku_tier](#input_sku_tier) | (Optional) The Sku Tier of this Load Balancer. Possible values are Global and Regional. | `string` | `"Regional"` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_backend_ids"></a> [backend_ids](#output_backend_ids) | The list of backend pool address IDs. |
| <a name="output_backend_map_ids"></a> [backend_map_ids](#output_backend_map_ids) | The map of backend pool address IDs. |
| <a name="output_frontend_ip_configurations"></a> [frontend_ip_configurations](#output_frontend_ip_configurations) | The list of frontend configurations names. |
| <a name="output_frontend_ip_configurations_map"></a> [frontend_ip_configurations_map](#output_frontend_ip_configurations_map) | The map of frontend configurations. |
| <a name="output_id"></a> [id](#output_id) | The Resource ID of the Load Balancer. |
| <a name="output_name"></a> [name](#output_name) | The Name of the Load Balancer. |
| <a name="output_natrule_map_ids"></a> [natrule_map_ids](#output_natrule_map_ids) | The map of NAT rules. |
| <a name="output_private_ip_addresses"></a> [private_ip_addresses](#output_private_ip_addresses) | The list of private IP addresses assigned to the frontend configuration names. |
| <a name="output_probe_ids"></a> [probe_ids](#output_probe_ids) | The list of Probe IDs. |
| <a name="output_probe_map_ids"></a> [probe_map_ids](#output_probe_map_ids) | The map of Load Balancer Probes. |
| <a name="output_resource"></a> [resource](#output_resource) | The Load Balancer resource. |
| <a name="output_rule_ids"></a> [rule_ids](#output_rule_ids) | The list of Load Balancer rules IDs. |
<!-- END_TF_DOCS -->
