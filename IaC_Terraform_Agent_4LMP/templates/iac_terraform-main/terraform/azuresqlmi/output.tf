##########################################################
## Copyright 2025 LSEG & Microsoft. All rights reserved. #
##########################################################

#---------------------------------------------------------
# - Outputs for Multiple SQL Managed Instances
#---------------------------------------------------------

output "sql_mi_instances" {
  description = "Map of all SQL Managed Instance module outputs"
  value       = module.azure_prdapppat_terraform_sql_mi
  sensitive   = true
}

output "sql_mi_instance_keys" {
  description = "List of SQL Managed Instance keys"
  value       = keys(module.azure_prdapppat_terraform_sql_mi)
}

output "sql_mi_count" {
  description = "Number of SQL Managed Instances deployed"
  value       = length(module.azure_prdapppat_terraform_sql_mi)
}
