FROM amd64/php:8.1.3-fpm-buster
LABEL maintainer="serverti <atendimento@serverti.com.br>" 
ENV container docker

RUN apt-get update && apt upgrade -y && apt-get install -y apt-utils && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libmemcached-dev \
        zlib1g-dev \
        libxml2-dev \
        libldap2-dev \
        libmcrypt-dev \
        libssl-dev \
        libicu-dev \
        libxslt-dev \
        libbz2-dev \
        libzip-dev \
        zip \
        libargon2-0-dev \
        locales \
        openssl \
        git \
        gnupg2 \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd
RUN docker-php-ext-install -j$(nproc) soap
RUN docker-php-ext-install -j$(nproc) \
        bcmath \
        bz2 \
        calendar
RUN docker-php-ext-install -j$(nproc) \
        opcache \
        dba

RUN apt-get install -y libgmp-dev   
RUN docker-php-ext-install -j$(nproc) \
        gmp \
        intl \
        mysqli \
        opcache \
        pcntl \
        pdo_mysql
RUN docker-php-ext-install -j$(nproc) \
        soap \
        sockets 
RUN docker-php-ext-install -j$(nproc) \
        xsl \
        zip



# Locales
RUN apt-get update \
	&& apt-get install -y locales

RUN dpkg-reconfigure locales \
	&& locale-gen C.UTF-8 \
	&& /usr/sbin/update-locale LANG=C.UTF-8

RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen \
	&& locale-gen

ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8


# Common
RUN apt-get update \
	&& apt-get install -y \
		openssl \
		git \
		gnupg2 \
        unzip


# PHP
# intl
RUN apt-get update \
	&& apt-get install -y libicu-dev \
	&& docker-php-ext-configure intl \
	&& docker-php-ext-install -j$(nproc) intl

# xml
RUN apt-get update \
	&& apt-get install -y \
	libxml2-dev \
	libxslt-dev \
	&& docker-php-ext-install -j$(nproc) \
		dom \
		xsl

# images
RUN apt-get update \
	&& apt-get install -y \
	libfreetype6-dev \
	libjpeg62-turbo-dev \
	libpng-dev \
	libgd-dev \
	&& docker-php-ext-configure gd --with-freetype --with-jpeg \
	&& docker-php-ext-install -j$(nproc) \
		gd \
		exif

# database
RUN docker-php-ext-install -j$(nproc) \
	mysqli \
	pdo \
	pdo_mysql

# strings
RUN apt-get update \
    && apt-get install -y libonig-dev \
    && docker-php-ext-install -j$(nproc) \
	    gettext \
	    mbstring

# math
RUN apt-get update \
	&& apt-get install -y libgmp-dev \
	&& ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h \
	&& docker-php-ext-install -j$(nproc) \
		gmp \
		bcmath

# compression
RUN apt-get update \
	&& apt-get install -y \
	libbz2-dev \
	zlib1g-dev \
	libzip-dev \
	&& docker-php-ext-install -j$(nproc) \
		zip \
		bz2

# ftp
RUN apt-get update \
	&& apt-get install -y \
	libssl-dev \
	&& docker-php-ext-install -j$(nproc) \
		ftp

# ssh2
RUN apt-get update \
	&& apt-get install -y \
	libssh2-1-dev

# memcached
RUN apt-get update \
	&& apt-get install -y \
	libmemcached-dev \
	libmemcached11


# others
RUN docker-php-ext-install -j$(nproc) \
	soap \
	sockets \
	calendar \
	sysvmsg \
	sysvsem \
	sysvshm


RUN apt-get install -y libssh2-1-dev libssh2-1 \
    && pecl install ssh2-1.3.1 \
    && docker-php-ext-enable ssh2


RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && php composer-setup.php --install-dir=/usr/local/bin --filename=composer


WORKDIR /var/www/html

EXPOSE 9000

CMD ["php-fpm"]