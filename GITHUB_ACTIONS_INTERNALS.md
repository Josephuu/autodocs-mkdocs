# Como Funciona GitHub Actions por Dentro

## Concepto Basico

GitHub Actions es un sistema de **automatacion basado en eventos** que ejecuta codigo en maquinas virtuales (runners) cuando ocurren cosas en tu repositorio.

## Arquitectura de Componentes

### 1. Eventos (Triggers)

Los eventos son **ganchos** que disparan el workflow:

```yaml
on:
  push:                    # Evento: alguien hizo push
    branches: [main]       # Filtro: solo en rama main
  pull_request:            # Evento: se creo/modifico PR
  schedule:                # Evento: cron job
    - cron: '0 0 * * *'    # Filtro: todos los dias a medianoche
  workflow_dispatch:       # Evento: manual (boton)
```

**Lista de eventos disponibles**:
- `push` - Codigo subido
- `pull_request` - PR creado/actualizado/cerrado
- `issues` - Issue creado/modificado
- `release` - Release publicado
- `schedule` - Cron job programado
- `workflow_dispatch` - Manual (boton verde)

### 2. Runners (Las VMs)

Un **runner** es una maquina virtual que ejecuta tus jobs.

#### Tipos de Runners

| Tipo | Descripcion | Uso |
|------|-------------|-----|
| **GitHub-hosted** | VMs administradas por GitHub | Uso comun (gratis 2000 min/mes) |
| **Self-hosted** | Tu propia maquina fisica/VM | Casos especiales, mas control |

#### Runners GitHub-hosted disponibles

```yaml
runs-on: ubuntu-latest    # Ubuntu 22.04 (recomendado)
runs-on: ubuntu-20.04     # Ubuntu 20.04
runs-on: windows-latest   # Windows Server 2022
runs-on: macos-latest     # macOS 12/13
```

**Ciclo de vida de un runner**:
1. **Provisionamiento**: GitHub crea una VM limpia
2. **Setup**: Instala herramientas basicas (git, node, python, docker)
3. **Ejecucion**: Corre tus steps
4. **Destruccion**: La VM se destruye (sin persistencia)

**Caracteristicas importantes**:
- **Frescas**: Cada job corre en una VM nueva
- **Sin estado**: Los archivos no se guardan entre jobs
- **Aisladas**: No pueden comunicarse entre si
- **Limitadas**: 6 horas maximo por job

### 3. Jobs y Steps

```yaml
jobs:                          # Puedes tener N jobs
  build:                       # Nombre del job
    runs-on: ubuntu-latest     # Que runner usar
    
    steps:                     # Lista de pasos secuenciales
      - name: Checkout         # Nombre descriptivo
        uses: actions/checkout@v4   # Action predefinida
        
      - name: Instalar dependencias
        run: pip install -r requirements.txt   # Comando shell
        
      - name: Correr tests
        run: pytest
```

**Diferencia clave**:
- **Job**: Unidad de trabajo que corre en un runner
- **Step**: Paso individual dentro de un job (comparte el mismo runner)

### 4. Actions (Bloques Reutilizables)

Las **actions** son scripts empaquetados que puedes reutilizar.

**Tipos de actions**:

| Tipo | Descripcion | Ejemplo |
|------|-------------|---------|
| **JavaScript** | Node.js | actions/checkout |
| **Composite** | Shell script | Setup de herramientas |
| **Docker** | Container | Herramientas especificas |

**Como se ejecutan**:

```yaml
steps:
  # Usa una action del marketplace
  - uses: actions/setup-python@v5
    with:
      python-version: '3.11'
      
  # O corre comandos directamente
  - run: echo "Hola mundo"
    shell: bash
```

### 5. Artifacts y Caché

#### Artifacts (Archivos de salida)

Los artifacts son **archivos que persisten** entre jobs o despues del workflow.

```yaml
jobs:
  build:
    steps:
      - run: mkdocs build   # Genera site/
      
      - uses: actions/upload-artifact@v3
        with:
          name: site
          path: site/        # Carpeta a guardar
          
  deploy:
    needs: build             # Espera que termine build
    steps:
      - uses: actions/download-artifact@v3
        with:
          name: site         # Descarga el artifact
          
      - run: deploy site/
```

**Caracteristicas**:
- Se almacenan en GitHub (temporalmente)
- Disponibles entre jobs del mismo workflow
- Se pueden descargar desde la UI
- Retencion: 90 dias por defecto

#### Cache (Caché entre ejecuciones)

El cache **acelera builds** guardando dependencias.

```yaml
steps:
  - uses: actions/cache@v3
    with:
      path: |
        ~/.cache/pip
        ~/.npm
      key: ${{ runner.os }}-deps-${{ hashFiles('**/requirements.txt') }}
```

**Diferencia: Artifacts vs Cache**:
- **Artifacts**: Output del workflow (site/, binarios, reportes)
- **Cache**: Input reutilizable (dependencias, node_modules)

## Flujo de Ejecucion Detallado

### Paso 1: Deteccion del Evento

```
Usuario hace push a main
        |
        v
GitHub detecta el evento "push"
        |
        v
Busca workflows en .github/workflows/
```

