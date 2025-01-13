resource "azurerm_virtual_network_gateway" "main" {
  count = var.gateway_enabled ? 1 : 0

  name = local.gateway_name

  location            = var.location
  resource_group_name = var.resource_group_name

  type          = "ExpressRoute"
  active_active = var.gateway_sku != "Standard" ? var.active_active_enabled : false
  sku           = var.gateway_sku

  remote_vnet_traffic_enabled = var.remote_vnet_traffic_enabled
  virtual_wan_traffic_enabled = var.virtual_wan_traffic_enabled

  dynamic "ip_configuration" {
    for_each = range(1, local.public_ip_count + 1)

    content {
      name                 = format("%s%s", local.ipconfig_name, local.public_ip_count > 1 ? "-0${ip_configuration.value}" : "")
      public_ip_address_id = azurerm_public_ip.main[ip_configuration.value - 1].id
      subnet_id            = coalesce(one(module.subnet[*].id), var.subnet_id)
    }
  }
  tags = merge(local.default_tags, var.extra_tags, var.gateway_extra_tags)

}

moved {
  from = azurerm_virtual_network_gateway.ergw[0]
  to   = azurerm_virtual_network_gateway.main[0]
}

resource "azurerm_public_ip" "main" {
  count = var.gateway_enabled ? local.public_ip_count : 0

  name                = format("%s%s", local.pub_ip_name, local.public_ip_count > 1 ? "-0${count.index + 1}" : "")
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.public_ip_sku
  zones               = var.public_ip_sku == "Standard" ? var.public_ip_zones : null

  tags = merge(local.default_tags, var.extra_tags, var.public_ip_extra_tags)
}

moved {
  from = azurerm_public_ip.public_ip[0]
  to   = azurerm_public_ip.main[0]
}

resource "azurerm_virtual_network_gateway_connection" "main" {
  count = var.gateway_enabled && var.circuit_connected ? 1 : 0

  name = local.connection_name

  location            = var.location
  resource_group_name = var.resource_group_name

  type                           = "ExpressRoute"
  express_route_circuit_id       = coalesce(one(azurerm_express_route_circuit.main[*].id), var.circuit_id)
  authorization_key              = var.circuit_authorization_key
  virtual_network_gateway_id     = one(azurerm_virtual_network_gateway.main[*].id)
  local_azure_ip_address_enabled = false
  routing_weight                 = var.connection_route_weight

  tags = merge(local.default_tags, var.extra_tags, var.connection_extra_tags)
  lifecycle {
    precondition {
      condition     = (var.circuit_enabled && var.circuit_id == null) || (!var.circuit_enabled && var.circuit_id != null)
      error_message = "Either `express_route_circuit_enabled` or `express_route_circuit_id` must be set."
    }
  }
}

moved {
  from = azurerm_virtual_network_gateway_connection.er_gateway_connection[0]
  to   = azurerm_virtual_network_gateway_connection.main[0]
}
