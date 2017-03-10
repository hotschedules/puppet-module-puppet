# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker smartindent
#
# == Class: puppet::params::agent::default {
#
# Sets default puppet parameters
#
# PRIVATE CLASS: do not call directly
#
class puppet::agent::config inherits puppet {

  define puppetagentconf(
    $agent          = $x_agent_hash,
    $content        = $content,
    $ensure         = "file",
    $group          = $group,
    $main           = $x_main_hash,
    $master         = $x_master_hash,
    $mode           = '0660',
    $owner          = $user,
  ) {
    file { "/etc/puppet/puppet.conf":
      content       => $content,
      ensure        => $ensure,
      group         => $group,
      mode          => $mode,
      owner         => $owner,
      notify        => Service['puppet']
    }
  }

  # Create Puppet agent configuration
  unless $::instance_role == 'puppet' {
    create_resources(puppetagentconf, {})
  }

}

