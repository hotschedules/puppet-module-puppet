# vim: ts=2:et:sw=2:sts=2:fdm=marker:si
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

  $mergedkeys = keys($mergedsettings)

  ensure_resource("${name}::set", $mergedkeys)

  # Set file perms & ownership
  ensure_resource('file', $configfile, {
    owner => $user,
    group => $group,
    mode  => '0660', # secure (may contain passwords)
  })

}

