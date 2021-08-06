# docker-alpine-backup-agent

conteneur de backup sur un nas distant. utilisation de rsync et de backups par lien hard pour economiser de la place

### parameters

 *  `NAS_IP      `
 *  `NAS_SSH_PORT` (22 by default)
 *  `NAS_SSH_PASS`
 *  `NAS_SSH_USER` (root by default)
 *  `NAS_SCRIPTS_POS` position des scipts du service sur le nas (by default /usr/local/bin)
 *  `BACKUP_SOURCES`  dossiers a backup (pas de / a la fin !)
 *  `BACKUP_DESTINATION` endroit où backup
 *  `BACKUP_CONF`

### backup conf retention

le backup conf est un `string`  de la forme : `[01]+-[01]+-[01]+-[01]+`

la premiere partie gere les jours, la seconde les semaine, la troisieme les mois et la derniere les années de retention

example:
```
11100000-10100-100001-10001

cette configuration garde en retention:
	* les 3 derniers jours
	* la derniere semaine
	* l'avant avant derniere semaine (notée week.3)
	* le dernier mois
	* le dernier '6 mois' (demie année)
	* la derniere année
	* la derniere '5 ans' (demie décénie)
```

### logs

toutes les opérations sont log dans un fichier backup.log a la racine du dossier de backup sur le nas (**ne pas supprimer !**)


## Warnings

2 fichiers doivent absolument etre conserver : `backup.log` et `.backup.conf`

**si ces derniers sont modifiés, des données peuvent etre perdu !**

## Feature

si la configuration du conteneur de backup est modifiée, une sauvegarde instantannée au format zip est faite du dossier de backup du nas

attention cela peut entrainer une augmentation drastique de la taille du dossier de backup

### dockerfile example

```
version: '3'
services:

  backup-agent:
    build: .
    environment:
      - NAS_IP=192.168.0.36
      - NAS_SSH_PORT=22
      - NAS_SSH_PASS=guest
      - NAS_SSH_USER=guest
      - NAS_SCRIPTS_POS=/home/guest/backup_scripts

      - BACKUP_SOURCES=/mnt/tosave /root
      - BACKUP_DESTINATION=/home/guest/backup

        #          |days|weeks|months|years
      - BACKUP_CONF=1110-00000-100000-00000
    volumes:
      - ./tosave:/mnt/tosave
```

