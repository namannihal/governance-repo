# Copyright 2024 LSEG & Microsoft. All rights reserved.
# Created  on: Oct. 8, 2024
# Created  by: Tarun P
# Modified on: Feb. 20, 2025
# Modified by: Naman Nihal
# Overview:
#   This module:
#  - Creates Azure App Service Plans & Windows Web Apps from tfvars configuration

#-------------------------------
# - Deploy App Service Plans (one per unique configuration)
#-------------------------------
module "azure_prdsvc_terraform_appserviceplan" {
  for_each = var.appserviceplan_configs

  source      = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-appserviceplan?ref=0.6.3"
  org_id      = var.org_id
  app_id      = var.app_id
  location    = var.location
  environment = var.environment
  context     = each.value.context == null ? var.context : each.value.context
  instance    = each.value.instance == null ? var.instance : each.value.instance

  resource_group_name = var.resource_group_name
  tags                = var.tags

  required_for_ase             = each.value.required_for_ase
  sku_name                     = each.value.sku_name
  os_type                      = each.value.os_type
  app_service_environment_id   = each.value.app_service_environment_id
  ase_sku_name                 = each.value.ase_sku_name
  worker_count                 = each.value.worker_count
  maximum_elastic_worker_count = each.value.maximum_elastic_worker_count
  per_site_scaling_enabled     = each.value.per_site_scaling_enabled
  zone_balancing_enabled       = each.value.zone_balancing_enabled
}

#-----------------------------------------------------------
# - Creating User Assigned Identity for each Windows Web App
#-----------------------------------------------------------
module "azure_prdsvc_terraform_userassignedidentity" {
  for_each = var.webapp_config

  source              = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-userassignedidentity?ref=0.4.2"
  org_id              = var.org_id
  app_id              = var.app_id
  location            = var.location
  environment         = var.environment
  context             = each.value.context
  instance            = each.value.instance
  resource_group_name = var.resource_group_name
}

#-----------------------------------
# - RBAC for user-assigned identity to Key Vault - Administrator
#-----------------------------------
module "azure_prdsvc_terraform_roleassignment_keyvault_admin" {
  source   = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-roleassignment?ref=0.2.5"
  for_each = var.webapp_config

  principal_id         = module.azure_prdsvc_terraform_userassignedidentity[each.key].principal_id
  role_definition_name = "Key Vault Administrator"
  scope                = var.key_vault_id

  depends_on = [
    module.azure_prdsvc_terraform_userassignedidentity
  ]
}

#-----------------------------------
# - RBAC for user-assigned identity to Key Vault - Secrets User
#-----------------------------------
module "azure_prdsvc_terraform_roleassignment_keyvault_secrets" {
  source   = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-roleassignment?ref=0.2.5"
  for_each = var.webapp_config

  principal_id         = module.azure_prdsvc_terraform_userassignedidentity[each.key].principal_id
  role_definition_name = "Key Vault Secrets User"
  scope                = var.key_vault_id

  depends_on = [
    module.azure_prdsvc_terraform_userassignedidentity
  ]
}

locals {
  default_storage_account_key = length(var.storage_account_config) > 0 ? sort(keys(var.storage_account_config))[0] : null

  storage_share_entries = concat(
    [
      for sa_key, sa_config in var.storage_account_config : {
        id               = sa_key
        sa_key           = sa_key
        webapp_key       = null
        context          = sa_config.context
        instance         = sa_config.instance
        quota            = sa_config.file_share_config.quota
        enabled_protocol = sa_config.file_share_config.enabled_protocol
        mount_path       = try(sa_config.file_share_config.mount_path, "/mounts/${sa_key}")
      } if can(sa_config.file_share_config)
    ],
    flatten([
      for sa_key, sa_config in var.storage_account_config : [
        for share_key, share in try(sa_config.file_share_configs, {}) : {
          id               = "${sa_key}__${share_key}"
          sa_key           = sa_key
          webapp_key       = try(share.webapp_key, share_key)
          context          = share.context
          instance         = share.instance
          quota            = share.quota
          enabled_protocol = share.enabled_protocol
          mount_path       = try(share.mount_path, "/mounts/${share_key}")
        }
      ]
    ]),
    [
      for webapp_key, webapp in var.webapp_config : {
        id               = "${coalesce(try(webapp.storage_mount.storage_account_key, null), local.default_storage_account_key)}__webapp__${webapp_key}"
        sa_key           = coalesce(try(webapp.storage_mount.storage_account_key, null), local.default_storage_account_key)
        webapp_key       = webapp_key
        context          = coalesce(try(webapp.storage_mount.share_context, null), webapp.context)
        instance         = coalesce(try(webapp.storage_mount.share_instance, null), webapp.instance)
        quota            = try(webapp.storage_mount.quota, 100)
        enabled_protocol = try(webapp.storage_mount.enabled_protocol, "SMB")
        mount_path       = coalesce(try(webapp.storage_mount.mount_path, null), "/mounts/${webapp_key}")
      } if try(webapp.storage_mount.enabled, false) && coalesce(try(webapp.storage_mount.storage_account_key, null), local.default_storage_account_key) != null
    ]
  )

  storage_share_entries_by_id = {
    for share in local.storage_share_entries : share.id => share
  }

  storage_identity_keys_by_sa = {
    for sa_key, sa_config in var.storage_account_config : sa_key => distinct(compact(concat(
      try(sa_config.webapp_identity_keys, []),
      [for _, share in try(sa_config.file_share_configs, {}) : try(share.webapp_key, null)],
      [for webapp_key, webapp in var.webapp_config : webapp_key if try(webapp.storage_mount.enabled, false) && coalesce(try(webapp.storage_mount.storage_account_key, null), local.default_storage_account_key) == sa_key]
    )))
  }
}

