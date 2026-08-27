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

  resource_group_id           = var.resource_group_id
  shared_nrtbl_vnet_id        = var.shared_nrtbl_vnet_id
  privateendpoint_subnet_id   = var.privateendpoint_subnet_id
  firewall_private_ip_address = var.firewall_private_ip_address

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

module "azure_prdsvc_terraform_roleassignment_vm_user_login" {
  source               = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-roleassignment?ref=0.2.5"
  for_each             = var.windows_vm
  principal_id         = var.vm_user_login_group_id
  role_definition_name = "Virtual Machine User Login"
  scope                = module.azure_prdsvcpat_terraform_windowsvirtualmachine[each.key].windowsvm.id
  depends_on           = [module.azure_prdsvcpat_terraform_windowsvirtualmachine]
}

module "azure_prdsvc_terraform_roleassignment_vm_admin_login" {
  source               = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-roleassignment?ref=0.2.5"
  for_each             = var.windows_vm
  principal_id         = var.vm_admin_login_group_id
  role_definition_name = "Virtual Machine Administrator Login"
  scope                = module.azure_prdsvcpat_terraform_windowsvirtualmachine[each.key].windowsvm.id
  depends_on           = [module.azure_prdsvcpat_terraform_windowsvirtualmachine]
}

module "azure-prdsvc-storageaccount-vm_files" {
  source = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-storageaccount.git?ref=1.1.0"
  for_each = {
    for vm_key, vm_config in var.windows_vm : vm_key => vm_config.storage_account_config
    if can(vm_config.storage_account_config)
  }
  org_id      = var.org_id
  app_id      = var.app_id
  location    = coalesce(try(each.value.location, null), var.location)
  environment = var.environment
  context     = each.value.context
  instance    = each.value.instance

  resource_group_name                    = coalesce(try(each.value.resource_group_name, null), var.resource_group_name)
  key_vault_id                           = coalesce(try(each.value.key_vault_id, null), var.key_vault_id)
  persist_access_key                     = each.value.persist_access_key
  enable_key_access                      = each.value.enable_key_access
  account_tier                           = each.value.account_tier
  account_replication_type               = each.value.account_replication_type
  network_access_enabled                 = false
  kv_secret_expiration_date              = each.value.kv_secret_expiration_date
  enable_file_share_AADDS_authentication = each.value.enable_file_share_AADDS_authentication
  customer_managed_key = {
    key_vault_id          = coalesce(try(each.value.key_vault_id, null), var.key_vault_id)
    identity_principal_id = module.azure_prdsvcpat_terraform_windowsvirtualmachine[try(each.value.primary_vm_identity_key[0], each.value.primary_vm_identity_key, each.key)].userassignedidentity.principal_id
    expiration_date       = each.value.kv_secret_expiration_date
  }
  identity = {
    type         = "UserAssigned"
    identity_ids = [module.azure_prdsvcpat_terraform_windowsvirtualmachine[try(each.value.primary_vm_identity_key[0], each.value.primary_vm_identity_key, each.key)].userassignedidentity.id]
  }
}

module "azure-prdsvc-terraform-privateendpoint" {
  source = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-privateendpoint?ref=0.7.2"
  for_each = {
    for vm_key, vm_config in var.windows_vm : vm_key => vm_config.storage_account_config
    if can(vm_config.storage_account_config) && try(vm_config.storage_account_config.create_file_pe, true)
  }
  org_id      = var.org_id
  app_id      = var.app_id
  location    = coalesce(try(each.value.location, null), var.location)
  environment = var.environment
  context     = each.value.context
  instance    = each.value.instance

  resource_group_name               = coalesce(try(each.value.resource_group_name, null), var.resource_group_name)
  subnet_id                         = coalesce(try(each.value.private_endpoint_config.subnet_id, null), var.privateendpoint_subnet_id)
  group_ids                         = ["file"]
  is_manual_connection              = try(each.value.private_endpoint_config.is_manual_connection, false)
  private_connection_resource_id    = module.azure-prdsvc-storageaccount-vm_files[each.key].id
  private_connection_resource_alias = null
  static_ip_required                = try(each.value.private_endpoint_config.static_ip_required, false)
}

resource "time_sleep" "wait_120_seconds_storage" {
  for_each        = var.windows_vm
  create_duration = "120s"
  depends_on      = [module.azure-prdsvc-terraform-privateendpoint]
}

module "azure_prdsvc_terraform_resourcenames_vm_fileshare" {
  source = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames?ref=0.2.7"
  for_each = {
    for k, v in var.windows_vm : k => v
    if can(v.storage_account_config) && can(v.file_share_config)
  }
  org_id      = var.org_id
  app_id      = var.app_id
  location    = var.location
  environment = var.environment
  context     = each.value.context
  instance    = each.value.instance

}

