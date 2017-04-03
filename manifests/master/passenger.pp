# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker smartindent
#
# == Define: puppet::master::passenger
# ---
#
# Configures puppetmaster passenger
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
class puppet::master::passenger(

  $passenger  = $::puppet::master::passenger,
  $user       = $::puppet::master::user,
  $group      = $::puppet::master::group,
  $configdir  = $::puppet::master::configdir,
  $vardir     = $::puppet::master::vardir,

  $defaults = {
    'debug'         => false,
    'port'          => 8140,
    'rackroot'      => "${::puppet::master::configdir}/rack",
    'ssldir'        => "${::puppet::master::vardir}/ssl",
    'certname'      => $::fqdn,
    'serveradmin'   => 'root',
  }

) inherits puppetmaster {

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
    content => template('puppetmaster/etc/puppet/rack/config.ru.erb'),
    mode    => '0644',
    require => File[$rackroot],
  }

  apache::vhost { "puppet-${certname}":
    port            => $port,
    priority        => '40',
    docroot         => "${rackroot}/public",
    serveradmin     => $serveradmin,
    servername      => $certname,
    ssl             => true,
    ssl_cert        => "${ssldir}/certs/${certname}.pem",
    ssl_key         => "${ssldir}/private_keys/${certname}.pem",
    ssl_chain       => "${ssldir}/ca/ca_crt.pem",
    ssl_ca          => "${ssldir}/ca/ca_crt.pem",
    ssl_crl         => "${ssldir}/ca/ca_crl.pem",
    rack_base_uris  => '/',
    custom_fragment => template('puppetmaster/apache_passenger_fragment.erb'),
    require         => [
      File["${rackroot}/config.ru"],
      File["${rackroot}/public"],
    ],
  }

  ensure_resource('ini_setting', 'puppet-master-sslclient',
    {
      'ensure'  => 'present',
      'setting' => 'ssl_client_header',
      'value'   => 'SSL_CLIENT_S_DN',
      'path'    => "${::puppet::master::configdir}/puppet.conf",
      'section' => 'master',
      'notify'  => Service[$::apache::service_name],
    }
  )

  ensure_resource('ini_setting', 'puppet-master-sslclientverify',
    {
      'ensure'  => 'present',
      'setting' => 'ssl_client_verify_header',
      'value'   => 'SSL_CLIENT_VERIFY',
      'path'    => "${::puppet::master::configdir}/puppet.conf",
      'section' => 'master',
      'notify'  => Service[$::apache::service_name],
    }
  )

}