#-----------------------------#
#  - Creating Storage Account #
#-----------------------------#
module "azure-prdsvc-storageaccount" {
  source      = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-storageaccount.git?ref=1.0.1"
  for_each    = var.storage_account_config
  org_id      = var.org_id
  app_id      = var.app_id
  location    = var.location
  environment = var.environment
  context     = each.value.context
  instance    = each.value.instance

  resource_group_name                    = var.resource_group_name
  key_vault_id                           = var.key_vault_id
  persist_access_key                     = each.value.persist_access_key
  enable_key_access                      = each.value.enable_key_access
  account_tier                           = each.value.account_tier
  account_replication_type               = each.value.account_replication_type
  kv_secret_expiration_date              = each.value.kv_secret_expiration_date
  enable_file_share_AADDS_authentication = each.value.enable_file_share_AADDS_authentication
  customer_managed_key = {
    key_vault_id          = var.key_vault_id
    identity_principal_id = module.azure_prdsvc_terraform_userassignedidentity[local.storage_identity_keys_by_sa[each.key][0]].principal_id
    expiration_date       = each.value.kv_secret_expiration_date
  }
  identity = {
    type         = "UserAssigned"
    identity_ids = [module.azure_prdsvc_terraform_userassignedidentity[local.storage_identity_keys_by_sa[each.key][0]].id]
  }

  depends_on = [
    module.azure_prdsvc_terraform_roleassignment_keyvault_admin,
    module.azure_prdsvc_terraform_roleassignment_keyvault_secrets
  ]
}

#-----------------------------------------------
# - Private Endpoints module for Storage Account
#-----------------------------------------------
module "azure-prdsvc-terraform-privateendpoint" {
  source      = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-privateendpoint?ref=0.7.2"
  for_each    = var.storage_account_config
  org_id      = var.org_id
  app_id      = var.app_id
  location    = var.location
  environment = var.environment
  context     = substr("st${each.value.context}", 0, 10)
  instance    = each.value.instance

  resource_group_name               = var.resource_group_name
  subnet_id                         = var.privateendpoint_subnet_id
  group_ids                         = ["file"]
  is_manual_connection              = each.value.private_endpoint_config.is_manual_connection
  private_connection_resource_id    = module.azure-prdsvc-storageaccount[each.key].id
  private_connection_resource_alias = null
  static_ip_required                = each.value.private_endpoint_config.static_ip_required
}

#-----------------------------------
# Sleep after Storage PE Creation
#-----------------------------------
resource "time_sleep" "wait_120_seconds_storage" {
  for_each        = var.storage_account_config
  create_duration = "120s"
  depends_on = [
    module.azure-prdsvc-terraform-privateendpoint
  ]
}

#---------------------------
#   Creating Storage Share
#---------------------------
module "azure-prdsvc-terraform-storageshare" {
  source      = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-storageshare?ref=0.3.1"
  for_each    = local.storage_share_entries_by_id
  org_id      = var.org_id
  app_id      = var.app_id
  location    = var.location
  environment = var.environment
  context     = each.value.context
  instance    = each.value.instance

  storage_account_name = module.azure-prdsvc-storageaccount[each.value.sa_key].name
  quota                = each.value.quota
  enabled_protocol     = each.value.enabled_protocol

  depends_on = [
    time_sleep.wait_120_seconds_storage,
    module.azure-prdsvc-storageaccount,
    module.azure-prdsvc-terraform-privateendpoint
  ]
}

