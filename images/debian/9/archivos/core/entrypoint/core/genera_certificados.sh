#!/bin/bash
dominio="$1"
[ -z "${dominio}" ] && (
        echo "Se ha de indicar el dominio para la generación de certificados"
        exit 1
)
openssl req -new -newkey rsa:4096 -key ${dominio}.key -out ${dominio}.csr -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=${dominio}"
openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=${dominio}" -keyout ${dominio}.key  -out ${dominio}.cert
