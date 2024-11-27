#!/bin/bash

# Répertoire de base pour Bind9
BIND9_DIR="./SAE5.02/test_ansible/roles/bind9"
SAMBA_DIR="./SAE5.02/test_ansible/roles/samba"

echo "=== Réinitialisation des conteneurs et volumes Bind9 ==="
cd "$BIND9_DIR"
docker rm -f bind9 2>/dev/null || true
docker volume prune -f 2>/dev/null || true

echo "=== Préparation et démarrage de Bind9 ==="
docker-compose build
docker-compose up -d

echo "=== Passage à la configuration de Samba AD ==="
cd "$SAMBA_DIR"
docker rm -f ad 2>/dev/null || true
docker-compose build
docker-compose up -d

echo "=== Exécution de la configuration DNS et AD avec Ansible ==="
ansible-playbook -i inventaire.ini "$BIND9_DIR/playbook.yml"
ansible-playbook -i inventaire.ini "$SAMBA_DIR/playbook.yml"

docker stop ad
docker start ad
