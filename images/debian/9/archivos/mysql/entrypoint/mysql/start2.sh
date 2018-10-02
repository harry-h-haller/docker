#!/bin/bash

echo "[$(date +'%Y/%m/%d %H:%M:%S')] --------------------------------------------------------------------------------"
echo "[$(date +'%Y/%m/%d %H:%M:%S')] Preconfigurando MySQL"
. /entrypoint/mysql/secure_installation.sh
echo "[$(date +'%Y/%m/%d %H:%M:%S')] Iniciando MySQL en segundo plano"
service mysql start
echo "[$(date +'%Y/%m/%d %H:%M:%S')] --------------------------------------------------------------------------------"