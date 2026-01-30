<!-- DOCSIBLE START -->

# 📃 Role overview

## webserver

Description: Install and configure NGINX web server

| Field                | Value           |
|--------------------- |-----------------|
| Readme update        | 2026/01/29 |

### Defaults

**These are static variables with lower priority**

#### File: defaults/main.yml

| Var          | Type         | Value       |
|--------------|--------------|-------------|
| [nginx_port](defaults/main.yml#L5)   | int | `80` |
| [nginx_ssl_port](defaults/main.yml#L6)   | int | `443` |
| [nginx_worker_processes](defaults/main.yml#L7)   | str | `auto` |
| [nginx_worker_connections](defaults/main.yml#L8)   | int | `1024` |
| [ssl_enabled](defaults/main.yml#L11)   | bool | `False` |
| [ssl_certificate_path](defaults/main.yml#L12)   | str | `/etc/ssl/certs/nginx.crt` |
| [ssl_certificate_key_path](defaults/main.yml#L13)   | str | `/etc/ssl/private/nginx.key` |
| [server_name](defaults/main.yml#L16)   | str | `localhost` |
| [document_root](defaults/main.yml#L17)   | str | `/var/www/html` |
| [client_max_body_size](defaults/main.yml#L20)   | str | `20M` |
| [keepalive_timeout](defaults/main.yml#L21)   | int | `65` |
| [gzip_enabled](defaults/main.yml#L22)   | bool | `True` |
| [access_log_path](defaults/main.yml#L25)   | str | `/var/log/nginx/access.log` |
| [error_log_path](defaults/main.yml#L26)   | str | `/var/log/nginx/error.log` |
| [log_level](defaults/main.yml#L27)   | str | `warn` |
| [security_headers_enabled](defaults/main.yml#L30)   | bool | `True` |
| [hsts_enabled](defaults/main.yml#L31)   | bool | `False` |
| [hsts_max_age](defaults/main.yml#L32)   | int | `31536000` |
| [custom_error_pages](defaults/main.yml#L35)   | dict | `{}` |
| [custom_error_pages.**404**](defaults/main.yml#L36)   | str | `/404.html` |
| [custom_error_pages.**500**](defaults/main.yml#L37)   | str | `/50x.html` |

### Vars

**These are variables with higher priority**

#### File: vars/main.yml

| Var          | Type         | Value       |
|--------------|--------------|-------------|
| [nginx_package_name](vars/main.yml#L4)   | str | `nginx` |
| [nginx_service_name](vars/main.yml#L5)   | str | `nginx` |
| [nginx_config_dir](vars/main.yml#L6)   | str | `/etc/nginx` |
| [nginx_sites_available](vars/main.yml#L7)   | str | `/etc/nginx/sites-available` |
| [nginx_sites_enabled](vars/main.yml#L8)   | str | `/etc/nginx/sites-enabled` |
| [nginx_user](vars/main.yml#L11)   | str | `www-data` |
| [nginx_group](vars/main.yml#L12)   | str | `www-data` |

### Tasks

#### File: tasks/main.yml

| Name | Module | Has Conditions | Tags |
| ---- | ------ | -------------- | -----|
| Update apt cache | apt | True | nginx,packages |
| Install NGINX | apt | False | nginx,packages |
| Ensure NGINX service is enabled | systemd | False | nginx,service |
| Create document root directory | file | False | nginx,config |
| Deploy NGINX main configuration | template | False | nginx,config |
| Deploy site configuration | template | False | nginx,config |
| Enable site | file | False | nginx,config |
| Deploy index.html | template | False | nginx,content |
| Configure SSL certificates | block | False | nginx,ssl |
| Copy SSL certificate | copy | True |  |
| Copy SSL private key | copy | True |  |
| Ensure NGINX is running | systemd | False | nginx,service |
| Verify NGINX is listening |  | False | nginx,verification |

## Author Information

DevOps Team

#### License

MIT

#### Minimum Ansible Version

2.9

#### Platforms

- **Ubuntu**: ['focal', 'jammy']
- **Debian**: ['bullseye']

#### Dependencies

No dependencies specified.
<!-- DOCSIBLE END -->
