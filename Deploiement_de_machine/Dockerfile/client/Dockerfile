FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Installer les paquets de base avant d'installer le reste
RUN apt-get update && apt-get install -y \
    apt-utils \
    curl \
    vim \
    net-tools \
    iputils-ping \
    lsb-release \
    tzdata \
    && apt-get clean

# Configuration de la zone horaire pour éviter les invites interactives de tzdata
RUN echo "tzdata tzdata/Areas select Europe" | debconf-set-selections \
    && echo "tzdata tzdata/Zones/Europe select Paris" | debconf-set-selections \
    && dpkg-reconfigure -f noninteractive tzdata

# Installer le bureau XFCE et SSH
RUN apt-get update && apt-get install -y \
    openssh-server \
    xfce4 \
    && apt-get clean

# Configuration de SSH
RUN mkdir /var/run/sshd \
    && echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config \
    && echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config

CMD service ssh start
