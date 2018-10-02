#!/bin/bash
. /entrypoint/postfix/preboot.sh

echo "[$(date +'%Y/%m/%d %H:%M:%S')] Iniciando servicio de shell segura"
service ssh start

echo "[$(date +'%Y/%m/%d %H:%M:%S')] Iniciando servicio de registro de mensajes"
service syslog-ng start

echo "[$(date +'%Y/%m/%d %H:%M:%S')] Iniciando servicio de correo"
service postfix stop 2>&1 /dev/null
service syslog-ng stop 2>&1 /dev/null
service syslog-ng start
service postfix start
while [ ! -f /var/log/mail.log ]
do
    echo "[$(date +'%Y/%m/%d %H:%M:%S')] Esperando a que se inicie el servicio de correo"
    sleep 1
done
tailf /var/log/mail.log
