# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: puppet::service
#
# Manages the Puppet service
#
# PRIVATE CLASS: do not call directly
#
class puppet::service inherits puppet {
  contain "puppet::agent::config"

  if $::instance_role == 'puppet' {
    contain "puppet::params::master::default"
  }

  contain "puppet::master::config"
}
