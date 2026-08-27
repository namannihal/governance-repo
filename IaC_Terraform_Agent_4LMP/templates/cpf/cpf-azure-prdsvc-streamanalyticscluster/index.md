---
version: 1.0.2
available_versions:
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.4.3
  - 0.4.2
---

<!-- BEGIN_TF_DOCS -->
# Stream Analytics Cluster module

## Overview

This terraform module creates a stream analytics cluster and managed private endpoint for Stream Analytics Cluster.

## Prerequisites

- An existing `Resource Group`, `Eventhub Namespace`, `Storage Account`, `Key Vault and associated Private Endpoint`.

## Guidance

#### Usage

- The current module is part of Stream Analytics Product where managed private can be created along with the cluster.
- The Managed private endpoint if created, requires manual approval before running the Stream Analytics Job Schedule.

- Usage Flow

| S. No. | Description | Execution | Repo Reference |
|--------|-------------|-----------|----------------|
| 1. | Create Stream Analytics Cluster along with Eventhub Namespace with managed private endpoint enabled for Eventhub Namespace | Terraform | Existing Repo |
| 2. | Create Stream Analytics Job along with above created cluster having managed private endpoint | Terraform | `Stream Analytics Job` Repo |
| 3. | Use existing Eventhub Namespace to create Event Hubs along with Consumer Group to be used for Input and Output | Terraform | `Stream Analytics Job` Repo |
| 4. | Assign Event Hub Data roles on existing Event Hubs IAM for Stream Analytics Job Managed Identity | Terraform | `Stream Analytics Job` Repo |
| 5. | Configure Stream Analytics Job with input and output with above created Eventhubs | Terraform | `Stream Analytics Job` Repo |
| 6. | Approve the managed private endpoint for Eventhub Namespace | Manual | Manual Task |
| 7. | Start the Stream Analytics Job Schedule | Terraform | `Stream Analytics Job Schedule` Repo |

#### Security Considerations

#### Additional Information

- This module currently supports the `azurerm version range of "~>3.40" to "<=3.97.1" versions` dated 29th April, 2024, due to limitation from Hashicorp. There are issues in Stream Analytics Cluster deployment with ">v3.97.1" azurerm versions and it has been reported to Hashicorp team.

## Security Controls

- Security controls are implemented in Stream Analytics Job module. There is no specific security control available for Stream Analytics Cluster.

## Changelog

- [azure-prdsvc-terraform-streamanalyticscluster](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/stream-analytics/)

### Terraform Docs

- [azure-prdsvc-terraform-streamanalyticscluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/stream_analytics_cluster)

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
| [azurerm_stream_analytics_cluster.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/stream_analytics_cluster) | resource |
| [azurerm_stream_analytics_managed_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/stream_analytics_managed_private_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_managed_private_endpoint"></a> [managed_private_endpoint](#input_managed_private_endpoint) | (Optional) manage private endpoint configuration<br/>object({<br/>  private_endpoint_name  = "(Required) The name which should be used for this Stream Analytics Managed Private Endpoint. Changing this forces a new resource to be created."<br/>  target_resource_id     = "(Required) The ID of the Private Link Enabled Remote Resource which this Stream Analytics Private endpoint should be connected to. Changing this forces a new resource to be created."<br/>  subresource_name       = "(Required) Specifies the sub resource name which the Stream Analytics Private Endpoint is able to connect to. Changing this forces a new resource to be created."<br/>}) | <pre>map(object({<br/>    private_endpoint_name = string<br/>    target_resource_id    = string<br/>    subresource_name      = string<br/>  }))</pre> | `{}` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_streaming_capacity"></a> [streaming_capacity](#input_streaming_capacity) | (Required) The number of streaming units supported by the Cluster. Accepted values are multiples of 36 in the range of 36 to 216 | `number` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The resource ID of the stream analytics service. |
| <a name="output_managed_private_endpoint_id"></a> [managed_private_endpoint_id](#output_managed_private_endpoint_id) | The Stream Analytics Managed Private Endpoint resource ID. |
| <a name="output_managed_private_endpoint_name"></a> [managed_private_endpoint_name](#output_managed_private_endpoint_name) | The Stream Analytics Managed Private Endpoint resource name. |
| <a name="output_managed_private_endpoint_resource"></a> [managed_private_endpoint_resource](#output_managed_private_endpoint_resource) | The Stream Analytics Managed Private Endpoint resource. |
| <a name="output_name"></a> [name](#output_name) | The name of the stream analytics cluster. |
| <a name="output_resource"></a> [resource](#output_resource) | The stream analytics resource. |
<!-- END_TF_DOCS -->
