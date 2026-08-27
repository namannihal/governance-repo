---
version: 2.0.3
available_versions:
  - 2.0.3
  - 2.0.2
  - 2.0.1
  - 2.0.0
  - 1.0.1
---

<!-- BEGIN_TF_DOCS -->
# Machine Learning Compute Cluster module

## Overview

This terraform module creates a Machine learning compute cluster.

## Prerequisites
- Exisiting `resource_group` and `virtual_network`
- One `user_assign_identity` to encypt storage account data.
- One `key_vault` to store the encryption key.
- dependent resource for machine learning workspace
  - `storage_account`
  - `app_insight`
  - `container_registry`
- Private endpoint for the below resource,
  - `private_endpoint_key_vault`
  - `private_endpoint_storage_account_file_share`
  - `private_endpoint_container_registry`
  - `private_endpoint_machine_learning_workspace`
- One `subnet` to configure private endpoint.
- One `network_security_group`to associate with the subnet
- Multiple `time_sleep` to wait for creation of DNS record post private endpoint deployment through DINE policy.
- One `route table`
- One `Log analytics workspace` for `App Insight configuration`.
- One `Machine learing workspace`

## Guidance
#### Usage
- Once deployed, Cluster within machine learning workspace cannot be seen from the portal, as the public access for workspace is disabled.
- The cluster in the workspace should be accessed from the subnet used for creation of machine learning workspace private endpoint.

#### Security Considerations
- Machine learning compute can only be created within a machine learning workspace.

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-AMLW-IA_030 | Azure Machine Learning workspace compute must have local authentication methods disabled | Azure Machine Learning workspace compute must have local authentication methods disabled (What) within Studio compute settings (How) in order to use modern robust and less prone to compromise authentication methods embedded within Entra ID (Why) | True | True | Control implemented by setting the default value of `local authentication` as `false`.|
| 2. | AZU-AMLW-AC_030 | Azure Machine Learning workspace compute must not have a public IP | Azure Machine Learning workspace compute must not have a public IP (What) within Studio compute settings (How) in order to prevent unauthorised access and data exposure to the internet (Why) | True | True | Control implemented by setting `node_public_ip_enabled` value as `false`.|
| 17. | AZU-AMLW-SI_010 | Azure Machine Learning workspace compute must be kept to within n-2 versions | Azure Machine Learning workspace compute must be kept to within n-2 versions (What) within Studio compute, reprovision (How) in order to keep up to date with vulnerability remediations (Why) | False | False | Control implemented by technical configuration setting: False |

## Changelog

- [azure-prdsvc-terraform-machinelearningworkspace](../CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/machine-learning/overview-what-is-azure-machine-learning?view=azureml-api-2)

### Terraform Docs

- [machine_learning_compute_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_compute_cluster)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0 |
| <a name="requirement_azapi"></a> [azapi](#requirement_azapi) | >= 1.9 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm) | >=4.33 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | >=4.33 |

## Resources

| Name | Type |
|------|------|
| [azurerm_machine_learning_compute_cluster.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_compute_cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s). | `string` | `null` | no |
| <a name="input_description_compute_instance"></a> [description_compute_instance](#input_description_compute_instance) | (Optional) The description of the Machine Learning Compute Instance. | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_identity_ids"></a> [identity_ids](#input_identity_ids) | (Optional) The list of identity ids | `list(string)` | `null` | no |
| <a name="input_identity_type"></a> [identity_type](#input_identity_type) | (Optional) The type of the identity | `string` | `"SystemAssigned"` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type. | `string` | `null` | no |
| <a name="input_local_auth_enabled"></a> [local_auth_enabled](#input_local_auth_enabled) | (Optional) Should local authentication be enabled? Defaults to false. | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_machine_learning_workspace_id"></a> [machine_learning_workspace_id](#input_machine_learning_workspace_id) | (Required) The id of the machine learning workspace | `string` | n/a | yes |
| <a name="input_max_node_count"></a> [max_node_count](#input_max_node_count) | (Required) Maximum node count. Changing this forces a new Machine Learning Compute Cluster to be created. | `number` | n/a | yes |
| <a name="input_min_node_count"></a> [min_node_count](#input_min_node_count) | (Required) Minimal node count. Changing this forces a new Machine Learning Compute Cluster to be created. | `number` | n/a | yes |
| <a name="input_node_public_ip_enabled"></a> [node_public_ip_enabled](#input_node_public_ip_enabled) | (Optional) Should nodes have public IP addresses enabled? Defaults to false. | `bool` | `false` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_scale_down_nodes_after_idle_duration"></a> [scale_down_nodes_after_idle_duration](#input_scale_down_nodes_after_idle_duration) | (Required) Node Idle Time Before Scale Down: defines the time until the compute is shutdown when it has gone into Idle state. Is defined according to W3C XML schema standard for duration. | `string` | n/a | yes |
| <a name="input_ssh"></a> [ssh](#input_ssh) | (Optional) An ssh block as defined below.<br/>object({<br/>  admin_username = (Required) Name of the administrator user account which can be used to SSH to nodes. Changing this forces a new Machine Learning Compute Cluster to be created.<br/>  admin_password = (Optional) Password of the administrator user account. Changing this forces a new Machine Learning Compute Cluster to be created.<br/>  key_value      = (Optional) SSH public key of the administrator user account. Changing this forces a new Machine Learning Compute Cluster to be created.<br/>}) | <pre>object({<br/>    admin_username = string<br/>    admin_password = string<br/>    key_value      = string<br/>  })</pre> | `null` | no |
| <a name="input_ssh_public_access_enabled"></a> [ssh_public_access_enabled](#input_ssh_public_access_enabled) | (Optional) Should SSH public access be enabled? Defaults to false. | `bool` | `false` | no |
| <a name="input_subnet_resource_id"></a> [subnet_resource_id](#input_subnet_resource_id) | (Optional) Virtual network subnet resource ID the compute nodes belong to. | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_vm_priority"></a> [vm_priority](#input_vm_priority) | (Required) The priority of the VM. Changing this forces a new Machine Learning Compute Cluster to be created. Accepted values are Dedicated and LowPriority. | `string` | n/a | yes |
| <a name="input_vm_size"></a> [vm_size](#input_vm_size) | (Required) The Virtual Machine Size. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The Resource ID of the Machine Learning Compute Cluster. |
| <a name="output_name"></a> [name](#output_name) | The Name of the Machine Learning Compute Cluster. |
| <a name="output_resource"></a> [resource](#output_resource) | The Machine Learning Compute Cluster resource. |
<!-- END_TF_DOCS -->
