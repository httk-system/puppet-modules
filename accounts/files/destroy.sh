#!/bin/bash

DESTROYNAME=$1

if [ -z "$DESTROYNAME" ]; then
    echo "Usage: $0 <username>"
    exit 1
fi

DESTROYUID=$(id -u "$DESTROYNAME")
DESTROYGID=$(id -g "$DESTROYNAME")

cd /root/accounts
find destroy.d -type f | sort -n | grep -v '.*~$\|.disabled$' | while read LINE; do
    if [ -e "${LINE}.disabled" ]; then
	continue
    fi
    source "$LINE" "$DESTROYNAME" "$DESTROYUID" "$DESTROYGID"
done
