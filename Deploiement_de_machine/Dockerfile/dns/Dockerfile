# Utiliser l'image de base Ubuntu
FROM ubuntu:22.04

# Mettre à jour le système et installer les paquets nécessaires
RUN apt-get update && apt-get install -y bind9 bind9utils bind9-doc openssh-server && rm -rf /var/lib/apt/lists/*

# Configurer SSH
RUN mkdir /var/run/sshd && echo 'root:root' | chpasswd
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config \
    && echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config

# Configurer Bind9 (par défaut)
RUN mkdir -p /etc/bind/zones

# Exposer les ports pour Bind9 (DNS) et SSH
EXPOSE 5443/udp 5553/tcp 22 10000

# Démarrer Bind9 et SSH
#CMD service ssh start && service bind9 start && tail -f /dev/null
CMD service ssh start && tail -f /dev/null
#CMD tail -f /dev/null
