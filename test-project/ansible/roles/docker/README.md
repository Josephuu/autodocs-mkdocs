# Ansible Role: Docker

Instala y configura Docker CE y Docker Compose.

## Requisitos

- Ubuntu/Debian
- Acceso root o sudo

## Variables

| Variable | Descripción | Default |
|----------|-------------|---------|
| `docker_users` | Usuarios a agregar al grupo docker | `[]` |
| `docker_install_compose` | Instalar Docker Compose | `true` |

## Ejemplo de Uso

```yaml
- hosts: all
  roles:
    - role: docker
      vars:
        docker_users:
          - ubuntu
          - deploy
```

## Post-instalación

- Usuarios configurados pueden usar docker sin sudo
- Docker Compose v2 disponible
