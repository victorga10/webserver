#!/bin/bash

DIR=/run/supervisor/
if [ -d "$DIR" ]; then
    echo "ok..."
else
    mkdir -p /run/supervisor/
fi

FILE=/run/supervisor/supervisord.pid
if test -f "$FILE"; then
    rm /run/supervisor/supervisord.pid
fi

FILE=/run/supervisor/supervisor.sock
if test -S "$FILE"; then
    rm /run/supervisor/supervisor.sock
fi

DIR=/var/log/supervisor
if [ -d "$DIR" ]; then
    echo "ok..."
else
    mkdir -p /var/log/supervisor
fi

FILE=/var/log/supervisor.log
if test -f "$FILE"; then
    echo "ok..."
else
     touch /var/log/supervisor/supervisor.log
fi


DIR=/run/php-fpm/
if [ -d "$DIR" ]; then
    echo "ok..."
else
    mkdir -p /run/php-fpm/
fi

FILE=/run/php-fpm/php-fpm.pid
if test -f "$FILE"; then
   rm /run/php-fpm/php-fpm.pid
fi

UID_OLD=$(id -u apache)
GID_OLD=$(id -g apache)


if [ -n "$PHP_UID" ]; then
        usermod -u $PHP_UID -o apache
        find / -uid $UID_OLD -type f -exec chown apache {} +
fi


if [ -n "$PHP_GID" ]; then
        groupmod -g $PHP_GID -o apache
        find / -gid $GID_OLD -type d -exec chown :apache {} +
fi

DIR=/usr/share/httpd/.composer/
if [ -d "$DIR" ]; then
	echo "ok..."
        chown -R apache:apache /usr/share/httpd

else
	mkdir -p /usr/share/httpd/.composer/
	chown -R apache:apache /usr/share/httpd
fi




set -e
set -u

#supervisord -n -c /etc/supervisord.conf

exec supervisord -n -c /etc/supervisord.conf "$@" 
