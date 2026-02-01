# Ansible Role: Jenkins

Instala y configura Jenkins CI/CD server.

## Requisitos

- Ubuntu/Debian
- Java 11 (se instala automaticamente)

## Variables

| Variable | Descripcion | Default |
|----------|-------------|---------|
| `jenkins_port` | Puerto de Jenkins | `8080` |
| `jenkins_admin_user` | Usuario administrador | `admin` |
| `configure_firewall` | Configurar UFW | `true` |

## Ejemplo de Uso

```yaml
- hosts: ci-servers
  roles:
    - role: jenkins
      vars:
        jenkins_port: 8080
```

## Post-instalacion

1. Acceder a http://localhost:8080
2. Obtener password inicial: `sudo cat /var/lib/jenkins/secrets/initialAdminPassword`
3. Completar setup wizard

## Plugins Recomendados

- Pipeline
- Git
- Blue Ocean
- Docker Pipeline
