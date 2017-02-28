# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: puppet::agent::service
#
# Manages the Puppet Master service
#
# PRIVATE CLASS: do not call directly
#
class puppet::agent::service inherits puppet {
  service { $svc
    ensure     =>  $svcensure,
    enable     =>  $svcenable,
    hasrestart =>  true,
  }
}
