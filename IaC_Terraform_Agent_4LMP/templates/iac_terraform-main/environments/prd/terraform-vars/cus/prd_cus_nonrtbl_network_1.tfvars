# We are using "ppr" as the environment value because "QA" is not allowed by the ResourceName module. ref- https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames/-/blob/main/variables.tf?ref_type=heads#L35
org_id         = "a1a"
app_id         = "52161"
location       = "centralus"
environment    = "prd"
instance       = "01"
location_short = "cus"

resource_group_name = "a1a-52161-prd-rg-prod-cus-01"
virtual_network_id  = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-nonrtbl-cus-01"
tags = {
  mnd-applicationid      = "app-52161"
  mnd-applicationname    = "estimates_azure_dbor_prd"
  mnd-costcentre         = "52161"
  mnd-dataclassification = "restricted"
  mnd-envsubtype         = "production"
  mnd-lifecycle          = "live"
  mnd-owner              = "TF-TF-IndiaEstimatesTech@lseg.com"
  mnd-projectcode        = "P011085"
  mnd-supportgroup       = "DEVELOP-ESTIMATES-COLLECT-ICA"
}

routable_rules = {
  route1 = {
    route1 = {
      name                   = "a1a-52161-prd-route-01"
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.150.66.68"
    }
  }
  route2 = {
    route2 = {
      name                   = "a1a-52161-prd-route-02"
      address_prefix         = "10.0.0.0/8"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.150.66.68"
    }
  }
  route3 = {
    route3 = {
      name                   = "a1a-52161-prd-route-03"
      address_prefix         = "172.16.0.0/12"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.150.66.68"
    }
  }
}

