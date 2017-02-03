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
  $agent_hash                 = getvar("::puppet::params::default::agent"),
  $configfile                 = getvar("::puppet::params::default::configfile"),
  $main_hash                  = getvar("::puppet::params::default::master"),
  $master_hash                = getvar("::puppet::params::default::master"),
  $pkg                        = getvar("::puppet::params::default::pkg"),
  $version                    = getvar("::puppet::params::default::version"),
) inherits puppet::params {

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
  validate_string         ( $x_main_hash["disable_warnings"]            )
  validate_absolute_path  ( $x_main_hash["logdir"]                      )
  validate_absolute_path  ( $x_main_hash["rundir"]                      )
  validate_string         ( $x_main_hash["ssldir"]                      )
  
  # [agent] section parameters
  validate_bool 				  ( $x_agent_hash["autoflush"]                  )
  validate_string 				( $x_agent_hash["certname"]                   )
  validate_integer 		    ( $x_agent_hash["configtimeout"]              )
  validate_string 			  ( $x_agent_hash["environment"]                )
  validate_bool 					( $x_agent_hash["listen"]                     )
  validate_bool 			    ( $x_agent_hash["pluginsync"]                 )
  validate_string 				( $x_agent_hash["server"]                     )
  validate_bool 					( $x_agent_hash["splay"]                      )
  
  # [master] section parameters
  validate_bool           ( $x_master_hash["autosign"]                  )
  validate_string         ( $x_master_hash["certname"]                  )
  validate_string         ( $x_master_hash["dns_alt_names"]             )
  validate_string         ( $x_master_hash["environment"]               )
  validate_integer        ( $x_master_hash["filetimeout"]               )
  validate_string         ( $x_master_hash["manifest"]                  )
  validate_string         ( $x_master_hash["modulepath"]                )
  validate_bool           ( $x_master_hash["pluginsync"]                )
  validate_string         ( $x_master_hash["ssl_client_header"]         )
  validate_string         ( $x_master_hash["ssl_client_verify_header"]  )

  class { '::puppet::install': } ->
  class { '::puppet::config': }

  contain 'puppet::install'
  contain 'puppet::config'

}
