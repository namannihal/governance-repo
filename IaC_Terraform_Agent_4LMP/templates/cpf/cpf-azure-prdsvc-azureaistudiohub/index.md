---
version: 0.2.3
available_versions:
  - 0.2.3
  - 0.2.2
  - 0.2.1
  - 0.2.0
  - 0.1.1
---

<!-- BEGIN_TF_DOCS -->
#Azure AI Studio Hub Module

## Overview

This terraform module creates a Azure AI Studio Hub.

## Prerequisites

- Exisiting `resource_group` and `virtual_network`
- One `user_assign_identity` to encypt storage account data.
- dependent resource for AI Studio Hub
  - `storage_account`
  - `key_vault`
- Private endpoint for the below resource,
  - `key_vault`
  - `storage_account`
- One `subnet` to configure private endpoint.
- One `network_security_group`to associate with the subnet
- Multiple `time_sleep` to wait for creation of DNS record post private endpoint deployment through DINE policy.
- One `route table`

## Guidance

#### Usage

- In Identity block `Type` is required when it is set to UserAssigned or SystemAssigned, UserAssigned.
- set the argument `kind` as `hub` for AI Studio Hub.

#### Security Considerations

- AI Studio Hub can only be created with private endpoint as public access has been disabled.
- Azure AI Studio Hub must be deployed with an outbound firewall (Refer the security control- AZU-AMLW-SC_040 for more information).
- Azure AI Studio Hub must be registered as High business impact workspaces.
- CMK is not enabled in this module, While enabling the cmk Microsoft creates a separate resource group in the subscription to store meta data, Only Microsoft can modify the resources in this managed resource group. Microsoft creates the following resources to store metadata for the workspace Azure Cosmos DB, Azure AI Search, Azure Storage. While creating the above microsoft manage reousrce for example storage account, its getting block by the policy for stoarge account. Hence the pipeline always thorws error when cmk is enabled.

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-AMLW-IA_010 | Use a Managed Identity for accessing Azure Resources | Azure AI Studio Hub must enforce the use of a Managed Identity to authenticate to Azure resources where this is supported (What) within target service access control settings (How) in order to remove the need to store credentials (Why) | True | True | Control implemented by `identity` block to enforce manage identity configuration |
| 2. | AZU-AMLW-IA_020 | Entra ID authentication only must be used | Entra ID authentication only must be used (What) via model endpoint deployment settings (How) in order to use modern robust and less prone to compromise authentication methods embedded within Entra ID (Why) | False | False | Control implemented by technical configuration setting:False |
| 3. | AZU-AMLW-IA_030 | Azure AI Studio Hub compute must have local authentication methods disabled | Azure AI Studio Hub compute must have local authentication methods disabled (What) within Studio compute settings (How) in order to use modern robust and less prone to compromise authentication methods embedded within Entra ID (Why) | False | False | Control implemented by technical configuration setting:False |
| 4. | AZU-AMLW-AC_010 | Disable Public Network Access | Azure AI Studio Hub must enforce a network guardrail (What) within Networking setting (How) in order to prevent unauthorised access and data exposure to the internet (Why) | True | True | Control implemented by setting `publicNetworkAccess` value as `Disabled`. |
| 5. | AZU-AMLW-AC_020 | Disable Public Network Access for model endpoints | Azure AI Studio Hub must disable public access for model endpoints (What) via model endpoint deployment settings (How) in order to prevent unauthorised access and data exposure to the internet (Why) | False | False | Control cannot be implemented by technical configuration |
| 6. | AZU-AMLW-AC_030 | Azure AI Studio Hub compute must not have a public IP | Azure AI Studio Hub compute must not have a public IP (What) within Studio compute settings (How) in order to prevent unauthorised access and data exposure to the internet (Why) | True | True | Control cannot be implemented by technical configuration |
| 7. | AZU-AMLW-AU_010 | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval (What) within Diagnostic settings (How) in order to prevent sensitive data leakage to third parties outside of LSEG control (Why) | False | False | Control implemented by technical configuration setting: False, This control will be implemented via custom policy. |
| 8. | AZU-AMLW-SC_010 | Azure AI Studio Hub must have a data classification tag | Azure AI Studio Hub must have a data classification tag (What) via management group policy assignment (How) in order to differentiate assets technical control requirements and to assist Security Operations in prioritising possible data breach mitigation responses (Why) | False | False | Control implemented by technical configuration setting: False, This control will be implemented via custom policy.|
| 9. | AZU-AMLW-SC_020 | Azure AI Studio Hub must not be able to corrupt the centrally managed private link private DNS zones when making a private endpoint for Azure AI Studio Hub| Azure AI Studio Hub must have an Azure DeployIfNotExists policy to update the centrally managed private link private DNS zones with its private A record (What) via Policy to management group mapping (How) to ensure there is no ability for the Azure App Deployment team to have authorisation over these zones that could allow them to corrupt this file and impact service availability (Why) | False | False | This control will be implemented via custom policy. |
| 10. | AZU-AMLW-SC_030 | Must use a dedicated CMK for Azure AI Studio Hub Transparent Data Encryption that is persisted in an HSM backed Key Vault | Use a dedicated Azure AI Studio Hub LSEG managed encryption at rest key persisted in an HSM backed Key Vault (What) via deployment settings (How) in order should Microsoft's key management platform become compromised LSEG can revoke access to exfiltrated encrypted data (Why) | False | False | CMK is not enabled in this module, While enabling the cmk Microsoft creates a separate resource group in the subscription to store meta data, Only Microsoft can modify the resources in this managed resource group. Microsoft creates the following resources to store metadata for the workspace Azure Cosmos DB, Azure AI Search, Azure Storage. While creating the above microsoft manage reousrce for example storage account, its getting block by the policy for stoarge account. Hence the pipeline always thorws error when cmk is enabled. |
| 11. | AZU-AMLW-SC_040 | Azure AI Studio Hub must be deployed with an outbound firewall | Azure AI Studio Hub must be deployed with an outbound firewall (What) within Networking, workspace managed outbound access, allow only approved outbound (How) as per LSEG Security standard (Why) | True | True | Control implemented by setting `isolation_mode` default value as `AllowOnlyApprovedOutbound`. |
| 12. | AZU-AMLW-SC_050 | Azure AI Studio Hub must not be able to corrupt the centrally managed private link private DNS zones when making a private endpoint for notebooks | Azure AI Studio Hub must have an Azure DeployIfNotExists policy to update the centrally managed private link private DNS zones with its notebook associated private A record (What) via Policy to management group mapping (How) to ensure there is no ability for the Azure App Deployment team to have authorisation over these zones that could allow them to corrupt this file and impact service availability (Why) | False | False | This Security control will be implement using custom policy. |
| 15. | AZU-AMLW-SC_080 |Azure AI Studio Hub managed VNet Private Endpoint outbound rules must only connect to PaaS services that belong to a related application and when there is a distinct business purpose  | Azure AI Studio Hub managed VNet Private Endpoint outbound rules must only connect to PaaS services that belong to a related application and when there is a distinct business purpose (What) within Network, workspace managed outbound access, allow only approved outbound, add user-defined outbound rules (How) to reduce the risk of data exfiltration and unauthorised PaaS resource access (Why) | False | False | Control implemented by technical configuration setting: False. |
| 16. | AZU-AMLW-SC_090 | Azure AI Studio Hub must be registered as High business impact workspaces | Azure AI Studio Hub must be registered as High business impact workspaces (What) via deployment settings (How) in order to prevent sensitive data leakage and gain addtional encryption in Microsoft managed environments (Why) | True | True | Control implemented by setting value of `hbiWorkspace` as `true` |
| 17. | AZU-AMLW-SI_010 | Azure AI Studio Hub compute must be kept to within n-2 versions | Azure AI Studio Hub compute must be kept to within n-2 versions (What) within Studio compute, reprovision (How) in order to keep up to date with vulnerability remediations (Why) | False | False | Control implemented by technical configuration setting: False. |

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

