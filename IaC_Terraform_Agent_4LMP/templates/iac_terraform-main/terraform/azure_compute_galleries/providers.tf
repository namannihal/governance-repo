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
      version = "2.5.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.11.0"
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
  storage_use_azuread        = true
  skip_provider_registration = true
}