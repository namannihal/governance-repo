---
version: 0.3.1
available_versions:
  - 0.3.1
  - 0.3.0
  - 0.2.0
  - 0.1.0
---

<!-- BEGIN_TF_DOCS -->
# Azure Monitor Private Link Scope Module


## Overview

- This module creates the Azure Monitor Private Link Scope and associates the Scoped Services to the AMPLS resource.

- An Azure Monitor Private Link Scope (AMPLS) connects a private endpoint to a set of Azure Monitor resources: Log Analytics workspaces and Application Insights, defining the boundaries of the monitoring network.

- Azure Private Link, can securely link Azure platform as a service (PaaS) resources to the virtual network by using private endpoints. Azure Monitor is a constellation of different interconnected services that work together to monitor the workloads.

## Prerequisites

- `Resource Group`
- `Log Analytics workspace`
- `Virtual Network`
- `Subnet`

## Guidance

#### Usage

- This module is creating Azure monitor private link scope and connecting with log analytics workspace.

#### Security Considerations

- One VNet can only connect to one AMPLS object:
    That means the AMPLS object must provide access to all the Azure Monitor resources the VNet should have access to,
- An AMPLS object can connect up to:
  - 300 Log Analytics workspaces and,
  - 1000 Application Insights,
- An Azure Monitor resource (Workspace or Application Insights or Data Collection Endpoint) can connect to a maximum of 5 AMPLSs,
- An AMPLS object can connect to a maximum of 10 Private Endpoints.

## Security Controls

Currently, as per LSEG Approved Azure Monitor Private Link Scope Security Requirements, there are no security controls for this product.

## Changelog

- [azure-prdsvc-terraform-monitorprivatelinkescope](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/samples/azure-samples/azure-monitor-private-link-scope/azure-monitor-private-link-scope/)  

### Terraform Docs

- [azurerm_monitor_private_link_scope](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_private_link_scope)
- [azurerm_monitor_private_link_scoped_service](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_private_link_scoped_service)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm) | >= 3.51 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | >= 3.51 |

## Resources

| Name | Type |
|------|------|
| [azurerm_monitor_private_link_scope.ampls](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_private_link_scope) | resource |
| [azurerm_monitor_private_link_scoped_service.amplssvc](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_private_link_scoped_service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_linked_resource_ids"></a> [linked_resource_ids](#input_linked_resource_ids) | (Optional) The Resource ID(s) of the linked resource(s). It must be Log Analytics Workspace ID(s) and/or Application Insights ID(s). Changing this forces a new resource to be created. | `list(string)` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The Resource ID of the Azure Monitor Private Link Scope. |
| <a name="output_map_scoped_service_ids"></a> [map_scoped_service_ids](#output_map_scoped_service_ids) | Map of the Scoped services IDs. |
| <a name="output_name"></a> [name](#output_name) | The Name of the Azure Monitor Private Link Scope. |
| <a name="output_resource"></a> [resource](#output_resource) | The Azure Monitor Private Link Scope resource. |
| <a name="output_scoped_service_ids"></a> [scoped_service_ids](#output_scoped_service_ids) | IDs of the Scoped services. |
<!-- END_TF_DOCS -->
