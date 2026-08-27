#------------------------------------------
# - Create a Route Table for each Subnet
#------------------------------------------
module "routetable" {
  #checkov:skip=CKV_TF_1:Skip module check for commit hash
  source = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-routetable?ref=0.5.3"

  for_each    = var.subnets
  org_id      = var.org_id
  app_id      = var.app_id
  location    = var.location
  environment = var.environment
  context     = each.value.context
  instance    = var.instance

  resource_group_name           = var.resource_group_name
  disable_bgp_route_propagation = true

  # Merge all routes from routable_rules to apply to each subnet
  route      = merge([for k, v in var.routable_rules : v]...)
  subnet_ids = []
  tags       = var.tags
}

#------------------------------
# - Create a NSG 
#------------------------------
module "nsg" {
  #checkov:skip=CKV_TF_1:Skip module check for commit hash
  source = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-networksecuritygroup?ref=0.6.2"

  for_each = var.subnets

  org_id      = var.org_id
  app_id      = var.app_id
  location    = var.location
  environment = var.environment
  context     = each.value.context
  instance    = var.instance

  resource_group_name = var.resource_group_name
  security_rules      = each.value.security_rules
  tags                = var.tags
}

#---------------------
# - Create Subnets SEQUENTIALLY
#---------------------

# Wait for NSG and Route Table creation to complete
resource "time_sleep" "wait_for_nsg_rt" {
  create_duration = "60s"

  depends_on = [module.nsg, module.routetable]
}

# IMPORTANT: Azure Policy requires NSG/RT at subnet creation time
# We pass the associations to avoid policy violation, but use lifecycle
# ignore_changes to prevent Terraform conflicts during parallel updates

module "subnet" {
  #checkov:skip=CKV_TF_1:Skip module check for commit hash
  source = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-subnet?ref=0.8.0"

  for_each = var.subnets

  org_id      = var.org_id
  app_id      = var.app_id
  environment = var.environment
  context     = each.value.context
  instance    = var.instance
  location    = var.location

  virtual_network_id = var.virtual_network_id
  address_prefix     = each.value.address_prefix
  service_endpoints  = each.value.service_endpoints != null ? each.value.service_endpoints : []
  delegation         = each.value.delegation

  # Pass associations to satisfy Azure Policy during creation
  # The subnet module should handle these with proper lifecycle rules
  route_table_id            = module.routetable[each.key].id
  network_security_group_id = module.nsg[each.key].id

  depends_on = [
    module.nsg,
    module.routetable,
    time_sleep.wait_for_nsg_rt
  ]
}