---
version: 0.3.0
available_versions:
  - 0.3.0
  - 0.2.2
  - 0.2.1
  - 0.2.0
  - 0.1.0
---

<!-- BEGIN_TF_DOCS -->
# Network watcher module

## Overview

- This terraform module creates a Network watcher and associated resources.
- Azure Network Watcher provides a suite of tools to monitor, diagnose, view metrics, and enable or disable logs for Azure IaaS (Infrastructure-as-a-Service) resources.
- Network Watcher isn't designed or intended for PaaS monitoring or Web analytics.

## Prerequisites

- `Resource Group` name is required.
- `Network Security Group id` , `Storage Account id ` and `Log Analytics Workspace id`is required.

## Guidance

#### Usage

- Network Watcher enables you to monitor and repair the network health of IaaS products like virtual machines (VMs), virtual networks (VNets), application gateways, load balancers, etc.

#### Security Considerations

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-VN-AU_010 | Network Watcher must be created for all LSEG supported Azure regions | Network Watcher must be created for all LSEG supported Azure regions (What) via the Overview settings (How) in order to support a security investigation after a security incident involving a Virtual Network in the Network Watcher region (Why) | False | False | This is a platform level control which will be implemented at ALZ vending |
| 2. | AZU-VN-AU_020 | NSG Flow Logs must send all diagnostic logs to a central Log Analytics workspace | NSG Flow Logs must send all diagnostic logs to a central Log Analytics workspace (What) via the Diagnostic settings (How) in order to capture to support a security investigation after a security incident involving a Virtual Network (Why) | False | False | Diagnostics settings will be enabled using a separate module at bundle/pattern level |
| 3. | AZU-VN-AU_030 |  NSG Flow Logs must be sent to a central SOC Storage Account | NSG Flow Logs must be sent to a central SOC Storage Account (What) via the Basics settings (How) in order to provide an immutable copy to adhere to compliance requirements (Why) | True | True | Implemented by setting `storage_account_id` as mandatory and added `retention_policy` block with `enabled = true` and `retention_in_days` minimum as `365` days |
| 4. | AZU-VN-AU_040 | NSG Flow Logs must be in version 2 format | NSG Flow Logs must be in version 2 format (What) via the Analytics settings (How) in order to capture all available information to support a security investigation after a security incident involving a Virtual Network (Why) | True | True | Implemented using `version = 2` |
| 5. | AZU-VN-AU_050 | NSG Flow Logs must enable traffic analytics with an interval of 1 hour and send data to the central Log Analytics workspace | NSG Flow Logs must enable traffic analytics with an interval of 1 hours and send data to the central Log Analytics workspace (What) in the Analytics settings (How) in order to capture all available information to support a security investigation after a security incident involving a Virtual Network (Why) | True | True | Implemented using `traffic_analytics` block and setting `enabled = true` and `interval_in_minutes = 60` within the block |
| 6. | AZU-VN-AU_060 | Flow logs must be created for every NSG | Flow logs must be created for every NSG (What) via the Flow Log settings (How) in order to capture to support a security investigation after a security incident involving a Virtual Network (Why) | False | False | This is a platform level control which will be implemented at ALZ vending |
| 7. | AZU-VN-AU_070 | NSG Flow Logs must be in a state of enabled | NSG Flow Logs must be in a state of enabled (What) via the Flow Log settings (How) in order to capture to support a security investigation after a security incident involving a Virtual Network (Why) | True | True | Implemented using `enabled = true` |

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Azure Network Watcher Connection monitor overview](https://learn.microsoft.com/en-us/azure/network-watcher/connection-monitor-overview)<br><br>[Cloud monitoring service level objectives ](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives)<br><br>[Supported Metrics for Azure Network Watcher Connnection Monitor](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-network-networkwatchers-connectionmonitors-metrics) |
| 5.| [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | True | Network Watcher service is zone-resilient by default.<br><br>[Network Watcher Service Availability and Redundancy](https://learn.microsoft.com/en-us/azure/network-watcher/frequently-asked-questions#service-availability-and-redundancy) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place.<br><br>[RBAC required to use Network Watcher capabilities](https://learn.microsoft.com/en-us/azure/network-watcher/required-rbac-permissions) |

## Changelog

- [azure-prdsvc-terraform-networkwatcher](../CHANGELOG.md)

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/network-watcher/network-watcher-monitoring-overview)

### Terraform Docs

- [azurerm_network_watcher](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_watcher)
- [azurerm_network_watcher_flow_log](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_watcher_flow_log)

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
| [azurerm_network_watcher.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_watcher) | resource |
| [azurerm_network_watcher_flow_log.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_watcher_flow_log) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_flow_log_name"></a> [flow_log_name](#input_flow_log_name) | (Required) The name of the Network Watcher Flow Log. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_flow_logs_enabled"></a> [flow_logs_enabled](#input_flow_logs_enabled) | (Optional) Should Network Flow Logging resource be deployed or skip as per input. | `bool` | `true` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_network_security_group_id"></a> [network_security_group_id](#input_network_security_group_id) | (Required) The ID of the Network Security Group for which to enable flow logs for. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_retention_in_days"></a> [retention_in_days](#input_retention_in_days) | (Optional) The number of days to retain flow log records. | `number` | `365` | no |
| <a name="input_storage_account_id"></a> [storage_account_id](#input_storage_account_id) | (Required) The ID of the Storage Account where flow logs are stored. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_traffic_analytics"></a> [traffic_analytics](#input_traffic_analytics) | "(Required) Object for containing traffic analytics parameter"<br>object({<br>  workspace_id                = "(Required) The resource GUID of the attached workspace."<br> workspace_resource_id       = "(Required) The resource ID of the attached workspace."<br>}) | <pre>object({<br>    workspace_id          = string<br>    workspace_resource_id = string<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_flow_log_name"></a> [flow_log_name](#output_flow_log_name) | The Name of the created network watcher flow log |
| <a name="output_id"></a> [id](#output_id) | The ID of the created network watcher |
| <a name="output_name"></a> [name](#output_name) | The Name of the created network watcher |
| <a name="output_resource"></a> [resource](#output_resource) | The Network Watcher resource. |
<!-- END_TF_DOCS -->
