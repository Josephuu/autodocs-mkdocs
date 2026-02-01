# Docker Redis Cache

Servidor Redis para caching en memoria.

## Caracteristicas

- Redis 7 Alpine
- Configuracion optimizada para cache
- Persistencia AOF habilitada
- Politica de eviccion allkeys-lru

## Uso

```bash
docker build -t redis-cache .
docker run -p 6379:6379 redis-cache
```

## Configuracion

| Parametro | Valor | Descripcion |
|-----------|-------|-------------|
| `maxmemory` | 256mb | Limite de memoria |
| `maxmemory-policy` | allkeys-lru | Politica de eviccion |
| `appendonly` | yes | Persistencia AOF |

## Conexion

```bash
redis-cli -h localhost -p 6379
```
