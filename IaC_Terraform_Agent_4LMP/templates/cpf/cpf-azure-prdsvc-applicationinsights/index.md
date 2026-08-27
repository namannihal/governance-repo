---
version: 1.0.3
available_versions:
  - 1.0.3
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.5.4
---

<!-- BEGIN_TF_DOCS -->
# Application Insights Module

## Overview

This terraform module creates an Application Insights and associated resources.

## Prerequisites
- The followoing dependencies must be existing before deploying an Application Insights resource. That includes:
  - `Resource Group` (To be called if not existing).
  - `User Assigned Identity` to be leveraged for Application Insights resource.
  - `Log Analytics Workspace` to be associated with Application Insights resource.

## Guidance

#### Usage

AzureRM 4.x Upgrade Notes for Application Insights

Impact analysis -- Low

No impact for existing users as there are no major changes.

The following are changes in the 4.x upgrade. However, in our configuration, we already have these values set:

  - The `daily_data_cap_in_gb` property now defaults to `100`.
  - The `daily_data_cap_notifications_disabled` property now defaults to `false`.

Wiki link for [AzureRM 4.x Upgrade](https://gitlab.dx1.lseg.com/groups/app/app-51310/azure/prdsvc/terraform/-/wikis/Terraform-AzureRM-Provider-Upgrade:-Version-3.x-to-4.x/Application-Insights) for details on the upgrade process.

For more details, refer to the official [AzureRM 4.x Upgrade Guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide#azurerm_application_insights)

- `workspace_id` can not be removed after set. More details can be found at [Migrate to workspace-based Application Insights resources](https://learn.microsoft.com/en-us/azure/azure-monitor/app/convert-classic-resource#migration-process).

#### Security Considerations

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-AIS-IA_010 | Azure Application Insights resources must have local authentication methods disabled | Application Insights resources should have local authentication methods disabled (What) within configure Properties settings (How) in order to use modern robust and less prone to compromise authentication methods embedded within Entra ID (Why) | True | False | This control can be implemented using the `local_authentication_disabled` variable set to `true`. However, since local authentication is required for certain applications, the control has been parameterized, and therefore, the test case has been removed. |
| 2. | AZU-AIS-IA_020 | LSEG developed application instrumentation must use Entra ID Managed Identities to authenticate to Monitor for Application Insights | LSEG developed application instrumentation must use Entra ID Managed Identities to authenticate to Monitor for Application Insights (What) by using a managed identity assigned to the monitoring metrics publisher role (How) in order to use modern robust and less prone to compromise authentication methods embedded within Entra ID (Why) | True | True | This control is implemented via managed identity and passing the pricipal ID to assign it the `Monitoring Metrics Publisher` over the Application Insights resource created. |

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames)<br><br>[Azure Monitor Naming Rules & Restrictions](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules#microsoftinsights) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Data Collection Basics of Azure Monitor Application Insights](https://learn.microsoft.com/en-us/azure/azure-monitor/app/opentelemetry-overview?tabs=aspnetcore)<br><br>[Cloud monitoring service level objectives](https://learn.microsoft.com/en-us/azure/api-management/api-management-howto-use-azure-monitor#service-level-objectives)<br><br>[Supported Metrics for Application Insights](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-insights-components-metrics) |
| 5. | [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | True | This control is implemented by creating a `Log Analytics Workspace` to be linked to the App Insights resource.<br><br>[Enhance data and service resilience in Azure Monitor Logs with availability zones](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/availability-zones) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json)<br><br> |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place.<br><br>[Resources, roles, and access control in Application Insights](https://learn.microsoft.com/en-us/azure/azure-monitor/roles-permissions-security)<br><br> |

## Changelog
[azure-prdsvc-terraform-appinsights](CHANGELOG.md)

## References

### Microsoft Docs
- [Official Documentation](https://learn.microsoft.com/en-us/azure/azure-monitor/app/app-insights-overview)

### Terraform Docs
- [azurerm_application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights)

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
| [azurerm_application_insights.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) | resource |
| [azurerm_application_insights_api_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights_api_key) | resource |
| [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_key_enabled"></a> [api_key_enabled](#input_api_key_enabled) | (Optional) Should api key created or skip as per input. | `bool` | `true` | no |
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_application_type"></a> [application_type](#input_application_type) | (Required) Specifies the type of Application Insights to create. Changing this forces a new resource to be created | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_daily_data_cap_in_gb"></a> [daily_data_cap_in_gb](#input_daily_data_cap_in_gb) | (Optional) Specifies the Application Insights component daily data volume cap in GB. | `number` | `100` | no |
| <a name="input_daily_data_cap_notifications_disabled"></a> [daily_data_cap_notifications_disabled](#input_daily_data_cap_notifications_disabled) | (Optional) Specifies if a notification email will be send when the daily data volume cap is met. | `bool` | `true` | no |
| <a name="input_disable_ip_masking"></a> [disable_ip_masking](#input_disable_ip_masking) | (Optional) Disables masking and log the real client IP. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_force_customer_storage_for_profiler"></a> [force_customer_storage_for_profiler](#input_force_customer_storage_for_profiler) | (Optional) Should the Application Insights component force users to create their own storage account for profiling? | `bool` | `false` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_internet_ingestion_enabled"></a> [internet_ingestion_enabled](#input_internet_ingestion_enabled) | (Optional) Should the Application Insights component support querying over the Public Internet? | `bool` | `true` | no |
| <a name="input_internet_query_enabled"></a> [internet_query_enabled](#input_internet_query_enabled) | (Optional) Should the Application Insights component support querying over the Public Internet? | `bool` | `true` | no |
| <a name="input_local_authentication_disabled"></a> [local_authentication_disabled](#input_local_authentication_disabled) | (Optional) Disable Non-Azure AD based Auth. Defaults to false. | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_read_permissions"></a> [read_permissions](#input_read_permissions) | (Optional) Specifies the list of read permissions granted to the API key. Valid values are agentconfig, aggregate, api, draft, extendqueries, search. Please note these values are case sensitive. Changing this forces a new resource to be created. | `list(string)` | <pre>[<br/>  "agentconfig",<br/>  "aggregate",<br/>  "api",<br/>  "draft",<br/>  "extendqueries",<br/>  "search"<br/>]</pre> | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_retention_in_days"></a> [retention_in_days](#input_retention_in_days) | (Optional) Specifies the retention period in days. | `number` | `90` | no |
| <a name="input_sampling_percentage"></a> [sampling_percentage](#input_sampling_percentage) | (Optional) Specifies the percentage of the data produced by the monitored application that is sampled for Application Insights telemetry. | `number` | `100` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_uai_principal_id"></a> [uai_principal_id](#input_uai_principal_id) | (Required) Principal id of the User Assigned Identity which should be used be assigned the Monitoring Metrics Publisher role | `string` | n/a | yes |
| <a name="input_workspace_id"></a> [workspace_id](#input_workspace_id) | (Optional) Specifies the id of a log analytics workspace resource | `string` | `null` | no |
| <a name="input_write_permissions"></a> [write_permissions](#input_write_permissions) | (Optional) Specifies the list of write permissions granted to the API key. Valid values are annotations. Please note these values are case sensitive. Changing this forces a new resource to be created. | `list(string)` | <pre>[<br/>  "annotations"<br/>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_key"></a> [api_key](#output_api_key) | The api_key of the Application Insights. |
| <a name="output_id"></a> [id](#output_id) | The Resource ID of the Application Insights. |
| <a name="output_name"></a> [name](#output_name) | The Name of the Application Insights. |
| <a name="output_resource"></a> [resource](#output_resource) | The Application Insights resource. |
<!-- END_TF_DOCS -->
