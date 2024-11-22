
module "express_route" {
  source  = "claranet/expressroute/azurerm"
  version = "x.x.x"

  environment    = var.environment
  location       = module.azure_region.location
  location_short = module.azure_region.location_short
  client_name    = var.client_name
  stack          = var.stack

  resource_group_name = module.rg.name

  logs_destinations_ids = [
    module.logs.id
  ]

  service_provider_name = "Equinix"
  peering_location      = "London"
  bandwidth_in_mbps     = 50

  virtual_network_name = module.azure_virtual_network.name
  subnet_cidr          = ["10.10.0.0/27"]

  # Enable when the ExpressRoute Circuit status is provisioned
  circuit_peering_enabled = false
  circuit_peerings = [
    {
      peering_type                  = "AzurePrivatePeering"
      primary_peer_address_prefix   = "169.254.0.0/30"
      secondary_peer_address_prefix = "169.254.0.4/30"
      peer_asn                      = 25419
      vlan_id                       = 100
    }
  ]
}
