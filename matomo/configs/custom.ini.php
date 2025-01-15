// This is mock data and must be change and encrypted at rest.
[General]
force_ssl = 1
enable_plugin_upload = 0
proxy_ip_read_last_in_list = 1
assume_secure_protocol = 1
noreply_email_address = "noreply@matomo.org"
trusted_hosts[] = "matomo.org"
proxy_client_headers[] = "HTTP_X_FORWARDED_FOR"
proxy_host_headers[] = "HTTP_X_FORWARDED_HOST"
trusted_hosts[] = "10.0.0.0/8"
trusted_hosts[] = "10.100.1.0/12"
proxy_ips[] = "10.100.1.0/12"

[log]
log_writers[] = "file"
log_level = "DEBUG"

[Tracker]
enable_fingerprinting_across_websites = 1
use_third_party_id_cookie = 1

[mail]
transport = "smtp"
port = "587"
type = "Login"
host = "SMTP_HOST"
username = "SMTP_USER"
password = "SMTP_PASSWORD"
encryption = "tls"

[database]
host = "matomo"
username = "matomo_rw"
password = "matomo"
dbname = "matomo"
tables_prefix = "matomo_"
adapter = "MYSQLI"
charset = "utf8mb4"

[Plugins]
Plugins[] = "CoreVue"
Plugins[] = "CorePluginsAdmin"
Plugins[] = "CoreAdminHome"
Plugins[] = "CoreHome"
Plugins[] = "WebsiteMeasurable"
Plugins[] = "IntranetMeasurable"
Plugins[] = "Diagnostics"
Plugins[] = "CoreVisualizations"
Plugins[] = "Proxy"
Plugins[] = "API"
Plugins[] = "Widgetize"
Plugins[] = "Transitions"
Plugins[] = "LanguagesManager"
Plugins[] = "Actions"
Plugins[] = "Dashboard"
Plugins[] = "MultiSites"
Plugins[] = "Referrers"
Plugins[] = "UserLanguage"
Plugins[] = "DevicesDetection"
Plugins[] = "Goals"
Plugins[] = "Ecommerce"
Plugins[] = "SEO"
Plugins[] = "Events"
Plugins[] = "UserCountry"
Plugins[] = "GeoIp2"
Plugins[] = "VisitsSummary"
Plugins[] = "VisitFrequency"
Plugins[] = "VisitTime"
Plugins[] = "VisitorInterest"
Plugins[] = "RssWidget"
Plugins[] = "Feedback"
Plugins[] = "Monolog"
Plugins[] = "Login"
Plugins[] = "TwoFactorAuth"
Plugins[] = "UsersManager"
Plugins[] = "SitesManager"
Plugins[] = "Installation"
Plugins[] = "CoreUpdater"
Plugins[] = "CoreConsole"
Plugins[] = "ScheduledReports"
Plugins[] = "UserCountryMap"
Plugins[] = "Live"
Plugins[] = "PrivacyManager"
Plugins[] = "ImageGraph"
Plugins[] = "Annotations"
Plugins[] = "MobileMessaging"
Plugins[] = "Overlay"
Plugins[] = "SegmentEditor"
Plugins[] = "Insights"
Plugins[] = "Morpheus"
Plugins[] = "Contents"
Plugins[] = "BulkTracking"
Plugins[] = "Resolution"
Plugins[] = "DevicePlugins"
Plugins[] = "Heartbeat"
Plugins[] = "Intl"
Plugins[] = "Marketplace"
Plugins[] = "UserId"
Plugins[] = "CustomJsTracker"
Plugins[] = "Tour"
Plugins[] = "PagePerformance"
Plugins[] = "CustomDimensions"
Plugins[] = "JsTrackerInstallCheck"
Plugins[] = "DBStats"
Plugins[] = "MobileAppMeasurable"
Plugins[] = "TagManager"
Plugins[] = "AbTesting"
Plugins[] = "ActivityLog"
Plugins[] = "AdvertisingConversionExport"
Plugins[] = "Cohorts"
Plugins[] = "CrashAnalytics"
Plugins[] = "CustomReports"
Plugins[] = "FormAnalytics"
Plugins[] = "Funnels"
Plugins[] = "HeatmapSessionRecording"
Plugins[] = "LoginSaml"
Plugins[] = "MediaAnalytics"
Plugins[] = "MultiChannelConversionAttribution"
Plugins[] = "RollUpReporting"
Plugins[] = "SearchEngineKeywordsPerformance"
Plugins[] = "SEOWebVitals"
Plugins[] = "UsersFlow"
Plugins[] = "WhiteLabel"
Plugins[] = "WooCommerceAnalytics"

