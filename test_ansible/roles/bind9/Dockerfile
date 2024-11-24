FROM ubuntu/bind9:latest

# Met à jour le système et installe OpenSSH Server
RUN apt-get update && apt-get install -y openssh-server && \
    mkdir -p /var/run/sshd && \
    echo 'root:root' | chpasswd && \
    sed -i 's/#Port 22/Port 22/' /etc/ssh/sshd_config && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's@UsePAM yes@UsePAM no@g' /etc/ssh/sshd_config

# Expose le port 22 pour SSH
EXPOSE 22

# Commande d'entrée pour démarrer SSH et Bind9
CMD service ssh start && /usr/sbin/named -f
