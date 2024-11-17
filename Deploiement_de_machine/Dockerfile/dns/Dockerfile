# Utiliser l'image de base Ubuntu
FROM ubuntu:20.04

# Configuration de la zone horaire pour éviter les invites interactives de tzdata
RUN echo "tzdata tzdata/Areas select Europe" | debconf-set-selections \
    && echo "tzdata tzdata/Zones/Europe select Paris" | debconf-set-selections \
    && dpkg-reconfigure -f noninteractive tzdata
    
# Mettre à jour les packages et installer Bind9 et OpenSSH
RUN apt-get update && apt-get install -y \
    bind9 \
    bind9utils \
    openssh-server \
    curl \
    vim \
    net-tools

# Créer le répertoire pour SSH
RUN mkdir /var/run/sshd

# Configurer SSH pour permettre la connexion root et l'authentification par mot de passe
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config

# Définir un mot de passe pour l'utilisateur root (par exemple "password")
RUN echo 'root:password' | chpasswd

# Exposer les ports pour SSH (22) et Bind9 (53)
EXPOSE 22
EXPOSE 5553/udp
EXPOSE 5443/tcp
EXPOSE 10000/tcp  

# Si tu as une interface d'administration Web

# Lancer SSH et Bind9
CMD service ssh start && named -f

