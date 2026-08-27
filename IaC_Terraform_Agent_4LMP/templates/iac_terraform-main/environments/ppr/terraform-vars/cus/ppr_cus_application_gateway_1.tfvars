org_id      = "a1a"
app_id      = "52161"
location    = "centralus"
environment = "ppr"
context     = "estimates"
instance    = "01"
tags = {
  mnd-applicationid      = "app-52161"
  mnd-applicationname    = "estimates_azure_dbor_ppr"
  mnd-costcentre         = "52161"
  mnd-dataclassification = "restricted"
  mnd-envsubtype         = "staging"
  mnd-envtype            = "ppr"
  mnd-lifecycle          = "live"
  mnd-owner              = "TF-TF-IndiaEstimatesTech@lseg.com"
  mnd-projectcode        = "P011085"
  mnd-supportgroup       = "DEVELOP-ESTIMATES-COLLECT-ICA"
  cloud_provider         = "azure"
  opt-datadog            = "require"
}

#### Platform and Application Dependencies ####
resource_group_name       = "a1a-52161-ppr-rg-estimates-cus-01"
platform_rtbl_vnet_id     = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-platform-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-rtbl-cus-01"
shared_nrtbl_vnet_id      = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01"
privateendpoint_subnet_id = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-platform-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-rtbl-cus-01/subnets/a1a-52161-ppr-snet-workload-cus-06"
subscription_id           = "7b8a8ffb-9be5-4786-8ba6-dd328b9d6857"
agw_subnet_id             = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-platform-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-rtbl-cus-01/subnets/a1a-52161-ppr-snet-appgw-cus-04"
keyvault_id               = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-cus-01/providers/Microsoft.KeyVault/vaults/a1a52161pprkvinfcus01"
private_ip_address        = "10.203.117.5"

#--------------------------------------------------------
#                     Application Gateway
#--------------------------------------------------------
backend_address_pools = [
  {
    name         = "beap-qdctweb-ppr"
    fqdns        = ["a1a-52161-ppr-app-qdctweb-cus-01-linux.azurewebsites.net"]
    ip_addresses = null
  },
  {
    name         = "beap-hvpweb-ppr"
    fqdns        = ["a1a-52161-ppr-app-hvpweb-cus-01-linux.azurewebsites.net"]
    ip_addresses = null
  },
  {
    name         = "beap-guidancebre-ppr"
    fqdns        = ["a1a-52161-ppr-app-guidancebre-cus-01-linux.azurewebsites.net"]
    ip_addresses = null
  },
  {
    name         = "beap-estimatessdi-ppr"
    fqdns        = ["a1a-52161-ppr-app-estimatessdi-cus-01-linux.azurewebsites.net"]
    ip_addresses = null
  },
  {
    name         = "beap-estimatesbre-ppr"
    fqdns        = ["a1a-52161-ppr-app-estimatesbre-cus-01-linux.azurewebsites.net"]
    ip_addresses = null
  },
  {
    name         = "beap-brokerxl-ppr"
    fqdns        = ["a1a-52161-ppr-app-brokerxl-cus-01-linux.azurewebsites.net"]
    ip_addresses = null
  },
  {
    name         = "beap-broker-ppr"
    fqdns        = ["a1a-52161-ppr-app-broker-cus-01-linux.azurewebsites.net"]
    ip_addresses = null
  },
  {
    name         = "beap-guidance-ppr"
    fqdns        = ["a1a-52161-ppr-app-guidance-cus-01-linux.azurewebsites.net"]
    ip_addresses = null
  },
  {
    name         = "beap-collection-ppr"
    fqdns        = ["a1a-52161-ppr-app-collection-cus-01-linux.azurewebsites.net"]
    ip_addresses = null
  },
  {
    name         = "beap-actualsbre-ppr"
    fqdns        = ["a1a-52161-ppr-app-actualsbre-cus-01-linux.azurewebsites.net"]
    ip_addresses = null
  }
]

