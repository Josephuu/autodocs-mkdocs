# Terraform Networking Module

Módulo para crear recursos de red adicionales en Azure.

## Uso

```hcl
module "networking" {
  source = "./modules/networking"

  resource_group_name = "my-rg"
  location            = "eastus"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource_group_name | Nombre del Resource Group | `string` | n/a | yes |
| location | Región de Azure | `string` | `"eastus"` | no |
| tags | Tags para los recursos | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| resource_group_id | ID del Resource Group |
| location | Región desplegada |
