# Gestion des accès

CRUD des utilisateurs
Conférer et révoquer des privilèges
Créer des rôles

## Pourquoi gérer les rôles

On développe un site web avec les contraintes de sécurité suivantes.

- Les programmeurs peuvent modifier des tables, des déclencheurs et des enregistrements. 
- L’administrateur de la BD peut ajouter des utilisateurs et accomplir toutes les opérations des développeurs
- Les visiteurs peuvent uniquement ajouter, lire, modifier, ou supprimer des enregistrements.

De cette façon, si un mot de passe utilisé dans le site web est volé, l’accès à la BD est limité. 

## CRUD des utilisateurs

Pour ajouter un nouvel utilisateur, on utilise la syntaxe suivante:

```mysql
CREATE USER nom IDENTIFIED BY mot_de_passe;
```

Exemple:
```mysql
CREATE USER visiteur IDENTIFIED BY '12345’;
```

Il existe toujours un utilisateur de base : root@localhost

### Modifier un utilisateur

Pour changer un mot de passe, la requête est:

```mysql
ALTER USER nom IDENTIFIED BY nouveau_mot_de_passe;
```

Exemple:
```mysql
ALTER USER visiteur IDENTIFIED BY '54321';
```

Pour renommer un utilisateur, la requête est :

```mysql
RENAME USER ancien_nom TO nouveau_nom;
```

Exemple :
```mysql
RENAME USER visiteur TO visiteurs;
```

### Supprimer un utilisateur

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

Pour assigner un privilège à un rôle, on utilise une requête GRANT.

```
GRANT priviliege1, privilege2 ON [* | table] TO nom_utilisateur;
```

On ajoute le privilège de lecture sur toutes les tables de la base de données ecole aux visiteurs.

```mysql
USE Ecole;
GRANT SELECT ON * TO 'visiteurs’;
```

Pour ajouter le privilège d’écriture et de modification sur la table Etudiant

```mysql
GRANT INSERT, UPDATE ON Etudiant TO 'visiteurs';
```

### Révoquer un privilège

La requête de retrait de privilège est REVOKE.

```mysql
REVOKE priviliege1, privilege2 ON [* | table] 
  FROM nom_utilisateur;
```

Par exemple, on révoque le privilège d’ajout des visiteurs sur la table Etudiant.

```mysql
REVOKE UPDATE ON Etudiant FROM ‘visiteurs’;
```

## Déterminer l'utilisateur connecté

La fonction USER() retourne l’utilisateur actuellement connecté à la base de données.

Exemple:
```mysql
SELECT USER();
```

```
| USER()         |
|-|
| root@localhost |
```

### :material-cog: --- Exercice 4.3.1 ---

Créez un nouvel utilisateur qui possède tous les privilèges.

Déconnectez-vous en fermant Workbench et reconnectez-vous avec le nouvel utilisateur.

## Les rôles

Que faire si on a 8 programmeurs qui ont chacun leur accès distinct (nom et mot de passe), mais qui doivent tous avoir le même niveau de privilège.

Imaginez qu’on ajoute une table. Doit-on modifier les accès de tous les utilisateurs ?

Ça serait plus simple d’avoir une structure contenant les privilèges.

**Un rôle est une liste d’accès**. Plutôt que de définir les accès par utilisateur, on peut leur assigner un rôle. 

Donc tous les utilisateurs avec les mêmes privilèges d’accès auront le même rôle. Cela facilite grandement le changement de privilèges.

### Définir un rôle

On utilise CREATE ROLE pour créer un nouveau rôle et DROP ROLE pour le supprimer.

Il n'y a pas de requête pour changer le nom d'un rôle.

```mysql
CREATE ROLE nom_role;
DROP ROLE nom_role;
```

### Conférer ou révoquer un privilège à un rôle

On remplace le nom d’utilisateur dans la requête GRANT ou REVOKE par le nom du rôle.

```mysql
GRANT privilege ON [*| Nom table] TO nom_role;
REVOKE privilege ON [* | Nom table] FROM nom_role;
```

Par exemple, on permet au programmeur de créer des tables et des clés étrangères.

```mysql
GRANT CREATE TABLE, REFERENCES ON * TO programmeur;
```

### Assigner un rôle à un utilisateur

On peut affecter un rôle directement à la création

```mysql
CREATE USER nom IDENTIFIED BY mot de passe
  DEFAULT ROLE role1, role2...;
```

Exemple:

```mysql
CREATE USER alice IDENTIFIED BY 'chat'
  DEFAULT ROLE programmeur ;
```

### Modifier le rôle affecté un utilisateur

On peut modifier les rôles avec

```mysql
GRANT role1, role2 ... TO utilisateur1, utilisateur2...

REVOKE role FROM utilisateur;
```

### Autres fonctions utiles pour la gestion des rôles

Afficher l'utilisateur connecté
```mysql
USER() 
```

Afficher tous les rôles de l’utilisateur connecté
```mysql
CURRENT_ROLE()
``` 

Afficher les privilèges
```mysql
SHOW GRANTS FOR role | utilisateur
```

### :material-cog: --- Exercice 4.3.2 ---

Créer un rôle enseignant qui peut modifier les tables Évaluation et Évaluation_etudiant ainsi qu’un rôle responsable qui peut changer la table Cours, Inscription, Groupe, Session et Etudiant.

Ajouter un utilisateur appelé Scott Summers qui est enseignant et Jean Grey qui est enseignante et responsable.