#
# Copyright 2025 LSEG & Microsoft. All rights reserved.
#

#------------------------------------------
# Data Sources
#------------------------------------------
data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

#------------------------
# - Create Azure Compute Gallery (Primary Region Only)
#------------------------
module "azure_prdsvc_terraform_azurecomputergallery" {
  #checkov:skip=CKV_TF_1:Skip module check for commit hash
  source              = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-sharedimagegallery.git?ref=0.2.0"
  org_id              = var.org_id
  app_id              = var.app_id
  context             = var.context
  instance            = var.instance
  environment         = var.environment
  location            = var.location
  resource_group_name = data.azurerm_resource_group.this.name
  description         = var.description
}

#--------------------------------
# User Assigned Identity
#--------------------------------
module "azure_prdsvc_terraform_user_assigned_identity_winbyor" {
  #checkov:skip=CKV_TF_1:Skip module check for commit hash
  source              = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-userassignedidentity?ref=0.3.1"
  org_id              = var.org_id
  app_id              = var.app_id
  location            = var.location
  environment         = var.environment
  context             = var.context
  instance            = var.instance
  resource_group_name = data.azurerm_resource_group.this.name
  tags                = var.tags
}

#------------------------------------------
# - Disk Encryption Set
#------------------------------------------
module "azure_prdsvc_terraform_diskencryptionset_winbyor" {
  #checkov:skip=CKV_TF_1:Skip module check for commit hash
  source              = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-diskencryptionset?ref=0.5.1"
  location            = var.location
  org_id              = var.org_id
  app_id              = var.app_id
  environment         = var.environment
  context             = var.context
  instance            = var.instance
  resource_group_name = data.azurerm_resource_group.this.name
  key_vault_id        = var.key_vault_id
  expiration_date     = local.expiration_date
  key_size            = local.key_size
  key_type            = local.key_type
  identity = {
    type         = "SystemAssigned, UserAssigned"
    identity_ids = [module.azure_prdsvc_terraform_user_assigned_identity_winbyor.id]
  }
  uai_principal_id = module.azure_prdsvc_terraform_user_assigned_identity_winbyor.principal_id
  tags             = var.tags
}
#------------------------------------------
# - Image Definitions (Dynamic for Windows/Linux)
#------------------------------------------
resource "azurerm_shared_image" "this" {
  for_each = var.image_definitions

  name                = "${each.value.os_name}-${each.value.os_version}-${each.value.architecture}-${each.value.image_type}"
  gallery_name        = module.azure_prdsvc_terraform_azurecomputergallery.name
  resource_group_name = data.azurerm_resource_group.this.name
  location            = var.location
  os_type             = each.value.os_type

  identifier {
    publisher = each.value.publisher
    offer     = each.value.offer
    sku       = each.value.sku
  }

  hyper_v_generation       = try(each.value.hyper_v_generation, "V2")
  architecture             = each.value.architecture
  description              = try(each.value.description, null)
  trusted_launch_enabled   = try(each.value.security_type, null) == "TrustedLaunch" ? true : null
  trusted_launch_supported = try(each.value.security_type, null) == "TrustedLaunchSupported" ? true : null

  tags = var.tags
}