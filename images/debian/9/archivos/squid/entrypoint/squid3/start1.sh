#!/bin/bash

service squid3 stop
service ssh start
. /entrypoint/squid3/preboot.sh
/usr/sbin/squid3 -NCd1
