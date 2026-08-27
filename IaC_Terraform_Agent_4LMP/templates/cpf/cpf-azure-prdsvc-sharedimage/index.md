---
version: 1.0.3
available_versions:
  - 1.0.3
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.1.2
---

<!-- BEGIN_TF_DOCS -->
# Azure Compute Gallery Image Definition module


## Overview

- This terraform module creates a Azure Compute Gallery Image Definition and its Image Version resources.
- Image definitions are created within a gallery and they carry information about the image and any requirements for using it to create VMs. This includes whether the image is Windows or Linux, release notes, and minimum and maximum memory requirements. It's a definition of a type of image.
- An image version is what we use to create a VM when using a gallery. We can have multiple versions of an image as needed for  environment. Like a managed image, when we use an image version to create a VM, the image version is used to create new disks for the VM. Image versions can be used multiple times.

## Prerequisites

- `Resource Group` must be created to deploy this module.
- `Azure Compute Gallery` aka azurerm_shared_image_gallery must be created to deploy this module. A CPD product azure-prdsvc-terraform-azurecomputegallery exists
- `managed_image_id` or `os_disk_snapshot_id` or `blob_uri` and `storage_account_id` where VHD file present must be created to deploy this module version. We must specify exact one of `blob_uri`, `managed_image_id` and `os_disk_snapshot_id`. `blob_uri` and `storage_account_id` must be specified together and contain a VHD file
-  For creation of `managed_image_id` , an image ID need to be present for running CPD module. Image can be created by generalizing or specializing a VM or through creation of image using Hashicorp Packer. There is no CPD product created for azurerm_image. `managed_image_id` can also contain a Virtual Machine ID which creates image in backend
-  For creation of `os_disk_snapshot_id`, a snapshot need to be present for running this CPD module. Snapshot can be created from a OS disk of VM CPD module manually. There is no CPD product created for azurerm_snapshot

## Guidance

-  CPD product `azure-prdsvc-terraform-sharedimage` is a combination of single image defintion and multiple image versions. Image definition can be a Linux or Windows. Image version creation is completely optional
-  During terraform apply of image version creation, for any failure of version creation. Image version metadata will get created in azure and subsequent pipeline runs will fail the pipeline mentioning image version present. Image version must be manually deleted by SRE team by raising a SNOW ticket or someone who have operator access to RG or subscription.
-  Default replication region of image version must be specifically provided where the image definition present. If Image fefinition or compute gallery is uksouth ensure uksouth is given as target replication region else pipeline will fail
- End_of_life_date OF image version must be in RFC3339 format
- There are no security controls to Image definition Version. Security controls are only present for image gallery

#### Usage

- This module create a compute gallery image definition and multiple image versions. A single image definition can be created by use of `shared_image` varaiable. Multiple image versions can be created by the use of `shared_image_versions` variable.
- Image definition is mandatory to use the module. Image versions are optional
- Images can be encrypted using disk encryption set. Make sure disk encryption sets are created in regions where it will be copied as disk encryption set is a region based resource

#### Security Considerations

#### Additional Information

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. |  |  |  |  |  |  |

## Changelog

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/virtual-machines/shared-image-galleries?tabs=vmsource%2Cazure-cli)

### Terraform Docs

