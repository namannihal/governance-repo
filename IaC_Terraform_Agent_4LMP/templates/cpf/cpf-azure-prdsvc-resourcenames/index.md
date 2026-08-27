<!-- BEGIN_TF_DOCS -->
# azure-prdsvc-terraform-resourcenames

[[_TOC_]]

## Introduction

### Component Description

azure-prdsvc-terraform-resourcenames is a helper module which generates resource names for Azure resources according to the customer Naming convention.

The resource delivers:

- No Resource at all
- Names for resources

### Additional notes

full resource object containing name, toolong, max\_length, slug and others

If the name of a resource is longer than allowed by Azure, it will not appear in `names`. Within deployments this will lead to an error in terraform 'key not found on object'. In those cases consider to shorten `context` or do not provide `region`. `resources` can be used for troubleshooting purposes as it contains a property `toolong`.

### Example Usage 1

Returns the name of the key vault. For example 'a0a12345devkvtestwe001'

```tf
module "azure-prdsvc-terraform-resourcenames" {
  source      = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames?ref=0.2.0"
  orgId       = "a0a"
  appId       = "12345"
  region      = "westeurope"
  environment = "dev"
  context     = "test"
  instance    = "001"
}

resource "azurerm_key_vault" "main" {
  name = module.azu-comp-tf-resourcenames.names.azurerm_key_vault
  ...
}

```

### Example Usage 2
Returns the name of the storage account. For example 'a0a12345devsttestwe001'

```tf
module "azu-comp-tf-resourcenames" {
  source      = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames?ref=0.1.0"
  orgId       = "a0a"
  appId       = "12345"
  region      = "weu"
  environment = "dev"
  context     = "test"
  instance    = "001"
}

resource "azurerm_storage_account" "main" {
  name = module.azure-prdsvc-terraform-resourcenames.names.azurerm_storage_account
  ...
}

```

### Developer docs

Earlier Versions of this module were based on [azurecaf\_name](https://registry.terraform.io/providers/aztfmod/azurecaf/1.2.16/docs/resources/azurecaf_name).
As we identified several bugs in its implementation which we could not resolve, we decided to rewrite the module.\
All names are generated the same way as `azurecaf_name` would do, except those which would be too long compared to the max length for the resource.
While `azurecaf_name` would cut off the name, we decided to exclude those names from the result as they would not be compliant to the customer naming convention anymore.

The Terraform code itself makes use of the `resourceDefinition.json` which can be downloaded from [terraform-provider-azurecaf](https://github.com/aztfmod/terraform-provider-azurecaf).\
If there are new Azure resources, one option to implement them would be to update this json with the most current version from GitHub.\
We also maintain a `customization.json` within this module. Within this json we can define adjustments and overwrite properties for resources.
e.g.

```json
{
    "azurerm_example_how_to_exclude": {
        "exclude": true // if we set exclude to true the resource will be excluded from output
    },
    "azurerm_function_app": {
        "slug": "func" // if we identify bugs in the resourceDefinition.json, we can correct properties as well
    }
}
```

### Changelog

- [azure-prdsvc-terraform-resourcenames](CHANGELOG.md)

## References

### Microsoft Docs

- [Azure Service Level Agreement](https://azure.microsoft.com/en-us/support/legal/sla/summary)

### Terraform Docs

- [azurecaf\_name](https://registry.terraform.io/providers/aztfmod/azurecaf/1.2.16/docs/resources/azurecaf_name)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |

## Providers

No providers.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app\_id](#input\_app\_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input\_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_separator"></a> [separator](#input\_separator) | (Optional) If a resource does not support hyphens, hyphens should be left out or replaced with 0 instead. e.g. Storage Accounts | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_names"></a> [names](#output\_names) | delivers a list of all resource names available mapped to the azurerm resource |
| <a name="output_names_toolong"></a> [names\_toolong](#output\_names\_toolong) | delivers a list of all resource names which are too long to be made available in `names` |
| <a name="output_resources"></a> [resources](#output\_resources) | full resource object containing name, toolong, max\_length, slug and others |
<!-- END_TF_DOCS -->
