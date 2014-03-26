# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker smartindent
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
# [*packages*]
# - Type - Array
# - Default
#   [
#    'puppet',
#   ]
# - Agent package installation list
#
# [*configfile*]
# - Type - String
# - Default - OS Specific
# - Agent configuration file location (absolute path)
#
# [*settings*]
# - Type - Hash (Hiera only parameter)
# - Default - NONE
# - Agent puppet configuration file settings
#
class puppet (
  $enabled    = true,
  $svc        = 'puppet',

  $user       = $::kernel ? {
    'Linux'   => 'puppet',
    'windows' => 'SYSTEM',
    default   => undef,
  },

  $group      = $::kernel ? {
    'Linux'   => 'puppet',
    'windows' => 'Administrators',
    default   => undef,
  },

  $packages   = [
    'puppet',
  ],

  $configfile = $::kernel ? {
    'Linux'   => '/etc/puppet/puppet.conf',
    'windows' => 'C:/ProgramData/PuppetLabs/puppet/etc/puppet.conf',
    default => undef,
  },

) {

  validate_bool           ( $enabled    )
  validate_string         ( $svc        )
  validate_string         ( $user       )
  validate_string         ( $group      )
  validate_array          ( $packages   )
  validate_absolute_path  ( $configfile )

  # NOTE: hiera_hash does not work as expected in a parameterized class
  #   definition; so we call it here.
  #
  # http://docs.puppetlabs.com/hiera/1/puppet.html#limitations
  # https://tickets.puppetlabs.com/browse/HI-118
  #
  $settings = hiera_hash('puppet::settings', {})


  # Initialize Module
  clabs::module::init { $name: }

}

