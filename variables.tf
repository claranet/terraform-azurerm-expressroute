variable "client_name" {
  description = "Name of client."
  type        = string
}

variable "environment" {
  description = "Name of application's environment."
  type        = string
}

variable "stack" {
  description = "Name of application's stack."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the application's resource group."
  type        = string
}

variable "location" {
  description = "Azure location."
  type        = string
}

variable "location_short" {
  description = "Short string for Azure location."
  type        = string
}

variable "service_provider_name" {
  description = "The name of the ExpressRoute [Service Provider](https://docs.microsoft.com/en-us/azure/expressroute/expressroute-locations-providers#partners)."
  type        = string
}

variable "peering_location" {
  description = "The name of the peering [location](https://docs.microsoft.com/en-us/azure/expressroute/expressroute-locations#locations)."
  type        = string
}

variable "bandwidth_in_mbps" {
  description = "The bandwidth in Mbps of the circuit."
  type        = number
}

variable "express_route_sku" {
  description = "ExpressRoute SKU. Possible values are [here](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/express_route_circuit#sku)."
  type = object({
    tier   = string,
    family = string
  })
  default = {
    tier   = "Standard"
    family = "MeteredData"
  }
}

variable "virtual_network_name" {
  description = "Virtual network name."
  type        = string
}

variable "subnet_gateway_cidr" {
  description = "The address prefix list to use for the subnet."
  type        = list(string)
  default     = null
}

variable "subnet_gateway_default_outbound_access_enabled" {
  description = "Whether to allow default outbound traffic from the subnet."
  type        = bool
  default     = false
}

variable "subnet_gateway_id" {
  description = "ID of an existing subnet gateway."
  type        = string
  default     = null
}

variable "public_ip_sku" {
  description = "SKU of public IP resource. Possible values are `Basic` or `Standard`."
  type        = string
  default     = "Standard"
}

variable "public_ip_allocation_method" {
  description = "Defines the allocation method for this IP address. Possible values are `Static` or `Dynamic`."
  type        = string
  default     = "Static"
}

variable "public_ip_zones" {
  description = "List of availability zone for the public IP resource."
  type        = list(number)
  default     = [1, 2, 3]
}

variable "active_active_enabled" {
  description = "Enable or disable an active-active Virtual Network Gateway. (Require a `HighPerformance` or an ` UltraPerformance` SKU.)"
  type        = bool
  default     = false
}

variable "express_route_gateway_sku" {
  description = "SKU of the virtual network gateway resource. Possible values are [here](https://docs.microsoft.com/en-us/azure/expressroute/expressroute-about-virtual-network-gateways#gwsku)."
  type        = string
  default     = "Standard"
}

variable "express_route_circuit_peerings" {
  description = "Configuration block of Private, Public and Microsoft ExpressRoute Circuit Peerings."
  type = list(object({
    peering_type                  = string
    primary_peer_address_prefix   = string
    secondary_peer_address_prefix = string
    peer_asn                      = number
    vlan_id                       = number
    shared_key                    = optional(string)
    microsoft_peering_config = optional(object({
      advertised_public_prefixes = list(string)
      customer_asn               = optional(number)
      routing_registry_name      = optional(string)
    }))
  }))
}

variable "express_route_circuit_peering_enabled" {
  description = "Enable or disable Express Route Circuit Peering configuration. (Should be disable at start. When the ExpressRoute circuit status is 'Provisioned', enable it.)"
  type        = bool
}

variable "express_route_gateway_enabled" {
  description = "Enable or disable creation of the Virtual Network Gateway."
  type        = bool
  default     = true
}

variable "express_route_gateway_connection_route_weight" {
  description = "The routing weight of the ExpressRoute Gateway connection."
  type        = number
  default     = 10
}

variable "express_route_circuit_enabled" {
  description = "Whether to create the ExpressRoute Circuit or not."
  type        = bool
  default     = true
}

variable "express_route_circuit_id" {
  description = "ExpressRoute Circuit ID if not managed by this module."
  type        = string
  default     = null
}

variable "express_route_circuit_connected" {
  description = "Whether the ExpressRoute Circuit is connected or not."
  type        = bool
  default     = true
}

variable "express_route_circuit_authorization_key" {
  description = "The authorization key to use for the ExpressRoute Circuit."
  type        = string
  sensitive   = true
  default     = null
}

variable "express_route_gateway_remote_vnet_traffic_enabled" {
  description = "Whether to allow remote VNet traffic to flow through the ExpressRoute Gateway."
  type        = bool
  default     = false
}

variable "express_route_gateway_virtual_wan_traffic_enabled" {
  description = "Whether to allow Virtual WAN traffic to flow through the ExpressRoute Gateway."
  type        = bool
  default     = false
}
