#!/bin/bash

echo "[$(date +'%Y/%m/%d %H:%M:%S')] --------------------------------------------------------------------------------"
echo "[$(date +'%Y/%m/%d %H:%M:%S')] Iniciando servidor SSH"
. /entrypoint/ssh/start2.sh
echo "[$(date +'%Y/%m/%d %H:%M:%S')] Preconfigurando MySQL"
. /entrypoint/mysql/secure_installation.sh
echo "[$(date +'%Y/%m/%d %H:%M:%S')] Iniciando MySQL en primer plano"
/usr/bin/mysqld_safe
echo "[$(date +'%Y/%m/%d %H:%M:%S')] --------------------------------------------------------------------------------"