resource "azapi_resource" "windows_vm_storage_share" {
  for_each = {
    for k, v in var.windows_vm : k => v
    if can(v.storage_account_config) && can(v.file_share_config)
  }

  type      = "Microsoft.Storage/storageAccounts/fileServices/shares@2024-01-01"
  name      = module.azure_prdsvc_terraform_resourcenames_vm_fileshare[each.key].names.azurerm_storage_share
  parent_id = "${module.azure-prdsvc-storageaccount-vm_files[each.key].id}/fileServices/default"

  body = {
    properties = {
      accessTier       = try(each.value.file_share_config.access_tier, "TransactionOptimized")
      enabledProtocols = each.value.file_share_config.enabled_protocol
      shareQuota       = each.value.file_share_config.quota
    }
  }

  response_export_values = ["*"]

  depends_on = [
    time_sleep.wait_120_seconds_storage,
    module.azure-prdsvc-storageaccount-vm_files,
    module.azure-prdsvc-terraform-privateendpoint
  ]
}

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

  lifecycle {
    ignore_changes = [tags, protected_settings]
  }

  protected_settings = jsonencode({
    commandToExecute = "powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -EncodedCommand ${textencodebase64(<<-POWERSHELL
      $ErrorActionPreference = "Stop"
      $storageAccountName = "${module.azure-prdsvc-storageaccount-vm_files[each.key].name}"
      $storageAccountKey  = "${module.azure-prdsvc-storageaccount-vm_files[each.key].primary_access_key}"
      $shareName          = "${module.azure_prdsvc_terraform_resourcenames_vm_fileshare[each.key].names.azurerm_storage_share}"
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
      $storageAccountName = "${module.azure-prdsvc-storageaccount-vm_files[each.key].name}"
      $storageAccountKey  = "${module.azure-prdsvc-storageaccount-vm_files[each.key].primary_access_key}"
      $shareName          = "${module.azure_prdsvc_terraform_resourcenames_vm_fileshare[each.key].names.azurerm_storage_share}"
      $driveLetter        = "${try(each.value.mount_drive_letter, "Z")}"
      $uncPath            = "\\${module.azure-prdsvc-storageaccount-vm_files[each.key].name}.file.core.windows.net\${module.azure_prdsvc_terraform_resourcenames_vm_fileshare[each.key].names.azurerm_storage_share}"

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

      $action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -NonInteractive -ExecutionPolicy Bypass -File `\"$scriptPath`\""
      $trigger = New-ScheduledTaskTrigger -AtStartup
      $principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount -RunLevel Highest
      $settings = New-ScheduledTaskSettingsSet -StartWhenAvailable
      Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Principal $principal -Settings $settings -Force | Out-Null

      & $scriptPath

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
    azapi_resource.windows_vm_storage_share,
    time_sleep.wait_120_seconds_storage
  ]
}

module "azure-prdsvc-storageaccount-asr_cache" {
  source = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-storageaccount.git?ref=1.1.0"
  for_each = {
    for storage in flatten([
      for vm_key, recovery_config in var.site_recovery : [
        for storage_key, storage_config in try(recovery_config.storage_account_config, {}) : merge(storage_config, {
          map_key         = "${vm_key}/${storage_key}"
          vm_key          = vm_key
          expiration_date = recovery_config.expiration_date
        })
      ]
    ]) : storage.map_key => storage
    if try(storage.id, null) == null
  }

  org_id      = var.org_id
  app_id      = var.app_id
  location    = coalesce(try(each.value.location, null), var.location)
  environment = var.environment
  context     = each.value.context
  instance    = each.value.instance

  resource_group_name                    = coalesce(try(each.value.resource_group_name, null), var.resource_group_name)
  key_vault_id                           = var.key_vault_id
  tags                                   = var.tags
  key_vault_tags                         = var.key_vault_tags
  account_tier                           = try(each.value.account_tier, "Standard")
  account_replication_type               = try(each.value.account_replication_type, "LRS")
  persist_access_key                     = try(each.value.persist_access_key, false)
  enable_key_access                      = try(each.value.enable_key_access, false)
  enable_file_share_AADDS_authentication = false
  network_access_enabled                 = false
  kv_secret_expiration_date              = each.value.expiration_date

  customer_managed_key = {
    key_vault_id = var.key_vault_id
    identity_principal_id = try(each.value.use_asr_uai_for_cmk, false) ? (
      module.azure_prdsvc_terraform_userassignedidentity_asr[each.value.vm_key].principal_id
    ) : module.azure_prdsvcpat_terraform_windowsvirtualmachine[each.value.vm_key].userassignedidentity.principal_id
    expiration_date = each.value.expiration_date
  }

  identity = {
    type = "UserAssigned"
    identity_ids = [
      try(each.value.use_asr_uai_for_cmk, false) ? (
        module.azure_prdsvc_terraform_userassignedidentity_asr[each.value.vm_key].id
      ) : module.azure_prdsvcpat_terraform_windowsvirtualmachine[each.value.vm_key].userassignedidentity.id
    ]
  }
}

data "azapi_resource" "asr_blob_service" {
  for_each = { for k, v in local.asr_storage_accounts : k => v if var.manage_asr_cache_soft_delete }

  type        = "Microsoft.Storage/storageAccounts/blobServices@2023-01-01"
  resource_id = "${each.value.resolved_id}/blobServices/default"

  response_export_values = ["properties.restorePolicy", "properties.deleteRetentionPolicy", "properties.containerDeleteRetentionPolicy", "properties.isVersioningEnabled", "properties.changeFeed"]

  depends_on = [module.azure-prdsvc-storageaccount-asr_cache]
}

