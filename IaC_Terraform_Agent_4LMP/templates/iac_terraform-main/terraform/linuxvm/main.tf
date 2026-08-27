#
# Copyright 2025 LSEG & Microsoft. All rights reserved.
#

########################################## Deploy Pattern - Dependencies ##########################################
#--------------------------------------------------
# - Deploy Linux VM Pattern
#-------------------------------------------------

data "azurerm_client_config" "this" {}

locals {
  windows_to_linux_timezone_map = {
    "Eastern Standard Time" = "America/New_York"
  }

  linux_vm_bootstrap = {
    for key, config in var.linux_vm_config : key => config
    if try(config.timezone, null) != null || try(config.mount_azure_files, false) == true
  }
}

module "azure-prdsvcpat-terraform-linux-vm" {
  source               = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvcpat/terraform/azure-prdsvcpat-terraform-linuxvirtualmachine.git?ref=1.1.0"
  for_each             = var.linux_vm_config
  org_id               = var.org_id
  app_id               = var.app_id
  location             = var.location
  environment          = var.environment
  context              = each.value.context
  instance             = each.value.instance
  context_private_key  = each.value.context_private_key
  instance_private_key = each.value.instance_private_key
  context_public_key   = each.value.context_public_key
  instance_public_key  = each.value.instance_public_key
  tags                 = var.tags
  key_vault_tags       = var.key_vault_tags
  #### Platform and Application Dependencies ####

  resource_group_id           = var.resource_group_id
  shared_nrtbl_vnet_id        = var.shared_nrtbl_vnet_id
  firewall_private_ip_address = var.firewall_private_ip_address

  #### Pattern specific variables - Additional Resources Switches ####
  key_vault_config             = each.value.key_vault_config
  privateendpoint_subnet_id    = var.privateendpoint_subnet_id
  network_config               = each.value.network_config
  disk_encryption_set          = each.value.disk_encryption_set
  size                         = each.value.size
  admin_username               = each.value.admin_username
  username                     = each.value.username
  zone                         = each.value.zone
  license_type                 = each.value.license_type
  proximity_placement_group_id = each.value.proximity_placement_group_id
  source_image_id              = each.value.source_image_id
  network_interface            = each.value.network_interface
  os_disk                      = each.value.os_disk
  identity_type                = try(each.value.enable_systemassigned_identity, true) ? "SystemAssigned, UserAssigned" : "UserAssigned"
  secure_boot_enabled          = each.value.secure_boot_enabled
  termination_notification     = each.value.termination_notification
  priority                     = each.value.priority
  vtpm_enabled                 = each.value.vtpm_enabled
  user_data                    = each.value.user_data
  custom_data                  = try(each.value.custom_data, null)
  dedicated_host_id            = each.value.dedicated_host_id
  dedicated_host_group_id      = each.value.dedicated_host_group_id
  virtual_machine_extensions   = try(each.value.virtual_machine_extensions, {})
  managed_disk                 = try(each.value.managed_disk, {})
  azure_backup                 = each.value.azure_backup
  enable_entra_auth            = try(each.value.enable_entra_auth, true)
}

#-----------------------------------
# - RBAC for VM managed identities to App Key Vault - Secrets Officer
#-----------------------------------
module "azure_prdsvc_terraform_roleassignment_app_keyvault" {
  source   = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-roleassignment?ref=0.2.5"
  for_each = var.linux_vm_config

  principal_id         = module.azure-prdsvcpat-terraform-linux-vm[each.key].userassignedidentity_linuxvm.principal_id
  role_definition_name = "Key Vault Secrets Officer"
  scope                = var.app_key_vault_id

  depends_on = [
    module.azure-prdsvcpat-terraform-linux-vm
  ]
}

#-----------------------------------
# - RBAC for VM system-assigned identity to Key Vault - Secrets Officer
#-----------------------------------
module "azure_prdsvc_terraform_roleassignment_system_identity_keyvault" {
  source   = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-roleassignment?ref=0.2.5"
  for_each = var.linux_vm_config

  principal_id         = try(module.azure-prdsvcpat-terraform-linux-vm[each.key].linuxvm.resource.identity[0].principal_id, null)
  role_definition_name = "Key Vault Secrets Officer"
  scope                = var.app_key_vault_id

