# Fonctions statistiques et filtrage

- Fonctions statistiques  
- Opérateurs d'ensemble  
- Atelier  

Plusieurs fonctions statistiques existent dans les agrégats.

On a déjà vu la fonction count qui permet de compter le nombre d’enregistrements.

On peut utiliser les fonctions statistiques hors des agrégats de données. Par contre, la restriction aux colonnes non agrégées s’applique.

## Fonctions statistiques

Sauf pour **count**, les fonctions sont  appellées sur des colonnes de type numérique.

|Fonction|Opération|
|||
|**sum**(nom_colonne)|Somme les valeurs de la liste|
|**min**(nom_colonne)|Trouve la valeur minimale parmi la liste|
|**max**(nom_colonne)|Trouve la valeur maximale parmi la liste|
|**avg**(nom_colonne)|Calcule la valeur moyenne de la liste|
|**count**(nom_colonne)|Compte le nombre de valeurs de la liste|
|**std**(nom_colonne)|Calcule l'écart-type des valeurs de la liste|

### Trouver le minimum

Affichez la note minimale qu’un étudiant a obtenue à l’évaluation portant l’id 5.

```mysql
SELECT min(note) FROM evaluations_etudiants
    WHERE evaluation_id = 5;
```

## :material-cog: --- Exercice 2.6.1 ---

A. Sélectionnez la valeur de la plus haute note obtenue à l'évaluation 9.
 
B. Sélectionnez le nom de l'étudiant ayant obtenu la plus haute note à l'évaluation 9.
 
C. Sélectionnez la note totale de l'étudiant 1234567 au groupe 2.

D. Sélectionnez la moyenne (en pourcentage) de l'évaluation 7.

## Afficher toutes les valeurs

Pour s'aider dans le debogage, on peut afficher le contenu d'un groupe. La fonction qui permet cela est **GROUP_CONCAT**.

Par exemple, voici le nom des étudiants inscrit au programme 420.01.

```mysql
SELECT GROUP_CONCAT(etudiants.nom), count(*) FROM etudiants 
    INNER JOIN programmes ON etudiants.code_programme = programmes.code_programme 
    WHERE programmes.code_programme = '420.01'
    GROUP BY etudiants.nom;
```

## Opérateurs d'ensemble

Des opérateurs existent sur les ensembles pour simplifier les requêtes de sélection.

Deux opérateurs existent :
- BETWEEN
- IN

### Between

Le mot-clé BETWEEN permet de chercher un enregistrement entre deux valeurs.

```mysql
... WHERE nom_colonne BETWEEN minimum AND maximum

-- équivalent à

... WHERE nom_colonne >= minimum AND nom_colonne <= maximum
```

### Négation

On peut appliquer la négation avec l'opérateur **NOT** à l'opérateur **BETWEEN** pour signifier toutes les valeurs sauf celles dans cet interval. La syntaxe est :

```mysql
... WHERE nom_colonne NOT BETWEEN minimum AND maximum
```

### IN

Pour vérifier si la colonne correspond à une valeur parmi une liste, on peut utiliser l’opérateur **IN**.

```
... WHERE nom_colonne IN (valeur1, valeur2 …)

-- équivalent à

... WHERE nom_colonne = valeur1 OR nom_colonne = valeur2 OR …
```

### IN avec Négation

On peut aussi utiliser l'opérateur de négation **NOT** devant l'opérateur **IN** pour sélectionner toutes les valeurs sauf celles dans l’intervalle.

```mysql
... WHERE nom_colonne NOT IN (valeur1, valeur2, ...)
```

## :material-cog: --- Exercice 2.6.2 ---

Sélectionnez le nom des étudiants qui ont suivi au moins l'un des cours suivants :

- 420-2B4-VI
- 420-2B3-VI
- 420-3B1-VI 
 
Sélectionnez les documents remis avant le 16 octobre 2020 ou après la fin de la session automne 2020 (19 décembre 2020)