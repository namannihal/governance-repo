org_id      = "a1a"
app_id      = "52161"
location    = "eastus2"
environment = "dev"
context     = "estimates"
instance    = "01"
tags = {
  mnd-applicationid      = "app-52161"
  mnd-applicationname    = "estimates_azure_dbor_dev"
  mnd-costcentre         = "52161"
  mnd-dataclassification = "restricted"
  mnd-envsubtype         = "test"
  mnd-envtype            = "dev"
  mnd-lifecycle          = "live"
  mnd-owner              = "TF-TF-IndiaEstimatesTech@lseg.com"
  mnd-projectcode        = "P011085"
  mnd-supportgroup       = "DEVELOP-ESTIMATES-COLLECT-ICA"
  cloud_provider         = "azure"
  opt-datadog            = "require"
}

#### Platform and Application Dependencies ####
resource_group_name       = "a1a-52161-dev-rg-estimates-eus2-01"
platform_rtbl_vnet_id     = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-platform-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-rtbl-eus2-01"
shared_nrtbl_vnet_id      = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01"
privateendpoint_subnet_id = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-platform-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-rtbl-eus2-01/subnets/a1a-52161-dev-snet-workload-eus2-06"
subscription_id           = "96278378-bea2-4e84-b5a3-4b5459eb2d18"
agw_subnet_id             = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-platform-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-rtbl-eus2-01/subnets/a1a-52161-dev-snet-appgw-eus2-04"
keyvault_id               = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-estimates-eus2-01/providers/Microsoft.KeyVault/vaults/a1a52161devkvinfeus201"
private_ip_address        = "10.93.197.5"

#--------------------------------------------------------
#                     Application Gateway
#--------------------------------------------------------
backend_address_pools = [
  {
    name         = "beap-qdctweb-dev"
    fqdns        = ["a1a-52161-dev-app-qdctweb-eus2-01-linux.azurewebsites.net"]
    ip_addresses = null
  },
  {
    name         = "beap-hvpweb-dev"
    fqdns        = ["a1a-52161-dev-app-hvpweb-eus2-01-linux.azurewebsites.net"]
    ip_addresses = null
  },
  {
    name         = "beap-guidancebre-dev"
    fqdns        = ["a1a-52161-dev-app-guidancebre-eus2-01-linux.azurewebsites.net"]
    ip_addresses = null
  },
  {
    name         = "beap-estimatessdi-dev"
    fqdns        = ["a1a-52161-dev-app-estimatessdi-eus2-01-linux.azurewebsites.net"]
    ip_addresses = null
  },
  {
    name         = "beap-estimatesbre-dev"
    fqdns        = ["a1a-52161-dev-app-estimatesbre-eus2-01-linux.azurewebsites.net"]
    ip_addresses = null
  },
  {
    name         = "beap-brokerxl-dev"
    fqdns        = ["a1a-52161-dev-app-brokerxl-eus2-01-linux.azurewebsites.net"]
    ip_addresses = null
  },
  {
    name         = "beap-broker-dev"
    fqdns        = ["a1a-52161-dev-app-broker-eus2-01-linux.azurewebsites.net"]
    ip_addresses = null
  },
  {
    name         = "beap-guidance-dev"
    fqdns        = ["a1a-52161-dev-app-guidance-eus2-01-linux.azurewebsites.net"]
    ip_addresses = null
  },
  {
    name         = "beap-collection-dev"
    fqdns        = ["a1a-52161-dev-app-collection-eus2-01-linux.azurewebsites.net"]
    ip_addresses = null
  },
  {
    name         = "beap-actualsbre-dev"
    fqdns        = ["a1a-52161-dev-app-actualsbre-eus2-01-linux.azurewebsites.net"]
    ip_addresses = null
  },
  {
    name         = "beap-couchdb-dev"
    fqdns        = ["hvprepdeveus201.estimates-test.dev.4.superprivate.azure.private.inf0.net"]
    ip_addresses = null
  }
]

