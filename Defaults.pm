package SF::Dashboard::Defaults;

use 5.010;
use strict;
use warnings;
use FlyLoader;

#
# NOTE
#
#   When modifying or adding a new dashboard below, you must update the
#   corresponding __VERSION string to the version number of the release these
#   changes apply to. This is required for the changes to be applied during
#   upgrade.
#

#
# get
#
#   Returns a list of all default dashboard configurations valid on the current
#   system.
#
sub get {
    my @dashboards = (
                       #
                       # DC Dashboards
                       #
                       {
                         '__FILTER' => sub { SF::Global::getApplianceType() eq 'mc' },
                         '__ID' => 'DC_USER_STATS',
                         '__VERSION' => '6.2.1',
                         'activeIndex' => 0,
                         'cycle' => 0,
                         'description' => 'Provides traffic and intrusion event statistics by user',
                         'lookback' => 3600,
                         'name' => 'Access Controlled User Statistics',
                         'refresh' => 0,
                         'tabs' => [
                                     {
                                       'label' => 'Connections',
                                       'lists' => [
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'flows_allowed_sum',
                                                                                          'color' => '#a3d6a3',
                                                                                          'field' => 'username',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'user_session_stats',
                                                                                          'title' => 'Allowed Connections by User',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Allowed Connections by User',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'flows_denied_sum',
                                                                                          'color' => '#e07777',
                                                                                          'field' => 'username',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'user_session_stats',
                                                                                          'title' => 'Denied Connections by User',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Denied Connections by User',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'unique_users',
                                                                                          'color' => '#5d81b3',
                                                                                          'field' => 'bucket_time',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'user_session_stats',
                                                                                          'title' => 'Unique Users over Time',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Unique Users over Time',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'kbytes_sum',
                                                                                          'color' => '#f2bb6c',
                                                                                          'field' => 'username',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'user_session_stats',
                                                                                          'title' => 'Traffic by User',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Traffic by User',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    }
                                                  ]
                                     },
                                     {
                                       'label' => 'Intrusion Events',
                                       'lists' => [
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'blocked_events_sum',
                                                                                          'color' => '#e07777',
                                                                                          'field' => 'username',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'user_ids_stats',
                                                                                          'title' => 'Dropped Events by User',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Dropped Events by User',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'impact_level_3_events_sum',
                                                                                          'color' => '#f2bb6c',
                                                                                          'field' => 'username',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'user_ids_stats',
                                                                                          'title' => 'Impact 3 Events by User',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Impact 3 Events by User',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'impact_level_1_events_sum',
                                                                                          'color' => '#e07777',
                                                                                          'field' => 'username',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'user_ids_stats',
                                                                                          'title' => 'Impact 1 Events by User',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Impact 1 Events by User',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'impact_level_4_events_sum',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'username',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'user_ids_stats',
                                                                                          'title' => 'Impact 4 Events by User',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Impact 4 Events by User',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'events_sum',
                                                                                          'color' => '#b0a8ee',
                                                                                          'field' => 'username',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'user_ids_stats',
                                                                                          'title' => 'Total Events by User',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Total Events by User',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'impact_level_2_events_sum',
                                                                                          'color' => '#f2bb6c',
                                                                                          'field' => 'username',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'user_ids_stats',
                                                                                          'title' => 'Impact 2 Events by User',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Impact 2 Events by User',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'impact_level_5_events_sum',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'username',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'user_ids_stats',
                                                                                          'title' => 'Impact 0 Events by User',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Impact 0 Events by User',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    }
                                                  ]
                                     },
                                     {
                                       'label' => 'VPN',
                                       'lists' => [
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed'   => 1,
                                                                       'last_access' => 0,
                                                                       'minimized'   => 0,
                                                                       'preferences' => {
                                                                                          'aggregate'   => 'longest_duration_users',
                                                                                          'color'       => '#cbd9e8',
                                                                                          'field'       => 'user_id',
                                                                                          'numResults'  => 10,
                                                                                          'postSort'    => 'rd',
                                                                                          'preset'      => '',
                                                                                          'search'      => 'e7c25146-9568-11e6-b7be-0050568e6d09',
                                                                                          'showChanges' => 1,
                                                                                          'table'       => 'current_users',
                                                                                          'title'       => 'Active VPN Sessions by Duration',
                                                                                          'to_show'     => 'desc',
                                                                                          'tz'          => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Active VPN Sessions by Duration',
                                                                       'type'  => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed'   => 1,
                                                                       'last_access' => 0,
                                                                       'minimized'   => 0,
                                                                       'preferences' => {
                                                                                          'aggregate'   => 'count',
                                                                                          'color'       => '#cbd9e8',
                                                                                          'field'       => 'vpn_client_application',
                                                                                          'numResults'  => 10,
                                                                                          'postSort'    => 'rd',
                                                                                          'preset'      => '',
                                                                                          'search'      => 'e7c25146-9568-11e6-b7be-0050568e6d09',
                                                                                          'showChanges' => 1,
                                                                                          'table'       => 'current_users',
                                                                                          'title'       => 'Active VPN Sessions by Client Application',
                                                                                          'to_show'     => 'desc',
                                                                                          'tz'          => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Active VPN Sessions by Client Application',
                                                                       'type'  => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed'   => 1,
                                                                       'last_access' => 0,
                                                                       'minimized'   => 0,
                                                                       'preferences' => {
                                                                                          'aggregate'   => 'count',
                                                                                          'color'       => '#cbd9e8',
                                                                                          'field'       => 'sensor',
                                                                                          'numResults'  => 10,
                                                                                          'postSort'    => 'rd',
                                                                                          'preset'      => '',
                                                                                          'search'      => 'e7c25146-9568-11e6-b7be-0050568e6d09',
                                                                                          'showChanges' => 1,
                                                                                          'table'       => 'current_users',
                                                                                          'title'       => 'Active VPN Sessions by Device',
                                                                                          'to_show'     => 'desc',
                                                                                          'tz'          => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Active VPN Sessions by Device',
                                                                       'type'  => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed'   => 1,
                                                                       'last_access' => 0,
                                                                       'minimized'   => 0,
                                                                       'preferences' => {
                                                                                          'aggregate'   => 'vpn_total_bytes_transferred_sum',
                                                                                          'color'       => '#cbd9e8',
                                                                                          'field'       => 'user_id',
                                                                                          'numResults'  => 10,
                                                                                          'postSort'    => 'rd',
                                                                                          'preset'      => '',
                                                                                          'search'      => '13caeb90-9569-11e6-a6e8-0050568e6d09',
                                                                                          'showChanges' => 1,
                                                                                          'table'       => 'rua_event',
                                                                                          'title'       => 'VPN Users by Data Transferred',
                                                                                          'to_show'     => 'desc',
                                                                                          'tz'          => 'America/New_York'
                                                                                        },
                                                                       'title' => 'VPN Users by Data Transferred',
                                                                       'type'  => 'Top10'
                                                                     }
                                                                 ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed'   => 1,
                                                                       'last_access' => 0,
                                                                       'minimized'   => 0,
                                                                       'preferences' => {
                                                                                          'aggregate'   => 'longest_duration_users',
                                                                                          'color'       => '#cbd9e8',
                                                                                          'field'       => 'user_id',
                                                                                          'numResults'  => 10,
                                                                                          'postSort'    => 'rd',
                                                                                          'preset'      => '',
                                                                                          'search'      => '13caeb90-9569-11e6-a6e8-0050568e6d09',
                                                                                          'showChanges' => 1,
                                                                                          'table'       => 'rua_event',
                                                                                          'title'       => 'VPN Users by Duration',
                                                                                          'to_show'     => 'desc',
                                                                                          'tz'          => 'America/New_York'
                                                                                        },
                                                                       'title' => 'VPN Users by Duration',
                                                                       'type'  => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed'   => 1,
                                                                       'last_access' => 0,
                                                                       'minimized'   => 0,
                                                                       'preferences' => {
                                                                                          'aggregate'   => 'count',
                                                                                          'color'       => '#cbd9e8',
                                                                                          'field'       => 'vpn_client_application',
                                                                                          'numResults'  => 10,
                                                                                          'postSort'    => 'rd',
                                                                                          'preset'      => '',
                                                                                          'search'      => '13caeb90-9569-11e6-a6e8-0050568e6d09',
                                                                                          'showChanges' => 1,
                                                                                          'table'       => 'rua_event',
                                                                                          'title'       => 'VPN Users by Client Application',
                                                                                          'to_show'     => 'desc',
                                                                                          'tz'          => 'America/New_York'
                                                                                        },
                                                                       'title' => 'VPN Users by Client Application',
                                                                       'type'  => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed'   => 1,
                                                                       'last_access' => 0,
                                                                       'minimized'   => 0,
                                                                       'preferences' => {
                                                                                          'aggregate'   => 'count',
                                                                                          'color'       => '#cbd9e8',
                                                                                          'field'       => 'vpn_client_country',
                                                                                          'numResults'  => 10,
                                                                                          'postSort'    => 'rd',
                                                                                          'preset'      => '',
                                                                                          'search'      => '13caeb90-9569-11e6-a6e8-0050568e6d09',
                                                                                          'showChanges' => 1,
                                                                                          'table'       => 'rua_event',
                                                                                          'title'       => 'VPN Users by Client Country',
                                                                                          'to_show'     => 'desc',
                                                                                          'tz'          => 'America/New_York'
                                                                                        },
                                                                       'title' => 'VPN Users by Client Country',
                                                                       'type'  => 'Top10'
                                                                     }
                                                                 ]
                                                    }
                                                  ]
                                     }
                                   ]
                       },
                       {
                         '__FILTER' => sub { SF::Global::getApplianceType() eq 'mc' },
                         '__ID' => 'DC_APP_STATS',
                         '__VERSION' => '7.2.0',
                         'activeIndex' => 0,
                         'cycle' => 0,
                         'description' => 'Provides application statistics',
                         'lookback' => 3600,
                         'name' => 'Application Statistics',
                         'refresh' => 0,
                         'tabs' => [
                                     {
                                       'label' => 'Connections',
                                       'lists' => [
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'flows_allowed_sum',
                                                                                          'color' => '#a3d6a3',
                                                                                          'field' => 'application',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'app_session_stats',
                                                                                          'title' => 'Allowed Connections by Application',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Allowed Connections by Application',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'flows_denied_sum',
                                                                                          'color' => '#e07777',
                                                                                          'field' => 'application',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'app_session_stats',
                                                                                          'title' => 'Denied Connections by Application',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Denied Connections by Application',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'unique_applications',
                                                                                          'color' => '#5d81b3',
                                                                                          'field' => 'bucket_time',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'app_session_stats',
                                                                                          'title' => 'Unique Applications over Time',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Unique Applications over Time',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'flows_allowed_sum',
                                                                                          'color' => '#a3d6a3',
                                                                                          'field' => 'risk',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'app_session_stats',
                                                                                          'title' => 'Allowed Connections by Application Risk',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Allowed Connections by Application Risk',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'flows_allowed_sum',
                                                                                          'color' => '#a3d6a3',
                                                                                          'field' => 'productivity',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'app_session_stats',
                                                                                          'title' => 'Allowed Connections by Business Relevance',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Allowed Connections by Business Relevance',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'kbytes_sum',
                                                                                          'color' => '#f2bb6c',
                                                                                          'field' => 'application',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'app_session_stats',
                                                                                          'title' => 'Traffic by Application',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Traffic by Application',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'kbytes_sum',
                                                                                          'color' => '#f2bb6c',
                                                                                          'field' => 'category',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'app_session_stats',
                                                                                          'title' => 'Traffic by Application Category',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Traffic by Application Category',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    }
                                                  ]
                                     },
                                     {
                                       'label' => 'Intrusion Events',
                                       'lists' => [
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'blocked_events_sum',
                                                                                          'color' => '#e07777',
                                                                                          'field' => 'application',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'app_ids_stats',
                                                                                          'title' => 'Dropped Events by Application',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Dropped Events by Application',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'impact_level_3_events_sum',
                                                                                          'color' => '#f2bb6c',
                                                                                          'field' => 'application',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'app_ids_stats',
                                                                                          'title' => 'Impact 3 Events by Application',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Impact 3 Events by Application',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'impact_level_1_events_sum',
                                                                                          'color' => '#e07777',
                                                                                          'field' => 'application',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'app_ids_stats',
                                                                                          'title' => 'Impact 1 Events by Application',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Impact 1 Events by Application',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'impact_level_4_events_sum',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'application',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'app_ids_stats',
                                                                                          'title' => 'Impact 4 Events by Application',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Impact 4 Events by Application',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'events_sum',
                                                                                          'color' => '#b0a8ee',
                                                                                          'field' => 'application',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'app_ids_stats',
                                                                                          'title' => 'Total Events by Application',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Total Events by Application',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'impact_level_2_events_sum',
                                                                                          'color' => '#f2bb6c',
                                                                                          'field' => 'application',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'app_ids_stats',
                                                                                          'title' => 'Impact 2 Events by Application',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Impact 2 Events by Application',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'impact_level_5_events_sum',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'application',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'app_ids_stats',
                                                                                          'title' => 'Impact 0 Events by Application',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Impact 0 Events by Application',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    }
                                                  ]
                                     }
                                   ]
                       },
                       {
                         '__FILTER' => sub { SF::Global::getApplianceType() eq 'mc' },
                         '__ID' => 'DC_CONNECTION_SUMMARY',
                         '__VERSION' => '6.0.0',
                         'activeIndex' => 0,
                         'cycle' => 0,
                         'description' => 'Provides tables and charts of the activity on your monitored network segment organized by different criteria',
                         'lookback' => 3600,
                         'name' => 'Connection Summary',
                         'refresh' => 0,
                         'tabs' => [
                                     {
                                       'label' => 'Connections',
                                       'lists' => [
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'flows_sum',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'source',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'flow_chunk',
                                                                                          'title' => 'Connections by Initiator IP',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Connections by Initiator IP',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'flows_sum',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'destination',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'flow_chunk',
                                                                                          'title' => 'Connections by Responder IP',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Connections by Responder IP',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'flows_sum',
                                                                                          'color' => '#5d81b3',
                                                                                          'field' => 'dynamic_bucket_time',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'flow_chunk',
                                                                                          'title' => 'Connections over Time',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Connections over Time',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'flows_sum',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'dport',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'flow_chunk',
                                                                                          'title' => 'Connections by Port',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Connections by Port',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'flows_sum',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'application',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'app_session_stats',
                                                                                          'title' => 'Connections by Application',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Connections by Application',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    }
                                                  ]
                                     },
                                     {
                                       'label' => 'Traffic',
                                       'lists' => [
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'traffic',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'source',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'flow_chunk',
                                                                                          'title' => 'Traffic by Initiator IP',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Traffic by Initiator IP',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'traffic',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'destination',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'flow_chunk',
                                                                                          'title' => 'Traffic by Responder IP',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Traffic by Responder IP',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'traffic',
                                                                                          'color' => '#5d81b3',
                                                                                          'field' => 'dynamic_bucket_time',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'flow_chunk',
                                                                                          'title' => 'Traffic over Time',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Traffic over Time',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'traffic',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'dport',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'flow_chunk',
                                                                                          'title' => 'Traffic by Port',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Traffic by Port',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'kbytes_sum',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'application',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'app_session_stats',
                                                                                          'title' => 'Traffic by Application',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Traffic by Application',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    }
                                                  ]
                                     },
                                     {
                                       '__FILTER' => sub { SF::Global::getApplianceModel() ne '500s2' },
                                       'label' => 'Geolocation',
                                       'lists' => [
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'flows_sum',
                                                                                          'color' => '#a3d6a3',
                                                                                          'field' => 'src_country',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'geoloc_session_stats',
                                                                                          'title' => 'Connections by Source Country',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Connections by Source Country',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'flows_sum',
                                                                                          'color' => '#a3d6a3',
                                                                                          'field' => 'dst_country',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'geoloc_session_stats',
                                                                                          'title' => 'Connections by Destination Country',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Connections by Destination Country',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'flows_sum',
                                                                                          'color' => '#a3d6a3',
                                                                                          'field' => 'src_continent',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'geoloc_session_stats',
                                                                                          'title' => 'Connections by Source Continent',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Connections by Source Continent',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'flows_sum',
                                                                                          'color' => '#a3d6a3',
                                                                                          'field' => 'dst_continent',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'geoloc_session_stats',
                                                                                          'title' => 'Connections by Destination Continent',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Connections by Destination Continent',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'kbytes_sum',
                                                                                          'color' => '#b0a8ee',
                                                                                          'field' => 'src_continent',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'geoloc_session_stats',
                                                                                          'title' => 'Traffic by Source Continent',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Traffic by Source Continent',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'kbytes_sum',
                                                                                          'color' => '#b0a8ee',
                                                                                          'field' => 'dst_continent',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'geoloc_session_stats',
                                                                                          'title' => 'Traffic by Destination Continent',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Traffic by Destination Continent',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'kbytes_sum',
                                                                                          'color' => '#b0a8ee',
                                                                                          'field' => 'src_country',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'geoloc_session_stats',
                                                                                          'title' => 'Traffic by Source Country',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Traffic by Source Country',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'kbytes_sum',
                                                                                          'color' => '#b0a8ee',
                                                                                          'field' => 'dst_country',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'geoloc_session_stats',
                                                                                          'title' => 'Traffic by Destination Country',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Traffic by Destination Country',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    }
                                                  ]
                                     },
                                     {
                                       'label' => 'TLS',
                                       'lists' => [
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'sessions_decrypted',
                                                                                          'color' => '#528841',
                                                                                          'field' => 'bucket_time',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'ssl_session_stats',
                                                                                          'title' => 'TLS Sessions Decrypted over Time',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'TLS Sessions Decrypted over Time',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'action',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'ssl_action_stats',
                                                                                          'title' => 'TLS Actions',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'TLS Actions',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'sessions_not_decrypted',
                                                                                          'color' => '#5d81b3',
                                                                                          'field' => 'bucket_time',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'ssl_session_stats',
                                                                                          'title' => 'TLS Sessions Not Decrypted over Time',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'TLS Sessions Not Decrypted over Time',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'cert_status',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'ssl_certificate_stats',
                                                                                          'title' => 'TLS Certificate Status',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'TLS Certificate Status',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'sessions_with_error',
                                                                                          'color' => '#883535',
                                                                                          'field' => 'bucket_time',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'ssl_session_stats',
                                                                                          'title' => 'TLS Sessions with Errors over Time',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'TLS Sessions with Errors over Time',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#e07777',
                                                                                          'field' => 'failure_reason',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'ssl_failure_reason_stats',
                                                                                          'title' => 'TLS Decryption Failure Reasons',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'TLS Decryption Failure Reasons',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    }
                                                  ]
                                     },
                                     {
                                       'label' => 'URL',
                                       'lists' => [
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'flows_allowed_sum',
                                                                                          'color' => '#a3d6a3',
                                                                                          'field' => 'category',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'url_cat_stats',
                                                                                          'title' => 'Allowed Connections by URL Category',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Allowed Connections by URL Category',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'flows_denied_sum',
                                                                                          'color' => '#e07777',
                                                                                          'field' => 'category',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'url_cat_stats',
                                                                                          'title' => 'Denied Connections by URL Category',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Denied Connections by URL Category',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'kbytes_sum',
                                                                                          'color' => '#f2bb6c',
                                                                                          'field' => 'category',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'url_cat_stats',
                                                                                          'title' => 'Traffic by URL Category',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Traffic by URL Category',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'kbytes_sum',
                                                                                          'color' => '#f2bb6c',
                                                                                          'field' => 'reputation',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'url_rep_stats',
                                                                                          'title' => 'Traffic by URL Reputation',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Traffic by URL Reputation',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'flows_allowed_sum',
                                                                                          'color' => '#a3d6a3',
                                                                                          'field' => 'reputation',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'url_rep_stats',
                                                                                          'title' => 'Allowed Connections by URL Reputation',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Allowed Connections by URL Reputation',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'flows_denied_sum',
                                                                                          'color' => '#e07777',
                                                                                          'field' => 'reputation',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'url_rep_stats',
                                                                                          'title' => 'Denied Connections by URL Reputation',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Denied Connections by URL Reputation',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    }
                                                  ]
                                     }
                                   ]
                       },
                       {
                         '__FILTER' => sub { SF::Global::getApplianceType() eq 'mc' },
                         '__ID' => 'DC_DETAILED',
                         '__VERSION' => '7.0.0',
                         'activeIndex' => 0,
                         'cycle' => 0,
                         'description' => 'Provides a detailed view of activity on the appliance',
                         'lookback' => 3600,
                         'name' => 'Detailed Dashboard',
                         'refresh' => 0,
                         'tabs' => [
                                     {
                                       'label' => 'Intrusion Events',
                                       'lists' => [
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'scale' => 'linear',
                                                                                          'show' => 'rate',
                                                                                          'types' => {
                                                                                                       'all' => 1,
                                                                                                       'dropped' => 1,
                                                                                                       'i1' => 1,
                                                                                                       'i2' => 1,
                                                                                                       'i3' => 1,
                                                                                                       'i4' => 1,
                                                                                                       'i5' => 1
                                                                                                     },
                                                                                          'update' => 30
                                                                                        },
                                                                       'title' => 'Intrusion Events',
                                                                       'type' => 'IPSEvents'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#5d81b3',
                                                                                          'field' => 'dynamic_bucket_time',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'event',
                                                                                          'title' => 'All Intrusion Events',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'All Intrusion Events',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#a3d6a3',
                                                                                          'field' => 'classification',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 'd1b36b3c-2909-11e0-ad19-fff04c9de09a',
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'event',
                                                                                          'title' => 'All Intrusion Events (Not Dropped)',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'All Intrusion Events (Not Dropped)',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#e07777',
                                                                                          'field' => 'classification',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 'd179f898-2909-11e0-ad19-fff04c9de09a',
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'event',
                                                                                          'title' => 'Dropped Intrusion Events',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Dropped Intrusion Events',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#f2bb6c',
                                                                                          'field' => 'classification',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 'd17ffa5e-2909-11e0-ad19-fff04c9de09a',
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'event',
                                                                                          'title' => 'Intrusion Events Requiring Analysis',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Intrusion Events Requiring Analysis',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    }
                                                  ]
                                     },
                                     {
                                       'label' => 'Context',
                                       'lists' => [
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'vendor',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'rna_service',
                                                                                          'title' => 'Servers',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Servers',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'os_name',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'rna_ip_host',
                                                                                          'title' => 'Operating Systems',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Operating Systems',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'product',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'rna_client_app',
                                                                                          'title' => 'Clients',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Clients',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'kbytes_sum',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'application',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'app_session_stats',
                                                                                          'title' => 'Traffic by Application',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Traffic by Application',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'traffic',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'source',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'flow_chunk',
                                                                                          'title' => 'Traffic by Initiator IP',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Traffic by Initiator IP',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'traffic',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'destination',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'flow_chunk',
                                                                                          'title' => 'Traffic by Responder IP',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Traffic by Responder IP',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'traffic',
                                                                                          'color' => '#5d81b3',
                                                                                          'field' => 'dynamic_bucket_time',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'flow_chunk',
                                                                                          'title' => 'Traffic over Time',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Traffic over Time',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'kbytes_sum',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'username',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'user_session_stats',
                                                                                          'title' => 'Traffic by User',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Traffic by User',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    }
                                                  ]
                                     },
                                     {
                                       'label' => 'Correlation',
                                       'lists' => [
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'classification',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 'd24b227e-2909-11e0-ad19-fff04c9de09a',
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'event',
                                                                                          'title' => 'Intrusion Events to High Criticality Hosts',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Intrusion Events to High Criticality Hosts',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'priorities' => {
                                                                                                            'None' => 1,
                                                                                                            'P1' => 1,
                                                                                                            'P2' => 1,
                                                                                                            'P3' => 1,
                                                                                                            'P4' => 1,
                                                                                                            'P5' => 1
                                                                                                          },
                                                                                          'scale' => 'linear',
                                                                                          'showAll' => 1,
                                                                                          'update' => 30
                                                                                        },
                                                                       'title' => 'Correlation Events',
                                                                       'type' => 'ComplianceEvents'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'show_not_evaluated' => 1,
                                                                                          'style' => 'PercentNCOT',
                                                                                          'update' => 30,
                                                                                          'whitelist' => 'All'
                                                                                        },
                                                                       'title' => 'Network Compliance',
                                                                       'type' => 'NetworkCompliance'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'scale' => 'linear',
                                                                                          'showAll' => 1,
                                                                                          'update' => 30,
                                                                                          'whitelist' => 'All'
                                                                                        },
                                                                       'title' => 'Allow List Events',
                                                                       'type' => 'WLEvents'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'ipaddr',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'whitelist_violations',
                                                                                          'title' => 'Allow List Violations',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Allow List Violations',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    }
                                                  ]
                                     },
                                     {
                                       'label' => 'Status',
                                       'lists' => [
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'display' => 'pie',
                                                                                          'update' => 60
                                                                                        },
                                                                       'title' => 'Appliance Status',
                                                                       'type' => 'ApplianceStatus'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'display' => 'simple',
                                                                                          'update' => 60
                                                                                        },
                                                                       'title' => 'Appliance Information',
                                                                       'type' => 'SystemInfo'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'showLatest' => 1,
                                                                                          'update' => 300
                                                                                        },
                                                                       'title' => 'Product Updates',
                                                                       'type' => 'ProductUpdates'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'cannedFeed' => 'https://blog.talosintelligence.com/rss/',
                                                                                          'entries' => 5,
                                                                                          'feedUrl' => 'https://blog.talosintelligence.com/rss/',
                                                                                          'showDescriptions' => 0
                                                                                        },
                                                                       'title' => 'RSS Feed',
                                                                       'type' => 'RSSFeed'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'update' => 60
                                                                                        },
                                                                       'title' => 'Current Sessions',
                                                                       'type' => 'Sessions'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'showBoot' => 1,
                                                                                          'synchronize' => 30
                                                                                        },
                                                                       'title' => 'System Time',
                                                                       'type' => 'SystemTime'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'loadAvg' => 1,
                                                                                          'update' => 60
                                                                                        },
                                                                       'title' => 'System Load',
                                                                       'type' => 'SystemLoad'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'display' => 'now',
                                                                                          'showAll' => 0,
                                                                                          'update' => 60
                                                                                        },
                                                                       'title' => 'Disk Usage',
                                                                       'type' => 'DiskUsage'
                                                                     }
                                                                   ]
                                                    }
                                                  ]
                                     }
                                   ]
                       },
                       {
                         '__FILTER' => sub { SF::Global::getApplianceType() eq 'mc' },
                         '__ID' => 'DC_FILES',
                         '__VERSION' => 'pre-6.0.0',
                         'activeIndex' => 0,
                         'cycle' => 0,
                         'description' => 'Provides an overview of Malware and File Events',
                         'lookback' => 3600,
                         'name' => 'Files Dashboard',
                         'refresh' => 0,
                         'tabs' => [
                                     {
                                       'label' => 'Malware',
                                       'lists' => [
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#f2bb6c',
                                                                                          'field' => 'receiving_ip',
                                                                                          'numResults' => 5,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => '95363a4e-7c38-11e1-972d-a8c3ba6b6369',
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'fireamp_event',
                                                                                          'title' => 'Hosts Receiving Malware',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Hosts Receiving Malware',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#f2bb6c',
                                                                                          'field' => 'sending_ip',
                                                                                          'numResults' => 5,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => '95363a4e-7c38-11e1-972d-a8c3ba6b6369',
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'fireamp_event',
                                                                                          'title' => 'Hosts Sending Malware',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Hosts Sending Malware',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#a3d6a3',
                                                                                          'field' => 'app_proto',
                                                                                          'numResults' => 5,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'fireamp_event',
                                                                                          'title' => 'Application Protocols Introducing Malware',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Application Protocols Introducing Malware',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'client',
                                                                                          'numResults' => 5,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'fireamp_event',
                                                                                          'title' => 'Client Applications Introducing Malware',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Client Applications Introducing Malware',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'web_app',
                                                                                          'numResults' => 5,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'fireamp_event',
                                                                                          'title' => 'Web Applications Introducing Malware',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Web Applications Introducing Malware',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#e07777',
                                                                                          'field' => 'file_type',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => '55e02258-67e2-4915-9b9f-a393e2a5d60f',
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'captured_file',
                                                                                          'title' => 'Possible Zero-Day Malware',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Possible Zero-Day Malware',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#e07777',
                                                                                          'field' => 'detection_name',
                                                                                          'numResults' => 5,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'fireamp_event',
                                                                                          'title' => 'Malware Threats',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Malware Threats',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#5d81b3',
                                                                                          'field' => 'dynamic_bucket_time',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => '95363a4e-7c38-11e1-972d-a8c3ba6b6369',
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'fireamp_event',
                                                                                          'title' => 'Threat Detections over Time',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Threat Detections over Time',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#bbeced',
                                                                                          'field' => 'user',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => '95363a4e-7c38-11e1-972d-a8c3ba6b6369',
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'fireamp_event',
                                                                                          'title' => 'Users Affected by Malware',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Users Affected by Malware',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#e07777',
                                                                                          'field' => 'threat_level',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'ld',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'captured_file',
                                                                                          'title' => 'Top Threats',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Top Threats',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#e07777',
                                                                                          'field' => 'event',
                                                                                          'numResults' => 5,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => '4b0368d8-d8f5-11e1-9623-d8e8dbc3926e',
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'event',
                                                                                          'title' => 'Malware Intrusions',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Malware Intrusions',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#b0a8ee',
                                                                                          'field' => 'file_type',
                                                                                          'numResults' => 5,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'fireamp_event',
                                                                                          'title' => 'File Types Infected with Malware',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'File Types Infected with Malware',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#b0a8ee',
                                                                                          'field' => 'parent_file_name',
                                                                                          'numResults' => 5,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'fireamp_event',
                                                                                          'title' => 'Processes Introducing Malware',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Processes Introducing Malware',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    }
                                                  ]
                                     },
                                     {
                                       'label' => 'Files',
                                       'lists' => [
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#f2bb6c',
                                                                                          'field' => 'receiving_ip',
                                                                                          'numResults' => 5,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'file_event',
                                                                                          'title' => 'Hosts Receiving Files',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Hosts Receiving Files',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#f2bb6c',
                                                                                          'field' => 'sending_ip',
                                                                                          'numResults' => 5,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'file_event',
                                                                                          'title' => 'Hosts Sending Files',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Hosts Sending Files',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#a3d6a3',
                                                                                          'field' => 'app_proto',
                                                                                          'numResults' => 5,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'file_event',
                                                                                          'title' => 'Application Protocols Transferring Files',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Application Protocols Transferring Files',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'client',
                                                                                          'numResults' => 5,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'file_event',
                                                                                          'title' => 'Client Applications Transferring Files',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Client Applications Transferring Files',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'web_app',
                                                                                          'numResults' => 5,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'file_event',
                                                                                          'title' => 'Web Applications Transferring Files',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Web Applications Transferring Files',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#5d81b3',
                                                                                          'field' => 'dynamic_bucket_time',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'file_event',
                                                                                          'title' => 'File Transfers over Time',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'File Transfers over Time',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'file_disposition',
                                                                                          'numResults' => 5,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'file_event',
                                                                                          'title' => 'File Dispositions',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'File Dispositions',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'file_rule_action',
                                                                                          'numResults' => 5,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'file_event',
                                                                                          'title' => 'File Actions',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'File Actions',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#bbeced',
                                                                                          'field' => 'user',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'file_event',
                                                                                          'title' => 'Users Transferring Files',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Users Transferring Files',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#b0a8ee',
                                                                                          'field' => 'file_type_category',
                                                                                          'numResults' => 5,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'file_event',
                                                                                          'title' => 'File Categories',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'File Categories',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#b0a8ee',
                                                                                          'field' => 'file_type',
                                                                                          'numResults' => 5,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'file_event',
                                                                                          'title' => 'File Types',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'File Types',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#b0a8ee',
                                                                                          'field' => 'file_name',
                                                                                          'numResults' => 5,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'file_event',
                                                                                          'title' => 'File Names',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'File Names',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    }
                                                  ]
                                     },
                                     {
                                       'label' => 'Status',
                                       'lists' => [
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'files_stored_kbytes_sum',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'file_type',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'storage_type_stats',
                                                                                          'title' => 'File Storage by Type',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'File Storage by Type',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'files_stored_kbytes_sum',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'file_disposition',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'storage_disp_stats',
                                                                                          'title' => 'File Storage by Disposition',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'File Storage by Disposition',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'files_stored_kbytes_sum',
                                                                                          'color' => '#5d81b3',
                                                                                          'field' => 'bucket_time',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'storage_disp_stats',
                                                                                          'title' => 'File Storage over Time',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'File Storage over Time',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'files_stored_sum',
                                                                                          'color' => '#5d81b3',
                                                                                          'field' => 'bucket_time',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'storage_disp_stats',
                                                                                          'title' => 'Files Stored over Time',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Files Stored over Time',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'files_stored_kbytes_sum',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'device',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'storage_disp_stats',
                                                                                          'title' => 'File Storage by Device',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'File Storage by Device',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'files_sent_kbytes_sum',
                                                                                          'color' => '#5d81b3',
                                                                                          'field' => 'bucket_time',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'transmission_type_stats',
                                                                                          'title' => 'Dynamic Analysis Traffic over Time',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Dynamic Analysis Traffic over Time',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'files_sent_sum',
                                                                                          'color' => '#5d81b3',
                                                                                          'field' => 'bucket_time',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'transmission_type_stats',
                                                                                          'title' => 'Files Sent for Dynamic Analysis over Time',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Files Sent for Dynamic Analysis over Time',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'files_sent_kbytes_sum',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'device',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'transmission_type_stats',
                                                                                          'title' => 'Dynamic Analysis Traffic by Device',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Dynamic Analysis Traffic by Device',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    }
                                                  ]
                                     }
                                   ]
                       },
                       {
                         '__DEFAULT' => 1,
                         '__FILTER' => sub { SF::Global::getApplianceType() eq 'mc' },
                         '__ID' => 'DC_SUMMARY',
                         '__VERSION' => '10.0.0',
                         'activeIndex' => 0,
                         'cycle' => 0,
                         'description' => 'Provides a summary of activity on the appliance',
                         'lookback' => 3600,
                         'name' => 'Summary Dashboard',
                         'refresh' => 0,
                         'tabs' => [
                                     {
                                       'label' => 'Network',
                                       'lists' => [
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'unique_applications',
                                                                                          'color' => '#5d81b3',
                                                                                          'field' => 'bucket_time',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'app_session_stats',
                                                                                          'title' => 'Unique Applications over Time',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Unique Applications over Time',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'kbytes_sum',
                                                                                          'color' => '#e07777',
                                                                                          'field' => 'risk',
                                                                                          'numResults' => 5,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'app_session_stats',
                                                                                          'title' => 'Traffic by Application Risk',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Traffic by Application Risk',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'kbytes_sum',
                                                                                          'color' => '#a3d6a3',
                                                                                          'field' => 'productivity',
                                                                                          'numResults' => 5,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'app_session_stats',
                                                                                          'title' => 'Traffic by Business Relevance',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Traffic by Business Relevance',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'kbytes_sum',
                                                                                          'color' => '#b0a8ee',
                                                                                          'field' => 'category',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'app_session_stats',
                                                                                          'title' => 'Traffic by Application Category',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Traffic by Application Category',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'kbytes_sum',
                                                                                          'color' => '#bbeced',
                                                                                          'field' => 'application',
                                                                                          'numResults' => 15,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 'c2f80a42-36f7-11e1-95bd-c3f1054139bc',
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'app_session_stats',
                                                                                          'title' => 'Top Web Applications Seen',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Top Web Applications Seen',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#f2bb6c',
                                                                                          'field' => 'vendor',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 'c3251f6e-36f7-11e1-95bd-c3f1054139bc',
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'rna_service',
                                                                                          'title' => 'Top Server Applications Seen',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Top Server Applications Seen',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'flows_sum',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'application',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 'c7aecc6a-096b-11e1-8057-af06213e7baa',
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'app_session_stats',
                                                                                          'title' => 'Risky Applications with Low Business Relevance',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Risky Applications with Low Business Relevance',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'flows_sum',
                                                                                          'color' => '#e07777',
                                                                                          'field' => 'reputation',
                                                                                          'numResults' => 5,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'url_rep_stats',
                                                                                          'title' => 'Connections by URL Reputation',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Connections by URL Reputation',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'kbytes_sum',
                                                                                          'color' => '#a3d6a3',
                                                                                          'field' => 'application',
                                                                                          'numResults' => 15,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 'c3d4a8da-36f7-11e1-95bd-c3f1054139bc',
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'app_session_stats',
                                                                                          'title' => 'Top Client Applications Seen',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Top Client Applications Seen',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#b0a8ee',
                                                                                          'field' => 'os_name',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 'c400127c-36f7-11e1-95bd-c3f1054139bc',
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'rna_ip_host',
                                                                                          'title' => 'Top Operating Systems Seen',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Top Operating Systems Seen',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'kbytes_sum',
                                                                                          'color' => '#bbeced',
                                                                                          'field' => 'username',
                                                                                          'numResults' => 5,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'user_session_stats',
                                                                                          'title' => 'Traffic by User',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Traffic by User',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'flows_sum',
                                                                                          'color' => '#f2bb6c',
                                                                                          'field' => 'category',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'url_cat_stats',
                                                                                          'title' => 'Connections by URL Category',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Connections by URL Category',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    }
                                                  ]
                                     },
                                     {
                                       'label' => 'Threats',
                                       'lists' => [
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#e07777',
                                                                                          'field' => 'ipaddr',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'ioc_state',
                                                                                          'title' => 'Indications of Compromise by Host',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Indications of Compromise by Host',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#e07777',
                                                                                          'field' => 'detection_name',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'fireamp_event',
                                                                                          'title' => 'Malware Threats',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Malware Threats',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#a3d6a3',
                                                                                          'field' => 'user',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'user_ioc_state',
                                                                                          'title' => 'Indications of Compromise by User',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Indications of Compromise by User',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'scale' => 'logarithmic',
                                                                                          'show' => 'total',
                                                                                          'types' => {
                                                                                                       'all' => 1,
                                                                                                       'dropped' => 1,
                                                                                                       'i1' => 1,
                                                                                                       'i2' => 1,
                                                                                                       'i3' => 1,
                                                                                                       'i4' => 1,
                                                                                                       'i5' => 1
                                                                                                     },
                                                                                          'update' => 30
                                                                                        },
                                                                       'title' => 'Intrusion Events',
                                                                       'type' => 'IPSEvents'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'flows_sum',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'ip_rep_category',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'ip_rep_cat_session_stats',
                                                                                          'title' => 'Connections by Security Intelligence Category',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Connections by Security Intelligence Category',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'kbytes_sum',
                                                                                          'color' => '#f2bb6c',
                                                                                          'field' => 'ip_rep_category',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'ip_rep_cat_session_stats',
                                                                                          'title' => 'Traffic by Security Intelligence Category',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Traffic by Security Intelligence Category',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    }
                                                  ]
                                     },
                                     {
                                       'label' => 'Intrusion Events',
                                       'lists' => [
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'src',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'event',
                                                                                          'title' => 'Top Attackers',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Top Attackers',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'dst',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'event',
                                                                                          'title' => 'Top Targets',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Top Targets',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#e07777',
                                                                                          'field' => 'classification',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 'd179f898-2909-11e0-ad19-fff04c9de09a',
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'event',
                                                                                          'title' => 'Dropped Intrusion Events',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Dropped Intrusion Events',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#5d81b3',
                                                                                          'field' => 'dynamic_bucket_time',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'event',
                                                                                          'title' => 'All Intrusion Events',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'All Intrusion Events',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'scale' => 'logarithmic',
                                                                                          'show' => 'total',
                                                                                          'types' => {
                                                                                                       'all' => 1,
                                                                                                       'dropped' => 1,
                                                                                                       'i1' => 1,
                                                                                                       'i2' => 1,
                                                                                                       'i3' => 1,
                                                                                                       'i4' => 1,
                                                                                                       'i5' => 1
                                                                                                     },
                                                                                          'update' => 30
                                                                                        },
                                                                       'title' => 'Intrusion Events',
                                                                       'type' => 'IPSEvents'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'events_sum',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'username',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'user_ids_stats',
                                                                                          'title' => 'Total Events by User',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Total Events by User',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'events_sum',
                                                                                          'color' => '#b0a8ee',
                                                                                          'field' => 'application',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 'dbbaaf0e-36f6-11e1-9fa6-c75b53b92104',
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'app_ids_stats',
                                                                                          'title' => 'Total Events by Application Protocol',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Total Events by Application Protocol',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'impact_level_1_events_sum',
                                                                                          'color' => '#e07777',
                                                                                          'field' => 'application',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 'dbbaaf0e-36f6-11e1-9fa6-c75b53b92104',
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'app_ids_stats',
                                                                                          'title' => 'Impact 1 Events by Application Protocol',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Impact 1 Events by Application Protocol',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'impact_level_2_events_sum',
                                                                                          'color' => '#f2bb6c',
                                                                                          'field' => 'application',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 'dbbaaf0e-36f6-11e1-9fa6-c75b53b92104',
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'app_ids_stats',
                                                                                          'title' => 'Impact 2 Events by Application Protocol',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Impact 2 Events by Application Protocol',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    }
                                                  ]
                                     },
                                     {
                                       'label' => 'Status',
                                       'lists' => [
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'display' => 'pie',
                                                                                          'update' => 60
                                                                                        },
                                                                       'title' => 'Appliance Status',
                                                                       'type' => 'ApplianceStatus'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'showLatest' => 1,
                                                                                          'update' => 300
                                                                                        },
                                                                       'title' => 'Product Updates',
                                                                       'type' => 'ProductUpdates'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'display' => 'now',
                                                                                          'showAll' => 0,
                                                                                          'update' => 60
                                                                                        },
                                                                       'title' => 'Disk Usage',
                                                                       'type' => 'DiskUsage'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'display' => 'simple',
                                                                                          'update' => 60
                                                                                        },
                                                                       'title' => 'Appliance Information',
                                                                       'type' => 'SystemInfo'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'cannedFeed' => 'https://blog.talosintelligence.com/rss/',
                                                                                          'entries' => 5,
                                                                                          'feedUrl' => 'https://blog.talosintelligence.com/rss/',
                                                                                          'showDescriptions' => 0
                                                                                        },
                                                                       'title' => 'RSS Feed',
                                                                       'type' => 'RSSFeed'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'update' => 60
                                                                                        },
                                                                       'title' => 'Current Sessions',
                                                                       'type' => 'Sessions'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'showBoot' => 1,
                                                                                          'synchronize' => 30
                                                                                        },
                                                                       'title' => 'System Time',
                                                                       'type' => 'SystemTime'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'loadAvg' => 1,
                                                                                          'update' => 60
                                                                                        },
                                                                       'title' => 'System Load',
                                                                       'type' => 'SystemLoad'
                                                                     }
                                                                   ]
                                                    }
                                                  ]
                                     },
                                     {
                                       'label' => 'Shadow Traffic',
                                       'top_list' => {
                                                       'widgets' => [
                                                                      {
                                                                        'collapsed' => 1,
                                                                        'last_access' => 0,
                                                                        'minimized' => 0,
                                                                        'preferences' => {
                                                                                           '0_title' => 'Evasive VPNs',
                                                                                           '0_table' => 'shadow_traffic_stats_evasive_vpn',
                                                                                           '0_search' => '',
                                                                                           '0_aggregate' => 'flows_sum',
                                                                                           '0_linkPageType' => 'Events',
                                                                                           '0_linkTable' => 'rna_flow_stats',
                                                                                           '0_linkConstraints' => 'shadow_traffic_type%3DEvasive%20VPN',
                                                                                           '1_title' => 'Multihop Proxies',
                                                                                           '1_table' => 'shadow_traffic_stats_multihop_proxy',
                                                                                           '1_search' => '',
                                                                                           '1_aggregate' => 'flows_sum',
                                                                                           '1_linkPageType' => 'Events',
                                                                                           '1_linkTable' => 'rna_flow_stats',
                                                                                           '1_linkConstraints' => 'shadow_traffic_type%3DMultihop%20Proxy',
                                                                                           '2_title' => 'Encrypted DNS',
                                                                                           '2_table' => 'shadow_traffic_stats_encrypted_dns',
                                                                                           '2_search' => '',
                                                                                           '2_aggregate' => 'flows_sum',
                                                                                           '2_linkPageType' => 'Events',
                                                                                           '2_linkTable' => 'rna_flow_stats',
                                                                                           '2_linkConstraints' => 'shadow_traffic_type%3DEncrypted%20DNS',
                                                                                           '3_title' => 'Domain Fronting',
                                                                                           '3_table' => 'shadow_traffic_stats_domain_fronting',
                                                                                           '3_search' => '',
                                                                                           '3_aggregate' => 'flows_sum',
                                                                                           '3_linkPageType' => 'Events',
                                                                                           '3_linkTable' => 'rna_flow_stats',
                                                                                           '3_linkConstraints' => 'shadow_traffic_type%3DDomain%20Fronting',
                                                                                           '4_title' => 'Fake TLS',
                                                                                           '4_table' => 'shadow_traffic_stats_fake_tls',
                                                                                           '4_search' => '',
                                                                                           '4_aggregate' => 'flows_sum',
                                                                                           '4_linkPageType' => 'Events',
                                                                                           '4_linkTable' => 'rna_flow_stats',
                                                                                           '4_linkConstraints' => 'shadow_traffic_type%3DFake%20TLS',
                                                                                           'showChanges' => 1,
                                                                                           'tz' => 'America/New_York'
                                                                                         },
                                                                        'title' => 'Shadow Traffic Connections',
                                                                        'type' => 'Counts'
                                                                      }
                                                                    ]
                                                     },
                                       'lists' => [
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'flows_sum',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'tlsfp_process_name',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'shadow_traffic_stats_evasive_vpn',
                                                                                          'title' => 'Evasive VPNs',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Evasive VPNs',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'flows_sum',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'responder_ip',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'shadow_traffic_stats_multihop_proxy',
                                                                                          'title' => 'Multihop Proxies',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Multihop Proxies',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'flows_sum',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'responder_ip',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'shadow_traffic_stats_encrypted_dns',
                                                                                          'title' => 'Encrypted DNS',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Encrypted DNS',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'flows_sum',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'server_name',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'shadow_traffic_stats_domain_fronting',
                                                                                          'title' => 'Domain Fronting',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Domain Fronting',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'flows_sum',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'responder_ip',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'shadow_traffic_stats_fake_tls',
                                                                                          'title' => 'Fake TLS',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Fake TLS',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    }
                                                  ]
                                     },
                                     {
                                       '__FILTER' => sub { SF::Global::getApplianceModel() ne '500s2' },
                                       'label' => 'Geolocation',
                                       'lists' => [
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#a3d6a3',
                                                                                          'field' => 'src_country',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'event',
                                                                                          'title' => 'Intrusion Events by Source Country',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Intrusion Events by Source Country',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#a3d6a3',
                                                                                          'field' => 'dst_country',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'event',
                                                                                          'title' => 'Intrusion Events by Destination Country',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Intrusion Events by Destination Country',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#b0a8ee',
                                                                                          'field' => 'src_continent',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'event',
                                                                                          'title' => 'Intrusion Events by Source Continent',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Intrusion Events by Source Continent',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'count',
                                                                                          'color' => '#b0a8ee',
                                                                                          'field' => 'dst_continent',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'event',
                                                                                          'title' => 'Intrusion Events by Destination Continent',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Intrusion Events by Destination Continent',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => []
                                                    }
                                                  ]
                                     },
                                     {
                                       'label' => 'QoS',
                                       'lists' => [
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'qos_dropped_kbytes',
                                                                                          'color' => '#bbeced',
                                                                                          'field' => 'sensor',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'intf_session_stats',
                                                                                          'title' => 'QoS-Dropped Traffic by Device',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'QoS-Dropped Traffic by Device',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'qos_dropped_kbytes_sum',
                                                                                          'color' => '#b0a8ee',
                                                                                          'field' => 'application',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'app_session_stats',
                                                                                          'title' => 'QoS-Dropped Traffic by Application',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'QoS-Dropped Traffic by Application',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'qos_dropped_kbytes',
                                                                                          'color' => '#e07777',
                                                                                          'field' => 'interface',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'intf_session_stats',
                                                                                          'title' => 'QoS-Dropped Traffic by Interface',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'QoS-Dropped Traffic by Interface',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'qos_dropped_kbytes_sum',
                                                                                          'color' => '#b0a8ee',
                                                                                          'field' => 'category',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'app_session_stats',
                                                                                          'title' => 'QoS-Dropped Traffic by Application Category',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'QoS-Dropped Traffic by Application Category',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'qos_dropped_kbytes_sum',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'username',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'user_session_stats',
                                                                                          'title' => 'QoS-Dropped Traffic by User',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'QoS-Dropped Traffic by User',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'qos_dropped_kbytes_sum',
                                                                                          'color' => '#f2bb6c',
                                                                                          'field' => 'rule',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'qos_rule_session_stats',
                                                                                          'title' => 'QoS-Dropped Traffic by QoS Rule',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'QoS-Dropped Traffic by QoS Rule',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    }
                                                  ]
                                     },
                                     {
                                       'label' => 'Zero Trust',
                                       'lists' => [
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'kbytes_sum',
                                                                                          'color' => '#a3d6a3',
                                                                                          'field' => 'application',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'ztna_app_session_stats',
                                                                                          'title' => 'Top Zero Trust Applications',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Top Zero Trust Applications',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'kbytes_sum',
                                                                                          'color' => '#bbeced',
                                                                                          'field' => 'username',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'ztna_user_session_stats',
                                                                                          'title' => 'Top Zero Trust Users',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Top Zero Trust Users',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => []
                                                    }
                                                  ]
                                     },
                                     {
                                       'label' => 'Encrypted Visibility Engine',
                                       'lists' => [
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'flows_sum',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'tlsfp_process_name',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'tlsfp_processname_stats',
                                                                                          'title' => 'Discovered Processes',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Discovered Processes',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'malicious_count',
                                                                                          'color' => '#e07777',
                                                                                          'field' => 'tlsfp_process_name',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'tlsfp_processname_stats',
                                                                                          'title' => 'Malicious Processes',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Malicious Processes',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'blocked_count',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'bucket_time',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'tlsfp_processname_stats',
                                                                                          'title' => 'Blocked Connections',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Blocked Connections',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'flows_sum',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'tlsfp_malware_confidence',
                                                                                          'numResults' => 5,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'tlsfp_malware_stats',
                                                                                          'title' => 'Threat Confidence',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Threat Confidence',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'malicious_count',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'responder_ip',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'eve_threat_detail_stats',
                                                                                          'title' => 'Malicious Process Responder IPs',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Malicious Process Responder IPs',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'flows_sum',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'bucket_time',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'tlsfp_processname_stats',
                                                                                          'title' => 'Connections with Detected Process Names',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Connections with Detected Process Names',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'malicious_count',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'server_name',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'eve_threat_detail_stats',
                                                                                          'title' => 'Malicious Process Contacted Domains',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Malicious Process Contacted Domains',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'Total Connections',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'crypto_assessment_type',
                                                                                          'numResults' => 5,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'crypto_assessment_stats',
                                                                                          'title' => 'Crypto Assessment',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Crypto Assessment',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'Connections with Exposed Credentials',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'responder_ip',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'exposed_credentials_stats',
                                                                                          'title' => 'Top Responder IPs with Exposed Credentials Sessions',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Top Responder IPs with Exposed Credentials Sessions',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    
                                                  ]
                                      }
                                   ]
                       },
                       {
                         '__FILTER' => sub { SF::Global::getApplianceType() eq 'mc' },
                         '__ID' => 'DC_SI_STATS',
                         '__VERSION' => '6.0.0',
                         'activeIndex' => 0,
                         'cycle' => 0,
                         'description' => 'Provides Security Intelligence statistics',
                         'lookback' => 3600,
                         'name' => 'Security Intelligence Statistics',
                         'refresh' => 0,
                         'tabs' => [
                                     {
                                       'label' => 'Statistics',
                                       'lists' => [
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'flows_sum',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'url_si_category',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'ip_rep_cat_session_stats',
                                                                                          'title' => 'Connections by URL SI Categories',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Connections by URL SI Categories',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'kbytes_sum',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'url_si_category',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'ip_rep_cat_session_stats',
                                                                                          'title' => 'Traffic by URL SI Categories',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Traffic by URL SI Categories',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'flows_sum',
                                                                                          'color' => '#a3d6a3',
                                                                                          'field' => 'ip_si_category',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'ip_rep_cat_session_stats',
                                                                                          'title' => 'Connections by Network SI Categories',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Connections by Network SI Categories',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'kbytes_sum',
                                                                                          'color' => '#a3d6a3',
                                                                                          'field' => 'ip_si_category',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'ip_rep_cat_session_stats',
                                                                                          'title' => 'Traffic by Network SI Categories',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Traffic by Network SI Categories',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'flows_sum',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'dns_si_category',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'ip_rep_cat_session_stats',
                                                                                          'title' => 'Connections by DNS SI Categories',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Connections by DNS SI Categories',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'kbytes_sum',
                                                                                          'color' => '#a3d6a3',
                                                                                          'field' => 'dns_si_category',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'ip_rep_cat_session_stats',
                                                                                          'title' => 'Traffic by DNS SI Categories',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Traffic by DNS SI Categories',
                                                                       'type' => 'Top10'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'aggregate' => 'flows_sum',
                                                                                          'color' => '#cbd9e8',
                                                                                          'field' => 'dns_record_type',
                                                                                          'numResults' => 10,
                                                                                          'postSort' => 'rd',
                                                                                          'preset' => '',
                                                                                          'search' => 0,
                                                                                          'showChanges' => 1,
                                                                                          'table' => 'dns_queries_by_record_type',
                                                                                          'title' => 'Connections by DNS Record Types',
                                                                                          'to_show' => 'desc',
                                                                                          'tz' => 'America/New_York'
                                                                                        },
                                                                       'title' => 'Connections by DNS Record Types',
                                                                       'type' => 'Top10'
                                                                     }
                                                                   ]
                                                    }
                                                  ]
                                     }
                                   ]
                       },
                       #
                       # Sensor Dashboards
                       #
                       {
                         '__DEFAULT' => 1,
                         '__FILTER' => sub { SF::Global::getApplianceType() eq 'sensor' && !SF::Global::hasOnBoxManager() },
                         '__ID' => 'SENSOR_SUMMARY',
                         '__VERSION' => 'pre-6.0.0',
                         'activeIndex' => 0,
                         'cycle' => 0,
                         'description' => 'Provides a summary of activity on the appliance',
                         'lookback' => 3600,
                         'name' => 'Summary Dashboard',
                         'refresh' => 0,
                         'tabs' => [
                                     {
                                       'label' => 'Summary',
                                       'lists' => [
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'display' => 'simple',
                                                                                          'update' => 60
                                                                                        },
                                                                       'title' => 'Appliance Information',
                                                                       'type' => 'SystemInfo'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'loadAvg' => 1,
                                                                                          'update' => 60
                                                                                        },
                                                                       'title' => 'System Load',
                                                                       'type' => 'SystemLoad'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'showBoot' => 1,
                                                                                          'synchronize' => 30
                                                                                        },
                                                                       'title' => 'System Time',
                                                                       'type' => 'SystemTime'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'update' => 60
                                                                                        },
                                                                       'title' => 'Current Sessions',
                                                                       'type' => 'Sessions'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'cannedFeed' => 'https://blog.talosintelligence.com/rss/',
                                                                                          'entries' => 5,
                                                                                          'feedUrl' => 'https://blog.talosintelligence.com/rss/',
                                                                                          'showDescriptions' => 0
                                                                                        },
                                                                       'title' => 'RSS Feed',
                                                                       'type' => 'RSSFeed'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'showAll' => 0,
                                                                                          'update' => 60
                                                                                        },
                                                                       'title' => 'Interface Traffic',
                                                                       'type' => 'InterfaceTraffic'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'update' => 30
                                                                                        },
                                                                       'title' => 'Current Interface Status',
                                                                       'type' => 'InterfaceStatus'
                                                                     }
                                                                   ]
                                                    }
                                                  ]
                                     }
                                   ]
                       },
                       #
                       # Onbox Dashboards
                       #
                       {
                         '__DEFAULT' => 1,
                         '__FILTER' => sub { SF::Global::hasOnBoxManager() },
                         '__ID' => 'ONBOX_SUMMARY',
                         '__VERSION' => 'pre-6.0.0',
                         'activeIndex' => 0,
                         'cycle' => 0,
                         'description' => 'Provides a summary of activity on the appliance',
                         'lookback' => 3600,
                         'name' => 'Summary Dashboard',
                         'refresh' => 0,
                         'tabs' => [
                                     {
                                       'label' => 'Summary',
                                       'lists' => [
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'display' => 'simple',
                                                                                          'update' => 60
                                                                                        },
                                                                       'title' => 'Appliance Information',
                                                                       'type' => 'SystemInfo'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'showLatest' => 1,
                                                                                          'update' => 300
                                                                                        },
                                                                       'title' => 'Product Updates',
                                                                       'type' => 'ProductUpdates'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'showLatest' => 1,
                                                                                          'update' => 300
                                                                                        },
                                                                       'title' => 'Product Licensing',
                                                                       'type' => 'Licensing'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'loadAvg' => 1,
                                                                                          'update' => 60
                                                                                        },
                                                                       'title' => 'System Load',
                                                                       'type' => 'SystemLoad'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'display' => 'now',
                                                                                          'showPartitions' => 0,
                                                                                          'update' => 60
                                                                                        },
                                                                       'title' => 'Disk Usage',
                                                                       'type' => 'DiskUsage'
                                                                     },
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'showBoot' => 1,
                                                                                          'synchronize' => 30
                                                                                        },
                                                                       'title' => 'System Time',
                                                                       'type' => 'SystemTime'
                                                                     }
                                                                   ]
                                                    },
                                                    {
                                                      'widgets' => [
                                                                     {
                                                                       'collapsed' => 1,
                                                                       'last_access' => 0,
                                                                       'minimized' => 0,
                                                                       'preferences' => {
                                                                                          'update' => 30
                                                                                        },
                                                                       'title' => 'Current Interface Status',
                                                                       'type' => 'InterfaceStatus'
                                                                     }
                                                                   ]
                                                    }
                                                  ]
                                     }
                                   ]
                       }
    );

    @dashboards = grep { !defined $_->{__FILTER} || &{$_->{__FILTER}}() } @dashboards;
    for my $dashboard (@dashboards) {
        delete $dashboard->{__FILTER};
        @{$dashboard->{tabs}} = grep { !defined $_->{__FILTER} || &{$_->{__FILTER}}() } @{$dashboard->{tabs}};
        for my $tab (@{$dashboard->{tabs}}) {
            delete $tab->{__FILTER};
            my @lists = @{$tab->{lists}};
            push @lists, $tab->{top_list} if defined $tab->{top_list};
            for my $list (@lists) {
                if (SF::MultiTenancy::getCurrentDomain() ne SF::MultiTenancy::getGlobalDomainId()) {
                    @{$list->{widgets}} = grep { SF::Dashboard::Widget::isValidForDomains($_->{type}) } @{$list->{widgets}};
                }
                @{$list->{widgets}} = grep { !defined $_->{__FILTER} || &{$_->{__FILTER}}() } @{$list->{widgets}};
                delete $_->{__FILTER} for @{$list->{widgets}};
            }
        }
    }

    return @dashboards;
}

