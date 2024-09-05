output "express_route_circuit_id" {
  description = "The ID of the ExpressRoute circuit"
  value       = try(azurerm_express_route_circuit.erc["erc"].id, null)
}

output "express_route_circuit_name" {
  description = "Name of the ExpressRoute circuit"
  value       = try(azurerm_express_route_circuit.erc["erc"].name, null)
}

output "express_route_circuit_service_provider_provisioning_state" {
  description = "The ExpressRoute circuit provisioning state from your chosen service provider"
  value       = try(azurerm_express_route_circuit.erc["erc"].service_provider_provisioning_state, null)
}

output "express_route_circuit_service_key" {
  description = "The string needed by the service provider to provision the ExpressRoute circuit"
  value       = try(azurerm_express_route_circuit.erc["erc"].service_key, null)
  sensitive   = true
}

output "express_route_peering_azure_asn" {
  description = "ASN (Autonomous System Number) Used by Azure for BGP Peering"
  value       = try({ for k, v in azurerm_express_route_circuit_peering.ercp : k => v.azure_asn }, null)
}

output "subnet_gateway_id" {
  description = "ID of the Gateway Subnet ID"
  value       = try(module.subnet_gateway["subnet_gateway"].id, null)
}

output "express_route_gateway_id" {
  description = "ID of the ExpressRoute Gateway"
  value       = try(azurerm_virtual_network_gateway.ergw["ergw"].id, null)
}
