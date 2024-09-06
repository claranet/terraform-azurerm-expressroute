output "express_route_circuit_id" {
  description = "The ID of the ExpressRoute circuit"
  value       = one(azurerm_express_route_circuit.erc[*].id)
}

output "express_route_circuit_name" {
  description = "Name of the ExpressRoute circuit"
  value       = one(azurerm_express_route_circuit.erc[*].name)
}

output "express_route_circuit_service_provider_provisioning_state" {
  description = "The ExpressRoute circuit provisioning state from your chosen service provider"
  value       = one(azurerm_express_route_circuit.erc[*].service_provider_provisioning_state)
}

output "express_route_circuit_service_key" {
  description = "The string needed by the service provider to provision the ExpressRoute circuit"
  value       = one(azurerm_express_route_circuit.erc[*].service_key)
  sensitive   = true
}

output "express_route_peering_azure_asn" {
  description = "ASN (Autonomous System Number) Used by Azure for BGP Peering"
  value       = try({ for k, v in azurerm_express_route_circuit_peering.ercp : k => v.azure_asn }, null)
}

output "subnet_gateway_id" {
  description = "ID of the Gateway Subnet"
  value       = one(module.subnet_gateway[*].subnet_id)
}

output "express_route_gateway_id" {
  description = "ID of the ExpressRoute Gateway"
  value       = one(azurerm_virtual_network_gateway.ergw[*].id)
}
