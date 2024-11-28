# Dockerfile
FROM ubuntu:20.04

# Met à jour le système et installe les paquets nécessaires
RUN apt-get update && \
    apt-get install -y samba smbclient krb5-user openssh-server && \
    mkdir -p /var/run/sshd && \
    echo 'root:root' | chpasswd && \
    sed -i 's/#Port 22/Port 22/' /etc/ssh/sshd_config && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's@UsePAM yes@UsePAM no@g' /etc/ssh/sshd_config

# Expose les ports nécessaires (SSH, Samba)
EXPOSE 22 53/udp 53/tcp 88/tcp 135/tcp 137-138/udp 139/tcp 389/tcp 445/tcp 464/tcp 636/tcp 3268-3269/tcp

# Commande d'entrée pour démarrer SSH
CMD service ssh start && bash

