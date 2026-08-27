---
version: 1.0.2
available_versions:
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.1.4
  - 0.1.3
---

<!-- BEGIN_TF_DOCS -->
# Azure Load Test Module

## Overview

- This terraform module creates a Load Test resource.
- Azure Load Testing is a fully managed load-testing service that enables you to generate high-scale load. The service simulates traffic for your applications, regardless of where they're hosted.
- Developers, testers, and quality assurance (QA) engineers can use it to optimize application performance, scalability, or capacity.

## Prerequisites

- `Resource Group` name is required.
- `KeyVault` for encyrption and all related components for keyvault such as nsg, route table, subnet and private endpoint - to be created or called as required.
- `User Assigned Identity` if user assigned identity is chosen for load test.

#### Usage

- This Module Covers deployment of Azure Load Test and dependant reosurces.
- Creating of tests is not part of this Azure Load Test TF configuration as Tests are configured via the Data plane and neither TF nor Az API doesn't support it yet. Please refer [https://github.com/hashicorp/terraform-provider-azurerm/issues/22903](github TF issue)

#### Security Considerations

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-LT-IA_010 | Load Testing must use a Managed Identity for accessing Azure Resources | ELoad Testing must enforce the use of a Managed Identity to authenticate to Azure resources where this is supported (What) within target service access control settings (How) in order to remove the need to store credentials (Why) | True | True | Implemented using `identity` variable to accept user Assigned and System Assigned Managed identities. |
| 2. | AZU-LT-AC_010 | Load Testing deployments must disable Public Network Access | Load Testing must enforce a network guardrail (What) to prevent the deployment of public IP address, load balancer and ingress enabled NSGs (How) in order to prevent unauthorised access and data exposure to the internet (Why) | False | False | Creation of Tests currently isn't possible with TF configuration. |
| 3. | AZU-LT-AU_010 | Send all diagnostic log categories to a central SOC Log Analytics workspace | SLoad Testing must send all diagnostic logs to a central SOC Log Analytics workspace (What) within Diagnostic Settings > Diagnostic Setting (How) in order to support a security investigation after a security incident (Why) | False | False | Implemented by LSEG DINE policies |
| 4. | AZU-LT-AU_020 | Send all diagnostic log categories to a central SOC Storage Account |  Load Testing must send all diagnostic logs to a central SOC Storage Account (What) within Diagnostic Settings > Diagnostic Setting (How) in order to provide an immutable copy to adhere to compliance requirements (Why) | False | False | mplemented by LSEG DINE policies. |
| 5. | AZU-LT-AU_030 | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval |  Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval (What) within Diagnostic Settings > Diagnostic Setting (How) in order to prevent sensitive data leakage to third parties outside of LSEG control (Why) | False | False | Implemented by LSEG policies. |
| 6. | AZU-LT-SC_010 | Credentials for other resources/systems must be stored in Azure Key Vault |  Credentials for other resources/systems must be stored in Azure Key Vault (What) within Deployment > Parameters (How) in order to ensure the security of credentials (Why) | False | False | Creation of Tests currently isn't possible with TF configuration, so control can't be implemented. |
| 7. | AZU-LT-SC_020 | Virtual Network integration must be enabled |   Virtual Network integration must be enabled for Load Testing deployments (What) within Deployment > Load > Network > Configure test traffic mode (How) in order to provide secure access to other Azure services and govern outbound requests with NSGs, UDRs and Azure Firewalls (Why) | False | False | Creation of Tests currently isn't possible with TF configuration. |
| 8. | AZU-LT-SC_030 | Ensure permissions to run Test Plans within Load Testing are removed from the custom contributor role |   Ensure permissions to run Test Plans within Load Testing are removed from the custom contributor role (What) via custom role settings (How) to reduce the likelihood of impacting systems due to misconfiguration or misuse of the service (Why) | False | False | Not in scope of TF configuration, to be implemented at RBAC level by lseg RBAC model. |

## Changelog

- [azure-prdsvc-terraform-loadtest](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://azure.microsoft.com/en-gb/products/load-testing/)

### Terraform Docs

- [azurerm_load_test](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/load_test)

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
| [azurerm_load_test.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/load_test) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input_description) | (Optional) Description of the resource. Changing this forces a new Load Test to be created. | `string` | `null` | no |
| <a name="input_encryption"></a> [encryption](#input_encryption) | Encryption settings for azurerm_load_test.<br/>    key_url  = "(Required)Specifies the URL of the encryption key."<br/>    identity = "(Required)Specifies the identity settings for encryption."<br/>      type        = "(Required)Specifies the type of Managed Service Identity for encryption."<br/>      identity_id = "(Required)Specifies a list of User Assigned Managed Identity IDs for encryption." | <pre>object({<br/>    key_url = string<br/>    identity = object({<br/>      type        = string<br/>      identity_id = string<br/>    })<br/>  })</pre> | n/a | yes |
| <a name="input_identity"></a> [identity](#input_identity) | (Optional) An identity block as defined below<br/>object({<br/>  type         = "(Required) Specifies the type of Managed Service Identity that should be configured on this Data Factory. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned` (to enable both)."<br/>  identity_ids = "(Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Data Factory. This is required when `type` is set to `UserAssigned` or `SystemAssigned, UserAssigned`."<br/>}) | <pre>object({<br/>    type         = string<br/>    identity_ids = list(string)<br/>  })</pre> | <pre>{<br/>  "identity_ids": [],<br/>  "type": "SystemAssigned"<br/>}</pre> | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input_name) | (Required) The name of the Load Test. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The ID of the Load Test. |
| <a name="output_name"></a> [name](#output_name) | The Name of the Load Test. |
| <a name="output_resource"></a> [resource](#output_resource) | The Load Test resource. |
<!-- END_TF_DOCS -->
