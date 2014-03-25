# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker smartindent
#
# == Class: puppet::config
# ---
#
# Configures the Puppet Agent
#
# === Parameters
# ---
#
# [*defaults*]
# - Type - Hash
# - Default - OS specific
# - Puppet agent configuration settings
#
class puppet::config(

  $defaults = {
    'listen'      => false,
    'pluginsync'  => true,
    'autoflush'   => true,
    'environment' => $::environment,
    'certname'    => $::fqdn,
    'server'      => $::servername,

    'modulepath'  =>  $::kernel ? {
      'Linux'   => '/etc/puppet/modules:/usr/share/puppet/modules',
      'windows' => 'C:/ProgramData/PuppetLabs/puppet/etc/modules;C:/usr/share/puppet/modules',
      default   => undef,
    },
  },

) inherits puppet {

  $mergedsettings = merge($defaults, $::puppet::settings)

  validate_bool   ( $mergedsettings['listen']       )
  validate_bool   ( $mergedsettings['pluginsync']   )
  validate_bool   ( $mergedsettings['autoflush']    )
  validate_string ( $mergedsettings['environment']  )
  validate_string ( $mergedsettings['certname']     )
  validate_string ( $mergedsettings['server']       )
  validate_string ( $mergedsettings['modulepath']   )

  $mergedkeys = keys($mergedsettings)

  ensure_resource("${name}::set", $mergedkeys)

  # Set file perms & ownership
  ensure_resource('file', $::puppet::configfile, {
    owner => $::puppet::user,
    group => 'adm',
    mode  => '0440', # secure (may contain passwords)
  })

}

