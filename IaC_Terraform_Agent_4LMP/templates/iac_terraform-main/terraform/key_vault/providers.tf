#
# Copyright 2025 LSEG & Microsoft. All rights reserved.
#

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.51"
    }

    # Directly provided version for "azapi" due issue in version "0.7.2" of "azure-prdsvc-terraform-subnet"
    azapi = {
      source  = "azure/azapi"
      version = "1.15.0"
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

