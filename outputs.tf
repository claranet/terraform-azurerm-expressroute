output "circuit_id" {
  description = "The ID of the ExpressRoute Circuit."
  value       = one(azurerm_express_route_circuit.main[*].id)
}

output "circuit_name" {
  description = "Name of the ExpressRoute Circuit."
  value       = one(azurerm_express_route_circuit.main[*].name)
}

output "circuit_service_provider_provisioning_state" {
  description = "The ExpressRoute Circuit provisioning state from your chosen service provider."
  value       = one(azurerm_express_route_circuit.main[*].service_provider_provisioning_state)
}

output "circuit_service_key" {
  description = "The string needed by the service provider to provision the ExpressRoute Circuit."
  value       = one(azurerm_express_route_circuit.main[*].service_key)
  sensitive   = true
}

output "peering_azure_asn" {
  description = "ASN (Autonomous System Number) used by Azure for BGP Peering."
  value       = try({ for k, v in azurerm_express_route_circuit_peering.main : k => v.azure_asn }, null)
}

output "subnet_id" {
  description = "ID of the Gateway Subnet."
  value       = one(module.subnet[*].id)
}

output "gateway_id" {
  description = "ID of the ExpressRoute Gateway."
  value       = one(azurerm_virtual_network_gateway.main[*].id)
}

output "resource" {
  description = "ExpressRoute Gateway resource object."
  value       = azurerm_virtual_network_gateway.main[*]
}

output "resource_circuit" {
  description = "ExpressRoute Circuit resource object."
  value       = azurerm_express_route_circuit.main[*]
}

output "resource_circuit_peering" {
  description = "ExpressRoute Circuit Peering resource object."
  value       = azurerm_express_route_circuit_peering.main[*]
}

output "resource_public_ip" {
  description = "Public IP resource object."
  value       = azurerm_public_ip.main[*]
}

output "resource_gateway_connection" {
  description = "ExpressRoute Gateway Connection resource object."
  value       = azurerm_virtual_network_gateway_connection.main[*]
}

output "module_subnet" {
  description = "Subnet module output."
  value       = module.subnet
}

output "module_diagnostic_settings" {
  description = "Diagnostic settings module output."
  value       = module.diagnostic_settings
}
