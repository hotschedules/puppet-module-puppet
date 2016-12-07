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
# - Default - 3.4.3 (OS specific)
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

  $enabled    = $::puppet::params::enabled,
  $svc        = $::puppet::params::svc,
  $pkg        = $::puppet::params::pkg,
  $version    = $::puppet::params::version,
  $user       = $::puppet::params::user,
  $group      = $::puppet::params::group,
  $configfile = $::puppet::params::configfile,
  $settings   = $::puppet::params::settings,
  $defaults   = $::puppet::params::defaults,

) inherits puppet::params {

  validate_bool           ( $enabled    )
  validate_string         ( $svc        )
  validate_string         ( $pkg        )
  validate_string         ( $version    )
  validate_string         ( $user       )
  validate_string         ( $group      )
  validate_absolute_path  ( $configfile )
  validate_hash           ( $settings   )
  validate_hash           ( $defaults   )
  notify { "Puppet version name: ${version}": loglevel => debug }

  # Initialize Module
  clabs::module::init { $name: }

}

