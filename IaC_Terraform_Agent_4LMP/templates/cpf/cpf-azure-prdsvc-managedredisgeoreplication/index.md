---
version: 1.0.0
available_versions:
  - 1.0.0
---

<!-- BEGIN_TF_DOCS -->
# Managed Redis Geo Replication Module


## Overview

This Terraform module establishes geo-replication linkage between Azure Managed Redis (Redis Enterprise) instances across multiple regions. It enables you to connect a primary Managed Redis instance with one or more replica instances, creating a geo-distributed Redis deployment for high availability and disaster recovery scenarios.

The module configures active geo-replication by linking existing Managed Redis instances that share the same geo-replication group name, allowing data to be replicated across regions while maintaining a single logical Redis deployment.

## Prerequisites
- `primary_managed_redis_id` (Required) - Resource ID of the primary Managed Redis instance
- `linked_managed_redis_ids` (Required) - List of 1-4 replica Redis instance resource IDs

## Guidance

### Usage

This module creates a geo-replication linkage between Azure Managed Redis (Redis Enterprise) instances. It connects a primary Redis instance with one or more replica instances across different regions, enabling data replication for high availability and disaster recovery.

1. Deploy Managed Redis instances in different regions using the `azure-prdsvc-terraform-managedredis` module
2. Ensure all Redis instances have the same `geo_replication_group_name` in their `default_database` configuration
3. Use this module to link the instances together by providing the primary Redis ID and a list of replica Redis IDs
4. The module establishes bi-directional replication between all linked instances

### Notes for Managed Redis Geo Replication

- Primary and replica Managed Redis instances must already exist before establishing geo-replication
- All instances must have the same `geo_replication_group_name` in their `default_database` configuration
- All instances must be deployed in **different Azure regions**
- All instances must use the **same SKU** (e.g., MemoryOptimized_M10, ComputeOptimized_C5, Balanced_B10)
- **Maximum of 5 instances** per geo-replication group (1 primary + 4 replicas)

### Example

```tf
# Primary Redis in West Europe
module "azure_prdsvc_terraform_managedredis_primary" {
  source              = "git::https://your-repo-url/azure-prdsvc-terraform-managedredis.git?ref=v1.0.0"
  resource_group_name = "rg-redis-primary-westeurope"
  location            = "westeurope"
  sku_name            = "MemoryOptimized_M10"
  default_database = {
    geo_replication_group_name = "my-redis-geo-group"
    clustering_policy          = "OSSCluster"
    eviction_policy            = "VolatileLRU"
  }
}
```

```tf
# Replica Redis in East US
module "azure_prdsvc_terraform_managedredis_replica_eastus" {
  source              = "git::https://your-repo-url/azure-prdsvc-terraform-managedredis.git?ref=v1.0.0"
  resource_group_name = "rg-redis-replica-eastus"
  location            = "eastus"
  sku_name            = "MemoryOptimized_M10"
  default_database = {
    geo_replication_group_name = "my-redis-geo-group"  # Same group name as primary
    clustering_policy          = "OSSCluster"
    eviction_policy            = "VolatileLRU"
  }
}
```

```tf
# Establish geo-replication linkage
module "azure_prdsvc_terraform_managedredis_georeplication" {
  source = "git::https://your-repo-url/azure-prdsvc-terraform-managedredisgeoreplication.git?ref=v1.0.0"
  # Primary Redis instance resource ID
  primary_managed_redis_id = module.azure_prdsvc_terraform_managedredis_primary.id
  # Replica Redis instances to link (must be in different regions with same SKU)
  linked_managed_redis_ids = [
    module.azure_prdsvc_terraform_managedredis_replica_eastus.id
  ]
  # Dependencies to ensure Redis instances are created first
  depends_on = [
    module.azure_prdsvc_terraform_managedredis_primary,
    module.azure_prdsvc_terraform_managedredis_replica_eastus
  ]
}
```

## Security Controls
- Security controls are not implemented at the project module level.
- All relevant security controls are enforced at the Managed Redis level, in accordance with organizational and platform standards.

## Changelog

- [azure-prdsvc-terraform-managedredisgeoreplication](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/redis/overview)

### Terraform Docs

- [azurerm_managed_redis](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_redis)

- [azurerm_managed_redis_geo_replication](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_redis_geo_replication)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm) | >= 4.33 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | >= 4.33 |

## Resources

| Name | Type |
|------|------|
| [azurerm_managed_redis_geo_replication.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_redis_geo_replication) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_linked_managed_redis_ids"></a> [linked_managed_redis_ids](#input_linked_managed_redis_ids) | (Required) A set of other Managed Redis IDs to link together in the geo-replication group. <br/><br/>The ID of the primary Managed Redis (managed_redis_id) is always included by default and does not need to be provided here.<br/><br/>Requirements:<br/>- Can contain up to 4 Managed Redis IDs, making up a group of 5 in total (including the primary)<br/>- All Managed Redis must have the same geo_replication_group_name configured in their default_database block<br/>- All instances must be in different regions<br/>- All instances must use the same SKU<br/>- Once linked, the geo-replication state of all Managed Redis instances will be updated<br/><br/>Example: [<br/>  "/subscriptions/{subscription-id}/resourceGroups/{rg-name}/providers/Microsoft.Cache/redisEnterprise/{redis-replica-1}",<br/>  "/subscriptions/{subscription-id}/resourceGroups/{rg-name}/providers/Microsoft.Cache/redisEnterprise/{redis-replica-2}"<br/>] | `list(string)` | n/a | yes |
| <a name="input_primary_managed_redis_id"></a> [primary_managed_redis_id](#input_primary_managed_redis_id) | (Required) The ID of the Managed Redis through which geo-replication group will be managed. <br/><br/>Linking is reciprocal - if A is linked to B, both A and B will have the same linking state. <br/>There is no need to have duplicate azurerm_managed_redis_geo_replication resources for each instance.<br/><br/>Changing this forces a new resource to be created.<br/><br/>Example: "/subscriptions/{subscription-id}/resourceGroups/{rg-name}/providers/Microsoft.Cache/redisEnterprise/{redis-name}" | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The Resource ID of the Managed Redis Geo-Replication. |
| <a name="output_name"></a> [name](#output_name) | The name of the Managed Redis Geo-Replication. |
| <a name="output_resource"></a> [resource](#output_resource) | The complete Managed Redis Geo-Replication resource. |
<!-- END_TF_DOCS -->
