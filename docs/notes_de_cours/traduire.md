# Comment traduire une requête du français à SQL  

## Traduire une requête du français à SQL

### Introduction

La traduction d'une requête du français à SQL est une étape importante dans le développement d'une application. Cette étape est souvent négligée, mais elle est essentielle pour s'assurer que la requête est correcte et qu'elle répond aux besoins de l'application.

Dans ce document, nous allons voir comment traduire une requête du français à SQL. Nous allons commencer par un exemple simple, puis nous verrons des exemples plus complexes.

### Étapes pour traduire une requête du français à SQL  

1. Trouver le verbe d'action : le verbe d'action indique le type de requête SQL que nous devons utiliser. Par exemple, si le verbe d'action est "Affichez", cela indique que nous devons utiliser une requête SELECT.  

Voici quelques verbes d'actions courants et leur équivalent en SQL :  

| Verbe d'action | SQL |
|----------------|-----|
| Affichez       | SELECT |
| Interrogez     | SELECT |
| Extraire       | SELECT |
| Récupérez        | SELECT |
| Sélectionnez   | SELECT |
| Montrez        | SELECT |
| Faites la liste | SELECT |
| Trouvez         | SELECT |
| Comptez         | SELECT COUNT |
| Insérez         | INSERT |
| Alimentez       | INSERT |
| Créez          | INSERT |
| Ajoutez         | INSERT |
| Modifiez       | UPDATE |
| Mettez à jour   | UPDATE |
| Changez         | UPDATE |
| Actualisez      | UPDATE |
| Corrigez        | UPDATE |
| Supprimez       | DELETE |
| Effacez        | DELETE |
| Retirez         | DELETE |
| Détruisez       | DELETE |



2. Identifier le sujet : le sujet indique les données que nous devons sélectionner. Par exemple, si le sujet est "les étudiants", cela indique que nous devons sélectionner les données de la table "etudiants".

3. Identifier les objets : les objets indiquent les colonnes que nous devons sélectionner. Par exemple, si les objets sont "le nom et le prénom", cela indique que nous devons sélectionner les colonnes "nom" et "prénom" de la table "etudiants".

4. Identifier les conditions : les conditions indiquent les critères que nous devons utiliser pour sélectionner les données. Par exemple, si les conditions sont "qui ont obtenu une note supérieure à 10", cela indique que nous devons utiliser une clause WHERE.

5. Identifier l'ordre : l'ordre indique comment nous devons trier les données. Par exemple, si l'ordre est "par ordre alphabétique", cela indique que nous devons utiliser une clause ORDER BY.

6. Identifier le nombre de résultats : le nombre de résultats indique combien de résultats nous devons afficher. Par exemple, si le nombre de résultats est "les 10 premiers", cela indique que nous devons utiliser une clause LIMIT.

### Exemple 1  

Supposons que nous voulons traduire la phrase suivante en SQL :

**"Affichez le nom et le prénom de tous les étudiants."**

Il faut analyser la phrase pour en extraire les éléments clés. 

Dans ce cas, les éléments clés sont :

- "Affichez" : cela indique que nous devons utiliser une requête SELECT. D'autres mots de cette catégorie pourraient être "Sélectionnez" ou "Montrez".

```sql
SELECT 
```

- "les étudiants" : cela indique que nous devons sélectionner les données de la table "étudiants".

```sql
SELECT * FROM etudiants;
```  

- "le nom et le prénom" : cela indique que nous devons sélectionner les colonnes "nom" et "prénom" de la table "étudiants".

```sql
SELECT nom, prenom FROM etudiants;
```  

- "tous" : cela indique que nous devons sélectionner toutes les lignes de la table "étudiants", donc pas de condition WHERE.

La requête SQL finale est donc :

```sql
SELECT nom, prenom FROM etudiants;
```  

### Exemple 2

Supposons que nous voulons traduire la phrase suivante en SQL :

**"Faire la liste des noms et prénoms de tous les étudiants qui ont été admis en 2021."**  

Dans ce cas, les éléments clés sont :  

- "Faire la liste" : cela indique que nous devons utiliser une requête SELECT.  

```sql
SELECT 
```

- "les étudiants" : cela indique que nous devons sélectionner les données de la table "étudiants".  

```sql
SELECT * FROM etudiants
```

- "les noms et prénoms" : cela indique que nous devons sélectionner les colonnes "nom" et "prénom" de la table "étudiants".  

```sql
SELECT nom, prenom FROM etudiants
```

- "qui ont été admis en 2021" : cela indique que nous devons utiliser une clause WHERE pour sélectionner les étudiants qui ont été admis en 2021.  

    - Ici, nous devons identifier la colonne qui contient l'année d'admission. Supposons que cette colonne s'appelle "date_admission".  

```sql
SELECT nom, prenom FROM etudiants WHERE date_admission = 2021;
```
    - Cependant, la date d'admission est souvent stockée sous forme de date. Si c'est le cas, nous devons utiliser une fonction pour extraire l'année de la date. La fonction pour extraire l'année de la date s'appelle "YEAR".

