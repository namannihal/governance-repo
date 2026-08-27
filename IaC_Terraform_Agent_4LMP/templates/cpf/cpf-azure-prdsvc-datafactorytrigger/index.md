---
version: 1.0.1
available_versions:
  - 1.0.1
  - 1.0.0
  - 0.1.0
---

<!-- BEGIN_TF_DOCS -->
# Azure DataFactory Trigger module


## Overview

This Terraform module creates an Azure Data Factory Schedule Trigger. A Schedule Trigger in Azure Data Factory (ADF) is used to run pipelines automatically at a specific time or on a recurring schedule.

## Prerequisites

This module requires the following pre-existing dependent Azure resources:

- Resource Group, Virtual Network (both modules to be called if not existing, if allowed by the deployment permissions).
- Subnet to be used by the Key Vault Private endpoint.
- Network Security Group to be associated with the Subnet.
- Route Table to be associated with the Subnet.
- Key Vault for resource Customer Managed Key encryption.
- Private Endpoint to create a private connection to the Key Vault.
- User Assigned Identity leveraged for both identity and Customer Managed Key encryption.
- Data factory module required to create the datafactory linked service(<https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-datafactory>).
- Data factory Linked Service module required to create the datafactory datasets(<https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-datafactorylinkedservice>)
- Data factory Datasets module required to create the datafactory pipeline activities(<https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-datafactorydataset>)
- Data factory pipeline must be created first before creating the Data Factory Trigger Schedule module.(<https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-datafactorypipeline/>)

## Guidance

#### Usage

##### Azure Data Factory Schedule Trigger

- This module enables the creation of Azure Data Factory schedule triggers.
- A target Data Factory pipeline must exist before this trigger module is deployed.
- The trigger supports configured schedule settings such as frequency, interval, start time, and optional end time.
- Pipeline parameters can be passed through the trigger pipeline block to control runtime behavior.

## Security Controls

- There are no security controls for this product.

## Changelog

- [azure-prdsvc-terraform-datafactorydataset](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/data-factory/)
- [Datafactory Trigger](https://learn.microsoft.com/en-us/azure/data-factory/how-to-create-schedule-trigger?tabs=data-factory)

### Terraform Docs

- [azurerm_data_factory_trigger_schedule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_trigger_schedule)

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
| [azurerm_data_factory_trigger_schedule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_schedule_trigger_config"></a> [schedule_trigger_config](#input_schedule_trigger_config) | (Optional) Map of Data Factory Schedule Trigger configurations. Each trigger supports:<br/>data_factory_id: (Required) The Data Factory ID in which to associate the Linked Service with.<br/>description: (Optional) The Schedule Trigger's description.<br/>schedule: (Optional) A schedule block to specify the recurrence schedule with:<br/>  days_of_month: (Optional) Day(s) of the month (1-31). Monthly frequency only.<br/>  days_of_week: (Optional) Days of the week (e.g., ["Monday", "Friday"]). Weekly frequency only.<br/>  hours: (Optional) Hours of the day (0-23).<br/>  minutes: (Optional) Minutes of the hour (0-59).<br/>  monthly: (Optional) Monthly schedule with:<br/>    weekday: (Required) Day of the week (e.g., "Sunday").<br/>    week: (Optional) Week occurrence (-1 for last, 1-4 for specific week).<br/>start_time: (Optional) The time the Schedule Trigger will start (UTC). Defaults to current time.<br/>time_zone: (Optional) The timezone of the start/end time.<br/>end_time: (Optional) The time the Schedule Trigger should end (UTC).<br/>interval: (Optional) The interval for trigger occurrence. Defaults to 1.<br/>frequency: (Optional) Trigger frequency: Minute, Hour, Day, Week, Month. Defaults to Minute.<br/>activated: (Optional) Specifies if the trigger is activated. Defaults to true.<br/>pipeline: (Optional) List of pipeline blocks. Each block supports:<br/>  name: (Required) Reference pipeline name.<br/>  parameters: (Optional) Pipeline parameters.<br/>annotations: (Optional) List of tags for describing the trigger. | <pre>map(object({<br/>    data_factory_id = string<br/>    description     = optional(string)<br/>    schedule = optional(object({<br/>      days_of_month = optional(list(number))<br/>      days_of_week  = optional(list(string))<br/>      hours         = optional(list(number))<br/>      minutes       = optional(list(number))<br/>      monthly = optional(object({<br/>        weekday = string<br/>        week    = optional(number)<br/>      }))<br/>    }))<br/>    start_time = optional(string)<br/>    time_zone  = optional(string)<br/>    end_time   = optional(string)<br/>    interval   = optional(number, 1)<br/>    frequency  = optional(string, "Minute")<br/>    activated  = optional(bool, true)<br/>    pipeline = optional(list(object({<br/>      name       = optional(string)<br/>      parameters = optional(map(string))<br/>    })))<br/>    annotations = optional(list(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_triggerschedule_id"></a> [triggerschedule_id](#output_triggerschedule_id) | Map of Data Factory Schedule Trigger IDs. |
| <a name="output_triggerschedule_name"></a> [triggerschedule_name](#output_triggerschedule_name) | Map of Data Factory Schedule Trigger names. |
| <a name="output_triggerschedule_resource"></a> [triggerschedule_resource](#output_triggerschedule_resource) | Map of Data Factory Schedule Trigger resources. |
<!-- END_TF_DOCS -->
