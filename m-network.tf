module "subnet" {
  source  = "claranet/subnet/azurerm"
  version = "~> 8.1.0"

  count = var.gateway_enabled && var.subnet_cidrs != null ? 1 : 0

  environment    = var.environment
  location_short = var.location_short
  client_name    = var.client_name
  stack          = var.stack

  resource_group_name = var.resource_group_name

  custom_name = "GatewaySubnet"

  virtual_network_name = var.virtual_network_name
  cidrs                = var.subnet_cidrs

  default_outbound_access_enabled = var.subnet_default_outbound_access_enabled
}

moved {
  from = module.subnet_gateway[0]
  to   = module.subnet[0]
}
