<!-- BEGIN_TF_DOCS -->
# Storage Key Vault Service Pattern

[[_TOC_]]

This readme provides an overview of a service pattern for `azure-prdsvcpat-terraform-storagekeyvault`. The solution proposed below provides an easy predefined template built on top of LSEG approved Cloud Products (with identified common configurations) and the service pattern intended to help application teams with rapid deployments of infrastructure.

Here are some of the key advantages the proposed solution offers:

- **Rapid Deployment:** Service patterns are pre-defined templates that can be easily reused which accelerates the deployment process by eliminating the need to write configurations from scratch for each deployment, saving time and effort.
- **Standardization and Consistency:** Service patterns provide standardized templates and best practices for deploying specific infrastructure that promotes consistent configurations. This ensures consistency across deployments, reducing the likelihood of configuration drifts/errors and making it easier to maintain and scale infrastructure.
- **Documentation:** Service pattern comes with built-in documentation that explain the purpose and usage of various components.
- **Security and Compliance:** Service pattern built on top of approved Cloud Products incorporate security best practices and compliance requirements, ensuring that infrastructure is deployed with security in mind from the outset. This reduces the likelihood of security vulnerabilities.
- **Reuse, Sharing and customization:** Teams can share and reuse patterns across projects and organizations. Patterns can be adapted, and customized over time as infrastructure/business requirements change.
- **Version Control:** Patterns can be version-controlled, allowing teams to track changes, roll back to previous configurations if issues arise, and collaborate more effectively through version control systems.

## Pattern Description

This section contains the details of the azure service technical use case.

The following diagram shows the High Level Design for **Service pattern for Storage Key Vault**:

[Image: StorageKeyVaultsvcpatHLD]

### Provisioned Azure services through IaC

- Key Vault Private Endpoint Pattern (Optional)
- User Assigned Identity
- Azure Storage Account
- Azure Storage blob Private Endpoint (Optional)
- Azure Storage fileshare Private Endpoint (Optional)
- Azure Storage queue Private Endpoint (Optional)
- Azure Storage table Private Endpoint (Optional)
- Azure Storage blob (Optional)
- Azure Storage fileshare (Optional)
- Azure Storage queue (Optional)
- Azure Storage table (Optional)

#### Simplified Usability

- This pattern significantly reduces user time and effort by eliminating the need to individually call each of the above mentioned modules. Instead, users can focus on passing the `required parameters` after invoking this service pattern.
- Additionally, this pattern seamlessly integrates essential resource blocks, such as the `time_sleep` block, which introduces necessary delays to ensure sufficient time for DNS zone establishment when configuring private endpoints for core products such as Storage Account, thereby ensuring the smooth creation of child resources.

### Secret management

- Azure Key Vault Private Endppoint pattern is offered as an optional component, and it serves as the repository for the Customer Managed Key (CMK) needed to activate encryption on the Storage Account. AKV is utilized for storing the CMK Key.
- If `persist_access_key` is set to true then you can store storage access key in `key vault`.

### Networking

- Storage account has several sub-resources like blob, table, file share, queues and each one requires private endpoint, so create necessary private endpoint before creating the sub-resource.
- Storage Account network_rules must bypass `AzureServices` to allow access to its sub-resources over private network.
- Creation of private endpoint requires subnet ID with valid CIDR, and association of NSG and Route Table.

### Identity Management

- Azure Directory Domain Services (AD DS) authentication for Azure file share depends on the availability of the Azure Active Directory Domain Service(AAD DS) in the Azure Subscription. If the AAD DS is available in the subscription, you can pass `true` as a value to `enable_file_share_AADDS_authentication` variable.
- Setting this `default_to_oauth_authentication` to True defaults to Azure Active Directory authorization in the Azure portal when accessing the Storage Account.
- If `enable_key_access` is set to `false` any requests to the account that are authorized with Shared Key, including shared access signatures (SAS), will be denied.

### Monitoring and Logging

- Storage Accounts sends all diagnostic logs to a central SOC Log Analytics workspace through DINE (Azure) policy within its Diagnostic settings in order to support a security investigation after a security incident involving a Storage Account.
- Storage Accounts sends all diagnostic logs to a central SOC Storage Account through DINE (Azure) policy within its Diagnostic settings in order to provide a copy to adhere to compliance requirements.

### Availability

- The pattern supports for deployment for different kinds of:
  account_replication_type (LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS),
  account_tier (Standard, Premium),
  account_kind (BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2),
  access_tier (Cool, Hot)

- Storage Account having globally redundant storage (GRS, GZRS, and RA-GZRS), Azure copies the data asynchronously to a secondary geographic region at least hundreds of miles away. This allows user to recover data if there's an outage in the primary region hence establishing BCDR strategy. Microsoft recommends `RA-GZRS` for maximum availability and durability of storage accounts.

### Other

