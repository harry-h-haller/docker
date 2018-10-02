#!/bin/bash

echo "[$(date +'%Y/%m/%d %H:%M:%S')] --------------------------------------------------------------------------------"
echo "[$(date +'%Y/%m/%d %H:%M:%S')] Squid3 PreBoot"
echo "[$(date +'%Y/%m/%d %H:%M:%S')] --------------"
echo "[$(date +'%Y/%m/%d %H:%M:%S')]"
echo "[$(date +'%Y/%m/%d %H:%M:%S')] Recrendo sistema de archivos para cache"
mkdir -pv /var/spool/squid3
chown proxy:proxy /var/spool/squid3
squid3 -z
echo "[$(date +'%Y/%m/%d %H:%M:%S')]"
echo "[$(date +'%Y/%m/%d %H:%M:%S')] Configurando parámetros de redes en el núcleo"

#echo 1024 32768 > /proc/sys/net/ipv4/ip_local_port_range
#echo 8192 > /proc/sys/net/ipv4/tcp_max_syn_backlog

echo "[$(date +'%Y/%m/%d %H:%M:%S')] Configurando parámetros de archivos en el núcleo"
ulimit -HSd unlimited
ulimit -HSn 16384
echo "[$(date +'%Y/%m/%d %H:%M:%S')] --------------------------------------------------------------------------------"
