#!/bin/bash
# Copyright VMware, Inc.
# SPDX-License-Identifier: APACHE-2.0

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace # Uncomment this line for debugging purposes

# Load Matomo environment
. /opt/bitnami/scripts/matomo-env.sh

#rm -f /opt/bitnami/matomo/composer.lock && composer install -n -d /opt/bitnami/matomo/
#composer require matomo-heatmapsessionrecording:* -q -d /opt/bitnami/matomo/

# Load libraries
. /opt/bitnami/scripts/libos.sh
. /opt/bitnami/scripts/liblog.sh
. /opt/bitnami/scripts/libservice.sh
. /opt/bitnami/scripts/libwebserver.sh

# Catch SIGTERM signal and stop all child processes
_forwardTerm() {
    warn "Caught signal SIGTERM, passing it to child processes..."
    pgrep -P $$ | xargs kill -TERM 2>/dev/null
# Start cron
    wait
    exit $?
}
trap _forwardTerm TERM

if am_i_root; then
    info "** Starting cron **"
    crontab /etc/cron.d/crons
    if ! cron_start; then
        error "Failed to start cron. Check that it is installed and its configuration is correct."
        exit 1
    fi
else
    warn "Cron will not be started because of running as a non-root user"
fi

echo "---custom ini---"
cp -rf /usr/custom.ini.php /bitnami/matomo/config/config.ini.php
cat /bitnami/matomo/config/config.ini.php

# Start Apache
if [[ -f "/opt/bitnami/scripts/nginx-php-fpm/run.sh" ]]; then
    exec "/opt/bitnami/scripts/nginx-php-fpm/run.sh"
else
    exec "/opt/bitnami/scripts/$(web_server_type)/run.sh"
fi

