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
  description = "The subnet module outputs."
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
  description = "The subnet module outputs."
  value       = { for key, value in module.azure_prdsvcpat_terraform_windowsvirtualmachine : key => value.diskencryptionset }
  sensitive   = true
}

output "proximityplacementgroup" {
  description = "The subnet module outputs."
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