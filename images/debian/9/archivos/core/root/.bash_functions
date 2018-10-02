#!/bin/bash

INFIJO=backup.${USER}

function archivar()
{
	argumentos="$*"
	for argumento in ${argumentos}
	do
		[ -f "${argumento}" ] && cp -v "${argumento}" "${argumento}.${INFIJO}.$(date +'%Y%m%d%H%M%S')"
	done
}

function escuchando()
{
        netstat -tunelpa | \
                grep -i "listen" | \
                egrep "^[tcp\|udp]" | \
                tr -s " " | \
                sort -k 2 | \
                awk 'BEGIN{printf("%-10s   %-22s   %-22s   %10s   %20s\n------------------------------------------------------------------------------------------------\n", "protocolo", "Local", "Remoto", "Usuario", "App")}{printf("%-10s | %-22s | %-22s | %10s | %20s\n", $1, $4, $5, $7, $9)}'
}

function ajustarPermisos()
{
	targets="$*"
	for target in ${targets}
	do
		chown -Rv telemaco230:Usuarios ${target}
		find ${target} \( -type d -or \( -type f -iname "*.sh" \) \) -exec chmod 755 {} \;
		find ${target} -type f \( -not -iname "*.sh" \) -exec chmod -v 644 {} \;
	done
}
