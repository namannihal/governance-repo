---
version: 2.1.0
available_versions:
  - 2.1.0
  - 2.0.0
  - 1.0.1
  - 1.0.0
  - 0.2.2
---

<!-- BEGIN_TF_DOCS -->
# CosmosDB Mongo Database module


## Overview

- This terraform module creates cosmosdb mongo database and associated resources such as
  - cosmosdb mongo collection
  - cosmosdb mongo role definition
  - cosmosdb mongo user definition

## Prerequisites

- Cosmosdb account must be created prior to deployment. When deploying cosmosdb account for mongo database, ensure the `local_authentication_disabled` argument is set to `False`.
- The `kind` variable must be set to `MongoDB` when deploying Cosmosdb account for Mongo Database.

## Guidance

#### Usage

- This module deploys the mongo database.
- Azure Cosmos DB for MongoDB offers two resource types with different architectures.
  - 'Request unit (RU) database accounts'
  - 'vCore clusters'
- vCore cluster aka Mongo cluster can only be provisioned over portal. This resource type is currently not available with terraform provider 'azurerm' in the current version.
- Regular Mongo Database is created by default using the resource type `azurerm_cosmosdb_mongo_database`.

## Migration Guide for Version 2.0.0

### Breaking Changes

**⚠️ CRITICAL: Version 2.0.0 introduces breaking changes that require manual intervention before upgrading.**

#### Context

- The `azurerm_cosmosdb_mongo_role_definition` resource has been replaced with `azapi_resource` due to an azurerm provider bug
- The azurerm provider cannot unmarshal the `type` field from Azure's API response, causing all Cosmos DB operations to fail
- All existing role definitions and user definitions must be deleted before upgrading

#### Impact

- All Terraform plan and apply commands will fail without following the migration steps
- Existing MongoDB role definitions created with the azurerm provider are incompatible

#### Risk

**Failing to apply this migration will indefinitely block pipeline runs, potentially blocking required production hotfixes.**

#### Migration Steps

**Delete Existing Role and User Definitions**

Open Azure Cloud Shell and execute the following script with appropriate values:

```bash
#!/bin/bash
SUBSCRIPTION_NAME="subscription-name"
ACCOUNT_NAME="cosmosdb-account-name"
RESOURCE_GROUP="resource-group-name"

# Set subscription
az account set -s "$SUBSCRIPTION_NAME"

# Delete all role definitions
az cosmosdb mongodb role definition list \
  --resource-group "$RESOURCE_GROUP" \
  --account-name "$ACCOUNT_NAME" | \
  jq -r '.[].id' | \
  xargs -I {} az cosmosdb mongodb role definition delete \
    --resource-group "$RESOURCE_GROUP" \
    --account-name "$ACCOUNT_NAME" \
    --id {} --yes

# Delete all user definitions
az cosmosdb mongodb user definition list \
  --account-name "$ACCOUNT_NAME" \
  --resource-group "$RESOURCE_GROUP" | \
  jq -r '.[].id' | \
  xargs -I {} az cosmosdb mongodb user definition delete \
    --account-name "$ACCOUNT_NAME" \
    --resource-group "$RESOURCE_GROUP" \
    --id {} --yes
```

**Verify Terraform Plan**

```
terraform plan
```

**VERY IMPORTANT:** Verify the plan shows:

- Creation of new `azapi_resource.mongo_role_definition` resources
- Creation of new `azurerm_cosmosdb_mongo_user_definition` resources
- **NO deletions of other Cosmos DB resources** (database, collections, etc.)

**Apply Changes**

```bash
terraform apply
```

**Post-Upgrade Actions**

