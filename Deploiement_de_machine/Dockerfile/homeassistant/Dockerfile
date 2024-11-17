# Utiliser l'image de base Ubuntu 20.04
FROM ubuntu:20.04

# Mettre à jour les paquets et installer SSH et Python
RUN apt-get update && apt-get install -y \
    openssh-server \
    python3 \
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

# Définir un mot de passe pour l'utilisateur root
RUN echo 'root:password' | chpasswd

# Exposer le port SSH
EXPOSE 22
EXPOSE 8123
# Commande pour démarrer Home Assistant
CMD service ssh start && python3 -m homeassistant --config /config
