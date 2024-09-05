module "express_route_circuit_diagnostic_settings" {
  source  = "claranet/diagnostic-settings/azurerm"
  version = "~> 6.5.0"

  resource_id           = var.express_route_circuit_enabled ? azurerm_express_route_circuit.erc[0].id : var.express_route_circuit_id
  logs_destinations_ids = var.logs_destinations_ids
  log_categories        = var.logs_categories
  metric_categories     = var.logs_metrics_categories

  custom_name = var.custom_diagnostic_settings_name
  name_prefix = var.name_prefix
  name_suffix = var.name_suffix
}
