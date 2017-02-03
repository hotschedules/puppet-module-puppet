# == Class puppet::params::puppetconf
class puppet::params::puppetconf {
  $enabled    = true

  $svc        = 'puppet'
  $pkg        = 'puppet'

  $version    = '3.8.7-1.el6'
  $user       = 'puppet'
  $group      = 'puppet'
  $configfile = '/etc/puppet/puppet.conf'

  $default_main_hash = {
    disable_warnings           => 'deprecations',
    logdir                     => '/var/log/puppet',
    rundir                     => '/var/run/puppet',
    ssldir                     => '$vardir/ssl',
  }

  $default_agent_hash = {
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

  $default_master_hash = {
    autosign                   => true,
    certname                   => $::servername,
    dns_alt_names              => 'puppet,dev-puppet-01',
    environment                => $::environment,
    filetimeout                => 1,
    manifest                   => '$confdir/environments/$environment/manifests',
    modulepath                 => '$confdir/environments/$environment/modules:$confdir/environments/$environment/dist',
    pluginsync                 => true,
    ssl_client_header          => 'SSL_CLIENT_S_DN',
    ssl_client_verify_header	 => 'SSL_CLIENT_VERIFY', 
  }
} 