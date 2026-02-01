# Ansible Role: Webserver

Configura NGINX como servidor web.

## Variables

Ver archivo defaults/main.yml para variables.

## Uso

```yaml
- role: webserver
  vars:
    nginx_port: 80
```

## Tasks

- Instalar NGINX
- Configurar sitio  
- Iniciar servicio
