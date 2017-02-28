# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker smartindent
#
# == Class: puppet::master::hiera
# ---
#
# Manages the Puppet Master Hiera configuration
#
# === Parameters
# ---
#
# [*defaults*]
# - NOTE - Use puppet::master::hiera via Hiera to override any defaults
# - Type - Hash
# - Default
#   {
#     'configfile'  => '/etc/puppet/hiera.yaml',
#   }
#
#
class puppet::master::hiera(

  $defaults = {
    'configfile'  => "${::puppet::master::configdir}/hiera.yaml",
  },

  $user     = $::puppet::master::user,
  $hiera    = $::puppet::master::hiera,

) inherits puppet::master {

  $mergedsettings = merge($defaults, $::puppet::master::r10k, $::puppet::master::hiera)

  $configfile   = $mergedsettings['configfile']
  $datasources  = $mergedsettings['datasources']
  $remotes      = $mergedsettings['remotes']

  validate_absolute_path  ( $configfile  )
  validate_array          ( $datasources )
  validate_hash           ( $remotes     )

  clabs::template {
    $configfile:
      owner   => $user,
      group   => 'adm',
      mode    => '0440',  # secure (may contain passwords)
      notify  => Class['::puppet::master::service'],
  }

  clabs::link {
    '/etc/hiera.yaml':
      target  => $mergedsettings['configfile'],
      force   => true,
  }

}