[PluginsInstalled]
PluginsInstalled[] = "Diagnostics"
PluginsInstalled[] = "Login"
PluginsInstalled[] = "CoreAdminHome"
PluginsInstalled[] = "UsersManager"
PluginsInstalled[] = "SitesManager"
PluginsInstalled[] = "Installation"
PluginsInstalled[] = "Monolog"
PluginsInstalled[] = "Intl"
PluginsInstalled[] = "JsTrackerInstallCheck"
PluginsInstalled[] = "CoreVue"
PluginsInstalled[] = "CorePluginsAdmin"
PluginsInstalled[] = "CoreHome"
PluginsInstalled[] = "WebsiteMeasurable"
PluginsInstalled[] = "IntranetMeasurable"
PluginsInstalled[] = "CoreVisualizations"
PluginsInstalled[] = "Proxy"
PluginsInstalled[] = "API"
PluginsInstalled[] = "Widgetize"
PluginsInstalled[] = "Transitions"
PluginsInstalled[] = "LanguagesManager"
PluginsInstalled[] = "Actions"
PluginsInstalled[] = "Dashboard"
PluginsInstalled[] = "MultiSites"
PluginsInstalled[] = "Referrers"
PluginsInstalled[] = "UserLanguage"
PluginsInstalled[] = "DevicesDetection"
PluginsInstalled[] = "Goals"
PluginsInstalled[] = "Ecommerce"
PluginsInstalled[] = "SEO"
PluginsInstalled[] = "Events"
PluginsInstalled[] = "UserCountry"
PluginsInstalled[] = "GeoIp2"
PluginsInstalled[] = "VisitsSummary"
PluginsInstalled[] = "VisitFrequency"
PluginsInstalled[] = "VisitTime"
PluginsInstalled[] = "VisitorInterest"
PluginsInstalled[] = "RssWidget"
PluginsInstalled[] = "Feedback"
PluginsInstalled[] = "TwoFactorAuth"
PluginsInstalled[] = "CoreUpdater"
PluginsInstalled[] = "CoreConsole"
PluginsInstalled[] = "ScheduledReports"
PluginsInstalled[] = "UserCountryMap"
PluginsInstalled[] = "Live"
PluginsInstalled[] = "PrivacyManager"
PluginsInstalled[] = "ImageGraph"
PluginsInstalled[] = "Annotations"
PluginsInstalled[] = "MobileMessaging"
PluginsInstalled[] = "Overlay"
PluginsInstalled[] = "SegmentEditor"
PluginsInstalled[] = "Insights"
PluginsInstalled[] = "Contents"
PluginsInstalled[] = "BulkTracking"
PluginsInstalled[] = "Morpheus"
PluginsInstalled[] = "Resolution"
PluginsInstalled[] = "DevicePlugins"
PluginsInstalled[] = "Heartbeat"
PluginsInstalled[] = "Marketplace"
PluginsInstalled[] = "UserId"
PluginsInstalled[] = "CustomJsTracker"
PluginsInstalled[] = "ProfessionalServices"
PluginsInstalled[] = "Tour"
PluginsInstalled[] = "PagePerformance"
PluginsInstalled[] = "CustomDimensions"
PluginsInstalled[] = "AbTesting"
PluginsInstalled[] = "AdvertisingConversionExport"
PluginsInstalled[] = "Cohorts"
PluginsInstalled[] = "CrashAnalytics"
PluginsInstalled[] = "CustomReports"
PluginsInstalled[] = "ActivityLog"
PluginsInstalled[] = "FormAnalytics"
PluginsInstalled[] = "Funnels"
PluginsInstalled[] = "MediaAnalytics"
PluginsInstalled[] = "MultiChannelConversionAttribution"
PluginsInstalled[] = "RollUpReporting"
PluginsInstalled[] = "SearchEngineKeywordsPerformance"
PluginsInstalled[] = "SEOWebVitals"
PluginsInstalled[] = "UsersFlow"
PluginsInstalled[] = "WhiteLabel"
PluginsInstalled[] = "WooCommerceAnalytics"
PluginsInstalled[] = "HeatmapSessionRecording"
PluginsInstalled[] = "DBStats"
PluginsInstalled[] = "MobileAppMeasurable"
PluginsInstalled[] = "TagManager"
PluginsInstalled[] = "LoginSaml"

[CustomReports]
datatable_archiving_maximum_rows_custom_reports = 500
datatable_archiving_maximum_rows_subtable_custom_reports = 500
custom_reports_validate_report_content_all_websites = 1
custom_reports_always_show_unique_visitors = 0
custom_reports_max_execution_time = 0
custom_reports_disabled_dimensions = ""
custom_reports_periods_force_aggregate_report_unique_metrics_evolution = ""
[FormAnalytics]
max_no_of_form_requests_allowed = 500
max_no_of_form_submission_requests_allowed = 500
max_no_of_form_fields_allowed = 2000


[Funnels]
funnels_num_max_rows_in_actions = 100
funnels_num_max_rows_in_referrers = 50
funnels_num_max_rows_populate_at_once = 60000

[MediaAnalytics]
media_analytics_exclude_query_parameters = "enablejsapi,player_id"
datatable_archiving_maximum_rows_media = 1000
datatable_archiving_maximum_rows_subtable_media = 1000
enable_event_tracking_by_default = 1

[MultiChannelConversionAttribution]
default_day_prior_to_conversion = 30
available_days_prior_to_conversion = "7,30,60,90"
datatable_archiving_maximum_rows = 500
datatable_archiving_maximum_rows_subtable = 500

[UsersFlow]
UsersFlow_num_max_steps = 10
UsersFlow_num_max_rows_in_actions = 100
UsersFlow_num_max_links_per_interaction = 5000

[HeatmapSessionRecording]
add_tracking_code_only_when_needed = 0
session_recording_sample_limits = "50,100,250,500,1000,2000,5000"
load_css_from_db = 1
max_time_allowed_on_page_column_limit = "9.2233720368548E+18"
default_heatmap_width = 1920