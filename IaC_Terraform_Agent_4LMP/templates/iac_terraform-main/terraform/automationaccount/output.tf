#------------------------------------------
# - Automation Account Output values
#------------------------------------------
output "automation_account_name" {
  description = "The name of the Automation Account."
  value       = module.azure-prdsvc-terraform-automationaccount.name
}

output "automation_account_id" {
  description = "The ID of the Automation Account."
  value       = module.azure-prdsvc-terraform-automationaccount.id
}

output "resource_group_name" {
  description = "The name of the Resource Group."
  value       = data.azurerm_resource_group.this.name
}

output "runbook_names" {
  description = "The names of the created runbooks."
  value       = try(module.azure-prdsvc-terraform-automationaccount.runbook_name, null)
}

output "runbook_ids" {
  description = "The IDs of the created runbooks."
  value       = try(module.azure-prdsvc-terraform-automationaccount.runbook_id, null)
}

