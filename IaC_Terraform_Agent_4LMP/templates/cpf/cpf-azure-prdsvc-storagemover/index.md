---
version: 1.0.2
available_versions:
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.2.1
  - 0.2.0
---

<!-- BEGIN_TF_DOCS -->
# azure-prdsvc-terraform-storagemover

## Overview

This terraform module creates an Azure Storage Mover resource.

## Prerequisites

- `Resource Group` name is required.

## Guidance

#### Usage

- Azure Storage Mover is a relatively new, fully managed migration service that enables you to migrate your files and folders to Azure Storage while minimizing downtime for your workload.
- This Module is not creating any storage mover agent due to the limitation of accessing the Onprem environment to configure the agent using terraform.

#### Security Considerations

#### Additional Information

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-SMVR-IA_010 | Use a Managed Identity for accessing Azure Resources | Storage Mover must enforce the use of a Managed Identity to authenticate to Azure resources where this is supported (What) within targets IAM settings (How) in order to remove the need to store credentials (Why) | False | False | Storage Mover agent is not implemented in the Module due to limitation of configuring the agent with Onprem environment. |
| 2. | AZU-SMVR-IA_020 | Credentials for other resources/systems must be stored in Azure Key Vault when Managed Identities cannot be used | Credentials for other resources/systems must be stored in Azure Key Vault (What) within Endpoint settings (How) in order to ensure the security of credentials (Why) | False | False | Storage Mover agent is not implemented in the Module due to limitation of configuring the agent with Onprem environment. |
| 3. | AZU-SMVR-IA_030 | The default username and password for the Storage Mover Agent should be changed to adhere to LSEG password standards | The default username and password for the Storage Mover Agent should be changed to adhere to LSEG password standards (What) within the Administrative shell (How) to prevent against an attempted brute force attack (Why) | False | False | Storage Mover agent is not implemented in the Module due to limitation of configuring the agent with Onprem environment.|
| 4. | AZU-SMVR-SC_010 | Only agents from within LSEG infrastructure should be registered | Only agents from within LSEG infrastructure should be registered (What) within Registered agent settings (How) to ensure data being migrated into the environment is coming from a known and trusted source (Why) | False | False | This control will be implemented via policy. |
| 5. | AZU-SMVR-SC_020 | Storage Mover Agent Appliances and any associated Key Vault must be unregistered and decommissioned once the migration is completed |  Storage Mover Agent Appliances and any associated Key Vault must be unregistered and decommissioned once the migration is completed (What) in the Agent settings (How) to reduce the risk of data exfiltration (Why) | False | False | Storage Mover agent is not implemented in the Module due to limitation of configuring the agent with Onprem environment.|
| 6. | AZU-SMVR-SC_030 | Storage Mover must only be used to move or copy data to a location that is within the same environment |  Storage Mover must only be used to move or copy data to a location that is within the same environment (e.g. prod <-> prod, dev <-> dev) (What) within the Job settings (How) to ensure data is kept within the same environment and to reduce the risk of data exfiltration (Why) | False | False | This control will be implemented via policy. |
| 7. | AZU-SMVR-SC_040 | Storage Mover Projects must be segregated per distinct business purpose |  Storage Mover Projects must be segregated per distinct business purpose (What) in the deployment settings (How) to reduce the blast radius should any authentication credentials become compromised (Why) | False | False | This control will be implemented via policy. |
| 8. |  AZU-SMVR-SC_050 | Storage Mover source endpoints must not be Azure Storage Accounts or NetApp Files |  Storage Mover source endpoints must not be Azure Storage Accounts or NetApp Files (What) in Endpoint settings (How) to reduce the risk of data exfiltration (Why) | False | False | This Control Can't be implemented due to Terraform limitations. |

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control will be implemented using Policy which inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Monitor Azure Storage Mover](https://learn.microsoft.com/en-us/azure/storage-mover/log-monitoring)<br><br>[Cloud monitoring service level objectives](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives)
| 5. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 6. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place.<br><br>[Built-in roles for management operations](https://docs.microsoft.com/en-us/azure/storage/common/authorization-resource-provider?toc=%2Fazure%2Fstorage%2Fblobs%2Ftoc.json&bc=%2Fazure%2Fstorage%2Fblobs%2Fbreadcrumb%2Ftoc.json#built-in-roles-for-management-operations)

## Changelog

- [azure-prdsvc-terraform-storagemover](CHANGELOG.md)

## References

### Microsoft Docs

-[Official Documentation](https://learn.microsoft.com/en-us/azure/storage-mover/service-overview)

### Terraform Docs
-[azurerm_storage_mover](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_mover)

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
| [azurerm_storage_mover.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_mover) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_description"></a> [description](#input_description) | (Optional) A description for the Storage Mover. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input_name) | (Required) Specifies the name which should be used for this Storage Mover. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The Resource ID of the Azure Storage Mover. |
| <a name="output_name"></a> [name](#output_name) | The Name of the Azure Storage Mover. |
| <a name="output_resource"></a> [resource](#output_resource) | The Resource of the Azure Storage Mover. |
<!-- END_TF_DOCS -->