  depends_on = [
    module.azure-prdsvcpat-terraform-linux-vm
  ]
}

#-----------------------------------
# - RBAC for ENTRA group: VM User Login (module, loop on VMs, static group)
#-----------------------------------
module "azure_prdsvc_terraform_roleassignment_vm_user_login" {
  source               = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-roleassignment?ref=0.2.5"
  for_each             = var.linux_vm_config
  principal_id         = var.vm_user_login_group_id
  role_definition_name = "Virtual Machine User Login"
  scope                = module.azure-prdsvcpat-terraform-linux-vm[each.key].linuxvm.id
  depends_on           = [module.azure-prdsvcpat-terraform-linux-vm]
}

#-----------------------------------
# - RBAC for ENTRA group: VM Administrator Login (module, loop on VMs, static group)
#-----------------------------------
module "azure_prdsvc_terraform_roleassignment_vm_admin_login" {
  source               = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-roleassignment?ref=0.2.5"
  for_each             = var.linux_vm_config
  principal_id         = var.vm_admin_login_group_id
  role_definition_name = "Virtual Machine Administrator Login"
  scope                = module.azure-prdsvcpat-terraform-linux-vm[each.key].linuxvm.id
  depends_on           = [module.azure-prdsvcpat-terraform-linux-vm]
}

#-----------------------------#
#  - Creating Storage Account #
#-----------------------------#
module "azure-prdsvc-storageaccount" {
  source      = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-storageaccount.git?ref=1.1.0"
  for_each    = var.storage_account_config
  org_id      = var.org_id
  app_id      = var.app_id
  location    = var.location
  environment = var.environment
  context     = "st${each.value.context}"
  instance    = each.value.instance

  resource_group_name                    = var.resource_group_name
  key_vault_id                           = var.key_vault_id
  persist_access_key                     = each.value.persist_access_key
  enable_key_access                      = each.value.enable_key_access
  account_tier                           = each.value.account_tier
  account_replication_type               = each.value.account_replication_type
  kv_secret_expiration_date              = each.value.kv_secret_expiration_date
  enable_file_share_AADDS_authentication = try(each.value.enable_file_share_AADDS_authentication, false)
  customer_managed_key = {
    key_vault_id          = var.key_vault_id
    identity_principal_id = module.azure-prdsvcpat-terraform-linux-vm[each.value.primary_vm_identity_key].userassignedidentity_linuxvm.principal_id
    expiration_date       = each.value.kv_secret_expiration_date
  }
  identity = {
    type         = "UserAssigned"
    identity_ids = [module.azure-prdsvcpat-terraform-linux-vm[each.value.primary_vm_identity_key].userassignedidentity_linuxvm.id]
  }

  depends_on = [
    module.azure-prdsvcpat-terraform-linux-vm
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
  context     = "st${each.value.context}"
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
  for_each        = var.linux_vm_config
  create_duration = "120s"
  depends_on      = [module.azure-prdsvc-terraform-privateendpoint]
}

#---------------------------
#   Creating Storage Share
#---------------------------
module "azure-prdsvc-terraform-storageshare" {
  source      = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-storageshare?ref=0.3.1"
  for_each    = var.linux_vm_config
  org_id      = var.org_id
  app_id      = var.app_id
  location    = var.location
  environment = var.environment
  context     = each.value.context
  instance    = each.value.instance

  storage_account_name = module.azure-prdsvc-storageaccount[each.value.storage_account_key].name
  quota                = each.value.file_share_config.quota
  enabled_protocol     = try(each.value.file_share_config.enabled_protocol, "SMB")

