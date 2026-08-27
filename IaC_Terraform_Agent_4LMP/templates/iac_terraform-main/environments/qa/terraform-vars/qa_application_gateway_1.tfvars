org_id      = "a1a"
app_id      = "52161"
location    = "eastus2"
environment = "tst"
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
resource_group_name       = "a1a-52161-dev-rg-estimates-eus2-02"
platform_rtbl_vnet_id     = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-platform-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-rtbl-eus2-01"
shared_nrtbl_vnet_id      = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01"
privateendpoint_subnet_id = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-platform-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-rtbl-eus2-01/subnets/a1a-52161-dev-snet-workload-eus2-06"
subscription_id           = "96278378-bea2-4e84-b5a3-4b5459eb2d18"
agw_subnet_id             = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-platform-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-rtbl-eus2-01/subnets/a1a-52161-dev-snet-appgw-eus2-04"
keyvault_id               = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-estimates-eus2-02/providers/Microsoft.KeyVault/vaults/a1a52161tstkvinfeus201"
private_ip_address        = "10.93.197.5"

#--------------------------------------------------------
#                     Application Gateway
#--------------------------------------------------------
backend_address_pools = [
  {
    name         = "beap-qdctweb-tst"
    fqdns        = ["a1a-52161-tst-app-qdctweb-eus2-01-linux.azurewebsites.net"]
    ip_addresses = null
  },
  {
    name         = "beap-hvpweb-tst"
    fqdns        = ["a1a-52161-tst-app-hvpweb-eus2-01-linux.azurewebsites.net"]
    ip_addresses = null
  },
  {
    name         = "beap-guidancebre-tst"
    fqdns        = ["a1a-52161-tst-app-guidancebre-eus2-01-linux.azurewebsites.net"]
    ip_addresses = null
  },
  {
    name         = "beap-estimatessdi-tst"
    fqdns        = ["a1a-52161-tst-app-estimatessdi-eus2-01-linux.azurewebsites.net"]
    ip_addresses = null
  },
  {
    name         = "beap-estimatesbre-tst"
    fqdns        = ["a1a-52161-tst-app-estimatesbre-eus2-01-linux.azurewebsites.net"]
    ip_addresses = null
  },
  {
    name         = "beap-brokerxl-tst"
    fqdns        = ["a1a-52161-tst-app-brokerxl-eus2-01-linux.azurewebsites.net"]
    ip_addresses = null
  },
  {
    name         = "beap-broker-tst"
    fqdns        = ["a1a-52161-tst-app-broker-eus2-01-linux.azurewebsites.net"]
    ip_addresses = null
  },
  {
    name         = "beap-guidance-tst"
    fqdns        = ["a1a-52161-tst-app-guidance-eus2-01-linux.azurewebsites.net"]
    ip_addresses = null
  },
  {
    name         = "beap-collection-tst"
    fqdns        = ["a1a-52161-tst-app-collection-eus2-01-linux.azurewebsites.net"]
    ip_addresses = null
  },
  {
    name         = "beap-actualsbre-tst"
    fqdns        = ["a1a-52161-tst-app-actualsbre-eus2-01-linux.azurewebsites.net"]
    ip_addresses = null
  },
  # CouchDB backend pool — uses FQDN so config survives VM IP changes
  {
    name         = "beap-couchdb-tst"
    fqdns        = ["hvpreptsteus201.estimates-test.dev.4.superprivate.azure.private.inf0.net"]
    ip_addresses = null
  }
]

