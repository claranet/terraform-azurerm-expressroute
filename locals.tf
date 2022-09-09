locals {
  public_ip_number = var.express_route_gateway_sku != "Standard" && var.active_active_enabled ? ["1", "2"] : ["1"]
}
