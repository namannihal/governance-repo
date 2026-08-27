#
# Copyright 2024 LSEG & Microsoft. All rights reserved.
#

########################################## Windows Web App Outputs ##########################################

# Note: The module outputs may vary depending on the external module structure
# For now, we'll output just the module references
output "webapp_modules" {
  description = "References to all created web application modules"
  value = {
    for k, v in module.azure_prdsvc_terraform_windowswebapp : k => "Module created successfully"
  }
}

# Output the ASP configurations being used
output "asp_configs" {
  description = "The App Service Plan configurations for different webapp groups"
  value = {
    for asp_key, asp_config in var.appserviceplan_configs : asp_key => {
      context      = asp_config.context
      instance     = asp_config.instance
      sku_name     = asp_config.sku_name
      os_type      = asp_config.os_type
      worker_count = asp_config.worker_count
    }
  }
}

# Output webapp to ASP mapping
output "webapp_asp_mapping" {
  description = "Which ASP each webapp is assigned to"
  value = {
    for webapp_name, webapp_config in var.webapp_config : webapp_name => webapp_config.asp_key
  }
}