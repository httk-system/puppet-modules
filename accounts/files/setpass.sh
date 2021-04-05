#!/bin/bash

SETNAME="$1"
SETPASS="$2"

if [ -z "$SETNAME" ]; then
    echo "Usage: $0 <username>"
fi

SETUID=$(id -u "$SETNAME")
SETGID=$(id -g "$SETNAME")

if [ -z "$SETPASS" ]; then
    while [ 0 = 0 ]; do
	echo -n Password: 
	read -s SETPASS

	echo -n Confirm password: 
	read -s SETPASSCONF

	if [ "$SETPASS" = "$SETPASSCONF" ]; then
	    break
	else
	    echo "Passwords do not match"
	    echo
	fi
    done
fi

cd /root/accounts
find setpass.d | sort -n | grep -v '.*~$\|.disabled$' | while [ 0 = 0 ]; do
    read LINE
    if [ -e "${LINE}.disabled" ]; then
	continue
    fi
    source "$LINE" "$SETNAME" "$SETPASS" "$SETUID" "$SETGID" 
done
