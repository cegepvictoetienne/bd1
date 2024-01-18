# Clés étrangères et relations

## Stocker des informations

Imaginons maintenant que l'on souhaite stocker des informations sur quel étudiant suit quel cours. On pourrait faire quelque chose qui ressemble à ceci :

|Nom|Code|Session|Sigle cours|Duree cours|Nom enseignant|Code employe|
|:--|:--|:--|:--|:-:|:--|:--|
|Tony Stark|1234567|H22|420-2B4-VI|60|Kara Danvers|7654|
|Natasha Romanov|3456789|H22|420-2B4-VI|60|Kara Danvers|7654|
|Tony Stark|1234567|H22|420-2A6-VI|90|Bruce Wayne|8765|
|Thor Odison|6789012|H22|420-2A6-VI|90|Bruce Wayne|8765|

 
!!! note "Problèmes ?"
    * Répétition des valeurs = perte d'espace mémoire !
    * Difficile de faire des modifications (ex. : changer le nom de l'enseignant)

## Relations entre tables

Il faut découper nos informations entre plusieurs tables et faire des références entre les tables. On référence alors la clé primaire d'une des tables dans l'autre table. 

C'est ce que l'on appelle une clé étrangère (__FOREIGN KEY__).

On remarque la direction de la flèche, de la table appelée « enfant » vers la table 
« parent ».

On ajoute dans la table enfant un champ enseignant et une annotation de clé étrangère. Donc ici chaque `cours` possède un `enseignant`.

``` mermaid
erDiagram  
    enseignants ||--o{ cours : "enseigne" 
{!enseignants.mermaid!}
{!cours.mermaid!}    
```

## Importances des relations

On trouve rarement une table isolée dans un modèle de base de données (table en relation avec aucune autre table).

Pour faire une analogie, on pourrait comporarer une table isolée à du code qui n'est pas référencé (fonction qui n'est jamais appelée) dans le domaine de la programmation.

## Clé étrangère SQL

Pour indiquer une clé étrangère, on ajoute la contrainte suivante dans la requête de création de la table.

```mysql
FOREIGN KEY (nom_colonne) REFERENCES table_parent(cle_primaire)
```

Exemple avec la table `cours`

```mysql
CREATE TABLE cours (  
    id INTEGER PRIMARY KEY AUTO_INCREMENT,  
    sigle CHAR (11),  
    duree TINYINT, 
    nom VARCHAR(255),
    enseignant NUMERIC(8),
    FOREIGN KEY (enseignant) REFERENCES enseignants (code_employe));
```

Ici rien ne change dans la création de la table `enseignants` (la table ne sait pas qu'elle est utilisée comme clé étrangère ailleurs).

## Suppression de tables qui contiennent des relations

``` mermaid
erDiagram  
    enseignants ||--o{ cours : "enseigne" 
{!enseignants.mermaid!}
{!cours.mermaid!} 
    
```

Peut-on supprimer la table `enseignants` sans supprimer la table `cours`?   Pourquoi?

!!! warning "Attention"
    Pour pouvoir supprimer une table, celle-ci ne doit pas être référencée par une autre table. Autrement dit, il faut que sa clé primaire ne soit pas une clé étrangère pour une ou plusieurs autres tables.

Si l'on pouvait faire la suppression, la table `cours` aurait une colonne qui contiendrait des clés d'une table inexistante.

## Ordre de création

Afin d'ajouter les contraintes de clés étrangères, la table parent doit être créée avant la table enfants.

Autrement, vous aurez une erreur SQL disant que votre contrainte FOREIGN KEY référence une table inexistante.

## :material-cog: --- Exercice 1.5.1 ---

Proposez un modèle de base de données illustrant qu'un enseignant est responsable d'un programme.

Implémentez la base de données correspondant à votre modèle.

## Tables d'association

Les clés étrangères permettent de référer un enregistrement dans une autre table. Qu'arrive-t-il dans la situation suivante:

Une BD permet de gérer les inscriptions des étudiants à leurs cours. Comment représenter le fait qu'un étudiant puisse s'inscrire à plusieurs cours et qu'à un même cours, plusieurs étudiants puissent s'inscrire ?

On ajoute une table dont le rôle dont les enregistrements représentent chaque relation.

Par exemple, on ajouterait une table `inscriptions` pour représenter notre association. Comme `inscriptions` est créée spécialement pour représenter une association, elle est appelée table d'association.

On voit ici que la table `inscriptions` assure l'association entre `cours`  et `etudiants`.

On peut voir que deux tables sont associées si l'on peut suivre avec notre doigt d'une table à l'autre en empruntant les flèches comme des chemins (ici le sens des flèches n'a pas d'importance).


``` mermaid
erDiagram  
    etudiants ||--o{ inscriptions : " " 
{!etudiants.mermaid!}
    inscriptions }o--|| cours : " "
{!inscriptions.mermaid!}
{!cours.mermaid!}    
```

## Mais... un instant!

Dans la table `inscriptions` la clé primaire est-elle vraiment composée de *deux* colonnes?

Oui, c'est possible: c'est appelé une *clé composée*. 


``` mermaid
erDiagram   
    etudiants ||--o{ inscriptions : " " 
{!etudiants.mermaid!}
    inscriptions }o--|| cours : " "
{!inscriptions.mermaid!}
{!cours.mermaid!}   
    
```

## Clé composée

Pour indiquer une clé composée dans une base de données, nous devrons utiliser la notation de contrainte.

Après avoir déclaré les colonnes, on indique

```mysql
PRIMARY KEY (nom_colonne1, nom_colonne2, … )
```

Ne fonctionne pas :
```mysql
CREATE TABLE inscriptions(
    etudiant NUMERIC(7) PRIMARY KEY, 
    cours INTEGER PRIMARY KEY,
    FOREIGN KEY (etudiant) REFERENCES etudiants (code),
    FOREIGN KEY (cours) REFERENCES cours (cours_id));
```

Bonne écriture :

```mysql
CREATE TABLE inscriptions(
    etudiant NUMERIC(7), 
    cours INTEGER,
    PRIMARY KEY (etudiant, cours),
    FOREIGN KEY (etudiant) REFERENCES etudiants (code),
    FOREIGN KEY (cours) REFERENCES cours (id_cours));
```

## Notation de contraintes

La notation contrainte de __PRIMARY KEY__ s'utilise aussi en présence d'une clé simple (clé comportant une seule colonne).

La notation vue précédemment constitue un raccourci intéressant lorsqu'on travaille.

On revient plus en détail sur les contraintes dans le Chapitre 4 - Assurer l'intégrité des données.