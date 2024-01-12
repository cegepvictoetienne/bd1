Établir une stratégie de sauvegarde de la BD

## Pourquoi sauvegarder une BD?

Pouvoir restaurer la BD dans les cas de :

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

## Étapes d’une stratégie de sauvegarde

1. Déterminer les données à sauvegarder?

* Qu’est-ce qui est critique?
    * Grouper par groupe : critique pour survivre, important pour opérer, optimal pour le développement
* Qu’est-ce qui est suffisamment important pour investir dans sa sauvegarde?
    * Dans cette question, évaluez le rapport quantité/coût. Faire une sauvegarde de Facebook (+/- 100 Po) est plus lourd qu’une sauvegarde de Wikipédia (+/- 10TB).

2. Déterminer la fréquence des sauvegardes?

* Sauvegardes périodiques (quotidienne, hebdomadaire)
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

* Ne pas tenter la loi de Murphy/loi de l’emmerdement maximal
  * La journée que vous avez besoin de restaurer la sauvegarde, il y a intérêt à ce que ça fonctionne
* Tenez compte des modifications aux structures de données
    * Avec l’évolution du projet, la stratégie de sauvegarde doit évoluer

## Types de sauvegarde

* Sauvegarde complète
    * Crée une copie complète de toutes les données
    * Pour : facile à mettre en place et diminue les risques d’incohérence à la restauration
    * Contre : demande beaucoup d’espace de stockage, car duplique l’information
* Sauvegarde différentielle
    * Crée une copie seulement des changements
    * Pour : ne duplique pas l’information de sauvegarde
    * Contre : système de restauration plus complexe qui peut s’effondrer si l’historique est corrompu.