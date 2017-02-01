# vim: ts=2:et:sw=2:sts=2:fdm=marker:si
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
    ensure_packages( $pkg, { ensure => $version })
}

