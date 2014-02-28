# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker smartindent
#
# Puppet
#

class puppet::master (
  $enabled,
  $svc,
) {

  # Master depends on puppet client configuration
  Class['puppet'] -> Class[$name]

  clabs::module::init { $name: }

}

