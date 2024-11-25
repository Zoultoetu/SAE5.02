#!/bin/bash

# Répertoire de base pour Samba AD
BASE_DIR="./SAE5.02/test_ansible/roles/samba"

# Réinitialiser les conteneurs et volumes liés à Samba AD
docker rm -f ad 2>/dev/null || true
docker volume prune -f 2>/dev/null || true

# Construire et démarrer le conteneur AD
cd "$BASE_DIR"
docker-compose build
docker-compose up -d

# Exécuter Ansible pour configurer l'AD
ansible-playbook -i inventaire.ini playbook.yml

# Redémarrer le conteneur pour appliquer les configurations
docker stop ad
docker start ad
