#!/bin/bash

SETNAME="$1"
SETPASS="$2"

if [ -z "$SETNAME" ]; then
    echo "Usage: $0 <username> [password]"
    exit 1
fi

SETUID=$(id -u "$SETNAME")
if [ "$?" != "0" ];then
    echo "Could not find user"
    exit 1
fi
SETGID=$(id -g "$SETNAME")

if [ -z "$SETPASS" ]; then
    while [ 0 = 0 ]; do
	echo -n Password: 
	read -s SETPASS
	echo
	
	echo -n Confirm password: 
	read -s SETPASSCONF
	echo
	
	if [ "$SETPASS" = "$SETPASSCONF" ]; then
	    break
	else
	    echo "Passwords do not match"
	    echo
	fi
    done
fi

cd /root/accounts
find setpass.d -type f | sort -n | grep -v '.*~$\|.disabled$' | while read LINE; do
    if [ -e "${LINE}.disabled" ]; then
	continue
    fi
    source "$LINE" "$SETNAME" "$SETPASS" "$SETUID" "$SETGID" 
done
