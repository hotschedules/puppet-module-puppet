# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker smartindent
#
# Puppet
#

class puppet::master::config inherits puppet::master {

  clabs::config { '/etc/puppet/hiera.yaml': notify => Service[$svc] }

}

