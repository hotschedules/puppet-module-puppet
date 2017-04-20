# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker smartindent
#
# == Define: puppet::master::config::passenger
# ---
#
# Configures puppet passenger
#
# NOTE: internal use only
#
# === Parameters
# ---
#
# [*name*]
# - Type - string
# - Puppet master configuration setting
#
class puppet::master::config::passenger(

  $passenger  = $passenger,
  $user       = $user,
  $group      = $group,
  $configdir  = $configdir,
  $vardir     = '/var/lib/puppet',

  $defaults = {
    'debug'         => false,
    'port'          => 8140,
    'rackroot'      => "${configdir}/rack",
    'ssldir'        => '/var/lib/puppet/ssl',
    'certname'      => $::fqdn,
    'serveradmin'   => 'root',
  }

) inherits puppet {

  if is_hash($passenger) {
    $mergedsettings = merge($defaults, $passenger)
  } else {
    $mergedsettings = $defaults
  }

  $debug          = $mergedsettings['debug']
  $port           = $mergedsettings['port']
  $rackroot       = $mergedsettings['rackroot']
  $ssldir         = $mergedsettings['ssldir']
  $certname       = $mergedsettings['certname']
  $serveradmin    = $mergedsettings['serveradmin']

  contain apache
  contain apache::mod::passenger
  contain apache::mod::ssl

  file { [
      $rackroot,
      "${rackroot}/public",
    ]:
      ensure => directory,
      owner  => $user,
      group  => $group,
      mode   => '0755',
  }

  file { "${rackroot}/config.ru":
    ensure  => 'present',
    owner   => $user,
    group   => $group,
    content => template('puppet/etc/puppet/rack/config.ru.erb'),
    mode    => '0644',
    require => File[$rackroot],
  }

  apache::vhost { "puppet-${certname}":
    port               => $port,
    priority           => '40',
    docroot            => "${rackroot}/public",
    serveradmin        => $serveradmin,
    servername         => $certname,
    ssl                => true,
    ssl_cert           => "${ssldir}/certs/${certname}.pem",
    ssl_key            => "${ssldir}/private_keys/${certname}.pem",
    ssl_chain          => "${ssldir}/ca/ca_crt.pem",
    ssl_ca             => "${ssldir}/ca/ca_crt.pem",
    ssl_crl            => "${ssldir}/ca/ca_crl.pem",
    rack_base_uris     => '/',
    custom_fragment    => template('puppet/apache_passenger_fragment.erb'),
    require            => [
      File["${rackroot}/config.ru"],
      File["${rackroot}/public"],
    ],
  }
}

