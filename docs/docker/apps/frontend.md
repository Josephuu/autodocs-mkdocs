# Docker App: Frontend

Aplicación React servida por NGINX.

## Build

```bash
docker build -t frontend:latest .
```

## Run

```bash
docker run -d -p 80:80 frontend:latest
```

## Multi-stage Build

```dockerfile
# Stage 1: Build
FROM node:18-alpine AS builder
WORKDIR /app
COPY . .
RUN npm ci && npm run build

# Stage 2: Runtime
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
```
