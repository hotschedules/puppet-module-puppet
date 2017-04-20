# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker smartindent
#
# == Class: puppet::params::agent {
#
# Sets default puppet parameters for agent
#
# PRIVATE CLASS: do not call directly
#
class puppet::params::agent {

  $pkg        = 'puppet'
  $svcenable  = true
  $svcensure  = true
  $svcname    = 'puppet'

  $agent = {
    autoflush         => true,
    certname          => $::fqdn,
    configtimeout     => 3600,
    disable_warnings  => 'deprecations',
    environment       => $::environment,
    listen            => false,
    pluginsync        => true,
    server            => $::servername,
    splay             => true,
  }

  $main = {
    disable_warnings  => 'deprecations',
    logdir            => '/var/log/puppet',
    rundir            => '/var/run/puppet',
    ssldir            => '$vardir/ssl',
  }
}