#-----------------------------------
# - RBAC for Storage File Share Access (User Assigned Identity to Storage)
#-----------------------------------
resource "azurerm_role_assignment" "storage_file_share_uai" {
  for_each = {
    for pair in flatten([
      for sa_key, identity_keys in local.storage_identity_keys_by_sa : [
        for webapp_key in identity_keys : {
          key        = "${sa_key}_${webapp_key}_uai"
          sa_key     = sa_key
          webapp_key = webapp_key
        }
      ]
    ]) : pair.key => pair
  }

  principal_id                     = module.azure_prdsvc_terraform_userassignedidentity[each.value.webapp_key].principal_id
  role_definition_name             = "Storage File Data SMB Share Contributor"
  scope                            = module.azure-prdsvc-storageaccount[each.value.sa_key].id
  skip_service_principal_aad_check = true

  depends_on = [
    module.azure-prdsvc-storageaccount,
    module.azure_prdsvc_terraform_userassignedidentity
  ]
}

#-----------------------------------
# - Creating Windows Web Apps
#-----------------------------------
module "azure_prdsvc_terraform_windowswebapp" {
  for_each = var.webapp_config

  source                    = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-windowswebapp?ref=1.0.1"
  org_id                    = var.org_id
  app_id                    = var.app_id
  location                  = var.location
  environment               = var.environment
  context                   = each.value.context
  instance                  = each.value.instance
  resource_group_name       = var.resource_group_name
  service_plan_id           = module.azure_prdsvc_terraform_appserviceplan[each.value.asp_key].id
  virtual_network_subnet_id = each.value.network_config.delegated_subnet_id_web_app

  key_vault_reference_identity_id        = module.azure_prdsvc_terraform_userassignedidentity[each.key].id
  client_affinity_enabled                = var.client_affinity_enabled
  client_certificate_enabled             = var.client_certificate_enabled
  client_certificate_mode                = var.client_certificate_mode
  client_certificate_exclusion_paths     = var.client_certificate_exclusion_paths
  enabled                                = var.enabled
  zip_deploy_file                        = var.zip_deploy_file
  virtual_network_backup_restore_enabled = var.virtual_network_backup_restore_enabled
  app_settings = merge(
    var.app_settings,
    {
      "KEYVAULT_HOST_URL" = format("https://%s.vault.azure.net/", split("/", var.key_vault_id)[length(split("/", var.key_vault_id))-1]),
      "UAMI_CLIENT_ID" = module.azure_prdsvc_terraform_userassignedidentity[each.key].client_id
    }
  )
  tags                                   = var.tags
  vnetContentShareEnabled                = var.virtualnetwork_content_share_enabled
  site_config                            = each.value.site_config
  auth_settings                          = var.auth_settings
  auth_settings_v2                       = var.auth_settings_v2
  sticky_settings                        = var.sticky_settings
  logs                                   = var.logs
  storage_accounts = [
    for share in local.storage_share_entries : {
      access_key   = module.azure-prdsvc-storageaccount[share.sa_key].primary_access_key
      account_name = module.azure-prdsvc-storageaccount[share.sa_key].name
      name         = "${share.id}_mount"
      share_name   = module.azure-prdsvc-terraform-storageshare[share.id].name
      type         = "AzureFiles"
      mount_path   = share.mount_path
    } if((share.webapp_key == null && contains(local.storage_identity_keys_by_sa[share.sa_key], each.key)) || (share.webapp_key != null && share.webapp_key == each.key))
  ]
  backup = var.backup
  identity = {
    type         = var.enable_system_assigned_identity ? "SystemAssigned, UserAssigned" : "UserAssigned"
    identity_ids = [module.azure_prdsvc_terraform_userassignedidentity[each.key].id]
  }
  connection_strings = var.connection_strings

  depends_on = [
    module.azure_prdsvc_terraform_appserviceplan,
    module.azure-prdsvc-terraform-storageshare
  ]
}

#-------------------------------------------
# - Deploy Private Endpoint for Windows Web Apps
#-------------------------------------------
module "azure_prdsvc_terraform_windowswebapp_privateendpoint" {
  for_each = var.webapp_config

  #checkov:skip=CKV_TF_1:Skip module check for commit hash
  source                            = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-privateendpoint?ref=0.7.3"
  resource_group_name               = var.resource_group_name
  org_id                            = var.org_id
  app_id                            = var.app_id
  location                          = var.location
  environment                       = var.environment
  instance                          = each.value.private_endpoint_config.instance == null ? each.value.instance : each.value.private_endpoint_config.instance
  context                           = each.value.context
  group_ids                         = ["sites"]
  is_manual_connection              = each.value.private_endpoint_config.is_manual_connection
  private_connection_resource_id    = module.azure_prdsvc_terraform_windowswebapp[each.key].id
  subnet_id                         = var.privateendpoint_subnet_id
  static_ip_required                = each.value.private_endpoint_config.static_ip_required
  private_connection_resource_alias = each.value.private_endpoint_config.private_connection_resource_alias
  ip_configuration                  = each.value.private_endpoint_config.ip_configuration
  request_message                   = try(each.value.private_endpoint_config.request_message, null)

  depends_on = [
    module.azure_prdsvc_terraform_windowswebapp
  ]
}