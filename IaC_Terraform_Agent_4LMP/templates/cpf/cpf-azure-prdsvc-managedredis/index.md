---
version: 1.1.3
available_versions:
  - 1.1.3
  - 1.1.2
  - 1.1.1
  - 1.1.0
  - 1.0.5
---

<!-- BEGIN_TF_DOCS -->
# Managed Redis module


## Overview

This terraform module creates a managed redis and Azure Managed Redis improves the performance and scalability of applications that rely heavily on fast data access. By storing frequently accessed data in memory and supporting advanced clustering options, it enables applications to process high-volume, low-latency read/write operations efficiently.

## Prerequisites

- `Resource Group` name is required.
- `Subnet ID` is required.

## Guidance

#### Usage

- Managed Redis Enterprise provides an enterprise-grade Redis cluster with automatic scaling, high availability, and active-active replication capabilities.
- Geo-replication requires all participating clusters to share the same `geo_replication_group_name`
- Only `Balanced`, `Compute Optimized`, and `Memory Optimized` SKU families are supported as per internal security controls.
- `Flash Optimized` SKU families are not allowed as per internal security controls.

##### Notes for Managed Redis

- To deploy multiple replicas, deploy the Managed Redis using this moudule, ensure the `geo_replication_group_name` is same for all the instance. To link to the replicas to primary redis cache, use the resource block. Refer deployTest folder for additional details.
- Azure Managed Redis support Active - Active replication as multi master deployment.
- To create geo-replication groups, each Managed Redis replica must have its own private endpoint. A separate private endpoint resource must be created for every replica instance and linked individually using the geo_replication_resource block.
- All caches in a geo-replication group must use the same configuration. This includes identical SKU, capacity, eviction policy, clustering policy, modules, and TLS settings. Any differences between instances will prevent geo-replication from being established.
- A geo-replication group can include up to **5 cache instances** across regions (including primary and replicas).

##### Geo-Replication Module Integration

- This module now supports **integrated geo-replication** via the `azure-prdsvc-terraform-managedredisgeoreplication` sub-module.
- Set `enable_geo_replication = true` and provide `geo_replication_config` to automatically configure geo-replication between primary and secondary Redis instances.
- The `geo_replication_config` requires:
  - `linked_redis_cache_ids`: List of resource IDs for secondary/linked Redis caches (1-4 instances)
- All Redis instances (primary and replicas) must have the same `geo_replication_group_name` in their `default_database` configuration.
- All instances must be in different Azure regions and use the same SKU.
- The primary Redis ID is automatically included - only provide the replica IDs in the list.
- Maximum of 5 total instances in a geo-replication group (1 primary + 4 replicas).
- When using the integrated module approach, the geo-replication configuration is automatically managed alongside the Redis instance.

##### Entra ID Authentication (Access Policy Assignments)

- This module supports **Entra ID authentication** for passwordless access to Redis data plane operations.
- Use the `access_policy_assignments` variable to grant managed identities or service principals access to Redis data.
- The `access_policy_name` should be set to `default` which grants full data access (equivalent to Data Owner).
- Access policy assignments are managed via the `azapi` provider using the `Microsoft.Cache/redisEnterprise/databases/accessPolicyAssignments` resource type.
- When using Entra ID authentication, applications authenticate using their Object ID as the username and an Entra token as the password.

## Security Controls

