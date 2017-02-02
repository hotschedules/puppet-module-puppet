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
    $logdir                     => '/var/log/puppet',
    $rundir                     => '/var/run/puppet',
    $ssldir                     => '$vardir/ssl',
    $disable_warnings           => 'deprecations'
  }

  $default_agent_hash = {
    $certname 				          => $::fqdn,
    $pluginsync 			          => true,
    $configtimeout 		          => 3600,
    $autoflush 				          => true,
    $splay 					            => true
    $environment 			          => $::environment,
    $listen 					          => false,
    $server 					          => $::servername,
    $disable_warnings           => 'deprecations'
  }

  $default_master_hash = {
    $modulepath                 => '$confdir/environments/$environment/modules:$confdir/environments/$environment/dist',
    $ssl_client_verify_header	  => 'SSL_CLIENT_VERIFY', 
    $pluginsync                 => true,
    $manifest                   => '$confdir/environments/$environment/manifests',
    $certname                   => $::servername,
    $ssl_client_header          => 'SSL_CLIENT_S_DN'
    $filetimeout                => 1,
    $dns_alt_names              => 'puppet,dev-puppet-01',
    $autosign                   => true,
    $environment                => $::environment,
  }
} 
