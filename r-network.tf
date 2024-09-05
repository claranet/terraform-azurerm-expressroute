module "subnet_gateway" {
  source  = "claranet/subnet/azurerm"
  version = "7.0.0"

  for_each = toset(var.express_route_gateway_enabled && var.subnet_gateway_cidr != null ? ["subnet_gateway"] : [])

  environment    = var.environment
  location_short = var.location_short
  client_name    = var.client_name
  stack          = var.stack

  resource_group_name = var.virtual_network_resource_group_name != null ? var.virtual_network_resource_group_name : var.resource_group_name

  custom_subnet_name = "GatewaySubnet"
  use_caf_naming     = false

  virtual_network_name = var.virtual_network_name
  subnet_cidr_list     = var.subnet_gateway_cidr
}

resource "azurerm_virtual_network_gateway" "ergw" {
  for_each = toset(var.express_route_gateway_enabled ? ["ergw"] : [])

  name = local.vgw_name

  location            = var.location
  resource_group_name = var.resource_group_name

  type          = "ExpressRoute"
  active_active = var.express_route_gateway_sku != "Standard" ? var.active_active_enabled : false
  sku           = var.express_route_gateway_sku

  dynamic "ip_configuration" {
    for_each = local.public_ip_number

    content {
      name                 = format("%s%s", local.express_route_gateway_ipconfig_name, length(local.public_ip_number) > 1 ? "-0${ip_configuration.value}" : "")
      public_ip_address_id = azurerm_public_ip.public_ip[ip_configuration.value].id
      subnet_id            = var.subnet_gateway_cidr != null ? module.subnet_gateway["subnet_gateway"].subnet_id : var.subnet_gateway_id
    }
  }
  tags = merge(local.default_tags, var.extra_tags, var.express_route_gateway_extra_tags)
}

resource "azurerm_public_ip" "public_ip" {
  for_each = toset(var.express_route_gateway_enabled ? local.public_ip_number : [])

  name                = format("%s%s", local.pub_ip_name, length(local.public_ip_number) > 1 ? "-0${each.value}" : "")
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.public_ip_sku
  zones               = var.public_ip_sku == "Standard" ? var.public_ip_zones : null

  tags = merge(local.default_tags, var.extra_tags, var.public_ip_extra_tags)
}

resource "azurerm_virtual_network_gateway_connection" "er_gateway_connection" {
  for_each = toset(var.express_route_gateway_enabled && var.express_route_circuit_connected ? ["ergwc"] : [])

  name = local.express_route_gateway_connection_name

  location            = var.location
  resource_group_name = var.resource_group_name

  type                           = "ExpressRoute"
  express_route_circuit_id       = var.express_route_circuit_enabled ? azurerm_express_route_circuit.erc["erc"].id : var.express_route_circuit_id
  authorization_key              = var.express_route_circuit_authorization_key
  virtual_network_gateway_id     = azurerm_virtual_network_gateway.ergw["ergw"].id
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
