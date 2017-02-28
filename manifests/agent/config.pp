# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: puppet::params::agent::default {
#
# Sets default puppet parameters
#
# PRIVATE CLASS: do not call directly
#
class puppet::agent::config inherits puppet {

  define puppetagentconf(
    $agent          = undef,
    $content        = template('puppet/etc/puppet/puppet.conf.erb'),
    $ensure         = "file",
    $group          = $group,
    $main           = undef,
    $master         = undef,
    $mode           = '0660',
    $owner          = $user,
    $svcname        = 'puppet'
  ) {
    file { "/etc/puppet/puppet.conf":
      content       => $content,
      ensure        => $ensure,
      group         => $group,
      mode          => $mode,
      owner         => $owner,
      notify        => Service[$svcname]
    }
  }

  # Create Puppet agent configuration
  create_resources(puppetagentconf, $x_conf_hash)

}

