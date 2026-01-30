# Diagrama de Infraestructura

## Vista General

```mermaid
graph TB
    subgraph "Azure Cloud"
        subgraph "Networking"
            VNET[VPC / Virtual Network]
            NSG[Network Security Groups]
            LB[Load Balancers]
        end
        
        subgraph "Compute Layer"
            VM[Virtual Machines]
            VMSS[VM Scale Sets]
            AKS[AKS Cluster]
        end
        
        subgraph "Storage Layer"
            SA[Storage Account]
            BLOB[Blob Storage]
            FILES[File Shares]
        end
        
        subgraph "Database"
            PG[(PostgreSQL)]
            REDIS[(Redis Cache)]
        end
    end
    
    subgraph "Configuration Management"
        ANSIBLE[Ansible]
    end
    
    Internet --> NSG
    NSG --> VNET
    VNET --> VM
    VNET --> AKS
    VNET --> SA
    AKS --> PG
    AKS --> REDIS
    ANSIBLE --> VM
    
    style Internet fill:#f96
    style AKS fill:#69f
    style PG fill:#9f9
```

## Módulos Terraform

| Módulo | Descripción | Recursos |
|--------|-------------|----------|
| **VPC** | Red virtual y subnets | VNet, Subnets, NSG |
| **Compute** | Máquinas virtuales | VMs, NICs, Public IPs |
| **Storage** | Almacenamiento | Storage Account, Containers |
| **AKS** | Kubernetes | Cluster, Node Pool |
