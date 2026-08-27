

#------------------------------------------
# - Data Source: Resource Group
#------------------------------------------
data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

#------------------------------------------
# - Create Automation Account
#------------------------------------------
module "azure-prdsvc-terraform-automationaccount" {
  source              = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-automationaccount.git?ref=1.1.0"
  org_id              = var.org_id
  app_id              = var.app_id
  environment         = var.environment
  location            = var.location
  context             = var.context
  instance            = var.instance
  sku_name            = var.sku_name
  resource_group_name = data.azurerm_resource_group.this.name
  identity            = var.identity
  tags                = var.tags

  # Runbook configuration
  runbook_var = var.runbook_var

  # Optional: Automation variables (only if provided)
  int_var             = var.int_var
  int_var_iterator    = var.int_var_iterator
  bool_var            = var.bool_var
  bool_var_iterator   = var.bool_var_iterator
  string_var          = var.string_var
  string_var_iterator = var.string_var_iterator
  object_var          = var.object_var
  object_var_iterator = var.object_var_iterator
  datetime_var        = var.datetime_var

  # Optional: Webhooks (only if provided)
  webhook_var = var.webhook_var

  # Optional: Credentials (only if provided and policy allows)
  credential_var          = var.credential_var
  credential_var_iterator = var.credential_var_iterator

  # Optional: Hybrid workers (only if provided)
  hybrid_runbook_worker_group_var = var.hybrid_runbook_worker_group_var
  hybrid_runbook_worker_var       = var.hybrid_runbook_worker_var

  # Optional: Encryption (only if provided)
  encryption = var.encryption
}

