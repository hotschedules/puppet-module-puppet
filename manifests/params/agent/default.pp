# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker smartindent
#
# == Class: puppet::params::agent::default {
#
# Sets default puppet parameters for agent:w

#
# PRIVATE CLASS: do not call directly
#
class puppet::params::agent::default {

  $content    = template('puppet/etc/puppet/puppet.conf.erb') 
  $group      = 'puppet'
  $hieramerge = true
  $pkg        = 'puppet'
  $svcenable  = true
  $svcensure  = true
  $svcname    = 'puppet'
  $user       = 'puppeti'
  $version    = '3.8.7-1.el6'

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

  $main = {
    disable_warnings           => 'deprecations',
    logdir                     => '/var/log/puppet',
    rundir                     => '/var/run/puppet',
    ssldir                     => '$vardir/ssl',
  }
}
