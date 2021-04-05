SETNAME="$1"
SETPASS="$2"
SETUID="$3"
SETGID="$4"

echo "$SETPASS" | passwd --stdin "$SETNAME"
