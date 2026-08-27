---
version: 1.0.3
available_versions:
  - 1.0.3
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.3.0
---

<!-- BEGIN_TF_DOCS -->
# SQL Managed Database module

## Overview

This terraform module creates a sql managed database and associated resources.

## Prerequisites

A `key vault` needs to be created first, if not exists, to store sensitive information. A delegated `Subnet` is  required for SQL Managed Instance creation.

## Guidance

#### Usage

- Azure SQL Database and SQL Managed Instance share a common code base with the latest stable version of SQL Server. Most of the standard SQL language, query processing, and database management features are identical.
- SQL MI failover has not been tested as the foundational resources required in paired region are not available.

#### Security Considerations

- The following API permissions are required for different principal_type:
  - When authenticated with a service principal, this Data Source: azuread_service_principal requires one of the following application roles: Application.Read.All or Directory.Read.All
  - When authenticated with a service principal, this Data Source: azuread_group requires one of the following application roles: Group.Read.All or Directory.Read.All
  - When authenticated with a service principal, this Data Source: azuread_user requires one of the following application roles: User.Read.All or Directory.Read.All
  - When authenticated with a user principal, none of the data sources requires any additional roles.

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-ASQLMIDB-AU_010 | Send all diagnostic log categories to a central SOC Log Analytics workspace | SQL Managed Instance Databases must send all diagnostic logs to a central SOC Log Analytics workspace (What) within Diagnostic setting (How) in order to support a security investigation after a security incident (Why) | False | False | To be implemented via `DINE` Policy. |
| 2. | AZU-ASQLMIDB-AU_020 | Send all diagnostic log categories to a central SOC Storage Account | SQL Managed Instance Databases must send all diagnostic logs to a central SOC Storage Account (What) within Diagnostic setting (How) In order to provide an immutable copy to adhere to compliance requirements (Why) | False | False  | To be implemented via `DINE` Policy. |
| 3. | AZU-ASQLMIDB-AU_030 | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval (What) within Diagnostic settings (How) in order to prevent sensitive data leakage to third parties outside of LSEG control (Why) | False | False | To be implemented via Policy with effect set to `Deny`. |
| 4. | AZU-ASQLMI-SC_010 | SQL Managed Instance Databases must have a data classification tag | SQL Managed Instance Databases must have a data classification tag with one of the following values, Public, Corporate, Restricted or Highly Restricted (What) within Tags setting (How) in order to differentiate assets technical control requirements and to assist Security Operations in prioritising possible data breach mitigation responses (Why) | False | False | Tags are not supported in SQL Managed Database. |

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Monitor Azure SQL Database](https://learn.microsoft.com/en-us/azure/azure-sql/database/monitoring-sql-database-azure-monitor?view=azuresql)<br><br>[Auditing for Azure SQL Database and Azure Synapse Analytics](https://learn.microsoft.com/en-us/azure/azure-sql/database/auditing-overview?view=azuresql)<br><br>[Extended Events in Azure SQL Database and Azure SQL Managed Instance](hhttps://learn.microsoft.com/en-us/azure/azure-sql/database/xevent-db-diff-from-svr?view=azuresql&tabs=sqldb)<br><br>[Supported metrics for Microsoft.Sql/servers/databases](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-sql-servers-databases-metrics)<br><br>[Cloud monitoring service level objectives](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives) |
| 5. | [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | True | This control is implemented by default as SQL Database takes automated backup with frequency as Full backups every week, Differential backups every 12 or 24 hours, Transaction log backups approximately every 10 minutes and further failover groups gives protection for SQL MI Instance failure.<br><br>[Overview of business continuity with Azure SQL Database](https://learn.microsoft.com/en-us/azure/azure-sql/database/business-continuity-high-availability-disaster-recover-hadr-overview?view=azuresql)<br><br>[High availability for Azure SQL Database](hhttps://learn.microsoft.com/en-us/azure/azure-sql/database/high-availability-sla?view=azuresql&tabs=azure-powershell)<br><br>[Automated backups in Azure SQL Database](https://learn.microsoft.com/en-us/azure/azure-sql/database/automated-backups-overview?view=azuresql)<br><br>[Active geo-replication](https://learn.microsoft.com/en-us/azure/azure-sql/database/active-geo-replication-overview?view=azuresql) |
| 6. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place.<br><br>[Azure built-in roles](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles)<br><br>[Configure and manage Microsoft Entra authentication with Azure SQL](hhttps://learn.microsoft.com/en-us/azure/azure-sql/database/authentication-aad-configure?view=azuresql&tabs=azure-powershell)<br><br>[Authorize database access to SQL Database, SQL Managed Instance, and Azure Synapse Analytics](https://learn.microsoft.com/en-us/azure/azure-sql/database/logins-create-manage?view=azuresql) |

## Changelog

- [azure-prdsvc-terraform-mssqlmanageddatabase](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/azure-sql/database/logins-create-manage?view=azuresql)

### Terraform Docs

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

## Resources

| Name | Type |
|------|------|
| [azurerm_mssql_managed_database.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_managed_database) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_long_term_retention_policies"></a> [long_term_retention_policies](#input_long_term_retention_policies) | (Optional) Map containing long_term_retention_policy for this Managed Database<br/>object({<br/>  weekly_retention  = "(Optional) The weekly retention policy for an LTR backup in an ISO 8601 format. Valid value is between 1 to 520 weeks. e.g. P1Y, P1M, P1W or P7D"<br/>  monthly_retention = "(Optional) The monthly retention policy for an LTR backup in an ISO 8601 format. Valid value is between 1 to 120 months. e.g. P1Y, P1M, P4W or P30D"<br/>  yearly_retention  = "(Optional) The yearly retention policy for an LTR backup in an ISO 8601 format. Valid value is between 1 to 10 years. e.g. P1Y, P12M, P52W or P365D."<br/>  week_of_year      = "(Optional) The week of year to take the yearly backup. Value has to be between 1 and 52."<br/>}) | <pre>map(object({<br/>    weekly_retention  = string<br/>    monthly_retention = string<br/>    yearly_retention  = string<br/>    week_of_year      = number<br/>  }))</pre> | `{}` | no |
| <a name="input_managed_instance_id"></a> [managed_instance_id](#input_managed_instance_id) | (Required) The ID of the Managed Instance. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input_name) | (Optional) Provide a custom name for the managed SQL database. If not set, a name will be generated. | `string` | `null` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_retention_days"></a> [retention_days](#input_retention_days) | (Optional) Specifies the short term retention policy - retention days for the new databases. | `number` | `7` | no |
| <a name="input_retention_policy"></a> [retention_policy](#input_retention_policy) | (Optional) Should retention policy be applied or skip as per input. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The ID of the SQL Managed Database |
| <a name="output_name"></a> [name](#output_name) | The name of the SQL Managed Database |
| <a name="output_resource"></a> [resource](#output_resource) | The Azure SQL Managed Database Resource. |
<!-- END_TF_DOCS -->
