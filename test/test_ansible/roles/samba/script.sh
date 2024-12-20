#!/bin/bash

# Répertoire de base pour Samba AD
BASE_DIR="./SAE5.02/test_ansible/roles/samba"

echo "=== Réinitialisation des conteneurs et volumes AD ==="
docker rm -f ad 2>/dev/null || true
docker volume prune -f 2>/dev/null || true

echo "=== Préparation et démarrage de Samba AD ==="
cd "$BASE_DIR"
docker-compose build
docker-compose up -d

echo "=== Exécution de la configuration Samba avec Ansible ==="
ansible-playbook -i inventaire.ini playbook.yml

docker stop ad
docker start ad
