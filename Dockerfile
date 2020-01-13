FROM centos:7
MAINTAINER serverti <atendimento@serverti.com.br>
ENV container docker

RUN yum install -y yum-utils epel-* &&\
	yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm &&\
	yum-config-manager --enable remi-php74 &&\
        yum update -y 

RUN yum install -y httpd-tools.x86_64 mod_ssl.x86_64 &&\
    yum install -y php php-common php-mcrypt php-cli php-curl &&\
    yum install -y php-pecl-zip php-bcmath unzip &&\
    yum install -y php-json php-geos.x86_64 php-interbase.x86_64 &&\
    yum install -y php-mbstring.x86_64 php-mysqlnd.x86_64 php-pdo.x86_64 php-pdo-* libssh2.x86_64  &&\
    yum install -y php-mongodb.noarch  php-pecl-mongodb.x86_64 php74-php-pecl-mongodb.x86_64  &&\
    yum install -y php-soap.x86_64  php-gd php-xml.x86_64 php-gmp.x86_64 php-pecl-ssh2.x86_64  &&\
    yum install -y wget git gcc-c++ make nano &&\
    yum install -y openvpn &&\
    yum clean all

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && php composer-setup.php --install-dir=/usr/local/bin --filename=composer


COPY httpd.conf /etc/httpd/conf/httpd.conf
RUN  echo "umask 0000" >> /etc/sysconfig/httpd
COPY start.sh /start.sh
RUN chmod 755 /start.sh

RUN mkdir -p /usr/share/httpd/.composer/
RUN chown -R apache:apache /usr/share/httpd/

RUN mkdir -p /var/www/src/public_html && chown -R apache:apache /var/www/


WORKDIR /var/www/

CMD /start.sh