resource "terraform_data" "asr_blob_service_live_state" {
  for_each = data.azapi_resource.asr_blob_service

  triggers_replace = [jsonencode({
    restore_policy_enabled     = try(each.value.output.properties.restorePolicy.enabled, false)
    delete_retention_enabled   = try(each.value.output.properties.deleteRetentionPolicy.enabled, false)
    container_delete_retention = try(each.value.output.properties.containerDeleteRetentionPolicy.enabled, false)
    versioning_enabled         = try(each.value.output.properties.isVersioningEnabled, false)
    change_feed_enabled        = try(each.value.output.properties.changeFeed.enabled, false)
  })]
}

resource "azapi_update_resource" "asr_blob_service_disable_restore_policy" {
  for_each = data.azapi_resource.asr_blob_service

  type        = each.value.type
  resource_id = each.value.resource_id

  body = {
    properties = {
      restorePolicy = {
        enabled = false
      }
    }
  }

  lifecycle {
    replace_triggered_by = [terraform_data.asr_blob_service_live_state[each.key]]
  }
}

resource "azapi_update_resource" "asr_blob_service_disable_soft_delete" {
  for_each = data.azapi_resource.asr_blob_service

  type        = each.value.type
  resource_id = each.value.resource_id

  body = {
    properties = {
      deleteRetentionPolicy = {
        enabled = false
      }
      containerDeleteRetentionPolicy = {
        enabled = false
      }
      isVersioningEnabled = false
      changeFeed = {
        enabled = false
      }
    }
  }

  depends_on = [azapi_update_resource.asr_blob_service_disable_restore_policy]

  lifecycle {
    replace_triggered_by = [
      terraform_data.asr_blob_service_live_state[each.key],
      azapi_update_resource.asr_blob_service_disable_restore_policy[each.key]
    ]
  }
}

resource "time_sleep" "wait_asr_soft_delete_propagation" {
  for_each = azapi_update_resource.asr_blob_service_disable_soft_delete

  create_duration = "60s"
  depends_on      = [azapi_update_resource.asr_blob_service_disable_soft_delete]

  lifecycle {
    replace_triggered_by = [azapi_update_resource.asr_blob_service_disable_soft_delete[each.key]]
  }
}

module "azure_prdsvc_terraform_asr_blob_privateendpoint" {
  source   = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-privateendpoint?ref=0.7.2"
  for_each = local.asr_storage_accounts

  org_id      = var.org_id
  app_id      = var.app_id
  location    = coalesce(try(each.value.location, null), var.location)
  environment = var.environment
  context     = "${substr(each.value.context, 0, 9)}b"
  instance    = each.value.instance

  resource_group_name               = coalesce(try(each.value.resource_group_name, null), var.resource_group_name)
  subnet_id                         = coalesce(try(each.value.private_endpoint_config.subnet_id, null), var.privateendpoint_subnet_id)
  group_ids                         = ["blob"]
  is_manual_connection              = try(each.value.private_endpoint_config.is_manual_connection, false)
  private_connection_resource_id    = each.value.resolved_id
  private_connection_resource_alias = null
  static_ip_required                = try(each.value.private_endpoint_config.static_ip_required, false)

  depends_on = [time_sleep.wait_asr_soft_delete_propagation]
}

data "azapi_resource" "site_recovery_source_vm" {
  for_each = local.asr_protected_vms

  type        = "Microsoft.Compute/virtualMachines@2023-09-01"
  resource_id = module.azure_prdsvcpat_terraform_windowsvirtualmachine[each.key].windowsvm.id

  response_export_values = ["properties.storageProfile"]

  retry = {
    error_message_regex  = ["(?i)not found", "(?i)resource.*not.*found", "(?i)404"]
    interval_seconds     = 10
    max_interval_seconds = 30
    multiplier           = 1.5
  }

  depends_on = [module.azure_prdsvcpat_terraform_windowsvirtualmachine]
}

module "azure_prdsvc_terraform_resourcenames_asr_data_disk" {
  source = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames?ref=1.2.1"
  for_each = {
    for item in flatten([
      for vm_key, vm_config in var.windows_vm : [
        for disk_key, disk_config in try(vm_config.additional_disk, {}) : {
          map_key  = "${vm_key}/${disk_key}"
          context  = disk_config.context
          instance = disk_config.instance
        }
      ]
      if contains(keys(var.site_recovery), vm_key)
    ]) : item.map_key => item
  }

  org_id      = var.org_id
  app_id      = var.app_id
  location    = var.location
  environment = var.environment
  context     = each.value.context
  instance    = each.value.instance
}

