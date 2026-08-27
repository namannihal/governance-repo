---
version: 0.3.0
available_versions:
  - 0.3.0
  - 0.2.1
  - 0.2.0
  - 0.1.0
---

<!-- BEGIN_TF_DOCS -->
# Express route port module

## Overview

This terraform module create a express_route_port and Express route port authorization resource type.

## Prerequisites

- User Assigned Identity needs to be created prior to this module.
- A keyvault with 2 keyvault secrets need to be created prior to this module.

## Guidance

#### Usage

- `macsec_ckn_keyvault_secret_id` and `macsec_cak_keyvault_secret_id` should be used together with identity, so that the Express Route Port instance have the right permission to access the Key Vault.

#### Security Considerations

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. |  |  |  |  |  |  |

## Changelog

- [azure-prdsvc-terraform-expressrouteport](CHANGELOG.md)

## References

### Microsoft Docs

- [official documentation](https://learn.microsoft.com/en-us/azure/expressroute/expressroute-erdirect-about)

### Terraform Docs

- [azurerm_azurerm_express_route_port](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/express_route_port)
- [azurerm_azurerm_express_route_port_authorization](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/express_route_port_authorization)

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
| [azurerm_express_route_port.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/express_route_port) | resource |
| [azurerm_express_route_port_authorization.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/express_route_port_authorization) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_bandwidth_in_gbps"></a> [bandwidth_in_gbps](#input_bandwidth_in_gbps) | (Required) Bandwith in gbps | `number` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 71 chars). | `string` | `null` | no |
| <a name="input_encapsulation"></a> [encapsulation](#input_encapsulation) | (Required) Encapsulation type express route port | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_identity_ids"></a> [identity_ids](#input_identity_ids) | (Optional) the identity to get the permission of keyvayult secret | `list(string)` | `null` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_link1"></a> [link1](#input_link1) | "(Optional) The link2 details for express route direct"<br>  object ({<br>  admin_enabled                 = (Required) Whether enable administration state on the Express Route Port Link? Defaults to false<br>  macsec_cipher                 = (Required) The MACSec cipher used for this Express Route Port Link. Possible values are GcmAes128 and GcmAes256. Defaults to GcmAes128.<br>  macsec_ckn_keyvault_secret_id = (Required) The ID of the Key Vault Secret that contains the MACSec CKN key for this Express Route Port Link<br>  macsec_cak_keyvault_secret_id = (Required) The ID of the Key Vault Secret that contains the Mac security CAK key for this Express Route Port Link<br>  }) | <pre>map(object({<br>    admin_enabled                 = bool<br>    macsec_cipher                 = string<br>    macsec_ckn_keyvault_secret_id = string<br>    macsec_cak_keyvault_secret_id = string<br>  }))</pre> | `null` | no |
| <a name="input_link2"></a> [link2](#input_link2) | "(Optional) The link2 details for express route direct"<br>  object ({<br>  admin_enabled                 = (Required) Whether enable administration state on the Express Route Port Link? Defaults to false<br>  macsec_cipher                 = (Required) The MACSec cipher used for this Express Route Port Link. Possible values are GcmAes128 and GcmAes256. Defaults to GcmAes128.<br>  macsec_ckn_keyvault_secret_id = (Required) The ID of the Key Vault Secret that contains the MACSec CKN key for this Express Route Port Link<br>  macsec_cak_keyvault_secret_id = (Required) The ID of the Key Vault Secret that contains the Mac security CAK key for this Express Route Port Link<br>  }) | <pre>map(object({<br>    admin_enabled                 = bool<br>    macsec_cipher                 = string<br>    macsec_ckn_keyvault_secret_id = string<br>    macsec_cak_keyvault_secret_id = string<br>  }))</pre> | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_peering_location"></a> [peering_location](#input_peering_location) | (Required) peering location | `string` | n/a | yes |
| <a name="input_port_authorization_name"></a> [port_authorization_name](#input_port_authorization_name) | (Required) The name of the port authorization | `string` | n/a | yes |
| <a name="input_port_name"></a> [port_name](#input_port_name) | (Required)The name of the port | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azurerm_express_route_port_authorization_key"></a> [azurerm_express_route_port_authorization_key](#output_azurerm_express_route_port_authorization_key) | The authorization key of the express route port. |
| <a name="output_azurerm_express_route_port_authorization_use_status"></a> [azurerm_express_route_port_authorization_use_status](#output_azurerm_express_route_port_authorization_use_status) | The authorization use status of the express route port. |
| <a name="output_azurerm_express_route_port_name"></a> [azurerm_express_route_port_name](#output_azurerm_express_route_port_name) | The name of the Express route port name |
| <a name="output_id"></a> [id](#output_id) | The ID of the express route port. |
| <a name="output_resource"></a> [resource](#output_resource) | The Express Route Port resource. |
<!-- END_TF_DOCS -->
