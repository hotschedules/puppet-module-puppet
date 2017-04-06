# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker smartindent
#
# == Definition puppet::agent::puppetagentconf {
#
# Generates Puppet Agent configuration
#
# PRIVATE CLASS: do not call directly
#
# puppet::agent::puppetagentconf generates /etc/puppet/puppet.conf
define puppet::agent::puppetagentconf(
  $content        = $content,
  $ensure         = 'file',
  $group          = $group,
  $mode           = '0660',
  $owner          = $owner,
  $main         = undef,
  $agent         = undef,
) {
  file { '/etc/puppet/puppet.conf':
    ensure  => $ensure,
    content => $content,
    group   => $group,
    mode    => $mode,
    owner   => $owner,
    notify  => Service['puppet']
  }
}
