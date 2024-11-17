# Utiliser l'image de base Ubuntu 20.04
FROM ubuntu:20.04

# Mettre à jour les paquets et installer SSH, OpenLDAP
RUN apt-get update && apt-get install -y \
    openssh-server \
    slapd \
    ldap-utils \
    curl \
    vim \
    net-tools

# Créer le répertoire pour SSH
RUN mkdir /var/run/sshd

# Activer la connexion root et l'authentification par mot de passe
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config

# Définir un mot de passe pour l'utilisateur root
RUN echo 'root:password' | chpasswd

# Exposer le port SSH
EXPOSE 22
EXPOSE 389

# Commande pour démarrer OpenLDAP
CMD service ssh start && service slapd start
