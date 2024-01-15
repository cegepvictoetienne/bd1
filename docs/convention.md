# Convention de nommage MySQL

Bien que MySQL n'a pas vraiment de convention de nommage officiel, voici certaines des règles les plus utilisées.

Ces règles sont **obligatoires** dans notre cours.

## Règles générales

- Toujours écrire les noms des tables et des colonnes (champs) en **minuscule**. Ça peut aider à éviter les erreurs, car MySQL est sensible à la case
- Ne jamais utiliser d'espace, la remplacer par une barre de soulignement "_"
- Ne jamais utiliser de caractères accentués
- Utilisez seulement des lettres dans les noms, pas de nombres ni de caractères spéciaux
- Évitez d'utiliser un préfix dans le nom, ça complique inutilement le nom et nuit à la visibilité (ex.: etudiants_prenom).

## Nom des tables

- Le nom doit être au pluriel
- Le nom doit être en minuscules (pas de *CamelCase*)
- Ne pas utiliser de préfix sauf si c'est inévitable.
- Le nom doit être clair et explicite
- Ne pas utiliser d'abréviation

## Nom des champs

- Le nom doit être en minuscules, sans espace et sans nombres
- On doit éviter les préfixes
- Utilisez un nom court, sans utiliser abréviation par contre
- Ne pas utiliser de mot réservé comme nom de champs, comme date par exemple
- Le nom d'une clé étrangère devrait contenir le nom de la table et de sa clé primaire. Une clé étrangère vers la table usager dont la clé primaire est le champ id devrait être nommée usager_id