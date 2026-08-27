---
version: 1.0.1
available_versions:
  - 1.0.1
  - 1.0.0
  - 0.2.3
  - 0.2.2
  - 0.2.1
---

<!-- BEGIN_TF_DOCS -->
# Front door rule set module

## Overview

This terraform module creates an Azure Front Door Rule Set.

## Prerequisites

- Azure CDN Front Door Profile needs to be created prior to this module.

## Guidance

#### Usage

- This module creates Azure FrontDoor Rule Set in Azure.

#### Security Considerations

## Security Controls

- There are no security Controls available to be implemented.

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. |  |  |  |  |  |  |

## Changelog

- [azure-prdsvc-terraform-cdnfrontdoorruleset](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/frontdoor/standard-premium/how-to-configure-rule-set)

### Terraform Docs

- [azurerm_cdn_frontdoor_rule_set](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_rule_set)

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
| [azurerm_cdn_frontdoor_rule_set.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_rule_set) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_cdn_frontdoor_profile_id"></a> [cdn_frontdoor_profile_id](#input_cdn_frontdoor_profile_id) | (Required) CDN frontdoor profile ID | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The ID of the Azure Frontdoor Rule set. |
| <a name="output_name"></a> [name](#output_name) | The name of the Azure Frontdoor Rule set. |
| <a name="output_resource"></a> [resource](#output_resource) | The Cdn Frontdoor Rule Set resource. |
<!-- END_TF_DOCS -->
