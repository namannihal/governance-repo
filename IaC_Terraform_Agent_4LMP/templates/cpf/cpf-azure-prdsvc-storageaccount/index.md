---
version: 1.2.4
available_versions:
  - 1.2.4
  - 1.2.3
  - 1.2.2
  - 1.2.1
  - 1.2.0
---

<!-- BEGIN_TF_DOCS -->
# Storage Account Module ReadMe


## Overview

- This terraform module creates the Azure storage account and optionally configures an Azure blob lifecycle management policy.

- An Azure storage account can contain various types of storage including blob storage, file storage, queue storage, or table storage.

- The storage account offers a unique namespace for Azure storage data, accessible globally over HTTPS.

- The data within a storage account is durable, highly available, secure, and scalable.

- A lifecycle management policy is consists of one or more rules that define actions based on specific conditions. The policy applies to base blob and optionally on the blob's versions or snapshots. For more information, refer to[Lifecycle_Management_Policy_Configure](https://learn.microsoft.com/en-us/azure/storage/blobs/lifecycle-management-policy-configure).

- You can serve static content (HTML, CSS, JavaScript, and image files) directly from a storage container named $web. Hosting the content in Azure Storage allows you to utilize serverless architectures including Azure functions and other Platform as a Service (PaaS) services. Azure `Storage static website hosting` is ideal when the  web server is not required to render content.

