#!/bin/bash

# Répertoire de base
BASE_DIR="/home/toine-fa/SAE5.02/test_ansible"

# Réinitialiser les conteneurs et volumes
docker rm -f bind9 2>/dev/null || true
docker volume prune -f 2>/dev/null || true

# Préparer le projet
cd "$BASE_DIR"
docker-compose build
docker-compose up -d

# Exécuter Ansible
ansible-playbook -i inventory.yml playbook.yml


#printf "\n test ping"
#ansible-playbook -i inventory.yml playbook.yml --extra-vars "ansible_user=toine-fa"


#printf "test connexion ssh"
#ansible-playbook -i /home/toine-fa/SAE5.02/Deploiement_de_machine/inventaire.ini install_ssh.yml
#printf "test débogage"
#ansible-playbook -i /chemin/vers/inventaire.ini install_ssh.yml -vvvv

#cd /home/toine-fa/SAE5.02/playbook  # Déplacement vers le dossier contenant les playbooks
#ansible-playbook -i /home/toine-fa/SAE5.02/Deploiement_de_machine/inventaire.ini main.yml
