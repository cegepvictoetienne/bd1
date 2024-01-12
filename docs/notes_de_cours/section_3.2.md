# Sauvegarder et restaurer une BD

Dumping
Charger une sauvegarde
Dumping dans un format texte
Charger des données d’un format texte

## Dumping

Le «dumping» consiste à générer le code SQL pour recréer complètement la base de données (CREATE DATABASE, TABLE et INSERT INTO).

Ce fichier comporte de nombreuses instructions SQL supplémentaires pour assurer que les données sont restaurées normalement.

Dans une invite de commande située là où votre exécutable MySQL est placé, entrez la commande suivante (Windows)

```console
.\mysqldump.exe --databases nom1 nom2 … > chemin/fichier.sql –unom_utilisateur –p
```

Exemple :
```console
.\mysqldump.exe --databases ecole … > ../ecole_backup.sql –uroot –p
```` 

Puis saisissez le mot de passe du compte.

Dans le répertoire parent, vous trouverez le fichier ecole_backup.sql.

Pour exporter toutes les bases de données, on remplace 
«--databases nom1» par «--all-databases»

On peut omettre l’option databases si l’on en exporte qu’une

```console
.\mysqldump.exe nom_db > chemin/fichier.sql –unom_utilisateur –p
```

## Charger une BD à partir d’un fichier de sauvegarde

Pour charger la BD, c’est simple : il suffit d’exécuter le script mysql!

Soit à travers Workbench ou avec l'invite de commandes

```console
mysql < fichier.sql
```

## Table corrompue

Une instruction permet de récupérer les données d’une table dont le fichier de sauvegarde serait corrompu.

```mysql
REPAIR TABLE Nom_table EXTENDED;
```

https://dev.mysql.com/doc/refman/8.0/en/repair-table.html

## Dumping dans un fichier texte

Il est possible d’exporter le contenu des tables dans des fichiers de format texte afin de les lire avec d’autres logiciels.

On trouve notamment le format *Comma Separeted Values* lisible par *Excel*. 

### Le format CSV

Le format CSV vient avec un standard français et anglais (avec un simple logiciel comme Notepad++ et une toute petite REGEX, vous pouvez facilement effectuer la conversion)

- Standard anglais : séparateur de colonne «,»
- Standard français : séparateur de colonne «;»

Séparateur de ligne : (\r)\n (retour de ligne)
Encapsulation des chaînes de caractère " "

|id_personne|nom|prenom|
||||
|2|Shutt|Steve|
|5|Stastny|Peter|
|7|Dryden|Ken|

**Format anglais**
Id_personne,nom,prenom
2,Shutt,Steve
5,Stastny,Peter
7,Dryden,Ken

**Format français**
Id_personne;nom;prenom
2;Shutt;Steve
5;Stastny;Peter
7;Dryden;Ken

### Exporter vers CSV

Par défaut, l’exportation sépare les colonnes par une tabulation.

```mysql
SELECT colonnes INTO OUTFILE 'nom_fichier'
    FIELDS TERMINATED BY ',' 
    OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    FROM nom_table;
```

Une instruction existe aussi à partir de l’invite de commande.

### Gestion de droits

Par défaut (et pour d’évidentes raisons de sécurité), MySQL limite les endroits où il est possible d’exporter un fichier texte.

Dans votre fichier my.ini, il faut ajouter l’instruction suivante 

[mysqld]
secure_file_priv = ""

N’oubliez de redémarrez mysql après.

## Charger à partir d'un fichier CSV

Pour lire un fichier CSV, on utilise l’instruction suivante:

```mysql
LOAD DATA INFILE 'nom_fichier' 
    INTO TABLE Nom_table
    FIELDS TERMINATED BY ',' 
    FIELDS ENCLOSED BY '"'
    LINES TERMINATED BY '\r\n';
```

Une instruction existe aussi à partir de l’invite de commande.