- [azure-prdsvc-terraform-datafactory](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://azure.microsoft.com/en-us/products/ai-studio)
- [AI Studi Hub ARM Template](https://learn.microsoft.com/en-us/azure/templates/microsoft.machinelearningservices/workspaces?pivots=deployment-language-terraform)

### Terraform Docs

- [AI Studio Hub](https://github.com/hashicorp/terraform-provider-azurerm/issues/25859)

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
| [azapi_resource.aihub](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_applicationInsights"></a> [applicationInsights](#input_applicationInsights) | (Optional) ARM id of the application insights associated with this workspace. | `string` | `null` | no |
| <a name="input_containerRegistry"></a> [containerRegistry](#input_containerRegistry) | (Optional) ARM id of the container registry associated with this workspace. | `string` | `null` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_description"></a> [description](#input_description) | (Optional) The description of this workspace. | `string` | `"AiStudiohub"` | no |
| <a name="input_discoveryUrl"></a> [discoveryUrl](#input_discoveryUrl) | (Optional) Url for the discovery service to identify regional endpoints for AI Studio Hub services | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_featureStoreSettings"></a> [featureStoreSettings](#input_featureStoreSettings) | (Optional) Feature store settings for the Azure AI Studio Hub.<br/>    computeRuntime = {<br/>      sparkRuntimeVersion = "(Optional) The version of the Spark runtime to use."<br/>    }<br/>    offlineStoreConnectionName = "(Optional) The name of the connection for the offline store."<br/>    onlineStoreConnectionName = "(Optional) The name of the connection for the online store." | <pre>object({<br/>    computeRuntime = object({<br/>      sparkRuntimeVersion = string<br/>    })<br/>    offlineStoreConnectionName = string<br/>    onlineStoreConnectionName  = string<br/>  })</pre> | `null` | no |
| <a name="input_friendlyName"></a> [friendlyName](#input_friendlyName) | (Optional) The friendly name for this workspace. This name in mutable | `string` | `"AiStudiohub"` | no |
| <a name="input_identity"></a> [identity](#input_identity) | (Optional) An identity block as defined below<br/>object({<br/>  type         = "(Required) Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed)."<br/>  identity_ids = "(Optional) The set of user assigned identities associated with the resource."<br/>}) | <pre>object({<br/>    type         = string<br/>    identity_ids = list(string)<br/>  })</pre> | <pre>{<br/>  "identity_ids": null,<br/>  "type": "SystemAssigned"<br/>}</pre> | no |
| <a name="input_imageBuildCompute"></a> [imageBuildCompute](#input_imageBuildCompute) | (Optional) The compute name for image build. | `string` | `null` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_keyVault"></a> [keyVault](#input_keyVault) | (Required) ARM id of the key vault associated with this workspace. This cannot be changed once the workspace has been created | `string` | n/a | yes |
| <a name="input_kind"></a> [kind](#input_kind) | (Optional) Enabling v1_legacy_mode may prevent you from using features provided by the v2 API. | `string` | `"Hub"` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input_name) | (Required) Name of the AI Hub Studio. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_outboundRules"></a> [outboundRules](#input_outboundRules) | (Optional) An ssh block as defined below.<br/>object({<br/>   rule_name               = "(Required) the name of the rule"<br/>   category                = "(Required) Category of a managed network Outbound Rule of a AI Studio Hub, possible value are Recommended,Required,UserDefined."<br/>   status                  = "(Required) Type of a managed network Outbound Rule of a AI Studio Hub , possible value are Active,Inactive"<br/>   type                    = "(Required) Set the object type, possible values are FQDN, ServiceTag and PrivateEndpoint"<br/>   fqdn_destination        = "(Optional) name of the FQDN"<br/>   service_tag_destination = (Optional) object({<br/>       action     = "(Required) The action enum for networking rule, supported values are Deny and Allow"<br/>       portRanges = "(Required) The port ranges for service tag destination rule."<br/>       protocol   = "(Required) the protocol for service tag destination rule."<br/>       serviceTag = "(Required) the service tag for service tag destination rule."<br/>   })<br/>   private_link_destination = (Optional) object({<br/>       serviceResourceId = "(Required) The service reousrce id for private link destination"<br/>       sparkEnabled      = "(Required) Spark for the private link destination"<br/>       sparkStatus       = "(Required) Spark status for the private link destination"<br/>       subResourceTarget = "(Required)sub resource for private link destination"<br/>   })<br/>}) | <pre>map(object({<br/>    category         = string<br/>    status           = string<br/>    type             = string<br/>    fqdn_destination = optional(string, null)<br/>    service_tag_destination = optional(object({<br/>      action     = string<br/>      portRanges = string<br/>      protocol   = string<br/>      serviceTag = string<br/>    }))<br/>    private_link_destination = optional(object({<br/>      serviceResourceId = string<br/>      sparkEnabled      = bool<br/>      sparkStatus       = string<br/>      subResourceTarget = string<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_parent_id"></a> [parent_id](#input_parent_id) | (Required) The ID of the azure resource in which this resource is created. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_primaryUserAssignedIdentity"></a> [primaryUserAssignedIdentity](#input_primaryUserAssignedIdentity) | (Optional)The user assigned identity resource id that represents the workspace identity. | `string` | `null` | no |
| <a name="input_serverlessComputeSettings"></a> [serverlessComputeSettings](#input_serverlessComputeSettings) | (Optional) Serverless compute settings for the Azure AI Studio Hub.<br/>    serverlessComputeCustomSubnet = "(Optional) The resource ID of an existing virtual network subnet in which serverless compute nodes should be deployed"<br/>    serverlessComputeNoPublicIP   = "(Optional) The flag to signal if serverless compute nodes deployed in custom vNet would have no public IP addresses for a workspace with private endpoint" | <pre>object({<br/>    serverlessComputeCustomSubnet = string<br/>    serverlessComputeNoPublicIP   = bool<br/>  })</pre> | `null` | no |
| <a name="input_serviceManagedResourcesSettings"></a> [serviceManagedResourcesSettings](#input_serviceManagedResourcesSettings) | (Optional) Settings for service managed resources.<br/>  The object contains the following properties:<br/>    cosmosDb = "(Optional) Cosmos DB settings."<br/>      collectionsThroughput = "(Required) Throughput for collections in Cosmos DB." | <pre>object({<br/>    cosmosDb = object({<br/>      collectionsThroughput = number<br/>    })<br/>  })</pre> | `null` | no |
| <a name="input_sku"></a> [sku](#input_sku) | (Optional) The SKU settings for the Azure ML workspace.<br/>  The object contains the following properties:<br/>    capacity = "(Optional) The capacity of the SKU."<br/>    family   = "(Optional) The family of the SKU."<br/>    name     = "(Required) The name of the SKU."<br/>    size     = "(Optional) The size of the SKU."<br/>    tier     = "(Required) The tier of the SKU." | <pre>object({<br/>    capacity = number<br/>    family   = string<br/>    name     = string<br/>    size     = string<br/>    tier     = string<br/>  })</pre> | <pre>{<br/>  "capacity": null,<br/>  "family": null,<br/>  "name": "Basic",<br/>  "size": null,<br/>  "tier": "Basic"<br/>}</pre> | no |
| <a name="input_status"></a> [status](#input_status) | (Optional) An identity block as defined below<br/>object({<br/>  sparkReady = "(Required) Indicates if Spark is ready.."<br/>  status     = "(Optional) Status for the managed network of a AI Studio Hub."<br/>}) | <pre>object({<br/>    sparkReady = bool<br/>    status     = string<br/>  })</pre> | `null` | no |
| <a name="input_storageAccount"></a> [storageAccount](#input_storageAccount) | (Optional) ARM id of the storage account associated with this workspace. This cannot be changed once the workspace has been created | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_v1LegacyMode"></a> [v1LegacyMode](#input_v1LegacyMode) | (Optional) Enabling v1_legacy_mode may prevent you from using features provided by the v2 API. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The ID of the Azure AI Studio Hub. |
| <a name="output_name"></a> [name](#output_name) | The Name of the Azure AI Studio Hub. |
| <a name="output_resource"></a> [resource](#output_resource) | The Azure AI Studio Hub resource. |
<!-- END_TF_DOCS -->
