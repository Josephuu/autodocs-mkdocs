# Ansible Role: Certbot

Obtiene certificados SSL gratuitos con Let's Encrypt usando Certbot.

## Requisitos

- Ubuntu/Debian
- Puerto 80 disponible para validación

## Variables

| Variable | Descripción | Default |
|----------|-------------|---------|
| `certbot_email` | Email para notificaciones de Let's Encrypt | `admin@example.com` |
| `certbot_domain` | Dominio para el certificado | `example.com` |
| `certbot_reload_nginx` | Recargar nginx después de obtener cert | `true` |

## Ejemplo de Uso

```yaml
- hosts: webservers
  roles:
    - role: certbot
      vars:
        certbot_email: admin@empresa.com
        certbot_domain: empresa.com
```

## Renovación Automática

Se configura un cron job para renovar los certificados automáticamente.
