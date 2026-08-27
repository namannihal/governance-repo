---
version: 1.0.1
available_versions:
  - 1.0.1
  - 1.0.0
  - 0.1.1
  - 0.1.0
---

<!-- BEGIN_TF_DOCS -->
# Postgres Flexible server Virtual Endpoint module


## Overview

This terraform module creates a Postgres Flexible server Virtual Endpoint and associated resources.

## Prerequisites

- A Postgre Flexible Server with required configurations and [dependencies](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-postgresqlserver/-/blob/main/README.md) deployed to host the database.

## Guidance

#### Usage

- This module deploys the Azure PostgreSQL Flexible Server Virtual Endpoint associated with `PostgreSQL Flexible Server`.

#### Security Considerations

#### Additional Information

- The Postgres Flexible server Virtual Endpoint feature released as a part azurerm version 3.116.0. The required azurerm version `3.116.0` or later.
- The Virtual Endpoint currently supports `ReadWrite` type only.
- Given the dependency on the primary and replica servers' existence prior to the virtual endpoint creation, and the limitation of a single endpoint per server, Created a seperate azure-prdsvc-terraform-postgresqlvirtualendpoint for virtual endpoint resource.
- All operations involving virtual endpoints, whether adding, editing, or removing, are performed in the context of the Default create mode.
- Pester test cases have been implemented to verify the postgresqlserver name. However, testing for the existence of  virtual endpoints is not included as this functionality is currently not supported via PowerShell dated 26th Aug, 2024.

## Security Controls

- Security control of this product is coverd under parent module `azure-prdsvc-terraform-postgresqlserver`.

## Changelog

- [azure-prdsvc-terraform-postgresqlvirtualendpoint](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-read-replicas-virtual-endpoints)

### Terraform Docs

- [azure-prdsvc-terraform-postgresqlvirtualendpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_virtual_endpoint)

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
| [azurerm_postgresql_flexible_server_virtual_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_virtual_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_replica_server_id"></a> [replica_server_id](#input_replica_server_id) | (Required) The Resource ID of the Replica Postgres Flexible Server this should be associated with. | `string` | n/a | yes |
| <a name="input_source_server_id"></a> [source_server_id](#input_source_server_id) | (Required) The Resource ID of the Source Postgres Flexible Server this should be associated with. | `string` | n/a | yes |
| <a name="input_virtual_endpoint_name"></a> [virtual_endpoint_name](#input_virtual_endpoint_name) | (Required) The name of the Virtual Endpoint. | `string` | n/a | yes |
| <a name="input_virtual_endpoint_type"></a> [virtual_endpoint_type](#input_virtual_endpoint_type) | (Required) The type of Virtual Endpoint. Currently only ReadWrite is supported. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The X ID of the Postgresflexible server Virtual Endpoint. |
| <a name="output_name"></a> [name](#output_name) | The name of the Postgresflexible server Virtual Endpoint. |
| <a name="output_resource"></a> [resource](#output_resource) | The Postgresflexible server Virtual Endpoint resource. |
<!-- END_TF_DOCS -->
