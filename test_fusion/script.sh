#!/bin/bash

BASE_DIR="./SAE5.02/test_fusion"

echo "=== Déploiement automatique ==="

# Étape 1 : Réinitialisation
echo "=== Réinitialisation des conteneurs ==="
docker rm -f fusion_service 2>/dev/null || true
docker volume prune -f 2>/dev/null || true
pwd
# Étape 2 : Construction et démarrage du conteneur
echo "=== Construction et démarrage du conteneur ==="
cd "$BASE_DIR" || exit
docker-compose up -d --build
cd
pwd
# Étape 3 : Exécution du playbook Ansible
echo "=== Configuration des services avec Ansible ==="
ansible-playbook -i "$BASE_DIR/inventaire.ini" "$BASE_DIR/playbook.yml"

echo "=== Déploiement terminé ==="
