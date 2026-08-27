# We are using "tst" as the environment value because "QA" is not allowed by the ResourceName module. ref- https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames/-/blob/main/variables.tf?ref_type=heads#L35
org_id         = "a1a"
app_id         = "52161"
location       = "eastus2"
environment    = "dev"
context        = "ecddb"
instance       = "01"
location_short = "eus2"

resource_group_name = "a1a-52161-dev-rg-estimates-eus2-01"
virtual_network_id  = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01"
tags = {
  mnd-applicationid      = "app-52161"
  mnd-applicationname    = "estimates_azure_dbor_dev"
  mnd-costcentre         = "52161"
  mnd-dataclassification = "restricted"
  mnd-envsubtype         = "test"
  mnd-lifecycle          = "live"
  mnd-owner              = "TF-TF-IndiaEstimatesTech@lseg.com"
  mnd-projectcode        = "P011085"
  mnd-supportgroup       = "DEVELOP-ESTIMATES-COLLECT-ICA"
}

routable_rules = {
  route1 = {
    route1 = {
      name                   = "a1a-52161-dev-route-estimates-eus2-01"
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.93.196.68"
    }
  }
  route2 = {
    route2 = {
      name                   = "a1a-52161-dev-route-estimates-eus2-02"
      address_prefix         = "10.0.0.0/8"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.93.196.68"
    }
  }
  route3 = {
    route3 = {
      name                   = "a1a-52161-dev-route-estimates-eus2-03"
      address_prefix         = "172.16.0.0/12"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.93.196.68"
    }
  }
}

