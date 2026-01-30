#!/usr/bin/env python3
import os

# Corregir compute/main.tf
compute_path = '/workspace/test-project/terraform/modules/compute/main.tf'
if os.path.exists(compute_path):
    with open(compute_path, 'r') as f:
        content = f.read()
    
    # Reemplazar \${ por ${
    content = content.replace('\\${', '${')
    
    with open(compute_path, 'w') as f:
        f.write(content)
    print(f'✅ Corregido: {compute_path}')

# Corregir aks/main.tf si existe
aks_path = '/workspace/test-project/terraform/modules/aks/main.tf'
if os.path.exists(aks_path):
    with open(aks_path, 'r') as f:
        content = f.read()
    
    content = content.replace('\\${', '${')
    
    with open(aks_path, 'w') as f:
        f.write(content)
    print(f'✅ Corregido: {aks_path}')

print('✅ Todos los archivos Terraform corregidos')
