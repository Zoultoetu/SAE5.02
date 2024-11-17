# Utiliser l'image de base Ubuntu 20.04
FROM ubuntu:20.04

# Mettre à jour les paquets et installer OpenSSH et l'environnement XFCE
RUN apt-get update && apt-get install -y \
    openssh-server \
    xfce4 \
    curl \
    vim \
    net-tools \
    iputils-ping \
    lsb-release

# Créer le répertoire pour SSH
RUN mkdir /var/run/sshd

# Activer la connexion root et l'authentification par mot de passe
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config

# Définir un mot de passe pour l'utilisateur root (par exemple "password")
RUN echo 'root:password' | chpasswd

# Exposer le port SSH
EXPOSE 22

# Lancer le serveur SSH et l'environnement XFCE
CMD service ssh start && startx
