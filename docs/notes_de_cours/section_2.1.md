# Créer, mettre à jour, supprimer des données

## Requêtes SQL

L’ensemble d’instructions du langage SQL pour faire des requêtes est différent de celui pour la structure des données.

On retrouve principalement 4 types de requêtes (principe *CRUD*):

- (**C**reate) Insertion (*INSERT*)
- (**R**ead) Sélection (*SELECT*)
- (**U**pdate) Mise à jour (*UPDATE*)
- (**D**elete) Suppression (*DELETE*)

## Insérer un enregistrement

La requête d’insertion est la suivante :

```sql
INSERT INTO Nom_table (nom_colonne1, nom_colonne2,...) 
VALUES (valeur_colonne1, valeur_colonne2,...);
```

Par exemple, la requête suivante ajoute un étudiant dans la table Étudiant.

```mysql
INSERT INTO etudiants (code, nom, 
        annee_admission, programme)
    VALUES (1324567, 'Tony Stark', 2023,
        '420.B0');
```


``` mermaid
erDiagram  
{!etudiants.mermaid!}
    
```

Dans le cas d’un champ assigné automatiquement, comme une clé auto-incrémentée ou l’utilisation d’une valeur par défaut, on n'indique pas cette colonne dans la requête **INSERT**.

```mysql
INSERT INTO cours (sigle, nom)
    VALUES ('420-2B4-VI', 'Base de données 1');
```

Le cours BD1 aura alors un id automatique et une durée de 60 heures.


``` mermaid
erDiagram  
{!cours.mermaid!}
    
```

|cours_id|enseignant|sigle|duree|nom|
|---|---|---|---|---|
|1|NULL|420-2B4-VI|60|Base de données 1|

### Insérer plusieurs enregistrements

On peut insérer dans une requête plusieurs enregistrements en les séparant par une virgule.

```mysql
INSERT INTO etudiants (code, nom, annee_admission, programme) 
    VALUES (1234567, 'Anthony Stark', 2018, '420.A0'),    
        (2345678, 'Steve Rogers', 2018, '420.A0'),      
        (3456789, 'Natasha Romanov', 2019, '420.A1');

```

``` mermaid
erDiagram  
{!etudiants.mermaid!}
    
```

### Omettre le nom des colonnes

On peut omettre le nom des colonnes à condition que les valeurs soient insérées dans l’ordre des colonnes.

Par exemple, cette instruction est valide :

```mysql
INSERT INTO etudiants VALUES      
    (1234567, '420.A0', 'Anthony Stark', 2018) 
```

``` mermaid
erDiagram  
{!etudiants.mermaid!}
    
```

L'instruction suivante n'est pas valide car la table *cours* comporte cinq colonnes et seulement deux valeurs sont indiquées:

```mysql
INSERT INTO cours VALUES ('420-2B4-VI', 'Base de données 1');
```

``` mermaid
erDiagram  
{!cours.mermaid!}     
```

L'instruction suivante n'est pas valide car l'ordre des colonnes n’est pas respecté:

```mysql
INSERT INTO etudiants VALUES ('Anthony Stark', 2018, '420.A0', 1234567);
```

### Utiliser la valeur par défaut

On peut indiquer explicitement à SQL d’utiliser la valeur par défaut en utilisant l’instruction  

```sql
DEFAULT(nom_colonne).
```

Ici le cours BD1 aura une durée de 60.

```mysql
    INSERT INTO cours (sigle, duree, nom) VALUES      
        ('420-2B4-VI', DEFAULT (duree), 'Base de données 1'),     
        ('420-1D6-VI', 90, 'Programmation 1');
```


### Omettre une colonne

Si lors de l’ajout d’un enregistrement une colonne ne possède pas de valeur par défaut et qu’aucune valeur n’est précisée, alors la valeur spéciale **NULL** est utilisée.

```mysql
INSERT INTO Cours (nom) VALUES ('Base de données 1');
```

Ici le sigle et l'enseignant de l’enregistrement sont **NULL** :

|cours_id|enseignant|sigle|duree|nom|
|---|---|---|---|---|
|1|NULL|NULL|60|Base de données 1|


## Afficher le contenu d’une table

Pour afficher tous les enregistrements d’une table, on utilise l’instruction suivante :

