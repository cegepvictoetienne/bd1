# Gestion des accès

Depuis le début de la session, nous nous connectons dans MySQL avec l'utilisateur *root*, ce qui nous donne tous les droits. En règle générale, nous allons plutôt créer des utilisateurs avec moins de droits afin de limiter les accès.

Par exemple, si on développe un site web, on préfère avoir les contraintes de sécurité suivantes dans MySQL:

- Les **visiteurs** du site peuvent uniquement ajouter, lire, modifier, ou supprimer des enregistrements.
- Les **programmeurs** peuvent faire ce que font les visiteurs, en plus de pouvoir modifier des tables et des déclencheurs (à venir dans le cours).
- L’**administrateur de la BD** peut faire ce que font les programmeurs, en plus de pouvoir ajouter des utilisateurs et gérer la sécurité.

De cette façon, si un mot de passe utilisé dans le site web est volé, l’accès à la BD est limité. 

## Ajouter un utilisateur

Pour ajouter un nouvel utilisateur, on utilise la syntaxe suivante:

```mysql
CREATE USER nom IDENTIFIED BY mot_de_passe;
```

Exemple:
```mysql
CREATE USER visiteur IDENTIFIED BY '12345';
```

Il existe toujours un utilisateur de base : root@localhost

## Modifier un utilisateur

Pour renommer un utilisateur, la requête est :

```mysql
RENAME USER ancien_nom TO nouveau_nom;
```

Exemple :
```mysql
RENAME USER visiteur TO visiteurs;
```

Pour changer un mot de passe, la requête est:

```mysql
ALTER USER nom IDENTIFIED BY nouveau_mot_de_passe;
```

Exemple:
```mysql
ALTER USER visiteur IDENTIFIED BY '54321';
```


## Supprimer un utilisateur

Pour retirer un utilisateur, on utilise la requête:

```mysql
DROP USER nom;
```

Exemple :

```mysql
DROP USER visiteurs;
```

## Niveaux de privilège

Les niveaux de privilèges accordent certains droits d’accès pour modifier des parties de la BD. Les niveaux (non exhaustif) sont

|   |   |   |
||||
|ALL (tout)|DELETE|REFERENCES (crée des clés étrangères)|
|ALTER|DROP|SELECT|
|CREATE|DROP ROLE|SHOW DATABASES|
|CREATE ROLE|EXECUTE (routines)|TRIGGER|
|CREATE ROUTINE|FILE|UPDATE|
|CREATE USER|INSERT| USAGE|

### Conférer un privilège

Pour assigner un privilège à un rôle, on utilise une requête GRANT:

```
GRANT priviliege1, privilege2 ON [* | table] TO nom_utilisateur;
```

Ex.: on ajoute ici le privilège de lecture sur toutes les tables de la base de données ecole aux visiteurs:

```mysql
USE ecole;
GRANT SELECT ON * TO 'visiteurs';
```

Ex.: on ajoute ici le privilège d’écriture et de modification sur la table etudiants:

```mysql
GRANT INSERT, UPDATE ON etudiants TO 'visiteurs';
```

### Révoquer un privilège

La requête de retrait de privilège est REVOKE:

```mysql
REVOKE priviliege1, privilege2 ON [* | table] 
  FROM nom_utilisateur;
```

Ex.: on révoque ici le privilège d’ajout des visiteurs sur la table etudiants:

```mysql
REVOKE UPDATE ON etudiants FROM 'visiteurs';
```

## Déterminer l'utilisateur connecté

La fonction USER() retourne l’utilisateur actuellement connecté à la base de données.

Exemple:
```mysql
SELECT USER();
```


| USER()         |
|-----|
| root@localhost |


### :material-cog: --- Exercice 4.3.1 ---

Faites un *use ecole* et créez un nouvel utilisateur nommé *toto* qui possède tous les privilèges sur votre BD ecole.

Déconnectez-vous en fermant Workbench et reconnectez-vous avec le nouvel utilisateur.

Essayez de faire un *use PlanetExpress* (quel message d'erreur obtenez-vous?). Essayez maintenant de faire un *use ecole*.

## Les rôles

Imaginons que nous avons 12 programmeurs qui doivent chacun avoir un nom et un mot de passe, mais qui doivent tous avoir les mêmes privilèges sur les tables.

Imaginez maintenant que l'on ajoute une table. Doit-on modifier les accès des 12 utilisateurs?

Ça serait plus simple d’avoir une seule structure contenant les privilèges, et de pouvoir assigner cette structure à nos 12 programmeurs.

**Un rôle est une liste d’accès** qui répond à ce besoin. Plutôt que de définir les accès pour chaque utilisateur, on peut créer un rôle et assigner ce rôle à tous nos programmeurs. Ainsi, si on veut changer l'accès de tous les programmeurs, on pourra changer seulement le rôle.

Tous les utilisateurs avec les mêmes privilèges ont le même rôle, ce qui facilite grandement le changement de privilèges.

### Définir un rôle

On utilise CREATE ROLE pour créer un nouveau rôle et DROP ROLE pour le supprimer:

```mysql
CREATE ROLE nom_role;
DROP ROLE nom_role;
```

Note: il n'y a pas de requête pour changer le nom d'un rôle.

### Conférer ou révoquer un privilège à un rôle

Comme précédement, on utilise GRANT ou REVOKE mais on remplace le nom d’utilisateur par le nom du **rôle**:

```mysql
GRANT privilege ON [*| Nom table] TO nom_role;
REVOKE privilege ON [* | Nom table] FROM nom_role;
```

Ex.: ici, on permet au rôle *programmeur* de créer des tables et des clés étrangères:

```mysql
GRANT CREATE TABLE, REFERENCES ON * TO programmeur;
```

### Assigner un rôle à un utilisateur

On peut affecter un rôle directement à la création:

```mysql
CREATE USER nom IDENTIFIED BY mot de passe
  DEFAULT ROLE role1, role2, ...;
```

Exemple:

```mysql
CREATE USER alice IDENTIFIED BY 'chat'
  DEFAULT ROLE programmeur;
```

On peut modifier les rôles avec:

```mysql
GRANT role1, role2 ... TO utilisateur1, utilisateur2...

REVOKE role FROM utilisateur;
```

### Autres fonctions utiles pour la gestion des rôles

Afficher l'utilisateur connecté
```mysql
SELECT USER();
```

Afficher tous les rôles de l’utilisateur connecté
```mysql
SELECT CURRENT_ROLE();
``` 

Afficher les privilèges
```mysql
SHOW GRANTS FOR role | utilisateur;
```

### :material-cog: --- Exercice 4.3.2 ---

* Créer un **rôle** nommé *enseignant* qui peut modifier les tables *evaluations* et *evaluations_etudiants*.
* Créer un **rôle** nommé *responsable* qui peut modifier les tables *cours*, *inscriptions*, *groupes*, *sessions* et *etudiants*.

* Ajouter un **utilisateur** nommé *Scott Summers* qui est *enseignant* et *Jean Grey* qui est à la fois *enseignante* et *responsable*.