- Workloads using MongoDB connections may require restart to reconnect with the new role definitions
- Application connectivity to Cosmos DB must be verified

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-CDBMRU-IA_010 | Cosmos DB MongoDB RU must use a Managed Identity for accessing Azure Resources | Cosmos DB MongoDB RU must enforce the use of a Managed Identity to authenticate to Azure resources where this is supported (What) within target service access control settings (How) in order to remove the need to store credentials (Why) | False | False  | The `identity` block is provisioned in `cosmosdbaccount`. The control will be implemented by LSEG standard. |
| 2. | AZU-CDBMRU-IA_020 | Cosmos DB MongoDB RU must not use the built-in Azure Cosmos DB service principal| Cosmos DB MongoDB RU must not use the built-in Azure Cosmos DB service principal to authenticate to Key Vault and retrieve customer managed keys (What) within code deployment parameters (How) in order to prevent the reuse of a tenant service principal and remove the need to store credentials (Why)| True | False | Service principal is not being for authentication in code implementation. |
| 3. | AZU-CDBMRU-IA_030 | Cosmos DB MongoDB RU must not allow the use of Read-only Access Keys for authentication | Cosmos DB MongoDB RU must not allow the use of Read-only Access Keys for authentication (What) within Connection strings (How) in order to use modern robust and less prone to compromise authentication methods (Why) | False | False | This control will be implemented by LSEG standard. |
| 4. | AZU-CDBMRU-IA_040 | Cosmos DB MongoDB RU must not allow the use of Read-write Access Keys for authentication |  Cosmos DB MongoDB RU must not allow the use of Read-write Access Keys for authentication (What) within Connection strings (How) in order to use modern robust and less prone to compromise authentication methods (Why) | False | False | This control will be implemented via policy. |
| 5. | AZU-CDBMRU-IA_050 | Cosmos DB MongoDB RU local service accounts must meet LSEG complexity requirements and be stored in the LSEG approved secrets management system |  Cosmos DB MongoDB RU local service accounts must meet LSEG complexity requirements and be stored in the LSEG approved secrets management system (What) within code deployment parameters (How) in order to protect secrets by using a secure storage mechanism (Why) | False | False | This control will be implemented by LSEG standard. |
| 6. | AZU-CDBMRU-AC_010 | Cosmos DB MongoDB RU must disable Public Network Access | Cosmos DB MongoDB RU must enforce a network guardrail (What) within Networking settings (How) in order to prevent unauthorised access and data exposure to the internet (Why) | False | False | The feature to `disable` public network access is not available for this product by Azure, `private_endpoint` can be added for private access. |
| 7. | AZU-CDBMRU-AC_020 | Cosmos DB MongoDB RU must enforce Role-based access control (RBAC) | Cosmos DB MongoDB RU must enforce Role-based access control (RBAC) for data plane operations (What) within Features, Role-based access control (RBAC) (How) in order to use fine-grained, role-based access when making data requests (Why) | True | False | This control is implemented by `azurerm_cosmosdb_mongo_user_definition` and `azurerm_cosmosdb_mongo_role_definition` block through which roles can be assigned. |
| 8. | AZU-CDBMRU-AU_010 | Send all security and audit diagnostic log categories to a central SOC Log Analytics workspace |  Cosmos DB MongoDB RU must send all security and audit diagnostic logs to a central SOC Log Analytics workspace (What) within Diagnostic settings (How) in order to support a security investigation after a security incident (Why)| False | False | This control will be implemented via policy. |
| 9. | AZU-CDBMRU-AU_020 | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval |  Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval (What) within Diagnostic settings (How) in order to prevent sensitive data leakage to third parties outside of LSEG control (Why) | False | False | This control will be implemented by LSEG standard. |
| 10. | AZU-CDBMRU-SC_010 | Must use a dedicated CMK for Cosmos DB MongoDB RU encryption key management that is persisted in a Key Vault premium SKU | Use a dedicated Cosmos DB MongoDB RU LSEG managed encryption at rest key persisted in a Key Vault premium SKU (What) within code deployment parameters (How) in order should Microsoft's key management platform become compromised LSEG can revoke access to exfiltrated encrypted data (Why) | True | False | The feature to add `Customer Managed Key` has been provisioned in `cosmosdbaccount` to encrypt data. The `sku_name` must be set to `Premium`. |
| 11. | AZU-CDBMRU-SC_020 | Cosmos DB MongoDB RU must have a data classification tag |  Cosmos DB MongoDB RU must have a data classification tag with one of the following values, Public, Corporate, Restricted or Highly Restricted (What) within Tags setting (How) in order to differentiate assets technical control requirements and to assist Security Operations in prioritising possible data breach mitigation responses (Why) | False | False |Tags are not supported in Mongo Database. |
| 12. | AZU-CDBMRU-SC_030 | Azure App Deployment must not be able to corrupt the centrally managed private link private DNS zones when making a private endpoint for Cosmos DB MongoDB RU |  Cosmos DB MongoDB RU must have an Azure DeployIfNotExists policy to update the centrally managed private link private DNS zones with its private A record (What) via Policy to management group mapping (How) to ensure there is no ability for the Azure App Deployment team to have authorisation over these zones that could allow them to corrupt this file and impact service availability (Why) | False | False | This control will be implemented via policy. |
| 13. | AZU-CDBMRU-SC_040 | Cosmos DB MongoDB RU must not enable Diagnostics full-text query in Production environments | : Cosmos DB MongoDB RU must not enable Diagnostics full-text query in Production environments (What) within Features, Diagnostics full-text query (How) in order to ensure sensitive data is not recorded within less secure logging systems | False | False | This control will be implemented by LSEG standard. |
| 14. | AZU-CDBMRU-CP_010 | Backup retention policy must be reviewed against requirements and set accordingly | Backup retention policy must be reviewed against requirements and set accordingly (What) within Backup & Restore Settings (How) in order to ensure retention meets the application, regulatory and disaster recovery requirements (Why) | False | False | This control will be implemented by LSEG standard. |
| 15. | AZU-CDBMRU-PT_010 | Cosmos DB MongoDB RU must only replicate data to LSEG approved geographical regions | Cosmos DB MongoDB RU must only replicate data to LSEG approved geographical regions (What) within Replicate data globally (How) in order to adhere to country specific data residency laws | False | False | This control will be implemented by LSEG standard. |
| 16. | AZU-CDBMRU-SI_010 | Cosmos DB MongoDB RU version must be kept to within n-2 versions |  Cosmos DB MongoDB RU version must be kept to within n-2 versions (What) with Features, Update Mongo DB server version (How) in order to keep up to date with vulnerability remediation's (Why) | False | False | This control will be implemented via policy. |

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Monitor Azure Cosmos DB for MongoDB vCore diagnostics logs with Azure Monitor](https://learn.microsoft.com/en-us/azure/cosmos-db/mongodb/vcore/how-to-monitor-diagnostics-logs?tabs=log-analytics) <br><br>[Cloud monitoring service level objectives](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives)<br><br>[Supported Metrics for Azure Cosmos DB for MongoDB](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-documentdb-mongoclusters-metrics) |
| 5.| [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | True | This control will be implemented at cosmosdb account level using the attribute `zone_redundant` of `geo_location` block and attribute `storage_redundancy` of `backup` block and `restore` block under resource type azurerm_cosmosdb_account. This is applicable only for Regular Mongo Database since terraform doesn't support vCore Cluster. <br><br>[Reliability in Azure Cosmos DB for MongoDB vCore](https://learn.microsoft.com/en-us/azure/reliability/reliability-cosmos-mongodb?toc=%2Fazure%2Fcosmos-db%2Fmongodb%2Fvcore%2Ftoc.json) <br><br>[Azure Cosmos DB for MongoDB Backup & Restore](https://learn.microsoft.com/en-us/azure/cosmos-db/mongodb/vcore/how-to-restore-cluster) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-OPS-09 Update Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-09-03 Deploy regular software updates and bug-fixes<br><br>SMCF-OPS-09-04 Monitor software update status and remediate non-compliant resources | Documentation<br><br>Documentation | False | This requires planning to upgrade clients to a version compatible with the API version we are upgrading to before upgrading the Azure Cosmos DB for MongoDB account. <br><br>[Upgrade the API version of your Azure Cosmos DB for MongoDB account](https://learn.microsoft.com/en-us/azure/cosmos-db/mongodb/upgrade-version) |
| 8. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place. <br><br>[Azure Cosmos DB for MongoDB RBAC](https://learn.microsoft.com/en-us/azure/cosmos-db/role-based-access-control) |

## Changelog

- [azure-prdsvc-terraform-cosmosdbmongodatabase](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/cosmos-db/mongodb/introduction)

### Terraform Docs

- [azurerm_cosmosdb_mongo_database](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_mongo_database)
- [azurerm_cosmosdb_mongo_collection](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_mongo_collection)
- [azurerm_cosmosdb_mongo_user_definition](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_mongo_user_definition)
- [azurerm_cosmosdb_mongo_role_definition](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_mongo_role_definition)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0 |
| <a name="requirement_azapi"></a> [azapi](#requirement_azapi) | >=1.10 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm) | >=4.33 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azapi"></a> [azapi](#provider_azapi) | >=1.10 |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | >=4.33 |

## Resources

| Name | Type |
|------|------|
| [azapi_resource.mongo_role_definition](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azurerm_cosmosdb_mongo_collection.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_mongo_collection) | resource |
| [azurerm_cosmosdb_mongo_database.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_mongo_database) | resource |
| [azurerm_cosmosdb_mongo_user_definition.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_mongo_user_definition) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_autoscale_settings"></a> [autoscale_settings](#input_autoscale_settings) | (Optional)<br/>object({<br/>  max_throughput = (Optional) The maximum throughput of the MongoDB database (RU/s). Must be between 1,000 and 1,000,000. Must be set in increments of 1,000. Conflicts with throughput.<br/>}) | <pre>object({<br/>    max_throughput = optional(number, 1000)<br/>  })</pre> | `null` | no |
| <a name="input_cosmosdb_account_id"></a> [cosmosdb_account_id](#input_cosmosdb_account_id) | (Required) The ID of the Cosmos DB Account. Used as parent resource for MongoDB role definitions. | `string` | n/a | yes |
| <a name="input_cosmosdb_account_name"></a> [cosmosdb_account_name](#input_cosmosdb_account_name) | (Required) The name of the Cosmos DB Mongo Database to create the table within. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_inherited_role_names"></a> [inherited_role_names](#input_inherited_role_names) | (Optional) A list of Mongo Roles that are inherited to the Mongo User Definition. | `list(string)` | `[]` | no |
| <a name="input_mongo_role_definition"></a> [mongo_role_definition](#input_mongo_role_definition) | (Optional) Configuration for MongoDB Role Definition.<br/>object({<br/>  role_name            = (Required) A user-friendly name for the Role Definition. Must be unique for the database account.<br/>  type                 = (Optional) Indicates whether the Role Definition was built-in or user created. Possible values are 'CustomRole' and 'BuiltInRole'. Defaults to 'CustomRole'.<br/>  inherited_role_names = (Optional) A list of role names which are inherited by this Role Definition.<br/>  privileges           = (Optional) A list of privilege objects. Each privilege contains:<br/>    - actions  = (Required) An array of actions that are allowed.<br/>    - resource = (Required) A resource block containing:<br/>      - collection_name = (Optional) The collection name the role is applied.<br/>      - db_name         = (Optional) The database name the role is applied.<br/>}) | <pre>object({<br/>    role_name            = string<br/>    type                 = optional(string, "CustomRole")<br/>    inherited_role_names = optional(list(string))<br/>    privileges = optional(list(object({<br/>      actions = list(string)<br/>      resource = object({<br/>        collection_name = optional(string)<br/>        db_name         = optional(string)<br/>      })<br/>    })))<br/>  })</pre> | `null` | no |
| <a name="input_mongocollection"></a> [mongocollection](#input_mongocollection) | (Optional)<br/>map(object({<br/>  name = (Required) Specifies the name of the Cosmos DB Mongo Collection. Changing this forces a new resource to be created.<br/>  shard_key = (Optional) The name of the key to partition on for sharding. There must not be any other unique index keys. Changing this forces a new resource to be created.<br/>  analytical_storage_ttl = (Optional) The default time to live of Analytical Storage for this Mongo Collection. If present and the value is set to -1, it is equal to infinity, and items don’t expire by default. If present and the value is set to some number n – items will expire n seconds after their last modified time.<br/>  default_ttl_seconds = (Optional) The default Time To Live in seconds. If the value is -1, items are not automatically expired.<br/>  throughput = (Optional) The throughput of the MongoDB collection (RU/s). Must be set in increments of 100. The minimum value is 400. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply.<br/>  index =  (Optional) One or more index blocks as defined below.<br/>  (map(object({<br/>    keys = (Required) Specifies the list of user settable keys for each Cosmos DB Mongo Collection.<br/>    unique = (Optional) Is the index unique or not? Defaults to false. <br/>  })))<br/>  autoscale_settings = (Optional) An autoscale_settings block as defined below. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply.<br/>  (object({<br/>    max_throughput = (Optional) The maximum throughput of the MongoDB collection (RU/s). Must be between 1,000 and 1,000,000. Must be set in increments of 1,000. Conflicts with throughput.<br/>  }))<br/>})) | <pre>map(object({<br/>    name                   = string<br/>    shard_key              = optional(string)<br/>    analytical_storage_ttl = optional(number, -1)<br/>    default_ttl_seconds    = optional(number, -1)<br/>    throughput             = optional(number)<br/>    index = optional(map(object({<br/>      keys   = list(string)<br/>      unique = optional(bool, false)<br/>    })))<br/>    autoscale_settings = optional(object({<br/>      max_throughput = optional(number, 1000)<br/>    }))<br/>  }))</pre> | `null` | no |
| <a name="input_mongodatabase_name"></a> [mongodatabase_name](#input_mongodatabase_name) | (Required) Specifies the name of the Cosmos DB Mongo Database. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_mongodb_password"></a> [mongodb_password](#input_mongodb_password) | (Required) The password for the Mongo User Definition. | `string` | n/a | yes |
| <a name="input_mongodb_username"></a> [mongodb_username](#input_mongodb_username) | (Required) The username for the Mongo User Definition. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_throughput"></a> [throughput](#input_throughput) | (Optional) The throughput of the MongoDB database (RU/s). Must be set in increments of 100. The minimum value is 400 and has a maximum value of 1000000. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply. | `number` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The ID of the Cosmos DB Mongo Database. |
| <a name="output_mongo_collection_id"></a> [mongo_collection_id](#output_mongo_collection_id) | The ID of the Cosmos DB Mongo Collection. |
| <a name="output_mongo_collection_name"></a> [mongo_collection_name](#output_mongo_collection_name) | The Name of the Cosmos DB Mongo Collection. |
| <a name="output_mongo_collection_resource"></a> [mongo_collection_resource](#output_mongo_collection_resource) | The resource of the Cosmos DB Mongo Collection. |
| <a name="output_name"></a> [name](#output_name) | The Name of the Cosmos DB Mongo Database. |
| <a name="output_resource"></a> [resource](#output_resource) | The Cosmos DB Mongo Database resource. |
<!-- END_TF_DOCS -->
