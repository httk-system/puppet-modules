#!/bin/bash

UIDSTART=5000
DEFAULTGID=100

#

NEWNAME=$1
NEWFULLNAME=$2
NEWUID=$3
NEWGID=$4

if [ -z "$NEWNAME" -o -z "$NEWFULLNAME" ]; then
    echo "Usage: $0 <username> \"<full name>\" [uid] [gid]"
    exit 1
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

if [ -z "$NEWUID" ]; then
    NEWUID=$(next_uid)
fi

if [ -z "$NEWGID" ]; then
    NEWGID="$DEFAULTGID"
fi


cd /root/accounts
find create.d -type f | sort -n | grep -v '.*~$\|.disabled$' | while read LINE; do
    if [ -e "${LINE}.disabled" ]; then
	continue
    fi
    source "$LINE" "$NEWNAME" "$NEWFULLNAME" "$NEWUID" "$NEWGID"
done
