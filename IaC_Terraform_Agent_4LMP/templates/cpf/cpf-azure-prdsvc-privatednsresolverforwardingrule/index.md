---
version: 0.3.0
available_versions:
  - 0.3.0
  - 0.2.0
  - 0.1.0
---

<!-- BEGIN_TF_DOCS -->
# Azure Private DNS Resolver Forwarding Rule module


## Overview

This terraform module creates an Azure Private DNS Resolver Forwarding Rule and associated resources.

## Prerequisites

- `Resource Group` name is required.  A `Virtual Network` needs to be created first, if not exists, to link to the DNS Resolver.
- `Private DNS Resolver` and `Private DNS Resolver Outbound Endpoint` needs to be created to link to the Private DNS Resolver Forwarding Ruleset.
- `Private DNS Resolver DNS Forwarding Ruleset` needs to be created to link to Private DNS Resolver Forwarding Rule.

## Guidance

#### Usage

- Azure Private DNS Resolver Forwarding Rules include one or more target DNS servers that are used for conditional forwarding.

#### Security Considerations

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. |  |  |  |  |  |  |

## Changelog

- [azure-prdsvc-terraform-privatednsresolverforwardingrule](CHANGELOG.md)

## References

### Microsoft Docs

-[Official Documentation](https://learn.microsoft.com/en-us/azure/dns/private-resolver-endpoints-rulesets#rules)

### Terraform Docs

- [azurerm_private_dns_resolver_forwarding_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_forwarding_rule)

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
| [azurerm_private_dns_resolver_forwarding_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_forwarding_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_dns_forwarding_ruleset_id"></a> [dns_forwarding_ruleset_id](#input_dns_forwarding_ruleset_id) | (Required) The ID of the Private DNS Forwarding Ruleset in which this Private DNS Forwarding Rule should be created. | `string` | n/a | yes |
| <a name="input_domain_name"></a> [domain_name](#input_domain_name) | (Required) The domain name suffix for which this Private DNS Forwarding Rule should be created. | `string` | n/a | yes |
| <a name="input_enabled"></a> [enabled](#input_enabled) | (Optional) Specifies the state of the Private DNS Resolver Forwarding Rule. Defaults to true. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_target_dns_servers"></a> [target_dns_servers](#input_target_dns_servers) | (Required) A list of target DNS servers for this Private DNS Forwarding Rule. | `map(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The Resource ID of the Private DNS Resolver Forwarding Rule. |
| <a name="output_name"></a> [name](#output_name) | The Name of the Private DNS Resolver Forwarding Rule. |
| <a name="output_resource"></a> [resource](#output_resource) | The Private Dns Resolver Forwarding Rule resource. |
<!-- END_TF_DOCS -->
