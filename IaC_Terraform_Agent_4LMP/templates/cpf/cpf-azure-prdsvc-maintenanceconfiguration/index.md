---
version: 1.0.1
available_versions:
  - 1.0.1
  - 1.0.0
  - 0.1.1
  - 0.1.0
---

<!-- BEGIN_TF_DOCS -->
# __product name__ module


## Overview

This terraform module creates a Maintenance Configuration and associated resources.

## Prerequisites

- Create a resource group or use existing resource group to manage host groups.
- For scale sets to use Maintenance Configurations, they need to have automatic OS upgrades enabled.Patch orchestration for virtual machines needs to be set to AutomaticByPlatform.

## Guidance

#### Usage

- Maintenance configuration can be applied for virtual machines, virtual machine scale sets, dedicated hosts.
- Maintenance Configurations provides two scheduled patching modes for VMs in the guest scope: Static Mode and Dynamic Scope Mode. By default, the system operates in Static Mode if the Dynamic Scope Mode is not configured.
- Dynamic scope mode is optional, if enabled, it automatically selects the appropriate resources.
- Pre and Post events need to be configured separately. For more details check the 'pre and post events' document below.
- Use `EXtension` scope to handle VM extension updates, `Host` scope for infrastructure level updates, `InGuestPatch` scope to manage OS patching separately from infrastructure maintenance, `OSImage` scope for rollout of new OS images and updates for VMs, `SQLDB` and `SQLManagedInstance` scopes to control platform maintenance.

#### Additional Information

- Maintenance configuration can be assigned to individual resources or resource groups. Once assigned, the updates follow the defined schedule.
- Maintenance windows can be scheduled using a recurrence pattern based on: Daily, Weekly, or Monthly.
- Maintenance configurations are available only for certain VM sizes.
- Maintenance window have a maximum allowed duration.
- Configurations are region specific and may not be available in all the locations.
- Track the maintenance events using Azure monitor and Activity log.

## Security Controls

- Currently, as per LSEG Approved Dedicated Host Requirements, there are no security controls for this product.

## Changelog

- [azure-prdsvc-terraform-maintenanceconfiguration](CHANGELOG.md)

## References

### Microsoft Docs

