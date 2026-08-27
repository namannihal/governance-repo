---
version: 1.0.2
available_versions:
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.5.2
  - 0.5.1
---

<!-- BEGIN_TF_DOCS -->
# Azure Machine learning workspace module


## Overview

This terraform module creates a machine learning workspace without managed outbound rules.

## Prerequisites

- Exisiting `resource_group` and `virtual_network`
- One `user_assign_identity` to encypt storage account data.
- One `key_vault` to store the encryption key.
- dependent resource for machine learning workspace
  - `storage_account`
  - `app_insight`
  - `container_registry`
- Private endpoint for the below resource,
  - `private_endpoint_key_vault`
  - `private_endpoint_storage_account_file_share`
  - `private_endpoint_container_registry`
- One `subnet` to configure private endpoint.
- One `network_security_group`to associate with the subnet
- Multiple `time_sleep` to wait for creation of DNS record post private endpoint deployment through DINE policy.
- One `route table`
- One `Log analytics workspace` for `App Insight configuration`.

## Guidance

#### Usage

- In Identity block `Type` is required when it is set to UserAssigned or SystemAssigned, UserAssigned.
- `feature_store` variable must be passed when `kind` variable is set as `FeatureStore`

#### Security Considerations

- Machine learning workspace can only be created with private endpoint as public access has been disabled.

#### Additional Information

- A `time_sleep` resource block is added while testing the module through validation pipeline, to allow key vault complete the private endpoint configuration. So that, while creating certificate it can access the key vault over the private Ip.
- Please note in this version of the module we haven't tested with machine learning workspace with feature store.
- CMK is not enabled in this module, While enabling the cmk, service metadata is stored on dedicated resources in Azure subscription. Microsoft creates a separate resource group in the subscription for this purpose, Only Microsoft can modify the resources in this managed resource group.
- Microsoft creates the following resources to store metadata for the workspace
    - Azure Cosmos DB
    - Azure AI Search
    - Azure Storage
  While creating the above microsoft manage reousrce for example storage account, its getting block by the policy we have for stoarge account. Hence the pipeline always thorws error when cmk is enable.