- Pattern provides the capability to deploy one Storage with private endpoint enabled along with desired number of tables, blobs, queues, file shares.
- The variable `key_vault_id` takes the resource ID of a key vault as input for storage account encryption and access key retention.
  If a key vault with specified resource ID does not exist or you pass null in place of a valid resource ID, this pattern will create a new key vault and the name of new key vault will be as per the values of the LSEG naming variables.
  In this case the key vault is created in the same resource group specified as a target of the pattern deployment, not in the resource group specified by the non existing key vault resource ID.

## Pattern Composability

The section describes what optional components are considered in the service pattern and which inputs govern and effect the deployement of these components

[Image: Storage Key Vault Pattern Solution]

# Pattern Usage Guidance

## Pattern Use Cases

| Use Case | Default Behaviour | Input Control- variable | Comments |
|----------|-------------------|-------------------------|----------|
| Deploy Azure KeyVault or use an existing Keyvault | By Default the patterns deploys new Keyvault | `key_vault_id` | If value is passed to the variable `key_vault_id` then it will accept the passed value else deploys the Azure keyvault with private endpoint configurations via module as part of pattern. |
| Create Storage Account based on account tier, replication type, kind and access tier | By Default, the pattern deploys Storage Account with account_tier ("Standard"), account_replication_type ("GRS"), account_kind ("StorageV2"), access_tier ("Hot") | `account_tier`, `account_replication_type`, `account_kind`, `access_tier` | By default, Storage account gets created with above mentioned properties but user has to option to pass valid values and deploy resource based on application requirement. |
| Create Storage Account with High Availability enabled | By Default, the pattern deploys Storage Account with `account_replication_type` as "GRS" | `account_replication_type` | Storage account gets created with `GRS` replication type maintaining high availablity of data across regions. |
| Deploy Private Endpoint for Blob | By Default, the pattern deploys private endpoint for blob, a sub-resource of Storage Account | `private_endpoints.blob.enable`| If `private_endpoints.blob.enable` is set to `False`, then it will not create Private Endpoint else it takes the default value as `True` and creates the Private Endpoint. |
| Deploy Private Endpoint for File Share | By Default, the pattern deploys private endpoint for File Share, a sub-resource of Storage Account | `private_endpoints.file_share.enable`| If `private_endpoints.file_share.enable` is set to `False`, then it will not create Private Endpoint else it takes the default value as `True` and creates the Private Endpoint. |
| Deploy Private Endpoint for Queue | By Default, the pattern deploys private endpoint for Queue, a sub-resource of Storage Account | `private_endpoints.queue.enable`| If `private_endpoints.queue.enable` is set to `False`, then it will not create Private Endpoint else it takes the default value as `True` and creates the Private Endpoint. |
| Deploy Private Endpoint for table | By Default, the pattern deploys private endpoint for Table, a sub-resource of Storage Account | `private_endpoints.table.enable`| If `private_endpoints.table.enable` is set to `False`, then it will not create Private Endpoint else it takes the default value as `True` and creates the Private Endpoint. |
| Create containers post Private Endpoint configuration | By Default, the pattern provides the option to deploy containers in Storage Account | `containers`| `var.containers` is a list of object with default set to empty list, else user can pass the necessary arguments to create the resource. |
| Create file_shares post Private Endpoint configuration | By Default, the pattern provides the option to deploy file_shares in Storage Account | `file_shares`| `var.file_shares` is a list of object with default set to empty list, else user can pass the necessary arguments to create the resource. |
| Create queues post Private Endpoint configuration | By Default, the pattern provides the option to deploy queues in Storage Account | `queues`| `var.queues` is a list of object with default set to empty list, else user can pass the necessary arguments to create the resource. |
| Create tables post Private Endpoint configuration | By Default, the pattern provides the option to deploy tables in Storage Account | `tables`| `var.tables` is a list of object with default set to empty list, else user can pass the necessary arguments to create the resource. |

## Special Use Case

| Use Case | Default Behaviour | Input Control- variable | Comments |
|----------|-------------------|-------------------------|----------|
| Initial deployment of Azure Storage Account with CMK enabled for storing tfstate files | By Default the patterns deploys Azure Storage Account with CMK enabled and store infrastructure details in existing tf state file | `backend "azurerm" {}` | For initial deployment of Storage Account for the purpose of storing tfstate files containing infrastructure details, comment `backend "azurerm" {}` code in test providers.tf file. Please refer the details below. |

### Request for Azure Subscription

In order to deploy the Storage key vault using this pattern, you would need a valid Azure subscription and resource group.

*If you already requested for a subscription or have an active subscription, you can skip this step* as the subscription vending process will create all the required resource groups and network resources for connectivity.

