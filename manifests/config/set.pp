# vim: ts=2:et:sw=2:sts=2:fdm=marker:si
#
# == Define: puppet::config::set
# ---
#
# Sets a Puppet Agent configuration setting
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
define puppet::config::set() {

  $value = $::puppet::config::mergedsettings[$name]

  ensure_resource('ini_setting', "puppet-agent-${name}",
    {
      'setting' => $name,
      'value'   => $value,
      'ensure'  => 'present',
      'path'    => $::puppet::configfile,
      'section' => 'agent',
      'notify'  => Service[$::puppet::svc],
    }
  )

}

