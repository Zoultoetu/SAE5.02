# Utiliser l'image de base Ubuntu
FROM ubuntu:22.04

# Mettre à jour le système et installer les paquets nécessaires
RUN apt-get update && apt-get install -y bind9 bind9utils bind9-doc openssh-server && rm -rf /var/lib/apt/lists/*

# Configurer SSH
RUN mkdir /var/run/sshd && echo 'root:root' | chpasswd
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config \
    && echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config

# Configurer Bind9
RUN mkdir -p /etc/bind/zones

# Exposer les ports pour Bind9 (DNS) et SSH
EXPOSE 5443/udp 5553/tcp 22 10000

CMD service ssh start && tail -f /dev/null

# Commande pour démarrer Bind9
CMD ["/usr/sbin/named", "-f", "-g"]