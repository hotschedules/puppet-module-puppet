# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker smartindent
#
# == Class: puppet::master::install
#
# Installs puppetmaster 
#
# PRIVATE CLASS: do not call directly

class puppet::master::install(

  $pkg      = $::puppet::master::pkg,
  $version  = $::puppet::master::version,

) {

  ensure_packages( $pkg, {
    ensure => $version,
  })

}
