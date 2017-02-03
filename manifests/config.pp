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
    $conf_hash      = $x_conf_hash,
    $content        = template('puppet/puppet.conf.erb'),
    $ensure         = "file",
    $owner          = $owner,
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
  ensure_resource(puppetconf, $conf_hash)

}
