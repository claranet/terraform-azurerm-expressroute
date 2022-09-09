terraform {
  required_version = ">= 1.1, < 1.3"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "~> 1.1"
    }
  }

  experiments = [module_variable_optional_attrs]
}
