# Utiliser l'image de base Ubuntu
FROM ubuntu:22.04

# Mettre à jour le système et installer les paquets nécessaires
RUN apt-get update && apt-get install -y \
    bind9 bind9utils bind9-doc \
    openssh-server \
    && rm -rf /var/lib/apt/lists/*

# Configurer SSH
RUN mkdir /var/run/sshd && echo 'root:password' | chpasswd 
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && sed -i 's/#PasswordAuthentication yes/' /etc/ssh/sshd_config

# Configurer Bind9 (par défaut)
RUN mkdir -p /etc/bind/zones

# Exposer les ports pour Bind9 (DNS) et SSH
EXPOSE 53/udp 53/tcp 22

# Démarrer Bind9 et SSH
CMD service ssh start && named -f
