#!/bin/bash
chmod 777 ~/SAE5.02/test_ansible/roles/samba/script.sh
# Répertoire de base pour Bind9
BASE_DIR_DNS="./SAE5.02/test_ansible/roles/bind9"

# Répertoire de base pour l'AD
BASE_DIR_AD="/home/toine-fa/SAE5.02/test_ansible/roles/bind9"

echo "=== Réinitialisation des conteneurs et volumes DNS ==="
docker rm -f bind9 2>/dev/null || true
docker volume prune -f 2>/dev/null || true

echo "=== Préparation et démarrage de Bind9 ==="
cd "$BASE_DIR_DNS"
docker-compose build
docker-compose up -d

echo "=== Exécution de la configuration DNS avec Ansible ==="
ansible-playbook -i inventaire.ini playbook.yml

docker stop dns
docker start dns

# Lancer la configuration de l'AD après DNS
echo "=== Passage à la configuration de l'Active Directory (AD) ==="
cd "$BASE_DIR_AD"
./script.sh  # Appel du script de configuration de l'AD
