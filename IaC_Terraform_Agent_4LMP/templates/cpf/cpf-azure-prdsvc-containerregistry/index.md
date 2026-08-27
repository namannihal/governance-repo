---
version: 1.1.4
available_versions:
  - 1.1.4
  - 1.1.3
  - 1.1.2
  - 1.1.1
  - 1.1.0
---

<!-- BEGIN_TF_DOCS -->
# Azure Container Registry module


## Overview

This terraform module creates an Azure Container Registry and associated resources.

## Prerequisites

- `Resource Group` must be created to deploy this module.

## Guidance

#### Usage

- This module creates a Azure Container Registry module with system assigned identity.
- `Georeplications` mode is enabled for this module.

###### AzureRM 3.x to 4.x Upgrade Notes for containerregistry

Product Impact -- Medium

Users in azurerm 3.x migrating to 4.x  need to perform the following changes

- The encryption.enabled property has been removed from the encryption block in the configuration.
- trust_policy_enabled property added and deprecated trust_policy block has been removed.
- retention_policy_in_days property added and deprecated retention_policy block has been removed.
- Removed virtual_network block from the network_rule_set as virtual_network is deprecated

- Wiki link for [AzureRM 4.x Upgrade](https://gitlab.dx1.lseg.com/groups/app/app-51310/azure/prdsvc/terraform/-/wikis/Terraform-AzureRM-Provider-Upgrade:-Version-3.x-to-4.x/container-registry) for details on the upgrade process.

For more details, refer to the official [AzureRM 4.x Upgrade Guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide)

#### Security Considerations

- The Service Principal (SPN) used to deploy this module **must have `Contributor` role or equivalent assigned** on the **subscription scope**.

#### Well-Architected Framework(WAF) for containerregistry

- Wiki link [WAF for containerregistry](https://gitlab.dx1.lseg.com/groups/app/app-51310/azure/prdsvc/terraform/-/wikis/Cloud-Products-Well-Architecture-Framework-Principles---WAF/containerregistry) for details on the WAF principles (Resiliency and Disaster Recovery(DR), Security, Cost Optimization and Operation Excellence).

#### Public Network Access Configuration

The module now supports optional configuration of public network access and export policy through two new variables:

- **`public_network_access_enabled`** (default: `false`) - Enable public network access for ACR to allow LSEG shared runners to push container images
- **`export_policy_enabled`** (default: `false`) - Enable export policy to allow artifact operations for shared runners

**Important**: Enabling these parameters requires the following policy exemptions:

- `524b0254-c285-4903-bee6-bb8126cde579` (Public network access policy)
- `0fdf0491-d080-4575-b627-ad0e843cba0f` (Export policy)

When enabled, use the existing `network_rule_set` parameter to restrict access to specific shared runner IPs:

```hcl
public_network_access_enabled = true
export_policy_enabled         = true

network_rule_set = {
  default_action = "Deny"
  ip_rule = [
    {
      action   = "Allow"
      ip_range = "203.0.113.5/32"  # Shared runner IP
    }
  ]
}
```

**Backward Compatibility**: Both parameters default to `false`, ensuring existing deployments are not affected.

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-ACR-IA_010 |  Use a Managed Identity for accessing Azure Resources |  Container Registry must enforce the use of a Managed Identity to authenticate to Azure resources where this is supported (What) within Identity setting (How) in order to remove the need to store credentials (Why) | True | False | Implemeneted using: 'identity' as resource attribute.  |
| 2. | AZU-ACR-IA_020 | Local account authentication must be disabled | Local account authentication must be disabled (What) within Access keys setting (How) in order to use modern robust and less prone to compromise authentication methods embedded within Microsoft Entra ID (Why) | True | True | Implemented using: "admin_enabled = False" in acr resource block. |
| 3. | AZU-ACR-IA_030 | Anonymous (unauthenticated) access must be disabled | Anonymous (unauthenticated) access must be disabled (What) in the Code deployment parameters (How) in order to prevent unauthorised access and use authentication to access resources (Why) | True | True | Implemented using: "anonymous_pull_enabled = False" in acr resource block. |
| 4. |  AZU-ACR-IA_040 | Repository scoped access tokens must be disabled | Repository scoped access tokens must be disabled (What) in the Code deployment parameters (How) in order to use modern robust and less prone to compromise authentication methods embedded within Microsoft Entra ID (Why) | False | False | It will be implemented using policy, can't be handled from the terraform code. |
| 5. | AZU-ACR-AC_010 | Disable Public Network Access | Container Registry must enforce a network guardrail (What) within Networking setting (How) in order to prevent unauthorised access and data exposure to the internet (Why) | True | True | Implemented using: "public_network_access_enabled = False" in acr resource block. |
| 6. |  AZU-ACR-AC_020 | Enable allow trusted Microsoft services to access this container registry | Enable allow trusted Microsoft services to access this container registry (What) within Networking settings (How) to allow Defender for Cloud access to provide vulnerability scanning (Why) | True | True | Implemented using: "network_rule_bypass_option = AzureServices" in acr resource block. |
| 7. | AZU-ACR-AU_010 | Send all diagnostic log categories to a central SOC Log Analytics workspace | Container Registry must send all diagnostic logs to a central SOC Log Analytics workspace (What) within Diagnostic setting (How) in order to support a security investigation after a security incident (Why) | False | False | It will be implemented using policy, can't be handled from the terraform code. |
| 8. | AZU-ACR-AU_030 | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval (What) within Diagnostic settings (How) in order to prevent sensitive data leakage to third parties outside of LSEG control (Why) | False | False | It will be implemented using policy, can't be handled from the terraform code. |
| 9. | AZU-ACR-SC_010 | Container registries must prevent export of artifacts |  Container registries must prevent export of artifacts (What) in the Code deployment parameters (How) to ensure data is kept within locations that have been approved for such classification and to reduce the risk of data exfiltration (Why) | True | True | Implemented using "export_policy_enabled = False" in acr resource block. |
| 10. | AZU-ACR-SC_020 | Azure App Deployment must not be able to corrupt the centrally managed private link private DNS zones when making a private endpoint for Container Registry | Container Registry must have an Azure DeployIfNotExists policy to update the centrally managed private link private DNS zones with its private A record (What) via Policy to management group mapping (How) to ensure there is no ability for the Azure App Deployment team to have authorisation over these zones that could allow them to corrupt this file and impact service availability (Why) | False | False | It will be implemented using policy, can't be handled from the terraform code. |
| 11. | AZU-ACR-SC_040 | Container Registry must not be used across environment type (e.g. APP1-PROD, APP1-DEV) except in non-production (e.g. APP1-DEV, APP1-STG, APP2-DEV) where there is no risk from separating them relevant to the application risk profile (e.g. Public vs Private) | Container Registry must not be used across environment type (e.g. APP1-PROD, APP1-DEV) except in non-production (e.g. APP1-DEV, APP1-STG, APP2-DEV) where there is no risk from separating them relevant to the application risk profile (e.g. Public vs Private) (What) within code deployment parameters (How) in order to reduce the risk of image changes or deletion in a lower controlled non-production environment affecting the launching / auto-scaling of containers in the production environment (Why) | False | False | This is a platform level control which will be implemented at ALZ vending. |

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Monitor Azure Container Registry](https://learn.microsoft.com/en-us/azure/container-registry/monitor-service)<br><br>[Supported Metrics for Azure Container Registry](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-containerregistry-registries-metrics)<br><br>[Cloud monitoring service level objectives](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives) |
| 5. | [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | True | This control will be implemented by following parameters: `georeplications` block for High Availability and failover, `zone_redundant_enabled` property for enabling geo replication.<br><br>[Geo-replication of Azure container registry](https://learn.microsoft.com/en-gb/azure/container-registry/container-registry-geo-replication). |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) <br><br>[Lock a container image in an Azure container registry](https://learn.microsoft.com/en-gb/azure/container-registry/container-registry-image-lock). |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place.<br><br>[Container Registry RBAC](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles)<br><br>[Azure RBAC for Container Registry](https://learn.microsoft.com/en-us/azure/container-registry/container-registry-roles?tabs=azure-cli). |

## Changelog

- [azure-prdsvc-terraform-containerregistry](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentaion] (<https://learn.microsoft.com/en-us/azure/container-registry/>)

### Terraform Docs

- [azurerm_container_registry] (<https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry>)

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
| [azurerm_container_registry.acr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_data_endpoint_enabled"></a> [data_endpoint_enabled](#input_data_endpoint_enabled) | (Optional) Whether to enable dedicated data endpoints for this Container Registry? This is only supported on resources with the Premium SKU. | `bool` | `false` | no |
| <a name="input_encryption"></a> [encryption](#input_encryption) | (Optional) One or more encryption block as defined in the following schema:<br/><br/>&bull; `key_vault_key_id` = string - (Required) indicates the ID of the Key Vault key.<br/><br/>&bull; `identity_client_id` = string - (Required) indicates the client ID of the managed identity associated with the encryption key.<br/><br/>**NOTE**: The managed identity used in encryption also needs to be part of the identity block under identity_ids. If a property above is not needed then it needs to be explicitly set to `null` or `[]` (empty list). | <pre>object({<br/>    key_vault_key_id   = string<br/>    identity_client_id = string<br/>  })</pre> | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_export_policy_enabled"></a> [export_policy_enabled](#input_export_policy_enabled) | (Optional) Whether the export policy is enabled for this Container Registry. Defaults to false.<br/><br/>Set this to `true` when using public_network_access_enabled with network_rule_set to allow the runners to push container images. | `bool` | `false` | no |
| <a name="input_georeplications"></a> [georeplications](#input_georeplications) | (Optional) A list of Azure locations where the container registry should be geo-replicated. One or more georeplications block as defined in the following schema:<br/><br/>&bull; `location` = string - (Required) A location where the container registry should be geo-replicated.<br/><br/>&bull; `zone_redundancy_enabled` = bool - (Optional) For the given location, zone redundancy should be enabled. Defaults to false<br/><br/>&bull; `tags` = map(string) - (Optional) A mapping of tags to assign to this replication location.<br/><br/>**NOTE**: This field can only be set only when the sku_tier for the container registry is premium. If a property above is not needed then it needs to be explicitly set to `null` or `[]` (empty list). | <pre>list(object({<br/>    location                = string<br/>    zone_redundancy_enabled = bool<br/>    tags                    = map(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_identity"></a> [identity](#input_identity) | (Required) An identity block as defined below<br/>object({<br/>  type         = "(Required) Specifies the type of Managed Service Identity that should be configured on this Windows Virtual Machine. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned` (to enable both)."<br/>  identity_ids = "(Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Windows Virtual Machine. This is required when `type` is set to `UserAssigned` or `SystemAssigned, UserAssigned`."<br/>}) | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(set(string))<br/>  })</pre> | <pre>{<br/>  "identity_ids": null,<br/>  "type": "SystemAssigned"<br/>}</pre> | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_network_rule_set"></a> [network_rule_set](#input_network_rule_set) | (Optional) One or more network_rule_set block as defined in the following schema:<br/><br/>**NOTE**: Network Rule Set is only supported on resources with the `Premium` SKU. Azure automatically configures Network Rules - to remove these you'll need to specify an network_rule_set block with default_action set to `Deny`. If a property above is not needed then it needs to be explicitly set to `null` or `[]` (empty list).<br/><br/>Schema and property description is the following:<pre>{<br/>  default_action = string - (Optional) The behaviour for requests matching no rules. Possible values are `Allow` or `Deny`. Defaults to `Allow`.<br/><br/>  ip_rule = [{ //Optional<br/>    ip_range  = string  - (Required) The CIDR block from which requests will match the rule.<br/>    action    = string  - (Required) The behaviour for requests matching this rule. At this time the only supported value is `Allow`.<br/>  }]<br/>}</pre> | <pre>object({<br/>    default_action = string<br/><br/>    ip_rule = list(object({<br/>      ip_range = string<br/>      action   = string<br/>    }))<br/>  })</pre> | `null` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public_network_access_enabled](#input_public_network_access_enabled) | (Optional) Whether public network access is enabled for this Container Registry. Defaults to false.<br/><br/>Set this to `true` to allow public access from shared runners to push container images. When enabled, use network_rule_set to define IP-based access rules for the runners. | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_retention_policy_in_days"></a> [retention_policy_in_days](#input_retention_policy_in_days) | (Optional) The number of days to retain an untagged manifest after which it gets purged. This is only supported on resources with the `Premium` SKU. | `number` | `null` | no |
| <a name="input_sku_tier"></a> [sku_tier](#input_sku_tier) | (Required) The SKU name of the container registry. Possible values are Basic, Standard and Premium. | `string` | `"Premium"` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_trust_policy_enabled"></a> [trust_policy_enabled](#input_trust_policy_enabled) | (Optional) Boolean value that indicates whether the trust policy is enabled.<br/><br/>**NOTE**: Trust Policy is only supported on resources with the `Premium` SKU. | `bool` | `false` | no |
| <a name="input_zone_redundancy_enabled"></a> [zone_redundancy_enabled](#input_zone_redundancy_enabled) | (Optional) Whether zone redundancy is enabled for this Container Registry? Changing this forces a new resource to be created. Defaults to false. This is only supported on resources with the `Premium` SKU. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The ID of the Container Registry. |
| <a name="output_name"></a> [name](#output_name) | The name of the Container Registry. |
| <a name="output_resource"></a> [resource](#output_resource) | The Container Registry resource. |
<!-- END_TF_DOCS -->