#
# getPresets
#
#   Returns a list of all default widget presets valid on the current system.
#
sub getPresets {
    my %presets = ();
    for my $widget (grep { $_->{type} eq 'Top10' } map { @{$_->{widgets}} } map { @{$_->{lists}} } map { @{$_->{tabs}} } get()) {
        my $name = $widget->{preferences}{title};
        my %preset = map { $_ => $widget->{preferences}{$_} } (qw(table field aggregate search to_show postSort));
        die "Different settings found with same widget title: $name"
            if defined $presets{$name} && grep { $presets{$name}->{$_} ne $preset{$_} } keys %preset;
        $presets{$name} = { name => $name, %preset };
    }
    return values %presets;
}

#
# install
#
#   Creates new dashboard objects from the default configurations.
#
sub install {
    my @configs = @_ ? @_ : get();
    for my $dashboard (@configs) {
        my @tab_uuids;
        for my $tab (@{$dashboard->{tabs}}) {
            my @list_uuids;
            for my $list (@{$tab->{lists}}) {
                my @widget_uuids;
                for my $widget (@{$list->{widgets}}) {
                    my $widget_obj = SF::EOHandler::storeObject(SF::EOHandler::newObject('DashboardWidget', $widget));
                    push @widget_uuids, $widget_obj->{uuid};
                }
                $list->{widgets} = \@widget_uuids;
                my $list_obj = SF::EOHandler::storeObject(SF::EOHandler::newObject('DashboardWidgetList', $list));
                push @list_uuids, $list_obj->{uuid};
            }
            $tab->{lists} = \@list_uuids;
            if (defined $tab->{top_list}) {
                my $list = $tab->{top_list};
                my @widget_uuids;
                for my $widget (@{$list->{widgets}}) {
                    my $widget_obj = SF::EOHandler::storeObject(SF::EOHandler::newObject('DashboardWidget', $widget));
                    push @widget_uuids, $widget_obj->{uuid};
                }
                $list->{widgets} = \@widget_uuids;
                my $list_obj = SF::EOHandler::storeObject(SF::EOHandler::newObject('DashboardWidgetList', $list));
                $tab->{top_list} = $list_obj->{uuid};
            }
            my $tab_obj = SF::EOHandler::storeObject(SF::EOHandler::newObject('DashboardTab', $tab));
            push @tab_uuids, $tab_obj->{uuid};
        }
        $dashboard->{tabs} = \@tab_uuids;
        SF::EOHandler::storeObject(SF::EOHandler::newObject('Dashboard', $dashboard));
    }
}

