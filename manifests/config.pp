# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker smartindent
#
# == Class: puppet::config
# ---
#
# Configures the Puppet Agent
#
# NOTE: internal use only
#
class puppet::config(

  $defaults   = $::puppet::defaults,
  $settings   = $::puppet::settings,
  $user       = $::puppet::user,
  $group      = $::puppet::group,
  $configfile = $::puppet::configfile,

) {

  $mergedsettings = merge($defaults, $settings)

  validate_bool   ( $mergedsettings['listen']       )
  validate_bool   ( $mergedsettings['pluginsync']   )
  validate_bool   ( $mergedsettings['autoflush']    )
  validate_string ( $mergedsettings['environment']  )
  validate_string ( $mergedsettings['certname']     )
  validate_string ( $mergedsettings['server']       )

  # Legacy puppet
  if versioncmp($::puppetversion,'3.6') == -1 {
    validate_string ( $mergedsettings['modulepath'] )

  # Remove legacy puppet settings
  } else {
    ensure_resource("${name}::unset", 'modulepath')
  }

  $mergedkeys = keys($mergedsettings)

  ensure_resource("${name}::set", $mergedkeys)

  # Set file perms & ownership
  ensure_resource('file', $configfile, {
    owner => $user,
    group => $group,
    mode  => '0660', # secure (may contain passwords)
  })

}

