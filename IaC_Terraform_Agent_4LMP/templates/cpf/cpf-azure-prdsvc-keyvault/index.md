---
version: 1.0.2
available_versions:
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.8.5
  - 0.8.4
---

<!-- BEGIN_TF_DOCS -->
# Key Vault Module

## Overview

This Terraform module creates an Azure Key vault and associated resources. Azure Key vault is a cloud service for securely storing and accessing secrets. A secret is anything that you want to tightly control access to, such as API keys, passwords, certificates, or cryptographic keys. This module also enables to grant permissions to user and groups to read and modify the secrets in Key vault.

## Prerequisites

- `Resource Group`,`Virtual Network` using `Private Endpoint`.
## Guidance

#### Usage

- This module creates an `Azure Key vault` with Azure role-based access control (Azure RBAC) authorization system.
- Please look in [documentation](https://docs.microsoft.com/en-us/azure/key-vault/general/rbac-guide?tabs=azure-cli) for the available built-in `RBAC` roles for `Key vault`.

- <b>IMPORTANT</b>:

  - Please make sure the vault's name is in between 3-24 alphanumeric characters while providing the values for `locals` in test main.tf.
  - If in case the name goes beyond 24 characters, it will give an error `This object does not have an attribute named "azurerm_key_vault".`
#### Security Considerations

- The **Service Principal/User** running this Terraform plan/workspace needs to have **equivalent** or **more than** of the "`User Access Administrator`" role to assign the roles using this module for managing `Key vault`.
- The "`Key vault Administrator`" role is assigned by default to the **Service Principal/User** running this Terraform plan/workspace. This is to grant the **Service Principal/User** permissions to create and manage secrets.
- This module does not deploy an associated Private endpoint for the Key vault resource. To create a Private endpoint for this Key vault, use the `azu-product-tf-privateendpoint` module after the Key vault creation at bundle or pattern level.

- <b>IMPORTANT</b>:
  - To avoid the redeployment issue caused due to usage of the data block which fetches the principle ID of the SPN running Terraform plan/workspace, in order to assign it the `Key Vault Administrator` role, the user is given an option to manually pass the ID of this SPN through the `kv_admin_role_app_spn_object_id` variable to avoid invoking the data block.

#### Well-Architected Framework(WAF) for Azure Key vault

- Wiki link: [WAF for Azure Key Vault](https://gitlab.dx1.lseg.com/groups/app/app-51310/azure/prdsvc/terraform/-/wikis/Cloud-Products-Well-Architecture-Framework-Principles---WAF/Keyvault) for details on the WAF principles (Resiliency and Disaster Recovery(DR), Security, Cost Optimization and Operation Excellence).

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-KV-AC\_011 | Key Vault endpoints must be accessed via Private Link (preferred) or via public endpoint with select LSEG network addresses configured | Key Vault endpoints must be accessed via Private Link (preferred) or via public endpoint with select LSEG network addresses configured (What) within Network settings (How) in order to prevent unauthorised access and data exposure to the internet (Why) | True | False | Implemented using `public_network_access_enabled = false` & Added `default_action` in the `network_acls`to `Deny`. |
| 2. | AZU-KV-AC\_020 | Disable trusted Microsoft service firewall bypass | Key Vaults must disable trusted Microsoft services to bypass the Key Vault firewall (What) within its Network settings (How) to control services that can have access to Key Vaults (Why) | True | False | Implemented using `bypass = "None"` in `default_network_acls` block. **Note**: This setting is not enforced, but just set as default value. It is still possible to set `bypass = "AzureServices"` through input variables.The Pester test has been temporarily removed due to incompatibility with Azure policy" |
| 3. | AZU-KV-AC\_030 | There must not be specific resource access allowed to bypass the Key Vault firewall | Key Vaults must not allow specific services to bypass the Key Vault firewall (What) within its Access configuration settings (How) to control services that can have access to Key Vaults (Why) | True | True | Implemented using `bypass = "None"` in `default_network_acls` block. **Note**: This setting is not enforced, but just set as default value. It is still possible to set `bypass = "AzureServices"` through input variables. |
| 4. | AZU-KV-AC\_040 | The RBAC permission model must be used | Key Vault must use the RBAC permission model (What) within its Access configuration settings (How) To provides a granular access method over keys that is fully integrated with Azure AD thus improving security over the legacy access policy method (Why) | True | True | Implemented using `enable_rbac_authorization  = true` |
| 5. | AZU-KV-AU\_010 | Send all diagnostic log categories to a central Log Analytics workspace | Key Vault must send all diagnostic logs to a central Log Analytics workspace (What) within its Diagnostic settings (How) in order to support a security investigation after a security incident involving a Storage Account (Why) | False | False | Diagnostics settings will be enabled using a separate module at bundle/pattern level |
| 6. | AZU-KV-AU\\_020 | Send all diagnostic log categories to a central SOC Storage Account | Key Vault must send all diagnostic logs to a central SOC Storage Account (What) within its Diagnostic settings (How) in order to provide an immutable copy to adhere to compliance requirements (Why) | False | False | Diagnostics settings will be enabled using a separate module at bundle/pattern level |
| 7. | AZU-KV-SC\_010 | Keys must be rotated automatically | Key Vault keys must be automatically rotated every 12 months (What) via Rotation policy settings (How) to reduce the risk that a stolen or cryptanalysis compromised key can be maliciously used (Why) | False | True | Key vault keys are not yet part of the key vault product |
| 8. | AZU-KV-SC\_020 | Keys must be persisted in an HSM backed vault | Key Vault keys must be persisted in an FIPS 140-2 Level 2 HSM backed vault (What) via the Pricing tier setting (How) to reduce the risk that a key can be compromised (Why) | False | False | Key vault keys are not yet part of the key vault product |
| 9. | AZU-KV-SC\_030 | A customer managed key must be dedicated per encrypted service instance | A single customer managed key must be used per encrypted service instance (What) via the Encrypted settings per service (How) to reduce the blast radius should a customer managed key become compromised (Why) | False | False | Control not implemented by technical configuration setting |
| 10. | AZU-KA-SI\_010 | Must have deletion protection enabled | Key Vault must have deletion protection enabled, soft delete between `30 to 90 days` and purge protection the with a retention period of `30 days` (What) within its Property settings (How) in order to recover secret material after an accidental or malicious deletion | True | True | Implemented using `purge_protection_enabled = true` and setting the default value of variable `soft_delete_retention_days` as `30`. Thus, no need to explicitly pass this parameter when using key vault module. But for special cases like MySQL Flexible Server we can use the variable to pass a retention period of 90 days. |
| 11. | AZU-KV-SC\_040 | Azure App Deployment must not be able to corrupt the centrally managed private link private DNS zones when making a private end point for Key Vault | Key Vault must have an Azure DeployIfNotExists policy to update the centrally managed private link private DNS zones with its private A record (What) via Policy to management group mapping (How) to ensure there is no ability for the Azure App Deployment team to have authorisation over these zones that could allow them to corrupt this file and impact service availability (Why) | False | False | This control will be implemented via policy. |

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Azure Key Vault logging](https://learn.microsoft.com/en-us/azure/key-vault/general/logging?tabs=Vault)<br><br>[Cloud monitoring service level objectives](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives)<br><br>[Supported metrics for Microsoft.Network/expressRouteCircuits](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-network-expressroutecircuits-metrics)<br><br>[ExpressRoute metrics](https://learn.microsoft.com/en-us/azure/expressroute/expressroute-monitoring-metrics-alerts#expressroute-metrics) |
| 5. | [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | True | The contents of the key vault are `replicated both within the region and to the paired region`.<br><br>If individual components within the key vault service fail, alternate components within the region automatically step in to serve your request to make sure that there's no degradation of functionality.<br><br>Since we use a private link to connect to key vault, it may take up to 20 minutes for the connection to be re-established in the event of a region failover. During failover, the key vault is in `read-only mode`.<br><br>[Azure Key Vault availability and redundancy](https://learn.microsoft.com/en-us/azure/key-vault/general/disaster-recovery-guidance) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-SEC-03 Secret Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1424/SMCF-SEC-03-Secret-Management) | SMCF-SEC-03-01: Provide capability to effectively manage workload secrets.<br><br>SMCF-SEC-03-04: Automate secret management to reduce security risks and human error | IaC<br><br>IaC | True | This control has been implemented in the `Key Vault Key module` using the `rotation_policy block`.<br><br>[Automate the rotation of a secret for resources that use one set of authentication credentials](https://learn.microsoft.com/en-us/azure/key-vault/secrets/tutorial-rotation)<br><br>[Automate the rotation of a secret for resources that have two sets of authentication credentials](https://learn.microsoft.com/en-us/azure/key-vault/secrets/tutorial-rotation-dual?tabs=azure-cli) |
| 8. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place.<br><br>The `azurerm_role_assignment` resource block is used to provide access to Key Vault keys, certificates, and secrets.<br><br>[Azure built-in roles](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles)<br><br>[Provide access to Key Vault keys, certificates, and secrets with an Azure role-based access control](https://learn.microsoft.com/en-us/azure/key-vault/general/rbac-guide?tabs=azure-cli)<br><br> |

## Changelog

- [azu-product-tf-keyvault](CHANGELOG.md)

## References

### Microsoft Docs

- [Azure Key Vault documentation](https://learn.microsoft.com/en-us/azure/key-vault/general/)

### Terraform Docs

- [azurerm_key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault)

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
| [azurerm_key_vault.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_client_config.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_enabled_for_deployment"></a> [enabled_for_deployment](#input_enabled_for_deployment) | (Optional) Specifies whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. | `bool` | `false` | no |
| <a name="input_enabled_for_disk_encryption"></a> [enabled_for_disk_encryption](#input_enabled_for_disk_encryption) | (Optional) Specifies whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. | `bool` | `false` | no |
| <a name="input_enabled_for_template_deployment"></a> [enabled_for_template_deployment](#input_enabled_for_template_deployment) | (Optional) Specifies whether Azure Resource Manager is permitted to retrieve secrets from the key vault. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_kv_admin_role_app_spn_object_id"></a> [kv_admin_role_app_spn_object_id](#input_kv_admin_role_app_spn_object_id) | (Optional) The object id of the Service Principal. | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_network_acls"></a> [network_acls](#input_network_acls) | (Optional) The network ACL configuration for the Key Vault.<br/>If not specified then the Key Vault will be created with a firewall that blocks access.<br/>Specify `null` to create the Key Vault with no firewall.<br/><br/>- `bypass` - (Optional) Should Azure Services bypass the ACL. Possible values are `AzureServices` and `None`. Defaults to `None`.<br/>- `ip_rules` - (Optional) A list of IP rules in CIDR format. Defaults to `[]`.<br/>- `virtual_network_subnet_ids` - (Optional) When using with Service Endpoints, a list of subnet IDs to associate with the Key Vault. Defaults to `[]`. | <pre>object({<br/>    bypass                     = optional(string, "None")<br/>    ip_rules                   = optional(list(string), [])<br/>    virtual_network_subnet_ids = optional(list(string), [])<br/>  })</pre> | `{}` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public_network_access_enabled](#input_public_network_access_enabled) | Specifies whether public network access is enabled for the Key Vault. | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku_name](#input_sku_name) | (Optional) The Name of the Sku used for the Key Vault. Possible values are standard and premium. | `string` | `"premium"` | no |
| <a name="input_soft_delete_retention_days"></a> [soft_delete_retention_days](#input_soft_delete_retention_days) | (Optional) The number of days that items should be retained for once soft-deleted. | `number` | `30` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The resource ID of the Key Vault. |
| <a name="output_name"></a> [name](#output_name) | The Name of the Key Vault. |
| <a name="output_resource"></a> [resource](#output_resource) | The Key Vault resource. |
| <a name="output_vault_uri"></a> [vault_uri](#output_vault_uri) | The URI of the Key Vault, used for performing operations on keys and secrets. |
<!-- END_TF_DOCS -->
