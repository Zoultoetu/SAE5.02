#!/bin/bash

cd ~
git clone https://github.com/Zoultoetu/SAE5.02
cd ~/SAE5.02/Deploiement_de_machine
docker-compose up
touch ~/SAE5.02/Deploiement_de_machine/inventaire.ini
cat <<final > ~/SAE5.02/Deploiement_de_machine/inventaire.ini

final

