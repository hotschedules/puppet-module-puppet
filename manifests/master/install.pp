# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker smartindent
#
# Puppet Master
#

class puppet::master::install inherits puppet::master {

  # r10k
  clabs::install { 'r10k': provider => 'gem' }

}

