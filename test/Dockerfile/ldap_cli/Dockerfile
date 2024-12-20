# Utilisation de l'image de base Ubuntu
FROM ubuntu:20.04

# Définir les variables d'environnement pour éviter les invites interactives
ENV DEBIAN_FRONTEND=noninteractive

# Configuration de la zone horaire pour éviter les invites interactives de tzdata
#RUN echo "tzdata tzdata/Areas select Europe" | debconf-set-selections \
 #   && echo "tzdata tzdata/Zones/Europe select Paris" | debconf-set-selections \
  #  && dpkg-reconfigure -f noninteractive tzdata

# Mise à jour et installation de slapd et ldap-utils
RUN apt-get update && apt-get install -y \
    slapd \
    apt-utils \
    ldap-utils \
    openssh-server \
    && apt-get clean

# Configurer le mot de passe administrateur pour LDAP via debconf
RUN echo "slapd slapd/password1 password root" | debconf-set-selections \
    && echo "slapd slapd/password2 password root" | debconf-set-selections \
    && echo "slapd slapd/allow_weak_crypto boolean true" | debconf-set-selections \
    && dpkg-reconfigure -f noninteractive slapd

# Créer les répertoires nécessaires et démarrer le service SSH
RUN mkdir /var/run/sshd

# Activer SSH pour la connexion root et l'authentification par mot de passe
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config \
    && echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config

# Démarrer SSH et slapd
CMD service ssh start && service slapd start && tail -f /dev/null
