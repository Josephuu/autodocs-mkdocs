# Ansible Role: Monitoring

Instala Prometheus y Grafana para monitoreo.

## Requisitos

- Ubuntu/Debian
- 2GB RAM mínimo recomendado

## Variables

| Variable | Descripción | Default |
|----------|-------------|---------|
| `grafana_admin_user` | Usuario admin de Grafana | `admin` |
| `grafana_admin_password` | Password admin | `admin` |
| `prometheus_retention` | Días de retención de métricas | `15d` |

## Endpoints

| Servicio | URL |
|----------|-----|
| Grafana | http://localhost:3000 |
| Prometheus | http://localhost:9090 |

## Ejemplo de Uso

```yaml
- hosts: monitoring
  roles:
    - role: monitoring
      vars:
        grafana_admin_password: securepass
```
