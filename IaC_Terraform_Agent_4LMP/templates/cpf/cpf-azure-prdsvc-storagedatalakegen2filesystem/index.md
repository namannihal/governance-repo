---
version: 1.0.1
available_versions:
  - 1.0.1
  - 1.0.0
  - 0.1.5
  - 0.1.4
  - 0.1.3
---

<!-- BEGIN_TF_DOCS -->
# Azure Storage Data Lake Gen2 File System module

## Overview

This terraform module creates a Azure Data Lake Gen2 File System and associated resources.

## Prerequisites

An Azure `Storage Account` must have been created if not exists.

## Guidance

#### Usage

- Along with Azure Data Lake Gen2 File System, this module allows us to create multiple container paths/directory.
- The data that we ingest persist as blobs in the storage account. The service that manages blobs is the Azure Blob Storage service. Data Lake Storage Gen2 describes the capabilities or "enhancements" to this service itself that caters to the demands of big data analytic workloads.

#### Security Considerations

- If we create a private endpoint for the Data Lake Storage Gen2 storage resource, then we should also create one for the Blob Storage resource. That's because operations that target the Data Lake Storage Gen2 endpoint might be redirected to the Blob endpoint. Similarly, if we add a private endpoint for Blob Storage only, and not for Data Lake Storage Gen2, some operations (such as Manage ACL, Create Directory, Delete Directory, etc.) will fail since the Gen2 APIs require a DFS private endpoint. By creating a private endpoint for both resources, we ensure that all operations can complete successfully.
- This resource requires some Storage specific roles which are not granted by default. Some of the built-ins roles that can be attributed are `Storage Account Contributor, Storage Blob Data Owner, Storage Blob Data Contributor, Storage Blob Data Reader`.
- The Storage Account requires account\_kind to be either `StorageV2` or `BlobStorage`. In addition, `is_hns_enabled` has to be set to `true`.

## Security Controls

- There are no security controls available to be implemented for this product.

## Changelog

- [azure-prdsvc-terraform-storagedatalakegen2filesystem](CHANGELOG.md)

## References

### Microsoft Docs

- [Azure Data Lake Storage Gen2](https://learn.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-introduction)
- [Private endpoints for Azure Storage](https://learn.microsoft.com/en-us/azure/storage/common/storage-private-endpoints)
- [Access control lists (ACLs)](https://learn.microsoft.com/en-gb/azure/storage/blobs/data-lake-storage-access-control#access-control-lists-on-files-and-directories)

### Terraform Docs

- [azurerm_storage_data_lake_gen2_filesystem](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_data_lake_gen2_filesystem)
- [azurerm_storage_data_lake_gen2_path](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_data_lake_gen2_path)

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
| [azurerm_storage_data_lake_gen2_filesystem.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_data_lake_gen2_filesystem) | resource |
| [azurerm_storage_data_lake_gen2_path.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_data_lake_gen2_path) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_file_System"></a> [file_System](#input_file_System) | (Optional) A filesystem variable which contains the following attributes:<br/>    (Optional) A mapping of Access Control Entries which should be assigned to this Data Lake Gen2 File System.<br/>      ace = "(Optional) A mapping of Access Control Entries which should be assigned to this Data Lake Gen2 File System."<br/>        scope       = "(Optional) Specifies whether the ACE represents an access entry or a default entry. Default value is access."<br/>        type        = "(Required) Specifies the type of entry. Can be user, group, mask or other."<br/>        id          = "(Optional) Specifies the Object ID of the Azure Active Directory User or Group that the entry relates to. Only valid for user or group entries."<br/>        permissions = "(Required) Specifies the permissions for the entry in rwx form. For example, rwx gives full permissions but r-- only gives read permissions."<br/>      owner      = "(Optional) Specifies the Object ID of the Azure Active Directory User to make the owning user of the root path (i.e. /). Possible values also include $superuser."<br/>      group      = "(Optional) Specifies the Object ID of the Azure Active Directory Group to make the owning group of the root path (i.e. /). Possible values also include $superuser."<br/>      properties = "(Optional) A mapping of Key to Base64-Encoded Values which should be assigned to this Data Lake Gen2 File System." | <pre>object({<br/>    ace = optional(map(object({<br/>      scope       = optional(string, null)<br/>      type        = string<br/>      id          = optional(string, null)<br/>      permissions = string<br/>    })), {})<br/>    owner      = optional(string, null)<br/>    group      = optional(string, null)<br/>    properties = optional(map(any), {})<br/>  })</pre> | `{}` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_path_variable"></a> [path_variable](#input_path_variable) | (Optional) One ore more path variables contain the following attributes:<br/>    (Optional) A mapping of Access Control Entries which should be assigned to this Data Lake Gen2 File System.<br/>      ace = "(Optional) A mapping of Access Control Entries which should be assigned to this Data Lake Gen2 File System."<br/>        scope       = "(Optional) Specifies whether the ACE represents an access entry or a default entry. Default value is access."<br/>        type        = "(Required) Specifies the type of entry. Can be user, group, mask or other."<br/>        id          = "(Optional) Specifies the Object ID of the Azure Active Directory User or Group that the entry relates to. Only valid for user or group entries."<br/>        permissions = "(Required) Specifies the permissions for the entry in rwx form. For example, rwx gives full permissions but r-- only gives read permissions."<br/>      owner              = "(Optional) Specifies the Object ID of the Azure Active Directory User to make the owning user of the root path (i.e. /). Possible values also include $superuser."<br/>      group              = "(Optional) Specifies the Object ID of the Azure Active Directory Group to make the owning group of the root path (i.e. /). Possible values also include $superuser."<br/>      path               = "(Required) The path which should be created within the Data Lake Gen2 File System in the Storage Account. Changing this forces a new resource to be created."<br/>      resource           = "(Required) Specifies the type for path to create. Currently only directory is supported. Changing this forces a new resource to be created." | <pre>map(object({<br/>    ace = optional(map(object({<br/>      scope       = optional(string)<br/>      type        = string<br/>      id          = optional(string)<br/>      permissions = string<br/>    })), null)<br/>    owner    = optional(string, null)<br/>    group    = optional(string, null)<br/>    path     = string<br/>    resource = string<br/>  }))</pre> | `{}` | no |
| <a name="input_storage_account_id"></a> [storage_account_id](#input_storage_account_id) | (Required) Specifies the ID of the Storage Account in which the Data Lake Gen2 File System should exist. Changing this forces a new resource to be created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The ID of the Data lake gen2 filesystem. |
| <a name="output_name"></a> [name](#output_name) | The name of the Data lake gen2 filesystem. |
| <a name="output_path_id"></a> [path_id](#output_path_id) | The ID of the Data lake gen2 path. |
| <a name="output_path_name"></a> [path_name](#output_path_name) | The name of the Data lake gen2 path. |
| <a name="output_path_resource"></a> [path_resource](#output_path_resource) | The Data lake gen2 path resource. |
| <a name="output_resource"></a> [resource](#output_resource) | The Data lake gen2 filesystem resource. |
<!-- END_TF_DOCS -->