backend_http_settings = [
  {
    name                                = "https-backend-qdctweb-dev"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-qdctweb-dev"
    host_name                           = ""
    pick_host_name_from_backend_address = true
    connection_draining = {
      enabled           = true
      drain_timeout_sec = 60
    }
  },
  {
    name                                = "https-backend-hvpweb-dev"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-hvpweb-dev"
    host_name                           = ""
    pick_host_name_from_backend_address = true
    connection_draining = {
      enabled           = true
      drain_timeout_sec = 60
    }
  },
  {
    name                                = "https-backend-guidancebre-dev"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-guidancebre-dev"
    host_name                           = ""
    pick_host_name_from_backend_address = true
    connection_draining = {
      enabled           = true
      drain_timeout_sec = 60
    }
  },
  {
    name                                = "https-backend-estimatessdi-dev"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-estimatessdi-dev"
    host_name                           = ""
    pick_host_name_from_backend_address = true
    connection_draining = {
      enabled           = true
      drain_timeout_sec = 60
    }
  },
  {
    name                                = "https-backend-estimatesbre-dev"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-estimatesbre-dev"
    host_name                           = ""
    pick_host_name_from_backend_address = true
    connection_draining = {
      enabled           = true
      drain_timeout_sec = 60
    }
  },
  {
    name                                = "https-backend-brokerxl-dev"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-brokerxl-dev"
    host_name                           = ""
    pick_host_name_from_backend_address = true
    connection_draining = {
      enabled           = true
      drain_timeout_sec = 60
    }
  },
  {
    name                                = "https-backend-broker-dev"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-broker-dev"
    host_name                           = ""
    pick_host_name_from_backend_address = true
    connection_draining = {
      enabled           = true
      drain_timeout_sec = 60
    }
  },
  {
    name                                = "https-backend-guidance-dev"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-guidance-dev"
    host_name                           = ""
    pick_host_name_from_backend_address = true
    connection_draining = {
      enabled           = true
      drain_timeout_sec = 60
    }
  },
  {
    name                                = "https-backend-collection-dev"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-collection-dev"
    host_name                           = ""
    pick_host_name_from_backend_address = true
    connection_draining = {
      enabled           = true
      drain_timeout_sec = 60
    }
  },
  {
    name                                = "https-backend-actualsbre-dev"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-actualsbre-dev"
    host_name                           = ""
    pick_host_name_from_backend_address = true
    connection_draining = {
      enabled           = true
      drain_timeout_sec = 60
    }
  },
  {
    name                                = "https-backend-couchdb-dev"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 6984
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-couchdb-dev"
    host_name                           = ""
    pick_host_name_from_backend_address = true
    trusted_root_certificate_names      = ["couchdb-ca-dev"]
    connection_draining = {
      enabled           = true
      drain_timeout_sec = 60
    }
  }
]

