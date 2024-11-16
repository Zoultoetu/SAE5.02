# Utiliser l'image de base de votre service DNS
FROM abilioesteves/bind9:0.0.3

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
EXPOSE 53/tcp 53/udp 10000/tcp 5443/udp 5553/tcp

# Commande de démarrage du service DNS
CMD ["named", "-g"]
