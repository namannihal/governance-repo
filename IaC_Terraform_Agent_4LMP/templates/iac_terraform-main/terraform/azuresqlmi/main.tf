#
# Copyright 2025 LSEG & Microsoft. All rights reserved.
#

########################################## Deploy Pattern - MSSQL MI ##########################################
#--------------------------------------------------
# - Deploy Primary Instance of MSSQL MI
#--------------------------------------------------

module "azure_prdapppat_terraform_sql_mi" {
  for_each    = var.sql_mi
  source      = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvcpat/terraform/azure-prdsvcpat-terraform-mssqlmanagedinstance.git?ref=1.2.0"
  org_id      = var.org_id
  app_id      = var.app_id
  location    = var.location
  environment = var.environment
  context     = each.value.context
  instance    = each.value.instance
  tags        = var.tags

  #### Platform and Application Dependencies (shared) ####

  resource_group_name                    = var.resource_group_name
  resource_group_name_secondary_location = var.resource_group_name_secondary_location
  shared_nrtbl_vnet_id                   = var.shared_nrtbl_vnet_id
  platform_rtbl_vnet_id                  = var.platform_rtbl_vnet_id
  shared_nrtbl_vnet_id_failover          = var.shared_nrtbl_vnet_id_failover
  rt_vnet_pe_subnet_id                   = var.rt_vnet_pe_subnet_id
  rt_vnet_pe_subnet_id_failover          = var.rt_vnet_pe_subnet_id_failover
  secondary_location                     = var.secondary_location
  key_vault_config                       = var.key_vault_config # shared across all MIs

  #### MI-specific configuration ####
  failover_enabled              = each.value.failover_enabled
  storage_config                = each.value.storage_config
  containers                    = each.value.containers
  network_config                = each.value.network_config
  license_type                  = each.value.license_type
  sku_name                      = each.value.sku_name
  timezone_id                   = each.value.timezone_id
  storage_size_in_gb            = each.value.storage_size_in_gb
  vcores                        = each.value.vcores
  collation                     = try(each.value.collation, null)
  storage_account_type          = each.value.storage_account_type
  failover_storage_account_type = each.value.failover_storage_account_type
  # storage_GZRS_enabled                      = each.value.storage_GZRS_enabled
  expiration_date                           = each.value.expiration_date
  auto_rotation_enabled                     = each.value.auto_rotation_enabled
  enable_entra_id_authentication            = each.value.enable_entra_id_authentication
  azuread_authentication_only               = try(each.value.azuread_authentication_only, false)
  administrator_login                       = each.value.administrator_login
  admin_email                               = try(each.value.admin_email, null)
  admin_object_id                           = try(each.value.admin_object_id, null)
  security_alert                            = each.value.security_alert
  recurring_scans                           = each.value.recurring_scans
  read_write_endpoint_failover_policy       = each.value.read_write_endpoint_failover_policy
  deploy_sqlmi_pe                           = each.value.deploy_sqlmi_pe
  deploy_sqlmi_pe_failover                  = each.value.deploy_sqlmi_pe_failover
  mssqlmi_db_variables                      = each.value.mssqlmi_db_variables
  readonly_endpoint_failover_policy_enabled = each.value.readonly_endpoint_failover_policy_enabled
  zone_redundant_enabled                    = each.value.zone_redundant_enabled
  failover_zone_redundant_enabled           = each.value.failover_zone_redundant_enabled
  private_endpoint                          = each.value.private_endpoint
  firewall_private_ip_address_failover      = try(each.value.firewall_private_ip_address_failover, null)
  firewall_private_ip_address               = each.value.firewall_private_ip_address
  secondary_type                            = each.value.secondary_type
  vulnerability_assessment = try(each.value.vulnerability_assessment, {
    storage_account_access_key          = null
    enabled                             = try(each.value.enable_vulnerability_assessment, false)
    storage_account_access_key_failover = null
    enabled_failover                    = try(each.value.enable_vulnerability_assessment, false) && try(each.value.failover_enabled, false)
  })
  create_role_assignment = try(each.value.create_role_assignment, true)
}