locals {
  asr_protected_vms = {
    for key, value in var.site_recovery : key => value
    if can(var.windows_vm[key])
  }

  asr_staging_storage_account_ids = {
    for key, value in var.site_recovery : key => coalesce(
      try(value.staging_storage_account_id, null),
      try(value.storage_account_config[value.staging_storage_account_key].id, null),
      try(module.azure-prdsvc-storageaccount-asr_cache["${key}/${value.staging_storage_account_key}"].id, null)
    )
    if can(var.windows_vm[key])
  }

  asr_recovery_rg_ids = {
    for key, value in var.site_recovery : key =>
    "/subscriptions/${data.azurerm_client_config.this.subscription_id}/resourceGroups/${value.resource_group_name_secondary}"
    if can(var.windows_vm[key])
  }

  asr_data_disk_ids = {
    for item in flatten([
      for vm_key, vm_config in var.windows_vm : [
        for disk_key, disk_config in try(vm_config.additional_disk, {}) : {
          map_key = "${vm_key}/${disk_key}"
          id      = "/subscriptions/${data.azurerm_client_config.this.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Compute/disks/${module.azure_prdsvc_terraform_resourcenames_asr_data_disk["${vm_key}/${disk_key}"].names.azurerm_managed_disk}"
        }
      ]
      if contains(keys(var.site_recovery), vm_key)
    ]) : item.map_key => item.id
  }

  asr_storage_accounts = {
    for storage in flatten([
      for vm_key, recovery_config in var.site_recovery : [
        for storage_key, storage_config in try(recovery_config.storage_account_config, {}) : merge(storage_config, {
          map_key = "${vm_key}/${storage_key}"
          resolved_id = coalesce(
            try(storage_config.id, null),
            try(module.azure-prdsvc-storageaccount-asr_cache["${vm_key}/${storage_key}"].id, null)
          )
        })
      ]
    ]) : storage.map_key => storage
  }

  asr_protected_storage_accounts = {
    for pair in flatten([
      for vm_key, recovery_config in local.asr_protected_vms : [
        for storage_key, storage_config in try(recovery_config.storage_account_config, {}) : {
          map_key = "${vm_key}/${storage_key}"
          storage_account_id = coalesce(
            try(storage_config.id, null),
            try(module.azure-prdsvc-storageaccount-asr_cache["${vm_key}/${storage_key}"].id, null)
          )
          vm_key = vm_key
        }
      ]
    ]) : pair.map_key => pair
  }
}

# ---------------------------------------------------------------------------
# Post-failover disk recovery: re-import data disks into Terraform state.
#
# After ASR failover + failback, Azure recreates the source managed disk in
# EUS2 with the same name and resource ID. However, the disk may have been
# removed from Terraform state (e.g. via a failed
# apply that left state inconsistent). Without an import, Terraform plans a
# fresh create and immediately errors with "resource already exists".
#
# HOW TO USE:
#   1. After a failover/failback cycle, set post_failover_import_disks = true
#      in the tfvars and run the pipeline (plan + apply).
#   2. Terraform will re-attach the existing Azure disk to the correct state
#      address without touching the disk or its data.
#   3. Reset post_failover_import_disks = false and commit before the next
#      normal run. Leaving it true with the disk already in state causes an
#      error ("Cannot import to an address managed by existing state").
# ---------------------------------------------------------------------------
import {
  for_each = var.post_failover_import_disks ? {
    for item in flatten([
      for vm_key, vm_config in var.windows_vm : [
        for disk_key, disk_config in try(vm_config.additional_disk, {}) : {
          map_key  = "${vm_key}/${disk_key}"
          vm_key   = vm_key
          disk_key = disk_key
        }
      ]
      if contains(keys(var.site_recovery), vm_key)
    ]) : item.map_key => item
  } : {}

  id = local.asr_data_disk_ids[each.key]
  to = module.azure_prdsvcpat_terraform_windowsvirtualmachine[each.value.vm_key].module.azure_prdsvc_terraform_manageddisk_additional_disk[each.value.disk_key].azurerm_managed_disk.this
}

module "azure_prdsvc_terraform_resourcenames_asr_rsv" {
  source   = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames?ref=1.2.1"
  for_each = local.asr_protected_vms

  org_id      = var.org_id
  app_id      = var.app_id
  location    = each.value.secondary_location
  environment = var.environment
  context     = coalesce(try(each.value.context, null), var.windows_vm[each.key].context)
  instance    = coalesce(try(each.value.instance, null), var.windows_vm[each.key].instance)
}

module "azure_prdsvc_terraform_userassignedidentity_asr" {
  source   = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-userassignedidentity?ref=0.4.2"
  for_each = local.asr_protected_vms

  org_id              = var.org_id
  app_id              = var.app_id
  location            = each.value.secondary_location
  environment         = var.environment
  context             = coalesce(try(each.value.asr_identity_context, null), "${substr(coalesce(try(each.value.context, null), var.windows_vm[each.key].context), 0, 9)}r")
  instance            = coalesce(try(each.value.asr_identity_instance, null), coalesce(try(each.value.instance, null), var.windows_vm[each.key].instance))
  resource_group_name = each.value.resource_group_name_secondary
  tags                = var.tags
}

module "azure_prdsvc_terraform_recoveryservicesvault" {
  source   = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-recoveryservicesvault.git?ref=1.0.0"
  for_each = local.asr_protected_vms

  org_id      = var.org_id
  app_id      = var.app_id
  location    = each.value.secondary_location
  environment = var.environment
  context     = coalesce(try(each.value.context, null), var.windows_vm[each.key].context)
  instance    = coalesce(try(each.value.instance, null), var.windows_vm[each.key].instance)

