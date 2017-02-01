# vim: ts=2:et:sw=2:sts=2:fdm=marker:si
#
# == Class: puppet
# ---
#
# Puppet Agent Default Parameters
#
class puppet::params {

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

