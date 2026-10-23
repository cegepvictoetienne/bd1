# Exercice 6 - Création et gestion de vues

## Contexte
Cet exercice implique la manipulation de vues dans la base de données des athlètes, utilisée dans l'exercice précédent. Le script SQL pour générer les tables nécessaires est accessible [**ici**](../ressources/ex05_create_tables.sql).

## Instructions

1. **Vue `resultats_hhmmss`** :
    - Créez une vue qui convertit et affiche le temps des résultats en format heures, minutes, secondes (hh\:mm\:ss). La vue doit reprendre les colonnes de la table `resultats` en ajoutant une nouvelle colonne `resultat_hhmmss` où le temps est formaté.

2. **Vue `athletes_complets`** :
    - Cette vue doit regrouper des informations provenant de plusieurs tables pour afficher chaque athlète avec les informations suivantes : `id`, `nom prénom concat`, `date_epreuve`, `nom_epreuve`, `resultat`. Les noms des colonnes doivent correspondre exactement à ceux indiqués.

3. **Filtrage sur `athletes_complets`** :
    - Utilisez la vue `athletes_complets` pour extraire et afficher uniquement les données des athlètes ayant participé à un marathon.

4. **Vue `resultats_21juillet2020`** :
    - Créez une vue qui filtre et affiche toutes les entrées de la table `resultats` pour la date du 21 juillet 2020.

5. **Modification de la vue pour une nouvelle date** :
    - Modifiez la vue `resultats_21juillet2020` pour qu'elle affiche les résultats du 14 juillet 2019 et renommez-la en `resultats_14juillet2019`.

6. **Suppression de la vue** :
    - Supprimez la vue `resultats_14juillet2019` une fois les modifications effectuées.

## Livrable
Soumettez toutes les requêtes SQL utilisées pour créer, modifier et supprimer les vues dans un script SQL.