module "azure_region" {
  source  = "claranet/regions/azurerm"
  version = "x.x.x"

  azure_region = var.azure_region
}

module "rg" {
  source  = "claranet/rg/azurerm"
  version = "x.x.x"

  location    = module.azure_region.location
  client_name = var.client_name
  environment = var.environment
  stack       = var.stack
}

module "logs" {
  source  = "claranet/run-common/azurerm//modules/logs"
  version = "x.x.x"

  client_name    = var.client_name
  location       = module.azure_region.location
  location_short = module.azure_region.location_short
  environment    = var.environment
  stack          = var.stack

  resource_group_name = module.rg.resource_group_name
}

module "azure_virtual_network" {
  source  = "claranet/vnet/azurerm"
  version = "x.x.x"

  environment    = var.environment
  location       = module.azure_region.location
  location_short = module.azure_region.location_short
  client_name    = var.client_name
  stack          = var.stack

  resource_group_name = module.rg.resource_group_name

  vnet_cidr = ["10.10.0.0/16"]
}

module "express_route" {
  source  = "claranet/expressroute/azurerm"
  version = "x.x.x"

  environment    = var.environment
  location       = module.azure_region.location
  location_short = module.azure_region.location_short
  client_name    = var.client_name
  stack          = var.stack

  resource_group_name = module.rg.resource_group_name

  logs_destinations_ids = [
    module.logs.log_analytics_workspace_id
  ]

  service_provider_name = "Equinix"
  peering_location      = "London"
  bandwidth_in_mbps     = 50

  virtual_network_name = module.azure_virtual_network.virtual_network_name
  subnet_gateway_cidr  = ["10.10.0.0/27"]

  # Enable when the ExpressRoute Circuit status is provisioned
  express_route_circuit_peering_enabled = false
  express_route_circuit_peerings = [
    {
      peering_type                  = "AzurePrivatePeering"
      primary_peer_address_prefix   = "169.254.00.0/30"
      secondary_peer_address_prefix = "169.254.00.4/30"
      peer_asn                      = 25419
      vlan_id                       = 100
    }
  ]
}
