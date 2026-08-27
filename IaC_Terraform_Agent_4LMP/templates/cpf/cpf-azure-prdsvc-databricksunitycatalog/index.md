---
version: 0.1.0
available_versions:
  - 0.1.0
---

<!-- BEGIN_TF_DOCS -->
# Databricks Catalog Module


## Overview

- This terraform module creates Databricks catalog resource.

## Prerequisites

- Databricks workspace

## Guidance

#### Usage

- This module will be used to create Databricks catalog along with valid parameters input.
- User must have right privilege in order to create `metastore`, `catalog` etc. sub-resources of unity catalog.
- Refer reference docs shared below for right privilege required for creation of sub-resources.
- `tfapply` will fail as catalog deployment requires `account ID` for deployment which can be fetched via admin privileges.

#### Security Considerations

## Security Controls

- There are no security controls for this product.

## SMCF Controls

- There are no SMCF controls for this product.

## Changelog

- [azure-prdsvc-terraform-databrickscatalog](CHANGELOG.md)

## References

### Microsoft Docs

- [official documentation](https://learn.microsoft.com/en-us/azure/databricks/data-governance/unity-catalog/)
- [Admin privileges in Unity Catalog](https://learn.microsoft.com/en-us/azure/databricks/data-governance/unity-catalog/manage-privileges/admin-privileges)

### Terraform Docs

- [databricks_catalog](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/catalog)
- [Deploying pre-requisite resources and enabling Unity Catalog](https://registry.terraform.io/providers/databricks/databricks/latest/docs/guides/unity-catalog-azure)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0 |
| <a name="requirement_databricks"></a> [databricks](#requirement_databricks) | >= 1.40 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_databricks"></a> [databricks](#provider_databricks) | >= 1.40 |

## Resources

| Name | Type |
|------|------|
| [databricks_catalog.this](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/catalog) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_comment"></a> [comment](#input_comment) | (Optional) User-supplied free-form text. | `string` | `null` | no |
| <a name="input_connection_name"></a> [connection_name](#input_connection_name) | (Optional) For Foreign Catalogs: the name of the connection to an external data source. Changes forces creation of a new resource. | `string` | `null` | no |
| <a name="input_enable_predictive_optimization"></a> [enable_predictive_optimization](#input_enable_predictive_optimization) | (Optional) Whether predictive optimization should be enabled for this object and objects under it. Can be ENABLE, DISABLE or INHERIT. | `string` | `"DISABLE"` | no |
| <a name="input_force_destroy"></a> [force_destroy](#input_force_destroy) | (Optional) Delete catalog regardless of its contents. | `string` | `null` | no |
| <a name="input_isolation_mode"></a> [isolation_mode](#input_isolation_mode) | (Optional) Whether the catalog is accessible from all workspaces or a specific set of workspaces. Can be ISOLATED or OPEN. Setting the catalog to ISOLATED will automatically allow access from the current workspace. | `string` | `"OPEN"` | no |
| <a name="input_name"></a> [name](#input_name) | (Required) Name of Catalog relative to parent metastore. | `string` | n/a | yes |
| <a name="input_options"></a> [options](#input_options) | (Optional) For Foreign Catalogs: the name of the entity from an external data source that maps to a catalog. For example, the database name in a PostgreSQL server. | `map(string)` | `{}` | no |
| <a name="input_owner"></a> [owner](#input_owner) | (Optional) Username/groupname/sp application_id of the catalog owner. | `string` | `null` | no |
| <a name="input_properties"></a> [properties](#input_properties) | (Optional) Extensible Catalog properties. | `map(any)` | `{}` | no |
| <a name="input_provider_name"></a> [provider_name](#input_provider_name) | (Optional) For Delta Sharing Catalogs: the name of the delta sharing provider. Change forces creation of a new resource. | `string` | `null` | no |
| <a name="input_share_name"></a> [share_name](#input_share_name) | (Optional) For Delta Sharing Catalogs: the name of the share under the share provider. Change forces creation of a new resource. | `string` | `null` | no |
| <a name="input_storage_root"></a> [storage_root](#input_storage_root) | (Optional) if storage_root is specified for the metastore) Managed location of the catalog. Location in cloud storage where data for managed tables will be stored. If not specified, the location will default to the metastore root location. Change forces creation of a new resource. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The ID of this catalog - same as the `name`. |
| <a name="output_metastore_id"></a> [metastore_id](#output_metastore_id) | The ID of the parent metastore. |
| <a name="output_name"></a> [name](#output_name) | The name of the created databricks catalog. |
| <a name="output_resource"></a> [resource](#output_resource) | The databricks catalog resource. |
<!-- END_TF_DOCS -->
