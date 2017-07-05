# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker smartindent
#
# == Class: puppet::master::config::hiera
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
class puppet::master::config::hiera(

  $defaults = { 'configfile'  => "${configdir}/hiera.yaml" },

) inherits puppet {

  $mergedsettings = merge($defaults, $r10ksettings, $hierasettings )

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
      notify  => Service[$mastersvcname]
  }

  clabs::link {
    '/etc/hiera.yaml':
      target  => $mergedsettings['configfile'],
      force   => true,
  }

}
