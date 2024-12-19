#!/bin/bash

log_path="/home/vince/crontab/logs/crontab.log"
dumps_path="/backup"

echo "=== "$(date +'%Y-%m-%d %Hh%Mm%S');
cd $dumps_path

# Suppression des backups > 2 mois
rm ./$(date --date="-2 months" +'%Y%m')*

# Compression tar.gz & suppression du dump non-compressé
daily=$(date +'%Y%m%d')
tar -zcf $daily.tar.gz $daily.sql && rm $daily.sql && echo "Backup '$daily.sql' compressé"