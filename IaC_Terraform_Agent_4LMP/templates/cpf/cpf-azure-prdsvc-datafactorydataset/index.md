---
version: 1.0.1
available_versions:
  - 1.0.1
  - 1.0.0
  - 0.1.0
---

<!-- BEGIN_TF_DOCS -->
# __product name__ module


## Overview

This Terraform module provisions Azure Data Factory datasets and their associated resources Blob Dataset,Custom Dataset and SQL table Dataset.

Dataset is a named view of data that references data utilized in pipeline activities as inputs and outputs. Datasets identify data across various data stores, including tables, files, folders, and documents. For example, an Azure Blob dataset specifies the blob container and folder path in Blob Storage from which activities retrieve data.

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

## Guidance

#### Usage

##### Azure Data Factory Datasets

- This module covers the datasets for `Azure Blob Dataset`,`SQL Table Dataset`  and `Custom Dataset`. Users can optionally create each dataset type based on their requirement.
- Datasets must reference existing linked services. The dataset configuration includes properties such as folder paths, file formats, and data structure definitions. Users should configure these values based on their specific data source requirements.

#### Security Considerations

#### Additional Information

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. |  |  |  |  |  |  |

## Changelog

- [azure-prdsvc-terraform-datafactorydataset](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/data-factory/)
- [Datasets](https://learn.microsoft.com/en-us/azure/data-factory/concepts-datasets-linked-services)

### Terraform Docs

- [azurerm_data_factory_dataset_azure_blob](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_dataset_azure_blob)
- [azurerm_data_factory_custom_dataset](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_custom_dataset)
- [azurerm_data_factory_dataset_azure_sql_table](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_dataset_azure_sql_table)

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
| [azurerm_data_factory_custom_dataset.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_custom_dataset) | resource |
| [azurerm_data_factory_dataset_azure_blob.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_dataset_azure_blob) | resource |
| [azurerm_data_factory_dataset_azure_sql_table.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_dataset_azure_sql_table) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_azure_blob_dataset_config"></a> [azure_blob_dataset_config](#input_azure_blob_dataset_config) | (Optional) Map of Azure Blob Dataset configurations for Data Factory.<br/>name                     = "(Required) The name of the Azure Blob Dataset. Must be unique within a data factory."<br/>data_factory_id          = "(Required) The Data Factory ID in which to associate the Linked Service with."<br/>linked_service_name      = "(Required) The explicit name of the Data Factory Linked Service."<br/>linked_service_key       = "(Optional) The key of the linked service in azure_blob_storage_linked_service_config map. If not specified, uses the dataset's own key."<br/>folder                   = "(Optional) The folder that this Dataset is in. If not specified, the Dataset will appear at the root level."<br/>description              = "(Optional) The description for the Data Factory Dataset."<br/>annotations              = "(Optional) List of tags that can be used for describing the Data Factory Dataset."<br/>parameters               = "(Optional) A map of parameters to associate with the Data Factory Dataset."<br/>additional_properties    = "(Optional) A map of additional properties to associate with the Data Factory Dataset."<br/>path                     = "(Optional) The path of the Azure Blob."<br/>filename                 = "(Optional) The filename of the Azure Blob."<br/>dynamic_path_enabled     = "(Optional) Is the path using dynamic expression, function or system variables? Defaults to false."<br/>dynamic_filename_enabled = "(Optional) Is the filename using dynamic expression, function or system variables? Defaults to false."<br/><br/>schema_column = "(Optional) A list of schema_column blocks:<br/>  name        = "(Required) The name of the column."<br/>  type        = "(Optional) Type of the column. Valid values are Byte, Byte[], Boolean, Date, DateTime, DateTimeOffset, Decimal, Double, Guid, Int16, Int32, Int64, Single, String, TimeSpan. Please note these values are case sensitive."<br/>  description = "(Optional) The description of the column." | <pre>map(object({<br/>    name                     = string<br/>    data_factory_id          = string<br/>    linked_service_name      = string<br/>    folder                   = optional(string, null)<br/>    description              = optional(string, null)<br/>    annotations              = optional(list(string), [])<br/>    parameters               = optional(map(string), {})<br/>    additional_properties    = optional(map(string), {})<br/>    path                     = optional(string, null)<br/>    filename                 = optional(string, null)<br/>    dynamic_path_enabled     = optional(bool, false)<br/>    dynamic_filename_enabled = optional(bool, false)<br/>    schema_column = optional(list(object({<br/>      name        = string<br/>      type        = optional(string, null)<br/>      description = optional(string, null)<br/>    })), [])<br/>  }))</pre> | `{}` | no |
| <a name="input_azure_sqltable_dataset_config"></a> [azure_sqltable_dataset_config](#input_azure_sqltable_dataset_config) | (Optional) Configuration for Azure SQL Table Dataset Services is below.<br/>  name                  = "(Required) Specifies the name of the Data Factory Dataset Azure SQL Table."<br/>  data_factory_id       = "(Required) The Data Factory ID in which to associate the Linked Service with."<br/>  schema                = "(Optional) The schema name of the table in the Azure SQL Database."<br/>  table                 = "(Optional) The table name of the table in the Azure SQL Database."<br/>  folder                = "(Optional) The folder that this Dataset is in. If not specified, the Dataset will appear at the root level."<br/>  description           = "(Optional) The description for the Data Factory Dataset Azure SQL Table."<br/>  linked_service_id     = "(Required) The Data Factory Linked Service ID in which to associate the Dataset with"<br/>  annotations           = "(Optional) List of tags that can be used for describing the Data Factory Dataset Azure SQL Table."<br/>  parameters            = "(Optional) A map of parameters to associate with the Data Factory Dataset Azure SQL Table."<br/>  additional_properties = "(Optional) A map of additional properties to associate with the Data Factory Dataset Azure SQL Table."<br/>  schema_column         = "(Optional) A schema_column block as defined below."<br/>    name                = "(Required) The name of the column."<br/>    type                = "(Optional) Type of the column. Valid values are Byte, Byte[], Boolean, Date, DateTime,DateTimeOffset, Decimal, Double, Guid, Int16, Int32, Int64, Single, String, TimeSpan . Please note these values are case sensitive."<br/>    description         = "(Optional)  The description of the column." | <pre>map(object({<br/>    name                  = string<br/>    data_factory_id       = string<br/>    schema                = optional(string, null)<br/>    table                 = optional(string, null)<br/>    folder                = optional(string, null)<br/>    description           = optional(string, null)<br/>    linked_service_id     = string<br/>    annotations           = optional(list(string), [])<br/>    parameters            = optional(map(string), {})<br/>    additional_properties = optional(map(string), {})<br/>    schema_column = optional(map(object({<br/>      name        = string<br/>      type        = optional(string, null)<br/>      description = optional(string, null)<br/>    })), null)<br/>  }))</pre> | `null` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_custom_dataset_config"></a> [custom_dataset_config](#input_custom_dataset_config) | (Optional) Configuration for Custom Data Factory Dataset (Generic).<br/>  name                  = "(Required) Specifies the name of the Data Factory Dataset. Changing this forces a new resource to be created. Must be globally unique. See the Microsoft documentation for all restrictions."<br/>  data_factory_id       = "(Required) The Data Factory ID in which to associate the Dataset with. Changing this forces a new resource."<br/>  type                  = "(Required) The type of dataset that will be associated with Data Factory. Changing this forces a new resource to be created."<br/>  type_properties_json  = "(Required) A JSON object that contains the properties of the Data Factory Dataset. Refer to datafactory/models.go for the shape of the expected JSON. For example, the JSON object for AzureBlob-typed Dataset will be unmarshaled into AzureBlobDatasetTypeProperties struct."<br/>  additional_properties = "(Optional) A map of additional properties to associate with the Data Factory Dataset."<br/>  annotations           = "(Optional) List of tags that can be used for describing the Data Factory Dataset."<br/>  description           = "(Optional) The description for the Data Factory Dataset."<br/>  folder                = "(Optional) The folder that this Dataset is in. If not specified, the Dataset will appear at the root level."<br/>  parameters            = "(Optional) A map of parameters to associate with the Data Factory Dataset."<br/>  schema_json           = "(Optional) A JSON object that contains the schema of the Data Factory Dataset."<br/><br/>  linked_service        = "(Required) A linked_service block as defined below:"<br/>    name                = "(Required) The name of the Data Factory Linked Service."<br/>    parameters          = "(Optional) A map of parameters to associate with the Data Factory Linked Service." | <pre>map(object({<br/>    name                  = string<br/>    data_factory_id       = string<br/>    type                  = string<br/>    type_properties_json  = string<br/>    additional_properties = optional(map(string), {})<br/>    annotations           = optional(list(string), [])<br/>    description           = optional(string, null)<br/>    folder                = optional(string, null)<br/>    parameters            = optional(map(string), {})<br/>    schema_json           = optional(string, null)<br/>    linked_service = object({<br/>      name       = string<br/>      parameters = optional(map(string), {})<br/>    })<br/>  }))</pre> | `{}` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_blobdataset_ids"></a> [blobdataset_ids](#output_blobdataset_ids) | The IDs of the Azure Blob Datasets. |
| <a name="output_blobdataset_names"></a> [blobdataset_names](#output_blobdataset_names) | The names of the Azure Blob Datasets. |
| <a name="output_blobdataset_resources"></a> [blobdataset_resources](#output_blobdataset_resources) | The Azure Blob Dataset resources. |
| <a name="output_customdataset_ids"></a> [customdataset_ids](#output_customdataset_ids) | The IDs of the Data Factory Custom Datasets. |
| <a name="output_customdataset_names"></a> [customdataset_names](#output_customdataset_names) | The names of the Data Factory Custom Datasets. |
| <a name="output_customdataset_resources"></a> [customdataset_resources](#output_customdataset_resources) | The Data Factory Custom Dataset resources. |
| <a name="output_sqltabledataset_ids"></a> [sqltabledataset_ids](#output_sqltabledataset_ids) | The IDs of the Data Factory sqltable Datasets. |
| <a name="output_sqltabledataset_names"></a> [sqltabledataset_names](#output_sqltabledataset_names) | The names of the Data Factory sqltable Datasets. |
| <a name="output_sqltabledataset_resources"></a> [sqltabledataset_resources](#output_sqltabledataset_resources) | The Data Factory sqltable Dataset resources. |
<!-- END_TF_DOCS -->
