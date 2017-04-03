# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker smartindent
#
# == Class: puppet::params {
#
# Sets default parameters for puppet
#
# PRIVATE CLASS: do not call directly
class puppet::params {
  if $::instance_role != 'puppet' {
    contain 'puppet::params::agent::default'
  }

  if $::instance_role == 'puppet' {
    contain 'puppet::params::master::default'
  }
}

