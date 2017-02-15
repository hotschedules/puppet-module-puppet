# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: fluentd::params::redhat
#
# Sets default {fluentd}[http://fluentd.org/] parameters for the RedHat OS family
#
# PRIVATE CLASS: do not call directly

class puppet::install inherits puppet {
    ensure_packages( $pkg, { ensure => $version })

  if %{::instance_role} == 'puppet' {
    ensure_packages( $masterpkg, {
      ensure => $version,
    })
  }
}

