# System Overview

mermaid
graph TB
    Azure[Azure Cloud] --> VPC[VPC]
    VPC --> VMs[VMs]
    VPC --> AKS[AKS]
    VMs --> Ansible[Ansible]
    AKS --> K8s[Kubernetes]
