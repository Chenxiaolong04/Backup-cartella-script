# Richiesta

**Obiettivo:**  
Realizzare un sistema che effettui automaticamente il backup della **home di un utente** e lo salvi nella directory `/opt/backup`.

---

# Script di Backup Automatico

Questo sistema esegue backup compressi della cartella `/home/"utente"` e li salva nella directory `/opt/backup`. Vengono mantenuti solo gli ultimi 7 backup.

---

Questo comando permette di creare una cartella directory backup nella cartella opt
sudo mkdir -p /opt/backup

Crea un file di tipo script bash nella directory backup chiamato backup_home.sh
sudo nano /opt/backup/backup_home.sh

Incollare questo script:
#!/bin/bash

# Cartella da salvare
SOURCE="/home/xiaolong"

# Cartella di destinazione backup
DEST="/opt/backup"

# Data odierna per nome file (YYYY-MM-DD)
DATA=$(date +%F-%H%M%S)   # Data + ora + minuti + secondi

# Nome file backup
FILE="backup-$DATA.tar.gz"

# Crea la cartella di destinazione se non esiste
mkdir -p "$DEST"

# Crea il backup compressato
tar -czf "$DEST/$FILE" "$SOURCE"

# Mantieni solo gli ultimi 7 backup
cd "$DEST" || exit
ls -1tr backup-*.tar.gz | head -n -7 | xargs -r rm --

Rendere il file  backup_home.sh eseguibile
sudo chmod +x /opt/backup/backup_home.sh

Quando digiti sudo crontab -e, stai aprendo il file crontab per l’utente root, quindi potrai programmare comandi che verranno eseguiti con i privilegi di amministratore.
sudo crontab -e

All’interno del  file che si apre scrivere la riga sotto cosi eseguirà ogni giorno alle 23:59: 
59 23 * * * /opt/backup/backup_home.sh >> /opt/backup/backup.log 2>&1

oppure la riga sotto che serve per creare il backup ogni minuto per vedere se funziona:
* * * * * /opt/backup/backup_home.sh >> /opt/backup/backup.log 2>&1
