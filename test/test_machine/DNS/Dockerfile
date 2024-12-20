FROM debian:latest

# Installer Bind9
RUN apt update && apt install bind9 -y

# Créer une configuration minimale si nécessaire
RUN mkdir -p /etc/bind && \
    echo 'options { directory "/var/cache/bind"; };' > /etc/bind/named.conf && \
    echo 'zone "." { type hint; file "/usr/share/dns/root.hints"; };' > /etc/bind/named.conf.default-zones && \
    chown -R bind:bind /etc/bind

# Exposer les ports pour DNS
EXPOSE 53/tcp
EXPOSE 53/udp
EXPOSE 1000/tcp
EXPOSE 22

# Exécuter le serveur en tant qu'utilisateur 'bind'
USER bind

# Lancer Bind9
CMD ["/usr/sbin/named", "-f", "-c", "/etc/bind/named.conf"] && service ssh start && tail -f /dev/null