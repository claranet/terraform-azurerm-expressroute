# Azure ExpressRoute

[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-blue.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![OpenTofu Registry](https://img.shields.io/badge/opentofu-registry-yellow.svg)](https://search.opentofu.org/module/claranet/expressroute/azurerm/)

This module creates an [Azure ExpressRoute Circuit](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/express_route_circuit).
When your Azure ExpressRoute Circuit is provisionned, you can create an [Azure ExpressRoute Circuit Peering](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/express_route_circuit_peering).
If you configure a Private Peering Circuit, you can deploy an [Azure Virtual Network Gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_gateway).

<!-- BEGIN_TF_DOCS -->
## Global versioning rule for Claranet Azure modules

| Module version | Terraform version | OpenTofu version | AzureRM version |
| -------------- | ----------------- | ---------------- | --------------- |
| >= 8.x.x       | **Unverified**    | 1.8.x            | >= 4.0          |
| >= 7.x.x       | 1.3.x             |                  | >= 3.0          |
| >= 6.x.x       | 1.x               |                  | >= 3.0          |
| >= 5.x.x       | 0.15.x            |                  | >= 2.0          |
| >= 4.x.x       | 0.13.x / 0.14.x   |                  | >= 2.0          |
| >= 3.x.x       | 0.12.x            |                  | >= 2.0          |
| >= 2.x.x       | 0.12.x            |                  | < 2.0           |
| <  2.x.x       | 0.11.x            |                  | < 2.0           |

## Contributing

If you want to contribute to this repository, feel free to use our [pre-commit](https://pre-commit.com/) git hook configuration
which will help you automatically update and format some files for you by enforcing our Terraform code module best-practices.

More details are available in the [CONTRIBUTING.md](./CONTRIBUTING.md#pull-request-process) file.

## Usage

This module is optimized to work with the [Claranet terraform-wrapper](https://github.com/claranet/terraform-wrapper) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `terraform-wrapper` available in the [documentation](https://github.com/claranet/terraform-wrapper#environment).

⚠️ Since modules version v8.0.0, we do not maintain/check anymore the compatibility with
[Hashicorp Terraform](https://github.com/hashicorp/terraform/). Instead, we recommend to use [OpenTofu](https://github.com/opentofu/opentofu/).

```hcl

module "express_route" {
  source  = "claranet/expressroute/azurerm"
  version = "x.x.x"

  environment    = var.environment
  location       = module.azure_region.location
  location_short = module.azure_region.location_short
  client_name    = var.client_name
  stack          = var.stack

  resource_group_name = module.rg.name

  logs_destinations_ids = [
    module.logs.id
  ]

  service_provider_name = "Equinix"
  peering_location      = "London"
  bandwidth_in_mbps     = 50

  virtual_network_name = module.azure_virtual_network.name
  subnet_cidrs         = ["10.10.0.0/27"]

  # Enable when the ExpressRoute Circuit status is provisioned
  circuit_peering_enabled = false
  circuit_peerings = [
    {
      peering_type                  = "AzurePrivatePeering"
      primary_peer_address_prefix   = "169.254.0.0/30"
      secondary_peer_address_prefix = "169.254.0.4/30"
      peer_asn                      = 25419
      vlan_id                       = 100
    }
  ]
}
```

## Providers

| Name | Version |
|------|---------|
| azurecaf | ~> 1.2, ~> 1.2.28 |
| azurerm | ~> 4.31 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| diagnostic\_settings | claranet/diagnostic-settings/azurerm | ~> 8.0.0 |
| subnet | claranet/subnet/azurerm | ~> 8.1.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_express_route_circuit.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/express_route_circuit) | resource |
| [azurerm_express_route_circuit_peering.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/express_route_circuit_peering) | resource |
| [azurerm_public_ip.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_virtual_network_gateway.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_gateway) | resource |
| [azurerm_virtual_network_gateway_connection.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_gateway_connection) | resource |
| [azurecaf_name.erc](https://registry.terraform.io/providers/claranet/azurecaf/latest/docs/data-sources/name) | data source |
| [azurecaf_name.ergw](https://registry.terraform.io/providers/claranet/azurecaf/latest/docs/data-sources/name) | data source |
| [azurecaf_name.ergw_connection](https://registry.terraform.io/providers/claranet/azurecaf/latest/docs/data-sources/name) | data source |
| [azurecaf_name.ergw_ipconfig](https://registry.terraform.io/providers/claranet/azurecaf/latest/docs/data-sources/name) | data source |
| [azurecaf_name.pub_ip](https://registry.terraform.io/providers/claranet/azurecaf/latest/docs/data-sources/name) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| active\_active\_enabled | Enable or disable an active-active Virtual Network Gateway. (Require a `HighPerformance` or an ` UltraPerformance` SKU.) | `bool` | `false` | no |
| bandwidth\_in\_mbps | The Circuit bandwidth in Mbps. | `number` | n/a | yes |
| circuit\_authorization\_key | The authorization key to use for the ExpressRoute Circuit. | `string` | `null` | no |
| circuit\_connected | Whether the ExpressRoute Circuit is connected or not. | `bool` | `true` | no |
| circuit\_custom\_name | Custom ExpressRoute Circuit resource name. | `string` | `null` | no |
| circuit\_enabled | Whether to create the ExpressRoute Circuit or not. | `bool` | `true` | no |
| circuit\_extra\_tags | Extra tags to add for ExpressRoute Circuit resource. | `map(string)` | `{}` | no |
| circuit\_id | ExpressRoute Circuit ID if not managed by this module. | `string` | `null` | no |
| circuit\_peering\_enabled | Enable or disable Express Route Circuit Peering configuration. (Should be disabled during circuit provisioning. When the ExpressRoute circuit status is 'Provisioned', enable it.) | `bool` | n/a | yes |
| circuit\_peerings | Configuration block of Private, Public and Microsoft ExpressRoute Circuit Peerings. | <pre>list(object({<br/>    peering_type                  = string<br/>    primary_peer_address_prefix   = string<br/>    secondary_peer_address_prefix = string<br/>    peer_asn                      = number<br/>    vlan_id                       = number<br/>    shared_key                    = optional(string)<br/>    route_filter_id               = optional(string)<br/>    microsoft_peering_config = optional(object({<br/>      advertised_public_prefixes = list(string)<br/>      customer_asn               = optional(number)<br/>      routing_registry_name      = optional(string)<br/>    }))<br/>  }))</pre> | n/a | yes |
| client\_name | Name of client. | `string` | n/a | yes |
| connection\_custom\_name | Custom ExpressRoute Gateway Connection resource name. | `string` | `null` | no |
| connection\_extra\_tags | Extra tags to add for ExpressRoute Gateway Connection resource. | `map(string)` | `{}` | no |
| connection\_route\_weight | The routing weight of the ExpressRoute Gateway connection. | `number` | `10` | no |
| custom\_diagnostic\_settings\_name | Custom name of the diagnostics settings, name will be 'default' if not set. | `string` | `"default"` | no |
| default\_tags\_enabled | Option to enable or disable default tags. | `bool` | `true` | no |
| environment | Name of application's environment. | `string` | n/a | yes |
| express\_route\_sku | ExpressRoute SKU. Possible values are [here](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/express_route_circuit#sku). | <pre>object({<br/>    tier   = string,<br/>    family = string<br/>  })</pre> | <pre>{<br/>  "family": "MeteredData",<br/>  "tier": "Standard"<br/>}</pre> | no |
| extra\_tags | Extra tags to add. | `map(string)` | `{}` | no |
| gateway\_custom\_name | Custom ExpressRoute Gateway resource name. | `string` | `null` | no |
| gateway\_enabled | Enable or disable creation of the Virtual Network Gateway. | `bool` | `true` | no |
| gateway\_extra\_tags | Extra tags to add for Virtual Network Gateway resource. | `map(string)` | `{}` | no |
| gateway\_ipconfig\_custom\_name | Custom ExpressRoute Gateway IP config name. | `string` | `null` | no |
| gateway\_sku | SKU of the Virtual Network Gateway resource. Possible values are [here](https://docs.microsoft.com/en-us/azure/expressroute/expressroute-about-virtual-network-gateways#gwsku). | `string` | `"Standard"` | no |
| location | Azure location. | `string` | n/a | yes |
| location\_short | Short string for Azure location. | `string` | n/a | yes |
| logs\_categories | Log categories to send to destinations. | `list(string)` | `null` | no |
| logs\_destinations\_ids | List of destination resources IDs for logs diagnostic destination.<br/>Can be `Storage Account`, `Log Analytics Workspace` and `Event Hub`. No more than one of each can be set.<br/>If you want to use Azure EventHub as a destination, you must provide a formatted string containing both the EventHub Namespace authorization send ID and the EventHub name (name of the queue to use in the Namespace) separated by the <code>&#124;</code> character. | `list(string)` | n/a | yes |
| logs\_metrics\_categories | Metrics categories to send to destinations. | `list(string)` | `null` | no |
| name\_prefix | Optional prefix for the generated name. | `string` | `""` | no |
| name\_suffix | Optional suffix for the generated name. | `string` | `""` | no |
| peering\_location | The name of the peering [location](https://docs.microsoft.com/en-us/azure/expressroute/expressroute-locations#locations). | `string` | n/a | yes |
| public\_ip\_allocation\_method | Defines the allocation method for this IP address. Possible values are `Static` or `Dynamic`. | `string` | `"Static"` | no |
| public\_ip\_custom\_name | Custom public IP resource name. | `string` | `null` | no |
| public\_ip\_extra\_tags | Extra tags to add for public IP resource. | `map(string)` | `{}` | no |
| public\_ip\_zones | List of availability zone for the public IP resource. | `list(number)` | <pre>[<br/>  1,<br/>  2,<br/>  3<br/>]</pre> | no |
| remote\_vnet\_traffic\_enabled | Whether to allow remote VNet traffic flow through the ExpressRoute Gateway. | `bool` | `false` | no |
| resource\_group\_name | Name of the application's resource group. | `string` | n/a | yes |
| service\_provider\_name | The name of the ExpressRoute [Service Provider](https://docs.microsoft.com/en-us/azure/expressroute/expressroute-locations-providers#partners). | `string` | n/a | yes |
| stack | Name of application's stack. | `string` | n/a | yes |
| subnet\_cidrs | The address prefix list to use for the subnet. | `list(string)` | `null` | no |
| subnet\_default\_outbound\_access\_enabled | Whether to allow default outbound traffic from the subnet. | `bool` | `false` | no |
| subnet\_id | ID of an existing subnet gateway. | `string` | `null` | no |
| virtual\_network\_name | Virtual network name. | `string` | n/a | yes |
| virtual\_wan\_traffic\_enabled | Whether to allow Virtual WAN traffic flow through the ExpressRoute Gateway. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| circuit\_id | The ID of the ExpressRoute Circuit. |
| circuit\_name | Name of the ExpressRoute Circuit. |
| circuit\_service\_key | The string needed by the service provider to provision the ExpressRoute Circuit. |
| circuit\_service\_provider\_provisioning\_state | The ExpressRoute Circuit provisioning state from your chosen service provider. |
| gateway\_id | ID of the ExpressRoute Gateway. |
| module\_diagnostic\_settings | Diagnostic settings module output. |
| module\_subnet | Subnet module output. |
| peering\_azure\_asn | ASN (Autonomous System Number) used by Azure for BGP Peering. |
| resource | ExpressRoute Gateway resource object. |
| resource\_circuit | ExpressRoute Circuit resource object. |
| resource\_circuit\_peering | ExpressRoute Circuit Peering resource object. |
| resource\_gateway\_connection | ExpressRoute Gateway Connection resource object. |
| resource\_public\_ip | Public IP resource object. |
| subnet\_id | ID of the Gateway Subnet. |
<!-- END_TF_DOCS -->
## Related documentation

Microsoft Azure documentation : [docs.microsoft.com/fr-fr/azure/expressroute/](https://docs.microsoft.com/fr-fr/azure/expressroute/)
