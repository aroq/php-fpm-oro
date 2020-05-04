ARG VERSION=7.3.17

# Dev image
FROM php:${VERSION}-fpm-alpine AS dev

## Install system dependencies
RUN apk update && \
    apk add --no-cache --virtual dev-deps git autoconf gcc g++ make && \
    apk add --no-cache \
      mysql-client \
      curl \
      libmcrypt \
      libmcrypt-dev \
      openssh-client \
      icu-dev \
      libpq \
      postgresql-dev \
      imap-dev \
      tidyhtml-dev \
      libxml2-dev \
      freetype-dev \
      libzip-dev \
      libpng-dev \
      libxslt-dev \
      libjpeg-turbo-dev

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted gnu-libiconv
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

## Install php extensions
RUN pecl install \
    xdebug \
    redis \
      && \
    docker-php-ext-enable xdebug && \
    docker-php-ext-enable redis && \
    docker-php-ext-install \
      xsl \
      soap \
      gd \
      pdo \
      mbstring \
      xml \
      opcache \
      zip \
      intl \
      pdo_pgsql \
      imap \
      tidy \
      pcntl && rm -rf /tmp/*
