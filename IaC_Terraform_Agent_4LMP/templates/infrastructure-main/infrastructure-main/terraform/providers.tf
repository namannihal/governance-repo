#
# Copyright 2023 LSEG & Microsoft. All rights reserved.
#
terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.33"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 3.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "<= 1.15"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.9"
    }

  }
  backend "azurerm" {
    use_azuread_auth = true
  }
}

provider "azurerm" {
  storage_use_azuread             = true
  resource_provider_registrations = "none"
  features {}
}
 