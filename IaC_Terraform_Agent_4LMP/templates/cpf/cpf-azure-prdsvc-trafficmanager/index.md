---
version: 1.0.2
available_versions:
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.5.0
  - 0.4.0
---

<!-- BEGIN_TF_DOCS -->
# Traffic Manager module

## Overview

This terraform module creates Traffic Manger profile, Azure endpoint, External endpoint and Nested endpoint.

## Prerequisites

- `Resource Group` name is required.
- `Public IP` for azure_endpoint.

## Guidance

#### Usage

Traffic Manger Profile:
- `max_return` must be set when the `traffic_routing_method` is `MultiValue`

Traffic Manager Nested Endpoint:
- If `min_child_endpoints` is less than either `minimum_required_child_endpoints_ipv4` or `minimum_required_child_endpoints_ipv6`, then it won't have any effect.

Nested Traffic Manager Endpoint:
- The nested endpoint can be created using this module in a Traffic Manager profile, but it needs another Traffic Manager profile id to be provided as target_resource_id.

#### Security Considerations

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-TMP-SC_010 | Traffic Manager profiles must enforce network flow encryption in transit using TLS | Traffic Manager profiles must enforce network flow encryption in transit using TLS (What) via configuration Endpoint monitor settings (How) in order to use techniques to establish an encrypted data channels over untrusted networks (Why) | True | True | Set the default value of the protocol as "HTTPS" in the monitoring setting of traffic manager profile. Traffic manager works on Layer 7 (Application layer) while TLS works on layer 4 ( Transport layer). Hence Traffic manager TLS setting cannot be implemented, based on the confirmation from security team this should be enforced on the endpoint monitoring which will be HTTPS. |
| 2. | AZU-TMP-SC_020 | Traffic Manager Profile Endpoints must reside from within LSEG approved eco systems | Traffic Manager Profile Endpoints must reside from within LSEG approved eco systems (What) via endpoints settings (How) to ensure LSEG business users or staff are not directed to malicious applications (Why) | False | False | Control implemented by technical configuration setting: False. Will be implemented by LSEG Standard. |
| 3. | AZU-TMP-SC_030 | Traffic Manager Profile Endpoint custom headers must not contain sensitive data | Traffic Manager Profile Endpoint custom headers must not contain sensitive data including restricted authentication or authorisation credentials (What) via endpoints, add endpoint Custom header setting (How) in order to ensure restricted data is not exposed to the internet where they could be used to exfiltrate LSEG data (Why) | False| False | Control implemented by technical configuration setting: False. Will be implemented by LSEG Standard. |

## SMCF Controls

