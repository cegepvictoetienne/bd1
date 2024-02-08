# Détecter et corriger les erreurs dans un script SQL

## Étapes de déboguage  

1. Assurer l'ordre des opérations  

    L'ordre des opérations est la suivante :

    1. **SELECT** 
    2. **FROM**
    3. **WHERE**
    4. **GROUP BY**
    5. **HAVING**
    6. **ORDER BY**
    7. **LIMIT**

2. Vérifier la syntaxe
    
        Vérifier la syntaxe tel que les virgules, les guillemets, les parenthèses, les points-virgules, etc.

3. Vérifier les noms de colonnes et de tables

    Vérifier que les noms de colonnes et de tables sont corrects.

4. Vérifier que les opérations sont exécutés avec le bon type de données

    Vérifier que les opérations sont exécutés avec le bon type de données. Par exemple, une opération de comparaison entre un entier et une chaîne de caractères.

5. Vérifier que les opérations concordent avec les instructions

    Vérifier que les opérations concordent avec les instructions. Par exemple, une clause *WHERE* qui ne concorde pas avec les instructions.

## Exemple de déboguage

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
        VARCHAR(255) prenom
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

### Exemple 1

```sql
SELECT nom, prenom, FROM etdiants
    WHERE code_etudiant = '1234567';
```

#### Analyse

1. **Assurer l'ordre des opérations** : L'ordre des opérations est respecté.
2. **Vérifier la syntaxe** : Il y a une virgule en trop après *prenom*.
3. **Vérifier les noms de colonnes et de tables** : Le nom de la table *etudiants* est mal orthographié.
4. **Vérifier que les opérations sont exécutés avec le bon type de données** : Le code étudiant est comparé à une chaîne de caractères alors qu'il s'agit d'un entier.
5. **Vérifier que les opérations concordent avec les instructions** : Tout semble beau.

#### Solution

```sql
SELECT nom, prenom FROM etudiants
    WHERE code_etudiant = 1234567;
```

### Exemple 2

Affichez la liste des noms des enseignants qui ont été embauchés il y a moins de 2 ans.

```sql
SELECT nom WHERE year(date_embauche) > adddate(now(), INTERVAL 2 YEAR) FORM enseignants;
```

#### Analyse

1. **Assurer l'ordre des opérations** : L'ordre des opérations n'est pas respecté, le *WHERE* doit suivre *FROM*.  
2. **Vérifier la syntaxe** : Il y a une faute de frappe dans le mot *FROM*.
3. **Vérifier les noms de colonnes et de tables** : Tout semble correct.  
4. **Vérifier que les opérations sont exécutés avec le bon type de données** : La fonction *year* retourne un entier alors que *adddate* retourne une date.
5. **Vérifier que les opérations concordent avec les instructions** : *adddate* ajoute 2 ans à la date actuelle, ce qui n'est pas ce qui est demandé, il faut soustraire 2 ans.

#### Solution

```sql
SELECT nom FROM enseignants WHERE date_embauche > subdate(now(), INTERVAL 2 YEAR);
```

### Exemple 3

Affichez le nom de tous les employés embauchés en mai.

```sql
SELECT code_employe, nom 
FROM employes 
WHERE month(date_embauche=5);
```

#### Analyse

1. **Assurer l'ordre des opérations** : L'ordre des opérations est respecté.
2. **Vérifier la syntaxe** : La fonction *month* est exécutée avec le résultat de *date_embauche=5* qui est un booléen.
3. **Vérifier les noms de colonnes et de tables** : Tout semble correct.
4. **Vérifier que les opérations sont exécutés avec le bon type de données** : La fonction *month* retourne un entier alors que *date_embauche* est une date.
5. **Vérifier que les opérations concordent avec les instructions** : Les instructions demandent que le nom de l'employé, pas le code.

#### Solution

```sql
SELECT nom
FROM employes
WHERE month(date_embauche) = 5;
```

### :material-cog: --- Exercice B.1.1 ---

A. Corrigez les erreurs dans le script suivant.

Sélectionnez le nom, le prénom et le numéro d'étudiant de tous les étudiants admis en 2021. 

```sql
SELECT nom, prenom numero_etudiant
FROM etudiantes
WHERE annee_admission = '2021-08-01';
```

B. Corrigez les erreurs dans le script suivant.

Sélectionnez le nom, le prénom et le code du programme de tous les étudiants inscrits au programme 420.A0, triés par ordre alphabétique de nom et prénom.

```sql
SELECT nom, prenom, code_programme
SORTED BY nom 
FROM etudiants
WHERE code_porgramme = 420.A0;
```

C. Corrigez les erreurs dans le script suivant.

Sélectionnez le nom des 5 évaluations qui ont la note maximale la plus élevée.

```sql
SELECT nom_evaluation, note_max
FROM evaluations
ORDER BY note_max 
FIRST 5 ROWS ONLY;
```