#
# Copyright 2024 LSEG & Microsoft. All rights reserved.
#

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.33.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "~>2.0.1"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.9.0"
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
  features {}
  subscription_id            = var.subscription_id
  storage_use_azuread        = false
  skip_provider_registration = true
}