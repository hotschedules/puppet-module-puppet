# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker smartindent
#
# == Class: puppet::install
# ---
#
# Installs the Puppet Agent
#
class puppet::install inherits puppet {

  ensure_resource('clabs::install', $pkg, {
    ensure => $version,
  })

}

