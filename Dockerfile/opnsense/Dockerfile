# Utiliser une image de base Nginx pour simuler OPNsense
FROM nginx:latest

# Installer SSH
RUN apt-get update && \
    apt-get install -y openssh-server && \
    # Activer les connexions SSH root
    sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    # Créer un répertoire pour les clés SSH
    mkdir -p /var/run/sshd && \
    # Démarrer le service SSH
    service ssh start

# Exposer les ports nécessaires
EXPOSE 80/tcp

# Commande de démarrage de Nginx
CMD ["nginx", "-g", "daemon off;"]
