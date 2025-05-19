#!/bin/bash
SOURCE="/home/xiaolong"
DEST="/opt/backup"
DATA=$(date +%F-%H%M%S)   # Data + ora + minuti + secondi
FILE="backup-$DATA.tar.gz"
mkdir -p "$DEST"
tar -czf "$DEST/$FILE" "$SOURCE"
cd "$DEST" || exit
ls -1tr backup-*.tar.gz | head -n -7 | xargs -r rm --
