---
version: 1.0.1
available_versions:
  - 1.0.1
  - 1.0.0
  - 0.1.3
  - 0.1.2
  - 0.1.1
---

<!-- BEGIN_TF_DOCS -->
# Redis Linked Server module

## Overview

This terraform module creates a Redis Linked Server and associated resources.

## Prerequisites
- Exisiting `resource_group` and `virtual_network`.
- One `network_security_group`to associate with the subnet.
- One `route table`.
- Two `redis cache` to be linked.
- one `User assign identity` to configure identity for `primary redis cache`.

## Guidance
#### Usage
- Require two `redis cache` to create a `redislink server`.
- To configure geo-replication ensure the servers meet the criteria mentioned in the following
  [link](https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/cache-how-to-geo-replication)

#### Security Considerations

## Security Controls

- Redis Linked Server does not have any [security controls](https://gitlab.dx1.lseg.com/app/app-51285/cloud-security-controls/azure-clear-listing/-/blob/main/azure/services/Microsoft.Cache/redis/v1.0.0/markdown/serviceControls.md) available currently. If any

## Changelog

- [azure_prdsvc_terraform_redislinkedserver](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/cache-how-to-geo-replication)

### Terraform Docs

- [azurerm_redis_linked_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_linked_server)

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
| [azurerm_redis_linked_server.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_linked_server) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_linked_redis_cache_id"></a> [linked_redis_cache_id](#input_linked_redis_cache_id) | (Required) The ID of the linked Redis cache. Changing this forces a new Redis to be created. | `string` | n/a | yes |
| <a name="input_linked_redis_cache_location"></a> [linked_redis_cache_location](#input_linked_redis_cache_location) | (Required) The location of the linked Redis cache. Changing this forces a new Redis to be created. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) The name of the Resource Group where the Redis caches exists. Changing this forces a new Redis to be created. | `string` | n/a | yes |
| <a name="input_server_role"></a> [server_role](#input_server_role) | (Required) The role of the linked Redis cache (eg `Secondary`). Changing this forces a new Redis to be created. Possible values are `Primary` and `Secondary`. | `string` | n/a | yes |
| <a name="input_target_redis_cache_name"></a> [target_redis_cache_name](#input_target_redis_cache_name) | (Required) The name of Redis cache to link with. Changing this forces a new Redis to be created (eg The primary role). | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The ID of the Redis Cache. |
| <a name="output_name"></a> [name](#output_name) | The name of the Redis Linked Server. |
| <a name="output_resource"></a> [resource](#output_resource) | The Redis Linked Server Resource. |
<!-- END_TF_DOCS -->
