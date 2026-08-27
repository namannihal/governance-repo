#
# Copyright 2025 LSEG & Microsoft. All rights reserved.
#

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.33"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.11.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 3.0"
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

provider "azuread" {
}
provider "azurerm" {
  features {}
  subscription_id                 = var.subscription_id
  storage_use_azuread             = true
  resource_provider_registrations = "none"
}