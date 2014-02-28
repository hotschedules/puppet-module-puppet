# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker smartindent
#
# Puppet
#

class puppet::config inherits puppet {

  clabs::template { $config: notify => Service[$svc] }

}

