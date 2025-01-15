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

# Load libraries
. /opt/bitnami/scripts/libbitnami.sh
. /opt/bitnami/scripts/liblog.sh
. /opt/bitnami/scripts/libwebserver.sh

print_welcome_page

if [[ "$1" = "/opt/bitnami/scripts/$(web_server_type)/run.sh" || "$1" = "/opt/bitnami/scripts/nginx-php-fpm/run.sh" || "$1" = "/opt/bitnami/scripts/matomo/run.sh" ]]; then
    info "** Starting Matomo setup **"
    /opt/bitnami/scripts/"$(web_server_type)"/setup.sh
    /opt/bitnami/scripts/php/setup.sh
    /opt/bitnami/scripts/mysql-client/setup.sh
    /opt/bitnami/scripts/matomo/setup.sh
    /post-init.sh
    info "** Matomo setup finished! **"
fi

info "** Running custom post-deploy tasks **"
php /bitnami/matomo/console marketplace:set-license-key --license-key $LICENSE_KEY

# info "** Extracting Heatmap plugin tar (Palo work around)... **"
# tar -xvf /plugins-to-install/HeatmapSessionRecording.tar.gz
# rm /plugins-to-install/HeatmapSessionRecording.tar.gz
# info "** Heat Map Plugin Extracted! **"

info "** Copying geolocation to directory... **"
cp -R /geolocation/. /bitnami/matomo/misc/

info "** Copying plugins to directory... **"
cp -R /plugins-to-install/. /bitnami/matomo/plugins/

info "** All Plugins Installed! **"

php /bitnami/matomo/console plugin:activate AbTesting
php /bitnami/matomo/console plugin:activate ActivityLog
php /bitnami/matomo/console plugin:activate AdvertisingConversionExport
php /bitnami/matomo/console plugin:activate Cohorts
php /bitnami/matomo/console plugin:activate CrashAnalytics
php /bitnami/matomo/console plugin:activate CustomReports
php /bitnami/matomo/console plugin:activate FormAnalytics
php /bitnami/matomo/console plugin:activate Funnels
php /bitnami/matomo/console plugin:activate HeatmapSessionRecording
php /bitnami/matomo/console plugin:activate LoginSaml
php /bitnami/matomo/console plugin:activate MediaAnalytics
php /bitnami/matomo/console plugin:activate MultiChannelConversionAttribution
php /bitnami/matomo/console plugin:activate RollUpReporting
php /bitnami/matomo/console plugin:activate SearchEngineKeywordsPerformance
php /bitnami/matomo/console plugin:activate SEOWebVitals
php /bitnami/matomo/console plugin:activate UsersFlow
php /bitnami/matomo/console plugin:activate WhiteLabel
php /bitnami/matomo/console plugin:activate WooCommerceAnalytics
info "** Plugins activated! **"

echo ""
exec "$@"