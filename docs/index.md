# Documentacion de Infraestructura DevOps

Bienvenido al sistema de documentacion automatizada para nuestra infraestructura.

!!! success "Documentacion Siempre Actualizada"
    Esta documentacion se genera automaticamente desde el codigo. **Garantiza 100% de sincronizacion** entre la infraestructura real y la documentacion.

---

## Inicio Rapido

| Seccion | Descripcion | Enlace |
|:--------|:------------|:-------|
| **Terraform** | Modulos de infraestructura como codigo para Azure | [Ver Modulos](terraform/index.md) |
| **Ansible** | Roles para gestion de configuracion de servidores | [Ver Roles](ansible/index.md) |
| **Kubernetes** | Helm Charts para despliegues en AKS | [Ver Charts](kubernetes/index.md) |
| **Docker** | Aplicaciones containerizadas | [Ver Apps](docker/index.md) |

---

## Stack Tecnologico

- **Azure Cloud**: AKS, VMs, Storage, Networking, DNS, Key Vault
- **Infrastructure as Code**: Terraform, Ansible
- **Containers**: Docker, Helm, Kubernetes

---

## Modulos Terraform (7)

Infraestructura como codigo para Azure:

- [VPC](terraform/modules/vpc.md) - Virtual Network y Subnets
- [Storage](terraform/modules/storage.md) - Storage Accounts
- [Compute](terraform/modules/compute.md) - VMs y Scale Sets
- [AKS](terraform/modules/aks.md) - Azure Kubernetes Service
- [DNS](terraform/modules/dns.md) - DNS zones
- [KeyVault](terraform/modules/keyvault.md) - Azure Key Vault
- [Networking](terraform/modules/networking.md) - Network resources

## Roles Ansible (6)

Configuracion automatizada de servidores:

- [Webserver](ansible/roles/webserver.md) - NGINX web server
- [Database](ansible/roles/database.md) - PostgreSQL/MySQL
- [Monitoring](ansible/roles/monitoring.md) - Prometheus y Grafana
- [Docker](ansible/roles/docker.md) - Docker CE
- [Certbot](ansible/roles/certbot.md) - Certificados SSL
- [Jenkins](ansible/roles/jenkins.md) - CI/CD server

## Helm Charts Kubernetes (2)

Orquestacion en AKS:

- [MyApp](kubernetes/helm/myapp.md) - Aplicacion principal
- [Nginx Ingress](kubernetes/helm/nginx-ingress.md) - Ingress Controller

## Apps Docker (3)

Aplicaciones containerizadas:

- [Backend](docker/apps/backend.md) - API Node.js
- [Frontend](docker/apps/frontend.md) - Frontend con NGINX
- [Redis Cache](docker/apps/redis-cache.md) - Redis para caching

---

## Como Contribuir

!!! tip "Flujo de Trabajo"
    1. **Escribe codigo** en `test-project/`
    2. **Haz commit** - El CI/CD genera documentacion automaticamente
    3. **Push** - La documentacion se publica automaticamente

```bash
# Ejemplo: Crear un nuevo modulo Terraform
mkdir test-project/terraform/modules/mi-modulo
# ... escribir main.tf, variables.tf, outputs.tf ...

git add .
git commit -m "feat: add mi-modulo terraform module"
git push origin main
```

---

**Ultima actualizacion**: Automatico en cada commit  
**Estado**: Sincronizado con el codigo fuente
