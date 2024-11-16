# Utiliser l'image de base Debian
FROM debian:latest

# Installer SSH et Xfce4
RUN apt-get update && \
    apt-get install -y openssh-server xfce4 && \
    # Activer les connexions SSH root
    sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    # Créer un répertoire pour les clés SSH
    mkdir -p /var/run/sshd && \
    # Démarrer le service SSH
    service ssh start

# Exposer les ports nécessaires
EXPOSE 22/tcp

# Commande de démarrage pour le client
CMD ["bash"]
