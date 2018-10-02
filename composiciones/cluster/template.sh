#!/bin/bash
n=$1
[ -z "${n}" ] && (
    echo "Indique el número de nodos"
    exit 1
) || (
echo "----------------------------------------------------------------------"
for i in $(seq 1 ${n})
do
echo "        nodo${i}:"
echo "                depends_on:"
echo "                        - ambaridb"
if [ $i -gt 1 ]
then
echo "                        - nodo$(expr ${i} - 1)"
fi
echo "                image: debian7_hwxcore:stable "
echo "                entrypoint:"
echo "                        - /entrypoint/entrypoint.sh"
echo "                        - hwxcore"
echo "                cap_add:"
echo "                        - ALL"
echo "                privileged: true"
echo "                environment:"
echo "                        DEBIAN_FRONTEND: noninteractive"
echo "                        NOTVISIBLE: "in users profile""
echo "                        SHELL: /bin/bash"
echo "                        FRONT_DOMAIN: "yggdrasil.inf""
echo "                        BACK_DOMAIN: \"cluster\""
echo "                        FRONT_IFACE: \"eth0\""
echo "                        BACK_IFACE: \"eth1\""
echo "                        NUM_NODOS: \"${n}\""
echo "                volumes:"
echo "                        - /var/run/docker.sock:/var/run/docker.sock"
echo "                        - cluster_nodo${i}_usr_hdp:/usr/hdp"
echo "                        - cluster_nodo${i}_hadoop:/hadoop"
echo "                hostname: nodo${i}"
echo "                domainname: yggdrasil.inf"
echo "                networks:"
echo "                        frontend:"
echo "                        backend:"
echo "                ports:"
echo "                        - \"10.11.12.13:$(expr 7001 + ${i}):22\""
done
echo ""
echo "----------------------------------------------------------------------"
echo ""
echo "    volumes:"
for i in $(seq 1 ${n})
do
echo "        cluster_nodo${i}_usr_hdp:"
echo "        cluster_nodo${i}_hadoop:"
done
 
)
