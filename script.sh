#!/bin/bash

# Étape 4 : Lancer les conteneurs Docker
docker-compose up -d

# Étape 5 : Créer le fichier d'inventaire
cat <<EOF > ~/SAE5.02/Deploiement_de_machine/inventaire.ini
[dns]
192.168.0.2

[ad]
192.168.0.3

[ldap]
192.168.0.4

[home_assistant]
192.168.0.5

[openvpn]
192.168.0.6

[opnsense]
192.168.0.7

[client]
192.168.0.8

[all:vars]
ansible_connection=ssh
ansible_user=root
ansible_ssh_pass=root_password
EOF

# Étape 6 : Mettre à jour /etc/hosts
cat <<EOF > /etc/hosts
192.168.0.2    dns
192.168.0.3    ad
192.168.0.4    ldap
192.168.0.5    home_assistant
192.168.0.6    openvpn
192.168.0.7    opnsense
192.168.0.8    client
EOF

# Étape 7 : Lancer le playbook principal
cd ~/SAE5.02/playbook  # Déplacement vers le dossier contenant les playbooks
ansible-playbook -i ~/SAE5.02/Deploiement_de_machine/inventaire.ini main.yml
