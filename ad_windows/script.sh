#!/bin/bash

BASE_DIR="./SAE5.02/ad_windows"

echo "=== Déploiement automatique de la machine VPN ==="

# Étape 1 : Réinitialisation des conteneurs
echo "=== Réinitialisation des conteneurs et volumes ==="
docker rm -f vpn_ad 2>/dev/null || true
docker volume prune -f 2>/dev/null || true

pwd
# Étape 2 : Construction et démarrage du conteneur
echo "=== Construction et démarrage du conteneur ==="
cd "$BASE_DIR" || exit
sudo docker compose up -d --build

# Étape 3 : Pause pour s'assurer que le conteneur est prêt
echo "=== Attente du démarrage du conteneur ==="
sleep 10

# Étape 4 : Configuration avec Ansible
echo "=== Configuration des services avec Ansible ==="
cd ../..
ansible-playbook -i "$BASE_DIR/inventaire.ini" "$BASE_DIR/playbook.yml" -e "samba_username=root samba_password=root"

echo "=== Déploiement terminé ==="
