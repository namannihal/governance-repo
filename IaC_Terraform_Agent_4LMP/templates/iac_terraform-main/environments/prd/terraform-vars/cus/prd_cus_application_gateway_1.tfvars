org_id      = "a1a"
app_id      = "52161"
location    = "centralus"
environment = "prd"
context     = "estimates"
instance    = "01"
tags = {
  mnd-applicationid      = "app-52161"
  mnd-applicationname    = "estimates_azure_dbor_prd"
  mnd-costcentre         = "52161"
  mnd-dataclassification = "restricted"
  mnd-envsubtype         = "staging"
  mnd-envtype            = "prd"
  mnd-lifecycle          = "live"
  mnd-owner              = "TF-TF-IndiaEstimatesTech@lseg.com"
  mnd-projectcode        = "P011085"
  mnd-supportgroup       = "DEVELOP-ESTIMATES-COLLECT-ICA"
  cloud_provider         = "azure"
  opt-datadog            = "require"
}

#### Platform and Application Dependencies ####
resource_group_name       = "a1a-52161-prd-rg-prod-cus-01"
platform_rtbl_vnet_id     = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-platform-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-rtbl-cus-01"
shared_nrtbl_vnet_id      = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-nonrtbl-cus-01"
privateendpoint_subnet_id = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-platform-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-rtbl-cus-01/subnets/a1a-52161-prd-snet-workload-cus-06"
subscription_id           = "ff741a46-f3b9-47fb-a826-3c5acb77a45a"
agw_subnet_id             = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-platform-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-rtbl-cus-01/subnets/a1a-52161-prd-snet-appgw-cus-04"
keyvault_id               = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-prod-cus-01/providers/Microsoft.KeyVault/vaults/a1a52161prdkvinfcus01"
private_ip_address        = "10.150.67.5"

#--------------------------------------------------------
#                     Application Gateway
#--------------------------------------------------------
backend_address_pools = [
  {
    name         = "beap-qdctweb-prd"
    fqdns        = ["a1a-52161-prd-app-qdctweb-cus-01-linux.azurewebsites.net"]
    ip_addresses = null
  },
  {
    name         = "beap-hvpweb-prd"
    fqdns        = ["a1a-52161-prd-app-hvpui-cus-01-windows.azurewebsites.net"]
    ip_addresses = null
  },
  {
    name         = "beap-guidancebre-prd"
    fqdns        = ["a1a-52161-prd-app-guidbre-cus-01-windows.azurewebsites.net"]
    ip_addresses = null
  },
  {
    name         = "beap-estimatessdi-prd"
    fqdns        = ["a1a-52161-prd-app-estsdi-cus-01-windows.azurewebsites.net"]
    ip_addresses = null
  },
  {
    name         = "beap-estimatesbre-prd"
    fqdns        = ["a1a-52161-prd-app-estbre-cus-01-windows.azurewebsites.net"]
    ip_addresses = null
  },
  {
    name         = "beap-brokerxl-prd"
    fqdns        = ["a1a-52161-prd-app-brkrxlsrv-cus-01-linux.azurewebsites.net"]
    ip_addresses = null
  },
  {
    name         = "beap-broker-prd"
    fqdns        = ["a1a-52161-prd-app-brkrui-cus-01-linux.azurewebsites.net"]
    ip_addresses = null
  },
  {
    name         = "beap-guidance-prd"
    fqdns        = ["a1a-52161-prd-app-guidance-cus-01-linux.azurewebsites.net"]
    ip_addresses = null
  },
  {
    name         = "beap-collection-prd"
    fqdns        = ["a1a-52161-prd-app-collection-cus-01-linux.azurewebsites.net"]
    ip_addresses = null
  },
  {
    name         = "beap-actualsbre-prd"
    fqdns        = ["a1a-52161-prd-app-actualsbre-cus-01-windows.azurewebsites.net"]
    ip_addresses = null
  }
]

