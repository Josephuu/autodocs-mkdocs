# Docker Redis Cache

Servidor Redis para caching en memoria.

## Características

- Redis 7 Alpine
- Configuración optimizada para cache
- Persistencia AOF habilitada
- Política de evicción allkeys-lru

## Uso

```bash
docker build -t redis-cache .
docker run -p 6379:6379 redis-cache
```

## Configuración

| Parámetro | Valor | Descripción |
|-----------|-------|-------------|
| `maxmemory` | 256mb | Límite de memoria |
| `maxmemory-policy` | allkeys-lru | Política de evicción |
| `appendonly` | yes | Persistencia AOF |

## Conexión

```bash
redis-cli -h localhost -p 6379
```
