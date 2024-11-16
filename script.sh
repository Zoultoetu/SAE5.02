#!/bin/bash

# Réseau Docker
docker network create \
  --driver bridge \
  --subnet=192.168.0.0/24 \
  internal_net

# Serveur DNS
docker run -d \
  --name dns \
  --network internal_net \
  --ip 192.168.0.2 \
  -e BIND_USER=root \
  -p 533:53/udp \
  -v ./config/dns:/data \
  --restart always \
  sameersbn/bind:latest \
  bash -c "apt-get update && apt-get install -y openssh-server && service ssh start"

# Active Directory avec Samba
docker run -d \
  --name ad \
  --network internal_net \
  --ip 192.168.0.3 \
  -e TZ=Europe/Paris \
  -e SAMBA_DOMAIN=domaine_toinefa \
  -e SAMBA_REALM=domaine.toinefa \
  -e SAMBA_ADMIN_PASSWORD=root \
  -p 389:389 \
  -p 445:445 \
  -p 3268:3268 \
  -v ./config/ad:/etc/samba \
  --restart always \
  dperson/samba \
  "/sbin/tini -- /usr/sbin/smbd -D"

# LDAP
docker run -d \
  --name ldap \
  --network internal_net \
  --ip 192.168.0.4 \
  -e LDAP_ORGANISATION="Mon Organisation" \
  -e LDAP_DOMAIN="domaine.local" \
  -e LDAP_ADMIN_PASSWORD=admin_password \
  -p 3391:389 \
  -p 636:636 \
  -v ./config/ldap:/var/lib/ldap \
  -v ./config/slapd.d:/etc/ldap/slapd.d \
  --restart always \
  osixia/openldap:latest \
  bash -c "apt-get update && apt-get install -y openssh-server && service ssh start && /container/tool/run"

# Home Assistant
docker run -d \
  --name home_assistant \
  --network internal_net \
  --ip 192.168.0.5 \
  -e TZ=Europe/Paris \
  -p 8123:8123 \
  -v ./config/home_assistant:/config \
  --restart always \
  homeassistant/home-assistant:stable \
  bash -c "apt-get update && apt-get install -y openssh-server && service ssh start && /init"

# Serveur VPN OpenVPN
docker run -d \
  --name openvpn \
  --cap-add NET_ADMIN \
  --network internal_net \
  --ip 192.168.0.6 \
  -e TZ=Europe/Paris \
  -p 1194:1194/udp \
  -v ./config/openvpn:/etc/openvpn \
  --restart always \
  kylemanna/openvpn:latest \
  ovpn_run

# Pare-feu OPNsense
docker run -d \
  --name opnsense \
  --network internal_net \
  --ip 192.168.0.7 \
  -e TZ=Europe/Paris \
  -p 8080:80 \
  -v ./config/opnsense:/etc/nginx/conf.d \
  --restart always \
  nginx:latest \
  bash -c "apt-get update && apt-get install -y openssh-server && service ssh start"

# Machine Client
docker run -d \
  --name client \
  --network internal_net \
  --ip 192.168.0.8 \
  -e DISPLAY \
  --restart always \
  debian:latest \
  bash -c "apt-get update && apt-get install -y xfce4 openssh-server && service ssh start"


cd /home/toine-fa/
git clone https://github.com/Zoultoetu/SAE5.02
cd /home/toine-fa/SAE5.02/Deploiement_de_machine

#docker-compose up -d

cat <<EOF > /home/toine-fa/SAE5.02/Deploiement_de_machine/inventaire.ini
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

cat <<EOF > /etc/hosts
192.168.0.2    dns
192.168.0.3    ad
192.168.0.4    ldap
192.168.0.5    home_assistant
192.168.0.6    openvpn
192.168.0.7    opnsense
192.168.0.8    client
EOF

cd /home/toine-fa/SAE5.02/playbook  # Déplacement vers le dossier contenant les playbooks
ansible-playbook -i /home/toine-fa/SAE5.02/Deploiement_de_machine/inventaire.ini main.yml
