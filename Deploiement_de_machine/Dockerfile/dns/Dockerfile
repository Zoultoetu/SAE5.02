# Dockerfile exemple
FROM ubuntu:22.04

# Mettre à jour et installer les paquets nécessaires
RUN apt-get update && apt-get install -y \
    bind9 bind9utils bind9-doc \
    openssh-server \
    && rm -rf /var/lib/apt/lists/*

# Configurer SSH
RUN mkdir /var/run/sshd && echo 'root:password' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && sed -i 's/#PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Configurer Bind9
COPY named.conf /etc/bind/named.conf
COPY named.conf.local /etc/bind/named.conf.local
COPY named.conf.options /etc/bind/named.conf.options
COPY db.example.com /etc/bind/db.example.com

# Exposer les ports nécessaires
EXPOSE 53/udp 53/tcp 22

# Démarrer SSH et Bind9
CMD service ssh start && /usr/sbin/named -f -g
