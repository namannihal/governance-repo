---
version: 1.1.2
available_versions:
  - 1.1.2
  - 1.1.1
  - 1.1.0
  - 1.0.1
  - 1.0.0
---

<!-- BEGIN_TF_DOCS -->
# Azure Synapse Workspace Module

## Overview

This terraform module creates a Azure Synapse Workspace resource and associated resource Synapse Spark pool.

## Prerequisites

- `Resource Group` name is required.
- A `key vault` to store the Customer Managed Key and other required secrets.
- A `managed identity` is required for CMK.
- One `Network security Group`, `Subnet`, `Route table`.
- Private endpoint for `keyVault` , `data lake storage` , `Blob storage`.
- One `storage data lake gen 2 file system`.
- `Time sleep` function to propagate DNS entries in the private DNS zone.

## Guidance

#### Usage

###### AzureRM 3.x to 4.x Upgrade Notes for Synapse Workspace

Product Impact -- Medium

Users in azurerm 3.x migrating to 4.x  need to consider the following changes

  - The `aad_admin` and `sql_aad_admin` configurations are now managed through dedicated resources (`azurerm_synapse_workspace_aad_admin` and `azurerm_synapse_workspace_sql_aad_admin`) instead of inline blocks within the workspace resource.

  - Wiki link for [AzureRM 4.x Upgrade](https://gitlab.dx1.lseg.com/groups/app/app-51310/azure/prdsvc/terraform/-/wikis/Terraform-AzureRM-Provider-Upgrade:-Version-3.x-to-4.x/Synapse-Workspace) for details on the upgrade process.

For more details, refer to the official [AzureRM 4.x Upgrade Guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide)

###### Others

- This Module Covers the deployment of Azure Synapse Workspace with Customer Managed Key.
- There is a conflict between `aad_admin` and `customer_managed_key`using `azurerm_synapse_workspace` resource block.So we cannot use both argument in the `azurerm_synapse_workspace` resource block.
- Activation of Synapse Workspace is not included in this Module due to terraform limitation and this needs to be activated manually.
- This Module now supports the Azure Synapse Workspace spark pool creation. A "azurerm_synapse_spark_pool" & azurerm_synapse_workspace_key resource block and is added.
- Customer Managed key and Continuous backup mode can only be enabled together with a valid `User Assigned`, `System Assigned` or `System Assigned, UserAssigned` Managed Identity.
- Use `key_vault_tags` variable to define additional Key Vault Key/Secret related tags in your product. Note that azure policies are enforcing a number N of tags for all products by default. Also note that Key Vault child resources support only 15 tags as the maximum limit. Therefore, please ensure the total count of tags enforced by policy and tags applied via variable does not exceed the limit. For example, if 10 tags are enforced via Azure policy, a maximum of 5 tags can be set via the `key_vault_tags` variable. Reference link - [Key tags](https://learn.microsoft.com/en-us/azure/key-vault/keys/about-keys-details#key-tags).
- Use the `tags` variable to define additional tags related to the product (core). Note that azure policies are enforcing a number N of tags for all products by default and that additional 3 tags are set on the main product via main terraform template.
If you are assigning additional tags (key-value pairs) via the `tags` variable, please ensure the total count does not exceed the limit supported by Azure resources. Reference link - [Azure Resources Tag Limitation](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/tag-support)
- The `identity` block allows the `type` to be either `SystemAssigned` or `SystemAssigned, UserAssigned`. However, the Synapse workspace does not support `UserAssigned` as the only identity type. A validation for this restriction has been added in the variables file.
- The code currently supports customer-managed key encryption only with a system-assigned identity. It does not yet support customer-managed keys with a user-assigned identity.

<b>IMPORTANT</b>:

  - Please make sure the datalakestore's name is in between 3-24 alphanumeric characters while providing the values for `locals` in test main.tf.
  - If in case the name goes beyond 24 characters, it will give an error `This object does not have an attribute named "azurerm_data_lake_store".`

 #### Additional Information

  - A Synapse workspace key is specific type of Customer-Managed key (CMK) used to encrypt data within an Azure Synapse workspace.
  - While CMK generally refers to key managed by customers for various Azure services, a Synpase Workspace key is specifically used for encryption within Synapse Analytics.
  - Unlike general CMKs, Synapse Workspace keys are dedicated to securing data in Synapse environments and integrated directly with synapse for encryption purposes, ensuring no conflict as they serve the same encryption goal within different contexts.

#### Security Considerations

- As per the Security policy, `Public access` to Synapse workspace is disabled.
- Whenever Synapse workspace is created, a default `SQL server` is created automatically to deploy SQL pools in Synapse. Since, `Resource type` is categorized under `Microsoft.sql/servers`, Any policies applied to Microsoft.sql/servers will also be applicable for Synapse workspace. (The `Deny` policy titled `Public network access on Azure SQL Database should be disabled` is also applicable to Synapse.)
- To securely access Synapse Studio, Creating a `Synapse Private Link Hub` along with a Private endpoint with subresource_name `Web` is an option. This setup secures the end-to-end connection to Synapse Studio.
- To securely access Synapse Studio, Please raise a `ZPA request` using the link `https://lsegroup.sharepoint.com/sites/CloudCentral/SitePages/ZScaler-Private-Access-(ZPA)-%E2%80%93-Application-Onboarding-Process.aspx?OR=Teams-HL&CT=1727419844294&clickparams=eyJBcHBOYW1lIjoiVGVhbXMtRGVza3RvcCIsIkFwcFZlcnNpb24iOiI1MC8yNDA4MTcwMDQxOSJ9` and provide Synapse private endpoint details.

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-SYN-IA_010 | Entra ID authentication only must be used | Entra ID authentication only must be used (What) on the Entra ID settings (How) in order to use modern, robust and less prone to compromise authentication methods embedded within Entra ID (Why) | True | True | This Control Implemented using `azuread_authentication_only `. |
| 2. | AZU-SYN-IA_020 | Use Managed Identity for accessing Azure resources | Synapse Analytics must enforce the use of a Managed Identity to authenticate to Azure resources where this is supported (What) within target service access control settings (How) in order to remove the need to store credentials (Why) | True | True | This Control Implemented using `identity {}`.|
| 3. | AZU-SYN-AC_010 | Public access to Synapse Analytics Studio and Workspace must only be accessed from a managed device | Public access to Synapse Analytics Studio and Workspace must only be accessed from a managed device (What) using Conditional Access policies (How) in order to prevent access from unmanaged devices (Why) | False | False | Control implemented by technical configuration setting: False. Will be implemented by LSEG standard. |
| 4. | AZU-SYN-AU_010 | Azure Synapse Analytics must send diagnostic logs to a central Log Analytics workspace | Azure Synapse Analytics must send diagnostic logs for SynapseGatewayApiRequests and SynapseRbacOperations to a central Log Analytics workspace (What) within its Diagnostic settings (How) in order to support a security investigation after a security incident involving Synapse Analytics (Why) | False | False | This control will be implemented via policy. |
| 5. | AZU-SYN-AU_020 | Azure Synapse Analytics must send SQL Audit Logs to the central Log Analytics Workspace | Azure Synapse Analytics must send SQL Audit Logs to the central Log Analytics Workspace (What) in the Auditing settings (How) in order to support a security investigation after a security incident involving Synapse Analytics (Why) | False | False | This control will be implemented via policy. |
| 6. | AZU-SYN-AU_030 | Azure Synapse SQL Server Audit Action and group must include important properties | Azure Synapse SQL Server Audit Actions and Groups properties should contain at least SUCCESSFUL_DATABASE_AUTHENTICATION_GROUP, FAILED_DATABASE_AUTHENTICATION_GROUP, BATCH_COMPLETED_GROUP (What) Auditing settings (How) in order to support a security investigation after a security incident involving an Azure Synapse SQL server and database (Why)| False | False | This Module only creates the Azure Synapse Workspace and configuration of SQL database properties are not part Azure Synapase Module. |
| 7. | AZU-SYN-AU_050 |  Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval (What) within Diagnostic settings (How) in order to prevent sensitive data leakage to third parties outside of LSEG control (Why) | False | False | This control will be implemented via policy. |
| 8. | AZU-SYN-SC_010 | Use a minimum of TLS version 1.2 for network connections to Azure Synapse SQL Server control and data planes | Azure Synapse SQL Server must enforce a minimum TLS version of 1.2 (What) in the Workspace settings (How) in order to establish robust encryption data channels over untrusted networks (Why) | False | False | This control not implemented in the code but by default Azure Synapse workspace is comes under TLS1.2 |
| 9. | AZU-SYN-SC_011 |  Credentials for other resources/systems must be stored in Azure Key Vault when Managed Identities cannot be used | Credentials for other resources/systems must be stored in Azure Key Vault (What) on the Properties page of a credential in the Synapse Analytics portal (How) in order to ensure the security of credentials (Why) | False | False | Control implemented by technical configuration setting: False. Will be implemented by LSEG standard. |
| 10. | AZU-SYN-SC_020 | Synapse Analytics must use a managed Virtual Network | Synapse Analytics must use a managed Virtual Network (What) on the Networking settings (How) to ensure network isolation of the Workspace (Why) | True | True | This Control Implemented using `managed_virtual_network_enabled `. |
| 11. | AZU-SYN-SC_030 | Use a dedicated Synapse Analytics CMK for Encryption that is persisted in an HSM backed Key Vault |  Synapse Analytics must enforce the use of a dedicated LSEG managed encryption at rest key persisted in an HSM backed Key Vault (What) in the Encryption settings (How) in order should Microsoft's key management platform become compromised LSEG can revoke access to exfiltrated encrypted data (Why) | True | True | This Control Implemented using `customer_managed_key `. |
| 12. | AZU-SYN-SC_040| Azure Synapse Analytics must have data exfiltration prevention enabled |   Azure Synapse Analytics must have data exfiltration prevention enabled (What) in the Network settings (How) so that only connections from Synapse Analytics are to resources located in LSEG approved Azure AD tenants (Why) | True | True |This Control Implemented using `data_exfiltration_protection_enabled`. |
| 13. | AZU-SYN-SC_050 | Synapse Analytics must not be used to move or copy data to a location outside the classification ceiling | Synapse Analytics must not be used to move or copy data to a target that is not within the data classification ceiling (What) within the Integration settings (How) to ensure data is kept within locations that have been approved for such classification and to reduce the risk of data exfiltration (Why) | False | False | Control implemented by technical configuration setting: False. Will be implemented by LSEG standard. |
| 14. | AZU-SYN-SC_070 | Synapse Analytics must have a data classification tag | SQL Server and databases must have a data classification tag (What) via its Tags settings (How) in order to differentiate assets technical control requirements and to assist Security Operations in prioritising possible data breach mitigation responses (Why) | False | False |This control will be implemented via policy. |
| 15. | AZU-SYN-SC_080 | Azure App Deployment must not be able to corrupt the centrally managed private link private DNS zones when making a private end point for Synapse Workspaces | Synapse Workspaces must have an Azure DeployIfNotExists policy to update the centrally managed private link private DNS zones with its private A record (What) via Policy to management group mapping (How) to ensure there is no ability for the Azure App Deployment team to have authorisation over these zones that could allow them to corrupt this file and impact service availability (Why) | False | False | Control implemented via technical configuration : False. |

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br><br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames)|
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Collect Diagnostics and send to Log Analytics]<br><br>[Monitor Synapse Workspace](https://learn.microsoft.com/en-us/azure/synapse-analytics/get-started-monitor)<br><br>[Cloud monitoring service level objectives ](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives)<br><br>[Supported metrics for Microsoft Synapse workspaces](https://learn.microsoft.com/en-us/azure/synapse-analytics/monitor-synapse-analytics-reference#supported-metrics-for-microsoftsynapseworkspaces) |
| 5.| [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | True | Use dedicated SQL pool restore points to recover or copy your data warehouse to a previous state in the primary region. Use data warehouse geo-redundant backups to restore to a different geographical region..<br><br>[Failover for business continuity and disaster recovery ](https://learn.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/backup-and-restore?context=%2Fazure%2Fsynapse-analytics%2Fcontext%2Fcontext#geo-backups-and-disaster-recovery)<br><br>[Backup and restore dedicated SQL pools in Azure Synapse Analytics](https://learn.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/backup-and-restore?context=%2Fazure%2Fsynapse-analytics%2Fcontext%2Fcontext) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 8. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place.<br><br>[Synapse RBAC Roles](https://learn.microsoft.com/en-us/azure/synapse-analytics/security/synapse-workspace-synapse-rbac-roles) |

## Changelog

- [azure-prdsvc-terraform-synapseworkspace](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/synapse-analytics/)

- [Connect Synapse from a restricted network](https://learn.microsoft.com/en-us/azure/synapse-analytics/security/how-to-connect-to-workspace-from-restricted-network#step-4-create-private-endpoints-for-your-workspace-resource)

### Terraform Docs

- [azurerm_synapse_workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_workspace)

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
| [azurerm_key_vault_key.cmk1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_role_assignment.system](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_synapse_spark_pool.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_spark_pool) | resource |
| [azurerm_synapse_workspace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_workspace) | resource |
| [azurerm_synapse_workspace_aad_admin.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_workspace_aad_admin) | resource |
| [azurerm_synapse_workspace_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_workspace_key) | resource |
| [azurerm_synapse_workspace_sql_aad_admin.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_workspace_sql_aad_admin) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aad_admin"></a> [aad_admin](#input_aad_admin) | (Optional) A aad_admin block as defined below.<br/>  object({<br/>    login  = "(Required) The login name of the Azure AD Administrator of this Synapse Workspace."<br/>    object_id = "(Required) The object id of the Azure AD Administrator of this Synapse Workspace."<br/>    tenant_id = (Required) The tenant id of the Azure AD Administrator of this Synapse Workspace.<br/>  }) | <pre>map(object({<br/>    login     = string<br/>    object_id = string<br/>    tenant_id = string<br/>  }))</pre> | `null` | no |
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_azure_devops_repo"></a> [azure_devops_repo](#input_azure_devops_repo) | (Optional) A azure_devops_repo block as defined below.<br/>  object({<br/>    account_name  = "(Required) Specifies the Azure DevOps account name."<br/>    branch_name   = "(Required) Specifies the collaboration branch of the repository to get code from."<br/>    last_commit_id = "(Optional) The last commit ID."<br/>    project_name = "(Required) Specifies the name of the Azure DevOps project."<br/>    repository_name = "(Required) Specifies the name of the git repository."<br/>    root_folder  = "(Required) Specifies the root folder within the repository. Set to / for the top level."<br/>    tenant_id  = "(Optional) the ID of the tenant for the Azure DevOps account."<br/>  }) | <pre>object({<br/>    account_name    = string<br/>    branch_name     = string<br/>    last_commit_id  = string<br/>    project_name    = string<br/>    repository_name = string<br/>    root_folder     = string<br/>    tenant_id       = string<br/>  })</pre> | `null` | no |
| <a name="input_cmk_key_name"></a> [cmk_key_name](#input_cmk_key_name) | (optional) Key name to be used (max 127 chars) | `string` | `null` | no |
| <a name="input_cmk_rotation_policy"></a> [cmk_rotation_policy](#input_cmk_rotation_policy) | (Optional) A rotation policy block as defined below<br/>object({<br/>  notify_before_expiry = "(Optional) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>  time_before_expiry   = "(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br/>  time_after_creation  = "(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br/>  expire_after         = "(Optional) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>}) | <pre>object({<br/>    notify_before_expiry = string<br/>    time_before_expiry   = string<br/>    time_after_creation  = optional(string, null)<br/>    expire_after         = string<br/>  })</pre> | <pre>{<br/>  "expire_after": "P365D",<br/>  "notify_before_expiry": "P358D",<br/>  "time_after_creation": null,<br/>  "time_before_expiry": "P7D"<br/>}</pre> | no |
| <a name="input_compute_subnet_id"></a> [compute_subnet_id](#input_compute_subnet_id) | (Optional) Subnet ID used for computes in workspace Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_customer_managed_key"></a> [customer_managed_key](#input_customer_managed_key) | (Required) An customer_managed_key block as defined below<br/>  object({<br/>    key_vault_id                 = "(Required) The resource ID of the Key Vault where the Key Vault Key resides."<br/>    expiration_date              = "(Required) Expiration UTC datetime (Y-m-d'T'H:M:S'Z')."<br/>  }) | <pre>object({<br/>    key_vault_id    = string<br/>    expiration_date = string<br/>  })</pre> | n/a | yes |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_github_repo"></a> [github_repo](#input_github_repo) | (Optional) A azure_devops_repo block as defined below.<br/>  object({<br/>    account_name  = "(Required) Specifies the GitHub account name."<br/>    branch_name = "(Required) Specifies the collaboration branch of the repository to get code from."<br/>    last_commit_id = "(Optional) The last commit ID."<br/>    repository_name = "(Required) Specifies the name of the git repository."<br/>    root_folder  = "(Required) Specifies the root folder within the repository. Set to / for the top level."<br/>    git_url  = "(Optional) Specifies the GitHub Enterprise host name."<br/>  }) | <pre>object({<br/>    account_name    = string<br/>    branch_name     = string<br/>    last_commit_id  = string<br/>    repository_name = string<br/>    root_folder     = string<br/>    git_url         = string<br/>  })</pre> | `null` | no |
| <a name="input_identity"></a> [identity](#input_identity) | (Optional) A Identity block as defined below.<br/>  object({<br/>    type = "(Required) Specifies the type of Managed Service Identity that should be associated with this Synapse Workspace.Possible values are SystemAssigned, UserAssigned and SystemAssigned, UserAssigned (to enable both)."<br/>    identity_ids = "(Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Synapse Workspace."<br/>  }) | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | <pre>{<br/>  "identity_ids": null,<br/>  "type": "SystemAssigned"<br/>}</pre> | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_key_vault_tags"></a> [key_vault_tags](#input_key_vault_tags) | (Optional) Key Vault related tags to be set on key vault child resources. | `map(any)` | `{}` | no |
| <a name="input_linking_allowed_for_aad_tenant_ids"></a> [linking_allowed_for_aad_tenant_ids](#input_linking_allowed_for_aad_tenant_ids) | (Optional) Allowed AAD Tenant Ids For Linking. | `list(string)` | `[]` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_managed_resource_group_name"></a> [managed_resource_group_name](#input_managed_resource_group_name) | (Optional) Workspace managed resource group. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_purview_id"></a> [purview_id](#input_purview_id) | (Optional) The ID of purview account. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_spark_pools"></a> [spark_pools](#input_spark_pools) | "(Optional) Map containing Spark Pool Objects."<br/>map(object({<br/>  node_size_family                    = (Required) The kind of nodes that the Spark Pool provides. Possible values are HardwareAcceleratedFPGA, HardwareAcceleratedGPU, MemoryOptimized, and None.<br/>  node_size                           = (Required) The level of node in the Spark Pool. Possible values are Small, Medium, Large, None, XLarge, XXLarge and XXXLarge.<br/>  node_count                          = (Optional) The number of nodes in the Spark Pool. Exactly one of node_count or auto_scale must be specified.<br/>  cache_size                          = (Optional) The cache size in the Spark Pool.<br/>  compute_isolation_enabled           = (Optional) Indicates whether compute isolation is enabled or not. Defaults to false.<br/>  dynamic_executor_allocation_enabled = (Optional) Indicates whether Dynamic Executor Allocation is enabled or not. Defaults to false.<br/>  min_executors                       = (Optional) The minimum number of executors allocated only when dynamic_executor_allocation_enabled set to true.<br/>  max_executors                       = (Optional) The maximum number of executors allocated only when dynamic_executor_allocation_enabled set to true.<br/>  session_level_packages_enabled      = (Optional) Indicates whether session level packages are enabled or not. Defaults to false.<br/>  spark_log_folder                    = (Optional) The default folder where Spark logs will be written. Defaults to /logs.<br/>  spark_events_folder                 = (Optional) The Spark events folder. Defaults to /events.<br/>  spark_version                       = (Optional) The Apache Spark version. Possible values are 2.4 , 3.1 , 3.2, 3.3, and 3.4. Defaults to 2.4.<br/>  autoscale_max_node_count            = (Optional) The maximum number of nodes the Spark Pool can support. Must be between 3 and 200.<br/>  autoscale_min_node_count            = (Optional) The minimum number of nodes the Spark Pool can support. Must be between 3 and 200.<br/>  autopause_delay_in_minutes          = (Optional) Number of minutes of idle time before the Spark Pool is automatically paused. Must be between 5 and 10080.<br/>  requirements_content                = (Optional) The content of library requirements.<br/>  requirements_filename               = (Optional) The name of the library requirements file.<br/>  spark_config_content                = (Optional) The contents of a spark configuration.<br/>  spark_config_filename               = (Optional) The name of the file where the spark configuration content will be stored.<br/>})) | <pre>map(object({<br/>    node_size_family                    = string<br/>    node_size                           = string<br/>    node_count                          = optional(number, null) #"Cannot set both node_count and autoscale_max/min_node_count."<br/>    cache_size                          = optional(number, null)<br/>    compute_isolation_enabled           = optional(bool, false)<br/>    dynamic_executor_allocation_enabled = optional(bool, false)<br/>    min_executors                       = optional(number, null)<br/>    max_executors                       = optional(number, null)<br/>    session_level_packages_enabled      = optional(bool, false)<br/>    spark_log_folder                    = optional(string, "/logs")<br/>    spark_events_folder                 = optional(string, "/events")<br/>    spark_version                       = optional(string, "3.4")<br/>    autoscale_max_node_count            = optional(number, 5) #"Cannot set both node_count and autoscale_max/min_node_count."<br/>    autoscale_min_node_count            = optional(number, 3) #"Cannot set both node_count and autoscale_max/min_node_count."<br/>    autopause_delay_in_minutes          = optional(number, null)<br/>    requirements_content                = optional(string, null)<br/>    requirements_filename               = optional(string, null)<br/>    spark_config_content                = optional(string, null)<br/>    spark_config_filename               = optional(string, null)<br/>  }))</pre> | `{}` | no |
| <a name="input_sql_aad_admin"></a> [sql_aad_admin](#input_sql_aad_admin) | (Optional) A sql_aad_admin block as defined below.<br/>  object({<br/>    login  = "(Required) The login name of the Azure AD Administrator of this Synapse Workspace SQL."<br/>    object_id = "(Required) The object id of the Azure AD Administrator of this Synapse Workspace SQL."<br/>    tenant_id = "(Required) The tenant id of the Azure AD Administrator of this Synapse Workspace SQL."<br/>  }) | <pre>map(object({<br/>    login     = string<br/>    object_id = string<br/>    tenant_id = string<br/>  }))</pre> | `null` | no |
| <a name="input_sql_administrator_login"></a> [sql_administrator_login](#input_sql_administrator_login) | (Optional) Specifies The login name of the SQL administrator.If this is not provided aad_admin or customer_managed_key must be provided. | `string` | `null` | no |
| <a name="input_sql_administrator_login_password"></a> [sql_administrator_login_password](#input_sql_administrator_login_password) | (Optional) The Password associated with the sql_administrator_login for the SQL administrator.If this is not provided aad_admin or customer_managed_key must be provided. | `string` | `null` | no |
| <a name="input_sql_identity_control_enabled"></a> [sql_identity_control_enabled](#input_sql_identity_control_enabled) | (Optional) Are pipelines (running as workspace's system assigned identity) allowed to access SQL pools | `bool` | `true` | no |
| <a name="input_storage_data_lake_gen2_filesystem_id"></a> [storage_data_lake_gen2_filesystem_id](#input_storage_data_lake_gen2_filesystem_id) | (Required) Specifies the ID of storage data lake gen2 filesystem resource. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The Resource ID of the Azure Synapse Workspace. |
| <a name="output_name"></a> [name](#output_name) | The Name of the Azure Synapse Workspace. |
| <a name="output_resource"></a> [resource](#output_resource) | The Resource of the Azure Logic App Workflow |
<!-- END_TF_DOCS -->
