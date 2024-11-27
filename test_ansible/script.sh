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

cd ../../../.. # Retour au répertoire racine du projet
pwd
ansible-playbook -i inventaire.ini "$BIND9_DIR/playbook.yml"
docker stop dns
docker start dns

pwd
ansible-playbook -i inventaire.ini "$SAMBA_DIR/playbook.yml"
docker stop dns
docker start dns
docker stop ad
docker start ad
# Lancer la configuration de l'AD après DNS
# echo "=== Passage à la configuration de l'Active Directory (AD) ==="
# cd "/home/toine-fa/SAE5.02/test_ansible/roles/samba"
# sudo bash ./script.sh  # Appel du script de configuration de l'AD
