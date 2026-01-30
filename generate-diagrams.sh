#!/bin/bash
set -e
WS="${WORKSPACE:-/workspace}"
DOCS_DIR="${WS}/docs"
DIAGRAMS_DIR="${DOCS_DIR}/diagrams"

echo "Generando diagramas..."
mkdir -p "${DIAGRAMS_DIR}"/{terraform,ansible,kubernetes,docker}

# Terraform (InfraMap)
if command -v inframap &> /dev/null && [ -d "${WS}/test-project/terraform" ]; then
    inframap generate "${WS}/test-project/terraform" 2>/dev/null | dot -Tsvg > "${DIAGRAMS_DIR}/terraform/infrastructure.svg" && echo "  infra.svg" || true
fi

# Ansible (Mermaid)
for role_dir in "${WS}/test-project/ansible/roles"/*/; do
    [ -d "$role_dir" ] || continue
    role_name=$(basename "$role_dir")
    echo "# Flow ${role_name}" > "${DIAGRAMS_DIR}/ansible/${role_name}-flow.md"
    echo "" >> "${DIAGRAMS_DIR}/ansible/${role_name}-flow.md"
    echo 'mermaid' >> "${DIAGRAMS_DIR}/ansible/${role_name}-flow.md"
    echo 'graph TD' >> "${DIAGRAMS_DIR}/ansible/${role_name}-flow.md"
    echo "    Start --> Install --> Config --> End" >> "${DIAGRAMS_DIR}/ansible/${role_name}-flow.md"
    echo "  ${role_name}-flow.md"
done

# System overview
cat > "${DIAGRAMS_DIR}/system-overview.md" << 'EOF'
# System Overview

mermaid
graph TB
    Azure[Azure Cloud] --> VPC[VPC]
    VPC --> VMs[VMs]
    VPC --> AKS[AKS]
    VMs --> Ansible[Ansible]
    AKS --> K8s[Kubernetes]
EOF
echo "  system-overview.md"
echo "Diagramas listos"