- [Official documentation](https://learn.microsoft.com/en-us/azure/virtual-machines/maintenance-configurationss)
- [pre and post events](https://learn.microsoft.com/en-us/azure/update-manager/pre-post-scripts-overview?tabs=preevent)

### Terraform Docs

- [azurerm_maintenance_configuration](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/maintenance_configuration)

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
| [azurerm_maintenance_assignment_dynamic_scope.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/maintenance_assignment_dynamic_scope) | resource |
| [azurerm_maintenance_configuration.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/maintenance_configuration) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_context_suffix"></a> [context_suffix](#input_context_suffix) | (Optional) Application context suffix information for the resource(s) (max 3 chars). | `string` | `null` | no |
| <a name="input_dynamic_scope"></a> [dynamic_scope](#input_dynamic_scope) | dynamic_scope = "(Optional) A dynamic_scope object block variable to define the dynamic scope of the Maintenance Assignment.Only valid for InGuestPatch Maintenance Configuration Scopes."<br/>dynamic_scope = (Optional) object({<br/>  name                           = "(Required) The name which should be used for this Dynamic Maintenance Assignment. Changing this forces a new Dynamic Maintenance Assignment to be created. The name must be unique per subscription."<br/>  filter                         = "(Required) A filter object block to define the filter values for the dynamic scope as defined below."<br/>    locations                    = "(Optional) Specify a list of allowed locations for the VMs to be patched."<br/>    os_types                     = "(Optional) Specify a list of allowed OS types for the VMs to be patched."<br/>    resource_groups              = "(Optional) Specify a list of allowed resource groups for the VMs to be patched."<br/>    resource_types               = "(Optional) Specify a list of allowed resource types for the VMs to be patched."<br/>    tag_filter                   = "(Optional) Filter VMs by Any or All specified tags. Defaults to Any."<br/>    tags                         = "(Optional) A list object block to define the tags to filter by as defined below."<br/>      tag                        = "(Required) Specify the tag to filter by."<br/>      values                     = "(Required) Specify a list of values the defined tag can have."<br/>}) | <pre>object({<br/>    name = string<br/>    filter = object({<br/>      locations       = optional(list(string))<br/>      os_types        = optional(list(string))<br/>      resource_groups = optional(list(string))<br/>      resource_types  = optional(list(string))<br/>      tag_filter      = optional(string)<br/>      tags = optional(list(object({<br/>        tag    = string<br/>        values = list(string)<br/>      })))<br/>    })<br/>  })</pre> | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_in_guest_user_patch_mode"></a> [in_guest_user_patch_mode](#input_in_guest_user_patch_mode) | (Optional) The in guest user patch mode. Possible values are Platform or User. Must be specified when scope is InGuestPatch | `string` | `null` | no |
| <a name="input_install_patches"></a> [install_patches](#input_install_patches) | Install_patches = "(Optional) An install_patches object block variable to define the patching configuration, it must be specified when scope variable is set to InGuestPatch. Supports the following attributes:"<br/>install_patches = (Optional) object({<br/>  linux = "(Optional) A linux object block to define the patching configuration for Linux VMs as defined below."<br/>    classifications_to_include    = "(Optional) Specify the list of Classification category of patches to be patched. Possible values are Critical, Security and Other."<br/>    package_names_mask_to_exclude = "(Optional) Specify the list of package names to be excluded from patching."<br/>    package_names_mask_to_include = "(Optional) Specify the list of package names to be included for patching."<br/>  windows = "(Optional) A windows object block to define the patching configuration for Windows VMs as defined below."<br/>    classifications_to_include    = "(Optional) Specify the list of Classification category of patches to be patched. Possible values are Critical, Security, UpdateRollup, FeaturePack, ServicePack, Definition, Tools and Updates."<br/>    kb_numbers_to_exclude         = "(Optional) Specify the list of KB numbers to be excluded from patching."<br/>    kb_numbers_to_include         = "(Optional) Specify the list of KB numbers to be included for patching."<br/>  reboot = "(Optional) Specify the possible reboot preference, based on which it would be decided to reboot the machine or not after the patch operation is completed. Possible values are Always, IfRequired and Never."<br/>}) | <pre>object({<br/>    linux = optional(object({<br/>      classifications_to_include    = optional(list(string))<br/>      package_names_mask_to_exclude = optional(list(string))<br/>      package_names_mask_to_include = optional(list(string))<br/>    }))<br/>    windows = optional(object({<br/>      classifications_to_include = optional(list(string))<br/>      kb_numbers_to_exclude      = optional(list(string))<br/>      kb_numbers_to_include      = optional(list(string))<br/>    }))<br/>    reboot = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_properties"></a> [properties](#input_properties) | (Optional) A mapping of properties to assign to the resource. | `map(any)` | `{}` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_scope"></a> [scope](#input_scope) | (Required) The scope of the Maintenance Configuration. Possible values are Extension, Host, InGuestPatch, OSImage, SQLDB or SQLManagedInstance. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_visibility"></a> [visibility](#input_visibility) | (Optional) The visibility of the Maintenance Configuration. The only allowable value is Custom. | `string` | `"Custom"` | no |
| <a name="input_window"></a> [window](#input_window) | window = (Optional) A window object block variable to define the maintenance window schedule. It supports the following attributes:<br/>window = (Optional) object({<br/>  start_date_time      = "(Required) The effective start date of the maintenance window in YYYY-MM-DD hh:mm format."<br/>  expiration_date_time = "(Optional) The effective expiration date of the maintenance window in YYYY-MM-DD hh:mm format."<br/>  duration             = "(Optional) The duration of the maintenance window in HH:mm format."<br/>  time_zone            = "(Required) The time zone for the maintenance window. A list of timezones can be obtained by executing [System.TimeZoneInfo]::GetSystemTimeZones() in PowerShell."<br/>  recur_every          = "(Optional) The rate at which a maintenance window is expected to recur. The rate can be expressed as daily, weekly, or monthly schedules."<br/>}) | <pre>object({<br/>    start_date_time      = string<br/>    expiration_date_time = optional(string)<br/>    duration             = optional(string)<br/>    time_zone            = string<br/>    recur_every          = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The Resource ID of the Maintenance Configuration. |
| <a name="output_name"></a> [name](#output_name) | The Name of the Maintenance Configuration. |
| <a name="output_resource"></a> [resource](#output_resource) | The Maintenance Configuration resource. |
<!-- END_TF_DOCS -->
