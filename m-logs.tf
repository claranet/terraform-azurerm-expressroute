module "diagnostic_settings" {
  source  = "claranet/diagnostic-settings/azurerm"
  version = "~> 8.1.0"

  count = one(azurerm_express_route_circuit.main[*].id) != null || var.circuit_id != null ? 1 : 0

  resource_id           = coalesce(one(azurerm_express_route_circuit.main[*].id), var.circuit_id)
  logs_destinations_ids = var.logs_destinations_ids
  log_categories        = var.logs_categories
  metric_categories     = var.logs_metrics_categories

  custom_name = var.custom_diagnostic_settings_name
  name_prefix = var.name_prefix
  name_suffix = var.name_suffix
}

moved {
  from = module.diagnostic_settings
  to   = module.diagnostic_settings[0]
}
