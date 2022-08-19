module "subnet_gateway" {
  source  = "claranet/subnet/azurerm"
  version = "5.0.0"

  for_each = toset(var.express_route_gateway_enabled && var.subnet_gateway_cidr != null ? ["subnet_gateway"] : [])

  environment    = var.environment
  location_short = var.location_short
  client_name    = var.client_name
  stack          = var.stack

  resource_group_name = var.resource_group_name

  custom_subnet_name = "GatewaySubnet"
  use_caf_naming     = false

  virtual_network_name = var.virtual_network_name
  subnet_cidr_list     = var.subnet_gateway_cidr
}

resource "azurerm_virtual_network_gateway" "er_gateway" {
  for_each = toset(var.express_route_gateway_enabled ? ["vgw"] : [])

  name = local.vgw_name

  location            = var.location
  resource_group_name = var.resource_group_name

  type          = "ExpressRoute"
  active_active = var.express_route_gateway_sku != "Standard" ? var.active_active_enabled : false
  sku           = var.express_route_gateway_sku

  dynamic "ip_configuration" {
    for_each = var.express_route_gateway_sku != "Standard" && var.active_active_enabled ? ["1", "2"] : ["1"]

    content {
      name                 = "${local.express_route_gateway_ipconfig_name}-0${ip_configuration.value}"
      public_ip_address_id = azurerm_public_ip.public_ip[ip_configuration.value].id
      subnet_id            = var.subnet_gateway_cidr != null ? module.subnet_gateway["subnet_gateway"].subnet_id : var.subnet_gateway_id
    }
  }
  tags = merge(local.default_tags, var.extra_tags, var.express_route_gateway_extra_tags)
}

resource "azurerm_public_ip" "public_ip" {
  for_each = toset(var.express_route_gateway_enabled ? local.public_ip_number : [])

  name                = "${local.pub_ip_name}-0${each.value}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.public_ip_sku
  zones               = var.public_ip_sku == "Standard" ? var.public_ip_zones : null

  tags = merge(local.default_tags, var.extra_tags, var.public_ip_extra_tags)
}

resource "azurerm_virtual_network_gateway_connection" "er_gateway_connection" {
  for_each = toset(var.express_route_gateway_enabled ? ["ergwc"] : [])

  name = local.express_route_gateway_connection_name

  location            = var.location
  resource_group_name = var.resource_group_name

  type                           = "ExpressRoute"
  express_route_circuit_id       = azurerm_express_route_circuit.erc.id
  virtual_network_gateway_id     = azurerm_virtual_network_gateway.er_gateway["vgw"].id
  local_azure_ip_address_enabled = false
  routing_weight                 = var.express_route_gateway_connection_route_weight

  tags = merge(local.default_tags, var.extra_tags, var.express_route_gateway_connection_extra_tags)
}
