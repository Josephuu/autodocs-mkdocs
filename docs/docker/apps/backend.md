# Docker App: Backend

API REST construida con Node.js.

## Build

```bash
docker build -t backend:latest .
```

## Run

```bash
docker run -d -p 3000:3000 backend:latest
```

## Variables de Entorno

| Variable | Description |
|----------|-------------|
| NODE_ENV | Entorno (development/production) |
| PORT | Puerto (default: 3000) |
| DATABASE_URL | URL de conexión a BD |
