#!/bin/bash
# Script para sincronizar README.md generados con docs/
# Ejecutar desde la raíz de tu proyecto (donde está mkdocs.yml)

set -e

echo "📚 Sincronizando documentación generada a docs/..."
echo ""

# Crear estructura en docs/
mkdir -p docs/{terraform/modules,ansible/roles,kubernetes/helm,docker/apps}

# Contador
total=0

# 1. Terraform Modules
echo "📦 Terraform Modules:"
if [ -d "test-project/terraform/modules" ]; then
    for module in test-project/terraform/modules/*/; do
        if [ -f "$module/README.md" ]; then
            module_name=$(basename "$module")
            cp "$module/README.md" "docs/terraform/modules/${module_name}.md"
            echo "  ✅ $module_name"
            ((total++))
        fi
    done
fi

# 2. Ansible Roles
echo ""
echo "🔧 Ansible Roles:"
if [ -d "test-project/ansible/roles" ]; then
    for role in test-project/ansible/roles/*/; do
        if [ -f "$role/README.md" ]; then
            role_name=$(basename "$role")
            cp "$role/README.md" "docs/ansible/roles/${role_name}.md"
            echo "  ✅ $role_name"
            ((total++))
        fi
    done
fi

# 3. Kubernetes Helm Charts
echo ""
echo "☸️  Kubernetes Helm Charts:"
if [ -d "test-project/kubernetes/helm" ]; then
    for chart in test-project/kubernetes/helm/*/; do
        if [ -f "$chart/README.md" ]; then
            chart_name=$(basename "$chart")
            cp "$chart/README.md" "docs/kubernetes/helm/${chart_name}.md"
            echo "  ✅ $chart_name"
            ((total++))
        fi
    done
fi

# 4. Docker Apps (crear docs básicos)
echo ""
echo "🐳 Docker Apps:"
if [ -d "test-project/docker/apps" ]; then
    for app in test-project/docker/apps/*/; do
        if [ -d "$app" ]; then
            app_name=$(basename "$app")

            # Crear documentación básica
            cat > "docs/docker/apps/${app_name}.md" << DOCKER_EOF
# Docker App: ${app_name}

## Overview

Aplicación Docker ubicada en \`test-project/docker/apps/${app_name}/\`

## Archivos

DOCKER_EOF

            # Agregar Dockerfile si existe
            if [ -f "$app/Dockerfile" ]; then
                echo "" >> "docs/docker/apps/${app_name}.md"
                echo "### Dockerfile" >> "docs/docker/apps/${app_name}.md"
                echo "" >> "docs/docker/apps/${app_name}.md"
                echo '```dockerfile' >> "docs/docker/apps/${app_name}.md"
                cat "$app/Dockerfile" >> "docs/docker/apps/${app_name}.md"
                echo '```' >> "docs/docker/apps/${app_name}.md"
            fi

            # Agregar package.json si existe
            if [ -f "$app/package.json" ]; then
                echo "" >> "docs/docker/apps/${app_name}.md"
                echo "### package.json" >> "docs/docker/apps/${app_name}.md"
                echo "" >> "docs/docker/apps/${app_name}.md"
                echo '```json' >> "docs/docker/apps/${app_name}.md"
                cat "$app/package.json" >> "docs/docker/apps/${app_name}.md"
                echo '```' >> "docs/docker/apps/${app_name}.md"
            fi

            echo "  ✅ $app_name"
            ((total++))
        fi
    done
fi

# 5. Crear páginas índice
echo ""
echo "📄 Creando páginas índice..."

# Terraform index
cat > docs/terraform/index.md << 'EOF'
# Módulos Terraform

Documentación de los módulos de Terraform para Azure.

## Módulos Disponibles

EOF
for module in docs/terraform/modules/*.md 2>/dev/null; do
    if [ -f "$module" ]; then
        module_name=$(basename "$module" .md)
        echo "- [$module_name](modules/$module_name.md)" >> docs/terraform/index.md
    fi
done

# Ansible index
cat > docs/ansible/index.md << 'EOF'
# Roles Ansible

Documentación de los roles de Ansible para gestión de configuración.

## Roles Disponibles

EOF
for role in docs/ansible/roles/*.md 2>/dev/null; do
    if [ -f "$role" ]; then
        role_name=$(basename "$role" .md)
        echo "- [$role_name](roles/$role_name.md)" >> docs/ansible/index.md
    fi
done

# Kubernetes index
cat > docs/kubernetes/index.md << 'EOF'
# Kubernetes / Helm

Documentación de los Helm Charts para Kubernetes.

## Charts Disponibles

EOF
for chart in docs/kubernetes/helm/*.md 2>/dev/null; do
    if [ -f "$chart" ]; then
        chart_name=$(basename "$chart" .md)
        echo "- [$chart_name](helm/$chart_name.md)" >> docs/kubernetes/index.md
    fi
done

# Docker index
cat > docs/docker/index.md << 'EOF'
# Docker Applications

Documentación de las aplicaciones Docker.

## Apps Disponibles

EOF
for app in docs/docker/apps/*.md 2>/dev/null; do
    if [ -f "$app" ]; then
        app_name=$(basename "$app" .md)
        echo "- [$app_name](apps/$app_name.md)" >> docs/docker/index.md
    fi
done

echo "  ✅ Índices creados"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Sincronización completa!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📊 Total de documentos: $total"
echo ""
echo "📁 Estructura creada en docs/:"
tree -L 2 docs/ 2>/dev/null || find docs/ -type f -name "*.md" | head -20
echo ""
echo "🚀 Próximo paso:"
echo "   mkdocs serve"
echo ""
