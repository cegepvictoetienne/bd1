# Exercice 11 - Gestion des usagers

Pour cet exercice nous allons utiliser la base de données **credit_social** (voir le script de création dans l'[exercice 9](ex09_enonce.md)).Vous devez produire un script SQL qui va effectuer les opérations suivantes. Assurez-vous de tester que les permissions sont bien appliquées. Vous pouvez ajouter les réponses des sections "e" dans le même script en commentaire.

## 1. Usager mike

a) Créez un usager avec les informations suivantes : 

- nom : mike
- mot de passe : !alph2
- hôte accepté : tous

b) Creez un rôle nommée `alpha`

c) Donnez les permissions suivantes à ce rôle : 

- Il a la permission de tout faire dans la base de données credit_social.
- Il peut aussi ajouter des permissions à d'autre usagers.
- Il peut créer des usagers pour *toutes les bases de données*, pas seulement credit_social.

d) Attribuez à l'usager `mike` le rôle `alpha` et assurez-vous que le rôles est activé automatiquement lors de la connexion de l'usager

e) Testez les éléments suivants : 

- Inscrivez le résultat d'une requête SELECT sur une table d'une autre base de données que credit_social. Par exemple **bd2_ex10**.  
- Faites la création de l'usager suivant (le point #2) avec cet usager. Est-ce que ça fonctionne?

## 2. Usager john

a) Créer un usager avec les informations suivantes : 

- nom : john
- mot de passe : !b3ta
- hôte accepté : tous

b) Creez un rôle nommée `beta`

c) Donnez les permissions suivantes à ce rôle : 

- Il peut faire des requêtes SELECT, UPDATE, INSERT sur les tables *citoyens* et *evenements* de la base de données credit_social.
- Il peut exécuter toutes les procédures stockées.

d) Attribuez à l'usager `john` le rôle `beta`

e) Testez les éléments suivants :  

- Essayez de supprimer l'événement avec le id 6 de la table evenement. Inscrivez la requête effectuée et le résultat.
- Exécutez une procédure stockée de la base de données credit_social, par exemple **liste_manifestant()**. Est-ce que ça fonctionne?
- Modifiez le crédit initial du citoyen avec le id 2107 pour 800. Inscrivez la requête effectuée pour la mise à jour et pour valider que la valeur a été modifiée.

## 3. Usager bob

a) Créer un usager avec les informations suivantes : 

- nom : bob
- mot de passe : !g2mm2
- hôte accepté : tous

b) Creez un rôle nommée `gamma`

c) Donnez les permissions suivantes à ce rôle : 

- Il peut faire des requêtes SELECT sur les colonnes nom, prenom et pin de la table *citoyens* de la base de données credit_social.
- Il peut exécuter uniquement la procédure stockée *update_classe* de la base de données credit_social.

d) Attribuez à l'usager `bob` le rôle `gamma`

e) Testez les éléments suivants :  

- Êtes-vous capable de donner le nom et prénom du citoyen avec le id 1111? Sinon pourquoi?
- Faites les modifications nécessaires pour en être capable. Inscrivez l'opération effectuée.
- Trouvez une façon pour permettre à cet usager de pouvoir afficher le nom, prenom et la classe d'un citoyen selon son PIN sans ajouter la table **classe** dans les permissions SELECT de l'usager (indice : on a vu une façon de visualiser les données d'une table sans y avoir accès). Inscrivez les opérations effectuées.
- Testez votre solution avec le PIN `39c0cf42-510c-4811-8c3c-47ab100443ce` et inscrivez le nom complet du citoyen correspondant.