---
version: 1.0.1
available_versions:
  - 1.0.1
  - 1.0.0
---

<!-- BEGIN_TF_DOCS -->
# Azure Frontdoor Custom Domain Association module


## Overview

This terraform module creates a Front Door Custom Domain Association.

## Prerequisites

- `Azure CDN Front Door Profile` needs to be created prior to this module.
- `Azure CDN Front Door Endpoint` needs to be created prior to this module (part of the Front Door Profile).
- `Azure CDN Front Door Origin Group` needs to be created prior to this module.
- `Azure CDN Front Door Origin` needs to be created prior to this module.
- `Azure CDN Front Door Route` needs to be created prior to this module.
- `Azure CDN Front Door Rule Set` (optional) can be created and associated with the route.
- `DNS Zone` and `DNS C Name record` needs to be created prior to this module.
- `Certificate` needs to be created for using this module. The certificate must be issued from a certified authority, should not be self-signed and must have more than 2 certificate chains.

## Guidance

#### Usage

- This module creates `Azure Custom Domain Association` resource to link a Custom Domain with Azure Front Door Routes.
- The Custom Domain Association enables custom domain names to be used with Front Door endpoints, allowing traffic routing through custom domains instead of the default Azure Front Door endpoint.
- To successfully deploy this module:
  1. Create the Custom Domain using the `azure-prdsvc-terraform-cdnfrontdoorcustomdomain` module with a valid CA-signed certificate
  2. Create the Route using the `azure-prdsvc-terraform-cdnfrontdoorroute` module, passing the custom domain ID via the `cdn_frontdoor_custom_domain_ids` parameter
  3. Deploy this Custom Domain Association module to establish the binding between the Route and Custom Domain
- **Testing Process**: This module has been successfully tested with the following approach:
  1. **Certificate Acquisition**: Requested a valid SSL certificate from a trusted Certificate Authority via Venafi
  2. **Infrastructure Setup**: Deployed all prerequisite resources (Profile, Endpoint, Origin Group, Origin, Route, DNS Zone, DNS CNAME record)
  3. **Certificate Import**: Imported the CA-signed certificate into Azure Key Vault in PKCS12 format
  4. **Role Assignment**: Granted Front Door system-assigned managed identity the "Key Vault Certificate User" role to access the certificate
  5. **Custom Domain Creation**: Created the Custom Domain with `CustomerCertificate` type referencing the Key Vault certificate
  6. **Route Configuration**: Configured the Route with the Custom Domain ID to establish the association
  7. **Association Deployment**: Successfully deployed the Custom Domain Association to link the Route with the Custom Domain
  8. **Validation**: Verified the association using Pester tests to confirm the Custom Domain is accessible via the configured hostname

#### Security Considerations

#### Additional Information

- TLS and SSL policy in greenfield denies CDN Front Door Route deployment. Custom domain is the only resource type amongst other Front Door modules that uses TLS/SSL. Hence custom domain is used as a dependent module for end to end testing.
- The custom domain module requires a certificate signed by a well-known Certificate Authority (CA). This is enforced by the Azure policy `Custom-Front Door domains must use a TLS certificate that is persisted in an HSM backed Key Vault-1.0.0` which mandates the use of `CustomerCertificate` type.
- **Certificate Acquisition Process**: To obtain a valid SSL certificate for testing and deployment:
  1. Request a certificate from a trusted CA . We can raise the same using Venafi
  2. Ensure the certificate meets the following requirements:
     - Issued by a certified authority (not self-signed)
     - Contains more than 2 certificate chains (root CA, intermediate CA(s), and end-entity certificate)
     - Stored in PKCS12/PFX format with proper content type (`application/x-pkcs12`)
  3. Import the certificate into Azure Key Vault
  4. Grant the Front Door system-assigned managed identity access to the Key Vault (Key Vault Administrator role)
  5. Reference the certificate in the Custom Domain configuration
- With a properly signed certificate from a trusted CA, full end-to-end deployment and testing can be achieved, including successful Custom Domain Association with Front Door Routes.

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|

## Changelog

- [azure-prdsvc-terraform-cdnfrontdoorcustomdomainassociation](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/frontdoor/)

### Terraform Docs

- [azurerm_cdn_frontdoor_custom_domain_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_custom_domain_association)

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
| [azurerm_cdn_frontdoor_custom_domain_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_custom_domain_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_cdn_frontdoor_custom_domain_id"></a> [cdn_frontdoor_custom_domain_id](#input_cdn_frontdoor_custom_domain_id) | (Required) The ID of the Front Door Custom Domain that should be managed by the association resource. Changing this forces a new association resource to be created. | `string` | n/a | yes |
| <a name="input_cdn_frontdoor_route_ids"></a> [cdn_frontdoor_route_ids](#input_cdn_frontdoor_route_ids) | (Required) One or more IDs of the Front Door Route to which the Front Door Custom Domain is associated with. | `list(string)` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The ID of the created CDN Frontdoor custom domain association. |
| <a name="output_resource"></a> [resource](#output_resource) | The Cdn Frontdoor Custom Domain Association resource. |
<!-- END_TF_DOCS -->
