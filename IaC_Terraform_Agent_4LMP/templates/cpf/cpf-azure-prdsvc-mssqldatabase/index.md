---
version: 1.0.2
available_versions:
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.7.1
  - 0.7.0
---

<!-- BEGIN_TF_DOCS -->
# MSSQL Database module


## Overview

This terraform module creates a azurerm_mssql_database and associated resources like SQL DB resources. and associated resources.

## Prerequisites

- `Key Vault` is required to created initially which is to be linked to the storage account.
- `Storage Account` is required to be created from which a `Storage Container` is created which is to be linked to MS SQL server.
- `MS SQL Server` is required to be craeted which is to be linked to MS SQL Database.

## Guidance

#### Usage

- This module deploys the Azure SQL Database which will be associated with sql server
- Using of a minimum of TLS version 1.2 for network connections to the SQL Database control and data planes, will be enabled via MS SQL Server module.
- Transparent data encryption at the database level is optional. If not provided, Server level encryption will be applied.
- This module doesn't create the role assignment to access the Key Vault keys, as the role assignment is already created in the MSSQLServer module. When using different Key Vaults for the Server and the Database, set `var.create_role_assignment_db_key` to `true` to ensure the role assignment is created.

#### Security Considerations

#### Additional Information

- `Provisioned` Database is supported for `General Purpose`, `Hyperscale`, `Business Critical`, `Premium`, `Standard` and `Basic` SKUs.
- `Serverless` Database is supported only for `General Purpose` and `Hyperscale` SKUs.
- `read_replica_count`: This is only settable for `Hyperscale` SKUs. It sets the number of read replicas for the database. If `zone redundancy` is enabled, the minimum replica count is 1.
- `read_scale`: This is only settable for `Business Critical`, `Hyperscale` and `Premium` SKUs. It enables or disables read scale for the database. It has to be enabled for `Hyperscale` SKU .
- `zone_redundant`: This is only settable for `Premium`, `Business Critical`, `General Purpose`, and `Hyperscale` SKUs. It enables or disables zone redundancy for the database.
- `license_type`: This is only settable for `Business Critical` and `General Purpose` under `Provisioned` Database SKUs. It sets the license type for the database.
- `auto_pause_delay_in_minutes`: This is only settable for `General Purpose` Serverless SKUs. It sets the delay before the database is automatically paused, with a range of 1 hour to 7 days.
- `min_capacity`: This is only settable for `General Purpose` Serverless and `Hyperscale` Serverless SKUs. It sets the minimum capacity for the database, with a default of 0.5 cores.
- SQL Databases on Azure support both `DTU-based` and `vCore-based` purchasing models. Data Warehousing (DW) workloads are not supported in Azure SQL Database. For `DW` workloads, use Azure Synapse Analytics (formerly SQL Data Warehouse) with dedicated SQL pools.

#### Important: Customer-Managed Key Rotation Timing:

When using CMK, Azure SQL Database takes up to `1 hour` to sync with a new key version after rotation in Key Vault.

Wait at least 1 hour after key rotation before running `terraform apply`.

The module's `data.azurerm_key_vault_key.cmk` in main.tf fetches the latest key immediately, but the database may still be using the old key for active transactions. Running terraform apply too soon will fail with the error: `PerDatabaseCMKKeyRotationAttemptedWhileOldThumbprintInUse`

Best Practice: This module enables `transparent_data_encryption_key_automatic_rotation_enabled = true` by default. Let Azure handle rotation automatically and plan deployments with the 1-hour buffer.

