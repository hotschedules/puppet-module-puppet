#
# == Define: puppet::config::unset
# ---
#
# Unsets a Puppet Agent configuration setting
#
# NOTE: internal use only
#
# === Parameters
# ---
#
# [*name*]
# - Type - string
# - Puppet agent configuration setting
#
define puppet::config::unset() {

  ensure_resource('ini_setting', "puppet-agent-${name}",
    {
      'setting' => $name,
      'ensure'  => 'absent',
      'path'    => $::puppet::configfile,
      'section' => 'agent',
      'notify'  => Service[$::puppet::svc],
    }
  )

}

