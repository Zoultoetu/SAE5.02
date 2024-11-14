#!/bin/bash

# Aller dans le répertoire principal
cd ~

# Cloner le dépôt contenant les fichiers et configurations nécessaires
git clone https://github.com/Zoultoetu/SAE5.02

# Aller dans le dossier du déploiement des machines
cd ~/SAE5.02/Deploiement_de_machine

# Lancer les conteneurs définis dans le fichier docker-compose.yml
docker-compose up -d

# Générer le fichier d'inventaire pour Ansible, contenant les adresses IP et groupes de machines
touch ~/SAE5.02/Deploiement_de_machine/inventaire.ini
cat <<EOF > ~/SAE5.02/Deploiement_de_machine/inventaire.ini
[dns]
192.168.0.2

[ad]
192.168.0.3

[ldap]
192.168.0.4

[home_assistant]
192.168.0.5

[openvpn]
192.168.0.6

[opnsense]
192.168.0.7

[client]
192.168.0.8

[all:vars]
ansible_connection=docker
EOF

# Ajouter les noms et adresses IP dans le fichier hosts pour qu’ils soient résolus correctement
cat <<EOF | sudo tee -a /etc/hosts
192.168.0.2 dns 
192.168.0.3 ad
192.168.0.4 ldap
192.168.0.5 home_assistant
192.168.0.6 openvpn
192.168.0.7 opnsense
192.168.0.8 client
EOF

# Création du playbook principal qui configure les accès SSH et exécute les autres playbooks par machine
cat <<'EOF' > ~/SAE5.02/Deploiement_de_machine/main.yml
- hosts: all
  become: true
  tasks:
    # Installer le serveur SSH sur chaque machine
    - name: Installer SSH
      apt:
        name: openssh-server
        state: present
      when: ansible_connection == "docker"

    # Autoriser la connexion root via SSH
    - name: Permettre la connexion root via SSH
      lineinfile:
        path: /etc/ssh/sshd_config
        regexp: '^#?PermitRootLogin'
        line: 'PermitRootLogin yes'
      notify: Redémarrer SSH

    # Définir le mot de passe pour root
    - name: Définir le mot de passe root
      user:
        name: root
        password: "{{ 'root' | password_hash('sha512') }}"

    # Assurer que le service SSH est activé et démarré
    - name: Démarrer et activer le service SSH
      service:
        name: ssh
        state: started
        enabled: true

  handlers:
    # Redémarrer SSH si la configuration a été modifiée
    - name: Redémarrer SSH
      service:
        name: ssh
        state: restarted

# Inclure les autres playbooks pour chaque service/machine
- import_playbook: dns_setup.yml
- import_playbook: ad_setup.yml
- import_playbook: ldap_setup.yml
- import_playbook: openvpn_setup.yml
- import_playbook: home_assistant_setup.yml
- import_playbook: opnsense_setup.yml
EOF

# Exécuter le playbook principal avec Ansible pour configurer chaque machine et déployer les services
ansible-playbook -i ~/SAE5.02/Deploiement_de_machine/inventaire.ini ~/SAE5.02/Deploiement_de_machine/main.yml
