FROM matomo AS base
COPY ./configs/php-custom.ini /usr/local/etc/php/conf.d/php-custom.ini
COPY ./configs/apache-custom.conf /etc/apache2/conf-enabled/apache-custom.conf
COPY ./configs/crons /etc/cron.d/crons
COPY ./configs/startup-script.sh /usr/share/startup-script.sh
#COPY ./configs/config.ini.php /usr/share/config.ini.php
COPY ./misc/plugins/ /usr/share/plugins/
COPY ./misc/geolocation/DBIP-City.mmdb /usr/share/maxmind/DBIP-City.mmdb

# Vulnerability scan of final image
FROM base AS vulnerabilityscan
ARG TRIVY_FAIL=0
COPY --from=aquasec/trivy:latest /usr/local/bin/trivy /usr/local/bin/trivy
RUN [[ $TRIVY_FAIL == 0 ]] || trivy filesystem --no-progress --severity CRITICAL --ignore-unfixed /
RUN echo scancompleted > /scancompleted

ENTRYPOINT [ "/entrypoint.sh" ]
CMD ["/usr/share/startup-script.sh"]