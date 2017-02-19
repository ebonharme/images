FROM php:apache 

ENV NEST_API_VERSION 1.1.4


RUN apt update && apt install -y wget cron git

RUN git clone https://github.com/chriseng/nestgraph.git /var/www/html
WORKDIR /var/www/html
RUN wget https://github.com/gboudreau/nest-api/archive/${NEST_API_VERSION}.tar.gz \
 && tar xvf ${NEST_API_VERSION}.tar.gz \
 && mv nest-api-${NEST_API_VERSION} nest-api-master \
 && rm ${NEST_API_VERSION}.tar.gz \
 && docker-php-ext-install mysqli \
 && docker-php-source delete \
 && echo '*/5 * * * *     /bin/rm -f /tmp/nest_php_* ; /usr/local/bin/php /var/www/html/insert.php > /dev/null' > cron.conf \
 && crontab cron.conf
