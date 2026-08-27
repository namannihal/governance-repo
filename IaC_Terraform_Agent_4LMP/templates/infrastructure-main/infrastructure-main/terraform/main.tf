locals {
  timestamp = formatdate("YYYYMMDDHHmmss", timestamp())
}
# #--------------------------------------------------
# # - Deploy Linux VM Pattern
# #-------------------------------------------------
module "azure-prdsvcpat-terraform-linux-vm" {
  source               = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvcpat/terraform/azure-prdsvcpat-terraform-linuxvirtualmachine?ref=1.2.0"
  for_each             = var.linux_vm_config
  org_id               = var.org_id
  app_id               = var.app_id
  location             = var.location
  environment          = var.environment
  context              = each.value.context
  instance             = each.value.instance
  context_private_key  = "${each.value.context}pvk"
  instance_private_key = each.value.instance
  context_public_key   = "${each.value.context}pbk"
  instance_public_key  = each.value.instance
  tags                 = var.tags
  enable_entra_auth    = false

  #### Platform and Application Dependencies ####
  resource_group_id    = data.azurerm_resource_group.ingestion_resource_group_name.id
  shared_nrtbl_vnet_id = data.azurerm_virtual_network.shared_nrt_vnet.id

  #### Pattern specific variables - Additional Resources Switches ####
  key_vault_config = {
    deploy_kv_and_pe = false
    key_vault_id     = data.azurerm_key_vault.akv.id
  }
  privateendpoint_subnet_id = data.azurerm_subnet.workload_subnet.id
  network_config = {
    use_existing_subnet = true
    subnet_id           = each.value.routable == true ? data.azurerm_subnet.workload_subnet.id : data.azurerm_subnet.ingestion_subnet.id
  }
  disk_encryption_set            = each.value.disk_encryption_set
  size                           = each.value.size
  admin_username                 = var.admin_username
  computer_name                  = each.value.computer_name
  zone                           = each.value.zone
  username                       = var.username
  source_image_id                = var.golden_image_id
  network_interface              = var.network_interface
  os_disk                        = each.value.os_disk
  termination_notification       = var.termination_notification
  managed_disk                   = each.value.managed_disk
  azure_backup                   = var.azure_backup
  identity_type                  = var.identity_type
  des_identity_type              = var.des_identity_type
  deploy_proximityplacementgroup = var.deploy_proximity_placement_group
  capacity_reservation_groups    = var.capacity_reservation_groups
}

module "azure-prdsvc-terraform-rbac-kv-crypto-user" {
  for_each     = var.linux_vm_config
  source       = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-roleassignment?ref=0.2.5"
  principal_id = module.azure-prdsvcpat-terraform-linux-vm[each.key].linuxvm.resource.identity[0].principal_id
  # "Key Vault Crypto User" role required to to read key for disk encryption set
  role_definition_name = "Key Vault Crypto User"
  scope                = data.azurerm_key_vault.akv.id
}

module "azure-prdsvc-terraform-rbac-kv-secrets-officer" {
  for_each     = var.linux_vm_config
  source       = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-roleassignment?ref=0.2.5"
  principal_id = module.azure-prdsvcpat-terraform-linux-vm[each.key].linuxvm.resource.identity[0].principal_id
  # "Key Vault Secrets Officer" role required to upload SSH keypair into keyvault (autossh_prereq.sh)
  role_definition_name = "Key Vault Secrets Officer"
  scope                = data.azurerm_key_vault.akv.id
}

resource "azurerm_virtual_machine_extension" "vm_boot_script_extension_vm" {
  for_each             = var.linux_vm_config
  name                 = "CustomScriptLinux-${local.timestamp}"
  virtual_machine_id   = module.azure-prdsvcpat-terraform-linux-vm[each.key].linuxvm.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"
  protected_settings = jsonencode({
    script = base64encode(templatefile("./scripts/octopi_automation.sh", {
      username                      = data.azurerm_key_vault_secret.bams_user.value
      password                      = data.azurerm_key_vault_secret.bams_password.value
      extension_environment         = var.extension_environment
      script_env                    = var.script_env
      computer_name                 = each.value.computer_name
      key_vault_name                = var.key_vault_name
      super_private_dns_environment = var.super_private_dns_environment
    }))
  })
  depends_on = [module.azure-prdsvc-terraform-rbac-kv-crypto-user, module.azure-prdsvc-terraform-rbac-kv-secrets-officer]
  timeouts {
    create = "5h30m"
  }
}
