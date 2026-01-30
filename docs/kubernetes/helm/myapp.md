# Helm Chart: MyApp

Chart para desplegar la aplicación principal en Kubernetes.

## Instalación

```bash
helm install myapp ./myapp
```

## Values

| Key | Default | Description |
|-----|---------|-------------|
| replicaCount | 2 | Número de réplicas |
| image.tag | latest | Tag de la imagen |
| service.port | 80 | Puerto del servicio |

## Desinstalación

```bash
helm uninstall myapp
```
