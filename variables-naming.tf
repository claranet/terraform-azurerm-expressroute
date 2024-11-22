variable "name_prefix" {
  description = "Optional prefix for the generated name."
  type        = string
  default     = ""
}

variable "name_suffix" {
  description = "Optional suffix for the generated name."
  type        = string
  default     = ""
}

variable "circuit_custom_name" {
  description = "Custom ExpressRoute Circuit resource name."
  type        = string
  default     = null
}

variable "gateway_custom_name" {
  description = "Custom ExpressRoute Gateway resource name."
  type        = string
  default     = null
}

variable "public_ip_custom_name" {
  description = "Custom public IP resource name."
  type        = string
  default     = null
}

variable "gateway_ipconfig_custom_name" {
  description = "Custom ExpressRoute Gateway IP config name."
  type        = string
  default     = null
}

variable "connection_custom_name" {
  description = "Custom ExpressRoute Gateway Connection resource name."
  type        = string
  default     = null
}
