---
version: 1.0.1
available_versions:
  - 1.0.1
  - 1.0.0
  - 0.1.0
---

<!-- BEGIN_TF_DOCS -->
# Azure DataFactory Pipeline module


## Overview

This terraform module creates a Azure DataFactory Pipeline.Azure Data Factory (ADF) pipelines are the core orchestration units that allow you to group activities, schedule workflows, move data, and transform data.

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
- Data factory Datasets module required to create the datafactory pipeline activit i es(<https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-datafactorydataset>)

## Guidance

#### Usage

##### Azure Data Factory Pipelines

- This module enables the creation of `Azure Data Factory pipelines`.
- Pipelines must reference existing datasets and linked services .  
- Each activity can reference datasets for input and output operations, enabling end-to-end data movement and transformation scenarios.

#### Security Considerations

#### Additional Information

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-DF-SC_040 | Data Factory Pipelines must not be used to move or copy data to a location outside the classification ceiling | Azure Data Factory must not be used to move or copy data to a location that is not within the data classification ceiling (What) within the Pipeline activities Linked Services (How) to ensure data is kept within locations that have been approved for such classification and to reduce the risk of data exfiltration (Why) | False | False | This control cannot be implemented by technical configuration setting. |
| 2. | AZU-DF-SC_050 | Pipeline activities must use secure configuration for secrets | Activities in pipelines containing secrets must set those as SecureInput/SecureOutput (What) in the General properties (How) so that the secret is not exposed in the console or logs (Why) | False | False |This control cannot be implemented by technical configuration setting. |
| 3. | AZU-DF-SC_080 | It must not be possible to associate Pipeline Activities with the runtime AutoResolveIntegrationRuntime | It must not be possible to associate Pipeline Activities with the runtime AutoResolveIntegrationRuntime (What) within the Activity settings (How) to ensure activities and pipelines are run on infrastructure that is owned and managed by LSEG to reduce the risk of data exfiltration (Why) | False | False | This control is implemented via policy. |
| 4. | AZU-DF-SC_110 | Pipelines must use parameters of SecureString type for secrets | Parameters in pipelines containing secrets must be of type SecureString (What) in the Parameters page of a Pipeline (How) so that the secret is not exposed within the console or logs (Why) | False | False | This control cannot be implemented by technical configuration setting. |

## Changelog

- [azure-prdsvc-terraform-datafactorypipeline](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/data-factory/)
- [Datafactory Pipelines](https://learn.microsoft.com/en-us/azure/data-factory/concepts-pipelines-activities?tabs=data-factory)

### Terraform Docs

- [azurerm_data_factory_pipeline](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_pipeline)

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
| [azurerm_data_factory_pipeline.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_pipeline) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_activities_json"></a> [activities_json](#input_activities_json) | (Optional) A JSON object that contains the activities that will be associated with the Data Factory Pipeline. | `string` | `null` | no |
| <a name="input_annotations"></a> [annotations](#input_annotations) | (Optional) List of tags that can be used for describing the Data Factory Pipeline. | `list(string)` | `null` | no |
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_concurrency"></a> [concurrency](#input_concurrency) | (Optional) The max number of concurrent runs for the Data Factory Pipeline. Must be between 1 and 50. | `number` | `null` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_data_factory_id"></a> [data_factory_id](#input_data_factory_id) | (Required) The Data Factory ID in which to associate the Pipeline with. Changing this forces a new resource. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input_description) | (Optional) The description for the Data Factory Pipeline. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_folder"></a> [folder](#input_folder) | (Optional) The folder that this Pipeline is in. If not specified, the Pipeline will appear at the root level. | `string` | `null` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_moniter_metrics_after_duration"></a> [moniter_metrics_after_duration](#input_moniter_metrics_after_duration) | (Optional) The TimeSpan value after which an Azure Monitoring Metric is fired. | `string` | `null` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_parameters"></a> [parameters](#input_parameters) | (Optional) A map of parameters to associate with the Data Factory Pipeline. | `map(string)` | `null` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_variables"></a> [variables](#input_variables) | (Optional) A map of variables to associate with the Data Factory Pipeline. | `map(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The Resource ID of the azure data factory pipeline. |
| <a name="output_name"></a> [name](#output_name) | The Name of the azure data factory pipeline. |
| <a name="output_resource"></a> [resource](#output_resource) | The azure data factory pipeline resource. |
<!-- END_TF_DOCS -->
