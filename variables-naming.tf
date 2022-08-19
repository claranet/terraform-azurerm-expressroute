variable "name_prefix" {
  description = "Optional prefix for the generated name"
  type        = string
  default     = ""
}

variable "name_suffix" {
  description = "Optional suffix for the generated name"
  type        = string
  default     = ""
}

variable "use_caf_naming" {
  description = "Use the Azure CAF naming provider to generate default resource name. `custom_name` override this if set. Legacy default name is used if this is set to `false`."
  type        = bool
  default     = true
}

variable "custom_express_route_circuit_name" {
  description = "Custom ExpressRoute Circuit resource name"
  type        = string
  default     = null
}

variable "custom_virtual_network_gateway_name" {
  description = "Custom virtual network gateway resource name"
  type        = string
  default     = null
}

variable "custom_public_ip_name" {
  description = "Custom public IP resource name"
  type        = string
  default     = null
}

variable "custom_express_route_ipconfig_name" {
  description = "Custom ExpressRoute Gateway IP config name"
  type        = string
  default     = null
}

variable "custom_express_route_gateway_connection_name" {
  description = "Custom ExpressRoute Gateway connection resource name"
  type        = string
  default     = null
}
