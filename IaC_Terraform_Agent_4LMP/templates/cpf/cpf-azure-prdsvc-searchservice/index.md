---
version: 1.0.2
available_versions:
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.2.3
  - 0.2.2
---

<!-- BEGIN_TF_DOCS -->
# Azure Search Service module


## Overview

This terraform module creates a Azure Search Service and associated resources.

## Prerequisites

An existing `resource_group`

## Guidance

#### Usage

- The basic and free SKUs provision the Search Service in a Shared Cluster - the standard SKUs use a Dedicated Cluster.
- The SKUs standard2, standard3, storage_optimized_l1 and storage_optimized_l2 are only available by submitting a quota increase request to Microsoft. Please see the product documentation on how to submit a quota increase request.
- Hosting_mode can only be configured when sku is set to standard3.
- When hosting_mode is set to highDensity the maximum number of partitions allowed is 3.
- The semantic_search_sku cannot be defined if your Search Services sku is set to free. The Semantic Search feature is only available in certain regions, please see the product documentation for more information.

#### Security Considerations

- When the public_network_access_enabled field has been set to false the private endpoint connections are the only allowed access point to the Search Service.
- CMK encryption get enabled by built in policy `Azure Cognitive Search services should use customer-managed keys to encrypt data at rest`. CMK encryption becomes operational when an object is created.

#### Additional Details

- For this product, we have enabled Customer-Managed Keys (CMK) through code, but the product is currently using an older API version that does not support CMK enforcement. Unfortunately, there is no option to enable this via Terraform, nor can these properties be set through the Azure portal. To update this configuration, the REST API must be used, as detailed here: Azure REST API[https://learn.microsoft.com/en-us/azure/search/search-manage-rest#create-or-update-a-service]

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-AAIS-IA_010 | Use a Managed Identity for accessing Azure Resources | Azure AI Search services must enforce the use of a Managed Identity to authenticate to Azure resources where this is supported (What) within target service access control settings (How) in order to remove the need to store credentials (Why) | True | True | Control implemented by adding identity block with identity type "System assigned" in the Azure AI Search module. |
| 2. | AZU-AAIS-IA_020 | Local account authentication must be disabled | Local account authentication must be disabled (What) within Keys, manage admin keys settings (How) in order to use modern robust and less prone to compromise authentication methods embedded within Microsoft Entra ID (Why) | True | True | Control implemented by setting the default value of `local_authentication_enabled` attribute as `false`. |
| 3. | AZU-AAIS-AC_010 | Disable Public Network Access | Azure AI Search services must enforce a network guardrail (What) within Networking settings (How) in order to prevent unauthorised access and data exposure to the internet (Why) | True | True | Control implemented by setting the default value of `public_network_access_enabled ` attribute as `false`.  |
| 4. | AZU-AAIS-AU_010 | Send all diagnostic log categories to a central SOC Log Analytics workspace | Azure AI Search services must send all diagnostic logs to a central SOC Log Analytics workspace (What) within Diagnostic settings (How) in order to support a security investigation after a security incident (Why) | False | False | This control will be implemented by policy. |
| 5. | AZU-AAIS-AU_020 | Send all diagnostic log categories to a central SOC Storage Account | Azure AI Search services must send all diagnostic logs to a central SOC Storage Account (What) within Diagnostic settings (How) In order to provide an immutable copy to adhere to compliance requirements (Why) | False | False | This control will be implemented by policy. |
| 6. |AZU-AAIS-AU_030 | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval (What) within Diagnostic settings (How) in order to prevent sensitive data leakage to third parties outside of LSEG control (Why) | False | False | This control will be implemented by Lseg technical team. |
| 7. | AZU-AAIS-SC_010 | Azure AI Search services must not be able to corrupt the centrally managed private link private DNS zones when making a private endpoint for Azure Machine Learning registries | Azure AI Search services must have an Azure DeployIfNotExists policy to update the centrally managed private link private DNS zones with its private A record (What) via Policy to management group mapping (How) to ensure there is no ability for the Azure App Deployment team to have authorisation over these zones that could allow them to corrupt this file and impact service availability (Why) | False | False | This control will be implemented by policy. |
| 8. | AZU-AAIS-SC_020 | Must use a dedicated CMK for Azure AI Search Transparent Data Encryption that is persisted in an HSM backed Key Vault | Use a dedicated Azure AI Search LSEG managed encryption at rest key persisted in an HSM backed Key Vault (What) within code deployment parameters (How) in order should Microsoft's key management platform become compromised LSEG can revoke access to exfiltrated encrypted data (Why) | True | True | This has been implement by setting the default as `true` for `customer_managed_key_enforcement_enabled` attribute. |

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Monitor metrics on Azure AI Search](https://learn.microsoft.com/en-us/azure/search/monitor-azure-cognitive-search)<br><br>[Supported Metrics for Azure AI Search](https://learn.microsoft.com/en-us/azure/search/monitor-azure-cognitive-search-data-reference#metrics)<br><br>[Cloud monitoring service level objectives](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives) |
| 5. | [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | False | This control cannot be implemented via terraform.<br><br>[Reliability in Azure AI Search](https://learn.microsoft.com/en-us/azure/search/search-reliability). |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json). |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package.<br><br>[Connect to Azure AI Search using role-based access controls](https://learn.microsoft.com/en-us/azure/search/search-security-rbac?tabs=config-svc-portal%2Croles-portal-admin%2Croles-portal%2Croles-portal-query%2Ctest-portal%2Ccustom-role-portal%2Cdisable-keys-portal). |

## Changelog

- [azure-prdsvc-terraform-searchservice](../CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/search/search-what-is-azure-search)

### Terraform Docs

- [azurerm_search_service](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/search_service#type)

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
| [azurerm_search_service.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/search_service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_hosting_mode"></a> [hosting_mode](#input_hosting_mode) | (Optional) Specifies the Hosting Mode, which allows for High Density partitions (that allow for up to 1000 indexes) should be supported. Possible values are highDensity or default. Defaults to default. | `string` | `"default"` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_partition_count"></a> [partition_count](#input_partition_count) | (Optional) Specifies the number of partitions which should be created. This field cannot be set when using a free or basic sku. | `number` | `2` | no |
| <a name="input_replica_count"></a> [replica_count](#input_replica_count) | (Optional) Specifies the number of Replica's which should be created for this Search Service. This field cannot be set when using a free sku | `number` | `2` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_semantic_search_sku"></a> [semantic_search_sku](#input_semantic_search_sku) | (Optional) Specifies the Semantic Search SKU which should be used for this Search Service. Possible values include free and standard, The semantic_search_sku cannot be defined if your Search Services sku is set to free | `string` | `null` | no |
| <a name="input_sku"></a> [sku](#input_sku) | (Required) The SKU which should be used for this Search Service. Possible values include basic, free, standard, standard2, standard3, storage_optimized_l1 and storage_optimized_l2. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The Resource ID of the Azure search service. |
| <a name="output_name"></a> [name](#output_name) | The Name of the Azure search service. |
| <a name="output_resource"></a> [resource](#output_resource) | The Azure search service resource. |
<!-- END_TF_DOCS -->
