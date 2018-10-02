#!/bin/bash

secure_installation() {
echo "[$(date +'%Y/%m/%d %H:%M:%S')] Securing installation.."
mysql -u root <<-EOF
    UPDATE mysql.user SET Password=PASSWORD('$MYSQL_ROOT_PASSWORD') WHERE User='root';
    DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
    DELETE FROM mysql.user WHERE User='';
    DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';
    GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USERNAME' IDENTIFIED BY '$MYSQL_PASSWORD' WITH GRANT OPTION;
    FLUSH PRIVILEGES;
    CREATE DATABASE IF NOT EXISTS test;
    CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE CHARACTER SET utf8;
    USE mysql;
    SOURCE /etc/mysql/zoneinfo.sql;
    install plugin daemon_memcached soname "libmemcached.so";
EOF
}

echo "[$(date +'%Y/%m/%d %H:%M:%S')] Creating MySQLd_safe directory"
mkdir -pv /var/run/mysqld

if [ -z "$MYSQL_ROOT_PASSWORD" ]; then
    echo "[$(date +'%Y/%m/%d %H:%M:%S')] MYSQL_ROOT_PASSWORD not set";
    exit 1;
fi

if [ -z "$MYSQL_USERNAME" ]; then
    echo "[$(date +'%Y/%m/%d %H:%M:%S')] MYSQL_USERNAME not set";
    exit 1;
fi

if [ -z "$MYSQL_PASSWORD" ]; then
    echo "[$(date +'%Y/%m/%d %H:%M:%S')] MYSQL_PASSWORD not set";
    exit 1;
fi

if [ -z "MYSQL_DATABASE" ]; then
    echo "[$(date +'%Y/%m/%d %H:%M:%S')] MYSQL_DATABASE not set";
    exit 1;
fi

echo "[$(date +'%Y/%m/%d %H:%M:%S')] Setting up initial data"
mysql_install_db
echo "[$(date +'%Y/%m/%d %H:%M:%S')] Starting mysql to setup privileges..."
/usr/sbin/mysqld &
MYSQL_TMP_PID=$!
echo "[$(date +'%Y/%m/%d %H:%M:%S')] Sleeping for 5s"
sleep 5

# Try to connect as root without a password
mysql -u root <<-EOF
USE mysql;
EOF

if [ $? != 1 ]; then
    secure_installation
else
    echo "[$(date +'%Y/%m/%d %H:%M:%S')] Error is OK, root password already set"
fi 

echo "[$(date +'%Y/%m/%d %H:%M:%S')] Kill temporary mysql daemon"
kill -TERM $MYSQL_TMP_PID && wait
