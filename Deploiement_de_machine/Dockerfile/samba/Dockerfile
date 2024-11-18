# Utiliser l'image de base Ubuntu 20.04
FROM ubuntu:20.04
    
# Mettre à jour les paquets et installer SSH et Samba
RUN apt-get update && apt-get install -y openssh-server samba curl vim net-tools iputils-ping

# Configurer SSH
#RUN mkdir /var/run/sshd && echo 'root:root' | chpasswd
#RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config \
#    && echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config

# Définir un mot de passe pour l'utilisateur root
#RUN echo 'root:password' | chpasswd

# Exposer le port SSH
EXPOSE 22

# Commande pour démarrer Samba
#CMD service ssh start && service smbd start && tail -f /dev/null
CMD service ssh start && tail -f /dev/null
#CMD tail -f /dev/null
