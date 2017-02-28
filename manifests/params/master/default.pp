# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: puppet::params::agent::default {
#
# Sets default puppet parameters
#
# PRIVATE CLASS: do not call directly
#
class puppet::params::master::default {

  $master = {
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

  $r10k     = hiera_hash('puppet::master::r10k',          {})
  $remotes  = hiera_hash('puppet::master::r10k::remotes', {})
  $hiera    = hiera_hash('puppet::master::hiera',         {})

  $passenger = false

}
