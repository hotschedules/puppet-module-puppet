# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker smartindent
#
# == Class: puppet::params::main {
#
# Sets default puppet parameters for agent
#
# PRIVATE CLASS: do not call directly
#
class puppet::params::main {
  $main = {
    disable_warnings  => 'deprecations',
    logdir            => '/var/log/puppet',
    rundir            => '/var/run/puppet',
    ssldir            => '$vardir/ssl',
  }
}
