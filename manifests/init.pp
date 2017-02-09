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

  $agent_hash     = getvar("::puppet::params::default::agent"),
  $hieramerge     = false,
  $main_hash      = getvar("::puppet::params::default::main"),
  $master_hash    = getvar("::puppet::params::default::master"),
  $pkg            = getvar("::puppet::params::default::pkg"),
  $version        = getvar("::puppet::params::default::version"),
  $svcensure      = getvar("::puppet::params::default::svcensure"),
  $svcenable      = getvar("::puppet::params::default::svcenable"),
  $svcname        = getvar("::puppet::params::default::svcname"),

) inherits puppet::params {

  validate_bool             ( $hieramerge     )
  validate_string           ( $pkg            )
  validate_string           ( $version        )
  validate_bool             ( $svcenable      )
  validate_string           ( $svcname        )
  validate_bool             ( $svcensure      )
  
  # Merge config hashes
  if $hieramerge {
    $x_agent  = hiera_hash('puppet::agent',  $agent_hash)
    $x_main   = hiera_hash('puppet::main',   $main_hash)
    $x_master = hiera_hash('puppet::master', $master_hash)
  } else {
    $x_agent  = $agent_hash
    $x_main   = $main_hash
    $x_master = $master_hash
  }

  
  # [agent] section parameters
  validate_bool 				  ( $x_agent["autoflush"]                  )
  validate_string 				( $x_agent["certname"]                   )
  validate_integer 		    ( $x_agent["configtimeout"]              )
  validate_string         ( $x_agent["disable_warnings"]           )
  validate_string 			  ( $x_agent["environment"]                )
  validate_bool 					( $x_agent["listen"]                     )
  validate_bool 			    ( $x_agent["pluginsync"]                 )
  validate_string 				( $x_agent["server"]                     )
  validate_bool 					( $x_agent["splay"]                      )

  # [main] section parameters
  validate_string         ( $x_main["disable_warnings"]            )
  validate_absolute_path  ( $x_main["logdir"]                      )
  validate_absolute_path  ( $x_main["rundir"]                      )
  validate_string         ( $x_main["ssldir"]                      )
  
  # [master] section parameters
  validate_bool           ( $x_master["autosign"]                  )
  validate_string         ( $x_master["certname"]                  )
  validate_string         ( $x_master["dns_alt_names"]             )
  validate_string         ( $x_master["environment"]               )
  validate_integer        ( $x_master["filetimeout"]               )
  validate_string         ( $x_master["manifest"]                  )
  validate_string         ( $x_master["modulepath"]                )
  validate_bool           ( $x_master["pluginsync"]                )
  validate_string         ( $x_master["ssl_client_header"]         )
  validate_string         ( $x_master["ssl_client_verify_header"]  )

  $x_conf_hash = {
    agentconf => {
        main    => $x_main,
        agent   => $x_agent,
        master  => $x_master,
    },
  }

  class { '::puppet::install': } ->
  class { '::puppet::config':  } ~>
  class { '::puppet::service': }

  contain 'puppet::install'
  contain 'puppet::config'
  contain 'puppet::service'

}
