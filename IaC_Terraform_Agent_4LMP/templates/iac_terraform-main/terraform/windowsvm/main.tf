#
# Copyright 2025 LSEG & Microsoft. All rights reserved.
#

########################################## Deploy Pattern - Dependencies ##########################################
#--------------------------------------------------
# - Deploy Windows VM Pattern
#--------------------------------------------------

data "azurerm_client_config" "this" {}

module "azure_prdsvcpat_terraform_windowsvirtualmachine" {
  source      = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvcpat/terraform/azure-prdsvcpat-terraform-windowsvirtualmachine.git?ref=1.1.0"
  for_each    = var.windows_vm
  org_id      = var.org_id
  app_id      = var.app_id
  location    = var.location
  environment = var.environment
  context     = each.value.context
  instance    = each.value.instance
  tags        = var.tags
  #### Platform and Application Dependencies ####

  # resource_group_name         = "${split("/",var.resource_group_id)[4]}"
  resource_group_id           = var.resource_group_id
  shared_nrtbl_vnet_id        = var.shared_nrtbl_vnet_id
  privateendpoint_subnet_id   = var.privateendpoint_subnet_id
  firewall_private_ip_address = var.firewall_private_ip_address

  #### Pattern specific variables - Additional Resources Switches ####
  key_vault_config                  = merge(each.value.key_vault_config, { key_vault_id = var.key_vault_id })
  network_config                    = each.value.network_config
  disk_encryption_set               = each.value.disk_encryption_set
  secure_boot_enabled               = each.value.secure_boot_enabled
  deploy_proximityplacementgroup    = each.value.deploy_proximityplacementgroup
  size                              = each.value.size
  admin_username                    = each.value.admin_username
  computer_name                     = each.value.computer_name
  source_image_id                   = var.source_image_id
  vm_agent_platform_updates_enabled = var.vm_agent_platform_updates_enabled
  os_disk = merge(each.value.os_disk, {
    network_access_policy = "DenyAll"
    public_network_access = "Disabled"
  })
  additional_disk   = try(each.value.additional_disk, {})
  zone              = try(each.value.zone, null)
  enable_entra_auth = var.enable_entra_auth
  identity_type     = "SystemAssigned, UserAssigned"
  timezone          = "Eastern Standard Time"
  key_vault_tags    = var.key_vault_tags
  azure_backup      = each.value.azure_backup
}

#-----------------------------------
# - RBAC for VM managed identities to App Key Vault - Secrets Officer
#-----------------------------------
module "azure_prdsvc_terraform_roleassignment_app_keyvault" {
  source   = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-roleassignment?ref=0.2.5"
  for_each = var.windows_vm

  principal_id         = module.azure_prdsvcpat_terraform_windowsvirtualmachine[each.key].userassignedidentity.principal_id
  role_definition_name = "Key Vault Secrets Officer"
  scope                = var.app_key_vault_id

  depends_on = [
    module.azure_prdsvcpat_terraform_windowsvirtualmachine
  ]
}

#-----------------------------------
# - RBAC for VM system-assigned identity to Key Vault - Secrets Officer
#-----------------------------------
module "azure_prdsvc_terraform_roleassignment_system_identity_keyvault" {
  source   = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-roleassignment?ref=0.2.5"
  for_each = var.windows_vm

  principal_id         = try(module.azure_prdsvcpat_terraform_windowsvirtualmachine[each.key].windowsvm.resource.identity[0].principal_id, null)
  role_definition_name = "Key Vault Secrets Officer"
  scope                = var.app_key_vault_id

  depends_on = [
    module.azure_prdsvcpat_terraform_windowsvirtualmachine
  ]
}

#-----------------------------------
# - RBAC for ENTRA group: VM User Login (module, loop on VMs, static group)
#-----------------------------------
module "azure_prdsvc_terraform_roleassignment_vm_user_login" {
  source               = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-roleassignment?ref=0.2.5"
  for_each             = var.windows_vm
  principal_id         = var.vm_user_login_group_id
  role_definition_name = "Virtual Machine User Login"
  scope                = module.azure_prdsvcpat_terraform_windowsvirtualmachine[each.key].windowsvm.id
  depends_on           = [module.azure_prdsvcpat_terraform_windowsvirtualmachine]
}

