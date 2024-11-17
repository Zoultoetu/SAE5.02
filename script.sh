#!/bin/bash

cd /home/toine-fa/
#git clone https://github.com/Zoultoetu/SAE5.02
cd /home/toine-fa/SAE5.02/Deploiement_de_machine

docker-compose up -d

cat <<EOF > /etc/hosts
192.168.0.2    dns
192.168.0.3    ad
192.168.0.4    ldap
192.168.0.5    home_assistant
192.168.0.6    openvpn
192.168.0.7    opnsense
192.168.0.8    client
EOF

printf "test ping"
ansible all -i /home/toine-fa/SAE5.02/Deploiement_de_machine/inventaire.ini -m ping
printf "test connexion ssh"
ansible-playbook -i /home/toine-fa/SAE5.02/Deploiement_de_machine/inventaire.ini install_ssh.yml
#printf "test débogage"
#ansible-playbook -i /chemin/vers/inventaire.ini install_ssh.yml -vvvv

#cd /home/toine-fa/SAE5.02/playbook  # Déplacement vers le dossier contenant les playbooks
#ansible-playbook -i /home/toine-fa/SAE5.02/Deploiement_de_machine/inventaire.ini main.yml
