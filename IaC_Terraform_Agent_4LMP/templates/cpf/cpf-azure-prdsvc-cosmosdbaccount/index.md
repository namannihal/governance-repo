---
version: 1.2.4
available_versions:
  - 1.2.4
  - 1.2.3
  - 1.2.2
  - 1.2.1
  - 1.1.1
---

<!-- BEGIN_TF_DOCS -->
# Cosmos DB Account module

## Overview

This terraform module creates a Cosmos DB Account and associated resources.

## Prerequisites

A `resource group` and `versionless Key Vault Key ID` for CMK encryption has been created.

## Guidance

#### Usage

AzureRM 4.x Upgrade Notes for Storage Account

Impact analysis -- Medium

Users in azurerm 3.x migrating to 4.x  need to perform the following changes
  Introduced new Optional Variables
- `enable_automatic_failover` ➝ `automatic_failover_enabled`
- `enable_free_tier` ➝ `free_tier_enabled`
- `enable_multiple_write_locations` ➝ `multiple_write_locations_enabled`

`ip_range_filter` variable type changed from `string` to `set(string)`.

Wiki link for [AzureRM 4.x Upgrade](https://gitlab.dx1.lseg.com/groups/app/app-51310/azure/prdsvc/terraform/-/wikis/Terraform-AzureRM-Provider-Upgrade:-Version-3.x-to-4.x/Cosmos-DB) for details on the upgrade process.

For more details, refer to the official [AzureRM 4.x Upgrade Guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide)

- This module deploys the CosmosDB Account which will be associated with NoSQL Database, Mongo DB, other DB API's. They will be deployed through separate module.
- In this module, skipping tfsec due to `Panic not a string error` because it's blocking to pass key and expiration variable in code.
- When multiple geo-locations are needed, please ensure the arguments `max_interval_in_seconds` set to more than 5 minutes and `max_staleness_prefix` set to more than 100000.
- Customer Managed key and Continuous backup mode can only be enabled together with a valid `User Assigned`, `System Assigned Managed Identity` or `System Assigned, UserAssigned`.
- Use `key_vault_tags` variable to define additional Key Vault Key/Secret related tags in your product. Note that azure policies are enforcing a number N of tags for all products by default. Also note that Key Vault child resources support only 15 tags as the maximum limit. Therefore, please ensure the total count of tags enforced by policy and tags applied via variable does not exceed the limit. For example, if 10 tags are enforced via Azure policy, a maximum of 5 tags can be set via the `key_vault_tags` variable. Reference link - [Key tags](https://learn.microsoft.com/en-us/azure/key-vault/keys/about-keys-details#key-tags).
- Use the `tags` variable to define additional tags related to the product (core). Note that azure policies are enforcing a number N of tags for all products by default and that additional 3 tags are set on the main product via main terraform template.
If you are assigning additional tags (key-value pairs) via the `tags` variable, please ensure the total count does not exceed the limit supported by Azure resources. Reference link - [Azure Resources Tag Limitation](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/tag-support)

#### Well-Architected Framework(WAF) for Azure Cosmos DB Account

- Wiki link: [WAF for Azure Cosmos DB Account](https://gitlab.dx1.lseg.com/groups/app/app-51310/azure/prdsvc/terraform/-/wikis/Cloud-Products-Well-Architecture-Framework-Principles---WAF/Cosmosdb) for details on the WAF principles (Resiliency and Disaster Recovery(DR), Security, Cost Optimization and Operation Excellence).

#### Security Considerations

- CosmosDB Account evolves around multiple DB API's. To align with the security controls section, the listed parameters in tabular column varies over other and thus requires change in their default values before creation of the respective database.

| CosmosDB Account for API's | Kind | Local Authentication | Public Network Access | Allow IP's for FW rules  |
|----------------------------|------|----------------------|-----------------------|--------------------------|
| NoSQL Database | GlobalDocumentDB | Disabled by default | Disabled by default | NA |
| Mongo Database | MongoDB | Enable to support Mongo DB | Disabled by default | NA |

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-CDBNSQL-IA_010 | Cosmos DB NoSQL must have local authentication methods disabled | Cosmos DB NoSQL must have local authentication methods disabled (What) via deployment settings (How) in order to use modern robust and less prone to compromise authentication methods embedded within Entra ID (Why) | True | False | Implemented by the setting the value of `local_authentication_disabled` argument to `True`. |
| 2. | AZU-CDBNSQL-IA_020 | Use a Managed Identity for accessing Azure Resources | Cosmos DB NoSQL must enforce the use of a Managed Identity to authenticate to Azure resources where this is supported (What) within target service access control settings (How) in order to remove the need to store credentials (Why) | True | True | Implemented using identity {} block in azurerm_cosmosdb_account terraform resource. Default will be the System Assigned Identity but the provision for UserAssigned Identity is also provided keeping the support for System Assigned Identity in consideration for CMK encryption in the upcoming versions of azure\_rm terraform provider.  |
| 3. |  AZU-CDBNSQL-AC_010 | Disable Public Network Access | Cosmos DB NoSQL must enforce a network guardrail (What) within Networking settings (How) in order to prevent unauthorised access and data exposure to the internet (Why) | True | True | Implemented by the setting the value of `public_network_access_enabled` argument to `false`. |
| 4. | AZU-CDBNSQL-CP_010 | Cosmos DB NoSQL Backup and Restore policy should be reviewed against requirements and set accordingly | Cosmos DB NoSQL Backup and Restore policy should be reviewed against requirements and set accordingly (What) via Backup and Restore (How) to ensure retention meets the application, regulatory and disaster recovery requirements (Why) | False | False | This control would be implemented by LSEG Standard. |
| 5. | AZU-CDBNSQL-SC_010 | Must use a dedicated CMK for Cosmos NoSQL Transparent Data Encryption that is persisted in an HSM backed Key Vault | Use a dedicated Cosmos NoSQL LSEG managed encryption at rest key persisted in an HSM backed Key Vault (What) via deployment settings (How) in order should Microsoft's key management platform become compromised LSEG can revoke access to exfiltrated encrypted data (Why) | True | True | This control is implemented by using `key_vault_key_id = azurerm_key_vault_key.this.versionless_id` |
| 6. | AZU-CDBNSQL-SC_020 | Use a minimum of TLS version 1.2 for network connections to Cosmos DB NoSQL control and data planes | Cosmos DB NoSQL must enforce a minimum TLS version of 1.2 (What) via Networking connectivity (How) in order to use modern techniques to establish robust encrypted data channels over untrusted networks (Why) | True | True | This control is implemented by hard coding the parameter `minimal_tls_version` to use TLS version to `1.2` in resource type `azurerm_cosmosdb_account`. |
| 7. | AZU-EH-CDBNSQL_030 | Cosmos DB NoSQL must not be able to corrupt the centrally managed private link private DNS zones when making a private endpoint for Event Hubs | Cosmos DB NoSQL must have an Azure DeployIfNotExists policy to update the centrally managed private link private DNS zones with its private A record (What) via policy to management group mapping (How) to ensure there is no ability for the Azure App Deployment team to have authorisation over these zones that could allow them to corrupt this file and impact service availability (Why) | False | False | This control would be implemented by LSEG Standard. |
| 8. | AZU-CDBNSQL-SC_040 | Cosmos DB NoSQL must have a data classification tag | Cosmos DB NoSQL must have a data classification tag (What) via Tags settings (How) in order to differentiate assets technical control requirements and to assist Security Operations in prioritising possible data breach mitigation responses (Why) | True | False | This cloud product has a provision to input the list of tags based on user input using variable tags, adding any mandantory tags can be taken care during the provisioning of resource. |
| 9. | AZU-CDBNSQL-SC_050 | Cosmos DB NoSQL must not use a Dedicated Gateway cache for Highly Restricted or Restricted data | Cosmos DB NoSQL must not use a Dedicated Gateway cache for Highly Restricted or Restricted data and instead must use Cache for Redis (What) via external cache, Cache instance (How) in order to protect any sensitive cache data by using a more robust clearlisted service such as Azure Cache for Redis (Why) | True | False | Removed the resource type 'azurerm_cosmosdb_sql_dedicated_gateway' from Cosmos DB Account. |
| 10. | AZU-CDBNSQL-SC_060 | Cosmos DB NoSQL should not enable CORS |  Cosmos DB NoSQL should not enable CORS (What) via CORS settings (How) as badly configured CORS could lead to the exposure of access credentials and data to the internet (Why) | False | False | This control would be implemented by LSEG Standard. |
| 11. | AZU-CDBNSQL-SC_070 | Cosmos DB NoSQL should not enable Diagnostics full-text query in Production environments | Cosmos DB NoSQL should not enable Diagnostics full-text query in Production environments (What) via Diagnostics settings (How) to ensure sensative data is not exposed into the less secure logging environment (Why) | False | False | This control would be implemented by LSEG Standard. |
| 12. | AZU-CDBNSQL-PT_010 | Cosmos DB NoSQL must only replicate data to LSEG approved geographical regions | Cosmos DB NoSQL must only replicate data to LSEG approved geographical regions (What) within Replicate data globally (How) in order to adhere to country specific data residency laws (Why) | False | False | This control would be implemented by LSEG Standard. |
| 13. | AZU-CDBMV-AU_010 | Send all diagnostic log categories to a central SOC Log Analytics workspace | Cosmos DB MongoDB VCore must send all diagnostic logs to a central SOC Log Analytics workspace (What) within Diagnostic settings (How) in order to support a security investigation after a security incident (Why) | False | False | This control will be implemented via policy. |
| 14. | AZU-CDBMV-AU_020 |  Send all diagnostic log categories to a central SOC Storage Account | Cosmos DB MongoDB VCore must send all diagnostic logs to a central SOC Storage Account (What) within Diagnostic settings (How) In order to provide an immutable copy to adhere to compliance requirements (Why) | False | False | This control will be implemented via policy. |
| 15. | AZU-CDBMV-AU_030 | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval (What) within Diagnostic settings (How) in order to prevent sensitive data leakage to third parties outside of LSEG control (Why) | False | False | This control will be implemented via policy. |
| 16. | AZU-CDBMV-SC_030 | Cosmos DB MongoDB vCore consumers must persist the connection strings as a secret in a Key Vault |  Cosmos DB MongoDB vCore consumers must persist the connection strings as a secret in a Key Vault (What) as part of consuming service configuration (How) in order to ensure the security of credentials (Why) | False | False | Control implemented by technical configuration setting is false. |
| 17. | AZU-CDBMV-SC_040 | Use a minimum of TLS version 1.2 for network connections to Cosmos DB MongoDB vCore control and data planes | Cosmos DB MongoDB vCore must enforce a minimum TLS version of 1.2 (What) via MongoDB rest API (How) in order to use modern techniques to establish robust encrypted data channels over untrusted networks | True | True | This control is implemented by hard coding the parameter `minimal_tls_version` to use TLS version to `1.2` in resource type `azurerm_cosmosdb_account`. |
| 18. | AZU-CDBMV-SI_010 | Cosmos DB MongoDB vCore versions must be kept to within n-2 versions | Cosmos DB MongoDB vCore versions must be kept to within n-2 versions (What) via MongoDB rest API (How) in order to keep up to date with vulnerability remediations (Why) | False | False | Control implemented by technical configuration setting is false. |

## Changelog

- [azure-prdsvc-terraform-cosmosdbaccount](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/cosmos-db/how-to-manage-database-account)

### Terraform Docs

- [azurerm_cosmosdb_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_account)

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
| [azurerm_cosmosdb_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_account) | resource |
| [azurerm_key_vault_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_backup"></a> [backup](#input_backup) | (Optional)<br/>object({<br/>  type                =  (Required) The type of the backup. Possible values are Continuous and Periodic. Migration of Periodic to Continuous is one-way, changing Continuous to Periodic forces a new resource to be created.<br/>  tier                =  (Optional) The continuous backup tier. Possible values are Continuous7Days and Continuous30Days.<br/>  interval_in_minutes =  (Optional) The interval in minutes between two backups. This is configurable only when type is Periodic. Possible values are between 60 and 1440.<br/>  retention_in_hours  =  (Optional) The time in hours that each backup is retained. This is configurable only when type is Periodic. Possible values are between 8 and 720.<br/>  storage_redundancy  =  (Optional) The storage redundancy is used to indicate the type of backup residency. This is configurable only when type is Periodic. Possible values are Geo, Local and Zone.<br/>}) | <pre>object({<br/>    type                = string<br/>    tier                = optional(string)<br/>    interval_in_minutes = optional(number)<br/>    retention_in_hours  = optional(number)<br/>    storage_redundancy  = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_capabilities"></a> [capabilities](#input_capabilities) | (Optional) Configures the capabilities to be enabled for this Cosmos DB account<br/>map(object({<br/>  name = (Required) The capability to enable - Possible values are AllowSelfServeUpgradeToMongo36, DisableRateLimitingResponses, EnableAggregationPipeline, EnableCassandra, EnableGremlin, EnableMongo, EnableMongo16MBDocumentSupport, EnableMongoRetryableWrites, EnableMongoRoleBasedAccessControl, EnablePartialUniqueIndex, EnableServerless, EnableTable, EnableTtlOnCustomPath, EnableUniqueCompoundNestedDocs, MongoDBv3.4 and mongoEnableDocLevelTTL.<br/>})) | <pre>map(object({<br/>    name = string<br/>  }))</pre> | `null` | no |
| <a name="input_cmk_key_name"></a> [cmk_key_name](#input_cmk_key_name) | (optional) Key name to be used (max 127 chars) | `string` | `null` | no |
| <a name="input_combined_policy"></a> [combined_policy](#input_combined_policy) | (Optional)<br/>object({<br/>  free_tier_enabled                     = (Required) Enable the Free Tier pricing option for this Cosmos DB account. Defaults to false. Changing this forces a new resource to be created.<br/>  analytical_storage_enabled            = (Optional) Enable Analytical Storage option for this Cosmos DB account. Defaults to false. Enabling and then disabling analytical storage forces a new resource to be created.<br/>  automatic_failover_enabled             = (Required) Enable automatic failover for this Cosmos DB account.<br/>  is_virtual_network_filter_enabled     = (Optional) Enables virtual network filtering for this Cosmos DB account.<br/>  multiple_write_locations_enabled       = (Required) Enable multiple write locations for this Cosmos DB account.<br/>  access_key_metadata_writes_enabled    = (Optional) Is write operations on metadata resources (databases, containers, throughput) via account keys enabled? Defaults to true.<br/>  mongo_server_version                  = (Optional) The Server Version of a MongoDB account. Possible values are 4.2, 4.0, 3.6, and 3.2.<br/>  network_acl_bypass_for_azure_services = (Optional) If Azure services can bypass ACLs. Defaults to false.  <br/>  network_acl_bypass_ids                = (Optional) The list of resource Ids for Network Acl Bypass for this Cosmos DB account.<br/>}) | <pre>object({<br/>    free_tier_enabled                     = bool<br/>    analytical_storage_enabled            = bool<br/>    automatic_failover_enabled            = bool<br/>    is_virtual_network_filter_enabled     = bool<br/>    multiple_write_locations_enabled      = bool<br/>    access_key_metadata_writes_enabled    = bool<br/>    mongo_server_version                  = string<br/>    network_acl_bypass_for_azure_services = bool<br/>    network_acl_bypass_ids                = list(string)<br/>  })</pre> | <pre>{<br/>  "access_key_metadata_writes_enabled": true,<br/>  "analytical_storage_enabled": false,<br/>  "automatic_failover_enabled": null,<br/>  "free_tier_enabled": false,<br/>  "is_virtual_network_filter_enabled": null,<br/>  "mongo_server_version": null,<br/>  "multiple_write_locations_enabled": null,<br/>  "network_acl_bypass_for_azure_services": false,<br/>  "network_acl_bypass_ids": null<br/>}</pre> | no |
| <a name="input_consistency_policy"></a> [consistency_policy](#input_consistency_policy) | (Required) used to define the consistency policy for this CosmosDB account<br/>object({<br/>  consistency_level       =  (Required) The Consistency Level to use for this CosmosDB Account - can be either BoundedStaleness, Eventual, Session, Strong or ConsistentPrefix.<br/>  max_interval_in_seconds =  (Optional) When used with the Bounded Staleness consistency level, this value represents the time amount of staleness (in seconds) tolerated. The accepted range for this value is 5 - 86400 (1 day). Defaults to 5. Required when consistency_level is set to BoundedStaleness.<br/>  max_staleness_prefix    =  (Optional) When used with the Bounded Staleness consistency level, this value represents the number of stale requests tolerated. The accepted range for this value is 10 – 2147483647. Defaults to 100. Required when consistency_level is set to BoundedStaleness.<br/>}) | <pre>object({<br/>    consistency_level       = string<br/>    max_interval_in_seconds = optional(number, 5)<br/>    max_staleness_prefix    = optional(number, 100)<br/>  })</pre> | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_cors_rule"></a> [cors_rule](#input_cors_rule) | (Optional)<br/>object({<br/>  allowed_headers  = (Required) A list of headers that are allowed to be a part of the cross-origin request.<br/>  allowed_methods  = (Required) A list of HTTP headers that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.<br/>  allowed_origins  = (Required) A list of origin domains that will be allowed by CORS.<br/>  exposed_headers  = (Required) A list of response headers that are exposed to CORS clients.<br/>  max_age_in_seconds = (Optional) The number of seconds the client should cache a preflight response. Possible values are between 1 and 2147483647.<br/>}) | <pre>object({<br/>    allowed_headers    = list(string)<br/>    allowed_methods    = list(string)<br/>    allowed_origins    = list(string)<br/>    exposed_headers    = list(string)<br/>    max_age_in_seconds = optional(number)<br/>  })</pre> | `null` | no |
| <a name="input_create_mode"></a> [create_mode](#input_create_mode) | (Optional) The creation mode for the CosmosDB Account. Possible values are Default and Restore. Changing this forces a new resource to be created. Create_mode only works when backup.type is Continuous. | `string` | `null` | no |
| <a name="input_create_role_assignment"></a> [create_role_assignment](#input_create_role_assignment) | (Optional) Whether to create a role assignment to the service identity to allow access to the key vault keys. | `bool` | `true` | no |
| <a name="input_customer_managed_key"></a> [customer_managed_key](#input_customer_managed_key) | (Required) An customer_managed_key block as defined below<br/>object({<br/>  key_vault_id                      = "(Required) The resource ID of the Key Vault where the Key Vault Key resides."<br/>  expiration_date                   = "(Required) Expiration UTC datetime (Y-m-d'T'H:M:S'Z')."<br/>  identity_principal_id             = "(Required) The principal ID of the User Assigned Identity that has access to the key."<br/>}) | <pre>object({<br/>    key_vault_id          = string<br/>    expiration_date       = string<br/>    identity_principal_id = string<br/>  })</pre> | n/a | yes |
| <a name="input_default_identity_type"></a> [default_identity_type](#input_default_identity_type) | (Optional) The default identity for accessing Key Vault. Possible values are FirstPartyIdentity, SystemAssignedIdentity or UserAssignedIdentity. Defaults to FirstPartyIdentity. When default_identity_type is a UserAssignedIdentity it must include the User Assigned Identity ID in the following format: UserAssignedIdentity=/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{userAssignedIdentityName}. | `string` | `"FirstPartyIdentity"` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_geo_location"></a> [geo_location](#input_geo_location) | (Required)  used to define where data should be replicated with the failover_priority<br/>map(object({<br/>  location          =  (Required) The name of the Azure region to host replicated data.<br/>  failover_priority =  (Required) The failover priority of the region. A failover priority of 0 indicates a write region. The maximum value for a failover priority = (total number of regions - 1). Failover priority values must be unique for each of the regions in which the database account exists. Changing this causes the location to be re-provisioned and cannot be changed for the location with failover priority 0.<br/>  zone_redundant    =  (Optional) Should zone redundancy be enabled for this region? Defaults to false.<br/>})) | <pre>map(object({<br/>    location          = string<br/>    failover_priority = number<br/>    zone_redundant    = optional(bool, false)<br/>  }))</pre> | n/a | yes |
| <a name="input_identity"></a> [identity](#input_identity) | (Required)<br/>object({<br/>  type = (Required) The Type of Managed Identity assigned to this Cosmos account. Possible values are SystemAssigned, UserAssigned and SystemAssigned, UserAssigned.<br/>  identity_ids = (Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Cosmos Account.<br/>}) | <pre>object({<br/>    type         = string<br/>    identity_ids = list(string)<br/>  })</pre> | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_ip_range_filter"></a> [ip_range_filter](#input_ip_range_filter) | (Optional) CosmosDB Firewall Support: This value specifies the set of IP addresses or IP address ranges in CIDR form to be included as the allowed list of client IPs for a given database account. | `set(string)` | `[]` | no |
| <a name="input_key_vault_tags"></a> [key_vault_tags](#input_key_vault_tags) | (Optional) Key Vault related tags to be set on key vault child resources. | `map(any)` | `{}` | no |
| <a name="input_kind"></a> [kind](#input_kind) | (Required) Specifies the Kind of CosmosDB to create - possible values are GlobalDocumentDB, MongoDB and Parse. Defaults to GlobalDocumentDB. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_local_authentication_disabled"></a> [local_authentication_disabled](#input_local_authentication_disabled) | Controls whether local authentication is disabled for CosmosDB. Defaults to true except for MongoDB accounts. | `bool` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_offer_type"></a> [offer_type](#input_offer_type) | (Required) Specifies the Offer Type to use for this CosmosDB Account; currently, this can only be set to Standard. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_restore"></a> [restore](#input_restore) | (Optional)<br/>object({<br/>  source_cosmosdb_account_id = (Required) The resource ID of the restorable database account from which the restore has to be initiated. Changing this forces a new resource to be created.<br/>  restore_timestamp_in_utc   = (Required) The creation time of the database or the collection (Datetime Format RFC 3339). Changing this forces a new resource to be created.<br/>  database                   = (Optional) database block <br/>  name                       = (Required) The database name for the restore request. Changing this forces a new resource to be created.<br/>  collection_names           = (Optional) A list of the collection names for the restore request. Changing this forces a new resource to be created.<br/>}) | <pre>object({<br/>    source_cosmosdb_account_id = string<br/>    restore_timestamp_in_utc   = string<br/>    database = object({<br/>      name             = string<br/>      collection_names = optional(list(string))<br/>    })<br/>  })</pre> | `null` | no |
| <a name="input_rotation_policy"></a> [rotation_policy](#input_rotation_policy) | (Optional) A rotation policy block as defined below<br/>object({<br/>  notify_before_expiry = "(Optional) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>  time_before_expiry   = "(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br/>  time_after_creation  = "(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br/>  expire_after         = "(Optional) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>}) | <pre>object({<br/>    notify_before_expiry = string<br/>    time_before_expiry   = string<br/>    time_after_creation  = optional(string, null)<br/>    expire_after         = string<br/>  })</pre> | <pre>{<br/>  "expire_after": "P365D",<br/>  "notify_before_expiry": "P358D",<br/>  "time_after_creation": null,<br/>  "time_before_expiry": "P7D"<br/>}</pre> | no |
| <a name="input_schema_type"></a> [schema_type](#input_schema_type) | (Required) The schema type of the Analytical Storage for this Cosmos DB account. Possible values are FullFidelity and WellDefined. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_total_throughput_limit"></a> [total_throughput_limit](#input_total_throughput_limit) | (Required) The total throughput limit imposed on this Cosmos DB account (RU/s). Possible values are at least -1. -1 means no limit. | `number` | n/a | yes |
| <a name="input_virtual_network_rule"></a> [virtual_network_rule](#input_virtual_network_rule) | (Optional) Configures the virtual network subnets allowed to access this Cosmos DB account<br/>object({<br/>  id =  (Required) The ID of the virtual network subnet.<br/>  ignore_missing_vnet_service_endpoint =  (Optional) If set to true, the specified subnet will be added as a virtual network rule even if its CosmosDB service endpoint is not active. Defaults to false. <br/>}) | <pre>object({<br/>    id                                   = string<br/>    ignore_missing_vnet_service_endpoint = optional(bool, false)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoint"></a> [endpoint](#output_endpoint) | The endpoint used to connect to the CosmosDB account. |
| <a name="output_id"></a> [id](#output_id) | The CosmosDB Account ID. |
| <a name="output_name"></a> [name](#output_name) | The CosmosDB Account name. |
| <a name="output_primary_key"></a> [primary_key](#output_primary_key) | The Primary key for the CosmosDB Account. |
| <a name="output_primary_mongodb_connection_string"></a> [primary_mongodb_connection_string](#output_primary_mongodb_connection_string) | Primary Mongodb connection string for the CosmosDB Account. |
| <a name="output_primary_readonly_key"></a> [primary_readonly_key](#output_primary_readonly_key) | The Primary read-only Key for the CosmosDB Account. |
| <a name="output_primary_readonly_mongodb_connection_string"></a> [primary_readonly_mongodb_connection_string](#output_primary_readonly_mongodb_connection_string) | Primary readonly Mongodb connection string for the CosmosDB Account. |
| <a name="output_primary_readonly_sql_connection_string"></a> [primary_readonly_sql_connection_string](#output_primary_readonly_sql_connection_string) | Primary readonly SQL connection string for the CosmosDB Account. |
| <a name="output_primary_sql_connection_string"></a> [primary_sql_connection_string](#output_primary_sql_connection_string) | Primary SQL connection string for the CosmosDB Account. |
| <a name="output_resource"></a> [resource](#output_resource) | The CosmosDB Account resource. |
| <a name="output_secondary_key"></a> [secondary_key](#output_secondary_key) | The Secondary key for the CosmosDB Account. |
| <a name="output_secondary_mongodb_connection_string"></a> [secondary_mongodb_connection_string](#output_secondary_mongodb_connection_string) | Secondary Mongodb connection string for the CosmosDB Account. |
| <a name="output_secondary_readonly_key"></a> [secondary_readonly_key](#output_secondary_readonly_key) | The Secondary read-only Key for the CosmosDB Account. |
| <a name="output_secondary_readonly_mongodb_connection_string"></a> [secondary_readonly_mongodb_connection_string](#output_secondary_readonly_mongodb_connection_string) | Secondary readonly Mongodb connection string for the CosmosDB Account. |
| <a name="output_secondary_readonly_sql_connection_string"></a> [secondary_readonly_sql_connection_string](#output_secondary_readonly_sql_connection_string) | Secondary readonly SQL connection string for the CosmosDB Account. |
| <a name="output_secondary_sql_connection_string"></a> [secondary_sql_connection_string](#output_secondary_sql_connection_string) | Secondary SQL connection string for the CosmosDB Account. |
<!-- END_TF_DOCS -->
