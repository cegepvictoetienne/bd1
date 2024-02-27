## Pourquoi faire des sauvegardes (*backups*) d'une BD?

Afin de pouvoir restaurer la BD en cas de :

* Destruction accidentelle (DROP *)
* Bris de serveur (usure/Ti-Guy qui a encore échappé son café)
* Attaque de pirates (ex.: rançongiciel)
* Manipulation erronée (ex. par du développement)
* Récréer les données suite à changement d’environnement (mise à jour MySQL)
* Pour un passage d'un environnement de tests à un déploiement en production
* Catastrophe naturelle, incendie, météorite ou invasion d’extra-terrestres :alien:

## Importance de la sauvegarde

Une perte de données coûte en moyenne entre 4,4 millions au Canada (2021).

Selon certains fournisseurs de stockage, jusqu’à la moitié des entreprises perdront des données au cours de leurs opérations.

## La stratégie 3-2-1

Présentée comme un standard, la règle du 3-2-1 est la suivante:

* 3 copies de chaque donnée
* 2 copies «onsite» (sur le même lieu physique)
* 1 copie «offsite» (dans un emplacement physique différent)

Cette règle est applicable à tout type de sauvegardes, pas seulement les bases de données

## Étapes d’une stratégie de sauvegarde

1. Déterminer les données à sauvegarder

* Qu’est-ce qui est critique? On peut grouper ainsi:
      * critique pour survivre
      * important pour opérer
      * optimal pour le développement
* Qu’est-ce qui est suffisamment important pour investir dans sa sauvegarde?
    * Dans cette question, évaluez le rapport quantité/coût. Faire une sauvegarde de Facebook (+/- 100 Po) est plus lourd qu’une sauvegarde de Wikipédia (+/- 10To).

2. Déterminer la fréquence des sauvegardes

* Sauvegardes périodiques (quotidienne, hebdomadaire, autre?)
    * Quelle quantité de travail on peut se permettre de perdre?
* Sauvegarde exceptionnelle
    * Quand ces sauvegardes sont-elles requises?

3. Choisir et mettre en place une stratégie

* Préparer deux serveurs locaux (2)
* Préparer un serveur distance/souscrire à un service (1)
* Décrire un système d’organisation des sauvegardes
    * Nomenclature/emplacement logiciel
* Mettre en place une routine de sauvegarde (périodique)
* Mettre en place une procédure de sauvegarde exceptionnelle

4. Tester (régulièrement) et assurer la maintenance

* Tenez compte des modifications aux structures de données
    * Avec l’évolution du projet, la stratégie de sauvegarde doit évoluer
* Ne pas tenter [la loi de Murphy](https://fr.wikipedia.org/wiki/Loi_de_Murphy). Le jour où vous aurez besoin de restaurer la BD, il y a intérêt à ce que ça fonctionne.

## Types de sauvegarde

* Sauvegarde **complète**
    * Crée une copie complète de toutes les données.
    * Facile à mettre en place et diminue les risques d’incohérence à la restauration.
    * Demande toutefois **beaucoup** d’espace de stockage car même l’information qui n'a pas changée.

* Sauvegarde **différentielle**
    * Crée une copie des éléments qui ont *changés* uniquement.
    * Sauvegarde plus rapide.
    * Restauration toutefois plus complexe et qui peut s'effondrer si l'historique est corrompu.