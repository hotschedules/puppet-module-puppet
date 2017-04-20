# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker smartindent
#
# == Class: puppet::agent::install
#
# Installs puppet agent 
#
# PRIVATE CLASS: do not call directly

class puppet::agent::install(

  $pkg      = $::puppet::params::agent::pkg,
  $version  = $::puppet::params::agent::version,

) {

  ensure_packages( $pkg, {
    ensure => $version,
  })

}
