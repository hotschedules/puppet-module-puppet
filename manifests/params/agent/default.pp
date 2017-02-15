# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: puppet::params::default {
#
# Sets default puppet parameters
#
# PRIVATE CLASS: do not call directly
#
class puppet::params::agent::default {

  $content         = template('puppet/etc/puppet/puppet.conf.erb') 
  $group           = 'puppet'
  $agentpkg        = 'puppet'
  $agentsvcname    = 'puppet'
  $agentsvcensure  = true
  $agentsvcenable  = true
  $user       = 'puppet'
  $version    = '3.8.7-1.el6'

  $main = {
    disable_warnings           => 'deprecations',
    logdir                     => '/var/log/puppet',
    rundir                     => '/var/run/puppet',
    ssldir                     => '$vardir/ssl',
  }

  $agent = {
    autoflush 				         => true,
    certname 				           => $::fqdn,
    configtimeout 		         => 3600,
    disable_warnings           => 'deprecations',
    environment 			         => $::environment,
    listen 					           => false,
    pluginsync 			           => true,
    server 					           => $::servername,
    splay 					           => true,
  }

} 
