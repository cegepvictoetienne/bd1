# Variables, conditions et boucles

On retrouve 2 types de variables en MySQL :

- Variables globales 
- Variables locales

Les variables globales sont accessibles partout, mais elles doivent être redéclarées à chaque exécution.

Lorsqu'on peut utiliser une variable **locale**, *on le fait!*

## Variables globales

Pour déclarer ou modifier une variable globale on utilise l’instruction:

```sql
SET @variable = valeur
```

Les valeurs possibles dans une variables sont :

Integer, decimal, float, blob, text

Tout autre type est converti dans l'un de ces types.

## Afficher une variable

On utilise l’instruction SELECT pour afficher une variable.

```sql
SET @nombre = 12;
SELECT @nombre;
```

Le résultat est :
```
| @nombre |
--
| 12      |
```

## Variables locales

Elles doivent être utilisées dans un bloc **BEGIN ... END**

```sql
DECLARE nom TYPE DEFAULT valeur;
```

Par exemple
```sql
DECLARE _nombre INTEGER DEFAULT 12;
```

Le **DEFAULT** valeur peut être omis pour ne pas affecter de valeurs lors de la déclaration. On les modifie également en utilisant l’instruction **SET** ou un **SELECT**.

## Variables locales

Toutes les instructions **DECLARE** doivent être au début du bloc **BEGIN**.

**Pour reconnaître les variables locales des colonnes, toutes les variables locales doivent être préfixées de  (standard de code)**

## Opérations

Les opérations arithmétiques et de comparaison sont permises dans les membres de droite des assignations.

On peut également utiliser les variables dans les requêtes.

```sql
SELECT nom FROM etudiants 
  WHERE code = @code;
```

# Conditions et boucles

L’instruction conditionnelle de base à la syntaxe suivante

```sql
IF condition THEN
	traitements…
END IF;
```

Pas d’accolade { }, elles sont remplacées par THEN … END IF;

Par exemple, on vérifie que l'âge est plus grande ou égale à 18 (le code ne fonctionne pas, on ne peut pas mettre d'instructions conditionnelles hors d'une fonction en SQL).

```sql 
IF @age >= 18 THEN
  SELECT 'Vous etes majeur';
END IF;
```

## Traitements alternatifs

```sql
IF condition THEN
	traitement
ELSEIF condition alternative THEN
	traitement
ELSE
	traitement
END IF;
```

## Instruction par cas

Semblable à l’instruction *switch*

```sql
CASE 
  WHEN condition THEN traitement
  WHEN condition THEN traitement
  ELSE traitement
END
```

La première condition validée est exécutée, puis le CASE est conclut (pas de *break* et pas de possibilité d'effectuer plusieurs traitements).

## Exemple de CASE 

L'exemple est un peu avancé, retenez l'élément suivant : on peut utiliser le CASE directement dans un SELECT

```sql
SELECT  	
  CASE 
    WHEN nb_echecs = 0 THEN "Pas d'echec"
    WHEN nb_echecs <= 2 THEN '2 echecs ou moins'
    ELSE 'Plus de deux echecs' 
  END
  FROM ...  		
    
```

## Instructions répétées

Boucle while qui exécute un traitement tant que la condition est vérifiée.

```sql
WHILE condition DO
	traitements…
END WHILE;
```

Boucle qui effectue au moins une fois le traitement (semblable à la boucle do-while).

```sql
REPEAT 
	traitements…
UNTIL condition
END REPEAT;
```