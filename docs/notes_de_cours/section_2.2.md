# Sélection, filtrage et opérateurs logiques

Sélection de colonnes
Filtrage des résultats
Opérateurs logiques
Ordonner et limiter

## Sélection de colonnes

Pour sélectionner des données, la requête est **SELECT** et à la syntaxe de base suivante :

```mysql
SELECT nom_colonne1, nom_colonne2,… FROM nom_table;
```

On indique après le **SELECT** que le nom des colonnes que l’on souhaite récupérer.

Pour récupérer les colonnes sigle et nom de la table Cours, on utilise la requête suivante :

```mysql
SELECT sigle, nom FROM cours;
```

On utilise le symbole __*__ pour indiquer la sélection de toutes les colonnes.

```mysql
SELECT * FROM nom_table;
```

``` mermaid
erDiagram  
{!cours.mermaid!}
    
```

### Alias

Il est possible de renommer des colonnes lors de la sélection (on verra plus tard des applications de ce concept)

Le mot-clé à utiliser est **AS**

```mysql
SELECT sigle, nom AS nom_cours FROM cours 
```

## Filtrer les enregistrements

Tout comme dans un **UPDATE** ou **DELETE**, il est possible d'utiliser la clause **WHERE** dans un **SELECT** afin de restreindre le nombre d'enregistrements affectés.

```mysql
SELECT nom_colonne1, nom_colonne2,… FROM nom_table 
    WHERE condition;
```

### Création de conditions

On peut utiliser les opérateurs suivants pour construire des conditions.

|Opérateur|Symbole|
|||
|Égal|=|
|Différent de|<>|
|Plus grand que|>|
|Plus grand ou égal que|>=|
|Plus petit que|<|
|Plus petit ou égal que|<=|

### Clause WHERE avec valeur NULL

Pour récupérer les colonnes dont la valeur est **NULL**, la structure de la condition est différente. Il faut utiliser le mot-clé **IS**.

```mysql
SELECT nom_colonne1, nom_colonne2... FROM nom_table WHERE nom_colonne IS NULL;
```

On ajoute le mot-clé **NOT** pour avoir les colonnes qui ne sont pas **NULL**

```mysql
SELECT nom_colonne1, nom_colonne2... FROM nom_table WHERE nom_colonne IS NOT NULL;
```

Pour sélectionner le nom des cours dont la durée est supérieure ou égale à 60 heures on utilise la requête suivante.

```mysql
SELECT nom FROM cours 
    WHERE duree >= 60;
```

Pour sélectionner les sigles des cours dont le nom est **NULL**, on utilise la requête suivante.

```mysql
SELECT sigle FROM cours 
    WHERE nom IS NULL;
```

``` mermaid
erDiagram  
{!cours.mermaid!} 
```

On peut combiner les opérations de filtrage en utilisant les opérateurs logiques.

|Opérateur|Instruction|
|||
|Et|AND|
|Ou|OR|

Sélectionnez le nom des cours où la durée est entre 60 et 75 heures incluse.

```mysql
SELECT nom FROM Cours
    WHERE duree >= 60 AND duree <= 75;
```

``` mermaid
erDiagram  
{!cours.mermaid!} 
```

### :material-cog: --- Exercice 2.2.1 ---

À partir du script [ecole.sql](../ecole.sql), créez la base de données **ecole** et répondez aux questions suivantes.

``` mermaid
erDiagram  
    
    enseignants ||--o{ programmes : "responsable"
    enseignants {
        NUMERIC(8) code_employe PK
        VARCHAR(255) nom
        NUMERIC(9) num_assurance_sociale
        TINYINT anciennete
    }

    enseignants ||--o{ cours : "enseigne"
    cours {
        INTEGER cours_id PK
        VARCHAR(255) nom 
        CHAR(10) sigle 
        TINYINT duree   "=60"
        TINYINT nombre_semaine   "=15"
        NUMERIC(8) enseignant FK
    }

    groupes ||--|{ cours : ""
    groupes ||--|{ sessions : ""
    groupes {
        INTEGER groupe_id PK
        INTEGER cours_id FK
        VARCHAR(4) session_code FK
        TINYINT numero_groupe
    }  

    programmes {
        CHAR(6) code_programme PK
        VARCHAR(255) nom
        NUMERIC(8) prof_responsable FK
    }

    etudiants }o--|| programmes : "est inscrit à"
    etudiants {
        NUMERIC(7) code_etudiant PK
        VARCHAR(255) nom
        YEAR annee_admission
        CHAR(6) code_programme FK
    }

    sessions {
        VARCHAR(4) session_code PK
        VARCHAR(255) session_saison
        DATE date_debut
        DATE date_fin
    }

    etudiants ||--o{ inscriptions : ""
    inscriptions }o--|| groupes : ""
    inscriptions {
        NUMERIC(7) code_etudiant PK
        INTEGER groupe_id PK
    }

    evaluations }o--|| groupes : ""
    evaluations {
        INTEGER evaluation_id PK
        INTEGER groupe_id FK
        VARCHAR(255) nom_evaluation
        NUMERIC(5_2) note_max
        DATE date_evaluation
    }

    evaluations_etudiants }o--|| evaluations : ""
    evaluations_etudiants {
        NUMERIC(7) code_etudiant PK,FK
        INTEGER evaluation_id PK,FK
        NUMERIC(5_2) note
    }
    
```

