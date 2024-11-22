data "azurecaf_name" "erc" {
  name          = var.stack
  resource_type = "azurerm_express_route_circuit"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix])
  use_slug      = true
  clean_input   = true
  separator     = "-"
}

data "azurecaf_name" "ergw" {
  name          = var.stack
  resource_type = "azurerm_virtual_network_gateway"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix])
  use_slug      = true
  clean_input   = true
  separator     = "-"
}

data "azurecaf_name" "pub_ip" {
  name          = var.stack
  resource_type = "azurerm_public_ip"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix])
  use_slug      = true
  clean_input   = true
  separator     = "-"
}

data "azurecaf_name" "ergw_ipconfig" {
  name          = var.stack
  resource_type = "azurerm_public_ip"
  prefixes      = compact(["ergwipconfig", local.name_prefix])
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix])
  use_slug      = false
  clean_input   = true
  separator     = "-"
}

data "azurecaf_name" "ergw_connection" {
  name          = var.stack
  resource_type = "azurerm_vpn_gateway_connection"
  prefixes      = compact(["ergwc", local.name_prefix])
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix])
  use_slug      = false
  clean_input   = true
  separator     = "-"
}
