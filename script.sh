#!/bin/bash

cd ~
git clone https://github.com/Zoultoetu/SAE5.02
cd ~/SAE5.02/Deploiement_de_machine
docker-compose up
touch ~/SAE5.02/Deploiement_de_machine/inventaire.ini
cat <<final > ~/SAE5.02/Deploiement_de_machine/inventaire.ini
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
    ansible_connection=docker
final

cat <<final > /etc/hosts
    192.168.0.2 dns 
    
    192.168.0.3 ad
    
    192.168.0.4 ldap
    
    192.168.0.5 home_assistant
    
    192.168.0.6 openvpn
    
    192.168.0.7 opnsense
    
    192.168.0.8 client

final

ansible-playbook -i ~/SAE5.02/Deploiement_de_machine/inventaire.ini ~/main.yml

