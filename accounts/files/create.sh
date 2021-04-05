#!/bin/bash

UIDSTART=5000
DEFAULTGUID=100

#

NEWNAME=$1
NEWUID=$2
NEWGID=$3

if [ -z "$NEWNAME" ]; then
    echo "Usage: $0 <username> [uid] [gid]"
fi

next_uid() {

    UIDLIST=$( getent passwd | awk -F: -v max="$UIDSTART" '$3>=max {print $3}' | sort -n )
    CHECKUID="$UIDSTART"
    
    while true; do
	if ! echo "$UIDLIST" | grep -F -q -w "$CHECKUID"; then
            break;
	fi
	CHECKUID=$(( "$CHECKUID" + 1))
    done
    echo "$CHECKUID"
}

if [ -z "$UID" ]; then
    NEWUID=$(next_uid)
fi

if [ -z "$NEWGID" ]; then
    NEWGID="$DEFAULTGID"
fi


cd /root/accounts
find create.d | sort -n | grep -v '.*~$\|.disabled$' | while [ 0 = 0 ]; do
    read LINE
    if [ -e "${LINE}.disabled" ]; then
	continue
    fi
    source "$LINE" "$NEWNAME" "$NEWUID" "$NEWGID"
done
