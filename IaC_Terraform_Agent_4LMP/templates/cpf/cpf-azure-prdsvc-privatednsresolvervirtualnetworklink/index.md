---
version: 0.3.0
available_versions:
  - 0.3.0
  - 0.2.1
  - 0.2.0
  - 0.1.0
---

<!-- BEGIN_TF_DOCS -->
# Private DNS Resolver Virtual Network Link module

## Overview

This terraform module creates a Private DNS Resolver Virtual Network Link and associated resources.

## Prerequisites

- `Resource Group` name is required.  A `Virtual Network` needs to be created first, if not exists, to link to the DNS Resolver.
- `Private DNS Resolver` and `Private DNS Resolver Outbound Endpoint` needs to be created to link to the Private DNS Resolver Forwarding Ruleset.
- `Private DNS Resolver DNS Forwarding Ruleset` needs to be created to link to Private DNS Resolver Virtual Network Link.

## Guidance

#### Usage

- A virtual network can be linked to private DNS zone as a registration or as a resolution virtual network.
- When creating a link between a private DNS zone and a virtual network. You have the option to enable autoregistration.
- After you create a private DNS zone in Azure, you'll need to link a virtual network to it. Once linked, VMs hosted in that virtual network can access the private DNS zone.
- Every private DNS zone has a collection of virtual network link child resources. Each one of these resources represents a connection to a virtual network.

#### Security Considerations

## Security Controls

> Note: Currently, as per LSEG Approved Private DNS resolver Virtual Ntwork Link Security Requirements, there are no security requirements for this product.

## Changelog

- [azure-prdsvc-terraform-privatednsresolvervirtualnetworklink](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/dns/private-dns-virtual-network-links)

### Terraform Docs

- [azurerm_private_dns_resolver_virtual_network_link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_virtual_network_link)

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
| [azurerm_private_dns_resolver_virtual_network_link.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_virtual_network_link) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_dns_forwarding_ruleset_id"></a> [dns_forwarding_ruleset_id](#input_dns_forwarding_ruleset_id) | (Required) The ID of the Private DNS Forwarding Rule set in which this Private DNS Forwarding Rule should be created. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_metadata"></a> [metadata](#input_metadata) | (Optional) Metadata attached to the Private DNS Resolver Forwarding Rule. | `map(string)` | `null` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_virtual_network_id"></a> [virtual_network_id](#input_virtual_network_id) | (Required) The ID of the Virtual Network that is linked to the Private DNS Resolver. Changing this forces a new Private DNS Resolver to be created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The id of the Private DNS Resolver Virtual Network link |
| <a name="output_name"></a> [name](#output_name) | The Name of the Private DNS Resolver Virtual Network link |
| <a name="output_resource"></a> [resource](#output_resource) | The Private Dns Resolver Virtual Network Link resource. |
<!-- END_TF_DOCS -->
