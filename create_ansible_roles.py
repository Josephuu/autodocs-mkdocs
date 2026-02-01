#!/usr/bin/env python3
import os

# Rol: Database (PostgreSQL)
db_tasks = '''---
# PostgreSQL Database Role
- name: Install PostgreSQL
  ansible.builtin.package:
    name: postgresql
    state: present

- name: Start and enable PostgreSQL
  ansible.builtin.service:
    name: postgresql
    state: started
    enabled: yes

- name: Create database
  ansible.builtin.postgresql_db:
    name: "{{ db_name }}"
    state: present
  become: true
  become_user: postgres

- name: Create database user
  ansible.builtin.postgresql_user:
    name: "{{ db_user }}"
    password: "{{ db_password }}"
    db: "{{ db_name }}"
    priv: ALL
    state: present
  become: true
  become_user: postgres

- name: Configure pg_hba for remote access
  ansible.builtin.template:
    src: pg_hba.conf.j2
    dest: /etc/postgresql/14/main/pg_hba.conf
  notify: Restart PostgreSQL
'''

db_defaults = '''---
# Default variables for database
db_name: myapp
db_user: appuser
db_password: changeme
db_port: 5432
postgresql_version: "14"
'''

db_handlers = '''---
- name: Restart PostgreSQL
  ansible.builtin.service:
    name: postgresql
    state: restarted
'''

# Rol: Monitoring (Prometheus + Grafana)
monitoring_tasks = '''---
# Monitoring Stack
- name: Create monitoring directory
  ansible.builtin.file:
    path: /opt/monitoring
    state: directory
    mode: '0755'

- name: Deploy Prometheus
  community.docker.docker_container:
    name: prometheus
    image: prom/prometheus:latest
    ports:
      - "9090:9090"
    volumes:
      - /opt/monitoring/prometheus.yml:/etc/prometheus/prometheus.yml
    restart_policy: always
    state: started

- name: Deploy Grafana
  community.docker.docker_container:
    name: grafana
    image: grafana/grafana:latest
    ports:
      - "3000:3000"
    env:
      GF_SECURITY_ADMIN_PASSWORD: "{{ grafana_admin_password }}"
    restart_policy: always
    state: started

- name: Deploy Node Exporter
  community.docker.docker_container:
    name: node-exporter
    image: prom/node-exporter:latest
    ports:
      - "9100:9100"
    restart_policy: always
    state: started
'''

monitoring_defaults = '''---
grafana_admin_password: admin123
prometheus_retention: 15d
'''

# Rol: Docker
docker_tasks = '''---
# Docker Installation
- name: Install required packages
  ansible.builtin.package:
    name:
      - apt-transport-https
      - ca-certificates
      - curl
      - gnupg
      - lsb-release
    state: present

- name: Add Docker GPG key
  ansible.builtin.apt_key:
    url: https://download.docker.com/linux/ubuntu/gpg
    state: present

- name: Add Docker repository
  ansible.builtin.apt_repository:
    repo: "deb [arch=amd64] https://download.docker.com/linux/ubuntu {{ ansible_distribution_release }} stable"
    state: present

- name: Install Docker
  ansible.builtin.package:
    name:
      - docker-ce
      - docker-ce-cli
      - containerd.io
      - docker-compose-plugin
    state: present

- name: Add user to docker group
  ansible.builtin.user:
    name: "{{ ansible_user }}"
    groups: docker
    append: yes

- name: Start Docker service
  ansible.builtin.service:
    name: docker
    state: started
    enabled: yes

- name: Deploy Portainer
  community.docker.docker_container:
    name: portainer
    image: portainer/portainer-ce:latest
    ports:
      - "9000:9000"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - portainer_data:/data
    restart_policy: always
    state: started
  when: install_portainer | bool
'''

docker_defaults = '''---
install_portainer: true
docker_users: []
'''

# Crear estructura
base_path = '/workspace/test-project/ansible/roles'

for role in ['database', 'monitoring', 'docker']:
    os.makedirs(f'{base_path}/{role}/tasks', exist_ok=True)
    os.makedirs(f'{base_path}/{role}/defaults', exist_ok=True)
    os.makedirs(f'{base_path}/{role}/handlers', exist_ok=True)

# Escribir archivos database
with open(f'{base_path}/database/tasks/main.yml', 'w') as f:
    f.write(db_tasks)
with open(f'{base_path}/database/defaults/main.yml', 'w') as f:
    f.write(db_defaults)
with open(f'{base_path}/database/handlers/main.yml', 'w') as f:
    f.write(db_handlers)

# Escribir archivos monitoring
with open(f'{base_path}/monitoring/tasks/main.yml', 'w') as f:
    f.write(monitoring_tasks)
with open(f'{base_path}/monitoring/defaults/main.yml', 'w') as f:
    f.write(monitoring_defaults)

# Escribir archivos docker
with open(f'{base_path}/docker/tasks/main.yml', 'w') as f:
    f.write(docker_tasks)
with open(f'{base_path}/docker/defaults/main.yml', 'w') as f:
    f.write(docker_defaults)

print('✅ Roles Ansible creados:')
print('  - webserver (ya existía)')
print('  - database (PostgreSQL)')
print('  - monitoring (Prometheus + Grafana + Node Exporter)')
print('  - docker (Docker CE + Portainer)')
