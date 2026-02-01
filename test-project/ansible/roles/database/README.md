# Ansible Role: Database

Configura bases de datos PostgreSQL o MySQL.

## Requisitos

- Ubuntu/Debian
- Acceso root o sudo

## Variables

| Variable | Descripción | Default |
|----------|-------------|---------|
| `db_type` | Tipo de base de datos (postgresql/mysql) | `postgresql` |
| `db_name` | Nombre de la base de datos | `appdb` |
| `db_user` | Usuario de la base de datos | `appuser` |
| `db_password` | Contraseña del usuario | `changeme` |
| `db_port` | Puerto de conexión | `5432` |

## Ejemplo de Uso

```yaml
- hosts: databases
  roles:
    - role: database
      vars:
        db_type: postgresql
        db_name: myapp
        db_user: myuser
        db_password: securepassword
```

## Backup Automático

Configura backups diarios en `/var/backups/database/`.
