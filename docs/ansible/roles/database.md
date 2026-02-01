# Ansible Role: Database

Instala y configura PostgreSQL.

## Requisitos

- Ubuntu 20.04+
- 2GB RAM mínimo

## Variables

| Variable | Default | Description |
|----------|---------|-------------|
| postgres_version | 14 | Versión de PostgreSQL |
| postgres_port | 5432 | Puerto |

## Ejemplo

```yaml
- role: database
  vars:
    postgres_version: 15
```
