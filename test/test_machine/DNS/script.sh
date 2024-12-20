sudo chmod 777 /var/run/docker.sock
cd /home/toine-fa
sudo rm -rf /home/toine-fa/SAE5.02
docker rm -f $(docker ps -aq)
docker rm -f $(docker ps -aq)
git clone https://github.com/Zoultoetu/SAE5.02
cd /home/toine-fa/
#git clone https://github.com/Zoultoetu/SAE5.02
cd /home/toine-fa/SAE5.02/test_machine/DNS
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
EOF

printf "test ping"
ansible all -i /home/toine-fa/SAE5.02/test_machine/DNS/inventaire.ini -m ping