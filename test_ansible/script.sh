#!/bin/bash

cd /home/toine-fa/
#git clone https://github.com/Zoultoetu/SAE5.02
cd /home/toine-fa/SAE5.02/test_ansible
docker-compose build
docker-compose up -d

ansible-playbook -i inventory.yml playbook.yml

printf "test ping"
ansible all -i /home/toine-fa/SAE5.02/Deploiement_de_machine/inventaire.ini -m ping
#printf "test connexion ssh"
#ansible-playbook -i /home/toine-fa/SAE5.02/Deploiement_de_machine/inventaire.ini install_ssh.yml
#printf "test débogage"
#ansible-playbook -i /chemin/vers/inventaire.ini install_ssh.yml -vvvv

#cd /home/toine-fa/SAE5.02/playbook  # Déplacement vers le dossier contenant les playbooks
#ansible-playbook -i /home/toine-fa/SAE5.02/Deploiement_de_machine/inventaire.ini main.yml
