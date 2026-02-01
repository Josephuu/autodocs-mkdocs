# Ansible Role: Webserver

Configura NGINX como servidor web.

## Requisitos

- Ubuntu/Debian

## Variables

| Variable | Descripción | Default |
|----------|-------------|---------|
| `nginx_port` | Puerto HTTP | `80` |
| `nginx_ssl_port` | Puerto HTTPS | `443` |
| `nginx_server_name` | Nombre del servidor | `_` |
| `nginx_root` | Directorio raíz | `/var/www/html` |

## Ejemplo de Uso

```yaml
- hosts: webservers
  roles:
    - role: webserver
      vars:
        nginx_port: 80
        nginx_server_name: empresa.com
```

## SSL/TLS

Para habilitar HTTPS, combinar con el rol `certbot`.
