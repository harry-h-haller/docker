#!/bin/bash
. /entrypoint/postfix/preboot.sh

echo "[$(date +'%Y/%m/%d %H:%M:%S')] Iniciando servicio de shell segura"
service ssh start

echo "[$(date +'%Y/%m/%d %H:%M:%S')] Iniciando servicio de registro de mensajes"
service syslog-ng start

echo "[$(date +'%Y/%m/%d %H:%M:%S')] Iniciando servicio de correo"
service postfix stop 2>&1 /dev/null
service postfix start
