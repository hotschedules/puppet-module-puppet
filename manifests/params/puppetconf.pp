# == Class puppet::params::puppetconf
class puppet::params::puppetconf {
  $enabled    = true

  $svc        = 'puppet'
  $pkg        = 'puppet'

  $version    = '3.8.7-1.el6'
  $user       = 'puppet'
  $group      = 'puppet'

  $configfile = '/etc/puppet/puppet.conf'

  # NOTE: hiera_hash does not work as expected in a parameterized class
  #   definition; so we call it here.
  #
  # http://docs.puppetlabs.com/hiera/1/puppet.html#limitations
  # https://tickets.puppetlabs.com/browse/HI-118
  #
  $settings = hiera_hash('puppet::settings', {})

  $defaults   = $::puppet::defaults,
  $settings   = $::puppet::settings,
  $user       = $::puppet::user,
  $group      = $::puppet::group,
  $configfile = $::puppet::configfile,



  # -- $defaults ----------------------------------------------------------- {{{
  #
  $defaults = {
    'listen'        => false,
    'pluginsync'    => true,
    'autoflush'     => true,
    'environment'   => $::environment,
    'certname'      => $::fqdn,
    'server'        => $::servername,
    'configtimeout' => 300,
  }
  #
  # ------------------------------------------------------------------------ }}}


} 
