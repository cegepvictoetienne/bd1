# Bases de données 1 (420-2B4-VI) - Hiver 2026
## Introduction
Vous trouverez ici les notes et exercices du cours. J'ajouterai du nouveau contenu continuellement.

**Préalable à ce cours** : 420-1D6-VI Programmation 1

**Ce cours est préalable à** :
420-3B4-VI : Bases de données 2 (approfondissement de la conception et intégration à des applications logicielles/web)  
420-3A5-VI : Développement web 2 (intégration des BD dans un contexte web)  
420-3C4-VI : Piratage éthique (sécuriser les applications)  
420-4C4-VI : Mégadonnées (efficacité des traitements sur de grands ensembles et base de données NoSQL)  

Il est donc préalable, indirectement, à presque tous les cours de la 3e année.

**Cheminement complet**: [https://techinfo.profinfo.ca/grille/](https://techinfo.profinfo.ca/grille/)  

## Environnement de travail

Afin d’utiliser MySQL vous devez installer deux logiciels :

* AMPPS, qui contient MySQL Server (installé aussi dans le cours de web 1)
* MySQL Workbench

### AMPPS
AMPPS est une pile Apache (Apache, MySQL, Php, Perl et d’autres) disponible à [https://ampps.com/](https://ampps.com/)

*Note* : si vous avez une erreur en lien avec « Microsoft c++ redistributable », lisez les détails de l’erreur. S’il est indiqué qu’une autre version est déjà installée, c’est probablement une version plus récente, ce qui est sans conséquence.

Une fois installé, vous n’avez qu’à le lancer pour voir apparaître cette petite fenêtre au bas à droite de votre écran. Le statut de MySQL devrait être vert (ça peut prendre quelques secondes après le démarrage pour passer du rouge au vert, c’est normal).

![AMPPS](images/ampps.png)

Note: si vous voulez, vous pouvez configurer AMPPS pour qu'il démarre automatiquement à l'ouverture de votre session Windows. Sinon vous devrez le démarrer manuellement.
 
### MySQL Workbench

Téléchargez-le sur le site [https://www.mysql.com/fr/products/workbench/](https://www.mysql.com/fr/products/workbench/)

À l’installation, choisissez « Client only ».

Pour le lancer, il suffit de cliquer sur l’application. Vous devez d’abord démarrer MySQL Server. 

Une fois l’application lancée, vous devez ajouter une connexion en cliquant sur « + » (seulement au premier démarrage). 

![](images/wb01.png)
 
Dans la fenêtre qui apparaît, entrez les infos suivantes :

* Connection Name : le nom de votre connexion. Vous pouvez mettre ce que vous voulez, tant que vous le retrouvez.

* Password : cliquez sur Store in Vault… et entrez le mot de passe : « mysql ».

* [optionnel] : cliquer sur le bouton Test Connection en bas à droite.

* Cliquer sur le bouton OK.

![](images/wb02.png)

Si tout se passe bien, vous verrez la fenêtre suivante:

![](images/wb03.png)

Vous allez pouvoir entrer des commandes SQL dans la zone indiquée. L’icône de disquette permet de sauvegarder vos scripts. L’éclair exécute tout le script tandis que l’éclair avec un curseur exécute que la requête dans laquelle votre curseur est situé.