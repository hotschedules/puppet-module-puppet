# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: puppet
#
# Full description of class puppet here.
#
# === Parameters
# ---
#

class puppet (
  $agent_hash                 = getvar("::puppet::params::puppetconf::default_agent_hash"),
  $configfile                 = getvar("::puppet::params::configfile")
  $main_hash                  = getvar("::puppet::params::puppetconf::main_agent_hash"),
  $master_hash                = getvar("::puppet::params::puppetconf::master_agent_hash"),
  $pkg                        = getvar("::puppet::params::puppetconf::pkg"),
  $version                    = getvar("::puppet::params::puppetconf::version"),
) inherits puppet::params {

)
  validate_absolute_path      ( $configfile )
  validate_string             ( $pkg )
  validate_string             ( $version )
  
  # Merge config hashes
  $x_agent_hash               = hiera_hash('puppet::params::agent', $agent_hash)
  $x_main_hash                = hiera_hash('puppet::params::main', $main_hash)
  $x_master_hash              = hiera_hash('puppet::params::master', $master_hash)
  $x_conf_hash = {
    agent     => $x_agent_hash,
    master    => $x_master_hash,
    main      => $x_main_hash
  }
 
  # [main] section parameters
  $disable_warnings           =  $x_main_hash["disable_warnings"]
  $logdir                     =  $x_main_hash["logdir"]
  $rundir                     =  $x_main_hash["rundir"]
  $ssldir                     =  $x_main_hash["ssldir"]

  validate_string         ( $disable_warnings )
  validate_absolute_path  ( $logdir     )
  validate_absolute_path  ( $rundir     )
  validate_string         ( $ssldir     )
  
  # [agent] section parameters
  $autoflush 				          =  $x_agent_hash["autoflush"]
  $certname 				          =  $x_agent_hash["certname"]
  $configtimeout 		          =  $x_agent_hash["configtimeout"]
  $environment 			          =  $x_agent_hash["environment"]
  $listen 					          =  $x_agent_hash["listen"]
  $pluginsync 			          =  $x_agent_hash["pluginsync"]
  $server 					          =  $x_agent_hash["server"]
  $splay 					            =  $x_agent_hash["splay"]

  validate_bool           ( $autoflush     )
  validate_string         ( $certname      )
  validate_integer        ( $configtimeout )
  validate_bool           ( $listen        )
  validate_bool           ( $pluginsync    )
  validate_string         ( $server        )
  validate_bool           ( $splay         )
  
  # [master] section parameters
  $autosign                 = $x_master_hash["autosign"]
  $mastercertname           = $x_master_hash["certname"]
  $dns_alt_names            = $x_master_hash["dns_alt_names"]
  $masterenvironment        = $x_master_hash["environment"]
  $filetimeout              = $x_master_hash["filetimeout"]
  $manifest                 = $x_master_hash["manifest"]
  $modulepath               = $x_master_hash["modulepath"]
  $masterpluginsync         = $x_master_hash["pluginsync"]
  $ssl_client_header        = $x_master_hash["ssl_client_header"]
  $ssl_client_verify_header	= $x_master_hash["ssl_client_verify_header"]

  validate_bool             ( $autosign                   )
  validate_string           ( $mastercertname             )
  validate_string           ( $dns_alt_names              )
  validate_string           ( $masterenvironment          )
  validate_integer          ( $filetimeout                )
  validate_string           ( $modulepath                 )
  validate_string           ( $manifest                   )
  validate_bool             ( $masterpluginsync           )
  validate_string           ( $ssl_client_header          )
  validate_string           ( $ssl_client_verify_header   )

  class { '::puppet::install': } ->
  class { '::puppet::config': }

  contain 'puppet::install'
  contain 'puppet::config'

}
