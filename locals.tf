locals {
  public_ip_count = var.gateway_sku != "Standard" && var.active_active_enabled ? 2 : 1
}
