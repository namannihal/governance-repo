
#---------------------------------------------------
# - Creating Public IP using Public IP Module
#---------------------------------------------------
module "azure-prdsvc-terraform-publicip" {
  #checkov:skip=CKV_TF_1:Skip module check for commit hash
  source                  = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-publicip?ref=0.3.2"
  org_id                  = var.org_id
  app_id                  = var.app_id
  location                = var.location
  environment             = var.environment
  context                 = var.context
  instance                = "04"
  resource_group_name     = var.resource_group_name
  allocation_method       = "Static"
  sku                     = "Standard"
  zones                   = var.zones
  public_ip_prefix_id     = null
  ddos_protection_plan_id = null
}

#--------------------------------------------
# - Creating User assign Identity using module
# -------------------------------------------
module "azure-prdsvc-terraform-userassignedidentity" {
  count = var.use_keyvault_certificates ? 1 : 0
  #checkov:skip=CKV_TF_1:Skip module check for commit hash
  source              = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-userassignedidentity?ref=0.4.2"
  org_id              = var.org_id
  app_id              = var.app_id
  location            = var.location
  environment         = var.environment
  context             = var.context
  instance            = var.instance
  resource_group_name = var.resource_group_name
}

#----------------------------------
# - RBAC for user assign identity to retrieve secrets
#----------------------------------
module "azure-prdsvc-terraform-rbac-secrets" {
  count = var.use_keyvault_certificates ? 1 : 0
  #checkov:skip=CKV_TF_1:Skip module check for commit hash
  source               = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-roleassignment?ref=0.2.5"
  principal_id         = module.azure-prdsvc-terraform-userassignedidentity[0].principal_id
  role_definition_name = "Key Vault Secrets User"
  scope                = var.keyvault_id
}

#----------------------------------
# - RBAC for user assign identity to retrieve certificates
#----------------------------------
module "azure-prdsvc-terraform-rbac-certificates" {
  count = var.use_keyvault_certificates ? 1 : 0
  #checkov:skip=CKV_TF_1:Skip module check for commit hash
  source               = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-roleassignment?ref=0.2.5"
  principal_id         = module.azure-prdsvc-terraform-userassignedidentity[0].principal_id
  role_definition_name = "Key Vault Certificate User"
  scope                = var.keyvault_id
}

#----------------------------------
# - RBAC for user assign identity to read KeyVault metadata
#----------------------------------
module "azure-prdsvc-terraform-rbac-reader" {
  count = var.use_keyvault_certificates ? 1 : 0
  #checkov:skip=CKV_TF_1:Skip module check for commit hash
  source               = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-roleassignment?ref=0.2.5"
  principal_id         = module.azure-prdsvc-terraform-userassignedidentity[0].principal_id
  role_definition_name = "Key Vault Reader"
  scope                = var.keyvault_id
  depends_on           = [module.azure-prdsvc-terraform-rbac-secrets, module.azure-prdsvc-terraform-rbac-certificates]
}

#-----------------------------------
# - Sleep after Role Assignment for Azure RBAC Propagation
#-----------------------------------
resource "time_sleep" "wait_for_rbac_propagation" {
  count = var.use_keyvault_certificates ? 1 : 0

  create_duration = "120s"

  depends_on = [
    module.azure-prdsvc-terraform-rbac-reader,
    module.azure-prdsvc-terraform-rbac-secrets,
    module.azure-prdsvc-terraform-rbac-certificates
  ]
}

resource "azurerm_key_vault_secret" "application_gateway_secrets" {
  for_each = local.key_vault_secret_names

  name         = local.key_vault_secrets_to_upload[each.key].name
  value        = local.key_vault_secrets_to_upload[each.key].value
  key_vault_id = var.keyvault_id
  content_type = local.key_vault_secrets_to_upload[each.key].content_type
}

#--------------------------------------------------------------
# - Extract CA certificate from CouchDB PFX
#   Runs only when couchdb_cert is provided (non-empty).
#   Uses scripts/extract-ca-cert.sh (bash + openssl on the runner).
#   Output: ca_cert_base64 — base64-encoded PEM containing the CA cert.
#--------------------------------------------------------------
data "external" "couchdb_ca_cert" {
  count = nonsensitive(trimspace(var.couchdb_cert)) != "" ? 1 : 0

  program = ["bash", "${path.module}/scripts/extract-ca-cert.sh"]

  query = {
    pfx_base64   = var.couchdb_cert
    pfx_password = var.cert_password
  }
}

