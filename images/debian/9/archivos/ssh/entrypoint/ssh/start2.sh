#!/bin/bash
[ ! -d /var/run/sshd ] && mkdir -pv /var/run/sshd
service ssh start