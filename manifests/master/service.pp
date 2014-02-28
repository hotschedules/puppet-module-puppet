# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker smartindent
#
# Puppet
#

class puppet::master::service inherits puppet::master {

  service {
    $svc:
      enable    => $enabled,
      ensure    => $enabled,
      subscribe => Clabs::Template['/etc/puppet/puppet.conf'],
  }

}

