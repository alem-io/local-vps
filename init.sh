#!/usr/bin/env bash

DEFAULT_PORT=22

[ "$1" ] && DEFAULT_PORT=$1

echo $DEFAULT_PORT

[ -f /root/.ssh/authorized_keys ] && chown root:root -R /root/.ssh/

/usr/sbin/sshd -D -p $DEFAULT_PORT
