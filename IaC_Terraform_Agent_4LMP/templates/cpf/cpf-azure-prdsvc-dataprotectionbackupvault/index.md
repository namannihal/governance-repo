---
version: 3.0.2
available_versions:
  - 3.0.2
  - 3.0.1
  - 3.0.0
  - 2.2.2
  - 2.2.1
---

<!-- BEGIN_TF_DOCS -->
# Azure Backup Vault Module


## Overview

This terraform module creates a Azure Backup Vault and data protection backup policy for Disk.

## Prerequisites
- `Resource Group` is required.
- A `key vault` to store the Customer Managed Key and other required secrets.
- A `managed identity` is required for CMK.
- One `Network security Group`, `Subnet`, `Route table`.
- Private endpoint for `keyVault`.
- `Time sleep` function to propagate DNS entries in the private DNS zone.

## Guidance

#### Usage
- This module supports the creation of Backup Vault using `azapi_resource` and backup policy for disk using its respective azurerm resource block. The creation of both resources is optional.
- By default both Backup Vault and Backup Policy for Disk will be created, as per the configuration provided by user.
- To create only Backup Vault set `create_disk_backup_policy = false`
- To create a policy in an existing backup vault set `create_backup_vault = false` and pass existing backup vault resource id in variable `existing_backup_vault_id.
- Users who currently have a disk backup vault referencing an older tag and are upgrading to the latest tag (2.0.0), should set `soft_delete_state` as `AlwaysOn`, `immutability_state` as `Locked`, `encryption_state` as `Disabled` and `cross_subscription_restore_state` as `Disabled`.

#### Security Considerations

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-ABV-IA_010 | Use a Managed Identity for accessing Azure Resources | Backup Vault must enforce the use of a Managed Identity to authenticate to Azure resources where this is supported (What) within target services access control settings (How) in order to remove the need to store credentials (Why) | True | True | Implemented using `identity_type`. |
| 2. | AZU-ABV-AC_010 | Ensure the Security admin does not have Contributor permissions on the Backup Vault | Ensure the Security admin does not have Contributor permissions on the Backup Vault (What) via Access control (IAM) settings (How) to provide additional layers of protection against critical operations and protect from accidental or malicious deletions or modifications (Why) | False | False | Control implemented by technical configuration setting: False. Will be implemented by LSEG standard.|
| 3. | AZU-ABV-AU_010 | Send all security and audit diagnostic log categories to a central SOC Log Analytics workspace | Backup Vault must send all security and audit diagnostic logs to a central SOC Log Analytics workspace (What) within Diagnostic setting (How) in order to support a security investigation after a security incident (Why) | False | False | This control will be implemented via policy.|
| 4. | AZU-ABV-AU_030 | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval (What) within Diagnostic settings (How) in order to prevent sensitive data leakage to third parties outside of LSEG control (Why) | False  | False | This control will be implemented via policy.|
| 5. | AZU-ABV-SC_020  | Azure Disk Backups must be segregated per distinct business purpose | Azure Disk Backups must be segregated per distinct business purpose, sufficient to allow granular access control and security (What) via deployment settings (How) to reduce the blast radius should any authentication credentials become compromised (Why) | False  | False | Control implemented by technical configuration setting: False. Will be implemented by LSEG standard.|
| 6. | AZU-ABV-SC_030  | Must use a dedicated CMK for Backup Vault encryption key management that is persisted in a Key Vault premium SKU | Use a dedicated Backup Vault LSEG managed encryption at rest key persisted in a Key Vault premium SKU (What) within Encryption Settings (How) in order should Microsoft's key management platform become compromised LSEG can revoke access to exfiltrated encrypted data (Why) | True | False | Implemented using `encryptionSettings`.|
| 7. | AZU-ABV-SC_040  | Backup Vaults must only connect to target resources that belong to the same environment | Backup Vaults must only connect to target resources that belong to the same environment (e.g. prod <-> prod, dev <-> dev) (What) within code deployment parameters (How) to reduce the risk of data exfiltration and unauthorised system access (Why) | False  | False | Control implemented by technical configuration setting: False. Will be implemented by LSEG standard.|
| 8. | AZU-ABV-SI_010  | Enable immutability vault  | Backup Vault must enforce the restriction of immutable vault (What) via Properties, immutable vault settings (How) to ensure backup data is protected from malicious actors that could lead to loss of recovery points or deleted backups (Why) | True  | False | Implemented using `immutabilitySettings`.|
| 9. | AZU-ABV-SI_020  | Enable lock immutability for the vault  | Backup Vault must enforce the lock immutability for the vault (What) via Properties, immutable vault settings (How) to ensure backup data is protected from malicious actors that could lead to loss of recovery points or deleted backups (Why) | True  | False | Implemented using `immutabilitySettings`.|
| 10. | AZU-ABV-SI_030  | Enable Soft Delete for Cloud Workloads with setting a minimum of 30 days retention period  |  Backup Vaults must enforce the use of Soft Delete for backups with a retention period of 30 days (What) within Properties, soft delete settings (How) in order to recover data after an accidental or malicious deletion (Why)| True  | False | Implemented using `retentionDurationInDays`.|
| 11. | AZU-ABV-SI_040 | Enable Always-on Soft Delete | Backup Vaults must enforce the use of Always-On Soft Delete for backups (What) within Properties, soft delete (How) in order to recover data after an accidental or malicious deletion and ensure data cant be deleted permanently (Why) | True  | False | Implemented using `SoftDeleteSettings State`. |
| 12. | AZU-ABV-SI_050 | Disable Cross Subscription Restore | Backup Vault must enforce the restriction of cross subscription restore (What) via Properties, cross subscription restore settings (How) in order to reduce the risk of data exfiltration (Why) | True  | True | Implemented using `CrossSubscriptionRestoreSettings State`.|

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Monitoring and reporting solutions for Azure Backup](https://learn.microsoft.com/en-us/azure/backup/monitoring-and-alerts-overview)<br><br>[Cloud monitoring service level objectives ](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives)<br><br>[Supported Metrics for Backup Vault](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-dataprotection-backupvaults-metrics) |
| 5.| [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | True | Azure backup Data will be available even in the zone outage and this feature is enabled by `redundancy` argument.<br><br>[Reliability in Azure Backup](https://learn.microsoft.com/en-us/azure/reliability/reliability-backup?toc=%2Fazure%2Fbackup%2Ftoc.json&bc=%2Fazure%2Fbackup%2Fbreadcrumb%2Ftoc.json) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place.<br><br>[About Multi-user authorization using Resource Guard](https://learn.microsoft.com/en-us/azure/backup/multi-user-authorization-concept?tabs=recovery-services-vault) |

## Changelog

[azure-prdsvc-terraform-dataprotectionbackupvault](CHANGELOG.md)

## References

### Microsoft Docs

[Official Documentation](https://learn.microsoft.com/en-us/azure/backup/create-manage-backup-vault)

### Terraform Docs

[azurerm_data_protection_backup_policy_disk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_protection_backup_policy_disk)
`

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