#
# installPresets
#
#    Creates new widget presets from the default configurations.
#
sub installPresets {
    for my $preset (getPresets()) {
        SF::EOHandler::storeObject(SF::EOHandler::newObject('DashboardPreset', $preset));
    }
}

#
# find
#
#   Returns a list of UUIDs corresponding to default dashboard objects matching
#   the given constraint. The constraint is given as a key-value pair where
#   the key can be either 'id' or 'default'.
#
#   @uuids = find(id => 'SUMMARY');
#   @uuids = find(default => 1);
#
sub find {
    my ($key, $value) = @_;
    my @dashboards = grep { defined $_->{data}{__ID} } @{SF::Dashboard::load()};

    if (defined $key && defined $value) {
        if ($key =~ /^ID$/i) {
            @dashboards = grep { $_->{data}{__ID} eq $value } @dashboards;
        }
        elsif ($key =~ /^DEFAULT$/i) {
            if ($value) {
                @dashboards = grep { $_->{data}{__DEFAULT} } @dashboards;
            }
            else {
                @dashboards = grep { !$_->{data}{__DEFAULT} } @dashboards;
            }
        }
    }

    return map { $_->{uuid} } @dashboards;
}

#
# resetAll
#
#   Deletes all dashboard objects created from default configurations and
#   re-creates them.
#
sub resetAll {
    SF::Dashboard::delete($_) for find();
    SF::EOHandler::deleteObject($_) for @{SF::EOHandler::bulkLoad('DashboardPreset')};
    install();
    installPresets();
}

