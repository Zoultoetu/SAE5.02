# Utiliser l'image de base Ubuntu 20.04
FROM ubuntu:20.04
    
# Mettre à jour les paquets et installer OpenVPN et SSH
RUN apt-get update && apt-get install -y \
    openssh-server \
    openvpn \
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
EXPOSE 1194

# Commande pour démarrer OpenVPN
CMD service ssh start && openvpn --config /etc/openvpn/openvpn.conf && tail -f /dev/null
