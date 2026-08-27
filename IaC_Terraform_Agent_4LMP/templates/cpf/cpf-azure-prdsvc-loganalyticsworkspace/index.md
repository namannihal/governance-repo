---
version: 2.1.0
available_versions:
  - 2.1.0
  - 2.0.2
  - 2.0.1
  - 2.0.0
  - 1.2.2
---

<!-- BEGIN_TF_DOCS -->
# Log Analytics Workspace module


## Overview

This terraform module creates a Log Analytics Workspace and, optionally, a Log Analytics Data Export Rule and Log Analytics Log Custom tables.

## Prerequisites

- To perform the deployment, a **Resource Group** must exist to deploy the Log Analytics Workspace.
- To deploy a Log Analytics Data Export Rule (optional), a **Storage Account** must exist to be leveraged as destination.

## Guidance

#### Usage

- A `mnd-dataclassification` tag key is created by default and assigned to the Log Analytics Workspace resource. The tag value is set to empty by default and set via Azure Policy. It is also possible to set the value via the input variable `data_classification_tag_value`.

#### Security Considerations

## Security Controls

| S. No. | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
| ------ | ---------- | --------------| ----------- | ----------- | ------------------- | -------- |
| 1. | AZU-LAW-IA_010 | LSEG developed applications must use Entra ID to authenticate to a Log Analytics workspace (What) by using the Azure Monitor Log Analytics API api.loganalytics.azure.com (How) in order to use modern robust and less prone to compromise authentication methods embedded within Entra ID (Why) | True | True | Authentication using Azure AD is enforced using the `local_authentication_disabled` parameter and is tested using pester. |
| 2. | AZU-LAW-AC_020 |  For central SOC Log Analytics enable granular Azure RBAC authorisation (What) within Properties set access control mode to use resource or workspace permissions (How) in order to restrict the blast radius should the authenticating credentials be compromised (Why) | True | True | Granular RBAC is enabled by default. Use of Resource or Workspace permissions can be set using the optional parameter `allow_resource_only_permissions`. The default value is set to true to enable resource-context access mode. |
| 3. | AZU-LAW-AC_030 | For log writing to a central SOC Log Analytics workspace enforce the use of a custom RBAC role (What) By creating a custom role with actions Microsoft.operationalinsights/workspaces/read, Microsoft.operationalinsights/workspaces/sharedkeys/action (How) in order to prevent log queries unauthorised entities to the central workspace with its consolidated application sensitive log data whilst allowing the ability to write log data to the workspace (Why) | False | False | SoC related control: Will be implemented through policy at management group level. |
| 4. | AZU-LAW-AU_020 | For a central SOC Log Analytics workspace set Data Retention to 365 days (What) via overview, manage usage and costs, Data retention (How) in order to support a security investigation after a security incident (Why) | True | True | Implemented using the optional parameter `retention_in_days`. Default value is 365. The parameter can be set to the required value as suited - Possible values are either 7 (Free Tier only) or range between 30 and 730. |
| 5. | AZU-LAW-AU_030 | For a central SOC Log Analytics workspace enable the SecurityInsights solution (What) via Deployment settings (How) in order to support if required a security investigation after a security incident using Azure Sentinel tools (Why) | False | False | SoC related control: Will be implemented through policy at management group level. |
| 6. | AZU-LAW-AU_050 | Log Analytics workspace must send all security, audit and activity logs to immutable storage (What) within Data export settings (How) in order to provide tamper-proof and immutable data to adhere to compliance requirements (Why) | False | False | SoC related control: Will be implemented through policy at management group level. |
| 7. | AZU-LAW-SC_020 |  Non Azure services or applications connecting to a Log Analytics Workspace must enforce a minimum TLS version of 1.2 with HTTPS (What) via Service or application specific settings (How) in order to use modern techniques to establish robust encrypted data channels over untrusted networks (Why) | False | False | Control cannot be implemented by technical configuration. |

## SMCF Controls