#-----------------------------------
# - RBAC for ENTRA group: VM Administrator Login (module, loop on VMs, static group)
#-----------------------------------
module "azure_prdsvc_terraform_roleassignment_vm_admin_login" {
  source               = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-roleassignment?ref=0.2.5"
  for_each             = var.windows_vm
  principal_id         = var.vm_admin_login_group_id
  role_definition_name = "Virtual Machine Administrator Login"
  scope                = module.azure_prdsvcpat_terraform_windowsvirtualmachine[each.key].windowsvm.id
  depends_on           = [module.azure_prdsvcpat_terraform_windowsvirtualmachine]
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
  context     = each.value.context
  #  context     = "st${each.value.context}"
  instance = each.value.instance

  resource_group_name                    = var.resource_group_name
  key_vault_id                           = var.key_vault_id
  persist_access_key                     = each.value.persist_access_key
  enable_key_access                      = each.value.enable_key_access
  account_tier                           = each.value.account_tier
  account_replication_type               = each.value.account_replication_type
  network_access_enabled                 = false
  kv_secret_expiration_date              = each.value.kv_secret_expiration_date
  enable_file_share_AADDS_authentication = each.value.enable_file_share_AADDS_authentication
  customer_managed_key = {
    key_vault_id          = var.key_vault_id
    identity_principal_id = module.azure_prdsvcpat_terraform_windowsvirtualmachine[try(each.value.primary_vm_identity_key[0], each.value.primary_vm_identity_key)].userassignedidentity.principal_id
    expiration_date       = each.value.kv_secret_expiration_date
  }
  identity = {
    type         = "UserAssigned"
    identity_ids = [module.azure_prdsvcpat_terraform_windowsvirtualmachine[try(each.value.primary_vm_identity_key[0], each.value.primary_vm_identity_key)].userassignedidentity.id]
  }
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
  context     = each.value.context
  #  context     = "st${each.value.context}"
  instance = each.value.instance

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
  for_each        = var.windows_vm
  create_duration = "120s"
  depends_on      = [module.azure-prdsvc-terraform-privateendpoint]
}

#---------------------------
#   Creating Storage Share
#---------------------------
module "azure-prdsvc-terraform-storageshare" {
  source = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-storageshare?ref=0.3.1"
  for_each = {
    for k, v in var.windows_vm : k => v
    if can(v.storage_account_key) && can(v.file_share_config)
  }
  org_id      = var.org_id
  app_id      = var.app_id
  location    = var.location
  environment = var.environment
  context     = each.value.context
  instance    = each.value.instance

  storage_account_name = module.azure-prdsvc-storageaccount[each.value.storage_account_key].name
  quota                = each.value.file_share_config.quota
  enabled_protocol     = each.value.file_share_config.enabled_protocol

  depends_on = [
    time_sleep.wait_120_seconds_storage,
    module.azure-prdsvc-storageaccount,
    module.azure-prdsvc-terraform-privateendpoint
  ]
}

