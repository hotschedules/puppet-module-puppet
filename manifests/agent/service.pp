# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker smartindent
#
# == Class: puppet::agent::service
#
# Manages the Puppet Master service
#
# PRIVATE CLASS: do not call directly
#
class puppet::agent::service inherits puppet {
  service { '$agentsvcname':
    ensure     => $agentsvcensure,
    enable     => $agentsvcenable,
    hasrestart => true,
  }
}