Reference: [Azure SQL Database Key Rotation](https://learn.microsoft.com/en-us/azure/azure-sql/database/transparent-data-encryption-byok-database-level-overview?view=azuresql&tabs=azurekeyvault#limitations:~:text=managed%20keys.-,Limitations,-The%20database%20level)

#### Well-Architected Framework (WAF) for MSSQL Database

- Refer to the Wiki for mssqldatabase WAF [documentation](https://gitlab.dx1.lseg.com/groups/app/app-51310/azure/prdsvc/terraform/-/wikis/Cloud-Products-Well-Architecture-Framework-Principles---WAF/mssqldatabase) covering core principles: Reliability, Disaster Recovery (DR), Security, Cost Optimization, and Operational Excellence.

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-SQLDB-IA_010 |  Entra ID authentication must be used except where SQL authentication is the only supported method | Entra ID authentication must be used except where SQL authentication is the only supported method (What) via Client services settings (How) in order to use modern robust and less prone to compromise authentication methods embedded within Entra ID (Why) | False | False | This control will be implemented as part of MS SQL Server.
| 2. | AZU-SQLDB-AC_020 | Must use Dynamic Data Masking for Highly Restricted data where it is inappropriate for technical administrators to see the clear text business data columns | When database authorisation roles do not provide granularity to prevent users accessing data they have no requirement to access, Dynamic Data Masking must be used to protect this data (what) database Security settings (How) to prevent inappropriate technical administrators access to clear text business data columns (Why) | False | False | As per the security control document, `Control implemented by technical configuration setting:False`. This control will be implemented via LSEG Standard as most cost effective approach.
| 3. | AZU-SQLDB-SC_020 | Use a minimum of TLS version 1.2 for network connections to the SQL Database control and data planes | SQL Server / database must enforce a minimum TLS version of 1.2 (What) within its Network settings (How) in order to use modern techniques to establish robust encrypted data channels over untrusted networks (Why) | False | False | This control will be implemented as part of MS SQL Server.
| 4. | AZU-SQLDB-SC_030 | SQL Databases must have a data classification tag | The SQL Databases must have a data classification tag (What) via its Tags settings (How) in order to differentiate assets technical control requirements and to assist Security Operations in prioritising possible data breach mitigation responses (Why) | True | False | This cloud product has a provision to input the list of tags based on user input using variable tags, adding any mandantory tags can be taken care during the provisioning of resource.
| 5. | AZU-SQLDB-SC_040 | Azure App Deployment must not be able to corrupt the centrally managed private link private DNS zones when making a private end point for SQL Database | SQL Database must have an Azure DeployIfNotExists policy to update the centrally managed private link private DNS zones with its private A record (What) via Policy to management group mapping (How) to ensure there is no ability for the Azure App Deployment team to have authorisation over these zones that could allow them to corrupt this file and impact service availability (Why) | False | False | Control is not implemented via technical configuration setting.
| 6. | AZU-SQLDB-SC_060 | Transparent Data Encryption on SQL databases must be enabled | Transparent Data Encryption on SQL databases must be enabled (What) within Security settings (How) in order to protect data-at-rest and meet compliance requirements (Why) | True | False | Implemented by setting the value of `transparent_data_encryption_enabled` to `true`.

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Monitor Azure SQL Database](https://learn.microsoft.com/en-us/azure/azure-sql/database/monitoring-sql-database-azure-monitor?view=azuresql)<br><br>[Azure SQL database auditing](https://learn.microsoft.com/en-us/azure/azure-sql/database/auditing-overview?view=azuresql)<br><br>[Azure SQL Database and Azure SQL Managed Instance extended events ](https://learn.microsoft.com/en-us/azure/azure-sql/database/xevent-db-diff-from-svr?view=azuresql&tabs=sqldb)<br><br>[Cloud monitoring service level objectives](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives)<br><br>[Supported metrics for Azure SQL database](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-sql-servers-databases-metrics) |
| 5. | [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | True | This control will be implemented by the `account_replication_type` variable within parent storage account to specify the redundancy option as `LRS`, `GRS`, `RAGRS`, `ZRS`, `GZRS` and `RAGZRS`. It defaults to `GRS`<br><br>The `zone_redundant` is used to enable replicas of this database to be spread across multiple availability zones<br><br> `long_term_retention_policy` and `short_term_retention_policy` are used to configure database backups and set a retention period for the same.<br><br>[Overview of business continuity with Azure SQL Database](https://learn.microsoft.com/en-us/azure/azure-sql/database/business-continuity-high-availability-disaster-recover-hadr-overview?view=azuresql)<br><br>[High availability for Azure SQL Database](https://learn.microsoft.com/en-us/azure/azure-sql/database/high-availability-sla?view=azuresql&tabs=azure-powershell)<br><br>[Automated backups in Azure SQL Database](https://learn.microsoft.com/en-us/azure/azure-sql/database/automated-backups-overview?view=azuresql)<br><br>[Active geo-replication](https://learn.microsoft.com/en-us/azure/azure-sql/database/active-geo-replication-overview?view=azuresql) |
| 6. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place.<br><br>[Azure built-in roles](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles)<br><br>[Manage Azure AD users and groups in Azure SQL Database](https://learn.microsoft.com/en-us/azure/azure-sql/database/authentication-aad-configure?view=azuresql&tabs=azure-powershell)<br><br>[Authorize database access](https://learn.microsoft.com/en-us/azure/azure-sql/database/logins-create-manage?view=azuresql) |

## Changelog

[azure-prdsvc-terraform-mssqldatabase](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation] https://learn.microsoft.com/en-us/azure/azure-sql/database/sql-database-paas-overview?view=azuresql-db

### Terraform Docs

- [azurerm_mssql_database] https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_database

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm) | >=4.33 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | >=4.33 |
| <a name="provider_time"></a> [time](#provider_time) | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_mssql_database.sqldb](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_database) | resource |
| [azurerm_role_assignment.cmk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [time_sleep.wait_60s_cmk](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [azurerm_key_vault_key.cmk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_key) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_auto_pause_delay_in_minutes"></a> [auto_pause_delay_in_minutes](#input_auto_pause_delay_in_minutes) | (Optional) Time in minutes after which database is automatically paused. A value of -1 means that automatic pause is disabled. Enabling auto-pause for a serverless database is not supported if long-term backup retention is enabled. | `number` | `null` | no |
| <a name="input_cmk_name"></a> [cmk_name](#input_cmk_name) | (optional) Customer managed key name to be used (max 127 chars) | `string` | `null` | no |
| <a name="input_cmk_rotation_policy"></a> [cmk_rotation_policy](#input_cmk_rotation_policy) | (Optional) A rotation policy block as defined below<br/>object({<br/>  notify_before_expiry = "(Optional) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>  time_before_expiry   = "(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br/>  time_after_creation  = "(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br/>  expire_after         = "(Optional) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>}) | <pre>object({<br/>    notify_before_expiry = optional(string)<br/>    time_before_expiry   = optional(string)<br/>    time_after_creation  = optional(string, null)<br/>    expire_after         = optional(string)<br/>  })</pre> | <pre>{<br/>  "expire_after": "P365D",<br/>  "notify_before_expiry": "P358D",<br/>  "time_after_creation": null,<br/>  "time_before_expiry": "P7D"<br/>}</pre> | no |
| <a name="input_collation"></a> [collation](#input_collation) | (Optional) Specifies the collation of the database. | `string` | `"SQL_Latin1_General_CP1_CI_AS"` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_create_mode"></a> [create_mode](#input_create_mode) | (Optional) The create mode of the database. Possible values are Copy, Default, OnlineSecondary, PointInTimeRestore, Recovery, Restore, RestoreExternalBackup, RestoreExternalBackupSecondary, RestoreLongTermRetentionBackup and Secondary | `string` | `"Default"` | no |
| <a name="input_create_role_assignment_db_key"></a> [create_role_assignment_db_key](#input_create_role_assignment_db_key) | Enable assigning the `Key Vault Crypto User` role to the service identity to allow its access to the key vault keys. | `bool` | `false` | no |
| <a name="input_creation_source_database_id"></a> [creation_source_database_id](#input_creation_source_database_id) | (Optional) The ID of the source database from which to create the new database. This should only be used for databases with create_mode values that use another database as reference. | `string` | `null` | no |
| <a name="input_customer_managed_key"></a> [customer_managed_key](#input_customer_managed_key) | (Optional) An customer_managed_key block as defined below<br/>object({<br/>  key_vault_id                      = "(Required) The resource ID of the Key Vault where the Key Vault Key resides."<br/>  expiration_date                   = "(Required) Expiration UTC datetime (Y-m-d'T'H:M:S'Z')."<br/>  identity_principal_id             = "(Required) The principal ID of the User Assigned Identity that has access to the key."<br/>}) | <pre>object({<br/>    key_vault_id          = string<br/>    expiration_date       = string<br/>    identity_principal_id = string<br/>  })</pre> | `null` | no |
| <a name="input_data_encryption_key"></a> [data_encryption_key](#input_data_encryption_key) | (Optional) ID of the key for Transparent Data Encryption. | `string` | `null` | no |
| <a name="input_database_name"></a> [database_name](#input_database_name) | (Optional) Name for the database | `string` | `null` | no |
| <a name="input_elastic_pool_id"></a> [elastic_pool_id](#input_elastic_pool_id) | (Optional) Specifies the ID of the elastic pool containing this database. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_geo_backup_enabled"></a> [geo_backup_enabled](#input_geo_backup_enabled) | (Optional) Specifies if the Geo Backup Policy is enabled | `bool` | `true` | no |
| <a name="input_identity"></a> [identity](#input_identity) | (Required) An identity block as defined below<br/>object({<br/>  type         = "(Required) Specifies the type of Managed Service Identity that should be configured on this MS SQL Database. Possible values are `UserAssigned`."<br/>  identity_ids = "(Required) Specifies a list of User Assigned Managed Identity IDs to be assigned to this MS SQL Database. This is required when `type` is set to `UserAssigned`."<br/>}) | <pre>object({<br/>    type         = string<br/>    identity_ids = list(string)<br/>  })</pre> | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_ledger_enabled"></a> [ledger_enabled](#input_ledger_enabled) | (Optional) A boolean that specifies if this is a ledger database | `bool` | `false` | no |
| <a name="input_license_type"></a> [license_type](#input_license_type) | (Optional) Specifies the license type applied to this database. Possible values are LicenseIncluded and BasePrice when using Provisioned Database and `null` for Using Serverless DB. Under Provisioned Database SKUs, this is only settable for `Business Critical` and `General Purpose` Provisioned Service tiers. | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_long_term_retention_policy"></a> [long_term_retention_policy](#input_long_term_retention_policy) | (Optional) A long_term_retention_policy block | <pre>object({<br/>    weekly_retention  = string #(Optional) The weekly retention policy for an LTR backup in an ISO 8601 format. Valid value is between 1 to 520 weeks. e.g. P1Y, P1M, P1W or P7D.<br/>    monthly_retention = string #(Optional) The monthly retention policy for an LTR backup in an ISO 8601 format. Valid value is between 1 to 120 months. e.g. P1Y, P1M, P4W or P30D.<br/>    yearly_retention  = string #(Optional) The yearly retention policy for an LTR backup in an ISO 8601 format. Valid value is between 1 to 10 years. e.g. P1Y, P12M, P52W or P365D.<br/>    week_of_year      = number #(Optional) The week of year to take the yearly backup. Value has to be between 1 and 52.<br/>  })</pre> | <pre>{<br/>  "monthly_retention": null,<br/>  "week_of_year": 1,<br/>  "weekly_retention": null,<br/>  "yearly_retention": null<br/>}</pre> | no |
| <a name="input_maintenance_configuration_name"></a> [maintenance_configuration_name](#input_maintenance_configuration_name) | (Optional) The name of the Public Maintenance Configuration window to apply to the database | `string` | `"SQL_Default"` | no |
| <a name="input_max_size_gb"></a> [max_size_gb](#input_max_size_gb) | (Optional) The max size of the database in gigabytes | `number` | `null` | no |
| <a name="input_min_capacity"></a> [min_capacity](#input_min_capacity) | (Optional) Minimal capacity that database will always have allocated, if not paused. This property is only settable for General Purpose and HyperScale Serverless databases. It sets the minimum capacity for the database, with a default of 0.5 cores. | `number` | `null` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_read_replica_count"></a> [read_replica_count](#input_read_replica_count) | (Optional) The number of readonly secondary replicas associated with the database to which readonly application intent connections may be routed. This property is only settable for Hyperscale edition databases. If zone redundancy is enabled, the minimum replica count is 1. | `number` | `0` | no |
| <a name="input_read_scale"></a> [read_scale](#input_read_scale) | (Optional) If enabled, connections that have application intent set to readonly in their connection string may be routed to a readonly secondary replica. This property is only settable for Premium, Hyperscale and Business Critical databases. | `bool` | `false` | no |
| <a name="input_recover_database_id"></a> [recover_database_id](#input_recover_database_id) | (Optional) The ID of the database to be recovered. This property is only applicable when the create_mode is Recovery. | `string` | `null` | no |
| <a name="input_restore_dropped_database_id"></a> [restore_dropped_database_id](#input_restore_dropped_database_id) | (Optional) The ID of the database to be restored. This property is only applicable when the create_mode is Restore. | `string` | `null` | no |
| <a name="input_restore_point_in_time"></a> [restore_point_in_time](#input_restore_point_in_time) | (Optional) Specifies the point in time (ISO8601 format) of the source database that will be restored to create the new database. This property is only settable for create_mode= PointInTimeRestore databases. | `string` | `null` | no |
| <a name="input_sample_name"></a> [sample_name](#input_sample_name) | (Optional) Specifies the name of the sample schema to apply when creating this database. Possible value is AdventureWorksLT. | `string` | `null` | no |
| <a name="input_secondary_type"></a> [secondary_type](#input_secondary_type) | (Optional) Specify how do you want replica to be made? Valid values include Geo, Named and Standby. Defaults to Geo. Changing this forces a new resource to be created. | `string` | `"Geo"` | no |
| <a name="input_server_id"></a> [server_id](#input_server_id) | (Required) Specifies the sql server ID to associate it with database. | `string` | n/a | yes |
| <a name="input_short_term_retention_policy"></a> [short_term_retention_policy](#input_short_term_retention_policy) | (Optional) A short_term_retention_policy block | <pre>object({<br/>    retention_days           = number #(Required) Point In Time Restore configuration. Value has to be between 7 and 35.<br/>    backup_interval_in_hours = number #(Optional) The hours between each differential backup. This is only applicable to live databases but not dropped databases. Value has to be 12 or 24. Defaults to 12 hours.<br/>  })</pre> | <pre>{<br/>  "backup_interval_in_hours": null,<br/>  "retention_days": null<br/>}</pre> | no |
| <a name="input_sku_name"></a> [sku_name](#input_sku_name) | (Optional) Specifies the name of the sku used by the database. Changing this forces a new resource to be created. For example, GP_S_Gen5_2,HS_Gen4_1,BC_Gen5_2, ElasticPool, Basic,S0, P2 ,DW100c, DS100. | `string` | `"S0"` | no |
| <a name="input_storage_account_type"></a> [storage_account_type](#input_storage_account_type) | (Optional) Specifies the storage account type used to store backups for this database. Possible values are Geo, Local and Zone, and GeoZone. The default value is Local. | `string` | `"Local"` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_threat_detection_policy"></a> [threat_detection_policy](#input_threat_detection_policy) | (Optional) Threat detection policy configuration. | <pre>object({<br/>    state                      = string    #(Optional) The State of the Policy. Possible values are Enabled, Disabled or New.<br/>    disabled_alerts            = list(any) #(Optional) Specifies a list of alerts which should be disabled. Possible values include Access_Anomaly, Sql_Injection and Sql_Injection_Vulnerability.<br/>    email_account_admins       = string    #(Optional) Should the account administrators be emailed when this alert is triggered? Possible values are Disabled and Enabled.<br/>    email_addresses            = list(any) #(Optional) A list of email addresses which alerts should be sent to.<br/>    retention_days             = string    #(Optional) Specifies the number of days to keep in the Threat Detection audit logs.<br/>    storage_account_access_key = string    #(Optional) Specifies the identifier key of the Threat Detection audit storage account. Required if state is Enabled.<br/>    storage_endpoint           = string    #(Optional) Specifies the blob storage endpoint (e.g. https://example.blob.core.windows.net). This blob storage will hold all Threat Detection audit logs. Required if state is Enabled.<br/>  })</pre> | <pre>{<br/>  "disabled_alerts": null,<br/>  "email_account_admins": null,<br/>  "email_addresses": null,<br/>  "retention_days": null,<br/>  "state": null,<br/>  "storage_account_access_key": null,<br/>  "storage_endpoint": null<br/>}</pre> | no |
| <a name="input_transparent_data_encryption_key_automatic_rotation_enabled"></a> [transparent_data_encryption_key_automatic_rotation_enabled](#input_transparent_data_encryption_key_automatic_rotation_enabled) | (Optional) Specify whether TDE automatically rotates the encryption Key to latest version or not. Defaults to true. | `any` | `true` | no |
| <a name="input_zone_redundant"></a> [zone_redundant](#input_zone_redundant) | (Optional) Whether or not this database is zone redundant, which means the replicas of this database will be spread across multiple availability zones. This property is only settable for Premium, Business Critical, General Purpose and Hyperscale service tiers. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The ID of the MS SQL Database. |
| <a name="output_name"></a> [name](#output_name) | The name of the MS SQL Database. |
| <a name="output_resource"></a> [resource](#output_resource) | The Azure SQL Database Resource. |
| <a name="output_tde_key_vault_key_id"></a> [tde_key_vault_key_id](#output_tde_key_vault_key_id) | The ID of the Key Vault key used for Transparent Data Encryption. Use this when configuring geo-replicas with customer-managed TDE. |
<!-- END_TF_DOCS -->
