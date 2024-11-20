cd /home/toine-fa/
#git clone https://github.com/Zoultoetu/SAE5.02
cd /home/toine-fa/SAE5.02/test_machine/dns
docker-compose build
docker-compose up -d

declare -A containers
containers=(
  ["dns"]="192.168.0.2"
)


for container in "${!containers[@]}" 
do
  echo "Configuration de SSH dans le conteneur $container (${containers[$container]})..."
  docker exec -ti "$container" bash -c "
    apt-get update && \
    apt-get install -y openssh-server && \
    mkdir -p /var/run/sshd && \
    echo 'root:root' | chpasswd && \
    RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config \
    && echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config\
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
ansible all -i /home/toine-fa/SAE5.02/test_machine/scriptdns.sh/inventaire.ini -m ping