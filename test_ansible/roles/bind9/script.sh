#!/bin/bash

# Répertoire de base
BASE_DIR="/home/toine-fa/SAE5.02/test_ansible/roles/bind9"

# Réinitialiser les conteneurs et volumes
docker rm -f bind9 2>/dev/null || true
docker volume prune -f 2>/dev/null || true

# Préparer le projet
cd "$BASE_DIR"
docker-compose build
docker-compose up -d

# Exécuter Ansible
ansible-playbook -i inventory.yml playbook.yml


