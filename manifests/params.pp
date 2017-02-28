# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: puppet::master::install
#
# Installs puppetmaster 
#
# PRIVATE CLASS: do not call directly
class puppet::params {
  contain "puppet::params::agent::default"

  if $::instance_role == 'puppet' {
    contain "puppet::params::master::default"
  }
}

