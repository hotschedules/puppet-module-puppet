# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: puppet::config {
#
# Sets default puppet parameters
#
# PRIVATE CLASS: do not call directly
#
class puppet::config inherits puppet {

  if $::instance_role == 'puppet' {
    contain "puppet::master::config"
  } else {
   contain "puppet::agent::config"
  }
}
