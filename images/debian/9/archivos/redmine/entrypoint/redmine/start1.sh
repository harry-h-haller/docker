#!/bin/bash


echo "[$(date +'%Y/%m/%d %H:%M:%S')] --------------------------------------------------------------------------------"
echo "[$(date +'%Y/%m/%d %H:%M:%S')] Iniciando servicio de acceso remoto"
. /entrypoint/ssh/start2.sh
echo "[$(date +'%Y/%m/%d %H:%M:%S')] Preparando el inicio del servicio Redmine"
. /entrypoint/redmine/pre-start.sh
[ -f /var/log/redmine.deployed ] && (
    echo "[$(date +'%Y/%m/%d %H:%M:%S')] Iniciando servicio Redmine en segundo plano $REDMINE_NETWORK_INTERFACE:$REDMINE_NETWORK_PORT"
    bundle exec ruby script/rails server -b $REDMINE_NETWORK_INTERFACE -p $REDMINE_NETWORK_PORT webrick -e production
)
echo "[$(date +'%Y/%m/%d %H:%M:%S')] --------------------------------------------------------------------------------"
