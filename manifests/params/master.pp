# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker smartindent
#
# == Class: puppet::params::master {
#
# Sets default puppet master parameters
#
# PRIVATE CLASS: do not call directly
#
class puppet::params::master {

  $passenger      = true
  $master         = {
    autosign                  => true,
    certname                  => $::servername,
    dns_alt_names             => 'puppet,dev-puppet-01',
    environment               => $::environment,
    filetimeout               => 1,
    manifest                  => '$confdir/environments/$environment/manifests',
    modulepath                => '$confdir/environments/$environment/modules:$confdir/environments/$environment/dist',
    pluginsync                => true,
    ssl_client_header         => 'SSL_CLIENT_S_DN',
    ssl_client_verify_header  => 'SSL_CLIENT_VERIFY',
  }
  $pkg        = "puppet-server"
  $r10k       = {
    'enabled'                 => true,
    'usessh'                  => true,
    'autoupdate'              => true,
    'timestamp'               => false,
    'timestampcmd'            => 'echo `date +\%Y-\%m-\%d-\%H:\%M:\%S` >> /var/log/r10k.log',
    'updatecmd'               => "r10k deploy environment ${::environment} -v -t >> /var/log/r10k.log 2>&1",
    'cronuser'                => 'puppet',
    'interval'                => '*/1',
    'configfile'              => '/etc/r10k.yaml',
    'cachedir'                => '/var/cache/r10k',
    'basedir'                 => "/etc/puppet/environments"
  }
  $ssldir     = '/var/lib/puppet/ssl'
  $svc        = 'httpd'
  $svcenable  = true
  $svcensure  = true
  $svcname    = 'puppet'
  $user       = 'puppet'
  $version    = '3.8.7-1.el6' 

}
