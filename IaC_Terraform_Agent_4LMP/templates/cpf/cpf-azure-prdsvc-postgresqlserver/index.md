---
version: 1.1.0
available_versions:
  - 1.1.0
  - 1.0.3
  - 1.0.2
  - 1.0.1
  - 1.0.0
---

<!-- BEGIN_TF_DOCS -->
# PostgreSQL Flexible Server module

## Process to upgrade the module version from <0.9.1 to the latest version

- [Migration Guide](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-postgresqlserver/-/wikis/Migration-Guide:-Upgrading-from-module-versions-prior-to-0.9.1-to-the-latest-version)

## Overview

This terraform module creates an Azure PostgreSQL server and associated resources.

## Prerequisites

- A `key vault` to store the Customer Managed Key and other required secrets.
- A Subnet in the targeted Virtual Network delegated to Postgre Flexible Server.
- A Subnet in the targeted Virtual Network for various private endpoints created for the dependent resources.
- Azure Database for PostgreSQL - Flexible Server Data Encryption with a Customer Managed Key requires user-assigned managed identity.

## Guidance

#### Usage

- The Geo-redundant backup encryption key needs to be created in an Azure Key Vault (AKV) in the region where the Geo-redundant backup is stored
- A unique name called as "postgres.database.azure.com" is appended to postgreSQL Flexible Server and private DNS Zone, that identifies the PostgreSQL Flexible server.
- Create Mode can be `Default`, `Replica`, `PointInTimeRestore`, `Update`.
- `Replica` create mode requires virtual networks to be peered if source server is in different virtual network. Ensure you have all the [requirements](https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-read-replicas) in place before creating a replica server.

- Replica servers can be promoted to standalone independent servers using the `replica_promotion` variable. Set `promote_mode` to `Standalone` and `promote_option` to either `Planned` (waits for full data sync, no data loss) or `Forced` (immediate promotion, potential data loss). After promotion completes, remove the `replica_promotion` configuration from the code. Promoted replicas cannot be reverted back to replica status.

- `PointInTimeRestore` create mode requires valid restore points in module. If the source server is configured with private access, you can restore only to another virtual network in the remote region. You can either choose an existing virtual network or create a new virtual network and restore your server into that network.
- Storage autogrow currently doesn't work with read-replica-enabled servers.

