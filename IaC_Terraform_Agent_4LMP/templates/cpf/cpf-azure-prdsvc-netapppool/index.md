---
version: 0.2.1
available_versions:
  - 0.2.1
  - 0.2.0
  - 0.1.0
---

<!-- BEGIN_TF_DOCS -->
# NetApp Pool module


## Overview

# This product has been Decommisioned. Will be no longer supported.

This terraform module creates a Netapp Pool and associated resources.

## Prerequisites

This module requires the following pre-existing dependent Azure resources:

- `Resource Group`, `Virtual Network` (both modules to be called if not existing, if allowed by the deployment permissions).
- `Subnet` to be used by the Key Vault Private endpoint.
- `Network Security Group` to be associated with the Subnet.
- `Route Table` to be associated with the Subnet.
- `Key Vault` for resource Customer Managed Key encryption.
- `Private Endpoint` to create a private connection to the Key Vault.
- `User Assigned Identity` leveraged for both identity and Customer Managed Key encryption.
- `Netapp Account` for Netapp Pool and volume.

## Guidance

#### Usage

- This modules creates a NetApp pool with `encryption` property enabled and with volume.

#### Security Considerations

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-NETAPP-AC_010 | Azure NetApp Files volumes export policies must not allow unrestricted access | Azure NetApp Files volumes export policies must not allow unrestricted access (What) within Volumes settings > export policy (How) to prevent unauthorised access to protected services (Why) | False | False | This control can't be implement as it will depends on the application team which IPs needs to whitelist. |
| 2. | AZU-NETAPP-AU_010 | Send all diagnostic log categories to a central SOC Log Analytics workspace | Azure NetApp Files Volumes must send all diagnostic logs to a central SOC Log Analytics workspace (What) within code deployment settings (How) in order to support a security investigation after a security incident (Why) | False | False | This control would e implemented via DINE Policy. |
| 3. | AZU-NETAPP-AU_020 | Send all diagnostic log categories to a central SOC Storage Account | Azure NetApp Files Volumes must send all diagnostic logs to a central SOC Storage Account (What) within code deployment settings (How) in order to provide an immutable copy to adhere to compliance requirements (Why) | False | False | This control would e implemented via DINE Policy. |
| 4. | AZU-NETAPP-AU_030 | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval (What) within code deployment settings (How) in order to prevent sensitive data leakage to third parties outside of LSEG control (Why) | False | False | This control would e implemented via DINE Policy. |
| 5. | AZU-NETAPP-SC_020 | Azure NetApp Files Volumes must use a dedicated CMK for Azure NetApp Files volumes Transparent Data Encryption that is persisted in an HSM backed Key Vault | Use a dedicated Azure NetApp Files Volumes LSEG managed encryption at rest key persisted in an HSM backed Key Vault (What) within code deployment settings (How) in order should Microsoft's key management platform become compromised LSEG can revoke access to exfiltrated encrypted data (Why) | True | False | This control is implemented via using `Encryption_key_source` set to `Microsoft.Keyvault`. |
| 6. | AZU-NETAPP-SC_030 | Azure NetApp Files Volumes must encrypt SMB3 traffic in transit | Azure NetApp Files Volumes must encrypt SMB3 traffic in transit (What) within code deployment settings (How) to use modern techniques to establish robust encrypted data channels (Why) | False | False | This control couldn't be implement due to limitations of AD Connections as we need valid AD domain server and SMB Server. |
| 7. | AZU-NETAPP-SC_040 | Azure NetApp Files volumes must not use NFSv3 | Azure NetApp Files volumes must not use NFSv3 (What) within Volumes > export policy settings (How) to use modern techniques to establish robust encrypted data channels (Why) | True | True | This control is implemented by setting `protocols` value set to `NFSv4.1`. |
| 8. | AZU-NETAPP-SC_050 | Azure NetApp Files NFS Volumes of type NFSv4.1 must use Kerberos data integrity or data privacy | Azure NetApp Files NFS Volumes of type NFSv4.1 must use Kerberos data integrity or data privacy (What) within Export policy settings (How) to use modern techniques to establish robust encrypted data channels (Why) | True | True | This control is implemented by setting `protocols_enabled` value set to `NFSv4.1`. |
| 9. | AZU-NETAPP-SC_060 | Azure NetApp Files Volumes must use Standard networking features | Azure NetApp Files Volumes must use Standard networking features (What) within code deployment settings (How) to use modern techniques to establish robust encrypted data channels (Why) | True | True | This control is implemented by setting `network_features` value set to `Standard`. |

## Changelog

- [azure-prdsvc-terraform-netapppool](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/azure-netapp-files/azure-netapp-files-set-up-capacity-pool)

### Terraform Docs

