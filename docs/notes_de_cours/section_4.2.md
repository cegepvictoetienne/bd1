# Confidentialité des données

Cryptage et hashage
Cryptage à clé symétrique
Cryptage de la BD

## Cryptage et hashage

Il est très souvent nécessaire d'assurer la confidentialité des données. Ainsi, un administrateur de BDD ne peut pas voir les informations de certains champs ou tables.

Quelle est la distinction entre le cryptage et le hashage?

**Cryptage** : transformation des données à l’aide d’une donnée secrète appelée clé

**Hashage** : transformation *non inversible* à l’aide d’un algorithme

Doc : https://dev.mysql.com/doc/refman/8.0/en/encryption-functions.html

## Hashage

Une fonction de hashage accepte généralement une seule chaîne en entrée et retourne une valeur correspondant à l’entrée (appelé *hash*).

La fonction peut produire un *hash* unique pour chaque entrée (fonction injective) ou permettre à plusieurs entrées de partager le même *hash*. Le deuxième cas est celui le plus rencontré.

Il faut évidemment évaluer le risque de collision de *hash* (partage de valeur). Pour le *hash* de Git, ce risque est estimé à environ $1 \times 10^{-48}$, soit de tirer au hasard un atome sur la Terre. 

Les fonctions utilisables par MySQL (et d'autres langages) sont

|Fonction|Longueur du hash|Type de colonne|
||||
|MD5|128 bits|CHAR(32)|
|SHA|160 bits|CHAR(40)|
|SHA2|variable|CHAR(56) à CHAR(128)|

Elles retournent toutes un hash en hexadécimal. On peut le convertir en binaire en utilisant la fonction **UNHEX**().

### SHA2

La fonction SHA2 permet d’utiliser divers algorithmes. Les algorithmes sont SHA-224, SHA-256, SHA-384 et SHA-512.

L’algorithme retourne un nombre de bits égal au nombre après le SHA (par exemple SHA-256 retourne un nombre binaire de 256 bits).

Le standard est d’utiliser au moins 256 bits. On voit souvent 256 et 512 être utilisés.

**Exemple**

L’utilisateur veut enregistrer un mot de passe 'tarte123'. Pour le hasher avec SHA-256 avant de l’intégrer à la BD on utilise :

```mysql
INSERT INTO Utilisateur (nom, mot_de_passe)
    VALUES ('Patissier21', SHA2('tarte123', 256));
```

**Résultat de SHA2**

La requête 
```mysql
SELECT * FROM Utilisateur;
```

retourne:

```
| nom           | mot_de_passe                                                     |

| patissier21   | b2c4b81704855df00cff57312d46ec28254e2f69f526cc61da5f2df20c43d075 |
| jardiner14    | b48cea174391677879618ace9ea78531f5a0d18551de187ee76eb3190624ef35 |
...
```
### Avantages et désavantages du hashage

Avantages :

* Plus rapide qu’un cryptage
* Espace mémoire constant
* Impossible à inverser

Désavantage :

* Impossible d’avoir accès à la donnée originale

### Quand utiliser le hashage?

* Pour les données que nous n’avons pas besoin de consulter
* Vérification d’intégrité de fichier ou de transport (checksum) 

### Fonction de SHA256

https://qvault.io/cryptography/how-sha-2-works-step-by-step-sha-256/#:~:text=SHA%2D2%20is%20an%20algorithm,is%20the%20output%20size%2C%20256.

1. Convertir en binaire
2. Ajouter un 1
3. Allonger avec des 0 à la fin pour obtenir un multiple de 512 moins 64 bits
4. Ajouter la longueur de l'entrée originale en binaire sur 64 bits.

**Exemple**

1. Allo -> **01100001 01101100 01101100 01101111**
2. 01100001 01101100 01101100 01101111 **1**
3. 01100001 01101100 01101100 01101111 1**000000 00000000 00000000 
   00000000 00000000 00000000 00000000 00000000 00000000 00000000 
   00000000 00000000 00000000 00000000 00000000 00000000 00000000 
   00000000 00000000 00000000 00000000 00000000 00000000 00000000 
   00000000 00000000 00000000 00000000 00000000 00000000 00000000 
   00000000 00000000 00000000 00000000 00000000 00000000 00000000
   00000000 00000000 00000000 00000000 00000000 00000000 00000000 
   00000000 00000000 00000000 00000000 00000000 00000000 00000000**
4. 01100001 01101100 01101100 01101111 1000000 00000000 00000000 00000000
   00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
   00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
   00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
   00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
   00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
   00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
   **00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000100**
5. Initialisation des 8 constantes de hash qui sont la représentation binaire des 32 premiers bits de la partie fractionnaire des racines des 8 premiers nombres premiers (2, 3, 5, 7, 11, 13, 17, 19)

**Exemple**

Racine de 2 = 1.41421356237
Partie fractionnaire = 41421356237
En binaire = 1101010000010011110011001100111

6. Initialisation des 64 constantes d'arrondissement qui sont la représentation binaire des 32 premiers bits de la partie fractionnaire des racines cubiques des 64 premiers nombres premiers (2, 3, 5, 7, 11, 13, 17, 19 - 311)
7. Création de *chunk* (segment) de 512 bits de long
8. Création du message pour chaque *chunk* 
9. Compression du message en utilisant les constantes établies et concaténation du résultat.

## Cryptage

Une fonction de cryptage transforme une chaîne avec les données d’une chaîne secrète appelée « clé ».

Texte clair + clé 🡺 texte crypté
Texte crypté + clé 🡺 texte clair 

On appelle cryptage à clé symétrique lorsque la clé servant à crypter et à décrypter est la même.

Voir Illustration - Hashage et cryptage 

### Sécurité du cryptage symétrique

La sécurité d’un cryptage à clé symétrique repose sur 2 facteurs :

- Le secret de la clé
- La longueur de la clé

### Algorithme AES

Le Advance Encryption Standard (AES) est la méthode de cryptage symétrique la plus utilisée aujourd’hui.

Les données sont cryptées par bloc de 128 bits. La clé peut faire 128, 192 ou 256 bits.

Il effectue plusieurs étapes de permutation / substitution

### Crypter avec MySQL

Pour crypter, on utilise la fonction **AES_ENCRYPT**. Son premier argument est le texte à crypter et le second la clé secrète. La clé doit avoir entre 128 et 256 bits.

```mysql
INSERT INTO Utilisateur (nom, carte_credit)
  VALUES ('Patissier21', AES_ENCRYPT('1234123412341234',  
  UNHEX('F3229A0B371ED2D9441B830D21A390C3')));
```

On place le résultat dans un BLOB.

#### Fonction UNHEX

La fonction **UNHEX** convertit une chaîne de valeurs hexadécimale en sa représentation sous forme de chaîne de caractères.

|Mot|HEX(*mot*)|CAST(UNHEX(*hex*) AS CHAR)|
||||
|A|41|A|
|Allo|416C6C6F|Allo|

### Décrypter avec MySQL

Pour décrypter, on utilise la fonction **AES_DECRYPT**. Le premier argument est la valeur à décrypter, le second la clé secrète.

```mysql
SELECT nom, CAST(AES_DECRYPT(carte_credit,   
  UNHEX('F3229A0B371ED2D9441B830D21A390C3’)) AS CHAR)
  AS carte_credit FROM Utilisateur;
```

Le résultat du décryptage.

```console
| nom           | carte_credit     |

| patissier21   | 1234123412341234 |
| jardiner14    | 9876987698769876 |
```

Si la mauvaise clé est passée, alors la valeur NULL est retounée (et non le résultat du décryptage avec la mauvaise clé !)

### Phrase secrète

Plutôt que d’utiliser une clé binaire, on peut utiliser une phrase secrète comme mot de passe. La clé est cependant limitée à 256 caractères. Comment fait-on ?

* On peut hasher la phrase secrète pour obtenir une chaîne de la bonne longueur !

# Phrase secrète

```mysql
# Insertion
INSERT INTO Utilisateur (nom, carte_credit) 
  VALUES ('Patissier21', AES_ENCRYPT('1234123412341234',
                           UNHEX(SHA2('secret', 256))));

# Lecture
SELECT nom, 
  CAST(AES_DECRYPT(carte_credit, UNHEX(SHA2('secret', 256))) AS CHAR) AS 'Carte credit'
  FROM Utilisateur;
```

# Cryptage de la BD

L’engin de stockage de données InnoDB permet de crypter l’ensemble d’une table ou de la BD. Via un plug-in.

Ces manipulations ne sont pas vues en classe.

https://dev.mysql.com/doc/refman/8.0/en/innodb-data-encryption.html

### :material-cog: --- Exercice 4.2.1 ---

On crée la table de renseignements personnels suivant :

1. Nom
2. Mot de passe
3. Le contenu du certificat de naissance
4. Une chaîne authentifiant le contenu du certificat de naissance
5. Numéro de compte en banque
6. Date de naissance

Ajoutez les informations d’une personne fictive en cryptant ou hashant les données selon la situation.

Affichez ensuite ces informations