locals {
  # Naming locals/constants
  name_prefix = lower(var.name_prefix)
  name_suffix = lower(var.name_suffix)

  erc_name                              = coalesce(var.custom_express_route_circuit_name, azurecaf_name.erc.result)
  vgw_name                              = coalesce(var.custom_virtual_network_gateway_name, azurecaf_name.vgw.result)
  pub_ip_name                           = coalesce(var.custom_public_ip_name, azurecaf_name.pub_ip.result)
  express_route_gateway_ipconfig_name   = coalesce(var.custom_express_route_ipconfig_name, "expressrouteGatewayIPConfig")
  express_route_gateway_connection_name = coalesce(var.custom_express_route_gateway_connection_name, format("%s-%s-%s-%s-%s", "ergwc", var.stack, var.client_name, var.location_short, var.environment))
}
