# SAE5.02
Projet R502 Antoine FAYOLLE RT3 Cyber

# **Déploiement d'un Serveur de Domotique Personnel**

## **1. Présentation**
Ce projet vise à déployer un serveur de domotique personnel, offrant des services essentiels pour un réseau local sécurisé. Le déploiement repose sur des conteneurs Docker orchestrés par Ansible, garantissant une installation automatisée, une maintenance simplifiée et une évolutivité future.

## **2. Fonctionnalités**
Les services inclus dans ce projet sont :
- **Serveur DNS** : Gestion des noms de domaine internes.
- **Active Directory (AD)** : Gestion centralisée des utilisateurs et des permissions.
- **Serveur Domotique (Home Assistant)** : Contrôle et automatisation des appareils connectés.
- **Serveur VPN (OpenVPN)** : Accès sécurisé au réseau interne.
- **Freebox** : Gestion des connexions internet et redirections réseau.

## **3. Prérequis**
Avant de déployer ce projet, vérifiez que les éléments suivants sont disponibles :
- Accès à une connexion internet pour les mises à jour et installations.
- Une Freebox ou tout autre routeur avec la gestion des redirections de ports.
- Un environnement Docker installé sur les serveurs.
- Ansible installé pour l'automatisation des déploiements.

## **4. Déploiement**
Les services sont déployés sur différentes machines virtuelles ou physiques, selon la configuration ci-dessous :

### **4.1. Serveur DNS / Active Directory (AD)**
- **Nom de la machine** : `DNS_AD_LDAP`
- **Adresse IP** : `10.8.0.3`
- **Description** : Gère la résolution des noms de domaine internes, les identifiants d'utilisateurs et les permissions. Le serveur LDAP est intégré avec l'AD fourni par Windows Server.
- **Playbooks Ansible** : Configure le serveur pour mettre les autres machines sur le domaine.

### **4.2. Serveur Domotique**
- **Nom de la machine** : `home_assistant`
- **Adresse IP** : `192.168.0.5`
- **Description** : Exécute Home Assistant pour centraliser et automatiser les appareils domotiques.
- **Playbooks Ansible** : Installation et configuration de Home Assistant.

### **4.3. Serveur VPN**
- **Nom de la machine** : `serveur_VPN`
- **Adresse IP** : `192.168.0.2`
- **Description** : Assure un accès sécurisé au réseau via OpenVPN. Clé de chiffrement intégrée pour renforcer la sécurité.
- **Playbooks Ansible** : Installation et configuration d’OpenVPN.


### **4.4. Freebox**
- **Rôle** : Configure les redirections de ports pour un accès fluide depuis l’extérieur aux services internes (ex. OpenVPN, Home Assistant).

## **5. Sécurité et Évolutivité**

### **Sécurité**
- Mise en place de clés de chiffrement pour OpenVPN.
- Politiques de mots de passe strictes (à envisager pour les services).
- Sauvegardes régulières des configurations et des données sensibles (non encore implémenté).

### **Évolutivité**
- Intégration prévue : Connecter l’Active Directory au serveur VPN via un serveur Radius pour une authentification unifiée.
- Surveillance des ressources : Suivi des performances pour ajuster les capacités du réseau si nécessaire.

## **6. Instructions d’Installation**

1. **Cloner le projet et lancer le projet**  
   ```bash
   git clone https://github.com/Zoultoetu/SAE5.02
   cd ./SAE5.02/ad_windows
   sudo bash ./SAE5.02/ad_windows/script.sh
   ```

2. **Configurer la Freebox**  
   Accédez à l’interface de la Freebox et configurez les redirections de ports pour permettre l’accès externe aux services.

## **7. Limitations Connues**
- Le serveur graphique (machine client) n’est pas encore implémenté.
- Les politiques de sauvegarde et de mise à jour automatique des services doivent être ajoutées.

## **8. Auteur**
Ce projet a été réalisé dans le cadre d’un déploiement de serveur domotique personnel. Pour toute question ou suggestion, contactez-moi à [meldantoine@gmail.com].
