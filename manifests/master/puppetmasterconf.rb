# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker smartindent
#
# == Definition: puppet::master::puppetmasterconf {
#
# Sets default puppet parameters
#
# PRIVATE CLASS: do not call directly
define puppetmasterconf(
  $agent          = $x_agent_hash,
  $content        = template('puppet/etc/puppet/puppetmaster.conf.erb'),
  $ensure         = 'file',
  $group          = $group,
  $main           = $x_main_hash,
  $master         = $x_master_hash,
  $mode           = '0660',
  $owner          = $user,
  $mastersvcname  = 'puppet-server'
) {
  file { '/etc/puppet/puppet.conf':
    ensure  => $ensure,
    content => $content,
    group   => $group,
    mode    => $mode,
    owner   => $owner,
    notify  => Service[$mastersvcname]
  }
}