  depends_on = [
    time_sleep.wait_120_seconds_storage,
    module.azure-prdsvc-storageaccount,
    module.azure-prdsvc-terraform-privateendpoint
  ]
}

#-----------------------------------------------------------
# - Linux bootstrap extension
#   Uses a single CustomScript handler per VM to avoid the
#   Azure Linux limitation on multiple extensions with the
#   same handler. This standalone resource is outside the VM
#   child module so it can depend on storage resources.
#-----------------------------------------------------------
resource "azurerm_virtual_machine_extension" "linux_bootstrap" {
  for_each = local.linux_vm_bootstrap

  name                       = "SetTimezone"
  virtual_machine_id         = module.azure-prdsvcpat-terraform-linux-vm[each.key].linuxvm.id
  publisher                  = "Microsoft.Azure.Extensions"
  type                       = "CustomScript"
  type_handler_version       = "2.1"
  auto_upgrade_minor_version = true
  tags                       = var.tags
  settings                   = jsonencode({})
  protected_settings = jsonencode({
    commandToExecute = replace(join("\n\n", compact([
      "set -euo pipefail",
      try(each.value.timezone, null) == null ? "" : "TIMEZONE=\"${lookup(local.windows_to_linux_timezone_map, each.value.timezone, each.value.timezone)}\"\ntimedatectl set-timezone \"$TIMEZONE\" || { ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime; echo $TIMEZONE > /etc/timezone; }\n",
      try(each.value.mount_azure_files, false) == false ? "" : <<-SCRIPT
      script_path=/usr/local/sbin/mount-azure-files-${each.value.context}-${each.value.instance}.sh
      cat > "$script_path" <<'MOUNTSCRIPT'
      #!/usr/bin/env bash
      set -euo pipefail

      storage_account_name="${module.azure-prdsvc-storageaccount[each.value.storage_account_key].name}"
      storage_account_key="${module.azure-prdsvc-storageaccount[each.value.storage_account_key].primary_access_key}"
      share_name="${module.azure-prdsvc-terraform-storageshare[each.key].name}"
      mount_point="${try(each.value.mount_point, "/app")}"
      mount_uid="${try(each.value.mount_uid, 1010)}"
      mount_gid="${try(each.value.mount_gid, 100)}"
      credentials_dir="/etc/smbcredentials"
      credentials_file="$credentials_dir/$storage_account_name-$share_name.cred"
      mount_source="//$storage_account_name.file.core.windows.net/$share_name"
      log_file="/var/log/azure-files-mount-${each.value.context}-${each.value.instance}.log"
      fstab_entry="$mount_source $mount_point cifs nofail,_netdev,x-systemd.automount,x-systemd.requires=network-online.target,vers=3.1.1,credentials=$credentials_file,serverino,nosharesock,actimeo=30,mfsymlinks,dir_mode=0755,file_mode=0755,uid=$mount_uid,gid=$mount_gid 0 0"

      exec > >(tee -a "$log_file") 2>&1

      if ! command -v dnf >/dev/null 2>&1; then
        echo "This mount automation expects RHEL 9 with dnf available." >&2
        exit 1
      fi

      dnf install -y cifs-utils

      mkdir -p "$credentials_dir" "$mount_point"

      write_credentials_file() {
        local smb_username="$1"

        printf 'username=%s\n' "$smb_username" > "$credentials_file"
        printf 'password=%s\n' "$storage_account_key" >> "$credentials_file"
        chmod 600 "$credentials_file"
      }

      if grep -qE "^[^#].*[[:space:]]$mount_point[[:space:]]+cifs[[:space:]]" /etc/fstab; then
        while IFS= read -r fstab_line; do
          set -- $fstab_line
          if [ "$${2:-}" != "$mount_point" ]; then
            printf '%s\n' "$fstab_line"
          fi
        done < /etc/fstab > /etc/fstab.azurefiles.tmp
        cat /etc/fstab.azurefiles.tmp > /etc/fstab
        rm -f /etc/fstab.azurefiles.tmp
      fi

      printf '%s\n' "$fstab_entry" >> /etc/fstab

      if mountpoint -q "$mount_point"; then
        umount "$mount_point" || true
      fi

      mount_succeeded=false
      for smb_username in "$storage_account_name" "localhost\\$storage_account_name"; do
        write_credentials_file "$smb_username"

        if mount "$mount_point"; then
          mount_succeeded=true
          break
        fi
      done

      if [ "$mount_succeeded" != "true" ]; then
        echo "Azure Files mount failed using both standard and localhost-prefixed SMB usernames." >&2
        exit 32
      fi

      mountpoint -q "$mount_point"
      MOUNTSCRIPT
      chmod 700 "$script_path"
      "$script_path"
      SCRIPT
    ])), "\r", "")
  })

  depends_on = [
    module.azure-prdsvcpat-terraform-linux-vm,
    module.azure-prdsvc-storageaccount,
    module.azure-prdsvc-terraform-privateendpoint,
    module.azure-prdsvc-terraform-storageshare,
    time_sleep.wait_120_seconds_storage
  ]
}

