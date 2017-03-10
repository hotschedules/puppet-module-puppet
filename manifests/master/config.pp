# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker smartindent
#
# == Class: puppet::params::agent::default {
#
# Sets default puppet parameters
#
# PRIVATE CLASS: do not call directly
#
class puppet::master::config inherits puppet {

  define puppetmasterconf(
    $agent          = $x_agent_hash,
    $content        = template('puppet/etc/puppet/puppet.conf.erb'),
    $ensure         = "file",
    $group          = $group,
    $main           = $x_main_hash,
    $master         = $x_master_hash,
    $mode           = '0660',
    $owner          = $user,
    $mastersvcname  = 'puppet-server'
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
