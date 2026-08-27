---
version: 1.0.3
available_versions:
  - 1.0.3
  - 1.0.2
  - 1.0.1
  - 1.0.0
---

<!-- BEGIN_TF_DOCS -->
# Machine Learning Compute Instance module

## Overview

This terraform module creates a Machine learning compute Instance.

## What is a Compute Instance?

An Azure Machine Learning compute instance is a managed cloud-based workstation for data scientists. It provides a fully configured and managed development environment in the cloud for machine learning. Compute instances can be used as a development, training, or inference compute target for development and testing purposes.

### Development Environment

- **Interactive Development**: Ideal for data scientists who need a Jupyter notebook environment with pre-installed ML frameworks
- **Code Development**: Write, test, and debug machine learning code using integrated development tools
- **Experimentation**: Quickly prototype and experiment with different ML models and algorithms

### Training Workloads

- **Small to Medium Training Jobs**: Suitable for training machine learning models with moderate computational requirements
- **Prototyping**: Test training scripts before scaling to larger compute clusters
- **Quick Iterations**: Rapidly iterate on model development with immediate access to compute resources

### Inference and Testing

- **Model Testing**: Test and validate trained models in a controlled environment
- **Batch Inference**: Run batch predictions for testing purposes
- **API Development**: Develop and test REST APIs for model deployment

### Common Scenarios

- **Data Exploration**: Analyze and visualize datasets before model training
- **Feature Engineering**: Perform data preprocessing and feature extraction
- **Model Evaluation**: Assess model performance and compare different approaches
- **Collaborative Development**: Share notebooks and code with team members through the workspace

## Prerequisites

- Existing `Machine Learning Workspace`

## Guidance

#### Usage
- Once deployed, Compute Instance within machine learning workspace cannot be seen from the portal, as the public access for workspace is disabled.
- The Instance in the workspace should be accessed from the subnet used for creation of machine learning workspace private endpoint.

#### Security Considerations
- Machine learning compute can only be created within a machine learning workspace.

### Network Connectivity Requirements

- Raise appcon request from '<https://manage.appconn.refinitiv.com>'.

| Instance | URL | Protocol | Port |
|----------|-----|----------|------|
| Compute instance | graph.windows.net | TCP | 443 |
| Compute instance | *.instances.azureml.net | TCP | 443 |
| Compute instance | *.instances.azureml.ms | TCP | 443, 8787, 18881 |
| Compute instance | uksouth.tundra.azureml.ms | UDP | 5831 |
| Compute instance | *.uksouth.batch.azure.com | Any | 443 |
| Compute instance | *.uksouth.service.batch.azure.com | Any | 443 |

- Please make use of below providers in Appcon request to open above network flows with your Consumer (subnet). (Note : Below mentioned providers are uksouth region)
  - 51310-MLWorkspace-Computeintance-FQDN-uksouth
  - 51310-MLWorkspace-Computeintance-azureml

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-AMLW-IA_030 | Azure Machine Learning workspace compute must have local authentication methods disabled | Azure Machine Learning workspace compute must have local authentication methods disabled (What) within Studio compute settings (How) in order to use modern robust and less prone to compromise authentication methods embedded within Entra ID (Why) | True | True | Control implemented by setting the default value of `local authentication` as `false`.|
| 2. | AZU-AMLW-AC_030 | Azure Machine Learning workspace compute must not have a public IP | Azure Machine Learning workspace compute must not have a public IP (What) within Studio compute settings (How) in order to prevent unauthorised access and data exposure to the internet (Why) | True | True | Control implemented by setting `node_public_ip_enabled` value as `false`.|
| 3. | AZU-AMLW-SC_041 |Azure Machine Learning workspace compute clusters and instances must use a LSEG VNet for outbound access | Azure Machine Learning workspace compute clusters and instances must use a LSEG VNet for outbound access (What) via deployment settings, Private with Internet Outbound, Use my own virtual network (How) to reduce the likelihood of data loss (Why) | False | False | Control implemented by technical configuration setting: subnet_resource_id |
| 4. | AZU-AMLW-SC_042 |Azure Machine Learning workspace compute clusters and instances must enable existing virtual network use | Azure Machine Learning workspace compute clusters and instances must enable existing virtual network use (What) via Machine Learning Studio, Create Compute, Security, Enable virtual network (How) to reduce the likelihood of data loss (Why) | False | False | Control implemented by technical configuration setting: subnet_resource_id |

