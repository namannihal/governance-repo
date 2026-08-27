---
version: 1.1.1
available_versions:
  - 1.1.1
  - 1.1.0
  - 1.0.4
  - 1.0.3
  - 1.0.2
---

<!-- BEGIN_TF_DOCS -->
# Redis Cache module

## Overview

This terraform module creates a redis cache and associated resources. Azure Cache for Redis provides an in-memory data store based on the Redis software. Redis improves the performance and scalability of an application that uses backend data stores heavily. Redis Cache able to process large volumes of application requests by keeping frequently accessed data in the server memory, which can be written to and read from quickly.

## Prerequisites

- `Resource Group` name is required.
- `Subnet ID` and `Managed Identity `is required.

## Guidance

#### Usage

- Azure Cache for Redis provides an in-memory data store based on the Redis software. Redis improves the performance and scalability of an application that uses backend data stores heavily.
- `Redis version 4` has been retired and no longer supports creating new instances. By default, it gets created with version 6.
- Downgrading the SKU will force a new resource to be created.
- The `maxmemory_reserved`, `maxmemory_delta`, and `maxfragmentationmemory_reserved` settings are exclusively available for Standard and Premium caches. These settings have predefined limits depending on the cache tier. For example, the `maxmemory_reserved` and `maxfragmentationmemory_reserved` values are set to 642 for Premium P1 caches, 1330 for Premium P2 caches, and so on.
- The above line causes `terraform plan` to show changes every time it is executed because the SKU configuration varies.

```
redis_configuration {
          ~ maxfragmentationmemory_reserved         = 1330 -> 10
          ~ maxmemory_delta                         = 1330 -> 2
          ~ maxmemory_reserved                      = 1330 -> 10
        }
Plan: 0 to add, 1 to change, 0 to destroy.
```

- Configuring the number of `replicas per master` and `replicas per primary` is only available when using the `Premium SKU` and cannot be used in conjunction with shards.
- If both `replicas_per_primary` and `replicas_per_master` are set, they need to be equal.

##### AzureRM 3.x to 4.x Upgrade Notes for Redis Cache

Product Impact -- Medium

