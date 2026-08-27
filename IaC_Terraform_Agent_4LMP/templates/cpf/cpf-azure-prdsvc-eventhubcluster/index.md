---
version: 1.0.2
available_versions:
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.3.2
  - 0.3.1
---

<!-- BEGIN_TF_DOCS -->
# Event Hub Cluster module

## Overview

- Event Hubs Dedicated clusters are designed to meet the needs of most demanding mission-critical event streaming workloads

## Prerequisites

- `Resource Group Name` is required.

## Guidance

#### Usage

- This terraform module creates an Event Hub Cluster.

#### Security Considerations

## Security Controls

This Event Hub Cluster Module does not have any security controls that can be implemented. All controls have been implemented and documented in Event Hub Namespace. If any new security controls are identified in this product a new version will be added.

## Changelog

- [azure-prdsvc-terraform-eventhubcluster](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/event-hubs/event-hubs-dedicated-overview)

### Terraform Docs

- [azurerm_eventhub_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_cluster)

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
| [azurerm_eventhub_cluster.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku_name](#input_sku_name) | (Optional) The SKU name of the EventHub Cluster. The only supported value at this time is `Dedicated_1`. Changing this forces a new resource to be created. | `string` | `"Dedicated_1"` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The ID of the created Event Hub Cluster. |
| <a name="output_name"></a> [name](#output_name) | The name of the created Event Hub Cluster. |
| <a name="output_resource"></a> [resource](#output_resource) | The Event Hub Cluster resource. |
<!-- END_TF_DOCS -->