#
# getUserDefault
#
#   Returns the UUID of the default dashboard for the current user.
#
sub getUserDefault {
    my $default = SF::UserPreferences::get_preference_value('Dashboard', 'Default');
    unless ($default && SF::Dashboard::exists($default)) {
        ($default) = find(default => 1);
    }
    return $default;
}

#
# setUserDefault
#
#   Sets the UUID of the default dashboard for the current user.
#
sub setUserDefault {
    my ($uuid) = @_;
    return undef unless SF::Dashboard::exists($uuid);
    SF::Dashboard::clearLoadCache();
    return SF::UserPreferences::set_preference_for_current_user('Dashboard', 'Default', $uuid);
}

sub getDashboardFlyout
{
    my $params = SF::Auth::getCurrentReqParams();
    my @flyout = ();

    foreach (sort {$a->{data}{name} cmp $b->{data}{name}} @{SF::Dashboard::load()})
    {
        push @flyout, {
            url => "/dashboard/view.cgi?id=$_->{uuid}",
            label => $_->{data}{name},
            active => $_->{uuid} eq $params->{id},
        };
    }
    push @flyout, {
        separator => 1,
    };
    push @flyout, {
        url => "/dashboard/new.cgi",
        label => SF::i18n::get_pm_msg("create_new_dashboard", "main")
    };

    return \@flyout;
}

1;
