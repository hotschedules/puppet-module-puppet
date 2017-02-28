# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: puppet::service
#
# Manages the Puppet service
#
# PRIVATE CLASS: do not call directly
#

  if %{::instance_role} == 'puppet' {
    service { $mastersvc:
      ensure      => $mastersvcensure, 
      enable      => $mastersvcenable,
      hasrestart  => true,
    }
  }

