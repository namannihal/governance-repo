---
version: 1.0.0
available_versions:
  - 1.0.0
  - 0.12.1
  - 0.12.0
  - 0.11.0
  - 0.10.0
---

<!-- BEGIN_TF_DOCS -->
# azure-prdsvc-terraform-recoveryservicesvault

## Overview

This terraform module creates a Recovery_Services_Vault, which is a centralized and scalable solution for data backup and disaster recovery.

## Prerequisites

- A **Resource Group** must exist to deploy the Recovery Services Vault.

## Guidance

#### Usage

- This module creates a Recovery_Services_Vault and Backup Policy for VM and File Share.
- This module also allows users to pass an existing Recovery Vault and Resource Group for the Backup Policy.
- Users can manually create only the Recovery Service Vault and pass the Backup Policy as optional.
- **Important**: The Terraform azurerm provider has issues towards the deployment of the recovery services vault module. The terraform `apply` continues for a very long time and fails eventually, due to this the pipeline deploys the Recovery Services Vault, but never results in success. The same has been observed in terraform local deployment and azure pipeline even increasing the timeout to 120 minutes.
- `classic_vmware_replication_enabled` is set to `false` as the classic experience is scheduled to be [deprecated](https://learn.microsoft.com/en-us/azure/site-recovery/move-from-classic-to-modernized-vmware-disaster-recovery).
- Customer Managed Key and Continuous backup mode can only be enabled together with a valid `User Assigned`, `System Assigned Managed Identity` or `System Assigned, UserAssigned`.
- Use the `key_vault_tags` variable to define additional Key Vault Key/Secret related tags in your product. Note that azure policies are enforcing a number N of tags for all products by default. Also note that Key Vault child resources support only 15 tags as the maximum limit. Therefore, please ensure the total count of tags enforced by policy and tags applied via variable does not exceed the limit. For example, if 10 tags are enforced via Azure policy, a maximum of 5 tags can be set via the `key_vault_tags` variable. Reference link - [Key tags](https://learn.microsoft.com/en-us/azure/key-vault/keys/about-keys-details#key-tags).
- Use the `tags` variable to define additional tags related to the product (core). Note that azure policies are enforcing a number N of tags for all products by default and that additional 3 tags are set on the main product via the main terraform template. If you are assigning additional tags (key-value pairs) via the `tags` variable, please ensure the total count does not exceed the limit supported by Azure resources. Reference link - [Azure Resources Tag Limitation](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/tag-support).
- This module now supports enabling Disaster Recovery (DR) for VMs using Azure Site Recovery (ASR). To enable DR for your VMs, set the `create_site_recovery_replicated_vm` variable to `true`. The following resources are created and managed:
  - `azurerm_role_assignment.recovery_Contributor`
  - `azurerm_role_assignment.recovery_Data_Contributor`
  - `azurerm_site_recovery_fabric.primary`
  - `azurerm_site_recovery_fabric.secondary`
  - `azurerm_site_recovery_protection_container.primary`
  - `azurerm_site_recovery_protection_container.secondary`
  - `azurerm_site_recovery_replication_policy.policy`
  - `azurerm_site_recovery_protection_container_mapping.container-mapping`
  - `azurerm_site_recovery_network_mapping.network-mapping`
  - `azurerm_site_recovery_replicated_vm.vm-replication`
- **Note**: The ASR storage account should not have soft delete enabled. We used a feature branch to make it work, but consumers of this product need to get an exception from Airwalk.
- **Caution**: When using `azurerm_site_recovery_replicated_vm`, be aware that the arguments `target_resource_group_id` and `managed_disk` are set under `ignore_changes` in the resource's `lifecycle` block due to recurring issues with these arguments. Please review and use this resource with care.
- Raise SRE request if `target_resource_group_id` or `managed_disk` of secondary resource needs to be changed.

#### Security Considerations

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-ARSV-IA_010 | Use a Managed Identity for accessing Azure Resources | Recovery Services Vault must enforce the use of a Managed Identity to authenticate to Azure resources where this is supported (What) within target services access control settings (How) in order to remove the need to store credentials (Why) | True | True | Implemented using `identity_type`. |
| 2. | AZU-ARSV-AC_010 | Disable Public Network Access | Recovery Services Vault must enforce a network guardrail (What) within the Networking settings (How) in order to prevent unauthorized access and data exposure to the internet (Why) | True | True | Implemented using `public_network_access_enabled` as false. |
| 3. | AZU-ARSV-AU_010 | Send all diagnostic log categories to a central SOC Log Analytics workspace | Recovery Services Vault must send all diagnostic logs to a central SOC Log Analytics workspace (What) within Diagnostic setting (How) in order to support a security investigation after a security incident (Why) | False | False | This control will be implemented via policy. |
| 4. | AZU-ARSV-AU_020 | Send all diagnostic log categories to a central SOC Storage Account |  Recovery Services Vault must send all diagnostic logs to a central SOC Storage Account (What) within Diagnostic setting (How) In order to provide an immutable copy to adhere to compliance requirements (Why) | False | False | This control will be implemented via policy. |
| 5. | AZU-ARSV-AU_030 | Must send diagnostic log categories to approved partner solutions only | Recovery Services Vault must send diagnostic log categories to approved partner solutions only (What) within Diagnostic settings (How) in order to prevent sensitive data leakage to third parties outside of LSEG control (Why) | False | False | This control will be implemented via policy. |
| 6. | AZU-ARSV-SC_010 | Recovery Services Vault must have a data classification tag | Recovery Services Vault must have a data classification tag (What) within Tags setting (How) in order to differentiate assets technical control requirements and to assist Security Operations in prioritizing possible data breach mitigation responses (Why) | False | False | This control will be implemented via policy. |
| 7. | AZU-ARSV-SC_020 | Recovery Services Vault Deployment must not be able to corrupt the centrally managed private link private DNS zones when making a private endpoint for Recovery Services Vault | Recovery Services Vault must have an Azure DeployIfNotExists policy to update the centrally managed private link private DNS zones with its private A record (What) via policy to management group mapping (How) to ensure there is no ability for the Azure App Deployment team to have authorization over these zones that could allow them to corrupt this file and impact service availability (Why) | False | False | This control will be implemented via policy. |
| 8. | AZU-ARSV-SC_030 | Must use a dedicated CMK for Recovery Services Vault that is persisted in an HSM backed Key Vault | Use a dedicated Recovery Services Vault LSEG managed encryption at rest key persisted in an HSM backed Key Vault (What) within Properties, encryption settings (How) in order should Microsoft's key management platform become compromised LSEG can revoke access to exfiltrated encrypted data (Why) | True | True | Implemented using `encryption` block. |
| 9. | AZU-ARSV-SC_050 | Azure File Shares Backups must be segregated per distinct business purpose | Azure File Share Backups must be segregated per distinct business purpose (What) deployment settings (How) to reduce the blast radius should any authentication credentials become compromised (Why) | False | False | This control will be implemented via policy. |
| 10. | AZU-ARSV-SC_060 | Recovery Services Vaults must only connect to target resources that belong to the same environment |  Recovery Services Vaults must only connect to target resources that belong to the same environment (e.g. prod <-> prod, dev <-> dev) (What) within code deployment parameters (How) to reduce the risk of data exfiltration and unauthorized system access (Why) | False | False | This control will be implemented via policy. |
| 11. | AZU-ASRV-SI_010 | Enable immutability vault | Recovery Services Vault should enforce the restriction of immutable vault (What) via Properties, immutable vault settings (How) to ensure backup data is protected from malicious actors that could lead to loss of recovery points or deleted backups (Why) | True | True | Control Implemented by setting `immutability = "Locked"` during vault creation. |
| 12. | AZU-ASRV-SI_020 | Enable Soft Delete for Cloud Workloads and Hybrid workload with a 30 days retention period |  Recovery Services Vaults must enforce the use of Soft Delete for backups with a retention period of 30 days (What) within Properties, security settings (How) in order to recover data after an accidental or malicious deletion (Why) | True | True | Implemented using `soft_delete_enabled` as in True but by default its enabled using terraform is for 14 days. |
| 13. | AZU-ASRV-SI_030|  Enable Always-on Soft Delete | Recovery Services Vaults must enforce the use of Always-On Soft Delete for backups (What) within Properties, security settings (How) in order to recover data after an accidental or malicious deletion and ensure data can't be deleted permanently (Why) | True | True | Implemented using `soft_delete_enabled` as in True. |
| 14. | AZU-ASRV-SI_040 | Enable Lock immutability for the vault | Recovery Services Vault must enforce the lock immutability for the vault (What) via Properties, immutable vault settings (How) to ensure backup data is protected from malicious actors that could lead to loss of recovery points or deleted backups (Why) | True | True | This control is set using AzAPI update script after the resource is initially deployed. This script sets `immutability = "Locked"` |
| 15. | AZU-ASRV-SI_050 | Disable Cross Subscription Restore | Recovery Services Vault must enforce the restriction of cross subscription restore (What) via Properties, cross subscription restore settings (How) to prevent data exfiltration (Why) | False | False | This control will be implemented via policy. |

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Monitoring and reporting solutions for Azure Backup](https://learn.microsoft.com/en-us/azure/backup/monitoring-and-alerts-overview)<br><br>[Cloud monitoring service level objectives ](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives)<br><br>[Supported Metrics for Recovery Services Vault](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-recoveryservices-vaults-metrics) |
| 5.| [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | True | Azure offers Geo-redundant Storage for storing backups. When GRS is enabled, Azure automatically replicates your data to a secondary region, which ensures data durability and availability even in the event of a regional outage.<br><br>[Reliability in Azure Backup](https://learn.microsoft.com/en-us/azure/reliability/reliability-backup?toc=%2Fazure%2Fbackup%2Ftoc.json&bc=%2Fazure%2Fbackup%2Fbreadcrumb%2Ftoc.json) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place.<br><br>[About Multi-user authorization using Resource Guard](https://learn.microsoft.com/en-us/azure/backup/multi-user-authorization-concept?tabs=recovery-services-vault) |

## Changelog

- [azure-prdsvc-terraform-recoveryservicesvault](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/backup/backup-azure-recovery-services-vault-overview)

### Terraform Docs

- [azurerm_recovery_services_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/recovery_services_vault)

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
| [azapi_update_resource.disable_cross_subscription_restore](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/update_resource) | resource |
| [azurerm_backup_policy_file_share.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_policy_file_share) | resource |
| [azurerm_backup_policy_vm.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_policy_vm) | resource |
| [azurerm_key_vault_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_private_endpoint.rsv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_recovery_services_vault.recovery_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/recovery_services_vault) | resource |
| [azurerm_role_assignment.cmk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.recovery_Contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.recovery_Data_Contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_site_recovery_fabric.primary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/site_recovery_fabric) | resource |
| [azurerm_site_recovery_fabric.secondary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/site_recovery_fabric) | resource |
| [azurerm_site_recovery_network_mapping.network-mapping](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/site_recovery_network_mapping) | resource |
| [azurerm_site_recovery_protection_container.primary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/site_recovery_protection_container) | resource |
| [azurerm_site_recovery_protection_container.secondary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/site_recovery_protection_container) | resource |
| [azurerm_site_recovery_protection_container_mapping.container-mapping](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/site_recovery_protection_container_mapping) | resource |
| [azurerm_site_recovery_replicated_vm.vm-replication](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/site_recovery_replicated_vm) | resource |
| [azurerm_site_recovery_replication_policy.policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/site_recovery_replication_policy) | resource |
| [azurerm_key_vault_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_key) | data source |
| [azurerm_resource_group.secondary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_application_consistent_snapshot_frequency_in_minutes"></a> [application_consistent_snapshot_frequency_in_minutes](#input_application_consistent_snapshot_frequency_in_minutes) | (Optional) Frequency in minutes for application-consistent snapshots. | `number` | `240` | no |
| <a name="input_backup_frequency"></a> [backup_frequency](#input_backup_frequency) | (Required) Frequency of backups | `string` | n/a | yes |
| <a name="input_backup_time"></a> [backup_time](#input_backup_time) | (Required) Time of day for backups | `string` | n/a | yes |
| <a name="input_cmk_key_name"></a> [cmk_key_name](#input_cmk_key_name) | (optional) Key name to be used (max 127 chars) | `string` | `null` | no |
| <a name="input_cmk_rotation_policy"></a> [cmk_rotation_policy](#input_cmk_rotation_policy) | (Optional) A rotation policy block as defined below<br/>object({<br/>  notify_before_expiry = "(Optional) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>  time_before_expiry   = "(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br/>  time_after_creation  = "(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br/>  expire_after         = "(Optional) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>}) | <pre>object({<br/>    notify_before_expiry = string<br/>    time_before_expiry   = string<br/>    time_after_creation  = optional(string, null)<br/>    expire_after         = string<br/>  })</pre> | <pre>{<br/>  "expire_after": "P365D",<br/>  "notify_before_expiry": "P358D",<br/>  "time_after_creation": null,<br/>  "time_before_expiry": "P7D"<br/>}</pre> | no |
| <a name="input_container_mapping_name"></a> [container_mapping_name](#input_container_mapping_name) | (Optional) Name of the container mapping | `string` | `null` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_create_file_backup_policy"></a> [create_file_backup_policy](#input_create_file_backup_policy) | (Optional) Set to true to enable file backup policy, false otherwise. | `bool` | `true` | no |
| <a name="input_create_rsv"></a> [create_rsv](#input_create_rsv) | (Required) Whether to Create RSV When RSV is already exists | `bool` | n/a | yes |
| <a name="input_create_site_recovery_replicated_vm"></a> [create_site_recovery_replicated_vm](#input_create_site_recovery_replicated_vm) | (Optional) Flag to create the Azure Site Recovery replicated VM | `bool` | `false` | no |
| <a name="input_create_vm_backup_policy"></a> [create_vm_backup_policy](#input_create_vm_backup_policy) | (Optional) Set to true to enable VM backup policy, false otherwise. | `bool` | `true` | no |
| <a name="input_cross_region_restore_enabled"></a> [cross_region_restore_enabled](#input_cross_region_restore_enabled) | (Optional) Cross region restore is a feature that allows you to restore data from a Recovery Services Vault in one region to a Recovery Services Vault in another region. | `bool` | `true` | no |
| <a name="input_cross_subscription_restore_state"></a> [cross_subscription_restore_state](#input_cross_subscription_restore_state) | (Optional) State for cross subscription restore. Allowed values: Enabled, Disabled. Default is Disabled. | `string` | `"Disabled"` | no |
| <a name="input_customer_managed_key"></a> [customer_managed_key](#input_customer_managed_key) | (Required) An customer_managed_key block as defined below<br/>object({<br/>  key_vault_id                      = "(Required) The resource ID of the Key Vault where the Key Vault Key resides."<br/>  infrastructure_encryption_enabled = "(Required) Used to specify whether enable Infrastructure Encryption (Double Encryption). Changing this forces a new resource to be created."<br/>  expiration_date                   = "(Required) Expiration UTC datetime (Y-m-d'T'H:M:S'Z')."<br/>  identity_id                       = "(Optional) The resource ID of the User Assigned Identity that has access to the key. To be used if `use_system_assigned_identity` is set to `false`"<br/>  identity_principal_id             = "(Optional) The principal ID of the User Assigned Identity that has access to the key. To be used if `use_system_assigned_identity` is set to `false`"<br/>  use_system_assigned_identity      = "(Optional) Indicate that system assigned identity should be used for CMK or not. Defaults to `false`"<br/>}) | <pre>object({<br/>    key_vault_id                      = string<br/>    infrastructure_encryption_enabled = bool<br/>    expiration_date                   = string<br/>    identity_id                       = optional(string)<br/>    identity_principal_id             = optional(string)<br/>    use_system_assigned_identity      = optional(bool, false)<br/>  })</pre> | n/a | yes |
| <a name="input_data_disks"></a> [data_disks](#input_data_disks) | (Optional) List of data disk configurations for replication | <pre>list(object({<br/>    disk_id                       = string<br/>    staging_storage_account_id    = string<br/>    target_disk_type              = string<br/>    target_replica_disk_type      = string<br/>    target_disk_encryption_set_id = string<br/>  }))</pre> | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_existing_rsv"></a> [existing_rsv](#input_existing_rsv) | (Optional) An existing_Recovery Service Vaults block supports the following:<br/>existing_rsv_name = "(Optional) The name of the existing Recovery Service Vaults."<br/>existing_rsv_rg   = "(Optional) The name of the existing Resource Group in which the Recovery Service Vaults exists." | <pre>object({<br/>    existing_rsv_name = optional(string)<br/>    existing_rsv_rg   = optional(string)<br/>  })</pre> | `{}` | no |
| <a name="input_fabric_name"></a> [fabric_name](#input_fabric_name) | (Optional) Name of the recovery fabric | `string` | `null` | no |
| <a name="input_fabric_secondary_name"></a> [fabric_secondary_name](#input_fabric_secondary_name) | (Optional) Name of the secondary recovery fabric | `string` | `null` | no |
| <a name="input_filesharebackup_frequency"></a> [filesharebackup_frequency](#input_filesharebackup_frequency) | (Required) Frequency of backups | `string` | n/a | yes |
| <a name="input_filesharebackup_time"></a> [filesharebackup_time](#input_filesharebackup_time) | (Required) Time of day for backups | `string` | n/a | yes |
| <a name="input_fileshareretention_daily_count"></a> [fileshareretention_daily_count](#input_fileshareretention_daily_count) | (Optional) Number of daily backups to retain | `number` | `7` | no |
| <a name="input_fileshareretention_monthly_count"></a> [fileshareretention_monthly_count](#input_fileshareretention_monthly_count) | (Optional) Number of monthly backups to retain | `number` | `12` | no |
| <a name="input_fileshareretention_monthly_weekdays"></a> [fileshareretention_monthly_weekdays](#input_fileshareretention_monthly_weekdays) | (Optional) Weekdays for monthly backups retention | `list(string)` | <pre>[<br/>  "Monday"<br/>]</pre> | no |
| <a name="input_fileshareretention_monthly_weeks"></a> [fileshareretention_monthly_weeks](#input_fileshareretention_monthly_weeks) | (Optional) Weeks for monthly backups retention | `list(string)` | <pre>[<br/>  "First"<br/>]</pre> | no |
| <a name="input_fileshareretention_weekly_count"></a> [fileshareretention_weekly_count](#input_fileshareretention_weekly_count) | (Optional) Number of weekly backups to retain | `number` | `4` | no |
| <a name="input_fileshareretention_weekly_weekdays"></a> [fileshareretention_weekly_weekdays](#input_fileshareretention_weekly_weekdays) | (Optional) Weekdays for weekly backups retention | `list(string)` | <pre>[<br/>  "Monday",<br/>  "Friday"<br/>]</pre> | no |
| <a name="input_fileshareretention_yearly_count"></a> [fileshareretention_yearly_count](#input_fileshareretention_yearly_count) | (Optional) Number of yearly backups to retain | `number` | `5` | no |
| <a name="input_fileshareretention_yearly_months"></a> [fileshareretention_yearly_months](#input_fileshareretention_yearly_months) | (Optional) Months for yearly backups retention | `list(string)` | <pre>[<br/>  "January"<br/>]</pre> | no |
| <a name="input_fileshareretention_yearly_weekdays"></a> [fileshareretention_yearly_weekdays](#input_fileshareretention_yearly_weekdays) | (Optional) Weekdays for yearly backups retention | `list(string)` | <pre>[<br/>  "Monday"<br/>]</pre> | no |
| <a name="input_fileshareretention_yearly_weeks"></a> [fileshareretention_yearly_weeks](#input_fileshareretention_yearly_weeks) | (Optional) Weeks for yearly backups retention | `list(string)` | <pre>[<br/>  "First"<br/>]</pre> | no |
| <a name="input_identity"></a> [identity](#input_identity) | (Optional) An identity block as defined below<br/>object({<br/>  type         = "(Required) Specifies the type of Managed Service Identity that should be configured on this Recovery Services Vault. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned` (to enable both)."<br/>  identity_ids = "(Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this App Configuration. This is required when `type` is set to `UserAssigned` or `SystemAssigned, UserAssigned`."<br/>}) | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | <pre>{<br/>  "identity_ids": null,<br/>  "type": "SystemAssigned"<br/>}</pre> | no |
| <a name="input_immutability"></a> [immutability](#input_immutability) | (Optional) Immutability Settings of vault, possible values include: Locked, Unlocked and Disabled. | `string` | `"Locked"` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_instant_restore_resource_group_prefix"></a> [instant_restore_resource_group_prefix](#input_instant_restore_resource_group_prefix) | (Required) Prefix for instant restore resource group | `string` | n/a | yes |
| <a name="input_instant_restore_resource_group_suffix"></a> [instant_restore_resource_group_suffix](#input_instant_restore_resource_group_suffix) | (Optional) Suffix for instant restore resource group | `string` | `"restore"` | no |
| <a name="input_instant_restore_retention_days"></a> [instant_restore_retention_days](#input_instant_restore_retention_days) | (Optional) Specifies the instant restore retention range in days | `number` | `1` | no |
| <a name="input_key_vault_tags"></a> [key_vault_tags](#input_key_vault_tags) | (Optional) Key Vault related tags to be set on key vault child resources. | `map(any)` | `{}` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_monitoring"></a> [monitoring](#input_monitoring) | (Optional) A monitoring block as defined below.<br/>object({<br/>  alerts_for_all_job_failures_enabled            = "(Optional) Enabling/Disabling built-in Azure Monitor alerts for security scenarios and job failure scenarios. Defaults to `true`."<br/>  alerts_for_critical_operation_failures_enabled = "(Optional) Enabling/Disabling alerts from the older (classic alerts) solution. Defaults to `true`."<br/>}) | <pre>object({<br/>    alerts_for_all_job_failures_enabled            = optional(bool, true)<br/>    alerts_for_critical_operation_failures_enabled = optional(bool, true)<br/>  })</pre> | `null` | no |
| <a name="input_network_mapping_name"></a> [network_mapping_name](#input_network_mapping_name) | (Optional) The name of the network mapping for Azure Site Recovery. | `string` | `null` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_os_disk_id"></a> [os_disk_id](#input_os_disk_id) | (Optional) The ID of the OS disk. | `string` | `null` | no |
| <a name="input_policy_type"></a> [policy_type](#input_policy_type) | (Optional) Type of BackupPolicy | `string` | `"V2"` | no |
| <a name="input_primary_location"></a> [primary_location](#input_primary_location) | (Optional) The primary location for the Azure resources. | `string` | `null` | no |
| <a name="input_primary_network_id"></a> [primary_network_id](#input_primary_network_id) | (Optional) ID of the primary network | `string` | `null` | no |
| <a name="input_protection_container_name"></a> [protection_container_name](#input_protection_container_name) | (Optional) Name of the protection container | `string` | `null` | no |
| <a name="input_protection_container_secondary_name"></a> [protection_container_secondary_name](#input_protection_container_secondary_name) | (Optional) Name of the secondary protection container | `string` | `null` | no |
| <a name="input_recovery_point_retention_in_minutes"></a> [recovery_point_retention_in_minutes](#input_recovery_point_retention_in_minutes) | (Optional) The retention period for recovery points in minutes. | `number` | `1440` | no |
| <a name="input_replication_name"></a> [replication_name](#input_replication_name) | (Optional) Name of the replication | `string` | `null` | no |
| <a name="input_replication_policy_name"></a> [replication_policy_name](#input_replication_policy_name) | (Optional) Name of the replication policy | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_resource_group_name_secondary"></a> [resource_group_name_secondary](#input_resource_group_name_secondary) | (Optional) Name of the Resource Group in which to create the resource. | `string` | `null` | no |
| <a name="input_retention_daily_count"></a> [retention_daily_count](#input_retention_daily_count) | (Optional) Number of daily backups to retain | `number` | `7` | no |
| <a name="input_retention_monthly_count"></a> [retention_monthly_count](#input_retention_monthly_count) | (Optional) Number of monthly backups to retain | `number` | `12` | no |
| <a name="input_retention_monthly_weekdays"></a> [retention_monthly_weekdays](#input_retention_monthly_weekdays) | (Optional) Weekdays for monthly backups retention | `list(string)` | <pre>[<br/>  "Monday"<br/>]</pre> | no |
| <a name="input_retention_monthly_weeks"></a> [retention_monthly_weeks](#input_retention_monthly_weeks) | (Optional) Weeks for monthly backups retention | `list(string)` | <pre>[<br/>  "First"<br/>]</pre> | no |
| <a name="input_retention_weekly_count"></a> [retention_weekly_count](#input_retention_weekly_count) | (Optional) Number of weekly backups to retain | `number` | `4` | no |
| <a name="input_retention_weekly_weekdays"></a> [retention_weekly_weekdays](#input_retention_weekly_weekdays) | (Optional) Weekdays for weekly backups retention | `list(string)` | <pre>[<br/>  "Monday",<br/>  "Friday"<br/>]</pre> | no |
| <a name="input_retention_yearly_count"></a> [retention_yearly_count](#input_retention_yearly_count) | (Optional) Number of yearly backups to retain | `number` | `5` | no |
| <a name="input_retention_yearly_months"></a> [retention_yearly_months](#input_retention_yearly_months) | (Optional) Months for yearly backups retention | `list(string)` | <pre>[<br/>  "January"<br/>]</pre> | no |
| <a name="input_retention_yearly_weekdays"></a> [retention_yearly_weekdays](#input_retention_yearly_weekdays) | (Optional) Weekdays for yearly backups retention | `list(string)` | <pre>[<br/>  "Monday"<br/>]</pre> | no |
| <a name="input_retention_yearly_weeks"></a> [retention_yearly_weeks](#input_retention_yearly_weeks) | (Optional) Weeks for yearly backups retention | `list(string)` | <pre>[<br/>  "First"<br/>]</pre> | no |
| <a name="input_rsv_subnet_id"></a> [rsv_subnet_id](#input_rsv_subnet_id) | (Optional) The ID of the subnet for the Recovery Services Vault. | `string` | `null` | no |
| <a name="input_secondary_location"></a> [secondary_location](#input_secondary_location) | (Optional)The secondary location for the resources. | `string` | `null` | no |
| <a name="input_sku"></a> [sku](#input_sku) | (Required) The SKU for the Recovery Services Vault. | `string` | n/a | yes |
| <a name="input_source_vm_id"></a> [source_vm_id](#input_source_vm_id) | (Optional) ID of the source VM | `string` | `null` | no |
| <a name="input_staging_storage_account_id"></a> [staging_storage_account_id](#input_staging_storage_account_id) | (Optional) ID of the staging storage account | `string` | `null` | no |
| <a name="input_storage_account_id"></a> [storage_account_id](#input_storage_account_id) | (Optional) The ID of the storage account. | `string` | `null` | no |
| <a name="input_storage_mode_type"></a> [storage_mode_type](#input_storage_mode_type) | (Optional) The storage type of the Recovery Services Vault. | `string` | `"GeoRedundant"` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_target_disk_type"></a> [target_disk_type](#input_target_disk_type) | (Optional) The type of the target disk. | `string` | `null` | no |
| <a name="input_target_encryption_set_id"></a> [target_encryption_set_id](#input_target_encryption_set_id) | (Optional) The ID of the target disk encryption set. | `string` | `null` | no |
| <a name="input_target_network_id"></a> [target_network_id](#input_target_network_id) | (Optional) ID of the target network | `string` | `null` | no |
| <a name="input_target_replica_disk_type"></a> [target_replica_disk_type](#input_target_replica_disk_type) | (Optional) The type of the target replica disk. | `string` | `null` | no |
| <a name="input_timezone"></a> [timezone](#input_timezone) | (Optional) Specifies the Timezone | `string` | `"UTC"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_fileshare_policy_id"></a> [fileshare_policy_id](#output_fileshare_policy_id) | The ID of the FileShare Backup Policy |
| <a name="output_fileshare_policy_name"></a> [fileshare_policy_name](#output_fileshare_policy_name) | The ID of the FileShare Backup Policy |
| <a name="output_id"></a> [id](#output_id) | The ID of the Recovery Service vault. |
| <a name="output_name"></a> [name](#output_name) | The Name of the Recovery Service Vault. |
| <a name="output_resource"></a> [resource](#output_resource) | The Recovery Service vault Resource |
| <a name="output_vm_policy_id"></a> [vm_policy_id](#output_vm_policy_id) | The ID of the VM Backup Policy |
| <a name="output_vm_policy_name"></a> [vm_policy_name](#output_vm_policy_name) | The ID of the VM Backup Policy |
<!-- END_TF_DOCS -->
