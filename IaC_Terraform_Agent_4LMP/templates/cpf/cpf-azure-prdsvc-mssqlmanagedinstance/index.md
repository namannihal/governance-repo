---
version: 1.5.0
available_versions:
  - 1.5.0
  - 1.4.0
  - 1.3.0
  - 1.2.3
  - 1.2.2
---

<!-- BEGIN_TF_DOCS -->
# Azure SQL Managed Instance module


## Overview

This terraform module creates a MS SQL Managed Instance module and associated resources.

## Prerequisites

- A `key vault` needs to be created first, if not exists, to store sensitive information. A delegated `Subnet` is  required in already existing `virtual network` for SQL Managed Instance creation.
- Set `storage_endpoint` and `storage_account_access_key` attribute values to `null` in `azurerm_mssql_managed_instance_security_alert_policy` resource block because a storage account is no longer needed.
- Do NOT set `storageAccountAccessKey` or `storageContainerSasKey` when the storage account is behind a firewall/VNet in`azurerm_mssql_managed_instance_vulnerability_assessment` resource block.Refer the link for further details(<https://learn.microsoft.com/en-us/azure/azure-sql/database/sql-database-vulnerability-assessment-storage?view=azuresql>)
- User-assigned identity is not supported for Vulnerability Assessment; use system-assigned identity instead.

## Guidance

#### Usage

- For enabling Transparent Data Encryption, SQL Managed instance requires one Managed Identity to be created where Key Vault RBAC access need to be assigned
- For enabling Vulnerability Assessment, Advanced Data Security needs to be enabled which is enabled once Security Alert Policy is configured.
- `storage_account_type = "GZRS"` is natively supported from `azurerm` v4.x onwards. Set `storage_account_type = "GZRS"` (primary) or `failover_storage_account_type = "GZRS"` (secondary) directly in the module call.
- [Zone redundancy for General Purpose](https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/doc-changes-updates-release-notes-whats-new?view=azuresql#general-availability-ga) - Deployment of `General Purpose` SKU in SQL Managed Instance to multiple availability zones to improve the availability of your instance in the event of a disaster is Generally Available (GA since June 2025) for both `General Purpose` and `Business Critical` SKUs.
- When auto-rotation is enabled (`auto_rotation_enabled = true`), the managed instance continuously checks the key vault for any new versions of the customer-managed key being used as the TDE protector. If a new version of the key is detected, the TDE protector on the managed instance is automatically rotated to the latest key version within 24 hours.
- Use `key_vault_tags` variable to define additional Key Vault Key/Secret related tags in your product. Note that azure policies are enforcing a number N of tags for all products by default. Also note that Key Vault child resources support only 15 tags as the maximum limit. Therefore, please ensure the total count of tags enforced by policy and tags applied via variable does not exceed the limit. For example, if 10 tags are enforced via Azure policy, a maximum of 5 tags can be set via the `key_vault_tags` variable. Reference link - [Key tags](https://learn.microsoft.com/en-us/azure/key-vault/keys/about-keys-details#key-tags).
- Use the `tags` variable to define additional tags related to the product (core). Note that azure policies are enforcing a number N of tags for all products by default and that additional 3 tags are set on the main product via main terraform template.
If you are assigning additional tags (key-value pairs) via the `tags` variable, please ensure the total count does not exceed the limit supported by Azure resources. Reference link - [Azure Resources Tag Limitation](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/tag-support)
- `general_purpose_v2_enabled` can only be set to `true` when using a General Purpose (`GP_*`) SKU.

#### Start/Stop Schedule Limitations

The stop and start feature has the following limitations :

- Stop and start is currently only available for instances in the **General Purpose** service tier.
- Instances **cannot** be stopped that:
  - Have an ongoing management operation (such as restore, vCore scaling, etc.)
  - Are part of a failover group
  - Use the Managed Instance link
  - Have zone redundancy enabled
  - Are part of an Instance pool
- While a SQL managed instance is in a stopped state, it is not possible to change its configuration properties. The instance must be started first.
- While the instance is stopped, backups cannot be taken. If long-term backups are configured, ensure the instance is running during the backup period.
- It is not possible to cancel a stop or start operation once initiated.
- If a vulnerability assessment scan is scheduled while the instance is stopped, the scan execution fails.
- Maintenance notifications are not sent for instances in a stopped state, which may result in incomplete notification sequences.
- Error logs are not persisted and are automatically erased when the instance is stopped.
- Each scheduled item is defined as a stop-and-start pair; both stop and start values must be populated.
- Scheduled pairs cannot overlap; the API returns an error if they do.
- The time span between any two successive actions (start after stop, or stop after start) must be at least **one hour**.
- If a conflicting operation is in progress when a stop is triggered, the mechanism retries after 10 minutes. If the conflict persists, the stop operation is skipped.

#### Security Considerations

- The following API permissions are required for different principal_type:
- When authenticated with a service principal, this Data Source: azuread_service_principal requires one of the following application roles: Application.Read.All or Directory.Read.All
- When authenticated with a service principal, this Data Source: azuread_group requires one of the following application roles: Group.Read.All or Directory.Read.All
- When authenticated with a service principal, this Data Source: azuread_user requires one of the following application roles: User.Read.All or Directory.Read.All
- When authenticated with a user principal, none of the data sources requires any additional roles.
- Configuring Entra ID Administrator for SQL Managed Instance:
- SQL MI Entra ID administrator creation requires Directory Reader privilege for SQL MI Managed IDENTITY (System/User Assigned)
- This is required because SQL Managed Instance needs permission to read Microsoft Entra ID to accomplish tasks such as authentication of users/admins
- Assigning `Directory reader` role on a User/Group/SPN/Managed Identity, requires current user to have Global Administrator or Privileged Role Administrator permissions
- Assigning permission to a Group allows the Group Owners can add required SQL MI identities in future if required.
- Different groups with `Directory Reader` permissions are mentioned below. Only `User Assigned Identity` should be created and same needs to be attached to `SQL Managed Instance Managed Identity` and to the below mentioned groups:
  - LMSP0 -> SecGrp/Azure/EntraID/51274/SQLMIDirectoryReader
  - LMSP1 -> SecGrp/Azure/EntraID/51274/SQLMIDirectoryReader
  - LSEG  -> LSEG\SecGrp/Azure/Entra/51310/SQLMIDirectoryReader

#### Additional Information

- Customer Managed key is passed from the same keyvault when managing transparent data encryption configuration for a MSSQL Managed Instance primary and failover. To allow greater flexibility in configuring customer-managed TDE, Azure SQL Managed Instance in one region can now be linked to key vault in any other region.
- For configuring failover, following prerequisites need to be configured:
  - The secondary managed instance must be empty that is, contain no user databases.
  - The two instances of SQL Managed Instance need to be the same service tier, and have the same storage size. While not required, it's strongly recommended that two instances have equal compute size, to make sure that secondary instance can sustainably process the changes being replicated from the primary instance, including the periods of peak activity.
  - The IP address range(s) of the virtual network hosting the primary instance must not overlap with IP address range(s) of the virtual network hosting the secondary instance.
  - Network Security Groups (NSG) rules on subnet hosting instance must have port 5022 (TCP) and the port range 11000-11999 (TCP) open inbound and outbound for connections from and to the subnet hosting the other managed instance. This applies to both subnets, hosting primary and secondary instance.
  - The secondary SQL Managed Instance is configured during its creation with the correct DNS zone ID. It's accomplished by passing the primary instance's zone ID as the value of DnsZonePartner parameter when creating the secondary instance. If not passed as a parameter, the zone ID is generated as a random string when the first instance is created in each VNet and the same ID is assigned to all other instances in the same subnet. Once assigned, the DNS zone can't be modified.
  - The collation and time zone of the secondary managed instance must match that of the primary managed instance.
  - Managed instances should be deployed in paired regions for performance reasons. Managed instances residing in geo-paired regions benefit from significantly higher geo-replication speed compared to unpaired regions.
  - To configure zone redundancy in the failover region, set mandatory variable `failover_zone_redundant_enabled` to true.
  - Connectivity needs to enabled between primary VNet and secondary VNet via Global Virtual Network Peering as recommended approach
- Storage is no longer required to hold Advanced Threat Protection Alerts. Use the `storage picker` to remove the storage configuration. Alerts can be viewed in `Azure Security Center`. Hence, Security Alert Policy is enabled without Storage Account.
- Vulnerability Assessment is enabled with Storage Account without having SAS or Access Key authorization.
- Security Alert Policy Configuration along with Storage account with private endpoint enabled, is not working, one of possible causes can be because of routes required by storage account to hop over internet.

```
Microsoft-Sql-managedInstances_UseOnly_mi-Storage = {
      name                   = "Microsoft.Sql-managedInstances_UseOnly_mi-Storage.${var.location}"
      address_prefix         = "Storage.${var.location}"
      next_hop_type          = "Internet"
      next_hop_in_ip_address = ""
    }
Microsoft-Sql-managedInstances_UseOnly_mi-Storage = {
      name                   = "Microsoft.Sql-managedInstances_UseOnly_mi-Storage.${var.secondary_region}"
      address_prefix         = "Storage.${var.secondary_region}"
      next_hop_type          = "Internet"
      next_hop_in_ip_address = ""
    }
```

- SQL Managed Instance deployment often takes around 3-5 hours for deployment, especially in cases where Zone Redundancy is enabled. So, please make sure to get `Project Timeout` and `Vault secrets expiration` timeout extended in pipeline to accommodate requirement of SQL Managed Instance product deployment.

#### Well-Architected Framework (WAF) for MSSQL Managed Instance

- Refer to the Wiki for MSSQL Managed Instance WAF [documentation](https://gitlab.dx1.lseg.com/groups/app/app-51310/azure/prdsvc/terraform/-/wikis/Cloud-Products-Well-Architecture-Framework-Principles---WAF/mssqlmanagedinstance) covering core principles: Reliability, Disaster Recovery (DR), Security, Cost Optimization, and Operational Excellence.

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-ASQLMI-IA_010 | Use a Managed Identity for accessing Azure Resources | SQL Managed Instance must enforce the use of a Managed Identity to authenticate to Azure resources where this is supported (What) within target services access control settings (How) in order to remove the need to store credentials (Why) | True | True | Implemented using `identity` block |
| 2. | AZU-ASQLMI-IA_020 | Entra ID authentication only / password authentication can be used, though Entra ID authentication only is recommended | Entra ID authentication only must be used (What) within Microsoft Entra ID (How) in order to use modern robust and less prone to compromise authentication methods embedded within Entra ID (Why) | False | False | Both Entra ID and Password Authentication exists as per product design. Though  Entra ID authentication only is highly recommended for SQL MI, password authentication is also supported. Also, SQLMI identity (User/System Assigned) need `Directory Reader` permission for Entra ID authentication and Active Directory Administrator assignment and hence assignment is set to `optional` for now. |
| 3. | AZU-ASQLMI-AC_010 | Disable Public Network Access | SQL Managed Instance must enforce a network guardrail (What) within its Network settings (How) in order to prevent unauthorised access and data exposure to the internet (Why) | True | True | Implemented by setting `public_data_endpoint_enabled = false` as default. |
| 4. | AZU-ASQLMI-AU_010 | Send all diagnostic log categories to a central SOC Log Analytics workspace | SQL Managed Instance must send all diagnostic logs to a central SOC Log Analytics workspace (What) within Diagnostic setting (How) in order to support a security investigation after a security incident (Why) | False | False | This Security Control will be implemented using Azure Policy. |
| 5. | AZU-ASQLMI-AU_020 | Send all diagnostic log categories to a central SOC Storage Account | SQL Managed Instance must send all diagnostic logs to a central SOC Storage Account (What) within Diagnostic setting (How) In order to provide an immutable copy to adhere to compliance requirements (Why) | False | False | This Security Control will be implemented using Azure Policy. |
| 6. | AZU-ASQLMI-AU_030 | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval (What) within Diagnostic settings (How) in order to prevent sensitive data leakage to third parties outside of LSEG control (Why) | False | False | This Security Control will be implemented using Azure Policy. |
| 7. | AZU-ASQLMI-CP_010 | Backup retention policy must be reviewed against requirements and set accordingly | The default backup retention policy must be reviewed against requirements and set accordingly (What) in Retention policies (How) to ensure retention meets the application, regulatory and disaster recovery requirements (Why) | False | False | This control will be implemented via policy. |
| 8. | AZU-ASQLMI-SC_010 | Use a minimum of TLS version 1.2 for network connections to the service control and data planes | SQL Managed Instance must enforce a minimum TLS version of 1.2 (What) within Networking (How) in order to use modern techniques to establish robust encrypted data channels over untrusted networks (Why) | True | True | This control is implemented using `minimum_tls_version = "1.2"`|
| 9. | AZU-ASQLMI-SC_020 | Must use a dedicated CMK for SQL Server Managed Instance Transparent Data Encryption that is persisted in an HSM backed Key Vault | Use a dedicated SQL Server Managed Instance LSEG managed encryption at rest key persisted in an HSM backed Key Vault (What) within Transparent data encryption settings (How) in order should Microsoft's key management platform become compromised LSEG can revoke access to exfiltrated encrypted data (Why) | True | True | Implemented using `azurerm_mssql_managed_instance_transparent_data_encryption` terraform resource block.|
| 10. | AZU-ASQLMI-SC_030 | SQL Managed Instance must have a data classification tag | SQL Managed Instance must have a data classification tag with one of the following values, Public, Corporate, Restricted or Highly Restricted (What) within Tags setting (How) in order to differentiate assets technical control requirements and to assist Security Operations in prioritising possible data breach mitigation responses (Why) | False | False | This Security Control will be implemented using Azure Policy. |
| 11. | AZU-ASQLMI-SC_040 | Azure App Deployment must not be able to corrupt the centrally managed private link private DNS zones when making a private end point for SQL Managed Instance | SQL Managed Instance must have an Azure DeployIfNotExists policy to update the centrally managed private link private DNS zones with its private A record (What) via Policy to management group mapping (How) to ensure there is no ability for the Azure App Deployment team to have authorisation over these zones that could allow them to corrupt this file and impact service availability (Why) | False | False | This Security Control will be implemented using Azure Policy. |

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Monitor Azure SQL Managed Instance](https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/monitoring-sql-managed-instance-azure-monitor?view=azuresql)<br><br>[Get started with Azure SQL Managed Instance auditing](https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/auditing-configure?view=azuresql)<br><br>[Extended Events in Azure SQL Database and Azure SQL Managed Instance](https://learn.microsoft.com/en-us/azure/azure-sql/database/xevent-db-diff-from-svr?view=azuresql&tabs=sqldb)<br><br>[Cloud monitoring service level objectives](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives)<br><br>[Supported metrics for Microsoft.Sql/managedInstances](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-sql-managedinstances-metrics) |
| 5. | [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | True | This control will be implemented by block `azurerm_mssql_managed_instance_failover_group` for enabling failover and `storage_account_type` parameter enables High Availability.<br><br>[Overview of business continuity with Azure SQL Managed Instance](https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/business-continuity-high-availability-disaster-recover-hadr-overview?view=azuresql)<br><br>[High availability for Azure SQL Managed Instance](https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/high-availability-sla?view=azuresql)<br><br>[Automated backups in Azure SQL Managed Instance](https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/automated-backups-overview?view=azuresql)<br><br>[Failover groups overview & best practices - Azure SQL Managed Instance](https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/failover-group-sql-mi?view=azuresql) |
| 6. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place.<br><br>[Azure built-in roles](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles)<br><br>[What is Windows Authentication for Microsoft Entra principals on Azure SQL Managed Instance?](https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/winauth-azuread-overview?view=azuresql) |

## Changelog

- [azure-prdsvc-terraform-mssqlmanagedinstance](CHANGELOG.md)

## References

### Microsoft Docs

- [AAD Authentication](https://learn.microsoft.com/en-us/azure/azure-sql/database/authentication-aad-configure?view=azuresql&tabs=azure-powershell#azure-portal)
- [Transparent Data Encryption](https://learn.microsoft.com/en-us/azure/azure-sql/database/transparent-data-encryption-tde-overview?view=azuresql&tabs=azure-portal#customer-managed-transparent-data-encryption---bring-your-own-key)
- [Threat Detection](https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/threat-detection-configure?view=azuresql)
- [Auto Failover Group PowerShell](https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/auto-failover-group-sql-mi?view=azuresql&tabs=azure-powershell)
- [Auto Failover Group Portal](https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/auto-failover-group-configure-sql-mi?view=azuresql&tabs=azure-portal)
- [Azure SQL Managed Instance](https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/sql-managed-instance-paas-overview?view=azuresql)
- [AAD Directory Role Assignment](https://learn.microsoft.com/en-us/azure/azure-sql/database/authentication-aad-directory-readers-role-tutorial?view=azuresql)
- [Security Rules and Routes](https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/connectivity-architecture-overview?view=azuresql&tabs=current#mandatory-security-rules-with-service-aided-subnet-configuration)
- [Zone redundancy for General Purpose](https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/doc-changes-updates-release-notes-whats-new?view=azuresql#preview)
- [Stop and start a SQL managed instance](https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/instance-stop-start-how-to?view=azuresql&tabs=azure-powershell-prep%2Cazure-portal)

### Terraform Docs

- [azurerm_mssql_managed_instance](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_managed_instance)
- [azurerm_mssql_managed_instance_active_directory_administrator](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_managed_instance_active_directory_administrator)
- [azurerm_mssql_managed_instance_transparent_data_encryption](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_managed_instance_transparent_data_encryption)
- [azurerm_mssql_managed_instance_security_alert_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_managed_instance_security_alert_policy)
- [azurerm_mssql_managed_instance_vulnerability_assessment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_managed_instance_vulnerability_assessment)
- [azurerm_mssql_managed_instance_failover_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_managed_instance_failover_group)
- [azurerm_mssql_managed_instance](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/mssql_managed_instance)
- [azurerm_mssql_managed_database](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_managed_database)

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
| [azurerm_mssql_managed_instance.failover](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_managed_instance) | resource |
| [azurerm_mssql_managed_instance.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_managed_instance) | resource |
| [azurerm_mssql_managed_instance_active_directory_administrator.failover](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_managed_instance_active_directory_administrator) | resource |
| [azurerm_mssql_managed_instance_active_directory_administrator.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_managed_instance_active_directory_administrator) | resource |
| [azurerm_mssql_managed_instance_failover_group.failover](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_managed_instance_failover_group) | resource |
| [azurerm_mssql_managed_instance_security_alert_policy.failover](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_managed_instance_security_alert_policy) | resource |
| [azurerm_mssql_managed_instance_security_alert_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_managed_instance_security_alert_policy) | resource |
| [azurerm_mssql_managed_instance_start_stop_schedule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_managed_instance_start_stop_schedule) | resource |
| [azurerm_mssql_managed_instance_transparent_data_encryption.failover](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_managed_instance_transparent_data_encryption) | resource |
| [azurerm_mssql_managed_instance_transparent_data_encryption.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_managed_instance_transparent_data_encryption) | resource |
| [azurerm_mssql_managed_instance_vulnerability_assessment.failover](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_managed_instance_vulnerability_assessment) | resource |
| [azurerm_mssql_managed_instance_vulnerability_assessment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_managed_instance_vulnerability_assessment) | resource |
| [azurerm_role_assignment.cmk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cmk_failover](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.sqlmi_storage_va](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.sqlmi_storage_va_failover](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [time_sleep.wait_rbac_propagation](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [time_sleep.wait_rbac_propagation_failover](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_key_vault_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_key) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_email"></a> [admin_email](#input_admin_email) | (Optional) The email of the Azure AD User or Group to be added as administrator of this PostgreSQL Server. | `string` | `null` | no |
| <a name="input_admin_object_id"></a> [admin_object_id](#input_admin_object_id) | (Optional) The object ID of the Azure AD User or Group to be added as administrator of this PostgreSQL Server. | `string` | `null` | no |
| <a name="input_administrator_login"></a> [administrator_login](#input_administrator_login) | (Required) The administrator login name for the new server. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_administrator_login_password"></a> [administrator_login_password](#input_administrator_login_password) | (Required) The password associated with the administrator_login user. Needs to comply with Azure's Password Policy | `string` | n/a | yes |
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_auto_rotation_enabled"></a> [auto_rotation_enabled](#input_auto_rotation_enabled) | (Optional) When enabled, the SQL Managed Instance will continuously check the key vault for any new versions of the key being used as the TDE protector. If a new version of the key is detected, the TDE protector on the SQL Managed Instance will be automatically rotated to the latest key version within 60 minutes. | `bool` | `true` | no |
| <a name="input_azuread_authentication_only"></a> [azuread_authentication_only](#input_azuread_authentication_only) | (Optional) Specify if you want to enable only Entra ID  authentication. | `bool` | `true` | no |
| <a name="input_cmk_key_name"></a> [cmk_key_name](#input_cmk_key_name) | (optional) Key name to be used (max 127 chars) | `string` | `null` | no |
| <a name="input_collation"></a> [collation](#input_collation) | (Optional) Specifies how the SQL Managed Instance will be collated. Changing this forces a new resource to be created | `string` | `"SQL_Latin1_General_CP1_CI_AS"` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_create_role_assignment"></a> [create_role_assignment](#input_create_role_assignment) | (Optional) Whether to create a role assignment to the primary service identity to allow access to the key vault keys. | `bool` | `true` | no |
| <a name="input_create_role_assignment_failover"></a> [create_role_assignment_failover](#input_create_role_assignment_failover) | (Optional) Whether to create a role assignment to the failover service identity to allow access to the key vault keys. | `bool` | `true` | no |
| <a name="input_customer_managed_key"></a> [customer_managed_key](#input_customer_managed_key) | (Required) An customer_managed_key block as defined below<br/>object({<br/>  key_vault_id                      = "(Required) The resource ID of the Key Vault where the Key Vault Key resides."<br/>  expiration_date                   = "(Required) Expiration UTC datetime (Y-m-d'T'H:M:S'Z')."<br/>  identity_id                       = "(Optional) The resource ID of the User Assigned Identity that has access to the key. To be used if `use_system_assigned_identity` is set to `false`"<br/>  identity_principal_id             = "(Optional) The principal ID of the User Assigned Identity that has access to the key."<br/>}) | <pre>object({<br/>    key_vault_id          = string<br/>    expiration_date       = string<br/>    identity_id           = optional(string)<br/>    identity_principal_id = optional(string)<br/>  })</pre> | n/a | yes |
| <a name="input_database_format"></a> [database_format](#input_database_format) | (Optional) Specifies the internal format of the SQL Managed Instance databases specific to the SQL engine version. Possible values are `AlwaysUpToDate` and `SQLServer2022`. Defaults to `SQLServer2022`. Note: Changing from `AlwaysUpToDate` to `SQLServer2022` forces a new resource to be created. | `string` | `"SQLServer2022"` | no |
| <a name="input_enable_entra_id_authentication"></a> [enable_entra_id_authentication](#input_enable_entra_id_authentication) | (Optional) Specify if you want to enable Entra ID authentication. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_failover_group"></a> [failover_group](#input_failover_group) | Note: If the variable is omitted, the default block below would be applied. Not the individual default values for each parameter.<br/>    failover_enabled                          = "(Required) Check if Failover to be enabled"<br/>    location                                  = "(Required) The Azure Region where the Managed Instance Failover Group should exist. Changing this forces a new resource to be created."<br/>    readonly_endpoint_failover_policy_enabled = "(Optional) Failover policy for the read-only endpoint. Defaults to true."<br/>    secondary_type                            = "(Optional) The type of the secondary Managed Instance. Possible values are Geo, Standby. Defaults to Geo."<br/>    use_unique_failover_group_name            = "(Optional) If true, creates a unique naming module for failover group with global scope. If false (default), uses the existing failover instance naming for backward compatibility. Defaults to false." | <pre>object({<br/>    failover_enabled                          = bool<br/>    location                                  = string<br/>    readonly_endpoint_failover_policy_enabled = optional(bool, true)<br/>    secondary_type                            = optional(string)<br/>    use_unique_failover_group_name            = optional(bool, false) # New backward-compatible flag<br/>  })</pre> | <pre>{<br/>  "failover_enabled": false,<br/>  "location": null,<br/>  "readonly_endpoint_failover_policy_enabled": true,<br/>  "secondary_type": "Geo",<br/>  "use_unique_failover_group_name": false<br/>}</pre> | no |
| <a name="input_failover_storage_account_type"></a> [failover_storage_account_type](#input_failover_storage_account_type) | (Optional) Specifies the storage account type in secondary region used to store backups for this database. Changing this forces a new resource to be created. Possible values are GRS, GZRS, LRS and ZRS. | `string` | `"GRS"` | no |
| <a name="input_failover_zone_redundant_enabled"></a> [failover_zone_redundant_enabled](#input_failover_zone_redundant_enabled) | (Optional)  Specifies whether or not the SQL Managed Instance is zone redundant in secondary region. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_general_purpose_v2_enabled"></a> [general_purpose_v2_enabled](#input_general_purpose_v2_enabled) | (Optional) Specifies whether the SQL Managed Instance should use the Next-gen General Purpose service tier. Defaults to false. Can only be set to true when using a General Purpose (GP_*) SKU. | `bool` | `false` | no |
| <a name="input_hybrid_secondary_usage"></a> [hybrid_secondary_usage](#input_hybrid_secondary_usage) | (Optional) Specifies the hybrid secondary usage for disaster recovery of the SQL Managed Instance. Possible values are `Active` and `Passive`. Defaults to `Active`. | `string` | `"Active"` | no |
| <a name="input_identity"></a> [identity](#input_identity) | (Optional) An identity block supports the following:<br/>object({<br/>  type         = "(Required) Specifies the type of Managed Service Identity that should be configured on this SQL Managed Instance."<br/>  identity_ids = "(Optional) A list of User Assigned Managed Identity IDs to be assigned to this SQL Managed Instance. Required if used together with customer_managed_key block."<br/>}) | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | <pre>{<br/>  "identity_ids": null,<br/>  "type": "SystemAssigned"<br/>}</pre> | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_key_size"></a> [key_size](#input_key_size) | (Optional) Specifies the Size of the RSA key to create in bytes. Allowed values are 1024, 2048, 3072 or 4096. | `number` | `2048` | no |
| <a name="input_key_type"></a> [key_type](#input_key_type) | (Optional) Specifies the Key Type to use for the Key Vault Key. | `string` | `"RSA-HSM"` | no |
| <a name="input_key_vault_tags"></a> [key_vault_tags](#input_key_vault_tags) | (Optional) Key Vault related tags to be set on key vault child resources. | `map(any)` | `{}` | no |
| <a name="input_license_type"></a> [license_type](#input_license_type) | (Required) Type of license the Managed Instance will use. Possible values are LicenseIncluded and BasePrice. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_maintenance_configuration_name"></a> [maintenance_configuration_name](#input_maintenance_configuration_name) | (Optional) The name of the Public Maintenance Configuration window to apply to the SQL Managed Instance. Valid values include SQL_Default or an Azure Location in the format SQL_{Location}_MI_{Size}(for example SQL_EastUS_MI_1). | `string` | `"SQL_Default"` | no |
| <a name="input_maintenance_configuration_name_failover"></a> [maintenance_configuration_name_failover](#input_maintenance_configuration_name_failover) | (Optional) The name of the Public Maintenance Configuration window to apply to the failover SQL Managed Instance. Valid values include SQL_Default or an Azure Location in the format SQL_{Location}_MI_{Size}(for example SQL_CentralUS_MI_2). If not specified, defaults to the value of maintenance_configuration_name. | `string` | `"SQL_Default"` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_proxy_override"></a> [proxy_override](#input_proxy_override) | (Optional) Specifies how the SQL Managed Instance will be accessed. Valid values include Proxy, and Redirect. | `string` | `"Redirect"` | no |
| <a name="input_read_write_endpoint_failover_policy"></a> [read_write_endpoint_failover_policy](#input_read_write_endpoint_failover_policy) | mode          = "(Required) The failover mode. Possible values are Automatic or Manual."<br/>  grace_minutes = "(Optional) Applies only if mode is Automatic. The grace period in minutes before failover with data loss is attempted." | <pre>object({<br/>    mode          = string<br/>    grace_minutes = optional(number, null)<br/>  })</pre> | <pre>{<br/>  "grace_minutes": 60,<br/>  "mode": "Automatic"<br/>}</pre> | no |
| <a name="input_recurring_scans"></a> [recurring_scans](#input_recurring_scans) | recurring_scans            = "(Optional) The recurring scans settings. The recurring_scans block supports fields documented below."<br/>      enabled                   = "(Optional) Boolean flag which specifies if recurring scans is enabled or disabled. Defaults to false."<br/>      email_subscription_admins = "(Optional) Boolean flag which specifies if the schedule scan notification will be sent to the subscription administrators. Defaults to true."<br/>      emails                    = "(Optional) Specifies an array of e-mail addresses to which the scan notification is sent." | <pre>object({<br/>    enabled                   = optional(bool)<br/>    email_subscription_admins = optional(bool)<br/>    emails                    = optional(list(string))<br/>  })</pre> | `null` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_resource_group_name_failover"></a> [resource_group_name_failover](#input_resource_group_name_failover) | (Optional) Name of the Resource Group in which to create the resource. | `string` | `null` | no |
| <a name="input_rotation_policy"></a> [rotation_policy](#input_rotation_policy) | (Optional) A rotation policy block as defined below<br/>object({<br/>  notify_before_expiry = "(Required) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>  time_before_expiry   = "(Required) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br/>  time_after_creation  = "(Optional) Rotate automatically at a duration after create as an ISO 8601 duration."<br/>  expire_after         = "(Required) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>}) | <pre>object({<br/>    notify_before_expiry = string<br/>    time_before_expiry   = string<br/>    time_after_creation  = optional(string, null)<br/>    expire_after         = string<br/>  })</pre> | <pre>{<br/>  "expire_after": "P365D",<br/>  "notify_before_expiry": "P351D",<br/>  "time_after_creation": "P358D",<br/>  "time_before_expiry": null<br/>}</pre> | no |
| <a name="input_security_alert"></a> [security_alert](#input_security_alert) | (Optional) Managed Instance Security Alert Policy block as defined below<br/>object({<br/>  disabled_alerts              = "(Optional) Specifies an array of alerts that are disabled. Possible values are Sql_Injection, Sql_Injection_Vulnerability, Access_Anomaly, Data_Exfiltration, Unsafe_Action and Brute_Force"<br/>  enabled                      = "(Optional) Specifies the state of the Security Alert Policy, whether it is enabled or disabled. Possible values are true, false."<br/>  email_account_admins_enabled = "(Optional) Boolean flag which specifies if the alert is sent to the account administrators or not. Defaults to false."<br/>  email_addresses              = "(Optional) Specifies an array of email addresses to which the alert is sent."<br/>  retention_days               = "(Optional) Specifies the number of days to keep in the Threat Detection audit logs. Defaults to 0."<br/>  storage_endpoint             = "(Optional) Specifies the blob storage endpoint (e.g. https://example.blob.core.windows.net). This blob storage will hold all Threat Detection audit logs."<br/>  storage_account_access_key   = "(Optional) Specifies the identifier key of the Threat Detection audit storage account. This is mandatory when you use storage_endpoint to specify a storage account blob endpoint."<br/>  }) | <pre>object({<br/>    disabled_alerts              = list(string)<br/>    enabled                      = bool<br/>    email_account_admins_enabled = bool<br/>    email_addresses              = optional(list(string))<br/>    retention_days               = number<br/>    storage_endpoint             = optional(string)<br/>    storage_account_access_key   = optional(string)<br/>  })</pre> | <pre>{<br/>  "disabled_alerts": [<br/>    "Sql_Injection",<br/>    "Sql_Injection_Vulnerability",<br/>    "Access_Anomaly",<br/>    "Data_Exfiltration",<br/>    "Unsafe_Action",<br/>    "Brute_Force"<br/>  ],<br/>  "email_account_admins_enabled": true,<br/>  "email_addresses": null,<br/>  "enabled": false,<br/>  "retention_days": 7,<br/>  "storage_account_access_key": null,<br/>  "storage_endpoint": null<br/>}</pre> | no |
| <a name="input_security_alert_failover"></a> [security_alert_failover](#input_security_alert_failover) | (Optional) Managed Instance Security Alert Policy block as defined below<br/>object({<br/>  storage_endpoint             = "(Optional) Specifies the blob storage endpoint (e.g. https://example.blob.core.windows.net). This blob storage will hold all Threat Detection audit logs."<br/>  storage_account_access_key   = "(Optional) Specifies the identifier key of the Threat Detection audit storage account. This is mandatory when you use storage_endpoint to specify a storage account blob endpoint."<br/>  }) | <pre>object({<br/>    storage_endpoint           = optional(string)<br/>    storage_account_access_key = optional(string)<br/>  })</pre> | <pre>{<br/>  "storage_account_access_key": null,<br/>  "storage_endpoint": null<br/>}</pre> | no |
| <a name="input_sku_name"></a> [sku_name](#input_sku_name) | (Required) Specifies the SKU Name for the SQL Managed Instance. Valid values include GP_Gen4, GP_Gen5, GP_Gen8IM, GP_Gen8IH, BC_Gen4, BC_Gen5, BC_Gen8IM or BC_Gen8IH. | `string` | n/a | yes |
| <a name="input_sku_name_failover"></a> [sku_name_failover](#input_sku_name_failover) | (Optional) Specifies the SKU Name for the failover SQL Managed Instance. If not specified, defaults to the value of sku_name. Valid values include GP_Gen4, GP_Gen5, GP_Gen8IM, GP_Gen8IH, BC_Gen4, BC_Gen5, BC_Gen8IM or BC_Gen8IH. | `string` | `null` | no |
| <a name="input_start_stop_description"></a> [start_stop_description](#input_start_stop_description) | (Optional) Specifies the description of the start/stop schedule. | `string` | `null` | no |
| <a name="input_start_stop_schedule"></a> [start_stop_schedule](#input_start_stop_schedule) | (Optional) A list of schedule blocks for the SQL Managed Instance start/stop schedule.<br/>object({<br/>  start_day  = "(Required) Start day of the schedule. Possible values are Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday."<br/>  start_time = "(Required) Start time of the schedule in 24-hour format (e.g., 08:00)."<br/>  stop_day   = "(Required) Stop day of the schedule. Possible values are Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday."<br/>  stop_time  = "(Required) Stop time of the schedule in 24-hour format (e.g., 17:00)."<br/>}) | <pre>list(object({<br/>    start_day  = string<br/>    start_time = string<br/>    stop_day   = string<br/>    stop_time  = string<br/>  }))</pre> | `[]` | no |
| <a name="input_start_stop_timezone_id"></a> [start_stop_timezone_id](#input_start_stop_timezone_id) | (Optional) Specifies the time zone of the start/stop schedule. Defaults to UTC. | `string` | `"UTC"` | no |
| <a name="input_storage_account_id_for_va"></a> [storage_account_id_for_va](#input_storage_account_id_for_va) | (Optional) The resource ID of the storage account for vulnerability assessment. Used to create RBAC role assignment before vulnerability assessment creation. If not provided, role assignment will use storage_account_id from vulnerability_assessment variable. | `string` | `null` | no |
| <a name="input_storage_account_id_for_va_failover"></a> [storage_account_id_for_va_failover](#input_storage_account_id_for_va_failover) | (Optional) The resource ID of the storage account for vulnerability assessment in failover region. Used to create RBAC role assignment before vulnerability assessment creation. If not provided, role assignment will use storage_account_id from vulnerability_assessment_failover variable. | `string` | `null` | no |
| <a name="input_storage_account_type"></a> [storage_account_type](#input_storage_account_type) | (Optional) Specifies the storage account type used to store backups for this database. Changing this forces a new resource to be created. Possible values are GRS, GZRS, LRS and ZRS. | `string` | `"GRS"` | no |
| <a name="input_storage_size_in_gb"></a> [storage_size_in_gb](#input_storage_size_in_gb) | (Required) Maximum storage space for the SQL Managed instance. This should be a multiple of 32 (GB). | `number` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet_id](#input_subnet_id) | (Required) The subnet resource id that the SQL Managed Instance will be associated with. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_subnet_id_failover"></a> [subnet_id_failover](#input_subnet_id_failover) | (Optional) The subnet resource id that the SQL Managed Instance will be associated with. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_timezone_id"></a> [timezone_id](#input_timezone_id) | (Optional) The TimeZone ID that the SQL Managed Instance will be operating in. Changing this forces a new resource to be created. | `string` | `"UTC"` | no |
| <a name="input_uai_principal_id"></a> [uai_principal_id](#input_uai_principal_id) | (Optional) Principal id of the User Assigned Identity which should be used to access the CMK encryption key in the Key Vault. This identity will be granted `Key Vault Crypto Service Encryption User` role on the Key vault. This must be the principal id of one of the `User Assigned Identities` assigned to the storage Account else `System Assigned Managed Identity` to be used. | `string` | `null` | no |
| <a name="input_vcores"></a> [vcores](#input_vcores) | (Required) Number of cores that should be assigned to the SQL Managed Instance. Values can be 8, 16, or 24 for Gen4 SKUs, or 4, 8, 16, 24, 32, 40, 64, or 80 for Gen5 SKUs. | `number` | n/a | yes |
| <a name="input_vcores_failover"></a> [vcores_failover](#input_vcores_failover) | (Optional) Number of cores that should be assigned to the failover SQL Managed Instance. If not specified, defaults to the value of vcores. Values can be 8, 16, or 24 for Gen4 SKUs, or 4, 8, 16, 24, 32, 40, 64, or 80 for Gen5 SKUs. | `number` | `null` | no |
| <a name="input_vulnerability_assessment"></a> [vulnerability_assessment](#input_vulnerability_assessment) | storage_container_path     = "(Required) A blob storage container path to hold the scan results (e.g. https://myStorage.blob.core.windows.net/VaScans/)." <br/>    storage_account_access_key = "(Optional) Specifies the identifier key of the storage account for vulnerability assessment scan results. If storage_container_sas_key isn't specified, storage_account_access_key is required."<br/>    storage_container_sas_key  = "(Optional) A shared access signature (SAS Key) that has write access to the blob container specified in storage_container_path parameter. If storage_account_access_key isn't specified, storage_container_sas_key is required."<br/>    enabled                    = "(Optional) Specifies the state of the vulnerability assessment, whether it is enabled or disabled. Possible values are true, false." | <pre>object({<br/>    storage_container_path     = string<br/>    storage_account_access_key = optional(string)<br/>    storage_container_sas_key  = optional(string)<br/>    enabled                    = optional(bool)<br/>  })</pre> | <pre>{<br/>  "enabled": false,<br/>  "storage_account_access_key": null,<br/>  "storage_container_path": null,<br/>  "storage_container_sas_key": null<br/>}</pre> | no |
| <a name="input_vulnerability_assessment_failover"></a> [vulnerability_assessment_failover](#input_vulnerability_assessment_failover) | storage_container_path     = "(Required) A blob storage container path to hold the scan results (e.g. https://myStorage.blob.core.windows.net/VaScans/)." <br/>    storage_account_access_key = "(Optional) Specifies the identifier key of the storage account for vulnerability assessment scan results. If storage_container_sas_key isn't specified, storage_account_access_key is required."<br/>    storage_container_sas_key  = "(Optional) A shared access signature (SAS Key) that has write access to the blob container specified in storage_container_path parameter. If storage_account_access_key isn't specified, storage_container_sas_key is required." | <pre>object({<br/>    storage_container_path     = string<br/>    storage_account_access_key = optional(string)<br/>    storage_container_sas_key  = optional(string)<br/>  })</pre> | <pre>{<br/>  "storage_account_access_key": null,<br/>  "storage_container_path": null,<br/>  "storage_container_sas_key": null<br/>}</pre> | no |
| <a name="input_zone_redundant_enabled"></a> [zone_redundant_enabled](#input_zone_redundant_enabled) | (Optional) Specifies whether or not the SQL Managed Instance is zone redundant. Defaults to `false`. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_active_directory_administrator_id"></a> [active_directory_administrator_id](#output_active_directory_administrator_id) | The ID of the SQL Managed Instance active directory administrator |
| <a name="output_fqdn"></a> [fqdn](#output_fqdn) | The FQDN of the SQL Managed Instance |
| <a name="output_id"></a> [id](#output_id) | The ID of the SQL Managed Instance |
| <a name="output_name"></a> [name](#output_name) | The name of the SQL Managed Instance. |
| <a name="output_resource"></a> [resource](#output_resource) | The SQL Managed Instance resource. |
| <a name="output_resource_failover"></a> [resource_failover](#output_resource_failover) | The SQL Managed Instance resource for failover region. |
| <a name="output_security_alert_policy_id"></a> [security_alert_policy_id](#output_security_alert_policy_id) | The ID of the MS SQL Managed Instance Security Alert Policy |
| <a name="output_transparent_data_encryption_id"></a> [transparent_data_encryption_id](#output_transparent_data_encryption_id) | The ID of the MSSQL Managed Instance encryption protector |
| <a name="output_vulnerability_assessment_id"></a> [vulnerability_assessment_id](#output_vulnerability_assessment_id) | The ID of the MS SQL Managed Instance Vulnerability Assessment. |
<!-- END_TF_DOCS -->
