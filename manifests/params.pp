# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker smartindent
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

  $version    = $::osfamily ? {
    'RedHat'  => '3.4.3-1.el6',
    'windows' => '3.4.3',
    default   => undef,
  }

  $user       = $::kernel ? {
    'Linux'   => 'puppet',
    'windows' => 'SYSTEM',
    default   => undef,
  }

  $group      = $::kernel ? {
    'Linux'   => 'puppet',
    'windows' => 'Administrators',
    default   => undef,
  }

  $configfile = $::kernel ? {
    'Linux'   => '/etc/puppet/puppet.conf',
    'windows' => 'C:/ProgramData/PuppetLabs/puppet/etc/puppet.conf',
    default => undef,
  }

  # NOTE: hiera_hash does not work as expected in a parameterized class
  #   definition; so we call it here.
  #
  # http://docs.puppetlabs.com/hiera/1/puppet.html#limitations
  # https://tickets.puppetlabs.com/browse/HI-118
  #
  $settings = hiera_hash('puppet::settings', {})


  # -- $defaults ----------------------------------------------------------- {{{
  #
  $i_defaults = {
    'listen'        => false,
    'pluginsync'    => true,
    'autoflush'     => true,
    'environment'   => $::environment,
    'certname'      => $::fqdn,
    'server'        => $::servername,
    'configtimeout' => 300,
  }

  # Legacy puppet
  if versioncmp($::puppetversion,'3.6') == -1 {

    $defaults = merge($i_defaults, {
      'modulepath'    =>  $::kernel ? {
        'Linux'   => '/etc/puppet/modules:/usr/share/puppet/modules',
        'windows' => 'C:/ProgramData/PuppetLabs/puppet/etc/modules;C:/usr/share/puppet/modules',
        default   => undef,
      },
    })

  } else {
    $defaults = $i_defaults
  }
  #
  # ------------------------------------------------------------------------ }}}

}

