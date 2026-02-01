# Runbooks

Procedimientos operacionales para gestión de incidentes y tareas comunes.

---

## Disaster Recovery

### Backup de Base de Datos PostgreSQL

```bash
# Backup completo
docker exec postgres pg_dump -U postgres mydb > backup_$(date +%Y%m%d).sql

# Backup solo schema
pg_dump -U postgres --schema-only mydb > schema_backup.sql

# Backup comprimido
pg_dump -U postgres mydb | gzip > backup.sql.gz
```

### Restore de Base de Datos

```bash
# Restore desde backup
psql -U postgres mydb < backup.sql

# Restore con drop/create
dropdb mydb && createdb mydb && psql mydb < backup.sql
```

---

## Troubleshooting

### Verificar Estado de Servicios

```bash
# Docker
docker-compose ps
docker-compose logs --tail 100

# Kubernetes
kubectl get pods -n production
kubectl logs deployment/app -n production

# Ansible
ansible-playbook -i inventory site.yml --check
```

### Reiniciar Servicios

```bash
# Docker Compose
docker-compose restart app

# Kubernetes
kubectl rollout restart deployment/app -n production

# Systemd
sudo systemctl restart nginx
```

---

## Deployment

### Desplegar Nueva Versión

```bash
# 1. Actualizar imagen
docker-compose pull
docker-compose up -d

# 2. Verificar health checks
curl http://localhost/health

# 3. Rollback si es necesario
docker-compose down
docker-compose up -d --no-deps app
```

---

## Mantenimiento

### Limpieza de Docker

```bash
# Eliminar imágenes no usadas
docker image prune -a

# Eliminar volúmenes huérfanos
docker volume prune

# Limpiar todo
docker system prune -a --volumes
```

### Rotación de Logs

```bash
# Verificar espacio de logs
du -sh /var/log/* | sort -hr

# Rotar logs manualmente
sudo logrotate -f /etc/logrotate.conf
```
