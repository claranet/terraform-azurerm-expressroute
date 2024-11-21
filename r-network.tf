module "subnet_gateway" {
  source  = "claranet/subnet/azurerm"
  version = "7.2.0"

  count = var.express_route_gateway_enabled && var.subnet_gateway_cidr != null ? 1 : 0

  environment    = var.environment
  location_short = var.location_short
  client_name    = var.client_name
  stack          = var.stack

  resource_group_name = var.resource_group_name

  custom_subnet_name = "GatewaySubnet"
  use_caf_naming     = false

  virtual_network_name = var.virtual_network_name
  subnet_cidr_list     = var.subnet_gateway_cidr

  default_outbound_access_enabled = var.subnet_gateway_default_outbound_access_enabled
}

moved {
  from = module.subnet_gateway["subnet_gateway"]
  to   = module.subnet_gateway[0]
}

resource "azurerm_virtual_network_gateway" "ergw" {
  count = var.express_route_gateway_enabled ? 1 : 0

  name = local.vgw_name

  location            = var.location
  resource_group_name = var.resource_group_name

  type          = "ExpressRoute"
  active_active = var.express_route_gateway_sku != "Standard" ? var.active_active_enabled : false
  sku           = var.express_route_gateway_sku

  remote_vnet_traffic_enabled = var.express_route_gateway_remote_vnet_traffic_enabled
  virtual_wan_traffic_enabled = var.express_route_gateway_virtual_wan_traffic_enabled

  dynamic "ip_configuration" {
    for_each = range(1, local.public_ip_number + 1)

    content {
      name                 = format("%s%s", local.express_route_gateway_ipconfig_name, local.public_ip_number > 1 ? "-0${ip_configuration.value}" : "")
      public_ip_address_id = azurerm_public_ip.public_ip[ip_configuration.value - 1].id
      subnet_id            = var.subnet_gateway_cidr != null ? module.subnet_gateway[0].subnet_id : var.subnet_gateway_id
    }
  }
  tags = merge(local.default_tags, var.extra_tags, var.express_route_gateway_extra_tags)

}
moved {
  from = azurerm_virtual_network_gateway.ergw["ergw"]
  to   = azurerm_virtual_network_gateway.ergw[0]
}

resource "azurerm_public_ip" "public_ip" {
  count = var.express_route_gateway_enabled ? local.public_ip_number : 0

  name                = format("%s%s", local.pub_ip_name, local.public_ip_number > 1 ? "-0${count.index + 1}" : "")
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.public_ip_sku
  zones               = var.public_ip_sku == "Standard" ? var.public_ip_zones : null

  tags = merge(local.default_tags, var.extra_tags, var.public_ip_extra_tags)
}

resource "azurerm_virtual_network_gateway_connection" "er_gateway_connection" {
  count = var.express_route_gateway_enabled && var.express_route_circuit_connected ? 1 : 0

  name = local.express_route_gateway_connection_name

  location            = var.location
  resource_group_name = var.resource_group_name

  type                           = "ExpressRoute"
  express_route_circuit_id       = var.express_route_circuit_enabled ? azurerm_express_route_circuit.erc[0].id : var.express_route_circuit_id
  authorization_key              = var.express_route_circuit_authorization_key
  virtual_network_gateway_id     = azurerm_virtual_network_gateway.ergw[0].id
  local_azure_ip_address_enabled = false
  routing_weight                 = var.express_route_gateway_connection_route_weight

  tags = merge(local.default_tags, var.extra_tags, var.express_route_gateway_connection_extra_tags)
  lifecycle {
    precondition {
      condition     = (var.express_route_circuit_enabled && var.express_route_circuit_id == null) || (!var.express_route_circuit_enabled && var.express_route_circuit_id != null)
      error_message = "Either `express_route_circuit_enabled` or `express_route_circuit_id` must be set."
    }
  }
}

moved {
  from = azurerm_virtual_network_gateway_connection.er_gateway_connection["ergwc"]
  to   = azurerm_virtual_network_gateway_connection.er_gateway_connection[0]
}