backend_http_settings = [
  {
    name                                = "https-backend-qdctweb-tst"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-qdctweb-tst"
    host_name                           = ""
    pick_host_name_from_backend_address = true
    connection_draining = {
      enabled           = true
      drain_timeout_sec = 60
    }
  },
  {
    name                                = "https-backend-hvpweb-tst"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-hvpweb-tst"
    host_name                           = ""
    pick_host_name_from_backend_address = true
    connection_draining = {
      enabled           = true
      drain_timeout_sec = 60
    }
  },
  {
    name                                = "https-backend-guidancebre-tst"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-guidancebre-tst"
    host_name                           = ""
    pick_host_name_from_backend_address = true
    connection_draining = {
      enabled           = true
      drain_timeout_sec = 60
    }
  },
  {
    name                                = "https-backend-estimatessdi-tst"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-estimatessdi-tst"
    host_name                           = ""
    pick_host_name_from_backend_address = true
    connection_draining = {
      enabled           = true
      drain_timeout_sec = 60
    }
  },
  {
    name                                = "https-backend-estimatesbre-tst"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-estimatesbre-tst"
    host_name                           = ""
    pick_host_name_from_backend_address = true
    connection_draining = {
      enabled           = true
      drain_timeout_sec = 60
    }
  },
  {
    name                                = "https-backend-brokerxl-tst"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-brokerxl-tst"
    host_name                           = ""
    pick_host_name_from_backend_address = true
    connection_draining = {
      enabled           = true
      drain_timeout_sec = 60
    }
  },
  {
    name                                = "https-backend-broker-tst"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-broker-tst"
    host_name                           = ""
    pick_host_name_from_backend_address = true
    connection_draining = {
      enabled           = true
      drain_timeout_sec = 60
    }
  },
  {
    name                                = "https-backend-guidance-tst"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-guidance-tst"
    host_name                           = ""
    pick_host_name_from_backend_address = true
    connection_draining = {
      enabled           = true
      drain_timeout_sec = 60
    }
  },
  {
    name                                = "https-backend-collection-tst"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-collection-tst"
    host_name                           = ""
    pick_host_name_from_backend_address = true
    connection_draining = {
      enabled           = true
      drain_timeout_sec = 60
    }
  },
  {
    name                                = "https-backend-actualsbre-tst"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-actualsbre-tst"
    host_name                           = ""
    pick_host_name_from_backend_address = true
    connection_draining = {
      enabled           = true
      drain_timeout_sec = 60
    }
  },
  {
    name                                = "https-backend-couchdb-tst"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 6984
    protocol                            = "Https"
    request_timeout                     = 30
    probe_name                          = "https-health-probe-couchdb-tst"
    host_name                           = ""
    pick_host_name_from_backend_address = true
    trusted_root_certificate_names      = ["couchdb-ca-tst"]
    connection_draining = {
      enabled           = true
      drain_timeout_sec = 60
    }
  }
]

