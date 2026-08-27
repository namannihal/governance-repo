
terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.51"
    }
    azapi = {
      source  = "azure/azapi"
      version = ">= 2.0.0, < 2.8.0"
    }
  }
  backend "azurerm" {
    use_azuread_auth = true
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
  storage_use_azuread        = true
}
