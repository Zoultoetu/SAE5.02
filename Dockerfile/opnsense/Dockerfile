FROM nginx:latest

# Installer SSH
RUN apt-get update && apt-get install -y openssh-server

# Créer le répertoire pour SSH
RUN mkdir /var/run/sshd

# Activer la connexion root et l'authentification par mot de passe
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config

# Démarrer SSH
CMD ["/usr/sbin/sshd", "-D"]
