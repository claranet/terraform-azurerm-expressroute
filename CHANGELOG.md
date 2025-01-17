## 8.0.0 (2025-01-17)

### ⚠ BREAKING CHANGES

* **AZ-1088:** module v8 structure and updates

### Features

* **AZ-1088:** force public ip sku to Standard 0a3d157
* **AZ-1088:** module v8 structure and updates efe7fd5

### Bug Fixes

* **AZ-1088:** bump azurerm to ~> 4.11 d72b6f0

### Documentation

* **AZ-1088:** fix example 97a0f8f

### Miscellaneous Chores

* **AZ-1088:** apply suggestions 8fd0b78
* **AZ-1088:** apply suggestions 7170570
* **deps:** update dependency opentofu to v1.8.6 7469117
* **deps:** update dependency opentofu to v1.8.7 d511e82
* **deps:** update dependency opentofu to v1.8.8 7833e7f
* **deps:** update dependency opentofu to v1.9.0 f111cd6
* **deps:** update dependency tflint to v0.55.0 baeb715
* **deps:** update dependency trivy to v0.58.0 d0b524d
* **deps:** update dependency trivy to v0.58.1 a945d46
* **deps:** update dependency trivy to v0.58.2 82e6967
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.19.0 c95c8b9
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.20.0 863c256
* update tflint config for v0.55.0 bc0f4d5

### Revert

* **AZ-1088:** revert part of 7e91caad c826c53

## 7.5.0 (2024-11-22)

### Features

* **AZ-1483:** allow to manage gateway subnet default outbound access b1ae89e

### Miscellaneous Chores

* **AZ-1483:** apply suggestion 6d7cd7b
* **deps:** update dependency claranet/diagnostic-settings/azurerm to v7 94c75c5
* **deps:** update dependency claranet/subnet/azurerm to v7.2.0 4e68c2e
* **deps:** update dependency opentofu to v1.8.3 db73e1a
* **deps:** update dependency opentofu to v1.8.4 8e20581
* **deps:** update dependency pre-commit to v4 f04a4e4
* **deps:** update dependency pre-commit to v4.0.1 2da3784
* **deps:** update dependency tflint to v0.54.0 0516a20
* **deps:** update dependency trivy to v0.56.1 c440e84
* **deps:** update dependency trivy to v0.56.2 15b337a
* **deps:** update dependency trivy to v0.57.1 bd2024c
* **deps:** update pre-commit hook pre-commit/pre-commit-hooks to v5 983a222
* **deps:** update pre-commit hook tofuutils/pre-commit-opentofu to v2.1.0 9eb4989
* **deps:** update tools d5c18bd
* prepare for new examples structure 6a75c2f
* update examples structure ec1b66e

## 7.4.0 (2024-10-03)

### Features

* use Claranet "azurecaf" provider 00b8db3

## 7.3.1 (2024-10-01)

### Documentation

* update README badge to use OpenTofu registry 328e417

### Miscellaneous Chores

* bump minimum AzureRM version e472a42
* **deps:** update dependency claranet/subnet/azurerm to v7.1.0 a31998d
* **deps:** update dependency trivy to v0.55.2 cd2f39e
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.96.0 5976dd8
* **deps:** update tools 3718aff

## 7.3.0 (2024-09-13)

### Features

* **AZ-1455:** add support of remote vnet traffic and vwan traffic 078b4e8

### Miscellaneous Chores

* **deps:** update dependency trivy to v0.55.1 6977e07
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.18.0 5931f46
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.2 2d211fc
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.3 a9a196c
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.95.0 4f4703f

## 7.2.0 (2024-09-06)

### Features

* **AZ-1452:** add express_route_circuit_authorization_key variable 4a8b0b3
* **AZ-1452:** make ExpressRoute Circuit management optional a017f84
* **AZ-1452:** prepare v8 module 4a38d15

### Bug Fixes

* **AZ-1452:** replace deprecated basic SKU with Standard SKU 27b8454
* **AZ-1452:** static public IP allocation on Standard SKU 271b848

### Continuous Integration

* **AZ-1391:** enable semantic-release [skip ci] 296fed4
* **AZ-1391:** update semantic-release config [skip ci] 30313a2

### Miscellaneous Chores

* **AZ-1452:** apply suggestions 5f01c48
* **AZ-1452:** fix fmt 5713b75
* **deps:** add renovate.json c243729
* **deps:** enable automerge on renovate c96cfcc
* **deps:** update dependency opentofu to v1.7.0 63362e9
* **deps:** update dependency opentofu to v1.7.1 d455f11
* **deps:** update dependency opentofu to v1.7.2 5d2052a
* **deps:** update dependency opentofu to v1.7.3 bcaeaa1
* **deps:** update dependency opentofu to v1.8.0 e20af61
* **deps:** update dependency opentofu to v1.8.1 4885726
* **deps:** update dependency opentofu to v1.8.2 af99547
* **deps:** update dependency pre-commit to v3.7.1 203d696
* **deps:** update dependency pre-commit to v3.8.0 437696d
* **deps:** update dependency terraform-docs to v0.18.0 07d50b4
* **deps:** update dependency tflint to v0.51.0 88d04de
* **deps:** update dependency tflint to v0.51.1 4a11d02
* **deps:** update dependency tflint to v0.51.2 454b5bb
* **deps:** update dependency tflint to v0.52.0 70aa607
* **deps:** update dependency tflint to v0.53.0 b21aba2
* **deps:** update dependency trivy to v0.50.2 c252a17
* **deps:** update dependency trivy to v0.50.4 c15035f
* **deps:** update dependency trivy to v0.51.0 83bd9ed
* **deps:** update dependency trivy to v0.51.1 0932af8
* **deps:** update dependency trivy to v0.51.2 8674713
* **deps:** update dependency trivy to v0.51.4 e89bbf1
* **deps:** update dependency trivy to v0.52.0 868c785
* **deps:** update dependency trivy to v0.52.1 a832f88
* **deps:** update dependency trivy to v0.52.2 cbb80ab
* **deps:** update dependency trivy to v0.53.0 8c228ea
* **deps:** update dependency trivy to v0.54.1 f3c40eb
* **deps:** update dependency trivy to v0.55.0 5b60b9a
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.17.0 295645f
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.0 a869c54
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.1 d223227
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.2 1ea7021
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.3 3e4f962
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.93.0 a4abbcd
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.0 cf3bc14
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.1 36dd605
* **deps:** update renovate.json 190bf4e
* **deps:** update terraform claranet/diagnostic-settings/azurerm to ~> 6.5.0 11775b1
* **deps:** update terraform claranet/subnet/azurerm to v6.3.0 4b74caa
* **deps:** update terraform claranet/subnet/azurerm to v7 ba7f8a2
* **pre-commit:** update commitlint hook 912a147
* **release:** remove legacy `VERSION` file 3f2a6b0

# v7.1.0 - 2022-11-23

Changed
  * AZ-908: Use the new data source for CAF naming (instead of resource)

# v7.0.1 - 2022-09-30

Changed
  * AZ-844: Bump `subnet` module to latest version

# v7.0.0 - 2022-09-30

Breaking
  * AZ-840: Update to Terraform `v1.3`

# v6.0.0 - 2022-09-09

Added
  * AZ-780: First release of ExpressRoute module