## Resources

| Name | Type |
|------|------|
| [azapi_resource.this](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_update_resource.backup_vault_encryption](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/update_resource) | resource |
| [azurerm_data_protection_backup_policy_blob_storage.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_protection_backup_policy_blob_storage) | resource |
| [azurerm_data_protection_backup_policy_disk.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_protection_backup_policy_disk) | resource |
| [azurerm_data_protection_backup_policy_postgresql_flexible_server.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_protection_backup_policy_postgresql_flexible_server) | resource |
| [azurerm_key_vault_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_key_vault_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_key) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_blob_backup_policy"></a> [blob_backup_policy](#input_blob_backup_policy) | (Optional) Properties configuration for the Blob Storage backup policy.<br/>object({<br/>  backup_repeating_time_intervals        = "(Optional) List of repeating time intervals in ISO 8601 interval format."<br/>  operational_default_retention_duration = "(Optional) Operational (short-term) default retention duration in ISO 8601 format (e.g. P7D)."<br/>  vault_default_retention_duration       = "(Optional) Vault (long-term) default retention duration in ISO 8601 format (e.g. P30D)."<br/>  time_zone                              = "(Optional) Time zone used by the backup schedule."<br/>  retention_rules = (Optional)list(object({<br/>    name     = "(Required) Name of the retention rule."<br/>    priority = "(Required) Numeric priority; lower number = higher priority."<br/>    duration = "(Required) Default duration applied when life_cycle list not supplied (ISO 8601)."<br/>      criteria = (Optional)list(object({<br/>        absolute_criteria      = "(Optional) Possible values include FirstOfDay, FirstOfWeek, FirstOfMonth, etc."<br/>        days_of_month          = "(Optional) List of days of month (1-31)."<br/>        days_of_week           = "(Optional) List of days e.g. Monday, Tuesday, ..."<br/>        weeks_of_month         = "(Optional) List of week indicators e.g. First, Second, Third, Fourth, Last."<br/>        months_of_year         = "(Optional) List of months e.g. January, February, ..."<br/>        scheduled_backup_times = "(Optional) List of RFC3339 timestamps for scheduled backups."<br/>      })<br/>      life_cycle = list(object({<br/>        data_store_type = "(Required) The type of data store. The only possible value is VaultStore."<br/>        duration        = "(Required) The retention duration in ISO 8601 format (e.g., P30D, P6M, P1Y)."<br/>      }))<br/>  }))<br/>}) | <pre>object({<br/>    backup_repeating_time_intervals        = optional(list(string), [])<br/>    operational_default_retention_duration = optional(string, )<br/>    vault_default_retention_duration       = optional(string, )<br/>    time_zone                              = optional(string, "UTC")<br/>    retention_rules = optional(list(object({<br/>      name     = string<br/>      priority = number<br/>      duration = optional(string)<br/>      criteria = list(object({<br/>        absolute_criteria      = optional(string)<br/>        days_of_month          = optional(list(number))<br/>        days_of_week           = optional(list(string))<br/>        weeks_of_month         = optional(list(string))<br/>        months_of_year         = optional(list(string))<br/>        scheduled_backup_times = optional(list(string))<br/>      }))<br/>      life_cycle = optional(list(object({<br/>        data_store_type = string<br/>        duration        = string<br/>      })), [])<br/>    })), [])<br/>  })</pre> | <pre>{<br/>  "backup_repeating_time_intervals": [<br/>    "R/2023-11-22T11:40:16+00:00/PT4H"<br/>  ],<br/>  "operational_default_retention_duration": "P7D",<br/>  "retention_rules": [],<br/>  "time_zone": "UTC",<br/>  "vault_default_retention_duration": "P30D"<br/>}</pre> | no |
| <a name="input_cmk_name"></a> [cmk_name](#input_cmk_name) | (optional) Customer managed key name to be used (max 127 chars) | `string` | `null` | no |
| <a name="input_cmk_rotation_policy"></a> [cmk_rotation_policy](#input_cmk_rotation_policy) | (Optional) A rotation policy block as defined below<br/>object({<br/>  notify_before_expiry = "(Optional) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>  time_before_expiry   = "(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br/>  time_after_creation  = "(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br/>  expire_after         = "(Optional) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>}) | <pre>object({<br/>    notify_before_expiry = string<br/>    time_before_expiry   = string<br/>    time_after_creation  = optional(string, null)<br/>    expire_after         = string<br/>  })</pre> | <pre>{<br/>  "expire_after": "P365D",<br/>  "notify_before_expiry": "P358D",<br/>  "time_after_creation": null,<br/>  "time_before_expiry": "P7D"<br/>}</pre> | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_create_backup_vault"></a> [create_backup_vault](#input_create_backup_vault) | (Optional) Whethere to Create Backup Vaule When Backup Vault is already exists. | `bool` | `true` | no |
| <a name="input_create_blob_backup_policy"></a> [create_blob_backup_policy](#input_create_blob_backup_policy) | Set to true to enable blob storage backup policy, false otherwise. | `bool` | `false` | no |
| <a name="input_create_disk_backup_policy"></a> [create_disk_backup_policy](#input_create_disk_backup_policy) | Set to true to enable VM backup policy, false otherwise. | `bool` | `true` | no |
| <a name="input_create_postgresqlserver_backup_policy"></a> [create_postgresqlserver_backup_policy](#input_create_postgresqlserver_backup_policy) | Set to true to enable postgre sqlserver backup policy, false otherwise. | `bool` | `true` | no |
| <a name="input_cross_subscription_restore_state"></a> [cross_subscription_restore_state](#input_cross_subscription_restore_state) | (Optional) The state for cross subscription restore settings. Possible value is Disabled. | `string` | `"Disabled"` | no |
| <a name="input_customer_managed_key"></a> [customer_managed_key](#input_customer_managed_key) | (Optional) An customer_managed_key block as defined below<br/>object({<br/>  key_vault_id                      = "(Required) The resource ID of the Key Vault where the Key Vault Key resides."<br/>  cmk_expiration_date               = "(Required) Expiration UTC datetime (Y-m-d'T'H:M:S'Z')."<br/>}) | <pre>object({<br/>    key_vault_id    = string<br/>    expiration_date = string<br/>  })</pre> | `null` | no |
| <a name="input_datastore_type"></a> [datastore_type](#input_datastore_type) | (Optional) Specifies the type of the data store.Possible values are ArchiveStore, SnapshotStore and VaultStore. | `string` | `"VaultStore"` | no |
| <a name="input_disk_backup_policy"></a> [disk_backup_policy](#input_disk_backup_policy) | (Optional) Properties configuration for the Disk Backup Policy.<br/>object({<br/>  backup_repeating_time_intervals = "(Optional) Specifies a list of repeating time interval. It should follow ISO 8601 repeating time interval."<br/>  default_retention_duration      = "(Optional) Default retention duration in ISO 8601 format."<br/>  time_zone                       = "(Optional) Specifies the Time Zone which should be used by the backup schedule."<br/>    retention_rule   = list(object({ <br/>      name     = "(Required) The name which should be used for this Backup Policy Disk. Changing this forces a new Backup Policy Disk to be created."<br/>      duration = "(Required) Duration of deletion after given timespan. It should follow ISO 8601 duration format. Changing this forces a new Backup Policy Disk to be created."<br/>      priority = "(Required) Retention Tag priority. Changing this forces a new Backup Policy Disk to be created."            <br/>        criteria = object({<br/>          absolute_criteria = "(Optional) Possible values are FirstOfDay and FirstOfWeek. Changing this forces a new Backup Policy Disk to be created."<br/>          })<br/>}) | <pre>object({<br/>    backup_repeating_time_intervals = list(string)<br/>    default_retention_duration      = string<br/>    time_zone                       = string<br/>    retention_rule = list(object({<br/>      name     = string<br/>      duration = string<br/>      priority = number<br/>      criteria = object({<br/>        absolute_criteria = string<br/>      })<br/>    }))<br/>  })</pre> | <pre>{<br/>  "backup_repeating_time_intervals": [<br/>    "R/2023-11-22T11:40:16+00:00/PT4H"<br/>  ],<br/>  "default_retention_duration": "P7D",<br/>  "retention_rule": [],<br/>  "time_zone": "UTC"<br/>}</pre> | no |
| <a name="input_encryption_state"></a> [encryption_state](#input_encryption_state) | (Optional) The state for encryption settings. Possible values are Disabled, Enabled. | `string` | `"Disabled"` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_existing_backup_vault_id"></a> [existing_backup_vault_id](#input_existing_backup_vault_id) | (Optional) The ID of the an existing Backup Vault. | `string` | `null` | no |
| <a name="input_identity"></a> [identity](#input_identity) | (Required) Specifies the type of Managed Service Identity that should be configured on this Data Protection Backup Vault. Only possible value is SystemAssigned. | `string` | `"SystemAssigned"` | no |
| <a name="input_immutability_state"></a> [immutability_state](#input_immutability_state) | (Optional) The state for immutability settings. Possible values are Disabled, Locked, Unlocked. | `string` | `"Locked"` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_key_vault_tags"></a> [key_vault_tags](#input_key_vault_tags) | (Optional) Key Vault related tags to be set on key vault child resources. | `map(any)` | `{}` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_postgresql_backup_policy"></a> [postgresql_backup_policy](#input_postgresql_backup_policy) | (Optional) Properties configuration for the PostgreSQL Flexible Server backup policy. <br/>object({<br/>  backup_repeating_time_intervals = "(Optional) Specifies a list of repeating time interval.It should follow ISO 8601 repeating time interval. Changing this forces a new resource to be created."<br/>  time_zone                       = "(Optional) Specifies the Time Zone which should be used by the backup schedule. Changing this forces a new resource to be created."<br/>  duration                        = "(Required) The retention duration up to which the backups are to be retained in the data stores. It should follow ISO 8601 duration format. Changing this forces a new resource to be created."<br/>  data_store_type                 = "(Required) The type of data store. The only possible value is `VaultStore`. Changing this forces a new resource to be created."<br/>    retention_rules = list(object({<br/>      name                   = "(Required) Specifies the name of the Backup Policy for the PostgreSQL Flexible Server. Changing this forces a new resource to be created."<br/>      priority               = "(Required) Specifies the priority of the rule. The priority number must be unique for each rule. The lower the priority number, the higher the priority of the rule. Changing this forces a new resource to be created."<br/>      duration               = "(Required) The retention duration up to which the backups are to be retained in the data stores. It should follow ISO 8601 duration format. Changing this forces a new resource to be created."<br/>      data_store_type        = "(Required) The type of data store for this rule. The only possible value is VaultStore. Changing this forces a new resource to be created."<br/>        criteria = object({<br/>          absolute_criteria      = "(Optional) Possible values are AllBackup, FirstOfDay, FirstOfWeek, FirstOfMonth and FirstOfYear. These values mean the first successful backup of the day/week/month/year. Changing this forces a new resource to be created."<br/>          days_of_week           = "(Optional) Possible values are Monday, Tuesday, Thursday, Friday, Saturday and Sunday. Changing this forces a new resource to be created."<br/>          weeks_of_month         = "(Optional) Possible values are First, Second, Third, Fourth and Last. Changing this forces a new resource to be created."<br/>          months_of_year         = "(Optional) Possible values are January, February, March, April, May, June, July, August, September, October, November and December. Changing this forces a new resource to be created."<br/>          scheduled_backup_times = "(Optional) Specify a list of backup times for backup in the RFC3339 format. Changing this forces a new resource to be created."<br/>    }) | <pre>object({<br/>    backup_repeating_time_intervals = list(string)<br/>    time_zone                       = string<br/>    duration                        = string<br/>    data_store_type                 = string<br/>    retention_rules = list(object({<br/>      name            = string<br/>      priority        = number<br/>      duration        = string<br/>      data_store_type = string<br/>      criteria = object({<br/>        absolute_criteria      = optional(string)<br/>        days_of_week           = optional(list(string))<br/>        weeks_of_month         = optional(list(string))<br/>        months_of_year         = optional(list(string))<br/>        scheduled_backup_times = optional(list(string))<br/>      })<br/>    }))<br/>  })</pre> | <pre>{<br/>  "backup_repeating_time_intervals": [<br/>    "R/2023-11-22T11:40:16+00:00/PT4H"<br/>  ],<br/>  "data_store_type": "VaultStore",<br/>  "duration": "P7D",<br/>  "retention_rules": [],<br/>  "time_zone": "UTC"<br/>}</pre> | no |
| <a name="input_redundancy"></a> [redundancy](#input_redundancy) | (Optional) Specifies the backup storage redundancy. Possible values are GeoRedundant and LocallyRedundant. | `string` | `"LocallyRedundant"` | no |
| <a name="input_resource_group_id"></a> [resource_group_id](#input_resource_group_id) | (Required) The resource ID of the Resource Group in which to create the resource. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_retentiondurationindays"></a> [retentiondurationindays](#input_retentiondurationindays) | (Optional) Soft Delete retention Duration in Days. | `number` | `30` | no |
| <a name="input_soft_delete_state"></a> [soft_delete_state](#input_soft_delete_state) | (Optional) The state for soft delete settings. Possible values are AlwaysOn, Off, On. | `string` | `"AlwaysOn"` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_blobstorage_policy_id"></a> [blobstorage_policy_id](#output_blobstorage_policy_id) | The Resource ID of the Blob Storage Backup Policy. |
| <a name="output_blobstorage_policy_name"></a> [blobstorage_policy_name](#output_blobstorage_policy_name) | The Name of the Blob Storage Backup Policy. |
| <a name="output_blobstorage_policy_resource"></a> [blobstorage_policy_resource](#output_blobstorage_policy_resource) | The Blob Storage Backup Policy resource. |
| <a name="output_disk_policy_id"></a> [disk_policy_id](#output_disk_policy_id) | The Resource ID of the Disk Backup Policy. |
| <a name="output_disk_policy_name"></a> [disk_policy_name](#output_disk_policy_name) | The Name of the Disk Backup Policy. |
| <a name="output_disk_policy_resource"></a> [disk_policy_resource](#output_disk_policy_resource) | The Disk Backup Policy resource. |
| <a name="output_id"></a> [id](#output_id) | The Resource ID of the Azure Backup Vault. |
| <a name="output_name"></a> [name](#output_name) | The Name of the Azure Backup Vault. |
| <a name="output_postgresql_policy_id"></a> [postgresql_policy_id](#output_postgresql_policy_id) | The Resource ID of the PostgreSQL Flexible Server Backup Policy. |
| <a name="output_postgresql_policy_name"></a> [postgresql_policy_name](#output_postgresql_policy_name) | The Name of the PostgreSQL Flexible Server Backup Policy. |
| <a name="output_postgresql_policy_resource"></a> [postgresql_policy_resource](#output_postgresql_policy_resource) | The PostgreSQL Flexible Server Backup Policy resource. |
| <a name="output_principal_id"></a> [principal_id](#output_principal_id) | The Principal ID of the Azure Backup Vault. |
| <a name="output_resource"></a> [resource](#output_resource) | The Azure Backup Vault Resource. |
<!-- END_TF_DOCS -->
