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

  $agent_hash                 = getvar("::puppet::params::puppetconf::default_agent_hash"),
  $master_hash                = getvar("::puppet::params::puppetconf::master_agent_hash"),
  $main_hash                  = getvar("::puppet::params::puppetconf::main_agent_hash")

) inherits puppet::params {
  
  $x_agent_hash               = hiera_hash('puppet::params::agent')
  $x_master_hash              = hiera_hash('puppet::params::master')
  $x_main_hash                = hiera_hash('puppet::params::main')
 
  # [main] section parameters
  $logdir                     =  $x_main_hash["logdir"]
  $rundir                     =  $x_main_hash["rundir"]
  $ssldir                     =  $x_main_hash["ssldir"]
  $disable_warnings           =  $x_main_hash["disable_warnings"]

  validate_absolute_path  ( $logdir     )
  validate_absolute_path  ( $rundir     )
  validate_absolute_path  ( $ssldir     )
  validate_string         ( $disable_warnings )
  
  # [agent] section parameters
  $certname 				          =  $x_agent_hash["certname"]
  $pluginsync 			          =  $x_agent_hash["pluginsync"]
  $configtimeout 		          =  $x_agent_hash["configtimeout"]
  $autoflush 				          =  $x_agent_hash["autoflush"]
  $splay 					            =  $x_agent_hash["splay"]
  $environment 			          =  $x_agent_hash["environment"]
  $listen 					          =  $x_agent_hash["listen"]
  $server 					          =  $x_agent_hash["server"]
  $disable_warnings           =  $x_agent_hash["disable_warnings"]

  validate_string         ( $certname      )
  validate_bool           ( $pluginsync    )
  validate_integer        ( $configtimeout )
  validate_bool           ( $autoflush     )
  validate_bool           ( $splay         )
  validate_bool           ( $listen        )
  validate_string         ( $environment   )
  validate_string         ( $server        )
  
  # [master] section parameters
  $modulepath               = $x_master_hash["modulepath"]
  $ssl_client_verify_header	= $x_master_hash["ssl_client_verify_header"]
  $pluginsync               = $x_master_hash["pluginsync"]
  $manifest                 = $x_master_hash["manifest"]
  $certname                 = $x_master_hash["certname"]
  $ssl_client_header        = $x_master_hash["ssl_client_header"]
  $filetimeout              = $x_master_hash["filetimeout"]
  $dns_alt_names            = $x_master_hash["dns_alt_names"]
  $autosign                 = $x_master_hash["autosign"]
  $environment              = $x_master_hash["environment"]

  validate_string           ( $modulepath                 )
  validate_string           ( $ssl_client_verify_header   )
  validate_bool             ( $pluginsync                 )
  validate_string           ( $manifest                   )
  validate_string           ( $certname                   )
  validate_string           ( $ssl_client_header          )
  validate_integer          ( $filetimeout                )
  validate_string           ( $dns_alt_names              )
  validate_bool             ( $autosign                   )
  validate_string           ( $environment                )

  # Initialize Module
  clabs::module::init { $name: }

}

