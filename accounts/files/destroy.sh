#!/bin/bash

DESTROYNAME=$1

if [ -z "$DESTROYNAME" ]; then
    echo "Usage: $0 <username>"
fi

DESTROYUID=$(id -u "$DESTROYNAME")
DESTROYGID=$(id -g "$DESTROYNAME")

cd /root/accounts
find destroy.d | sort -n | grep -v '.*~$\|.disabled$' | while [ 0 = 0 ]; do
    read LINE
    if [ -e "${LINE}.disabled" ]; then
	continue
    fi
    source "$LINE" "$DESTROYNAME" "$DESTROYUID" "$DESTROYGID"
done
