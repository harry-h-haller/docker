#!/bin/bash

echo "[$(date +'%Y/%m/%d %H:%M:%S')] --------------------------------------------------------------------------------"
echo "[$(date +'%Y/%m/%d %H:%M:%S')] Comprobando lista de usuarios"

[ -f /opt/svn/configuracion/usuarios.txt ] && (
    n=$(cat /opt/svn/configuracion/usuarios.txt | egrep -v '^#' | egrep -v '^$' | wc -l)
    for i in $(seq 1 $n)
    do
        echo "[$(date +'%Y/%m/%d %H:%M:%S')] --------------------"
        grupo=$(cat /opt/svn/configuracion/usuarios.txt | egrep -v '^#' | egrep -v '^$' | head -n ${i} | tail -n 1 | cut -f1 -d',')
        usuario=$(cat /opt/svn/configuracion/usuarios.txt | egrep -v '^#' | egrep -v '^$' | head -n ${i} | tail -n 1 | cut -f2 -d',')
        clave=$(cat /opt/svn/configuracion/usuarios.txt | egrep -v '^#' | egrep -v '^$' | head -n ${i} | tail -n 1 | cut -f3 -d',')

        echo "[$(date +'%Y/%m/%d %H:%M:%S')] Creando usuario ${usuario}, grupo ${grupo}"

        check_group=$(getent group | grep "${grupo}")
        [ -z "${check_group}" ] && (
            echo "[$(date +'%Y/%m/%d %H:%M:%S')]     Creando grupo ${grupo}"
            groupadd "${grupo}"
        )

        id "${usuario}" >/dev/null 2>&1
        [ $? -ne 0 ] && (
            echo "[$(date +'%Y/%m/%d %H:%M:%S')]     Creando usuario ${usuario}"
            useradd -g users -G "${grupo}" -m -d "/home/${usuario}" -s /bin/bash "${usuario}"
            echo "${usuario}:${clave}" | chpasswd
        )

        [ -f /home/${usuario}/.ssh/id_rsa ] && (
            echo "[$(date +'%Y/%m/%d %H:%M:%S')] Limpiando claves previas"
            echo "[$(date +'%Y/%m/%d %H:%M:%S')] $(rm -fv /home/${usuario}/.ssh/id_rsa)"
            echo "[$(date +'%Y/%m/%d %H:%M:%S')] $(rm -fv /home/${usuario}/.ssh/id_rsa.pub)"
            cat /home/${usuario}/.ssh/id_rsa.pub > /home/${usuario}/.ssh/authorized_keys
            echo "host *" > /home/${usuario}/.ssh/config
            echo "    StrictHostKeyChecking no" >> /home/${usuario}/.ssh/config
            echo "    UserKnownHostsFile /dev/null" >> /home/${usuario}/.ssh/config
        )

        echo "[$(date +'%Y/%m/%d %H:%M:%S')] Generando nuevas claves para el usuario"
        su --login ${usuario} --command "ssh-keygen -b 2048 -t rsa -N \"\" -C \"${usuario} @ $(hostname -s)\" -f /home/${usuario}/.ssh/id_rsa"

        echo "[$(date +'%Y/%m/%d %H:%M:%S')] Generando correo para el usuario ${usuario}"
        tar rvf "/tmp/${usuario}.tar" /home/${usuario}/.ssh/id_rsa /home/${usuario}/.ssh/id_rsa.pub 2>/dev/null
        gzip -9 "/tmp/${usuario}.tar" 2>/dev/null
        echo "Adjunto archivo de identificación para el usuario '${usuario}'." | mailx -a /tmp/${usuario}.tar.gz -s "Nuevo usuario: ${usuario}" -S smtp=smtp-relay:25 $MAIL_PUSH
        echo "[$(date +'%Y/%m/%d %H:%M:%S')] Realizando limpieza"
        rm -fv "/tmp/${usuario}.tar.gz"
    done
)

