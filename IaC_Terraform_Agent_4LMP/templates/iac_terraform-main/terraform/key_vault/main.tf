#
# Copyright 2025 LSEG & Microsoft. All rights reserved.
#

data "azurerm_client_config" "this" {}

module "keyvaultprivateendpoint" {
  source                          = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvcpat/terraform/azure-prdsvcpat-terraform-keyvaultprivateendpoint.git?ref=0.4.3"
  for_each                        = var.keyvaults
  org_id                          = var.org_id
  app_id                          = var.app_id
  location                        = var.location
  environment                     = var.environment
  tags                            = var.tags
  context                         = each.value.context
  instance                        = each.value.instance
  resource_group_name             = var.resource_group_name
  sku_name                        = var.sku_name
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment
  network_acls = {
    bypass = "AzureServices"
  }

  private_endpoint = each.value.private_endpoint
}