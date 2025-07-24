# Copy matomo config file if custom config exists
if [ -f "/usr/share/config.ini.php" ];then
    cp -f /usr/share/config.ini.php /var/www/html/config/config.ini.php
    chmod 666 /var/www/html/config/config.ini.php
fi
# Copy matomo plugins if custom plugins exist
if ! [ -z "$(ls -A /usr/share/plugins)" ];then cp -rf /usr/share/plugins/* /var/www/html/plugins/;fi
apache2-foreground