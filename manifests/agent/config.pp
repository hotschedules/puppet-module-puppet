# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker smartindent
#
# == Class: puppet::params::agent::default {
#
# Sets default puppet parameters
#
# PRIVATE CLASS: do not call directly
#
class puppet::agent::config inherits puppet {

  define puppetagentconf(
    $agent          = undef,
    $content        = $content,
    $ensure         = "file",
    $group          = $group,
    $main           = undef,
    $mode           = '0660',
    $owner          = $user,
    $confighash     = {}
  ) {
    file { "/etc/puppet/puppet.conf":
      content       => $content,
      ensure        => $ensure,
      group         => $group,
      mode          => $mode,
      owner         => $owner,
      notify        => Service['puppet']
    }
  }

  create_resources(puppetagentconf, { 'confighash' = {'main' => $x_main, 'agent' => $x_agent }} )

}