| S. No. | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|--------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Traffic Manager metrics and alerts ](https://learn.microsoft.com/en-us/azure/traffic-manager/traffic-manager-metrics-alerts)<br><br>[Cloud monitoring service level objectives ](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives)<br><br>[Supported metrics for Traffic Manager](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-network-trafficmanagerprofiles-metrics) |
| 5. | [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC <br><br>Documentation | True | Traffic Manager is a Global Service which provides a high availability solution by routing traffic to the available endpoints. This control will be implemented by using the attribute `traffic_routing_method`. <br><br> [Reliability in Azure Traffic Manager](https://learn.microsoft.com/en-us/azure/reliability/reliability-traffic-manager) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place.<br><br>[RBAC built-in roles ](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles) |

## Changelog

- [azure-prdsvc-terraform-trafficmanager](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/traffic-manager/traffic-manager-overview)

### Terraform Docs

- [azure-prdsvc-terraform-trafficmanagerprofile](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/traffic_manager_profile)
- [azure-prdsvc-terraform-trafficmanagerendpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/traffic_manager_azure_endpoint)
- [azure-prdsvc-terraform-trafficmanagerexternalendpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/traffic_manager_external_endpoint)
- [azure-prdsvc-terraform-trafficmanagernestedendpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/traffic_manager_nested_endpoint)

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
| [azurerm_traffic_manager_azure_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/traffic_manager_azure_endpoint) | resource |
| [azurerm_traffic_manager_external_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/traffic_manager_external_endpoint) | resource |
| [azurerm_traffic_manager_nested_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/traffic_manager_nested_endpoint) | resource |
| [azurerm_traffic_manager_profile.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/traffic_manager_profile) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_azure_endpoint"></a> [azure_endpoint](#input_azure_endpoint) | (Optional) Azure Endpoint Attribute.<br/>object({<br/>endpoint_name      = (Rquired) The name of the endpoint.<br/>profile_id         = (Rquired) The name of the Profile id.<br/>weight             = (Optional) The weight of the endpoint.<br/>target_resource_id = (Rquired) The Target resource id.<br/>endpoint_enabled   = (Optional) To enable endpoint.<br/>geo_mappings       = (Optional) The Geo mapping setting.<br/>priority           = (Optional) The Priority of the endpoint.<br/>custom_header_for_endpoint = (Optional) Map of opject attribute of custom header.<br/>name  = optional(string) Name of the custom header.<br/>value = optional(string) Value of the custom header.<br/>endpoint_subnet = (Optional) Map of object for subnet setting.<br/>first = optional(string) first ip address of your subnet<br/>last  = optional(string) last ip address of your subnet<br/>scope = optional(string) cidr range of your subnet. | <pre>map(object({<br/>    endpoint_name      = string<br/>    profile_id         = string<br/>    weight             = optional(number)<br/>    target_resource_id = string<br/>    endpoint_enabled   = optional(bool)<br/>    geo_mappings       = optional(list(string))<br/>    priority           = optional(number)<br/>    custom_header_for_endpoint = optional(map(object({<br/>      name  = optional(string)<br/>      value = optional(string)<br/>    })), {})<br/>    endpoint_subnet = optional(object({<br/>      first = optional(string)<br/>      last  = optional(string)<br/>      scope = optional(string)<br/>    }), null)<br/>  }))</pre> | `{}` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_custom_header"></a> [custom_header](#input_custom_header) | (Optional) Custom Header for Endpoints<br/>object({<br/>name   = (Required) Name of the custom header.<br/>value  = (Required) Value of the custom header | <pre>map(object({<br/>    name  = string<br/>    value = string<br/>  }))</pre> | `{}` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_expected_status_code_ranges"></a> [expected_status_code_ranges](#input_expected_status_code_ranges) | (Optional) A list of status code ranges in the format of 100-101. | `list(string)` | <pre>[<br/>  "200-399",<br/>  "400-550"<br/>]</pre> | no |
| <a name="input_external_endpoint"></a> [external_endpoint](#input_external_endpoint) | (Optional) Azure External Endpoint attribute.<br/>object({<br/>endpoint_name      = (Rquired) The name of the endpoint.<br/>profile_id         = (Rquired) The name of the Profile id.<br/>weight             = (Optional) The weight of the endpoint.<br/>target             = (Rquired) The Target resource id.<br/>endpoint_location  = (Rquired) Location of the endpoint.<br/>endpoint_enabled   = (Optional) To enable point.<br/>geo_mappings       = (Optional) The Geo mapping setting.<br/>priority           = (Optional) The Priority of the endpoint.<br/>custom_header_for_extrenal_endpoint = (Optional) Map of opject attribute of custom header.<br/>name  = optional(string) Name of the custom header.<br/>value = optional(string) Value of the custom header.<br/>external_endpoint_subnet = (Optional) External endpoint subnet attribute<br/>first = optional(string) first ip address of your subnet<br/>last  = optional(string) last ip address of your subnet<br/>scope = optional(string) cidr range of your subnet. | <pre>map(object({<br/>    endpoint_name     = string<br/>    profile_id        = string<br/>    weight            = optional(number)<br/>    target            = string<br/>    endpoint_location = string<br/>    endpoint_enabled  = optional(bool)<br/>    geo_mappings      = optional(list(string))<br/>    priority          = optional(number)<br/>    custom_header_for_extrenal_endpoint = optional(map(object({<br/>      name  = optional(string)<br/>      value = optional(string)<br/>    })), {})<br/>    external_endpoint_subnet = optional(object({<br/>      first = optional(string)<br/>      last  = optional(string)<br/>      scope = optional(string)<br/>    }), null)<br/>  }))</pre> | `{}` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_interval_in_seconds"></a> [interval_in_seconds](#input_interval_in_seconds) | (Optional) The interval used to check the endpoint health from a Traffic Manager probing agent. You can specify two values here: 30 (normal probing) and 10 (fast probing). The default value is 30 | `number` | `30` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_max_return"></a> [max_return](#input_max_return) | (Optional) The amount of endpoints to return for DNS queries to this Profile. Possible values range from 1 to 8. | `number` | `null` | no |
| <a name="input_nested_endpoint"></a> [nested_endpoint](#input_nested_endpoint) | (Optional) Azure External Endpoint attribute.<br/>object({<br/> endpoint_name      = (Rquired) The name of the endpoint.<br/>profile_id         = (Rquired) The name of the Profile id.<br/>weight             = (Optional) The weight of the endpoint.<br/>minimum_child_endpoints               = (Rquired) Min Child Endpoint.<br/>minimum_required_child_endpoints_ipv4 = (Rquired) This argument specifies the minimum number of IPv4 (DNS record type A) endpoints that must be ‘online’ in the child profile in order for the parent profile to direct traffic to any of the endpoints in that child profile.<br/>minimum_required_child_endpoints_ipv6 = (Optional) This argument specifies the minimum number of IPv6 (DNS record type AAAA) endpoints that must be ‘online’ in the child profile in order for the parent profile to direct traffic to any of the endpoints in that child profile.<br/>target_resource_id                    = (Rquired) The resource id of an Azure resource to target.<br/>endpoint_location                     = (Optional) Endpoint location.<br/>enabled                               = (Optional) Enabled Endpoint.<br/>geo_mappings                          = (Optional) Geo mapping.<br/>priority                              = (Optional) Priority of the endpoint.<br/>custom_header_for_nested_endpoint     = (Optional) Custom header for nested endpoint.<br/>name                                  = (Optional) name of the custom header<br/>value                                 = (Optional) value of the custom header.<br/>nested_endpoint_subnet                = (Optional) nested endpoint subnet attribute.<br/>first = optional(string) first ip address of your subnet<br/>last  = optional(string) last ip address of your subnet<br/>scope = optional(string) cidr range of your subnet. | <pre>map(object({<br/>    endpoint_name                         = string<br/>    profile_id                            = string<br/>    weight                                = optional(number)<br/>    minimum_child_endpoints               = number<br/>    minimum_required_child_endpoints_ipv4 = optional(number)<br/>    minimum_required_child_endpoints_ipv6 = optional(number)<br/>    target_resource_id                    = string<br/>    endpoint_location                     = optional(string)<br/>    enabled                               = optional(bool)<br/>    geo_mappings                          = optional(list(string))<br/>    priority                              = optional(number)<br/>    custom_header_for_nested_endpoint = optional(map(object({<br/>      name  = optional(string)<br/>      value = optional(string)<br/>    })), {})<br/>    nested_endpoint_subnet = optional(object({<br/>      first = optional(string)<br/>      last  = optional(string)<br/>      scope = optional(string)<br/>    }), null)<br/>  }))</pre> | `{}` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_path"></a> [path](#input_path) | (Optional) The path used by the monitoring checks. Required when protocol is set to HTTP or HTTPS - cannot be set when protocol is set to TCP. | `string` | `"/"` | no |
| <a name="input_port"></a> [port](#input_port) | (Required) The port number used by the monitoring checks. | `number` | n/a | yes |
| <a name="input_profile_status"></a> [profile_status](#input_profile_status) | (Optional) The status of the profile, can be set to either Enabled or Disabled | `string` | `"Enabled"` | no |
| <a name="input_relative_name"></a> [relative_name](#input_relative_name) | (Required) The relative domain name, this is combined with the domain name used by Traffic Manager to form the FQDN. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_timeout_in_seconds"></a> [timeout_in_seconds](#input_timeout_in_seconds) | (Optional) The amount of time the Traffic Manager probing agent should wait before considering that check a failure when a health check probe is sent to the endpoint | `number` | `10` | no |
| <a name="input_tolerated_number_of_failures"></a> [tolerated_number_of_failures](#input_tolerated_number_of_failures) | (Optional) The number of failures a Traffic Manager probing agent tolerates before marking that endpoint as unhealthy. Valid values are between 0 and 9. The default value is 3 | `number` | `3` | no |
| <a name="input_traffic_routing_method"></a> [traffic_routing_method](#input_traffic_routing_method) | (Required) Specifies the algorithm used to route traffic. Possible values are Geographic, Weighted, Performance, Priority, Subnet and MultiValue. | `string` | n/a | yes |
| <a name="input_traffic_view_enabled"></a> [traffic_view_enabled](#input_traffic_view_enabled) | (Optional) Indicates whether Traffic View is enabled for the Traffic Manager profile. | `bool` | `true` | no |
| <a name="input_ttl"></a> [ttl](#input_ttl) | (Required) The TTL value of the Profile used by Local DNS resolvers and clients. | `number` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoint_name"></a> [endpoint_name](#output_endpoint_name) | The Name of the Traffic Manager endpoint. |
| <a name="output_external_endpoint_name"></a> [external_endpoint_name](#output_external_endpoint_name) | The Name of the Traffic Manager external endpoint. |
| <a name="output_id"></a> [id](#output_id) | The ID of the Traffic Manager Profile. |
| <a name="output_name"></a> [name](#output_name) | The Name of the Traffic Manager Profile. |
| <a name="output_nested_endpoint_name"></a> [nested_endpoint_name](#output_nested_endpoint_name) | The Name of the Traffic Manager nested endpoint. |
| <a name="output_resource"></a> [resource](#output_resource) | The Traffic Manager Profile resource. |
<!-- END_TF_DOCS -->
