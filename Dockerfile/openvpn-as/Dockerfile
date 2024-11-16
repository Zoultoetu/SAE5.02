# Utiliser l'image de base de OpenVPN
FROM openvpn/openvpn-as

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
EXPOSE 943/tcp 8443/tcp 1194/udp

# Commande de démarrage de OpenVPN
CMD ["/usr/local/openvpn_as/bin/ovpn-init"]
