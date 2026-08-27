---
version: 0.3.0
available_versions:
  - 0.3.0
  - 0.2.1
  - 0.2.0
  - 0.1.0
---

<!-- BEGIN_TF_DOCS -->
# Azure Private DNS Resolver Outbound Endpoint module


## Overview

This terraform module creates an Azure Private DNS Resolver Outbound Endpoint and associated resources, including `Private DNS Resolver`, and `Private DNS Resolver Outbound Endpoint`.

Azure DNS Private Resolver Outbound Endpoint enables conditional forwarding name resolution from Azure to on-premises, other cloud providers, or external DNS servers.

## Prerequisites

- `Resource Group` name is required.  A `Virtual Network` and `Subnet` needs to be created first, if not exists, to link to the DNS Resolver.
- `Private DNS Resolver` to be created.

## Guidance

#### Usage

- This Module tested locally with default settings.

#### Security Considerations

## Security Controls

- Currently, as per LSEG Approved private DNS resolver Security Requirements, there are no security requirements for this product.

## Changelog

- [azure-prdsvc-terraform-privatednsresolveroutboundendpoint](CHANGELOG.md)

## References

### Microsoft Docs

- [Azure Private DNS Resolver Outbound Endpoint](https://learn.microsoft.com/en-us/azure/dns/private-resolver-endpoints-rulesets#outbound-endpoints)

### Terraform Docs

- [azurermprivate_dns_resolver_outbound_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_outbound_endpoint)

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
| [azurerm_private_dns_resolver_outbound_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_outbound_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_private_dns_resolver_id"></a> [private_dns_resolver_id](#input_private_dns_resolver_id) | (Required) Specifies the ID of the Private DNS Resolver Outbound Endpoint. Changing this forces a new Private DNS Resolver Inbound Endpoint to be created. | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet_id](#input_subnet_id) | (Required) The ID of the Subnet that is linked to the Private DNS Resolver Outbound Endpoint. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The Resource ID of the Private DNS Resolver Outbound Endpoint. |
| <a name="output_name"></a> [name](#output_name) | The Name of the Private DNS Resolver Outbound Endpoint. |
| <a name="output_resource"></a> [resource](#output_resource) | The Private Dns Resolver Outbound Endpoint resource. |
<!-- END_TF_DOCS -->