backend_http_settings = [
  {
    name                                = "https-backend-qdctweb-ppr"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-qdctweb-ppr"
    host_name                           = ""
    pick_host_name_from_backend_address = true
    connection_draining = {
      enabled           = true
      drain_timeout_sec = 60
    }
  },
  {
    name                                = "https-backend-hvpweb-ppr"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-hvpweb-ppr"
    host_name                           = ""
    pick_host_name_from_backend_address = true
    connection_draining = {
      enabled           = true
      drain_timeout_sec = 60
    }
  },
  {
    name                                = "https-backend-guidancebre-ppr"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-guidancebre-ppr"
    host_name                           = ""
    pick_host_name_from_backend_address = true
    connection_draining = {
      enabled           = true
      drain_timeout_sec = 60
    }
  },
  {
    name                                = "https-backend-estimatessdi-ppr"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-estimatessdi-ppr"
    host_name                           = ""
    pick_host_name_from_backend_address = true
    connection_draining = {
      enabled           = true
      drain_timeout_sec = 60
    }
  },
  {
    name                                = "https-backend-estimatesbre-ppr"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-estimatesbre-ppr"
    host_name                           = ""
    pick_host_name_from_backend_address = true
    connection_draining = {
      enabled           = true
      drain_timeout_sec = 60
    }
  },
  {
    name                                = "https-backend-brokerxl-ppr"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-brokerxl-ppr"
    host_name                           = ""
    pick_host_name_from_backend_address = true
    connection_draining = {
      enabled           = true
      drain_timeout_sec = 60
    }
  },
  {
    name                                = "https-backend-broker-ppr"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-broker-ppr"
    host_name                           = ""
    pick_host_name_from_backend_address = true
    connection_draining = {
      enabled           = true
      drain_timeout_sec = 60
    }
  },
  {
    name                                = "https-backend-guidance-ppr"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-guidance-ppr"
    host_name                           = ""
    pick_host_name_from_backend_address = true
    connection_draining = {
      enabled           = true
      drain_timeout_sec = 60
    }
  },
  {
    name                                = "https-backend-collection-ppr"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-collection-ppr"
    host_name                           = ""
    pick_host_name_from_backend_address = true
    connection_draining = {
      enabled           = true
      drain_timeout_sec = 60
    }
  },
  {
    name                                = "https-backend-actualsbre-ppr"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-actualsbre-ppr"
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
    name                           = "lsn-priv-https-qdctweb-ppr"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "qdct-dr-ppr"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_name                      = "qdct-dr-ppr.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-qdctweb-ppr"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_names                     = null
    host_name                      = "qdct-dr-ppr.estimates.dbors.internal"
  },
  # HTTPS listeners for hvpweb
  {
    name                           = "lsn-priv-https-hvpweb-ppr"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "hvpweb-dr-ppr"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_name                      = "hvpweb-dr-ppr.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-hvpweb-ppr"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_name                      = "hvpweb-dr-ppr.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  # HTTPS listeners for guidancebre
  {
    name                           = "lsn-priv-https-guidancebre-ppr"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "guidancebre-dr-ppr"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_name                      = "guidancebre-dr-ppr.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-guidancebre-ppr"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_name                      = "guidancebre-dr-ppr.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  # HTTPS listeners for estimatessdi
  {
    name                           = "lsn-priv-https-estimatessdi-ppr"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "estimatessdi-dr-ppr"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_name                      = "estimatessdi-dr-ppr.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-estimatessdi-ppr"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_name                      = "estimatessdi-dr-ppr.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  # HTTPS listeners for estimatesbre
  {
    name                           = "lsn-priv-https-estimatesbre-ppr"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "estimatesbre-dr-ppr"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_name                      = "estimatesbre-dr-ppr.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-estimatesbre-ppr"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_name                      = "estimatesbre-dr-ppr.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  # HTTPS listeners for brokerxl
  {
    name                           = "lsn-priv-https-brokerxl-ppr"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "brokerxl-dr-ppr"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_name                      = "brokerxl-dr-ppr.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-brokerxl-ppr"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_name                      = "brokerxl-dr-ppr.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  # HTTPS listeners for broker
  {
    name                           = "lsn-priv-https-broker-ppr"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "broker-dr-ppr"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_name                      = "broker-dr-ppr.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-broker-ppr"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_name                      = "broker-dr-ppr.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  # HTTPS listeners for guidance
  {
    name                           = "lsn-priv-https-guidance-ppr"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "guidance-dr-ppr"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_name                      = "guidance-dr-ppr.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-guidance-ppr"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_name                      = "guidance-dr-ppr.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  # HTTPS listeners for collection
  {
    name                           = "lsn-priv-https-collection-ppr"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "collection-dr-ppr"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_name                      = "collection-dr-ppr.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-collection-ppr"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_name                      = "collection-dr-ppr.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  # HTTPS listeners for actualsbre
  {
    name                           = "lsn-priv-https-actualsbre-ppr"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "actualsbre-dr-ppr"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_name                      = "actualsbre-dr-ppr.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-actualsbre-ppr"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_name                      = "actualsbre-dr-ppr.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  }
]

probes = [
  {
    name                                      = "https-health-probe-qdctweb-ppr"
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
    name                                      = "https-health-probe-hvpweb-ppr"
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
    name                                      = "https-health-probe-guidancebre-ppr"
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
    name                                      = "https-health-probe-estimatessdi-ppr"
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
    name                                      = "https-health-probe-estimatesbre-ppr"
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
    name                                      = "https-health-probe-brokerxl-ppr"
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
    name                                      = "https-health-probe-broker-ppr"
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
    name                                      = "https-health-probe-guidance-ppr"
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
    name                                      = "https-health-probe-collection-ppr"
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
    name                                      = "https-health-probe-actualsbre-ppr"
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
    name                        = "https-rule-priv-qdctweb-ppr"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-qdctweb-ppr"
    priority                    = 110
    backend_address_pool_name   = "beap-qdctweb-ppr"
    backend_http_settings_name  = "https-backend-qdctweb-ppr"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-qdctweb-ppr"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-qdctweb-ppr"
    priority                    = 130
    backend_address_pool_name   = "beap-qdctweb-ppr"
    backend_http_settings_name  = "https-backend-qdctweb-ppr"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  # HTTPS rules - hvpweb
  {
    name                        = "https-rule-priv-hvpweb-ppr"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-hvpweb-ppr"
    priority                    = 111
    backend_address_pool_name   = "beap-hvpweb-ppr"
    backend_http_settings_name  = "https-backend-hvpweb-ppr"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-hvpweb-ppr"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-hvpweb-ppr"
    priority                    = 131
    backend_address_pool_name   = "beap-hvpweb-ppr"
    backend_http_settings_name  = "https-backend-hvpweb-ppr"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  # HTTPS rules - guidancebre
  {
    name                        = "https-rule-priv-guidancebre-ppr"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-guidancebre-ppr"
    priority                    = 112
    backend_address_pool_name   = "beap-guidancebre-ppr"
    backend_http_settings_name  = "https-backend-guidancebre-ppr"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-guidancebre-ppr"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-guidancebre-ppr"
    priority                    = 132
    backend_address_pool_name   = "beap-guidancebre-ppr"
    backend_http_settings_name  = "https-backend-guidancebre-ppr"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  # HTTPS rules - estimatessdi
  {
    name                        = "https-rule-priv-estimatessdi-ppr"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-estimatessdi-ppr"
    priority                    = 113
    backend_address_pool_name   = "beap-estimatessdi-ppr"
    backend_http_settings_name  = "https-backend-estimatessdi-ppr"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-estimatessdi-ppr"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-estimatessdi-ppr"
    priority                    = 133
    backend_address_pool_name   = "beap-estimatessdi-ppr"
    backend_http_settings_name  = "https-backend-estimatessdi-ppr"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  # HTTPS rules - estimatesbre
  {
    name                        = "https-rule-priv-estimatesbre-ppr"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-estimatesbre-ppr"
    priority                    = 114
    backend_address_pool_name   = "beap-estimatesbre-ppr"
    backend_http_settings_name  = "https-backend-estimatesbre-ppr"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-estimatesbre-ppr"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-estimatesbre-ppr"
    priority                    = 134
    backend_address_pool_name   = "beap-estimatesbre-ppr"
    backend_http_settings_name  = "https-backend-estimatesbre-ppr"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  # HTTPS rules - brokerxl
  {
    name                        = "https-rule-priv-brokerxl-ppr"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-brokerxl-ppr"
    priority                    = 115
    backend_address_pool_name   = "beap-brokerxl-ppr"
    backend_http_settings_name  = "https-backend-brokerxl-ppr"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-brokerxl-ppr"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-brokerxl-ppr"
    priority                    = 135
    backend_address_pool_name   = "beap-brokerxl-ppr"
    backend_http_settings_name  = "https-backend-brokerxl-ppr"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  # HTTPS rules - broker
  {
    name                        = "https-rule-priv-broker-ppr"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-broker-ppr"
    priority                    = 116
    backend_address_pool_name   = "beap-broker-ppr"
    backend_http_settings_name  = "https-backend-broker-ppr"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-broker-ppr"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-broker-ppr"
    priority                    = 136
    backend_address_pool_name   = "beap-broker-ppr"
    backend_http_settings_name  = "https-backend-broker-ppr"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  # HTTPS rules - guidance
  {
    name                        = "https-rule-priv-guidance-ppr"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-guidance-ppr"
    priority                    = 117
    backend_address_pool_name   = "beap-guidance-ppr"
    backend_http_settings_name  = "https-backend-guidance-ppr"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-guidance-ppr"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-guidance-ppr"
    priority                    = 137
    backend_address_pool_name   = "beap-guidance-ppr"
    backend_http_settings_name  = "https-backend-guidance-ppr"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  # HTTPS rules - collection
  {
    name                        = "https-rule-priv-collection-ppr"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-collection-ppr"
    priority                    = 118
    backend_address_pool_name   = "beap-collection-ppr"
    backend_http_settings_name  = "https-backend-collection-ppr"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-collection-ppr"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-collection-ppr"
    priority                    = 138
    backend_address_pool_name   = "beap-collection-ppr"
    backend_http_settings_name  = "https-backend-collection-ppr"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  # HTTPS rules - actualsbre
  {
    name                        = "https-rule-priv-actualsbre-ppr"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-actualsbre-ppr"
    priority                    = 119
    backend_address_pool_name   = "beap-actualsbre-ppr"
    backend_http_settings_name  = "https-backend-actualsbre-ppr"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-actualsbre-ppr"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-actualsbre-ppr"
    priority                    = 139
    backend_address_pool_name   = "beap-actualsbre-ppr"
    backend_http_settings_name  = "https-backend-actualsbre-ppr"
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
    name                = "qdct-dr-ppr"
    key_vault_secret_id = "https://a1a52161pprkvinfcus01.vault.azure.net/secrets/qdct-dr-ppr"
    data                = null
    password            = null
  },
  {
    name                = "hvpweb-dr-ppr"
    key_vault_secret_id = "https://a1a52161pprkvinfcus01.vault.azure.net/secrets/hvpweb-dr-ppr"
    data                = null
    password            = null
  },
  {
    name                = "guidancebre-dr-ppr"
    key_vault_secret_id = "https://a1a52161pprkvinfcus01.vault.azure.net/secrets/guidancebre-dr-ppr"
    data                = null
    password            = null
  },
  {
    name                = "estimatessdi-dr-ppr"
    key_vault_secret_id = "https://a1a52161pprkvinfcus01.vault.azure.net/secrets/estimatessdi-dr-ppr"
    data                = null
    password            = null
  },
  {
    name                = "estimatesbre-dr-ppr"
    key_vault_secret_id = "https://a1a52161pprkvinfcus01.vault.azure.net/secrets/estimatesbre-dr-ppr"
    data                = null
    password            = null
  },
  {
    name                = "brokerxl-dr-ppr"
    key_vault_secret_id = "https://a1a52161pprkvinfcus01.vault.azure.net/secrets/brokerxl-dr-ppr"
    data                = null
    password            = null
  },
  {
    name                = "broker-dr-ppr"
    key_vault_secret_id = "https://a1a52161pprkvinfcus01.vault.azure.net/secrets/broker-dr-ppr"
    data                = null
    password            = null
  },
  {
    name                = "guidance-dr-ppr"
    key_vault_secret_id = "https://a1a52161pprkvinfcus01.vault.azure.net/secrets/guidance-dr-ppr"
    data                = null
    password            = null
  },
  {
    name                = "collection-dr-ppr"
    key_vault_secret_id = "https://a1a52161pprkvinfcus01.vault.azure.net/secrets/collection-dr-ppr"
    data                = null
    password            = null
  },
  {
    name                = "actualsbre-dr-ppr"
    key_vault_secret_id = "https://a1a52161pprkvinfcus01.vault.azure.net/secrets/actualsbre-dr-ppr"
    data                = null
    password            = null
  }
]