```sql
SELECT * FROM nom_table;
```

Nous verrons dans les prochaines sections les requêtes **SELECT** en détail.

## :material-cog: --- Exercice 2.1.1 ---

Ajoutez les enseignants et les programmes suivants:

**enseignants**

|code_employe|nom|num_assurance_sociale|anciennete|
|||||
|9876|Clark Kent|150 150 150|8|
|8765|Bruce Wayne|260 260 260|14|
|7654|Kara Danvers|888 777 666|0|
|6573|Richard Grayson|222 444 666|4|

**programmes** 

|code|nom|responsable|
||||
|420.A0|Informatique appliquée|Bruce Wayne|
|420.B0|Informatique - jeux vidéos|Kara Danvers|

## Mettre à jour un enregistrement

On utilise la requête **UPDATE** pour mettre à jour un enregistrement.

```mysql
UPDATE nom_table SET nom_colonne1 = valeur1, nom_colonne2 = valeur2; 
```

Cette syntaxe comporte un défaut car ici, on met à jour **tous** les enregistrements! Dans la plupart des cas, ce n’est pas ce qu’on cherche à faire.

Pour indiquer quel enregistrement mettre à jour, on utilise la clause **WHERE** qui permet de spécifier une condition. 

### Clause WHERE

La syntaxe d’une requête UPDATE avec la clause WHERE est :

```sql
UPDATE nom_table 
    SET nom_colonne1 = valeur1, nom_colonne2 = valeur 2, ...
    WHERE condition;
```

Par exemple, on souhaite que le programme 420.A0 (Informatique appliquée) soit maintenant sous la responsabilité de Clark Kent (9876).

```sql
UPDATE programmes
    SET responsable = 9876
    WHERE code = '420.B0'; 
```

``` mermaid
erDiagram  
{!programmes.mermaid!}
```

### Désactiver le SafeMode

Si vous n'indiquez pas de clause WHERE ou que celle-ci ne s'applique pas sur une clé, alors la requête sera bloquée par le *SafeMode*.

Pour désactiver le SafeMode :

Edit > Preferences > SQLEditor > Safe updates
Puis reconnectez-vous au serveur.

### :material-cog: --- Exercice 2.1.2 ---

A. Mettez à jour le profil de Kara Danvers pour assigner la valeur 1 à son ancienneté.

B. Mettez à jour le cours BD1 pour qu'il ait une durée de 90 heures.

## Duplicata de clé primaire

Qu’arrive-t-il si on ajoute un enregistrement pour lequel la clé primaire existe déjà?

2 choix :

1) Provoquer une erreur (ce qui se produit normalement)

2) Offrir la possibilité de mettre à jour l’enregistrement

## Mettre à jour si la clé existe déjà

On modifie la requête **INSERT** de la façon suivante :

```mysql
INSERT INTO nom_table (nom_colonne1, nom_colonne2,…)
    VALUES (valeur1, valeur2,…)
    ON DUPLICATE KEY UPDATE;
```

Note: il n'est pas toujours une bonne idée d’utiliser **ON DUPLICATE KEY UPDATE**.

Souvent, on veut signaler une erreur pour indiquer à l’utilisateur qu’il fait une opération non standard.

On peut utiliser **ON DUPLICATE KEY UPDATE** lorsqu’on transfère des données ou que l’on est sûr que les enregistrements sont identiques.

## Supprimer un enregistrement

La requête de suppression est **DELETE** et a la syntaxe suivante :

```mysql
DELETE FROM nom_table WHERE condition;
```

Comme pour les requêtes DROP, aucune confirmation n'est demandée.

***Attention*** : s’il n’y a pas de clause WHERE et que le SafeMode est désactivé, vous allez supprimer toutes les données de la table.

## :material-cog: --- Exercice 2.1.3 ---

L'enseignant Bruce Wayne souhaite quitter son poste d'enseignant pour devenir un riche homme d'affaires. Retirez-le de la table *Enseignants*.

Ajoutez-le de nouveau par la suite et réassignez-le comme responsable de programme.

***Difficultés :*** 

1. Vérifier vos contraintes de clé étrangère
2. Pour vérifier si une valeur est **NULL**, on doit utiliser l'expression **IS NULL**    et non « **= NULL** » (et **!= NULL** devient **IS NOT NULL**)