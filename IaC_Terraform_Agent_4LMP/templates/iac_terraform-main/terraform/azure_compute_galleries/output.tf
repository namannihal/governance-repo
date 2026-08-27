#
# Copyright 2025 LSEG & Microsoft. All rights reserved.
#

# Outputs for Azure Compute Gallery
output "gallery_id" {
  description = "The ID of the Azure Compute Gallery"
  value       = module.azure_prdsvc_terraform_azurecomputergallery.id
}

output "gallery_name" {
  description = "The name of the Azure Compute Gallery"
  value       = module.azure_prdsvc_terraform_azurecomputergallery.name
}

output "image_definitions" {
  description = "Map of all image definitions with their IDs and names"
  value = {
    for key, image in azurerm_shared_image.this : key => {
      id   = image.id
      name = image.name
    }
  }
}

output "image_ids" {
  description = "Map of image definition IDs"
  value       = { for key, image in azurerm_shared_image.this : key => image.id }
}

output "image_names" {
  description = "Map of image definition names"
  value       = { for key, image in azurerm_shared_image.this : key => image.name }
}
