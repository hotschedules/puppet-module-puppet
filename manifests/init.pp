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

  $agent_hash      = getvar("::puppet::params::default::agent"),
  $agentsvcenable  = getvar("::puppet::params::default::agentsvcenable"),
  $agentsvcensure  = getvar("::puppet::params::default::agentsvcensure"),
  $agentsvcname    = getvar("::puppet::params::default::agentsvcname"),
  $hieramerge      = getvar("::puppet::params::default::hieramerge"),,
  $main_hash       = getvar("::puppet::params::default::main"),
  $master_hash     = getvar("::puppet::params::default::master"),
  $mastersvcenable = getvar("::puppet::params::default::mastersvcenable"),
  $mastersvcensure = getvar("::puppet::params::default::mastersvcensure"),
  $mastersvcname   = getvar("::puppet::params::default::mastersvcname"),
  $pkg             = getvar("::puppet::params::default::masterpkg"),
  $version         = getvar("::puppet::params::default::version"),

) inherits puppet::params {

  validate_bool             ( $hieramerge     )
  validate_string           ( $agentpkg            )
  validate_string           ( $version        )
  validate_bool             ( $agentsvcenable      )
  validate_string           ( $agentsvcname        )
  validate_bool             ( $agentsvcensure      )

  if %{::instance_role} == 'puppet' {
    validate_string           ( $masterpkg            )
    validate_bool             ( $mastersvcenable      )
    validate_string           ( $mastersvcname        )
    validate_bool             ( $mastersvcensure      )
  }
  
  # Merge config hashes
  if $hieramerge {
    $x_agent  = hiera_hash('puppet::agent',  $agent_hash)
    $x_main   = hiera_hash('puppet::main',   $main_hash)
    if %{::instance_role} == 'puppet' {
      $x_master = hiera_hash('puppet::master', $master_hash)
    }
  } else {
    $x_agent  = $agent_hash
    $x_main   = $main_hash
    if %{::instance_role} == 'puppet' {
      $x_master = $master_hash
    }
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
  
  if %{::instance_role} == 'puppet' {
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
  }


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

  if %{::instance_role} == 'puppet' {
    contain "${name}::r10k"
    contain "${name}::hiera"
    if $passenger {
      contain "${name}::passenger"
    }
  }
}
