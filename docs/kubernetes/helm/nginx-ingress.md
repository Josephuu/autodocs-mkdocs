# Helm Chart: Nginx Ingress

NGINX Ingress Controller para Kubernetes.

## Caracteristicas

- Load balancing HTTP/HTTPS
- SSL/TLS termination
- Path-based routing
- Custom configurations

## Instalacion

```bash
helm install nginx-ingress ./nginx-ingress
```

## Configuracion

| Parametro | Descripcion | Default |
|-----------|-------------|---------|
| `replicaCount` | Numero de replicas | `2` |
| `image.tag` | Version de NGINX | `"1.25.0"` |
| `service.type` | Tipo de servicio | `LoadBalancer` |

## Ejemplo de Ingress

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-app
spec:
  ingressClassName: nginx
  rules:
  - host: app.ejemplo.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: my-service
            port:
              number: 80
```