| S. No. | Control ID     | Control Title                                                                                                                                            | Description                                                                                                                                                                                                                                                                                                                                                                         | Implemented | Tested using Pester | Comments                                                                                                                                                |
| ------ | -------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- | ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1.     | AZU-AMR-IA_010 | Azure Managed Redis must use a Managed Identity for accessing Azure Resources                                                                            | Azure Managed Redis must enforce the use of a Managed Identity to authenticate to Azure resources where this is supported (What) within target service access control settings (How) in order to remove the need to store credentials (Why)                                                                                                                                         | False       | False               | As per the security control document, `Control implemented by technical configuration setting:False`. This control will be implemented via LSEG Policy. |
| 2.     | AZU-AMR-IA_020 | Access Key Authentication should be disabled                                                                                                             | Azure Managed Redis should not use Access Keys for authentication (What) via Authentication settings (How) in order to use modern robust and less prone to compromise authentication methods embedded within Entra ID (Why)                                                                                                                                                         | True        | True                | Implemented using `access_keys_authentication_enabled =var.access_keys_authentication_enabled` with default as false                                                                                           |
| 3.     | AZU-AMR-AC_010 | Disable Public Network Access                                                                                                                            | Azure Managed Redis must enforce a network guardrail (What) in the Networking settings (How) in order to ensure inbound connections are using private networking (Why)                                                                                                                                                                                                              | True        | True                | Implemented using `public_network_access = Disabled`                                                                                                    |
| 4.     | AZU-AMR-AU_010 | Send all security and audit diagnostic log categories to a central Log Analytics workspace                                                               | Azure Managed Redis must send all security and audit diagnostic logs to a central Log Analytics workspace (What) via Diagnostic settings (How) in order to support a security investigation after a security incident (Why)                                                                                                                                                         | False       | False               | Diagnostics settings will be enabled using a separate module at bundle/pattern level                                                                    |
| 5.     | AZU-AMR-AU_020 | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval                                                        | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval (What) within Diagnostic settings (How) in order to prevent sensitive data leakage to third parties outside of LSEG control (Why)                                                                                                                                                 | False       | False               | Diagnostics settings will be enabled using a separate module at bundle/pattern level                                                                    |
| 6.     | AZU-AMR-SC_010 | Azure Managed Redis must use a dedicated CMK for encrypting disk data that is persisted in a Key Vault premium SKU                                       | Use a dedicated Azure Managed Redis encryption at rest key that is persisted in a Key Vault premium SKU (What) via Advanced settings (How) in order to use modern techniques to establish robust encrypted data channels over untrusted networks (Why)                                                                                                                              | False       | False               | Encryption uses platform managed keys keyvault                                                                                                          |
| 7.     | AZU-AMR-SC_020 | Network connections to Azure Managed Redis control and data planes must use TLS encryption                                                               | Azure Managed Redis must enforce network flow encryption in transit using TLS (What) in Advanced settings (How) in order to use techniques to establish an encrypted data channels over untrusted networks (Why)                                                                                                                                                                    | True        | True                | To maintain all the communications secure and encrypted in transit which is implemented using `client_protocol = "Encrypted"`                           |
| 8.     | AZU-AMR-SC_030 | Azure Managed Redis must not be able to corrupt the centrally managed private link private DNS zones when making a private end point for Cache for Redis | Azure Managed Redis must have an Azure DeployIfNotExists policy to update the centrally managed private link private DNS zones with its private A record (What) via Policy to management group mapping (How) to ensure there is no ability for the app team to have authorisation over these zones that could allow them to corrupt this file and impact service availability (Why) | False       | False               | This control will be implemented via policy.                                                                                                            |

## Example

```tf
module "azure_prdsvc_terraform_managedredis" {
  source              = "../.."
  org_id              = local.org_id
  app_id              = local.app_id
  location            = local.location
  environment         = local.environment
  context             = local.context
  instance            = local.instance
  resource_group_name = data.azurerm_resource_group.this.name
  sku_name            = local.sku
  high_availability_enabled = true

  default_database = {
    clustering_policy          = "OSSCluster"
    eviction_policy            = "AllKeysLRU"
    geo_replication_group_name = "Testgroup"
  }

  customer_managed_key = {
    key_vault_id              = module.azure-prdsvc-terraform-keyvault.id
    identity_principal_id     = module.azure-prdsvc-terraform-userassignedidentity.principal_id
    user_assigned_identity_id = module.azure-prdsvc-terraform-userassignedidentity.id
    expiration_date           = local.expiration_date
  }

  identity = {
    type         = "UserAssigned"
    identity_ids = [module.azure-prdsvc-terraform-userassignedidentity.id]
  }

  # Entra ID Access Policy Assignments for passwordless authentication
  access_policy_assignments = {
    "app-managed-identity" = {
      name               = "appManagedIdentity"  # Alphanumeric only, 1-60 chars
      object_id          = module.azure-prdsvc-terraform-userassignedidentity.principal_id
      access_policy_name = "default"  # Grants full data access
    }
  }

  tags = local.tags

  depends_on = [
    time_sleep.wait_60_seconds_keyvault
  ]
}
```

Implementation of Redis & Database Constraints

