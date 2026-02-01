#!/usr/bin/env python3
"""Generate mkdocs.yml dynamically based on detected resources."""

import os
from pathlib import Path

BASE_DIR = Path(__file__).parent.parent
TEST_PROJECT = BASE_DIR / "test-project"
MKDOCS_FILE = BASE_DIR / "mkdocs.yml"


def get_terraform_modules():
    """Get list of Terraform modules."""
    modules_dir = TEST_PROJECT / "terraform" / "modules"
    if not modules_dir.exists():
        return []

    modules = []
    for item in sorted(modules_dir.iterdir()):
        if item.is_dir() and (item / "main.tf").exists():
            modules.append(item.name)
    return modules


def get_ansible_roles():
    """Get list of Ansible roles."""
    roles_dir = TEST_PROJECT / "ansible" / "roles"
    if not roles_dir.exists():
        return []

    roles = []
    for item in sorted(roles_dir.iterdir()):
        if item.is_dir() and (item / "tasks").exists():
            roles.append(item.name)
    return roles


def get_docker_apps():
    """Get list of Docker apps."""
    apps_dir = TEST_PROJECT / "docker" / "apps"
    if not apps_dir.exists():
        return []

    apps = []
    for item in sorted(apps_dir.iterdir()):
        if item.is_dir() and (item / "Dockerfile").exists():
            apps.append(item.name)
    return apps


def get_helm_charts():
    """Get list of Helm charts."""
    charts_dir = TEST_PROJECT / "kubernetes" / "helm"
    if not charts_dir.exists():
        return []

    charts = []
    for item in sorted(charts_dir.iterdir()):
        if item.is_dir() and (item / "Chart.yaml").exists():
            charts.append(item.name)
    return charts


def generate_mkdocs():
    """Generate complete mkdocs.yml file."""

    tf_modules = get_terraform_modules()
    ansible_roles = get_ansible_roles()
    docker_apps = get_docker_apps()
    helm_charts = get_helm_charts()

    # Build Terraform section
    tf_section = "  - Terraform:\n      - terraform/index.md\n      - Modulos:\n"
    for mod in tf_modules:
        tf_section += f"          - {mod.capitalize()}: terraform/modules/{mod}.md\n"

    # Build Ansible section
    ansible_section = "  - Ansible:\n      - ansible/index.md\n      - Roles:\n"
    for role in ansible_roles:
        ansible_section += f"          - {role.capitalize()}: ansible/roles/{role}.md\n"

    # Build Docker section
    docker_section = "  - Docker:\n      - docker/index.md\n      - Aplicaciones:\n"
    for app in docker_apps:
        docker_section += f"          - {app.capitalize()}: docker/apps/{app}.md\n"

    # Build Kubernetes section
    k8s_section = "  - Kubernetes:\n      - kubernetes/index.md\n      - Helm Charts:\n"
    for chart in helm_charts:
        k8s_section += f"          - {chart.capitalize()}: kubernetes/helm/{chart}.md\n"

    # Complete mkdocs.yml content
    content = f"""site_name: Documentacion DevOps
site_description: Documentacion automatizada de infraestructura
site_author: DevOps Team

theme:
  name: material
  language: es
  palette:
    - scheme: default
      primary: indigo
      accent: indigo
  features:
    - navigation.tabs
    - search.suggest
    - content.code.copy

plugins:
  - search:
      lang: es

markdown_extensions:
  - pymdownx.highlight
  - pymdownx.superfences
  - admonition
  - pymdownx.emoji:
      emoji_index: !!python/name:material.extensions.emoji.twemoji
      emoji_generator: !!python/name:material.extensions.emoji.to_svg
  - toc:
      permalink: true
  - tables

nav:
  - Inicio: index.md

{tf_section}
{ansible_section}
{docker_section}
{k8s_section}
  - Runbooks:
      - runbooks/index.md

copyright: Copyright &copy; 2026 DevOps Team
"""

    MKDOCS_FILE.write_text(content, encoding="utf-8")
    print(f"Generated: {MKDOCS_FILE}")
    print(f"  - Terraform modules: {len(tf_modules)}")
    print(f"  - Ansible roles: {len(ansible_roles)}")
    print(f"  - Docker apps: {len(docker_apps)}")
    print(f"  - Helm charts: {len(helm_charts)}")


if __name__ == "__main__":
    generate_mkdocs()
    print("mkdocs.yml generated successfully!")