http_listeners = [
  # HTTPS listeners for qdct
  {
    name                           = "lsn-priv-https-qdctweb-dev"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "qdct-dev"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_names                     = null
    host_name                      = "qdct.dev.estimates.dbors.internal"
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-qdctweb-dev"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_names                     = null
    host_name                      = "qdct.dev.estimates.dbors.internal"
    firewall_policy_id             = null
  },
  # HTTPS listeners for hvpweb
  {
    name                           = "lsn-priv-https-hvpweb-dev"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "hvpweb-dev"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_name                      = "hvpweb.dev.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-hvpweb-dev"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_name                      = "hvpweb.dev.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  # HTTPS listeners for guidancebre
  {
    name                           = "lsn-priv-https-guidancebre-dev"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "guidancebre-dev"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_name                      = "guidancebre.dev.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-guidancebre-dev"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_name                      = "guidancebre.dev.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  # HTTPS listeners for estimatessdi
  {
    name                           = "lsn-priv-https-estimatessdi-dev"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "estimatessdi-dev"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_name                      = "estimatessdi.dev.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-estimatessdi-dev"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_name                      = "estimatessdi.dev.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  # HTTPS listeners for estimatesbre
  {
    name                           = "lsn-priv-https-estimatesbre-dev"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "estimatesbre-dev"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_name                      = "estimatesbre.dev.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-estimatesbre-dev"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_name                      = "estimatesbre.dev.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  # HTTPS listeners for brokerxl
  {
    name                           = "lsn-priv-https-brokerxl-dev"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "brokerxl-dev"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_name                      = "brokerxl.dev.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-brokerxl-dev"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_name                      = "brokerxl.dev.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  # HTTPS listeners for broker
  {
    name                           = "lsn-priv-https-broker-dev"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "broker-dev"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_name                      = "broker.dev.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-broker-dev"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_name                      = "broker.dev.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  # HTTPS listeners for guidance
  {
    name                           = "lsn-priv-https-guidance-dev"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "guidance-dev"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_name                      = "guidance.dev.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-guidance-dev"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_name                      = "guidance.dev.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  # HTTPS listeners for collection
  {
    name                           = "lsn-priv-https-collection-dev"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "collection-dev"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_name                      = "collection.dev.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-collection-dev"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_name                      = "collection.dev.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  # HTTPS listeners for actualsbre
  {
    name                           = "lsn-priv-https-actualsbre-dev"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "actualsbre-dev"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_name                      = "actualsbre.dev.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-actualsbre-dev"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_name                      = "actualsbre.dev.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-https-couchdb-dev"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "couchdb-dev"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_name                      = "couchdb.dev.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-couchdb-dev"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_name                      = "couchdb.dev.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  }
]

probes = [
  {
    name                                      = "https-health-probe-qdctweb-dev"
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
    name                                      = "https-health-probe-hvpweb-dev"
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
    name                                      = "https-health-probe-guidancebre-dev"
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
    name                                      = "https-health-probe-estimatessdi-dev"
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
    name                                      = "https-health-probe-estimatesbre-dev"
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
    name                                      = "https-health-probe-brokerxl-dev"
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
    name                                      = "https-health-probe-broker-dev"
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
    name                                      = "https-health-probe-guidance-dev"
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
    name                                      = "https-health-probe-collection-dev"
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
    name                                      = "https-health-probe-actualsbre-dev"
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
  # CouchDB probe on HTTPS:6984 — /_up returns 200 when CouchDB is healthy (requires no auth)
  {
    name                                      = "https-health-probe-couchdb-dev"
    path                                      = "/_up"
    protocol                                  = "Https"
    port                                      = 6984
    host                                      = null
    interval                                  = 30
    timeout                                   = 30
    unhealthy_threshold                       = 3
    pick_host_name_from_backend_http_settings = true
    match = {
      body        = ""
      status_code = ["200"]
    }
  }
]

request_routing_rules = [
  # HTTPS rules - qdct
  {
    name                        = "https-rule-priv-qdctweb-dev"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-qdctweb-dev"
    priority                    = 110
    backend_address_pool_name   = "beap-qdctweb-dev"
    backend_http_settings_name  = "https-backend-qdctweb-dev"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-qdctweb-dev"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-qdctweb-dev"
    priority                    = 111
    backend_address_pool_name   = "beap-qdctweb-dev"
    backend_http_settings_name  = "https-backend-qdctweb-dev"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  # HTTPS rules - hvpweb
  {
    name                        = "https-rule-priv-hvpweb-dev"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-hvpweb-dev"
    priority                    = 120
    backend_address_pool_name   = "beap-hvpweb-dev"
    backend_http_settings_name  = "https-backend-hvpweb-dev"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-hvpweb-dev"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-hvpweb-dev"
    priority                    = 121
    backend_address_pool_name   = "beap-hvpweb-dev"
    backend_http_settings_name  = "https-backend-hvpweb-dev"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  # HTTPS rules - guidancebre
  {
    name                        = "https-rule-priv-guidancebre-dev"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-guidancebre-dev"
    priority                    = 130
    backend_address_pool_name   = "beap-guidancebre-dev"
    backend_http_settings_name  = "https-backend-guidancebre-dev"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-guidancebre-dev"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-guidancebre-dev"
    priority                    = 131
    backend_address_pool_name   = "beap-guidancebre-dev"
    backend_http_settings_name  = "https-backend-guidancebre-dev"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  # HTTPS rules - estimatessdi
  {
    name                        = "https-rule-priv-estimatessdi-dev"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-estimatessdi-dev"
    priority                    = 140
    backend_address_pool_name   = "beap-estimatessdi-dev"
    backend_http_settings_name  = "https-backend-estimatessdi-dev"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-estimatessdi-dev"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-estimatessdi-dev"
    priority                    = 141
    backend_address_pool_name   = "beap-estimatessdi-dev"
    backend_http_settings_name  = "https-backend-estimatessdi-dev"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  # HTTPS rules - estimatesbre
  {
    name                        = "https-rule-priv-estimatesbre-dev"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-estimatesbre-dev"
    priority                    = 150
    backend_address_pool_name   = "beap-estimatesbre-dev"
    backend_http_settings_name  = "https-backend-estimatesbre-dev"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-estimatesbre-dev"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-estimatesbre-dev"
    priority                    = 151
    backend_address_pool_name   = "beap-estimatesbre-dev"
    backend_http_settings_name  = "https-backend-estimatesbre-dev"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  # HTTPS rules - brokerxl
  {
    name                        = "https-rule-priv-brokerxl-dev"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-brokerxl-dev"
    priority                    = 160
    backend_address_pool_name   = "beap-brokerxl-dev"
    backend_http_settings_name  = "https-backend-brokerxl-dev"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-brokerxl-dev"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-brokerxl-dev"
    priority                    = 161
    backend_address_pool_name   = "beap-brokerxl-dev"
    backend_http_settings_name  = "https-backend-brokerxl-dev"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  # HTTPS rules - broker
  {
    name                        = "https-rule-priv-broker-dev"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-broker-dev"
    priority                    = 170
    backend_address_pool_name   = "beap-broker-dev"
    backend_http_settings_name  = "https-backend-broker-dev"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-broker-dev"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-broker-dev"
    priority                    = 171
    backend_address_pool_name   = "beap-broker-dev"
    backend_http_settings_name  = "https-backend-broker-dev"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  # HTTPS rules - guidance
  {
    name                        = "https-rule-priv-guidance-dev"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-guidance-dev"
    priority                    = 180
    backend_address_pool_name   = "beap-guidance-dev"
    backend_http_settings_name  = "https-backend-guidance-dev"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-guidance-dev"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-guidance-dev"
    priority                    = 181
    backend_address_pool_name   = "beap-guidance-dev"
    backend_http_settings_name  = "https-backend-guidance-dev"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  # HTTPS rules - collection
  {
    name                        = "https-rule-priv-collection-dev"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-collection-dev"
    priority                    = 190
    backend_address_pool_name   = "beap-collection-dev"
    backend_http_settings_name  = "https-backend-collection-dev"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-collection-dev"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-collection-dev"
    priority                    = 191
    backend_address_pool_name   = "beap-collection-dev"
    backend_http_settings_name  = "https-backend-collection-dev"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  # HTTPS rules - actualsbre
  {
    name                        = "https-rule-priv-actualsbre-dev"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-actualsbre-dev"
    priority                    = 200
    backend_address_pool_name   = "beap-actualsbre-dev"
    backend_http_settings_name  = "https-backend-actualsbre-dev"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-actualsbre-dev"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-actualsbre-dev"
    priority                    = 201
    backend_address_pool_name   = "beap-actualsbre-dev"
    backend_http_settings_name  = "https-backend-actualsbre-dev"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  # CouchDB routing rules
  {
    name                        = "https-rule-priv-couchdb-dev"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-couchdb-dev"
    priority                    = 210
    backend_address_pool_name   = "beap-couchdb-dev"
    backend_http_settings_name  = "https-backend-couchdb-dev"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-couchdb-dev"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-couchdb-dev"
    priority                    = 211
    backend_address_pool_name   = "beap-couchdb-dev"
    backend_http_settings_name  = "https-backend-couchdb-dev"
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
use_keyvault_certificates = false

ssl_certificates = [
  {
    name                = "qdct-cert-dev"
    key_vault_secret_id = null
    path_of_certificate = null
    data                = null
    password            = null
  },
  {
    name                = "hvpweb-cert-dev"
    key_vault_secret_id = null
    path_of_certificate = null
    data                = null
    password            = null
  },
  {
    name                = "guidancebre-cert-dev"
    key_vault_secret_id = null
    path_of_certificate = null
    data                = null
    password            = null
  },
  {
    name                = "estimatessdi-cert-dev"
    key_vault_secret_id = null
    path_of_certificate = null
    data                = null
    password            = null
  },
  {
    name                = "estimatesbre-cert-dev"
    key_vault_secret_id = null
    path_of_certificate = null
    data                = null
    password            = null
  },
  {
    name                = "brokerxl-cert-dev"
    key_vault_secret_id = null
    path_of_certificate = null
    data                = null
    password            = null
  },
  {
    name                = "broker-cert-dev"
    key_vault_secret_id = null
    path_of_certificate = null
    data                = null
    password            = null
  },
  {
    name                = "guidance-cert-dev"
    key_vault_secret_id = null
    path_of_certificate = null
    data                = null
    password            = null
  },
  {
    name                = "collection-cert-dev"
    key_vault_secret_id = null
    path_of_certificate = null
    data                = null
    password            = null
  },
  {
    name                = "actualsbre-cert-dev"
    key_vault_secret_id = null
    path_of_certificate = null
    data                = null
    password            = null
  }
]

#---------------------------------------------------------
# Trusted Root Certificates — CA cert for CouchDB backend (HTTPS:6984).
# CA cert is automatically extracted from TF_VAR_couchdb_cert (PFX) at apply time
# by scripts/extract-ca-cert.sh — no separate HashiCorp Vault entry required.
#---------------------------------------------------------
trusted_root_certificates = [
  {
    name = "couchdb-ca-dev"
  }
]
