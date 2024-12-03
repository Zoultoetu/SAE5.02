#!/bin/bash

# Répertoires pour Bind9 et Samba
BIND9_DIR="./SAE5.02/test_fusion/roles/bind9"
SAMBA_DIR="./SAE5.02/test_fusion/roles/samba"
INVENTORY="./SAE5.02/test_fusion/inventaire.ini"

echo "=== Déploiement automatique de Bind9 et Samba AD ==="

# Étape 1 : Réinitialiser les conteneurs et volumes
echo "=== Réinitialisation des conteneurs et volumes ==="
cd "$BIND9_DIR"
docker rm -f dns 2>/dev/null || true
docker rm -f ad 2>/dev/null || true
docker volume prune -f 2>/dev/null || true

# Étape 2 : Démarrer Bind9
echo "=== Déploiement de Bind9 ==="
docker-compose down 2>/dev/null || true
docker-compose up -d --build

# Étape 3 : Configurer Bind9 avec Ansible
echo "=== Configuration de Bind9 avec Ansible ==="
ansible-playbook -i "$INVENTORY" "$BIND9_DIR/playbook.yml"

# Étape 4 : Démarrer Samba AD
echo "=== Déploiement de Samba AD ==="
cd "$SAMBA_DIR"
docker-compose down 2>/dev/null || true
docker-compose up -d --build

# Étape 5 : Configurer Samba AD avec Ansible
echo "=== Configuration de Samba AD avec Ansible ==="
ansible-playbook -i "$INVENTORY" "$SAMBA_DIR/playbook.yml"

echo "=== Déploiement terminé ==="
