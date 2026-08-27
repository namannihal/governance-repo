---
version: 1.0.5
available_versions:
  - 1.0.5
  - 1.0.4
  - 1.0.3
  - 1.0.2
  - 1.0.1
---

<!-- BEGIN_TF_DOCS -->
# Purview Account

## Overview

This terraform module creates a purview account and associated resources.

## Prerequisites
- `Managed Identities` should exist.

## Guidance

#### Usage
- Purview account is used to centrally manage data governance across data estate, spanning both cloud and on-premises environments.
- To use Microsoft Purview as centralized data governance solution, it is needed to deploy one or more Microsoft Purview accounts inside an Azure subscription.

#### Security Considerations
- Public access for ingestion is disabled as per below implemented property.
    ```
    managedResourcesPublicNetworkAccess = "Disabled"
    ```

#### Additional Information
- Purview Account has a known [bug] (https://github.com/Azure/azure-rest-api-specs/issues/22257) when using the Identity type as "UserAssigned".
- While performing idempotency testing, it's been observed that passing identity type as `SystemAssigned, UserAssigned` the value of the `identity_ids` property is getting deleted and recreated. However, if we use `SystemAssigned` no such behaviour is seen.
- At present `Managed Identities` for Purview Account is in preview.

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-PUR-IA_010 | Use a Managed Identity for accessing Azure Resources | Microsoft Purview must enforce the use of a Managed Identity to authenticate to Azure resources where this is supported (What) within targets Source Management settings (How) in order to remove the need to store credentials (Why) | True | True | Implemented using `identity` block. At present it's accepts only the `SystemAssigned` identity type. Please refer the `Additional Information` section for more details. |
| 2. | AZU-PUR-AC_010 | Access to Microsoft Purview must be controlled through Conditional Access | Access to Microsoft Purview must be controlled through Conditional Access (What) within Conditional Access settings (How) to prevent access from unmanaged devices(Why) | False | False | This control will be implemented by LSEG standard policy. |
| 3. | AZU-PUR-AC_020 | Microsoft Purview must disable public network access for ingestion | Microsoft Purview must disable public network access for ingestion (What) within its Network settings (How) in order to prevent unauthorised access and data exposure to the internet (Why) | True | True | This control is implemented by hardcoding the value as `Disabled` against the argument `managedResourcesPublicNetworkAccess`. |
| 4. | AZU-PUR-AU_010 | Send all diagnostic log categories to a central SOC Log Analytics workspace | Purview must send all diagnostic logs to a central SOC Log Analytics workspace (What) Auditing settings (How) in order to support a security investigation after a security incident (Why) | False | False | SOC related control: Will be implemented through policy at management group level. |
| 5. | AZU-PUR-AU_020 | Send all diagnostic log categories to a central SOC Storage Account |  Purview must send all diagnostic logs to a central SOC Storage Account (What) via Diagnostic settings (How) in order to provide an immutable copy to adhere to compliance requirements (Why) | False | False | SOC related control: Will be implemented through policy at management group level. |
| 6. | AZU-PUR-AU_030 | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval (What) within Service specific (How) in order to prevent sensitive data leakage to third parties outside of LSEG control (Why) | False | False | This control will be implemented by LSEG standard policy. |
| 7. | AZU-PUR-SC_010 | Credentials for other resources/systems must be stored in Azure Key Vault when Managed Identities cannot be used | Credentials for other resources/systems must be stored in Azure Key Vault (What) within Source Management settings (How) in order to ensure the security of credentials (Why) | False | False | This control will be implemented by LSEG standard policy. |
| 8. | AZU-PUR-SC_020 | Azure Purview must only allow creation of runtimes that are of type Self Hosted and not of type Azure | Azure Purview must only allow creation of runtimes that are of type Self Hosted and not of type Azure (What) within the Pipeline activities Linked services (How) to ensure pipelines are run on infrastructure that is owned and managed by LSEG to reduce the risk of data exfiltration (Why) | False | False | Currently, app teams are deploying using the Self Hosted agent within their pipelines. This practice has to be exercised via LSEG standard process by the respective teams performing the deployment in their environment. |

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Microsoft Purview metrics in Azure Monitor ](https://learn.microsoft.com/en-us/purview/how-to-monitor-with-azure-monitor)<br><br>[Cloud monitoring service level objectives ](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives)<br><br>[Supported Metrics for Microsoft Purview ](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-purview-accounts-metrics) |
| 5.| [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | True | This control is implemented by `Default` since Microsoft Purview makes reasonable efforts to support zone-redundant availability zones, where resources automatically replicate across zones in supported regions. <br><br>[Reliability in Microsoft Purview ](https://learn.microsoft.com/en-us/azure/reliability/reliability-microsoft-purview?context=%2Fpurview%2Fcontext%2Freliability-context) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place. <br><br>[Microsoft Purview RBAC Roles ](https://learn.microsoft.com/en-us/defender-office-365/scc-permissions) |

## Changelog

- [azure-prdsvc-terraform-purviewaccount](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/purview/)

### Terraform Docs

- [azurerm_purview_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/purview_account)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0 |
| <a name="requirement_azapi"></a> [azapi](#requirement_azapi) | >=1.9 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azapi"></a> [azapi](#provider_azapi) | >=1.9 |

## Resources

| Name | Type |
|------|------|
| [azapi_resource.purview](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_identity"></a> [identity](#input_identity) | (Optional) An identity block as defined below<br/>object({<br/>  type         = "(Required) Specifies the type of Managed Service Identity that should be configured on this Purview Account. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned` (to enable both)."<br/>  identity_ids = "(Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Purview Account. This is required when `type` is set to `UserAssigned` or `SystemAssigned, UserAssigned`."<br/>}) | <pre>object({<br/>    type         = string<br/>    identity_ids = list(string)<br/>  })</pre> | <pre>{<br/>  "identity_ids": null,<br/>  "type": "SystemAssigned"<br/>}</pre> | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_managedEventHubState"></a> [managedEventHubState](#input_managedEventHubState) | (Optional) Gets or sets the state of managed eventhub. If enabled managed eventhub will be created, if disabled the managed eventhub will be removed. | `string` | `"Disabled"` | no |
| <a name="input_managedResourceGroupName"></a> [managedResourceGroupName](#input_managedResourceGroupName) | (Optional) Gets or sets the managed resource group name. | `string` | `null` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_parent_id"></a> [parent_id](#input_parent_id) | (Required) The ID of the azure resource in which this resource is created. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_publicNetworkAccess"></a> [publicNetworkAccess](#input_publicNetworkAccess) | (Optional) Gets or sets the public network access. | `string` | `"Enabled"` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The ID of the Purview Account. |
| <a name="output_name"></a> [name](#output_name) | The Name of the Purview Account. |
| <a name="output_resource"></a> [resource](#output_resource) | The Purview Account resource. |
<!-- END_TF_DOCS -->
