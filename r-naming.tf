resource "azurecaf_name" "erc" {
  name          = var.stack
  resource_type = "azurerm_express_route_circuit"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix, var.use_caf_naming ? "" : "erc"])
  use_slug      = var.use_caf_naming
  clean_input   = true
  separator     = "-"
}

resource "azurecaf_name" "vgw" {
  name          = var.stack
  resource_type = "azurerm_virtual_network_gateway"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix, var.use_caf_naming ? "" : "vgw"])
  use_slug      = var.use_caf_naming
  clean_input   = true
  separator     = "-"
}

resource "azurecaf_name" "pub_ip" {
  name          = var.stack
  resource_type = "azurerm_public_ip"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix, var.use_caf_naming ? "" : "pubip"])
  use_slug      = var.use_caf_naming
  clean_input   = true
  separator     = "-"
}
