# Gestion Etudiant

## Introduction

Le projet `gestion-etudiant` est un projet d'étude de groupe qui vise à créer une application CRUD en utilisant Java EE avec JSF, JPA, et EJB. Les fonctionnalités clés incluent la création, la liste, la modification et la suppression d'étudiants.

## Technologies et Outils Utilisés

- **Java EE**: Avec l'utilisation de JSF, JDBC, JPA, et EJB.
- **PostgreSQL**: Système de gestion de base de données.
- **Log4J**: Pour la gestion des logs.
- **JSTL**: JavaServer Pages Standard Tag Library.
- **Docker**: Pour la containerisation et l'orchestration.
- **PgAdmin**: Interface pour la gestion de PostgreSQL.
- **Tomcat**: Serveur d'applications Java.
- **Gradle**: Pour la gestion et l'automatisation de build.

## Prérequis

- Docker et Docker Compose

## Installation et Configuration

1. **Clonez le dépôt** :
   ```bash
   git clone https://github.com/zlorgoncho1/gestion-etudiant.git
   ```

> Configuration Environnementale :
> Avant de démarrer le projet, il est essentiel de configurer les variables d'environnement. Pour > cela, vous devez créer un fichier `.env` à la racine du projet. Suivez ces étapes :

> 1. **Créer le fichier .env** :
>    Localisez le fichier `template.env` dans le répertoire du projet. Ce fichier contient un modèle des variables d'environnement nécessaires pour le projet.

> 2. **Copier le contenu de `template.env`** :
>    Ouvrez `template.env` et copiez son contenu.

> 3.  **Créer un nouveau fichier `.env`** :
>     À la racine du projet, créez un nouveau fichier et nommez-le `.env`.

> 4. **Coller et Personnaliser** :
>    Collez le contenu copié de `template.env` dans le fichier `.env` nouvellement créé. Remplacez les valeurs des variables par celles spécifiques à votre environnement et à votre configuration.

> Par exemple, si `template.env` contient des lignes comme celles-ci :

```env
DATABASE_USER=
DATABASE_PASSWORD=
```

> Vous devriez compléter par vos propres valeurs d'utilisateur et de mot de passe de base de données.

> 5. **Enregistrer le fichier `.env`** :
>    Après avoir remplacé les valeurs, enregistrez le fichier `.env`.

> Cette étape est cruciale pour que le projet puisse accéder à toutes les variables d'environnement nécessaires lors de l'exécution, notamment pour la configuration de la base de données, les ports, etc.

2. **Configuration de Docker** :
   Utilisez le fichier `Dockerfile` et `docker-compose.yml` pour configurer l'environnement nécessaire. Le fichier `Dockerfile` crée une image nommée `jze` qui inclut Ubuntu, JDK, Gradle, et Tomcat.

3. **Démarrage de la Base de Données** :

   ```bash
   docker-compose up -d database
   ```

   Importez le fichier `gestion-etudiant.sql` dans le conteneur PostgreSQL pour initialiser la base de données.

   ```bash
   docker-compose exec -it database psql -U {YOUR_DATABASE_USERNAME} -d gestion-etudiant -f gestion-etudiant.sql
   ```

## Démarrage du Projet

1. **Lancer les Services** :
   Après avoir initialisé la base de données, lancez les autres services :
   ```bash
   docker-compose stop database
   docker-compose up
   ```
2. **Accès à l'Application** :
   Ouvrez votre navigateur et accédez à `localhost:8888/app/views/students.xhtml` pour utiliser l'application.

## Contribution

Pour contribuer au projet, suivez les conventions de codage standard de Java EE et assurez-vous de tester vos modifications avant de soumettre une pull request.

- Créez une nouvelle branche pour chaque fonctionnalité ou correction de bug ou membre de l'équipe.
- Faites vos modifications.
- Soumettez une Pull Request pour fusionner vos modifications dans la branche principale.

### _Il s'agit d'un projet de classe développé par le groupe `[UNCHK | Elite Fusion]` composé par: `Ousmane Gueye, Yacine Bar, Fabrice Jordan Ramos, Papa Matar Diop, Ousmane Sow, Sokhna Niane`_
