variable "default_tags_enabled" {
  description = "Option to enable or disable default tags."
  type        = bool
  default     = true
}

variable "extra_tags" {
  description = "Extra tags to add."
  type        = map(string)
  default     = {}
}

variable "express_route_circuit_extra_tags" {
  description = "Extra tags to add for ExpressRoute Circuit resource."
  type        = map(string)
  default     = {}
}

variable "express_route_gateway_extra_tags" {
  description = "Extra tags to add for Virtual Network Gateway resource."
  type        = map(string)
  default     = {}
}

variable "public_ip_extra_tags" {
  description = "Extra tags to add for public IP resource."
  type        = map(string)
  default     = {}
}

variable "express_route_gateway_connection_extra_tags" {
  description = "Extra tags to add for ExpressRoute Gateway connection resource."
  type        = map(string)
  default     = {}
}
