output "keyvault" {
  description = "The keyvault module outputs."
  value       = { for key, value in module.azure_prdsvcpat_terraform_windowsvirtualmachine : key => value.keyvault }
  sensitive   = true
}

output "keyvault_pe" {
  description = "The keyvault-pe module outputs."
  value       = { for key, value in module.azure_prdsvcpat_terraform_windowsvirtualmachine : key => value.keyvault_pe }
  sensitive   = true
}

output "userassignedidentity" {
  description = "The userassignedidentity module outputs."
  value       = { for key, value in module.azure_prdsvcpat_terraform_windowsvirtualmachine : key => value.userassignedidentity }
  sensitive   = true
}

output "networksecuritygroup" {
  description = "The networksecuritygroup module outputs."
  value       = { for key, value in module.azure_prdsvcpat_terraform_windowsvirtualmachine : key => value.networksecuritygroup }
  sensitive   = true
}

output "routetable" {
  description = "The routetable module outputs."
  value       = { for key, value in module.azure_prdsvcpat_terraform_windowsvirtualmachine : key => value.routetable }
  sensitive   = true
}

output "subnet" {
  description = "The subnet module outputs."
  value       = { for key, value in module.azure_prdsvcpat_terraform_windowsvirtualmachine : key => value.subnet }
  sensitive   = true
}

output "diskencryptionset" {
  description = "The diskencryptionset module outputs."
  value       = { for key, value in module.azure_prdsvcpat_terraform_windowsvirtualmachine : key => value.diskencryptionset }
  sensitive   = true
}

output "proximityplacementgroup" {
  description = "The proximityplacementgroup module outputs."
  value       = { for key, value in module.azure_prdsvcpat_terraform_windowsvirtualmachine : key => value.proximityplacementgroup }
  sensitive   = true
}

output "windowsvm" {
  description = "The windows vm module outputs."
  value       = { for key, value in module.azure_prdsvcpat_terraform_windowsvirtualmachine : key => value.windowsvm }
  sensitive   = true
}

output "dataprotectionbackupvault" {
  description = "The dataprotectionbackupvault module outputs."
  value       = { for key, value in module.azure_prdsvcpat_terraform_windowsvirtualmachine : key => value.dataprotectionbackupvault }
  sensitive   = true
}

output "dataprotectionbackupinstance" {
  description = "The dataprotectionbackupinstance module outputs."
  value       = { for key, value in module.azure_prdsvcpat_terraform_windowsvirtualmachine : key => value.dataprotectionbackupinstance }
  sensitive   = true
}

output "recovery_services_vault_id" {
  description = "The IDs of the recovery services vaults."
  value       = { for key, value in module.azure_prdsvc_terraform_recoveryservicesvault : key => value.id }
}

output "recovery_services_vault_name" {
  description = "The names of the recovery services vaults."
  value       = { for key, value in module.azure_prdsvc_terraform_recoveryservicesvault : key => value.name }
}

output "recovery_services_vault_resource" {
  description = "The recovery services vault resource outputs."
  value       = { for key, value in module.azure_prdsvc_terraform_recoveryservicesvault : key => value.resource }
  sensitive   = true
}

output "site_recovery_replication_name" {
  description = "The Azure Site Recovery replicated VM resource names."
  value = {
    for key, value in var.site_recovery : key => value.replication_name
    if can(var.windows_vm[key])
  }
}

output "site_recovery_failover_automation" {
  description = "The ASR names and resource groups required by the failover-couchdb-automation pipeline."
  value = {
    for key, value in var.site_recovery : key => {
      recovery_services_vault_name                = module.azure_prdsvc_terraform_recoveryservicesvault[key].name
      recovery_services_vault_resource_group_name = value.resource_group_name_secondary
      primary_fabric_name                         = value.fabric_name
      secondary_fabric_name                       = value.fabric_secondary_name
      primary_protection_container_name           = value.protection_container_name
      secondary_protection_container_name         = value.protection_container_secondary_name
      replication_policy_name                     = value.replication_policy_name
      replication_name                            = value.replication_name
      promoted_region                             = var.location
      standby_region                              = value.secondary_location
      target_virtual_machine_name                 = try(value.target_virtual_machine_name, null)
      primary_cache_storage_account_id = coalesce(
        try(value.staging_storage_account_id, null),
        try(value.storage_account_config[value.staging_storage_account_key].id, null),
        try(module.azure-prdsvc-storageaccount-asr_cache["${key}/${value.staging_storage_account_key}"].id, null)
      )
      primary_cache_storage_account_name = try(split("/", coalesce(
        try(value.staging_storage_account_id, null),
        try(value.storage_account_config[value.staging_storage_account_key].id, null),
        try(module.azure-prdsvc-storageaccount-asr_cache["${key}/${value.staging_storage_account_key}"].id, null)
      ))[8], null)
    }
    if can(var.windows_vm[key])
  }
}

output "asr_cache_storage_account_name" {
  description = "The storage account names used for ASR cache, including reprotect cache accounts."
  value = {
    for storage in flatten([
      for vm_key, recovery_config in var.site_recovery : [
        for storage_key, storage_config in try(recovery_config.storage_account_config, {}) : {
          map_key = "${vm_key}/${storage_key}"
          storage_account_id = coalesce(
            try(storage_config.id, null),
            try(module.azure-prdsvc-storageaccount-asr_cache["${vm_key}/${storage_key}"].id, null)
          )
        }
      ]
    ]) : storage.map_key => split("/", storage.storage_account_id)[8] if storage.storage_account_id != null
  }
}

output "asr_cache_storage_account_id" {
  description = "The storage account IDs used for ASR cache, including reprotect cache accounts."
  value = {
    for storage in flatten([
      for vm_key, recovery_config in var.site_recovery : [
        for storage_key, storage_config in try(recovery_config.storage_account_config, {}) : {
          map_key = "${vm_key}/${storage_key}"
          storage_account_id = coalesce(
            try(storage_config.id, null),
            try(module.azure-prdsvc-storageaccount-asr_cache["${vm_key}/${storage_key}"].id, null)
          )
        }
      ]
    ]) : storage.map_key => storage.storage_account_id if storage.storage_account_id != null
  }
}