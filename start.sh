#!/bin/bash


ln -sf /dev/stdout /var/log/httpd/access_log
ln -sf /dev/stderr /var/log/httpd/error_log

chown -R apache:apache /var/www/ && chmod -R 770 /var/www/


set -e

set -- httpd -DFOREGROUND "$@"

exec "$@"
