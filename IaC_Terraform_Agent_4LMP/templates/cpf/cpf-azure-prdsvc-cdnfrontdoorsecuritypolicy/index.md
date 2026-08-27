---
version: 1.0.1
available_versions:
  - 1.0.1
  - 1.0.0
  - 0.2.4
  - 0.2.3
  - 0.2.2
---

<!-- BEGIN_TF_DOCS -->
# Azure Front door Security Policy module

## Overview

This terraform module create a Front Door Security Policy.

## Prerequisites

- Azure CDN Front Door Profile needs to be created prior to this module.
- DNS Zone and DNS C Name Record needs to be created prior to this module.
- Azure CDN Front Door Custom Domain needs to be created prior to this module.
- Azure CDN Front Door Firewall Policy needs to be created prior to this module.

## Guidance

#### Usage

- This module creates below resource in Azure
  - Azure Security Policy.
    The number of domain blocks that maybe included in the configuration file varies depending on the sku_name field of the linked Front Door Profile. The Standard_AzureFrontDoor sku may contain up to 100 domain blocks and a Premium_AzureFrontDoor sku may contain up to 500 domain blocks.
- `This Module Can't be tested with Greenfield changes, as it only support the certificate signed by well known CA` due to this policy `Custom-Front Door domains must use a TLS certificate that is persisted in an HSM backed Key Vault-1.0.0` can use only `CustomerCertificate`.

#### Security Considerations

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. |  |  |  |  |  |  |

## Changelog

- [azure-prdsvc-cdnfrontdoorsecuritypolicy](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/web-application-firewall/afds/afds-overview)

### Terraform Docs

- [azurerm_cdn_frontdoor_security_policy](https://learn.microsoft.com/en-us/azure/frontdoor/web-application-firewall)

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
| [azurerm_cdn_frontdoor_security_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_security_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_cdn_frontdoor_firewall_policy_id"></a> [cdn_frontdoor_firewall_policy_id](#input_cdn_frontdoor_firewall_policy_id) | (Required) The Resource Id of the Front Door Firewall Policy that should be linked to this Front Door Security Policy. Changing this forces a new Front Door Security Policy to be created. | `string` | n/a | yes |
| <a name="input_cdn_frontdoor_profile_id"></a> [cdn_frontdoor_profile_id](#input_cdn_frontdoor_profile_id) | (Required) The ID of the Frontdoor profile | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_domain"></a> [domain](#input_domain) | (Required) map(object({<br/>  cdn_frontdoor_domain_id = "(Required) The Resource Id of the Front Door Custom Domain or Front Door Endpoint that should be bound to this Front Door Security Policy. Changing this forces a new Front Door Security Policy to be created."<br/>})) | <pre>map(object({<br/>    cdn_frontdoor_domain_id = string<br/>  }))</pre> | n/a | yes |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_patterns_to_match"></a> [patterns_to_match](#input_patterns_to_match) | (Required) The list of paths to match for this firewall policy. Possible value includes /*. Changing this forces a new Front Door Security Policy to be created. | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The ID of the created frontdoor Security policy. |
| <a name="output_name"></a> [name](#output_name) | The name of the created frontdoor Security Policy. |
| <a name="output_resource"></a> [resource](#output_resource) | The Cdn Frontdoor Security Policy resource. |
<!-- END_TF_DOCS -->