- [azurerm_shared_image](https://registry.terraform.io/providers/hashicorp/Azurerm/3.117.0/docs/resources/shared_image)
- [azurerm_shared_image_version](https://registry.terraform.io/providers/hashicorp/Azurerm/3.117.0/docs/resources/shared_image_version)

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
| [azurerm_shared_image.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/shared_image) | resource |
| [azurerm_shared_image_version.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/shared_image_version) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_accelerated_network_support_enabled"></a> [accelerated_network_support_enabled](#input_accelerated_network_support_enabled) | (Optional) Specifies if the Shared Image supports Accelerated Network. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_architecture"></a> [architecture](#input_architecture) | (Optional) CPU architecture supported by an OS. Possible values are x64 and Arm64. Defaults to x64. Changing this forces a new resource to be created. | `string` | `"x64"` | no |
| <a name="input_confidential_vm_enabled"></a> [confidential_vm_enabled](#input_confidential_vm_enabled) | (Optional) Specifies if Confidential Virtual Machines enabled. It will enable all the features of trusted, with higher confidentiality features for isolate machines or encrypted data. Available for Gen2 machines. Changing this forces a new resource to be created. | `bool` | `null` | no |
| <a name="input_confidential_vm_supported"></a> [confidential_vm_supported](#input_confidential_vm_supported) | (Optional) Specifies if supports creation of both Confidential virtual machines and Gen2 virtual machines with standard security from a compatible Gen2 OS disk VHD or Gen2 Managed image. Changing this forces a new resource to be created. | `bool` | `null` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_description"></a> [description](#input_description) | (Optional) A description of this Shared Image. | `string` | `""` | no |
| <a name="input_disk_controller_type_nvme_enabled"></a> [disk_controller_type_nvme_enabled](#input_disk_controller_type_nvme_enabled) | (Optional) Specifies if the Shared Image supports NVMe disks. Changing this forces a new resource to be created. | `bool` | `null` | no |
| <a name="input_disk_types_not_allowed"></a> [disk_types_not_allowed](#input_disk_types_not_allowed) | (Optional) list of One or more Disk Types not allowed for the Image. Possible values include Standard_LRS and Premium_LRS. | `list(string)` | `null` | no |
| <a name="input_end_of_life_date"></a> [end_of_life_date](#input_end_of_life_date) | (Optional) The end of life date in RFC3339 format of the Image. Format as YYYY-MM-DDTHH:MM:SSZ | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_eula"></a> [eula](#input_eula) | (Optional) The End User Licence Agreement for the Shared Image. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_gallery_name"></a> [gallery_name](#input_gallery_name) | (Required) Specifies the name of the Shared Image Gallery in which this Shared Image should exist. Changing this forces a new resource to be created | `string` | n/a | yes |
| <a name="input_hyper_v_generation"></a> [hyper_v_generation](#input_hyper_v_generation) | (Optional) The generation of HyperV that the Virtual Machine used to create the Shared Image is based on. Possible values are V1 and V2. Defaults to V1. Changing this forces a new resource to be created. | `string` | `"V2"` | no |
| <a name="input_identifier"></a> [identifier](#input_identifier) | (Required) Object containing variables for identifier configuration<br/>object({<br/>  offer     = (Required) The Offer Name for this Shared Image. Changing this forces a new resource to be created.<br/>  publisher = (Required) The Publisher Name for this Gallery Image. Changing this forces a new resource to be created.<br/>  sku       = (Required) The Name of the SKU for this Gallery Image. Changing this forces a new resource to be created.<br/>}) | <pre>object({<br/>    offer     = string<br/>    publisher = string<br/>    sku       = string<br/>  })</pre> | n/a | yes |
| <a name="input_image_name"></a> [image_name](#input_image_name) | (Required) Specifies the name of the Shared Image. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_max_recommended_memory_in_gb"></a> [max_recommended_memory_in_gb](#input_max_recommended_memory_in_gb) | (Optional) Maximum memory in GB recommended for the Image. | `number` | `null` | no |
| <a name="input_max_recommended_vcpu_count"></a> [max_recommended_vcpu_count](#input_max_recommended_vcpu_count) | (Optional) Maximum count of vCPUs recommended for the Image. | `number` | `null` | no |
| <a name="input_min_recommended_memory_in_gb"></a> [min_recommended_memory_in_gb](#input_min_recommended_memory_in_gb) | (Optional) Minimum memory in GB recommended for the Image. | `number` | `null` | no |
| <a name="input_min_recommended_vcpu_count"></a> [min_recommended_vcpu_count](#input_min_recommended_vcpu_count) | (Optional) Minimum count of vCPUs recommended for the Image. | `number` | `null` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_os_type"></a> [os_type](#input_os_type) | (Required) The type of Operating System present in this Shared Image. Possible values are Linux and Windows. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_privacy_statement_uri"></a> [privacy_statement_uri](#input_privacy_statement_uri) | (Optional) The URI containing the Privacy Statement associated with this Shared Image. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_purchase_plan"></a> [purchase_plan](#input_purchase_plan) | (Optional) Object containing variables for purchase plan configuration<br/>object({<br/>  name      = (Required) The Purchase Plan Name for this Shared Image. Changing this forces a new resource to be created.<br/>  publisher = (Optional) The Purchase Plan Publisher for this Gallery Image. Changing this forces a new resource to be created.<br/>  product   = (Optional) The Purchase Plan Product for this Gallery Image. Changing this forces a new resource to be created.<br/>}) | <pre>object({<br/>    name      = string<br/>    publisher = optional(string)<br/>    product   = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_release_note_uri"></a> [release_note_uri](#input_release_note_uri) | (Optional) The URI containing the Release Notes associated with this Shared Image. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_shared_image_versions"></a> [shared_image_versions](#input_shared_image_versions) | shared_image_versions = (Optional) A map of the 'shared_image_versions' objects used to create 0 or more image versions and supports the following:<br/>shared_image_versions = (Optional) object({<br/>image_version_number                      = (Required) The version number for this Image Version, such as 1.0.0. Changing this forces a new resource to be created.<br/>blob_uri                                  = (Optional) URI of the Azure Storage Blob used to create the Image Version. Changing this forces a new resource to be created.<br/>storage_account_id                        = (Optional) The ID of the Storage Account where the Blob exists. Changing this forces a new resource to be created.<br/>end_of_life_date                          = (Optional) The end of life date in RFC3339 format of the Image Version.<br/>exclude_from_latest                       = (Optional) Should this Image Version be excluded from the latest filter? If set to true this Image Version won't be returned for the latest version. Defaults to false.<br/>managed_image_id                          = (Optional) The ID of the Managed Image or Virtual Machine ID which should be used for this Shared Image Version. Changing this forces a new resource to be created.The ID can be sourced from the azurerm_image Data Source or Resource.<br/>os_disk_snapshot_id                       = (Optional) The ID of the OS disk snapshot which should be used for this Shared Image Version. Changing this forces a new resource to be created.<br/>deletion_of_replicated_locations_enabled  = (Optional) Specifies whether this Shared Image Version can be deleted from the Azure Regions this is replicated to. Defaults to false. Changing this forces a new resource to be created.<br/>replication_mode                          = (Optional) Mode to be used for replication. Possible values are Full and Shallow. Defaults to Full. Changing this forces a new resource to be created.<br/>target_region = "(Required) A map of `target_region` objects for the Windows Web App<br/>target_region = (Required) object({<br/>  regional_replica_count                  = (Required) The Publisher Name for this Gallery Image. Changing this forces a new resource to be created.<br/>  disk_encryption_set_id                  = (Optional) The ID of the Disk Encryption Set to encrypt the Image Version in the target region. Changing this forces a new resource to be created.<br/>  exclude_from_latest_enabled             = (Optional) Specifies whether this Shared Image Version should be excluded when querying for the latest version. Defaults to false.<br/>  storage_account_type                    = (Optional) The storage account type for the image version. Possible values are Standard_LRS, Premium_LRS and Standard_ZRS. Defaults to Standard_LRS. You can store all of your image version replicas in Zone Redundant Storage by specifying Standard_ZRS.<br/>  })<br/>}) | <pre>map(object({<br/>    image_version_number                     = string<br/>    blob_uri                                 = optional(string)<br/>    storage_account_id                       = optional(string)<br/>    end_of_life_date                         = optional(string)<br/>    exclude_from_latest                      = optional(bool, false)<br/>    managed_image_id                         = optional(string)<br/>    os_disk_snapshot_id                      = optional(string)<br/>    deletion_of_replicated_locations_enabled = optional(bool, false)<br/>    replication_mode                         = optional(string, "Full")<br/>    target_region = map(object({<br/>      regional_replica_count      = number<br/>      disk_encryption_set_id      = optional(string)<br/>      exclude_from_latest_enabled = optional(string, false)<br/>      storage_account_type        = optional(string, "Standard_LRS")<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_specialized"></a> [specialized](#input_specialized) | (Optional) Specifies that the Operating System used inside this Image has not been Generalized (for example, sysprep on Windows has not been run). Changing this forces a new resource to be created. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_trusted_launch_enabled"></a> [trusted_launch_enabled](#input_trusted_launch_enabled) | (Optional) Specifies if Trusted Launch has to be enabled for the Virtual Machine created from the Shared Image. Changing this forces a new resource to be created.Only one of trusted_launch_supported, trusted_launch_enabled, confidential_vm_supported and confidential_vm_enabled can be specified. | `bool` | `true` | no |
| <a name="input_trusted_launch_supported"></a> [trusted_launch_supported](#input_trusted_launch_supported) | (Optional) Specifies if supports creation of both Trusted Launch virtual machines and Gen2 virtual machines with standard security created from the Shared Image. Changing this forces a new resource to be created. | `bool` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The Resource ID of the Compute Gallery Image Definition. |
| <a name="output_name"></a> [name](#output_name) | The Name of the Compute Gallery Image Definition Name. |
| <a name="output_resource"></a> [resource](#output_resource) | The Azure Compute Gallery Image definition resource. |
| <a name="output_version_ids"></a> [version_ids](#output_version_ids) | The resource version IDs consists of a map of objects of the Azure Compute Gallery Image version IDs |
| <a name="output_version_names"></a> [version_names](#output_version_names) | The resource version names consists of map of object of the Azure Compute Gallery Image version names |
| <a name="output_version_resources"></a> [version_resources](#output_version_resources) | The resource versions consists of map of objects of the Azure Compute Gallery Image version |
<!-- END_TF_DOCS -->