### Paso 2: Parseo del Workflow

```
Lee docs.yml
        |
        v
Resuelve variables (${{ github.ref }}, secrets)
        |
        v
Determina matriz de jobs (si hay strategy.matrix)
```

### Paso 3: Asignacion de Runners

```
Job: build -> Pide runner ubuntu-latest
        |
        v
GitHub busca runner disponible
        |
        v
Provisiona VM nueva (toma ~10-30 segundos)
        |
        v
Runner esta listo, comienza ejecucion
```

### Paso 4: Ejecucion de Steps

```
Step 1: actions/checkout
  - Clona el repo en /home/runner/work/repo/repo
  - Configura git
  
Step 2: Instalar dependencias
  - Corre pip install
  - Modifica el filesystem del runner
  
Step 3: Build
  - Genera archivos
  - Todo queda en el runner (temporal)
```

### Paso 5: Upload Artifacts

```
Step: upload-artifact
  - Comprime la carpeta
  - Sube a storage de GitHub
  - Asocia al workflow run
```

### Paso 6: Cleanup

```
Job termina
        |
        v
Runner se destruye completamente
        |
        v
VM se recicla (nada persiste)
```

## Variables y Contextos

### Contextos Disponibles

```yaml
steps:
  - run: |
      echo "Repo: ${{ github.repository }}"
      echo "Ref: ${{ github.ref }}"
      echo "SHA: ${{ github.sha }}"
      echo "Actor: ${{ github.actor }}"
      echo "Workflow: ${{ github.workflow }}"
      echo "Run ID: ${{ github.run_id }}"
```

### Secrets y Variables

**Secrets** (encriptados):
```yaml
steps:
  - run: |
      echo "${{ secrets.DEPLOY_TOKEN }}"
```

**Variables** (visibles):
```yaml
steps:
  - run: |
      echo "${{ vars.PROJECT_NAME }}"
```

**Environment Variables**:
```yaml
env:
  NODE_ENV: production
  
steps:
  - run: echo $NODE_ENV   # Accede como variable de shell
```

## Networking y Seguridad

### Acceso a Internet

Los runners tienen **acceso completo a internet**:
```yaml
steps:
  - run: |
      curl https://api.github.com
      wget https://example.com/file.zip
      pip install requests
```

### Limitaciones de Seguridad

- **No pueden acceder a otros repositorios** (sin token)
- **No persistente**: Todo se borra al terminar
- **Sandboxed**: Ejecutan en contenedores/VMs aislados

### Tokens Automaticos

GitHub genera un token temporal `GITHUB_TOKEN`:

```yaml
steps:
  - uses: actions/checkout@v4
    with:
      token: ${{ secrets.GITHUB_TOKEN }}   # Se inyecta automaticamente
```

**Permisos configurables**:
```yaml
permissions:
  contents: read      # Leer codigo
  pages: write        # Escribir en GitHub Pages
  id-token: write     # OIDC para cloud providers
```

## Comparacion: GitHub Actions vs Servidor Propio

| Aspecto | GitHub Actions | Servidor Propio |
|---------|---------------|-----------------|
| **Setup** | Cero configuracion | Instalar todo manual |
| **Mantenimiento** | GitHub lo hace | Tu responsabilidad |
| **Escalabilidad** | Ilimitado (pago) | Limitado por hardware |
| **Seguridad** | Sandbox aislado | Depende de tu config |
| **Persistencia** | Ninguna (fresco cada vez) | Puedes guardar estado |
| **Costo** | Gratis 2000 min/mes | Costo de electricidad/servidor |

## Diagrama de Arquitectura

```
Usuario
   |
   | push a main
   v
+------------------+
|   GitHub Repo    |
|  (almacena yaml) |
+------------------+
   |
   | Event: push
   v
+------------------+
|  GitHub Actions  |
|  (orquestador)   |
+------------------+
   |
   | "Necesito runner"
   v
+------------------+
|  GitHub Runners  |
|  (pool de VMs)   |
+------------------+
   |
   | Provisiona VM
   v
+------------------+
|  Ubuntu Latest   |
|  (runner limpio) |
|                  |
|  1. Checkout     |
|  2. Install deps |
|  3. Run commands |
|  4. Upload artif |
|                  |
|  [DESTRUIR VM]   |
+------------------+
   |
   | Deploy to Pages
   v
+------------------+
|  GitHub Pages    |
|  (hosting web)   |
+------------------+
```

## Resumen Ejecutivo

| Concepto | Explicacion Simple |
|----------|-------------------|
| **Runner** | Una PC virtual que GitHub presta para ejecutar tu codigo |
| **Job** | Un grupo de tareas que corren en la misma PC |
| **Step** | Una tarea individual (comando o action) |
| **Action** | Un programa reutilizable que hace algo especifico |
| **Artifact** | Archivos que quedan guardados despues de la ejecucion |
| **Event** | Lo que dispara todo (push, PR, manual) |

**Regla de oro**: Cada vez que haces push, GitHub crea una PC nueva, ejecuta tus comandos, y luego destruye la PC. Nada queda guardado en ella (salvo artifacts).
