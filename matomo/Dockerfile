FROM docker.io/bitnami/matomo
USER root
COPY ./plugins /plugins-to-install
COPY ./geolocation /geolocation
COPY ./configs/custom.ini.php /usr/custom.ini.php
COPY ./configs/crons /etc/cron.d/crons
COPY ./configs/php-custom.ini /opt/bitnami/php/etc/conf.d/php-custom.ini
COPY ./configs/matomo/run.sh /opt/bitnami/scripts/matomo/run.sh
COPY ./configs/matomo/entrypoint.sh /opt/bitnami/scripts/matomo/entrypoint.sh
RUN chmod +x /opt/bitnami/scripts/matomo/run.sh
RUN chmod +x /opt/bitnami/scripts/matomo/entrypoint.sh
COPY ./configs/apache.conf /opt/bitnami/apache/conf/sites-enabled/000-default.conf
RUN apt-get update && apt-get install nano && apt-get install tar && apt-get install sendmail -y && \
apt-get install build-essential -y && \
curl -sL https://github.com/maxmind/libmaxminddb/releases/download/1.9.1/libmaxminddb-1.9.1.tar.gz | tar xz && cd libmaxminddb-1.9.1 && ./configure && make install && cd .. && rm -rf libmaxminddb-1.9.1 && \
curl -sL https://github.com/maxmind/mod_maxminddb/releases/download/1.2.0/mod_maxminddb-1.2.0.tar.gz | tar xz && cd mod_maxminddb-1.2.0 && ./configure && make install && cd .. && rm -rf mod_maxminddb-1.2.0