Users in azurerm 3.x migrating to 4.x  need to perform the following changes
  - The deprecated `enable_non_ssl_port` property has been removed in favour of the `non_ssl_port_enabled` property.
  - The deprecated `redis_configuration.enable_authentication` property has been removed in favour of the `redis_configuration.authentication_enabled` property.
  - The `redis_configuraton.data_persistence_authentication_method` property no longer defaults to SAS.
  - The `family` property is now case-sensitive. You will need to update your configuration to match the casing expected by the API.
  - The `redis_version` property now defaults to 6.

  - Wiki link for [AzureRM 4.x Upgrade](https://gitlab.dx1.lseg.com/groups/app/app-51310/azure/prdsvc/terraform/-/wikis/Terraform-AzureRM-Provider-Upgrade:-Version-3.x-to-4.x/rediscache) for details on the upgrade process.

For more details, refer to the official [AzureRM 4.x Upgrade Guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide)

#### Security Considerations

- `enable_authentication` can only be set to false if a `subnet_id` is specified; and only works if there aren't existing instances within the subnet with enable_authentication set to true.
- There are some limitations and points to note before securing the Redis Cache with a Virtual Network which is only possible with `Premium` SKU. Please go through the link for the same: [Limitations of VNet injection](https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/cache-how-to-premium-vnet).

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-MCR-IA_010 | Cache for Redis access keys must be protected from unauthorised access |  An application or service using the Cache for Redis access key to authenticate to cache data must protect the key (what) by having the key persisted in a Key vault as opposed to an application file (how) to prevent malicious data access and exfiltration | False | False |  As per the security control document, `Control implemented by technical configuration setting:False`. This control will be implemented via LSEG Policy. |
| 2. | AZU-MCR-IA_020 | Cache for Redis must use a Managed Identity for accessing Azure Resources | CCache for Redis must enforce the use of a Managed Identity to authenticate to Azure resources where this is supported (What) within target service access control settings (How) in order to remove the need to store credentials (Why) | False | False | As per the security control document, `Control implemented by technical configuration setting:False`. This control will be implemented via LSEG Policy. |
| 3. | AZU-MCR-IA_030 | Cache For Redis must have local authentication methods disabled | Cache For Redis must have local authentication methods disabled (What) within Authentication settings (How) in order to use modern robust and less prone to compromise authentication methods embedded within Entra ID (Why) | False | False |As per the security control document, `Control implemented by technical configuration setting:False`. This control will be implemented via LSEG Policy. |
| 4. | AZU-MCR-AC_010 | Disable Public Network Access| Cache for Redis must enforce a network guardrail if processing data with internal and above data classification (What) via Private endpoint settings (How) in order to prevent unauthorised access and data exposure to the internet (Why) | False | False | Implemented using `public_network_access_enabled = false` |
| 5. | AZU-MCR-AU_010 | Send all security and audit diagnostic log categories to a central Log Analytics workspace |  Cache for Redis must send all security and audit diagnostic logs to a central Log Analytics workspace (What) via Diagnostic settings (How) in order to support a security investigation after a security incident (Why) | False | False | Diagnostics settings will be enabled using a separate module at bundle/pattern level |
| 6. | AZU-MCR-AU_030 | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval (What) within Diagnostic settings (How) in order to prevent sensitive data leakage to third parties outside of LSEG control (Why) | False | False | Diagnostics settings will be enabled using a separate module at bundle/pattern level |
| 7. | AZU-MCR-SC_020 | Use a minimum of TLS version 1.2 for network connections to Cache for Redis control and data planes | Cache for Redis must enforce a minimum TLS version of 1.2 (What) via Advanced settings (How) in order to use modern techniques to establish robust encrypted data channels over untrusted networks (Why) | True | True |  Implemented using `minimum_tls_version = "1.2"` |
| 8. | AZU-MCR-SC_030 | Network connections to Cache for Redis control and data planes must use TLS encryption | Cache for Redis must enforce network flow encryption in transit using TLS (What) in Advanced settings (How) in order to use techniques to establish an encrypted data channels over untrusted networks (Why) | True | False | Terraform does not have any specific property to only allow TLS Encryption only. TLS 1.2 should be used, to maintain all the communications secure and encrypted in transit which is implemented using `minimum_tls_version = "1.2"` which will be validated in security control `AZU-MCR-SC_020` |
| 8. | AZU-MCR-SC_050 | Azure App Deployment must not be able to corrupt the centrally managed private link private DNS zones when making a private end point for Cache for Redis | Cache for Redis must have an Azure DeployIfNotExists policy to update the centrally managed private link private DNS zones with its private A record (What) via Policy to management group mapping (How) to ensure there is no ability for the Azure App Deployment team to have authorisation over these zones that could allow them to corrupt this file and impact service availability (Why) | False | False | This control will be implemented via policy. |

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Monitor Azure Cache for Redis](https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/cache-how-to-monitor)<br><br>[Cloud monitoring service level objectives ](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives)<br><br>[Supported Metrics for Azure Cache for Redis](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-cache-redis-metrics) |
| 5.| [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | True | This control will be implemented by following parameters: `Zones` property specifies list of availability zones, `replicas_per_master` property for enabling the amount of replicas to create per master redis cache, `replicas_per_primary` amount of replicas to create per primary for redis cache.<br><br>[Enable zone redundancy for Azure Cache for Redis](https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/cache-how-to-zone-redundancy)<br><br>[Configure passive geo-replication for Premium Azure Cache for Redis instances](https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/cache-how-to-geo-replication)<br><br>[Configure active geo-replication for Enterprise Azure Cache for Redis instances](https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/cache-how-to-active-geo-replication)<br><br>[Configure Azure Cache for Redis for high availability](https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/cache-high-availability)<br><br>[Failover and patching for Azure Cache for Redis](https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/cache-failover) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place.<br><br>[Azure built-in roles](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles)<br><br>[Configure role-based access control with Azure Cache for Redis Data Access Policy](https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/cache-configure-role-based-access-control) |

## Changelog

- [azure-prdsvc-terraform-rediscache](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/cache-overview)

### Terraform Docs

- [azurerm_redis_cache](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_cache)

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
| [azurerm_redis_cache.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_cache) | resource |
| [azurerm_redis_cache_access_policy_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_cache_access_policy_assignment) | resource |
| [azurerm_redis_firewall_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_firewall_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_keys_authentication_enabled"></a> [access_keys_authentication_enabled](#input_access_keys_authentication_enabled) | (Optional) Whether access key authentication is enabled. Must be set to false when active_directory_authentication_enabled is true. Defaults to false to comply with AZU-MCR-IA_030 security control. | `bool` | `false` | no |
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_capacity"></a> [capacity](#input_capacity) | (Required) The size of the Redis cache to deploy. Valid values for a `C` SKU family (`Basic` or `Standard`) are `0`, `1`, `2`, `3`, `4`, `5`, `6`. For `P` SKU family (`Premium`) valid values are `1`, `2`, `3`, `4`,`5`. | `number` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_disable_access_key_authentication"></a> [disable_access_key_authentication](#input_disable_access_key_authentication) | (Deprecated) Use access_keys_authentication_enabled instead. Specifies whether access key authentication should be disabled. | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_firewall_rules"></a> [firewall_rules](#input_firewall_rules) | "(Optional) List of Azure Redis Cache firewall rule specification."<br/>object({<br/>  name              = (Required) Specifies the name of the Firewall Rule.<br/>  start_ip_address  = (Required) The starting IP Address to allow through the firewall for this rule<br/>  end_ip_address    = (Required) The ending IP Address to allow through the firewall for this rule<br/>}) | <pre>list(object({<br/>    name             = string<br/>    start_ip_address = string<br/>    end_ip_address   = string<br/>  }))</pre> | `[]` | no |
| <a name="input_identity"></a> [identity](#input_identity) | (Required) An identity block as defined below<br/>object({<br/>  type         = "(Required) Specifies the type of Managed Service Identity that should be configured on this Redis Cluster. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both)."<br/>  identity_ids = "(Optional) A list of User Assigned Managed Identity IDs to be assigned to this Redis Cluster."<br/>}) | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(set(string))<br/>  })</pre> | <pre>{<br/>  "identity_ids": null,<br/>  "type": "SystemAssigned"<br/>}</pre> | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_non_ssl_port_enabled"></a> [non_ssl_port_enabled](#input_non_ssl_port_enabled) | (Optional) Enable the non-SSL port (6379) - secure Redis instances will only accept SSL connections on port 6380. Defaults to false for security. | `bool` | `false` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_patch_schedule"></a> [patch_schedule](#input_patch_schedule) | "(Optional) The scheduled maintenance for Azure Cache for Redis service to regularly updates the cache with the latest platform features and fixes."<br/>object({<br/>  day_of_week    = (Required) the Weekday name - possible values include Monday, Tuesday, Wednesday etc.<br/>  start_hour_utc = (Optional) the Start Hour for maintenance in UTC - possible values range from 0 - 23.<br/>}) | <pre>object({<br/>    day_of_week    = string<br/>    start_hour_utc = optional(number, 5)<br/>  })</pre> | n/a | yes |
| <a name="input_policy_assignments"></a> [policy_assignments](#input_policy_assignments) | "(Optional) Map of access policy assignments for the Redis Cache. This is only applicable if AAD authentication is enabled."<br/>object({<br/>  name                = (Required) The name of the Redis Cache Access Policy Assignment. Changing this forces a new Redis Cache Access Policy Assignment to be created.<br/>  access_policy_name  = (Required) The name of the Access Policy to be assigned. Changing this forces a new Redis Cache Access Policy Assignment to be created.<br/>  object_id           = (Required) The principal ID to be assigned the Access Policy. Changing this forces a new Redis Cache Access Policy Assignment to be created.<br/>  object_id_alias     = (Required) The alias of the principal ID. User-friendly name for object ID. Also represents username for token based authentication. Changing this forces a new Redis Cache Access Policy Assignment to be created.<br/>}) | <pre>map(object({<br/>    name               = string<br/>    access_policy_name = string<br/>    object_id          = string<br/>    object_id_alias    = string<br/>  }))</pre> | `{}` | no |
| <a name="input_private_static_ip_address"></a> [private_static_ip_address](#input_private_static_ip_address) | (Optional) The Static IP Address to assign to the Redis Cache when hosted inside the Virtual Network. This argument implies the use of `subnet_id`. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_redis_configuration"></a> [redis_configuration](#input_redis_configuration) | "(Optional) Amount of replicas to create per master for this Redis Cache."<br/>object({<br/>  aof_backup_enabled                      = (Optional) Enable or disable AOF persistence for this Redis Cache. Defaults to false.<br/>  aof_storage_connection_string_0         = (Optional) First Storage Account connection string for AOF persistence.<br/>  aof_storage_connection_string_1         = (Optional) Second Storage Account connection string for AOF persistence.<br/>  authentication_enabled                   = (Optional) If set to false, the Redis instance will be accessible without authentication. Defaults to true.<br/>  active_directory_authentication_enabled = (Optional) Enable Microsoft Entra (AAD) authentication. Defaults to true.<br/>  maxmemory_reserved                      = (Optional) Value in megabytes reserved for non-cache usage e.g. failover. Defaults are shown below.<br/>  maxmemory_delta                         = (Optional) The max-memory delta for this Redis instance. Defaults are shown below.<br/>  maxfragmentationmemory_reserved         = (Optional) Value in megabytes reserved to accommodate for memory fragmentation. Defaults are shown below.<br/>  maxmemory_policy                        = (Optional) How Redis will select what to remove when maxmemory is reached. Defaults are shown below. Defaults to volatile-lru.<br/>  rdb_backup_enabled                      = (Optional) Is Backup Enabled? Only supported on Premium SKUs. Defaults to false.<br/>  rdb_backup_frequency                    = (Optional) The Backup Frequency in Minutes. Only supported on Premium SKUs. Possible values are: 15, 30, 60, 360, 720 and 1440.<br/>  rdb_backup_max_snapshot_count           = (Optional) The maximum number of snapshots to create as a backup. Only supported for Premium SKUs.<br/>  rdb_storage_connection_string           = (Optional) The Connection String to the Storage Account. Only supported for Premium SKUs. <br/>  data_persistence_authentication_method = (Optional) The authentication method for data persistence. Defaults to SAS.<br/>}) | <pre>object({<br/>    aof_backup_enabled                      = optional(bool, false)<br/>    aof_storage_connection_string_0         = optional(string, null)<br/>    aof_storage_connection_string_1         = optional(string, null)<br/>    authentication_enabled                  = optional(bool, true)<br/>    active_directory_authentication_enabled = optional(bool, true)<br/>    maxmemory_reserved                      = optional(number, null)<br/>    maxmemory_delta                         = optional(number, null)<br/>    maxfragmentationmemory_reserved         = optional(number, null)<br/>    maxmemory_policy                        = optional(string, null)<br/>    rdb_backup_enabled                      = optional(bool, false)<br/>    rdb_backup_frequency                    = optional(number)<br/>    rdb_backup_max_snapshot_count           = optional(number, null)<br/>    rdb_storage_connection_string           = optional(number, null)<br/>    data_persistence_authentication_method  = optional(string, "SAS")<br/>  })</pre> | <pre>{<br/>  "active_directory_authentication_enabled": true,<br/>  "aof_backup_enabled": false,<br/>  "aof_storage_connection_string_0": null,<br/>  "aof_storage_connection_string_1": null,<br/>  "authentication_enabled": true,<br/>  "data_persistence_authentication_method": "SAS",<br/>  "maxfragmentationmemory_reserved": null,<br/>  "maxmemory_delta": null,<br/>  "maxmemory_policy": null,<br/>  "maxmemory_reserved": null,<br/>  "rdb_backup_enabled": false,<br/>  "rdb_backup_frequency": null,<br/>  "rdb_backup_max_snapshot_count": null,<br/>  "rdb_storage_connection_string": null<br/>}</pre> | no |
| <a name="input_redis_version"></a> [redis_version](#input_redis_version) | (Optional) The version of Redis to use. Defaults to the latest version supported by Azure Cache for Redis. | `string` | `"6"` | no |
| <a name="input_replicas_per_master"></a> [replicas_per_master](#input_replicas_per_master) | (Optional) Amount of replicas to create per master for this Redis Cache. | `number` | `null` | no |
| <a name="input_replicas_per_primary"></a> [replicas_per_primary](#input_replicas_per_primary) | (Optional) Amount of replicas to create per primary for this Redis Cache. If both replicas_per_primary and replicas_per_master are set, they need to be equal. | `number` | `null` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_shard_count"></a> [shard_count](#input_shard_count) | (Optional) Only available when using the Premium SKU The number of Shards to create on the Redis Cluster. | `number` | `null` | no |
| <a name="input_sku"></a> [sku](#input_sku) | (Required) The SKU of Redis Cache. Possible values are `Basic`, `Standard` or `Premium`. | `string` | `"Standard"` | no |
| <a name="input_subnet_id"></a> [subnet_id](#input_subnet_id) | (Optional) Only available when using the Premium SKU The ID of the Subnet within which the Redis Cache should be deployed. This Subnet must only contain Azure Cache for Redis instances without any other type of resources. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_zones"></a> [zones](#input_zones) | (Optional) Specifies a list of Availability Zones in which this Redis Cache should be located. Changing this forces a new Redis Cache to be created. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The Resource ID of the Azure Cache for Redis. |
| <a name="output_name"></a> [name](#output_name) | The name of Azure Redis Cache. |
| <a name="output_resource"></a> [resource](#output_resource) | The Redis Cache resource. |
<!-- END_TF_DOCS -->