http_listeners = [
  # HTTPS listeners for qdctweb
  {
    name                           = "lsn-priv-https-qdctweb-tst"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "qdct-tst"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_name                      = "qdct.tst.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-qdctweb-tst"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_name                      = "qdct.tst.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  # HTTPS listeners for hvpweb
  {
    name                           = "lsn-priv-https-hvpweb-tst"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "hvpweb-tst"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_name                      = "hvpweb.tst.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-hvpweb-tst"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_name                      = "hvpweb.tst.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  # HTTPS listeners for guidancebre
  {
    name                           = "lsn-priv-https-guidancebre-tst"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "guidancebre-tst"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_name                      = "guidancebre.tst.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-guidancebre-tst"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_name                      = "guidancebre.tst.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  # HTTPS listeners for estimatessdi
  {
    name                           = "lsn-priv-https-estimatessdi-tst"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "estimatessdi-tst"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_name                      = "estimatessdi.tst.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-estimatessdi-tst"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_name                      = "estimatessdi.tst.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  # HTTPS listeners for estimatesbre
  {
    name                           = "lsn-priv-https-estimatesbre-tst"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "estimatesbre-tst"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_name                      = "estimatesbre.tst.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-estimatesbre-tst"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_name                      = "estimatesbre.tst.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  # HTTPS listeners for brokerxl
  {
    name                           = "lsn-priv-https-brokerxl-tst"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "brokerxl-tst"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_name                      = "brokerxl.tst.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-brokerxl-tst"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_name                      = "brokerxl.tst.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  # HTTPS listeners for broker
  {
    name                           = "lsn-priv-https-broker-tst"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "broker-tst"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_name                      = "broker.tst.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-broker-tst"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_name                      = "broker.tst.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  # HTTPS listeners for guidance
  {
    name                           = "lsn-priv-https-guidance-tst"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "guidance-tst"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_name                      = "guidance.tst.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-guidance-tst"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_name                      = "guidance.tst.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  # HTTPS listeners for collection
  {
    name                           = "lsn-priv-https-collection-tst"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "collection-tst"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_name                      = "collection.tst.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-collection-tst"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_name                      = "collection.tst.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  # HTTPS listeners for actualsbre
  {
    name                           = "lsn-priv-https-actualsbre-tst"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "actualsbre-tst"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_name                      = "actualsbre.tst.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-actualsbre-tst"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_name                      = "actualsbre.tst.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  # CouchDB listeners
  {
    name                           = "lsn-priv-https-couchdb-tst"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "couchdb-tst"
    require_sni                    = true
    listener_type                  = "MultiSite"
    host_name                      = "couchdb.tst.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  },
  {
    name                           = "lsn-priv-http-couchdb-tst"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttp"
    protocol                       = "Http"
    ssl_certificate_name           = null
    require_sni                    = false
    listener_type                  = "MultiSite"
    host_name                      = "couchdb.tst.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  }
]

probes = [
  {
    name                                      = "https-health-probe-qdctweb-tst"
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
    name                                      = "https-health-probe-hvpweb-tst"
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
    name                                      = "https-health-probe-guidancebre-tst"
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
    name                                      = "https-health-probe-estimatessdi-tst"
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
    name                                      = "https-health-probe-estimatesbre-tst"
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
    name                                      = "https-health-probe-brokerxl-tst"
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
    name                                      = "https-health-probe-broker-tst"
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
    name                                      = "https-health-probe-guidance-tst"
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
    name                                      = "https-health-probe-collection-tst"
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
    name                                      = "https-health-probe-actualsbre-tst"
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
    name                                      = "https-health-probe-couchdb-tst"
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
  # HTTPS rules - qdctweb
  {
    name                        = "https-rule-priv-qdctweb-tst"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-qdctweb-tst"
    priority                    = 310
    backend_address_pool_name   = "beap-qdctweb-tst"
    backend_http_settings_name  = "https-backend-qdctweb-tst"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-qdctweb-tst"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-qdctweb-tst"
    priority                    = 311
    backend_address_pool_name   = "beap-qdctweb-tst"
    backend_http_settings_name  = "https-backend-qdctweb-tst"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  # HTTPS rules - hvpweb
  {
    name                        = "https-rule-priv-hvpweb-tst"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-hvpweb-tst"
    priority                    = 320
    backend_address_pool_name   = "beap-hvpweb-tst"
    backend_http_settings_name  = "https-backend-hvpweb-tst"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-hvpweb-tst"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-hvpweb-tst"
    priority                    = 321
    backend_address_pool_name   = "beap-hvpweb-tst"
    backend_http_settings_name  = "https-backend-hvpweb-tst"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  # HTTPS rules - guidancebre
  {
    name                        = "https-rule-priv-guidancebre-tst"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-guidancebre-tst"
    priority                    = 330
    backend_address_pool_name   = "beap-guidancebre-tst"
    backend_http_settings_name  = "https-backend-guidancebre-tst"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-guidancebre-tst"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-guidancebre-tst"
    priority                    = 331
    backend_address_pool_name   = "beap-guidancebre-tst"
    backend_http_settings_name  = "https-backend-guidancebre-tst"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  # HTTPS rules - estimatessdi
  {
    name                        = "https-rule-priv-estimatessdi-tst"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-estimatessdi-tst"
    priority                    = 340
    backend_address_pool_name   = "beap-estimatessdi-tst"
    backend_http_settings_name  = "https-backend-estimatessdi-tst"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-estimatessdi-tst"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-estimatessdi-tst"
    priority                    = 341
    backend_address_pool_name   = "beap-estimatessdi-tst"
    backend_http_settings_name  = "https-backend-estimatessdi-tst"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  # HTTPS rules - estimatesbre
  {
    name                        = "https-rule-priv-estimatesbre-tst"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-estimatesbre-tst"
    priority                    = 350
    backend_address_pool_name   = "beap-estimatesbre-tst"
    backend_http_settings_name  = "https-backend-estimatesbre-tst"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-estimatesbre-tst"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-estimatesbre-tst"
    priority                    = 351
    backend_address_pool_name   = "beap-estimatesbre-tst"
    backend_http_settings_name  = "https-backend-estimatesbre-tst"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  # HTTPS rules - brokerxl
  {
    name                        = "https-rule-priv-brokerxl-tst"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-brokerxl-tst"
    priority                    = 360
    backend_address_pool_name   = "beap-brokerxl-tst"
    backend_http_settings_name  = "https-backend-brokerxl-tst"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-brokerxl-tst"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-brokerxl-tst"
    priority                    = 361
    backend_address_pool_name   = "beap-brokerxl-tst"
    backend_http_settings_name  = "https-backend-brokerxl-tst"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  # HTTPS rules - broker
  {
    name                        = "https-rule-priv-broker-tst"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-broker-tst"
    priority                    = 370
    backend_address_pool_name   = "beap-broker-tst"
    backend_http_settings_name  = "https-backend-broker-tst"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-broker-tst"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-broker-tst"
    priority                    = 371
    backend_address_pool_name   = "beap-broker-tst"
    backend_http_settings_name  = "https-backend-broker-tst"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  # HTTPS rules - guidance
  {
    name                        = "https-rule-priv-guidance-tst"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-guidance-tst"
    priority                    = 380
    backend_address_pool_name   = "beap-guidance-tst"
    backend_http_settings_name  = "https-backend-guidance-tst"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-guidance-tst"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-guidance-tst"
    priority                    = 381
    backend_address_pool_name   = "beap-guidance-tst"
    backend_http_settings_name  = "https-backend-guidance-tst"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  # HTTPS rules - collection
  {
    name                        = "https-rule-priv-collection-tst"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-collection-tst"
    priority                    = 390
    backend_address_pool_name   = "beap-collection-tst"
    backend_http_settings_name  = "https-backend-collection-tst"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-collection-tst"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-collection-tst"
    priority                    = 391
    backend_address_pool_name   = "beap-collection-tst"
    backend_http_settings_name  = "https-backend-collection-tst"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  # HTTPS rules - actualsbre
  {
    name                        = "https-rule-priv-actualsbre-tst"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-actualsbre-tst"
    priority                    = 400
    backend_address_pool_name   = "beap-actualsbre-tst"
    backend_http_settings_name  = "https-backend-actualsbre-tst"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-actualsbre-tst"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-actualsbre-tst"
    priority                    = 401
    backend_address_pool_name   = "beap-actualsbre-tst"
    backend_http_settings_name  = "https-backend-actualsbre-tst"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  # CouchDB routing rules
  {
    name                        = "https-rule-priv-couchdb-tst"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-https-couchdb-tst"
    priority                    = 410
    backend_address_pool_name   = "beap-couchdb-tst"
    backend_http_settings_name  = "https-backend-couchdb-tst"
    rewrite_rule_set_name       = null
    url_path_map_name           = null
    redirect_configuration_name = null
  },
  {
    name                        = "http-rule-priv-couchdb-tst"
    rule_type                   = "Basic"
    listener_name               = "lsn-priv-http-couchdb-tst"
    priority                    = 411
    backend_address_pool_name   = "beap-couchdb-tst"
    backend_http_settings_name  = "https-backend-couchdb-tst"
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
          "10.202.161.128/25", # ZPA-LSEG-Dev-Seg1-Uksouth
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
    name                = "qdct-cert-tst"
    key_vault_secret_id = null
    path_of_certificate = null
    data                = null
    password            = null
  },
  {
    name                = "hvpweb-cert-tst"
    key_vault_secret_id = null
    path_of_certificate = null
    data                = null
    password            = null
  },
  {
    name                = "guidancebre-cert-tst"
    key_vault_secret_id = null
    path_of_certificate = null
    data                = null
    password            = null
  },
  {
    name                = "estimatessdi-cert-tst"
    key_vault_secret_id = null
    path_of_certificate = null
    data                = null
    password            = null
  },
  {
    name                = "estimatesbre-cert-tst"
    key_vault_secret_id = null
    path_of_certificate = null
    data                = null
    password            = null
  },
  {
    name                = "brokerxl-cert-tst"
    key_vault_secret_id = null
    path_of_certificate = null
    data                = null
    password            = null
  },
  {
    name                = "broker-cert-tst"
    key_vault_secret_id = null
    path_of_certificate = null
    data                = null
    password            = null
  },
  {
    name                = "guidance-cert-tst"
    key_vault_secret_id = null
    path_of_certificate = null
    data                = null
    password            = null
  },
  {
    name                = "collection-cert-tst"
    key_vault_secret_id = null
    path_of_certificate = null
    data                = null
    password            = null
  },
  {
    name                = "actualsbre-cert-tst"
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
    name = "couchdb-ca-tst"
  }
]