- Use `key_vault_tags` variable to define additional Key Vault Keys/Secret related tags in your product, and you can not have more than 2 tags (key-value pairs), as the product gets a default of 13 tags and Key Vault child resources support only 15 tags as the maximum limit. Reference link - [Key tags](https://learn.microsoft.com/en-us/azure/key-vault/keys/about-keys-details#key-tags)

- Use the `tags` variable to define additional tags related to the product (core). Note that the product already has a default of 13 tags, so if you are adding multiple additional tags (key-value pairs), ensure the total count does not exceed the limit supported by Azure resources. [Azure Resources Tag Limitation](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/tag-support)

- The `private_dns_zone_id` becomes mandatory when setting a `delegated_subnet_id`. For existing flexible servers who don't want to be recreated, you need to provide the `private_dns_zone_id` to the service team to manually migrate to the specified private DNS zone. The `azurerm_private_dns_zone` should end with suffix `.postgres.database.azure.com`.

- The parameters `delegated_subnet_id` and `private_dns_zone_id` are made optional intentionally and are null by default, allowing them to be enabled when necessary as per Application need. `private_access` can be enabled by setting a value to these attributes.

- To add a `private_endpoint`, `delegated_subnet_id` and `private_dns_zone_id` should be null.  

- The attribute `public_network_access_enabled` is hardcoded with value `false` because `public access` is enabled by default when enabling `private_endpoint` which is against security controls and `public_network_access_enabled` must be set to false when `delegated_subnet_id` and `private_dns_zone_id` have a value.

- The `azurerm_key_vault_key` data block is used to fetch the latest key vault key version, which is then applied to the PostgresSQL server to ensure it uses the current version of the `customer_managed_key`.

- Geo-redundant backup requires deployment in an Azure paired region. A dedicated Key Vault with customer-managed keys, private endpoint infrastructure, and VNet peering must be provisioned in the paired region to support encrypted backup replication and secure cross-region connectivity for disaster recovery scenarios.

- Cross-region read replicas deployed in separate virtual networks require VNet peering to establish connectivity across regional boundaries. This enables replication traffic between primary and replica servers and ensures proper DNS resolution for the replica's FQDN across VNets.

#### Security Considerations

- The following API permissions are required for different principal_type:
  - When authenticated with a service principal, this Data Source: azuread_service_principal requires one of the following application roles: Application.Read.All or Directory.Read.All
  - When authenticated with a service principal, this Data Source: azuread_group requires one of the following application roles: Group.Read.All or Directory.Read.All
  - When authenticated with a service principal, this Data Source: azuread_user requires one of the following application roles: User.Read.All or Directory.Read.All
  - When authenticated with a user principal, none of the data sources requires any additional roles.
- Some additional rules and routes to be added by Application team in `Network Security Group` and `Route Table` for the successful postgresql flexible server deployment:
```
security_rules = {
    "rule1" = {
      name                                       = "AllowVnetInbound"
      description                                = "Allow traffic to Azure Database for PostgreSQL"
      priority                                   = 3000
      direction                                  = "Inbound"
      access                                     = "Allow"
      protocol                                   = "Tcp"
      source_port_range                          = "*"
      destination_port_range                     = "*"
      source_address_prefix                      = "VirtualNetwork"
      destination_address_prefix                 = "VirtualNetwork"
      source_application_security_group_ids      = []
      destination_application_security_group_ids = []
    },
    "rule2" = {
      name                                       = "AllowVnetOutbound"
      description                                = "Allow traffic to Azure Database for PostgreSQL"
      priority                                   = 3000
      direction                                  = "Outbound"
      access                                     = "Allow"
      protocol                                   = "Tcp"
      source_port_range                          = "*"
      destination_port_range                     = "*"
      source_address_prefix                      = "VirtualNetwork"
      destination_address_prefix                 = "VirtualNetwork"
      source_application_security_group_ids      = []
      destination_application_security_group_ids = []
    },
    "rule3" = {
      name                                       = "AllowAzureLoadBalanceraInbound"
      description                                = "Allow traffic to Azure Database for PostgreSQL"
      priority                                   = 3100
      direction                                  = "Inbound"
      access                                     = "Allow"
      protocol                                   = "*"
      source_port_range                          = "*"
      destination_port_range                     = "*"
      source_address_prefix                      = "VirtualNetwork"
      destination_address_prefix                 = "VirtualNetwork"
      source_application_security_group_ids      = []
      destination_application_security_group_ids = []
    },
    "rule4" = {
      name                                       = "AllowInternetOutbound"
      description                                = "Allow traffic to Azure Database for PostgreSQL"
      priority                                   = 3100
      direction                                  = "Outbound"
      access                                     = "Allow"
      protocol                                   = "*"
      source_port_range                          = "*"
      destination_port_range                     = "*"
      source_address_prefix                      = "*"
      destination_address_prefix                 = "Internet"
      source_application_security_group_ids      = []
      destination_application_security_group_ids = []
    },
    "rule5" = {
      name                                       = "AllowOnpremInbound"
      description                                = "Allow traffic to Azure Database for PostgreSQL"
      priority                                   = 3200
      direction                                  = "Inbound"
      access                                     = "Allow"
      protocol                                   = "*"
      source_port_range                          = "*"
      destination_port_range                     = "*"
      source_address_prefixes                      = ["167.68.0.0/16", "159.220.0.0/16", "162.8.0.0/16", "159.42.0.0/16", "172.16.0.0/12", "10.0.0.0/8", "163.231.0.0/16", "164.179.0.0/16"]
      destination_address_prefix                 = "VirtualNetwork"
      source_application_security_group_ids      = []
      destination_application_security_group_ids = []
    },
    "rule6" = {
      name                                       = "AllowOnpremOutbound"
      description                                = "Allow traffic to Azure Database for PostgreSQL"
      priority                                   = 3200
      direction                                  = "Outbound"
      access                                     = "Allow"
      protocol                                   = "*"
      source_port_range                          = "*"
      destination_port_range                     = "*"
      source_address_prefix                      = "VirtualNetwork"
      destination_address_prefixes                 = ["167.68.0.0/16", "159.220.0.0/16", "162.8.0.0/16", "159.42.0.0/16", "172.16.0.0/12", "10.0.0.0/8", "163.231.0.0/16", "164.179.0.0/16"]
      source_application_security_group_ids      = []
      destination_application_security_group_ids = []
    }
  }

route = {
  {
    "routekey1" = {
      name                   = "a1a-51337-dev-route-atlapps-uks-01"
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.202.136.68"
    }
    "routekey2" = {
      name                   = "a1a-51337-dev-route-atlapps-uks-02"
      address_prefix         = "10.0.0.0/8"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.202.136.68"
    }
    "routekey3" = {
      name                   = "a1a-51337-dev-route-atlapps-uks-03"
      address_prefix         = "172.16.0.0/12"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.202.136.68"
    }
  }
  subnet_ids = []
}
```
- For HA Enablement, enable `5432` port for both `Inbound` and `Outbound` direction with destination `Service tags` as mentioned below:
  - Inbound  : `Storage`, `VirtualNetwork`
  - Outbound : `Storage`, `VirtualNetwork`, `AzureActiveDirectory`

#### Well-Architected Framework (WAF) for PostgreSQL Flexible Server

- Refer to the Wiki for PostgreSQL Flexible Server WAF [documentation](https://gitlab.dx1.lseg.com/groups/app/app-51310/azure/prdsvc/terraform/-/wikis/Cloud-Products-Well-Architecture-Framework-Principles---WAF/-PostgreSQL-Flexible-Server) covering core principles: Reliability, Disaster Recovery (DR), Security, Cost Optimization, and Operational Excellence.

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-PSQLF-IA_010 | Use a Managed Identity for accessing Azure Resources | PostgreSQL server must enforce the use of a Managed Identity to authenticate to Azure resources where this is supported (What) Access control settings (How) in order to remove the need to store credentials (Why) | True | True | This control is implemented via `identity {}` block. |
| 2. | AZU-PSQLF-IA_020 | Entra ID authentication only must be used | Entra ID authentication only must be used (What) in order to use modern robust and less prone to compromise authentication methods embedded within Microsoft Entra ID (How) | True | True | This control will be implemented via attributes `active_directory_auth_enabled` as always set to `True` and `password_auth_enabled` as always set to `False` [As per requirements from App team and post security exemption approval, `password_auth_enabled` variable is added and its value depends on user input]. |
| 3. | AZU-PSQLF-AC_010 | Disable Public Network Access | PostgreSQL Server must enforce a network guardrail if persisting data with internal and above data classification (What) within Networking settings (How) in order to prevent unauthorised access and data exposure to the internet (Why) | True | True | This control is implemented by hardcoding the attribute `public_network_access_enabled` to `false` |
| 4. | AZU-PSQLF-AU_010 | Send all diagnostic log categories to a central SOC Log Analytics workspace | PostgreSQL Server must send all diagnostic logs to a central SOC Log Analytics workspace (What) Auditing settings (How) in order to support an security investigation after a security incident (Why) | False | False | This control will be implemented via policy. |
| 5. | AZU-PSQLF-AU_020 | Send all diagnostic log categories to a central SOC Storage Account | PostgreSQL Server must send all diagnostic logs to a central SOC Storage Account (What) via Diagnostic settings (How) In order to provide an immutable copy to adhere to compliance requirements (Why) | False | False | This control will be implemented via policy. |
| 6. | AZU-PSQLF-CP_010 | Backup retention policy must be reviewed against requirements and set accordingly |  The default backup retention policy must be reviewed against requirements and set accordingly (What) in Retention policies (How) to ensure retention meets the application, regulatory and disaster recovery requirements (Why) | False | False | This control will be implemented via policy. |
| 7. | AZU-PSQLF-SC_010 | Must use a dedicated CMK for PostgreSQL Server Azure Storage Encryption that is persisted in an HSM backed Key Vault | Use a dedicated PostgreSQL Server LSEG managed encryption at rest key persisted in an HSM backed Key Vault (What) within Azure Storage encryption enabled by default (How) in order should Microsoft's key management platform become compromised LSEG can revoke access to exfiltrated encrypted data (Why) | True | False | This control will be implemented via `customer_managed_key` block and using Key type as `RSA-HSM`. |
| 8. | AZU-PSQLF-SC_030 | Network connections to the PostgreSQL Flexible Server control and data planes must use TLS encryption | PostgreSQL Flexible Server must enforce network flow encryption in transit using TLS (What) within the PostgreSQL server parameters (require_secure_transport) (How) in order to use modern techniques to establish robust encrypted data channels over untrusted networks (Why) | True | True | This control will be implemented by setting up `require_secure_transport` to `on` passed in `configuration` variable and by default `TLSV1.2` and `TLSV1.3` protocols are supported of which `TLSV1.2` is the minimum one. |
| 9. | AZU-PSQLF-SC_040 | PostgreSQL Flexible server  must have a data classification tag | PostgreSQL Flexible Server must have a data classification tag with one of the following values, Public, Corporate, Restricted or Highly Restricted (What) within PostgreSQL Flexible Server (How) in order to differentiate assets technical control requirements and to assist Security Operations in prioritising possible data breach mitigation responses (Why) | False | False  | This control will be implemented via policy. |

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Monitor metrics on Azure Database for PostgreSQL - Flexible Server](https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-monitoring)<br><br>[Monitor Azure Database for PostgreSQL - Flexible Server by using Azure Monitor workbooks](https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-workbooks)<br><br>[Logs in Azure Database for PostgreSQL - Flexible Server](https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-logging)<br><br>[Audit logging in Azure Database for PostgreSQL - Flexible Server](https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-audit)<br><br>[Configure and access logs in Azure Database for PostgreSQL - Flexible Server](https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/how-to-configure-and-access-logs)<br><br>[Supported metrics for PostgreSQL flexibleServers](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-dbforpostgresql-flexibleservers-metrics)<br><br>[Cloud monitoring service level objectives](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives) |
| 5. | [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | True | This control will be implemented by following parameters: `high_availability` block for High Availability and failover, `geo_redundant_backup_enabled` property for enabling geo replication, `create_mode` parameter for creating server replica, restore and update operations.<br><br>[Overview of business continuity with Azure Database for PostgreSQL - Flexible Server](https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-business-continuity)<br><br>[High availability (Reliability) in Azure Database for PostgreSQL - Flexible Server](https://learn.microsoft.com/en-us/azure/reliability/reliability-postgresql-flexible-server?toc=%2Fazure%2Fpostgresql%2Ftoc.json&bc=%2Fazure%2Fpostgresql%2Fbreadcrumb%2Ftoc.json)<br><br>[Backup and restore in Azure Database for PostgreSQL - Flexible Server](https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-backup-restore)<br><br>[Geo-disaster recovery in Azure Database for PostgreSQL - Flexible Server](https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-geo-disaster-recovery) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place.<br><br>[Azure built-in roles](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles)<br><br>[Manage Microsoft Entra roles in Azure Database for PostgreSQL - Flexible Server](https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/how-to-manage-azure-ad-users)<br><br>[Use Microsoft Entra ID for authentication with Azure Database for PostgreSQL - Flexible Server](https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/how-to-configure-sign-in-azure-ad-authentication) |

## Changelog

- [azure-prdsvc-terraform-postgresqlserver](CHANGELOG.md)

## References

### Microsoft Docs

- [Official documentation](https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/overview)
- [Restore Server](https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/how-to-restore-server-portal)
- [Data Encryption using CMK](https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-data-encryption)
- [Azure AD Authentication](https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/how-to-configure-sign-in-azure-ad-authentication)
- [Read Replicas](https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-read-replicas)
- [Networking for PostgreSQl Server](https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-networking-private#virtual-network-concepts)

### Terraform Docs

- [azurerm_postgresql_flexible_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server)
- [azurerm_postgresql_flexible_server_active_directory_administrator](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_active_directory_administrator)
- [azurerm_postgresql_flexible_server_configuration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_configuration)
- [azuread_user](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/user)
- [azuread_group](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group)
- [azuread_service_principal](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal)
- [data azurerm_postgresql_flexible_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/postgresql_flexible_server)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0 |
| <a name="requirement_azapi"></a> [azapi](#requirement_azapi) | >= 2.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm) | >=4.33 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azapi"></a> [azapi](#provider_azapi) | >= 2.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | >=4.33 |
| <a name="provider_time"></a> [time](#provider_time) | n/a |

## Resources

| Name | Type |
|------|------|
| [azapi_update_resource.replica_promotion](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/update_resource) | resource |
| [azurerm_key_vault_key.geo](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_key_vault_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_postgresql_flexible_server.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server) | resource |
| [azurerm_postgresql_flexible_server_active_directory_administrator.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_active_directory_administrator) | resource |
| [azurerm_postgresql_flexible_server_configuration.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_configuration) | resource |
| [azurerm_role_assignment.cmk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cmk_geo](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [time_sleep.wait_60s_cmk](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [time_sleep.wait_for_server_ready](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_active_directory_objects"></a> [active_directory_objects](#input_active_directory_objects) | (Required) The Active Directory object block to create the PostgreSQL Flexible Server Active Directory Admin.<br/>object ({<br/>  tenant_id    = "(Required) The Azure Tenant ID. Changing this forces a new resource to be created."<br/>  admin_object_id = "(Required) The object ID of a user, service principal or security group in the Azure Active Directory tenant set as the Flexible Server Admin. Changing this forces a new resource to be created."<br/>  admin_principal_name = "(Required) The name of Azure Active Directory principal. Changing this forces a new resource to be created."<br/>  principal_type = "(Required) The type of Azure Active Directory principal. Possible values are Group, ServicePrincipal and User. Changing this forces a new resource to be created."<br/>}) | <pre>map(object({<br/>    tenant_id            = string<br/>    admin_object_id      = string<br/>    admin_principal_name = string<br/>    principal_type       = string<br/>  }))</pre> | <pre>{<br/>  "admin_object_id": null,<br/>  "admin_principal_name": null,<br/>  "principal_type": null,<br/>  "tenant_id": null<br/>}</pre> | no |
| <a name="input_admin_login"></a> [admin_login](#input_admin_login) | (Optional) The adminstrator login and Password.<br/>object ({<br/>  administrator_login    = "(Optional) The Administrator login for the PostgreSQL Flexible Server. Required when create_mode is Default and authentication.password_auth_enabled is true."<br/>  administrator_password = "(Optional) The Password associated with the administrator_login for the PostgreSQL Flexible Server. Required when create_mode is Default and authentication.password_auth_enabled is true."<br/>}) | <pre>object({<br/>    administrator_login    = string<br/>    administrator_password = string<br/>  })</pre> | <pre>{<br/>  "administrator_login": null,<br/>  "administrator_password": null<br/>}</pre> | no |
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_auto_grow_enabled"></a> [auto_grow_enabled](#input_auto_grow_enabled) | (Optional) Is the storage auto grow for PostgreSQL Flexible Server enabled? Defaults to `false`. | `bool` | `false` | no |
| <a name="input_backup_retention_days"></a> [backup_retention_days](#input_backup_retention_days) | (Optional) The backup retention days for the PostgreSQL Flexible Server. Possible values are between 7 and 35 days. | `number` | `7` | no |
| <a name="input_cmk_geo_name"></a> [cmk_geo_name](#input_cmk_geo_name) | (optional) Customer managed key name to be used for geo redundancy (max 127 chars) | `string` | `null` | no |
| <a name="input_cmk_name"></a> [cmk_name](#input_cmk_name) | (optional) Customer managed key name to be used (max 127 chars) | `string` | `null` | no |
| <a name="input_cmk_rotation_policy"></a> [cmk_rotation_policy](#input_cmk_rotation_policy) | (Optional) A rotation policy block as defined below:<br/>object({<br/>  notify_before_expiry = "(Optional) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>  time_before_expiry   = "(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br/>  time_after_creation  = "(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br/>  expire_after         = "(Optional) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>}) | <pre>object({<br/>    notify_before_expiry = string<br/>    time_before_expiry   = string<br/>    time_after_creation  = optional(string, null)<br/>    expire_after         = string<br/>  })</pre> | <pre>{<br/>  "expire_after": "P365D",<br/>  "notify_before_expiry": "P358D",<br/>  "time_after_creation": null,<br/>  "time_before_expiry": "P7D"<br/>}</pre> | no |
| <a name="input_cmk_rotation_policy_geo"></a> [cmk_rotation_policy_geo](#input_cmk_rotation_policy_geo) | (Optional) A rotation policy block for geo redundancy as defined below:<br/>object({<br/>  notify_before_expiry = "(Optional) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>  time_before_expiry   = "(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br/>  time_after_creation  = "(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br/>  expire_after         = "(Optional) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>}) | <pre>object({<br/>    notify_before_expiry = string<br/>    time_before_expiry   = string<br/>    time_after_creation  = optional(string, null)<br/>    expire_after         = string<br/>  })</pre> | <pre>{<br/>  "expire_after": "P365D",<br/>  "notify_before_expiry": "P358D",<br/>  "time_after_creation": null,<br/>  "time_before_expiry": "P7D"<br/>}</pre> | no |
| <a name="input_configuration"></a> [configuration](#input_configuration) | (Optional) A configuration block supports the following:<br/>object({<br/>  name  = (Required) "Specifies the name of the PostgreSQL Configuration, which needs to be a valid PostgreSQL configuration name. PostgreSQL provides the ability to extend the functionality using azure extensions, with PostgreSQL azure extensions you should specify the name value as azure.extensions and the value you wish to allow in the extensions list."<br/>  value = (Required) "Specifies the value of the PostgreSQL Configuration. Follow PostgreSQL documentation for valid values."<br/>}) | <pre>map(object({<br/>    name  = string<br/>    value = string<br/>  }))</pre> | <pre>{<br/>  "require_secure_transport": {<br/>    "name": "require_secure_transport",<br/>    "value": "on"<br/>  },<br/>  "ssl_min_protocol_version": {<br/>    "name": "ssl_min_protocol_version",<br/>    "value": "TLSv1.2"<br/>  }<br/>}</pre> | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_create_mode"></a> [create_mode](#input_create_mode) | (Optional) The creation mode which can be used to restore or replicate existing servers. Possible values are Default, GeoRestore, PointInTimeRestore, Replica and Update. Changing this forces a new PostgreSQL Flexible Server to be created. | `string` | `"Default"` | no |
| <a name="input_create_role_assignment"></a> [create_role_assignment](#input_create_role_assignment) | (Optional) Whether to create a role assignment to the service identity to allow access to the key vault keys. | `bool` | `true` | no |
| <a name="input_customer_managed_key"></a> [customer_managed_key](#input_customer_managed_key) | (Required) An customer_managed_key block as defined below:<br/>object({<br/>  key_vault_id                      = "(Required) The resource ID of the Key Vault where the Key Vault Key resides."<br/>  expiration_date                   = "(Required) Expiration UTC datetime (Y-m-d'T'H:M:S'Z')."<br/>  identity_principal_id             = "(Required) The principal ID of the User Assigned Identity that has access to the key."<br/>}) | <pre>object({<br/>    key_vault_id          = string<br/>    cmk_expiration_date   = string<br/>    identity_principal_id = string<br/>  })</pre> | n/a | yes |
| <a name="input_customer_managed_key_geo"></a> [customer_managed_key_geo](#input_customer_managed_key_geo) | (Optional) An customer_managed_key block for geo redundancy as defined below:<br/>object({<br/>  key_vault_id                      = "(Required) The resource ID of the Key Vault where the Key Vault Key resides."<br/>  expiration_date                   = "(Required) Expiration UTC datetime (Y-m-d'T'H:M:S'Z')."<br/>  identity_principal_id             = "(Required) The principal ID of the User Assigned Identity that has access to the key."<br/>}) | <pre>object({<br/>    key_vault_id          = string<br/>    cmk_expiration_date   = string<br/>    identity_principal_id = string<br/>  })</pre> | <pre>{<br/>  "cmk_expiration_date": null,<br/>  "identity_principal_id": null,<br/>  "key_vault_id": null<br/>}</pre> | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_geo_redundant_backup_enabled"></a> [geo_redundant_backup_enabled](#input_geo_redundant_backup_enabled) | (Optional) Is Geo-Redundant backup enabled on the PostgreSQL Flexible Server. Defaults to false. | `bool` | `false` | no |
| <a name="input_high_availability"></a> [high_availability](#input_high_availability) | (Optional) A high_availability block supports the following:<br/>object({<br/>  mode                      = "(Required) The high availability mode for the PostgreSQL Flexible Server. Possible value are SameZone or ZoneRedundant."<br/>  standby_availability_zone = "(Optional) Specifies the Availability Zone in which the standby Flexible Server should be located."<br/>}) | <pre>object({<br/>    mode                      = string<br/>    standby_availability_zone = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_identity"></a> [identity](#input_identity) | (Optional) An identity block supports the following:<br/>object({<br/>  type         = "(Required) Specifies the type of Managed Service Identity that should be configured on this PostgreSQL Flexible Server. The only possible value is UserAssigned."<br/>  identity_ids = "(Required) A list of User Assigned Managed Identity IDs to be assigned to this PostgreSQL Flexible Server. Required if used together with customer_managed_key block."<br/>}) | <pre>object({<br/>    type         = string<br/>    identity_ids = list(string)<br/>  })</pre> | <pre>{<br/>  "identity_ids": null,<br/>  "type": "UserAssigned"<br/>}</pre> | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_key_vault_tags"></a> [key_vault_tags](#input_key_vault_tags) | (Optional) Key Vault related tags to be set on key vault child resources. | `map(any)` | `{}` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_maintenance_window"></a> [maintenance_window](#input_maintenance_window) | (Optional) A maintenance_window block supports the following:<br/>object({<br/>  day_of_week  = "(Optional) The day of week for maintenance window, where the week starts on a Sunday, i.e. Sunday = 0, Monday = 1. Defaults to 0."<br/>  start_hour   = "(Optional) The start hour for maintenance window. Defaults to 0."<br/>  start_minute = "(Optional) The start minute for maintenance window. Defaults to 0."<br/>}) | <pre>object({<br/>    day_of_week  = number<br/>    start_hour   = number<br/>    start_minute = number<br/>  })</pre> | <pre>{<br/>  "day_of_week": 0,<br/>  "start_hour": 0,<br/>  "start_minute": 0<br/>}</pre> | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_paired_location"></a> [paired_location](#input_paired_location) | (Optional) Paired Location of the resource group. | `string` | `null` | no |
| <a name="input_password_auth_enabled"></a> [password_auth_enabled](#input_password_auth_enabled) | (Optional) Whether or not password authentication is allowed to access the PostgreSQL Flexible Server. | `bool` | `false` | no |
| <a name="input_point_in_time_restore_time_in_utc"></a> [point_in_time_restore_time_in_utc](#input_point_in_time_restore_time_in_utc) | (Optional) The point in time to restore from source_server_id when create_mode is GeoRestore, PointInTimeRestore. Changing this forces a new PostgreSQL Flexible Server to be created. | `string` | `null` | no |
| <a name="input_replica_promotion"></a> [replica_promotion](#input_replica_promotion) | (Optional) A replica promotion configuration block, to promote a read replica.<br/>object({<br/>  promote_mode   = "(Required) Specify the type of operation to apply on the read replica. Possible values are 'Standalone' or 'Switchover'."<br/>  promote_option = "(Required) Specify the data synchronization option when processing promotion. Possible values are 'Planned', 'Forced'."<br/>  role           = "(Optional) The replication role after promotion. Possible values are 'AsyncReplica', 'GeoAsyncReplica', 'None', 'Primary'. Defaults to 'None'."<br/>}) | <pre>object({<br/>    promote_mode   = string<br/>    promote_option = string<br/>    role           = optional(string, "None")<br/>  })</pre> | `null` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_server_version"></a> [server_version](#input_server_version) | (Optional) The version of PostgreSQL Flexible Server to use. Possible values are 11,12, 13, 14 and 15. Required when create_mode is Default. Changing this forces a new PostgreSQL Flexible Server to be created. When create_mode is Update, upgrading version wouldn't force a new resource to be created. | `string` | `"17"` | no |
| <a name="input_sku_name"></a> [sku_name](#input_sku_name) | (Optional) The SKU Name for the PostgreSQL Flexible Server. The name of the SKU, follows the tier + name pattern (e.g. B_Standard_B1ms, GP_Standard_D2s_v3, MO_Standard_E4s_v3) | `string` | `null` | no |
| <a name="input_source_server_id"></a> [source_server_id](#input_source_server_id) | (Optional) The resource ID of the source PostgreSQL Flexible Server to be restored. Required when create_mode is GeoRestore, PointInTimeRestore or Replica. Changing this forces a new PostgreSQL Flexible Server to be created. | `string` | `null` | no |
| <a name="input_source_server_location"></a> [source_server_location](#input_source_server_location) | (Optional) The location of the source PostgreSQL Flexible Server to be restored. Required when create_mode is PointInTimeRestore or Replica. Changing this forces a new PostgreSQL Flexible Server to be created. | `string` | `null` | no |
| <a name="input_storage_mb"></a> [storage_mb](#input_storage_mb) | (Optional) The max storage allowed for the PostgreSQL Flexible Server. Possible values are 32768, 65536, 131072, 262144, 524288, 1048576, 2097152, 4194304, 8388608, 16777216 and 33553408. | `number` | `null` | no |
| <a name="input_storage_tier"></a> [storage_tier](#input_storage_tier) | (Optional) The name of storage performance tier for IOPS of the PostgreSQL Flexible Server. Possible values are P4, P6, P10, P15, P20, P30, P40, P50, P60, P70 or P80. Default value is dependant on the storage_mb value. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_tenant_id"></a> [tenant_id](#input_tenant_id) | (Required) The Tenant ID of the Azure Active Directory which is used by the Active Directory authentication. | `string` | n/a | yes |
| <a name="input_vnet_integration"></a> [vnet_integration](#input_vnet_integration) | (Optional) The inputs required for Private access (VNet Integration)<br/>object({<br/>  delegated_subnet_id  = "(Optional) The ID of the virtual network subnet to create the PostgreSQL Flexible Server. The provided subnet should not have any other resource deployed in it and this subnet will be delegated to the PostgreSQL Flexible Server, if not already delegated. Changing this forces a new PostgreSQL Flexible Server to be created."<br/>  private_dns_zone_id  = "(Optional) The ID of the private DNS zone to create the PostgreSQL Flexible Server. Changing this forces a new PostgreSQL Flexible Server to be created. The azurerm_private_dns_zone should end with suffix .postgres.database.azure.com"<br/>}) | <pre>object({<br/>    delegated_subnet_id = optional(string)<br/>    private_dns_zone_id = optional(string)<br/>  })</pre> | <pre>{<br/>  "delegated_subnet_id": null,<br/>  "private_dns_zone_id": null<br/>}</pre> | no |
| <a name="input_zone"></a> [zone](#input_zone) | (Optional) Specifies the Availability Zone in which the PostgreSQL Flexible Server should be located. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_admin_id"></a> [admin_id](#output_admin_id) | The ID of the first PostgreSQL Flexible Server Active Directory Administrator. |
| <a name="output_configuration_id"></a> [configuration_id](#output_configuration_id) | The ID of the PostgreSQL Flexible Server Configuration |
| <a name="output_fqdn"></a> [fqdn](#output_fqdn) | The FQDN of the PostgreSQL Flexible Server |
| <a name="output_id"></a> [id](#output_id) | The ID of the PostgreSQL Flexible Server |
| <a name="output_name"></a> [name](#output_name) | The name of the PostgreSQL Flexible Server |
| <a name="output_public_network_access_enabled"></a> [public_network_access_enabled](#output_public_network_access_enabled) | Provide the status of public network access |
| <a name="output_resource"></a> [resource](#output_resource) | The Postgresql Flexible Server resource. |
<!-- END_TF_DOCS -->