backend_http_settings = [
  {
    name                                = "https-backend-qdctweb-prd"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-qdctweb-prd"
    host_name                           = ""
    pick_host_name_from_backend_address = true
    connection_draining = {
      enabled           = true
      drain_timeout_sec = 60
    }
  },
  {
    name                                = "https-backend-hvpweb-prd"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-hvpweb-prd"
    host_name                           = ""
    pick_host_name_from_backend_address = true
    connection_draining = {
      enabled           = true
      drain_timeout_sec = 60
    }
  },
  {
    name                                = "https-backend-guidancebre-prd"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-guidancebre-prd"
    host_name                           = ""
    pick_host_name_from_backend_address = true
    connection_draining = {
      enabled           = true
      drain_timeout_sec = 60
    }
  },
  {
    name                                = "https-backend-estimatessdi-prd"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-estimatessdi-prd"
    host_name                           = ""
    pick_host_name_from_backend_address = true
    connection_draining = {
      enabled           = true
      drain_timeout_sec = 60
    }
  },
  {
    name                                = "https-backend-estimatesbre-prd"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-estimatesbre-prd"
    host_name                           = ""
    pick_host_name_from_backend_address = true
    connection_draining = {
      enabled           = true
      drain_timeout_sec = 60
    }
  },
  {
    name                                = "https-backend-brokerxl-prd"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-brokerxl-prd"
    host_name                           = ""
    pick_host_name_from_backend_address = true
    connection_draining = {
      enabled           = true
      drain_timeout_sec = 60
    }
  },
  {
    name                                = "https-backend-broker-prd"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-broker-prd"
    host_name                           = ""
    pick_host_name_from_backend_address = true
    connection_draining = {
      enabled           = true
      drain_timeout_sec = 60
    }
  },
  {
    name                                = "https-backend-guidance-prd"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-guidance-prd"
    host_name                           = ""
    pick_host_name_from_backend_address = true
    connection_draining = {
      enabled           = true
      drain_timeout_sec = 60
    }
  },
  {
    name                                = "https-backend-collection-prd"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-collection-prd"
    host_name                           = ""
    pick_host_name_from_backend_address = true
    connection_draining = {
      enabled           = true
      drain_timeout_sec = 60
    }
  },
  {
    name                                = "https-backend-actualsbre-prd"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-actualsbre-prd"
    host_name                           = ""
    pick_host_name_from_backend_address = true
    connection_draining = {
      enabled           = true
      drain_timeout_sec = 60
    }
  }
]

