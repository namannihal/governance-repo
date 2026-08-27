---
version: 2.0.1
available_versions:
  - 2.0.1
  - 2.0.0
  - 1.1.0
  - 1.0.1
  - 1.0.0
---

<!-- BEGIN_TF_DOCS -->
# Azure Frontdoor Custom Domain module

## Overview

This terraform module creates a Front Door Custom Domain.

## Prerequisites
- `Azure CDN Front Door Profile` needs to be created prior to this module.
- `DNS Zone` and `DNS C Name record` needs to be created prior to this module.

## Guidance

#### Usage
- This module creates below resource in Azure
  - Custom Domain for Azure Frontdoor endpoint.
- To associate the custom domain with endpoint or route, we need to use "azure-prdsvc-terraform-cdnfrontdoorroute" module to pass the custom domain id.

#### Security Considerations

#### Additional Information
- TLS and SSL policy in greenfield denies CDN Front Door Route deployment. Custom domain is the only resource type amongst other Front Door modules that uses TLS/SSL. Hence custom domain is used as a dependent module for end to end testing.
- However, custom domain module can't be tested with Greenfield changes, as it only support the certificate signed by well known CA. This is because of this policy `Custom-Front Door domains must use a TLS certificate that is persisted in an HSM backed Key Vault-1.0.0` can use only `CustomerCertificate`.
- Due to this limitation, we are able to progress till terraform plan stage and full functionality of the product couldn't be tested in Greenfield.

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-AFD-SC_060 | Front Door must use an approved LSEG domain name | Front Door must use an approved LSEG domain name (What) within Domains settings (How) in order to ensure brand integrity of LSEG public websites (Why) | False | False | This Control would be implemented by LSEG Standard. |
| 2. | AZU-AFD-SC_070 |  Front Door domains must use a TLS certificate that is persisted in an HSM backed Key Vault |  Front Door domains must use a TLS certificate that is persisted in an HSM backed Key Vault (What) within Secrets setting (How) to ensure TLS authentication trust and reducing the risk of web site spoofing (Why) | False | False | This Control would be implemented by LSEG Standard. |
| 3. | AZU-AFD-SC_090 | Use a minimum of TLS version 1.2 for network connections to the Front Door control and data planes | Front Door must enforce a minimum TLS version of 1.2 (What) within Domains, HTTPS (How) in order to use modern techniques to establish robust encrypted data channels over untrusted networks (Why) | True | False | Implemented by setting the value of `minimum_tls_version` argument to `TLS12`. The TLS version is enforced in code, but it is not possible to retrieve the value via PowerShell in Pester post-deployment test. |

## Changelog

- [azure-prdsvc-terraform-cdnfrontdoorcustomdomain](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/frontdoor/)

### Terraform Docs

- [azurerm_cdn_frontdoor_custom_domain](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_custom_domain)

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
| [azurerm_cdn_frontdoor_custom_domain.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_custom_domain) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_cdn_frontdoor_profile_id"></a> [cdn_frontdoor_profile_id](#input_cdn_frontdoor_profile_id) | (Required) The name id of the frontdoor profile. | `string` | n/a | yes |
| <a name="input_cdn_frontdoor_secret_id"></a> [cdn_frontdoor_secret_id](#input_cdn_frontdoor_secret_id) | (Optional) Resource ID of the Front Door Secret. | `string` | `null` | no |
| <a name="input_certificate_type"></a> [certificate_type](#input_certificate_type) | (Optional) Defines the source of the SSL certificate. | `string` | `"ManagedCertificate"` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_dns_zone_id"></a> [dns_zone_id](#input_dns_zone_id) | (Optional) The ID of the Azure DNS Zone which should be used for this Front Door Custom Domain. If you are using Azure to host your DNS domains, you must delegate the domain provider's domain name system (DNS) to an Azure DNS Zone. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_host_name"></a> [host_name](#input_host_name) | (Required) The host name of the domain. The host_name field must be the FQDN of your domain. | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_expiration_date"></a> [expiration_date](#output_expiration_date) | The Expiration date of created CDN Frontdoor custom domain. |
| <a name="output_id"></a> [id](#output_id) | The ID of the created CDN Frontdoor custom domain. |
| <a name="output_name"></a> [name](#output_name) | The name of the created CDN Frontdoor custom domain. |
| <a name="output_resource"></a> [resource](#output_resource) | The Cdn Frontdoor Custom Domain resource. |
<!-- END_TF_DOCS -->
