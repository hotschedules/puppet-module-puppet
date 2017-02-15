# vim: ts=2:et:sw=2:sts=2:fdm=marker:si
#
# == Class: puppet::install
# ---
#
# Installs the Puppet Agent
#
class puppet::install inherits puppet {
    ensure_packages( $pkg, { ensure => $version })

  if %{::instance_role} == 'puppet' {
    ensure_packages( $masterpkg, {
      ensure => $version,
    })
  }
}

