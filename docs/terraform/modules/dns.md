# Terraform DNS Module

Crea y gestiona zonas DNS en Azure.

## Uso

```hcl
module "dns" {
  source = "./modules/dns"

  zone_name           = "empresa.com"
  resource_group_name = "my-rg"
  root_ip             = "20.190.159.0"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| zone_name | Nombre de la zona DNS | `string` | n/a | yes |
| resource_group_name | Nombre del Resource Group | `string` | n/a | yes |
| root_ip | IP para el registro A raíz | `string` | n/a | yes |
| ttl | Time To Live | `number` | `300` | no |
| tags | Tags para los recursos | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| zone_id | ID de la zona DNS |
| name_servers | Name servers de la zona |
| zone_name | Nombre de la zona creada |