- [azurerm_netapp_pool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_pool#account_name)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm) | >= 3.51 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | >= 3.51 |

## Resources

| Name | Type |
|------|------|
| [azurerm_netapp_pool.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_pool) | resource |
| [azurerm_netapp_volume.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_volume) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_name"></a> [account_name](#input_account_name) | (Required) The name of the NetApp account in which the NetApp Pool should be created. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_encryption_type"></a> [encryption_type](#input_encryption_type) | (Optional) The encryption type of the pool. Valid values include Single, and Double. Defaults to Single. Changing this forces a new resource to be created. | `string` | `"Single"` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_net_app_volumes"></a> [net_app_volumes](#input_net_app_volumes) | (Optional) Configuration for Kusto database Principal assignments is below.<br/>    name                                 = "(Required) The name of the NetApp Pool. Changing this forces a new resource to be created."<br/>    zone                                 = " (Optional) Specifies the Availability Zone in which the Volume should be located. Possible values are 1, 2 and 3. Changing this forces a new resource to be created. This feature is currently in preview, for more information on how to enable it, please refer to Manage availability zone volume placement for Azure NetApp Files."<br/>    account_name                         = "(Required) The name of the NetApp account in which the NetApp Pool should be created. Changing this forces a new resource to be created."<br/>    volume_path                          = "(Required) A unique file path for the volume. Used when creating mount targets. Changing this forces a new resource to be created."<br/>    azure_vmware_data_store_enabled      = "(Optional) Is the NetApp Volume enabled for Azure VMware Solution (AVS) datastore purpose. Defaults to false. Changing this forces a new resource to be created."<br/>    protocols                            = "(Optional) The target volume protocol expressed as a list. Supported single value include CIFS, NFSv3, or NFSv4.1. If argument is not defined it will default to NFSv3. Changing this forces a new resource to be created and data will be lost. Dual protocol scenario is supported for CIFS and NFSv3, for more information, please refer to Create a dual-protocol volume for Azure NetApp Files document."<br/>    security_style                       = " (Optional) Volume security style, accepted values are unix or ntfs. If not provided, single-protocol volume is created defaulting to unix if it is NFSv3 or NFSv4.1 volume, if CIFS, it will default to ntfs. In a dual-protocol volume, if not provided, its value will be ntfs. Changing this forces a new resource to be created."<br/>    subnet_id                            = "(Required) The ID of the Subnet the NetApp Volume resides in, which must have the Microsoft.NetApp/volumes delegation. Changing this forces a new resource to be created."<br/>    network_features                     = "(Optional) Indicates which network feature to use, accepted values are Basic or Standard, it defaults to Basic if not defined. This is a feature in public preview and for more information about it and how to register, please refer to Configure network features for an Azure NetApp Files volume."<br/>    storage_quota_in_gb                  = "(Required) The maximum Storage Quota allowed for a file system in Gigabytes."<br/>    snapshot_directory_visible           = " (Optional) Specifies whether the .snapshot (NFS clients) or ~snapshot (SMB clients) path of a volume is visible, default value is true."<br/>    create_from_snapshot_resource_id     = "(Optional) Creates volume from snapshot. Following properties must be the same as the original volume where the snapshot was taken from: protocols, subnet_id, location, service_level, resource_group_name, account_name and pool_name. Changing this forces a new resource to be created."<br/>    throughput_in_mibps                  = "(Optional) Throughput of this volume in Mibps."<br/>    encryption_key_source                = "(Optional) The encryption key source, it can be Microsoft.NetApp for platform managed keys or Microsoft.KeyVault for customer-managed keys. This is required with key_vault_private_endpoint_id. Changing this forces a new resource to be created."<br/>    kerberos_enabled                     = "(Optional) Enable to allow Kerberos secured volumes. Requires appropriate export rules."<br/>    key_vault_private_endpoint_id        = "(Optional) The Private Endpoint ID for Key Vault, which is required when using customer-managed keys. This is required with encryption_key_source. Changing this forces a new resource to be created."<br/>    smb_non_browsable_enabled            = "(Optional) Limits clients from browsing for an SMB share by hiding the share from view in Windows Explorer or when listing shares in "net view." Only end users that know the absolute paths to the share are able to find the share. Defaults to false. For more information, please refer to Understand NAS share permissions in Azure NetApp Files."<br/>    smb_access_based_enumeration_enabled = "(Optional) Limits enumeration of files and folders (that is, listing the contents) in SMB only to users with allowed access on the share. For instance, if a user doesn't have access to read a file or folder in a share with access-based enumeration enabled, then the file or folder doesn't show up in directory listings. Defaults to false. For more information, please refer to Understand NAS share permissions in Azure NetApp Files."<br/>    smb_continuous_availability_enabled  = "(Optional) Enable SMB Continuous Availability."<br/>    data_protection_replication          = "(Optional) A data_protection_replication block as defined below. Changing this forces a new resource to be created."<br/>      endpoint_type                      = "(Optional) The endpoint type, default value is dst for destination."<br/>      remote_volume_location             = "(Required) Location of the primary volume. Changing this forces a new resource to be created."<br/>      remote_volume_resource_id          = "(Required) Resource ID of the primary volume."<br/>      replication_frequency              = "(Required) Replication frequency, supported values are '10minutes', 'hourly', 'daily', values are case sensitive."<br/>    data_protection_snapshot_policy      = "(Optional) A data_protection_snapshot_policy block is used when automatic snapshots for a volume based on a specific snapshot policy. It supports the following:"<br/>      snapshot_policy_id                 = "(Required) Resource ID of the snapshot policy to apply to the volume."<br/>    export_policy_rule                   = "(Optional) An export_policy_rule block supports the following:"<br/>      rule_index                         = "(Required) The index number of the rule."<br/>      allowed_clients                    = "(Required) A list of allowed clients IPv4 addresses."<br/>      protocols_enabled                  = "(Optional) A list of allowed protocols. Valid values include CIFS, NFSv3, or NFSv4.1. Only one value is supported at this time. This replaces the previous arguments: cifs_enabled, nfsv3_enabled and nfsv4_enabled."<br/>      unix_read_only                     = "(Optional) Is the file system on unix read only?"<br/>      unix_read_write                    = "(Optional) Is the file system on unix read and write?"<br/>      root_access_enabled                = "(Optional) Is root access permitted to this volume?"<br/>      kerberos_5_read_only_enabled       = "(Optional) Is Kerberos 5 read-only access permitted to this volume?"<br/>      kerberos_5_read_write_enabled      = "(Optional) Is Kerberos 5 read/write permitted to this volume?"<br/>      kerberos_5i_read_only_enabled      = "(Optional) Is Kerberos 5i read-only permitted to this volume?"<br/>      kerberos_5i_read_write_enabled     = "(Optional) Is Kerberos 5i read/write permitted to this volume?"<br/>      kerberos_5p_read_only_enabled      = "(Optional) Is Kerberos 5p read-only permitted to this volume?"<br/>      kerberos_5p_read_write_enabled     = "(Optional) Is Kerberos 5p read/write permitted to this volume?" | <pre>map(object({<br/>    name                                 = string<br/>    zone                                 = optional(number)<br/>    account_name                         = string<br/>    volume_path                          = string<br/>    azure_vmware_data_store_enabled      = optional(bool)<br/>    protocols                            = optional(list(string))<br/>    security_style                       = optional(string)<br/>    subnet_id                            = string<br/>    storage_quota_in_gb                  = string<br/>    snapshot_directory_visible           = optional(string)<br/>    create_from_snapshot_resource_id     = optional(string)<br/>    throughput_in_mibps                  = optional(number)<br/>    kerberos_enabled                     = optional(string)<br/>    key_vault_private_endpoint_id        = optional(string)<br/>    smb_non_browsable_enabled            = optional(bool)<br/>    smb_access_based_enumeration_enabled = optional(bool)<br/>    smb_continuous_availability_enabled  = optional(bool)<br/>    data_protection_replication = optional(map(object({<br/>      endpoint_type             = optional(string)<br/>      remote_volume_location    = string<br/>      remote_volume_resource_id = string<br/>      replication_frequency     = string<br/>    })))<br/>    data_protection_snapshot_policy = optional(map(object({<br/>      snapshot_policy_id = string<br/>    })))<br/>    export_policy_rule = optional(map(object({<br/>      rule_index                     = number<br/>      allowed_clients                = list(string)<br/>      protocols_enabled              = optional(list(string))<br/>      unix_read_only                 = optional(string)<br/>      unix_read_write                = optional(string)<br/>      root_access_enabled            = optional(string)<br/>      kerberos_5_read_only_enabled   = optional(string)<br/>      kerberos_5_read_write_enabled  = optional(string)<br/>      kerberos_5i_read_only_enabled  = optional(string)<br/>      kerberos_5i_read_write_enabled = optional(string)<br/>      kerberos_5p_read_only_enabled  = optional(string)<br/>      kerberos_5p_read_write_enabled = optional(string)<br/>    })))<br/>  }))</pre> | `{}` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_qos_type"></a> [qos_type](#input_qos_type) | (Optional) QoS Type of the pool. Valid values include Auto or Manual. | `string` | `"Auto"` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_service_level"></a> [service_level](#input_service_level) | (Required) The service level of the file system. Valid values include Premium, Standard, and Ultra. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_size_in_tb"></a> [size_in_tb](#input_size_in_tb) | (Required) Provisioned size of the pool in TB. Value must be between 2 and 500. | `number` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The Resource ID of the NetApp Pool. |
| <a name="output_name"></a> [name](#output_name) | The Name of the Azure NetApp Pool. |
| <a name="output_netappvolume_ids"></a> [netappvolume_ids](#output_netappvolume_ids) | The IDs of the NetApp Volume. |
| <a name="output_netappvolume_names"></a> [netappvolume_names](#output_netappvolume_names) | The Names of the NetApp Volumes. |
| <a name="output_netappvolume_resource"></a> [netappvolume_resource](#output_netappvolume_resource) | The Resource of the NetApp Volumes. |
| <a name="output_resource"></a> [resource](#output_resource) | The NetApp Pool resource. |
<!-- END_TF_DOCS -->