- `Enterprise_` and `EnterpriseFlash_` prefixed SKUs were previously used by Redis Enterprise, and not supported by Managed Redis.
- Updating the following properties will force a new database to be created, data will be lost and Managed Redis will be unavailable during the operation: `clustering_policy`, `geo_replication_group_name`, and `module`
- Changing `clustering_policy` forces database recreation. Data will be lost and Managed Redis will be unavailable during the operation.
- Changing `geo_replication_group_name` forces database recreation. Data will be lost and Managed Redis will be unavailable during the operation.
- An Identity is required when type is set to `UserAssigned` or `SystemAssigned`, `UserAssigned`.
- Changing `name` & `args` forces database recreation. Data will be lost and Managed Redis will be unavailable during the operation.
- Only `RediSearch` and `RedisJSON` modules are allowed with geo-replication.

## Changelog

- [azure-prdsvc-terraform-managedredis](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/redis/overview)

### Terraform Docs

- [azurerm_managed_redis](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_redis)
- [azapi_resource](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) (used for access policy assignments)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0 |
| <a name="requirement_azapi"></a> [azapi](#requirement_azapi) | >= 2.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm) | >= 4.33 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azapi"></a> [azapi](#provider_azapi) | >= 2.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | >= 4.33 |

## Resources

| Name | Type |
|------|------|
| [azapi_resource.access_policy_assignment](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) | resource |
| [azurerm_key_vault_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_managed_redis.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_redis) | resource |
| [azurerm_role_assignment.cmk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_key_vault_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_key) | data source |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_keys_authentication_enabled"></a> [access_keys_authentication_enabled](#input_access_keys_authentication_enabled) | Whether access key authentication is enabled on the Azure Managed Redis default database. | `bool` | `false` | no |
| <a name="input_access_policy_assignments"></a> [access_policy_assignments](#input_access_policy_assignments) | (Optional) Map of Entra ID access policy assignments for the Managed Redis database. This enables data plane access using Entra ID authentication.<br/>object({<br/>  name               = "(Required) The name of the access policy assignment. Must be alphanumeric only (A-Z, a-z, 0-9), 1-60 characters. No hyphens or special characters allowed."<br/>  object_id          = "(Required) The principal ID (Object ID) of the user, service principal, or managed identity to be assigned the access policy."<br/>  access_policy_name = "(Optional) The name of the access policy to assign. Defaults to 'default'. Currently only 'default' is supported by the API."<br/>}) | <pre>map(object({<br/>    name               = string<br/>    object_id          = string<br/>    access_policy_name = optional(string, "default")<br/>  }))</pre> | `{}` | no |
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_client_protocol"></a> [client_protocol](#input_client_protocol) | Client protocol for Azure Managed Redis. Encrypted = TLS, Plaintext = non-TLS | `string` | `"Encrypted"` | no |
| <a name="input_cmk_key_name"></a> [cmk_key_name](#input_cmk_key_name) | (optional) Key name to be used (max 127 chars) | `string` | `null` | no |
| <a name="input_cmk_rotation_policy"></a> [cmk_rotation_policy](#input_cmk_rotation_policy) | (Optional) A rotation policy block as defined below<br/>object({<br/>  notify_before_expiry = "(Optional) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>  time_before_expiry   = "(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br/>  time_after_creation  = "(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br/>  expire_after         = "(Optional) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>}) | <pre>object({<br/>    notify_before_expiry = string<br/>    time_before_expiry   = string<br/>    time_after_creation  = optional(string, null)<br/>    expire_after         = string<br/>  })</pre> | <pre>{<br/>  "expire_after": "P365D",<br/>  "notify_before_expiry": "P358D",<br/>  "time_after_creation": null,<br/>  "time_before_expiry": "P7D"<br/>}</pre> | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_create_role_assignment"></a> [create_role_assignment](#input_create_role_assignment) | (Optional) Whether to create a role assignment to the service identity to allow access to the key vault keys. | `bool` | `true` | no |
| <a name="input_customer_managed_key"></a> [customer_managed_key](#input_customer_managed_key) | (Required) An customer_managed_key block as defined below<br/>object({<br/>  key_vault_id                      = "(Required) The resource ID of the Key Vault where the Key Vault Key resides."<br/>  expiration_date                   = "(Required) Expiration UTC datetime (Y-m-d'T'H:M:S'Z')."<br/>  identity_id                       = "(Required) The resource ID of the User Assigned Identity that has access to the key. To be used if `use_system_assigned_identity` is set to `false`"<br/>  identity_principal_id             = "(Required) The principal ID of the User Assigned Identity that has access to the key."<br/>}) | <pre>object({<br/>    key_vault_id          = string<br/>    expiration_date       = string<br/>    identity_id           = string<br/>    identity_principal_id = string<br/>  })</pre> | n/a | yes |
| <a name="input_default_database"></a> [default_database](#input_default_database) | (Required) Default database configuration block for the Managed Redis instance.<br/>  object({<br/>    clustering_policy                     = "(Optional) Clustering policy for the database. Defaults to 'OSSCluster'."<br/>    eviction_policy                       = "(Optional) Eviction strategy when memory is full. Defaults to 'VolatileLRU'."<br/>    geo_replication_group_name            = "(Optional) Geo-replication group name shared across all participating regions."<br/>    persistence_append_only_file_backup_frequency = "(Optional) AOF backup frequency."<br/>    persistence_redis_database_backup_frequency   = "(Optional) Full Redis database backup frequency."<br/>    module                                = "(Optional) List of Redis Enterprise modules with fields 'name' and 'args'."<br/>  })<br/>  The default database controls clustering, persistence, and geo-replication behavior and is required for Redis Enterprise. | <pre>object({<br/>    clustering_policy                             = optional(string, "OSSCluster")<br/>    eviction_policy                               = optional(string, "VolatileLRU")<br/>    geo_replication_group_name                    = optional(string, null)<br/>    persistence_append_only_file_backup_frequency = optional(string)<br/>    persistence_redis_database_backup_frequency   = optional(string)<br/>    module = optional(list(object({<br/>      name = string<br/>      args = optional(string)<br/>    })))<br/>  })</pre> | n/a | yes |
| <a name="input_enable_geo_replication"></a> [enable_geo_replication](#input_enable_geo_replication) | (Optional) Enable geo-replication for this Managed Redis instance. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_geo_replication_config"></a> [geo_replication_config](#input_geo_replication_config) | (Optional) Configuration for geo-replication. Required when enable_geo_replication is true.<br/>object({<br/>  linked_redis_cache_ids = "(Required) List of linked Managed Redis resource IDs (1-4 instances). The primary Redis ID is automatically included."<br/>})<br/>Note: All linked Redis instances must:<br/>- Have the same geo_replication_group_name in their default_database configuration<br/>- Be in different Azure regions<br/>- Use the same SKU<br/>- Maximum of 5 total instances (primary + 4 replicas) | <pre>object({<br/>    linked_redis_cache_ids = list(string)<br/>  })</pre> | `null` | no |
| <a name="input_high_availability_enabled"></a> [high_availability_enabled](#input_high_availability_enabled) | (Optional) Determines whether high availability is enabled for the Managed Redis instance. When enabled, Azure Redis Enterprise provisions a 2-node replica set to ensure automatic failover. Changing this value forces a new Managed Redis instance to be created. Defaults to true. | `bool` | `true` | no |
| <a name="input_identity"></a> [identity](#input_identity) | (Optional) An identity block as defined below<br/>object({<br/>  type         = "(Required) Specifies the type of Managed Service Identity that should be configured on this Managed Redis. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned` (to enable both)."<br/>  identity_ids = "(Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Managed Redis. This is required when `type` is set to `UserAssigned` or `SystemAssigned, UserAssigned`."<br/>}) | <pre>object({<br/>    type         = string<br/>    identity_ids = list(string)<br/>  })</pre> | <pre>{<br/>  "identity_ids": [],<br/>  "type": "SystemAssigned"<br/>}</pre> | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_key_vault_tags"></a> [key_vault_tags](#input_key_vault_tags) | (Optional) Tags to be set on the Key Vault Key. | `map(any)` | `{}` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku_name](#input_sku_name) | (Required) Allowed SKU families: MemoryOptimized_*, ComputeOptimized_*, Balanced_*. FlashOptimized_* SKUs are out of scope as per Cyber Security controls. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_geo_replication"></a> [geo_replication](#output_geo_replication) | The geo-replication configuration if enabled. |
| <a name="output_hostname"></a> [hostname](#output_hostname) | The hostname of the Azure Cache for Redis. |
| <a name="output_id"></a> [id](#output_id) | The Resource ID of the Azure Managed Redis. |
| <a name="output_name"></a> [name](#output_name) | The name of Azure Managed Redis. |
| <a name="output_resource"></a> [resource](#output_resource) | The Managed Redis resource. |
<!-- END_TF_DOCS -->
