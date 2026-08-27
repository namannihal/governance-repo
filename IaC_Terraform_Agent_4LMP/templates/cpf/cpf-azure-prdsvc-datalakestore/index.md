---
version: 1.1.0
available_versions:
  - 1.1.0
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.8.1
---

<!-- BEGIN_TF_DOCS -->
# Data Lake Store module

## Overview

- This terraform module creates a Azure Data Lake Gen2 storage Account and associated resources.
- A lifecycle management policy is composed of one or more rules that define a set of actions to take based on a condition being met. The policy acts on a base blob, and optionally on the blob's versions or snapshots. For more details, please refer [Lifecycle_Management_Policy_Configure](https://learn.microsoft.com/en-us/azure/storage/blobs/lifecycle-management-policy-configure).

## Prerequisites

- Exisiting `resource_group` and `virtual_network`
- One `user_assign_identity` to encypt storage account data.
- One `key_vault` to store the encryption key.
- One `Private endpoint` for `keyvault`
- One `subnet` to configure private endpoint.
- One `route table` to associate with the subnet
- One `network_security_group` to associate with the subnet
- One `time_sleep` to wait for creation of DNS record post key vault private endpoint deployment through DINE policy.

## Guidance

#### Usage

- Creates a storage account with `is_hns_enabled` property enabled, i.e. enabling hierarchical namespace for Azure Data Lake Storage Gen2.
- The Storage Account requires account_kind to be either `StorageV2` or `BlockBlobStorage`. In addition, `is_hns_enabled` to be set to true.
- Additionally, `sftp_enabled` SFTP support can also be enabled if `is_hns_enabled` set to true
- Also, `nfsv3_enabled` NFSv3 protocol can be enabled further if `is_hns_enabled` set to true
- Since the data lake store name is limited to maximum length 24 chars, the sum of context and instance variable must be atmost 7 chars. For example if you need to use 3 chars for the instance number, the context will be limited to 4 chars.
- The `match_blob_index_tag` property requires enabling the blobIndex feature with [PSH or CLI commands](https://azure.microsoft.com/en-us/blog/manage-and-find-data-with-blob-index-for-azure-storage-now-in-preview/).
- `match_blob_index_tag` is not supported as a filter for versions and snapshots.
- `base_blob`, a part of `actions` block of the Storage Account Management Policy have following points to be noted:
  - The `tier_to_cool_after_days_since_modification_greater_than`, `tier_to_cool_after_days_since_last_access_time_greater_than` and `tier_to_cool_after_days_since_creation_greater_than` can not be set at the same time.

  - The `auto_tier_to_hot_from_cool_enabled` must be used together with `tier_to_cool_after_days_since_last_access_time_greater_than`.

  - The `tier_to_archive_after_days_since_modification_greater_than`,`tier_to_archive_after_days_since_last_access_time_greater_than` and `tier_to_archive_after_days_since_creation_greater_than` can not be set at the same time.

  - The `tier_to_cool_after_days_since_modification_greater_than`,  `tier_to_cool_after_days_since_last_access_time_greater_than` and `tier_to_cool_after_days_since_creation_greater_than` can not be set at the same time.

  - The `delete_after_days_since_modification_greater_than`, `delete_after_days_since_last_access_time_greater_than` and `delete_after_days_since_creation_greater_than` can not be set at the same time.

  - The `last_access_time_enabled` must be set to true in the azurerm_storage_account in order to use `tier_to_cool_after_days_since_last_access_time_greater_than`, `tier_to_archive_after_days_since_last_access_time_greater_than` and `delete_after_days_since_last_access_time_greater_than`.

- Use `key_vault_tags` variable to define additional Key Vault Keys/Secret related tags in your product, and you can not have more than 2 tags (key-value pairs), as the product gets a default of 13 tags and Key Vault child resources support only 15 tags as the maximum limit. Reference link - [Key tags](https://learn.microsoft.com/en-us/azure/key-vault/keys/about-keys-details#key-tags)

- Use the `tags` variable to define additional tags related to the product (core). Note that the product already has a default of 13 tags, so if you are adding multiple additional tags (key-value pairs), ensure the total count does not exceed the limit supported by Azure resources. [Azure Resources Tag Limitation](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/tag-support)

#### Security Considerations

- `public_network_access_enabled` to the storage account can be set as true with default as false. When network_access_enabled as set as true, it allows to choose selective subnets, "Enabled from selected virtual networks and IP address". By default , the default action is deny when no other rules match.

## Security Controls

- Azure data lake store doesn't have any security control available currently.

- The following security control is inherited from the storage account.

| S. No. | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|--------|------------|---------------|-------------|-------------|---------------------|----------|
| 1.    | AZU-SA-SC_060 | File shares must use a minimum SMB 3.1.1 protocol with AES-256-GCM channel encryption | File shares must use a minimum SMB 3.1.1 protocol with AES-256-GCM channel encryption (What) within SMB protocol settings (How) in order to use modern techniques to establish robust encrypted data channels (Why) | True | True | Control implented via `share_properties{}` block in the module. Along with AES-256-GCM channel encryption, AES-128-GCM encyption is also enabled within SMB protocol settings, to support few special azure resources like Function app and VMSS integration with file share which require AES-128-GCM encyption to be enabled. |

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control is implemented by generating names using the resource naming module.<br><br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandatory` and most of the `Optional` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Monitor Azure Data Lake](https://learn.microsoft.com/en-us/previous-versions/azure/data-lake-store/data-lake-store-diagnostic-logs)<br><br>[Cloud monitoring service level objectives](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives)<br><br>[Supported Metrics for Azure Data Lake](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-datalakestore-accounts-metrics) |
| 5. | [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | True | For high availability and replication geo-redundant storage (GRS) is enabled for  `account_replication_type` variable, For redundancy purposes.<br><br>[High Availability For Logic App Workflow](https://learn.microsoft.com/en-us/azure/logic-apps/logic-apps-overview#create-and-deploy-to-different-environments) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application teams' requirements.<br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place.<br><br>[Azure built-in roles](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles)<br><br>[Data-Lakes-Store-Authentication](https://learn.microsoft.com/en-us/previous-versions/azure/data-lake-store/data-lakes-store-authentication-using-azure-active-directory) |

## Changelog

- [azure-prdsvc-terraform-datalakestore](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-introduction)

### Terraform Docs

- [azurerm_storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account)

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
| [azurerm_key_vault_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_key_vault_secret.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_role_assignment.cmk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_encryption_scope.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_encryption_scope) | resource |
| [azurerm_storage_management_policy.lifecycle](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_management_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_tier"></a> [access_tier](#input_access_tier) | (Optional) Defines the Access Tier for the Storage Account.<br></br>&#8226; Possible values are: `Cool`, `Hot`. | `string` | `"Hot"` | no |
| <a name="input_account_kind"></a> [account_kind](#input_account_kind) | (Optional) Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. | `string` | `"StorageV2"` | no |
| <a name="input_account_replication_type"></a> [account_replication_type](#input_account_replication_type) | (Optional) Defines the type of replication to use for this storage account. Valid options for Standard Storage Account are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. GRS is not supported for Premium Storage Account. | `string` | `"GRS"` | no |
| <a name="input_account_tier"></a> [account_tier](#input_account_tier) | (Optional) Defines the Tier to use for this storage account. Valid options are Standard and Premium. | `string` | `"Standard"` | no |
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_cmk_key_name"></a> [cmk_key_name](#input_cmk_key_name) | (optional) Key name to be used (max 127 chars) | `string` | `null` | no |
| <a name="input_cmk_rotation_policy"></a> [cmk_rotation_policy](#input_cmk_rotation_policy) | (Optional) A rotation policy block as defined below<br/>object({<br/>  notify_before_expiry = "(Optional) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>  time_before_expiry   = "(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br/>  time_after_creation  = "(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br/>  expire_after         = "(Optional) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>}) | <pre>object({<br/>    notify_before_expiry = string<br/>    time_before_expiry   = string<br/>    time_after_creation  = optional(string, null)<br/>    expire_after         = string<br/>  })</pre> | <pre>{<br/>  "expire_after": "P365D",<br/>  "notify_before_expiry": "P358D",<br/>  "time_after_creation": null,<br/>  "time_before_expiry": "P7D"<br/>}</pre> | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_create_role_assignment"></a> [create_role_assignment](#input_create_role_assignment) | (Optional) Whether to create a role assignment to the service identity to allow access to the key vault keys. | `bool` | `true` | no |
| <a name="input_customer_managed_key"></a> [customer_managed_key](#input_customer_managed_key) | (Required) A customer_managed_key block as defined below<br/>object({<br/>  key_vault_id            = "(Required) The resource ID of the Key Vault where the Key Vault Key resides."<br/>  expiration_date         = "(Required) Expiration UTC datetime (Y-m-d'T'H:M:S'Z')."<br/>  identity_principal_id   = "(Required) The principal ID of the User Assigned Identity that has access to the key."<br/>}) | <pre>object({<br/>    key_vault_id          = string<br/>    expiration_date       = string<br/>    identity_principal_id = string<br/>  })</pre> | n/a | yes |
| <a name="input_default_to_oauth_authentication"></a> [default_to_oauth_authentication](#input_default_to_oauth_authentication) | (Optional) Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account | `bool` | `true` | no |
| <a name="input_edge_zone"></a> [edge_zone](#input_edge_zone) | (Optional) Specifies the Edge Zone within the Azure Region where this Storage Account should exist. Changing this forces a new Storage Account to be created. | `string` | `null` | no |
| <a name="input_enable_key_access"></a> [enable_key_access](#input_enable_key_access) | (Optional) If set to `false` any requests to the account that are authorized with Shared Key, including shared access signatures (SAS), will be denied. | `bool` | `true` | no |
| <a name="input_encryption_scopes"></a> [encryption_scopes](#input_encryption_scopes) | (Optional) Map of the encryption scopes in the Storage Account. | <pre>map(object({<br/>    name             = string<br/>    key_vault_key_id = string<br/>  }))</pre> | `{}` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_identity"></a> [identity](#input_identity) | (Required) An identity block as defined below<br/>object({<br/>  type         = "(Required) Specifies the type of Managed Service Identity that should be configured on this Storage Account. Possible values are `UserAssigned`, `SystemAssigned, UserAssigned` (to enable both)."<br/>  identity_ids = "(Required) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Storage Account. This is required when `type` is set to `UserAssigned` or `SystemAssigned, UserAssigned`."<br/>}) | <pre>object({<br/>    type         = string<br/>    identity_ids = list(string)<br/>  })</pre> | n/a | yes |
| <a name="input_infrastructure_encryption_enabled"></a> [infrastructure_encryption_enabled](#input_infrastructure_encryption_enabled) | (Optional) Determines if the Infrastruction Encryption of the storage account should be enabled or disabled. | `string` | `true` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_key_vault_id"></a> [key_vault_id](#input_key_vault_id) | (Required) ID of the existing Key vault to store the Customer Managed Key for Encryption. | `string` | n/a | yes |
| <a name="input_key_vault_tags"></a> [key_vault_tags](#input_key_vault_tags) | (Optional) Key Vault related tags to be set on key vault child resources. | `map(any)` | `{}` | no |
| <a name="input_kv_secret_expiration_date"></a> [kv_secret_expiration_date](#input_kv_secret_expiration_date) | (Required) Expiration UTC datetime (Y-m-d'T'H:M:S'Z') for Storage Account access key Key vault Secret. | `string` | n/a | yes |
| <a name="input_large_file_share_enabled"></a> [large_file_share_enabled](#input_large_file_share_enabled) | (Optional) Set to `true`, the Storage Account will be enabled for large file shares. | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_network_access_enabled"></a> [network_access_enabled](#input_network_access_enabled) | Enable or disable public network access for the storage account. | `bool` | `false` | no |
| <a name="input_network_rules"></a> [network_rules](#input_network_rules) | (Optional) A network_rules block as defined below<br/>object({<br/>  default_action             = "(Required) The Default Action to use when no rules match ip_rules / virtual_network_subnet_ids. Possible values are `\"Allow\"` and `\"Deny\"`."<br/>  bypass                     = "(Optional) Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of [`\"Logging\"`, `\"Metrics\"`, `\"AzureServices\"`, `\"None\"`]."<br/>  ip_rules                   = "(Optional) One or more Public IP Addresses or CIDR Blocks which should be able to access the Storage Account."<br/>  virtual_network_subnet_ids = "(Optional) One or more Subnet IDs which should be able to access the Storage Account."<br/>}) | <pre>object({<br/>    bypass                     = list(string)<br/>    ip_rules                   = list(string)<br/>    virtual_network_subnet_ids = list(string)<br/>  })</pre> | <pre>{<br/>  "bypass": [<br/>    "AzureServices"<br/>  ],<br/>  "ip_rules": [],<br/>  "virtual_network_subnet_ids": []<br/>}</pre> | no |
| <a name="input_nfsv3_enabled"></a> [nfsv3_enabled](#input_nfsv3_enabled) | (Optional) Set to `true`, the `NFSV3` protocol will be enabled. | `bool` | `false` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_persist_access_key"></a> [persist_access_key](#input_persist_access_key) | (Optional) Set `true` to store storage access key in `key vault`. | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_retention_policy_days"></a> [retention_policy_days](#input_retention_policy_days) | (Optional) Specifies the number of days that the containers, blob and  share should be retained, the value must be between between 1 and 365. | `number` | `30` | no |
| <a name="input_rules"></a> [rules](#input_rules) | (Optional) A map of rule block as documented below:<br/>object({<br/>  name    = "(Required) The name of the rule. The rule name is case-sensitive. It must be unique within a policy."<br/>  enabled = "(Required) Specify whether the rule is enabled."<br/>  filters = "(Required) The filters block supports the following:<br/>  object({<br/>    blob_types           = "(Required) An array of predefined values. The possible values are `blockBlob` and `appendBlob`."<br/>    prefix_match         = "(Optional) An array of strings for prefixes to be matched."<br/>    match_blob_index_tag = "(Optional) A `match_blob_index_tag` block defined as follows. The block defines the blob index tag-based filtering for blob objects."<br/>    object({<br/>      name      = "(Required) The filter tag name used for tag-based filtering for blob objects."<br/>      operation = "(Optional) The comparison operator that is used for object comparison and filtering. The possible value is `==`. Defaults to `==`."<br/>      value     = "(Required) The filter tag value used for tag-based filtering for blob objects."<br/>    })<br/>  })"<br/>  actions = "(Required) An actions block defined as follows:<br/>  object({<br/>    base_blob = (Optional) A base_blob block defined as follows:<br/>    object({<br/>      tier_to_cool_after_days_since_modification_greater_than        = "(Optional) The age in days after last modification to tier blobs to cool storage. Supports blob currently at Hot tier. Must be between `0` and `99999`."<br/>      tier_to_cool_after_days_since_last_access_time_greater_than    = "(Optional) The age in days after last access time to tier blobs to cool storage. Supports blob currently at Hot tier. Must be between `0` and `99999`."<br/>      tier_to_cool_after_days_since_creation_greater_than            = "(Optional) The age in days after creation to cool storage. Supports blob currently at Hot tier. Must be between `0` and `99999`."<br/>      auto_tier_to_hot_from_cool_enabled                             = "(Optional) Specifies whether a blob should automatically be tiered from cool back to hot if it's accessed again after being tiered to cool. Defaults to false."<br/>      tier_to_archive_after_days_since_modification_greater_than     = "(Optional) The age in days after last modification to tier blobs to archive storage. Supports blob currently at Hot or Cool tier. Must be between `0` and `99999`."<br/>      tier_to_archive_after_days_since_last_access_time_greater_than = "(Optional) The age in days after last access time to tier blobs to archive storage. Supports blob currently at Hot or Cool tier. Must be between 0 and99999."<br/>      tier_to_archive_after_days_since_creation_greater_than         = "(Optional) The age in days after creation to archive storage. Supports blob currently at Hot or Cool tier. Must be between 0 and99999."<br/>      tier_to_archive_after_days_since_last_tier_change_greater_than = "(Optional) The age in days after last tier change to the blobs to skip to be archved. Must be between `0` and `99999`."<br/>      tier_to_cold_after_days_since_modification_greater_than        = "(Optional) The age in days after last modification to tier blobs to cold storage. Supports blob currently at Hot tier. Must be between `0` and `99999`."<br/>      tier_to_cold_after_days_since_last_access_time_greater_than    = "(Optional) The age in days after last access time to tier blobs to cold storage. Supports blob currently at Hot tier. Must be between `0` and `99999`."<br/>      tier_to_cold_after_days_since_creation_greater_than            = "(Optional) The age in days after creation to cold storage. Supports blob currently at Hot tier. Must be between `0` and `99999`."<br/>      delete_after_days_since_modification_greater_than              = "(Optional) The age in days after last modification to delete the blob. Must be between `0` and `99999`."<br/>      delete_after_days_since_last_access_time_greater_than          = "(Optional) The age in days after last access time to delete the blob. Must be between `0` and `99999`."<br/>      delete_after_days_since_creation_greater_than                  = "(Optional) The age in days after creation to delete the blob. Must be between `0` and `99999`."<br/>    })<br/>    snapshot = (Optional) A snapshot block as documented below:<br/>    object({<br/>      change_tier_to_archive_after_days_since_creation               = "(Optional) The age in days after creation to tier blob snapshot to archive storage. Must be between `0` and `99999`."<br/>      tier_to_archive_after_days_since_last_tier_change_greater_than = "(Optional) The age in days after last tier change to the blobs to skip to be archved. Must be between `0` and `99999`."<br/>      change_tier_to_cool_after_days_since_creation                  = "(Optional) The age in days after creation to tier blob snapshot to cool storage. Must be between `0` and `99999`."<br/>      tier_to_cold_after_days_since_creation_greater_than            = "(Optional) The age in days after creation to cold storage. Supports blob currently at Hot tier. Must be between `0` and `99999`."<br/>      delete_after_days_since_creation_greater_than                  = "(Optional) The age in days after creation to delete the blob snapshot. Must be between `0` and `99999`."<br/>    })<br/>    version = (Optional) A version block as documented below:<br/>    object({<br/>      change_tier_to_archive_after_days_since_creation               = "(Optional) The age in days after creation to tier blob version to archive storage. Must be between `0` and `99999`."<br/>      tier_to_archive_after_days_since_last_tier_change_greater_than = "(Optional) The age in days after last tier change to the blobs to skip to be archved. Must be between `0` and `99999`."<br/>      change_tier_to_cool_after_days_since_creation                  = "(Optional) The age in days creation create to tier blob version to cool storage. Must be between `0` and `99999`."<br/>      tier_to_cold_after_days_since_creation_greater_than            = "(Optional) The age in days after creation to cold storage. Supports blob currently at Hot tier. Must be between `0` and `99999`."<br/>      delete_after_days_since_creation                               = "(Optional) The age in days after creation to delete the blob version. Must be between `0` and `99999`."<br/>    })<br/>  })"<br/>}) | <pre>map(object({<br/>    name    = string<br/>    enabled = bool<br/>    filters = object({<br/>      blob_types   = set(string)<br/>      prefix_match = set(string)<br/>      match_blob_index_tag = optional(object({<br/>        name      = string<br/>        operation = optional(string, "==")<br/>        value     = string<br/>      }))<br/>    })<br/>    actions = object({<br/>      base_blob = optional(object({<br/>        tier_to_cool_after_days_since_modification_greater_than        = optional(number)<br/>        tier_to_cool_after_days_since_last_access_time_greater_than    = optional(number)<br/>        tier_to_cool_after_days_since_creation_greater_than            = optional(number)<br/>        auto_tier_to_hot_from_cool_enabled                             = optional(bool, false)<br/>        tier_to_archive_after_days_since_modification_greater_than     = optional(number)<br/>        tier_to_archive_after_days_since_last_access_time_greater_than = optional(number)<br/>        tier_to_archive_after_days_since_creation_greater_than         = optional(number)<br/>        tier_to_archive_after_days_since_last_tier_change_greater_than = optional(number)<br/>        tier_to_cold_after_days_since_modification_greater_than        = optional(number)<br/>        tier_to_cold_after_days_since_last_access_time_greater_than    = optional(number)<br/>        tier_to_cold_after_days_since_creation_greater_than            = optional(number)<br/>        delete_after_days_since_modification_greater_than              = optional(number)<br/>        delete_after_days_since_last_access_time_greater_than          = optional(number)<br/>        delete_after_days_since_creation_greater_than                  = optional(number)<br/>      }))<br/>      snapshot = optional(object({<br/>        change_tier_to_archive_after_days_since_creation               = optional(number)<br/>        tier_to_archive_after_days_since_last_tier_change_greater_than = optional(number)<br/>        change_tier_to_cool_after_days_since_creation                  = optional(number)<br/>        tier_to_cold_after_days_since_creation_greater_than            = optional(number)<br/>        delete_after_days_since_creation_greater_than                  = optional(number)<br/>      }))<br/>      version = optional(object({<br/>        change_tier_to_archive_after_days_since_creation               = optional(number)<br/>        tier_to_archive_after_days_since_last_tier_change_greater_than = optional(number)<br/>        change_tier_to_cool_after_days_since_creation                  = optional(number)<br/>        tier_to_cold_after_days_since_creation_greater_than            = optional(number)<br/>        delete_after_days_since_creation                               = optional(number)<br/>      }))<br/>    })<br/>  }))</pre> | `{}` | no |
| <a name="input_sftp_enabled"></a> [sftp_enabled](#input_sftp_enabled) | (Optional) Boolean, enable SFTP for the storage account. SFTP support requires is_hns_enabled set to true. Defaults to false | `bool` | `false` | no |
| <a name="input_smb_settings"></a> [smb_settings](#input_smb_settings) | (Optional) SMB settings for the storage account. | <pre>object({<br/>    versions                = list(string)<br/>    channel_encryption_type = set(string)<br/>  })</pre> | <pre>{<br/>  "channel_encryption_type": [<br/>    "AES-256-GCM"<br/>  ],<br/>  "versions": [<br/>    "SMB3.1.1"<br/>  ]<br/>}</pre> | no |
| <a name="input_storage_policy_required"></a> [storage_policy_required](#input_storage_policy_required) | (Optional) Specifies whether the storage account management policy is required. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The ID of the Storage Account. |
| <a name="output_name"></a> [name](#output_name) | The name of the Storage Account. |
| <a name="output_resource"></a> [resource](#output_resource) | The Storage Account resource. |
<!-- END_TF_DOCS -->
