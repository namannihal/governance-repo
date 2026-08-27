---
version: 1.0.2
available_versions:
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.4.4
  - 0.4.3
---

<!-- BEGIN_TF_DOCS -->
# Key Vault Key module


## Overview

This terraform module creates an Azure key Vault Key.

## Prerequisites

A `Key Vault` needs to be created first, if not exists, to hold the `Key Vault Key`.

## Guidance

#### Usage

#### Security Considerations

- The default expiration date for the Key vault Key is set to one year from the date of provisioning if no value is provided for the expiration date.
- Automated cryptographic key rotation in Key Vault allows users to configure Key Vault to automatically generate a new key version at a specified frequency. To configure rotation, you can use key rotation policy, which can be defined on each individual key.
- Cryptographic best practices recommend rotating encryption keys at least every two years.

#### Additional Information

For more information on key rotation, please refer to https://learn.microsoft.com/en-us/azure/key-vault/keys/how-to-configure-key-rotation

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-KV-SC\_010 | Keys must be rotated automatically | Key Vault keys must be automatically rotated every 12 months (What) via Rotation policy settings (How) to reduce the risk that a stolen or cryptanalysis compromised key can be maliciously used (Why) | True | True | Added Key vault key rotation policy feature in the module and its can be set during the provisioning of Key Vault keys. |
| 2. | AZU-KV-SC\_020 | Keys must be persisted in an HSM backed vault | Key Vault keys must be persisted in an FIPS 140-2 Level 2 HSM backed vault (What) via the Pricing tier setting (How) to reduce the risk that a key can be compromised (Why) | True | False | The default Key type is set to RSA-HSM, user can change it to RSA during provisioning (if required). |
| 3. | AZU-KV-SC\_030 | A customer managed key must be dedicated per encrypted service instance | A single customer managed key must be used per encrypted service instance (What) via the Encrypted settings per service (How) to reduce the blast radius should a customer managed key become compromised (Why) | False | False | Control not implemented by technical configuration setting. |

## Changelog

- [azure-prdsvc-terraform-keyvaultkey](CHANGELOG.md)

## References

### Microsoft Docs

- [Azure Key Vault Keys](https://learn.microsoft.com/en-us/azure/key-vault/keys/about-keys)

### Terraform Docs

- [azurerm_key_vault_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key)

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
| [azurerm_key_vault_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 71 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_expiration_date"></a> [expiration_date](#input_expiration_date) | (Required) Expiration UTC datetime (Y-m-d'T'H:M:S'Z'). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_key_opts"></a> [key_opts](#input_key_opts) | (Required) A list of JSON web key operations. Possible values include: decrypt, encrypt, sign, unwrapKey, verify and wrapKey. | `list(string)` | n/a | yes |
| <a name="input_key_size"></a> [key_size](#input_key_size) | (Optional) Specifies the Size of the RSA key to create in bytes. Allowed values are 1024, 2048, 3072 or 4096. | `number` | `4096` | no |
| <a name="input_key_type"></a> [key_type](#input_key_type) | (Optional) Specifies the Key Type to use for the Key Vault Key. | `string` | `"RSA-HSM"` | no |
| <a name="input_key_vault_id"></a> [key_vault_id](#input_key_vault_id) | (Required) The ID of the Key Vault where the Key should be created. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input_name) | (optional) Key name to be used (max 127 chars) | `string` | `null` | no |
| <a name="input_not_before_date"></a> [not_before_date](#input_not_before_date) | (Optional) Key not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z'). | `string` | `null` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_rotation_policy"></a> [rotation_policy](#input_rotation_policy) | (Optional) A rotation policy block as defined below<br/>object({<br/>  notify_before_expiry = "(Required) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>  time_before_expiry   = "(Required) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br/>  time_after_creation  = "(Optional) Rotate automatically at a duration after create as an ISO 8601 duration."<br/>  expire_after         = "(Required) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>}) | <pre>object({<br/>    notify_before_expiry = string<br/>    time_before_expiry   = string<br/>    time_after_creation  = optional(string, null)<br/>    expire_after         = string<br/>  })</pre> | <pre>{<br/>  "expire_after": "P365D",<br/>  "notify_before_expiry": "P351D",<br/>  "time_after_creation": "P358D",<br/>  "time_before_expiry": null<br/>}</pre> | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The ID of the created Key Vault Key. |
| <a name="output_name"></a> [name](#output_name) | The name of the created Key Vault Key. |
| <a name="output_resource"></a> [resource](#output_resource) | The Key Vault Key resource. |
<!-- END_TF_DOCS -->
