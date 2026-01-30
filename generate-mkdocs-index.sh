#!/bin/bash
# Genera automáticamente los archivos index.md para MkDocs

set -e

WS="${WORKSPACE:-/workspace}"
DOCS_DIR="${WS}/docs"

echo "📑 Generando index.md para MkDocs..."

mkdir -p "${DOCS_DIR}"

# Terraform
generate_terraform_index() {
    local OUTPUT="${DOCS_DIR}/terraform/index.md"
    mkdir -p "$(dirname "$OUTPUT")"

    echo "# Terraform" > "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "Módulos de infraestructura como código para Azure." >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "## Módulos Disponibles" >> "$OUTPUT"
    echo "" >> "$OUTPUT"

    local MODULES_DIR=""
    if [ -d "${WS}/terraform/modules" ]; then
        MODULES_DIR="${WS}/terraform/modules"
    elif [ -d "${WS}/test-project/terraform" ]; then
        MODULES_DIR="${WS}/test-project/terraform"
    fi

    if [ -n "$MODULES_DIR" ] && [ -d "$MODULES_DIR" ]; then
        for module_path in "$MODULES_DIR"/*/; do
            if [ -d "$module_path" ]; then
                local module_name=$(basename "$module_path")
                local readme_path="${module_path}/README.md"
                local description="Módulo de Terraform"
                if [ -f "$readme_path" ]; then
                    local first_line=$(head -1 "$readme_path" | sed 's/^#* //')
                    if [ -n "$first_line" ]; then
                        description="$first_line"
                    fi
                fi
                echo "- [${module_name}](./modules/${module_name}.md) - ${description}" >> "$OUTPUT"
            fi
        done
    else
        echo "- No se encontraron módulos" >> "$OUTPUT"
    fi

    echo "" >> "$OUTPUT"
    echo "## Uso Rápido" >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo '\`\`\`hcl' >> "$OUTPUT"
    echo 'module "ejemplo" {' >> "$OUTPUT"
    echo '  source = "./modules/<nombre-modulo>"' >> "$OUTPUT"
    echo '}' >> "$OUTPUT"
    echo '\`\`\`' >> "$OUTPUT"

    echo "  ✓ ${OUTPUT}"
}

# Ansible
generate_ansible_index() {
    local OUTPUT="${DOCS_DIR}/ansible/index.md"
    mkdir -p "$(dirname "$OUTPUT")"

    echo "# Ansible" > "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "Roles para configuración automatizada de servidores." >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "## Roles Disponibles" >> "$OUTPUT"
    echo "" >> "$OUTPUT"

    local ROLES_DIR=""
    if [ -d "${WS}/ansible/roles" ]; then
        ROLES_DIR="${WS}/ansible/roles"
    elif [ -d "${WS}/test-project/ansible/roles" ]; then
        ROLES_DIR="${WS}/test-project/ansible/roles"
    fi

    if [ -n "$ROLES_DIR" ] && [ -d "$ROLES_DIR" ]; then
        for role_path in "$ROLES_DIR"/*/; do
            if [ -d "$role_path" ]; then
                local role_name=$(basename "$role_path")
                local readme_path="${role_path}/README.md"
                local description="Rol de Ansible"
                if [ -f "$readme_path" ]; then
                    local first_line=$(head -1 "$readme_path" | sed 's/^#* //')
                    if [ -n "$first_line" ]; then
                        description="$first_line"
                    fi
                fi
                echo "- [${role_name}](./roles/${role_name}.md) - ${description}" >> "$OUTPUT"
            fi
        done
    else
        echo "- No se encontraron roles" >> "$OUTPUT"
    fi

    echo "  ✓ ${OUTPUT}"
}

# Kubernetes
generate_kubernetes_index() {
    local OUTPUT="${DOCS_DIR}/kubernetes/index.md"
    mkdir -p "$(dirname "$OUTPUT")"

    echo "# Kubernetes" > "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "Recursos y Helm Charts para despliegues en AKS." >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "## Helm Charts Disponibles" >> "$OUTPUT"
    echo "" >> "$OUTPUT"

    local CHARTS_DIR=""
    if [ -d "${WS}/helm/charts" ]; then
        CHARTS_DIR="${WS}/helm/charts"
    elif [ -d "${WS}/kubernetes/helm" ]; then
        CHARTS_DIR="${WS}/kubernetes/helm"
    elif [ -d "${WS}/test-project/kubernetes/helm" ]; then
        CHARTS_DIR="${WS}/test-project/kubernetes/helm"
    fi

    if [ -n "$CHARTS_DIR" ] && [ -d "$CHARTS_DIR" ]; then
        for chart_path in "$CHARTS_DIR"/*/; do
            if [ -d "$chart_path" ]; then
                local chart_name=$(basename "$chart_path")
                local readme_path="${chart_path}/README.md"
                local description="Helm Chart"
                if [ -f "$readme_path" ]; then
                    local first_line=$(head -1 "$readme_path" | sed 's/^#* //')
                    if [ -n "$first_line" ]; then
                        description="$first_line"
                    fi
                fi
                echo "- [${chart_name}](./helm/${chart_name}.md) - ${description}" >> "$OUTPUT"
            fi
        done
    else
        echo "- No se encontraron charts" >> "$OUTPUT"
    fi

    echo "  ✓ ${OUTPUT}"
}

# Docker
generate_docker_index() {
    local OUTPUT="${DOCS_DIR}/docker/index.md"
    mkdir -p "$(dirname "$OUTPUT")"

    echo "# Docker" > "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "Aplicaciones containerizadas." >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "## Aplicaciones Disponibles" >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "- Backend - API Node.js" >> "$OUTPUT"
    echo "- Frontend - React + NGINX" >> "$OUTPUT"

    echo "  ✓ ${OUTPUT}"
}

# Runbooks
generate_runbooks_index() {
    local OUTPUT="${DOCS_DIR}/runbooks/index.md"
    mkdir -p "$(dirname "$OUTPUT")"

    echo "# Runbooks" > "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "Procedimientos operacionales." >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "## Disaster Recovery" >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo '\`\`\`bash' >> "$OUTPUT"
    echo '# Backup PostgreSQL' >> "$OUTPUT"
    echo 'pg_dump -U user dbname > backup.sql' >> "$OUTPUT"
    echo '\`\`\`' >> "$OUTPUT"

    echo "  ✓ ${OUTPUT}"
}

# Main
echo "═══════════════════════════════════════════"
echo "  Generando índices para MkDocs"
echo "═══════════════════════════════════════════"

generate_terraform_index
generate_ansible_index
generate_kubernetes_index
generate_docker_index
generate_runbooks_index

echo ""
echo "✅ Índices generados correctamente"
