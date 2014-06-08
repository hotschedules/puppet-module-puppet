# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker smartindent
#
# == Class: puppet::install
# ---
#
# Installs the Puppet Agent
#
class puppet::install(

  $pkg      = $::puppet::pkg,
  $version  = $::puppet::version,

) {

  # Workaround for chocolatey based package installation not honoring version
  # lock
  if $::kernel != 'windows' {
    ensure_resource('clabs::install', $pkg, {
      ensure => $version,
    })
  }

}

