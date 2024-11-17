# Utiliser l'image de base Ubuntu 20.04
FROM ubuntu:20.04

# Mettre à jour les paquets et installer SSH et Nginx pour simuler OPNsense
RUN echo "tzdata tzdata/Areas select Europe" | debconf-set-selections \
&& echo "tzdata tzdata/Zones/Europe select Paris" | debconf-set-selections \ 
    apt-get update && apt-get install -y \
    openssh-server \
    nginx \
    curl \
    vim \
    net-tools \
    iputils-ping

# Créer le répertoire pour SSH
RUN mkdir /var/run/sshd

# Activer la connexion root et l'authentification par mot de passe
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config

# Définir un mot de passe pour l'utilisateur root
RUN echo 'root:password' | chpasswd

# Exposer le port SSH
EXPOSE 22
EXPOSE 80

# Commande pour démarrer Nginx et SSH
CMD service ssh start && nginx -g 'daemon off;'
