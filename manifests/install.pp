# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: puppet::install {
#
# Installs puppet packages
#
# PRIVATE CLASS: do not call directly
#

class puppet::install inherits puppet {
  contain "puppet::agent::install"

  if $::instance_role == 'puppet' {
    contain "puppet::master::install"
  }
}
