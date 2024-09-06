resource "azurerm_express_route_circuit" "erc" {
  count = var.express_route_circuit_enabled ? 1 : 0
  name  = local.erc_name

  resource_group_name = var.resource_group_name
  location            = var.location

  service_provider_name = var.service_provider_name
  peering_location      = var.peering_location
  bandwidth_in_mbps     = var.bandwidth_in_mbps

  sku {
    tier   = var.express_route_sku.tier
    family = var.express_route_sku.family
  }

  tags = merge(local.default_tags, var.extra_tags, var.express_route_circuit_extra_tags)
}

moved {
  from = azurerm_express_route_circuit.erc
  to   = azurerm_express_route_circuit.erc[0]
}

resource "azurerm_express_route_circuit_peering" "ercp" {
  for_each = var.express_route_circuit_peering_enabled ? { for peering in var.express_route_circuit_peerings : peering.peering_type => peering } : {}

  express_route_circuit_name = one(azurerm_express_route_circuit.erc[*].name)
  resource_group_name        = var.resource_group_name

  peering_type                  = each.value.peering_type
  primary_peer_address_prefix   = each.value.primary_peer_address_prefix
  secondary_peer_address_prefix = each.value.secondary_peer_address_prefix
  peer_asn                      = each.value.peer_asn
  vlan_id                       = each.value.vlan_id
  shared_key                    = lookup(each.value, "shared_key", null)

  route_filter_id = each.value.peering_type == "MicrosoftPeering" ? lookup(each.value, "route_filter_id", null) : null

  dynamic "microsoft_peering_config" {
    for_each = each.value.peering_type == "MicrosoftPeering" && each.value.microsoft_peering_config != null ? [each.value.microsoft_peering_config] : []

    content {
      advertised_public_prefixes = lookup(microsoft_peering_config.value, "advertised_public_prefixes", null)
      customer_asn               = lookup(microsoft_peering_config.value, "customer_asn", null)
      routing_registry_name      = lookup(microsoft_peering_config.value, "routing_registry_name", null)
    }
  }
}
