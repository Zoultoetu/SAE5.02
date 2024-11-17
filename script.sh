#!/bin/bash

cd /home/toine-fa/
#git clone https://github.com/Zoultoetu/SAE5.02
cd /home/toine-fa/SAE5.02/Deploiement_de_machine

docker-compose up -d

declare -A containers
containers=(
  ["dns"]="192.168.0.2"
  ["ad"]="192.168.0.3"
  ["ldap"]="192.168.0.4"
  ["home_assistant"]="192.168.0.5"
  ["openvpn"]="192.168.0.6"
  ["opnsense"]="192.168.0.7"
  ["client"]="192.168.0.8"
)

echo "Installation de SSH dans les conteneurs..."

for container in "${!containers[@]}" 
do
  docker exec -ti "$container" bash -c "
    apt-get install -y openssh-server && \
    mkdir -p /var/run/sshd && \
    echo 'root:root' | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    service ssh start
  "
  echo "SSH configuré sur le conteneur $container (${containers[$container]})"
done

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