```sql
SELECT nom, prenom FROM etudiants WHERE YEAR(date_admission) = 2021;
```

La requête SQL finale est donc :

```sql
SELECT nom, prenom FROM etudiants WHERE YEAR(date_admission) = 2021;
```

### Exemple 3  

Supposons que nous voulons traduire la phrase suivante en SQL :

**"Affichez le nom, le prénom et le nombre d'années d'expérience de tous les employés qui ont plus de 5 ans d'expérience, du plus expérimenté au moins expérimenté."**  

Dans ce cas, les éléments clés sont :

- "Affichez" : cela indique que nous devons utiliser une requête SELECT.  

```sql
SELECT 
```

- "les employés" : cela indique que nous devons sélectionner les données de la table "employés".  

```sql
SELECT * FROM employes
```

- "le nom et le prénom" : cela indique que nous devons sélectionner les colonnes "nom" et "prénom" de la table "employés".  

```sql
SELECT nom, prenom FROM employes
```

- "le nombre d'années d'expérience" : Dans la table "employés", il n'y a pas de colonne "nombre d'années d'expérience". Cependant, nous pouvons calculer le nombre d'années d'expérience en soustrayant la date d'embauche de la date actuelle. La fonction pour soustraire des dates avec l'année comme valeur de retour s'appelle "TIMESTAMPDIFF" et la fonction pour la date actuelle s'appelle "NOW".   

```sql
SELECT nom, prenom, TIMESTAMPDIFF(YEAR,  date_embauche, NOW()) AS nombre_annees_experience 
FROM employes
```

- "qui ont plus de 5 ans d'expérience" : cela indique que nous devons utiliser une clause WHERE pour sélectionner les employés qui ont plus de 5 ans d'expérience.  Nous avons déjà calculé le nombre d'années d'expérience, donc nous pouvons utiliser cette colonne dans la clause WHERE.  

```sql
SELECT nom, prenom, TIMESTAMPDIFF(YEAR,  date_embauche, NOW()) AS nombre_annees_experience 
FROM employes 
WHERE TIMESTAMPDIFF(YEAR,  date_embauche, NOW()) > 5;
```

- "du plus expérimenté au moins expérimenté" : cela indique que nous devons utiliser une clause ORDER BY pour trier les employés par nombre d'années d'expérience, du plus expérimenté au moins expérimenté.  

```sql
SELECT nom, prenom, TIMESTAMPDIFF(YEAR,  date_embauche, NOW()) AS nombre_annees_experience
FROM employes 
WHERE TIMESTAMPDIFF(YEAR,  date_embauche, NOW()) > 5
ORDER BY nombre_annees_experience DESC;
```

La requête SQL finale est donc :

```sql
SELECT nom, prenom, TIMESTAMPDIFF(YEAR,  date_embauche, NOW()) AS nombre_annees_experience
FROM employes 
WHERE TIMESTAMPDIFF(YEAR,  date_embauche, NOW()) > 5
ORDER BY nombre_annees_experience DESC;
```

### Exemple 4

Supposons que nous voulons traduire la phrase suivante en SQL :

**"Affichez le nom et le résultat des 3 étudiants ayant obtenu la meilleure note à l'examen final."**

Dans ce cas, les éléments clés sont :

- "Affichez" : cela indique que nous devons utiliser une requête SELECT.  

```sql
SELECT 
```

- "le nom et le résultat" : cela indique que nous devons sélectionner les colonnes "nom" et "résultat" de la table "étudiants".  

```sql
SELECT nom, resultat FROM etudiants
```

- "des 3 étudiants" : cela indique que nous devons sélectionner les 3 premiers étudiants. Nous pouvons utiliser une clause LIMIT pour cela.  

```sql
SELECT nom, resultat FROM etudiants
LIMIT 3;
```

- "ayant obtenu la meilleure note à l'examen final" : cela indique que nous devons utiliser une clause ORDER BY pour trier les étudiants par résultat, du meilleur au moins bon.  

```sql
SELECT nom, resultat FROM etudiants
ORDER BY resultat DESC
LIMIT 3;
```

La requête SQL finale est donc :

```sql
SELECT nom, resultat FROM etudiants
ORDER BY resultat DESC
LIMIT 3;
```

### :material-cog: --- Exercice A.1.1 ---

Avec le schéma de la base de données suivant, traduisez les phrases suivantes en SQL :

``` mermaid
erDiagram  
    
    enseignants ||--o{ programmes : "responsable"
    enseignants {
        NUMERIC(8) code_employe PK
        VARCHAR(255) nom
        NUMERIC(9) num_assurance_sociale
        DATE date_embauche
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

A. Affichez le nom et le sigle de tous les cours.  

B. Affichez le nom et le sigle de tous les cours enseignés par l'enseignant avec le code 12345678.

C. Affichez le nom du cours et sa durée par semaine pour tous les cours.

D. Faite la liste des noms et les années d'ancienneté des 3 enseignants les plus anciens.  





