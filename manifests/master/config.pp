# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: puppet::params::agent::default {
#
# Sets default puppet parameters
#
# PRIVATE CLASS: do not call directly
#
class puppet::master::config inherits puppet {

  define puppetmasterconf(
    $agent          = undef,
    $content        = template('puppet/etc/puppet/puppet.conf.erb'),
    $ensure         = "file",
    $group          = $group,
    $main           = undef,
    $master         = undef,
    $mode           = '0660',
    $owner          = $user,
    $mastersvcname        = 'puppet'
  ) {
    file { "/etc/puppet/puppet.conf":
      content       => $content,
      ensure        => $ensure,
      group         => $group,
      mode          => $mode,
      owner         => $owner,
      notify        => Service[$mastersvcname]
    }
  }

  # Create Puppet agent configuration
  create_resources(puppetmasterconf, $x_conf_hash)

}
