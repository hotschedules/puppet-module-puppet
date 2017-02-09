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
    $content        = $content,
    $ensure         = "file",
    $owner          = $user,
    $group          = $group,
    $mode           = '0660',
    $configfile     = $configfile,
    $svc            = $svc,
  ) {
    file { "${configfile}":
      content       => $content,
      ensure        => $ensure,
      owner         => $owner,
      group         => $group,
      mode          => $mode
    },
    notify          => Service[$svc]
  }

  # Create Puppet agent configuration
  create_resources(puppetconf, $x_conf_hash,$agent_defaults)

}
