# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: puppet::master::service
#
# Manages the Puppet service
#
# PRIVATE CLASS: do not call directly
#
class puppet::master::service inherits puppet {

service { $mastersvcname:
    ensure      => $mastersvcensure,
    enable      => $mastersvcenable,
    hasrestart  => true,
  }
}
