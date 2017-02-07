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
  $main_hash                  = getvar("::puppet::params::default::main"),
  $master_hash                = getvar("::puppet::params::default::master"),
  $pkg                        = getvar("::puppet::params::default::pkg"),
  $version                    = getvar("::puppet::params::default::version"),
  $agent_defaults             = getvar("::puppet::params::default::agent_defaults"),
) inherits puppet::params {

  validate_absolute_path      ( $configfile )
  validate_string             ( $pkg )
  validate_string             ( $version )
  validate_hash               ( $agent_defaults )
  
  # Merge config hashes
  $x_conf_hash = {
    agent         => hiera_hash('puppet::params::agent',   $agent_hash),
    main          => hiera_hash('puppet::params::main',    $main_hash),
    master        => hiera_hash('puppet::params::master',  $master_hash),
  }
 
  # [main] section parameters
  validate_string         ( $x_conf_hash['main']["disable_warnings"]            )
  validate_absolute_path  ( $x_conf_hash['main']["logdir"]                      )
  validate_absolute_path  ( $x_conf_hash['main']["rundir"]                      )
  validate_string         ( $x_conf_hash['main']["ssldir"]                      )
  
  # [agent] section parameters
  validate_bool 				  ( $x_conf_hash['agent']["autoflush"]                  )
  validate_string 				( $x_conf_hash['agent']["certname"]                   )
  validate_integer 		    ( $x_conf_hash['agent']["configtimeout"]              )
  validate_string         ( $x_conf_hash['agent']["disable_warnings"]           )
  validate_string 			  ( $x_conf_hash['agent']["environment"]                )
  validate_bool 					( $x_conf_hash['agent']["listen"]                     )
  validate_bool 			    ( $x_conf_hash['agent']["pluginsync"]                 )
  validate_string 				( $x_conf_hash['agent']["server"]                     )
  validate_bool 					( $x_conf_hash['agent']["splay"]                      )
  
  # [master] section parameters
  validate_bool           ( $x_conf_hash['master']["autosign"]                  )
  validate_string         ( $x_conf_hash['master']["certname"]                  )
  validate_string         ( $x_conf_hash['master']["dns_alt_names"]             )
  validate_string         ( $x_conf_hash['master']["environment"]               )
  validate_integer        ( $x_conf_hash['master']["filetimeout"]               )
  validate_string         ( $x_conf_hash['master']["manifest"]                  )
  validate_string         ( $x_conf_hash['master']["modulepath"]                )
  validate_bool           ( $x_conf_hash['master']["pluginsync"]                )
  validate_string         ( $x_conf_hash['master']["ssl_client_header"]         )
  validate_string         ( $x_conf_hash['master']["ssl_client_verify_header"]  )

  class { '::puppet::install': } ->
  class { '::puppet::config': }

  contain 'puppet::install'
  contain 'puppet::config'

}