A. Sélectionnez les codes d'employé des enseignants qui ont au moins 5 ans d'ancienneté.  
B. Sélectionnez le nom des étudiants admis entre 2019 et 2020.  
C. Sélectionnez la date de début de session de toutes les sessions d'automne.  

## Ordonner les résultats

Pour obtenir des résultats triés, on utilise la clause ORDER BY. Cette clause est optionnelle.

```mysql
SELECT nom_colonne1, nom_colonne2, ... FROM Nom_table
    WHERE condition
    ORDER BY nom_colonne1, nom_colonne2, ...
```

Il faut porter attention à la taille de la sélection, car un tri devient vite couteux en ressources.

Pour sélectionner le nom et la durée des cours et les classer en ordre alphabétique on utilise la requete suivante.

```mysql
SELECT nom, duree FROM cours
    ORDER by nom;
```

``` mermaid
erDiagram  
{!cours.mermaid!} 
```

Maintenant, on veut la même requête, mais en ordonnant d'abord par durée, puis par ordre alphabétique. Voici le résultat attendu :

|nom|duree|
||:-:|
|Mathématique de l'ordinateur|45|
|Base de donnees 1|60|
|Fonctionnement de l'ordinateur|60|
|Développement Web 2|75|
|Programmation 1|90|
|Programmation 2|90|

On peut trier sur plusieurs colonnes en les séparant par des virgules. Le tri se fait en ordre inverse que les colonnes sont indiquées.

```mysql
SELECT nom, duree FROM cours
    ORDER BY duree, nom;
```

Ici on tri par ordre alphabétique et après par durée. Donc le résultat final est *globablement* trié par durée, et pour chaque durée, les éléments sont en ordre alphabétique.

### Tris stables et instables

* Dans la théorie des tris (oui, ça existe et c'est assez riche comme théorie), on parle de tri stable si, pour des valeurs égales, l'ordre original est préservé.

* Dans l'exemple précédent, on tri par ordre alphabétique d'abord. Ensuite, quand on tri par durée, deux cours de même durée resteront dans l'ordre (le tri par durée ne change pas l'ordre des éléments). C'est ce qu'on appelle un tri stable.

* Bien qu'intéressant parce qu'ils permettent le tri par plusieurs colonnes successivement, les tris stables (*bubble*, *insertion*, *merge*) sont généralement plus lents que les tris instables (*quicksort*, *shellsort*, *radix*, *bogosort (a.k.a stupid sort)*).

### Ordonnancement des caractères

Comment se fait un tri sur un CHAR/VARCHAR ?

* Par le code ASCII donc numéro en premier, ensuite lettres majuscules, ensuite lettres minuscules.

* «Boujour» vient donc avant «allo»

* Certains caractères spéciaux sont entre les majuscules et minuscules!

### Ordre décroissant

On peut ajouter l’ordre du tri après le nom d'une colonne dans la clause ORDER BY.

- ASC pour ascendant (croissant). Cette valeur est celle par défaut.
- DESC pour descendant (décroissant)

```mysql
SELECT * FROM Table
    ORDER BY nom_colonne1, nom_colonne2 DESC;

SELECT * FROM Table
    ORDER BY nom_colonne1 DESC, nom_colonne2;
```

## Limiter les résultats

On peut aussi indiquer un nombre maximal de résultats à afficher avec la clause LIMIT

```mysql
LIMIT nombre_sélectionné
LIMIT premier_enregistrement, nombre_sélectionné
```

La clause LIMIT est optionnelle.

On veut par exemple seulement les 5 premiers cours pour avoir un aperçu des données dans la table Cours.

```mysql
SELECT * FROM Cours
    LIMIT 0, 5;

## Alternative

SELECT * FROM Cours
    LIMIT 5;
```

### :material-cog: --- Exercice 2.2.2 ---

A. Sélectionnez les 5 évaluations ayant la plus basse pondération

B. Sélectionnez le nom des 3 étudiants qui ont été admis le plus récemment

C. Sélectionnez tous les groupes, triés par numéro de groupe en ordre croissant et par session, de la plus récente à la plus ancienne (supposez que les sessions sont ajoutées dans l'ordre qu'elles arrivent). Les groupes d'un même cours doivent être regroupés à l'affichage.