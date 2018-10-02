#!/bin/bash


interfaz="$(ip addr show eth0 | grep 'inet ' | cut -f2 | awk '{ print $2}')"
echo '#!/bin/bash' > /etc/profile.d/entorno.sh
echo '' >> /etc/profile.d/entorno.sh
env | sed -r "s/^/export /" >> /etc/profile.d/entorno.sh

echo "[$(date +'%Y/%m/%d %H:%M:%S')] --------------------------------------------------------------------------------"
echo "[$(date +'%Y/%m/%d %H:%M:%S')] Configurando plantillas"
for archivo in $(find / -maxdepth 5 -type f -iname "*.plantilla")
do
    echo "[$(date +'%Y/%m/%d %H:%M:%S')] Procesando plantilla: ${archivo}"
    longitud="${#archivo}"
    destino=$(echo "${archivo:0:$(expr ${longitud} - 9)}")
    echo "[$(date +'%Y/%m/%d %H:%M:%S')] Destino de la plantilla: ${destino}"
    sufijo="$(date +'%Y%m%d_%H%M%S')"
    [ -f "${destino}" ] && (
        echo "[$(date +'%Y/%m/%d %H:%M:%S')] Haciendo copia de seguridad de ${destino}"
        cp -v "${destino}" "${destino}.${sufijo}" | xargs -d"\n" -I{} echo "[$(date +'%Y/%m/%d %H:%M:%S')] {}"
    )

    direccionIp="$(echo "${interfaz}" | cut -d"/" -f1)"
    nombreHost="$(hostname -f)"

    echo "[$(date +'%Y/%m/%d %H:%M:%S')] Realizando sustituciones"
    cat "${archivo}" | sed "s/#interface#/${direccionIp}/" | sed "s/#hostname#/${nombreHost}/" >> "${destino}"

    echo "[$(date +'%Y/%m/%d %H:%M:%S')] Registrando cambios"
    diff "${destino}" "${destino}.${sufijo}" >> ${destino}.${sufijo}.patch
done

echo "--------------------------------------------------------------------------------"
echo "[$(date +'%Y/%m/%d %H:%M:%S')] Iniciando"
echo "[$(date +'%Y/%m/%d %H:%M:%S')] Argumentos: $#/$*"

argumento="$1"
echo "[$(date +'%Y/%m/%d %H:%M:%S')] Ejecutando: /entrypoint/${argumento}/start1.sh"
[ -f "/entrypoint/${argumento}/start1.sh" ] && (
        echo "--------------------------------------------------------------------------------"
        . "/entrypoint/${argumento}/start1.sh" | xargs -d"\n" -I{} echo "[$(date +'%Y/%m/%d %H:%M:%S')] {}"
        echo "--------------------------------------------------------------------------------"
) || (
        echo "[$(date +'%Y/%m/%d %H:%M:%S')] No se encuentran los archivos del servicio ${argumento}"
)
echo "--------------------------------------------------------------------------------"
