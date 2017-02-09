# vim: ts=2:et:sw=2:sts=2:fdm=marker:si
#
# == Class: puppet::config
# ---
#
# Configures the Puppet Agent
#
# NOTE: internal use only
#
class puppet::config inherits puppet {

  define puppetconf(
    $agent          = undef,
    $content        = template('puppet/puppet.conf.erb'),
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
  create_resources(puppetconf, $x_conf_hash)

}
