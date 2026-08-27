#
# Copyright 2025 LSEG & Microsoft. All rights reserved.
#

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.33.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "~> 2.5.0"
    }
  }
  backend "azurerm" {
    use_azuread_auth = true
  }
}
provider "azuread" {
  # Authentication will use environment variables or Azure CLI context
}
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
    key_vault {
      purge_soft_delete_on_destroy          = true
      purge_soft_deleted_keys_on_destroy    = true
      purge_soft_deleted_secrets_on_destroy = true
      recover_soft_deleted_key_vaults       = true
      recover_soft_deleted_keys             = true
      recover_soft_deleted_secrets          = true
    }
  }
  subscription_id                 = var.subscription_id
  storage_use_azuread             = true
  resource_provider_registrations = "none"
}

provider "azapi" {
  subscription_id = var.subscription_id
}