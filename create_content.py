#!/usr/bin/env python3
import os

# Crear directorios base
os.makedirs('/workspace/test-project/terraform/modules/vpc', exist_ok=True)
os.makedirs('/workspace/test-project/ansible/roles/webserver/tasks', exist_ok=True)
os.makedirs('/workspace/test-project/ansible/roles/webserver/defaults', exist_ok=True)
os.makedirs('/workspace/test-project/ansible/roles/webserver/handlers', exist_ok=True)
os.makedirs('/workspace/test-project/ansible/roles/webserver/templates', exist_ok=True)

# ========== TERRAFORM ==========

main_tf = '''# =============================================================================
# Módulo: VPC para Azure
# Descripción: Crea una Virtual Network con subnets públicas y privadas
# =============================================================================

resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  tags                = var.tags
}

resource "azurerm_subnet" "public" {
  count                = length(var.public_subnets)
  name                 = "public-subnet-${count.index + 1}"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.public_subnets[count.index]]
}

resource "azurerm_subnet" "private" {
  count                = length(var.private_subnets)
  name                 = "private-subnet-${count.index + 1}"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.private_subnets[count.index]]
}

resource "azurerm_network_security_group" "public" {
  name                = "${var.vnet_name}-public-nsg"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  tags                = var.tags

  security_rule {
    name                       = "AllowHTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowHTTPS"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "public" {
  count                     = length(azurerm_subnet.public)
  subnet_id                 = azurerm_subnet.public[count.index].id
  network_security_group_id = azurerm_network_security_group.public.id
}
'''

variables_tf = '''# =============================================================================
# Variables del Módulo VPC
# =============================================================================

variable "resource_group_name" {
  description = "Nombre del Resource Group de Azure"
  type        = string
}

variable "location" {
  description = "Región de Azure donde se desplegará la infraestructura"
  type        = string
  default     = "eastus"
}

variable "vnet_name" {
  description = "Nombre de la Virtual Network"
  type        = string
}

variable "address_space" {
  description = "Espacio de direcciones IP de la VNet (CIDR)"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "public_subnets" {
  description = "Lista de CIDRs para subnets públicas"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "Lista de CIDRs para subnets privadas"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "environment" {
  description = "Ambiente de despliegue (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "Tags para todos los recursos"
  type        = map(string)
  default = {
    ManagedBy = "Terraform"
    Project   = "Infrastructure"
  }
}
'''

outputs_tf = '''# =============================================================================
# Outputs del Módulo VPC
# =============================================================================

output "vnet_id" {
  description = "ID de la Virtual Network creada"
  value       = azurerm_virtual_network.this.id
}

output "vnet_name" {
  description = "Nombre de la Virtual Network"
  value       = azurerm_virtual_network.this.name
}

output "public_subnet_ids" {
  description = "IDs de las subnets públicas"
  value       = azurerm_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs de las subnets privadas"
  value       = azurerm_subnet.private[*].id
}

output "nsg_id" {
  description = "ID del Network Security Group"
  value       = azurerm_network_security_group.public.id
}

output "resource_group_name" {
  description = "Nombre del Resource Group"
  value       = azurerm_resource_group.this.name
}
'''

# Escribir archivos Terraform
with open('/workspace/test-project/terraform/modules/vpc/main.tf', 'w') as f:
    f.write(main_tf)

with open('/workspace/test-project/terraform/modules/vpc/variables.tf', 'w') as f:
    f.write(variables_tf)

with open('/workspace/test-project/terraform/modules/vpc/outputs.tf', 'w') as f:
    f.write(outputs_tf)

print('✓ Terraform VPC module creado')
print('  - main.tf')
print('  - variables.tf')
print('  - outputs.tf')

# ========== ANSIBLE ==========

