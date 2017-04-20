# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker smartindent
#
# == Class: puppet::params {
#
# Sets default parameters for puppet
#
# PRIVATE CLASS: do not call directly

class puppet::params {

  $configdir  = '/etc/puppet'
  $configfile = '/etc/puppet/puppet.conf'
  $group      = 'puppet'
  $user       = 'puppet'
  $version    = '3.8.7-1.el6'

  contain 'puppet::params::agent'
  contain 'puppet::params::master'
}
