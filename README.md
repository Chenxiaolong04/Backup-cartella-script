# Richiesta

**Obiettivo:**  
Realizzare un sistema che effettui automaticamente il backup della **home di un utente** e lo salvi nella directory `/opt/backup`.

---

# Script di Backup Automatico

Questo sistema esegue backup compressi della cartella `/home/"utente"` e li salva nella directory `/opt/backup`. Vengono mantenuti solo gli ultimi 7 backup.

---

## Creazione della directory di destinazione

```bash
sudo mkdir -p /opt/backup
```

## Creazione dello script `backup_home.sh`

```bash
sudo nano /opt/backup/backup_home.sh
```

Incollare questo script:

```bash
#!/bin/bash

# Cartella da salvare  
SOURCE="/home/xiaolong"

# Cartella di destinazione backup  
DEST="/opt/backup"

# Data odierna per nome file (YYYY-MM-DD-HHMMSS)  
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
```

## Rendere eseguibile lo script

```bash
sudo chmod +x /opt/backup/backup_home.sh
```

## Programmazione automatica tramite `cron`

Apri il file crontab dell’utente root:

```bash
sudo crontab -e
```

Aggiungi una delle seguenti righe:

### Backup ogni giorno alle 23:59:

```cron
59 23 * * * /opt/backup/backup_home.sh >> /opt/backup/backup.log 2>&1
```

### Backup ogni minuto (per test):

```cron
* * * * * /opt/backup/backup_home.sh >> /opt/backup/backup.log 2>&1
```

---

## Log

L’output del backup (inclusi eventuali errori) viene registrato in:

```
/opt/backup/backup.log
```

---

## Pulizia automatica

Il sistema conserva **solo gli ultimi 7 file di backup**.

---

## Autore

Chen Xiaolong  
ITS ICT Torino – Corso SWD  
2025
