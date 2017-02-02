# vim: ts=2:et:sw=2:sts=2:fdm=marker:si
#
# == Class: puppet
# ---
#
# Manages the Puppet Agent
#
# === Parameters
# ---
#
# [*enabled*]
# - Type - Boolean
# - Default - true
# - Agent auto run
#
# [*svc*]
# - Type - String
# - Default - puppet
# - Agent service name
#
# [*pkg*]
# - Type - String
# - Default - puppet
# - Agent package name
#
# [*version*]
# - Type - String
# - Default - 3.8.7-1.el6 (OS specific)
# - Puppet Agent Version
#
# [*user*]
# - Type - String
# - Default - OS Specific
# - Agent service run-as user
#
# [*group*]
# - Type - String
# - Default - OS Specific
# - Agent service run-as group
#
# [*configfile*]
# - Type - String
# - Default - OS Specific
# - Agent configuration file location (absolute path)
#
# [*settings*]
# - Type - Hash
# - Default - {}
# - Agent puppet configuration file settings
#
# [*defaults*]
# - Type - Hash
# - Default - OS Specific
# - Agent puppet configuration file setting defaults
#
class puppet (

  $agent_hash                 = hiera_hash("::puppet::params::agent"),
  $master_hash                = hiera_hash("::puppet::params::agent"),
  $main_hash                  = hiera_hash("::puppet::params::agent")

) inherits puppet::params {
 
  # [main] section parameters
  $logdir                     =  $main_hash["logdir"]
  $rundir                     =  $main_hash["rundir"]
  $ssldir                     =  $main_hash["ssldir"]
  $disable_warnings           =  $main_hash["disable_warnings"]

  validate_absolute_path  ( $logdir     )
  validate_absolute_path  ( $rundir     )
  validate_absolute_path  ( $ssldir     )
  validate_string         ( $disable_warnings )
  
  # [agent] section parameters
  $certname 				          =  $agent_hash["certname"]
  $pluginsync 			          =  $agent_hash["pluginsync"]
  $configtimeout 		          =  $agent_hash["configtimeout"]
  $autoflush 				          =  $agent_hash["autoflush"]
  $splay 					            =  $agent_hash["splay"]
  $environment 			          =  $agent_hash["environment"]
  $listen 					          =  $agent_hash["listen"]
  $server 					          =  $agent_hash["server"]
  $disable_warnings           =  $agent_hash["disable_warnings"]

  validate_string         ( $certname      )
  validate_bool           ( $pluginsync    )
  validate_integer        ( $configtimeout )
  validate_bool           ( $autoflush     )
  validate_bool           ( $splay         )
  validate_bool           ( $listen        )
  validate_string         ( $environment   )
  validate_string         ( $server        )
  
  # [master] section parameters
  $modulepaths                = $master_hash["modulepath"]
  $ssl_client_verify_headers	= $master_hash["ssl_client_verify_header"]
  $pluginsyncs                = $master_hash["pluginsync"]
  $manifests                  = $master_hash["manifest"]
  $certnames                  = $master_hash["certname"]
  $ssl_client_headers         = $master_hash["ssl_client_header"]
  $filetimeouts               = $master_hash["filetimeout"]
  $dns_alt_namess             = $master_hash["dns_alt_names"]
  $autosigns                  = $master_hash["autosign"]
  $environments               = $master_hash["environment"]

  validate_bool           ( $pluginsync       )
  validate_bool           ( $autosign         )

  # Initialize Module
  clabs::module::init { $name: }

}

