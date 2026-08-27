---
version: 2.0.1
available_versions:
  - 2.0.1
  - 2.0.0
  - 1.2.0
  - 1.1.0
  - 1.0.0
---

<!-- BEGIN_TF_DOCS -->
# CosmosDB SQL Container module


## Overview

This terraform module creates a cosmosdb sql container and associated resources.

## Prerequisites

- Cosmos DB SQL Container is a child resource of Cosmos DB Account. A Cosmos DB Account parent resource and related dependencies must be existing before deploying a Cosmos DB SQL Container. That includes:
  - `Resource Group`, `Virtual Network` (To be called if not existing).
  - `Subnet` to be used by the Private Endpoint.
  - `Network Security Group` to be associated with the Subnet.
  - `Route Table` to be associated with the Subnet.
  - `Key Vault` to store Cosmos DB Account Customer Managed Key (CMK) encryption.
  - `Private Endpoint` to create a private connection to the Key Vault and the Cosmos DB Account.
  - `User Assigned Identity` to be leveraged for both the Cosmos DB Account identity and CMK   encryption.
  - `Cosmos DB Account` and `Cosmos SQL DB` as the cosmos db sql container mandatory parent resource.

## Guidance

#### Usage

AzureRM 4.x Upgrade Notes for CosmosDB SQL Container

Impact analysis -- Medium

When migrating from azurerm 3.x to 4.x, you must update the value for `partition_key_paths` from a string to a list of strings. This means that if you previously provided a single string value, you now need to wrap it in square brackets to make it a list. For example, change:

```hcl
partition_key_path = "/myPartitionKey"
```

to

```hcl
partition_key_paths = ["/myPartitionKey"]
```

No other variable-level changes are required.

- The `partition_key_path` argument is replaced by `partition_key_paths`, and its type changes from `string` to `list(string)`.

