#!/bin/sh

# this script builds a mini-daemon, which isn't a real daemon because it
# should die when the owning terminal dies, but what makes it useful is
# that it will restart the command given to it when it completes, with a
# configurable timeout period elapsing before doing so.

if [ "$1" = '-h' ]; then
    echo "timeout defaults to 1 sec.\nUsage: $(basename "$0") sentinel-pidfile [timeout] command [command arg [more command args...]]"
    exit
fi

if [ $# -lt 2 ]; then
    echo "No command given."
    exit
fi

PIDFILE=$1
shift

TIMEOUT=1
if [[ $1 =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
        TIMEOUT=$1
        [ $# -lt 2 ] && echo "No command given (timeout was given)." && exit
        shift
fi

echo "Checking pid in file ${PIDFILE}." >&2

#Check to see if process running
if [ -f "$PIDFILE" ]; then
    PID=$(< $PIDFILE)
    if [ $? = 0 ]; then
        ps -p $PID >/dev/null 2>&1
        if [ $? = 0 ]; then
            echo "This script is (probably) already running as PID ${PID}."
            exit
        fi
    fi
fi

# Write our pid to file.
echo $$ >$PIDFILE

cleanup() {
        rm $PIDFILE
}
trap cleanup EXIT

# Run command until we're killed.
while true; do
    eval "$@"
    echo "I am $$ and my child has exited; restart in ${TIMEOUT}s" >&2
    sleep $TIMEOUT
done