  resource_group_name           = each.value.resource_group_name_secondary
  resource_group_name_secondary = each.value.resource_group_name_secondary
  key_vault_tags                = var.key_vault_tags
  tags                          = var.tags

  create_rsv                            = true
  create_vm_backup_policy               = false
  create_file_backup_policy             = false
  create_site_recovery_replicated_vm    = false
  sku                                   = each.value.sku
  storage_mode_type                     = each.value.storage_mode_type
  cross_region_restore_enabled          = each.value.cross_region_restore_enabled
  cross_subscription_restore_state      = each.value.cross_subscription_restore_state
  immutability                          = each.value.immutability
  monitoring                            = try(each.value.monitoring, null)
  backup_frequency                      = ""
  backup_time                           = ""
  filesharebackup_frequency             = ""
  filesharebackup_time                  = ""
  instant_restore_resource_group_prefix = substr("${var.org_id}${var.app_id}${var.environment}", 0, 23)

  identity = {
    type         = "SystemAssigned, UserAssigned"
    identity_ids = [module.azure_prdsvc_terraform_userassignedidentity_asr[each.key].id]
  }

  customer_managed_key = {
    key_vault_id                      = var.key_vault_id
    infrastructure_encryption_enabled = true
    expiration_date                   = each.value.expiration_date
    identity_id                       = module.azure_prdsvc_terraform_userassignedidentity_asr[each.key].id
    identity_principal_id             = module.azure_prdsvc_terraform_userassignedidentity_asr[each.key].principal_id
    use_system_assigned_identity      = false
  }

  primary_location                                     = var.location
  secondary_location                                   = each.value.secondary_location
  fabric_name                                          = each.value.fabric_name
  fabric_secondary_name                                = each.value.fabric_secondary_name
  protection_container_name                            = each.value.protection_container_name
  protection_container_secondary_name                  = each.value.protection_container_secondary_name
  replication_policy_name                              = each.value.replication_policy_name
  container_mapping_name                               = each.value.container_mapping_name
  network_mapping_name                                 = each.value.network_mapping_name
  replication_name                                     = each.value.replication_name
  recovery_point_retention_in_minutes                  = each.value.recovery_point_retention_in_minutes
  application_consistent_snapshot_frequency_in_minutes = each.value.application_consistent_snapshot_frequency_in_minutes

  rsv_subnet_id = each.value.rsv_subnet_id
  source_vm_id  = module.azure_prdsvcpat_terraform_windowsvirtualmachine[each.key].windowsvm.id
  os_disk_id    = tostring(data.azapi_resource.site_recovery_source_vm[each.key].output.properties.storageProfile.osDisk.managedDisk.id)
  # data_disks intentionally empty: disk registration is handled by azapi_resource.asr_replicated_vm
  # (vmManagedDisks) which is the single source of truth. The RSV module does not create the
  # replication item (create_site_recovery_replicated_vm = false).
  data_disks                 = []
  staging_storage_account_id = local.asr_staging_storage_account_ids[each.key]
  storage_account_id         = local.asr_staging_storage_account_ids[each.key]
  primary_network_id         = each.value.primary_network_id
  target_network_id          = each.value.target_network_id
  target_disk_type           = each.value.target_disk_type
  target_replica_disk_type   = each.value.target_replica_disk_type
  target_encryption_set_id   = null

  depends_on = [
    module.azure_prdsvc_terraform_asr_blob_privateendpoint,
    time_sleep.wait_asr_soft_delete_propagation
  ]
}

module "azure_prdsvc_terraform_asr_rsv_privateendpoint" {
  source = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-privateendpoint?ref=0.7.2"
  for_each = {
    for key, value in local.asr_protected_vms : key => value
    if try(value.create_rsv_private_endpoint, true) && try(value.rsv_subnet_id, null) != null
  }

  org_id      = var.org_id
  app_id      = var.app_id
  location    = each.value.secondary_location
  environment = var.environment
  context     = "${substr(coalesce(try(each.value.context, null), var.windows_vm[each.key].context), 0, 8)}r"
  instance    = coalesce(try(each.value.instance, null), var.windows_vm[each.key].instance)

  resource_group_name               = each.value.resource_group_name_secondary
  subnet_id                         = each.value.rsv_subnet_id
  group_ids                         = ["AzureSiteRecovery"]
  is_manual_connection              = false
  private_connection_resource_id    = module.azure_prdsvc_terraform_recoveryservicesvault[each.key].id
  private_connection_resource_alias = null
  static_ip_required                = false
  tags                              = var.tags

  depends_on = [module.azure_prdsvc_terraform_recoveryservicesvault]
}

resource "time_sleep" "wait_asr_rsv_pe_propagation" {
  for_each = local.asr_protected_vms

  create_duration = "30s"
  depends_on      = [module.azure_prdsvc_terraform_asr_rsv_privateendpoint]
}

