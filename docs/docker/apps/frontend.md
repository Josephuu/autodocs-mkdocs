# Docker Frontend App

Frontend React servido con NGINX.

## Características

- React 18
- NGINX como servidor web
- Configuración optimizada para producción

## Variables de Entorno

| Variable | Descripción | Default |
|----------|-------------|---------|
| `REACT_APP_API_URL` | URL de la API backend | `http://localhost:3000` |

## Uso

```bash
docker build -t frontend .
docker run -p 80:80 frontend
```

## Configuración NGINX

El contenedor incluye configuración optimizada para React Router y compresión gzip.
