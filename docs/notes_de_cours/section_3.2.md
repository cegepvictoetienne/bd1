# Sauvegarder et restaurer une BD

## Dumping

Le «dumping» permet de générer le code SQL COMPLET qui pourra servir à recréer automatiquement toute la BD (CREATE DATABASE, CREATE TABLE et INSERT INTO).

Ce fichier SQL comporte de nombreuses instructions supplémentaires pour assurer que les données sont restaurées normalement.

* Procédure (sur Windows):
    * Ouvrez une invite de commande en mode administrateur (cherchez CMD, ensuite bouton de droite, exécuter en tant qu'Administrateur)
    * Utilisez la commande CD (nom de dossier) pour vous rendre dans le dossier où est situé votre exécutable MySQL (généralement dans C:\\Program Files\\Ampps\\mysql\\bin). Attention il se trouve peut-être aussi une version dans les dossiers de Workbench, mais ce n'est probablement pas celle que vous utilisez dans le cours).
    * La commande à entrer (générique) est la suivante:

```console
mysqldump.exe --databases nom > chemin\fichier.sql –u nom_utilisateur –p
```

Exemple pour la BD ecole que l'on veut "dumper" dans le même dossier:
```console
mysqldump.exe --databases ecole > backup_ecole.sql –u root –p
```

Puis saisissez le mot de passe du compte (par défaut, c'est *mysql*). Vous trouverez ensuite dans le dossier courant le fichier backup_ecole.sql.

On peut faire un dump de plusieurs BD à la fois (va créer un seul gros fichier SQL) en les séparant par des virugles:

```console
mysqldump.exe --databases nom1, nom2, nom3 > chemin\fichier.sql –u nom_utilisateur –p
```

Pour exporter toutes les BD, on peut remplacer **--databases nom** par **--all-databases**.

On peut omettre l’option --databases si l’on en exporte qu’une seule:

```console
mysqldump.exe nom > chemin\fichier.sql –u nom_utilisateur –p
```

## Charger une BD à partir d’un fichier de sauvegarde

Pour charger (donc restaurer) la BD, c’est simple : il suffit d’exécuter le script mysql.

Soit à travers Workbench ou avec l'invite de commandes :

```console
mysql < fichier.sql
```

## Dumping dans un fichier texte non SQL

Il est possible d’exporter le contenu des tables dans des fichiers de format texte (pas SQL) afin de les lire avec d’autres logiciels.

On trouve notamment le format **CSV** (*Comma Separeted Values*) que l'on peut ouvrir par exemple avec *Excel*.

### Le format CSV

Le format CSV vient avec un standard français et anglais (avec un simple logiciel comme Notepad++ et un REGEX, vous pouvez facilement effectuer la conversion)

- Standard anglais : séparateur de colonne «,»
- Standard français : séparateur de colonne «;»

Séparateur de ligne : \\r\\n (retour de ligne)

Encapsulation des chaînes de caractère " "

|id_personne|nom|prenom|
||||
|2|Shutt|Steve|
|5|Stastny|Peter|
|7|Dryden|Ken|

Contenu du fichier si format **anglais** :

Id_personne,nom,prenom
2,Shutt,Steve
5,Stastny,Peter
7,Dryden,Ken

Contenu du fichier si format **français** :

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

Dans votre fichier **my.ini** (disponible généralement dans C:\\Program Files\\Ampps\\mysql\\ampps), il faut ajouter l’instruction suivante sous la section [mysqld]:

[mysqld]
secure_file_priv = ""

N’oubliez de redémarrez mysql après.

Le fichier csv sera disponible dans C:\\Program Files\\Ampps\\mysql\\data\\nom_bd

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


## Table corrompue

Une instruction permet d'essayer de récupérer les données d’une table corrompue (ex.: si vous ne disposez pas du fichier de sauvegarde). La récupération avec cette commande n'est pas garantie:

```mysql
REPAIR TABLE Nom_table EXTENDED;
```

Plus de détail ici: [https://dev.mysql.com/doc/refman/8.0/en/repair-table.html](https://dev.mysql.com/doc/refman/8.0/en/repair-table.html)
