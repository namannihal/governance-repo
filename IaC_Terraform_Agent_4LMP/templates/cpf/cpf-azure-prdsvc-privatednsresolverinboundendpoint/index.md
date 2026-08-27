---
version: 0.2.1
available_versions:
  - 0.2.1
  - 0.2.0
  - 0.1.0
---

<!-- BEGIN_TF_DOCS -->
# Private DNS Resolver Inbound Endpoint module


## Overview

This terraform module creates an Azure Private DNS Resolver Inbound Endpoint and associated resources, including `Private DNS Resolver` and `Private DNS Resolver Inbound Endpoint`.

## Prerequisites

The `virtual network` and `Subnet` has been created in the `Resource Group`.
`Private DNS Resolver` to be created.

## Guidance

#### Usage

- This module is tested locally with `Dynamic` IP config.

#### Security Considerations

- This module supports the creation of both IP config `Dynamic` or `Static` while provisioning the private DNS resolver inbound endpoint.

## Security Controls

- Currently, as per LSEG Approved private DNS resolver Security Requirements, there are no security requirements for this product.

## Changelog

- [azure-prdsvc-terraform-privatednsresolverinboundendpoint](CHANGELOG.md)

## References

### Microsoft Docs

- [Azure Private DNS Resolver Inbound Endpoint](https://learn.microsoft.com/en-us/azure/dns/private-resolver-endpoints-rulesets#inbound-endpoints)

### Terraform Docs

- [azurerm_private_dns_resolver_inbound_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_inbound_endpoint)

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
| [azurerm_private_dns_resolver_inbound_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_inbound_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_ip_configurations"></a> [ip_configurations](#input_ip_configurations) | (Required) Multiple objects can be specified to define multiple IP configurations.<br>object({<br>private_ip_allocation_method = (Required) Private IP address allocation method. Allowed value is Dynamic. Defaults to Dynamic.<br>subnet_id                    = (Required) The subnet ID of the IP configuration.<br>})) | <pre>map(object({<br>    private_ip_allocation_method = string<br>    subnet_id                    = string<br>  }))</pre> | n/a | yes |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_private_dns_resolver_id"></a> [private_dns_resolver_id](#input_private_dns_resolver_id) | (Required) Specifies the ID of the Private DNS Resolver Inbound Endpoint. Changing this forces a new Private DNS Resolver Inbound Endpoint to be created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The resource ID of the created private DNS resolver inbound endpoint. |
| <a name="output_name"></a> [name](#output_name) | The name of the created private DNS resolver inbound endpoint. |
| <a name="output_resource"></a> [resource](#output_resource) | The Private Dns Resolver Inbound Endpoint resource. |
<!-- END_TF_DOCS -->