#-----------------------------------------------------------
# - Mount Azure File Share on Windows VMs
#   Uses a Custom Script Extension on each VM where
#   mount_azure_files = true. The extension mounts the share
#   immediately and registers a scheduled task that remounts it
#   on every startup under SYSTEM.
#-----------------------------------------------------------
resource "azurerm_virtual_machine_extension" "mount_azure_files" {
  for_each = {
    for k, v in var.windows_vm : k => v
    if try(v.mount_azure_files, false) == true
  }

  name                       = "AzureFilesMount"
  virtual_machine_id         = module.azure_prdsvcpat_terraform_windowsvirtualmachine[each.key].windowsvm.id
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.10"
  auto_upgrade_minor_version = true
  tags                       = var.tags
  settings                   = jsonencode({})
  protected_settings = jsonencode({
    commandToExecute = "powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -EncodedCommand ${textencodebase64(<<-POWERSHELL
      $ErrorActionPreference = "Stop"
      $storageAccountName = "${module.azure-prdsvc-storageaccount[each.value.storage_account_key].name}"
      $storageAccountKey  = "${module.azure-prdsvc-storageaccount[each.value.storage_account_key].primary_access_key}"
      $shareName          = "${module.azure-prdsvc-terraform-storageshare[each.key].name}"
      $driveLetter        = "${try(each.value.mount_drive_letter, "Z")}"
      $uncPath            = "\\$storageAccountName.file.core.windows.net\$shareName"
      $commonAppDataPath  = [System.Environment]::GetFolderPath("CommonApplicationData")
      $scriptDir          = Join-Path $commonAppDataPath "AzureFilesMount"
      $scriptPath         = Join-Path $scriptDir "mount-azure-files.ps1"
      $logPath            = Join-Path $scriptDir "mount-azure-files.log"
      $taskName           = "MountAzureFiles-${each.value.context}-${each.value.instance}"

      New-Item -ItemType Directory -Path $scriptDir -Force | Out-Null

      @'
      $ErrorActionPreference = "Stop"
      $scriptDir = Split-Path -Path $MyInvocation.MyCommand.Path -Parent
      $logPath = Join-Path $scriptDir "mount-azure-files.log"
      $storageAccountName = "${module.azure-prdsvc-storageaccount[each.value.storage_account_key].name}"
      $storageAccountKey  = "${module.azure-prdsvc-storageaccount[each.value.storage_account_key].primary_access_key}"
      $shareName          = "${module.azure-prdsvc-terraform-storageshare[each.key].name}"
      $driveLetter        = "${try(each.value.mount_drive_letter, "Z")}"
      $uncPath            = "\\${module.azure-prdsvc-storageaccount[each.value.storage_account_key].name}.file.core.windows.net\${module.azure-prdsvc-terraform-storageshare[each.key].name}"

      Start-Transcript -Path $logPath -Append -Force | Out-Null

      $password = ConvertTo-SecureString $storageAccountKey -AsPlainText -Force
      $credential = New-Object System.Management.Automation.PSCredential ("localhost\$storageAccountName", $password)

      $existingGlobalMapping = Get-SmbGlobalMapping -LocalPath "$($driveLetter):" -ErrorAction SilentlyContinue
      if ($null -ne $existingGlobalMapping) {
        Remove-SmbGlobalMapping -LocalPath "$($driveLetter):" -Force -ErrorAction SilentlyContinue
      }

      if (Test-Path "$($driveLetter):") {
        cmd /c "net use $($driveLetter): /delete /yes" | Out-Null
      }

      New-SmbGlobalMapping -RemotePath $uncPath -LocalPath "$($driveLetter):" -Credential $credential -RequirePrivacy $true
      Stop-Transcript | Out-Null
      '@ | Set-Content -Path $scriptPath -Encoding UTF8 -Force

      $action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -NonInteractive -ExecutionPolicy Bypass -File `"$scriptPath`""
      $trigger = New-ScheduledTaskTrigger -AtStartup
      $principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount -RunLevel Highest
      $settings = New-ScheduledTaskSettingsSet -StartWhenAvailable
      Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Principal $principal -Settings $settings -Force | Out-Null

      Start-ScheduledTask -TaskName $taskName
      Start-Sleep -Seconds 15

      if (-not (Test-Path "$($driveLetter):")) {
        if (Test-Path $logPath) {
          Get-Content $logPath | Select-Object -Last 50 | ForEach-Object { Write-Output $_ }
        }
        throw "Azure Files mount did not create drive $($driveLetter):"
      }
    POWERSHELL
    , "UTF-16LE")}"
  })

  depends_on = [
    module.azure_prdsvcpat_terraform_windowsvirtualmachine,
    module.azure-prdsvc-terraform-storageshare,
    time_sleep.wait_120_seconds_storage
  ]
}