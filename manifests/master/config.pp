# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker smartindent
#
# == Class: puppet::master::config {
#
# Sets default puppet parameters
#
# PRIVATE CLASS: do not call directly
#
class puppet::master::config inherits puppet {

  
  file { "$configdir/puppet.conf":
    ensure  => $ensure,
    content => template("puppet/etc/puppet/puppet.conf.erb"),
    group   => $group,
    mode    => $mode,
    owner   => $owner,
    notify  => [Service[$agentsvcname],Service[$mastersvcname]]
  }

  contain 'puppet::master::config::hiera'

  if $r10k {
    contain 'puppet::master::config::r10k'
  }

  if $passenger {
    contain 'puppet::master::config::passenger'
  }



}

