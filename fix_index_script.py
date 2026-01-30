#!/usr/bin/env python3
script = '''#!/bin/bash
set -e
WS="${WORKSPACE:-/workspace}"
DOCS_DIR="${WS}/docs"

echo "📑 Generando index.md..."
mkdir -p "${DOCS_DIR}"

generate_terraform_index() {
    local OUTPUT="${DOCS_DIR}/terraform/index.md"
    mkdir -p "$(dirname "$OUTPUT")"
    echo "# Terraform" > "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "Modulos de infraestructura." >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "## Modulos" >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    local MODULES_DIR="${DOCS_DIR}/terraform/modules"
    if [ -d "$MODULES_DIR" ]; then
        local found=false
        for md_file in "$MODULES_DIR"/*.md; do
            [ -f "$md_file" ] || continue
            local name=$(basename "$md_file" .md)
            echo "- [${name}](./modules/${name}.md)" >> "$OUTPUT"
            found=true
        done
        [ "$found" = false ] && echo "- Sin modulos" >> "$OUTPUT"
    else
        echo "- Sin modulos" >> "$OUTPUT"
    fi
    echo "  ✓ terraform/index.md"
}

generate_ansible_index() {
    local OUTPUT="${DOCS_DIR}/ansible/index.md"
    mkdir -p "$(dirname "$OUTPUT")"
    echo "# Ansible" > "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "Roles." >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "## Roles" >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    local ROLES_DIR="${DOCS_DIR}/ansible/roles"
    if [ -d "$ROLES_DIR" ]; then
        local found=false
        for md_file in "$ROLES_DIR"/*.md; do
            [ -f "$md_file" ] || continue
            local name=$(basename "$md_file" .md)
            echo "- [${name}](./roles/${name}.md)" >> "$OUTPUT"
            found=true
        done
        [ "$found" = false ] && echo "- Sin roles" >> "$OUTPUT"
    else
        echo "- Sin roles" >> "$OUTPUT"
    fi
    echo "  ✓ ansible/index.md"
}

generate_kubernetes_index() {
    local OUTPUT="${DOCS_DIR}/kubernetes/index.md"
    mkdir -p "$(dirname "$OUTPUT")"
    echo "# Kubernetes" > "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "Helm Charts." >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "## Charts" >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    local CHARTS_DIR="${DOCS_DIR}/kubernetes/helm"
    if [ -d "$CHARTS_DIR" ]; then
        local found=false
        for md_file in "$CHARTS_DIR"/*.md; do
            [ -f "$md_file" ] || continue
            local name=$(basename "$md_file" .md)
            echo "- [${name}](./helm/${name}.md)" >> "$OUTPUT"
            found=true
        done
        [ "$found" = false ] && echo "- Sin charts" >> "$OUTPUT"
    else
        echo "- Sin charts" >> "$OUTPUT"
    fi
    echo "  ✓ kubernetes/index.md"
}

generate_docker_index() {
    local OUTPUT="${DOCS_DIR}/docker/index.md"
    mkdir -p "$(dirname "$OUTPUT")"
    echo "# Docker" > "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "Apps." >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "## Apps" >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    local APPS_DIR="${DOCS_DIR}/docker/apps"
    if [ -d "$APPS_DIR" ]; then
        local found=false
        for md_file in "$APPS_DIR"/*.md; do
            [ -f "$md_file" ] || continue
            local name=$(basename "$md_file" .md)
            echo "- [${name}](./apps/${name}.md)" >> "$OUTPUT"
            found=true
        done
        [ "$found" = false ] && echo "- Sin apps" >> "$OUTPUT"
    else
        echo "- Sin apps" >> "$OUTPUT"
    fi
    echo "  ✓ docker/index.md"
}

generate_runbooks_index() {
    local OUTPUT="${DOCS_DIR}/runbooks/index.md"
    mkdir -p "$(dirname "$OUTPUT")"
    echo "# Runbooks" > "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "Procedimientos." >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "## Backup" >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo 'pg_dump db > backup.sql' >> "$OUTPUT"
    echo "  ✓ runbooks/index.md"
}

echo "=================================="
echo "  Generando indices"
echo "=================================="
generate_terraform_index
generate_ansible_index
generate_kubernetes_index
generate_docker_index
generate_runbooks_index
echo ""
echo "✅ Listo"
'''

with open('/workspace/generate-mkdocs-index.sh', 'w', newline='\n') as f:
    f.write(script)
import os
os.chmod('/workspace/generate-mkdocs-index.sh', 0o755)
print('✓ Script creado')
