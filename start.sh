#!/bin/bash

chown -R apache:apache /var/www/ && chmod -R 0775 /var/www/

rm /var/run/httpd/httpd.pid

set -e

set -- httpd -DFOREGROUND "$@"

exec "$@"
