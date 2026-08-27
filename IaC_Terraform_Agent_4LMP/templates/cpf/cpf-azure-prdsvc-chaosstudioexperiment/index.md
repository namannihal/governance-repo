---
version: 2.0.2
available_versions:
  - 2.0.2
  - 2.0.1
  - 2.0.0
  - 1.2.1
  - 1.2.0
---

<!-- BEGIN_TF_DOCS -->
# Chaos Studio Experiment module


## Overview

This terraform module creates a Azure Chaos Studio  and associated resources. Azure Chaos Studio is a service that enables developers and engineers to perform chaos engineering experiments easily within their cloud environment.

## Prerequisites

- `Resource Group`
- `Key Vault`
- `Network Security Group`
- `Route Table`
- `Subnet`
- `Private Endpoint for KeyVault`
- `Role Assignment for KeyVault`
- `Proximity Placement Group for Windows Virtual Machine`
- `User Assigned Identity`
- `Key Vault Secret`
- `Windows Virtual Machine`

## Guidance

#### Usage

- This module creates 3 resources which together form `Azure Chaos Studio` and consists of
    - `Azure Chaos Studio Capability`
    - `Azure Chaos Studio Experiment`
    - `Azure Chaos Studio Target`
 - Possible `parameter` values can be found in this [documentation](https://learn.microsoft.com/en-gb/azure/chaos-studio/chaos-studio-fault-library)
 - The azurerm provider version `3.111.0 to 3.116.0` may encounter timeout issues for chaos studio. timeouts after 30 minutes saying it couldn't get the list of chaos capability types/target types. To avoid potential issues, consider using stable azurerm version `3.110.0`.

 - <b>IMPORTANT</b>:

  - Take into account the following limitations (https://learn.microsoft.com/en-us/azure/chaos-studio/chaos-studio-service-limits)

#### Security Considerations

 - When you attempt to control the ability to inject faults against a resource, the most important operation to restrict is` Microsoft.Chaos/experiments/start/action`. This operation starts a chaos experiment that injects faults.

 - A chaos experiment has a system-assigned managed identity or a user-assigned managed identity that executes faults on a resource. If you choose to use a system-assigned managed identity for your experiment, the identity is created at experiment creation time in your Microsoft Entra tenant. User-assigned managed identites may be used across any number of experiments.

 - Within a chaos experiment, you can choose to enable custom role assignment on either your system-assigned or user-assigned managed identity selection. Enabling this functionality allows Chaos Studio to create and assign a custom role containing any necessary experiment action capabilities to your experiment's identity (that do not already exist in your identity selection). If a chaos experiment is using a user-assigned managed identity, any custom roles assigned to the experiment identity by Chaos Studio will persist after experiment deletion.

 - If you choose to grant your experiment permissions manually, you must grant its identity appropriate permissions to all target resources. If the experiment identity doesn't have appropriate permission to a resource, it can't execute a fault against that resource.
 - Each resource must be onboarded to Chaos Studio as a target with corresponding capabilities enabled. If a target or the capability for the fault being executed doesn't exist, the experiment fails without affecting the resource.

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-CHAOS-AU_010 | Send all security and audit diagnostic log categories to a central SOC Log Analytics workspace | Chaos Studio must send all security and audit diagnostic logs to a central SOC Log Analytics workspace (What) within Experiments Diagnostic settings (How) in order to support a security investigation after a security incident (Why) | False | False | This control will be implemented by a DINE policy. |
| 2. | AZU-CHAOS-AU_030 | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval (What) within Diagnostic settings (How) in order to prevent sensitive data leakage to third parties outside of LSEG control (Why) | False | False | This control will be implemented via policy. |
| 3. | AZU-CHAOS-SC_010 | Ensure permissions to start Chaos Studio Experiments are removed from the custom contributor role | Ensure permissions to start Chaos Studio Experiments are removed from the custom contributor role (What) via custom role settings (How) to restrict Chaos Studio capabilities to a specific subset of users (Why) | False | False | Control cannot be implemented by technical configuration |
| 4. | AZU-CHAOS-SC_030 | Azure Chaos Studio Experiments must be removed once the experiment is completed | Azure Chaos Studio Experiments must be removed once the experiment is completed (What) by deleting the Azure Chaos Studio Experiment group (How) to prevent out of band invocation of experiments (Why) | False | False | Control cannot be implemented by technical configuration |

## Changelog

- [azure-prdsvc-terraform-chaosstudioexperiment](CHANGELOG.md)

## References

### Microsoft Docs

- [Azure Chaos Studio Documentation](https://learn.microsoft.com/en-us/azure/chaos-studio/)

### Terraform Docs

- [azurerm_chaos_studio_capability](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/chaos_studio_capability)
- [azurerm_chaos_studio_target](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/chaos_studio_target)
- [azurerm_chaos_studio_experiment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/chaos_studio_experiment)

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
| [azapi_resource.this](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource_action.exp_patch_tags](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource_action) | resource |
| [azurerm_chaos_studio_capability.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/chaos_studio_capability) | resource |
| [azurerm_chaos_studio_experiment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/chaos_studio_experiment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_chaos_studio_agent_target_mi"></a> [chaos_studio_agent_target_mi](#input_chaos_studio_agent_target_mi) | (Optional) The managed identity clientid, secret and tenantid to register the vm agent target<br/>{<br/>  clientId = "xxxxxxxxxxxxxxxxxxxxxxxxxx"<br/>  tenantId = "xxxxxxxxxxxxxxxxxxxxxxxxxx"<br/>  type     = "AzureManagedIdentity"<br/>} | `map(string)` | `{}` | no |
| <a name="input_chaos_studio_agent_target_subnetids"></a> [chaos_studio_agent_target_subnetids](#input_chaos_studio_agent_target_subnetids) | (Optional) The relay and container subnet id to register private aks target<br/>{<br/>  containerSubnetId = "/subscription/xxx/xxx/xxx/xx"<br/>  relaySubnetId     = "/subscription/xxx/xxx/xxx/xx"<br/>} | `map(string)` | `{}` | no |
| <a name="input_chaos_studio_capability_type"></a> [chaos_studio_capability_type](#input_chaos_studio_capability_type) | (Required) Type of the Capability for Azure Chaos Capability | `string` | n/a | yes |
| <a name="input_chaos_studio_target_enabled"></a> [chaos_studio_target_enabled](#input_chaos_studio_target_enabled) | (Optional) Whether the target registration is necessary or not. If a target has multiple capabilities it can be registered only once | `bool` | `false` | no |
| <a name="input_chaos_studio_target_id"></a> [chaos_studio_target_id](#input_chaos_studio_target_id) | (Optional) The chaos studio target id that is needed only when additional capabilities are needed for a already registered target | `string` | `""` | no |
| <a name="input_chaos_studio_target_resource_id"></a> [chaos_studio_target_resource_id](#input_chaos_studio_target_resource_id) | (Required) Resource ID of the Target Resource for Azure Chaos Target Resource | `string` | n/a | yes |
| <a name="input_chaos_studio_target_type"></a> [chaos_studio_target_type](#input_chaos_studio_target_type) | (Required) Type of the Target Resource for Azure Chaos Target Resource | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_identity"></a> [identity](#input_identity) | (Optional) An identity block as defined below<br/>object({<br/>  type         = "(Required) Specifies the type of Managed Service Identity that should be configured on this Windows Virtual Machine. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned` (to enable both)."<br/>  identity_ids = "(Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Windows Virtual Machine. This is required when `type` is set to `UserAssigned` or `SystemAssigned, UserAssigned`."<br/>}) | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(set(string))<br/>  })</pre> | <pre>{<br/>  "identity_ids": null,<br/>  "type": "SystemAssigned"<br/>}</pre> | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input_name) | (Required) Specifies the name which should be used for this Storage Mover. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_selectors"></a> [selectors](#input_selectors) | (Required) A selectors block supports the following:<br/># chaos_studio_target_ids = "(Required) A list of Chaos Studio Target IDs that should be part of this Selector."<br/>  selector_name           = "(Required) The name of this Selector." | <pre>map(object({<br/>    selector_name = string<br/>  }))</pre> | n/a | yes |
| <a name="input_steps"></a> [steps](#input_steps) | (Required) A map of Steps block supports the following:<br/>  object({<br/>  branch = (Required) A map of branch blocks as defined below:<br/>    object({<br/>      experiment_branch_name = "(Required) The name of the branch."<br/>      actions = (Required) A map of branch blocks as defined below:<br/>      object({<br/>        action_type   = "(Required) The type of action that should be added to the experiment. Possible values are `continuous`, `delay` and `discrete`."<br/>        duration      = "(Optional) An ISO8601 formatted string specifying the duration for a delay or continuous action."<br/>        parameters    = "(Optional) A key-value map of additional parameters to configure the action. The values that are accepted by this depend on the urn i.e. the capability/fault that is applied."<br/>        selector_name = "(Optional) The name of the Selector to which this action should apply to. This must be specified if the action_type is continuous or discrete."<br/>        urn           = "(Optional) The Unique Resource Name of the action, this value is provided by the azurerm_chaos_studio_capability resource e.g. azurerm_chaos_studio_capability.example.urn. This must be specified if the action_type is `continuous` or `discrete`."<br/>      })<br/>    })<br/>  experiment_step_name = "(Required) The name of the Step."<br/>}) | <pre>map(object({<br/>    branch = map(object({<br/>      experiment_branch_name = string<br/>      actions = map(object({<br/>        action_type   = string<br/>        duration      = optional(string)<br/>        parameters    = optional(map(any))<br/>        selector_name = optional(string)<br/>        urn           = optional(string)<br/>      }))<br/>    }))<br/>    experiment_step_name = string<br/>  }))</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_capability_id"></a> [capability_id](#output_capability_id) | The Resource ID of the Azure Chaos Studio. |
| <a name="output_capability_resource"></a> [capability_resource](#output_capability_resource) | The Azure Chaos Studio resource. |
| <a name="output_chaos_studio_experiment_id"></a> [chaos_studio_experiment_id](#output_chaos_studio_experiment_id) | The Resource ID of the Azure Chaos Studio. |
| <a name="output_chaos_studio_experiment_name"></a> [chaos_studio_experiment_name](#output_chaos_studio_experiment_name) | The Name of the Azure Chaos Studio. |
| <a name="output_chaos_studio_experiment_resource"></a> [chaos_studio_experiment_resource](#output_chaos_studio_experiment_resource) | The Azure Chaos Studio resource. |
| <a name="output_chaos_studio_target_id"></a> [chaos_studio_target_id](#output_chaos_studio_target_id) | The Resource ID of the Azure Chaos Studio Target. |
<!-- END_TF_DOCS -->
