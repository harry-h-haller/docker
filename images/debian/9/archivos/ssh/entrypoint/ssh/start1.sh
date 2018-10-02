#!/bin/bash
echo "[$(date +'%Y/%m/%d %H:%M:%S')] Iniciando servidor SSH en primer plano"
[ ! -d /var/run/sshd ] && mkdir -pv /var/run/sshd
/usr/sbin/sshd -D