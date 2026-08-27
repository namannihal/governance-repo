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
# CDN Frontdoor Secret module

## Overview

This terraform module create a Frontdoor secret

## Prerequisites

- Network security group and Subnet needs to be created prior to this module.
- Key Vault and Key vault certificate needs to be created prior to this module.
- Azure CDN Front Door Profile needs to be created prior to this module.

## Guidance

#### Usage

- This module create below resource in Azure
  - CDN Front door secret.
- This Module Can't be tested with Teraform apply, as it only support the certificate signed by well known CA.
- There will no pester test case for this module as secret cannot be created without well known CA.
- Currently Frontdoor profile terraform resource doesn't have any identity block.
- If you would like to use the latest version of the Key Vault Certificate use the Key Vault Certificates versionless_id attribute as the key_vault_certificate_id fields value(e.g. key_vault_certificate_id = azurerm_key_vault_certificate.example.versionless_id).
- You must add an Access Policy to your azurerm_key_vault for the Microsoft.AzurefrontDoor-Cdn Enterprise Application Object ID.

#### Security Considerations

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. |  |  |  |  |  |  |

## Changelog

- [azure-prdsvc-terraform-cdnfrontdoorsecret](CHANGELOG.md)
-
## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/frontdoor/managed-identity?tabs=system-assigned)

### Terraform Docs

- [azure-prdsvc-terraform-cdnfrontdoorsecret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_secret)

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
| [azurerm_cdn_frontdoor_secret.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_secret) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_cdn_frontdoor_profile_id"></a> [cdn_frontdoor_profile_id](#input_cdn_frontdoor_profile_id) | (Required) The ID of the Frontdoor profile | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10c chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_key_vault_certificate_id"></a> [key_vault_certificate_id](#input_key_vault_certificate_id) | (Required) The key vault certificate id | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The ID of the frontdoor secret. |
| <a name="output_name"></a> [name](#output_name) | The Name of Frontdoor Secret |
| <a name="output_resource"></a> [resource](#output_resource) | The Cdn Frontdoor Secret resource. |
<!-- END_TF_DOCS -->
