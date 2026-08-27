---
version: 2.0.2
available_versions:
  - 2.0.2
  - 2.0.1
  - 2.0.0
  - 1.1.1
  - 1.1.0
---

<!-- BEGIN_TF_DOCS -->
# Azure Data Explorer Kusto Cluster


## Overview

- This terraform module creates a Azure data explorer kusto cluster and associated resources. Azure Data Explorer is a fully managed, high-performance, big data analytics platform that makes it easy to analyze high volumes of data in near real time. The Azure Data Explorer toolbox gives you an end-to-end solution for data ingestion, query, visualization, and management.

## Prerequisites

This module requires the following pre-existing dependent Azure resources:

- Resource Group, Virtual Network (both modules to be called if not existing, if allowed by the deployment permissions).
- Subnet to be used by the Key Vault Private endpoint.
- Network Security Group to be associated with the Subnet.
- Route Table to be associated with the Subnet.
- Key Vault for resource Customer Managed Key encryption.
- Private Endpoint to create a private connection to the Key Vault.
- Storage Account for a managed private endpoint
- User Assigned Identity leveraged for both identity and Customer Managed Key encryption.

## Guidance

#### Usage

- This module is deploying Azure data explorer Kusto cluster using User Assigned Identity with CMK encryption.
- Use `key_vault_tags` variable to define additional Key Vault Key/Secret related tags in your product. Note that azure policies are enforcing a number N of tags for all products by default. Also note that Key Vault child resources support only 15 tags as the maximum limit. Therefore, please ensure the total count of tags enforced by policy and tags applied via variable does not exceed the limit. For example, if 10 tags are enforced via Azure policy, a maximum of 5 tags can be set via the `key_vault_tags` variable. Reference link - [Key tags](https://learn.microsoft.com/en-us/azure/key-vault/keys/about-keys-details#key-tags).
- Use the `tags` variable to define additional tags related to the product (core). Note that azure policies are enforcing a number N of tags for all products by default and that additional 3 tags are set on the main product via main terraform template.
If you are assigning additional tags (key-value pairs) via the `tags` variable, please ensure the total count does not exceed the limit supported by Azure resources. Reference link - [Azure Resources Tag Limitation](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/tag-support)

#### Security Considerations

- If optimized_auto_scale block is not used, then the capacity is required.
NOTE: If an optimized_auto_scale block is defined and no capacity is set, then the capacity is initially set to the value of minimum_instances.

- Kusto Cluster is only allowing own tenant by default. Explicit configuration of this setting got  change from trusted_external_tenants = ["MyTenantOnly"] to `trusted_external_tenants = []`.

- In this module as we are deploying the cluster with cmk encryption enabled, it takes some time for the backend to be ready. Running CMK concurrently during this period results in an error message stating 'cluster is in maintenance process.' By adding `time_sleep` block in main.tf file, we allow the cluster sufficient time to be ready before applying CMK.

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. |  AZU-ADEC-IA_010 |  Use a Managed Identity for accessing Azure Resources | Azure Data Explorer Cluster must enforce the use of a Managed Identity to authenticate to Azure resources where this is supported (What) within targets Identity settings (How) in order to remove the need to store credentials (Why) | True | True | This Security Control is implemented by using `identity` block in code. |
| 2. | AZU-ADEC-IA_020 |  Azure Data Explorer must not allow cross tenant queries and commands | Azure Data Explorer must not allow cross tenant queries and commands (What) within Security settings (How) in order to restrict access to an LSEG tenant (Why) | True | False | This Security Control is implemented by using `trusted_external_tenants` is set to `[]` which means My Tenant only. |
| 3. |  AZU-ADEC-AC_010 | Disable Public Network Access | Azure Data Explorer Cluster must enforce a network guardrail (What) within Networking, public access settings (How) in order to prevent unauthorized access and data exposure to the internet (Why) | True | True | This Security Control is implemented by using `public_network_access_enabled` variable is set to `false`. |
| 4. | AZU-ADEC-SC_010 | Azure Data Explorer Cluster disks must be encrypted | Azure Data Explorer Cluster disks must be encrypted (What) by enabling Transparent Data Encryption within Security settings (How), to enable encryption at rest on the cluster, providing protection from data exfiltration for stored data, should the Microsoft platform become compromised (Why) | True | True | This Security Control is implemented by using `disk_encryption_enabled` variable is set to `true`. |
| 5. |  AZU-ADEC-SC_020 | Restricted outbound access must be set to enabled | Restricted outbound access must be set to enabled (What) within Networking, restrict outbound access, enabled (How) in order to restrict outbound access and reduce the risk of data exfiltration (Why) | True | True | This Security Control is implemented by using `outbound_network_access_restricted` variable is set to `true`. |
| 6. | AZU-ADEC-SC_030 | Outbound network connections must only be to PaaS services that belong to a related application and when there is a distinct business purpose | Outbound network connections must only be to PaaS services that belong to a related application and when there is a distinct business purpose (What) within Networking, restrict outbound access, FQDN (How) in order to reduce the risk of data exfiltration and unauthorised data access (Why) | True | True | This Security Control is implemented by using `outbound_network_access_restricted` variable is set to `true`. |
| 7. | AZU-ADEC-SC_040 | Azure App Deployment must not be able to corrupt the centrally managed private link private DNS zones when making a private endpoint for Kusto Query and Ingestion | Azure Data Explorer associated Kusto Query and Ingestion FQDN must have an Azure DeployIfNotExists policy to update the centrally managed private link private DNS zones with its private A record (What) via Policy to management group mapping (How) to ensure there is no ability for the Azure App Deployment team to have authorisation over these zones that could allow them to corrupt this file and impact service availability (Why) | False | False | This control would be implemented via DINE Policy of LSEG Standard. |
| 8. | AZU-ADEC-SC_050 | Azure App Deployment must not be able to corrupt the centrally managed private link private DNS zones when making a private endpoint for Queue | Azure Data Explorer associated Queue FQDN must have an Azure DeployIfNotExists policy to update the centrally managed private link private DNS zones with its private A record (What) via Policy to management group mapping (How) to ensure there is no ability for the Azure App Deployment team to have authorisation over these zones that could allow them to corrupt this file and impact service availability (Why) | False | False | This control would be implemented via DINE Policy of LSEG Standard. |
| 9. | AZU-ADEC-SC_060 | Azure App Deployment must not be able to corrupt the centrally managed private link private DNS zones when making a private endpoint for Blob | Azure Data Explorer associated Blob FQDN must have an Azure DeployIfNotExists policy to update the centrally managed private link private DNS zones with its private A record (What) via Policy to management group mapping (How) to ensure there is no ability for the Azure App Deployment team to have authorisation over these zones that could allow them to corrupt this file and impact service availability (Why) | False | False | This control would be implemented via DINE Policy of LSEG Standard. |
| 10. | AZU-ADEC-SC_070 |  Azure App Deployment must not be able to corrupt the centrally managed private link private DNS zones when making a private endpoint for Table | Azure Data Explorer associated Table FQDN must have an Azure DeployIfNotExists policy to update the centrally managed private link private DNS zones with its private A record (What) via Policy to management group mapping (How) to ensure there is no ability for the Azure App Deployment team to have authorisation over these zones that could allow them to corrupt this file and impact service availability (Why) | False | False | This control would be implemented via DINE Policy of LSEG Standard. |
| 11. | AZU-ADEC-SC_080 | Must use a dedicated CMK for Azure Data Explorer Cluster Transparent Data Encryption that is persisted in an HSM backed Key Vault | Use a dedicated Azure Data Explorer Cluster LSEG managed encryption at rest key persisted in an HSM backed Key Vault (What) within Encryption settings (How) in order should Microsoft's key management platform become compromised LSEG can revoke access to exfiltrated encrypted data (Why) | True | True | This Security Control is implemented by using resource `azurerm_kusto_cluster_customer_managed_key` block. |
| 12. | AZU-ADEC-SI_010 | Azure Data Explorer clusters must be prevented from running purge commands | Azure Data Explorer Cluster must be prevented from being configured to run purge commands (What) in the Configurations settings (How) in order to prevent tables and data from being permanently deleted (Why) | True | True | This Security Control is implemented by using `purge_enabled` variable is set to `true`. |

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Monitor metrics on Azure Data Explorer](https://learn.microsoft.com/en-us/azure/data-explorer/using-metrics)<br><br>[Cloud monitoring service level objectives](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives)<br><br>[Supported Metrics for Azure Data Explorer](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-kusto-clusters-metrics) |
| 5.| [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | True | The Kusto cluster Geo-disaster recovery feature is designed to make it easier to recover from a disaster of this magnitude and abandon a failed Azure region.<br><br>[Overview of business continuity with Azure Data Explorer](https://learn.microsoft.com/en-us/azure/data-explorer/business-continuity-overview) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package.<br><br>[Azure built-in roles](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles) [Azure Data Explorer authentication and authorization](https://learn.microsoft.com/en-us/azure/data-explorer/kusto/access-control/). |

## Changelog

- [azure-prdsvc-terraform-kustocluster](CHANGELOG.md)

## References

### Microsoft Docs

- [Azure Data Explorer Kusto Cluster](https://learn.microsoft.com/en-us/azure/data-explorer/data-explorer-overview)

### Terraform Docs

- [azurerm_kusto_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_cluster)
- [azurerm_kusto_cluster_customer_managed_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_cluster_customer_managed_key)
- [azurerm_kusto_cluster_principal_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_cluster_principal_assignment)
- [azurerm_kusto_cluster_managed_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_cluster_managed_private_endpoint)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm) | >=4.33 |
| <a name="requirement_time"></a> [time](#requirement_time) | >= 0.10 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | >=4.33 |
| <a name="provider_time"></a> [time](#provider_time) | >= 0.10 |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_kusto_cluster.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_cluster) | resource |
| [azurerm_kusto_cluster_customer_managed_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_cluster_customer_managed_key) | resource |
| [azurerm_kusto_cluster_managed_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_cluster_managed_private_endpoint) | resource |
| [azurerm_kusto_cluster_principal_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_cluster_principal_assignment) | resource |
| [azurerm_role_assignment.cmk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [time_sleep.Kusto_cluster_sec](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [azurerm_key_vault_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_key) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_fqdns"></a> [allowed_fqdns](#input_allowed_fqdns) | (Optional) List of allowed FQDNs(Fully Qualified Domain Name) for egress from Cluster. | `set(string)` | `null` | no |
| <a name="input_allowed_ip_ranges"></a> [allowed_ip_ranges](#input_allowed_ip_ranges) | (Optional) The list of ips in the format of CIDR allowed to connect to the cluster. | `set(string)` | `null` | no |
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_auto_stop_enabled"></a> [auto_stop_enabled](#input_auto_stop_enabled) | (Optional) Specifies if the cluster could be automatically stopped (due to lack of data or no activity for many days). | `bool` | `true` | no |
| <a name="input_cmk_rotation_policy"></a> [cmk_rotation_policy](#input_cmk_rotation_policy) | (Optional) A rotation policy block as defined below<br/>object({<br/>  notify_before_expiry = "(Optional) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>  time_before_expiry   = "(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br/>  time_after_creation  = "(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br/>  expire_after         = "(Optional) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>}) | <pre>object({<br/>    notify_before_expiry = string<br/>    time_before_expiry   = string<br/>    time_after_creation  = optional(string, null)<br/>    expire_after         = string<br/>  })</pre> | <pre>{<br/>  "expire_after": "P365D",<br/>  "notify_before_expiry": "P358D",<br/>  "time_after_creation": null,<br/>  "time_before_expiry": "P7D"<br/>}</pre> | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_create_role_assignment"></a> [create_role_assignment](#input_create_role_assignment) | (Optional) Whether to create a role assignment to the service identity to allow access to the key vault keys. | `bool` | `true` | no |
| <a name="input_customer_managed_key"></a> [customer_managed_key](#input_customer_managed_key) | (Required) An customer_managed_key block as defined below<br/>object({<br/>  key_vault_id                      = "(Required) The resource ID of the Key Vault where the Key Vault Key resides."<br/>  expiration_date                   = "(Required) Expiration UTC datetime (Y-m-d'T'H:M:S'Z')."<br/>  identity_id                       = "(Optional) The resource ID of the User Assigned Identity that has access to the key. To be used if `use_system_assigned_identity` is set to `false`"<br/>  identity_principal_id             = "(Optional) The principal ID of the User Assigned Identity that has access to the key."<br/>}) | <pre>object({<br/>    key_vault_id          = string<br/>    expiration_date       = string<br/>    identity_id           = optional(string)<br/>    identity_principal_id = optional(string)<br/>  })</pre> | n/a | yes |
| <a name="input_double_encryption_enabled"></a> [double_encryption_enabled](#input_double_encryption_enabled) | (Optional) Is the cluster's double encryption enabled? Changing this forces a new resource to be created. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_identity"></a> [identity](#input_identity) | (Optional) An identity block as defined below<br/>object({<br/>  type         = "(Required) Specifies the type of Managed Service Identity that should be configured on this Data Explorer Kusto cluster. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned` (to enable both)."<br/>  identity_ids = "(Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Data Explorer Kusto cluster. This is required when `type` is set to `UserAssigned` or `SystemAssigned, UserAssigned`."<br/>}) | <pre>object({<br/>    type         = string<br/>    identity_ids = list(string)<br/>  })</pre> | <pre>{<br/>  "identity_ids": [],<br/>  "type": "SystemAssigned"<br/>}</pre> | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_key_vault_tags"></a> [key_vault_tags](#input_key_vault_tags) | (Optional) Key Vault related tags to be set on key vault child resources. | `map(any)` | `{}` | no |
| <a name="input_language_extensions"></a> [language_extensions](#input_language_extensions) | (Optional) A list of language extension blocks to enable on the Kusto cluster. Each block supports the following:<br/>name  = "(Required) The name of the language extension. Possible values are PYTHON and R."<br/>image = "(Required) The language extension image. Possible values are Python3_11_7, Python3_11_7_DL, Python3_10_8, Python3_10_8_DL, Python3_6_5, PythonCustomImage, and R." | <pre>list(object({<br/>    name  = string<br/>    image = string<br/>  }))</pre> | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_managed_private_endpoint"></a> [managed_private_endpoint](#input_managed_private_endpoint) | (Optional) Configuration for Managed Privatendpoint is below.<br/>    name                         = "(Required) The name of the Managed Private Endpoints to create. Changing this forces a new resource to be created."<br/>    cluster_name                 = "(Required) The name of the Kusto Cluster. Changing this forces a new resource to be created."<br/>    resource_group_name          = "(Required) Specifies the Resource Group where the Kusto Cluster should exist. Changing this forces a new resource to be created."<br/>    private_link_resource_id     = "(Required) The ARM resource ID of the resource for which the managed private endpoint is created. Changing this forces a new resource to be created."<br/>    group_id                     = "(Required) The group id in which the managed private endpoint is created. Changing this forces a new resource to be created."<br/>    private_link_resource_region = "(Optional) The region of the resource to which the managed private endpoint is created. Changing this forces a new resource to be created."<br/>    request_message              = "(Optional) The user request message." | <pre>object({<br/>    name                         = string<br/>    private_link_resource_id     = string<br/>    group_id                     = string<br/>    private_link_resource_region = optional(string, null)<br/>    request_message              = optional(string, null)<br/>  })</pre> | `null` | no |
| <a name="input_name"></a> [name](#input_name) | (Required) The name of the Kusto Cluster to create. Only lowercase Alphanumeric characters allowed, starting with a letter. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_optimized_auto_scale"></a> [optimized_auto_scale](#input_optimized_auto_scale) | (Optional) A optimized_auto_scale block supports the following:<br/>minimum_instances - "(Required) The minimum number of allowed instances. Must between 0 and 1000."<br/>maximum_instances - "(Required) The maximum number of allowed instances. Must between 0 and 1000." | <pre>object({<br/>    maximum_instances = number<br/>    minimum_instances = number<br/>  })</pre> | `null` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_principal_assignments"></a> [principal_assignments](#input_principal_assignments) | (Optional) Configuration for Kusto Cluster Principal assignments is below.<br/>    name           = "(Required) The name of the Kusto cluster principal assignment. Changing this forces a new resource to be created."<br/>    principal_id   = "(Required) The name of the Kusto Cluster. Changing this forces a new resource to be created."<br/>    principal_type = "(Required) The type of the principal. Valid values include App, Group, User. Changing this forces a new resource to be created."<br/>    role           = "(Required) The cluster role assigned to the principal. Valid values include AllDatabasesAdmin and AllDatabasesViewer. Changing this forces a new resource to be created."<br/>    tenant_id      = "(Required) The tenant id in which the principal resides. Changing this forces a new resource to be created." | <pre>map(object({<br/>    name           = string<br/>    principal_id   = string<br/>    principal_type = string<br/>    role           = string<br/>    tenant_id      = string<br/>  }))</pre> | `{}` | no |
| <a name="input_public_ip_type"></a> [public_ip_type](#input_public_ip_type) | (Optional) Indicates what public IP type to create - IPv4 (default), or DualStack (both IPv4 and IPv6). | `string` | `"IPv4"` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input_sku) | A sku block supports the following:<br/>name     - "(Required) The name of the SKU. Possible values are Dev(No SLA)_Standard_D11_v2, Dev(No SLA)_Standard_E2a_v4, Standard_D14_v2, Standard_D11_v2, Standard_D16d_v5, Standard_D13_v2, Standard_D12_v2, Standard_DS14_v2+4TB_PS, Standard_DS14_v2+3TB_PS, Standard_DS13_v2+1TB_PS, Standard_DS13_v2+2TB_PS, Standard_D32d_v5, Standard_D32d_v4, Standard_EC8ads_v5, Standard_EC8as_v5+1TB_PS, Standard_EC8as_v5+2TB_PS, Standard_EC16ads_v5, Standard_EC16as_v5+4TB_PS, Standard_EC16as_v5+3TB_PS, Standard_E80ids_v4, Standard_E8a_v4, Standard_E8ads_v5, Standard_E8as_v5+1TB_PS, Standard_E8as_v5+2TB_PS, Standard_E8as_v4+1TB_PS, Standard_E8as_v4+2TB_PS, Standard_E8d_v5, Standard_E8d_v4, Standard_E8s_v5+1TB_PS, Standard_E8s_v5+2TB_PS, Standard_E8s_v4+1TB_PS, Standard_E8s_v4+2TB_PS, Standard_E4a_v4, Standard_E4ads_v5, Standard_E4d_v5, Standard_E4d_v4, Standard_E16a_v4, Standard_E16ads_v5, Standard_E16as_v5+4TB_PS, Standard_E16as_v5+3TB_PS, Standard_E16as_v4+4TB_PS, Standard_E16as_v4+3TB_PS, Standard_E16d_v5, Standard_E16d_v4, Standard_E16s_v5+4TB_PS, Standard_E16s_v5+3TB_PS, Standard_E16s_v4+4TB_PS, Standard_E16s_v4+3TB_PS, Standard_E64i_v3, Standard_E2a_v4, Standard_E2ads_v5, Standard_E2d_v5, Standard_E2d_v4, Standard_L8as_v3, Standard_L8s, Standard_L8s_v3, Standard_L8s_v2, Standard_L4s, Standard_L16as_v3, Standard_L16s, Standard_L16s_v3, Standard_L16s_v2, Standard_L32as_v3 and Standard_L32s_v3."<br/>capacity - "(Optional) Specifies the node count for the cluster. Boundaries depend on the SKU name."<br/>NOTE:<br/>If no optimized_auto_scale block is defined, then the capacity is required. ~> NOTE: If an optimized_auto_scale block is defined and no capacity is set, then the capacity is initially set to the value of minimum_instances. | <pre>object({<br/>    name     = string<br/>    capacity = number<br/>  })</pre> | n/a | yes |
| <a name="input_streaming_ingestion_enabled"></a> [streaming_ingestion_enabled](#input_streaming_ingestion_enabled) | (Optional) Specifies if the streaming ingest is enabled. | `bool` | `null` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_user_identity"></a> [user_identity](#input_user_identity) | (Optional) The user assigned identity that has access to the Key Vault Key. If not specified, system assigned identity will be used. | `string` | `null` | no |
| <a name="input_virtual_network_configuration"></a> [virtual_network_configuration](#input_virtual_network_configuration) | (Optional) A virtual_network_configuration block as defined below.Changing this forces a new resource to be created.<br/>subnet_id                    = "(Required) The subnet resource id."<br/>engine_public_ip_id          = "(Required) Engine service's public IP address resource id."<br/>data_management_public_ip_id = "(Required) Data management's service public IP address resource id." | <pre>object({<br/>    data_management_public_ip_id = string<br/>    engine_public_ip_id          = string<br/>    subnet_id                    = string<br/>  })</pre> | `null` | no |
| <a name="input_zones"></a> [zones](#input_zones) | (Optional) Specifies a list of Availability Zones in which this Kusto Cluster should be located. Changing this forces a new Kusto Cluster to be created. | `set(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_data_ingestion_uri"></a> [data_ingestion_uri](#output_data_ingestion_uri) | The Kusto Cluster URI to be used for data ingestion. |
| <a name="output_id"></a> [id](#output_id) | The Resource ID of the Azure Kusto Cluster. |
| <a name="output_name"></a> [name](#output_name) | The Name of the Azure Kusto Cluster. |
| <a name="output_resource"></a> [resource](#output_resource) | The Azure Kusto Cluster resource. |
| <a name="output_uri"></a> [uri](#output_uri) | The FQDN of the Azure Kusto Cluster. |
<!-- END_TF_DOCS -->