http_listeners = [
  # HTTPS listeners for qdct
  {
    name                           = "lsn-priv-https-qdctweb-prd"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "qdct-prd"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_names                     = null
    host_name                      = "qdct.estimates.dbors.internal"
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-qdctweb-prd"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_names                     = null
    host_name                      = "qdct.estimates.dbors.internal"
    firewall_policy_id             = null
  },
  # HTTPS listeners for hvpweb
  {
    name                           = "lsn-priv-https-hvpweb-prd"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "hvpweb-prd"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_name                      = "hvpweb.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-hvpweb-prd"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_name                      = "hvpweb.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  # HTTPS listeners for guidancebre
  {
    name                           = "lsn-priv-https-guidancebre-prd"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "guidancebre-prd"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_name                      = "guidancebre.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-guidancebre-prd"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_name                      = "guidancebre.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  # HTTPS listeners for estimatessdi
  {
    name                           = "lsn-priv-https-estimatessdi-prd"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "estimatessdi-prd"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_name                      = "estimatessdi.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-estimatessdi-prd"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_name                      = "estimatessdi.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  # HTTPS listeners for estimatesbre
  {
    name                           = "lsn-priv-https-estimatesbre-prd"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "estimatesbre-prd"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_name                      = "estimatesbre.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-estimatesbre-prd"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_name                      = "estimatesbre.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  # HTTPS listeners for brokerxl
  {
    name                           = "lsn-priv-https-brokerxl-prd"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "brokerxl-prd"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_name                      = "brokerxl.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-brokerxl-prd"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_name                      = "brokerxl.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  # HTTPS listeners for broker
  {
    name                           = "lsn-priv-https-broker-prd"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "broker-prd"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_name                      = "broker.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-broker-prd"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_name                      = "broker.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  # HTTPS listeners for guidance
  {
    name                           = "lsn-priv-https-guidance-prd"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "guidance-prd"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_name                      = "guidance.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-guidance-prd"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_name                      = "guidance.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  # HTTPS listeners for collection
  {
    name                           = "lsn-priv-https-collection-prd"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "collection-prd"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_name                      = "collection.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-collection-prd"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_name                      = "collection.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  # HTTPS listeners for actualsbre
  {
    name                           = "lsn-priv-https-actualsbre-prd"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "actualsbre-prd"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_name                      = "actualsbre.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-actualsbre-prd"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_name                      = "actualsbre.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  }
]

probes = [
  {
    name                                      = "https-health-probe-qdctweb-prd"
    path                                      = "/"
    protocol                                  = "Https"
    port                                      = 443
    host                                      = null
    interval                                  = 30
    timeout                                   = 30
    unhealthy_threshold                       = 3
    pick_host_name_from_backend_http_settings = true
    match = {
      body        = ""
      status_code = ["200", "201", "202", "203", "204", "205", "206", "207", "208", "226", "301", "302", "303", "304", "307", "308"]
    }
  },
  {
    name                                      = "https-health-probe-hvpweb-prd"
    path                                      = "/"
    protocol                                  = "Https"
    port                                      = 443
    host                                      = null
    interval                                  = 30
    timeout                                   = 30
    unhealthy_threshold                       = 3
    pick_host_name_from_backend_http_settings = true
    match = {
      body        = ""
      status_code = ["200", "201", "202", "203", "204", "205", "206", "207", "208", "226", "301", "302", "303", "304", "307", "308"]
    }
  },
  {
    name                                      = "https-health-probe-guidancebre-prd"
    path                                      = "/"
    protocol                                  = "Https"
    port                                      = 443
    host                                      = null
    interval                                  = 30
    timeout                                   = 30
    unhealthy_threshold                       = 3
    pick_host_name_from_backend_http_settings = true
    match = {
      body        = ""
      status_code = ["200", "201", "202", "203", "204", "205", "206", "207", "208", "226", "301", "302", "303", "304", "307", "308"]
    }
  },
  {
    name                                      = "https-health-probe-estimatessdi-prd"
    path                                      = "/"
    protocol                                  = "Https"
    port                                      = 443
    host                                      = null
    interval                                  = 30
    timeout                                   = 30
    unhealthy_threshold                       = 3
    pick_host_name_from_backend_http_settings = true
    match = {
      body        = ""
      status_code = ["200", "201", "202", "203", "204", "205", "206", "207", "208", "226", "301", "302", "303", "304", "307", "308"]
    }
  },
  {
    name                                      = "https-health-probe-estimatesbre-prd"
    path                                      = "/"
    protocol                                  = "Https"
    port                                      = 443
    host                                      = null
    interval                                  = 30
    timeout                                   = 30
    unhealthy_threshold                       = 3
    pick_host_name_from_backend_http_settings = true
    match = {
      body        = ""
      status_code = ["200", "201", "202", "203", "204", "205", "206", "207", "208", "226", "301", "302", "303", "304", "307", "308"]
    }
  },
  {
    name                                      = "https-health-probe-brokerxl-prd"
    path                                      = "/"
    protocol                                  = "Https"
    port                                      = 443
    host                                      = null
    interval                                  = 30
    timeout                                   = 30
    unhealthy_threshold                       = 3
    pick_host_name_from_backend_http_settings = true
    match = {
      body        = ""
      status_code = ["200", "201", "202", "203", "204", "205", "206", "207", "208", "226", "301", "302", "303", "304", "307", "308"]
    }
  },
  {
    name                                      = "https-health-probe-broker-prd"
    path                                      = "/"
    protocol                                  = "Https"
    port                                      = 443
    host                                      = null
    interval                                  = 30
    timeout                                   = 30
    unhealthy_threshold                       = 3
    pick_host_name_from_backend_http_settings = true
    match = {
      body        = ""
      status_code = ["200", "201", "202", "203", "204", "205", "206", "207", "208", "226", "301", "302", "303", "304", "307", "308"]
    }
  },
  {
    name                                      = "https-health-probe-guidance-prd"
    path                                      = "/"
    protocol                                  = "Https"
    port                                      = 443
    host                                      = null
    interval                                  = 30
    timeout                                   = 30
    unhealthy_threshold                       = 3
    pick_host_name_from_backend_http_settings = true
    match = {
      body        = ""
      status_code = ["200", "201", "202", "203", "204", "205", "206", "207", "208", "226", "301", "302", "303", "304", "307", "308"]
    }
  },
  {
    name                                      = "https-health-probe-collection-prd"
    path                                      = "/"
    protocol                                  = "Https"
    port                                      = 443
    host                                      = null
    interval                                  = 30
    timeout                                   = 30
    unhealthy_threshold                       = 3
    pick_host_name_from_backend_http_settings = true
    match = {
      body        = ""
      status_code = ["200", "201", "202", "203", "204", "205", "206", "207", "208", "226", "301", "302", "303", "304", "307", "308"]
    }
  },
  {
    name                                      = "https-health-probe-actualsbre-prd"
    path                                      = "/"
    protocol                                  = "Https"
    port                                      = 443
    host                                      = null
    interval                                  = 30
    timeout                                   = 30
    unhealthy_threshold                       = 3
    pick_host_name_from_backend_http_settings = true
    match = {
      body        = ""
      status_code = ["200", "201", "202", "203", "204", "205", "206", "207", "208", "226", "301", "302", "303", "304", "307", "308"]
    }
  }
]

request_routing_rules = [
  # HTTPS rules - qdct
  {
    name                        = "https-rule-priv-qdctweb-prd"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-qdctweb-prd"
    priority                    = 110
    backend_address_pool_name   = "beap-qdctweb-prd"
    backend_http_settings_name  = "https-backend-qdctweb-prd"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-qdctweb-prd"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-qdctweb-prd"
    priority                    = 130
    backend_address_pool_name   = "beap-qdctweb-prd"
    backend_http_settings_name  = "https-backend-qdctweb-prd"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  # HTTPS rules - hvpweb
  {
    name                        = "https-rule-priv-hvpweb-prd"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-hvpweb-prd"
    priority                    = 111
    backend_address_pool_name   = "beap-hvpweb-prd"
    backend_http_settings_name  = "https-backend-hvpweb-prd"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-hvpweb-prd"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-hvpweb-prd"
    priority                    = 131
    backend_address_pool_name   = "beap-hvpweb-prd"
    backend_http_settings_name  = "https-backend-hvpweb-prd"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  # HTTPS rules - guidancebre
  {
    name                        = "https-rule-priv-guidancebre-prd"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-guidancebre-prd"
    priority                    = 112
    backend_address_pool_name   = "beap-guidancebre-prd"
    backend_http_settings_name  = "https-backend-guidancebre-prd"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-guidancebre-prd"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-guidancebre-prd"
    priority                    = 132
    backend_address_pool_name   = "beap-guidancebre-prd"
    backend_http_settings_name  = "https-backend-guidancebre-prd"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  # HTTPS rules - estimatessdi
  {
    name                        = "https-rule-priv-estimatessdi-prd"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-estimatessdi-prd"
    priority                    = 113
    backend_address_pool_name   = "beap-estimatessdi-prd"
    backend_http_settings_name  = "https-backend-estimatessdi-prd"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-estimatessdi-prd"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-estimatessdi-prd"
    priority                    = 133
    backend_address_pool_name   = "beap-estimatessdi-prd"
    backend_http_settings_name  = "https-backend-estimatessdi-prd"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  # HTTPS rules - estimatesbre
  {
    name                        = "https-rule-priv-estimatesbre-prd"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-estimatesbre-prd"
    priority                    = 114
    backend_address_pool_name   = "beap-estimatesbre-prd"
    backend_http_settings_name  = "https-backend-estimatesbre-prd"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-estimatesbre-prd"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-estimatesbre-prd"
    priority                    = 134
    backend_address_pool_name   = "beap-estimatesbre-prd"
    backend_http_settings_name  = "https-backend-estimatesbre-prd"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  # HTTPS rules - brokerxl
  {
    name                        = "https-rule-priv-brokerxl-prd"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-brokerxl-prd"
    priority                    = 115
    backend_address_pool_name   = "beap-brokerxl-prd"
    backend_http_settings_name  = "https-backend-brokerxl-prd"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-brokerxl-prd"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-brokerxl-prd"
    priority                    = 135
    backend_address_pool_name   = "beap-brokerxl-prd"
    backend_http_settings_name  = "https-backend-brokerxl-prd"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  # HTTPS rules - broker
  {
    name                        = "https-rule-priv-broker-prd"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-broker-prd"
    priority                    = 116
    backend_address_pool_name   = "beap-broker-prd"
    backend_http_settings_name  = "https-backend-broker-prd"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-broker-prd"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-broker-prd"
    priority                    = 136
    backend_address_pool_name   = "beap-broker-prd"
    backend_http_settings_name  = "https-backend-broker-prd"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  # HTTPS rules - guidance
  {
    name                        = "https-rule-priv-guidance-prd"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-guidance-prd"
    priority                    = 117
    backend_address_pool_name   = "beap-guidance-prd"
    backend_http_settings_name  = "https-backend-guidance-prd"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-guidance-prd"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-guidance-prd"
    priority                    = 137
    backend_address_pool_name   = "beap-guidance-prd"
    backend_http_settings_name  = "https-backend-guidance-prd"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  # HTTPS rules - collection
  {
    name                        = "https-rule-priv-collection-prd"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-collection-prd"
    priority                    = 118
    backend_address_pool_name   = "beap-collection-prd"
    backend_http_settings_name  = "https-backend-collection-prd"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-collection-prd"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-collection-prd"
    priority                    = 138
    backend_address_pool_name   = "beap-collection-prd"
    backend_http_settings_name  = "https-backend-collection-prd"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  # HTTPS rules - actualsbre
  {
    name                        = "https-rule-priv-actualsbre-prd"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-actualsbre-prd"
    priority                    = 119
    backend_address_pool_name   = "beap-actualsbre-prd"
    backend_http_settings_name  = "https-backend-actualsbre-prd"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-actualsbre-prd"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-actualsbre-prd"
    priority                    = 139
    backend_address_pool_name   = "beap-actualsbre-prd"
    backend_http_settings_name  = "https-backend-actualsbre-prd"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  }
]
#---------------------------------------------------------
#             WAF Policy Settings and Custom Rules
#---------------------------------------------------------
waf_mode = "Prevention"

custom_rules = {
  allow_all_traffic = {
    name      = "AllowAllTraffic"
    enabled   = true
    priority  = 1
    rule_type = "MatchRule"
    action    = "Allow"
    match_conditions = {
      mc1 = {
        match_variables = {
          mv1 = {
            variable_name = "RemoteAddr"
          }
        }
        transforms         = []
        operator           = "IPMatch"
        negation_condition = false
        match_values = [
          "0.0.0.0/0"
        ]
      }
    }
  }
  allow_internal_ips = {
    name      = "AllowInternalIPs"
    enabled   = true
    priority  = 2
    rule_type = "MatchRule"
    action    = "Allow"
    match_conditions = {
      mc1 = {
        match_variables = {
          mv1 = {
            variable_name = "RemoteAddr"
          }
        }
        transforms         = []
        operator           = "IPMatch"
        negation_condition = false
        match_values = [
          "10.79.37.128/25",   # ZPA-LSEG-Pre-Prod-Seg1-EUS2
          "10.203.15.128/25",  # ZPA-LSEG-Pre-Prod-Seg1-EUS
          "10.18.147.128/25",  # ZPA-LSEG-Pre-Prod-Seg1-Southeast Asia
          "10.203.151.128/25", # ZPA-LSEG-Pre-Prod-Seg1-Uksouth
          "10.239.52.0/23",    # Estimates application routable subnet
          "100.72.0.0/17"      # Estimates application non-routable subnet
        ]
      }
    }
  }
  rate_limit_all_traffic = {
    name                 = "RateLimitAllTraffic"
    enabled              = true
    priority             = 20
    rule_type            = "RateLimitRule"
    action               = "Block"
    rate_limit_duration  = "OneMin"
    rate_limit_threshold = 2000
    group_rate_limit_by  = "ClientAddr"
    match_conditions = {
      mc1 = {
        match_variables = {
          mv1 = {
            variable_name = "RemoteAddr"
          }
        }
        transforms         = []
        operator           = "IPMatch"
        negation_condition = false
        match_values = [
          "0.0.0.0/0"
        ]
      }
    }
  }
}

#---------------------------------------------------------
#             Application Gateway Zones and Capacity
#---------------------------------------------------------
zones    = ["1", "2", "3"]
capacity = 2

#---------------------------------------------------------
#             SSL Certificates Configuration
#---------------------------------------------------------
use_keyvault_certificates = true

ssl_certificates = [
  {
    name                = "qdct-prd"
    key_vault_secret_id = "https://a1a52161prdkvinfcus01.vault.azure.net/secrets/qdct-prd"
    data                = null
    password            = null
  },
  {
    name                = "hvpweb-prd"
    key_vault_secret_id = "https://a1a52161prdkvinfcus01.vault.azure.net/secrets/hvpweb-prd"
    data                = null
    password            = null
  },
  {
    name                = "guidancebre-prd"
    key_vault_secret_id = "https://a1a52161prdkvinfcus01.vault.azure.net/secrets/guidancebre-prd"
    data                = null
    password            = null
  },
  {
    name                = "estimatessdi-prd"
    key_vault_secret_id = "https://a1a52161prdkvinfcus01.vault.azure.net/secrets/estimatessdi-prd"
    data                = null
    password            = null
  },
  {
    name                = "estimatesbre-prd"
    key_vault_secret_id = "https://a1a52161prdkvinfcus01.vault.azure.net/secrets/estimatesbre-prd"
    data                = null
    password            = null
  },
  {
    name                = "brokerxl-prd"
    key_vault_secret_id = "https://a1a52161prdkvinfcus01.vault.azure.net/secrets/brokerxl-prd"
    data                = null
    password            = null
  },
  {
    name                = "broker-prd"
    key_vault_secret_id = "https://a1a52161prdkvinfcus01.vault.azure.net/secrets/broker-prd"
    data                = null
    password            = null
  },
  {
    name                = "guidance-prd"
    key_vault_secret_id = "https://a1a52161prdkvinfcus01.vault.azure.net/secrets/guidance-prd"
    data                = null
    password            = null
  },
  {
    name                = "collection-prd"
    key_vault_secret_id = "https://a1a52161prdkvinfcus01.vault.azure.net/secrets/collection-prd"
    data                = null
    password            = null
  },
  {
    name                = "actualsbre-prd"
    key_vault_secret_id = "https://a1a52161prdkvinfcus01.vault.azure.net/secrets/actualsbre-prd"
    data                = null
    password            = null
  }
]
