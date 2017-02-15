# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: puppet::service
#
# Manages the Puppet service
#
# PRIVATE CLASS: do not call directly
#
class puppet::service inherits puppet {

  service { $svcname:
    ensure      => $svcensure,
    enable      => $svcenable,
    hasrestart  => true,
  }

  if %{::instance_role} == 'puppet' {
    service { $mastersvc:
    
    }


}
