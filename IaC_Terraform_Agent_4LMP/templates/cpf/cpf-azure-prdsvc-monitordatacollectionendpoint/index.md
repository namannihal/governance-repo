---
version: 1.0.2
available_versions:
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.2.0
  - 0.1.0
---

<!-- BEGIN_TF_DOCS -->
# Monitor Data Collection Endpoint (DCE) ReadME


## Overview

An Azure Monitor **Data Collection Endpoint (DCE)** is an endpoint used by Azure Monitor / Azure Monitor Agent (AMA) to ingest monitoring data. It provides a configurable endpoint for data collection scenarios and is commonly used alongside **Data Collection Rules (DCRs)**.

DCEs help define _where monitoring data is sent_ and can be used to support network isolation and controlled ingestion patterns.

### Why is a DCE needed?

A DCE is required in the following scenarios:

- **Custom Logs ingestion** – When using the Logs Ingestion API or collecting custom text/JSON logs via AMA, a DCE is mandatory as it serves as the ingestion entry point.
The following data sources currently require a DCE:
  - Custom log Files, isslogs, Windows Firewall Logs
  - Prometheus Metrics (Container Insights)

## Key Features

This Terraform module provisions an **Azure Monitor Data Collection Endpoint** and supports configuration of common DCE properties, including:

- **`description`** – Optional description for the DCE
- **`kind`** – Endpoint kind (as supported by Azure)
- **`public_network_access_enabled`** – Enable/disable public network access to the endpoint
- **`azurerm_monitor_data_collection_rule_association`** – Optionally associates the DCE with one or more Azure resources (e.g., Virtual Machines, VM Scale Sets) via the `association_targets` variable, using an `azurerm_monitor_data_collection_rule_association` resource per target

## Prerequisites

- Create a dedicated resource group or use an existing resource group to create the Data Collection Endpoint.
- Ensure you have appropriate permissions to create Azure Monitor resources in the target subscription/resource group.

## Guidance

#### Usage

#### Additional Information

- Define the `azurerm_monitor_data_collection_endpoint` resource in your Terraform configuration (or consume this module).
- Provide required inputs such as `resource_group_name`, `location`, and naming inputs.
- Optionally configure `description`, `kind`, and `public_network_access_enabled`.
- Reference the DCE from Data Collection Rules (DCRs) / Data Collection Rule Associations as required by your monitoring design.
- Use the `azurerm_monitor_data_collection_rule_association` input variable to associate the DCE with one or more Azure resources (e.g., Virtual Machines, VM Scale Sets), if assocaition is not at data collection rule module.
- Apply the Terraform configuration to provision the Data Collection Endpoint in Azure.

## Security Controls

- Currently, as per LSEG Approved Monitor Data Collection Endpoint Requirements, there are no security controls for this product.

## Changelog

- [azure-prdsvc-terraform-monitordatacollectionendpoint](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/azure-monitor/essentials/data-collection-endpoint-overview)

### Terraform Docs

- [azurerm_monitor_data_collection_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_data_collection_endpoint)
- [azurerm_monitor_data_collection_rule_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_data_collection_rule_association)

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
| [azurerm_monitor_data_collection_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_data_collection_endpoint) | resource |
| [azurerm_monitor_data_collection_rule_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_data_collection_rule_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_association_targets"></a> [association_targets](#input_association_targets) | (Optional) List of target resources for Data Collection Endpoint associations.<br/>  target_resource_id = "(Required) Resource ID of the target to associate with the DCE."<br/>  description        = "(Optional) Description for the association target." | <pre>list(object({<br/>    target_resource_id = string<br/>    description        = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_description"></a> [description](#input_description) | (Optional) Specifies a description for the Data Collection Endpoint. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_kind"></a> [kind](#input_kind) | (Optional) The kind of the Data Collection Endpoint. Possible values are 'Linux' and 'Windows'. | `string` | `"Windows"` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public_network_access_enabled](#input_public_network_access_enabled) | (Optional) Whether network access from public internet to the Data Collection Endpoint is allowed. Defaults to true. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_configuration_access_endpoint"></a> [configuration_access_endpoint](#output_configuration_access_endpoint) | The endpoint used by Azure Monitor Agent to retrieve Data Collection Rule configurations, e.g., https://<dce>.<region>.control.monitor.azure.com. |
| <a name="output_id"></a> [id](#output_id) | The Resource ID of the Monitor Data Collection Endpoint. |
| <a name="output_immutable_id"></a> [immutable_id](#output_immutable_id) | The immutable ID of the Monitor Data Collection Endpoint. |
| <a name="output_logs_ingestion_endpoint"></a> [logs_ingestion_endpoint](#output_logs_ingestion_endpoint) | The endpoint used for ingesting logs via the Logs Ingestion API, e.g., https://<dce>.<region>.ingest.monitor.azure.com. |
| <a name="output_name"></a> [name](#output_name) | The Name of the Monitor Data Collection Endpoint. |
| <a name="output_resource"></a> [resource](#output_resource) | The Monitor Data Collection Endpoint resource. |
<!-- END_TF_DOCS -->
