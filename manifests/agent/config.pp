# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker smartindent
#
# == Class: puppet::agent::config {
#
# Sets default puppet parameters
#
# PRIVATE CLASS: do not call directly
#
class puppet::agent::config inherits puppet {

  file { "$configdir/puppet.conf":
    ensure  => $ensure,
    content => template("puppet/etc/puppet/puppet.conf.erb"),
    group   => $group,
    mode    => $mode,
    owner   => $owner,
    notify  => Service['$agentsvcname']
  }
}

