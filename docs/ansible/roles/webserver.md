# Ansible Role: Webserver

Configura NGINX como servidor web.

## Requisitos

- Ubuntu 20.04+
- Python 3

## Variables

| Variable | Default | Description |
|----------|---------|-------------|
| nginx_port | 80 | Puerto HTTP |
| nginx_worker_processes | auto | Procesos workers |

## Ejemplo

```yaml
- role: webserver
  vars:
    nginx_port: 8080
```
