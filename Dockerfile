FROM centos:7
MAINTAINER serverti <atendimento@serverti.com.br>
ENV container docker


RUN	rpm --rebuilddb && yum clean all &&\
	yum install -y iproute  python-setuptools  hostname  inotify-tools  which rsync jq telnet htop atop iotop mtr &&\
	yum install -y yum-utils epel-* &&\
	yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm &&\
	yum-config-manager --disable remi-php54 &&\
	yum-config-manager --disable remi-php73 &&\
	yum-config-manager --enable remi-php74 &&\
        yum update -y  &&\
	yum clean all && rm -rf /tmp/yum* &&\
	easy_install pip &&\
        pip install supervisor


RUN yum install -y httpd-tools.x86_64 mod_ssl.x86_64  php php-pear php-devel  php-fpm php-common php-mcrypt php-cli php-curl &&\
    yum install -y php-pecl-zip php-zip php-bcmath unzip php-pecl-zmq.x86_64  &&\
    yum install -y php-json php-geos php-interbase &&\
    yum install -y php-mbstring php-mysqlnd php-pdo php-pdo-* libssh2  &&\
    yum install -y php-mongodb.noarch php-pecl-mongodb &&\
    yum install -y php-soap  php-pecl-apcu php-pecl-apcu-devel php-gd php-xml php-gmp php-pecl-ssh2  &&\
    yum install -y php-opcache php-pecl-zendopcache php-pear-CAS php-xmlrpc php-ldap &&\
    yum install -y php-pear-Net-Curl php-pear-Net-IMAP php-imap php-phpiredis &&\
    yum install -y wget git gcc-c++ make nano tmux php-mongodb.noarch php-pecl-mongodb.x86_64 mongodb.x86_64  &&\
    yum install -y openvpn openssl &&\
    yum clean all

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && php composer-setup.php --install-dir=/usr/local/bin --filename=composer


COPY start.sh /start.sh
RUN chmod 755 /start.sh

COPY opcache.ini /usr/local/etc/php/conf.d/opcache.ini
COPY supervisord.conf /etc/supervisord.conf
COPY www.conf /etc/php-fpm.d/www.conf

WORKDIR /var/www/html

EXPOSE 9000

CMD /start.sh