- To enable `Static website hosting` feature, select your default file name and optionally specify a custom 404 page path. For more information, refer to [Microsoft](https://learn.microsoft.com/en-gb/azure/storage/blobs/storage-blob-static-website).

## Product Version

Refer to the following changelog document for the current product version, previous versions, and the revision history:

[azure-prdsvc-terraform-storageaccount](CHANGELOG.md)

## Prerequisites

- Ensure that the following prerequisites are met:

- A `Resource Group` name is required.  

- A `Key Vault` must be created first, if it does not already exist, to save the sensitive information such as `access key` to the storage account.

**Note:** The `Key Vault` creation is managed by a module call.

### Dependent Cloud Products

There are no dependent cloud products in the current version of the product.

## Requirements

This section is generated automatically through the .tfdocs pipeline.

### Provider Versions

This section is generated automatically through the .tfdocs pipeline.

### Resources

This section is generated automatically through the .tfdocs pipeline.

## Guidance

#### Usage

###### AzureRM 3.x to 4.x Upgrade Notes for Storage Account

Product Impact -- LOW

Users in azurerm 3.x migrating to 4.x  need to perform the following changes
  - Introduced new Optional Variable  `https_traffic_only_enabled` with default as true  and replaced the deprecated variable `enable_https_traffic_only` with the new variable.

  - Wiki link for [AzureRM 4.x Upgrade](https://gitlab.dx1.lseg.com/groups/app/app-51310/azure/prdsvc/terraform/-/wikis/Terraform-AzureRM-Provider-Upgrade:-Version-3.x-to-4.x/storageaccount) for details on the upgrade process.

For more details, refer to the official [AzureRM 4.x Upgrade Guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide)

###### Others
- This module is tested locally with public access enabled for the storage account. Testing with public access completely disabled will be performed once the self-hosted agents are available to run the pipeline.

- To connect the private endpoint to the remote resource without having the correct RBAC permissions on the remote resource, set `is_manual_connection` value to `true`.

- The `Storage Account` only supports one sub-resource per private endpoint.

- The `match_blob_index_tag` property requires enabling the blobIndex feature with [PSH or CLI commands](https://azure.microsoft.com/en-us/blog/manage-and-find-data-with-blob-index-for-azure-storage-now-in-preview/).

- The `match_blob_index_tag` is not supported as a filter for versions and snapshots.

- The `base_blob` which is a part of `actions` block of the Storage Account Management Policy have following points to be noted:

  - The `tier_to_cool_after_days_since_modification_greater_than`, `tier_to_cool_after_days_since_last_access_time_greater_than` and `tier_to_cool_after_days_since_creation_greater_than` can not be set at the same time.

  - The `auto_tier_to_hot_from_cool_enabled` must be used together with `tier_to_cool_after_days_since_last_access_time_greater_than`.

  - The `tier_to_archive_after_days_since_modification_greater_than`,`tier_to_archive_after_days_since_last_access_time_greater_than` and `tier_to_archive_after_days_since_creation_greater_than` can not be set at the same time.

  - The `tier_to_cool_after_days_since_modification_greater_than`,  `tier_to_cool_after_days_since_last_access_time_greater_than` and `tier_to_cool_after_days_since_creation_greater_than` can not be set at the same time.

  - The `delete_after_days_since_modification_greater_than`, `delete_after_days_since_last_access_time_greater_than` and `delete_after_days_since_creation_greater_than` can not be set at the same time.

  - The `last_access_time_enabled` must be set to `true` in the azurerm_storage_account in order to use `tier_to_cool_after_days_since_last_access_time_greater_than`, `tier_to_archive_after_days_since_last_access_time_greater_than` and `delete_after_days_since_last_access_time_greater_than`.

- The `static_website` is only set when the `account_kind` is set to `StorageV2` or `BlockBlobStorage`.

## Outputs

- This section is generated automatically through the .tfdocs pipeline.

#### Security Considerations

The following are the security measures that need to be considered when working on the project:

- The `public_network_access_enabled` setting for the storage account has been configured to false, so the module will only be utilized via self hosted agents. If you try to run the module using Microsoft hosted agents will result in the error.

- To store the storage account `access key` in `key vault` set the variable `persist_access_key` to `true`.

- The `shared_access_key_enabled` control in this storage module has not been configured to `false`, rather it is parameterised to allow the user to enable or disable as per the requirement. Reason: If it is set to `false`, all requests including shared access signatures, must be authorized using Azure Active Directory (Azure AD). The Azure Storage supports Azure AD authorization only for Blob Storage and Queue Storage. If the Shared Key authorization is dissabled for storage account, the Azure Files data in the Azure portal will not be accessible.

- If the `shared_access_key_enabled` attribute is set to `false` via the input parameter `enable_key_access`, a flag `storage_use_azuread = true`must be added in the providers block so that terraform can authenticate to storage account using Azure AD authentication.

- Azure Directory Domain Services (AD DS) authentication for Azure file share depends on the availability of the Azure Active Directory Domain Service(AAD DS) in the Azure Subscription. If the AAD DS is available in the subscription, pass `true` value to `enable_file_share_AADDS_authentication` variable. Currently the `false` value is passed for testing of storage account, as the AADDS are not created in the subscription.

- This module supports the creation of multiple encryption scopes while provisioning the storage account, but currently terraform is not supporting the association of encryption scope with containers and blobs. It could be implemented by other tools in the upcoming versions of this module. References: https://github.com/hashicorp/terraform-provider-azurerm/issues/12055, https://github.com/hashicorp/terraform-provider-azurerm/issues/17272.

- To create an encryption scope in the Storage Account, the Storage Account identity must have **Key Vault Crypto Service Encryption User** role assigned to the key vault containing the encryption keys.

#### Well-Architected Framework(WAF) for Azure Storage Account

- Wiki link: [WAF for Azure Storage Account](https://gitlab.dx1.lseg.com/groups/app/app-51310/azure/prdsvc/terraform/-/wikis/Cloud-Products-Well-Architecture-Framework-Principles---WAF/Storage-Account) for details on the WAF principles (Resiliency and Disaster Recovery(DR), Security, Cost Optimization and Operation Excellence).

## Security Control Framework

| Sl. No. | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|--------|------------|---------------|-------------|-------------|---------------------|----------|
| 1  | `AZU-SA-IA_010` | Use a managed identity for accessing Azure resources. | **What?** If a managed identity is supported, the Storage Account must enforce the use of a managed identity to authenticate before using the Azure resources.<br> **How?** In the access control settings. <br> **Why?** To adhere to the principle of least privilege and remove the need to store the credentials.| True | True | Implemented using `identity{}` block in `azurerm_storage_acount` resource. This product does not support identity type `SystemAssigned` due to the CMK encryption constraints, either use `UserAssigned` or both `SystemAssigned, UserAssigned`. |
| 2  | `AZU-SA-IA_020` | Authentication to file shares must be via Azure Active Directory Domain Services. | **What?** Control Summary: Authentication to file shares must be via Active Directory Domain Services. <br> **How?** Within the SMB File share overview settings. <br> **Why?** To use the modern robust and less prone to compromise authentication methods. | True | False | To configure a File share to authenticate via Azure Active Directory Domain Services. It need an Azure Active Directory Domain Services resource deployed in the subscription, which is not available in the subscription during the tesing of this module. |
| 3  | `AZU-SA-IA_030` | Storage Account keys should only be enabled when a managed identity is not supported. |  **What?** within its Configuration. <br> **How?**  in order to use modern robust and less prone to compromise authentication methods within Entra ID. <br> **Why?** To use modern robust and less prone to compromise authentication methods imbedded within Azure Active Directory. | True | False | This control will be impleted via policy. Although, the module supports enabling or disabling the Storage Account Key Access as per the requirement.|
| 4  | `AZU-SA-IA_040` | Storage Account keys where approved must be regularly rotated with a maximum lifetime of 180 days. | **What?** Storage Account keys must be rotated regularly, with a maximum lifetime of 180 days.<br> **How?** In the Access Key settings.<br> **Why?** To comply with LSEG policy and reduce the risk of unauthorised access and data loss. | True | False | This control will be impleted via policy. |
| 5  | `AZU-SA-IA_050` | Shared Access Signatures (SAS) where approved for external access must apply resource and permission restrictions in accordance with the principle of least privilege, and IP address restrictions (where possible to apply). | **What?** SAS tokens must enforce resource and permission restrictions, and apply IP address restrictions where possible.<br> **How?** In the Shared Access Signature settings.<br> **Why?** To comply with LSEG policy and reduce the risk of unauthorised access and data loss. | True | True | Ensure SAS tokens are configured with the minimum required permissions, resource scope, and IP address restrictions, using Azure Policy or automation. |
| 4  | `AZU-SA-IA_060` | Storage Account Blob anonymous access must be disabled. | **What?** Blob anonymous access must be disabled.<br> **How?** In the Configuration Settings.<br> **Why?** To prevent unauthenticated access to resources and data loss. | True | True | Ensure the `allow_blob_public_access` property is set to `false` in the `azurerm_storage_account` resource to disable anonymous access. |
| 6  | `AZU-SA-AC_011` | Storage Account endpoints must be accessed via PrivateLink (preferred) or via public endpoint with select LSEG network addresses configured | **What?** Storage Account endpoints must be accessed via PrivateLink (preferred) or via public endpoint with select LSEG network addresses configured <br> **How?**  in order to prevent unauthorised access and data exposure to the interne  <br> **Why?** To prevent data exposure to the internet.  | True | False | Implemented using terraform resource argument: `public_network_access_enabled = true` and `default_action= Deny`|
| 7  | `AZU-SA-AU_010` | Send all diagnostic log categories to a central SOC Log Analytics workspace. | **What?** Storage Accounts must send all diagnostic logs to a central SOC Log Analytics workspace. <br> **How?** Within its diagnostic settings. <br> **Why?** To support a security investigation after a security incident involving a Storage Account. | False | False | This control will be implemented via policy. |
| 8  | `AZU-SA-AU_020` | Send all diagnostic log categories to a central SOC Storage Account. | **What?** Storage Accounts must send all diagnostic logs to a central SOC Storage Account.<br> **How?** Within its Diagnostic settings. <br> **Why?** To provide an immutable copy to adhere to compliance requirements. | False | False | This control will be implemented via policy. |
| 9  | `AZU-SA-AU_030` | Sending diagnostic logs to partner categories is permitted only after Cyber Security Risk Assessment and approval. | **What?** Sending diagnostic logs to partner categories is allowed only after a Cyber Security Risk Assessment and explicit approval. <br> **How?** Within Diagnostic settings. <br> **Why?** To prevent sensitive data leakage to third parties outside of LSEG control. | False | False | This control will be implemented via policy. |
| 9  | `AZU-SA-SC_010` | Network connections to the Storage Account control and data planes must use TLS encryption. | **What?** Storage Account must enforce network flow encryption in transit using TLS. <br> **How?** Via Deployment api rest settings. <br> **Why?** To use techniques to establish an encrypted data channels over untrusted networks.| True | True | Implemented using terrform resource argument: `enable_https_traffic_only = true`. |
| 10 | `AZU-SA-SC_020` | Use a minimum of TLS version 1.2 with HTTPS. |**What?** Storage Accounts must enforce a minimum TLS version of 1.2. <br> **How?** Within its configuration settings. <br> **Why?**  To use modern techniques to establish robust encrypted data channels over untrusted networks.| True | True | Implemented using terraform resource argument: `min_tls_version = "TLS1_2"`|
| 11 | `AZU-SA-SC_030` | Must use a dedicated CMK for Storage Account Transparent Data Encryption that is persisted in an HSM backed Key Vault for Blob, File Shares, Queues and Tables. |**What?** Use a dedicated Storage Account LSEG managed encryption at rest key persisted in an HSM backed Key Vault. <br> **How?** Within the deployment encryption settings. <br> **Why?** It should Microsoft's key management platform become compromised LSEG can revoke access to exfiltrated encrypted data. | True | True | CMK encryption has been implemented using HSM-RSA 4096 Key backed by a premium key vault, Implemted using `customer_managed_key` block within azurerm_storage_account resource. Queue and Table encryption is supported only when the account_kind is set to StorageV2 using arguments: `queue_encryption_key_type = var.cmk_enabled == true && var.account_kind == "StorageV2" ? "Account" : "Service"` and `table_encryption_key_type = var.cmk_enabled == true && var.account_kind == "StorageV2" ? "Account" : "Service"`. |
| 12 | `AZU-SA-SC_040`  | File Shares, Container, Blob and Tables must be segregated per distinct business purpose. |**What?**  File Shares, Container, Blob and Tables must be segregated per distinct business purpose, sufficient to allow granular access control and security settings in order to protect the stored data. <br> **How?** In deployment settings. <br> **Why?** To reduce the blast radius should any authentication credentials become compromised. | False | False | This depends on the design decision and can be taken into acccount while provisionig the Storage Account, Containers, Shares, Queues and Table using the modules. |
| 13 | `AZU-SA-SC_050` | Distinct business segregated Container or Blobs must be protected with a separate dedicated CMK per Container or Blob for Transparent Data Encryption that is persisted in an HSM backed Key Vault |**What?**  Distinct business segregated Container or Blobs must be protected with a separate dedicated CMK per Container or Blob for Transparent Data Encryption that is persisted in an HSM backed Key Vault. <br> **How?** In encryption scope settings <br> **Why?** should Microsoft's key management platform become compromised the blast area is limited and LSEG can revoke access to exfiltrated encrypted data.| True | False | This module supports the creation of  multiple encryption scopes while provisioning the storage account. The assoiciation of encryption scope with Conatiners and Blobs currently is not supported by the terraform, it could be implemented by other tools in the upcoming versions of this module. |
| 17 | `AZU-SA-SC_100` | Storage Accounts must have a data classification tag with one of the following values: Public, Corporate, Restricted, or Highly Restricted | **What?** Storage Accounts must have a data classification tag with one of the following values: Public, Corporate, Restricted, or Highly Restricted.<br> **How?** Within Tags setting.<br> **Why?** To differentiate assets' technical control requirements and to assist Security Operations in prioritising possible data breach mitigation responses. | False | False | The tag `data classification` is not hardcoded in the module; however, the module accepts tags as an input parameter during resource provisioning. Ensure the `data classification` tag and its value are provided as input when using this module. |
| 18 | `AZU-SA-SC_110` | Storage Accounts must disable Network File System (NFS) shares | **What?** Storage Accounts must disable Network File System (NFS) shares.<br> **How?** Within code deployment parameters.<br> **Why?** To prevent unencrypted data over untrusted networks. | True | False | Ensure the `nfsv3_enabled` property is set to `false` in the `azurerm_storage_account` resource to disable NFS shares. |
| 17 | `AZU-SA-SI_010`  | Disable Storage Account cross tenant replication. |**What?**  Storage Accounts must enforce the restriction of cross tenant replication.  <br> **How?**  Via its Object replication settings.<br> **Why?** To prevent data exfiltration.| True | True | Implemented using terraform resource argument: `cross_tenant_replication_enabled` = `false`.|
| 18 | `AZU-SA-SI_020`  | Storage Accounts must have a data classification tag |**What?** Storage Accounts must have a data classification tag. <br> **How?** Via its Tags settings. <br> **Why?** To differentiate assets technical control requirements and to assist Security Operations in prioritising possible data breach mitigation responses.| False | False | The tag `data classification` is not hardcoded in the module, whereas the module has capability to accept tags as input parameter during the resource provisioning. Tag `data classification` and corresponding value should be privided a input parameter while using this module. |
| 19 | `AZU-SA-SI_030` | Enable Soft Delete for Blob with a 30 day retention period. |**What?** Storage Accounts must enforce the use of Blob Soft Delete if blobs are being used with a retention period of 30 days. <br> **How?**  Within its Data protection settings. <br> **Why?** To recover data after an accidental or malicious deletion.| True | True | Implemented using `blob_properties` block in terraform `azurerm_storage_account` resource. The Default retention is set to 30 days and it can be changed during the provisiong of Storage Account. |
| 20 | `AZU-SA-SI_040` | Enable Soft Delete for Files with a 30 day retention period. |**What?** Storage Accounts must enforce the use of File Soft Delete if files are used with a retention period of 30 days. <br> **How?** Within its Data protection settings. <br> **Why?** To recover data after an accidental or malicious deletion. | True | True | Implemented using `share_properties` block in terraform `azurerm_storage_account` resource. The Default retention is set to 30 days and it can be changed during the provisiong of Storage Account |
| 21 | `AZU-SA-SC_090` | Azure App Deployment must not be able to corrupt the centrally managed private link private DNS zones when making a private end point for File. |**What?**  Storage Account File services must have an Azure DeployIfNotExists policy to update the centrally managed private link private DNS zones with its private A record. <br> **How?** Via Policy to management group mapping.  <br> **Why?** To ensure there is no ability for the Azure App Deployment team to have authorisation over these zones that could allow them to corrupt this file and impact service availability.| False | False | This Control will be implemented via policy. |
| 22 | `AZU-SA-SC_091` | Azure App Deployment must not be able to corrupt the centrally managed private link private DNS zones when making a private end point for Blob. | **What?** Storage Account Blob services must have an Azure DeployIfNotExists policy to update the centrally managed private link private DNS zones with its private A record.  <br> **How?**Via Policy to management group mapping. <br> **Why?** To ensure there is no ability for the Azure App Deployment team to have authorisation over these zones that could allow them to corrupt this file and impact service availability.| False | False | This Control will be implemented via policy. |
| 23 | `AZU-SA-SC_092` | Azure App Deployment must not be able to corrupt the centrally managed private link private DNS zones when making a private end point for Table. | **What?** Storage Account Table services must have an Azure DeployIfNotExists policy to update the centrally managed private link private DNS zones with its private A record. <br> **How?** Via Policy to management group mapping.  <br> **Why?** To ensure there is no ability for the Azure App Deployment team to have authorisation over these zones that could allow them to corrupt this file and impact service availability.| False | False | This Control will be implemented via policy. |
| 24 | `AZU-SA-SC_093` | Azure App Deployment must not be able to corrupt the centrally managed private link private DNS zones when making a private end point for Queue. |**What?** Storage Account Queue services must have an Azure DeployIfNotExists policy to update the centrally managed private link private DNS zones with its private A record. <br> **How?** Via Policy to management group mapping. <br> **Why?** To ensure there is no ability for the Azure App Deployment team to have authorisation over these zones that could allow them to corrupt this file and impact service availability.| False | False | This Control will be implemented via policy. |

## Service Management Controls Framework

| Sl. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1 | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | **SMCF-GOV-02-03:** Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br>**SMCF-GOV-02-04:** Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, and so on.<br>**SMCF-GOV-02-05:** Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames).<br>[Storage Account Name](https://learn.microsoft.com/en-us/azure/storage/common/storage-account-overview?toc=%2Fazure%2Fstorage%2Fblobs%2Ftoc.json&bc=%2Fazure%2Fstorage%2Fblobs%2Fbreadcrumb%2Ftoc.json#storage-account-name).|
| 2 | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | **SMCF-GOV-03-02:** It must apply tags to all the deployed resources, where applicable. | IaC Policy | True | This control will be implemented using `tags` parameter.<br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3 | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | **SMCF-GOV-08-01:** Enforce resource configuration and properties.<br>**SMCF-GOV-08-02:** Enforce resource security baseline configuration. | Iac Policy | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4 | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | **SMCF-OPS-03-02:** Define and automate resource operation and security log collection.<br>**SMCF-OPS-03-03:** Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs). | Policy Documentation | True | This control will be implemented by `DINE` Policy.<br>[Monitor Azure Blob Storage](https://learn.microsoft.com/en-us/azure/storage/blobs/monitor-blob-storage?tabs=azure-portal)<br>[Best practices for monitoring Azure Blob Storage](https://learn.microsoft.com/en-us/azure/storage/blobs/blob-storage-monitoring-scenarios) <br>[Supported Metrics for Azure Storage Account](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-storage-storageaccounts-metrics)<br>[Cloud monitoring service level objectives](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives) |
| 5 | [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | **SMCF-OPS-06-03:** Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements. | IaC Documentation | True | This control will be implemented by following parameters: `account_replication_type` for High Availability `GRS` property for enabling geo replication.<br>[Use geo-redundancy to design highly available applications](https://learn.microsoft.com/en-us/azure/storage/common/geo-redundant-design?toc=%2Fazure%2Fstorage%2Fblobs%2Ftoc.json&bc=%2Fazure%2Fstorage%2Fblobs%2Fbreadcrumb%2Ftoc.json). |
| 6 | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | **SMCF-OPS-07-01:** Prevent accidental or malicious deletion of production resources.<br>**SMCF-OPS-07-02:** Prevent accidental misconfiguration of key production resources. | IaC Documentation | False | This control will be implemented as per the LSEG standard based on application team requirement. <br><[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) <br>[Apply an Azure Resource Manager lock to a storage account](https://learn.microsoft.com/en-us/azure/storage/common/lock-account-resource?toc=%2Fazure%2Fstorage%2Fblobs%2Ftoc.json&bc=%2Fazure%2Fstorage%2Fblobs%2Fbreadcrumb%2Ftoc.json&tabs=portal). |
| 7 | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | **SMCF-SEC-05-03:** Grant access based on appropriate review of business justification and approvals. | IaC Documentation | True | This control is implemented by following parameters: `default_to_oauth_authentication` is `True` for Active directory authentication.<br>[Built-in roles for management operations](https://learn.microsoft.com/en-us/azure/storage/common/authorization-resource-provider?toc=%2Fazure%2Fstorage%2Fblobs%2Ftoc.json&bc=%2Fazure%2Fstorage%2Fblobs%2Fbreadcrumb%2Ftoc.json#built-in-roles-for-management-operations)<br><br>[Authorize access to blobs using Microsoft Entra ID](https://learn.microsoft.com/en-us/azure/storage/blobs/authorize-access-azure-active-directory). |

## Frequently Asked Questions

There are no FAQs for the current version of the product.

## Known Issues and Limitations

There are no known issues or limitations in the current version of the product.

## Additional Information

- The current security controls definition version is v.0.0.5.

- The following are in scope for security controls descriptions:

 - Standard v2 SKU

- The following are out of scope for security controls descriptions:

 - Data Lake Gen 2 features

 - Private End Point

 - Premium SKU

 - Azure AD Domain Services

 ### Additional Prerequisites

There are no additional prerequisites for the current version of the product.

### Additional Cloud Products

There are no additional cloud products to be called for the current version of the product.

### Additional Security Considerations

There are no additional security considerations for the current version of the product.

## References

### Microsoft Documentation

- [Storage Account Overview](https://learn.microsoft.com/en-us/azure/storage/common/storage-account-overview)

### Terraform Documentation

- [Azure Storage Account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account)

- [Storage Encryption Scope](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_encryption_scope)

- [Storage Management Policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_management_policy)

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
| [azurerm_storage_account.st](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_encryption_scope.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_encryption_scope) | resource |
| [azurerm_storage_management_policy.lifecycle](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_management_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_tier"></a> [access_tier](#input_access_tier) | (Optional) The access tier for the storage account. The possible values are `Cool` and `Hot`. | `string` | `"Hot"` | no |
| <a name="input_account_kind"></a> [account_kind](#input_account_kind) | (Optional) The kind of account. The possible values are `BlobStorage`, `BlockBlobStorage`, `FileStorage`, `Storage` and `StorageV2`. | `string` | `"StorageV2"` | no |
| <a name="input_account_replication_type"></a> [account_replication_type](#input_account_replication_type) | (Optional) The type of replication to use for this storage account. The possible values are `LRS`, `GRS`, `RAGRS`, `ZRS`, `GZRS`, and `RAGZRS`. | `string` | `"GRS"` | no |
| <a name="input_account_tier"></a> [account_tier](#input_account_tier) | (Optional) The tier to be used for this storage account. The possible values are `Standard` and `Premium`. | `string` | `"Standard"` | no |
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only five numbers are used. | `string` | n/a | yes |
| <a name="input_cmk_key_name"></a> [cmk_key_name](#input_cmk_key_name) | (optional) Key name to be used (max 127 chars) | `string` | `null` | no |
| <a name="input_cmk_rotation_policy"></a> [cmk_rotation_policy](#input_cmk_rotation_policy) | (Optional) A rotation policy block as defined below<br/>object({<br/>  notify_before_expiry = "(Optional) Notify at a given duration before expiry as an ISO 8601 duration."<br/>  time_before_expiry   = "(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br/>  time_after_creation  = "(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br/>  expire_after         = "(Optional) Expire a Key Vault key after the given duration as an ISO 8601 duration."<br/>}) | <pre>object({<br/>    notify_before_expiry = string<br/>    time_before_expiry   = string<br/>    time_after_creation  = optional(string, null)<br/>    expire_after         = string<br/>  })</pre> | <pre>{<br/>  "expire_after": "P365D",<br/>  "notify_before_expiry": "P358D",<br/>  "time_after_creation": null,<br/>  "time_before_expiry": "P7D"<br/>}</pre> | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) The application context information for the resource(s) (maximum 10 characters). | `string` | `null` | no |
| <a name="input_create_role_assignment"></a> [create_role_assignment](#input_create_role_assignment) | (Optional) Whether to create a role assignment to the service identity to allow access to the key vault keys. | `bool` | `true` | no |
| <a name="input_cross_tenant_replication_enabled"></a> [cross_tenant_replication_enabled](#input_cross_tenant_replication_enabled) | Specifies whether cross-tenant replication is enabled for the storage account. | `bool` | `false` | no |
| <a name="input_custom_domain"></a> [custom_domain](#input_custom_domain) | (Optional) Map of the custom domain of the Storage Account.<br/>object({<br/>  name            = "(Required) The Custom Domain Name to use for the Storage Account, which will be validated by Azure."<br/>  use_subdomain   = "(Optional) Should the Custom Domain Name be validated by using indirect CNAME validation?"<br/> }) | <pre>map(object({<br/>    name          = string<br/>    use_subdomain = string<br/>  }))</pre> | `{}` | no |
| <a name="input_customer_managed_key"></a> [customer_managed_key](#input_customer_managed_key) | (Required) A customer_managed_key block as defined below<br/>object({<br/>  key_vault_id            = "(Required) The resource ID of the Key Vault where the Key Vault Key resides."<br/>  expiration_date         = "(Required) Expiration UTC datetime (Y-m-d'T'H:M:S'Z')."<br/>  identity_principal_id   = "(Required) The principal ID of the User Assigned Identity that has access to the key."<br/>}) | <pre>object({<br/>    key_vault_id          = string<br/>    expiration_date       = string<br/>    identity_principal_id = string<br/>  })</pre> | n/a | yes |
| <a name="input_default_to_oauth_authentication"></a> [default_to_oauth_authentication](#input_default_to_oauth_authentication) | (Optional) Specifies whether to default to Azure Active Directory authorization in the Azure portal, when accessing the storage account. Defaults to `false`. | `bool` | `true` | no |
| <a name="input_enable_file_share_AADDS_authentication"></a> [enable_file_share_AADDS_authentication](#input_enable_file_share_AADDS_authentication) | (Optional) Specifies whether to enable authentication to file shares via Active Directory Domain Services. | `bool` | `true` | no |
| <a name="input_enable_key_access"></a> [enable_key_access](#input_enable_key_access) | (Optional) Specifies whether the key access is to be enabled. If it is set to `false`, any requests to the account that are authorized with the shared key, including the shared access signatures (SAS), are denied. | `bool` | `false` | no |
| <a name="input_encryption_scopes"></a> [encryption_scopes](#input_encryption_scopes) | (Optional) The map of the encryption scopes in the storage account. | <pre>map(object({<br/>    name             = string<br/>    key_vault_key_id = string<br/>  }))</pre> | `{}` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. It is provided as an abbreviation with maximum three characters to leave more characters to the other naming components. | `string` | n/a | yes |
| <a name="input_https_traffic_only_enabled"></a> [https_traffic_only_enabled](#input_https_traffic_only_enabled) | (Optional) //to implement securtiy control, this property needs to be true to use techniques to establish an encrypted data channels over untrusted networks. However this needs to be false for file share because Azure Files doesn't currently support encryption-in-transit with the NFS protocol and relies instead on network-level security.. | `bool` | `true` | no |
| <a name="input_identity"></a> [identity](#input_identity) | (Required) An identity block as defined below<br/>type         = "(Required) The type of managed service identity that must be configured on this storage account. The possible values are `UserAssigned` or `SystemAssigned, UserAssigned` (to enable both)."<br/>identity_ids = "(Required) A list of user-assigned managed identity IDs to be assigned to this storage account. This is required when `type` is set to `UserAssigned` or `SystemAssigned, UserAssigned`."<br/>}) | <pre>object({<br/>    type         = string<br/>    identity_ids = list(string)<br/>  })</pre> | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) The instance number, if the context includes or requires multiple resources of the same type (max three integers). | `string` | `null` | no |
| <a name="input_key_vault_id"></a> [key_vault_id](#input_key_vault_id) | (Required) The ID of the existing Key Vault to store the customer-managed key for encryption. | `string` | n/a | yes |
| <a name="input_key_vault_tags"></a> [key_vault_tags](#input_key_vault_tags) | (Optional) Key Vault related tags to be set on key vault child resources. | `map(any)` | `{}` | no |
| <a name="input_kv_secret_expiration_date"></a> [kv_secret_expiration_date](#input_kv_secret_expiration_date) | (Required) The expiration UTC datetime (Y-m-d'T'H:M:S'Z') for the storage account access key from the Key Vault Secret. | `string` | n/a | yes |
| <a name="input_large_file_share_enabled"></a> [large_file_share_enabled](#input_large_file_share_enabled) | (Optional) storage account is enabled for large file shares. Defaults to `true`. | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) The location of the resource group. | `string` | n/a | yes |
| <a name="input_network_access_enabled"></a> [network_access_enabled](#input_network_access_enabled) | Enable or disable public network access for the storage account. | `bool` | `false` | no |
| <a name="input_network_rules"></a> [network_rules](#input_network_rules) | (Optional) A network_rules block as defined below<br/>object({<br/>  bypass                     = "(Optional) Specifies whether traffic is bypassed for logging, metrics or Azure services. The possible values are any combination of `\"Logging\"`, `\"Metrics\"`, `\"AzureServices\"`, or `\"None\"`."<br/>  ip_rules                   = "(Optional) One or more Public IP Addresses or CIDR blocks that must be able to access the storage account."<br/>  virtual_network_subnet_ids = "(Optional) One or more Subnet IDs that must be able to access the storage account."<br/>}) | <pre>object({<br/>    bypass                     = optional(list(string), ["AzureServices"])<br/>    ip_rules                   = optional(list(string), [])<br/>    virtual_network_subnet_ids = optional(list(string), [])<br/>  })</pre> | <pre>{<br/>  "bypass": [<br/>    "AzureServices"<br/>  ],<br/>  "ip_rules": [],<br/>  "virtual_network_subnet_ids": []<br/>}</pre> | no |
| <a name="input_nfsv3_enabled"></a> [nfsv3_enabled](#input_nfsv3_enabled) | (Optional) Specifies whether the NFSV3 protocol is enabled. Defaults to `true`. | `bool` | `false` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) A three letter code representing organization, tenant, or CSP. | `string` | n/a | yes |
| <a name="input_persist_access_key"></a> [persist_access_key](#input_persist_access_key) | (Optional) Set this to `true` to store storage access key in the Key Vault. | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) The name of the resource group the storage account is created in. | `string` | n/a | yes |
| <a name="input_restore_policy"></a> [restore_policy](#input_restore_policy) | (Optional) The number of days for point in time restore. Must be less than the days specified in delete_retention_policy | `number` | `29` | no |
| <a name="input_retention_policy_days"></a> [retention_policy_days](#input_retention_policy_days) | (Optional) The number of days that the containers, blob, queues and share must be retained. The possible values must be between between 1 and 365. | `number` | `30` | no |
| <a name="input_rules"></a> [rules](#input_rules) | (Optional) A map of rule block as documented below:<br/>object({<br/>  name    = "(Required) The name of the rule. The rule name is case-sensitive. It must be unique within a policy."<br/>  enabled = "(Required) Specify whether the rule is enabled."<br/>  filters = "(Required) The filters block supports the following:<br/>  object({<br/>    blob_types           = "(Required) An array of predefined values. The possible values are `blockBlob` and `appendBlob`."<br/>    prefix_match         = "(Optional) An array of strings for prefixes to be matched."<br/>    match_blob_index_tag = "(Optional) A `match_blob_index_tag` block defined as follows. The block defines the blob index tag-based filtering for blob objects."<br/>    object({<br/>      name      = "(Required) The filter tag name used for tag-based filtering for blob objects."<br/>      operation = "(Optional) The comparison operator that is used for object comparison and filtering. The possible value is `==`. Defaults to `==`."<br/>      value     = "(Required) The filter tag value used for tag-based filtering for blob objects."<br/>    })<br/>  })"<br/>  actions = "(Required) An actions block defined as follows:<br/>  object({<br/>    base_blob = (Optional) A base_blob block defined as follows:<br/>    object({<br/>      tier_to_cool_after_days_since_modification_greater_than        = "(Optional) The age in days after last modification to tier blobs to cool storage. Supports blob currently at Hot tier. Must be between `0` and `99999`."<br/>      tier_to_cool_after_days_since_last_access_time_greater_than    = "(Optional) The age in days after last access time to tier blobs to cool storage. Supports blob currently at Hot tier. Must be between `0` and `99999`."<br/>      tier_to_cool_after_days_since_creation_greater_than            = "(Optional) The age in days after creation to cool storage. Supports blob currently at Hot tier. Must be between `0` and `99999`."<br/>      auto_tier_to_hot_from_cool_enabled                             = "(Optional) Specifies whether a blob should automatically be tiered from cool back to hot if it's accessed again after being tiered to cool. Defaults to false."<br/>      tier_to_archive_after_days_since_modification_greater_than     = "(Optional) The age in days after last modification to tier blobs to archive storage. Supports blob currently at Hot or Cool tier. Must be between `0` and `99999`."<br/>      tier_to_archive_after_days_since_last_access_time_greater_than = "(Optional) The age in days after last access time to tier blobs to archive storage. Supports blob currently at Hot or Cool tier. Must be between 0 and99999."<br/>      tier_to_archive_after_days_since_creation_greater_than         = "(Optional) The age in days after creation to archive storage. Supports blob currently at Hot or Cool tier. Must be between 0 and99999."<br/>      tier_to_archive_after_days_since_last_tier_change_greater_than = "(Optional) The age in days after last tier change to the blobs to skip to be archved. Must be between `0` and `99999`."<br/>      tier_to_cold_after_days_since_modification_greater_than        = "(Optional) The age in days after last modification to tier blobs to cold storage. Supports blob currently at Hot tier. Must be between `0` and `99999`."<br/>      tier_to_cold_after_days_since_last_access_time_greater_than    = "(Optional) The age in days after last access time to tier blobs to cold storage. Supports blob currently at Hot tier. Must be between `0` and `99999`."<br/>      tier_to_cold_after_days_since_creation_greater_than            = "(Optional) The age in days after creation to cold storage. Supports blob currently at Hot tier. Must be between `0` and `99999`."<br/>      delete_after_days_since_modification_greater_than              = "(Optional) The age in days after last modification to delete the blob. Must be between `0` and `99999`."<br/>      delete_after_days_since_last_access_time_greater_than          = "(Optional) The age in days after last access time to delete the blob. Must be between `0` and `99999`."<br/>      delete_after_days_since_creation_greater_than                  = "(Optional) The age in days after creation to delete the blob. Must be between `0` and `99999`."<br/>    })<br/>    snapshot = (Optional) A snapshot block as documented below:<br/>    object({<br/>      change_tier_to_archive_after_days_since_creation               = "(Optional) The age in days after creation to tier blob snapshot to archive storage. Must be between `0` and `99999`."<br/>      tier_to_archive_after_days_since_last_tier_change_greater_than = "(Optional) The age in days after last tier change to the blobs to skip to be archved. Must be between `0` and `99999`."<br/>      change_tier_to_cool_after_days_since_creation                  = "(Optional) The age in days after creation to tier blob snapshot to cool storage. Must be between `0` and `99999`."<br/>      tier_to_cold_after_days_since_creation_greater_than            = "(Optional) The age in days after creation to cold storage. Supports blob currently at Hot tier. Must be between `0` and `99999`."<br/>      delete_after_days_since_creation_greater_than                  = "(Optional) The age in days after creation to delete the blob snapshot. Must be between `0` and `99999`."<br/>    })<br/>    version = (Optional) A version block as documented below:<br/>    object({<br/>      change_tier_to_archive_after_days_since_creation               = "(Optional) The age in days after creation to tier blob version to archive storage. Must be between `0` and `99999`."<br/>      tier_to_archive_after_days_since_last_tier_change_greater_than = "(Optional) The age in days after last tier change to the blobs to skip to be archved. Must be between `0` and `99999`."<br/>      change_tier_to_cool_after_days_since_creation                  = "(Optional) The age in days creation create to tier blob version to cool storage. Must be between `0` and `99999`."<br/>      tier_to_cold_after_days_since_creation_greater_than            = "(Optional) The age in days after creation to cold storage. Supports blob currently at Hot tier. Must be between `0` and `99999`."<br/>      delete_after_days_since_creation                               = "(Optional) The age in days after creation to delete the blob version. Must be between `0` and `99999`."<br/>    })<br/>  })"<br/>}) | <pre>map(object({<br/>    name    = string<br/>    enabled = bool<br/>    filters = object({<br/>      blob_types   = set(string)<br/>      prefix_match = set(string)<br/>      match_blob_index_tag = optional(object({<br/>        name      = string<br/>        operation = optional(string, "==")<br/>        value     = string<br/>      }))<br/>    })<br/>    actions = object({<br/>      base_blob = optional(object({<br/>        tier_to_cool_after_days_since_modification_greater_than        = optional(number)<br/>        tier_to_cool_after_days_since_last_access_time_greater_than    = optional(number)<br/>        tier_to_cool_after_days_since_creation_greater_than            = optional(number)<br/>        auto_tier_to_hot_from_cool_enabled                             = optional(bool, false)<br/>        tier_to_archive_after_days_since_modification_greater_than     = optional(number)<br/>        tier_to_archive_after_days_since_last_access_time_greater_than = optional(number)<br/>        tier_to_archive_after_days_since_creation_greater_than         = optional(number)<br/>        tier_to_archive_after_days_since_last_tier_change_greater_than = optional(number)<br/>        tier_to_cold_after_days_since_modification_greater_than        = optional(number)<br/>        tier_to_cold_after_days_since_last_access_time_greater_than    = optional(number)<br/>        tier_to_cold_after_days_since_creation_greater_than            = optional(number)<br/>        delete_after_days_since_modification_greater_than              = optional(number)<br/>        delete_after_days_since_last_access_time_greater_than          = optional(number)<br/>        delete_after_days_since_creation_greater_than                  = optional(number)<br/>      }))<br/>      snapshot = optional(object({<br/>        change_tier_to_archive_after_days_since_creation               = optional(number)<br/>        tier_to_archive_after_days_since_last_tier_change_greater_than = optional(number)<br/>        change_tier_to_cool_after_days_since_creation                  = optional(number)<br/>        tier_to_cold_after_days_since_creation_greater_than            = optional(number)<br/>        delete_after_days_since_creation_greater_than                  = optional(number)<br/>      }))<br/>      version = optional(object({<br/>        change_tier_to_archive_after_days_since_creation               = optional(number)<br/>        tier_to_archive_after_days_since_last_tier_change_greater_than = optional(number)<br/>        change_tier_to_cool_after_days_since_creation                  = optional(number)<br/>        tier_to_cold_after_days_since_creation_greater_than            = optional(number)<br/>        delete_after_days_since_creation                               = optional(number)<br/>      }))<br/>    })<br/>  }))</pre> | `{}` | no |
| <a name="input_static_website"></a> [static_website](#input_static_website) | (Optional) A static_website block supports the following:<br/>index_document     = "(Optional) The webpage that Azure Storage serves for requests to the root of a website or any subfolder. For example, index.html. The value is case-sensitive."<br/>error_404_document = "(Optional) The absolute path to a custom webpage that must be used when a request is made that does not correspond to an existing file." | <pre>object({<br/>    index_document     = optional(string)<br/>    error_404_document = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_storage_policy_required"></a> [storage_policy_required](#input_storage_policy_required) | (Optional) Specifies whether the storage account management policy is required. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) The tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The ID of the storage account. |
| <a name="output_name"></a> [name](#output_name) | The name of the storage account. |
| <a name="output_primary_access_key"></a> [primary_access_key](#output_primary_access_key) | The primary access key of the storage account. |
| <a name="output_primary_blob_endpoint"></a> [primary_blob_endpoint](#output_primary_blob_endpoint) | The primary BLOB endpoint. |
| <a name="output_primary_connection_string"></a> [primary_connection_string](#output_primary_connection_string) | The storage account primary connection string. |
| <a name="output_resource"></a> [resource](#output_resource) | The name of the storage account resource. |
<!-- END_TF_DOCS -->
