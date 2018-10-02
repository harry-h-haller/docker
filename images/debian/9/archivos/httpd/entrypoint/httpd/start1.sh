#!/bin/bash
echo "[$(date +'%Y/%m/%d %H:%M:%S')] --------------------------------------------------------------------------------"
[ ! -d /opt/html/conf.d ] && (
    mkdir -pv /opt/html/conf.d | xargs -d"\n" -I{} echo "[$(date +'%Y/%m/%d %H:%M:%S')] {}"
)
echo "[$(date +'%Y/%m/%d %H:%M:%S')] Iniciando servidor SSH en segundo plano"
. /entrypoint/ssh/start2.sh

echo "[$(date +'%Y/%m/%d %H:%M:%S')] --------------------------------------------------------------------------------"
echo "[$(date +'%Y/%m/%d %H:%M:%S')] Iniciando servidor Apache 2 en primer plano"
. /etc/apache2/envvars
service apache2 stop
. /usr/sbin/apache2ctl -D FOREGROUND -e debug
