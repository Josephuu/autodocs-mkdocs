# Diagramas de Arquitectura

## Índice de Diagramas

### Infraestructura
- [Vista General de Infraestructura](./terraform/infrastructure-overview.md)
- [Dependencias Terraform](./terraform/dependencies.md)

### Aplicaciones
- [Flujo de Roles Ansible](./ansible/webserver-flow.md)
- [Arquitectura Docker](./docker/)

### Sistema Completo
```mermaid
graph TB
    subgraph "Infraestructura Azure"
        VNET[VPC]
        VM[VMs]
        AKS[AKS]
        STORAGE[Storage]
    end
    
    subgraph "Configuración"
        ANSIBLE[Ansible Roles]
    end
    
    subgraph "Aplicaciones"
        APP[App Container]
        DB[(Database)]
    end
    
    VNET --> VM
    VNET --> AKS
    VM --> ANSIBLE
    AKS --> APP
    APP --> DB
    
    style VNET fill:#69f
    style AKS fill:#9f9
    style DB fill:#f99
```
