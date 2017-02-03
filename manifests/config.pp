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
    $agent_hash     = $x_agent_hash,
    $content        = template('puppet/puppet.conf.erb'),
    $ensure         = "file",
    $owner          = $owner,
    $group          = $group,
    $mode           = '0660',
    $main_hash      = $x_main_hash,
    $master_hash    = $x_master_hash,
  ) {
    file { "/etc/puppet/puppet.conf":
      content       => $content,
      ensure        => $ensure,
      owner         => $owner,
      group         => $group,
      mode          => $mode
  }

  # Create Puppet conf
  ensure_resource('puppetconf', $configfile, {
    owner => $user,
    group => $group,
    mode  => '0660', # secure (may contain passwords)
  })

  }
}
