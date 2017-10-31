# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker smartindent
#
# == Class: puppet::master::service
#
# Manages the Puppet Master service
#
# PRIVATE CLASS: do not call directly
#
class puppet::master::service inherits puppet {

  service { 'puppetmaster':
    ensure => 'stopped',
    enable => false,
  }

  service { $agentsvcname:
    ensure     => $agentsvcensure,
    enable     => $agentsvcenable,
    hasrestart => true,
  }

}