resource "azurerm_site_recovery_fabric" "asr_primary" {
  for_each            = local.asr_protected_vms
  name                = each.value.fabric_name
  resource_group_name = each.value.resource_group_name_secondary
  recovery_vault_name = module.azure_prdsvc_terraform_recoveryservicesvault[each.key].name
  location            = var.location
  depends_on = [
    module.azure_prdsvc_terraform_recoveryservicesvault,
    time_sleep.wait_asr_rsv_pe_propagation,
  ]
}

resource "azurerm_site_recovery_fabric" "asr_secondary" {
  for_each            = local.asr_protected_vms
  name                = each.value.fabric_secondary_name
  resource_group_name = each.value.resource_group_name_secondary
  recovery_vault_name = module.azure_prdsvc_terraform_recoveryservicesvault[each.key].name
  location            = each.value.secondary_location
  depends_on = [
    module.azure_prdsvc_terraform_recoveryservicesvault,
    time_sleep.wait_asr_rsv_pe_propagation,
  ]
}

resource "azurerm_site_recovery_protection_container" "asr_primary" {
  for_each             = local.asr_protected_vms
  name                 = each.value.protection_container_name
  resource_group_name  = each.value.resource_group_name_secondary
  recovery_vault_name  = module.azure_prdsvc_terraform_recoveryservicesvault[each.key].name
  recovery_fabric_name = azurerm_site_recovery_fabric.asr_primary[each.key].name
}

resource "azurerm_site_recovery_protection_container" "asr_secondary" {
  for_each             = local.asr_protected_vms
  name                 = each.value.protection_container_secondary_name
  resource_group_name  = each.value.resource_group_name_secondary
  recovery_vault_name  = module.azure_prdsvc_terraform_recoveryservicesvault[each.key].name
  recovery_fabric_name = azurerm_site_recovery_fabric.asr_secondary[each.key].name
}

resource "azurerm_site_recovery_replication_policy" "asr_policy" {
  for_each                                             = local.asr_protected_vms
  name                                                 = each.value.replication_policy_name
  resource_group_name                                  = each.value.resource_group_name_secondary
  recovery_vault_name                                  = module.azure_prdsvc_terraform_recoveryservicesvault[each.key].name
  recovery_point_retention_in_minutes                  = each.value.recovery_point_retention_in_minutes
  application_consistent_snapshot_frequency_in_minutes = each.value.application_consistent_snapshot_frequency_in_minutes
}

resource "azurerm_site_recovery_protection_container_mapping" "asr_container_mapping" {
  for_each                                  = local.asr_protected_vms
  name                                      = each.value.container_mapping_name
  resource_group_name                       = each.value.resource_group_name_secondary
  recovery_vault_name                       = module.azure_prdsvc_terraform_recoveryservicesvault[each.key].name
  recovery_fabric_name                      = azurerm_site_recovery_fabric.asr_primary[each.key].name
  recovery_source_protection_container_name = azurerm_site_recovery_protection_container.asr_primary[each.key].name
  recovery_target_protection_container_id   = azurerm_site_recovery_protection_container.asr_secondary[each.key].id
  recovery_replication_policy_id            = azurerm_site_recovery_replication_policy.asr_policy[each.key].id
}

resource "azurerm_site_recovery_network_mapping" "asr_network_mapping" {
  for_each                    = local.asr_protected_vms
  name                        = each.value.network_mapping_name
  resource_group_name         = each.value.resource_group_name_secondary
  recovery_vault_name         = module.azure_prdsvc_terraform_recoveryservicesvault[each.key].name
  source_recovery_fabric_name = azurerm_site_recovery_fabric.asr_primary[each.key].name
  target_recovery_fabric_name = azurerm_site_recovery_fabric.asr_secondary[each.key].name
  source_network_id           = each.value.primary_network_id
  target_network_id           = each.value.target_network_id
}

