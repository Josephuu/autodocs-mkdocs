# Terraform Storage Module

Módulo para crear Storage Accounts en Azure.

## Usage

```hcl
module "storage" {
  source = "./modules/storage"

  name                = "mystorage"
  resource_group_name = "my-rg"
  location            = "eastus"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| name | Storage account name | `string` | n/a | yes |
| resource_group_name | RG name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | Storage account ID |
| primary_endpoint | Blob endpoint |
