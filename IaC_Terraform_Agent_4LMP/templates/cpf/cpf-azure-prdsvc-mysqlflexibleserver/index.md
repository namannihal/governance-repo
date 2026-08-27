---
version: 1.2.1
available_versions:
  - 1.2.1
  - 1.2.0
  - 1.1.2
  - 1.1.1
  - 1.1.0
---

<!-- BEGIN_TF_DOCS -->
# MySQL Flexible Server module

## Overview

This terraform module creates an Azure MySQL Flexible Server and associated resources.

## Prerequisites

- A `keyvault` with `private endpoint` for CMK is required before creating MySQL Flexible Server resource.
- A `subnet` delegated to `Microsoft.DBforMySQL/flexibleServers` is manadatory.
- A `Private DNS Zone` is mandatory to create with suffix `.mysql.database.azure.com`.

## Guidance

#### Usage

- Creating a GeoRestore server requires the source server with `geo_redundant_backup_enabled` enabled.
- When a server is first created it may not be immediately available for `geo restore` or `replica`. It may take a few minutes to several hours for the necessary metadata to be populated.
- `identity` is required when `customer_managed_key` is specified.
- The `private_dns_zone_id` is required when setting a `delegated_subnet_id`. The `azurerm_private_dns_zone` should end with suffix `.mysql.database.azure.com`.
- In this module we are not using centralized private DNS zone 'privatelink.mysql.database.azure.com'. It is intended only for Private End Point scenario. Therefore, we are creating own private dns zone and linking it with Vnet ID. Also, own private dns zone should not contain the privatelink label.
- The chosen subnet for `delegated_subnet_id` has to be delegated to Microsoft.DBforMySQL/flexibleServers.
- The `replication_role` cannot be set while creating and only can be updated from Replica to None.
- You can use Terraform's `ignore_changes` functionality to ignore changes to the `zone` and `high_availability.0.standby_availability_zone` fields should you wish for Terraform to not migrate the MySQL Flexible Server back to it's primary Availability Zone after a fail-over.
- The Availability Zones available depend on the Azure Region that the MySQL Flexible Server is being deployed into.
- `primary_user_assigned_identity_id` or `geo_backup_user_assigned_identity_id` is required when type is set to UserAssigned or SystemAssigned, UserAssigned.
- `storage.0.auto_grow_enabled` must be enabled when `high_availability` is enabled. To change the `high_availability` for a MySQL Flexible Server created with `high_availability` disabled during creation, the resource has to be recreated.
- The parameters `delegated_subnet_id` and `private_dns_zone_id` are optional and `null` by default, `private access` can be enabled by setting a value for these attributes.  
- Public network access is now enforced natively in `azurerm_mysql_flexible_server` by setting `public_network_access` to `Disabled` during resource creation.
- To use a `private_endpoint`, `delegated_subnet_id` and `private_dns_zone_id` should be null and a private endpoint must be created separately. Since public access is set to `Disabled` at create time, the old AzAPI post-create patch and related policy exemption flow are no longer required.
- A `private_endpoint` can be created without any Cyber Exemption for public network access when `delegated_subnet_id` and `private_dns_zone_id` are set to null.
- Customer Managed key and Continuous backup mode can only be enabled together with a valid `User Assigned`, `System Assigned` or `System Assigned, UserAssigned` Managed Identity.
- Use `key_vault_tags` variable to define additional Key Vault Key/Secret related tags in your product. Note that azure policies are enforcing a number N of tags for all products by default. Also note that Key Vault child resources support only 15 tags as the maximum limit. Therefore, please ensure the total count of tags enforced by policy and tags applied via variable does not exceed the limit. For example, if 10 tags are enforced via Azure policy, a maximum of 5 tags can be set via the `key_vault_tags` variable. Reference link - [Key tags](https://learn.microsoft.com/en-us/azure/key-vault/keys/about-keys-details#key-tags).
- Use the `tags` variable to define additional tags related to the product (core). Note that azure policies are enforcing a number N of tags for all products by default and that additional 3 tags are set on the main product via main terraform template.
If you are assigning additional tags (key-value pairs) via the `tags` variable, please ensure the total count does not exceed the limit supported by Azure resources. Reference link - [Azure Resources Tag Limitation](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/tag-support)
- The Azure MySQL Flexible Server Terraform module leverages an AzAPI update resource block to support storage sizes up to 32 TB, whereas the standard `azurerm` provider supports a maximum of 16 TB (16,384 GB). Storage size updates are managed exclusively through the AzAPI update block, with changes to `storage_size` intentionally ignored in the `azurerm` resource. To update the storage size users must enable the relevant AzAPI variable `enable_update_storage_size_gb` and specify the desired storage size using the variable `update_storage_size_gb`.

## Well-Architected Framework(WAF) for MySQL Flexible Server

- Wiki link: [WAF for MySQL Flexible Server](https://gitlab.dx1.lseg.com/groups/app/app-51310/azure/prdsvc/terraform/-/wikis/Cloud-Products-Well-Architecture-Framework-Principles---WAF/mysqlflexibleserver) for details on the WAF principles (Resiliency and Disaster Recovery(DR), Security, Cost Optimization and Operation Excellence).

#### Security Considerations

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-MSQLF-IA_010 | Use a Managed Identity for accessing Azure Resources | DB for MySQL must enforce the use of a Managed Identity to authenticate to Azure resources where this is supported (What) within target Access control settings (How) in order to remove the need to store credentials (Why) | True | True | This control is implemented via `identity {}` block. |
| 2. | AZU-MSQLF-IA_020 | Entra ID authentication only must be used | Entra ID authentication only must be used (What) within Authentication settings (How) in order to use modern robust and less prone to compromise authentication methods embedded within Entra ID (Why) | True | False | Product does not support only Entra authentication. Thus, both MySQL and Entra authentication is provided using `administrator_login` and `administrator_password` for MySQL authentication and `azurerm_mysql_flexible_server_active_directory_administrator` resource block to assign Entra admin. The Entra ID authentication is supported in code, but there is no PowerShell command to check authentication parameter values in Pester post-deployment test. |
| 3. | AZU-MSQLF-AC_010 | Disable Public Network Access | DB for MySQL must enforce a network guardrail (What) within Networking settings (How) in order to prevent unauthorised access and data exposure to the internet (Why) | True | True | This control will be implemented by setting the attributes `delegated_subnet_id` and `private_dns_zone_id`.|
| 4. | AZU-MSQLF-AU_010 |   Send all security and audit diagnostic log categories to a central SOC Log Analytics workspace |DB for MySQL must send all security and audit diagnostic logs to a central SOC Log Analytics workspace (What) within Diagnostic settings (How) in order to support a security investigation after a security incident (Why) | False | False | This control will be implemented via policy.|
| 5. | AZU-MSQLF-AU_030 |  DB for MySQL must ensure the MySQL server Audit log is enabled for all events capture| DB for MySQL must ensure the MySQL server Audit log is enabled for all events capture (What) via Server parameters settings (How) in order to support a security investigation after a security incident (Why) | True | True | This control is implemented by setting the `audit_log_enabled` server parameter to `ON` within the `azurerm_mysql_flexible_server_configuration` resource block.|
| 6. | AZU-MSQLF-AU_040 | DB for MySQL must ensure MySQL server timezone is consistent with wider related Azure logs timezone | DB for MySQL must ensure MySQL server timezone is consistent with wider related Azure logs timezone (What) via Server parameters settings (How) in order to ensure audit event timelines are consistent when needed during investigations (Why) | True | True | This control is implemented by setting the `time_zone` server parameter to `UTC` within the `azurerm_mysql_flexible_server_configuration` resource block. |
| 7. | AZU-MSQLF-SC_010 | Must use a dedicated CMK for DB for MySQL Transparent Data Encryption that is persisted in a Key Vault premium SKU | Use a dedicated DB for MySQL LSEG managed encryption at rest key persisted in a Key Vault premium SKU (What) within Data encryption settings (How) in order should Microsoft's key management platform become compromised LSEG can revoke access to exfiltrated encrypted data (Why) | True | True | This control is implemented via `customer_managed_key block` and using Key type as `RSA-HSM`.|
| 8. | AZU-MSQLF-SC_030 | Azure App Deployment must not be able to corrupt the centrally managed private DNS zones when integrating DB for MySQL into a VNet and supporting hostname resolution | Azure App Deployment must not be able to corrupt the centrally managed private DNS zones when integrating DB for MySQL into a VNet and supporting hostname resolution (What) via Policy to management group mapping (How) to ensure there is no ability for the Azure App Deployment team to have authorisation over these zones that could allow them to corrupt this file and impact service availability (Why) | False | False | This control will be implemented via policy.|
| 9. | AZU-MSQLF-SC_050 | DB for MySQL must have a data classification tag | DB for MySQL must have a data classification tag (What) via its Tags settings (How) in order to differentiate assets technical control requirements and to assist Security Operations in prioritising possible data breach mitigation responses (Why) | False | False | This control will be implemented via policy.|
| 10. | AZU-MSQLF-SC_060 | Network connections to the DB for MySQL control and data planes must use TLS encryption | DB for MySQL must enforce network flow encryption in transit using TLS (What) via Server parameters settings (How) in order to use modern techniques to establish robust encrypted data channels over untrusted networks (Why) | True | True | This control is implemented by default as the serevr parameter `tls_version` is set to `TLSV1.2` by default.|
| 11. | AZU-MSQLF-CP_010 | DB for MySQL should configure compute tier at Business Critical for Tier 1 workloads |  DB for MySQL should configure compute tier at Business Critical for Tier 1 workloads (What) within Compute + storage settings (How) in order to ensure appropriate levels of resilience when hosting production services (Why) | False | False | This control will be implemented as per LSEG Standard.|
| 12. | AZU-MSQLF-CP_040 | Backup retention policy must be reviewed against requirements and set accordingly |  Backup retention policy must be reviewed against requirements and set accordingly (What) within Compute + storage settings (How) in order to ensure retention meets the application, regulatory and disaster recovery requirements (Why) | False | False | This control will be implemented as per LSEG Standard. It can be done by setting the `backup_retention_days` parameter as per convenience.|
| 13. | AZU-MSQLF-SI_010 | MySQL version must be kept non-EOL and within n-2 versions | MySQL version must be kept non-EOL and within n-2 versions (What) in Deployment settings (How) in order to ensure service uses non-EOL software with latest security updates and policies (Why) | False | False | This control will be implemented as per LSEG Standard.|

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames)|
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Collect Diagnostics and send to Log Analytics]<br><br>[Monitor Azure Database for MySQL - Flexible Server](https://learn.microsoft.com/en-us/azure/mysql/flexible-server/concepts-monitoring)<br><br>[Cloud monitoring service level objectives ](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives)<br><br>[Supported metrics for Microsoft.DBforMySQL/flexibleServers](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-dbformysql-flexibleservers-metrics) |
| 5.| [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | True | automated backups and high availability addresses different levels of fault-protection with different recovery time and data loss exposures<br><br>[Overview of business continuity with Azure Database for MySQL - Flexible Server ](https://learn.microsoft.com/en-us/azure/mysql/flexible-server/concepts-business-continuity) <br><br>[Backup and restore in Azure Database for MySQL - Flexible Server](https://learn.microsoft.com/en-us/azure/mysql/flexible-server/concepts-backup-restore) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 8. | [SMCF-OPS-09 Update Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-09-03 Deploy regular software updates and bug-fixes<br><br>SMCF-OPS-09-04 Monitor software update status and remediate non-compliant resources | Documentation<br><br>Documentation | False | Azure Database for MySQL flexible server performs periodic maintenance to keep your managed database secure, stable, and up-to-date <br><br>[Scheduled maintenance in Azure Database for MySQL](https://learn.microsoft.com/en-us/azure/mysql/flexible-server/concepts-maintenance)<br><br>[Major version upgrade in Azure Database for MySQL](https://learn.microsoft.com/en-us/azure/mysql/flexible-server/how-to-upgrade)  |
| 9. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place.<br><br>[Azure built-in roles](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles)<br><br> [Microsoft Entra authentication for Azure Database for MySQL - Flexible Server](https://learn.microsoft.com/en-us/azure/mysql/flexible-server/concepts-azure-ad-authentication) |

## Changelog

[azure-prdsvc-terraform-mysqlflexibleserver](CHANGELOG.md)

## References

### Microsoft Docs
- [Official Documentation](https://learn.microsoft.com/en-us/azure/mysql/flexible-server/overview)
- [Azure Availability Zones documentation](https://azure.microsoft.com/en-gb/explore/global-infrastructure/geographies/#geographies)
- [Private DNS zone integration with MySQL Flexible Server](https://learn.microsoft.com/en-us/azure/mysql/flexible-server/concepts-networking-vnet)

### Terraform Docs
- [azurerm_mysql_flexible_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0 |
| <a name="requirement_azapi"></a> [azapi](#requirement_azapi) | >= 1.9 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm) | >=4.33 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azapi"></a> [azapi](#provider_azapi) | >= 1.9 |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | >=4.33 |
| <a name="provider_time"></a> [time](#provider_time) | n/a |

## Resources

| Name | Type |
|------|------|
| [azapi_update_resource.backup_interval](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/update_resource) | resource |
| [azapi_update_resource.storage_size](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/update_resource) | resource |
| [azurerm_key_vault_key.geo](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_key_vault_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_mysql_flexible_server.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server) | resource |
| [azurerm_mysql_flexible_server_active_directory_administrator.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server_active_directory_administrator) | resource |
| [azurerm_mysql_flexible_server_configuration.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server_configuration) | resource |
| [azurerm_role_assignment.cmk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cmk_geo](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [time_sleep.wait_60s_cmk](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_key_vault_key.cmk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_key) | data source |
| [azurerm_key_vault_key.cmk_geo](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_key) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_object_id"></a> [admin_object_id](#input_admin_object_id) | (Optional) The object ID of the Azure AD Administrator of this PostgreSQL Server. | `string` | `null` | no |
| <a name="input_admin_principal_name"></a> [admin_principal_name](#input_admin_principal_name) | (Optional) The Principal Name of the Azure AD Administrator of this PostgreSQL Server. | `string` | `null` | no |
| <a name="input_administrator"></a> [administrator](#input_administrator) | (Optional) An administrator block supports the following:<br/>object({<br/>   administrator_login = "(Optional) The Administrator login for the MySQL Flexible Server. Required when create_mode is Default. Changing this forces a new MySQL Flexible Server to be created."<br/>   administrator_password = "(Optional) The Password associated with the administrator_login for the MySQL Flexible Server. Required when create_mode is Default."<br/>}) | <pre>object({<br/>    administrator_login    = string<br/>    administrator_password = string<br/>  })</pre> | `null` | no |
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_backup_interval_hours"></a> [backup_interval_hours](#input_backup_interval_hours) | (Optional) The backup interval in hours for the MySQL Flexible Server. Possible values are between 12 and 24 hours. This can only be set via Azure API. | `number` | `null` | no |
| <a name="input_backup_retention_days"></a> [backup_retention_days](#input_backup_retention_days) | (Optional) The backup retention days for the MySQL Flexible Server. Possible values are between 1 and 35 days. | `number` | `7` | no |
| <a name="input_cmk_key_name"></a> [cmk_key_name](#input_cmk_key_name) | (optional) Key name to be used (max 127 chars) | `string` | `null` | no |
| <a name="input_cmk_rotation_policy"></a> [cmk_rotation_policy](#input_cmk_rotation_policy) | (Optional) A rotation policy block as defined below<br/>object({<br/>  notify_before_expiry = "(Optional) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>  time_before_expiry   = "(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br/>  time_after_creation  = "(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br/>  expire_after         = "(Optional) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>}) | <pre>object({<br/>    notify_before_expiry = string<br/>    time_before_expiry   = string<br/>    time_after_creation  = optional(string, null)<br/>    expire_after         = string<br/>  })</pre> | <pre>{<br/>  "expire_after": "P365D",<br/>  "notify_before_expiry": "P358D",<br/>  "time_after_creation": null,<br/>  "time_before_expiry": "P7D"<br/>}</pre> | no |
| <a name="input_configuration"></a> [configuration](#input_configuration) | (Optional) A configuration block supports the following:<br/>object({<br/>  name  = "(Required) Specifies the name of the MySQL Flexible Server Configuration, which needs to be a valid MySQL configuration name. Changing this forces a new resource to be created."<br/>  value = "(Required) Specifies the value of the MySQL Flexible Server Configuration. See the MySQL documentation for valid values."<br/>}) | <pre>map(object({<br/>    name  = string<br/>    value = string<br/>  }))</pre> | `{}` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_create_mode"></a> [create_mode](#input_create_mode) | (Optional) The creation mode which can be used to restore or replicate existing servers. Possible values are Default, PointInTimeRestore, GeoRestore and Replica. | `string` | `"Default"` | no |
| <a name="input_create_role_assignment"></a> [create_role_assignment](#input_create_role_assignment) | (Optional) Whether to create a role assignment to the service identity to allow access to the key vault keys. | `bool` | `true` | no |
| <a name="input_customer_managed_key"></a> [customer_managed_key](#input_customer_managed_key) | (Required) An customer_managed_key block as defined below<br/>object({<br/>  key_vault_id                      = "(Required) The resource ID of the Key Vault where the Key Vault Key resides."<br/>  key_vault_geo_id                  = "(Optional) The resource ID of the Key Vault for geobackup where the Key Vault Key resides."<br/>  expiration_date                   = "(Required) Expiration UTC datetime (Y-m-d'T'H:M:S'Z')."<br/>  uai_principal_id             = "(Required) The principal ID of the User Assigned Identity that has access to the key."<br/>  uai_principal_id_geo = "(Optional) The principal ID of the User Assigned Identity for geobackup that has access to the key."<br/>}) | <pre>object({<br/>    key_vault_id              = string<br/>    key_vault_geo_id          = optional(string)<br/>    expiration_date           = string<br/>    identity_principal_id     = string<br/>    identity_principal_id_geo = optional(string)<br/>  })</pre> | n/a | yes |
| <a name="input_delegated_subnet_id"></a> [delegated_subnet_id](#input_delegated_subnet_id) | (Optional) The ID of the virtual network subnet to create the MySQL Flexible Server. Changing this forces a new MySQL Flexible Server to be created. | `string` | `null` | no |
| <a name="input_enable_high_availability"></a> [enable_high_availability](#input_enable_high_availability) | (Optional) Is High Availability enabled for the MySQL Flexible Server. | `bool` | `false` | no |
| <a name="input_enable_update_backup_interval"></a> [enable_update_backup_interval](#input_enable_update_backup_interval) | (Optional) Indicates if the MySQL Flexible Server backup interval should be updated using AzAPI. | `bool` | `false` | no |
| <a name="input_enable_update_storage_size_gb"></a> [enable_update_storage_size_gb](#input_enable_update_storage_size_gb) | (Optional) Indicates if the MySQL Flexible Server storage size should be updated. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_geo_redundant_backup_enabled"></a> [geo_redundant_backup_enabled](#input_geo_redundant_backup_enabled) | (Optional) Is Geo-Redundant backup enabled on the MySQL Flexible Server. | `bool` | `false` | no |
| <a name="input_high_availability"></a> [high_availability](#input_high_availability) | (Optional) A high_availability block supports the following:<br/>object({<br/>  mode                      = "(Required) The high availability mode for the MySQL Flexible Server. Possible value are SameZone or ZoneRedundant."<br/>  standby_availability_zone = "(Optional) Specifies the Availability Zone in which the standby Flexible Server should be located. Possible values are 1, 2 and 3"<br/>}) | <pre>object({<br/>    mode                      = string<br/>    standby_availability_zone = optional(string)<br/>  })</pre> | <pre>{<br/>  "mode": "SameZone",<br/>  "standby_availability_zone": null<br/>}</pre> | no |
| <a name="input_identity"></a> [identity](#input_identity) | (Required) An identity block supports the following:<br/>object({<br/>  type         = "(Required) Specifies the type of Managed Service Identity that should be configured on this MySQL Flexible Server. The only possible value is UserAssigned."<br/>  identity_ids = "(Required) A list of User Assigned Managed Identity IDs to be assigned to this MySQL Flexible Server."<br/>}) | <pre>object({<br/>    type         = string<br/>    identity_ids = list(string)<br/>  })</pre> | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_key_vault_tags"></a> [key_vault_tags](#input_key_vault_tags) | (Optional) Key Vault related tags to be set on key vault child resources. | `map(any)` | `{}` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_maintenance_window"></a> [maintenance_window](#input_maintenance_window) | (Optional) A maintenance_window block supports the following:<br/>object({<br/>  day_of_week  = "(Optional) The day of week for maintenance window, where the week starts on a Sunday, i.e. Sunday = 0, Monday = 1. Defaults to 0."<br/>  start_hour   = "(Optional) The start hour for maintenance window. Defaults to 0."<br/>  start_minute = "(Optional) The start minute for maintenance window. Defaults to 0."<br/>}) | <pre>object({<br/>    day_of_week  = optional(number)<br/>    start_hour   = optional(number)<br/>    start_minute = optional(number)<br/>  })</pre> | <pre>{<br/>  "day_of_week": 0,<br/>  "start_hour": 0,<br/>  "start_minute": 0<br/>}</pre> | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_paired_location"></a> [paired_location](#input_paired_location) | (Optional) Paired Location of the resource group. | `string` | `null` | no |
| <a name="input_point_in_time_restore_time_in_utc"></a> [point_in_time_restore_time_in_utc](#input_point_in_time_restore_time_in_utc) | (Optional) The point in time to restore from creation_source_server_id when create_mode is PointInTimeRestore. Changing this forces a new MySQL Flexible Server to be created. Changing this forces a new MySQL Flexible Server to be created. | `string` | `null` | no |
| <a name="input_private_dns_zone_id"></a> [private_dns_zone_id](#input_private_dns_zone_id) | (Optional) The ID of the private DNS zone to create the MySQL Flexible Server. Changing this forces a new MySQL Flexible Server to be created. | `string` | `null` | no |
| <a name="input_replication_role"></a> [replication_role](#input_replication_role) | (Optional) The replication role. Possible value is None | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_server_version"></a> [server_version](#input_server_version) | (Optional) The version of the MySQL Flexible Server to use. Possible values are 5.7, 8.0.21, and 8.4. Changing this forces a new MySQL Flexible Server to be created. | `string` | `null` | no |
| <a name="input_sku_name"></a> [sku_name](#input_sku_name) | (Optional) The SKU Name for the MySQL Flexible Server. The name of the SKU, follows the tier + name pattern (e.g. B_Standard_B1ms, GP_Standard_D2s_v3, MO_Standard_E4s_v3) | `string` | `null` | no |
| <a name="input_source_server_id"></a> [source_server_id](#input_source_server_id) | (Optional) The resource ID of the source MySQL Flexible Server to be restored. Required when create_mode is PointInTimeRestore, GeoRestore, and Replica. Changing this forces a new MySQL Flexible Server to be created. | `string` | `null` | no |
| <a name="input_sql_mode"></a> [sql_mode](#input_sql_mode) | (Optional) The SQL mode for the MySQL Flexible Server.Set to custom value to disable specific modes or null to use MySQL system default. | `string` | `"ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION"` | no |
| <a name="input_storage"></a> [storage](#input_storage) | (Optional) A storage block supports the following:<br/>object({<br/>  auto_grow_enabled  = "(Optional) Should Storage Auto Grow be enabled?"<br/>  io_scaling_enabled   = "(Optional) Should IOPS be scaled automatically? If true, iops can not be set."<br/>  iops = " (Optional) The storage IOPS for the MySQL Flexible Server. Possible values are between 360 and 20000."<br/>  size_gb = "(Optional) The max storage allowed for the MySQL Flexible Server. Possible values are between 20 and 16384."<br/>}) | <pre>object({<br/>    auto_grow_enabled  = optional(bool)<br/>    io_scaling_enabled = optional(bool)<br/>    iops               = optional(number)<br/>    size_gb            = optional(number)<br/>  })</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_update_storage_size_gb"></a> [update_storage_size_gb](#input_update_storage_size_gb) | (Optional) The storage size in GB for the MySQL Flexible Server when using AzAPI update. Used for storage sizes greater than 16TB. Possible values are between 20 and 32768. Storage size can only be increased and cannot be downsized. | `number` | `null` | no |
| <a name="input_zone"></a> [zone](#input_zone) | (Optional) Specifies the Availability Zone in which the MySQL Flexible Server should be located. Possible values are 1, 2 and 3. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The Resource ID of the MySQL Flexible Server. |
| <a name="output_name"></a> [name](#output_name) | The Name of the MySQL Flexible Server. |
| <a name="output_resource"></a> [resource](#output_resource) | The MySQL Flexible Server resource. |
<!-- END_TF_DOCS -->
