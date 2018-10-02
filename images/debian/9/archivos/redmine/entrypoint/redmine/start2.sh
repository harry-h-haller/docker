#!/bin/bash

echo "[$(date +'%Y/%m/%d %H:%M:%S')] --------------------------------------------------------------------------------"
echo "[$(date +'%Y/%m/%d %H:%M:%S')] Iniciando servicio de acceso remoto"
. /entrypoint/ssh/start2.sh
echo "[$(date +'%Y/%m/%d %H:%M:%S')] Preparando el inicio del servicio Redmine"
. /entrypoint/redmine/pre-start.sh
echo "[$(date +'%Y/%m/%d %H:%M:%S')] Iniciando servicio Redmine en segundo plano"
mkdir -pv /var/log/redmine
chmod -R root:root /var/log/redmine
bundle exec ruby script/rails server -b $REDMINE_NETWORK_INTERFACE -p $REDMINE_NETWORK_PORT webrick -e production 2>&1 >> /var/log/redmine/redmine.$(date +'%Y%m%d').log
echo "[$(date +'%Y/%m/%d %H:%M:%S')] --------------------------------------------------------------------------------"
