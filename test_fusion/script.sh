#!/bin/bash

BASE_DIR="./SAE5.02/test_fusion"

echo "=== Déploiement automatique de Bind9 et Samba ==="

# Étape 1 : Réinitialisation des conteneurs
echo "=== Réinitialisation des conteneurs et volumes ==="
docker rm -f dns_ad 2>/dev/null || true
docker volume prune -f 2>/dev/null || true

# Étape 2 : Construction et démarrage du conteneur
echo "=== Construction et démarrage du conteneur ==="
cd "$BASE_DIR" || exit
docker-compose up -d --build

# Étape 3 : Pause pour s'assurer que le conteneur est prêt
echo "=== Attente du démarrage du conteneur ==="
sleep 10
# Étape 4 : Exécution du playbook Ansible
echo "=== Configuration des services avec Ansible ==="
cd ../..
ansible-playbook -i "$BASE_DIR/inventaire.ini" "$BASE_DIR/playbook.yml"

echo "=== Démarrage des services Bind9 et Samba ==="
    docker exec -it dns service named start
    docker exec -it dns service smbd start
# docker stop dns_ad
# docker start dns_ad

echo "Europe/Paris" > /etc/timezone
dpkg-reconfigure --frontend noninteractive tzdata

echo "=== Déploiement terminé ==="