resource "azapi_resource" "asr_replicated_vm" {
  for_each = local.asr_protected_vms

  type = "Microsoft.RecoveryServices/vaults/replicationFabrics/replicationProtectionContainers/replicationProtectedItems@2022-10-01"
  name = each.value.replication_name
  parent_id = join("/", [
    module.azure_prdsvc_terraform_recoveryservicesvault[each.key].id,
    "replicationFabrics", each.value.fabric_name,
    "replicationProtectionContainers", each.value.protection_container_name
  ])

  body = {
    properties = {
      policyId = join("/", [
        module.azure_prdsvc_terraform_recoveryservicesvault[each.key].id,
        "replicationPolicies", each.value.replication_policy_name
      ])
      providerSpecificDetails = {
        instanceType   = "A2A"
        fabricObjectId = module.azure_prdsvcpat_terraform_windowsvirtualmachine[each.key].windowsvm.id
        recoveryContainerId = join("/", [
          module.azure_prdsvc_terraform_recoveryservicesvault[each.key].id,
          "replicationFabrics", each.value.fabric_secondary_name,
          "replicationProtectionContainers", each.value.protection_container_secondary_name
        ])
        recoveryResourceGroupId = local.asr_recovery_rg_ids[each.key]
        vmManagedDisks = concat(
          [{
            diskId                              = lower(tostring(data.azapi_resource.site_recovery_source_vm[each.key].output.properties.storageProfile.osDisk.managedDisk.id))
            primaryStagingAzureStorageAccountId = local.asr_staging_storage_account_ids[each.key]
            recoveryResourceGroupId             = local.asr_recovery_rg_ids[each.key]
            recoveryReplicaDiskAccountType      = each.value.target_replica_disk_type
            recoveryTargetDiskAccountType       = each.value.target_disk_type
            recoveryDiskEncryptionSetId         = each.value.target_encryption_set_id
          }],
          coalesce(try(each.value.use_existing_data_disk, true), true) ? [
            for disk_key, disk_config in try(var.windows_vm[each.key].additional_disk, {}) : {
              diskId                              = lower(local.asr_data_disk_ids["${each.key}/${disk_key}"])
              primaryStagingAzureStorageAccountId = local.asr_staging_storage_account_ids[each.key]
              recoveryResourceGroupId             = local.asr_recovery_rg_ids[each.key]
              recoveryReplicaDiskAccountType      = coalesce(try(disk_config.target_replica_disk_type, null), each.value.target_replica_disk_type)
              recoveryTargetDiskAccountType       = coalesce(try(disk_config.target_disk_type, null), each.value.target_disk_type)
              recoveryDiskEncryptionSetId         = each.value.target_encryption_set_id
            }
          ] : []
        )
      }
    }
  }

  response_export_values = []

  timeouts {
    create = "5h"
  }

  lifecycle {
    ignore_changes = [body]
  }

  depends_on = [
    module.azure_prdsvcpat_terraform_windowsvirtualmachine,
    data.azapi_resource.site_recovery_source_vm,
    azurerm_site_recovery_protection_container_mapping.asr_container_mapping,
    azurerm_site_recovery_network_mapping.asr_network_mapping,
    time_sleep.wait_asr_cache_rbac_propagation,
    module.azure_prdsvc_terraform_asr_blob_privateendpoint,
    time_sleep.wait_asr_soft_delete_propagation,
    time_sleep.wait_asr_rsv_pe_propagation
  ]
}

resource "time_sleep" "wait_asr_replication_protected" {
  for_each = {
    for key, value in local.asr_protected_vms : key => value
    if try(value.target_virtual_machine_name, null) != null ||
    try(value.target_network_id, null) != null ||
    try(value.target_encryption_set_id, null) != null
  }

  # ASR protection job runs asynchronously after PUT; wait before issuing PATCH
  create_duration = "10m"
  depends_on      = [azapi_resource.asr_replicated_vm]

  lifecycle {
    replace_triggered_by = [azapi_resource.asr_replicated_vm[each.key]]
  }
}

resource "azapi_resource_action" "asr_set_target_vm_name" {
  for_each = {
    for key, value in local.asr_protected_vms : key => value
    if try(value.target_virtual_machine_name, null) != null ||
    try(value.target_network_id, null) != null ||
    try(value.target_encryption_set_id, null) != null
  }

  type = "Microsoft.RecoveryServices/vaults/replicationFabrics/replicationProtectionContainers/replicationProtectedItems@2022-10-01"
  resource_id = join("/", [
    module.azure_prdsvc_terraform_recoveryservicesvault[each.key].id,
    "replicationFabrics", each.value.fabric_name,
    "replicationProtectionContainers", each.value.protection_container_name,
    "replicationProtectedItems", each.value.replication_name
  ])
  method                 = "PATCH"
  when                   = "apply"
  response_export_values = []

  retry = {
    # ErrorInVMConfigurationAsProtectionFailed is transient: ASR protection job is still running
    error_message_regex  = ["(?i)UnhandledException", "(?i)not.*ready", "(?i)in.*progress", "(?i)ErrorInVMConfigurationAsProtectionFailed"]
    interval_seconds     = 60
    max_interval_seconds = 300
    multiplier           = 1.5
  }

  timeouts {
    create = "30m"
    update = "30m"
  }

  body = {
    properties = merge(
      {
        providerSpecificDetails = merge(
          { instanceType = "A2A" },
          try(each.value.target_encryption_set_id, null) != null ? {
            vmManagedDisks = concat(
              [{
                diskId                      = lower(tostring(data.azapi_resource.site_recovery_source_vm[each.key].output.properties.storageProfile.osDisk.managedDisk.id))
                recoveryDiskEncryptionSetId = each.value.target_encryption_set_id
              }],
              coalesce(try(each.value.use_existing_data_disk, true), true) ? [
                for disk_key, disk_config in try(var.windows_vm[each.key].additional_disk, {}) : {
                  diskId                      = lower(local.asr_data_disk_ids["${each.key}/${disk_key}"])
                  recoveryDiskEncryptionSetId = each.value.target_encryption_set_id
                }
              ] : []
            )
          } : {}
        )
      },
      try(each.value.target_virtual_machine_name, null) != null ? {
        recoveryAzureVMName = each.value.target_virtual_machine_name
      } : {},
      try(each.value.target_network_id, null) != null ? {
        selectedRecoveryAzureNetworkId = each.value.target_network_id
      } : {}
    )
  }

  depends_on = [time_sleep.wait_asr_replication_protected]
}