subnets = {
  ecapp_subnet = {
    context           = "ecapp"
    address_prefix    = "100.72.1.0/25"
    routes            = {}
    service_endpoints = []
    security_rules = {
      rule1 = {
        name                                       = "Allow_Storage_account"
        description                                = ""
        priority                                   = 100
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "Tcp"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefixes                    = ["100.72.4.0/26"]
        destination_address_prefix                 = "VirtualNetwork"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
      rule2 = {
        name                                       = "AllowVnetInbound"
        description                                = "Allow traffic to Azure"
        priority                                   = 3000
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "Tcp"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefix                      = "VirtualNetwork"
        destination_address_prefix                 = "VirtualNetwork"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
      rule3 = {
        name                                       = "AllowAzureLoadBalanceraInbound"
        description                                = "Allow traffic to Azure"
        priority                                   = 3100
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
      rule4 = {
        name                                       = "AllowOnpremInbound"
        description                                = "Allow traffic to Azure"
        priority                                   = 3200
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefixes                    = ["167.68.0.0/16", "159.220.0.0/16", "162.8.0.0/16", "159.42.0.0/16", "172.16.0.0/12", "10.0.0.0/8", "163.231.0.0/16", "164.179.0.0/16"]
        destination_address_prefix                 = "VirtualNetwork"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
      rule5 = {
        name                                       = "AllowHTTPS"
        description                                = ""
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
      rule6 = {
        name                                       = "AllowVnetOutbound"
        description                                = "Allow traffic to Azure"
        priority                                   = 3000
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "Tcp"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefix                      = "VirtualNetwork"
        destination_address_prefix                 = "VirtualNetwork"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
      rule7 = {
        name                                       = "AllowOnpremOutbound"
        description                                = "Allow traffic to Azure"
        priority                                   = 3200
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefix                      = "VirtualNetwork"
        destination_address_prefixes               = ["167.68.0.0/16", "159.220.0.0/16", "162.8.0.0/16", "159.42.0.0/16", "172.16.0.0/12", "10.0.0.0/8", "163.231.0.0/16", "164.179.0.0/16"]
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
    }
    delegation = []
  }
  ecasp1_subnet = {
    context           = "ecasp1"
    address_prefix    = "100.72.2.0/27"
    routes            = {}
    service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.ServiceBus", "Microsoft.Web", "Microsoft.Sql", "Microsoft.EventHub"]
    security_rules = {
      rule1 = {
        name                                       = "AllowVnetInbound"
        description                                = "Allow traffic to Azure"
        priority                                   = 3000
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "Tcp"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefix                      = "VirtualNetwork"
        destination_address_prefix                 = "VirtualNetwork"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
      rule2 = {
        name                                       = "AllowAzureLoadBalanceraInbound"
        description                                = "Allow traffic to Azure"
        priority                                   = 3100
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "Tcp"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefix                      = "VirtualNetwork"
        destination_address_prefix                 = "VirtualNetwork"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
      rule3 = {
        name                                       = "AllowOnpremInbound"
        description                                = "Allow traffic to Azure"
        priority                                   = 3200
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefixes                    = ["167.68.0.0/16", "159.220.0.0/16", "162.8.0.0/16", "159.42.0.0/16", "172.16.0.0/12", "10.0.0.0/8", "163.231.0.0/16", "164.179.0.0/16"]
        destination_address_prefix                 = "VirtualNetwork"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
      rule4 = {
        name                                       = "AllowVnetOutbound"
        description                                = "Allow traffic to Azure"
        priority                                   = 3000
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
      rule5 = {
        name                                       = "AllowOnpremOutbound"
        description                                = "Allow traffic to Azure"
        priority                                   = 3200
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefix                      = "VirtualNetwork"
        destination_address_prefixes               = ["167.68.0.0/16", "159.220.0.0/16", "162.8.0.0/16", "159.42.0.0/16", "172.16.0.0/12", "10.0.0.0/8", "163.231.0.0/16", "164.179.0.0/16"]
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
    address_prefix    = "100.72.2.64/27"
    routes            = {}
    service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.ServiceBus", "Microsoft.Web", "Microsoft.Sql", "Microsoft.EventHub"]
    security_rules = {
      rule1 = {
        name                                       = "AllowVnetInbound"
        description                                = "Allow traffic to Azure"
        priority                                   = 3000
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "Tcp"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefix                      = "VirtualNetwork"
        destination_address_prefix                 = "VirtualNetwork"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
      rule2 = {
        name                                       = "AllowAzureLoadBalanceraInbound"
        description                                = "Allow traffic to Azure"
        priority                                   = 3100
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "Tcp"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefix                      = "VirtualNetwork"
        destination_address_prefix                 = "VirtualNetwork"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
      rule3 = {
        name                                       = "AllowOnpremInbound"
        description                                = "Allow traffic to Azure"
        priority                                   = 3200
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefixes                    = ["167.68.0.0/16", "159.220.0.0/16", "162.8.0.0/16", "159.42.0.0/16", "172.16.0.0/12", "10.0.0.0/8", "163.231.0.0/16", "164.179.0.0/16"]
        destination_address_prefix                 = "VirtualNetwork"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
      rule4 = {
        name                                       = "AllowVnetOutbound"
        description                                = "Allow traffic to Azure"
        priority                                   = 3000
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
      rule5 = {
        name                                       = "AllowOnpremOutbound"
        description                                = "Allow traffic to Azure"
        priority                                   = 3200
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefix                      = "VirtualNetwork"
        destination_address_prefixes               = ["167.68.0.0/16", "159.220.0.0/16", "162.8.0.0/16", "159.42.0.0/16", "172.16.0.0/12", "10.0.0.0/8", "163.231.0.0/16", "164.179.0.0/16"]
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
    address_prefix    = "100.72.4.0/26"
    routes            = {}
    service_endpoints = []
    security_rules = {
      rule1 = {
        name                                       = "AllowVnetInbound"
        description                                = "Allow traffic to Azure"
        priority                                   = 3000
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "Tcp"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefix                      = "VirtualNetwork"
        destination_address_prefix                 = "VirtualNetwork"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
      rule2 = {
        name                                       = "AllowAzureLoadBalanceraInbound"
        description                                = "Allow traffic to Azure"
        priority                                   = 3100
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
      rule3 = {
        name                                       = "AllowOnpremInbound"
        description                                = "Allow traffic to Azure"
        priority                                   = 3200
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefixes                    = ["167.68.0.0/16", "159.220.0.0/16", "162.8.0.0/16", "159.42.0.0/16", "172.16.0.0/12", "10.0.0.0/8", "163.231.0.0/16", "164.179.0.0/16"]
        destination_address_prefix                 = "VirtualNetwork"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
      rule4 = {
        name                                       = "AllowAnyCustom29876-29877Inbound"
        description                                = "Allow traffic to Azure"
        priority                                   = 3210
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
      rule5 = {
        name                                       = "AllowAnyCustom1433Inbound"
        description                                = "Allow traffic to Azure"
        priority                                   = 3220
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        destination_port_range                     = "1433"
        source_address_prefixes                    = ["100.72.4.0/26"]
        destination_address_prefix                 = "VirtualNetwork"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
      rule6 = {
        name                                       = "AllowVnetOutbound"
        description                                = "Allow traffic to Azure"
        priority                                   = 3000
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "Tcp"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefix                      = "VirtualNetwork"
        destination_address_prefix                 = "VirtualNetwork"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
      rule7 = {
        name                                       = "AllowOnpremOutbound"
        description                                = "Allow traffic to Azure"
        priority                                   = 3200
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefix                      = "VirtualNetwork"
        destination_address_prefixes               = ["167.68.0.0/16", "159.220.0.0/16", "162.8.0.0/16", "159.42.0.0/16", "172.16.0.0/12", "10.0.0.0/8", "163.231.0.0/16", "164.179.0.0/16"]
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
    }
    delegation = []
  }
  eaapp_subnet = {
    context           = "eaapp"
    address_prefix    = "100.72.10.0/26"
    routes            = {}
    service_endpoints = []
    security_rules = {
      rule1 = {
        name                                       = "AllowVnetInbound"
        description                                = "Allow traffic to Azure"
        priority                                   = 3000
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "Tcp"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefix                      = "VirtualNetwork"
        destination_address_prefix                 = "VirtualNetwork"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
      rule2 = {
        name                                       = "AllowAzureLoadBalanceraInbound"
        description                                = "Allow traffic to Azure"
        priority                                   = 3100
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
      rule3 = {
        name                                       = "AllowOnpremInbound"
        description                                = "Allow traffic to Azure"
        priority                                   = 3200
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefixes                    = ["167.68.0.0/16", "159.220.0.0/16", "162.8.0.0/16", "159.42.0.0/16", "172.16.0.0/12", "10.0.0.0/8", "163.231.0.0/16", "164.179.0.0/16"]
        destination_address_prefix                 = "VirtualNetwork"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
      rule4 = {
        name                                       = "AllowTibcoInbound"
        description                                = "Allow traffic to Azure"
        priority                                   = 3300
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
      rule5 = {
        name                                       = "AllowVnetOutbound"
        description                                = "Allow traffic to Azure"
        priority                                   = 3000
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "Tcp"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefix                      = "VirtualNetwork"
        destination_address_prefix                 = "VirtualNetwork"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
      rule6 = {
        name                                       = "AllowVnetOutbound"
        description                                = "Allow traffic to Azure"
        priority                                   = 3000
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "Tcp"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefix                      = "VirtualNetwork"
        destination_address_prefix                 = "VirtualNetwork"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
      rule7 = {
        name                                       = "AllowOnpremOutbound"
        description                                = "Allow traffic to Azure"
        priority                                   = 3200
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefix                      = "VirtualNetwork"
        destination_address_prefixes               = ["167.68.0.0/16", "159.220.0.0/16", "162.8.0.0/16", "159.42.0.0/16", "172.16.0.0/12", "10.0.0.0/8", "163.231.0.0/16", "164.179.0.0/16"]
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
      rule8 = {
        name                                       = "AllowTibcoOutbound"
        description                                = "Allow traffic to Azure"
        priority                                   = 3300
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
    address_prefix    = "100.72.10.128/27"
    routes            = {}
    service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.ServiceBus", "Microsoft.Web", "Microsoft.Sql", "Microsoft.EventHub"]
    security_rules = {
      rule1 = {
        name                                       = "AllowVnetInbound"
        description                                = "Allow traffic to Azure"
        priority                                   = 3000
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "Tcp"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefix                      = "VirtualNetwork"
        destination_address_prefix                 = "VirtualNetwork"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
      rule2 = {
        name                                       = "AllowAzureLoadBalanceraInbound"
        description                                = "Allow traffic to Azure"
        priority                                   = 3100
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
      rule3 = {
        name                                       = "AllowOnpremInbound"
        description                                = "Allow traffic to Azure"
        priority                                   = 3200
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefixes                    = ["167.68.0.0/16", "159.220.0.0/16", "162.8.0.0/16", "159.42.0.0/16", "172.16.0.0/12", "10.0.0.0/8", "163.231.0.0/16", "164.179.0.0/16"]
        destination_address_prefix                 = "VirtualNetwork"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
      rule4 = {
        name                                       = "AllowVnetOutbound"
        description                                = "Allow traffic to Azure"
        priority                                   = 3000
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "Tcp"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefix                      = "VirtualNetwork"
        destination_address_prefix                 = "VirtualNetwork"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
      rule5 = {
        name                                       = "AllowOnpremOutbound"
        description                                = "Allow traffic to Azure"
        priority                                   = 3200
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefix                      = "VirtualNetwork"
        destination_address_prefixes               = ["167.68.0.0/16", "159.220.0.0/16", "162.8.0.0/16", "159.42.0.0/16", "172.16.0.0/12", "10.0.0.0/8", "163.231.0.0/16", "164.179.0.0/16"]
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
    address_prefix    = "100.72.11.128/26"
    routes            = {}
    service_endpoints = []
    security_rules = {
      rule1 = {
        name                                       = "AllowVnetInbound"
        description                                = "Allow traffic to Azure"
        priority                                   = 3000
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "Tcp"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefix                      = "VirtualNetwork"
        destination_address_prefix                 = "VirtualNetwork"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
      rule2 = {
        name                                       = "AllowAzureLoadBalanceraInbound"
        description                                = "Allow traffic to Azure"
        priority                                   = 3100
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
      rule3 = {
        name                                       = "AllowOnpremInbound"
        description                                = "Allow traffic to Azure"
        priority                                   = 3200
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefixes                    = ["167.68.0.0/16", "159.220.0.0/16", "162.8.0.0/16", "159.42.0.0/16", "172.16.0.0/12", "10.0.0.0/8", "163.231.0.0/16", "164.179.0.0/16"]
        destination_address_prefix                 = "VirtualNetwork"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
      rule4 = {
        name                                       = "AllowVnetOutbound"
        description                                = "Allow traffic to Azure"
        priority                                   = 3000
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "Tcp"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefix                      = "VirtualNetwork"
        destination_address_prefix                 = "VirtualNetwork"
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
      rule5 = {
        name                                       = "AllowOnpremOutbound"
        description                                = "Allow traffic to Azure"
        priority                                   = 3200
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        destination_port_range                     = "*"
        source_address_prefix                      = "VirtualNetwork"
        destination_address_prefixes               = ["167.68.0.0/16", "159.220.0.0/16", "162.8.0.0/16", "159.42.0.0/16", "172.16.0.0/12", "10.0.0.0/8", "163.231.0.0/16", "164.179.0.0/16"]
        source_application_security_group_ids      = []
        destination_application_security_group_ids = []
      }
    }
    delegation = []
  }
}