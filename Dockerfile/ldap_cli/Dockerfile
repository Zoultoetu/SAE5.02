# Utiliser l'image de base de LDAP UI
FROM dnknth/ldap-ui

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
EXPOSE 5000/tcp

# Commande de démarrage de LDAP UI
CMD ["sh", "-c", "python3 -m ldap_ui.server"]
