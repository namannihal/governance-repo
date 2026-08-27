---
version: 1.0.3
available_versions:
  - 1.0.3
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.11.1
---

<!-- BEGIN_TF_DOCS -->
# MSSQL Server module


## Overview

This terraform module creates a MSSQL Server (PaaS) and associated resources.

## Prerequisites

- `Network Security Group`
- `Subnet`
- `User Assigned Identity` for Storage
- `User Assigned Identity` for MSSQL Server
- `Key Vault`
- `Private Endpoint` for Key Vault
- `Storage Account`
- `Private Endpoint` for Storage Blob

## Guidance

#### Usage

- When authenticated with a service principal, this module requires one of the following application roles: User.Read.All or Directory.Read.All

- Use `key_vault_tags` variable to define additional Key Vault Key/Secret related tags in your product. Note that azure policies are enforcing a number N of tags for all products by default. Also note that Key Vault child resources support only 15 tags as the maximum limit. Therefore, please ensure the total count of tags enforced by policy and tags applied via variable does not exceed the limit. For example, if 10 tags are enforced via Azure policy, a maximum of 5 tags can be set via the `key_vault_tags` variable. Reference link - [Key tags](https://learn.microsoft.com/en-us/azure/key-vault/keys/about-keys-details#key-tags).

- Use the `tags` variable to define additional tags related to the product (core). Note that azure policies are enforcing a number N of tags for all products by default and that additional 3 tags are set on the main product via main terraform template.
If you are assigning additional tags (key-value pairs) via the `tags` variable, please ensure the total count does not exceed the limit supported by Azure resources. Reference link - [Azure Resources Tag Limitation](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/tag-support)

- Supports identity block to use managed identity type as `SystemAssigned, UserAssigned` or `UserAssigned`. By default, TDE in Azure SQL uses the primary UserAssigned managed identity set on the server for key vault access. If no UserAssigned identities have been assigned to the server, then the SystemAssigned managed identity of the server is used for key vault access. However SystemAssigned managed identity cannot be assigned for TDE for keyvault access during sql server provisioning as policy blocks sql server provisioning due to no TDE encryption. SystemAssigned managed identity can only be extracted post provisioning of sql server.Reference link - [Managed Identities with CMK](https://learn.microsoft.com/en-us/azure/azure-sql/database/transparent-data-encryption-byok-identity?view=azuresql#considerations-while-using-umi-for-customer-managed-tde)

**IMPORTANT NOTE**

    - We have added `azurerm_mssql_firewall_rule` and `azurerm_mssql_virtual_network_rule` resource blocks for the resources which needs access to MSSQL server through networking to work properly. These blocks are made `Optional` with conditions.
    - For adding these rules, we need to put `public_network_access_enabled` as "True" and get the policy `Public network access on Azure SQL Database should be disabled` exempted so that the Server gets created without any issue.
    - To create Virtual Network rules in sql server, the required `Subnet` should have the ServiceEndpoint `Microsoft.Sql`.

- Below is the example on how to test the rules (please remember to add the subnet `service_endpoints` as mentioned above):

  ```
  public_network_access_enabled = true
  firewall_rules = {
    rule1 = {
      name             = "allow-azure-services"
      start_ip_address = "0.0.0.0"
      end_ip_address   = "0.0.0.0"
    }
    rule2 = {
      name             = "allow-azure-hdi-hm1"
      start_ip_address = "168.61.49.99"
      end_ip_address   = "168.61.49.99"
    }
    rule3 = {
      name             = "allow-azure-hdi-hm2"
      start_ip_address = "23.99.5.239"
      end_ip_address   = "23.99.5.239"
    }
  }
  vnet_rules = {
    vnet_rule1 = {
      name      = "allow-hdi-to-server"
      subnet_id = module.azure-prdsvc-terraform-subnet.id
    }
  }
  ```

#### Security Considerations

- For Transparent Data Encryption using Customer Managed key, the MSSQL Server only support the key size of 2048 and 3072 bytes [Microsoft Document](https://learn.microsoft.com/en-us/azure/key-vault/keys/byok-specification).

#### Vulnerability Assessment

This module supports **Vulnerability Assessment** for SQL Server to eliminate configuration drift and align with Azure Defender security policies.

##### Configuration

The module provides two optional object variables for security configuration:

1. **`security_alert_policy`** - Enables Advanced Threat Protection (prerequisite for vulnerability assessment)
   - `enabled` flag (default: `false`) - Controls resource creation
   - When enabled, configures threat detection settings

2. **`vulnerability_assessment`** - Configures vulnerability scanning with storage-based results
   - `enabled` flag (default: `false`) - Controls resource creation
   - Requires `security_alert_policy` to be enabled first

Both variables default to disabled to prevent unintended resource creation. Enable them explicitly when Azure Defender for SQL is enabled at subscription level to eliminate drift.

##### Usage Examples

**Enable Vulnerability Assessment (recommended when Azure Defender is enabled):**
```hcl
module "mssql_server" {
  source = "..."
  security_alert_policy = {
    enabled              = true
    state                = "Enabled"
    disabled_alerts      = []
    email_account_admins = true
    email_addresses      = []
  }
  vulnerability_assessment = {
    enabled                = true
    storage_container_path = "${azurerm_storage_account.example.primary_blob_endpoint}vulnerability-assessment/"
    recurring_scans = {
      enabled                   = true
      email_subscription_admins = true
      emails                    = []
    }
  }
}
```

**Disable for environments without compliance requirements (default):**
```hcl
module "mssql_server" {
  source = "..."
  # security_alert_policy and vulnerability_assessment not configured (defaults to disabled)
}
```

##### Important Notes

- Both resources use conditional creation with `count` based on the `enabled` flag
- Vulnerability assessment requires security alert policy to be enabled first
- Storage authentication uses managed identity (leverages existing Storage Blob Data Contributor role)
- No storage account access keys are stored in Terraform state
- Scan results are stored in the specified storage container path
- When Azure Defender for SQL is enabled at subscription level, this configuration matches what Azure Defender creates
- Addresses recurring drift issues in terraform plans

**References**:
- [SQL Vulnerability Assessment](https://learn.microsoft.com/en-us/azure/defender-for-cloud/sql-azure-vulnerability-assessment-overview)
- [Azure Defender for SQL](https://learn.microsoft.com/en-us/azure/defender-for-cloud/defender-for-sql-usage)
- [Security Alert Policy](https://learn.microsoft.com/en-us/azure/azure-sql/database/threat-detection-overview)

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-SQLS-IA\_010 | Use System Assigned Managed Identity for accessing Azure Resources | SQL server must enforce the use of its System Assigned Managed Identity to authenticate to Azure resources where this is supported (What) Access control settings (How) in order to adhere to the principle of least privilege and remove the need to store credentials (Why) | False | False | Only the User Assigned Managed Identity is supported. Implemented using `identity {}` block in `azurerm_mssql_server` terraform resource. This product supports the use of `User Assigned Managed Identity` only due to the CMK encryption constraints.|
| 2. | AZU-SQLS-IA\_020 | Entra ID authentication must be used except where SQL authentication is the only supported method |  Entra ID authentication must be used except where SQL authentication is the only supported method (What) within Microsoft Entra admin settings (How) in order to use modern robust and less prone to compromise authentication methods embedded within Entra ID (Why) | True | False | Latest control ID states SQL Authentication or Entra ID Authentication or Both SQL and Entra ID authentication can be used. Given provision to implemented using `azuread_administrator{}` block or `administrator_login` or both in `azurerm_mssql_server` terraform resource. |
| 3. | AZU-SQLS-AC\_010 | Disable Public Network Access | SQL Server must enforce a network guardrail if persisting data with internal and above data classification (What) within Networking settings (How) in order to prevent data exposure to the internet (Why) | True | True | Implemented by the setting the value of `public_network_access_enabled` arrgument to `false`. |
| 4. | AZU-SQLS-AC\_020 | Use least privilege RBAC built in roles for SQL server authorisation | Authorisation to SQL Server must use the built-in specific service RBAC roles (What) Access control settings (How) in order to restrict the blast radius should the authenticating credentials be compromised (Why) | False | False | The module is not creating any role assignment on the SQL Server. Granular RBAC can be enabled using a separate module at bundle/pattern level. |
| 5. | AZU-SQLS-AU\_010 | Send audit logs including Microsoft support operations to a central Log Analytics workspace | Send audit logs including Microsoft support operations to a central log Analytics workspace (What) Auditing settings (How) in order to support an security investigation after a security incident involving a SQL server and database (Why) | False | False | Audit Logging can be enabled using a separate module at bundle/pattern level.
| 6. | AZU-SQLS-AU\_011 | Send Microsoft support operations audit logs to a central SOC Log Analytics workspace | Send Microsoft support operations audit logs to a central SOC Log Analytics workspace (What) via Auditing settings (How) in order to support a security investigation after a security incident (Why) | False | False | Audit Logging can be enabled using a separate module at bundle/pattern level.
| 7. | AZU-SQLS-AU\_020 | Send audit logs to a central SOC Storage Account | Send audit logs to a central SOC Storage Account (What) via Auditing settings (How) In order to provide an immutable copy to adhere to compliance requirements (Why) | False | False | Audit Logging can be enabled using a separate module at bundle/pattern level.
| 8. | AZU-SQLS-AU\_021 | Send Microsoft support operations audit logs to central SOC Storage Account | Send Microsoft support operations audit logs to central SOC Storage Account (What) via Auditing settings (How) In order to provide an immutable copy to adhere to compliance requirements (Why) | False | False | Audit Logging can be enabled using a separate module at bundle/pattern level.
| 9. | AZU-SQLS-AU\_030 | SQL Server Audit Action and Group must include important properties | SQL Server Audit Actions and Groups properties should contain at least SUCCESSFUL\_DATABASE\_AUTHENTICATION\_GROUP, FAILED\_DATABASE\_AUTHENTICATION\_GROUP, BATCH\_COMPLETED\_GROUP (What) Auditing settings (How) in order to support a security investigation after a security incident involving a SQL server and database (Why) | True | True | Auditing can be enabled by providing input using `auditing_policy` variable. The default auditing policy in SQL Server includes the following set of action groups, SUCCESSFUL\_DATABASE\_AUTHENTICATION\_GROUP, FAILED\_DATABASE\_AUTHENTICATION\_GROUP and BATCH\_COMPLETED\_GROUP. |
| 10. | AZU-SQLS-CP\_010 | Backup retention policy must be reviewed against requirements and set accordingly | The default backup retention policy must be reviewed against requirements and set accordingly (What) in Retention policies (How) to ensure retention meets the application, regulatory and disaster recovery requirements (Why) | False | False | Backup retention policy for the SQL database can be configured using the SQL database module during the database creation. |
| 11. | AZU-SQLS-SC\_010 | Must use a dedicated CMK for SQL Server Transparent Data Encryption that is persisted in an HSM backed Key Vault | Use a dedicated SQL Server LSEG managed encryption at rest key persisted in an HSM backed Key Vault (What) within Transparent data encryption settings (How) in order should Microsoft's key management platform become compromised LSEG can revoke access to exfiltrated encrypted data (Why) | True | True | Implemented using `azurerm_mssql_server_transparent_data_encryption` terraform resource. |
| 12. | AZU-SQLS-SC\_020 | SQL Server must have a data classification tag | SQL Server must have a data classification tag (What) via its Tags settings (How) in order to differentiate assets technical control requirements and to assist Security Operations in prioritising possible data breach mitigation responses (Why) | True | False | This cloud product has a provision to input the list of tags based on user input using variable tags, adding any mandantory tags can be taken care during the provisioning of resource.|

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames)|
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place.<br><br>[Azure built-in roles](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles) |

## Changelog

- [azure-prdsvc-terraform-mssqlserver](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/azure-sql/database/sql-database-paas-overview?view=azuresql-db)

### Terraform Docs

- [azurerm_mssql_server](https://registry.terraform.io/providers/hashicorp/azurerm/3.40.0/docs/resources/mssql_server)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0 |
| <a name="requirement_azapi"></a> [azapi](#requirement_azapi) | >=1.9 |
| <a name="requirement_azuread"></a> [azuread](#requirement_azuread) | >= 2.40 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm) | >=4.33 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azapi"></a> [azapi](#provider_azapi) | >=1.9 |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | >=4.33 |

## Resources

| Name | Type |
|------|------|
| [azapi_update_resource.serverautoRotationEnabled](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/update_resource) | resource |
| [azurerm_key_vault_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_mssql_firewall_rule.firewalls](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_firewall_rule) | resource |
| [azurerm_mssql_server.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server) | resource |
| [azurerm_mssql_server_extended_auditing_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server_extended_auditing_policy) | resource |
| [azurerm_mssql_server_microsoft_support_auditing_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server_microsoft_support_auditing_policy) | resource |
| [azurerm_mssql_server_security_alert_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server_security_alert_policy) | resource |
| [azurerm_mssql_server_vulnerability_assessment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server_vulnerability_assessment) | resource |
| [azurerm_mssql_virtual_network_rule.allow_access_to_mssqlserver](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_virtual_network_rule) | resource |
| [azurerm_role_assignment.auditing](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cmk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_group_name"></a> [admin_group_name](#input_admin_group_name) | (Optional) The group name of the Azure AD Administrator of this MS SQL Server. | `string` | `null` | no |
| <a name="input_admin_object_id"></a> [admin_object_id](#input_admin_object_id) | (Optional) The object id of the Azure AD Administrator of this SQL Server. | `string` | `null` | no |
| <a name="input_admin_user_email"></a> [admin_user_email](#input_admin_user_email) | (Optional) The email of the Azure AD Administrator of this MS SQL Server. | `string` | `null` | no |
| <a name="input_admin_username"></a> [admin_username](#input_admin_username) | (Optional) The login username of the Azure AD Administrator of this SQL Server. | `string` | `null` | no |
| <a name="input_administrator_login"></a> [administrator_login](#input_administrator_login) | (Optional) The administrator login name for the new server. | `string` | `null` | no |
| <a name="input_administrator_login_password"></a> [administrator_login_password](#input_administrator_login_password) | (Optional) The password associated with the administrator_login user. Needs to comply with Azure's Password Policy | `string` | `null` | no |
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_auditing_policy"></a> [auditing_policy](#input_auditing_policy) | (Optional) An auditing policy block as defined below<br/>object({<br/>  storage_account_id                 = "(Required) The ID of the Storage Account to hold all extended auditing logs."<br/>  retention_in_days                  = "(Optional) The number of days to retain logs for in the storage account.Defaults to 0."<br/>  enabled                            = "(Optional) Whether to enable the extended auditing policy."<br/>  log_monitoring_enabled             = "(Optional) Enable audit events to Azure Monitor? To enable server audit events to Azure Monitor, please enable its main database audit events to Azure Monitor."<br/>  audit_microsoft_support_operations = "(Optional) Enable auditing of Microsoft support operations tracks Microsoft support engineers' (DevOps) operations on your server."<br/>}) | <pre>object({<br/>    storage_account_id                 = string<br/>    retention_in_days                  = optional(number, 0)<br/>    enabled                            = optional(bool, true)<br/>    log_monitoring_enabled             = optional(bool, true)<br/>    audit_microsoft_support_operations = optional(bool, true)<br/>  })</pre> | `null` | no |
| <a name="input_azuread_admin_authentication"></a> [azuread_admin_authentication](#input_azuread_admin_authentication) | (Optional) Specifies whether AD Users and administrators (e.g. azuread_administrator[0].login_username) can be used to login, or also local database users (e.g. administrator_login). When true, the administrator_login and administrator_login_password properties can be omitted. | `bool` | `true` | no |
| <a name="input_azuread_authentication_only"></a> [azuread_authentication_only](#input_azuread_authentication_only) | (Optional) Specifies whether only AD Users and administrators (e.g. azuread_administrator[0].login_username) can be used to login, or also local database users (e.g. administrator_login). When true, the administrator_login and administrator_login_password properties can be omitted. | `bool` | `false` | no |
| <a name="input_cmk_key_name"></a> [cmk_key_name](#input_cmk_key_name) | (optional) Key name to be used (max 127 chars) | `string` | `null` | no |
| <a name="input_cmk_rotation_policy"></a> [cmk_rotation_policy](#input_cmk_rotation_policy) | (Optional) A rotation policy block as defined below<br/>object({<br/>  notify_before_expiry = "(Optional) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>  time_before_expiry   = "(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br/>  time_after_creation  = "(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br/>  expire_after         = "(Optional) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>}) | <pre>object({<br/>    notify_before_expiry = string<br/>    time_before_expiry   = string<br/>    time_after_creation  = optional(string, null)<br/>    expire_after         = string<br/>  })</pre> | <pre>{<br/>  "expire_after": "P365D",<br/>  "notify_before_expiry": "P358D",<br/>  "time_after_creation": null,<br/>  "time_before_expiry": "P7D"<br/>}</pre> | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_create_role_assignment"></a> [create_role_assignment](#input_create_role_assignment) | (Optional) Whether to create a role assignment to the service identity to allow access to the key vault keys. | `bool` | `true` | no |
| <a name="input_customer_managed_key"></a> [customer_managed_key](#input_customer_managed_key) | (Required) An customer_managed_key block as defined below<br/>object({<br/>  key_vault_id                      = "(Required) The resource ID of the Key Vault where the Key Vault Key resides."<br/>  expiration_date                   = "(Required) Expiration UTC datetime (Y-m-d'T'H:M:S'Z')."<br/>  identity_principal_id             = "(Required) The principal ID of the User Assigned Identity that has access to the key."<br/>}) | <pre>object({<br/>    key_vault_id          = string<br/>    expiration_date       = string<br/>    identity_principal_id = string<br/>  })</pre> | n/a | yes |
| <a name="input_data_encryption_key"></a> [data_encryption_key](#input_data_encryption_key) | (Optional) ID of the key for Transparent Data Encryption. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_failover_group"></a> [failover_group](#input_failover_group) | (Optional) Enable Failover Group. | `bool` | `false` | no |
| <a name="input_firewall_rules"></a> [firewall_rules](#input_firewall_rules) | (Optional) A map of firewall rules block supports the following:<br/>object({<br/>  name             = "(Required) The name of the firewall rule. Changing this forces a new resource to be created."<br/>  start_ip_address = "(Required) The starting IP address to allow through the firewall for this rule."<br/>  end_ip_address   = "(Required) The ending IP address to allow through the firewall for this rule."<br/>}) | <pre>map(object({<br/>    name             = string<br/>    start_ip_address = string<br/>    end_ip_address   = string<br/>  }))</pre> | `{}` | no |
| <a name="input_identity"></a> [identity](#input_identity) | (Required) An identity block as defined below<br/>object({<br/>  type         = "(Required) Specifies the type of Managed Service Identity that should be configured on this MS SQL Server.  Possible values are UserAssigned, SystemAssigned, UserAssigned (to enable both)."<br/>  identity_ids = "(Required) Specifies a list of User Assigned Managed Identity IDs to be assigned to this MS SQL Server. This is required for setting TDE for giving access to CMK key vault key. The first element will be made primary_user_assigned_identity_id. This should be given if type is UserAssigned or SystemAssigned, UserAssigned"<br/>}) | <pre>object({<br/>    type         = string<br/>    identity_ids = list(string)<br/>  })</pre> | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_key_vault_tags"></a> [key_vault_tags](#input_key_vault_tags) | (Optional) Key Vault related tags to be set on key vault child resources. | `map(any)` | `{}` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public_network_access_enabled](#input_public_network_access_enabled) | (Optional) Whether public network access is allowed for this server. | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Optional) Name of the Resource Group in which to create the resource. | `string` | `"a1a-51310-dev-rg-testing-uks-02"` | no |
| <a name="input_security_alert_policy"></a> [security_alert_policy](#input_security_alert_policy) | (Optional) A security alert policy block as defined below<br/>object({<br/>  enabled                    = "(Optional) Boolean flag to enable or disable the security alert policy resource. Defaults to false."<br/>  state                      = "(Optional) Specifies the state of the policy, whether it is enabled or disabled. Possible values are Enabled and Disabled. Defaults to Enabled."<br/>  disabled_alerts            = "(Optional) Specifies an array of alerts that are disabled. Allowed values are: Sql_Injection, Sql_Injection_Vulnerability, Access_Anomaly, Data_Exfiltration, Unsafe_Action, Brute_Force."<br/>  email_account_admins       = "(Optional) Boolean flag which specifies if the alert is sent to the account administrators or not. Defaults to true."<br/>  email_addresses            = "(Optional) Specifies an array of email addresses to which the alert is sent."<br/>  retention_days             = "(Optional) Specifies the number of days to keep in the Threat Detection audit logs. Defaults to 0."<br/>  storage_endpoint           = "(Optional) Specifies the blob storage endpoint (e.g. https://example.blob.core.windows.net). This blob storage will hold all Threat Detection audit logs."<br/>  storage_account_access_key = "(Optional) Specifies the identifier key of the Threat Detection audit storage account."<br/>}) | <pre>object({<br/>    enabled                    = optional(bool, false)<br/>    state                      = optional(string, "Enabled")<br/>    disabled_alerts            = optional(list(string), [])<br/>    email_account_admins       = optional(bool, true)<br/>    email_addresses            = optional(list(string), [])<br/>    retention_days             = optional(number, 0)<br/>    storage_endpoint           = optional(string, null)<br/>    storage_account_access_key = optional(string, null)<br/>  })</pre> | `{}` | no |
| <a name="input_server_name"></a> [server_name](#input_server_name) | (Optional) The Principal Name of the Azure AD Administrator of this MS SQL Server. | `string` | `null` | no |
| <a name="input_server_version"></a> [server_version](#input_server_version) | (Optional) The version for the new server. Valid values are: 2.0 (for v11 server) and 12.0 (for v12 server). | `string` | `"12.0"` | no |
| <a name="input_service_principal"></a> [service_principal](#input_service_principal) | (Optional) The email of the Azure AD Administrator of this MS SQL Server. | `string` | `null` | no |
| <a name="input_storage_account_primary_blob_endpoint"></a> [storage_account_primary_blob_endpoint](#input_storage_account_primary_blob_endpoint) | (Required) The endpoint URL for blob storage in the primary location. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_vnet_rules"></a> [vnet_rules](#input_vnet_rules) | (Optional) A map of vnet rules block supports the following:<br/>object({<br/>  name      = "(Required) The name of the SQL virtual network rule. Changing this forces a new resource to be created."<br/>  subnet_id = "(Required) The ID of the subnet from which the SQL server will accept communications."<br/>}) | <pre>map(object({<br/>    name      = string<br/>    subnet_id = string<br/>  }))</pre> | `{}` | no |
| <a name="input_vulnerability_assessment"></a> [vulnerability_assessment](#input_vulnerability_assessment) | (Optional) A vulnerability assessment block as defined below<br/>object({<br/>  enabled                    = "(Optional) Boolean flag which specifies if vulnerability assessment is enabled. Defaults to false."<br/>  storage_container_path     = "(Optional) A blob storage container path to hold the scan results (e.g. https://example.blob.core.windows.net/vulnerability-assessment/)."<br/>  storage_account_access_key = "(Optional) Specifies the identifier key of the storage account for vulnerability assessment scan results."<br/>  recurring_scans = object({<br/>    enabled                   = "(Optional) Boolean flag which specifies if recurring scans is enabled. Defaults to true."<br/>    email_subscription_admins = "(Optional) Boolean flag which specifies if the schedule scan notification will be sent to the subscription administrators. Defaults to true."<br/>    emails                    = "(Optional) Specifies an array of email addresses to which the scan notification is sent."<br/>  })<br/>}) | <pre>object({<br/>    enabled                    = optional(bool, false)<br/>    storage_container_path     = optional(string, null)<br/>    storage_account_access_key = optional(string, null)<br/>    recurring_scans = optional(object({<br/>      enabled                   = optional(bool, true)<br/>      email_subscription_admins = optional(bool, true)<br/>      emails                    = optional(list(string), [])<br/>    }), {})<br/>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The ID of the created SQL server. |
| <a name="output_name"></a> [name](#output_name) | The name of the created SQL server. |
| <a name="output_resource"></a> [resource](#output_resource) | The Azure SQL server Resource. |
<!-- END_TF_DOCS -->
