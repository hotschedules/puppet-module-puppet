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
    $content        = template('puppet/puppet.conf.erb'),
    $ensure         = "file",
    $owner          = $user,
    $group          = $group,
    $mode           = '0660',
  ) {
    file { "${configfile}":
      content       => $content,
      ensure        => $ensure,
      owner         => $owner,
      group         => $group,
      mode          => $mode
    }
  }

  # Create Puppet conf
  create_resources(puppetconf, $agent_defaults, $x_conf_hash )

}
