#!/bin/bash
# Script de limpieza para el container - elimina archivos innecesarios
# Ejecutar desde: /workspace (dentro del container)

set -e

echo "🧹 Limpiando archivos temporales e innecesarios..."

# ============================================
# ARCHIVOS TEMPORALES Y BACKUPS
# ============================================
FILES_TO_REMOVE=(
    # Backups
    "docker-compose.yml.new"
    "Dockerfile.complete.new"

    # Scripts de fix temporales (ya aplicados)
    "fix-all.sh"
    "fix_aks.py"
    "fix_all.py"
    "fix_diagrams_script.py"
    "fix_index_script.py"
    "fix_script.py"
    "fix_terraform.py"

    # Scripts de generación (ya usados)
    "generate-mkdocs-index-fixed.sh"
)

for file in "${FILES_TO_REMOVE[@]}"; do
    if [ -f "$file" ]; then
        rm -v "$file"
        echo "  ✓ Eliminado: $file"
    fi
done

# ============================================
# PRE-COMMIT CONFIG
# ============================================
if [ -f ".pre-commit-config.yaml" ] && [ -f ".pre-commit-config-optional.yaml" ]; then
    rm -v ".pre-commit-config.yaml"
    mv -v ".pre-commit-config-optional.yaml" ".pre-commit-config.yaml"
    echo "  ✓ Consolidado: pre-commit-config"
fi

# ============================================
# BUILD DE MKDOCS (NO VA EN EL REPO)
# ============================================
if [ -d "site" ]; then
    rm -rf site/
    echo "  ✓ Eliminado: site/ (build generado por mkdocs)"
fi

# ============================================
# WORKFLOWS DUPLICADOS
# ============================================
# Mantener solo docs.yml, eliminar variantes
WORKFLOW_BACKUPS=(
    ".github/workflows/docs-final.yml"
    ".github/workflows/docs-fixed.yml"
    ".github/workflows/docs-minimal.yml"
    ".github/workflows/docs-v2.yml"
    ".github/workflows/docs-v3.yml"
)

for wf in "${WORKFLOW_BACKUPS[@]}"; do
    if [ -f "$wf" ]; then
        rm -v "$wf"
        echo "  ✓ Eliminado workflow duplicado: $wf"
    fi
done

# ============================================
# CREAR .GITIGNORE
# ============================================
if [ ! -f ".gitignore" ]; then
cat > .gitignore << 'EOF'
# Build de MkDocs
site/

# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python

# Entornos virtuales
venv/
ENV/
env/

# IDEs
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Logs
*.log

# Archivos temporales
*.tmp
*.bak
*.new
*.old

# Scripts de fix temporales
fix-*.sh
fix_*.py
fix_*.sh
cleanup-container.sh
EOF
    echo "  ✓ Creado: .gitignore"
fi

echo ""
echo "============================================"
echo "✅ Limpieza completada!"
echo "============================================"
echo ""
echo "📁 Estructura final importante:"
echo ""
echo "  Configuración:"
echo "    ├── mkdocs.yml              (configuración principal)"
echo "    ├── docker-compose.yml      (orquestación)"
echo "    ├── Dockerfile.complete     (o Dockerfile.simple)"
echo "    ├── .pre-commit-config.yaml (opcional)"
echo "    └── .gitignore              (nuevo)"
echo ""
echo "  Documentación:"
echo "    └── docs/                   (contenido markdown)"
echo "        ├── index.md"
echo "        ├── terraform/"
echo "        ├── ansible/"
echo "        ├── docker/"
echo "        ├── kubernetes/"
echo "        └── runbooks/"
echo ""
echo "  Código fuente (ejemplos):"
echo "    └── test-project/           (código de ejemplo)"
echo "        ├── terraform/"
echo "        ├── ansible/"
echo "        ├── docker/"
echo "        └── kubernetes/"
echo ""
echo "  GitHub Actions:"
echo "    └── .github/workflows/"
echo "        └── docs.yml            (workflow activo)"
echo ""
echo "📝 Próximos pasos:"
echo "    1. git add -A"
echo "    2. git commit -m 'chore: cleanup container and add Docker/K8s to nav'"
echo "    3. git push origin main"
echo ""
