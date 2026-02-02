# Arquitectura Tecnica del Sistema AutoDoc

## Stack Tecnologico

### Generadores de Documentacion

| Herramienta | Proposito | Input | Output |
|-------------|-----------|-------|--------|
| **terraform-docs** | Docs de modulos TF | Archivos .tf | README.md con tablas |
| **docsible** | Docs de roles Ansible | tasks/, defaults/ | README.md del rol |
| **helm-docs** | Docs de charts Helm | Chart.yaml, values.yaml | README.md con valores |

### Site Generator

- **MkDocs**: Generador de sitios estaticos
- **Material Theme**: Tema con busqueda, navegacion, highlighting
- **Extensiones**: pymdownx.highlight, emoji, admonition, tables

### Pipeline CI/CD

- **GitHub Actions**: Pipeline automatizado
- **Trigger**: Push a main
- **Jobs**: Build + Deploy

## Por Que Eliminamos Pre-commit Hooks

### Problemas

1. **Container sin Terraform**: terraform_fmt/validate fallaban
2. **Ruido Windows/Linux**: CRLF vs LF, permisos de archivos
3. **Duplicacion**: Hooks validaban local + CI volvia a validar
4. **Complejidad innecesaria**: Mas puntos de fallo

### Solucion

**Centralizar en CI/CD**:
- CI tiene todas las herramientas instaladas
- Ambiente Ubuntu controlado y consistente
- Developer solo escribe codigo y push

## Replicabilidad en Azure DevOps

### Respuesta corta: SI, completamente

### Equivalencias

| GitHub Actions | Azure DevOps |
|----------------|--------------|
| `ubuntu-latest` | `vmImage: 'ubuntu-latest'` |
| `actions/checkout` | `checkout: self` |
| `actions/setup-python` | `UsePythonVersion@0` |
| GitHub Pages | Azure Static Web Apps |

### Diferencias Clave

1. **Hosting**: 
   - GitHub Pages es nativo y automatico
   - Azure requiere Static Web Apps + token

2. **Sintaxis**: Similar pero no identica

3. **Marketplace**: Acciones vs Tasks

## Conclusion

- **GitHub Actions**: Mas simple, integrado nativo
- **Azure DevOps**: Posible pero requiere mas configuracion
- **Recomendacion**: Mantener en GitHub si ya funciona