| S. No. | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
| ------ | ----------------- | ----------------------| ------------------- | --------------------- | -------- |
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Mode) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model)| SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring)| SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policies<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Monitor Log Analytics workspace health](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/log-analytics-workspace-health)<br><br>[Cloud monitoring service level objectives](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives)<br><br>[Supported metrics for Microsoft.Monitor](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-monitor-accounts-metrics)|
| 5. | [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | True | This control is implemented by `Default` as Azure Monitor Logs availability zones are zone-redundant which means that Microsoft manages spreading service requests and replicating data across different zones in supported regions.<br><br>[Enhance data and service resilience in Azure Monitor Logs with availability zones](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/availability-zones) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard via based on application team requirement.<br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place.<br><br>[Monitor Log Analytics workspace health](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/log-analytics-workspace-health#permissions-required)<br><br>[Manage access to Log Analytics workspaces](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/manage-access?tabs=portal) |

## Changelog

- [azure-prdsvc-terraform-loganalyticsworkspace](CHANGELOG.md)

## References

### Microsoft Docs

- [Log Analytics Workspace](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/log-analytics-workspace-overview)
- [Log Analytics Data Export](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/logs-data-export?tabs=portal#overview)

### Terraform Docs

- [azurerm_log_analytics_workspace](https://registry.terraform.io/providers/hashicorp/azurerm/3.83.0/docs/resources/log_analytics_workspace)
- [azurerm_log_analytics_data_export_rule](https://registry.terraform.io/providers/hashicorp/azurerm/3.83.0/docs/resources/log_analytics_data_export_rule)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0 |
| <a name="requirement_azapi"></a> [azapi](#requirement_azapi) | >=1.9 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm) | >=4.33 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azapi"></a> [azapi](#provider_azapi) | >=1.9 |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | >=4.33 |

## Resources

| Name | Type |
|------|------|
| [azapi_resource.custom_table](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azurerm_log_analytics_data_export_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_data_export_rule) | resource |
| [azurerm_log_analytics_workspace.log_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_resource_only_permissions"></a> [allow_resource_only_permissions](#input_allow_resource_only_permissions) | (Optional) The resource permissions log for the Log Analytics workspace. | `bool` | `true` | no |
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_cmk_for_query_forced"></a> [cmk_for_query_forced](#input_cmk_for_query_forced) | (Optional) The cmk_for_query_forced for the Log Analytics workspace. | `bool` | `false` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_daily_quota_gb"></a> [daily_quota_gb](#input_daily_quota_gb) | (Optional) The daily quota in GB for the Log Analytics workspace. | `number` | `-1` | no |
| <a name="input_data_classification_tag_value"></a> [data_classification_tag_value](#input_data_classification_tag_value) | (Optional) The value of the data classification tag required by policy. | `string` | `""` | no |
| <a name="input_data_collection_rule_id"></a> [data_collection_rule_id](#input_data_collection_rule_id) | (Optional) The ID of the Data Collection Rule to use for this workspace. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_identity"></a> [identity](#input_identity) | (Optional) An identity block as defined below<br/>object({<br/>  type         = "(Required) Specifies the identity type of the Log Analytics Workspace. Possible values are SystemAssigned (where Azure will generate a Service Principal for you) and UserAssigned where you can specify the Service Principal IDs in the identity_ids field"<br/>  identity_ids = " (Optional) Specifies a list of user managed identity ids to be assigned. Required if type is UserAssigned"<br/>}) | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(set(string))<br/>  })</pre> | <pre>{<br/>  "identity_ids": null,<br/>  "type": "SystemAssigned"<br/>}</pre> | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_internet_ingestion_enabled"></a> [internet_ingestion_enabled](#input_internet_ingestion_enabled) | (Optional) The internet ingestion enabled for the Log Analytics workspace. | `bool` | `false` | no |
| <a name="input_internet_query_enabled"></a> [internet_query_enabled](#input_internet_query_enabled) | (Optional) The internet query enabled for the Log Analytics workspace. | `bool` | `false` | no |
| <a name="input_local_authentication_disabled"></a> [local_authentication_disabled](#input_local_authentication_disabled) | (Optional) Specifies whether to disable local authentication for the Log Analytics workspace. When set to true, enforces Azure AD (Entra ID) authentication only. | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_log_analytics_custom_tables"></a> [log_analytics_custom_tables](#input_log_analytics_custom_tables) | (Optional) A map of custom tables to create in the Log Analytics workspace.<br/>map(object({<br/>  description = "(Optional) Description of the custom table's purpose and usage."<br/>  restoredLogs = Optional(object({<br/>    endRestoreTime    = "(Required) The timestamp to end the restore by (UTC)."<br/>    sourceTable        = "(Required) The table to restore data from."<br/>    startRestoreTime   = "(Required) The timestamp to start the restore from (UTC)."<br/>  }))<br/>  columns = (Required)list(object({<br/>    name         = "(Required) The name of the column."<br/>    displayName  = "(Required) The display name of the column."<br/>    type         = "(Required) The data type of the column (e.g., 'string', 'datetime', 'int', 'real', 'boolean', 'guid', 'dynamic')."<br/>    description  = "(Optional) Description of the column's purpose."<br/>    dataTypeHint = "(Optional) Column data type logical hint. Valid values: 'armPath', 'guid', 'ip', 'uri'."<br/>  }))<br/>  searchResults = Optional(object({<br/>    description     = "(Required) Description of the search results configuration."<br/>    endSearchTime   = "(Required) The end time for search results in ISO 8601 format."<br/>    limit           = "(Required) The maximum number of search results to return."<br/>    query           = "(Required) The KQL query to execute for search results."<br/>    startSearchTime = "(Required) The start time for search results in ISO 8601 format."<br/>  }))<br/>  }))<br/>  retention_in_days    = "(Optional) The table retention period in days (4-4383, or -1 for default)."<br/>  total_retention_days = "(Optional) The total retention period in days (4-4383, or -1 for default)."<br/>  plan                 = "(Required) The table plan type. Valid values: 'Analytics', 'Basic'."<br/>})) | <pre>map(object({<br/>    description = optional(string, null)<br/>    restoredLogs = optional(object({<br/>      endRestoreTime   = string<br/>      sourceTable      = string<br/>      startRestoreTime = string<br/>    }), null)<br/>    columns = list(object({<br/>      name         = string<br/>      displayName  = string<br/>      type         = string<br/>      description  = optional(string, null)<br/>      dataTypeHint = optional(string, null)<br/>    }))<br/>    searchResults = optional(object({<br/>      description     = string<br/>      endSearchTime   = string<br/>      limit           = number<br/>      query           = string<br/>      startSearchTime = string<br/>    }), null)<br/>    retention_in_days    = optional(number, 365)<br/>    total_retention_days = optional(number, 365)<br/>    plan                 = string<br/>  }))</pre> | `{}` | no |
| <a name="input_log_analytics_data_export"></a> [log_analytics_data_export](#input_log_analytics_data_export) | (Optional)<br/>object({<br/>  name = (Required) The name of the Log Analytics Data Export Rule. Changing this forces a new Log Analytics Data Export Rule to be created.<br/>  table_names = (Required) A list of table names to export to the destination resource, for example: ["Heartbeat", "SecurityEvent"].<br/>  destination_resource_id = (Required) The destination resource ID. It should be a storage account, an event hub namespace or an event hub. If the destination is an event hub namespace, an event hub would be created for each table automatically.<br/>  enabled = (Optional) Is this Log Analytics Data Export Rule enabled? Possible values include true or false. Defaults to false.<br/>}) | <pre>object({<br/>    name                    = string<br/>    table_names             = list(string)<br/>    destination_resource_id = string<br/>    enabled                 = optional(bool)<br/>  })</pre> | `null` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_reservation_capacity_in_gb_per_day"></a> [reservation_capacity_in_gb_per_day](#input_reservation_capacity_in_gb_per_day) | (Optional) The reservation capacity in GB per day for the Log Analytics workspace. | `number` | `null` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_retention_in_days"></a> [retention_in_days](#input_retention_in_days) | (Optional) The retention in days for the Log Analytics workspace. | `number` | `365` | no |
| <a name="input_sku"></a> [sku](#input_sku) | (Optional) The SKU for the Log Analytics workspace. | `string` | `"PerGB2018"` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_custom_log_tables"></a> [custom_log_tables](#output_custom_log_tables) | n/a |
| <a name="output_export_rule_id"></a> [export_rule_id](#output_export_rule_id) | The resource ID of the created Data Export Rule. |
| <a name="output_export_rule_name"></a> [export_rule_name](#output_export_rule_name) | The name of the created Data Export Rule. |
| <a name="output_id"></a> [id](#output_id) | The resource ID of the Log Analytics Workspace. If a new Log Analytics Workspace is created, fetch its data id, if one is created, fetch the remote one instead. |
| <a name="output_log_analytics_data_id"></a> [log_analytics_data_id](#output_log_analytics_data_id) | The resource ID of the Log Analytics Data Export Rule. |
| <a name="output_log_analytics_data_resource"></a> [log_analytics_data_resource](#output_log_analytics_data_resource) | The Log Analytics Data Export Rule resource. |
| <a name="output_name"></a> [name](#output_name) | The name of the Log Analytics Workspace. |
| <a name="output_resource"></a> [resource](#output_resource) | The Log Analytics Workspace resource. |
| <a name="output_workspace_id"></a> [workspace_id](#output_workspace_id) | The Workspace (or Customer) ID for the Log Analytics Workspace. |
<!-- END_TF_DOCS -->
