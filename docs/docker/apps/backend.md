# Docker Backend App

API Node.js para el backend de la aplicación.

## Características

- Node.js 18
- Express.js
- Health check endpoint

## Variables de Entorno

| Variable | Descripción | Default |
|----------|-------------|---------|
| `PORT` | Puerto de la aplicación | `3000` |
| `NODE_ENV` | Entorno (development/production) | `development` |

## Endpoints

| Ruta | Descripción |
|------|-------------|
| `/health` | Health check |
| `/api` | API endpoints |

## Uso

```bash
docker build -t backend .
docker run -p 3000:3000 backend
```
