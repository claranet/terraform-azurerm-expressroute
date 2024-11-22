locals {
  # Naming locals/constants
  name_prefix = lower(var.name_prefix)
  name_suffix = lower(var.name_suffix)

  circuit_name    = coalesce(var.circuit_custom_name, data.azurecaf_name.erc.result)
  gateway_name    = coalesce(var.gateway_custom_name, data.azurecaf_name.ergw.result)
  pub_ip_name     = coalesce(var.public_ip_custom_name, data.azurecaf_name.pub_ip.result)
  ipconfig_name   = coalesce(var.gateway_ipconfig_custom_name, data.azurecaf_name.ergw_ipconfig.result)
  connection_name = coalesce(var.connection_custom_name, data.azurecaf_name.ergw_connection.result)
}