#--------------------------------------------
# - Creating Webapplication firewall policy
#--------------------------------------------
module "azure-prdsvc-terraform-webapplicationfirewallpolicy" {
  #checkov:skip=CKV_TF_1:Skip module check for commit hash
  source              = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-webapplicationfirewallpolicy?ref=1.1.0"
  org_id              = var.org_id
  app_id              = var.app_id
  location            = var.location
  environment         = var.environment
  context             = var.context
  instance            = var.instance
  resource_group_name = var.resource_group_name
  tags                = var.tags

  policy_settings = {
    enabled                     = true
    mode                        = var.waf_mode
    request_body_check          = true
    file_upload_limit_in_mb     = 100
    max_request_body_size_in_kb = 128
    log_scrubbing_rule          = {}
  }

  # Using module defaults: Microsoft_DefaultRuleSet 2.1 + Bot Manager 1.1
  manage_rule_set             = {}
  bot_manager_ruleset_version = "1.0"

  custom_rules = var.custom_rules
}

#--------------------------------------------------------------
# - Creates Application gateway module
#--------------------------------------------------------------
module "azure-prdsvc-terraform-applicationgateway" {
  #checkov:skip=CKV_TF_1:Skip module check for commit hash
  source              = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-applicationgateway.git?ref=1.0.1"
  org_id              = var.org_id
  app_id              = var.app_id
  environment         = var.environment
  location            = var.location
  context             = var.context
  instance            = var.instance
  sku_name            = "WAF_v2"
  sku_tier            = "WAF_v2"
  resource_group_name = var.resource_group_name
  tags                = var.tags
  firewall_policy_id  = module.azure-prdsvc-terraform-webapplicationfirewallpolicy.id
  zones               = var.zones
  capacity            = var.capacity

  global = {
    request_buffering_enabled  = false
    response_buffering_enabled = false
  }

  autoscale_configuration = {
    min_capacity = 2
    max_capacity = 10
  }

  identity_ids = var.use_keyvault_certificates ? [module.azure-prdsvc-terraform-userassignedidentity[0].id] : null

  gateway_ip_configurations = [{
    name      = "appgateway-gwipc-${var.instance}"
    subnet_id = var.agw_subnet_id
  }]

  frontend_ip_configurations = {
    "public" = {
      name                          = "appgateway-feip-pub"
      public_ip_address_id          = module.azure-prdsvc-terraform-publicip.id
      private_ip_address            = null
      private_ip_address_allocation = null
      subnet_id                     = null
    },
    "private" = {
      name                          = "appgateway-feip-priv"
      subnet_id                     = var.agw_subnet_id
      private_ip_address            = var.private_ip_address
      private_ip_address_allocation = "Static"
      private_ip_address_version    = "IPv4"
      public_ip_address_id          = null

    }
  }

  frontend_ports = [
    {
      name = "appgateway-feporthttps"
      port = 443
    },
    {
      name = "appgateway-feporthttp"
      port = 80
    }
  ]

  backend_address_pools     = var.backend_address_pools
  backend_http_settings     = var.backend_http_settings
  http_listeners            = var.http_listeners
  probes                    = var.probes
  request_routing_rules     = var.request_routing_rules
  trusted_root_certificates = local.trusted_root_certificates_final

  ssl_certificates = local.ssl_certificates_final

  depends_on = [
    azurerm_key_vault_secret.application_gateway_secrets,
    time_sleep.wait_for_rbac_propagation,
    module.azure-prdsvc-terraform-rbac-reader,
    module.azure-prdsvc-terraform-rbac-secrets,
    module.azure-prdsvc-terraform-rbac-certificates
  ]
}

output "application_gateway_id" {
  description = "The ID of the Application Gateway"
  value       = module.azure-prdsvc-terraform-applicationgateway.id
}

output "application_gateway_name" {
  description = "The name of the Application Gateway"
  value       = module.azure-prdsvc-terraform-applicationgateway.name
}

output "waf_policy_id" {
  description = "The ID of the WAF Policy"
  value       = module.azure-prdsvc-terraform-webapplicationfirewallpolicy.id
}

output "public_ip_address" {
  description = "The public IP address of the Application Gateway"
  value       = module.azure-prdsvc-terraform-publicip.ip_address
}