subnets = {
  ecapp_subnet = {
    context           = "ecapp"
    address_prefix    = "100.69.1.0/25"
    routes            = {}
    service_endpoints = []
    security_rules = {
      rule1 = {
        name                                       = "AllowVnetInbound"
        description                                = "Allow VirtualNetwork inbound traffic"
        priority                                   = 100
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefix                      = "VirtualNetwork"
        destination_address_prefix                 = "VirtualNetwork"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
      rule2 = {
        name                                       = "AllowHTTPSOutbound"
        description                                = "Allow HTTPS to AzureCloud"
        priority                                   = 100
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "Tcp"
        source_port_range                          = "*"
        destination_port_range                     = "443"
        source_address_prefix                      = "*"
        destination_address_prefix                 = "AzureCloud"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
      rule3 = {
        name                                       = "AllowVnetOutbound"
        description                                = "Allow VirtualNetwork outbound traffic"
        priority                                   = 110
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefix                      = "VirtualNetwork"
        destination_address_prefix                 = "VirtualNetwork"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
    }
    delegation = []
  }
  ecasp1_subnet = {
    context           = "ecasp1"
    address_prefix    = "100.69.2.0/27"
    routes            = {}
    service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.ServiceBus", "Microsoft.Web", "Microsoft.Sql", "Microsoft.EventHub"]
    security_rules = {
      rule1 = {
        name                                       = "AllowVnetInbound"
        description                                = "Allow VirtualNetwork inbound traffic"
        priority                                   = 100
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefix                      = "VirtualNetwork"
        destination_address_prefix                 = "VirtualNetwork"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
      rule2 = {
        name                                       = "AllowVnetOutbound"
        description                                = "Allow VirtualNetwork outbound traffic"
        priority                                   = 100
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefix                      = "VirtualNetwork"
        destination_address_prefix                 = "VirtualNetwork"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
    }
    delegation = [
      {
        delegation_name         = "delegation"
        service_delegation_name = "Microsoft.Web/serverFarms"
        actions = [
          "Microsoft.Network/virtualNetworks/subnets/action"
        ]
      }
    ]
  }
  ecasp2_subnet = {
    context           = "ecasp2"
    address_prefix    = "100.69.2.64/27"
    routes            = {}
    service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.ServiceBus", "Microsoft.Web", "Microsoft.Sql", "Microsoft.EventHub"]
    security_rules = {
      rule1 = {
        name                                       = "AllowVnetInbound"
        description                                = "Allow VirtualNetwork inbound traffic"
        priority                                   = 100
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefix                      = "VirtualNetwork"
        destination_address_prefix                 = "VirtualNetwork"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
      rule2 = {
        name                                       = "AllowVnetOutbound"
        description                                = "Allow VirtualNetwork outbound traffic"
        priority                                   = 100
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefix                      = "VirtualNetwork"
        destination_address_prefix                 = "VirtualNetwork"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
    }
    delegation = [
      {
        delegation_name         = "delegation"
        service_delegation_name = "Microsoft.Web/serverFarms"
        actions = [
          "Microsoft.Network/virtualNetworks/subnets/action"
        ]
      }
    ]
  }
  ecpec_subnet = {
    context           = "ecpec"
    address_prefix    = "100.69.4.0/26"
    routes            = {}
    service_endpoints = []
    security_rules = {
      rule1 = {
        name                                       = "AllowVnetInbound"
        description                                = "Allow VirtualNetwork inbound traffic"
        priority                                   = 100
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefix                      = "VirtualNetwork"
        destination_address_prefix                 = "VirtualNetwork"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
      rule2 = {
        name                                       = "AllowADFInbound"
        description                                = "Allow ADF ports inbound"
        priority                                   = 110
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        destination_port_range                     = "29876-29877"
        source_address_prefix                      = "*"
        destination_address_prefix                 = "VirtualNetwork"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
      rule3 = {
        name                                       = "AllowSQLInbound"
        description                                = "Allow SQL 1433 inbound"
        priority                                   = 120
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        destination_port_range                     = "1433"
        source_address_prefix                      = "VirtualNetwork"
        destination_address_prefix                 = "VirtualNetwork"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
      rule4 = {
        name                                       = "AllowVnetOutbound"
        description                                = "Allow VirtualNetwork outbound traffic"
        priority                                   = 100
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefix                      = "VirtualNetwork"
        destination_address_prefix                 = "VirtualNetwork"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
    }
    delegation = []
  }
  eaapp_subnet = {
    context           = "eaapp"
    address_prefix    = "100.69.10.0/26"
    routes            = {}
    service_endpoints = []
    security_rules = {
      rule1 = {
        name                                       = "AllowVnetInbound"
        description                                = "Allow VirtualNetwork inbound traffic"
        priority                                   = 100
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefix                      = "VirtualNetwork"
        destination_address_prefix                 = "VirtualNetwork"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
      rule2 = {
        name                                       = "AllowTibcoInbound"
        description                                = "Allow Tibco inbound traffic on port 7222"
        priority                                   = 110
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        destination_port_range                     = "7222"
        source_address_prefixes                    = ["10.51.10.111/32", "10.51.10.112/32"]
        destination_address_prefix                 = "VirtualNetwork"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
      rule3 = {
        name                                       = "AllowVnetOutbound"
        description                                = "Allow VirtualNetwork outbound traffic"
        priority                                   = 100
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefix                      = "VirtualNetwork"
        destination_address_prefix                 = "VirtualNetwork"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
      rule4 = {
        name                                       = "AllowTibcoOutbound"
        description                                = "Allow Tibco outbound traffic"
        priority                                   = 110
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefix                      = "VirtualNetwork"
        destination_address_prefixes               = ["10.51.10.111/32", "10.51.10.112/32"]
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
    }
    delegation = []
  }
  eaasp_subnet = {
    context           = "eaasp"
    address_prefix    = "100.69.10.128/27"
    routes            = {}
    service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.ServiceBus", "Microsoft.Web", "Microsoft.Sql", "Microsoft.EventHub"]
    security_rules = {
      rule1 = {
        name                                       = "AllowVnetInbound"
        description                                = "Allow VirtualNetwork inbound traffic"
        priority                                   = 100
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefix                      = "VirtualNetwork"
        destination_address_prefix                 = "VirtualNetwork"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
      rule2 = {
        name                                       = "AllowVnetOutbound"
        description                                = "Allow VirtualNetwork outbound traffic"
        priority                                   = 100
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefix                      = "VirtualNetwork"
        destination_address_prefix                 = "VirtualNetwork"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
    }
    delegation = [
      {
        delegation_name         = "delegation"
        service_delegation_name = "Microsoft.Web/serverFarms"
        actions = [
          "Microsoft.Network/virtualNetworks/subnets/action"
        ]
      }
    ]
  }
  eapec_subnet = {
    context           = "eapec"
    address_prefix    = "100.69.11.128/26"
    routes            = {}
    service_endpoints = []
    security_rules = {
      rule1 = {
        name                                       = "AllowVnetInbound"
        description                                = "Allow VirtualNetwork inbound traffic"
        priority                                   = 100
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefix                      = "VirtualNetwork"
        destination_address_prefix                 = "VirtualNetwork"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
      rule2 = {
        name                                       = "AllowVnetOutbound"
        description                                = "Allow VirtualNetwork outbound traffic"
        priority                                   = 100
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefix                      = "VirtualNetwork"
        destination_address_prefix                 = "VirtualNetwork"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
    }
    delegation = []
  }
}