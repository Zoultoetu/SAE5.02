# Utilisation de l'image de base Ubuntu
FROM ubuntu:20.04

# Définir les variables d'environnement pour éviter les invites interactives
ENV DEBIAN_FRONTEND=noninteractive

# Installer les paquets de base nécessaires, y compris tzdata, avant toute configuration
RUN apt-get update && apt-get install -y \
    apt-utils \
    curl \
    vim \
    net-tools \
    iputils-ping \
    lsb-release \
    tzdata \
    && apt-get clean

# Installation des paquets nécessaires pour le serveur DNS
RUN apt-get update && apt-get install -y \
    bind9 \
    bind9utils \
    openssh-server \
    && apt-get clean

# Préparer les volumes pour la configuration dynamique
VOLUME ["/etc/bind"]

# Configuration du service SSH pour permettre les connexions root et l'authentification par mot de passe
RUN mkdir /var/run/sshd \
    && echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config \
    && echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config

# Démarrer les services nécessaires (SSH, bind9, etc.)
CMD service ssh start && service bind9 start && tail -f /dev/null


# Utiliser l'image de base Ubuntu
FROM ubuntu:22.04

# Mettre à jour le système et installer les paquets nécessaires
RUN apt-get update && apt-get install -y \
    bind9 bind9utils bind9-doc \
    openssh-server \
    && rm -rf /var/lib/apt/lists/*

# Configurer SSH
RUN mkdir /var/run/sshd && echo 'root:password' | chpasswd 
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/' /etc/ssh/sshd_config

# Configurer Bind9 (par défaut)
RUN mkdir -p /etc/bind/zones

# Exposer les ports pour Bind9 (DNS) et SSH
EXPOSE 53/udp 53/tcp 22

# Démarrer Bind9 et SSH
CMD service ssh start && named -f
