  
FROM ubuntu:20.10

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -yqq && apt-get install -yqq software-properties-common > /dev/null
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
RUN apt-get update -yqq > /dev/null && \
    apt-get install -yqq php8.0-cli php8.0-pgsql php8.0-xml php8.0-mbstring > /dev/null

RUN apt-get install -yqq composer > /dev/null

RUN apt-get install -y php-pear php8.0-dev libevent-dev > /dev/null
RUN pecl install event-3.0.2 > /dev/null && echo "extension=event.so" > /etc/php/8.0/cli/conf.d/event.ini

COPY deploy/conf/php-async-jit.ini /etc/php/8.0/cli/php.ini

ADD ./ /ubiquity
WORKDIR /ubiquity

RUN chmod -R 777 /ubiquity

RUN composer require phpmv/ubiquity-devtools:dev-master phpmv/ubiquity-workerman:dev-master --quiet

RUN composer install --optimize-autoloader --classmap-authoritative --no-dev --quiet

RUN chmod 777 -R /ubiquity/.ubiquity/*

COPY deploy/conf/workerman/pgsql/workerServices.php app/config/workerServices.php

RUN echo "opcache.preload=/ubiquity/app/config/preloader.script.php" >> /etc/php/8.0/cli/php.ini

CMD /ubiquity/vendor/bin/Ubiquity serve -t=workerman -p=8080 -h=0.0.0.0