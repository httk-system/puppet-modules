NEWNAME="$1"
NEWFULLNAME="$2"
NEWUID="$3"
NEWGID="$4"

adduser --uid "$NEWUID" --gid "$NEWGID" --gecos "$NEWFULLNAME" "$NEWNAME"
