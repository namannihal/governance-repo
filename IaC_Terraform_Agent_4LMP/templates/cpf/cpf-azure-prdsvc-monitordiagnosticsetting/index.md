---
version: 1.0.1
available_versions:
  - 1.0.1
  - 1.0.0
  - 0.2.3
  - 0.2.2
  - 0.2.1
---

<!-- BEGIN_TF_DOCS -->
# Azure Monitor Diagnostic Setting module

## Overview

This terraform module creates a `azurerm_monitor_diagnostic_setting` and associated resources like Diagnostic Log. Diganostic/Resource log is enabled at specified resource levels.

## Prerequisites

- An existing `Resource Group`

## Guidance

#### Usage

- This module deploys the diagnostics setting for a particular resource and sends the log and metric data to an Azure Storage Account, Azure Event Hub and an Azure Log Analytics Workspace.
- The storage account to which the diagnostics logs data to be sent must be in the same region as to the resource for which it is collecting the diagnostics data.
- A single diagnostic setting can define no more than one of each of the destinations. If we need to send data to more than one of a particular destination type (for example, two different Log Analytics workspaces), then create multiple settings. Each resource can have up to 5 diagnostic settings.

###### AzureRM 3.x to 4.x Upgrade Notes for Monitor Diagnostic Setting

Product Impact -- MEDIUM

Users in azurerm 3.x migrating to 4.x need to perform the following changes:
  - **BREAKING CHANGE:** Removed deprecated retention arguments (`diag_log_retention_days` and `metric_retention_days`) from the `diagnostics_resource_ids` variable as retention policies are deprecated in Azure RM 4.0+. Retention policies should now be configured at the destination level (Storage Account, Log Analytics Workspace, etc.) rather than at the diagnostic setting level.

  - Wiki link for [AzureRM Provider >= 4.33 Upgrade](https://gitlab.dx1.lseg.com/groups/app/app-51310/azure/prdsvc/terraform/-/wikis/Terraform-AzureRM-Provider-Upgrade:-Version-3.x-to-4.x/MonitorDiagnosticSetting) for details on the upgrade process.

For more details, refer to the official [AzureRM 4.x Upgrade Guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide)

#### Security Considerations

#### Additional Information

- Multiple Inputs can be provided for Diagnostic Logs as per below ways:

```
# Key = westeurope1
westeurope1 = {
    diagnostics_resource_ids = {
        target_resource_id             = module.azure-prdsvc-terraform-keyvault.id
        storage_account_id             = "${data.azurerm_subscription.current.id}/resourceGroups/${module.azure-prdsvc-terraform-resourcegroup.name}/providers/Microsoft.Storage/storageAccounts/${module.azure-prdsvc-terraform-storageaccount.name}"
        log_analytics_workspace_id     = try(module.azure-prdsvc-terraform-loganalyticsworkspace.id, "null")
        eventhub_name                  = try(module.azure_prdsvc_terraform_eventhub.name, "null")
        eventhub_authorization_rule_id = null
        metric_enabled                 = true
    }
  }

# Key = westeurope2
westeurope2 = {
    diagnostics_resource_ids = {
        target_resource_id             = //ENTER THE RESOURCE ID
        storage_account_id             = "${data.azurerm_subscription.current.id}/resourceGroups/${module.azure-prdsvc-terraform-resourcegroup.name}/providers/Microsoft.Storage/storageAccounts/${module.azure-prdsvc-terraform-storageaccount.name}"
        log_analytics_workspace_id     = try(module.azure-prdsvc-terraform-loganalyticsworkspace.id, "null")
        eventhub_name                  = try(module.azure_prdsvc_terraform_eventhub.name, "null")
        eventhub_authorization_rule_id = null
        metric_enabled                 = true
    }
  }
```

## Security Controls

- There are no security controls to be implemented.

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy. |
| 5. | [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | True | This control is implemented by `Default` as Azure Monitor Logs availability zones are zone-redundant which means that Microsoft manages spreading service requests and replicating data across different zones in supported regions. <br><br>[Enhance data and service resilience in Azure Monitor Logs with availability zones ](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/availability-zones) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place. <br><br>[Roles, permissions, and security in Azure Monitor  ](https://learn.microsoft.com/en-us/azure/azure-monitor/roles-permissions-security) |

## Changelog

[azure-prdsvc-terraform-monitordiagnosticsetting](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/azure-monitor/overview)

### Terraform Docs

- [azurerm_monitor_diagnostic_setting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting)
- [azurerm_eventhub_namespace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace_authorization_rule)
- [azurerm_monitor_diagnostic_categories](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories)

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
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_diagnostic_categories.amds_diag_catg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_diagnostics_resource_ids"></a> [diagnostics_resource_ids](#input_diagnostics_resource_ids) | "(Required) The map of diagnostics arguments required to configure Diagnostic Settings:<br/>object({<br/>  target_resource_id             = "(Required) The ID of the resource for which to enable the diagnostic setting."<br/>  storage_account_id             = "(Optional) Specifies the id of a Storage Account where Diagnostics Data should be sent."<br/>  log_analytics_workspace_id     = "(Optional) Specifies the id of a Log Analytics Workspace."<br/>  eventhub_name                  = "(Optional) Name of the EventHub."<br/>  eventhub_authorization_rule_id = "(Optional) Event Hub Authorizaation ID."<br/>  metric_enabled                 = "(Optional) Specifies if metrics enabled or not."<br/>}) | <pre>object({<br/>    target_resource_id             = string<br/>    storage_account_id             = optional(string, null)<br/>    log_analytics_workspace_id     = optional(string, null)<br/>    eventhub_name                  = optional(string, null)<br/>    eventhub_authorization_rule_id = optional(string, null)<br/>    metric_enabled                 = optional(bool, true)<br/>  })</pre> | n/a | yes |
| <a name="input_enabled_log_category_group"></a> [enabled_log_category_group](#input_enabled_log_category_group) | (Optional) The name of a Diagnostic Log Category Group for this Resource. If set, only category_group will be used in enabled_log block; otherwise, all available categories will be used. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_log_analytics_destination_type"></a> [log_analytics_destination_type](#input_log_analytics_destination_type) | (Optional) Specifies the destination type for Log Analytics. Use 'Dedicated' for resource-specific tables or 'AzureDiagnostics' for the default table. | `string` | `"AzureDiagnostics"` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The Resource ID of the Diagnostic Setting for Azure resources. |
| <a name="output_name"></a> [name](#output_name) | The Name of the Diagnostic Setting. |
| <a name="output_resource"></a> [resource](#output_resource) | The Diagnostic Setting resource. |
<!-- END_TF_DOCS -->
