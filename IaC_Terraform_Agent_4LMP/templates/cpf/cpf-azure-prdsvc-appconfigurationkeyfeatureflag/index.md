---
version: 1.0.2
available_versions:
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.1.1
  - 0.1.0
---

<!-- BEGIN_TF_DOCS -->
# Azure App Configuration Key and Featureflag module


## Overview

This Terraform module creates and configures the **Azure App Configuration keys and features**.

Azure App Configuration provides a service to centrally manage application settings and feature flags.This makes it easier to centrally configure distributed applications.

Azure App Configuration includes keys that store configuration data as key-values. Key-values provide a simple and flexible way for developers to represent application settings.

Azure App Configuration includes feature flags, which you can use to enable or disable a functionality, and variant feature flags, which allow multiple variations of a feature flag.A feature flag is a variable with a binary state of on or off.

For more information, refer to the [Azure App Configuration documentation](https://learn.microsoft.com/en-us/azure/azure-app-configuration/).

## Prerequisites

- Ensure that the following prerequisites are met:

  - `Resource Group`
  - `Virtual Network`
  - `Network Security Group`
  - `Subnet`
  - `Key Vault`
  - `Private Endpoint` for Key Vault
  - `Azure App Configuration Store`
  - `Private Endpoint` for App Configuration Store

## Guidance

#### Usage

- The `App Configuration Store ID` should be passed to the module to work with existing App Configuration stores and focus on key and feature flag management.
- Use `type = "kv"` for standard configuration settings with plain text or JSON values.
- Use `type = "vault"` to store sensitive values in Azure Key Vault and reference them securely.
- **Feature flags** are designed for testing multiple filters including percentage rollout, user targeting, group targeting, and time window constraints.
- Implement time-based feature rollouts with `timewindow_filter` for scheduled releases.
- Gradually roll out features using `percentage_filter_value` for controlled deployments.

- For a complete feature overview, refer to the [Azure App Configuration documentation](https://learn.microsoft.com/en-us/azure/azure-app-configuration/).

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. |  |  |  |  |  |  |

## Changelog

- [azure-prdsvc-terraform-appconfigurationkeyfeatureflag](CHANGELOG.md)

## References

### Microsoft Docs

[Azure App Configuration](https://learn.microsoft.com/en-us/azure/azure-app-configuration/)

### Terraform Docs

[Azure App Configuration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/app_configuration)

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
| [azurerm_app_configuration_feature.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_configuration_feature) | resource |
| [azurerm_app_configuration_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_configuration_key) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_appconfiguration_id"></a> [appconfiguration_id](#input_appconfiguration_id) | (Required) The ID of the App Configuration store where the keys will be created. | `string` | n/a | yes |
| <a name="input_config_keys"></a> [config_keys](#input_config_keys) | (Optional) A map of App Configuration keys to create.<br/><br/>Each key in the map represents a configuration entry with the following structure:<br/>map(object({<br/>  key                 = "(Required) The name of the App Configuration Key to create. Changing this forces a new resource to be created."<br/>  label               = "(Optional) The label of the App Configuration Key. Changing this forces a new resource to be created."<br/>  value               = "(Optional) The value of the App Configuration Key."<br/>  content_type        = "(Optional) The content type of the App Configuration Key."<br/>  locked              = "(Optional) Should this App Configuration Key be Locked to prevent changes. Defaults to false."<br/>  type                = "(Optional) The type of the App Configuration Key. It can either be kv (simple key/value) or vault (where the value is a reference to a Key Vault Secret). Defaults to kv."<br/>  vault_key_reference = "(Optional) The ID of the vault secret this App Configuration Key refers to. This should only be set when type is set to vault."<br/>})) | <pre>map(object({<br/>    key                 = string<br/>    label               = optional(string, null)<br/>    value               = optional(string, null)<br/>    content_type        = optional(string, null)<br/>    locked              = optional(bool, false)<br/>    type                = optional(string, "kv")<br/>    vault_key_reference = optional(string, null)<br/>  }))</pre> | `{}` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_feature_flags"></a> [feature_flags](#input_feature_flags) | (Optional) A map of App Configuration feature flags to create.<br/>map(object({<br/>  name                    = "(Required) The name of the App Configuration Feature. Changing this forces a new resource to be created."<br/>  key                     = "(Optional) The key of the App Configuration Feature. The value for name will be used if this is unspecified. Changing this forces a new resource to be created."<br/>  label                   = "(Optional) The label of the App Configuration Feature Flag. Changing this forces a new resource to be created."<br/>  enabled                 = "(Optional) The state of the Feature Flag. Defaults to false."<br/>  description             = "(Optional) The description of the Feature Flag."<br/>  locked                  = "(Optional) Should this App Configuration Feature Flag be Locked to prevent changes? Defaults to false."<br/>  percentage_filter_value = "(Optional) A number representing a percentage of the user base for which this feature should be enabled. Valid values are between 0 and 100."<br/>  targeting_filter = optional(object({<br/>    default_rollout_percentage = "(Required) A number representing a percentage of the user base for which this feature should be enabled by default."<br/>    groups = optional(list(object({<br/>      name               = "(Required) The name of the group."<br/>      rollout_percentage = "(Required) Percentage of the group for which the feature should be enabled."<br/>    })))<br/>    users = "(Optional) A list of users to target for this feature flag."<br/>  }))<br/>  timewindow_filter = optional(object({<br/>    start = "(Required) The start time of the time window. Should be in RFC3339 format."<br/>    end   = "(Required) The end time of the time window. Should be in RFC3339 format."<br/>  }))<br/>})) | <pre>map(object({<br/>    name                    = string<br/>    key                     = optional(string, null)<br/>    label                   = optional(string, null)<br/>    enabled                 = optional(bool, false)<br/>    description             = optional(string, null)<br/>    locked                  = optional(bool, false)<br/>    percentage_filter_value = optional(number, null)<br/>    targeting_filter = optional(object({<br/>      default_rollout_percentage = number<br/>      groups = optional(list(object({<br/>        name               = string<br/>        rollout_percentage = number<br/>      })))<br/>      users = optional(list(string))<br/>    }))<br/>    timewindow_filter = optional(object({<br/>      start = string<br/>      end   = string<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_configuration_feature_flag_ids"></a> [app_configuration_feature_flag_ids](#output_app_configuration_feature_flag_ids) | The IDs of the managed app configuration feature flags. |
| <a name="output_app_configuration_feature_flag_names"></a> [app_configuration_feature_flag_names](#output_app_configuration_feature_flag_names) | The names of the managed app configuration feature flags. |
| <a name="output_app_configuration_key_ids"></a> [app_configuration_key_ids](#output_app_configuration_key_ids) | The IDs of the managed app configuration keys. |
| <a name="output_app_configuration_key_names"></a> [app_configuration_key_names](#output_app_configuration_key_names) | The names of the managed app configuration keys. |
| <a name="output_resource_feature_flag"></a> [resource_feature_flag](#output_resource_feature_flag) | The azure app configuration feature flag resources (map of all feature flags). |
| <a name="output_resource_key"></a> [resource_key](#output_resource_key) | The azure app configuration key resources (map of all keys). |
<!-- END_TF_DOCS -->
