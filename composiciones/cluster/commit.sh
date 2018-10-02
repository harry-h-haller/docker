#!/bin/bash

version="$1"
docker commit cluster_ambaridb_1 ambaridb:$version
docker commit cluster_ambariserver_1 ambariserver:$version
docker commit cluster_master1_1 master1:$version
docker commit cluster_master2_1 master2:$version
docker commit cluster_master3_1 master3:$version
docker commit cluster_worker1_1 worker1:$version
docker commit cluster_worker2_1 worker2:$version
docker commit cluster_worker3_1 worker3:$version