Wiki link for [AzureRM 4.x Upgrade](https://gitlab.dx1.lseg.com/groups/app/app-51310/azure/prdsvc/terraform/-/wikis/Terraform-AzureRM-Provider-Upgrade:-Version-3.x-to-4.x/Cosmosdb-Sql-Container) for details on the upgrade process.

For more details, refer to the official [AzureRM 4.x Upgrade Guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide)

- This module deploys the cosmosdb sql container and other child resources such as cosmosdb sql function, cosmosdb sql trigger, cosmosdb sql stored procedure.

## Important: Breaking Change for Partial Configuration Tag - 1.2.0

**CAUTION:** Users who partially specify `combined_attributes` without including `throughput` must now explicitly set the throughput value based on their configuration requirements.

## Usage Scenarios

- **Don't pass `combined_attributes` block at all**: Uses default values from variable definition (throughput = 400).
- **Pass partial `combined_attributes` without throughput**: Throughput becomes `null` (uses database-level throughput cascade).
- **Explicit null for database-level throughput**: Set `throughput = null` to share throughput configured at database level.
- **Container-level throughput**: Specify explicit value (e.g., `throughput = 800`) for dedicated container throughput.
- **Autoscale mode**: When `autoscale_settings` is provided at container level, throughput is automatically set to `null`.

## Migration Guide for Existing Users

- **No `combined_attributes` specified**: No change required - continues using default throughput = 400.
- **Partial `combined_attributes` without throughput**: **ACTION REQUIRED** - Add `throughput = 400` (or your desired value) to maintain previous behavior.
- **Explicit `throughput = null`**: No change required - null value is preserved for database-level throughput sharing.
- **Explicit throughput values**: No change required - values are preserved.

## Important: Version Upgrade Guidance - 2.0.0

**CAUTION:** This module version includes a variable default behavior change for `combined_attributes.analytical_storage_ttl`; if this value is not passed when required, it may cause configuration drift and trigger Cosmos DB SQL container redeployment.

- **Upgrade required**: Consumers must bump the module version to `v2.0.0` (or higher) to get this fix.
- **When account-level analytical storage is enabled**: Explicitly pass `combined_attributes.analytical_storage_ttl` as either `-1` (infinite retention) or a specific TTL value.
- **Important**: If account-level analytical storage is enabled and this value is not passed explicitly, it can cause configuration drift and trigger container redeployment.
- **When account-level analytical storage is disabled**: Do not pass `combined_attributes.analytical_storage_ttl`.

#### Security Considerations

- It's observed that 'analyticalStorageTtl' property in Cosmosdb sql container has a one to one relationship with the attribute 'analytical_storage_enabled' which needs to be set as true in 'azurerm_cosmosdb_account' resource while provisioning the container.

## Security Controls

Currently, as per LSEG Approved Cosmos DB SQL Container Security Requirements, there are no security controls for this product.

## Changelog

- [azure-prdsvc-terraform-cosmosdbsqlcontainer](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/cosmos-db/nosql/)

### Terraform Docs

- [azurerm_cosmosdb_sql_container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_sql_container)
- [azurerm_cosmosdb_sql_function](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_sql_function)
- [azurerm_cosmosdb_sql_trigger](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_sql_trigger)
- [azurerm_cosmosdb_sql_stored_procedure](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_sql_stored_procedure)

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
| [azurerm_cosmosdb_sql_container.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_sql_container) | resource |
| [azurerm_cosmosdb_sql_function.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_sql_function) | resource |
| [azurerm_cosmosdb_sql_stored_procedure.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_sql_stored_procedure) | resource |
| [azurerm_cosmosdb_sql_trigger.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_sql_trigger) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_name"></a> [account_name](#input_account_name) | (Required) The name of the Cosmos DB Account to create the container within. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_autoscale_settings"></a> [autoscale_settings](#input_autoscale_settings) | (Optional)<br/>object({<br/>  max_throughput =  (Optional) The maximum throughput of the SQL container (RU/s). Must be between 1,000 and 1,000,000. Must be set in increments of 1,000. Conflicts with throughput.<br/>}) | <pre>object({<br/>    max_throughput = optional(number, 1000)<br/>  })</pre> | `null` | no |
| <a name="input_combined_attributes"></a> [combined_attributes](#input_combined_attributes) | (optional)<br/>object({<br/>  partition_key_version  = (Optional) Define a partition key version. Changing this forces a new resource to be created. Possible values are 1and 2. This should be set to 2 in order to use large partition keys.<br/>  throughput             = (Optional) The throughput of SQL container (RU/s). Must be set in increments of 100. The minimum value is 400. This must be set upon container creation otherwise it cannot be updated without a manual terraform destroy-apply.<br/>  default_ttl            = (Optional) The default time to live of SQL container. If missing, items are not expired automatically. If present and the value is set to -1, it is equal to infinity, and items don’t expire by default. If present and the value is set to some number n – items will expire n seconds after their last modified time.<br/>  analytical_storage_ttl = (Optional) The default time to live of Analytical Storage for this SQL container. If present and the value is set to -1, it is equal to infinity, and items don’t expire by default. If present and the value is set to some number n – items will expire n seconds after their last modified time.<br/>}) | <pre>object({<br/>    partition_key_version  = optional(number, 1)<br/>    throughput             = optional(number)<br/>    default_ttl            = optional(number, -1)<br/>    analytical_storage_ttl = optional(number, null)<br/>  })</pre> | <pre>{<br/>  "analytical_storage_ttl": null,<br/>  "default_ttl": -1,<br/>  "partition_key_version": 1,<br/>  "throughput": 400<br/>}</pre> | no |
| <a name="input_conflict_resolution_policy"></a> [conflict_resolution_policy](#input_conflict_resolution_policy) | (Optional)<br/>  mode                          = (Required) Indicates the conflict resolution mode. Possible values include: LastWriterWins, Custom.<br/>  conflict_resolution_path      = (Optional) The conflict resolution path in the case of LastWriterWins mode.<br/>  conflict_resolution_procedure = (Optional) The procedure to resolve conflicts in the case of Custom mode. | <pre>map(object({<br/>    mode                          = string<br/>    conflict_resolution_path      = optional(string)<br/>    conflict_resolution_procedure = optional(string)<br/>  }))</pre> | `null` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_database_name"></a> [database_name](#input_database_name) | (Required) The name of the Cosmos DB SQL Database to create the container within. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_indexing_policy"></a> [indexing_policy](#input_indexing_policy) | (Optional)<br/>object({<br/>  indexing_mode =  (Optional) Indicates the indexing mode. Possible values include: consistent and none. Defaults to consistent.<br/>  included_path =  (Optional) One or more included_path blocks as defined below. Either included_path or excluded_path must contain the path /*<br/>  map(object({<br/>    path        =  (Required) Path for which the indexing behaviour applies to.<br/>  }))<br/>  excluded_path =  (Optional) One or more excluded_path blocks as defined below. Either included_path or excluded_path must contain the path /*<br/>  map(object({<br/>    path        =  (Required) Path that is excluded from indexing.<br/>  }))<br/>  composite_index = (Optional) One or more composite_index blocks as defined below.<br/>  map(object({<br/>    index         = (Required) One or more index blocks as defined below.<br/>    map(object({<br/>      path  = (Required) Path for which the indexing behaviour applies to.<br/>      order = (Required) Order of the index. Possible values are Ascending or Descending.<br/>    }))  <br/>  }))<br/>  spatial_index = (Optional) One or more spatial_index blocks as defined below.<br/>  map(object({<br/>    path        = (Required) Path for which the indexing behaviour applies to. According to the service design, all spatial types including LineString, MultiPolygon, Point, and Polygon will be applied to the path.<br/>  }))<br/>}) | <pre>object({<br/>    indexing_mode = optional(string, "consistent")<br/>    included_path = optional(map(object({<br/>      path = string<br/>    })))<br/>    excluded_path = optional(map(object({<br/>      path = string<br/>    })))<br/>    composite_index = optional(map(object({<br/>      index = map(object({<br/>        path  = string<br/>        order = string<br/>      }))<br/>    })))<br/>    spatial_index = optional(map(object({<br/>      path = string<br/>    })))<br/>  })</pre> | `null` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input_name) | (Optional) Specifies the name of the Cosmos DB SQL Container resource. If not provided, the resource name is created leveraging LSEG variables as per standard naming convention. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_partition_key_kind"></a> [partition_key_kind](#input_partition_key_kind) | (Optional) Define a partition key kind. Possible values are Hash and MultiHash. Defaults to Hash. Changing this forces a new resource to be created. | `string` | `"Hash"` | no |
| <a name="input_partition_key_path"></a> [partition_key_path](#input_partition_key_path) | (Required) Define a partition key. Changing this forces a new resource to be created. | `list(string)` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_sql_function"></a> [sql_function](#input_sql_function) | (Optional)<br/>map(object({<br/>  name = "(Required) The name which should be used for this SQL User Defined Function. Changing this forces a new SQL User Defined Function to be created."<br/>  body = "(Required) Body of the User Defined Function."<br/>})) | <pre>map(object({<br/>    name = string<br/>    body = string<br/>  }))</pre> | `null` | no |
| <a name="input_sql_storedprocedure"></a> [sql_storedprocedure](#input_sql_storedprocedure) | (Optional)<br/>map(object({<br/>  name          = "(Required) Specifies the name of the Cosmos DB SQL Stored Procedure. Changing this forces a new resource to be created."<br/>  body          = "(Required) The body of the stored procedure."<br/>  account_name  = "(Required) The name of the cosmosdb account."<br/>  database_name = "(Required) The name of the cosmosdb sql database."<br/>})) | <pre>map(object({<br/>    name          = string<br/>    body          = string<br/>    account_name  = string<br/>    database_name = string<br/>  }))</pre> | `null` | no |
| <a name="input_sql_trigger"></a> [sql_trigger](#input_sql_trigger) | (Optional)<br/>map(object({<br/>  name      = "(Required) The name which should be used for this SQL Trigger. Changing this forces a new SQL Trigger to be created."<br/>  body      = "(Required) Body of the SQL Trigger."<br/>  operation = "(Required) The operation the trigger is associated with. Possible values are All, Create, Update, Delete and Replace."<br/>  type      = "(Required) Type of the Trigger. Possible values are Pre and Post."<br/>})) | <pre>map(object({<br/>    name      = string<br/>    body      = string<br/>    operation = string<br/>    type      = string<br/>  }))</pre> | `null` | no |
| <a name="input_unique_key"></a> [unique_key](#input_unique_key) | (Optional)<br/>map(object({<br/>  paths =  (Required) A list of paths to use for this unique key. Changing this forces a new resource to be created. <br/>})) | <pre>map(object({<br/>    paths = list(string)<br/>  }))</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_function_id"></a> [function_id](#output_function_id) | The ID of the SQL User Defined Function. |
| <a name="output_function_name"></a> [function_name](#output_function_name) | The name of the SQL User Defined Function. |
| <a name="output_function_resource"></a> [function_resource](#output_function_resource) | The CosmosDB SQL Function resource. |
| <a name="output_id"></a> [id](#output_id) | The ID of the CosmosDB SQL Container. |
| <a name="output_name"></a> [name](#output_name) | The name of the CosmosDB SQL Container. |
| <a name="output_resource"></a> [resource](#output_resource) | The CosmosDB SQL Container resource. |
| <a name="output_stored_procedure_id"></a> [stored_procedure_id](#output_stored_procedure_id) | The ID of the Cosmos DB SQL Stored Procedure. |
| <a name="output_stored_procedure_name"></a> [stored_procedure_name](#output_stored_procedure_name) | The name of the Cosmos DB SQL Stored Procedure. |
| <a name="output_stored_procedure_resource"></a> [stored_procedure_resource](#output_stored_procedure_resource) | The CosmosDB SQL Stored Procedure resource. |
| <a name="output_trigger_id"></a> [trigger_id](#output_trigger_id) | The ID of the SQL Trigger. |
| <a name="output_trigger_name"></a> [trigger_name](#output_trigger_name) | The name of the SQL Trigger. |
| <a name="output_trigger_resource"></a> [trigger_resource](#output_trigger_resource) | The CosmosDB SQL Trigger resource. |
<!-- END_TF_DOCS -->
