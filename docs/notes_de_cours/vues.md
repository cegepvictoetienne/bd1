# Vues (Views)

En SQL, les vues permettent d'enregistrer une requête fréquemment utilisée pour la réutiliser aisément dans d'autres requêtes. Une vue agit comme une requête stockée et nommée, accessible comme une table virtuelle.

## Avantages de créer une vue

- **Simplification des requêtes** : Les vues permettent de réduire la complexité des requêtes en masquant les détails de la jointure et des calculs.
- **Sécurisation des données** : Les vues peuvent limiter l'accès à certaines données, ce qui est utile pour protéger les informations sensibles.
- **Facilitation de la maintenance** : Les modifications apportées à une vue se répercutent sur toutes les requêtes qui l'utilisent, simplifiant ainsi la maintenance.

Il est important de noter que les vues ne sont pas un moyen d'optimiser les performances des requêtes. Lorsqu'une vue est utilisée dans une requête, la requête sous-jacente de la vue est exécutée en premier, suivie de la requête principale.

# Créer une vue

Pour créer une vue, utilisez la syntaxe suivante :

```sql
CREATE [OR REPLACE] VIEW [nom_bd.]nom_view [(liste_colonne)]
AS
requête_select;
```

- **CREATE [OR REPLACE]** : Si la vue existe déjà, `OR REPLACE` permet de la remplacer.
- **[nom_bd.]nom_view** : Le nom de la vue doit être unique dans la base de données.
- **[(liste_colonne)]** : Les noms des colonnes de la vue peuvent être spécifiés; sinon, ils seront dérivés de la requête SELECT.
- **requête_select** : La requête SELECT peut interroger des tables et d'autres vues.

## Exemple

```sql
CREATE OR REPLACE VIEW etudiants_informatique (nom_complet, da)
AS 
    SELECT CONCAT(e.nom, ', ', e.prenom) AS nom_complet,
           e.da
    FROM etudiants e
    JOIN etudiants_concentration ec ON ec.etudiant_id = e.id
    JOIN concentrations c ON c.id = ec.concentration
    WHERE c.description = 'Technique informatique';
```

Utilisation de la vue :

```sql
SELECT * 
FROM etudiants_informatique
ORDER BY da;
```

# Modifier une vue

Pour modifier une vue, utilisez `CREATE OR REPLACE VIEW` ou `ALTER VIEW`. Les deux commandes modifient la vue existante :

```sql
ALTER VIEW nom_view [(liste_colonne)]
AS requête_select;
```

!!! Note
    Le nom de la vue ne peut pas être modifié directement par `ALTER VIEW`. Pour renommer une vue, utilisez :

    ```sql
    RENAME TABLE ancien_nom_vue 
    TO nouveau_nom_vue;
    ```

# Supprimer une vue

Pour supprimer une vue :

```sql
DROP VIEW [IF EXISTS] nom_vue;
```

L'option `IF EXISTS` permet d'éviter une erreur si la vue spécifiée n'existe pas.

Source

- [https://dev.mysql.com/doc/refman/8.0/en/create-view.html](https://dev.mysql.com/doc/refman/8.0/en/create-view.html)
- [https://www.mysqltutorial.org/mysql-views-tutorial.aspx](https://www.mysqltutorial.org/mysql-views-tutorial.aspx)