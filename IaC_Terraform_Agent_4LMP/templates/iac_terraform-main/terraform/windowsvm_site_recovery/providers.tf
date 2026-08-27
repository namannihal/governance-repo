terraform {
  required_version = ">= 1.7.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.33.0, < 4.71.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.11.1"
    }
    azapi = {
      source  = "azure/azapi"
      version = "~>2.5.0"
    }
  }

  backend "azurerm" {
    use_azuread_auth = true
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy          = true
      purge_soft_deleted_keys_on_destroy    = true
      purge_soft_deleted_secrets_on_destroy = true
      recover_soft_deleted_key_vaults       = true
      recover_soft_deleted_keys             = true
      recover_soft_deleted_secrets          = true
    }
  }

  storage_use_azuread             = true
  resource_provider_registrations = "none"
}
