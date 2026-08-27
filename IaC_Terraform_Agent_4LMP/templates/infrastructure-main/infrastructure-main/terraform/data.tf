data "azurerm_resource_group" "ingestion_resource_group_name" {
  name = var.ingestion_resource_group_name
}

data "azurerm_key_vault" "akv" {
  name                = var.key_vault_name
  resource_group_name = var.adc_resource_group_name
}

#### Private endpoint subnet
data "azurerm_subnet" "workload_subnet" {
  name                 = var.workload_subnet_name
  virtual_network_name = var.platform_rt_vnet_name
  resource_group_name  = var.platform_resource_group_name
}

#### Shared Non-Routable VNet
data "azurerm_virtual_network" "shared_nrt_vnet" {
  name                = var.shared_nrt_vnet_name
  resource_group_name = var.shared_resource_group_name
}

#### Ingestion VM subnet
data "azurerm_subnet" "ingestion_subnet" {
  name                 = var.ingestion_subnet_name
  virtual_network_name = var.shared_nrt_vnet_name
  resource_group_name  = var.shared_resource_group_name
}

#### BAMS Credentials
data "azurerm_key_vault_secret" "bams_user" {
  name         = var.bams_user_secret_name
  key_vault_id = data.azurerm_key_vault.akv.id
}

data "azurerm_key_vault_secret" "bams_password" {
  name         = var.bams_password_secret_name
  key_vault_id = data.azurerm_key_vault.akv.id
}
