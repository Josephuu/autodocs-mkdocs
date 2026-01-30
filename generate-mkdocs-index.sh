#!/bin/bash
# =============================================================================
# Genera automáticamente los archivos index.md para MkDocs
# 
# Uso:
#   WORKSPACE=/ruta/al/repo ./generate-mkdocs-index.sh
# 
# En GitHub Actions:
#   WORKSPACE: ${{ github.workspace }}
# =============================================================================

set -e

WS="${WORKSPACE:-/workspace}"
DOCS_DIR="${WS}/docs"

echo "📑 Generando index.md para MkDocs..."
echo "   WORKSPACE: ${WS}"
echo "   DOCS_DIR: ${DOCS_DIR}"

mkdir -p "${DOCS_DIR}"

# =============================================================================
# Terraform
# =============================================================================
generate_terraform_index() {
    local OUTPUT="${DOCS_DIR}/terraform/index.md"
    mkdir -p "$(dirname "$OUTPUT")"
    
    echo "# Terraform" > "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "Módulos de infraestructura como código para Azure." >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "## Módulos Disponibles" >> "$OUTPUT"
    echo "" >> "$OUTPUT"

    # Buscar módulos documentados en docs/terraform/modules/
    local MODULES_DIR="${DOCS_DIR}/terraform/modules"
    
    if [ -d "$MODULES_DIR" ]; then
        local found=false
        for md_file in "$MODULES_DIR"/*.md; do
            if [ -f "$md_file" ]; then
                local module_name=$(basename "$md_file" .md)
                echo "- [${module_name}](./modules/${module_name}.md) - Módulo de Terraform" >> "$OUTPUT"
                found=true
            fi
        done
        
        if [ "$found" = false ]; then
            echo "- No hay módulos documentados aún" >> "$OUTPUT"
        fi
    else
        echo "- No hay módulos documentados aún" >> "$OUTPUT"
    fi

    echo "" >> "$OUTPUT"
    echo "## Uso Rápido" >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo '```hcl' >> "$OUTPUT"
    echo 'module "ejemplo" {' >> "$OUTPUT"
    echo '  source = "./modules/<nombre-modulo>"' >> "$OUTPUT"
    echo '}' >> "$OUTPUT"
    echo '```' >> "$OUTPUT"

    echo "  ✓ ${OUTPUT}"
}

# =============================================================================
# Ansible
# =============================================================================
generate_ansible_index() {
    local OUTPUT="${DOCS_DIR}/ansible/index.md"
    mkdir -p "$(dirname "$OUTPUT")"
    
    echo "# Ansible" > "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "Roles para configuración automatizada de servidores." >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "## Roles Disponibles" >> "$OUTPUT"
    echo "" >> "$OUTPUT"

    local ROLES_DIR="${DOCS_DIR}/ansible/roles"
    
    if [ -d "$ROLES_DIR" ]; then
        local found=false
        for md_file in "$ROLES_DIR"/*.md; do
            if [ -f "$md_file" ]; then
                local role_name=$(basename "$md_file" .md)
                echo "- [${role_name}](./roles/${role_name}.md) - Rol de Ansible" >> "$OUTPUT"
                found=true
            fi
        done
        
        if [ "$found" = false ]; then
            echo "- No hay roles documentados aún" >> "$OUTPUT"
        fi
    else
        echo "- No hay roles documentados aún" >> "$OUTPUT"
    fi

    echo "  ✓ ${OUTPUT}"
}

# =============================================================================
# Kubernetes
# =============================================================================
generate_kubernetes_index() {
    local OUTPUT="${DOCS_DIR}/kubernetes/index.md"
    mkdir -p "$(dirname "$OUTPUT")"
    
    echo "# Kubernetes" > "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "Recursos y Helm Charts para despliegues en AKS." >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "## Helm Charts Disponibles" >> "$OUTPUT"
    echo "" >> "$OUTPUT"

    local CHARTS_DIR="${DOCS_DIR}/kubernetes/helm"
    
    if [ -d "$CHARTS_DIR" ]; then
        local found=false
        for md_file in "$CHARTS_DIR"/*.md; do
            if [ -f "$md_file" ]; then
                local chart_name=$(basename "$md_file" .md)
                echo "- [${chart_name}](./helm/${chart_name}.md) - Helm Chart" >> "$OUTPUT"
                found=true
            fi
        done
        
        if [ "$found" = false ]; then
            echo "- No hay charts documentados aún" >> "$OUTPUT"
        fi
    else
        echo "- No hay charts documentados aún" >> "$OUTPUT"
    fi

    echo "  ✓ ${OUTPUT}"
}

# =============================================================================
# Docker
# =============================================================================
generate_docker_index() {
    local OUTPUT="${DOCS_DIR}/docker/index.md"
    mkdir -p "$(dirname "$OUTPUT")"
    
    echo "# Docker" > "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "Aplicaciones containerizadas." >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "## Aplicaciones Disponibles" >> "$OUTPUT"
    echo "" >> "$OUTPUT"

    local APPS_DIR="${DOCS_DIR}/docker/apps"
    
    if [ -d "$APPS_DIR" ]; then
        local found=false
        for md_file in "$APPS_DIR"/*.md; do
            if [ -f "$md_file" ]; then
                local app_name=$(basename "$md_file" .md)
                echo "- [${app_name}](./apps/${app_name}.md) - Aplicación Docker" >> "$OUTPUT"
                found=true
            fi
        done
        
        if [ "$found" = false ]; then
            echo "- No hay aplicaciones documentadas aún" >> "$OUTPUT"
        fi
    else
        echo "- No hay aplicaciones documentadas aún" >> "$OUTPUT"
    fi

    echo "  ✓ ${OUTPUT}"
}

# =============================================================================
# Runbooks
# =============================================================================
generate_runbooks_index() {
    local OUTPUT="${DOCS_DIR}/runbooks/index.md"
    mkdir -p "$(dirname "$OUTPUT")"
    
    echo "# Runbooks" > "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "Procedimientos operacionales." >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "## Disaster Recovery" >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo '```bash' >> "$OUTPUT"
    echo '# Backup PostgreSQL' >> "$OUTPUT"
    echo 'pg_dump -U user dbname > backup.sql' >> "$OUTPUT"
    echo '```' >> "$OUTPUT"

    echo "  ✓ ${OUTPUT}"
}

# =============================================================================
# Main
# =============================================================================
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
