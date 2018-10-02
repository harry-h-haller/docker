#!/bin/bash

[ -z "${MAIL_DOMAIN}" ] && (
    echo "[$(date +'%Y/%m/%d %H:%M:%S')] Error: no se ha indicado el dominio de coreo. MAIL_DOMAIN"
    exit 127
)

[ -z "${MAIL_ADDRESS_ROOT}" ] && (
    echo "[$(date +'%Y/%m/%d %H:%M:%S')] Error: no se ha indicado el buzón de correo para el administrador. MAIL_ADDRESS_ROOT"
    exit 127
)

[ -z "${MAIL_ADDRESS_USER}" ] && (
    echo "[$(date +'%Y/%m/%d %H:%M:%S')] Error: no se ha indicado el buzón de correo para el usuario base. MAIL_ADDRESS_USER"
    exit 127
)

echo "127.0.0.1 ${MAIL_DOMAIN}" >> /etc/hosts

echo "[$(date +'%Y/%m/%d %H:%M:%S')] Creando usaurio ${MAIL_ADDRESS_USER}"
useradd -m -d /home/${MAIL_ADDRESS_USER} -s /bin/bash ${MAIL_ADDRESS_USER}
echo "[$(date +'%Y/%m/%d %H:%M:%S')] Asignado contraseña por defecto"
echo "[$(date +'%Y/%m/%d %H:%M:%S')] ${MAIL_ADDRESS_USER}:esclarecido" | chpasswd
echo "[$(date +'%Y/%m/%d %H:%M:%S')] Creando buzón de correo para el usuario"
mkdir /var/spool/mail/${MAIL_ADDRESS_USER}
chown ${MAIL_ADDRESS_USER}:mail /var/spool/mail/${MAIL_ADDRESS_USER}

echo "postmaster: root" > /etc/aliases
echo "root: ${MAIL_ADDRESS_ROOT}" >> /etc/aliases
echo "${MAIL_ADDRESS_USER}: ${MAIL_ADDRESS_USER}@${MAIL_DOMAIN}" >> /etc/aliases
chown -v root:root /etc/aliases
newaliases

echo "[$(date +'%Y/%m/%d %H:%M:%S')] Reajustando configuración de postfix:"
echo "[$(date +'%Y/%m/%d %H:%M:%S')]     - dominio de correo: ${MAIL_DOMAIN}"
echo "[$(date +'%Y/%m/%d %H:%M:%S')]     - servidor de correo: $(hostname -f)"
echo "[$(date +'%Y/%m/%d %H:%M:%S')]     - dirección de correo para root: ${MAIL_ADDRESS_ROOT}"
echo "[$(date +'%Y/%m/%d %H:%M:%S')]     - dirección de correo para ${MAIL_ADDRESS_USER}: ${MAIL_ADDRESS_USER}@${MAIL_DOMAIN}"
postconf -e mynetworks=127.0.0.1,172.18.0.0/24,192.168.0.0/16
postconf -e myhostname=$(hostname -f)
postconf -e mydestination="$(hostname -f), ${MAIL_DOMAIN}, localhost.localdomain, localhost"
postconf -e mail_spool_directory="/var/spool/mail/"
postconf -e mailbox_command=""
