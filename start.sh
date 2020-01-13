#!/bin/bash

FILE=/var/run/httpd/httpd.pid
if test -f "$FILE"; then
    rm  "$FILE"
fi

set -e

set -- httpd -DFOREGROUND "$@"

exec "$@"
