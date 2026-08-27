---
version: 1.0.2
available_versions:
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.3.2
  - 0.3.1
---

<!-- BEGIN_TF_DOCS -->
# Mongo vCore Cluster

## Overview

- This terraform module creates mongo vcore cluster and associated resources.
   - Microsoft.DocumentDB/mongoClusters

## Prerequisites

- `Resource Group` should exist.
-  A `Key Vault` needs to be created first, if not exists, to hold the `Key Vault Secret`.

## Guidance

#### Usage

- Azure Cosmos DB for MongoDB offers two resource types with different architectures.
  - 'Request unit (RU) database accounts'
  - 'vCore clusters'
 This resource type is currently not available with terraform native provider 'azurerm'. Hence `vCore cluster` is deployed using ARM template with in the terraform resource `azurerm_resource_group_template_deployment`.
- vCore Cluster eases lift & shift migration of an existing MongoDB workload or building a new MongoDB application.
- vCore Cluster supports workloads having long-running queries, complex aggregation pipelines, distributed transactions etc.
- vCore Cluster offers high-capacity vertical and horizontal scaling with familiar architecture. cluster tiers are bifurcated basis low traffic/high traffic from the applications running in Development/Test and Production enviroments.
- vCore model is ideal for applications requiring 99.995% availability.
- The connection string generated for Mongo Cluster is stored as secret in azure key vault. Therefore the resource type `azurerm_key_vault_secret` is declared in the root module.
- Following up the security controls for networking, public network access to Mongo Cluster has been parameterised with a default value as disabled for `var.public_access`.
- Use `key_vault_tags` variable to define additional Key Vault Keys/Secret related tags in your product, and you can not have more than 2 tags (key-value pairs), as the product gets a default of 13 tags and Key Vault child resources support only 15 tags as the maximum limit. Reference link - [Key tags](https://learn.microsoft.com/en-us/azure/key-vault/keys/about-keys-details#key-tags)
- Use the `tags` variable to define additional tags related to the product (core). Note that the product already has a default of 13 tags, so if you are adding multiple additional tags (key-value pairs), ensure the total count does not exceed the limit supported by Azure resources. [Azure Resources Tag Limitation](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/tag-support)
- **Currently, `restoreParameters` and `replica` features are not supported in this module.
- These features will be available in a future release once the module is migrated to the 4.x version of the Terraform AzureRM provider.

#### Additional Information

- Global Distribution feature serves as Cross-region replication in Azure Cosmos DB for MongoDB vCore is currently in preview.
- Encryption at rest is now available for documents and backups stored in Azure Cosmos DB for MongoDB vCore in most Azure regions. Encryption at rest is applied automatically for both new and existing customers in these regions.
- Data stored in Azure Cosmos DB for MongoDB vCore cluster is automatically and seamlessly encrypted with keys managed by Microsoft using service-managed keys.
- Azure Cosmos DB for MongoDB vCore provides automatic backups that enable point-in-time recovery (PITR) without any action required from users.
- Azure Cosmos DB for MongoDB vCore Point-In-Time Database Restore dont support from terraform need to do it from portal.

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-CDBMV-AC_011 | Cosmos DB MongoDB vCore must not allow public IP addresses | Cosmos DB MongoDB vCore must not allow public IP addresses (What) within Network settings (How) in order to prevent unauthorised access and data exposure to the internet (Why) | True | False |implemented by removing firewallRules block
| 2. | AZU-CDBMV-AC_020 | Cosmos DB MongoDB vCore must not allow public access from Azure services | Cosmos DB MongoDB vCore must not allow public access from Azure services (What) within Network settings (How) in order to prevent unauthorised access and data exposure to the internet (Why)| True | False |implemented by making public_access Disabled
| 3. | AZU-CDBMV-AU_010 | Send all security and audit diagnostic log categories to a central SOC Log Analytics workspace | Cosmos DB MongoDB vCore must send all security and audit diagnostic logs to a central SOC Log Analytics workspace (What) within Diagnostic settings (How) in order to support a security investigation after a security incident (Why) | False | False | This control will be implemented via policy. |
| 4. | AZU-CDBMV-AU_030 | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval |  Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval (What) within Diagnostic settings (How) in order to prevent sensitive data leakage to third parties outside of LSEG control (Why)| False | False | This control will be implemented via policy. |
| 5. | AZU-CDBMV-SC_010 | Cosmos DB MongoDB vCore must have a data classification tag | Cosmos DB MongoDB vCore must have a data classification tag (What) via Tags settings (How) in order to differentiate assets technical control requirements and to assist Security Operations in prioritising possible data breach mitigation responses | True | False  | This cloud product has a provision to input the list of tags based on user input using variable tags, adding any mandantory tags can be taken care during the provisioning of resource. |
| 6. | AZU-CDBMV-SC_020 | Cosmos DB MongoDB vCore must have the admin password rotated so they are distinct from the original value stored in the Terraform state file, meet LSEG complexity requirements and are stored in the LSEG approved secrets management system |  Cosmos DB MongoDB vCore must have the admin password rotated so they are distinct from the original value stored in the Terraform state file, meet LSEG complexity requirements and are stored in the LSEG approved secrets management system (What) via Overview reset password (How) in order to protect secrets by using a secure storage mechanism (Why) | False | False | MongoDB admin password rotation will be implemented by LSEG standard policy. |
| 7. | AZU-CDBMV-SC_030 | Cosmos DB MongoDB vCore consumers must persist the connection strings as a secret in a Key Vault |  Cosmos DB MongoDB vCore consumers must persist the connection strings as a secret in a Key Vault (What) as part of consuming service configuration (How) in order to ensure the security of credentials (Why) | True | False | This control is implemented using the resource type `azurerm_key_vault_secret`. Pester test case is used to verify only the existence of the secret and not the exact connection string presence. Since connection string is a sensitive and secure string, comparison of value is not done due to security reasons. |
| 8. | AZU-CDBMV-SC_050 | Azure App Deployment must not be able to corrupt the centrally managed private link private DNS zones when making a private endpoint for Cosmos DB MongoDB vCore| Cosmos DB MongoDB vCore must enforce a minimum TLS version of 1.2 (What) via MongoDB rest API (How) in order to use modern techniques to establish robust encrypted data channels over untrusted networks  Cosmos DB MongoDB vCore must have an Azure DeployIfNotExists policy to update the centrally managed private link private DNS zones with its private A record (What) via Policy to management group mapping (How) to ensure there is no ability for the Azure App Deployment team to have authorisation over these zones that could allow them to corrupt this file and impact service availability (Why)| False | False | This control will be implemented via policy. |
| 9. | AZU-CDBMV-SI_010 | Cosmos DB MongoDB vCore versions must be kept to within n-2 versions | Cosmos DB MongoDB vCore versions must be kept to within n-2 versions (What) via MongoDB rest API (How) in order to keep up to date with vulnerability remediations (Why) | False | False | This control will be implemented via policy. |

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Monitor Azure Cosmos DB for MongoDB vCore diagnostics logs with Azure Monitor ](https://learn.microsoft.com/en-us/azure/cosmos-db/mongodb/vcore/how-to-monitor-diagnostics-logs?tabs=log-analytics) <br><br>[Cloud monitoring service level objectives ](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives)<br><br>[Supported Metrics for Azure Cosmos DB for MongoDB ](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-documentdb-mongoclusters-metrics) |
| 5.| [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | True | This control is implemented by parameterising the property `enableHa` in code. Azure Cosmos DB for MongoDB vCore provides automatic backups that enable point-in-time recovery (PITR) without any action required from users. Azure Cosmos DB for MongoDB vCore Point-In-Time Database Restore is in preview currently.<br><br>[Reliability in Azure Cosmos DB for MongoDB vCore ](https://learn.microsoft.com/en-us/azure/reliability/reliability-cosmos-mongodb?toc=%2Fazure%2Fcosmos-db%2Fmongodb%2Fvcore%2Ftoc.json) <br><br>[Azure Cosmos DB for MongoDB Backup & Restore ](https://learn.microsoft.com/en-us/azure/cosmos-db/mongodb/vcore/how-to-restore-cluster) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-OPS-09 Update Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-09-03 Deploy regular software updates and bug-fixes<br><br>SMCF-OPS-09-04 Monitor software update status and remediate non-compliant resources | Documentation<br><br>Documentation | False | This requires planning to upgrade clients to a version compatible with the API version we are upgrading to before upgrading the Azure Cosmos DB for MongoDB account. <br><br>[Upgrade the API version of your Azure Cosmos DB for MongoDB account ](https://learn.microsoft.com/en-us/azure/cosmos-db/mongodb/upgrade-version) |
| 8. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place. <br><br>[Azure Cosmos DB for MongoDB RBAC ](https://learn.microsoft.com/en-us/azure/cosmos-db/role-based-access-control) |

## Changelog

- [azure-prdsvc-terraform-mongocluster](CHANGELOG.md)

## References

### Microsoft Docs

- [Mongo vCore Cluster](https://learn.microsoft.com/en-us/azure/cosmos-db/mongodb/vcore/)

### Terraform Docs

- [azurerm_resource_group_template_deployment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_template_deployment)
- [Microsoft.DocumentDB/mongoClusters](https://learn.microsoft.com/en-us/azure/templates/microsoft.documentdb/mongoclusters?pivots=deployment-language-arm-template#mongoclusterrestoreparameters-1)

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
| [azurerm_key_vault_secret.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_resource_group_template_deployment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_template_deployment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_login"></a> [admin_login](#input_admin_login) | (Optional) The administrator's login for the mongo cluster. | `string` | `"null"` | no |
| <a name="input_admin_password"></a> [admin_password](#input_admin_password) | (Optional) The password of the administrator login. | `string` | `"null"` | no |
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_arm_template_name"></a> [arm_template_name](#input_arm_template_name) | (Required) The ARM Template name. | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster_name](#input_cluster_name) | (Required) The cluster name of the mongo database. | `string` | n/a | yes |
| <a name="input_content_type"></a> [content_type](#input_content_type) | (Optional) Specifies the content type of the Key Vault Secret. | `string` | `null` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_create_mode"></a> [create_mode](#input_create_mode) | (Required) The mode to create a mongo cluster. The acccepted values are Default, PointInTimeRestore, Restore. | `string` | `"Default"` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_expiration_date"></a> [expiration_date](#input_expiration_date) | (Optional) Expiration UTC datetime (Y-m-d'T'H:M:S'Z'). | `string` | `null` | no |
| <a name="input_high_availability"></a> [high_availability](#input_high_availability) | (Optional) Whether high availability is enabled on the node group. | `bool` | `false` | no |
| <a name="input_high_availability_mode"></a> [high_availability_mode](#input_high_availability_mode) | The target high availability mode requested for the cluster. | `string` | `"Disabled"` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | n/a | yes |
| <a name="input_key_vault_id"></a> [key_vault_id](#input_key_vault_id) | (Required) The ID of the Key Vault where the Secret should be created. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_key_vault_tags"></a> [key_vault_tags](#input_key_vault_tags) | (Optional) Key Vault related tags to be set on key vault child resources. | `map(any)` | `{}` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_node_disk_size"></a> [node_disk_size](#input_node_disk_size) | (Required) The disk storage size for the node group in GB. Example values: 128, 256, 512, 1024. | `number` | n/a | yes |
| <a name="input_node_sku"></a> [node_sku](#input_node_sku) | (Required) The resource sku for the node group. This defines the size of CPU and memory that is provisioned for each node. Example values: 'M30', 'M40'. | `string` | `"null"` | no |
| <a name="input_not_before_date"></a> [not_before_date](#input_not_before_date) | (Optional) Key not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z'). | `string` | `null` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_public_access"></a> [public_access](#input_public_access) | (Optional) Whether public access is enabled on the mongo cluster. | `string` | `"Disabled"` | no |
| <a name="input_resource_group_id"></a> [resource_group_id](#input_resource_group_id) | The ID of the resource group where the Mongo cluster will be created. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_server_version"></a> [server_version](#input_server_version) | (Optional) The Mongo DB server version. | `string` | `"null"` | no |
| <a name="input_shard_count"></a> [shard_count](#input_shard_count) | The number of shards for the MongoDB cluster | `number` | `1` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_connection_string"></a> [connection_string](#output_connection_string) | The Connection String of the mongo vCore cluster. |
| <a name="output_id"></a> [id](#output_id) | The ID of the mongo vCore cluster. |
| <a name="output_keyvault_secret_name"></a> [keyvault_secret_name](#output_keyvault_secret_name) | The Name of the key vault secret. |
| <a name="output_keyvault_secret_resource"></a> [keyvault_secret_resource](#output_keyvault_secret_resource) | The Resource of the key vault secret. |
| <a name="output_name"></a> [name](#output_name) | The Name of the mongo vCore cluster. |
| <a name="output_resource"></a> [resource](#output_resource) | The Resource of the mongo vCore cluster. |
<!-- END_TF_DOCS -->
