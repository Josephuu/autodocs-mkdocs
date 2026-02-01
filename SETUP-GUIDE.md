# 🚀 Guía de Configuración - Documentación Automatizada

Esta guía te ayuda a configurar el sistema de documentación automatizada desde cero.

---

## 📋 Requisitos Previos

- [ ] Repositorio en GitHub creado
- [ ] Git configurado localmente
- [ ] Docker y docker-compose instalados
- [ ] Personal Access Token (PAT) de GitHub generado

---

## 🏗️ Estructura de Archivos Importantes

```
repo/
├── .github/workflows/docs.yml          # Workflow de CI/CD
├── .pre-commit-config.yaml             # Hooks de pre-commit
├── .hadolint.yaml                      # Configuración de hadolint
├── generate-mkdocs-index.sh            # Script generador de índices
├── mkdocs.yml                          # Configuración de MkDocs
└── docs/                               # Documentación generada
```

---

## ⚙️ Configuración Paso a Paso

### 1. Configurar GitHub Pages

1. Ve a tu repo en GitHub → **Settings** → **Pages**
2. **Source**: Selecciona **GitHub Actions**
3. Guardar

### 2. Configurar Entorno de Deployment

1. Ve a **Settings** → **Environments**
2. Haz clic en **github-pages**
3. En **Deployment branches**, selecciona **"Selected branches"**
4. Agrega `main` (o `master`) a la lista de ramas permitidas

### 3. Configurar Pre-commit Local (Opcional pero recomendado)

```bash
# Instalar pre-commit
pip install pre-commit

# Instalar hooks
cd /ruta/a/tu/repo
pre-commit install
```

---

## 🔧 Solución de Problemas Comunes

### Error: "Permission denied" en archivos

**Causa**: Archivos creados por root en contenedor Docker.

**Solución**:
```bash
sudo chown -R $(whoami):$(whoami) .
```

### Error: "Branch main is not allowed to deploy"

**Causa**: Reglas de protección del entorno.

**Solución**: Ve a Settings → Environments → github-pages → Agrega `main` a ramas permitidas.

### Error: "mkdir: cannot create directory '/workspace'"

**Causa**: Variable WORKSPACE no definida en GitHub Actions.

**Solución**: El workflow ya incluye:
```yaml
env:
  WORKSPACE: ${{ github.workspace }}
```

### Error: "target 'terraform/modules/modules.md' is not found"

**Causa**: El script generaba enlaces incorrectos.

**Solución**: Usar el script `generate-mkdocs-index.sh` actualizado que busca en `docs/terraform/modules/`.

---

## 📝 Flujo de Trabajo

### Desarrollo Local

```bash
# 1. Modificar código (TF/Ansible/K8s/Docker)
vim terraform/modules/vpc/main.tf

# 2. Commit (hooks generan docs automáticamente)
git add .
git commit -m "feat: add new feature"

# 3. Push (dispara GitHub Actions)
git push origin main
```

### Resultado

1. Pre-commit genera README.md en cada módulo/rol/chart
2. Pre-commit genera docs/*/index.md para MkDocs
3. GitHub Actions construye el sitio
4. GitHub Pages publica automáticamente

---

## 🌐 Acceder a la Documentación

Después de un push exitoso, tu documentación estará en:

```
https://TU-USUARIO.github.io/TU-REPO/
```

Ejemplo:
```
https://josephuu.github.io/autodocs-mkdocs/
```

---

## 🛠️ Herramientas Utilizadas

| Herramienta | Propósito |
|-------------|-----------|
| terraform-docs | Generar docs de módulos Terraform |
| docsible | Generar docs de roles Ansible |
| helm-docs | Generar docs de Helm Charts |
| mkdocs-material | Sitio web de documentación |
| hadolint | Lint de Dockerfiles |
| pre-commit | Hooks automáticos en git |

---

## ✅ Checklist de Verificación

- [ ] Workflow en `.github/workflows/docs.yml`
- [ ] Script `generate-mkdocs-index.sh` ejecutable
- [ ] `.pre-commit-config.yaml` configurado
- [ ] `.hadolint.yaml` creado
- [ ] GitHub Pages habilitado (Source: GitHub Actions)
- [ ] Rama `main` permitida en Environment protection rules
- [ ] Primer push exitoso
- [ ] Documentación visible en la URL

---

## 📚 Recursos

- [MkDocs Material](https://squidfunk.github.io/mkdocs-material/)
- [terraform-docs](https://terraform-docs.io/)
- [pre-commit](https://pre-commit.com/)
- [GitHub Pages](https://pages.github.com/)