tasks_main = '''---
# =============================================================================
# Tasks: Webserver (NGINX)
# Descripción: Instala y configura NGINX como servidor web
# =============================================================================

- name: Update apt cache
  ansible.builtin.apt:
    update_cache: yes
    cache_valid_time: 3600
  when: ansible_os_family == "Debian"

- name: Install NGINX
  ansible.builtin.package:
    name: nginx
    state: present

- name: Create NGINX configuration from template
  ansible.builtin.template:
    src: nginx.conf.j2
    dest: /etc/nginx/nginx.conf
    owner: root
    group: root
    mode: '0644'
  notify: Restart NGINX

- name: Create site configuration
  ansible.builtin.template:
    src: default-site.j2
    dest: /etc/nginx/sites-available/default
    owner: root
    group: root
    mode: '0644'
  notify: Reload NGINX

- name: Ensure NGINX is started and enabled
  ansible.builtin.service:
    name: nginx
    state: started
    enabled: yes

- name: Configure firewall for HTTP
  ansible.builtin.ufw:
    rule: allow
    port: "{{ nginx_port }}"
    proto: tcp
  when: configure_firewall | bool

- name: Configure firewall for HTTPS
  ansible.builtin.ufw:
    rule: allow
    port: "{{ nginx_ssl_port }}"
    proto: tcp
  when:
    - configure_firewall | bool
    - enable_ssl | bool
'''

defaults_main = '''---
# =============================================================================
# Default Variables: Webserver
# =============================================================================

# Puerto HTTP para NGINX
nginx_port: 80

# Puerto HTTPS para NGINX
nginx_ssl_port: 443

# Número de worker processes (auto = número de CPUs)
nginx_worker_processes: auto

# Conexiones por worker
nginx_worker_connections: 1024

# Habilitar SSL
enable_ssl: false

# Rutas de certificados SSL (cuando enable_ssl: true)
ssl_certificate: /etc/nginx/ssl/cert.pem
ssl_certificate_key: /etc/nginx/ssl/key.pem

# Configurar firewall UFW
configure_firewall: true

# Página de error personalizada
nginx_error_pages:
  404: /404.html
  500: /500.html

# Límite de tamaño de upload
nginx_client_max_body_size: 10M
'''

handlers_main = '''---
# =============================================================================
# Handlers: Webserver
# =============================================================================

- name: Restart NGINX
  ansible.builtin.service:
    name: nginx
    state: restarted

- name: Reload NGINX
  ansible.builtin.service:
    name: nginx
    state: reloaded
'''

template_nginx = '''user {{ nginx_user | default('www-data') }};
worker_processes {{ nginx_worker_processes }};
pid /run/nginx.pid;

events {
    worker_connections {{ nginx_worker_connections }};
    use epoll;
    multi_accept on;
}

http {
    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    keepalive_timeout 65;
    types_hash_max_size 2048;
    client_max_body_size {{ nginx_client_max_body_size }};

    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    # Logging
    access_log /var/log/nginx/access.log;
    error_log /var/log/nginx/error.log;

    # Gzip
    gzip on;
    gzip_vary on;
    gzip_proxied any;
    gzip_comp_level 6;
    gzip_types text/plain text/css text/xml application/json application/javascript application/rss+xml application/atom+xml image/svg+xml;

    include /etc/nginx/conf.d/*.conf;
    include /etc/nginx/sites-enabled/*;
}
'''

# Escribir archivos Ansible
with open('/workspace/test-project/ansible/roles/webserver/tasks/main.yml', 'w') as f:
    f.write(tasks_main)

with open('/workspace/test-project/ansible/roles/webserver/defaults/main.yml', 'w') as f:
    f.write(defaults_main)

with open('/workspace/test-project/ansible/roles/webserver/handlers/main.yml', 'w') as f:
    f.write(handlers_main)

with open('/workspace/test-project/ansible/roles/webserver/templates/nginx.conf.j2', 'w') as f:
    f.write(template_nginx)

print('')
print('✓ Ansible Webserver role creado')
print('  - tasks/main.yml')
print('  - defaults/main.yml')
print('  - handlers/main.yml')
print('  - templates/nginx.conf.j2')
print('')
print('=' * 50)
print('¡Contenido listo para commit!')
print('=' * 50)