- Azure Machine Learning workspaces compute uses a LSEG managed VNet for outbound access.

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-AMLW-IA_010 | Use a Managed Identity for accessing Azure Resources | Azure Machine Learning workspaces must enforce the use of a Managed Identity to authenticate to Azure resources where this is supported (What) within target service access control settings (How) in order to remove the need to store credentials (Why) | True | True | Control implemented by `identity` block to enforce manage identity configuration |
| 2. | AZU-AMLW-IA_020 | Entra ID authentication only must be used | Entra ID authentication only must be used (What) via model endpoint deployment settings (How) in order to use modern robust and less prone to compromise authentication methods embedded within Entra ID (Why) | False | False | Control implemented by technical configuration setting:False |
| 3. | AZU-AMLW-IA_030 | Azure Machine Learning workspace compute must have local authentication methods disabled | Azure Machine Learning workspace compute must have local authentication methods disabled (What) within Studio compute settings (How) in order to use modern robust and less prone to compromise authentication methods embedded within Entra ID (Why) | True | True | This control is implemented in [Machine Learning Compute Cluster](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-machinelearningcomputecluster) module. |
| 4. | AZU-AMLW-AC_010 | Disable Public Network Access | Azure Machine Learning workspaces must enforce a network guardrail (What) within Networking setting (How) in order to prevent unauthorised access and data exposure to the internet (Why) | True | True | Control implemented by setting `public_network_access_enabled` value as `false`. |
| 5. | AZU-AMLW-AC_020 | Disable Public Network Access for model endpoints | Azure Machine Learning workspace must disable public access for model endpoints (What) via model endpoint deployment settings (How) in order to prevent unauthorised access and data exposure to the internet (Why) | False | False | Control implemented by technical configuration setting:False |
| 6. | AZU-AMLW-AC_030 | Azure Machine Learning workspace compute must not have a public IP | Azure Machine Learning workspace compute must not have a public IP (What) within Studio compute settings (How) in order to prevent unauthorised access and data exposure to the internet (Why) | True | True | This control is implemented in [Machine Learning Compute Cluster](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-machinelearningcomputecluster) module. |
| 7. | AZU-AMLW-SI_010 | Azure Machine Learning workspaces compute must be kept to within n-2 versions | Azure Machine Learning workspaces compute must be kept to within n-2 versions (What) within Studio compute, reprovision (How) in order to keep up to date with vulnerability remediations (Why) | True | True | This control is implemented in [Machine Learning Compute Cluster](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-machinelearningcomputecluster) module. |
| 8. | AZU-AMLW-AU_010 | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval (What) within Diagnostic settings (How) in order to prevent sensitive data leakage to third parties outside of LSEG control (Why) | False | False | Control implemented by technical configuration setting: False, This control will be implemented via custom policy. |
| 9. | AZU-AMLW-SC_010 | Azure Machine Learning workspaces must have a data classification tag | Azure Machine Learning workspaces must have a data classification tag (What) via management group policy assignment (How) in order to differentiate assets technical control requirements and to assist Security Operations in prioritising possible data breach mitigation responses (Why) | False | False | Control implemented by technical configuration setting: False, This control will be implemented via custom policy.|
| 10. | AZU-AMLW-SC_020 | Azure Machine Learning workspaces must not be able to corrupt the centrally managed private link private DNS zones when making a private endpoint for Azure Machine Learning workspace | Azure Machine Learning must have an Azure DeployIfNotExists policy to update the centrally managed private link private DNS zones with its private A record (What) via Policy to management group mapping (How) to ensure there is no ability for the Azure App Deployment team to have authorisation over these zones that could allow them to corrupt this file and impact service availability (Why) | False | False | This control will be implemented via custom policy. |
| 11. | AZU-AMLW-SC_030 | Must use a dedicated CMK for Azure Machine Learning workspaces Transparent Data Encryption that is persisted in an HSM backed Key Vault | Use a dedicated Azure Machine Learning workspace LSEG managed encryption at rest key persisted in an HSM backed Key Vault (What) via deployment settings (How) in order should Microsoft's key management platform become compromised LSEG can revoke access to exfiltrated encrypted data (Why) | False | False | CMK is not enabled in this module, While enabling the cmk Microsoft creates a separate resource group in the subscription to store meta data, Only Microsoft can modify the resources in this managed resource group. Microsoft creates the following resources to store metadata for the workspace Azure Cosmos DB, Azure AI Search, Azure Storage.While creating the above microsoft manage reousrce for example storage account, its getting block by the policy we have for stoarge account. Hence the pipeline always thorws error when cmk is enable. |
| 12. | AZU-AMLW-SC_041 | Azure Machine Learning workspaces compute must use a LSEG managed VNet for outbound access | Azure Machine Learning workspaces compute must use a LSEG managed VNet for outbound access (What) via deployment settings, Private with Internet Outbound, Use my own virtual network (How) to reduce the likelihood of data loss (Why) | True | True | This control is implemented setting Value of `isolation_mode` as `disabled` |
| 13. | AZU_AMLW-SC_042 | Azure Machine Learning workspaces compute must enable existing virtual network use |Microsoft.MachineLearningServices/workspaces/Azure Machine Learning workspaces compute must enable existing virtual network use | True | True | This control is implemented setting Value of `isolation_mode` as `disabled` |
| 14. | AZU-AMLW-SC_050 | Azure Machine Learning workspaces must not be able to corrupt the centrally managed private link private DNS zones when making a private endpoint for notebooks | Azure Machine Learning must have an Azure DeployIfNotExists policy to update the centrally managed private link private DNS zones with its notebook associated private A record (What) via Policy to management group mapping (How) to ensure there is no ability for the Azure App Deployment team to have authorisation over these zones that could allow them to corrupt this file and impact service availability (Why) | False | False | This Security control will be implement using custom policy. |
| 15. | AZU-AMLW-SC_090 | Azure Machine Learning workspaces must be registered as High business impact workspaces | Azure Machine Learning workspaces must be registered as High business impact workspaces (What) via deployment settings (How) in order to prevent sensitive data leakage and gain addtional encryption in Microsoft managed environments (Why) | True | True | Control implemented by setting value of `high_business_impact` as `true` |

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br><br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames)|
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Collect Diagnostics and send to Log Analytics]<br><br>[Monitor Azure Machine Learning](https://learn.microsoft.com/en-us/azure/machine-learning/monitor-azure-machine-learning?view=azureml-api-2)<br><br>[Cloud monitoring service level objectives ](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives)<br><br>[Supported metrics for Microsoft.MachineLearningServices/workspaces](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-machinelearningservices-workspaces-metrics) |
| 5.| [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | True | Deployment of Azure Machine Learning and associated resources in multi-regional.<br><br>[Failover for business continuity and disaster recovery ](https://learn.microsoft.com/en-us/azure/machine-learning/how-to-high-availability-machine-learning?view=azureml-api-2) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 8. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place.<br><br>[Manage access to Azure Machine Learning workspaces](https://learn.microsoft.com/en-us/azure/machine-learning/how-to-assign-roles?view=azureml-api-2&tabs=team-lead) |

## Changelog

- [azure-prdsvc-terraform-machinelearningworkspace](../CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/machine-learning/how-to-create-attach-compute-cluster?view=azureml-api-2&tabs=python)

### Terraform Docs

- [azurerm_machinelearningworkspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_workspace)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0 |
| <a name="requirement_azapi"></a> [azapi](#requirement_azapi) | >= 1.9 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm) | >=4.33 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | >=4.33 |

## Resources

| Name | Type |
|------|------|
| [azurerm_machine_learning_workspace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_workspace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_application_insights_id"></a> [application_insights_id](#input_application_insights_id) | (Required) The ID of the Application Insights associated with this Machine Learning Workspace. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_container_registry_id"></a> [container_registry_id](#input_container_registry_id) | (Optional) The ID of the container registry associated with this Machine Learning Workspace. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_description"></a> [description](#input_description) | (Optional) The description of this Machine Learning Workspace. | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_feature_store"></a> [feature_store](#input_feature_store) | (Optional) A feature_store block as defined below.<br/>object({<br/>  computer_spark_runtime_version = (Optional) The version of Spark runtime.<br/>  offline_connection_name        = (Optional) The name of offline store connection (Azure storage data lake gen2 reosurce id).<br/>  online_connection_name         = (Optional) The name of online store connection (Azure redius cache resource id).<br/>}) | <pre>object({<br/>    computer_spark_runtime_version = string<br/>    offline_connection_name        = string<br/>    online_connection_name         = string<br/>  })</pre> | `null` | no |
| <a name="input_friendly_name"></a> [friendly_name](#input_friendly_name) | (Optional) Display name for this Machine Learning Workspace. | `string` | `""` | no |
| <a name="input_identity_ids"></a> [identity_ids](#input_identity_ids) | (Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Machine Learning Workspace. | `list(string)` | `null` | no |
| <a name="input_identity_type"></a> [identity_type](#input_identity_type) | (Optional) Specifies the type of Managed Service Identity that should be configured on this Machine Learning Workspace. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned | `string` | `"SystemAssigned"` | no |
| <a name="input_image_build_compute_name"></a> [image_build_compute_name](#input_image_build_compute_name) | (Optional) The compute name for image build of the Machine Learning Workspace. | `string` | `null` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_key_vault_id"></a> [key_vault_id](#input_key_vault_id) | (Required) The ID of key vault associated with this Machine Learning Workspace. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_kind"></a> [kind](#input_kind) | (Optional) The type of the Workspace. Possible values are Default, FeatureStore. Defaults to Default | `string` | `"Default"` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_primary_user_assigned_identity"></a> [primary_user_assigned_identity](#input_primary_user_assigned_identity) | (Optional) The user assigned identity id that represents the workspace identity. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku_name](#input_sku_name) | (Optional) SKU/edition of the Machine Learning Workspace, possible values are Basic. Defaults to Basic. | `string` | `"Basic"` | no |
| <a name="input_storage_account_id"></a> [storage_account_id](#input_storage_account_id) | (Required) The ID of the Storage Account associated with this Machine Learning Workspace. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_v1_legacy_mode_enabled"></a> [v1_legacy_mode_enabled](#input_v1_legacy_mode_enabled) | (Optional) Enable V1 API features, enabling v1_legacy_mode may prevent you from using features provided by the v2 API. Defaults to false. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The Resource ID of the Machine Learning Workspace. |
| <a name="output_name"></a> [name](#output_name) | The Name of the Machine Learning Workspace. |
| <a name="output_resource"></a> [resource](#output_resource) | The Machine Learning Workspace resource. |
<!-- END_TF_DOCS -->
