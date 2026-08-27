---
version: 1.0.2
available_versions:
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.3.3
  - 0.3.2
---

<!-- BEGIN_TF_DOCS -->
# Monitor AutoScale Setting Module

## Overview

This terraform module creates an AutoScale Setting which can be applied to Virtual Machine Scale Sets, App Services and other scalable resources.

## Prerequisites

The target resources that requires autoscaling such as Virtual Machine Scale Sets, Azure Kubernetes Service, App Service should be in place.

## Guidance

#### Usage

- The maximum number of instances is also limited by the amount of Cores available in the subscription.
- All profile names must be unique (case insensitive).
- The allowed value of `metric_name` highly depends on the targeting resource type.
- Either of `fixed_date` or `recurrence` block can be specified in a Profile.

#### Security Considerations

## Security Controls

Currently, as per LSEG Approved `Monitor Autoscale Settings` Security requirements, there are no security controls for this product.

## Changelog

[azurerm_monitor_autoscale_setting](CHANGELOG.md)

## References

### Microsoft Docs
- [Official Documentation]
(https://learn.microsoft.com/en-us/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-autoscale-overview)
- [Supported metrics with Azure Monitor]
(https://learn.microsoft.com/en-gb/azure/azure-monitor/reference/supported-metrics/metrics-index)

### Terraform Docs
- [azurerm_monitor_autoscale_setting]
(https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting)

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
| [azurerm_monitor_autoscale_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_enabled"></a> [enabled](#input_enabled) | (Optional) Specifies whether automatic scaling is enabled for the target resource. Defaults to true | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_notification"></a> [notification](#input_notification) | (Optional) A notification block supports the following:<br/>webhook = (Optional) object({<br/>  service_uri = "(Required) The HTTPS URI which should receive scale notifications."<br/>  properties  = "(Optional) A map of settings."<br/>}) | <pre>object({<br/>    webhook = optional(object({<br/>      service_uri = string<br/>      properties  = optional(map(any))<br/>    }), null)<br/>  })</pre> | `null` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_predictive"></a> [predictive](#input_predictive) | (Optional) A predictive block supports the following:<br/>scale_mode      = "(Required) Specifies the predictive scale mode. Possible values are Enabled or ForecastOnly"<br/>look_ahead_time = "(Optional) Specifies the amount of time by which instances are launched in advance. It must be between PT1M and PT1H in ISO 8601 format." | <pre>object({<br/>    scale_mode      = string<br/>    look_ahead_time = optional(string)<br/>  })</pre> | <pre>{<br/>  "look_ahead_time": "PT5M",<br/>  "scale_mode": "Enabled"<br/>}</pre> | no |
| <a name="input_profile"></a> [profile](#input_profile) | (Required) A profile block supports the following:<br/>name     = "(Required) Specifies the name of the profile."<br/>capacity = (Required) object({<br/>  default = "(Required) The number of instances that are available for scaling if metrics are not available for evaluation. The default is only used if the current instance count is lower than the default. Valid values are between 0 and 1000."<br/>  maximum = "(Required) The maximum number of instances for this resource. Valid values are between 0 and 1000."<br/>  minimum = "(Required) The minimum number of instances for this resource. Valid values are between 0 and 1000."<br/>})<br/>rule = (Optional) list(object({<br/>  metric_trigger            = (Required) object({<br/>    metric_name             = "(Required) The name of the metric that defines what the rule monitors, such as Percentage CPU for Virtual Machine Scale Sets and CpuPercentage for App Service Plan."<br/>    metric_resource_id      = "(Required) The ID of the Resource which the Rule monitors."<br/>    operator                = "(Required) Specifies the operator used to compare the metric data and threshold. Possible values are: Equals, NotEquals, GreaterThan, GreaterThanOrEqual, LessThan, LessThanOrEqual."<br/>    statistic               = "(Required) Specifies how the metrics from multiple instances are combined. Possible values are Average, Max, Min and Sum."<br/>    time_aggregation        = "(Required) Specifies how the data that's collected should be combined over time. Possible values include Average, Count, Maximum, Minimum, Last and Total."<br/>    time_grain              = "(Required) Specifies the granularity of metrics that the rule monitors, which must be one of the pre-defined values returned from the metric definitions for the metric. This value must be between 1 minute and 12 hours an be formatted as an ISO 8601 string."<br/>    time_window             = "(Required) Specifies the time range for which data is collected, which must be greater than the delay in metric collection (which varies from resource to resource). This value must be between 5 minutes and 12 hours and be formatted as an ISO 8601 string."<br/>    threshold               = "(Required) Specifies the threshold of the metric that triggers the scale action."<br/>    metric_namespace        = "(Optional) The namespace of the metric that defines what the rule monitors, such as microsoft.compute/virtualmachinescalesets for Virtual Machine Scale Sets."<br/>    dimensions = (Optional) list(object({<br/>      name     = "(Required) The name of the dimension."<br/>      operator = "(Required) The dimension operator. Possible values are Equals and NotEquals. Equals means being equal to any of the values. NotEquals means being not equal to any of the values."<br/>      values   = "(Required) A list of dimension values."<br/>    }))<br/>    divide_by_instance_count = "(Optional) Whether to enable metric divide by instance count."<br/>  })<br/>  scale_action = (Required) object({<br/>    cooldown  = "(Required) The amount of time to wait since the last scaling action before this action occurs. Must be between 1 minute and 1 week and formatted as a ISO 8601 string."<br/>    direction = "(Required) The scale direction. Possible values are Increase and Decrease."<br/>    type      = "(Required) The type of action that should occur. Possible values are ChangeCount, ExactCount, PercentChangeCount and ServiceAllowedNextValue."<br/>    value     = "(Required) The number of instances involved in the scaling action."<br/>  })<br/>}))<br/>fixed_date = (Optional) object({<br/>  end      = "(Required) Specifies the end date for the profile, formatted as an RFC3339 date string."<br/>  start    = "(Required) Specifies the start date for the profile, formatted as an RFC3339 date string."<br/>  timezone = "(Optional) The Time Zone of the start and end times. A list of possible values can be found here. Defaults to UTC."<br/>})<br/>recurrence = (Optional) object({<br/>  timezone = "(Optional) The Time Zone used for the hours field. A list of possible values can be found here. Defaults to UTC."<br/>  days     = "(Required) A list of days that this profile takes effect on. Possible values include Monday, Tuesday, Wednesday, Thursday, Friday, Saturday and Sunday."<br/>  hours    = "(Required) A list containing a single item, which specifies the Hour interval at which this recurrence should be triggered (in 24-hour time). Possible values are from 0 to 23."<br/>  minutes  = "(Required) A list containing a single item which specifies the Minute interval at which this recurrence should be triggered."<br/>})) | <pre>list(object({<br/>    name = string<br/>    capacity = object({<br/>      default = number<br/>      maximum = number<br/>      minimum = number<br/>    })<br/>    rule = optional(list(object({<br/>      metric_trigger = object({<br/>        metric_name        = string<br/>        metric_resource_id = string<br/>        operator           = string<br/>        statistic          = string<br/>        time_aggregation   = string<br/>        time_grain         = string<br/>        time_window        = string<br/>        threshold          = number<br/>        metric_namespace   = optional(string)<br/>        dimensions = optional(list(object({<br/>          name     = string<br/>          operator = string<br/>          values   = list(string)<br/>        })), [])<br/>        divide_by_instance_count = optional(bool)<br/>      })<br/>      scale_action = object({<br/>        cooldown  = string<br/>        direction = string<br/>        type      = string<br/>        value     = string<br/>      })<br/>    })))<br/>    fixed_date = optional(object({<br/>      end      = string<br/>      start    = string<br/>      timezone = optional(string)<br/>    }), null)<br/>    recurrence = optional(object({<br/>      timezone = optional(string)<br/>      days     = list(string)<br/>      hours    = list(number)<br/>      minutes  = list(number)<br/>    }), null)<br/>  }))</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_target_resource_id"></a> [target_resource_id](#input_target_resource_id) | (Required) Specifies the resource ID of the resource that the autoscale setting should be added to. Changing this forces a new resource to be created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The Resource ID of the AutoScale Setting. |
| <a name="output_name"></a> [name](#output_name) | The Name of the AutoScale Setting. |
| <a name="output_resource"></a> [resource](#output_resource) | The AutoScale Setting resource. |
<!-- END_TF_DOCS -->
