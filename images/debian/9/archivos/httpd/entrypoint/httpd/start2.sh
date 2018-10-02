#!/bin/bash
[ ! -d /opt/html/conf.d ] && (
    mkdir -pv /opt/html/conf.d | xargs -d"\n" -I{} echo "[$(date +'%Y/%m/%d %H:%M:%S')] {}"
)
service apache2 stop
service apache2 start
