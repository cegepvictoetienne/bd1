# Automatisation des sauvegardes

## Script bat

Le script bat permet de programmer un script s’exécutant dans l’invite de commande. C’est à peu près l’équivalent Windows des scripts bash des environnements UNIX/LINUX.

### Sauvegarder la base de données

**Contenu du fichier .bat** (exemple... il faut que ces dossiers soient les bons!).

Pour ne pas à avoir à taper le mot de passe manuellement, on rajoute l'option -p suivi du mot de passe (sans espace entre le -p et le mot de passe). Attention, ceci montre un mot de passe en texte clair, donc assurez-vous que ce script est visible seulement aux administrateurs.

SET date=%DATE%  
ECHO ================  
ECHO Sauvegarde auto  
ECHO ================  
C:\\program files\\ampps\\mysql\\bin\\mysqldump.exe --all-databases > C:\\backups_sql\\backup_%date%.sql -u root -pmysql  
ECHO Sauvegarde terminee

### Appeler le script

Maintenant, plus qu’à double cliquer sur le script bat pour qu’il s’exécute.

![](images/bat_1.png)

## Programmer la tâche

Avec le planificateur de tâche Windows (Task Scheduler), vous pouvez indiquer à Windows de démarrer une tâche à un moment donné.

Une tâche peut consister à exécuter un script bat par exemple.

Le planificateur se trouve dans « Outils d’administration Windows » dans Windows 10, ou « Outils Windows » dans Windows 11.

![](images/bat_2.png)