## Changelog

- [azure-prdsvc-terraform-machinelearningworkspace](../CHANGELOG.md)

## References

### Microsoft Docs

- [What is an Azure Machine Learning compute instance?](https://learn.microsoft.com/en-us/azure/machine-learning/concept-compute-instance?view=azureml-api-2)
- [Create a compute instance](https://learn.microsoft.com/en-us/azure/machine-learning/how-to-create-compute-instance?view=azureml-api-2)
- [Official Documentation](https://learn.microsoft.com/en-us/azure/machine-learning/overview-what-is-azure-machine-learning?view=azureml-api-2)

### Terraform Docs

- [machine_learning_compute_instance](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_compute_instance)

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
| [azurerm_machine_learning_compute_instance.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_compute_instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_assign_to_user"></a> [assign_to_user](#input_assign_to_user) | (Optional) A user that the compute instance is assigned to.<br/>object({<br/>  object_id = (Optional) The object ID of the user.<br/>  tenant_id = (Optional) The tenant ID of the user.<br/>}) | <pre>object({<br/>    object_id = optional(string)<br/>    tenant_id = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_authorization_type"></a> [authorization_type](#input_authorization_type) | (Optional) The Compute Instance Authorization type. Possible values include: personal. Changing this forces a new Machine Learning Compute Instance to be created. | `string` | `"personal"` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_description"></a> [description](#input_description) | (Optional) The description of the Machine Learning Compute Instance. Changing this forces a new Machine Learning Compute Instance to be created. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_identity"></a> [identity](#input_identity) | (Optional) An identity block as defined below<br/>type         = "(Required) The type of managed service identity that must be configured. The possible values are `SystemAssigned`, `UserAssigned` or `SystemAssigned, UserAssigned` (to enable both)."<br/>identity_ids = "(Optional) A list of user-assigned managed identity IDs to be assigned to this resource. This is required when `type` is set to `UserAssigned` or `SystemAssigned, UserAssigned`." | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | <pre>{<br/>  "identity_ids": [],<br/>  "type": "SystemAssigned"<br/>}</pre> | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_local_auth_enabled"></a> [local_auth_enabled](#input_local_auth_enabled) | (Optional) Enables local authentication methods for the compute instance. Changing this forces a new Machine Learning Compute Instance to be created. | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_machine_learning_workspace_id"></a> [machine_learning_workspace_id](#input_machine_learning_workspace_id) | (Required)  The ID of the Machine Learning Workspace. Changing this forces a new Machine Learning Compute Instance to be created. | `string` | n/a | yes |
| <a name="input_node_public_ip_enabled"></a> [node_public_ip_enabled](#input_node_public_ip_enabled) | (Optional) Whether the compute instance will have a public ip. | `bool` | `false` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_ssh"></a> [ssh](#input_ssh) | (Optional) SSH configuration for the compute instance.<br/>object({<br/>  public_key = (Required) SSH public key for the compute instance.<br/>}) | <pre>object({<br/>    public_key = string<br/>  })</pre> | `null` | no |
| <a name="input_subnet_resource_id"></a> [subnet_resource_id](#input_subnet_resource_id) | (Optional) Virtual network subnet resource ID the compute nodes belong to. Changing this forces a new Machine Learning Compute Instance to be created. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_virtual_machine_size"></a> [virtual_machine_size](#input_virtual_machine_size) | (Required) The Virtual Machine Size. Changing this forces a new Machine Learning Compute Instance to be created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The Resource ID of the Machine Learning Compute Instance. |
| <a name="output_name"></a> [name](#output_name) | The Name of the Machine Learning Compute Instance. |
| <a name="output_resource"></a> [resource](#output_resource) | The Machine Learning Compute Instance resource. |
<!-- END_TF_DOCS -->