resource "azurerm_role_assignment" "asr_secondary_cache_contributor" {
  for_each = local.asr_protected_storage_accounts

  scope                = each.value.storage_account_id
  role_definition_name = "Storage Account Contributor"
  principal_id         = module.azure_prdsvc_terraform_recoveryservicesvault[each.value.vm_key].resource[0].identity[0].principal_id

  depends_on = [module.azure_prdsvc_terraform_recoveryservicesvault]
}

resource "azurerm_role_assignment" "asr_secondary_cache_blob_data_contributor" {
  for_each = local.asr_protected_storage_accounts

  scope                = each.value.storage_account_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = module.azure_prdsvc_terraform_recoveryservicesvault[each.value.vm_key].resource[0].identity[0].principal_id

  depends_on = [module.azure_prdsvc_terraform_recoveryservicesvault]
}

resource "azurerm_role_assignment" "asr_rsv_uai_target_kv_crypto" {
  for_each = {
    for key, value in local.asr_protected_vms : key => value
    if try(value.key_vault_id_secondary, null) != null
  }

  scope                = each.value.key_vault_id_secondary
  role_definition_name = "Key Vault Crypto Service Encryption User"
  principal_id         = module.azure_prdsvc_terraform_userassignedidentity_asr[each.key].principal_id

  depends_on = [module.azure_prdsvc_terraform_userassignedidentity_asr]
}

resource "azurerm_role_assignment" "asr_rsv_system_id_target_kv_crypto" {
  for_each = {
    for key, value in local.asr_protected_vms : key => value
    if try(value.key_vault_id_secondary, null) != null
  }

  scope                = each.value.key_vault_id_secondary
  role_definition_name = "Key Vault Crypto Service Encryption User"
  principal_id         = module.azure_prdsvc_terraform_recoveryservicesvault[each.key].resource[0].identity[0].principal_id

  depends_on = [module.azure_prdsvc_terraform_recoveryservicesvault]
}

resource "azurerm_role_assignment" "asr_rsv_system_id_source_kv_crypto" {
  for_each = { for key, value in local.asr_protected_vms : key => value if try(value.key_vault_id_secondary, null) != null }

  scope                = var.key_vault_id
  role_definition_name = "Key Vault Crypto Service Encryption User"
  principal_id         = module.azure_prdsvc_terraform_recoveryservicesvault[each.key].resource[0].identity[0].principal_id

  depends_on = [module.azure_prdsvc_terraform_recoveryservicesvault]
}

resource "azurerm_role_assignment" "vm_msi_secondary_kv_crypto" {
  for_each = { for key, value in local.asr_protected_vms : key => value if try(value.key_vault_id_secondary, null) != null }

  scope                = each.value.key_vault_id_secondary
  role_definition_name = "Key Vault Crypto Service Encryption User"
  principal_id         = module.azure_prdsvcpat_terraform_windowsvirtualmachine[each.key].userassignedidentity.principal_id

  depends_on = [module.azure_prdsvcpat_terraform_windowsvirtualmachine]
}

resource "azurerm_role_assignment" "vm_msi_secondary_app_kv_secrets" {
  for_each = { for key, value in local.asr_protected_vms : key => value if try(value.app_key_vault_id_secondary, null) != null }

  scope                = each.value.app_key_vault_id_secondary
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = module.azure_prdsvcpat_terraform_windowsvirtualmachine[each.key].userassignedidentity.principal_id

  depends_on = [module.azure_prdsvcpat_terraform_windowsvirtualmachine]
}

resource "azurerm_role_assignment" "vm_system_id_secondary_app_kv_secrets" {
  for_each = { for key, value in local.asr_protected_vms : key => value if try(value.app_key_vault_id_secondary, null) != null }

  scope                = each.value.app_key_vault_id_secondary
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = try(module.azure_prdsvcpat_terraform_windowsvirtualmachine[each.key].windowsvm.resource.identity[0].principal_id, null)

  depends_on = [module.azure_prdsvcpat_terraform_windowsvirtualmachine]
}

resource "time_sleep" "wait_asr_cache_rbac_propagation" {
  for_each = local.asr_protected_vms

  create_duration = "90s"
  depends_on = [
    azurerm_role_assignment.asr_secondary_cache_contributor,
    azurerm_role_assignment.asr_secondary_cache_blob_data_contributor,
    azurerm_role_assignment.asr_rsv_uai_target_kv_crypto,
    azurerm_role_assignment.asr_rsv_system_id_target_kv_crypto,
    azurerm_role_assignment.asr_rsv_system_id_source_kv_crypto,
    azurerm_role_assignment.vm_msi_secondary_kv_crypto,
    azurerm_role_assignment.vm_msi_secondary_app_kv_secrets,
    azurerm_role_assignment.vm_system_id_secondary_app_kv_secrets,
  ]

  lifecycle {
    replace_triggered_by = [
      azurerm_role_assignment.asr_secondary_cache_contributor,
      azurerm_role_assignment.asr_secondary_cache_blob_data_contributor,
      azurerm_role_assignment.asr_rsv_uai_target_kv_crypto,
      azurerm_role_assignment.asr_rsv_system_id_target_kv_crypto,
      azurerm_role_assignment.asr_rsv_system_id_source_kv_crypto,
      azurerm_role_assignment.vm_msi_secondary_kv_crypto,
    ]
  }
}