If you do not have a subscription, you can request for one using the link - [LMP Azure Subscription Vending](https://lsegroup.sharepoint.com/sites/CloudCentral/SitePages/LMP-Azure-Subscription-Vending.aspx).

As part of the subscription vending request the Cloud Engineer will update the request with the subscription details and following will be created for the application teams:

* Subscription
* Platform Resource Group & Platform resources (VNETs, Subnets, bastion, etc.) 
* Application Resource Group
* Platform and Application AD groups and role assignments
* Application Service principal (SPN)

### Request for DX1 onboarding

Once you have the subscription ready, next step would be to request DX1 onboarding (Gitlab project creation).

*If you already have a DX1 repo for your application, you can skip this step*, if not use the [SNOW link](https://lseg.service-now.com/esc?id=sc_cat_item&sys_id=25e78c001b2c6110a25b8326464bcb12) to raise the onboarding request.

Once the request is approved, the following are created as part of the DX1 onboarding:

* Gitlab project with template repository structure for terraform deployment. Here's a screenshot of the template folder structure.
* Dedicated Gitlab runner
* Whitelisting of firewall rules for DX1 to Azure connectivity

For more details on how to fill the fields in the SNOW request, refer to this documentation link - [DX1 Adoption](https://lsegroup.sharepoint.com/sites/DXOne-Tools/SitePages/DXOne%20Adoption.aspx)

Once the Gitlab repository is provisioned, the main branch should look as below:

[Image: Gitlab Repo]

> <mark>**Note:**</mark>
> The folder structure shown above can change depending on template being used, check with DX1 team for more information.

### **Create storage account to store Terraform state**

After the DX1 onboarding is complete, as a pre-requisite, you would have to create a storage account to store the terraform state file for the deployments.

*If you already have a storage account provisioned and are actively using it to store terraform state file in DX1 repo, you can skip this step and move ahead with Storage Key vault Pattern deployment*.

If you do not have a storage account then to provision the storage account, there are few dependent resources that need to be deployed, all of these can be deployed using `Storage Key Vault Service Pattern`, having different Azure cloud products as mentioned below:

* Keyvault
* Private Endpoint for Keyvault
* User Assigned Identity
* Storage Account
* Private Endpoint for Storage Account
* Blob Container

Use the pattern code reference to provision the required resources, make sure you are updating the values as per your application and commenting `backend "azurerm" {}`.

After all the below files are updated, run the pipeline to provision all the above resources.

> <mark>**Note:**</mark>
> only update the files and arguments based on requirement and retain the contents of other files. <mark>Create a new branch from main</mark> and use the same to provision the storage account.

## Additional Information

1. Data in a storage account is durable, highly available, secure, and massively scalable.
2. A lifecycle management policy is composed of one or more rules that define a set of actions to take based on a condition being met. The policy acts on a base blob, and optionally on the blob's versions or snapshots. For more details, please refer [Lifecycle_Management_Policy_Configure](https://learn.microsoft.com/en-us/azure/storage/blobs/lifecycle-management-policy-configure).
3. You can serve static content (HTML, CSS, JavaScript, and image files) directly from a storage container named $web. Hosting your content in Azure Storage enables you to use serverless architectures that include Azure Functions and other Platform as a service (PaaS) services. Azure `Storage static website hosting` is a great option in cases where you don't require a web server to render content.
4. If you are trying to connect the Private Endpoint to a remote resource without having the correct RBAC permissions on the remote resource set `is_manual_connection` value to true.
5. `Storage Account` only support 1 sub-resource per private endpoint.
6. The `match_blob_index_tag` property requires enabling the blobIndex feature with [PSH or CLI commands](https://azure.microsoft.com/en-us/blog/manage-and-find-data-with-blob-index-for-azure-storage-now-in-preview/).
7. `match_blob_index_tag` is not supported as a filter for versions and snapshots.
8. `base_blob`, a part of `actions` block of the Storage Account Management Policy have following points to be noted:
  - The `tier_to_cool_after_days_since_modification_greater_than`, `tier_to_cool_after_days_since_last_access_time_greater_than` and `tier_to_cool_after_days_since_creation_greater_than` can not be set at the same time.

  - The `auto_tier_to_hot_from_cool_enabled` must be used together with `tier_to_cool_after_days_since_last_access_time_greater_than`.

  - The `tier_to_archive_after_days_since_modification_greater_than`,`tier_to_archive_after_days_since_last_access_time_greater_than` and `tier_to_archive_after_days_since_creation_greater_than` can not be set at the same time.

  - The `tier_to_cool_after_days_since_modification_greater_than`,  `tier_to_cool_after_days_since_last_access_time_greater_than` and `tier_to_cool_after_days_since_creation_greater_than` can not be set at the same time.

  - The `delete_after_days_since_modification_greater_than`, `delete_after_days_since_last_access_time_greater_than` and `delete_after_days_since_creation_greater_than` can not be set at the same time.

  - The `last_access_time_enabled` must be set to true in the azurerm_storage_account in order to use `tier_to_cool_after_days_since_last_access_time_greater_than`, `tier_to_archive_after_days_since_last_access_time_greater_than` and `delete_after_days_since_last_access_time_greater_than`.
9. `static_website` can only be set when the `account_kind` is set to `StorageV2` or `BlockBlobStorage`.
10. `shared_access_key_enabled` control in this storage module has not been hardcoded to false, rather it is parameterised using variable `enable_key_access` to allow the user to enable or disable it as required. Reason: If we set it to false then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD) and Azure Storage supports Azure AD authorization for requests to Blob Storage and Queue Storage only. If you disallow authorization with Shared Key for the storage account, you will not be able to access Azure Files data in the Azure portal.
11. If the value of the attribute `shared_access_key_enabled` is set to `false` via the input parameter `enable_key_access`, you need to add a flag in providers block `storage_use_azuread = true` so that terraform can authenticate to storage account using Azure AD authentication.
12. Azure Directory Domain Services (AD DS) authentication for Azure file share depends on the availability of the Azure Active Directory Domain Service(AAD DS) in the Azure Subscription. If the AAD DS is available in the subscription, you can pass `true` as a value to `enable_file_share_AADDS_authentication` variable.
13. This module supports the creation of  multiple encryption scopes through variable `encryption_scopes` while provisioning the storage account, but the association of encryption scope with containers and blobs is currently not supported by the terraform, it could be implemented by other tools in the upcoming versions of this module. References: https://github.com/hashicorp/terraform-provider-azurerm/issues/12055, https://github.com/hashicorp/terraform-provider-azurerm/issues/17272.
14. Key vault key and secret supports only up to 15 tags. Please refer link:
- [Key vault key tags](https://learn.microsoft.com/en-us/azure/key-vault/keys/about-keys-details)
- [Key vault secret tags](https://learn.microsoft.com/en-us/azure/key-vault/secrets/about-secrets#secret-tags)

## Pattern Usage

### Prerequisites

- A Resource Group where you want to create the Storage Account.
- A Virtual Network and Subnet where you plan to deploy the Private Endpoint.
- Nework Connectivity : If you have multiple Virtual Networks, you need to setup the connectivity between the Virtual Network containing Gitlab Pipeline runner and the Virtual Network where you plan to deploy the Private Endpoints for the Storage Account.

## Guidance

### Build and Test

1. Call the module whichever is needed to be deployed. As the example given below,

```
module "storage_account_pe" {
  #checkov:skip=CKV_TF_1:Skip module check for commit hash
  source                         = "../../"
  org_id                         = local.org_id
  app_id                         = local.app_id
  location                       = local.location
  environment                    = local.environment
  context                        = local.context
  instance                       = local.instance
  resource_group_name            = data.azurerm_resource_group.this.name
  storage_account                = local.storage_account
  private_endpoints              = local.private_endpoints
  containers                     = local.containers
  file_shares                    = local.file_shares
  queues                         = local.queues
  tables                         = local.tables

  ## Key vault Variables
  sku_name                        = "premium"
  enabled_for_deployment          = false
  enabled_for_disk_encryption     = false
  enabled_for_template_deployment = false
  network_acls = {
    bypass = "AzureServices"
  }

  private_endpoint = {
    subnet_id                         = module.azure-prdsvc-terraform-subnet.id
    is_manual_connection              = false
    private_connection_resource_alias = null
    static_ip_required                = false
  }

  key_vault_secrets      = {}
  key_vault_certificates = {}
  key_vault_keys = {
    kv_key1 = {
      key_number      = "05"
      expiration_date = "2025-01-01T00:00:00Z"
      rotation_policy = {
        notify_before_expiry = "P351D"
        time_before_expiry   = null
        time_after_creation  = "P358D"
        expire_after         = "P365D"
      }
      key_opts = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
    }
  }
}
```
2. Update the source with right tag version.
2. Check the terraform variables file and update the values of org_id, app_id, location, context, instance and other necessary arguments for all the resources being deployed. Example displayed in .tests/deployTest folder.
3. If the plan is use to use the existing resouce available on azure then please make sure to use 'data block'.
4. **Note: The .tests/deployTest folder is for for deployment and unit test cases , Use only as reference and not as the exact implementation of the pattern.**

## Changelog

- [azure-prdsvcpat-terraform-storagekeyvault](CHANGELOG.md)

## References

### Microsoft Docs

- [Storage Account](https://learn.microsoft.com/en-us/azure/storage/common/storage-account-overview)
- [Containers](https://learn.microsoft.com/en-us/azure/storage/blobs/storage-blobs-introduction#containers)
- [Queues](https://learn.microsoft.com/en-us/azure/storage/queues/storage-queues-introduction)
- [File Share](https://learn.microsoft.com/en-us/azure/storage/files/storage-files-introduction)
- [Table](https://learn.microsoft.com/en-us/azure/storage/tables/table-storage-overview)

### Terraform Docs

- [azurerm_storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account)
- [azurerm_storage_encryption_scope](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_encryption_scope)
- [azurerm_storage_management_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_management_policy)
- [azurerm_storage_container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container)
- [azurerm_storage_queue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue)
- [azurerm_storage_share](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share)
- [azurerm_storage_table](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_table)

### Service-Pattern-HLD

- [Storage-key-Vault-Pattern](https://gitlab.dx1.lseg.com/groups/app/app-51310/azure/prdsvc/terraform/-/wikis/Service-Pattern-HLD/Storage-key-Vault-Pattern)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm) | >= 3.51 |
| <a name="requirement_time"></a> [time](#requirement_time) | ~> 0.10 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | >= 3.51 |
| <a name="provider_time"></a> [time](#provider_time) | ~> 0.10 |

## Resources

| Name | Type |
|------|------|
| [time_sleep.wait_seconds_private](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [azurerm_resources.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resources) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_containers"></a> [containers](#input_containers) | (Optional) List of Storage Container configurations. | <pre>list(object({<br>    metadata = optional(map(any), null)<br>    instance = string<br>  }))</pre> | `[]` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_enabled_for_deployment"></a> [enabled_for_deployment](#input_enabled_for_deployment) | (Optional) Specifies whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. | `bool` | `false` | no |
| <a name="input_enabled_for_disk_encryption"></a> [enabled_for_disk_encryption](#input_enabled_for_disk_encryption) | (Optional) Specifies whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. | `bool` | `false` | no |
| <a name="input_enabled_for_template_deployment"></a> [enabled_for_template_deployment](#input_enabled_for_template_deployment) | (Optional) Specifies whether Azure Resource Manager is permitted to retrieve secrets from the key vault. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_file_shares"></a> [file_shares](#input_file_shares) | (Optional) List of File Share configurations. | <pre>list(object({<br>    instance         = string<br>    quota            = string<br>    enabled_protocol = optional(string, "SMB")<br>    access_tier      = optional(string, "TransactionOptimized")<br>  }))</pre> | `[]` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_key_vault_certificates"></a> [key_vault_certificates](#input_key_vault_certificates) | (Optional) A map of Key vault certificates to be created using following variables:<br>  cert_number            = "(Required) Specifies certificate number for multiple certificates to be created."<br>  import_certificate     = "(Required) Choose to import certificate or to generate one."<br>  path_of_certificate    = "(Optional) Provide the path of the existing certificate. (Required) in case of import_certificate as True."<br>  issuer_parameters_name = "(Required) The name of the Certificate Issuer. Changing this forces a new resource to be created."<br>  ec_key_required        = "(Required) Do you want to create an `EC` key?"<br>  curve                  = "(Optional) Specifies the curve to use when creating an EC key. Possible values are P-256, P-256K, P-384, and P-521.This field will be required in a future release if key_type is EC or EC-HSM. Changing this forces a new resource to be created."<br>  key_type               = "(Required) Specifies the type of key. Changing this forces a new resource to be created."<br>  key_size               = "(Optional) The size of the key used in the certificate. This property is required when using RSA keys. Changing this forces a new resource to be created."<br>  reuse_key              = "(Required) Is the key reusable? Changing this forces a new resource to be created."<br>  action_type            = "(Required) The Type of action to be performed when the lifetime trigger is triggerec. Changing this forces a new resource to be created."<br>  content_type           = "(Required) The Content-Type of the Certificate, such as application/x-pkcs12 for a PFX or application/x-pem-file for a PEM. Changing this forces a new resource to be created."<br>  key_usage              = "(Required) A list of uses associated with this Key. Possible values are cRLSign, dataEncipherment, decipherOnly, digitalSignature, encipherOnly, keyAgreement, keyCertSign, keyEncipherment and nonRepudiation. Changing this forces a new resource to be created."<br>  trigger = object({<br>    days_before_expiry  = optional(number, null)<br>    lifetime_percentage = optional(string, null)<br>  })<br>  x509_certificate_properties = object({<br>    extended_key_usage = "(Optional) A list of Extended/Enhanced Key Usages. Changing this forces a new resource to be created."<br>    subject            = "(Required) The Certificate's Subject. Changing this forces a new resource to be created."<br>    subject_alternative_names = list(object({<br>      dns_names = "(Optional) A list of alternative DNS names (FQDNs) identified by the Certificate. Changing this forces a new resource to be created."<br>      emails    = "(Optional) A list of email addresses identified by this Certificate. Changing this forces a new resource to be created."<br>      upns      = "(Optional) A list of User Principal Names identified by the Certificate. Changing this forces a new resource to be created."<br>    }))<br>    validity_in_months = "(Required) The Certificates Validity Period in Months. Changing this forces a new resource to be created."<br>  })<br>})) | <pre>map(object({<br>    cert_number            = string<br>    path_of_certificate    = optional(string, null)<br>    issuer_parameters_name = string<br>    ec_key_required        = bool<br>    curve                  = optional(string, "P-256")<br>    key_type               = string<br>    key_size               = optional(number, 2048)<br>    reuse_key              = bool<br>    action_type            = string<br>    content_type           = string<br>    key_usage              = list(string)<br>    trigger = object({<br>      days_before_expiry  = optional(number, null)<br>      lifetime_percentage = optional(string, null)<br>    })<br>    x509_certificate_properties = object({<br>      extended_key_usage = optional(list(string))<br>      subject            = string<br>      subject_alternative_names = object({<br>        dns_names = optional(list(string))<br>        emails    = optional(list(string))<br>        upns      = optional(list(string))<br>      })<br>      validity_in_months = string<br>    })<br>  }))</pre> | `{}` | no |
| <a name="input_key_vault_id"></a> [key_vault_id](#input_key_vault_id) | (Optional) The resource Id of the Key Vault to be used for Storage Account encryption and access key retention. If a Key Vault with specified ID does not exist or `null` value is passed , this pattern will create a new Key Vault using the values of LSEG naming variables. In this case the Key Vault is created in the same resource group specified by resource_group_name. | `string` | `null` | no |
| <a name="input_key_vault_keys"></a> [key_vault_keys](#input_key_vault_keys) | (Optional) A map of Key vault key object variables:<br>  key_number = "(Required) Specifies key number for multiple keys to be created."<br>  key_type   = "(Optional) Specifies the Key Type to use for the Key Vault Key."<br>  key_size   = "(Optional) Specifies the Size of the RSA key to create in bytes. Allowed values are 1024, 2048, 3072 or 4096."<br>  not_before_date = "(Optional) Key not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z')."<br>  expiration_date = "(Required) Expiration UTC datetime (Y-m-d'T'H:M:S'Z')."<br>  key_opts        = "(Required) A list of JSON web key operations. Possible values include: decrypt, encrypt, sign, unwrapKey, verify and wrapKey."<br>  rotation_policy = (Optional) object({<br>    notify_before_expiry = "(Required) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br>    time_before_expiry   = "(Required) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br>    time_after_creation  = "(Optional) Rotate automatically at a duration after create as an ISO 8601 duration."<br>    expire_after         = "(Required) Expire a Key Vault Key after given duration as an ISO 8601 duration.<br>  }) | <pre>map(object({<br>    key_number      = string<br>    key_type        = optional(string, "RSA-HSM")<br>    key_size        = optional(number, 4096)<br>    not_before_date = optional(string, null)<br>    expiration_date = string<br>    key_opts        = list(string)<br>    rotation_policy = object({<br>      notify_before_expiry = string<br>      time_before_expiry   = string<br>      time_after_creation  = optional(string, null)<br>      expire_after         = string<br>    })<br>  }))</pre> | `{}` | no |
| <a name="input_key_vault_secrets"></a> [key_vault_secrets](#input_key_vault_secrets) | (Optional) A map of key vault secrets to be created with following variables:<br>  secret_number   = "(Required) Specifies secret number for multiple secrets to be created."<br>  value           = "(Required) Specifies the value of the Key Vault Secret. Changing this will create a new version of the Key Vault Secret."<br>  content_type    = "(Optional) Specifies the content type of the Key Vault Secret."<br>  not_before_date = "(Optional) Key not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z')."<br>  expiration_date = "(Optional) Expiration UTC datetime (Y-m-d'T'H:M:S'Z')." | <pre>map(object({<br>    secret_number   = string<br>    value           = string<br>    content_type    = optional(string, null)<br>    not_before_date = optional(string, null)<br>    expiration_date = optional(string, null)<br>  }))</pre> | `{}` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_network_acls"></a> [network_acls](#input_network_acls) | (Optional) The network ACL configuration for the Key Vault.<br>If not specified then the Key Vault will be created with a firewall that blocks access.<br>Specify `null` to create the Key Vault with no firewall.<br><br>- `bypass` - (Optional) Should Azure Services bypass the ACL. Possible values are `AzureServices` and `None`. Defaults to `None`.<br>- `default_action` - (Optional) The default action when no rule matches. Possible values are `Allow` and `Deny`. Defaults to `Deny`.<br>- `ip_rules` - (Optional) A list of IP rules in CIDR format. Defaults to `[]`.<br>- `virtual_network_subnet_ids` - (Optional) When using with Service Endpoints, a list of subnet IDs to associate with the Key Vault. Defaults to `[]`. | <pre>object({<br>    bypass                     = optional(string, "None")<br>    default_action             = optional(string, "Deny")<br>    ip_rules                   = optional(list(string), [])<br>    virtual_network_subnet_ids = optional(list(string), [])<br>  })</pre> | `{}` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_private_endpoint"></a> [private_endpoint](#input_private_endpoint) | (Required) Private Endpoint variables for Keyvault:<br>  subnet_id                         = "(Required) The ID of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint. Changing this forces a new resource to be created."<br>  is_manual_connection              = "(Optional) Does the Private Endpoint require Manual Approval from the remote resource owner? Changing this forces a new resource to be created."<br>  static_ip_required                = "(Optional) Whether a Static IP is required to be assigned to Private Endpoint or not."<br>  private_connection_resource_id    = "(Optional) The ID of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. One of `private_connection_resource_id` or `private_connection_resource_alias` must be specified. Changing this forces a new resource to be created."<br>  private_connection_resource_alias = "(Optional) The Service Alias of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. One of private_connection_resource_id or private_connection_resource_alias must be specified. Changing this forces a new resource to be created."<br>  ip_configuration = (Optional) map(object({<br>  private_ip_address = "(Required) Specifies the static IP address within the private endpoint's subnet to be used. Changing this forces a new resource to be created."<br>  subresource_name   = "(Optional) Specifies the subresource this IP address applies to."<br>  member_name        = "(Optional) Specifies the member name this IP address applies to."<br>})) | <pre>object({<br>    subnet_id                         = string<br>    is_manual_connection              = optional(bool, false)<br>    static_ip_required                = optional(bool, false)<br>    private_connection_resource_id    = optional(string, null)<br>    private_connection_resource_alias = optional(string, null)<br>    ip_configuration = optional(map(object({<br>      private_ip_address = string<br>      subresource_name   = optional(string, "vault")<br>      member_name        = optional(string, "default")<br>    })), {})<br>  })</pre> | n/a | yes |
| <a name="input_private_endpoints"></a> [private_endpoints](#input_private_endpoints) | (Required) Configuration for enabling Private Endpoints for the Storage Account. | <pre>object({<br>    blob = object({<br>      enable               = optional(bool, true)<br>      is_manual_connection = optional(bool, false)<br>      static_ip_required   = optional(bool, false)<br>      ip_configuration = optional(map(object({<br>        private_ip_address = string<br>        subresource_name   = string<br>        member_name        = optional(string, "default")<br>      })), {})<br>    })<br>    file_share = object({<br>      enable               = optional(bool, true)<br>      is_manual_connection = optional(bool, false)<br>      static_ip_required   = optional(bool, false)<br>      ip_configuration = optional(map(object({<br>        private_ip_address = string<br>        subresource_name   = string<br>        member_name        = optional(string, "default")<br>      })), {})<br>    })<br>    queue = object({<br>      enable               = optional(bool, true)<br>      is_manual_connection = optional(bool, false)<br>      static_ip_required   = optional(bool, false)<br>      ip_configuration = optional(map(object({<br>        private_ip_address = string<br>        subresource_name   = string<br>        member_name        = optional(string, "default")<br>      })), {})<br>    })<br>    table = object({<br>      enable               = optional(bool, true)<br>      is_manual_connection = optional(bool, false)<br>      static_ip_required   = optional(bool, false)<br>      ip_configuration = optional(map(object({<br>        private_ip_address = string<br>        subresource_name   = string<br>        member_name        = optional(string, "default")<br>      })), {})<br>    })<br>    subnet_id = string<br>  })</pre> | n/a | yes |
| <a name="input_queues"></a> [queues](#input_queues) | (Optional) List of Storage Queue configurations. | <pre>list(object({<br>    metadata = optional(map(any), null)<br>    instance = string<br>  }))</pre> | `[]` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) The name of the Resource group for Storage account creation. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku_name](#input_sku_name) | (Optional) The Name of the Sku used for the Key Vault. Possible values are standard and premium. | `string` | `"premium"` | no |
| <a name="input_storage_account"></a> [storage_account](#input_storage_account) | (Required) Configuration for the Storage Account. | <pre>object({<br>    account_tier                           = optional(string, "Standard")<br>    account_replication_type               = optional(string, "GRS")<br>    account_kind                           = optional(string, "StorageV2")<br>    access_tier                            = optional(string, "Hot")<br>    large_file_share_enabled               = optional(bool, false)<br>    nfsv3_enabled                          = optional(bool, false)<br>    enable_key_access                      = optional(bool, true)<br>    retention_policy_days                  = optional(number, 30)<br>    persist_access_key                     = optional(bool, true)<br>    cmk_key_expiration_date                = string<br>    kv_secret_expiration_date              = string<br>    enable_file_share_AADDS_authentication = optional(bool, true)<br>    default_to_oauth_authentication        = optional(bool, true)<br>    identity_type                          = optional(string, "UserAssigned")<br>    storage_policy_required                = optional(bool, false)<br>    static_website = optional(object({<br>      index_document     = optional(string)<br>      error_404_document = optional(string)<br>    }), null)<br>    rules = optional(map(object({<br>      name    = string<br>      enabled = bool<br>      filters = object({<br>        blob_types   = set(string)<br>        prefix_match = set(string)<br>        match_blob_index_tag = optional(object({<br>          name      = string<br>          operation = optional(string, "==")<br>          value     = string<br>        }))<br>      })<br>      actions = object({<br>        base_blob = optional(object({<br>          tier_to_cool_after_days_since_modification_greater_than        = optional(number)<br>          tier_to_cool_after_days_since_last_access_time_greater_than    = optional(number)<br>          tier_to_cool_after_days_since_creation_greater_than            = optional(number)<br>          auto_tier_to_hot_from_cool_enabled                             = optional(bool, false)<br>          tier_to_archive_after_days_since_modification_greater_than     = optional(number)<br>          tier_to_archive_after_days_since_last_access_time_greater_than = optional(number)<br>          tier_to_archive_after_days_since_creation_greater_than         = optional(number)<br>          tier_to_archive_after_days_since_last_tier_change_greater_than = optional(number)<br>          tier_to_cold_after_days_since_modification_greater_than        = optional(number)<br>          tier_to_cold_after_days_since_last_access_time_greater_than    = optional(number)<br>          tier_to_cold_after_days_since_creation_greater_than            = optional(number)<br>          delete_after_days_since_modification_greater_than              = optional(number)<br>          delete_after_days_since_last_access_time_greater_than          = optional(number)<br>          delete_after_days_since_creation_greater_than                  = optional(number)<br>        }))<br>        snapshot = optional(object({<br>          change_tier_to_archive_after_days_since_creation               = optional(number)<br>          tier_to_archive_after_days_since_last_tier_change_greater_than = optional(number)<br>          change_tier_to_cool_after_days_since_creation                  = optional(number)<br>          tier_to_cold_after_days_since_creation_greater_than            = optional(number)<br>          delete_after_days_since_creation_greater_than                  = optional(number)<br>        }))<br>        version = optional(object({<br>          change_tier_to_archive_after_days_since_creation               = optional(number)<br>          tier_to_archive_after_days_since_last_tier_change_greater_than = optional(number)<br>          change_tier_to_cool_after_days_since_creation                  = optional(number)<br>          tier_to_cold_after_days_since_creation_greater_than            = optional(number)<br>          delete_after_days_since_creation                               = optional(number)<br>        }))<br>      })<br>    })), {})<br>    network_rules = object({<br>      default_action             = optional(string, "Deny")<br>      bypass                     = optional(list(string), ["AzureServices"])<br>      ip_rules                   = optional(list(string), [])<br>      virtual_network_subnet_ids = optional(list(string), [])<br>    })<br>    cmk_key_rotation_policy = optional(object({<br>      notify_before_expiry = optional(string, "P358D")<br>      time_before_expiry   = optional(string, "P7D")<br>      time_after_creation  = optional(string, null)<br>      expire_after         = optional(string, "P365D")<br>    }), {})<br>    encryption_scopes = optional(map(object({<br>      name             = string<br>      key_vault_key_id = string<br>    })), {})<br>  })</pre> | n/a | yes |
| <a name="input_tables"></a> [tables](#input_tables) | (Optional) List of Table configurations. | <pre>list(object({<br>    instance = string<br>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_blob_private_endpoint_id"></a> [blob_private_endpoint_id](#output_blob_private_endpoint_id) | The ID of the blob private endpoint. |
| <a name="output_containers"></a> [containers](#output_containers) | The created container(s). |
| <a name="output_file_private_endpoints_id"></a> [file_private_endpoints_id](#output_file_private_endpoints_id) | The ID of the file share private endpoint. |
| <a name="output_file_shares"></a> [file_shares](#output_file_shares) | The created file share(s). |
| <a name="output_queue_private_endpoints_id"></a> [queue_private_endpoints_id](#output_queue_private_endpoints_id) | The ID of the queue private endpoint. |
| <a name="output_queues"></a> [queues](#output_queues) | The created queues(s). |
| <a name="output_storage_account_id"></a> [storage_account_id](#output_storage_account_id) | The ID of the storage account. |
| <a name="output_storage_account_name"></a> [storage_account_name](#output_storage_account_name) | The name of the storage account. |
| <a name="output_storage_resource"></a> [storage_resource](#output_storage_resource) | The storage account resource. |
| <a name="output_table_private_endpoints_id"></a> [table_private_endpoints_id](#output_table_private_endpoints_id) | The ID of the table private endpoint. |
| <a name="output_tables"></a> [tables](#output_tables) | The created tables(s). |
<!-- END_TF_DOCS -->
