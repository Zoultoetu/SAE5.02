FROM debian:latest

RUN apt update
RUN apt install bind9 openssh-server apt-utils -y

# Configurer SSH
RUN mkdir /var/run/sshd && echo 'root:root' | chpasswd
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config \
   && echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config


RUN mkdir -p /etc/bind/zones

EXPOSE 53/tcp
EXPOSE 53/udp
EXPOSE 22
EXPOSE 10000/tcp

USER bind:bind

CMD ["/usr/sbin/named", "-f", "-g"] && service ssh start && tail -f /dev/null