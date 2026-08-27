---
version: 1.1.1
available_versions:
  - 1.1.1
  - 1.1.0
  - 1.0.1
  - 1.0.0
  - 0.9.0
---

<!-- BEGIN_TF_DOCS -->
# Azure Managed Disk module


## Overview

This terraform module creates a managed disk and it's associated resources.

## Prerequisites

- `Windows Virtual Machine` or `Linux Virtual Machine` to which deployed managed disk can be attached.

## Guidance

#### Usage

- Ensure to pass `performance_tier` parameter as per the [valid options](https://learn.microsoft.com/en-us/azure/virtual-machines/disks-change-performance) for the chosen disk size.

###### AzureRM 3.x to 4.x Upgrade for Managed Disk

Product Impact -- Low

- Updated `azurerm` provider version from `3.x` to `4.x`.

#### Security Considerations

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-MD-AC_010 | Disable Public and Private Network Access | Managed Disks must enforce a network guardrail (What) in the Networking setting (How) in order to prevent disk and data export of Managed Disks (Why) | True | True | Implemented using network_access_policy argument in azurerm_managed_disk resource type, where value is set to "DenyAll" |
| 2. | AZU-MD-SC_010 | Managed Disks must use a Disk Encryption Set that is persisted in a Premium SKU HSM backed Key Vault | Managed Disks must use a Disk Encryption Set that is persisted in a Premium SKU HSM backed Key Vault (What) in the Encryption settings (How) in order should Microsoft's key management platform become compromised LSEG can revoke access to exfiltrated encrypted data (Why) | False | False | This security check will be implemented in Disk encryption set (DES) module |
| 3. | AZU-MD-SC_020 | Managed Disks must have a data classification tag | Managed Disks must have a data classification tag (What) in the Tags setting (How) in order to differentiate assets technical control requirements and to assist Security Operations in prioritising possible data breach mitigation responses (Why) | False | False | Tag values specific to individual resources will be taken care during the time of provision |

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames). |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Disk Related Metrics](https://learn.microsoft.com/en-us/azure/virtual-machines/disks-metrics).<br><br>[Cloud monitoring service level objectives](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives).<br><br>[Supported Metrics for Disks](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-compute-disks-metrics). |
| 5. | [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | True | This control is implemented by following parameters: `availability_zone` for High Availability `storage_account_type` property for enabling geo replication.<br><br>[Redundancy options for managed disks](https://learn.microsoft.com/en-us/azure/virtual-machines/disks-redundancy)<br><br>Disk Backup can be enabled using module [Data Protection Backup Instance](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-dataprotectionbackupinstance) <br><br>[Azure Disk Backup](https://learn.microsoft.com/en-us/azure/backup/disk-backup-overview) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place.<br><br>[Virtual Machine RBAC](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles) |
| 8. | [SMCF-OPS-09 Update Management](https://dev.azure.com/LSEG/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1408/SMCF-OPS-09-Update-Management) | SMCF-OPS-09-01 Assess cloud resources for missing updates | Documentation | False | This control will be implemented as per LSEG Standard.<br><br>[Updates and Maintenance Overview](https://learn.microsoft.com/en-us/azure/virtual-machines/updates-maintenance-overview) |

## Changelog

- [azure-prdsvc-terraform-manageddisk](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/virtual-machines/managed-disks-overview)

### Terraform Docs

- [azurerm_managed_disk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0 |
| <a name="requirement_azapi"></a> [azapi](#requirement_azapi) | >=1.9 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm) | >= 4.33 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azapi"></a> [azapi](#provider_azapi) | >=1.9 |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | >= 4.33 |

## Resources

| Name | Type |
|------|------|
| [azapi_update_resource.this](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/update_resource) | resource |
| [azurerm_managed_disk.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk) | resource |
| [azurerm_virtual_machine_data_disk_attachment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_attach_disk_to_vm"></a> [attach_disk_to_vm](#input_attach_disk_to_vm) | (Required) Whether to attach the disk to a virtual machine. When false, creates a standalone disk for VMSS scenarios. | `bool` | n/a | yes |
| <a name="input_availability_zone"></a> [availability_zone](#input_availability_zone) | (Optional) The Availability Zone in which this Managed Disk should be located. Make sure the disk sku you want to use can be created in availability zone. | `string` | `null` | no |
| <a name="input_caching"></a> [caching](#input_caching) | (Optional) Specifies the caching requirements for this Data Disk. | `string` | `"ReadWrite"` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 71 chars). | `string` | `null` | no |
| <a name="input_data_access_auth_mode"></a> [data_access_auth_mode](#input_data_access_auth_mode) | (Optional)Specifies the authentication mode for data access. | `string` | `"AzureActiveDirectory"` | no |
| <a name="input_disk_encryption_set_id"></a> [disk_encryption_set_id](#input_disk_encryption_set_id) | (Required) The resource ID of a Disk Encryption Set which should be used to encrypt this Managed Disk. | `string` | n/a | yes |
| <a name="input_disk_iops_read_only"></a> [disk_iops_read_only](#input_disk_iops_read_only) | (Optional) The number of IOPS allowed across all VMs mounting the shared disk as read-only; only settable for UltraSSD disks and PremiumV2 disks with shared disk enabled. One operation can transfer between 4k and 256k bytes. | `number` | `null` | no |
| <a name="input_disk_iops_read_write"></a> [disk_iops_read_write](#input_disk_iops_read_write) | (Optional) The number of IOPS allowed for this disk; only settable for UltraSSD disks and PremiumV2 disks. One operation can transfer between 4k and 256k bytes. | `number` | `null` | no |
| <a name="input_disk_mbps_read_only"></a> [disk_mbps_read_only](#input_disk_mbps_read_only) | (Optional) The bandwidth allowed across all VMs mounting the shared disk as read-only; only settable for UltraSSD disks and PremiumV2 disks with shared disk enabled. MBps means millions of bytes per second. | `number` | `null` | no |
| <a name="input_disk_mbps_read_write"></a> [disk_mbps_read_write](#input_disk_mbps_read_write) | (Optional) The bandwidth allowed for this disk; only settable for UltraSSD disks and PremiumV2 disks. MBps means millions of bytes per second. | `number` | `null` | no |
| <a name="input_disk_size_gb"></a> [disk_size_gb](#input_disk_size_gb) | (Optional) Specifies the size of the managed disk to create in gigabytes. If create_option is Copy or FromImage, then the value must be equal to or greater than the source's size. The size can only be increased. Defaults to `128` | `string` | `"128"` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_gallery_image_reference_id"></a> [gallery_image_reference_id](#input_gallery_image_reference_id) | (Optional) ID of a Gallery Image Version to copy when create_option is FromImage. This field cannot be specified if image_reference_id is specified. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_hyper_v_generation"></a> [hyper_v_generation](#input_hyper_v_generation) | (Optional) The HyperV Generation of the Disk when the source of an Import or Copy operation targets a source that contains an operating system. Possible values are V1 and V2. For ImportSecure it must be set to V2. Changing this forces a new resource to be created. Defaults to `V2` | `string` | `"V2"` | no |
| <a name="input_image_reference_id"></a> [image_reference_id](#input_image_reference_id) | (Optional) ID of an existing platform/marketplace disk image to copy from | `string` | `""` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_lun"></a> [lun](#input_lun) | (Optional) The Logical Unit Number of the Data Disk, which needs to be unique within the Virtual Machine. Required when virtual_machine_id is provided. Valid range is 0-63. | `number` | `null` | no |
| <a name="input_max_shares"></a> [max_shares](#input_max_shares) | (Optional) The maximum number of VMs that can attach to the disk at the same time. Value greater than one indicates a disk that can be mounted on multiple VMs at the same time. | `number` | `null` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_os_type"></a> [os_type](#input_os_type) | (Optional) Specify a value when the source is an Import, Copy or Image. | `string` | `null` | no |
| <a name="input_performance_tier"></a> [performance_tier](#input_performance_tier) | (Optional) The disk performance tier to use. This feature is currently supported only for premium SSDs. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the managed disk. | `string` | n/a | yes |
| <a name="input_source_resource_id"></a> [source_resource_id](#input_source_resource_id) | (Optional) The ID of an existing Managed Disk or Snapshot to copy from. | `string` | `""` | no |
| <a name="input_source_uri"></a> [source_uri](#input_source_uri) | (Optional) URI to a valid VHD file to be used for the disk creation. | `string` | `""` | no |
| <a name="input_storage_account_id"></a> [storage_account_id](#input_storage_account_id) | (Optional) The ID of the Storage Account where the source_uri is located. Required when create_option is set to `Import` or `ImportSecure`. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_storage_account_type"></a> [storage_account_type](#input_storage_account_type) | (Optional) The type of storage to use for the managed disk. Possible values are Standard_LRS, StandardSSD_ZRS, Premium_LRS, PremiumV2_LRS, Premium_ZRS, StandardSSD_LRS or UltraSSD_LRS. | `string` | `"StandardSSD_LRS"` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_trusted_launch_enabled"></a> [trusted_launch_enabled](#input_trusted_launch_enabled) | (Optional) Specifies if Trusted Launch is enabled for the Managed Disk. Changing this forces a new resource to be created. | `bool` | `false` | no |
| <a name="input_virtual_machine_id"></a> [virtual_machine_id](#input_virtual_machine_id) | (Optional) The ID of the virtual machine to attach the disk to. If null, creates a standalone disk. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | ID of the managed disk. |
| <a name="output_name"></a> [name](#output_name) | Name of the managed disk. |
| <a name="output_resource"></a> [resource](#output_resource) | The Managed Disk resource. |
<!-- END_TF_DOCS -->
